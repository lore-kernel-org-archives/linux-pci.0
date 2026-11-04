Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.107.74.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793808758;
	b=PMR4uCG3ilH1cweYG7Bz76z3TZjKRxbNOj3kqLxAFMX5L2uQQWPyr6x9HRPZrVM2zNsT
	 OlH+MQXMj/P2BnXeNzLKZRJaVzku8Zx4XrxF/WsHdElZ3f/zUNnm5j0+/hCUOqM8HFSZh
	 5NX7sMT4R+F2llhrw5yFg98dJ3VGUco3ayc65ZcEtDmuNwSyJF4af08uYJVCJQZu6+B5O
	 DIXJMKPm2e5G4Tx1J5JlyZ1AdKTEvxSh8Qs+SaaFwAwavPLEs0WgkTASKFx0WV19pOraV
	 Ke0c5ruDcO5yjJKM3aJOQ5ad1Ol8YAE0lGmVgDSVLMvh3YDP/MVVVVI5TEkHRKLe9yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808758;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Nu+RkBA/VqCJJDDe0dNKXrdZvfKm3X9oJKuXV8aDeQs=;
	b=RihzPT3XMgKM2POmwBlV6s5GMZoCUUiiKJLivtd56mQ9PQMCoF9NfhjzBDLn6RtYzyDV
	 ccQmt6GLC00jlZJyyV/XlMmo0eNJJIIM6UllcgoN9K68iG1G/lH38IwATIPuK4SR2v1D4
	 JfR1Mak2TaPJfCovsx1llDOnc4nLnZAWieDTrB/KWvvli1A9Di+xyTpELM7GDJY1br1k2
	 Tb+SCQgvguDz85oElD6TFK3NmQLAm4T++8IZhYea1R8NHcfsAQJHXQSdD3KCc0RBDsTyw
	 LepU1FZl3TdDH9HeaYyadaGKAV5EYm0/Lk4IwErQKpRVxKc9qvFGyXvXFxqVVKRTElg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="su0/cejS";
	arc=fail smtp.remote-ip=40.107.74.123
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021123.outbound.protection.outlook.com [40.107.74.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A2606A32F;
	Wed,  4 Nov 2026 16:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 481A2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=su0/cejS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc3eta1VDS78pPJswKXUZqEprQaZnpaoBaEjno2XXU6CICJWJjjlbLSPFl/XyO8zKG9s69mITNueXFWiNSAXGUZgLeQewVLKz6hZyAFctA7mB8JgYWqfzTj8pJDDB5q7IjFZQt4Z9ZKkFlgpyxZ8ZlC65yNv4Bt/NEiyI7VpVfyCHEPQ0MiGlyEu7/dIJLuqcExSewYVYyjSVex+Z+RiD+Hw6ivn4Q7IQ4JwaoBhoWWZrLuLDoWmfCT+Xvd0PJghpwlnyNqo/EJW2CEFKgIkApog6YrSQFwdKS5M++TA84lV8RfvRrtSvRx0xmutfWUUMhoMH1gaqkqBdqXXXBn4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu+RkBA/VqCJJDDe0dNKXrdZvfKm3X9oJKuXV8aDeQs=;
 b=kdxUHWP5HgKBs+/NJuJJvQbv1r4RYLmXx7DY3R5LruU/BKG2lfMemzk0X4e0ybW5QSROQz4EhxGVZTPrhAGESxnWAg2s7r7Ol1XD8Yb26EpKjLEQW4zTYn4wGcnKIaPG+i8KkvtUi51dkHdWbrWo1VJ8RkmnWl5bfmpL9Zp3vmTV+N9ROH1RLHvD2/HVqH9dmMK32PxivcThe9vMSocj9qNO26mlgBt+kTGYI2AWBkJbl8huvFalDexwqDWVcOUANVMsIyDf9GKIuKdy50SZETFwYInr0R6bv/1RA1bcBq66jSCW3KbRyXBP0wnKuHp5zwK1SUCEfth20s8KJQGCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu+RkBA/VqCJJDDe0dNKXrdZvfKm3X9oJKuXV8aDeQs=;
 b=su0/cejSzfCF7ZnY/4JOlbcnT9TGx8TK1hfBRFT4ipVOqXNLfb6V2dgvmmWcttVqaYA0b1DThME3vP22n6EJfSvD9Am6NhczQxruv17lrHLuPAa+tEMqjp4HHMCpzbfyN6MtpSn7DsJwFv8l7xbhqXkGuyyFsLxkFsE3uZtDuhw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6678.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:417::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:12:34 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:12:34 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devverma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v7 1/7] dmaengine: dw-edma: Add a channel transfer size operation
Date: Thu,  5 Nov 2026 01:12:21 +0900
Message-ID: <20261104161227.1742005-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104161227.1742005-1-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0297.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3c14b6-ce53-45a1-4342-08df3a8e6fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|56012099006|261021121427099003|261009223027099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	AtLDd1/7/x9tDffb8CxJegzBz6+HAjeHWKefOMUmYouxC33VYL/0Qwf+mOicuAGu/Oc+V+E4PjBiUCCigoqMxjC/vzxR9T/FFw7p9ky7j+nGGPrvsIZPLEoBGXjEyk1REhK6JiB6tC28kZ0Mo7WYnGWMQavsZIP10pcZeM8r1a1ezVPtbuNVRUxYE7WzmEx3Cd2QsjnjizwELytvA7mdUOgF2JOng9qQhchycVSCZ6HEBfq1rJ1jFDdxYi7CR+3lNB61DIqrmTYXS6fcktLpGf3V+3aEs9YG+/rkNsnj2sesUWVCK4nA324tX5Ucxxu0i9dFPH7E7LuXOG9xFIo7iqoIJesLjPOXLJwvs7gLI17hJFf28v7afwvGZuXK7K+/KP+WYm1RwyqAQIf6sQE1l9AqQcWu7a5g69WIYcILS+ayIK0xMwAD2xVOo4rk1dygx4UDN/BSY5ExavmWHG3ViQ+r+zmd87dy/5kzImfpP/fZkShbg7y7NFp3MjRg83RXVSukh67ithQwRYxV7Wde794EUOHDX6KgQ37CZDgyI3k0R9sGhS22Z8iy5HybEs5UjA/bO705wsCiEmVL54Csy0ZwTa92tpSbPO+6YlQ9bDcIv0BXOJH2yM4JUI6/oIPn1e3AgHJaqtl1ZlV/onWB2yYsZtr8wihK8WtYjG2y95g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IAYctW9yqmBh0YWh6XOFCIFJLc9o/OdrqFmechTLR6LS2f4lNzhHYYzQ/b3P?=
 =?us-ascii?Q?Vuv0qypF4WlsgEslbw32TevIYUr9+27pRZGAPv45eBBLM/tTVPwtIB04M/nh?=
 =?us-ascii?Q?psBpVzEqlfeIRiMGn6wav+VgQKJBp9bDUmgxHrXRjUX4zfn/h56YaSzBy+Zq?=
 =?us-ascii?Q?4X8coVADC09Ueq//z7teq9m0HqrCiVhuJo860xL0ONFH8X7606XOMm5czSB3?=
 =?us-ascii?Q?kV5xEt7FtBIA5EMlhEiAqFUTxb5dXrpiCpE63xhI2vEoC2PnhS8fJqyC3gEi?=
 =?us-ascii?Q?r5ehp7jMGxmVL8cxsik4J22M/Uiaad5tURPGKw3Bqza7Cski8MqCjKPN+ZYo?=
 =?us-ascii?Q?yaPjiMbVP1ADGl9G6HE0B6vSW1t2q+/Cu3fwJe3tdGNMNfYOc/mY8bUmMzyf?=
 =?us-ascii?Q?6Umigss6yTkNBC70FPIb+eOyHAg7iFOC9psqq/UfuC937wM8IYSlnKszJ17p?=
 =?us-ascii?Q?ZK1b6Jx63/Wstc7rNX83RKNLi7F6lHC0C21PF85hRZaHCqlLSQPI19Ftnhm4?=
 =?us-ascii?Q?VoyUwVfppbCHlQsqY9Ue6uKKV9Q+TFgN8gg88cEocbxa0X53c2GmWN5PbwtE?=
 =?us-ascii?Q?qMIAmnAVkeDtLlO/B7dimon18Y7Arxzse0i8stCR+pIGaJPmUBLgUhVyX7gA?=
 =?us-ascii?Q?pXeqITmLo1qDtxD/EmhTKHWEaByPZOUDzkq/x8OX3XZ2tix72FigOJmyOoyH?=
 =?us-ascii?Q?0OI5nUzFB2V/Gm7s1adJLsSdm9qM0sC0pbfEWdSzaGw4E2MEuq+tyP0kNIJb?=
 =?us-ascii?Q?fScQd2dGNieFlR9mtvQu842KyEPDhXOigWfVQMpWtv9EI8Le0N02dGV5lOM7?=
 =?us-ascii?Q?8I08OIYnU9GwUtu2qIaR57PNoJGcO8wKNdfvCb+oR2ti5LnW6oU+WJ8zXkJx?=
 =?us-ascii?Q?F6s1Vq0stCuHmSAHxTg9moX03pHzpCVSjnSrsKf1emMwL9nVGSVHUXJBrEL2?=
 =?us-ascii?Q?KBscp9VZgkqilW5MuHIp4IiTr7zuE8pF1BK/qlcZsRPAemeQM5NAmYv5Xcrr?=
 =?us-ascii?Q?zuK1/pzuMW+60TFyh4lvtNdsXHvO6N7CNSVaJ4QfzN0iCfiwz1OoND+ElKuu?=
 =?us-ascii?Q?7fVDOg6eJfMfRwBbKRmVx8l7lxPtHxj/ty9LSA846Dx3e6tmjYXMvBwdN1OK?=
 =?us-ascii?Q?6GlIgg2+Zb5OsN0ahcEkHzze4F8ZMb8cLoN0cY3jOCmooo2YtsjIHhGwp2Gd?=
 =?us-ascii?Q?OCrU2diXP5pp1hga+WAKxaCZozBH5V0TmyjBkFiTsOtAqoewv77hRz9fcIOO?=
 =?us-ascii?Q?A0QPw4rlPi/OtQU2avaTvoX9RVGFpxp+ufFc7dUYcDbtdVjJf09T5YZJx39y?=
 =?us-ascii?Q?et5i4aLRzbGnnOVjQcMVTE8/TZrXQTL7SNZ7OKcbbzyhfatDPTPxWGAFf5UL?=
 =?us-ascii?Q?U/NAW3bRKMkFH5uarVfDHRfNpZr8cV9WUM2RbNJ585muQI3sUQBt+EDdSRZ5?=
 =?us-ascii?Q?bGodAenBwjkPeyklItOkmaIrkzMBlsP5Z4giqtvJfsI/V7GLGZ1uoWT75KEf?=
 =?us-ascii?Q?w/CU4jYDtVEle6ll+em0yJFsVB0hDZZ2kzfVqML/xywR67qnEJaSuA+eMIdo?=
 =?us-ascii?Q?pyvZpeRzyfdY0x/5fSKcDnj5L9UsFC+XqlMUnXmxEI7btn9GFhLLYAYFXJlU?=
 =?us-ascii?Q?aWiXLdX1i1y1gty/556zeU8zuJ7VTP1GstXFbPqWRcaSzEyQ2fzrZanaPboB?=
 =?us-ascii?Q?T72aTZ14X/L6j+cXMa3tCXRaD1odrEkHQ5aRFNkaycRYnih1WqukPpbfCxwX?=
 =?us-ascii?Q?l4IAsuprHmXiuL3JmGwRQcSyJO+Szuf0hgH7jcfEwNImVoXHPTc0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3c14b6-ce53-45a1-4342-08df3a8e6fa1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:12:34.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrPMZB6/z2QxTAS4h29HdEciXdvfcp9hctuXDBd8sirRBN/yObLxwtw/PyZG7o4vscNTMn+BBgduIwOOTr5jCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6678

Expose the channel transfer size through a core operation for eDMA and
HDMA. LL progress handling will use it to check for a stopped channel
with no payload left to transfer.

PCI Express DM Controller Databook 6.10a-lca06, section 7.3.4,
"Detecting the End of the HDMA Transfer", documents this polling method:

  STATUS field of the HDMA Write/Read Channel Status register
  (HDMA_STATUS_OFF_[WR|RD]CH_i) is Stopped, and the HDMA Transfer Size
  register is 0x0.

The same condition applies to eDMA as well.

No functional change on its own.

Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v6:
  - Add Frank's Reviewed-by.
  - Add Cc:stable because patch 2 depends on this change.
  - No code changes.

 drivers/dma/dw-edma/dw-edma-core.h    | 6 ++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 76fd5a41a707..84a811bdcb6d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -163,6 +163,7 @@ struct dw_edma_core_ops {
 	int (*ch_quiesce)(struct dw_edma_chan *chan);
 	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
+	u32 (*ch_transfer_size)(struct dw_edma_chan *chan);
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t handler);
 	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
@@ -262,6 +263,11 @@ enum dma_status dw_edma_core_ch_status(struct dw_edma_chan *chan)
 	return chan->dw->core->ch_status(chan);
 }
 
+static inline u32 dw_edma_core_ch_transfer_size(struct dw_edma_chan *chan)
+{
+	return chan->dw->core->ch_transfer_size(chan);
+}
+
 static inline irqreturn_t
 dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 			dw_edma_handler_t handler)
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c053cb4c2844..fa8be85c7ac1 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -318,6 +318,11 @@ static enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 		return DMA_ERROR;
 }
 
+static u32 dw_edma_v0_core_ch_transfer_size(struct dw_edma_chan *chan)
+{
+	return GET_CH_32(chan->dw, chan->dir, chan->id, transfer_size);
+}
+
 static void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -665,6 +670,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_quiesce = dw_edma_v0_core_ch_quiesce,
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
+	.ch_transfer_size = dw_edma_v0_core_ch_transfer_size,
 	.handle_int = dw_edma_v0_core_handle_int,
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index d42cb4ad49a2..aa430219d0af 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -156,6 +156,11 @@ static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
 		return DMA_ERROR;
 }
 
+static u32 dw_hdma_v0_core_ch_transfer_size(struct dw_edma_chan *chan)
+{
+	return GET_CH_32(chan->dw, chan->dir, chan->id, transfer_size);
+}
+
 static void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -425,6 +430,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_quiesce = dw_hdma_v0_core_ch_quiesce,
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
+	.ch_transfer_size = dw_hdma_v0_core_ch_transfer_size,
 	.handle_int = dw_hdma_v0_core_handle_int,
 	.non_ll_start = dw_hdma_v0_core_non_ll_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
-- 
2.54.0

