Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794003715;
	b=VUwhFEi7+W2dsEHQO9jUx666T58EheL+ABq1QdUdzAT7uNe2UMt12LF8jdClDf7F2bWr
	 ERY4IoCpREUWaZ7wPA2Gpig5CtymGuJD04YGDvsBrWBnQTFn5UkqHNBUQIqn6KJ0GYevb
	 n0L64k4FdHkk8MtxM7TQsfeA0dztbU//bC7ofMIWJZpanoJog+IFsGz1RmPhm0W32tbTL
	 ndlmdKs61sJhO8IRgRJvObw+zHxT1od7+/rr4/zxrhj+eahz6rXAg8AZOlBg+0QyN9RM0
	 IKK5xWl1m1ZvtEKCLcVtCMIwUOy2NeCfkWO5hROFkC1hXCu0aWnqjnYOloRJvO46Xkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003715;
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
	bh=EQ4cGRAm11t8h/W/HeA9xFo4gLMy/Fdmkpau8rQ0cIA=;
	b=jYTiO/tvuf6soe+/UtfkXJfF/tM/WU2s0+xWYgZYxFsU4QCwjdRmWLuP/1QoB+B0mJP8
	 nMGQp/KNUHRbTZHWE0J/bOzXoUp5HvwTSHRoUKILSi6sS+2GDkt+fSGdT+lQZWNmDEJnt
	 dU3ODkJLq3w75mPNqaa6eJMrwYLrwL1Nc5cWjzkliQykCTI3WTgsm9+Rc1tRl4E8PPq0t
	 gGz+JwSAUqrQWe99tfEX+4b3mbfwCIdctsa2hZ/lPad/wznb4cPQMIOszzDUQ5NeYgJuG
	 uH/6lUDm5aelfJrO3Ze9b+D1e78zFYp3S9mDF5yN5cNXCxL00lzC5Oz/kASFaL5tLOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DU8kX89v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.18
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C34606A32C;
	Fri,  6 Nov 2026 22:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C34606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DU8kX89v
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJ1ZYuPSzzvuDlE18pR+74oSPbMo9qRXJl6blgV80QH2TgaZjYIw28GltStdp8QYayVVPsduELTsWjWxhEHtqbwUTBkn9Tt9XgTsAWYcPiwPMiSODQbR2nG9m73a/9/oFoCQulZiU05vmAC1w2CDtm7HZuHIjsbX8pUYMKYlAQ8V9kjPp+GPRXcYwU5wnMC7e1rK7J6nPLW6O1gxP4TY2X5xExTyn4aTIfcIt4MsEktSQiPM40Ps2ximj5ilBrY3INbNnWxEG+teHAyd3h/g+UBlLi9q/BRfgbnHM6BWC2JtKqMx5+QJoxlQBp2B2C6xMIpUIAUnKxBu/bHemwzJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ4cGRAm11t8h/W/HeA9xFo4gLMy/Fdmkpau8rQ0cIA=;
 b=QSM9LKrvpedWG4QexeprFRQzXgsuvNNEbCNKUXPFZpB9eJvPy9Lx/lcNgKx+pxJ5B0xUgoQxvR/e3h6y57q9AHWMV/gPjYQQSvx1pe6Y+7u5psjhcRhqGDmfi4rtZPaRisDdzIEY9dLuUOyt7trLbuddxkMg0/1h/rb5OFUCd3N2IcTno6nn97+4tIl2CNt2zx3swndZ5MrAlE5U5Hpyh/Y5UJ00s1R0qfBUNx/YvIjjhUgzJF6ZC7XC3ieHfkmBcQsPLlPKtpbTrQsTNB40Znd8iRSTK7vlZqazY8Pnib9tHE17GNTgJO5VDl0uk8hmTDbkWT7QrMiq1ge2f7aFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ4cGRAm11t8h/W/HeA9xFo4gLMy/Fdmkpau8rQ0cIA=;
 b=DU8kX89vENFqNKG5cTUejrOl4EI4cOuywBu3NP+ftkBADM9IW5FUQGmNFb481jCE0nCmGS+pD/98dnhgEhO8XY5BqlOyST8kkwuI+0eyyz8YqPeSWpqW2Wf+Gz5gLgXjzOuU0mX5EG/cKPxDqh9/OSmZxTxw0FR9PWB1dSNUlAMPYuchsjWnqegkd5KpVMiLZ0FWApOZSj2+5AzPupfitxJtrUfpT/LmRkZE2VOjKB1us1dVnQ9UuFoNJWecTPSLw3ENbySEKBjHfoV6kHKj5PDnBURkqKRdEeSGImOFNfcN7WRcc8AA/g7WKZtZEJH5OR6U6x63lNEDyd5KXLE3bA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB10648.eurprd04.prod.outlook.com (2603:10a6:10:586::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 22:21:51 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 22:21:50 +0000
From: Frank.Li@oss.nxp.com
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] PCI: epf-test: Use dmaengine_has_cap() instead of dma_has_cap()
Date: Fri,  6 Nov 2026 17:21:39 -0500
Message-ID: <20261106222142.86087-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB10648:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a77fa1f-3490-4a46-5ec2-08df3c545a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|19092799006|366016|921020|11063799006|56012099006|261021130227099003|261022115727099003|261022113327099003|261021135927099003|261021133027099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261026130827099003|261026135527099003|261028144727099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	eYKsU81CqoSn4oiPCOUhITmmFgX4Y8UrEt+uv3ixqybTkp/1/XZ0pqGD0hBF+VQV0G8S05OreJFbsePGWvFc/te5nIN3Jg4Wq8WuiAc1ImVnIMhL14JpWp+61CI2TY4SRMAQmcwbNXO3oQTIXwUlIoVFBcZDv/YfRPsIxm6+3UDvZ17Z8HGRHMrUwLWFPKIXiWE2wy6kK++snZy9u+1aUnYhbrwtgSc5Cj3BdvhG6GseJ0/R9lKIZljd4SGC8R6KY/6GoU2MGZZnjW0VmAhzOLmHIKSOlzRtU3zOxH99pSOjCnBzc7fDAD8BlI4OBR7p5wgl3l/pUtQjWfTQdYSobnLqr/AUV88xYaiIYslTtjTQB6hO8KU/7IHzM8tUq1vqhKth6qA13Qf1AcqnYVLB6rMAPNEAiBc1Qi2AjkfGSAweHiEOIt6Vw0ZughLKi6r6lw9ZKw6yoTW8jISDHUpALOR7Rrz9+SHPPIydwefkksz1FADj3uT/Yg6IbExbRp/vjRHwxb9vlHcL4WCgjc5v96xjFJG9VhZDw7Ygp/HQPa3kq7qHT7vVTwL5sZRNtoRCLHM7nAwuoEguH1IUlbvncmQV83JuomXl8pTiwD79H6wghPqn1XFHOC9pLt2uqCWAHgaNozFmDtnMBPsgAilTK+rbtNWZnegLI8Yfw2YQh1WOkXhdtM5p+YlCtbH5bcXX45KEqrqUGc+02liaH39fFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(19092799006)(366016)(921020)(11063799006)(56012099006)(261021130227099003)(261022115727099003)(261022113327099003)(261021135927099003)(261021133027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261026130827099003)(261026135527099003)(261028144727099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BA8E4tfoOlJUTwzt4VLeoDUkhoUkee1NCSAaDRDnAdzXaXZ3ln0njsxBFf1L?=
 =?us-ascii?Q?9S90+tuLKkN1U4m7ZKZ8ArpgeRdnx/IA8+fvkpVtng8sX+CSEwHIvJVj8BTP?=
 =?us-ascii?Q?1wVVTQUjyzw+iNPikhxjlDjDvrcXHcVBAjITHtpSc37ZIMInVIondT2kmFW6?=
 =?us-ascii?Q?NbLnBgT/CZLWQ3lvVF/FlbRd81RErT0WTSThjQ/sT+Ggo7S3X/BqO3ZIlzQm?=
 =?us-ascii?Q?6KgZE8F/BgVcc1mSmeqzSzvX94vzNQGgkJad8Cuz58EXQ6bvrKKz7rwYSQxy?=
 =?us-ascii?Q?6a5UoYo3p7KX1YyiC/pInqmcZ+z4NjfzAQVTRGKPjG0ld9brwuSBDc22Dzt/?=
 =?us-ascii?Q?rckRDi77FfY/yz0w3NXIay3Tk/G5DXeDATJ7t4088RIW+XWPvdofANp1elTN?=
 =?us-ascii?Q?WFnuiDk+pnRGNVvnKjyTf05jPyVxLAIKnSBIlaWj72Qd1DpG/8AhyENEIm/h?=
 =?us-ascii?Q?tiFPVufIh9/VWfvTKum/ay2xHFxQeXRCMSn7nQnBflqav6H0lmBURtlIWM0C?=
 =?us-ascii?Q?f9cUu/0KIlMPM8omupt4pFi4I2fXZQfXkh6d/+3/Vg92hePqoLI2GtCsNwjk?=
 =?us-ascii?Q?cKnW5IsyfraFPKp7AKMfsOkTN4ousHaRj1j8locSCdrzUiGTgZEePJvBXOwo?=
 =?us-ascii?Q?Phc55jPUUdRcYDcZV2DKAaqeXiO3X37RRyYskharBtbMM+fdGWN4ZaAQJ8H0?=
 =?us-ascii?Q?IGkUGdFUT2LwaoFyr2K8RamHgEorFY5Xbw3iBzoGKrpmnv/J0K2OjvUueUuQ?=
 =?us-ascii?Q?nyKW6Di8ovlxMD4+teqjV58sqPfst7B9hUJ1AmHCUbl/CZ/OwuhsAz5mnYvT?=
 =?us-ascii?Q?BLWu9rFB63NgOZdqDpCxdxr6GuuVZIm4emAoTHiSfUPZ4KTK/HsKyHXcja+e?=
 =?us-ascii?Q?+Rm0is8HduRzR+AsSzg8Aflm+UIZmRzqAgjabN9RSG1LewsAFIt/LAmHdNKo?=
 =?us-ascii?Q?o08yNF9uklRVX2PgCTrdUhF+TAwJWWgMVltk8JUd6Q7mkIK4FLY1gaX6FLcR?=
 =?us-ascii?Q?yLbw4z0FFlB5dpK/hL0UsnUv15fy5tvk1viTMyu8a+yQotwWWrthv138Omxy?=
 =?us-ascii?Q?rD7tvVBtReR+nztOxU0S8C65q14x24ZgR4j1zm4lymS34O6x/IWY2j4zEd/c?=
 =?us-ascii?Q?TxowQYdLz39n6w1vdQ8ThYXaJwwBnx/hPuHdvAj7gqqBt5M/ejYlwKbqVbN5?=
 =?us-ascii?Q?bbm82RGxjt/t/uIb7Erv9D8SxdeMpxdDOhKm8hskzfpyctOzw6HDkhYBI165?=
 =?us-ascii?Q?Aa9ecvPtnBW5I6717Q/kdmucfCrTTDvCf48TS9Y0u51lsDHq+sYajwXfxgNV?=
 =?us-ascii?Q?g+kAs8wXuD72VxBAEzhsV04IfhC8MDQpqRHyfeyY2y0lkSOWmY3Kkx8khJ2f?=
 =?us-ascii?Q?LY2R3T6xmy42oB3nh7R8pS8rIbZX8xcIyYsnwrwngEPuj0MMsAicITAVc7qf?=
 =?us-ascii?Q?8kxtWmdNRFV69Z0O3+UAcGRJQQr8RoruoQ7d5FZE0g+L/BeS9Zf7wOmdqi/I?=
 =?us-ascii?Q?DgxIkUT0vwaCp3MDZC9ie8rhe8joo6WYFNxqm6vqw7DDu7VOhQzGRC6/L+U2?=
 =?us-ascii?Q?4Eb/w7GH9V6l+FClKRKYcf0NNNRyYeovSrbEj0VRPdEH7irJMRvRBWENO7Jq?=
 =?us-ascii?Q?TBHusrayjTRFv8MRrPZpwOPt/+WstysmRihlu0Nr9SJyRmeotNf9EtU7IW8u?=
 =?us-ascii?Q?Y7lS79d2IU0yiyO3MslF2FB9Wim2IchyUDtgYfWx4hK8E6mBOIueFDtAsXk8?=
 =?us-ascii?Q?U9a0mk3j2Yn+Vrq6icNcY5+B1mJdt3zK5wKbFA2UPiNKp90h2hlN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a77fa1f-3490-4a46-5ec2-08df3c545a85
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 22:21:50.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XICJZWIWdoWaHXa5sfQIH3SZzf8riLqQuJjnc2udOT4rQqv8A0YbxsCshj290cd1ieZN01tcxV2eWEs7GkmtDUXMOjIo7aInOmbuJeKFAW+T+03FWqeQ4amp3hRiyzyT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10648

From: Frank Li <Frank.Li@nxp.com>

dmaengine_has_cap() takes a dma_chan pointer and avoids direct access
to the cap_mask field inside struct dma_device, which is a step toward
making struct dma_device internals private.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 14fa1fc10ead7..188c533293216 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -371,7 +371,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 	orig_size = copy_size = le32_to_cpu(reg->size);
 
 	if (flags & FLAG_USE_DMA) {
-		if (!dma_has_cap(DMA_MEMCPY, epf_test->dma_chan_tx->device->cap_mask)) {
+		if (!dmaengine_has_cap(epf_test->dma_chan_tx, DMA_MEMCPY)) {
 			dev_err(dev, "DMA controller doesn't support MEMCPY\n");
 			ret = -EINVAL;
 			goto set_status;
-- 
2.43.0

