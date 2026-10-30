Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793372877;
	b=Fk+F6YbGOyw2jntzTLZVvXII9XBYR5zDwe/LYas1FTwBVo2t58PkU2NdZKAzSmjvsXir
	 iB9os2hMX5/KjUndpEBgubngliz792rAKxR1BKXyt4UstYRhWSgsKBmDVvqYOa+RIaxFu
	 +PihD95+IJCoyCD/pKIB9OKqk+BGnm8mxgaMzJYeN84/EgFCNJfICazgUYkZ+Zt4eF8FJ
	 MU4Ng/1MoYCYD3IOPhZJqQsbKZpVSk9x8HY5lqYoBS7Q0pQj2B8KKqwPWDxwiotIAG7D+
	 KCUvaaiy12m4UPBosBtM3o5uiUfZpQY1ttd69GDo9Y5pd1dkmKqFYrogJBBHo8qvwGQ==
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
	bh=R4+msdmXClDl1SA3QsIX9Wk7OdhDud6Yg5iSbpVKwMo=;
	b=yArwyW1JKf1rFmO5EDV2axvBW2O2qwokPk8wdhCGsuJAtlUPdfTbeWhe1ik7FdAcaFT/
	 5MB93AKmBgaGNWulKxsjHLXPSPDZ7RiEWB8LCmgPLfoozvCDcsNEObYNs2B1Ouy9CUHR8
	 pWbScj//cTYh6IgvBIGEZDCmNKjy+6idCOLT58P8Szyo28CccvivWhF3JtQ1Uxv9ZRqKN
	 7hfOVOqVM6MtFfKufMvnGw5m4OfSaLGPmFtN4KRkQ15/EDQhBnF/jVajIjxYoSYRAmy7o
	 Yyu0dfGrOToFVUx5exhscp2Wthg9U9T5d5xZh04Jcf74jY9ltd49BJJSiSmS4t50nQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=tRqWHK69;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.82
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020082.outbound.protection.outlook.com [52.101.229.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E8606A332;
	Fri, 30 Oct 2026 15:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F6E8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=tRqWHK69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6/KZjX/Vmwx0jA/6xLwf7KXrTQFxhVTiKf+mXebyaK9yyGtAQOETEsX5jf6NA1T6S+kHVSYy0E1vHORcLcuBWE6IFP1KAgsuRBeQZrAJnxfBNT1pXnwWEFwxarHPyuwxHy8QRVyzwPeSDXRpkXS2QU+qu9gzT6ttcCMw8+aXoAonrhuu+6a8UIl8yQrKCHTF548JoNxCG7E0nAEow0At5/cxn434Tg7zmXBUCklzkRqFJG0oaSA7D41T+ugE5LIN5FAMXRjIIXreBOHd7KmmWkH3KoS23IUee+7wXA1QYLWw6AOJCa26edsANMNnrsQjfFBcOZfL0TyMzUz6fSV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4+msdmXClDl1SA3QsIX9Wk7OdhDud6Yg5iSbpVKwMo=;
 b=hr5aGCYq3wOsoItdcTLVG1BjiECe33kPgtIYqu+GqDDwVDNmj25wA7g9EWNzomH3xNniHGH1TYFVutRZfaMXVl0lP9IkaUY4nelr1YA2wvHBjPNG+pG0XcoI/jPar50+H4sP11MxrTkxttVlAwmP7FSFMn62yDi6L1tDusDsKbscp4C/MDNDtac+xkXLzc5fVqg+Wr6ft2gsT0u4tzzJHUaoSHXZtMTyeNwPbrcdWA14ODNdmydCXgPJTIuiyw89CRIFjYAQ97lFlK6cQQafCOofRJnbZskApfXoXortYGghTBcLLwXGi3AedZ1uCoUW62eU1vr3BR1Nty6PIscN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4+msdmXClDl1SA3QsIX9Wk7OdhDud6Yg5iSbpVKwMo=;
 b=tRqWHK690Y0b8bM3il2fZv6VHbJpPjKbWv3dm3pwvyjtSp+1pv990skZbfJNmWxvXDy+qnVum9u0I4L6XJflLPv4BwTK+kYjLRHfEWv5pmtykWuylkY4j18kjrtnq2t+QNi0ZTxvSexzRzQpRZxBaQkBRgHMlspNcZstRfHF34U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB2389.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 15:07:52 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 15:07:52 +0000
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
Subject: [PATCH v6 2/5] dmaengine: dw-edma: Reclaim LL entries from hardware progress
Date: Sat, 31 Oct 2026 00:07:39 +0900
Message-ID: <20261030150742.2586776-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030150742.2586776-1-den@valinux.co.jp>
References: <20261030150742.2586776-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 35e05e75-0c2e-4b34-9936-08df369791e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|5023799004|56012099006|261009223027099003|261026140227099003|261026135527099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	5ooHi8unkVCBcKQaZAHKLHxQWhcMPQ51rvpPwKUZvwJI58QxcsiB9aQdWAyHsShZOOR0pTMTKkuvLGdi2KFK4KAEUTykYhpwwmREvFFi2G8pzut3GE7vnGW7YjMfvvMaGuQ/QkhT7e+iRWt5G1PWknbcwWtt5Zopfs56tm2VhpgPWAhuGm3aB4cGYt9dX410XcAUAzBxlgGsDHhq/UKrtSKfH0FIW+l5vVOUcrW1mq/hG9Az+c3XP9bW7jHXcQphjd0fGkC1YQhN7mwToRCSpIn4y3auPhz/0ImptyMj5dqTsSi/NXDhPuNyk1T/hf3pKQ7Ij3OvmuqlpK+LvmkmnP5B5NDfyywhO28EAB6DnMsjHR45jUCU7GWfW/VXkCCa0LzBCetBemT+JSp+3c/hFUSy5/3gs/wrInUq8Eoh4rVAxA5Mm3YX3Zd+74aDyc1UFZUVE2mCcEfMPfFS00fee7x5/kG9lz5YbypTIzBToGRitBijJaBm9d0wwI0Oe9Whmt32FKHijYExy+jolRmm8iDl/urIi1ly54iXsb+ueBU4TCV8PNtIcRwMbK6HUPzCEfiNp4G8PeyqHGL8/sa7heQ3hLWgk+2sSTOiq2DUsKmj8mfn0eE6GFP20M9GcVuf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(5023799004)(56012099006)(261009223027099003)(261026140227099003)(261026135527099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6NIoSEG++rOmSmXho+WO040l3v3V4MIJG2bGHZTLz/D+qGXvgPlLEvKCCLo?=
 =?us-ascii?Q?2kx/0Vzx8lyc1PYYsq769Z1RIBT1TMOQbsgz0CYPzb7RkC6YheADvOmodarE?=
 =?us-ascii?Q?5wmWs1lhzGluRw1KHyDgokIR0LyZ/YLxIgaNylQErCkyrRC3XMPS+DfV/X2f?=
 =?us-ascii?Q?rJIwV2oVtZJ4bo6uVCpPe5VJ7auh/3x74fkkGLr6sSBNab3a0ThKc7mR79Fx?=
 =?us-ascii?Q?S+4V3NSlxVFlcmyVvk7Q7tiBi+rVh9nF8s+ttP236KeadoskEUasEEcJsyZQ?=
 =?us-ascii?Q?Plo/muLIqmiyAb/TcIBvbgA0MtELD7oVHuHNFDIjKJ0xMS3g1PpuK5g1Bo8P?=
 =?us-ascii?Q?bvMzOkb4YksZsRBLAUCDJ/Qf92QtmZpKjAv9DZNb0S/xiHTBIUqVFSseQD+v?=
 =?us-ascii?Q?SumIqVVC7MhEjonNW+S0PRxZqA15Z+seNn8vqTZYx8frs2Pc/4NBUlBb7/fh?=
 =?us-ascii?Q?CG+Rz0EAACOtJrqVEfNKhZjQcQtaE9+6Lla9zr5cuelS6IbmptTwAD18aHn5?=
 =?us-ascii?Q?EKJc+CRCMM/mAw7pu7S97jXr45+dvNWKBeV39rzyFDBv9cBJNg85EVqVDP6Z?=
 =?us-ascii?Q?LXMBnVuBgUQ2FMtRCXw288bM5RVhffxgm/Xzn9/gGP/LrYNfU7/ACOs7ASmS?=
 =?us-ascii?Q?w+Jd2aCamiEhOa8EwPb2L/I2ecTpRJmjp8aDLhZuwJCycp8tClqOUEHk4z3t?=
 =?us-ascii?Q?xOs7ZalWtfH9liBecAMZ9Se+rLpFlzz6EKnu6O5qYCtw+WH9ImCuBg9ij4F2?=
 =?us-ascii?Q?+lK+7R5EuWscLjXjQTdurS8ScHcsCy7bs/L++dV5fowKVGDM+KWaA3CO876x?=
 =?us-ascii?Q?jt6rM2hsU3Jt+lKQS5t28KqN4xpLzMf2iiiZEYiRNG7VmbY0gZLe7dUaeA/v?=
 =?us-ascii?Q?QgOckQ8beVQfqLzvXxOO87CtPyPRLjZtqZBCCQpneH2NG/14aRbvmJy4GvLz?=
 =?us-ascii?Q?cJD6C6C8DdF1H7wLnukOHHd0YwppAyDRH08siS5Yb4ihZ5F7ivpc0lQ+bPMT?=
 =?us-ascii?Q?tRtv6o2A4SDgguVTwLgupyiTw562N0lh5i3wuhl6DONcVrySdD9X7RfnO9k8?=
 =?us-ascii?Q?u7n7BpH6mDWKc//ISnDXuQ0wpWCG+5E9aJaK3uEa0vTGonErLxsY5+WbbvHZ?=
 =?us-ascii?Q?RHZzN/xn9tW2iJ0Nnj6hFGxOExYH2SZjv6h5G1MGSED8hFosuUkgihsbd9Y6?=
 =?us-ascii?Q?DjH2ZOP+4KirZEUx8p1Y5+Qlj87qWewrwtVCFUTyhEL9/jtnqPjNtpVaJynA?=
 =?us-ascii?Q?rnsPTay0fPk7veQUkJz7qZIryaLJRUodjeroqaeRKPGxJYwMp6dKpCxWNF4o?=
 =?us-ascii?Q?VLAu5FPiVqiJ5HrIg70JfFoJJK2Er1/7eM7x6RZ3a222aCDg4J1cLpoEuiBt?=
 =?us-ascii?Q?KStcNs9N9htW3Hc3RVU+UXMXhjwpNbNL3fsn9rzUdWt1lPRTjIrZmTzRp8VS?=
 =?us-ascii?Q?qouv9z4zxVVEiOETfBqcTl3dC+BcNHd4PuDMCNeMhM72QbmfE+XJ2cAfdZhP?=
 =?us-ascii?Q?eFUSxktfsIMDYLr1FbEKQX6EbVxxZcWb7QldK8sFUs2NBBPls4hyDItJTaN9?=
 =?us-ascii?Q?IMR3hXlj3hcX0fa1hWjKUNuH1JG1Rwf216zhjC6yEWSqoLWbhdrlvDHoTSez?=
 =?us-ascii?Q?ku98MI/8aKqpd5ZpfK9fxoLbOI9l8WWkfm/JlLILNN5UdL8/M8MM6YtNhzFb?=
 =?us-ascii?Q?QEUJ3Vy/ySkfnKcqnSdngEY6D1iflTmcxLsS9KE3OEqDzN/bC5ZK9A75gpRK?=
 =?us-ascii?Q?HoAtV5KpV4/T4hfJIkFvIcvEmTt85ulZAg8lHacZAdyvUv00lUQp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e05e75-0c2e-4b34-9936-08df369791e3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:07:52.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c92/+7a7QQtV+c5B+lu2OdkXMWA3UmSYCmBYqBTMKv5+SeeWiolC19KRbKG0KJvZOVkLFP0CGh/iAmEclt7/Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2389

Once requests are appended while the channel runs, a DONE interrupt no
longer means that all published entries have completed.

Use DMA_LLP to advance ll_done and complete descriptors in issue order.
Reclaim entries as they complete so descriptors larger than the ring
can be submitted in batches.

DMA_LLP may advance before payload completion, so keep the running
completion boundary one entry behind it. Use DMA_LLP itself once the
channel is stopped with a zero transfer size. Hold vc.lock to serialize
progress with ring resets and doorbells.

Refill reclaimed entries and restart a stopped channel if work remains.
Defer STOP and PAUSE completion until the channel stops.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Reworked v5 patch 13:
https://lore.kernel.org/r/20260812155721.2807506-14-den@valinux.co.jp/

Changes since v5:
  - Read the registers in the progress handler instead of retaining an
    IRQ-paired LLP snapshot.
  - Allow index 0 to wrap. Reject running samples that would reclaim all
    pending entries, so an unchanged start pointer cannot look like a
    full lap.

 drivers/dma/dw-edma/dw-edma-core.c | 140 ++++++++++++++++++++++++++---
 1 file changed, 126 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b08bb31657c9..74613c95ae11 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -53,13 +53,6 @@ dw_edma_alloc_desc(struct dw_edma_chan *chan, size_t nburst)
 {
 	struct dw_edma_desc *desc;
 
-	/*
-	 * For now, a descriptor that does not fit would stall the channel
-	 * forever: reject it up front.
-	 */
-	if (!chan->non_ll && nburst > chan->ll_max - 1)
-		return NULL;
-
 	desc = kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);
 	if (unlikely(!desc))
 		return NULL;
@@ -146,6 +139,76 @@ static bool dw_edma_ll_pending(struct dw_edma_chan *chan)
 	return chan->ll_head != chan->ll_done;
 }
 
+static bool dw_edma_ll_stopped(struct dw_edma_chan *chan)
+{
+	return dw_edma_core_ch_status(chan) == DMA_COMPLETE &&
+	       !dw_edma_core_ch_transfer_size(chan);
+}
+
+/* Return the first entry we cannot reclaim yet. */
+static int dw_edma_ll_boundary(struct dw_edma_chan *chan, int idx,
+			       bool stopped)
+{
+	if (idx < 0 || (u32)idx > chan->ll_max)
+		return -EINVAL;
+
+	/* After a stop, LLP points past the completed entries. */
+	if (stopped)
+		return idx == chan->ll_max ? 0 : idx;
+
+	/*
+	 * DMA_LLP can advance before payload completion. Keep the boundary
+	 * one entry behind it, wrapping at the start of the ring.
+	 */
+	return idx ? idx - 1 : chan->ll_max - 1;
+}
+
+/* Must be called with vc.lock held. */
+static void dw_edma_ll_consume(struct dw_edma_chan *chan, int idx,
+			       bool stopped)
+{
+	struct virt_dma_desc *vd, *_vd;
+	u32 done, used;
+
+	idx = dw_edma_ll_boundary(chan, idx, stopped);
+	if (idx < 0)
+		return;
+
+	done = dw_edma_core_get_ll_dist(chan, chan->ll_done, idx);
+	used = dw_edma_core_get_used_num(chan);
+
+	/*
+	 * LLP may still point to the first pending entry. Subtracting one
+	 * can wrap the index and falsely mark all pending entries complete.
+	 * Reclaim them all only after the channel has stopped.
+	 */
+	if (!done || done > used || (!stopped && done == used))
+		return;
+
+	chan->ll_done = idx;
+
+	/* Match reclaimed entries to descriptors in issue order. */
+	list_for_each_entry_safe(vd, _vd, &chan->vc.desc_issued, node) {
+		struct dw_edma_desc *desc = vd2dw_edma_desc(vd);
+		u32 consumed = min_t(u32, done,
+				     desc->start_burst - desc->done_burst);
+
+		if (!consumed)
+			break;
+
+		desc->done_burst += consumed;
+		done -= consumed;
+		if (desc->done_burst != desc->nburst)
+			break;
+
+		dw_hdma_set_callback_result(vd, DMA_TRANS_NOERROR);
+		list_del(&vd->node);
+		vchan_cookie_complete(vd);
+	}
+
+	WARN_ON_ONCE(done);
+}
+
 static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chan *chan = desc->chan;
@@ -174,7 +237,6 @@ static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
 		}
 	}
 
-	desc->done_burst = desc->start_burst;
 	desc->start_burst = i;
 }
 
@@ -283,6 +345,45 @@ static void dw_edma_core_ch_maybe_doorbell(struct dw_edma_chan *chan)
 	dw_edma_core_ch_doorbell(chan);
 }
 
+/*
+ * Must be called with vc.lock held.
+ *
+ * HDMA does not update LLP continuously. Only use it to track running
+ * transfers when handling an interrupt.
+ */
+static void dw_edma_ll_advance(struct dw_edma_chan *chan, bool event)
+{
+	bool stopped = dw_edma_ll_stopped(chan);
+
+	if (stopped || event)
+		dw_edma_ll_consume(chan, dw_edma_core_ll_cur_idx(chan),
+				   stopped);
+
+	if (chan->request != EDMA_REQ_NONE) {
+		/* Wait for the channel to stop before completing STOP or PAUSE. */
+		if (!stopped)
+			return;
+
+		if (chan->request == EDMA_REQ_STOP) {
+			dw_edma_finish_termination(chan);
+		} else if (chan->request == EDMA_REQ_PAUSE) {
+			dw_edma_set_request(chan, EDMA_REQ_NONE);
+			chan->status = EDMA_ST_PAUSE;
+		}
+		return;
+	}
+
+	dw_edma_start_transfer(chan);
+	if (!dw_edma_ll_pending(chan)) {
+		chan->status = EDMA_ST_IDLE;
+		return;
+	}
+
+	chan->status = EDMA_ST_BUSY;
+	if (stopped)
+		dw_edma_core_ch_doorbell(chan);
+}
+
 static void dw_edma_device_caps(struct dma_chan *dchan,
 				struct dma_slave_caps *caps)
 {
@@ -749,7 +850,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
-/* Must be called with vc.lock held. */
+/* Non-LL completion; vc.lock must be held. */
 static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
@@ -772,8 +873,6 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
 			dw_hdma_set_callback_result(vd, DMA_TRANS_NOERROR);
 			list_del(&vd->node);
 			vchan_cookie_complete(vd);
-			if (!chan->non_ll)
-				chan->ll_done = chan->ll_head;
 		}
 
 		if (chan->request == EDMA_REQ_PAUSE) {
@@ -796,7 +895,6 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
 	default:
 		break;
 	}
-	dw_edma_core_ch_maybe_doorbell(chan);
 }
 
 static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
@@ -808,6 +906,16 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
+static void dw_edma_ll_interrupt(struct dw_edma_chan *chan)
+{
+	guard(spinlock_irqsave)(&chan->vc.lock);
+
+	if (chan->status == EDMA_ST_PAUSE)
+		return;
+
+	dw_edma_ll_advance(chan, true);
+}
+
 static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 {
 	struct virt_dma_desc *vd;
@@ -838,8 +946,12 @@ static void dw_edma_irq_work(struct work_struct *work)
 	do {
 		events = atomic_xchg(&chan->irq_pending, 0);
 
-		if (events & DW_EDMA_DEFERRED_DONE)
-			dw_edma_done_interrupt(chan);
+		if (events & DW_EDMA_DEFERRED_DONE) {
+			if (chan->non_ll)
+				dw_edma_done_interrupt(chan);
+			else
+				dw_edma_ll_interrupt(chan);
+		}
 		if (events & DW_EDMA_DEFERRED_ABORT)
 			dw_edma_abort_interrupt(chan);
 	} while (atomic_read(&chan->irq_pending));
-- 
2.54.0

