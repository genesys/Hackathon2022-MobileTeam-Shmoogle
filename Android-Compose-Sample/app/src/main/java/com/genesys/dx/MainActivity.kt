package com.genesys.dx

import android.content.Context
import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material.Icon
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.core.view.ViewCompat
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentContainerView
import androidx.navigation.NavController
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.genesys.cloud.integration.messenger.MessengerAccount
import com.genesys.cloud.ui.structure.controller.ChatController
import com.genesys.cloud.ui.structure.controller.ChatLoadResponse
import com.genesys.cloud.ui.structure.controller.ChatLoadedListener
import com.genesys.cloud.ui.structure.elements.ChatElement
import com.genesys.cloud.ui.structure.elements.StorableChatElement
import com.genesys.cloud.ui.structure.history.ChatElementListener
import com.genesys.dx.ui.theme.ComposeChatTheme
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import okhttp3.OkHttpClient
import okhttp3.Request

class MainActivity : AppCompatActivity() {

    lateinit var chatController: ChatController

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            ComposeChatTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colors.background
                ) {
                    val navController = rememberNavController()
                    BuildNavigationGraph(navController)
                }
            }
        }
    }

    @Composable
    private fun BuildNavigationGraph(navController: NavController) {
        NavHost(
            navController = navController as NavHostController,
            startDestination = "homeScreen"
        ) {
            composable(route = "homeScreen") {
                HomeScreen {
                    navController.navigate("chatScreen")
                }
            }
            composable(route = "chatScreen") {
                ChatScreen()
            }
        }
    }

    @Composable
    fun HomeScreen(navigateToChatScreen: () -> Unit) {

        Image(
            modifier = Modifier.fillMaxSize(),
            painter = painterResource(R.drawable.background),
            contentDescription = "background_image",
            contentScale = ContentScale.FillBounds
        )

        Icon(
            painter = painterResource(id = R.drawable.support),
            contentDescription = null,
            tint = androidx.compose.ui.graphics.Color.White,
            modifier = Modifier
                .padding(16.dp)
                .size(Dp(30f))
                .clickable {
                    navigateToChatScreen.invoke()
                }
        )
    }

    @Composable
    fun ChatScreen() {
        val activity = LocalContext.current as AppCompatActivity
        val context = activity.applicationContext

        val uiState = remember { mutableStateOf(UiState(false, null)) }

        if (uiState.value.isLoading.not()) {

            uiState.value = uiState.value.copy(isLoading = true)

            loadChatFragment(context) { chatFragment ->

                uiState.value = uiState.value.copy(isLoading = true, chatFragment = chatFragment)
            }
        }

        uiState.value.chatFragment?.let { chatFragment ->
            AndroidView(
                modifier = Modifier.fillMaxSize(),
                factory = {
                    FragmentContainerView(activity).apply { id = ViewCompat.generateViewId() }
                },
                update = { fragmentContainerView ->
                    activity.supportFragmentManager
                        .beginTransaction()
                        .replace(fragmentContainerView.id, chatFragment).commitAllowingStateLoss()
                }
            )
        }
    }

    private fun loadChatFragment(context: Context, function: (Fragment) -> Unit) {

        val messengerAccount = MessengerAccount(
            deploymentId = "f6dd00eb-349b-4f12-95a4-9bdd24ee607c",
            domain = "inindca.com"
        ).apply {
            tokenStoreKey = "com.genesys.messenger.poc"
            logging = true
        }

        chatController = ChatController
            .Builder(context)
            .chatElementListener(object : ChatLoadedListener, ChatElementListener {

                override fun onReceive(items: List<StorableChatElement>) {
                    val last = items.last()
                    if (last.getType() == ChatElement.IncomingElement) {
//                        speak(last.text)
                        speak("Hey, You have a new message waiting from the Booking app")
                    }
                }

                override fun onComplete(result: ChatLoadResponse) {
                }

            })
            .build(messengerAccount, object : ChatLoadedListener {

                override fun onComplete(result: ChatLoadResponse) {
                    result.error?.let {
                        // report Chat loading failed
                    } ?: let {
                        function.invoke(result.fragment!!)
                    }
                }
            })

    }

    private fun speak(message: String) {
        val coroutineScope = CoroutineScope(Dispatchers.IO)

        coroutineScope.launch {

            val okHttpClient = OkHttpClient()
            val requestBuilder = Request.Builder()
            requestBuilder.url("https://shmooogle.loca.lt/message?text=$message")
            val call = okHttpClient.newCall(requestBuilder.build())
            call.execute()
        }
    }
}