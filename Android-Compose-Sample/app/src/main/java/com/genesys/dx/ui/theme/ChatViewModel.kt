package com.genesys.dx.ui.theme

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.genesys.dx.UiState

class ChatViewModel : ViewModel() {

    private var _uiState = MutableLiveData<UiState>()
    var uiState: LiveData<UiState> = _uiState

}