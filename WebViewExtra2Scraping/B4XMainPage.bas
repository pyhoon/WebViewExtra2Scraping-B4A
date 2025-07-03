B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=WebViewExtra2Scraping.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private HtmlParser As MiniHtmlParser
	Private WebView1 As WebView
	Private WebViewExtras2 As WebViewExtras
	Private WebViewSetting3 As WebViewSettings
	Private WebChromeClient4 As DefaultWebChromeClient
	Private JavascriptInterface5 As DefaultJavascriptInterface
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	HtmlParser.Initialize
	JavascriptInterface5.Initialize
	WebViewExtras2.Initialize(WebView1)
	WebChromeClient4.Initialize("DefaultWebChromeClient1")
	WebViewExtras2.SetWebChromeClient(WebChromeClient4)
	WebViewExtras2.addJavascriptInterface(JavascriptInterface5, "B4A")
	WebViewSetting3.setUseWideViewPort(WebView1, True)
	WebViewSetting3.setLoadWithOverviewMode(WebView1, True)
	Dim UA As String = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246"
	WebViewSetting3.setUserAgentString(WebView1, UA)
	WebView1.LoadUrl("https://www.rili.com.cn/wannianli/2025/0602.html")
End Sub

Private Sub WebView1_PageFinished (Url As String)
	'Log("PageFinished")
	Dim Javascript As String = "B4A.CallSub('Process_HTML', true, document.documentElement.outerHTML)"
	WebViewExtras2.ExecuteJavascript(Javascript)
End Sub

Sub Process_HTML (HTML As String) 'ignore
	'File.WriteString(File.DirInternal, "webpage.html", HTML)
	'Dim s As String = File.ReadString(File.DirInternal, "webpage.html")
	Dim RootNode As HtmlNode = HtmlParser.Parse(HTML)
	Dim yi As HtmlNode = HtmlParser.FindNode(RootNode, "div", HtmlParser.CreateHtmlAttribute("id", "wnl_yi"))
	If yi.IsInitialized Then
		Dim txt As HtmlNode = HtmlParser.FindNode(yi, "div", HtmlParser.CreateHtmlAttribute("class", "txt"))
		For Each node As HtmlNode In txt.Children
			For Each att As HtmlAttribute In node.Attributes
				'Log($"${att.Key}: ${att.Value}"$)
				Log("结果: " & att.Value)
				xui.MsgboxAsync(att.Value, "结果:")
			Next
		Next
	Else
		Log("找不到元素")
	End If
End Sub