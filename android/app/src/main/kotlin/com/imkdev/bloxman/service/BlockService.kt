package com.imkdev.bloxman.service

import android.content.Context
import android.net.Uri

interface BlockService<T> {

    fun insert(context: Context, phone: String?) : Uri?

    fun insert(context: Context, phone: String?, callback: (message: String)-> Unit)

    fun delete(context: Context, phone: String?) : Boolean

    fun delete(context: Context, phone: String?, callback: (message: String)-> Unit)

    fun findAll(context: Context) : List<T>

    fun findAll(context: Context, callback: (json: String)-> Unit)
}