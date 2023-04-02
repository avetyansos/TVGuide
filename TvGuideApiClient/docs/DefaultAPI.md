# DefaultAPI

All URIs are relative to *https://demo-c.cdn.vmedia.ca/json*

Method | HTTP request | Description
------------- | ------------- | -------------
[**channelsGet**](DefaultAPI.md#channelsget) | **GET** /Channels | Get TV channels
[**programItemsGet**](DefaultAPI.md#programitemsget) | **GET** /ProgramItems | Get program items


# **channelsGet**
```swift
    open class func channelsGet(completion: @escaping (_ data: [Channel]?, _ error: Error?) -> Void)
```

Get TV channels

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Get TV channels
DefaultAPI.channelsGet() { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**[Channel]**](Channel.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **programItemsGet**
```swift
    open class func programItemsGet(completion: @escaping (_ data: [ProgramItem]?, _ error: Error?) -> Void)
```

Get program items

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Get program items
DefaultAPI.programItemsGet() { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**[ProgramItem]**](ProgramItem.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

