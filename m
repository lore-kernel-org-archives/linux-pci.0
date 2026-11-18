Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794996254;
	b=anH4AbnYpQX96XKDiPs3/GFuaRYuFlYEpKrspzbMdk8/fvpLdUdPcImwy0qu/3EDkh7N
	 eQ/Kj/cmcISINrPVn3Z6dmCo7HVeWhJyLITwRKIWg1HTkcChjelcum9mRVNObjKF2sK2h
	 4Cw7keqLJmDmpAYtQ4kA0rwX1JGLGpuI3LHr0T6dODfMmLwZkACJu162yino6o6ot1AIX
	 axBoPZoLPRlhKdTjrzjVjfaWUqiS/pgacbnlurpR8fINQjPo9HeJxJZ70Ic3mfoawbGS9
	 5HgB++eB3Yizdh+prIJdavWwktyTIx9cYJAvbLxCV0OutT8rtMz0qXSZjzfV40YsYWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996254;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rLT9bEJivW3KgEFZZXXfmmSSnCrRhVuFC35Xk2x73JM=;
	b=K/KaCqiD62clSU4VRLXwXMW3MWOaIzDFyZ/85mZFwWiKOuloS3FaQeqGxuZWJF3dK6RB
	 yBzfAPMgJRGnjfo9DDKSZcFXygvthRigMNOfTfmEH9ziBCC2S644nrKz4SJ5Ct+xMg6li
	 YP/J9WItnto7vEqd/M8IyLSpdrEXP5ctSDIirlburS3zanPT+WB9jUEvN7oRMdH3I2kYM
	 gWPxuw4390n6v29UBKJt9D3nnjxuyWPvGX/NVHpsyUpIfOE9mLjjt5w76HOjv38P1RLhJ
	 /8oXPjsfFa2jlHwQQ5mz7FTEmDbQDVF89Rylw7d0dhzc6xbMe2Uw9BBcwFVNj2JVYrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=oQjgQHBE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.60
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FE606A31C;
	Wed, 18 Nov 2026 10:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 797FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=oQjgQHBE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMqCfzYFWnTZPLe2S1hTjhEPSnqvni+9Ca9t6ZBo1cwMWkrbasDlCF2bIe0jWvJw/sKwWIs3RxCVFqT5cNQf6+zsFH6DD++J+iJO6aXK+u6VIuLX+XFxtyuZ/tbYxiO6HSUlzWJN2Kv68gYHDKIVzj1KyU4eJ+e3G2F24DwlC3WYIEhyGNOrpqYHLtK+/8ex7u5OIoS//+ApgwJeRd1K72CQB6Xf/ICcjFxFj4BHs0Q9iHf06ulrpBjnw+EQsxHeCbdkDWm1BvCox9iy3i2OezcGD5jAV5WnKe2TAeyAyORmpns+g46IfjO3zeFjNE4QVgRU0BapOiP3wTKrvzV7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLT9bEJivW3KgEFZZXXfmmSSnCrRhVuFC35Xk2x73JM=;
 b=HRIPKEQ+l6GVobHBaC25BpwwTcwu1vHVJklTwc0Ln6VM9kE0H5rmOnOHAsaKfeQcBNuKNkGVLXeQFIKsIBJUYZcHhd3HEOd8n1D8IGDJ/wKoR9MRpgjMpeWTATudwoaHikLSVn/nIKG3aOI0T3um0zi/L9TLpxA7mGLeE9JYa7FWe/KYi7V2xGHV6+hEcbkZTwhmhBu6IiTQ7U8yyzVTV1V2PYOFYXhJo5raNsyV34cNVmOYAMByn8470+23DpcLoUFAI3wxWPzHAbwno/tr6R+CYOnI2YMBj//kIpPy69aOVzinHDF7H/b2ZjUgO80/b6reycvokRC4FURfIp9MgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLT9bEJivW3KgEFZZXXfmmSSnCrRhVuFC35Xk2x73JM=;
 b=oQjgQHBEOIxfEa8/wOnteHMnHUXUH3YTvEUxOuH0mg1AwXFb+RMKNB0ZazTlYwhIQF+MS3MLfkuQCeNkY2XVC8EbsuVgkeXkeNsfWYxb9XzAbjZyx2VC3ieARqyPuoAYClw6F1t54kSw2TPArfFiehEEcqej1GBUrZBdgRsmVwbJsmFu+5BbHf8LXbCoVEthOCXjmeg35mpBufNc9BkqI/wW2lhagldHsEQeDfGP35TwMntUvO2k3qWQP1PT5mgmiHnCzJfLX1ACE32vsM5YSv+vxuC4rhiWwcW+s5XvRqh06lsUEypNI2RmKjyi12s1qJnUF94S6Bere1qfHVh+9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by PA6PR04MB11734.eurprd04.prod.outlook.com (2603:10a6:102:524::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 10:04:10 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 10:04:09 +0000
From: Stefan Ghetu <stefan.ghetu@nxp.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	hongxing.zhu@nxp.com,
	Jason Liu <jason.hui.liu@nxp.com>,
	Stefan Ghetu <stefan.ghetu@nxp.com>
Subject: [PATCH] LF-18678 PCI: Add quirk to fix byte-swapped class code on ARA240 device
Date: Wed, 18 Nov 2026 12:04:06 +0200
Message-ID: <20261118100406.600995-1-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0048.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::31) To AM6PR04MB4472.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::20)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_|PA6PR04MB11734:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d954cc3-92fc-468c-56e8-08df455b4a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|23010399003|261028144727099003|10067099003|56012099006|11063799006|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	h4FiLC8+hPTiqpC/xKhKvw5LdE3jpT+5zM2xnGg5Qqk+EGQjNQxUp3U/1RT+x6GJv9Tzrkhfl6Pya7TbI9db4OPRooPJr9OvZ43Dn5JI9FUz7kN+jLU2nS2d9fDq9g6Gd3vdBElP4X8OQYtwjFEnb7c8qZqzRaxPtnzAScF2EXwbLHzpPXfBtlmXs/Rm6rKUQIMbtCstFT00mqDYca56jQdPgobIf4+t9Xy5xkfOrqTyyCffnOZQhUvsB8IZ1AxNhAKRB/I+TLRZpmOSQGIczj91tlIAX09GEO8ESFaXJvHHHqQiBWZcughCTbWSaeH/cpMPbzDRhDwfYulsD4KpCzW+lyJqLFojLnyi7iT2KHZ3y9PbI7Piq/gFfMSvZIsW/pmNB5bm9YiTe2FJ/5gmWSKUh4zMpAACOtVozVsWuJU5sKMfwLnF18LZZKdoCVA/CCg1+BM/DoQOSUdIvW2pT9Bl/NBcFXcOwSYQ2Zll6Yt3pziVxR6s8CVeW8I2MCdacXiOuWKCl6OnPN1z0IsARnX6Gfdp78Uok5fPy99X56vi3QDmozk2rr97y9KPBk4xep8mupG97XsN/6yY7EZOz/M2ujjZQveTgG/opuqmoYOQeWthIksFcEb1rlsSa4VVgJUkgOD+OaMulpo2oj0M03hAsd6ocjBvjQ6qbwtx4lA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4472.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(261028144727099003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261102123227099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6S4pQ1qzvwWsL8eFIO1IxjP1fMfWpJu7bZ2YYLD/+3j8EKkRSfcz9lXv9/wt?=
 =?us-ascii?Q?+wijA40wfZgxKaeWBDdsdaPNv4drT4BJ6vdfVbwJ6/1NSKsmTPDke4SRwQeI?=
 =?us-ascii?Q?0/I4bQQyKVpSBsmEGeZYi6VPrbh7H1gpOTM7uT8NoB7dsp5WEFsdVXS0Yoc1?=
 =?us-ascii?Q?aH244Z1wc43w0LEJvud6WHPn9uJgnVb24CkwcJwyOe9l45PBaMVymybwJFo4?=
 =?us-ascii?Q?68Q6eMVRYFyIPUGOXyRMO2j0w2Wp2pTvWBtsuTnto4BmxDUe3FGpKlV7Ljzg?=
 =?us-ascii?Q?WEuTYAhZNn9mjuchHvuLvf9ocxk2Dq3uLTlZm+2WYsZ3LWeufQJG2oZp/Jpa?=
 =?us-ascii?Q?08Bb53+t1hTTQTqvRZjtjqoVb4743FTSLqjIx1ThqbaG8OyR3MUVOvXdMm0y?=
 =?us-ascii?Q?xhZnkeqfUkAx6Lj+llw30C2Ct0ccxu8wINZKy0uRzDpRc0OcTpP6JRjr8xxY?=
 =?us-ascii?Q?HXJrnC3OUhgGTDYNrEVwU0YrQLLH8kLZnckZyzs2xb1tgHDQ6LGlkaaPdM4o?=
 =?us-ascii?Q?XhJLpn//PHkgISdcfBQJLxkEKbMjearAajegDEFrsncHKLEBooDzElaNaUGL?=
 =?us-ascii?Q?UOmeK4oYLluynJeC5R/nNPRtVnYVUFwFjwRCeSwb+atexVFOVdeq1ZpWyJ4H?=
 =?us-ascii?Q?r1wA57Q9Vbgy/6ko5gRkV9Mv7YnuhAdmbqiVIu4yYV4p9qLljOMdpUqcog36?=
 =?us-ascii?Q?pUxewesiBuGMNyy3YVmPKJnJQKAu1nU61DCKA3sryAP/66EzrCkQLiAvIQi+?=
 =?us-ascii?Q?HTn8NF2rLWiY/4/0+IYLorDmQclk0rhrksz5aarLWlIF8zfOfs5CvFZqsDa7?=
 =?us-ascii?Q?n3QyI7fwWBthlws7cI2+exL9uLLs7w2r47GEIoyzmmJSrot/758o2mzndDQw?=
 =?us-ascii?Q?WMFwJE1u9NyEmR1qy3dCgIFnrQGptoqYoASioSGqM7eClA5Uzgn6FfcCJsoK?=
 =?us-ascii?Q?ZC8IKP9Yd4uM2ZCMvKJbZ2YjCxRvqHz+5Lvr0nQs+KRvSsdB+aLcGYv6P1/x?=
 =?us-ascii?Q?MetW8XOJ3H836iDJETCYNVvTIIXbIjjpCNWG5xnwjQCHU6z6Ir6wyGuEreQ1?=
 =?us-ascii?Q?ev/w6JyMNKQ3+UTh0QPOaHgGMzFwtKh8vVwyKxr48X+5boG+Anps55uozA4/?=
 =?us-ascii?Q?V69jWe5BsbRNxx7dFQ1t4JAO32ztX8I9TBbXluIE69l3QtC9BU0RaTLnPl5y?=
 =?us-ascii?Q?3fplgq4MFCP/72KJddaX4kP0GnOMDNTg3LT7Uo3ihvpbXWGRrpSHfZg3W2gw?=
 =?us-ascii?Q?MnTTTy06kwWJTJXHobdLGvzTQAenH1QYE3zB64/VM8kP+N719+ASsFA6+S0t?=
 =?us-ascii?Q?NiLNY3zfoTXSCRst5Q22LYVnw24RGpxLabSMBsVNKtes3jK3GLKj2Aw/A2VM?=
 =?us-ascii?Q?DMOgyoxZWUfaxuQ8418nZusXxRtGwn6gQ3nre2Yj1zS04ilMfx/0a+6Ysn6u?=
 =?us-ascii?Q?lNF/14R9asTb9+IcHTYySV4PqdHqP1X/mncWnJqMpZYHxOjVLRHeKABifbsh?=
 =?us-ascii?Q?UV6MiQbvSEjr7D6Vc46uUHFqzGF9WznQ1wTcxFenDE+u+S8WJz23z0RsB7tI?=
 =?us-ascii?Q?q0T+B6AqCZLkEVVevCwr5113sotRmQkRqDKGH8h+dLsgXFsEaxxWQZekNJhY?=
 =?us-ascii?Q?j5AHAkWW9VJ4AF6CBz46+qJxj6scAdRQwq5nTNfSeHrISt90MPirz2S76sq7?=
 =?us-ascii?Q?KhIvVkAGHCgGT7reWOJ6B9oeB2LAdLVU8sgR8kuZ1uFNZ7gBwoNqu6ZB9y+d?=
 =?us-ascii?Q?3SFdSn6m2Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d954cc3-92fc-468c-56e8-08df455b4a0d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 10:04:09.8236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cs4QbTO1AcyjSSULzP1JWhOLfhEOO0U/8/aRBwElmd0Wii5E+1W4NucZArQvJ5HvhNytc+TIS9wfNUlVajbzoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11734

From: Richard Zhu <hongxing.zhu@nxp.com>

The ARA240 PCIe endpoint device (1e58:0002) reports an incorrect,
byte-swapped class code of 0x000012 instead of 0x120000 (Processing
Accelerator). This causes the device to appear as an unclassified
device (class 0x00) rather than a processing accelerator (class 0x12).

On ARM platforms, the kernel may refuse to assign BARs to unclassified
devices, preventing the ARA240 from functioning properly. The device
cannot be initialized and remains unusable.

Add a PCI quirk to force the correct class code during early device
enumeration, allowing proper resource assignment and device operation.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
---
 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3d92b99a49238..fc95d87d4af0a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -559,6 +559,18 @@ static void quirk_citrine(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CITRINE,	quirk_citrine);
 
+/*
+ * The ARA240 device reports a byte-swapped class code (0x000012) instead of
+ * the correct value (0x120000 - Processing Accelerator). This causes resource
+ * assignment issues on ARM platforms. Apply a quirk to force the correct
+ * class code.
+ */
+static void quirk_ara240_class_code(struct pci_dev *dev)
+{
+	dev->class = 0x120000;
+}
+DECLARE_PCI_FIXUP_HEADER(0x1e58, 0x0002, quirk_ara240_class_code);
+
 /*
  * This chip can cause bus lockups if config addresses above 0x600
  * are read or written.
-- 
2.53.0

