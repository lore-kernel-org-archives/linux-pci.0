Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793808765;
	b=xGdiF85spdIth0cFOBVwxbX21Be7bwfmIdSzQAUZX0dWCQcK3A87ljVQn9FrbUPgSIRG
	 EOwZnoy47ZWg/r9zdHqEcB8P5HDRESN+5/Wv7tO1VkT7Aq021fukXz+UVLdY2WfVdVsb4
	 OlrsmSIWEgjWHmFMBctM9SKIA0ahn3tQ5fbvaL8GppjvmkI7Rv7Gu9epO5gLoI3Kt31dm
	 FS8XBNfAadvkUMlLt3L7u+Gdvy/8MtQXq80zi+WRZl4deLojK7CnU4gOlFXETSU0ti5uM
	 F9hgaUFdmph28x0ID6LjlNTGfQRcP9Tpzo6k/SREBnO35tTuxuk5wzZtaZsHPTrN0Bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808765;
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
	bh=XbVFjfQZwetk6Qr/1Fwp/ktss3WW9UO6yUjOIRoqzD0=;
	b=XfaTDHPO514Nojd5gOrcRzbX9m6HdWCu8WOLClkB8ehNXMqrF3yUGs1OB8b13UYKp8tU
	 2JfCuNCZKBqb9YLHZKq5nVCZMMd1VPqlTqHeRuHvPO25/HCjEqbLz+hwebPQ0guJkrq8v
	 JEayS7S7OiXizmpxn5AlV51KnBoeTDDgbMm+fp8AiVJ/l73vaukEwfET5gT+VAzjSLvAV
	 iRXrQq78SAFpOKDe+O2MPyaOLiQsV/fihocM0lUGr45wDBWHcIBhZG+eYtp5CoXI4V2fW
	 YfdKxa17vSuPRm4ALw3g1AtfRwld0LHZJQysat0vE7oEw2tKtwHrOwGcnZ2CXeas4zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=tcPp+Iez;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020079.outbound.protection.outlook.com [52.101.228.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A8606A33E;
	Wed,  4 Nov 2026 16:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 289A8606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=tcPp+Iez
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNPImich+z01eR0iNXem8VWmdzIIq0CUdJeQmod9KDwM1QzrA6MXe9xtwBGbO/x8Omu/bLpmL5G9aEGAWpIiw9OBsK50Drvpj0CQu0Ir8Yv1UuQtug4oSnpIqmB/W0FUszONvLuAiNDEne7hPSJY3iA0/esCHrNqhCc8OdSeGAbM88GC+49EI3C6wMBdNEBd2/dhUGE5Z0qb8yHaq2tjTuCo989O7TNoFTxOeoDhjqxgSLkMAqW7Sj+Xa4a6i33kfvJLXX3ebSVq9BL26IAtV2ifKXmd0LSBGsMgLccoo6tO3Kg3eM2YfijilKEZKdZFotLn69b7qZMciE7BAaI/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbVFjfQZwetk6Qr/1Fwp/ktss3WW9UO6yUjOIRoqzD0=;
 b=BqVcqzYYxg2VCZxjsjk9p4CQnm0i1iZMt5jhK0r5zdO62dHubpX0cEQJeNeD04LK0o2oQ3scSw9koVEGc5AVoIbZ7yh6O4VpLQd6Y9I2u30lyZdpIN/QVfLRQhIa43Wix/VCwP0o/rgdJ6HFwb8vFxwC78TsI0I1blgmUsZ3PNYoOslRArEp54hZjIyApBp8MKmxeMRmZyeNRg10aJhzkZAxMBcIapE4Pcl8KV/nKdWbtxfxSF+t0BhURERwvSNOyFhvqAymqCZ4nBxVkg1z6oDwgzh7ks+Wcy007tl2ZWEP1DgXgUrLXYIJ59FIRr8X0tLoN3tXpvcjdAOgbzVAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbVFjfQZwetk6Qr/1Fwp/ktss3WW9UO6yUjOIRoqzD0=;
 b=tcPp+IezvspB42mTiMupKh6kDiJT727tqx/ffzzrlhoHJta+K4lKFh0SB1+TK6Pd48yIhmAN5w9fMS/EMC2Y/I4vh2bC1fI1cHu0FPq10wQufwfR41Du5AT6b0caOf3ZVWu34lLIBNZ78Cuc6rAQXmCljekhwmIKGvjpmPJ8/eo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6678.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:417::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:12:36 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:12:36 +0000
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
Subject: [PATCH v7 3/7] dmaengine: dw-edma: Factor out descriptor completion
Date: Thu,  5 Nov 2026 01:12:23 +0900
Message-ID: <20261104161227.1742005-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104161227.1742005-1-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 60cc4c7d-244b-468d-2895-08df3a8e70ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|56012099006|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+E7t7drpV0NJlR9lhdhAu4YddCIZRH52sf6N6NFsSuxhPgrP1XRXtoHS+fBU35k3DGj/RyutzV03saXnoe38kAfwm8YX/W/E6TDiM5tyXDinCNC83Tkwvklx1jGFOggzR7DflF0so3PIFPwTu5JF7+m0rQHWYT+0Xyz8pbDIMQEIJDfxKT96UcIUc3Ie3YEoSJQSldE0QityI71gbRkiuL71S6l2oa1D5C0wJdVImNKvHGLJVM5i84FK2u0dhWq8Z8cgdz19n2UQQij7nqMj/b1lA4SJxYQOw0QiNZxyjoKjZueUw2zYTJQsfmzzukbSPRUIC/xkm50qpudLq8fnR+lTfJkjd5PKoYU0PtiuW8gBIXdlV8gWSPsBIeQOXaLS0Y8pxJfdGXcKh0ntZ/IqgT3m3GkeL0pDrLicV5r/HFsgKJTVqrzuxxCDqnoS+Tpzr2GvYmRp/muxTtQ51i1WzDQtLyY7zquIxRS0OzfWSnLWlnFtC7OyrmtWx1fZy6k1ZAlTWrTs/AwR8mYnMTvIR3Kzqw2pIOJBs8sqdUwY9tcpze/hMIoLHFM0TyMjG4NCLppbn3suBuPeG51SFdJ9HsXIX4YyToDZDQcE+eM1V2c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TDgFxXtld3Z7olm9KmG9YNnoMv6ZwP4sk9zIjXFlW6vB+Q2C7kXg90x9jW9A?=
 =?us-ascii?Q?VQ6F39goTITlmtsxiHXjexfsgub+zdT/infNSubb/2b9GaOWgFNuyANfKRVj?=
 =?us-ascii?Q?59Ot9sPiXE6Ok6zYJCNWh70e2jGjpsdbmjPfdG4aC2lOQMGNPZYyQ5k6dXO0?=
 =?us-ascii?Q?Pc54RFRrLHiFuy8bQH1XPiQPEMyuTGcSu7Lo5tMiKjqIDHKi/OwLNbE2VbNb?=
 =?us-ascii?Q?lGyyg9KKVL4Fk3ky6AXsaPJJ9eEtyRgi67T5SiBbruEtiIlaMXmItAQUosEi?=
 =?us-ascii?Q?NP+YANTgnljvdMz5BPJVJkypul44kq0r9l6ezW3ICZxVZm1cz7EbOhbB+hu5?=
 =?us-ascii?Q?q0NdSdJd2sHR9cAL8igOmM28++M8BVsbW/SIu1bKrstdpK1XP/RifNWZfONN?=
 =?us-ascii?Q?w2uCS59iSpjDj13Wh0TGW7iJsUDZ29kCaHuBchNnBpnZC+dP3lDZ2R+9O/+h?=
 =?us-ascii?Q?C+XnYwzfx/R4Ljs/Osdaqos214zWAbFEsnN0Vi1Gst6MNfrwFmicjceanx8u?=
 =?us-ascii?Q?Kr9sDAOHFlENJSr9E0D0n5IwzD+8/OntuRn+SEK2v74NV3GFl3irMitRpJTW?=
 =?us-ascii?Q?H0A2zOtajkvcXNUhCgdKu87aoev9MBfR/7fh6Zf97YIzez06YJF56ML5sTRK?=
 =?us-ascii?Q?BFNuMnZ18qskcN/Bx4MtYKCtx63q2maLwTCCeqtE4kTheXnY2q6B/DuudV63?=
 =?us-ascii?Q?cyefvg1a8/GJibniOxUAMUSsEL46Pon4iDtxdBHPfa3llfOf4Kwjlumktnjz?=
 =?us-ascii?Q?UXt/r0J4P+UGCOJoYnNIn3M1Pol1eIBLhKrpsUR163wD/CoDiJhr1MdOaa/w?=
 =?us-ascii?Q?zVIWAf+IehzUR5uUrsf6KqPP+UX/IGRzvT+T7S6rwf0u5HbDUSQWh3IEURJN?=
 =?us-ascii?Q?dluggR4UgedoTelKtsv5qD/Ni+eDRQ8WqchsnGCnMa9B6lY0FH775I9J9dAx?=
 =?us-ascii?Q?8xLVGzdhMlbPiHotb4Q8qxPQektElyS2+VMJbGJ+mXaP45oEE8zEFfvffT83?=
 =?us-ascii?Q?aNQ54R4tqXS3Hc+MWS+SXudwIDh5lRgfutdlStcwecZbqsurpgI8n502KG2f?=
 =?us-ascii?Q?VpEaIWpS6d6a7BBLT557Hf7oRGsavH4HK2NFvo9Ave375Fy5Sze42s4+l/zn?=
 =?us-ascii?Q?7NnBVYUVMO16K8PNoCAbNKb9FMUYyBKvp5YJt6JFI3IJs5yjII51e1ImjS1G?=
 =?us-ascii?Q?SOtbc8T2jDwIghU2HFFL8j3wkeLdTjgRziy5ZKmhm9FnGr/4E7blSHY5PVyS?=
 =?us-ascii?Q?uc9OuXdLv5+qr6O3llwHReMmjndQiDwuGKiCSHCoJdd4JGzhBhh/0noH78uF?=
 =?us-ascii?Q?d5DfYQt5WCsGZg2Vk1NsFYju/YB4qYG5sPTo2nDRjP9VoO3rfhV4cZbszFOW?=
 =?us-ascii?Q?O5nn1ctY3daSnfsWax36MKxUqCVpY72BfsEC+R48n1s0M6uqiCc651mcj8+U?=
 =?us-ascii?Q?cfbSQfDehHTVb+67s41fouaf2AOJhOKyjFO99++gljqxgm3ObMJRfmurxjwl?=
 =?us-ascii?Q?HFQNCZB+4tkc5zlB5K8vSkk4nOU2CB1gKoMR6L7n5wVAJ2jy5HUp4jt6OWO1?=
 =?us-ascii?Q?KF6jWIvhyWeUsuGDo+JOgs6+YN1U50rdXIzlXSK1RbRezS+hlpJ4AUO6BD+S?=
 =?us-ascii?Q?YHS6V6L5AylQaZYOp/Rw2RI0XdWYiW+lbQdwHr1//vGvdCNASOu7pbIyyY5X?=
 =?us-ascii?Q?vXIwHAYa905mtU+o9xu5MWeLamL5EgYNdfzMwZmpF9CqCc7NIMyejQRrGdxU?=
 =?us-ascii?Q?ZmDXXLV5NT1SfVMx5yrDzo9xyvrXjH7A758nQPQgsr8hCJjgdF1+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cc4c7d-244b-468d-2895-08df3a8e70ae
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:12:36.0828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9z0xgNPWLSOkhkt+oPHGl+Cu/IwEZgd0NyL3YcC0SKWcA3n3zbPBdjorMohIoBF2n4qIho29nM5alBdse6pACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6678

Completing a descriptor takes three steps: record the callback result,
unlink it from the issued list and hand it to virt-dma.

Factor them into dw_edma_complete_vdesc() to avoid sprinkling
vchan_cookie_complete() calls throughout the driver.

No functional change.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v6:
  - New patch, per Frank's comment here:
    https://lore.kernel.org/r/auTL2mHwCt20uhII@SMW015318/
    "let vchan_cookie_complete() at one place only".

 drivers/dma/dw-edma/dw-edma-core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index fb38d51037c5..e2f7af5969c6 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -107,6 +107,15 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
 	res->residue = residue;
 }
 
+/* Must be called with vc.lock held. */
+static void dw_edma_complete_vdesc(struct virt_dma_desc *vd,
+				   enum dmaengine_tx_result result)
+{
+	dw_hdma_set_callback_result(vd, result);
+	list_del(&vd->node);
+	vchan_cookie_complete(vd);
+}
+
 static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
 {
 	u32 i;
@@ -788,9 +797,7 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
 
 		desc = vd2dw_edma_desc(vd);
 		if (desc->start_burst >= desc->nburst) {
-			dw_hdma_set_callback_result(vd, DMA_TRANS_NOERROR);
-			list_del(&vd->node);
-			vchan_cookie_complete(vd);
+			dw_edma_complete_vdesc(vd, DMA_TRANS_NOERROR);
 			if (!chan->non_ll)
 				chan->ll_done = chan->ll_head;
 		}
@@ -838,9 +845,7 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 	if (vd && chan->request == EDMA_REQ_STOP) {
 		dw_edma_terminate_all_descs(chan);
 	} else if (vd) {
-		dw_hdma_set_callback_result(vd, DMA_TRANS_ABORTED);
-		list_del(&vd->node);
-		vchan_cookie_complete(vd);
+		dw_edma_complete_vdesc(vd, DMA_TRANS_ABORTED);
 	}
 	if (!chan->non_ll)
 		dw_edma_core_reset_ll(chan);
-- 
2.54.0

