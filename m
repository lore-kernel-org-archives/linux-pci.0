Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808767;
	b=Y1gSJDlNSjLaOZ0TxmkWqkXgPpChZFNKgW8dnbtn9zqshsSVE22EnajP1CRQUtVPg/lx
	 0r7+dDCa8lfxFGdNS73UoiH1vDgpdsWSyHmY+HnHn7p+Uf/U4aP2J6soA+HiX+kCMwz3Y
	 vteQNNL359TxkoTdQZwm6HixI/j/mEUb0096B3CCDaHxIBHaUFQ3Swgp4ZeZvcmqO+A2o
	 Xp93QqZprawFB1ZvfKTmO563DJfNQ7bTiVTXtVDJKnfkp9czb3lt9cKOpi5flP+rqW54O
	 nmZyz59ujy3kcXOQaNbqKvXsdwmyIv16YYJ+2mlr6Xh4qYJqWKNojkjRiZ1l0uQ9vMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808767;
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
	bh=wMR5T85nASEeM8CnOuqCu+1VsoW2i38YKk0FALfvWMw=;
	b=MFyliBuJkyUQI8ZDzirZcIxH4ELGwIcaSkQm0sxCaQS67tDpTtwt3G8nwqQhGbqhpZth
	 gOqVOWfyzvUMIh79o1FGCjwaszixQleQ3zulWO2VaDo2vhLLk0xYaqkgE2e6ts7GoHks4
	 NwnYHmdHv7vntGhpSMVTN/tBqiO+9ykvt+k92uTTvEL3viy55mIOe7KckVhnDIG/vaYT3
	 BPtYOI8MiEh4mMX+oiy2EehF9ka2nncAr97a6rbsBnxzuwj/NX87DqO1i6KreDdCcmJUZ
	 WtTvjeHN2uFtv2cLTn2R/Dbfmi8HZjTeGnHIpnsz9+PWksiiLADnYTNSscWs7BwI7Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ekpApLbJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020079.outbound.protection.outlook.com [52.101.228.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC22606A329;
	Wed,  4 Nov 2026 16:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CC22606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ekpApLbJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLvmOuspZi5MnWD0BhKpAbduDXY4295omi1BVbduwL9ildyNxFD7DGmuLI9IkZ30NLHLITDr4GdOta4l/JKnWr2LteYJVTGFCQ86g/MgwOOgN64dutIOgdVNQEkZvIkLz+9oBm2um9KnT2T4uQiFM5Qbqk9JsZ4BZwk1XKHfpHoRlRm+JyF3nLguEYTQc99krOA6z6Errjc0cyMuT/GGgbv6AsU+k+NqIHMM8B2RtQn2S+4WesCfwszWMWygjh+j0CbCc+StAMYI+W+vB4G04doYpW8iXSdwB/hbVPfkwBC4vrGAHlcFBdmN7KJsg/lJTaeqSLVrNjlisW+yPxJewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMR5T85nASEeM8CnOuqCu+1VsoW2i38YKk0FALfvWMw=;
 b=BBw2anyD+xxnjB5G/1CPBA3V9yfDS4ZP5FhmIv0oayWKNkDh3K5xuF5N2+5lw7KvQhDnTmlmtXFf3UetU6a+NjQaU9ZwrH74BZZxXBdfn4AMaq5G3VRMcpX8jwlFysvaY+8SSxWIFcZnHOKBVgd28XosAnMrUyG/GstANKG9AJelKrGUMMlRM5l7CMopS7lZ9E7QeXbDZ1f9D5I+gWxg2QmgbRLaK5Q2pDATus8yBZMuBHguh8TvHAWp21xJLlPFjxGr7GsRXYsNyebMw0TttCyRmOlRTW9ns06NaxTiqBZxv/yDtVwBU88GvusuzLGtYFjX3Zai1PRwzB7WvBdshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMR5T85nASEeM8CnOuqCu+1VsoW2i38YKk0FALfvWMw=;
 b=ekpApLbJlIQoVfPPivztLlB2ujfZIgcfX3oJDbTTJVIL3tLvT15i1NDlBvosrngz1bdYbeOyL4mFq5Mrs/8zuDUq05G1GvFJQ2I/uXwprJ5FNm7gxJDQQjllq3eTIaSWMPVh/094nnGGWhqABr/5RlZDdrFHH3g5CqNMC8uIDJg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6678.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:417::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:12:37 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:12:37 +0000
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
Subject: [PATCH v7 5/7] dmaengine: dw-edma: Use HDMA watermark interrupts as LL progress
Date: Thu,  5 Nov 2026 01:12:25 +0900
Message-ID: <20261104161227.1742005-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104161227.1742005-1-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0088.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 68a0ef5b-d017-4853-8576-08df3a8e71a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|261022105027099003|56012099006|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261022113327099003|261102123227099003|261026135527099003|261028144727099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BNnCSdxqA0/6b7316gjHSXaUCrwlMCkm623br8Fggnidg61g9YjluK9/Kapvza9XCnj4J3/sPsg0IWc+PvzyPVqzXW2XFp9wDAoaegSpdDpOXcslqlZRp/unwp0QBSmDw7ZFp8A5Vq2TqVKVfLIaNe/YbY0wwPV2LvrUcITRE/tl4yZCSdXj/34g8F4kWn5QhUlypN7PtUiRJIbGJH6qj3HqFgXVlspZ4SotSqY7T5xoBmjYHEgqPa+FLBHmthhAoL6uka2SJWXcrWb230LIw2eU6msivLOeWWjF6RX20roTdOVti2wdT0P7yOpOlkzQS76rrX+W0m79cSKUGEVia47VkUCurTxj/31Qk33pQ9IVuUreDAk0V/vdhIY4CT6S5G0gP1n8K/R2LBJsZs86KwuX6HJb1Kvdb7LoDoJGCq38XZfJht3Nof+xthhhfFjy9NLMedMq2YMDxU6yFbNqPueCM0xU37t6HemlGFmzjKTKZaeJt6d6PKluMmHf63bou78UGbbaPXlFtq/o1HrdJ5RjFVZ6//HLvmuGG0kX9IIV8plqL+cGXJWxFSI9Zwi2DMylfQOK7+fJbwzxnbJR2/xOqOgYkWtNY+asFWYDp62MVmN0NaLtVqj0Kh+wzlk1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261022113327099003)(261102123227099003)(261026135527099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mvSOq4lx/Lo68r80HP4uwIAQ2eQuuSmaxwziZZAeCyr9GPhWRcUUZRbjtzO4?=
 =?us-ascii?Q?wDggb84cYrhmaPiCm9vu8XY75Mm+o9p4ZLLZA1dAHRveoNkTpLYFIXuhdE/c?=
 =?us-ascii?Q?WPKQH8vmlkHJUAl0of/hLyFSG5VQOkh1AqPWvUACzptEjqESsJPpGDe9TBKJ?=
 =?us-ascii?Q?LflCqbs6IaE7LJeLFwvsxx71wL4ArieHc7tInwzt638LE0UkClQpYf6pTGMF?=
 =?us-ascii?Q?3+vq8udApRQLcj7Fl2lWK3l/+HD9JWBXT1RC15vBtkv+O1TRqTrKSL85Mlnm?=
 =?us-ascii?Q?WVTx9VbB97w7Ua3nw19sl1I9705TC4vuUM/HCKNPgw4EfewEVIbUCzpsm4eb?=
 =?us-ascii?Q?vUIlhTmv4AJCiqhOW2SXrQZGKos2rZpW6KoOztjnlIqpcYWIvUMmoRr/DjHV?=
 =?us-ascii?Q?x34EIt0aTXbw8hqGFUS0wB6IDw3BvgK031gmQTOY38KEdnGi+QlfAbrReC/u?=
 =?us-ascii?Q?CbgwIOV0nv1NWNlWGVp1VQW2pA3sfjYjueGK3syrEvsJPLXPcGVNGKH/43tn?=
 =?us-ascii?Q?Atu9R8Hhx5bYBaFI5LdEwYFDHJ99Xy6BMjRetqeXxNSZW63aZXb4mW+rfYug?=
 =?us-ascii?Q?h3nB+DY4HMA7u2N4s5nMCI+cNDWO7uxA3tNL7dXcCGcLBUCPuD5irolvT2sF?=
 =?us-ascii?Q?FLjixpJynk7Z+YogrFfWICxxnyrnW6+MdeYw6RgGLpIaBbtlrM717w5VGd5S?=
 =?us-ascii?Q?k7D8SANIEl9dmKzgSK0cxjdjVG4hxowRe2kiYjT452kyniwd5jBO45b3M/GX?=
 =?us-ascii?Q?oUJswvd/TtmBTq0PGQpTWTI1vclD4IiycitXKKtmuf3uXZXdpv7RX0AMdRq4?=
 =?us-ascii?Q?Qc4u4o6maaA0sOIgBsBz8ka30FTNHfvQNuc1/7cYxAVjdgHT/1p4amz+lxV3?=
 =?us-ascii?Q?yVKhszuRVfYkAJJyJhltzeuUbRDAY5OqaDO/Dva1da5n8pXhdkV7eHuK4MuK?=
 =?us-ascii?Q?qM50bKsznar4eBrjWgufAyVhKjEp0qCQn4TZQAMPOzfVxurwghkhCo3IYfhw?=
 =?us-ascii?Q?J//YCXTA82PiIFHcDp61s/IRWAtsSGVfs5juFqoO0FWorFCEZAkgffZWKs0O?=
 =?us-ascii?Q?vlhWPG31DCWWPgJuiCnBV8gfT9dJn0VdJj2oT9MREsiA4xUZp9SA5edP3Z/d?=
 =?us-ascii?Q?uKmYoRar1menRauUpukbQ6CKo+AHITMY4tHcqt+JW4mpuB9FQ+HPnS1P/naK?=
 =?us-ascii?Q?ylTKG/dLgGIEVZscwF9kfldhRHBTM1vMhsCJgchR1bhcbi2Hts67sXBjase9?=
 =?us-ascii?Q?ZvHVI1gSCkkqSaM9gJ07FB9T1R5iCvV+OuJhyvWA6n1mw73b7oJacE5H1S2j?=
 =?us-ascii?Q?xiJIfDcqggR/kmhZ7D243yChTCqA2PS4hpHM1JeFM9WFwrm+q6t6hKPBuTDY?=
 =?us-ascii?Q?OT0NC0WcYGagKbyAnv5Lb15Xvp6yNrwLarj0vzPaIJXZwZEAH/Vq50mXNyR0?=
 =?us-ascii?Q?2UmO2zK3INwxpCB8IIF3LjNMMqPoxgI8PYjLeCcBKM0OzDt/ob1GGVXLA7FA?=
 =?us-ascii?Q?xfFz98pkbQk5l1PMYIUxtth5axkR1YQkb+JQsC8DCHy14p+9uVkPJfpdpYk7?=
 =?us-ascii?Q?P3ZntWOhZelmAX+nnCVghc8yHLDaDdURgwoUnVEeq0JgxX7tK0tT45jvNdq9?=
 =?us-ascii?Q?KOHAq/8DciGRasVqke3z5cwPZxCwSxuizxrvDA5M5J3/uT85lrL9OgaApM0m?=
 =?us-ascii?Q?7ZAVW6uwnWE8J6z6pNeABIufAJrsYm1ncexLCILsxL7d7eSafcnIAXli3OBF?=
 =?us-ascii?Q?VE2qCNN9i1VpwxYGOjXjZYp6a8S2WzV+zvoCyOr2ejL7egXoMDII?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a0ef5b-d017-4853-8576-08df3a8e71a1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:12:37.6754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSt9XKtvIJLPYgvdgExuSNkpMxTXB7ZGoaDNPWr55VFYfGXmeTXEarSOpMGKVemOx5puoauTumB8J7xyExyG9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6678

While HDMA is running, DMA_LLP is updated only at watermark events.
Enable watermark interrupts to track progress without waiting for the
channel to stop.

Set the watermark bits on entries that request an interrupt, configure
local or remote delivery, and pass events to the LL progress handler.
Unmask local watermark interrupts only for LL channels in local IRQ mode.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v6:
  - Keep watermark interrupts masked for non-LL channels (Sashiko).
  - Link to v6: https://lore.kernel.org/r/20261030150742.2586776-4-den@valinux.co.jp/

Note: Since v6, IRQ placement has been limited to descriptor ends and
      the last free entry to keep the series small. Further tuning can
      be done in follow-up patches. I should've mentioned this in v6
      when dropping v5 patch 14:
      https://lore.kernel.org/r/20260812155721.2807506-15-den@valinux.co.jp/

 drivers/dma/dw-edma/dw-hdma-v0-core.c | 62 ++++++++++++++++++++++-----
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
 2 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index aa430219d0af..0cccd0003a1b 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -58,7 +58,8 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
 {
 	val &= ~(HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN |
 		 HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_REMOTE_STOP_INT_EN |
-		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_STOP_INT_MASK);
+		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_WATERMARK_INT_MASK |
+		 HDMA_V0_STOP_INT_MASK);
 
 	/*
 	 * HDMA_INT_STATUS.STOP and .ABORT are latched only when LSIE and
@@ -68,6 +69,9 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
 	 */
 	val |= HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
 
+	if (chan->non_ll || chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
+		val |= HDMA_V0_WATERMARK_INT_MASK;
+
 	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
 		val |= HDMA_V0_REMOTE_ABORT_INT_EN |
 		       HDMA_V0_REMOTE_STOP_INT_EN |
@@ -81,10 +85,12 @@ static void dw_hdma_v0_core_ch_off(struct dw_edma *dw, enum dw_edma_dir dir,
 				   u16 id)
 {
 	SET_CH_32(dw, dir, id, int_setup,
-		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+		  HDMA_V0_STOP_INT_MASK | HDMA_V0_WATERMARK_INT_MASK |
+		  HDMA_V0_ABORT_INT_MASK);
 	SET_CH_32(dw, dir, id, ch_en, 0);
 	SET_CH_32(dw, dir, id, int_clear,
-		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+		  HDMA_V0_STOP_INT_MASK | HDMA_V0_WATERMARK_INT_MASK |
+		  HDMA_V0_ABORT_INT_MASK);
 }
 
 static void dw_hdma_v0_core_off(struct dw_edma *dw)
@@ -95,18 +101,26 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
 	dir = EDMA_DIR_WRITE;
 	for (id = 0; id < dw->wr_ch_cnt; id++) {
 		SET_CH_32(dw, dir, id, int_setup,
-			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+			  HDMA_V0_STOP_INT_MASK |
+			  HDMA_V0_WATERMARK_INT_MASK |
+			  HDMA_V0_ABORT_INT_MASK);
 		SET_CH_32(dw, dir, id, int_clear,
-			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+			  HDMA_V0_STOP_INT_MASK |
+			  HDMA_V0_WATERMARK_INT_MASK |
+			  HDMA_V0_ABORT_INT_MASK);
 		SET_CH_32(dw, dir, id, ch_en, 0);
 	}
 
 	dir = EDMA_DIR_READ;
 	for (id = 0; id < dw->rd_ch_cnt; id++) {
 		SET_CH_32(dw, dir, id, int_setup,
-			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+			  HDMA_V0_STOP_INT_MASK |
+			  HDMA_V0_WATERMARK_INT_MASK |
+			  HDMA_V0_ABORT_INT_MASK);
 		SET_CH_32(dw, dir, id, int_clear,
-			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+			  HDMA_V0_STOP_INT_MASK |
+			  HDMA_V0_WATERMARK_INT_MASK |
+			  HDMA_V0_ABORT_INT_MASK);
 		SET_CH_32(dw, dir, id, ch_en, 0);
 	}
 }
@@ -168,6 +182,14 @@ static void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 	SET_CH_32(dw, chan->dir, chan->id, int_clear, HDMA_V0_STOP_INT_MASK);
 }
 
+static void dw_hdma_v0_core_clear_watermark_int(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	SET_CH_32(dw, chan->dir, chan->id, int_clear,
+		  HDMA_V0_WATERMARK_INT_MASK);
+}
+
 static void dw_hdma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -208,17 +230,23 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 			continue;
 
 		val = dw_hdma_v0_core_status_int(chan);
-		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val)) {
+
+		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val))
 			dw_hdma_v0_core_clear_done_int(chan);
-			handler(chan, DW_EDMA_IRQ_STOP);
+		if (FIELD_GET(HDMA_V0_WATERMARK_INT_MASK, val))
+			dw_hdma_v0_core_clear_watermark_int(chan);
 
+		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val)) {
+			handler(chan, DW_EDMA_IRQ_STOP);
+			ret = IRQ_HANDLED;
+		} else if (FIELD_GET(HDMA_V0_WATERMARK_INT_MASK, val)) {
+			handler(chan, DW_EDMA_IRQ_PROGRESS);
 			ret = IRQ_HANDLED;
 		}
 
 		if (FIELD_GET(HDMA_V0_ABORT_INT_MASK, val)) {
 			dw_hdma_v0_core_clear_abort_int(chan);
 			handler(chan, DW_EDMA_IRQ_ABORT);
-
 			ret = IRQ_HANDLED;
 		}
 	}
@@ -275,7 +303,7 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
 
 	/* Enable engine */
 	SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
-	/* Interrupt unmask - stop, abort */
+	/* Interrupt unmask - stop, watermark, abort */
 	tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
 	tmp = dw_hdma_v0_core_int_setup(chan, tmp);
 	SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
@@ -336,6 +364,11 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 	/* MSI done addr - low, high */
 	SET_CH_32(dw, chan->dir, chan->id, msi_stop.lsb, chan->msi.address_lo);
 	SET_CH_32(dw, chan->dir, chan->id, msi_stop.msb, chan->msi.address_hi);
+	/* MSI watermark addr - low, high */
+	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.lsb,
+		  chan->msi.address_lo);
+	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.msb,
+		  chan->msi.address_hi);
 	/* MSI abort addr - low, high */
 	SET_CH_32(dw, chan->dir, chan->id, msi_abort.lsb, chan->msi.address_lo);
 	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
@@ -355,6 +388,13 @@ dw_hdma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 	if (cb)
 		control |= DW_HDMA_V0_CB;
 
+	if (irq) {
+		control |= DW_HDMA_V0_LWIE;
+
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
+			control |= DW_HDMA_V0_RWIE;
+	}
+
 	dw_hdma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
 				 burst->dar);
 }
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index b88226cdd791..e240ffb3dea7 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -18,6 +18,7 @@
 #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
 #define HDMA_V0_REMOTE_STOP_INT_EN		BIT(3)
 #define HDMA_V0_ABORT_INT_MASK			BIT(2)
+#define HDMA_V0_WATERMARK_INT_MASK		BIT(1)
 #define HDMA_V0_STOP_INT_MASK			BIT(0)
 #define HDMA_V0_LINKLIST_EN			BIT(0)
 #define HDMA_V0_CONSUMER_CYCLE_STAT		BIT(1)
-- 
2.54.0

