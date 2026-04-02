Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3153D3CE7;
	Thu,  2 Apr 2026 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122755; cv=fail; b=J09wTTGhXgZPnmdEl+Bco4byziY18fOQwiXg656jr4MRCKw2J+4QjcGHbXyhAwRpQmK8XKVTfUxb0FlEZtiP84zezQPnc8M1qk5FtIBCskpaUYT4WwqHtoBPudXRvaZxMd3nVXSydPoyf/CPIJgbZueI3Bp3q0ao9nDSiYifExM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122755; c=relaxed/simple;
	bh=RMQrCLdbz4jiURBfeNjRslP0s1ygPNcG7d8k3DPgmy0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sJK8tm4qCVUv5gZ9P0OjxdEw5FejEHIbx0FG+u+AXMnSIAcG/uGyPaqX/OeLQX3oD2ZqYFCHArrKZ1GvwRzwCzKcd1oePK2Z7ki86fBdDtvWRYdPiUl0VpBoKla6ZrXslNq2c/iIc1/PqxuGOBPJktFFM8LKR69VTC3xeFIW5zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m0K/w+JF; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m0K/w+JF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0PmRKt4dMmsLeSQea+CVT9XRmCeEL4d1ARw1v8HREh/7VWF2wyFNCh8lNqArjJp+m/nDBKfNb0exm3prutapHaiVgMydm/HD899R/7J0H8HLNxeFeAKzZrjfQl2ECQPz+wnu9KfUquccKZT92lJtG5jNw5JvdzlPdn6VRgjG72cYeP6PTvMVUoAiaQcT0OJtw2xECfTc6/V2HqcmBQCKCijAzjkSG+yqFNKycCM2B1bmRAXx6ezUcYZ8Z2Z2ZBJA+IxQqTRFLVri/eb6/9QBs6i/hCm8WGdhov5qcgHmOBmVYJzeugayXEf99PJvHRZbEYR+zxDAFsByNQlZTnI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejqrYxkyVjscL/VY7y7kuDp/OuQgloD6i2Ludz84Qdw=;
 b=b5l8cXq5TSUrTEnDqUmssrbLG5ZHiv7wGm/woBflizn3a87QwQaA6cuRkAgzDGPdfWPoJ3qI48hBB9ABpPGR34IJeJAG/Ns100ZyE2eSJc2Kq8VoyK6EBS/1MXDy+iqUOBQAgsajneYmsiMD6HIfRa1Hs91f1J83ywJT01Ay8+OZ0hhAdEpodCsTnF8yVArZVx8B4LcYUH0kVTOmlMPAKZrFRjxIrA8ia3GwaMKcmaRZiH/zA9/LqGhSPKo/m7plxey19rE2r64Zbf29xRM9Yu+rHI4sEVsIdqvAWSjmrvoVTFKhjTfGSwuN7q95Og2CV3bKcrm+EZCCyuvT05F70Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejqrYxkyVjscL/VY7y7kuDp/OuQgloD6i2Ludz84Qdw=;
 b=m0K/w+JFUTyDlHtxM+zqSJ65FURUi47p5uguYt2+a7xMoR9WNXlKRududoRl8LDM42AYhBJifevtfeYWCuwGEJWMJVkqk1kHuoxS7CqwOBB5yaOY4b8ZUPNyYfoQ2wBBvWwaXu18lp6J5B+71x6z2PdWdcClYuIf+4YydPJQdC+DMpPVaPqdydRIdk3fdgnaYhQ8P5ooZ0B8jjvhRdhzarwtPCei9neO0/1uZoS8JviRHL2K1OEWjRsy3fyJel/lOygx7ZLB++XdwB3GgH3wQM4MZG9I4ZDYeRuB5dZ+hETbvKQrD0clfWXolTyyTBO2Xs1gaEK2kV8lleFnNTSIew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 09:39:02 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 09:39:02 +0000
From: Richard Cheng <icheng@nvidia.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jan@nvidia.com,
	newtonl@nvidia.com,
	sreddym@nvidia.com,
	skomatineni@nvidia.com,
	vidyas@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	mochs@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] PCI/NPEM: Set LED_HW_PLUGGABLE for hotplug-capable ports
Date: Thu,  2 Apr 2026 17:38:50 +0800
Message-Id: <20260402093850.23075-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: a76a6b7c-ceb2-4612-635d-08de909bac49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DDdzQd8qK8fls/x1iBrpraDT2loGSk7nVg2BnqOE9YKrQWwQ6mFe7pOuwJI/wacpvm5vSaFt2lKO1Yg0IQbD68UmvORVYhQJs1xsvdej2xcCojO+mK/gyYJHqZL15TDQHJOC4XyQho9CwnUXeh3AB0iK8ImLA7JUGesbr0aFSyS1XYGQAKfiA+ViJscxeUOSnR55mcDGXykVassTwzMPjnWkd01g43ARwLZBt7fh0vCUJYo/m48oHegRvIoS5YaHnIxO1e7NNorvn1bpylhzHY/5Ja/axUWzOXCRGfWOmJQwOMKFoJ0ty7KIx6wGXGR6s/J8vN14DUcv0ISAwaUit4+nW0dQlaPJ3rrXkB28ZcywqswI/xsx4WjsxrEiGk7z+v/XXeqOtlO8i32y2uhjDPApfYj6fNFVogB2ZWbiaj42uDt6AFr1SuC+qe8XbCn7K6QWnuSmjDaIHLxVI8V3q4iYil5DAePsLcJbFMNayL/AaiUZiieAY2fUMzbhfQA/FIKUdw7KstYbVAeGCVFxfva0Ver8+40czfL8UIYYJCn5KJGVwrjjGwYO0zJSTvKjg4dZ7gLNg8gRxk7GSecAu5bzFpZsD++wY3zLo0ZJyKnY2itX60P6qfEPuxWmQtYYkn1wkBaYo71Bkn41nD1ShQl7JPxud/D406cIDihBDJxYx/OqtqNkBqqmTb2MZ6v7DT+tNnk2cI8EEiQizjQD1fMaEVwM/8N6Zq+2QW+2P3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RNx3lLUeaqXi47NDwpx6+oqvB5qiAIM01BgkxzEax4lcwpdtL4l3XSbFT/Ic?=
 =?us-ascii?Q?1LiERczO8aIW6Ed4jVNetR4pcB4d6wSFmxA3kLWgYUUXNmvD3Cgpig7lG7FT?=
 =?us-ascii?Q?AsWhzGjF2OkH+sl0sioy+/MS5qTqzAqAMadKR9thUOvZUq6kZuNQ5MyNnjYq?=
 =?us-ascii?Q?3//Et+zpS6EA7PPn2HGE3Pgfl/U9m53Xlp1rdaXw4M8WNRRYmXGupkoo4Fsq?=
 =?us-ascii?Q?w2eAG1QSMGsTi8Za7pem11pZGB66awC64A0vY+ZtEn50snBDUyAoxNSit/q7?=
 =?us-ascii?Q?uAWV8LaPExxmGggo8qjYiv0cBoERQiXVYWHjOFnbHWsuE60v2yddyqvBkyql?=
 =?us-ascii?Q?gI8olMRohiVBys1hLi+nisF5AuJE6P3/gnU8CCNMEkO02PYTiIgX8l+TFh6H?=
 =?us-ascii?Q?fYepXQa9/XqgRJTVCq66d0Wp+RMZyuKqTbOfYvk7yIAbdvbbWDiaeAacygFJ?=
 =?us-ascii?Q?J01ISD1ZmgEdz5aptnqQE6pF1CZbMzRT6pMApYSe5y0zmk7cOAyBT5b2z6z0?=
 =?us-ascii?Q?m+iVf9kwKLq20wvj8VT5S3/7XJGWct70xTozd+zxMxdQhaheyg0qtSQqpB0Q?=
 =?us-ascii?Q?HzJUskJfJPNeXpAv0/bxeFBuDAdUKvc+WtiWqBBUoWOaac7qHfUVTvOy0lL6?=
 =?us-ascii?Q?RrurQ6mC2rAbNRfLf7lhCpy8IgTpVBpIIA8H/l2Mu3esP8bFumokMufyYV8S?=
 =?us-ascii?Q?AkkCFO+B0FYYWucu/6N6vO1n4h8oHDF+ZDbDOyclyVrAQNigvh7SZ1AyHJa+?=
 =?us-ascii?Q?x+SprHiwErsp1Z49BSrAhz13uWsMsjnl9hresNvGcnya+Rjr8Kq4iHvhHTG3?=
 =?us-ascii?Q?YwdfvTnq9uHK/tqCcVeOA+7PvWCWFvSP5kSBLe/x5LATM2RU3QDgQ6zoa6Ey?=
 =?us-ascii?Q?Vr1N1V3xqzvubXz9yp+8DQztqWAqeD1nDQUR52CDuwe4SYhiAAE7vJL1b0ZX?=
 =?us-ascii?Q?k4eBQXXCFAgJWnfsGsOPP6bI2wmYKSx+x8nbb5GFZl9xqU62ZlkqQ9O3V+FM?=
 =?us-ascii?Q?gsdKaGoQZoj8Ayn89V46IxNitvP5uap1jciMEynP2sRJaqfg5vkGpM8wxEWB?=
 =?us-ascii?Q?ouOPsWinYqae2omf9IAHNc8Ebr9XQ7RIzM4x+bML4Y65+EqPeowgHcutCmRk?=
 =?us-ascii?Q?tASHtRATAAKHTzkpB2TRnwG4zbFXvIIv8MO/eq7Jz7e5hqa9oobm9O1Luhlz?=
 =?us-ascii?Q?xeMhq078o96F4gOakJnGWrjWfnkbjNtIzMFUaXC6h7WeK0zh3ckizGUH1+we?=
 =?us-ascii?Q?gMV3+qbCvlrTrHNtykhdCQBjKmAvXHbR6cMlAjdaUSj7mKw5w5RROYt0YXIn?=
 =?us-ascii?Q?wiQ2ZTu0Sar02NT6yUkAQKmQrJj0VQHdCv7jffIub1u928APPioByelGMs+u?=
 =?us-ascii?Q?cJGNixqCqECmkeR2+NVJP2MnQqqc/UIMb8maPHEy7OokFQoYlysGxc1CWH0l?=
 =?us-ascii?Q?FAvxqN9HBd7mFKewbJF/DIAzkN2bdZBr7Y1HuWaUMKAiIgkKIHChLBmjYG8g?=
 =?us-ascii?Q?BFq4+d2YozMCevqKiGw7SA5ldi8TXL5UQqVCguvoctLsRC7nsOrmtnhi8Qt2?=
 =?us-ascii?Q?MKcSrqmbnWJ8o1y25ISBr9EUSoyUIBC8H1AixpqHsvQXpKpJ+UQy70WQgtb7?=
 =?us-ascii?Q?+/q9eSslwMb4Xc2bjmsyRAvFz52+BR4LLbJSrBer1Cfrq8wFmyNyHA2a6Sen?=
 =?us-ascii?Q?V4pEew/ajQiEEelKh1wGb3RwwAUOs2Pdd70SwKrhNZb8PTswStHDI7pyB5fG?=
 =?us-ascii?Q?oCTHkUcINQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76a6b7c-ceb2-4612-635d-08de909bac49
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:39:02.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CYERdOWl4L00U4ckLTEgw/G8M4u9pL5TPLKTP5tG+YC+VT2Cnd5FHWRt7jPjh0TMe9/q0biQQB4L5BNYA5Zwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841

NPEM registers LED classdevs on PCI endpoint that may be behind
hotplug-capable ports. During hot-removal, led_classdev_unregister()
calls led_set_brightness(LED_OFF) which PCI config on a disconnected
device, returning -ENODEV:

```
leds 0003:01:00.0:enclosure:ok: Setting an LED's brightness failed (-19)
```

The LED core already suppresses this for devices with LED_HW_PLUGGABLE
set, but NPEM never sets it. Add the flag since NPEM LEDs are on
hot-pluggable hardware by nature.

Fixes: 4e893545ef87 ("PCI/NPEM: Add Native PCIe Enclosure Management support")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
The bug was triggered on an ARM64 machine with CPU model Olympus.
Kernel version is v6.17.
The PCI topology is
```
$ sudo lspci -tv
-[0001:00]---00.0-[01]--+-00.0  Mellanox Technologies CX8 Family [ConnectX-8]
                        +-00.1  Mellanox Technologies CX8 Family [ConnectX-8]
                        +-00.2  Mellanox Technologies CX8 Family [ConnectX-8]
                        \-00.3  Mellanox Technologies CX8 Family [ConnectX-8]
-[0002:00]---00.0-[01]--
-+-[0003:00]---00.0-[01]----00.0  Montage Technology Co., Ltd. Device c002
 \-[0003:80]---00.0-[81]----00.0  Montage Technology Co., Ltd. Device c002
-[0004:00]---00.0-[01]--
-+-[0005:00]---00.0-[01]----00.0  Samsung Electronics Co Ltd Device a810
 +-[0005:40]---00.0-[41]----00.0  Samsung Electronics Co Ltd Device a810
 +-[0005:c0]---00.0-[c1]----00.0  Intel Corporation I210 Gigabit Network Connection
 \-[0005:e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Technology, Inc. ASPEED Graphics Family
                                          \-02.0  ASPEED Technology, Inc. Device 2603
-+-[0006:00]---00.0-[01]--
 \-[0006:80]---00.0-[81]--
```
We're targeting on 0003:01:00.0 CXL [0502]: Montage Technology Co., Ltd. Device [1b00:c002] (rev 03).
First use `sudo setpci -s 0003:00:00.0 0x1f4.w=0x0002` to set UnmaskLinkDisable in CXL DVSEC.
Then disable the link with `sudo setpci -v -s 0003:00:00.0 CAP_EXP+0x10.b=0x10:0x10`


Best regards,
Richard Cheng.
---
 drivers/pci/npem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
index ffeeedf6e311..c51879fcd438 100644
--- a/drivers/pci/npem.c
+++ b/drivers/pci/npem.c
@@ -504,7 +504,7 @@ static int pci_npem_set_led_classdev(struct npem *npem, struct npem_led *nled)
 	led->brightness_get = brightness_get;
 	led->max_brightness = 1;
 	led->default_trigger = "none";
-	led->flags = 0;
+	led->flags = LED_HW_PLUGGABLE;
 
 	ret = led_classdev_register(&npem->dev->dev, led);
 	if (ret)
-- 
2.43.0

