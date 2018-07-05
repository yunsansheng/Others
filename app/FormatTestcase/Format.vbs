Sub WorksheetLoop2()

         Dim ws As Worksheet

         For Each ws In Worksheets

            '激活分页'
            ws.Activate
            '自动换行'
            ws.Range("G2:G100").WrapText = True

            Columns("G").ColumnWidth = 60
            ws.Range("A1:J1").Font.Bold = True

            '背景色'
            ws.Range("A1:J1").Interior.ColorIndex = 33

            '字体颜色'
            ws.Range("A1:J1").Font.ColorIndex = 1

            ws.Rows(1).RowHeight = 24

            '对齐'
            ws.Rows(1).HorizontalAlignment = xlCenter
            ws.Rows(1).VerticalAlignment = xlCenter

            
            With ActiveSheet
                REM 查找Body Header URL 并加粗
                For Each c In Range("G2:G100")
        
                      With c
        
                        cv = .Value
        
                        i = InStr(1, cv, "Body:", 1)
        
                        .Characters(i, 5).Font.Bold = True
                        
                        k = InStr(1, cv, "Header:", 1)
        
                        .Characters(k, 7).Font.Bold = True
                        
                        u = InStr(1, cv, "Url:", 1)
        
                        .Characters(u, 4).Font.Bold = True
        
                      End With
        
                Next
        
             End With
         Next
End Sub




