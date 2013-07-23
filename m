Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:50320 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934665Ab3GWWoB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 18:44:01 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so11227756obc.26
        for <linux-pci@vger.kernel.org>; Tue, 23 Jul 2013 15:44:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130723155645.GA18422@google.com>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
	<1374261258-23036-2-git-send-email-yinghai@kernel.org>
	<CAErSpo78DU3bPwkVOt=1XD08y9iD38+wUOp2+GVxO7P68TOOjg@mail.gmail.com>
	<CAE9FiQUyVUssJx8eZK9kabS99CD6ry-UnJ9q1-q+f53Fx+tjng@mail.gmail.com>
	<20130723155645.GA18422@google.com>
Date: Tue, 23 Jul 2013 15:44:00 -0700
Message-ID: <CAE9FiQVrr+sgYOJFcpHs_jZacB0s2z23YCX+vmcLUg2T6kg=bQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Separate stop and remove devices in pciehp
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 23, 2013 at 8:56 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Can you include an example that shows the failure, like you did for
> the "Fix hotplug remove" patch?

Rescue:~ # echo -n 0 > /sys/bus/pci/slots/2/power
[  342.236825] pci_hotplug: power_write_file: power = 0
[  342.237149] pciehp 0000:00:03.0:pcie04: disable_slot: physical_slot = 2
[  342.247370] pciehp 0000:00:03.0:pcie04: pciehp_get_power_status:
SLOTCTRL a8 value read 1f9
[  342.247922] pciehp 0000:00:03.0:pcie04: pciehp_unconfigure_device:
domain:bus:dev = 0000:02:00
[  342.467075] mlx4_core 0000:02:00.0: Received reset from slave:63
[  342.467909]   free irq_desc for 1422
[  342.468154]   free irq_desc for 1423
[  342.468181]   free irq_desc for 1424
[  342.468208]   free irq_desc for 1425
[  342.469192] pci 0000:02:07.7: freeing pci_dev info
[  342.708175] mlx4_core 0000:02:00.0: Received reset from slave:62
[  342.708990]   free irq_desc for 1418
[  342.709223]   free irq_desc for 1419
[  342.727400]   free irq_desc for 1420
[  342.727656]   free irq_desc for 1421
[  342.728072] pci 0000:02:07.6: freeing pci_dev info
[  342.946429] mlx4_core 0000:02:00.0: Received reset from slave:61
[  342.947283]   free irq_desc for 1414
[  342.947511]   free irq_desc for 1415
[  342.957275]   free irq_desc for 1416
[  342.957301]   free irq_desc for 1417
[  342.957722] pci 0000:02:07.5: freeing pci_dev info
[  343.189692] mlx4_core 0000:02:00.0: Received reset from slave:60
[  343.190545]   free irq_desc for 1410
[  343.190814]   free irq_desc for 1411
[  343.207337]   free irq_desc for 1412
[  343.207576]   free irq_desc for 1413
[  343.207985] pci 0000:02:07.4: freeing pci_dev info
[  343.410663] mlx4_core 0000:02:00.0: Received reset from slave:59
[  343.411639]   free irq_desc for 1406
[  343.411880]   free irq_desc for 1407
[  343.427370]   free irq_desc for 1408
[  343.427412]   free irq_desc for 1409
[  343.427741] pci 0000:02:07.3: freeing pci_dev info
[  343.630818] mlx4_core 0000:02:00.0: Received reset from slave:58
[  343.631652]   free irq_desc for 1402
[  343.631842]   free irq_desc for 1403
[  343.647404]   free irq_desc for 1404
[  343.647433]   free irq_desc for 1405
[  343.647769] pci 0000:02:07.2: freeing pci_dev info
[  343.877043] mlx4_core 0000:02:00.0: Received reset from slave:57
[  343.877884]   free irq_desc for 1398
[  343.878128]   free irq_desc for 1399
[  343.887382]   free irq_desc for 1400
[  343.887409]   free irq_desc for 1401
[  343.887827] pci 0000:02:07.1: freeing pci_dev info
[  344.117975] mlx4_core 0000:02:00.0: Received reset from slave:56
[  344.118777]   free irq_desc for 1394
[  344.118978]   free irq_desc for 1395
[  344.137653]   free irq_desc for 1396
[  344.137683]   free irq_desc for 1397
[  344.138013] pci 0000:02:07.0: freeing pci_dev info
[  344.353527] mlx4_core 0000:02:00.0: Received reset from slave:55
[  344.354368]   free irq_desc for 1390
[  344.354616]   free irq_desc for 1391
[  344.367628]   free irq_desc for 1392
[  344.367654]   free irq_desc for 1393
[  344.368080] pci 0000:02:06.7: freeing pci_dev info
[  344.578265] mlx4_core 0000:02:00.0: Received reset from slave:54
[  344.579170]   free irq_desc for 1386
[  344.579393]   free irq_desc for 1387
[  344.597591]   free irq_desc for 1388
[  344.597829]   free irq_desc for 1389
[  344.598375] pci 0000:02:06.6: freeing pci_dev info
[  344.823697] mlx4_core 0000:02:00.0: Received reset from slave:53
[  344.824566]   free irq_desc for 1382
[  344.824796]   free irq_desc for 1383
[  344.837932]   free irq_desc for 1384
[  344.837958]   free irq_desc for 1385
[  344.838295] pci 0000:02:06.5: freeing pci_dev info
[  345.080025] mlx4_core 0000:02:00.0: Received reset from slave:52
[  345.080991]   free irq_desc for 1378
[  345.081017]   free irq_desc for 1379
[  345.081044]   free irq_desc for 1380
[  345.081072]   free irq_desc for 1381
[  345.081673] pci 0000:02:06.4: freeing pci_dev info
[  345.324705] mlx4_core 0000:02:00.0: Received reset from slave:51
[  345.325533]   free irq_desc for 1374
[  345.325776]   free irq_desc for 1375
[  345.337761]   free irq_desc for 1376
[  345.338003]   free irq_desc for 1377
[  345.338344] pci 0000:02:06.3: freeing pci_dev info
[  345.561761] mlx4_core 0000:02:00.0: Received reset from slave:50
[  345.562572]   free irq_desc for 1370
[  345.562854]   free irq_desc for 1371
[  345.577696]   free irq_desc for 1372
[  345.577900]   free irq_desc for 1373
[  345.578428] pci 0000:02:06.2: freeing pci_dev info
[  345.817280] mlx4_core 0000:02:00.0: Received reset from slave:49
[  345.818069]   free irq_desc for 1366
[  345.818334]   free irq_desc for 1367
[  345.827792]   free irq_desc for 1368
[  345.828041]   free irq_desc for 1369
[  345.828479] pci 0000:02:06.1: freeing pci_dev info
[  346.043593] mlx4_core 0000:02:00.0: Received reset from slave:48
[  346.044435]   free irq_desc for 1362
[  346.044696]   free irq_desc for 1363
[  346.057780]   free irq_desc for 1364
[  346.058026]   free irq_desc for 1365
[  346.058468] pci 0000:02:06.0: freeing pci_dev info
[  346.285626] mlx4_core 0000:02:00.0: Received reset from slave:47
[  346.286447]   free irq_desc for 1358
[  346.286654]   free irq_desc for 1359
[  346.298437]   free irq_desc for 1360
[  346.298468]   free irq_desc for 1361
[  346.298883] pci 0000:02:05.7: freeing pci_dev info
[  346.521972] mlx4_core 0000:02:00.0: Received reset from slave:46
[  346.522804]   free irq_desc for 1354
[  346.523021]   free irq_desc for 1355
[  346.537805]   free irq_desc for 1356
[  346.538014]   free irq_desc for 1357
[  346.538345] pci 0000:02:05.6: freeing pci_dev info
[  346.758293] mlx4_core 0000:02:00.0: Received reset from slave:45
[  346.759116]   free irq_desc for 1350
[  346.759326]   free irq_desc for 1351
[  346.777970]   free irq_desc for 1352
[  346.778225]   free irq_desc for 1353
[  346.778594] pci 0000:02:05.5: freeing pci_dev info
[  347.002991] mlx4_core 0000:02:00.0: Received reset from slave:44
[  347.003844]   free irq_desc for 1346
[  347.004075]   free irq_desc for 1347
[  347.017996]   free irq_desc for 1348
[  347.018022]   free irq_desc for 1349
[  347.018428] pci 0000:02:05.4: freeing pci_dev info
[  347.246432] mlx4_core 0000:02:00.0: Received reset from slave:43
[  347.247341]   free irq_desc for 1342
[  347.247584]   free irq_desc for 1343
[  347.258171]   free irq_desc for 1344
[  347.258198]   free irq_desc for 1345
[  347.258711] pci 0000:02:05.3: freeing pci_dev info
[  347.479329] mlx4_core 0000:02:00.0: Received reset from slave:42
[  347.480199]   free irq_desc for 1338
[  347.480428]   free irq_desc for 1339
[  347.498712]   free irq_desc for 1340
[  347.498740]   free irq_desc for 1341
[  347.499261] pci 0000:02:05.2: freeing pci_dev info
[  347.722833] mlx4_core 0000:02:00.0: Received reset from slave:41
[  347.723694]   free irq_desc for 1334
[  347.723909]   free irq_desc for 1335
[  347.738117]   free irq_desc for 1336
[  347.738145]   free irq_desc for 1337
[  347.738865] pci 0000:02:05.1: freeing pci_dev info
[  347.966906] mlx4_core 0000:02:00.0: Received reset from slave:40
[  347.967833]   free irq_desc for 1330
[  347.968129]   free irq_desc for 1331
[  347.978209]   free irq_desc for 1332
[  347.978235]   free irq_desc for 1333
[  347.978779] pci 0000:02:05.0: freeing pci_dev info
[  348.202972] mlx4_core 0000:02:00.0: Received reset from slave:39
[  348.203801]   free irq_desc for 1326
[  348.204106]   free irq_desc for 1327
[  348.218210]   free irq_desc for 1328
[  348.218239]   free irq_desc for 1329
[  348.218707] pci 0000:02:04.7: freeing pci_dev info
[  348.440833] mlx4_core 0000:02:00.0: Received reset from slave:38
[  348.441566]   free irq_desc for 1322
[  348.441592]   free irq_desc for 1323
[  348.441618]   free irq_desc for 1324
[  348.441645]   free irq_desc for 1325
[  348.442210] pci 0000:02:04.6: freeing pci_dev info
[  348.674736] mlx4_core 0000:02:00.0: Received reset from slave:37
[  348.675620]   free irq_desc for 1318
[  348.675836]   free irq_desc for 1319
[  348.688249]   free irq_desc for 1320
[  348.688279]   free irq_desc for 1321
[  348.688913] pci 0000:02:04.5: freeing pci_dev info
[  348.915084] mlx4_core 0000:02:00.0: Received reset from slave:36
[  348.915924]   free irq_desc for 1314
[  348.916166]   free irq_desc for 1315
[  348.928316]   free irq_desc for 1316
[  348.928342]   free irq_desc for 1317
[  348.928891] pci 0000:02:04.4: freeing pci_dev info
[  349.163498] mlx4_core 0000:02:00.0: Received reset from slave:35
[  349.164328]   free irq_desc for 1310
[  349.164557]   free irq_desc for 1311
[  349.178429]   free irq_desc for 1312
[  349.178457]   free irq_desc for 1313
[  349.178925] pci 0000:02:04.3: freeing pci_dev info
[  349.408023] mlx4_core 0000:02:00.0: Received reset from slave:34
[  349.408968]   free irq_desc for 1306
[  349.409262]   free irq_desc for 1307
[  349.428433]   free irq_desc for 1308
[  349.428458]   free irq_desc for 1309
[  349.429123] pci 0000:02:04.2: freeing pci_dev info
[  349.654194] mlx4_core 0000:02:00.0: Received reset from slave:33
[  349.655147]   free irq_desc for 1302
[  349.655371]   free irq_desc for 1303
[  349.668461]   free irq_desc for 1304
[  349.668493]   free irq_desc for 1305
[  349.669050] pci 0000:02:04.1: freeing pci_dev info
[  349.891204] mlx4_core 0000:02:00.0: Received reset from slave:32
[  349.892084]   free irq_desc for 1298
[  349.892379]   free irq_desc for 1299
[  349.910554]   free irq_desc for 1300
[  349.910580]   free irq_desc for 1301
[  349.910977] pci 0000:02:04.0: freeing pci_dev info
[  350.135234] mlx4_core 0000:02:00.0: Received reset from slave:31
[  350.136159]   free irq_desc for 1294
[  350.136402]   free irq_desc for 1295
[  350.148679]   free irq_desc for 1296
[  350.148706]   free irq_desc for 1297
[  350.149284] pci 0000:02:03.7: freeing pci_dev info
[  350.375403] mlx4_core 0000:02:00.0: Received reset from slave:30
[  350.376317]   free irq_desc for 1290
[  350.376562]   free irq_desc for 1291
[  350.388723]   free irq_desc for 1292
[  350.388752]   free irq_desc for 1293
[  350.389227] pci 0000:02:03.6: freeing pci_dev info
[  350.623964] mlx4_core 0000:02:00.0: Received reset from slave:29
[  350.624553]   free irq_desc for 1286
[  350.624797]   free irq_desc for 1287
[  350.639613]   free irq_desc for 1288
[  350.639639]   free irq_desc for 1289
[  350.640102] pci 0000:02:03.5: freeing pci_dev info
[  350.859688] mlx4_core 0000:02:00.0: Received reset from slave:28
[  350.860599]   free irq_desc for 1282
[  350.860867]   free irq_desc for 1283
[  350.878685]   free irq_desc for 1284
[  350.878713]   free irq_desc for 1285
[  350.879210] pci 0000:02:03.4: freeing pci_dev info
[  351.120632] mlx4_core 0000:02:00.0: Received reset from slave:27
[  351.121627]   free irq_desc for 1278
[  351.121876]   free irq_desc for 1279
[  351.138726]   free irq_desc for 1280
[  351.138754]   free irq_desc for 1281
[  351.139239] pci 0000:02:03.3: freeing pci_dev info
[  351.371352] mlx4_core 0000:02:00.0: Received reset from slave:26
[  351.372238]   free irq_desc for 1274
[  351.372446]   free irq_desc for 1275
[  351.388802]   free irq_desc for 1276
[  351.388830]   free irq_desc for 1277
[  351.389344] pci 0000:02:03.2: freeing pci_dev info
[  351.607354] mlx4_core 0000:02:00.0: Received reset from slave:25
[  351.608232]   free irq_desc for 1270
[  351.608542]   free irq_desc for 1271
[  351.618836]   free irq_desc for 1272
[  351.618863]   free irq_desc for 1273
[  351.619517] pci 0000:02:03.1: freeing pci_dev info
[  351.847766] mlx4_core 0000:02:00.0: Received reset from slave:24
[  351.848654]   free irq_desc for 1266
[  351.848939]   free irq_desc for 1267
[  351.859021]   free irq_desc for 1268
[  351.859050]   free irq_desc for 1269
[  351.859523] pci 0000:02:03.0: freeing pci_dev info
[  352.088053] mlx4_core 0000:02:00.0: Received reset from slave:23
[  352.088968]   free irq_desc for 1262
[  352.089296]   free irq_desc for 1263
[  352.099156]   free irq_desc for 1264
[  352.099183]   free irq_desc for 1265
[  352.099819] pci 0000:02:02.7: freeing pci_dev info
[  352.315173] mlx4_core 0000:02:00.0: Received reset from slave:22
[  352.316039]   free irq_desc for 1258
[  352.316318]   free irq_desc for 1259
[  352.329593]   free irq_desc for 1260
[  352.329621]   free irq_desc for 1261
[  352.330101] pci 0000:02:02.6: freeing pci_dev info
[  352.552492] mlx4_core 0000:02:00.0: Received reset from slave:21
[  352.553419]   free irq_desc for 1254
[  352.553618]   free irq_desc for 1255
[  352.568953]   free irq_desc for 1256
[  352.569255]   free irq_desc for 1257
[  352.569765] pci 0000:02:02.5: freeing pci_dev info
[  352.795614] mlx4_core 0000:02:00.0: Received reset from slave:20
[  352.796516]   free irq_desc for 1250
[  352.796782]   free irq_desc for 1251
[  352.810942]   free irq_desc for 1252
[  352.810970]   free irq_desc for 1253
[  352.811667] pci 0000:02:02.4: freeing pci_dev info
[  353.036489] mlx4_core 0000:02:00.0: Received reset from slave:19
[  353.037399]   free irq_desc for 1246
[  353.037618]   free irq_desc for 1247
[  353.049243]   free irq_desc for 1248
[  353.049269]   free irq_desc for 1249
[  353.049919] pci 0000:02:02.3: freeing pci_dev info
[  353.268173] mlx4_core 0000:02:00.0: Received reset from slave:18
[  353.269072]   free irq_desc for 1242
[  353.269338]   free irq_desc for 1243
[  353.279047]   free irq_desc for 1244
[  353.279075]   free irq_desc for 1245
[  353.279578] pci 0000:02:02.2: freeing pci_dev info
[  353.495897] mlx4_core 0000:02:00.0: Received reset from slave:17
[  353.496792]   free irq_desc for 1238
[  353.497020]   free irq_desc for 1239
[  353.509130]   free irq_desc for 1240
[  353.509155]   free irq_desc for 1241
[  353.509591] pci 0000:02:02.1: freeing pci_dev info
[  353.727846] mlx4_core 0000:02:00.0: Received reset from slave:16
[  353.728760]   free irq_desc for 1234
[  353.729031]   free irq_desc for 1235
[  353.739199]   free irq_desc for 1236
[  353.739226]   free irq_desc for 1237
[  353.739710] pci 0000:02:02.0: freeing pci_dev info
[  353.964528] mlx4_core 0000:02:00.0: Received reset from slave:15
[  353.965411]   free irq_desc for 1230
[  353.965702]   free irq_desc for 1231
[  353.979235]   free irq_desc for 1232
[  353.979264]   free irq_desc for 1233
[  353.979754] pci 0000:02:01.7: freeing pci_dev info
[  354.192662] mlx4_core 0000:02:00.0: Received reset from slave:14
[  354.193571]   free irq_desc for 1226
[  354.193818]   free irq_desc for 1227
[  354.211294]   free irq_desc for 1228
[  354.211323]   free irq_desc for 1229
[  354.211725] pci 0000:02:01.6: freeing pci_dev info
[  354.430697] mlx4_core 0000:02:00.0: Received reset from slave:13
[  354.431291]   free irq_desc for 1222
[  354.431596]   free irq_desc for 1223
[  354.449506]   free irq_desc for 1224
[  354.449868]   free irq_desc for 1225
[  354.450335] pci 0000:02:01.5: freeing pci_dev info
[  354.671942] mlx4_core 0000:02:00.0: Received reset from slave:12
[  354.672829]   free irq_desc for 1218
[  354.673044]   free irq_desc for 1219
[  354.689367]   free irq_desc for 1220
[  354.689710]   free irq_desc for 1221
[  354.690078] pci 0000:02:01.4: freeing pci_dev info
[  354.905203] mlx4_core 0000:02:00.0: Received reset from slave:11
[  354.906106]   free irq_desc for 1214
[  354.906403]   free irq_desc for 1215
[  354.919409]   free irq_desc for 1216
[  354.919441]   free irq_desc for 1217
[  354.919868] pci 0000:02:01.3: freeing pci_dev info
[  355.136846] mlx4_core 0000:02:00.0: Received reset from slave:10
[  355.137760]   free irq_desc for 1210
[  355.138031]   free irq_desc for 1211
[  355.149449]   free irq_desc for 1212
[  355.149474]   free irq_desc for 1213
[  355.150103] pci 0000:02:01.2: freeing pci_dev info
[  355.376467] mlx4_core 0000:02:00.0: Received reset from slave:9
[  355.377307]   free irq_desc for 1206
[  355.377613]   free irq_desc for 1207
[  355.389630]   free irq_desc for 1208
[  355.389658]   free irq_desc for 1209
[  355.390091] pci 0000:02:01.1: freeing pci_dev info
[  355.614027] mlx4_core 0000:02:00.0: Received reset from slave:8
[  355.614871]   free irq_desc for 1202
[  355.615125]   free irq_desc for 1203
[  355.615151]   free irq_desc for 1204
[  355.615177]   free irq_desc for 1205
[  355.615608] pci 0000:02:01.0: freeing pci_dev info
[  355.845129] mlx4_core 0000:02:00.0: Received reset from slave:7
[  355.846105]   free irq_desc for 1198
[  355.846343]   free irq_desc for 1199
[  355.859707]   free irq_desc for 1200
[  355.859738]   free irq_desc for 1201
[  355.860170] pci 0000:02:00.7: freeing pci_dev info
[  356.080643] mlx4_core 0000:02:00.0: Received reset from slave:6
[  356.081540]   free irq_desc for 1194
[  356.081821]   free irq_desc for 1195
[  356.099602]   free irq_desc for 1196
[  356.099628]   free irq_desc for 1197
[  356.100048] pci 0000:02:00.6: freeing pci_dev info
[  356.317310] mlx4_core 0000:02:00.0: Received reset from slave:5
[  356.318150]   free irq_desc for 1190
[  356.318414]   free irq_desc for 1191
[  356.329658]   free irq_desc for 1192
[  356.329687]   free irq_desc for 1193
[  356.330131] pci 0000:02:00.5: freeing pci_dev info
[  356.560616] mlx4_core 0000:02:00.0: Received reset from slave:4
[  356.561558]   free irq_desc for 1186
[  356.561796]   free irq_desc for 1187
[  356.579690]   free irq_desc for 1188
[  356.579716]   free irq_desc for 1189
[  356.580123] pci 0000:02:00.4: freeing pci_dev info
[  356.805358] mlx4_core 0000:02:00.0: Received reset from slave:3
[  356.806231]   free irq_desc for 1182
[  356.806512]   free irq_desc for 1183
[  356.819726]   free irq_desc for 1184
[  356.819755]   free irq_desc for 1185
[  356.820244] pci 0000:02:00.3: freeing pci_dev info
[  357.037258] mlx4_core 0000:02:00.0: Received reset from slave:2
[  357.038125]   free irq_desc for 1178
[  357.038350]   free irq_desc for 1179
[  357.049932]   free irq_desc for 1180
[  357.049956]   free irq_desc for 1181
[  357.050484] pci 0000:02:00.2: freeing pci_dev info
[  357.280942] mlx4_core 0000:02:00.0: Received reset from slave:1
[  357.281875]   free irq_desc for 1174
[  357.282105]   free irq_desc for 1175
[  357.299910]   free irq_desc for 1176
[  357.299936]   free irq_desc for 1177
[  357.300380] pci 0000:02:00.1: freeing pci_dev info
[  357.666540]   free irq_desc for 1170
[  357.666769]   free irq_desc for 1171
[  357.666969]   free irq_desc for 1172
[  357.667331]   free irq_desc for 1173
[  357.679938] mlx4_core 0000:02:00.0: Disabling SR-IOV
[  359.692517] pcieport 0000:00:03.0: pcie_link_disable_set: lnk_ctrl = 50
[  359.693860] pciehp 0000:00:03.0:pcie04: pcie_isr: intr_loc 10
[  359.710375] pciehp 0000:00:03.0:pcie04: pciehp_power_off_slot:
SLOTCTRL a8 write cmd 400
[  360.713164] pciehp 0000:00:03.0:pcie04: pcie_isr: intr_loc 10
[  360.713568] pciehp 0000:00:03.0:pcie04: pciehp_green_led_off:
SLOTCTRL a8 write cmd 300
Rescue:~ #
Rescue:~ # echo -n 1 > /sys/bus/pci/slots/2/power
[  386.009999] pci_hotplug: power_write_file: power = 1
[  386.010279] pciehp 0000:00:03.0:pcie04: enable_slot: physical_slot = 2
[  386.014703] pciehp 0000:00:03.0:pcie04: pciehp_get_power_status:
SLOTCTRL a8 value read 7f9
[  386.016722] pciehp 0000:00:03.0:pcie04: pcie_isr: intr_loc 10
[  386.034851] pciehp 0000:00:03.0:pcie04: pciehp_power_on_slot:
SLOTCTRL a8 write cmd 0
[  386.054793] pcieport 0000:00:03.0: pcie_link_disable_set: lnk_ctrl = 40
[  386.055342] pciehp 0000:00:03.0:pcie04: pcie_isr: intr_loc 10
[  386.075495] pciehp 0000:00:03.0:pcie04: pciehp_green_led_blink:
SLOTCTRL a8 write cmd 200
[  386.345818] pciehp 0000:00:03.0:pcie04: check_link_active: lnk_status = f082
[  386.449877] pciehp 0000:00:03.0:pcie04: pciehp_check_link_status:
lnk_status = f082
[  386.450350] pciehp 0000:00:03.0:pcie04: Device 0000:02:00.0 already
exists at 0000:02:00, cannot hot-add
[  386.464941] pciehp 0000:00:03.0:pcie04: Cannot add device at 0000:02:00
[  386.485177] pcieport 0000:00:03.0: pcie_link_disable_set: lnk_ctrl = 50
[  386.485180] pciehp 0000:00:03.0:pcie04: check_link_active: lnk_status = f882
[  386.499216] pciehp 0000:00:03.0:pcie04: pcie_isr: intr_loc 10
[  386.499236] pciehp 0000:00:03.0:pcie04: pciehp_power_off_slot:
SLOTCTRL a8 write cmd 400
[  387.503092] pciehp 0000:00:03.0:pcie04: pcie_isr: intr_loc 10
[  387.503425] pciehp 0000:00:03.0:pcie04: pciehp_green_led_off:
SLOTCTRL a8 write cmd 300
[  387.515045] pciehp 0000:00:03.0:pcie04:
pciehp_set_attention_status: SLOTCTRL a8 write cmd 40
[  387.536437] pciehp 0000:00:03.0:pcie04: pcie_isr: intr_loc 10
-bash: echo: write error: Invalid argument
