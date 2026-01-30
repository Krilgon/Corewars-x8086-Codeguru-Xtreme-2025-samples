;secondary program/ it catches the 2 zombie and then jumps to the main core along with the 2 zombie




jmp getZombie

getZombie:

nop 
nop
nop 
nop
nop


push es

push cs
pop es

mov si, ax

unt_logic:
mov bl, [0x2612]
mov ax, 0x24FF
mov dx, 0x24FF
add bx, si

mov ch, [bx + TABLE]

add cx, 0x140

attack:
mov di, cx

INT 0x86
pop es
xor cx, cx
jmp [0x0]

TABLE:
db 2
db 80
db 102
db 180
db 250
db 9
db 95
db 109
db 179
db 193
db 22
db 36
db 106
db 184
db 206
db 29
db 35
db 113
db 135
db 213
db 26
db 40
db 126
db 140
db 210
db 224
db 55
db 69
db 139
db 217
db 239
db 60
db 66
db 144
db 166
db 244
db 59
db 73
db 159
db 173
db 243
db 0
db 86
db 100
db 170
db 248
db 15
db 93
db 99
db 177
db 199
db 20
db 90
db 104
db 190
db 204
db 19
db 33
db 119
db 133
db 203
db 24
db 46
db 124
db 130
db 208
db 230
db 53
db 123
db 137
db 223
db 237
db 50
db 64
db 150
db 164
db 234
db 57
db 79
db 157
db 163
db 241
db 6
db 84
db 154
db 168
db 254
db 13
db 83
db 97
db 183
db 197
db 10
db 88
db 110
db 188
db 194
db 17
db 39
db 117
db 187
db 201
db 30
db 44
db 114
db 128
db 214
db 228
db 43
db 121
db 143
db 221
db 227
db 48
db 70
db 148
db 218
db 232
db 63
db 77
db 147
db 161
db 247
db 4
db 74
db 152
db 174
db 252
db 3
db 81
db 103
db 181
db 251
db 8
db 94
db 108
db 178
db 192
db 23
db 37
db 107
db 185
db 207
db 28
db 34
db 112
db 134
db 212
db 27
db 41
db 127
db 141
db 211
db 225
db 54
db 68
db 138
db 216
db 238
db 61
db 67
db 145
db 167
db 245
db 58
db 72
db 158
db 172
db 242
db 1
db 87
db 101
db 171
db 249
db 14
db 92
db 98
db 176
db 198
db 21
db 91
db 105
db 191
db 205
db 18
db 32
db 118
db 132
db 202
db 25
db 47
db 125
db 131
db 209
db 231
db 52
db 122
db 136
db 222
db 236
db 51
db 65
db 151
db 165
db 235
db 56
db 78
db 156
db 162
db 240
db 7
db 85
db 155
db 169
db 255
db 12
db 82
db 96
db 182
db 196
db 11
db 89
db 111
db 189
db 195
db 16
db 38
db 116
db 186
db 200
db 31
db 45
db 115
db 129
db 215
db 229
db 42
db 120
db 142
db 220
db 226
db 49
db 71
db 149
db 219
db 233
db 62
db 76
db 146
db 160
db 246
db 5
db 75
db 153
db 175
db 253
