Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:50477 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027Ab3GVRsl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2013 13:48:41 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo405XN5f4tKp=kJhuqimoYV5+KhdZG=rJ31tkHdOEhx7A@mail.gmail.com>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
	<CAErSpo405XN5f4tKp=kJhuqimoYV5+KhdZG=rJ31tkHdOEhx7A@mail.gmail.com>
Date: Mon, 22 Jul 2013 10:48:41 -0700
Message-ID: <CAE9FiQUPNinBo77UnsuY7w_oWjqAwy9seKVVBBP844EA_BPkng@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix hotplug remove with sriov again
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 22, 2013 at 10:39 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Jul 19, 2013 at 1:14 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> Found hot-remove pcie card with sriov enabled cause crash in v3.10.
>>
>> It is regression caused by commit ba518e3c177547dfebf7fa7252cea0c850e7ce25
>> (PCI: pciehp: Iterate over all devices in slot, not functions 0-7)
>
> Can you post the dmesg or console log showing the crash?  If somebody
> else sees this crash, having the log in the mailing list archive will
> help them figure out that this is the fix they need.

Rescue:~ # echo -n 0 > /sys/bus/pci/slots/2/power
[ 5445.937864] pci_hotplug: power_write_file: power = 0
[ 5445.938153] pciehp 0000:00:03.0:pcie04: disable_slot: physical_slot = 2
[ 5445.949164] pciehp 0000:00:03.0:pcie04: pciehp_get_power_status:
SLOTCTRL a8 value read 1f9
[ 5445.949672] pciehp 0000:00:03.0:pcie04: pciehp_unconfigure_device:
domain:bus:dev = 0000:02:00
[ 5445.969878] mlx4_core 0000:02:00.0: Disabling SR-IOV
[ 5446.215792] mlx4_core 0000:02:00.0: Received reset from slave:1
[ 5446.217265]   free irq_desc for 1174
[ 5446.217567]   free irq_desc for 1175
[ 5446.229637]   free irq_desc for 1176
[ 5446.229691]   free irq_desc for 1177
[ 5446.230758] pci 0000:02:00.1: freeing pci_dev info
[ 5446.463034] mlx4_core 0000:02:00.0: Received reset from slave:2
[ 5446.463984]   free irq_desc for 1178
[ 5446.464274]   free irq_desc for 1179
[ 5446.479397]   free irq_desc for 1180
[ 5446.479804]   free irq_desc for 1181
[ 5446.480364] pci 0000:02:00.2: freeing pci_dev info
[ 5446.718817] mlx4_core 0000:02:00.0: Received reset from slave:3
[ 5446.719737]   free irq_desc for 1182
[ 5446.720123]   free irq_desc for 1183
[ 5446.729482]   free irq_desc for 1184
[ 5446.729533]   free irq_desc for 1185
[ 5446.730128] pci 0000:02:00.3: freeing pci_dev info
[ 5446.967233] mlx4_core 0000:02:00.0: Received reset from slave:4
[ 5446.968242]   free irq_desc for 1186
[ 5446.968508]   free irq_desc for 1187
[ 5446.979492]   free irq_desc for 1188
[ 5446.979905]   free irq_desc for 1189
[ 5446.981335] pci 0000:02:00.4: freeing pci_dev info
[ 5447.215089] mlx4_core 0000:02:00.0: Received reset from slave:5
[ 5447.216123]   free irq_desc for 1190
[ 5447.216460]   free irq_desc for 1191
[ 5447.229640]   free irq_desc for 1192
[ 5447.229692]   free irq_desc for 1193
[ 5447.230212] pci 0000:02:00.5: freeing pci_dev info
[ 5447.463557] mlx4_core 0000:02:00.0: Received reset from slave:6
[ 5447.464562]   free irq_desc for 1194
[ 5447.464867]   free irq_desc for 1195
[ 5447.479527]   free irq_desc for 1196
[ 5447.479579]   free irq_desc for 1197
[ 5447.480518] pci 0000:02:00.6: freeing pci_dev info
[ 5447.731734] mlx4_core 0000:02:00.0: Received reset from slave:7
[ 5447.732717]   free irq_desc for 1198
[ 5447.733032]   free irq_desc for 1199
[ 5447.749623]   free irq_desc for 1200
[ 5447.749675]   free irq_desc for 1201
[ 5447.750238] pci 0000:02:00.7: freeing pci_dev info
[ 5447.966630] mlx4_core 0000:02:00.0: Received reset from slave:8
[ 5447.967646]   free irq_desc for 1202
[ 5447.967947]   free irq_desc for 1203
[ 5447.979694]   free irq_desc for 1204
[ 5447.979746]   free irq_desc for 1205
[ 5447.980168] pci 0000:02:01.0: freeing pci_dev info
[ 5448.222466] mlx4_core 0000:02:00.0: Received reset from slave:9
[ 5448.223455]   free irq_desc for 1206
[ 5448.223830]   free irq_desc for 1207
[ 5448.239969]   free irq_desc for 1208
[ 5448.240022]   free irq_desc for 1209
[ 5448.240782] pci 0000:02:01.1: freeing pci_dev info
[ 5448.478746] mlx4_core 0000:02:00.0: Received reset from slave:10
[ 5448.479740]   free irq_desc for 1210
[ 5448.480071]   free irq_desc for 1211
[ 5448.489773]   free irq_desc for 1212
[ 5448.490298]   free irq_desc for 1213
[ 5448.491051] pci 0000:02:01.2: freeing pci_dev info
[ 5448.720910] mlx4_core 0000:02:00.0: Received reset from slave:11
[ 5448.721946]   free irq_desc for 1214
[ 5448.722198]   free irq_desc for 1215
[ 5448.739749]   free irq_desc for 1216
[ 5448.739800]   free irq_desc for 1217
[ 5448.740644] pci 0000:02:01.3: freeing pci_dev info
[ 5448.970280] mlx4_core 0000:02:00.0: Received reset from slave:12
[ 5448.971247]   free irq_desc for 1218
[ 5448.971515]   free irq_desc for 1219
[ 5448.989981]   free irq_desc for 1220
[ 5448.990405]   free irq_desc for 1221
[ 5448.991519] pci 0000:02:01.4: freeing pci_dev info
[ 5449.223394] mlx4_core 0000:02:00.0: Received reset from slave:13
[ 5449.224348]   free irq_desc for 1222
[ 5449.224651]   free irq_desc for 1223
[ 5449.239806]   free irq_desc for 1224
[ 5449.239872]   free irq_desc for 1225
[ 5449.240365] pci 0000:02:01.5: freeing pci_dev info
[ 5449.483929] mlx4_core 0000:02:00.0: Received reset from slave:14
[ 5449.484909]   free irq_desc for 1226
[ 5449.485193]   free irq_desc for 1227
[ 5449.499872]   free irq_desc for 1228
[ 5449.499939]   free irq_desc for 1229
[ 5449.500420] pci 0000:02:01.6: freeing pci_dev info
[ 5449.736091] mlx4_core 0000:02:00.0: Received reset from slave:15
[ 5449.737126]   free irq_desc for 1230
[ 5449.737430]   free irq_desc for 1231
[ 5449.749963]   free irq_desc for 1232
[ 5449.750016]   free irq_desc for 1233
[ 5449.750655] pci 0000:02:01.7: freeing pci_dev info
[ 5449.976423] mlx4_core 0000:02:00.0: Received reset from slave:16
[ 5449.977463]   free irq_desc for 1234
[ 5449.977704]   free irq_desc for 1235
[ 5449.989977]   free irq_desc for 1236
[ 5449.990027]   free irq_desc for 1237
[ 5449.990567] pci 0000:02:02.0: freeing pci_dev info
[ 5450.203801] mlx4_core 0000:02:00.0: Received reset from slave:17
[ 5450.204757]   free irq_desc for 1238
[ 5450.205063]   free irq_desc for 1239
[ 5450.220138]   free irq_desc for 1240
[ 5450.220526]   free irq_desc for 1241
[ 5450.221462] pci 0000:02:02.1: freeing pci_dev info
[ 5450.459183] mlx4_core 0000:02:00.0: Received reset from slave:18
[ 5450.460094]   free irq_desc for 1242
[ 5450.460433]   free irq_desc for 1243
[ 5450.473318]   free irq_desc for 1244
[ 5450.473657]   free irq_desc for 1245
[ 5450.474055] pci 0000:02:02.2: freeing pci_dev info
[ 5450.716685] mlx4_core 0000:02:00.0: Received reset from slave:19
[ 5450.717715]   free irq_desc for 1246
[ 5450.717954]   free irq_desc for 1247
[ 5450.730326]   free irq_desc for 1248
[ 5450.730376]   free irq_desc for 1249
[ 5450.731344] pci 0000:02:02.3: freeing pci_dev info
[ 5450.963028] mlx4_core 0000:02:00.0: Received reset from slave:20
[ 5450.963980]   free irq_desc for 1250
[ 5450.964309]   free irq_desc for 1251
[ 5450.980321]   free irq_desc for 1252
[ 5450.980407]   free irq_desc for 1253
[ 5450.981486] pci 0000:02:02.4: freeing pci_dev info
[ 5451.216104] mlx4_core 0000:02:00.0: Received reset from slave:21
[ 5451.217006]   free irq_desc for 1254
[ 5451.217402]   free irq_desc for 1255
[ 5451.230218]   free irq_desc for 1256
[ 5451.230580]   free irq_desc for 1257
[ 5451.231433] pci 0000:02:02.5: freeing pci_dev info
[ 5451.468278] mlx4_core 0000:02:00.0: Received reset from slave:22
[ 5451.469250]   free irq_desc for 1258
[ 5451.469527]   free irq_desc for 1259
[ 5451.480235]   free irq_desc for 1260
[ 5451.480286]   free irq_desc for 1261
[ 5451.480821] pci 0000:02:02.6: freeing pci_dev info
[ 5451.708808] mlx4_core 0000:02:00.0: Received reset from slave:23
[ 5451.709831]   free irq_desc for 1262
[ 5451.710109]   free irq_desc for 1263
[ 5451.720320]   free irq_desc for 1264
[ 5451.720774]   free irq_desc for 1265
[ 5451.721286] pci 0000:02:02.7: freeing pci_dev info
[ 5451.967833] mlx4_core 0000:02:00.0: Received reset from slave:24
[ 5451.968861]   free irq_desc for 1266
[ 5451.969165]   free irq_desc for 1267
[ 5451.980340]   free irq_desc for 1268
[ 5451.980725]   free irq_desc for 1269
[ 5451.981814] pci 0000:02:03.0: freeing pci_dev info
[ 5452.215387] mlx4_core 0000:02:00.0: Received reset from slave:25
[ 5452.216410]   free irq_desc for 1270
[ 5452.216711]   free irq_desc for 1271
[ 5452.230791]   free irq_desc for 1272
[ 5452.230841]   free irq_desc for 1273
[ 5452.231804] pci 0000:02:03.1: freeing pci_dev info
[ 5452.479753] mlx4_core 0000:02:00.0: Received reset from slave:26
[ 5452.480677]   free irq_desc for 1274
[ 5452.481045]   free irq_desc for 1275
[ 5452.490411]   free irq_desc for 1276
[ 5452.490460]   free irq_desc for 1277
[ 5452.491277] pci 0000:02:03.2: freeing pci_dev info
[ 5452.728961] mlx4_core 0000:02:00.0: Received reset from slave:27
[ 5452.729876]   free irq_desc for 1278
[ 5452.730469]   free irq_desc for 1279
[ 5452.730525]   free irq_desc for 1280
[ 5452.730575]   free irq_desc for 1281
[ 5452.731132] pci 0000:02:03.3: freeing pci_dev info
[ 5452.968678] mlx4_core 0000:02:00.0: Received reset from slave:28
[ 5452.969655]   free irq_desc for 1282
[ 5452.969939]   free irq_desc for 1283
[ 5452.980494]   free irq_desc for 1284
[ 5452.980558]   free irq_desc for 1285
[ 5452.981101] pci 0000:02:03.4: freeing pci_dev info
[ 5453.223899] mlx4_core 0000:02:00.0: Received reset from slave:29
[ 5453.224896]   free irq_desc for 1286
[ 5453.225157]   free irq_desc for 1287
[ 5453.240827]   free irq_desc for 1288
[ 5453.240877]   free irq_desc for 1289
[ 5453.241357] pci 0000:02:03.5: freeing pci_dev info
[ 5453.480534] mlx4_core 0000:02:00.0: Received reset from slave:30
[ 5453.481469]   free irq_desc for 1290
[ 5453.481754]   free irq_desc for 1291
[ 5453.500604]   free irq_desc for 1292
[ 5453.501013]   free irq_desc for 1293
[ 5453.501753] pci 0000:02:03.6: freeing pci_dev info
[ 5453.753006] mlx4_core 0000:02:00.0: Received reset from slave:31
[ 5453.754081]   free irq_desc for 1294
[ 5453.754395]   free irq_desc for 1295
[ 5453.770626]   free irq_desc for 1296
[ 5453.770689]   free irq_desc for 1297
[ 5453.771160] pci 0000:02:03.7: freeing pci_dev info
[ 5453.996813] mlx4_core 0000:02:00.0: Received reset from slave:32
[ 5453.997762]   free irq_desc for 1298
[ 5453.998103]   free irq_desc for 1299
[ 5454.010692]   free irq_desc for 1300
[ 5454.010742]   free irq_desc for 1301
[ 5454.011668] pci 0000:02:04.0: freeing pci_dev info
[ 5454.248027] mlx4_core 0000:02:00.0: Received reset from slave:33
[ 5454.248994]   free irq_desc for 1302
[ 5454.249287]   free irq_desc for 1303
[ 5454.260953]   free irq_desc for 1304
[ 5454.261279]   free irq_desc for 1305
[ 5454.261696] pci 0000:02:04.1: freeing pci_dev info
[ 5454.497131] mlx4_core 0000:02:00.0: Received reset from slave:34
[ 5454.498033]   free irq_desc for 1306
[ 5454.498368]   free irq_desc for 1307
[ 5454.510715]   free irq_desc for 1308
[ 5454.511040]   free irq_desc for 1309
[ 5454.511637] pci 0000:02:04.2: freeing pci_dev info
[ 5454.756143] mlx4_core 0000:02:00.0: Received reset from slave:35
[ 5454.757169]   free irq_desc for 1310
[ 5454.757450]   free irq_desc for 1311
[ 5454.770945]   free irq_desc for 1312
[ 5454.770995]   free irq_desc for 1313
[ 5454.771448] pci 0000:02:04.3: freeing pci_dev info
[ 5455.025076] mlx4_core 0000:02:00.0: Received reset from slave:36
[ 5455.026029]   free irq_desc for 1314
[ 5455.026291]   free irq_desc for 1315
[ 5455.040816]   free irq_desc for 1316
[ 5455.040865]   free irq_desc for 1317
[ 5455.041315] pci 0000:02:04.4: freeing pci_dev info
[ 5455.271839] mlx4_core 0000:02:00.0: Received reset from slave:37
[ 5455.272777]   free irq_desc for 1318
[ 5455.273083]   free irq_desc for 1319
[ 5455.290978]   free irq_desc for 1320
[ 5455.291240]   free irq_desc for 1321
[ 5455.291721] pci 0000:02:04.5: freeing pci_dev info
[ 5455.515457] mlx4_core 0000:02:00.0: Received reset from slave:38
[ 5455.516424]   free irq_desc for 1322
[ 5455.516538]   free irq_desc for 1323
[ 5455.516587]   free irq_desc for 1324
[ 5455.516635]   free irq_desc for 1325
[ 5455.517140] pci 0000:02:04.6: freeing pci_dev info
[ 5455.757061] mlx4_core 0000:02:00.0: Received reset from slave:39
[ 5455.757998]   free irq_desc for 1326
[ 5455.758287]   free irq_desc for 1327
[ 5455.770962]   free irq_desc for 1328
[ 5455.771028]   free irq_desc for 1329
[ 5455.771488] pci 0000:02:04.7: freeing pci_dev info
[ 5456.005454] mlx4_core 0000:02:00.0: Received reset from slave:40
[ 5456.006393]   free irq_desc for 1330
[ 5456.006644]   free irq_desc for 1331
[ 5456.020994]   free irq_desc for 1332
[ 5456.021057]   free irq_desc for 1333
[ 5456.021527] pci 0000:02:05.0: freeing pci_dev info
[ 5456.249555] mlx4_core 0000:02:00.0: Received reset from slave:41
[ 5456.250495]   free irq_desc for 1334
[ 5456.250798]   free irq_desc for 1335
[ 5456.261188]   free irq_desc for 1336
[ 5456.261251]   free irq_desc for 1337
[ 5456.262184] pci 0000:02:05.1: freeing pci_dev info
[ 5456.496812] mlx4_core 0000:02:00.0: Received reset from slave:42
[ 5456.497782]   free irq_desc for 1338
[ 5456.498102]   free irq_desc for 1339
[ 5456.511340]   free irq_desc for 1340
[ 5456.511403]   free irq_desc for 1341
[ 5456.511908] pci 0000:02:05.2: freeing pci_dev info
[ 5456.752499] mlx4_core 0000:02:00.0: Received reset from slave:43
[ 5456.753720]   free irq_desc for 1342
[ 5456.753972]   free irq_desc for 1343
[ 5456.771268]   free irq_desc for 1344
[ 5456.771329]   free irq_desc for 1345
[ 5456.771727] pci 0000:02:05.3: freeing pci_dev info
[ 5457.007932] mlx4_core 0000:02:00.0: Received reset from slave:44
[ 5457.008893]   free irq_desc for 1346
[ 5457.009117]   free irq_desc for 1347
[ 5457.021232]   free irq_desc for 1348
[ 5457.021472]   free irq_desc for 1349
[ 5457.022457] pci 0000:02:05.4: freeing pci_dev info
[ 5457.261323] mlx4_core 0000:02:00.0: Received reset from slave:45
[ 5457.262191]   free irq_desc for 1350
[ 5457.262480]   free irq_desc for 1351
[ 5457.281299]   free irq_desc for 1352
[ 5457.281346]   free irq_desc for 1353
[ 5457.281710] pci 0000:02:05.5: freeing pci_dev info
[ 5457.513048] mlx4_core 0000:02:00.0: Received reset from slave:46
[ 5457.513944]   free irq_desc for 1354
[ 5457.514207]   free irq_desc for 1355
[ 5457.531258]   free irq_desc for 1356
[ 5457.531306]   free irq_desc for 1357
[ 5457.531670] pci 0000:02:05.6: freeing pci_dev info
[ 5457.760620] mlx4_core 0000:02:00.0: Received reset from slave:47
[ 5457.761494]   free irq_desc for 1358
[ 5457.761794]   free irq_desc for 1359
[ 5457.771264]   free irq_desc for 1360
[ 5457.771312]   free irq_desc for 1361
[ 5457.771773] pci 0000:02:05.7: freeing pci_dev info
[ 5458.008640] mlx4_core 0000:02:00.0: Received reset from slave:48
[ 5458.009717]   free irq_desc for 1362
[ 5458.009947]   free irq_desc for 1363
[ 5458.021417]   free irq_desc for 1364
[ 5458.021795]   free irq_desc for 1365
[ 5458.022351] pci 0000:02:06.0: freeing pci_dev info
[ 5458.252793] mlx4_core 0000:02:00.0: Received reset from slave:49
[ 5458.253677]   free irq_desc for 1366
[ 5458.253972]   free irq_desc for 1367
[ 5458.271677]   free irq_desc for 1368
[ 5458.271724]   free irq_desc for 1369
[ 5458.272084] pci 0000:02:06.1: freeing pci_dev info
[ 5458.489329] mlx4_core 0000:02:00.0: Received reset from slave:50
[ 5458.490216]   free irq_desc for 1370
[ 5458.490505]   free irq_desc for 1371
[ 5458.501513]   free irq_desc for 1372
[ 5458.501776]   free irq_desc for 1373
[ 5458.502129] pci 0000:02:06.2: freeing pci_dev info
[ 5458.731210] mlx4_core 0000:02:00.0: Received reset from slave:51
[ 5458.732090]   free irq_desc for 1374
[ 5458.732437]   free irq_desc for 1375
[ 5458.751457]   free irq_desc for 1376
[ 5458.751503]   free irq_desc for 1377
[ 5458.751859] pci 0000:02:06.3: freeing pci_dev info
[ 5458.973317] mlx4_core 0000:02:00.0: Received reset from slave:52
[ 5458.974191]   free irq_desc for 1378
[ 5458.974489]   free irq_desc for 1379
[ 5458.991634]   free irq_desc for 1380
[ 5458.991894]   free irq_desc for 1381
[ 5458.992269] pci 0000:02:06.4: freeing pci_dev info
[ 5459.228617] mlx4_core 0000:02:00.0: Received reset from slave:53
[ 5459.229475]   free irq_desc for 1382
[ 5459.229736]   free irq_desc for 1383
[ 5459.241833]   free irq_desc for 1384
[ 5459.242083]   free irq_desc for 1385
[ 5459.242445] pci 0000:02:06.5: freeing pci_dev info
[ 5459.457288] mlx4_core 0000:02:00.0: Received reset from slave:54
[ 5459.458150]   free irq_desc for 1386
[ 5459.458462]   free irq_desc for 1387
[ 5459.471683]   free irq_desc for 1388
[ 5459.471927]   free irq_desc for 1389
[ 5459.472283] pci 0000:02:06.6: freeing pci_dev info
[ 5459.713679] mlx4_core 0000:02:00.0: Received reset from slave:55
[ 5459.714556]   free irq_desc for 1390
[ 5459.714867]   free irq_desc for 1391
[ 5459.731666]   free irq_desc for 1392
[ 5459.731711]   free irq_desc for 1393
[ 5459.732073] pci 0000:02:06.7: freeing pci_dev info
[ 5459.957250] mlx4_core 0000:02:00.0: Received reset from slave:56
[ 5459.958154]   free irq_desc for 1394
[ 5459.958417]   free irq_desc for 1395
[ 5459.971922]   free irq_desc for 1396
[ 5459.971968]   free irq_desc for 1397
[ 5459.972321] pci 0000:02:07.0: freeing pci_dev info
[ 5460.191680] mlx4_core 0000:02:00.0: Received reset from slave:57
[ 5460.192550]   free irq_desc for 1398
[ 5460.192787]   free irq_desc for 1399
[ 5460.211683]   free irq_desc for 1400
[ 5460.211729]   free irq_desc for 1401
[ 5460.212086] pci 0000:02:07.1: freeing pci_dev info
[ 5460.433863] mlx4_core 0000:02:00.0: Received reset from slave:58
[ 5460.434719]   free irq_desc for 1402
[ 5460.435006]   free irq_desc for 1403
[ 5460.451914]   free irq_desc for 1404
[ 5460.451959]   free irq_desc for 1405
[ 5460.452316] pci 0000:02:07.2: freeing pci_dev info
[ 5460.673364] mlx4_core 0000:02:00.0: Received reset from slave:59
[ 5460.674225]   free irq_desc for 1406
[ 5460.674555]   free irq_desc for 1407
[ 5460.692072]   free irq_desc for 1408
[ 5460.692338]   free irq_desc for 1409
[ 5460.692695] pci 0000:02:07.3: freeing pci_dev info
[ 5460.922618] mlx4_core 0000:02:00.0: Received reset from slave:60
[ 5460.923478]   free irq_desc for 1410
[ 5460.923741]   free irq_desc for 1411
[ 5460.941851]   free irq_desc for 1412
[ 5460.941897]   free irq_desc for 1413
[ 5460.942254] pci 0000:02:07.4: freeing pci_dev info
[ 5461.161658] mlx4_core 0000:02:00.0: Received reset from slave:61
[ 5461.162534]   free irq_desc for 1414
[ 5461.162851]   free irq_desc for 1415
[ 5461.182001]   free irq_desc for 1416
[ 5461.182251]   free irq_desc for 1417
[ 5461.182608] pci 0000:02:07.5: freeing pci_dev info
[ 5461.412367] mlx4_core 0000:02:00.0: Received reset from slave:62
[ 5461.413303]   free irq_desc for 1418
[ 5461.413350]   free irq_desc for 1419
[ 5461.413394]   free irq_desc for 1420
[ 5461.413441]   free irq_desc for 1421
[ 5461.413991] pci 0000:02:07.6: freeing pci_dev info
[ 5461.664620] mlx4_core 0000:02:00.0: Received reset from slave:63
[ 5461.665489]   free irq_desc for 1422
[ 5461.665732]   free irq_desc for 1423
[ 5461.682056]   free irq_desc for 1424
[ 5461.682104]   free irq_desc for 1425
[ 5461.682465] pci 0000:02:07.7: freeing pci_dev info
[ 5463.037163] mlx4_core 0000:02:00.0: command 0x14 failed: fw status = 0x9
[ 5463.037635] mlx4_core 0000:02:00.0: vhcr command:0x14 slave:0
failed with error:0, status -9
[ 5463.052599] mlx4_core 0000:02:00.0: HW2SW_EQ failed (-5)
[ 5463.052605] remove_mtt_ok-761: state RES_MTT_ALLOCATED, ref_count 1
[ 5463.052607] mlx4_core 0000:02:00.0: vhcr command:0xf01 slave:0
failed with error:0, status -16
[ 5463.052611] mlx4_core 0000:02:00.0: Failed to free mtt range at:512 order:9
[ 5463.054664] mlx4_core 0000:02:00.0: command 0x14 failed: fw status = 0x9
[ 5463.054669] mlx4_core 0000:02:00.0: vhcr command:0x14 slave:0
failed with error:0, status -9
[ 5463.054673] mlx4_core 0000:02:00.0: HW2SW_EQ failed (-5)
[ 5463.054678] remove_mtt_ok-761: state RES_MTT_ALLOCATED, ref_count 1
[ 5463.054681] mlx4_core 0000:02:00.0: vhcr command:0xf01 slave:0
failed with error:0, status -16
[ 5463.054684] mlx4_core 0000:02:00.0: Failed to free mtt range at:1024 order:9
[ 5463.056586] mlx4_core 0000:02:00.0: command 0x14 failed: fw status = 0x9
[ 5463.056591] mlx4_core 0000:02:00.0: vhcr command:0x14 slave:0
failed with error:0, status -9
[ 5463.056595] mlx4_core 0000:02:00.0: HW2SW_EQ failed (-5)
[ 5463.056599] remove_mtt_ok-761: state RES_MTT_ALLOCATED, ref_count 1
[ 5463.056602] mlx4_core 0000:02:00.0: vhcr command:0xf01 slave:0
failed with error:0, status -16
[ 5463.056605] mlx4_core 0000:02:00.0: Failed to free mtt range at:1536 order:9
[ 5463.058522] mlx4_core 0000:02:00.0: command 0x14 failed: fw status = 0x9
[ 5463.058527] mlx4_core 0000:02:00.0: vhcr command:0x14 slave:0
failed with error:0, status -9
[ 5463.058531] mlx4_core 0000:02:00.0: HW2SW_EQ failed (-5)
[ 5463.058534] remove_mtt_ok-761: state RES_MTT_ALLOCATED, ref_count 1
[ 5463.058537] mlx4_core 0000:02:00.0: vhcr command:0xf01 slave:0
failed with error:0, status -16
[ 5463.058540] mlx4_core 0000:02:00.0: Failed to free mtt range at:32 order:2
[ 5463.072428]   free irq_desc for 1170
[ 5463.072475]   free irq_desc for 1171
[ 5463.072520]   free irq_desc for 1172
[ 5463.072565]   free irq_desc for 1173
[ 5464.075050] pci 0000:02:00.0: freeing pci_dev info
[ 5464.075364] ------------[ cut here ]------------
[ 5464.075602] WARNING: CPU: 20 PID: 25098 at include/linux/kref.h:47
kobject_get+0x40/0x60()
[ 5464.092574] Modules linked in:
[ 5464.092748] CPU: 20 PID: 25098 Comm: bash Not tainted
3.10.0-yh-04644-g692d9ae-dirty #1787
[ 5464.112615] Hardware name: Oracle Corporation  unknown       /
, BIOS 11016600    05/17/2011
[ 5464.112620]  0000000000000009 ffff885011f51cd8 ffffffff820b9680
0000000000004880
[ 5464.112623]  0000000000000000 ffff885011f51d18 ffffffff81096957
ffffffff82b28f20
[ 5464.112627]  ffff8880263dd000 0000000000000000 ffff883027056828
ffff882025616200
[ 5464.112629] Call Trace:
[ 5464.112640]  [<ffffffff820b9680>] dump_stack+0x46/0x58
[ 5464.112649]  [<ffffffff81096957>] warn_slowpath_common+0x87/0xb0
[ 5464.112654]  [<ffffffff8109699a>] warn_slowpath_null+0x1a/0x20
[ 5464.112657]  [<ffffffff81504aa0>] kobject_get+0x40/0x60
[ 5464.112664]  [<ffffffff81760db7>] get_device+0x17/0x30
[ 5464.112671]  [<ffffffff815387a2>] pci_dev_get+0x22/0x30
[ 5464.112677]  [<ffffffff8154e758>] pciehp_unconfigure_device+0xa8/0x190
[ 5464.112681]  [<ffffffff8154e150>] pciehp_disable_slot+0x160/0x200
[ 5464.112683]  [<ffffffff8154e494>] pciehp_sysfs_disable_slot+0x64/0x130
[ 5464.112686]  [<ffffffff8154d03a>] disable_slot+0x5a/0x70
[ 5464.112695]  [<ffffffff8154997f>] power_write_file+0xaf/0x130
[ 5464.112699]  [<ffffffff8153f471>] pci_slot_attr_store+0x21/0x30
[ 5464.112708]  [<ffffffff8124272b>] sysfs_write_file+0x10b/0x160
[ 5464.112718]  [<ffffffff811d1b1b>] vfs_write+0xeb/0x1d0
[ 5464.112721]  [<ffffffff811d1fb5>] SyS_write+0x55/0xb0
[ 5464.112728]  [<ffffffff820d609a>] tracesys+0xd4/0xd9
[ 5464.112730] ---[ end trace a3110aa40b91f7fc ]---
[ 5464.112744] pci : freeing pci_dev info
[ 5464.112745] ------------[ cut here ]------------
[ 5464.112753] WARNING: CPU: 20 PID: 25098 at lib/list_debug.c:56
__list_del_entry+0x63/0xe0()
[ 5464.112755] list_del corruption, ffff8880263dd000->prev is
LIST_POISON2 (dead000000200200)
[ 5464.112756] Modules linked in:
[ 5464.112759] CPU: 20 PID: 25098 Comm: bash Tainted: G        W
3.10.0-yh-04644-g692d9ae-dirty #1787
[ 5464.112760] Hardware name: Oracle Corporation  unknown       /
, BIOS 11016600    05/17/2011
[ 5464.112764]  0000000000000009 ffff885011f51bc8 ffffffff820b9680
0000000000000d70
[ 5464.112768]  ffff885011f51c18 ffff885011f51c08 ffffffff81096957
ffff885011f51c58
[ 5464.112771]  ffff8880263dd000 ffff8880263dd000 ffff8880263dd098
ffff8880263dd0a8
[ 5464.112772] Call Trace:
[ 5464.112776]  [<ffffffff820b9680>] dump_stack+0x46/0x58
[ 5464.112779]  [<ffffffff81096957>] warn_slowpath_common+0x87/0xb0
[ 5464.112782]  [<ffffffff81096a36>] warn_slowpath_fmt+0x46/0x50
[ 5464.112786]  [<ffffffff81518273>] __list_del_entry+0x63/0xe0
[ 5464.112790]  [<ffffffff81518301>] list_del+0x11/0x40
[ 5464.112797]  [<ffffffff8153064c>] pci_release_dev+0x4c/0x150
[ 5464.112801]  [<ffffffff817610f5>] device_release+0xa5/0x110
[ 5464.112804]  [<ffffffff81504c4f>] kobject_release+0x6f/0x90
[ 5464.112807]  [<ffffffff81504b0c>] kobject_put+0x4c/0x60
[ 5464.112810]  [<ffffffff81760e07>] put_device+0x17/0x20
[ 5464.112812]  [<ffffffff815386aa>] pci_dev_put+0x1a/0x20
[ 5464.112815]  [<ffffffff8154e812>] pciehp_unconfigure_device+0x162/0x190
[ 5464.112818]  [<ffffffff8154e150>] pciehp_disable_slot+0x160/0x200
[ 5464.112821]  [<ffffffff8154e494>] pciehp_sysfs_disable_slot+0x64/0x130
[ 5464.112823]  [<ffffffff8154d03a>] disable_slot+0x5a/0x70
[ 5464.112826]  [<ffffffff8154997f>] power_write_file+0xaf/0x130
[ 5464.112830]  [<ffffffff8153f471>] pci_slot_attr_store+0x21/0x30
[ 5464.112833]  [<ffffffff8124272b>] sysfs_write_file+0x10b/0x160
[ 5464.112836]  [<ffffffff811d1b1b>] vfs_write+0xeb/0x1d0
[ 5464.112839]  [<ffffffff811d1fb5>] SyS_write+0x55/0xb0
[ 5464.112842]  [<ffffffff820d609a>] tracesys+0xd4/0xd9
[ 5464.112844] ---[ end trace a3110aa40b91f7fd ]---
[ 5464.112859] BUG: unable to handle kernel NULL pointer dereference
at           (null)
[ 5464.112863] IP: [<ffffffff8154e815>] pciehp_unconfigure_device+0x165/0x190
[ 5464.112866] PGD 0
[ 5464.112868] Oops: 0000 [#1] SMP
[ 5464.112871] Modules linked in:
[ 5464.112873] CPU: 20 PID: 25098 Comm: bash Tainted: G        W
3.10.0-yh-04644-g692d9ae-dirty #1787
[ 5464.112874] Hardware name: Oracle Corporation  unknown       /
, BIOS 11016600    05/17/2011
[ 5464.112875] task: ffff8850278acb40 ti: ffff885011f50000 task.ti:
ffff885011f50000
[ 5464.112878] RIP: 0010:[<ffffffff8154e815>]  [<ffffffff8154e815>]
pciehp_unconfigure_device+0x165/0x190
[ 5464.112879] RSP: 0018:ffff885011f51d88  EFLAGS: 00010296
[ 5464.112881] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000181000094
[ 5464.112882] RDX: 0000000181000095 RSI: 0000000000000001 RDI: ffff88103d807d00
[ 5464.112883] RBP: ffff885011f51db8 R08: 0000000000000007 R09: ffff88303e7d70c0
[ 5464.112884] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[ 5464.112886] R13: ffff883027056828 R14: ffff882025616200 R15: ffff886025383ea0
[ 5464.112888] FS:  00007f6ef7efa700(0000) GS:ffff88303e600000(0000)
knlGS:0000000000000000
[ 5464.112889] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 5464.112891] CR2: 0000000000000000 CR3: 0000003010ce7000 CR4: 00000000000007e0
[ 5464.112892] Stack:
[ 5464.112895]  ffff885011f51da8 fefb010000000002 ffff882025616000
ffff882025616200
[ 5464.112898]  ffff882025616200 ffffffff822a36a0 ffff885011f51df8
ffffffff8154e150
[ 5464.112900]  0000000000000001 01ff882025616000 ffff882025616000
ffff8820256160f8
[ 5464.112900] Call Trace:
[ 5464.112903]  [<ffffffff8154e150>] pciehp_disable_slot+0x160/0x200
[ 5464.112905]  [<ffffffff8154e494>] pciehp_sysfs_disable_slot+0x64/0x130
[ 5464.112908]  [<ffffffff8154d03a>] disable_slot+0x5a/0x70
[ 5464.112910]  [<ffffffff8154997f>] power_write_file+0xaf/0x130
[ 5464.112913]  [<ffffffff8153f471>] pci_slot_attr_store+0x21/0x30
[ 5464.112916]  [<ffffffff8124272b>] sysfs_write_file+0x10b/0x160
[ 5464.112919]  [<ffffffff811d1b1b>] vfs_write+0xeb/0x1d0
[ 5464.112921]  [<ffffffff811d1fb5>] SyS_write+0x55/0xb0
[ 5464.112923]  [<ffffffff820d609a>] tracesys+0xd4/0xd9
[ 5464.112947] Code: ba 04 00 00 00 48 8b 7b 10 66 81 e1 fb fe 80 cd
04 66 89 4d de 0f b7 c9 e8 39 fd fd ff 48 89 df 4c 89 e3 e8 7e 9e fe
ff 4c 89 e0 <4d> 8b 24 24 4c 39 e8 0f 85 2e ff ff ff e9 21 ff ff ff 66
0f 1f
[ 5464.112949] RIP  [<ffffffff8154e815>] pciehp_unconfigure_device+0x165/0x190
[ 5464.112950]  RSP <ffff885011f51d88>
[ 5464.112951] CR2: 0000000000000000
[ 5464.113457] ---[ end trace a3110aa40b91f7fe ]---
