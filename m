Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.229.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793372878;
	b=qrHftEoy49q9nGPa3Av4CR6cS5Sgd1cdVghB3DG/LksVG24p1NO5owxFBzyjcbEmMSCZ
	 WVTXP6tj6GE5sfB8+030H6xlM6mE2tbqq20f2ar+XFXAHpxg76Rl5TqhWwqoJVQPBZsvK
	 YT+fQFCPwharVhfkjgb4HNajev55SE9Kqq6Pmzj4p6wDJgFnvI+WPnFaHmpkPnWvUHZ2L
	 b8teuu2x29fzdkh5Os0eKFgcHVnL/Zg5vX8s1QJScpe0OYtvexRdDg4kXkgYmCBiQIMEX
	 jH1ebBPQKmfAePChguKaAECQ39MXVoW4ct/q7CG9PYFizb2/kMbCGUH1J4cPidzzHqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372878;
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
	bh=btP6hc5X4IN0Mlz529k7fsd+NkP5QZ9brXQS+dJWWPc=;
	b=JZTenjSyLE9nIgoDBG96S27iiwdrSV7M+GDZrQvvOsy9LDwC3mvjDKnlrTnigHPJb/ta
	 GluCoge2kUOxWf7d6jNKTaiP8Ff0A/WKzflPpITfekek5XOGG4pgKX69e8eQcxwMX/nN8
	 HWgBJj2DhaXlijqbS3HJfoOex5m8P8/ASmcHvBQ8lGoawZ3DpnJe0OqQzoaBGbogt7tP7
	 BRoZ1dpZBzjpTbw3+mAW3sOFmqk8PlA5Mkc/rZVjbx+7SFdJ2k/+O7Ooj2F8pBikA96qN
	 ufE0SYj5hU4BQr7BlPo0ZelmzKr/buC+Hg2Z7uNcawlB+dQpGw+Mvup+MwoN51FB1dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=FSik57z3;
	arc=fail smtp.remote-ip=52.101.229.82
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020082.outbound.protection.outlook.com [52.101.229.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013160A2610;
	Fri, 30 Oct 2026 15:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F013160A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=FSik57z3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFOuOTSt1/bWks1p2MYJXye6hz4+WRwJGVzhqGVa2nL3nEnketrtfskInyh2YCRyKW7dvGstUKabCioF1wY/5XQFdux0s0h3UCcL/wcaK8xShM+5F3kkPIKyzX4t6ZUaOI/aYU8IoxHDVktDULxeA/By0RgB4Hmu4HmN1bQskDwZFO/bUuTo4uVAMWlFBj45O4swnSSnfqv/1C22rOUMT16xhiTRyFCnqsrMy9Mz4Mscqwn0oLMfoJn9qKNSrLsgatXZoNFBVZHPdarxxUifOpYrJ4oNtJGtUAT8C891w0SN8X4QZJ2pvho2FnAa5XWD68XpCHXeCuaROA4sW9BBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btP6hc5X4IN0Mlz529k7fsd+NkP5QZ9brXQS+dJWWPc=;
 b=R+svXUvDW6mkbuTpk77Gz8LG83yCn2QQ/bCVGHhH1DmD/4qLCTKIrebDDtRH0eDrrCURw/mxR9Bla9bUyvqViyMz/LVsWXjBxkNrQTV14BcvzCT8DldNRCMzVrfo9PAyPb2CTljh5kb284mCwcZ6MLfYYQiweGqQXlPBznLhiAW90WoJ3Y/tqPrWEFWVnMWyLIdXHH+hYM9PuPZ2Emj4RTsfLF5PLzDipxoRfPAaJwIeFlQJuKlwOpoqwBp9cQ7s4wXE5f/Uy32juikPMg+h4m0Ya8f/PBjnSTAb4TSut+5XH56wlsY+id4K91tIMl6FyfJ+/HXOAQzNZ7MI3Z3dYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btP6hc5X4IN0Mlz529k7fsd+NkP5QZ9brXQS+dJWWPc=;
 b=FSik57z3LmBY51d7pkVquIZKEUlAT9KfejOcXayLPir7Ppx0U5GNTVpsqwQsrLEFS+GZgvQcaM/kfSGk3Q0AYXGJqU31UvJGzjvFSE9X2xwu/AIuIMr+BXUNCLEmx0WhYYVw9kAxujXUASB1wFtE79K7cV5vlJ7WVXYYSkdeQ0U=
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
Subject: [PATCH v6 4/5] dmaengine: dw-edma: Dynamically append requests while running
Date: Sat, 31 Oct 2026 00:07:41 +0900
Message-ID: <20261030150742.2586776-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030150742.2586776-1-den@valinux.co.jp>
References: <20261030150742.2586776-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0007.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 0a528b4d-0259-4c23-9dbe-08df369792ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|5023799004|56012099006|261009223027099003|261026140227099003|261026135527099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	laainbP3E1bQjNoRNPmmnrGi7rl0nUrSdvj3473MTEaDV7IvRq2d6oMWebFYRC8AHnaMZBNDTR3CiCibUKC+Q0Sl13zbh9KUwpsNiWUO1a640Fa4dpdzsfMHpDchXbNyPK6UQxGXDMIT2Ncr1wF120N65qNyaB+OjCYIcDN8bBZd+Fzsrk8oUtwBDWO+tLEGkKA66EpcCz7Op9zSMSBZ7d7I95WCjz8yP4Dcuj9CXTx0xgalrzWEJWXbb8HkY9pTiW0UKviA3K6kif3SWyZSbMjr56S45y/z8DNTC7k1eM2V2mhGcYyzXwnGg0WiDfgh4PWzUjzuS89g/8Zk3mfO03CmU8u/89GQX5O5sGmPToOsMWIvf0fy9cy/VmOSjMg5Nem21p7SgqeGZjFcLvwSuXqkeGz5+SreDjx3W5LP0PnwWpixg7icGkhUpsyqA+P9/HijnDmL6OOhSGqLWKT/ixJcRwNLzacgdfwgFJO8nXg3MxCEGDPTcUkMkYHacRdOMANPZ+Skirj/Y9q2zFd6q/7znYuH7JZGwD02IjITMz7c34M97+n+16k83GVSFcjV0chv9IiqUvDiCI1KufWFiNbqr5FHhLiL7nXVfv4aWvOPtSlJgkE9cr3kp0vRCm/C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(5023799004)(56012099006)(261009223027099003)(261026140227099003)(261026135527099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?34+tbw2KceEJT2//jNp4rsX4RD2HySo6oAm6ZS3Xo1dbG8VI0iVshdTwZqig?=
 =?us-ascii?Q?6J4enQrKVgPkeaSIg5+AiJ6MU0Vv6y8i8+Ir/nHUBvJWPctBpjoI/41lQyE9?=
 =?us-ascii?Q?kVao4sMxWcyb4+ckpctxpoIjgdT0POCPHMw7ZJC9oDhUPt77u7jrh7WVWPEb?=
 =?us-ascii?Q?AG3EewrNIcRqc70Vmn4vw/y/vFPSgv0g/f8WMDNKaEWjlCeo5xXchAK/5ZV3?=
 =?us-ascii?Q?qX3FhYY3QbBBK/vuA4ZnvSDpkIlsWYRHqlp8EDF9m1BnNoCr2Ex0RmiWya3w?=
 =?us-ascii?Q?74FkfSniNDRpzRCVlB7+n7DuQMBxCr7S1kDCKxdgR996hWDOueXG1QbPBPLN?=
 =?us-ascii?Q?WtVmwDS60PcZ3thaz0h0L3f/ZZ8+O/jowMpyj4AV9Nnhpcp5Bv9Wp8DT3dYJ?=
 =?us-ascii?Q?m82wNwybbdJP2LAfWmzK+wqtO/x75Zma9QKYjbtEbF4crhLBxxS77aMPomBm?=
 =?us-ascii?Q?9JMVQ9vmLtfvG4AIt7cgxzS+IeZRPx1o0ymEmJPfiCfMCgvyaYDeV+eCAM0j?=
 =?us-ascii?Q?Hxq0gbg+vuKqq+BaHuhTUauA7K6qmtHVIZRtJv1uRj/RrWgfZ7FoCrRSpTgN?=
 =?us-ascii?Q?tbMZlgvrvjaJCPkBzK/RPKHjIiHaQew290nAxYXFJAM0azwbgm3nSg7jVoeB?=
 =?us-ascii?Q?UGzrdryoD21Xxb+BMetrWpeb5vQXT+Q+kiIbJsFf12RZeBZXL4Jf1+pSKKDd?=
 =?us-ascii?Q?ZyirwaU8e+Slz8vIUwomdCALrZGx+wSva3CnXBxlPhKs1Nm9IhVYH9CKmHO6?=
 =?us-ascii?Q?qlHyHd2e4GoDUzdXR3XOIWUDDh51Ybu/ozrfidCSh6RhmKEqb24NEJfOdUmn?=
 =?us-ascii?Q?7yYnabyTMueU238P31OK/rupQeyuG5BMGHP/ai5amv5HhDuGxezQPl+yE5ub?=
 =?us-ascii?Q?9eOclsiviSkj5VlRVzpazd7ZBehyA7/1wDs+u63blO8/0DZiZfvbOBjpvdn0?=
 =?us-ascii?Q?vLH02+FdBZX0NIX6VVCxbw4SqDi6Bj144ONUi8Jj8MgGQMDI6UZwt4qLNc0W?=
 =?us-ascii?Q?8KGEYr7vafwDN2Un04nb7aVpDn7rSqicCmHcCjySd3P1nrVwcgSZkhDYXRHn?=
 =?us-ascii?Q?UGa2TpfCLQ1kArpu78LpByvqReDKdh3Hi+vXIBWbLAEbMZYZ37Sb88IS107/?=
 =?us-ascii?Q?RZ8esyxPuABUMTTBynbCAEHnjdI6iZ27lW2/pyZnfhgiJShkTFHAd7JiiBgo?=
 =?us-ascii?Q?KheoTUUB4F4lW6pWyyYpnVHDuTToMo5bKyJ2W1+lOpmtfHuQ/d8aEBQ+tBLg?=
 =?us-ascii?Q?FcYlvT7JlQa+U8eQwv8OdwUHIfFp3/sVoyKCLwm3XI1p/DApuLJWgbmPTv3u?=
 =?us-ascii?Q?adrjicJg/g0Gdk7S3FkzOXpE8FzcYHAnmjqD9Gx0BwB2qj1bQyvUJOeNDb3W?=
 =?us-ascii?Q?McvBAGouDtvOsQSBSIlkSbleJxrbsGW8xqo97bTUwwvuuc3KpG2IOEosIHxb?=
 =?us-ascii?Q?7WGbtZUpEHdJgQ+CsvBGatZepfbvfRaiiQUN5DZHINglBGA3yd+V6SRFHEMR?=
 =?us-ascii?Q?KDdl9ydbBLzEnTMU600i2L5V/m+QjShJra618GuGf3KnD7paIlKTK5mNDNmV?=
 =?us-ascii?Q?igyIkeYFn2Yf2EOJzR2KiXBYflx92tN2SBsZ7stSHZG5k0bLD3TiYJ1lhMtZ?=
 =?us-ascii?Q?oIGIomFyxAAhstnJxOkDRb86DNScOvmfnOR4qoHyDhQcvq8gomU4oP4fEzmG?=
 =?us-ascii?Q?M5KXcgjhQl3DGte/I52pEAJLQotQQNuuNxnnkCHDJltuBgGBgtODJTqaXKos?=
 =?us-ascii?Q?NNc99q5X2liibR7nJ2Ij+VzmYIvQ6TnP5rlR0xrdVVkJOAbTrSZa?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a528b4d-0259-4c23-9dbe-08df369792ef
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:07:54.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGV7tLAslVPaclQWFmqWhr3TmOVVD5k61acGPfqqRxFOK08u2ggJPC5qUeaYPY3NuwmflC8+TlAt3Adk90a3Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2389

From: Frank Li <Frank.Li@nxp.com>

Allow issue_pending() to fill free LL entries while the channel is busy,
then check progress and restart it if it has stopped. Publish requests
in descriptor order.

Multiple descriptors can now have entries in the LL ring. When resetting
the ring after an abort, mark the other descriptors with pending entries
as aborted too, so they cannot be replayed.

On resume, keep an LL channel BUSY while entries remain published,
even if dw_edma_start_transfer() publishes nothing new.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Co-developed-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Reworked v5 patches 18 and 20:
https://lore.kernel.org/r/20260812155721.2807506-19-den@valinux.co.jp/
https://lore.kernel.org/r/20260812155721.2807506-21-den@valinux.co.jp/

 drivers/dma/dw-edma/dw-edma-core.c | 67 +++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 74613c95ae11..3e23d177a579 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -102,8 +102,24 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
 
 static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
 {
+	struct virt_dma_desc *vd, *tmp;
 	u32 i;
 
+	/*
+	 * We cannot tell which pending entries completed before the reset.
+	 * Abort their descriptors to avoid repeating a transfer.
+	 */
+	list_for_each_entry_safe(vd, tmp, &chan->vc.desc_issued, node) {
+		struct dw_edma_desc *desc = vd2dw_edma_desc(vd);
+
+		if (desc->start_burst == desc->done_burst)
+			continue;
+
+		dw_hdma_set_callback_result(vd, DMA_TRANS_ABORTED);
+		list_del(&vd->node);
+		vchan_cookie_complete(vd);
+	}
+
 	chan->ll_head = 0;
 	chan->ll_done = 0;
 	/* Drop stale CB bits before reusing the circular LL ring. */
@@ -259,21 +275,34 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
+	int ret = 0;
 
-	vd = vchan_next_desc(&chan->vc);
-	if (!vd)
-		return 0;
+	if (chan->non_ll) {
+		vd = vchan_next_desc(&chan->vc);
+		if (!vd)
+			return 0;
 
-	desc = vd2dw_edma_desc(vd);
-	if (!desc)
-		return 0;
+		dw_edma_core_start(vd2dw_edma_desc(vd));
+		return 1;
+	}
 
-	if (!chan->non_ll && !chan->ll_valid)
-		dw_edma_core_reset_ll(chan);
+	list_for_each_entry(vd, &chan->vc.desc_issued, node) {
+		if (!dw_edma_core_get_free_num(chan))
+			break;
 
-	dw_edma_core_start(desc);
+		desc = vd2dw_edma_desc(vd);
+		/* Fully published descriptors may still be in flight. */
+		if (desc->start_burst == desc->nburst)
+			continue;
 
-	return 1;
+		if (!chan->ll_valid)
+			dw_edma_core_reset_ll(chan);
+
+		dw_edma_core_start(desc);
+		ret = 1;
+	}
+
+	return ret;
 }
 
 static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
@@ -535,7 +564,8 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
 		err = -EPERM;
 	} else {
 		chan->status = EDMA_ST_BUSY;
-		if (!dw_edma_start_transfer(chan))
+		if (!dw_edma_start_transfer(chan) &&
+		    (chan->non_ll || !dw_edma_ll_pending(chan)))
 			chan->status = EDMA_ST_IDLE;
 		dw_edma_core_ch_maybe_doorbell(chan);
 	}
@@ -580,11 +610,16 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	if (chan->configured && vchan_issue_pending(&chan->vc) &&
-	    chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE) {
-		chan->status = EDMA_ST_BUSY;
-		dw_edma_start_transfer(chan);
-		dw_edma_core_ch_maybe_doorbell(chan);
+	    chan->request == EDMA_REQ_NONE) {
+		if (chan->status == EDMA_ST_IDLE) {
+			chan->status = EDMA_ST_BUSY;
+			dw_edma_start_transfer(chan);
+			dw_edma_core_ch_maybe_doorbell(chan);
+		} else if (!chan->non_ll &&
+			   chan->status == EDMA_ST_BUSY) {
+			dw_edma_start_transfer(chan);
+			dw_edma_ll_advance(chan, false);
+		}
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
-- 
2.54.0

