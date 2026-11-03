Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793741375;
	b=RBmjN+MNmoGHNwgYH9x/MpuD7t+FRmIStYbV91ha27kz3ydLCzKvLcJuAtOP/scTtR4s
	 NmMz/74iWs/jnG3TS++f8wDrv+EwS9kPOUlG5st4Vfo9mh72pq/2MR3qEIv6wlCA29hFf
	 EfV9VHwYqN4sbV3ew1ApG1RK5O86zpc6IqmI/O69/JwTN2LVd2tj0FiKGs142mx0qWBxF
	 9/fQyHGL1rQTg2IJpnkvtSDCDmgjtqt+6P8F1JIqjgjnWWfCmIzgF6VrHYwTY4vM04Kaf
	 xrcCqrxtNehP/S9GYAHXQWTZvWfbVv/OXl1Pa4spmnCX2krasf6dYum3vLpQ7SXvkbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741375;
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
	bh=WVFB3x+vbokwnbA87dvpY6x8h44wUlkVWIJ/qJDAqIY=;
	b=ZoWfVLNxzRLt3q7TpLX1f8aE+MgNd11yfeexbioI2gp0PA9vUQeFWnJVpGWdKNW1UZGZ
	 cR1xXBUZJVZg+xvkiAvTSQCai+MNQ/AAAaSJjX7Jwm6EI+uUXL4xJHN4uUMUq7VVtzd7g
	 Qs7kongFfrimgquTobT3EZTxtOw8RHm9hfB/xNRK+UQcj19oHwTj38loM0P8OuCH/b0/+
	 OqtuoUUkWdm6czcSrsqnBR275SN4/lVFkd6NNEzsyY0KUWlHqL0Oi/qmDbwMU9DbtHrpD
	 svxkej8a027KBUsvYSJ+Cq+IbrF5ja2owlCOQBmh58jijA+cpY32JKpxjzD45TFIWpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Nt23ef+S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.34
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA584606A31B;
	Tue,  3 Nov 2026 21:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA584606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Nt23ef+S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsP678L1JQODcdN5gTIoVbB0ne2Bz4aQ3FYLCz9AfJcbnD0yE65zey5f6Mqjn2zBX96jfV7tn43qoAy7M996Vt8k9gxOA4sF/xbdOSUHSpCmi72rclKtJQRPi1xWbMUAmVMKkbPcwS4YtV5J+hq9xlLMQ9HqNSOLPi/lcQo+/OrM3DAKqVxcXrgzCzGSk9r+ERua88nXZUFo3J3obLo2l38IGoJ9KG67fKTm4L9gWJ62JmecTFzCInIqWjrPdwgvJmmCxUeD+bqkg2yL9n3qf9m8iyNQx6iwh/ZQ8mLo5bt1dsFjAOT4X6RQmsXS9PBNNCQj1IikIs/XVM/bAg6kOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVFB3x+vbokwnbA87dvpY6x8h44wUlkVWIJ/qJDAqIY=;
 b=fKLqNoJIiOhiMhwGpQG+XUWdRu89RuXs1Se8pgSBdy5DAGCS5h2BHcTCU7wJ2UV2vZifvYuMH85X74m2jpig2zmxPIyHR9TI+kwEDi5NwN44Kwh6NKrvonDEyM/DxmGffJrQ5wgSsl/9Db2CXxwFKdje3L40O2dvyStAB/xOJJawB+Z1V0jfI8DtNPZCSPMw2HTqOLhAQBpz3xgeQCSO9J5gV0w95jRzggqtZV+x5zwmbfG8yYlWuZniwjjOVEWcTYsPtiCiUvIaEeoYWEFOxzXcWhT7n4dDu8u+6L8K89vJP0QCofNqGUjL6ASNMaTPoMzvcDvr3ohXg06LcG/GBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVFB3x+vbokwnbA87dvpY6x8h44wUlkVWIJ/qJDAqIY=;
 b=Nt23ef+SD3Mto02/norG319PLdn+hfwQ2hdKknRquT1RUTdRSvKE2tShwaSe6yj8aUQIqDzdzGStybXHjJqJ/b+QF9L6XhucKkp4NZAWG1Us6aXaUYlf+/07/4KWUb8113udMR+QKcRbv+TPSFdtZ6ue6XQphFLvnW7j3Giq76PCATvo5U7tqLS5+H5+JGmvwbm33seVUjYWbngF/9vdM52l9m2+nsZz1OOwhaPZfLuu1vbGjiYKWStpv7zVj6JxqNcJth3oQjMfHu36VleizZfdcSWKZDpyiFBfqojLmCG3r+KA85YMI2DFhmwa5ZQGZOYj1xc5ANZQelJrbfo02Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI0PR04MB12078.eurprd04.prod.outlook.com (2603:10a6:800:313::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Tue, 3 Nov 2026
 21:29:30 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 21:29:30 +0000
From: Frank.Li@oss.nxp.com
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	mhi@lists.linux.dev (open list:MHI BUS),
	linux-arm-msm@vger.kernel.org (open list:MHI BUS),
	linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] PCI: replace chan->device->dev with dmaengine_get_provider_device()
Date: Tue,  3 Nov 2026 16:29:20 -0500
Message-ID: <20261103212924.1780217-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:510:5::24) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI0PR04MB12078:EE_
X-MS-Office365-Filtering-Correlation-Id: b329d409-68b7-4848-6bf8-08df39f18bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|19092799006|921020|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/oS1jS0DPhw0WfjPQz1FEkcidPoNi5TWQEh8xYZet+zI5ety7yH13DM/CO9t8ybkM+EM1pl1nGSVKwtsnI4EvFrbw3ZGSclcWZqC9HNbiK97IE0hTKXtXNa1XN/j3yfqlyqCngSlXtj5AoIEJ7TbhN+3yNBV9p+9DE+9jiRJnVYPqVdYciiM6Npv9QrlRIohHg83P/siS7V9FOAU6yZyPCU3g2b1A2oVzQEHAkzrmOdW4ITVfZTVrW5pmphFFZPys6XuK/UjLKCSrHRGrF69Xv2BLsk8Sj2d31bVr6DDfPjF2Ka8FHJDI/u/qKwVs42vjg7NVdrZhTMyNR6scy4ceQlouWZJ2YwAtc3eccClTXsMjTkxMwhGe1+N1gxVyWd/c17nkpU3x5GJ3Tvd5oG3qzKZ4UBUs2ZvbhTP1CY5NjYtwxjpaJnFP0n7+XCajF9tKBdb6pUzMLSq1itEqaIPzxlBtyfGz95so1xX6AveW9OS1dIT5LBnJFUL3eCt9mUpiIbaGvqYO34eNHJ1qr+3AMUKB8v4AgdHBRLzOvvI/0TcWWnXjyCgHbDlGWWvfl2G+IkkVA7RhcsWrInwGnlGwVkPh1OvroA99oNJQcaSDN38957dkEH7Hs9X4QFPto9o0Yk9ZPMUnnJ9oZAhHf7CeV1Ru7vOiTQnPhdV3chPPIsuReTo1exNyKFNUh3aM8afS7VRR1bGXMcknDFepTJIFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(19092799006)(921020)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?npADhHXYvyYK+eSoDhQy2JwyxaiKxoRSnTSTDfcHdAw+j5B9d6rC+1U/84uW?=
 =?us-ascii?Q?H2mZwwIHEdjMc0qL7h+D4VvVGcoAhIiyRkZRfa9Dx998y9IKo2aH6ag3p5/r?=
 =?us-ascii?Q?59bInuFemYCQwwX089XHa9CKmSDoVu1xf0m0926djRQovdmYPyIi4UYQEjsJ?=
 =?us-ascii?Q?BevBL3NDbIYNQAU3sjWS7Zo6Ti8OBZA8ftC2ksGT1Z7y0IftQt7zf9Bkj12Y?=
 =?us-ascii?Q?o5y8FjHzvhuzyvcBozqOO8H2wFJhYYuqJhlQdRnYKaeD90Jij3PaWN0g1DWB?=
 =?us-ascii?Q?8rGnulkUH2dz9T1KPu+nhX0RGXTAm7kX4Ry2lx8bMU2YsrRW7GxmwDRSQMJy?=
 =?us-ascii?Q?NhgbIIeXMH3bAgPTiOpaJwYyJP/Sf5rrI9GB/k4RwUDXuM06BreqoES9Mclr?=
 =?us-ascii?Q?LBdM/V/5i+CXWwibM1UWiUtNCgj65tm+yVJxZ5/AY/8diAccDPnHJcfgXIpm?=
 =?us-ascii?Q?Dfhwtacuqou16HORizhWXa7cdnh0LNWvm1YtDrb43WrSN+HoqvVUi6svW9wB?=
 =?us-ascii?Q?sDYCwQqcQ2PDZ0QkwusFsWTBgGzVANVUhLmQYUIw3MxqwR89LrF1t//unaGg?=
 =?us-ascii?Q?Fh0gdD8v4g8ZtmM92U8SWolqes+N+U58UN9anQZqpP32i484IWRTv9U/d+Bw?=
 =?us-ascii?Q?gv13aJTHEpDQZJiZsIG/imvQ7L/wCIdHJbnxiVCrLBbIJnEu4GHnt4SKPi2I?=
 =?us-ascii?Q?CeyidjnQVn2pRuXAeJn+Dni0ScHHcEWgiLr2ZEonhR6fsSNQwPUm7yrr3kdV?=
 =?us-ascii?Q?yINwoCcPjMgYbB1moPMqpUWHLmc6dickRaxat0mS8zrl232OrJDDINCMTHq7?=
 =?us-ascii?Q?8ZyOBPfGVybs0NAly0cxSEDTzlgMeckN7s1gNxGy+NylWbUczEQ7uwigYB3o?=
 =?us-ascii?Q?+hyZJ0b8XexxIlvF3zsFbdKMtXEqvB3D0ZnCDwOI0Wlu2GQjHna+8qilyzXA?=
 =?us-ascii?Q?iIx9Sox0poZh8H3zEpOjxnRrubSJLCoHBKai3My8lLlTdErITE5UjhBb8Izk?=
 =?us-ascii?Q?Bj6Z+kp08F7GCBD4sq5UeTg4vpIBPFRASlc6W3LbQGz2k1tgZKjRs0VHSiig?=
 =?us-ascii?Q?Szuz92rBKZRNn0R5IhSbHTVJ704XDmfFK3dnb9/6w4YqQItDDn/4Uzr3ry3q?=
 =?us-ascii?Q?lCzcrNwVi0TmXiapOudSVrbFHfm5whudM7R5Bk3U7hea8YGGXK476CND1Wzn?=
 =?us-ascii?Q?es8v3WjScZV7+fw4HZ+lQ0nTwA1kCDduer1f2UEM4UZlK3PXZQ3Kiw0V/fmq?=
 =?us-ascii?Q?BWrqZS8BN2hZ9m/SdYmVPTdOem+A7H66J3O/CBJp0WcgyM5aXsxjW9ixwRqj?=
 =?us-ascii?Q?zN4/j+Ief2EdxPMyACDG/ucic9glHXVzgITotynlihcDQBWKH/yVYAPPjrJx?=
 =?us-ascii?Q?DU0pew40oXftTNq3dY7+XX5Lk6xF4N/NRjOv8pm94yaqRwLSP/79LY6FMuYi?=
 =?us-ascii?Q?fSSFWAyCBjREax5W2lLtvrLaEo22Qv4FPPieUnd4cInsKtgEv/3Azpf83T/g?=
 =?us-ascii?Q?5uDetXK4DCyG63sRPnB5mRjT5fH8x1D03ZNFFZ0YNH5S/YjSloUbXt1Bihry?=
 =?us-ascii?Q?rBVq6A6fw8sSDb1d4wJKKVDIUyyFql9PU4jGgIEbB8u3rsG1y2CsChwvts5x?=
 =?us-ascii?Q?WNFVh3RHzF9SZt8gbXllj+w58KEqAZwQOgJMa/0M56Xs4aGBHQhLMRIQqN2y?=
 =?us-ascii?Q?lNFK3L2+MbouhtVXuJttfkzVk7ywQxYubcQqMioXTeviX/yH03Akcj6tCJC/?=
 =?us-ascii?Q?YO7l0JQEjYO/dmkx74Yw58jhFkA+duzhhb+iicuUyELYDAj8bz9u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b329d409-68b7-4848-6bf8-08df39f18bd1
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:29:30.6169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Z3ZYkk1TsRtYWAn/sEkpk5VK9OtcXIiKN+tjmHv9i/z4fOY/htbRvvaU06nX8cw9Uzb+He1XcgI0V2ToQ+VpGwHfzBkROGF8yKeOP53oaFShXkttDr7CKHKnm0YlRbZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12078

From: Frank Li <Frank.Li@nxp.com>

Use the dmaengine_get_provider_device() API instead of directly
accessing chan->device->dev to get the DMA provider device.

No functional change. Prepare make to struct dma_device private to the DMA
engine.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c  | 2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 78f1fb1a6b0c7..5677fcbfe44f7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -646,7 +646,7 @@ static bool pci_epf_mhi_filter(struct dma_chan *chan, void *node)
 	memset(&caps, 0, sizeof(caps));
 	dma_get_slave_caps(chan, &caps);
 
-	return chan->device->dev == filter->dev && filter->dma_mask &
+	return dmaengine_get_provider_device(chan) == filter->dev && filter->dma_mask &
 					caps.directions;
 }
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d4905aa8e4c01..fd63e423c4726 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -238,7 +238,7 @@ static bool epf_dma_filter_fn(struct dma_chan *chan, void *node)
 	memset(&caps, 0, sizeof(caps));
 	dma_get_slave_caps(chan, &caps);
 
-	return chan->device->dev == filter->dev
+	return dmaengine_get_provider_device(chan) == filter->dev
 		&& (filter->dma_mask & caps.directions);
 }
 
-- 
2.43.0

