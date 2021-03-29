object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'JSON'
  ClientHeight = 775
  ClientWidth = 773
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    773
    775)
  PixelsPerInch = 96
  TextHeight = 16
  object Button1: TButton
    Left = 666
    Top = 8
    Width = 99
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'TEST'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 652
    Height = 386
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 8
    Top = 400
    Width = 652
    Height = 367
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '{'
      '  "type": "bubble",'
      '  "hero": {'
      '    "type": "image",'
      '    "url": "https://scdn.line-'
      'apps.com/n/channel_devcenter/img/fx/01_1_cafe.png",'
      '    "size": "full",'
      '    "aspectRatio": "20:13",'
      '    "aspectMode": "cover",'
      '    "action": {'
      '      "type": "uri",'
      '      "uri": "http://linecorp.com/"'
      '    }'
      '  },'
      '  "body": {'
      '    "type": "box",'
      '    "layout": "vertical",'
      '    "contents": ['
      '      {'
      '        "type": "text",'
      '        "text": "Brown Cafe",'
      '        "weight": "bold",'
      '        "size": "xl"'
      '      },'
      '      {'
      '        "type": "box",'
      '        "layout": "baseline",'
      '        "margin": "md",'
      '        "contents": ['
      '          {'
      '            "type": "icon",'
      '            "size": "sm",'
      '            "url": "https://scdn.line-'
      'apps.com/n/channel_devcenter/img/fx/review_gold_star_28.'
      'png"'
      '          },'
      '          {'
      '            "type": "icon",'
      '            "size": "sm",'
      '            "url": "https://scdn.line-'
      'apps.com/n/channel_devcenter/img/fx/review_gold_star_28.'
      'png"'
      '          },'
      '          {'
      '            "type": "icon",'
      '            "size": "sm",'
      '            "url": "https://scdn.line-'
      'apps.com/n/channel_devcenter/img/fx/review_gold_star_28.'
      'png"'
      '          },'
      '          {'
      '            "type": "icon",'
      '            "size": "sm",'
      '            "url": "https://scdn.line-'
      'apps.com/n/channel_devcenter/img/fx/review_gold_star_28.'
      'png"'
      '          },'
      '          {'
      '            "type": "icon",'
      '            "size": "sm",'
      '            "url": "https://scdn.line-'
      'apps.com/n/channel_devcenter/img/fx/review_gray_star_28.'
      'png"'
      '          },'
      '          {'
      '            "type": "text",'
      '            "text": "4.0",'
      '            "size": "sm",'
      '            "color": "#999999",'
      '            "margin": "md",'
      '            "flex": 0'
      '          }'
      '        ]'
      '      },'
      '      {'
      '        "type": "box",'
      '        "layout": "vertical",'
      '        "margin": "lg",'
      '        "spacing": "sm",'
      '        "contents": ['
      '          {'
      '            "type": "box",'
      '            "layout": "baseline",'
      '            "spacing": "sm",'
      '            "contents": ['
      '              {'
      '                "type": "text",'
      '                "text": "Place",'
      '                "color": "#aaaaaa",'
      '                "size": "sm",'
      '                "flex": 1'
      '              },'
      '              {'
      '                "type": "text",'
      '                "text": "Miraina Tower, 4-1-6 Shinjuku, Tokyo",'
      '                "wrap": true,'
      '                "color": "#666666",'
      '                "size": "sm",'
      '                "flex": 5'
      '              }'
      '            ]'
      '          },'
      '          {'
      '            "type": "box",'
      '            "layout": "baseline",'
      '            "spacing": "sm",'
      '            "contents": ['
      '              {'
      '                "type": "text",'
      '                "text": "Time",'
      '                "color": "#aaaaaa",'
      '                "size": "sm",'
      '                "flex": 1'
      '              },'
      '              {'
      '                "type": "text",'
      '                "text": "10:00 - 23:00",'
      '                "wrap": true,'
      '                "color": "#666666",'
      '                "size": "sm",'
      '                "flex": 5'
      '              }'
      '            ]'
      '          }'
      '        ]'
      '      }'
      '    ]'
      '  },'
      '  "footer": {'
      '    "type": "box",'
      '    "layout": "vertical",'
      '    "spacing": "sm",'
      '    "contents": ['
      '      {'
      '        "type": "button",'
      '        "style": "link",'
      '        "height": "sm",'
      '        "action": {'
      '          "type": "uri",'
      '          "label": "CALL",'
      '          "uri": "https://linecorp.com"'
      '        }'
      '      },'
      '      {'
      '        "type": "button",'
      '        "style": "link",'
      '        "height": "sm",'
      '        "action": {'
      '          "type": "uri",'
      '          "label": "WEBSITE",'
      '          "uri": "https://linecorp.com"'
      '        }'
      '      },'
      '      {'
      '        "type": "spacer",'
      '        "size": "sm"'
      '      }'
      '    ],'
      '    "flex": 0'
      '  }'
      '}')
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
