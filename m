Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793372877;
	b=5Sc1eroj7lV5o1/LKZLhjy6YMIcaYVFSxxeHgiGrl3mCsV1obsDwCqZcXc2BAYCwRA0N
	 Q+r+rbiTr7ANnwdwbdYcfeErVV6CjXCiNc3OkVlIqXx48tPMFox+PZJWamYpYhXMa3bJk
	 EnVCHpTNjQzWaPBmhlyxi1LwU5xKbMHtdgLrrGCstgZTR22oayEgM7otdyBJadvlOPjQZ
	 IJ8aYCGmca2Z4UF41g4djDopn/y3WsQrnqxVdxcSsCr68zPJllXAmlbv44KNsZwTwj37i
	 Zu841lZNiLGMahU7v13ZXtAo5Qw7F9iQclKnxV1dSrcgdsf5Ze8/TsZPU4MDz+sB+8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372877;
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
	bh=2pUKuc9oLYmobn3zEC/ncSCAvYOjNke5qF/f+3snewY=;
	b=AEyt7Dlu9HHDWz9URxPLKoqI/B6k93s0NrnaBcgnTvjOvBdC2rKCgdqN5DLH5c9RYX8U
	 bxu0PwThOEzEx1pPTQBRd73S/3GDxroKHa2RXZkGaLP4OaW1Lq1O8f4g9AuZ0lIbYS8F3
	 kvso/VRMtvr9NbIA6LmbcVi6WsSntok2GCDGjcHg+0969ZVAYI9OTO+6JK4mhrb8JQ1nH
	 5KSaCiLl/7x6uYX3j0/sjmm8STqgagZ1KFf5asAUJAMS2kYQrrMIknxLPTCWSmhx80n8k
	 /WL8QOArUaOLcbo5eJk0MGCcHXtxiME3ThuAnstX/FugpZgzjUQJIXjhA4czDMwnUYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="wB55/q8l";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.82
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020082.outbound.protection.outlook.com [52.101.229.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFDD60A2600;
	Fri, 30 Oct 2026 15:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CFDD60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=wB55/q8l
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXrD/T7VOq3FCQz4TIRnd0iu6LFb6T8f8D9cBsQumPmHd8xtGwAm1stbb+7BdvQUooeKYhoVz7LyBad25DXRwYlORx/O/GsWZUs2AGX52yLdHj5YGHi2MopK30dX0Rq96hperCRDNG+bO8348W3/vAHeMQhA9B7PPQuBZ/zLWJFtvY6/lxGTEdhfdgxhkdtjL6bv2ORaogJ1Ix0hNsRBs+7vD5YQIs36Bbc/LrhcFn3SH33rL/+AZUvOD+xadMmy+ereq96eixwTNzTs2XKtzMgRn3rV2u6UOjHaj8Fg9BPhuvFuqAnpcC+S/6R3bQ3bQ/oP80DbGQj6MCk3HKsClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pUKuc9oLYmobn3zEC/ncSCAvYOjNke5qF/f+3snewY=;
 b=ZQl9jTHeECRJLCluCS20YKBJnPezP2GyplhS1MboHLfWEVkeOJP4sAG7i0EF6FpplHIuig3vqO/Ia1tZ+S1UabR1IPhEN/infLnOXLdjDAsSuGY33lZ0256AZbgYbepTQL5PwetX1Q2POFjrW8h4ycNmSVq/d3sIXCiZmbjzVk3Qh/29z+pmjJ6oSePu4qttqCtP+DPvW2ALhsCHLtV6uGCuVmb/cjj7BR9xR1XW1rYi6oyh5A+yHrz2dgWojuCPDexlyKlb3UvElih1rCcj01ZWhWE+RTXL9qhZg/RHUMfRS1M2ayjV37qBWJB9fUeLTSE3zjFhePN/3hYCK+irYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pUKuc9oLYmobn3zEC/ncSCAvYOjNke5qF/f+3snewY=;
 b=wB55/q8lS2zGt8oLlOHnK2mt6h41rKLsPNun6ABSHkgXIlaxsZPX6oNfw0hXuMitTRCYoEMYl0o9tT+eMQZSx7y+azRoq6Y3LZbB04TcVOudWRcopFHOinaI88KA46DXF71gsiV8RSWw4473EDXVa5oY9ZAn1YWGqCoNl7dyrMY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB2389.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 15:07:55 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 15:07:55 +0000
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
Subject: [PATCH v6 3/5] dmaengine: dw-edma: Use HDMA watermark interrupts as LL progress
Date: Sat, 31 Oct 2026 00:07:40 +0900
Message-ID: <20261030150742.2586776-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030150742.2586776-1-den@valinux.co.jp>
References: <20261030150742.2586776-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0051.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB2389:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fa66eb-77db-4965-6700-08df36979266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|56012099006|261009223027099003|261026140227099003|261026135527099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SOfP8UYh9rYYn3To2p0R+OXtKQdRy9URcBIGB8eGt6sey2FPXNMTgOAsXARskWPsIBGih8t9uaCCBxt9mkPDaq/8IaIZXGcAUdA+oAWxyvfexR40OIZKK2l0BrGkrxGEo4CweH/D2h4HqgoZnzFBU2otqpTHg0wP63vN8fxKiIY0In42ZzbRFa5nBk5GLwEXwZA4SoikkT5k8o7oagC3XH7ci2oCcxfqVe/zFfrst46vKNkpKcGNnedN0cfOoXnkrNBUh0+nOvm2Xh6v3iJ3eaenvkaahzoz60WZGrMuPZ78Cne/ETobxokn7dr7uDHmNBB455fIuJl+dmvscirSIIgY3dwNcXomUXznXRkyaWU38SugcNulRoYR/qWA7CCzHB8d9EBp0a047//rbqxBDMQxq/FG1X3d9PFznRrHTX/rOhpTjB3plqK/2sJnTDQwg83jjyhGA13AAI5Ba7RFu2zCoQYkLL4uNF+GSvL7nm04bpHRgwPEdQlLBm0fdlN0mvLRI3pz25f9v8MEcfabvH4wJKBhnoVSxW66DslTAP3yYRxuo913Bw6xkYMWhkU6zeeX5zuPlcBE416rcO2IOOMCX0px0H6bYg6O5zIrdoMNOLMhZYnGZZq06h6XxMUz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(261009223027099003)(261026140227099003)(261026135527099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XcqGJJ3FZt9uleQe24OTUUJkQgxo+wwLSQHbe5jpzz3WEqwLAbdAulFtF/iS?=
 =?us-ascii?Q?DOJxgYfV45lbW9m8ZHJUmwEE6g45nvwmAZfSKb47KamAMVTD5q2TKLOm6vJ2?=
 =?us-ascii?Q?eZeMTY++rbe3Nc/NTjG5DxRPknvpHGy3w4XuEtlFFXlUr5WGVT7bf9uwdcmD?=
 =?us-ascii?Q?W9zP/9KOxXWpRcfuYbRIJBUaYweDvj33SYF8D/btnnJyJy+wCg28EGhYtHkr?=
 =?us-ascii?Q?BULKosIMPVg4iK+iNye6tTtZaCbFfhawrFluNFMBYI57xiUbZa7iFZbn1bls?=
 =?us-ascii?Q?9ZBe0QYaobIbGYt8NKxdEUi9b8/Jgfk0BNELTolpFDHjp4Afin0Z9V2sfsPl?=
 =?us-ascii?Q?mqrliFz5jlN3ATXJnuwiXZGdIh+e5wNra7RH3yB1CGbhgzRfNXVtxpoSA6yv?=
 =?us-ascii?Q?u6Pz7I+NS39G0h6JMjgctWylicy6PaShsBYQRY2Eg5K4EZZ9rs6OgbrrFpqh?=
 =?us-ascii?Q?TQWAGu9zgPnO8Dl8/R3yO2MYuH6PGUCSp32AXwMUFEXtn/SY22HZxjjfxSG0?=
 =?us-ascii?Q?rxOTpYtOi2+vVbo1f676p4GHmtNqtKuHGgUkpjoOBhezUlzkSJGroaQdyT04?=
 =?us-ascii?Q?pS9+PKQ008k9n70wfi5q1Tou1MB2kN6oh5z0sd/D8BN4HbHELC+nJbeUMDRq?=
 =?us-ascii?Q?lG7Q1X9y5KUUANaj9cpzBb33WFelppXbpnv4gD4zm/tNiBpCHb35GrzkAMme?=
 =?us-ascii?Q?4dgCrZAsAJvV5+Ak1rXXW18GiFKA/m2WySl/tCLecUp+xv4Dw/wonbKH+WD4?=
 =?us-ascii?Q?KwtVUu94IfIy3mu8x5vbNi1B4aMoiHoELQpknIL8H1DaZWrhPxrD7cfTvZAi?=
 =?us-ascii?Q?nllZKUldvBgvO727dqscTYHsceDQXb3RXmDQwvCNBLmNDiVio+j94SSFzXq1?=
 =?us-ascii?Q?vY8QI0jjxyMKEnrgFYifKtzHZdYqpQZvwBgRu4kXEjBcaE+RRooIz7e5mm4J?=
 =?us-ascii?Q?sPY8TRx4xpS979k7yi8weIZ0wXq33lxNFbGXi63siMT/CHy3jkKMVTtHic8x?=
 =?us-ascii?Q?jgxHF9TUYSsfkmqohqaZqC4fcHAIiH+LsJZ5vD0gFA78fZJ9uKUKmdLGD7AC?=
 =?us-ascii?Q?9N9k0gvAHPaEWLTbtVFO1R3TOU41XkpA8yAjspLbFy6NpUwzCn4Bqbc6BEak?=
 =?us-ascii?Q?JxPRqmZfUDWu5xf97hHTZhe/4/mL76iEKfj2wVp8bdzhn785uOa5vIouG012?=
 =?us-ascii?Q?QrgTs403ivhkbLIBCJTBjzdGxo7NGMcyXmDddtICXWGLPn/jEKnlT1LT73aH?=
 =?us-ascii?Q?Z/za6xztzAJKrExz7ZQcrreP24xuElho/VJgSdACbv/d0jqxTdZ5Eoh1NHqS?=
 =?us-ascii?Q?hLUghA0mHmr53CA/YBGr3qeNPboiLVVuLKUX2AmtPoqsc/9SyoifiQyDNIJv?=
 =?us-ascii?Q?6NuJ5JVOgwZ6sQN772QDYWQsb3RR2UdJB8kSnrU20HAJpYhMVTONfrlYBY8w?=
 =?us-ascii?Q?nBpWLOuqWR6edi2fNha+sUywXvE9OnyteUPIrElYsPPujPGqOJ52AhJj2o+B?=
 =?us-ascii?Q?RONDuTbw5OcJ+t3Vs+ZqrYt6GCERUw8iXtyaEubArfdzv7VOrp8cl/gGBdrn?=
 =?us-ascii?Q?01rY6IaSFDqD+LHN4RcZVXrjw8a6aB+8UK7aAvvlNpd9GGlM9+9+JMFwK/cT?=
 =?us-ascii?Q?5U7wHRKugZ7/m7MWWXSygFbNPlaIn2twIDszlHeQHGo91tzoYAlUBZuXLfMV?=
 =?us-ascii?Q?e14woJS+J6crCrVdWgLeQPfqvpe82ChM31IRpprVkViEu63DC76HtnFSKxz1?=
 =?us-ascii?Q?jw4xXqjOE/Rr3eJbB6PElq/CEavKqrPdlWpHJ56z2H0qFjJqLk7l?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fa66eb-77db-4965-6700-08df36979266
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:07:53.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +linLEbwOXYJavFPGYLGOof+p2VgViTdkbZDaAeGGaQG5EzXD74XkF1g+jUyrNrnLyR6bi58kEjbGf5iLv8NTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2389

While HDMA is running, DMA_LLP is updated only at watermark events.
Enable watermark interrupts to track progress without waiting for the
channel to stop.

Set the watermark bits on entries that request an interrupt, configure
local or remote delivery, and pass events to the LL progress handler.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Reworked v5 patch 16:
https://lore.kernel.org/r/20260812155721.2807506-17-den@valinux.co.jp/

Use the common progress handler and omit the unused ll_irq_clear
callback change from v5.

 drivers/dma/dw-edma/dw-hdma-v0-core.c | 65 ++++++++++++++++++++++-----
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
 2 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index aa430219d0af..7ca5afa181fe 100644
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
@@ -68,10 +69,14 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
 	 */
 	val |= HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
 
-	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
+	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
+		if (!chan->non_ll)
+			val |= HDMA_V0_WATERMARK_INT_MASK;
+
 		val |= HDMA_V0_REMOTE_ABORT_INT_EN |
 		       HDMA_V0_REMOTE_STOP_INT_EN |
 		       HDMA_V0_ABORT_INT_MASK | HDMA_V0_STOP_INT_MASK;
+	}
 
 	return val;
 }
@@ -81,10 +86,12 @@ static void dw_hdma_v0_core_ch_off(struct dw_edma *dw, enum dw_edma_dir dir,
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
@@ -95,18 +102,26 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
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
@@ -168,6 +183,14 @@ static void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan)
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
@@ -208,17 +231,23 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
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
@@ -275,7 +304,7 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
 
 	/* Enable engine */
 	SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
-	/* Interrupt unmask - stop, abort */
+	/* Interrupt unmask - stop, watermark, abort */
 	tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
 	tmp = dw_hdma_v0_core_int_setup(chan, tmp);
 	SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
@@ -336,6 +365,11 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
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
@@ -355,6 +389,13 @@ dw_hdma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
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

