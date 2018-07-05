'这是注释'
REM 这是另一种注释

'官方help文档'
'https://msdn.microsoft.com/zh-cn/VBA/VBA-Excel'

Sub name ()
	'我没有返回值'
	'我不能用call调用'
	'我不能通过函数的方式调用'
End Sub

Function name ()
	'我可以有返回值'
	return 123
End Function


Sub Area(x As Double, y As Double)
    Msg Box("x *  y= " & x * y)

End Sub

Function findArea(Length As Double, Width As Double)
    Rem 调用SUB Area,注意没有括号
    Area Length, Width
    
End Function


'Workbook对象是Workbooks集合的成员'
'工作表对象Worksheets'
'Range对象表示单元格，行，列或包含一个或多个连续单元格块的单元格的选择。'
