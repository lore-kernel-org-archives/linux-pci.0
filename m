Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556589;
	b=uw+znbxy/Nyhk+/e7GTgS+I31jDg8KzKCklBqwolH0mGQlW2S95wJDj3buRrezIGPe+D
	 D54z+3T1g+3yA3DxT0aU2FgPJisnrywZHovUlGVTpOWUQNtlofDIThFcsFE5Nq+f21lyq
	 LWXLOifq9qcVnNlx1ywJILm+ojreJpekm0hB5Tt3Krdyst6yJBTWAH8ESrzp1Ian1WVKU
	 2i0HdwXvBETCAUSs/wHA7atvtY7KUACDeqqI/pMapNWzvX6Pc75OmqTdhSvppXo8I+R8m
	 sWjSZm67BgBcLDoKymau1ab+QFSc9DFOzARwD3VfXqgCmzMnmFTElaTFDFW6CUhLkeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556589;
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
	bh=Z0OdunVhjo0g0gb2rB/RiM0HInzGlY9XUYYNswrlREY=;
	b=CRwy5vNU9IGeSkgvFmjU1Mc4NzxL0uJFNYWX04biUSG+T0szkLWcIdy66sBGmM8izHVc
	 cD/fgF54smNcWIK7ipBDBqQMJrEYCcytguu28Qq5rvpCDymJdahnTeHN8eOFM+J8AQrKc
	 Q5kZhMJHmnDZXIWlhkaljNzL50Kq8BbEyg2Pt7dJ51EhrruMp08O/hqamBvTeC92+CViR
	 vaMX7rEDIX3W44YOuyosf2CGwCJCVHrzSTOOtvYRfTNlNxLVuAa9BayxLtd0nRNlrrQUC
	 lT9hM8Z6g1fJ7DYIunC8jk2lojtEDiRHp44AUuwFU5X0WrH0jDWb5h2V75Or1FQUqkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=LCMZHy0V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.72
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D32606A332;
	Wed, 21 Oct 2026 04:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31D32606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=LCMZHy0V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ff3Q3DuHEr4TLtqLN3dPcIn06jsz4NsLflCl5INJiYRgDLZKP7RMdlzBULclHHtLYrwbfUI8+7OAgG2mdOStdTZM8O68JDZ/BICMzRjLZXr7v0A1/nWs7ZT9xtOnveWE8oNGgL3k75v/5Gv+mfSgnF0oIkSYGSR5cuAGhDegbG/vJDJluM3sHxcSx1NXMZDQ3GSMSqsw2nVYNFBfbSK9PqY/6gxLerEyufobCHWabeOQxPOHmqepGJokowQmp5dVF/913mkmaqnOq2CrKaH4cNSoOL9sVaZxj9VkZWDfwCQ/Q6qezx4s6X1/LrLOOjxn1Pz/wXCfbbIxmAkkCqlQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0OdunVhjo0g0gb2rB/RiM0HInzGlY9XUYYNswrlREY=;
 b=HAEZwm6QCj3RN7wdXFBqVQ+QYh9k+X8/phGMVDeKptIoICnCRxZjp9z3VsxR6RLZOsnGE6ZrQ6IyufrLr2Cbf7IQIOyJTdy4cYWNYClb+uOoL6SYaB5YsYBtrGNdAVmNoT5lnmPouVdRc4cCQD5hweLiyz91u9a69E4bY8CBZaEBSHUoSoqrnoi4s4AmatgpHC5m94deRMgxoY5j3bK65c/zH0q1A94Pd5c0lOXwrvkxdz8kXmAIItZNBabTO2wTuMWfagTtvXt0HWwxlfPLSdl3aCMUtkNVOkniyK+5uPwYNiJk0HUkNxXFvJDKz/keo8f5ZQC9ajuG0QzSDeFCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0OdunVhjo0g0gb2rB/RiM0HInzGlY9XUYYNswrlREY=;
 b=LCMZHy0VOheZmVtdQVFqos80RiEy5bG0c5Qn7CjB3E4Aaw4XlbguH29YRVlZl4BpCMBwzNSDhgnJVgGt+Pkv02fFhri4y5OBIUlEkIqcsZcS9sbb94Gewy4MHpBGastR+l8RzOXZOmOGFdFrVe2XcqiCF5FzSfvwsXpaFr2lzRY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB3180.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:22:45 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 04:22:45 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v7 10/10] NTB: ntb_hw_epf: Support DMA and MW sharing a BAR
Date: Wed, 21 Oct 2026 13:22:29 +0900
Message-ID: <20261021042229.2280937-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021042229.2280937-1-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0246.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB3180:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3ac7cb-1a19-4dc4-79da-08df2f2af4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	gJszIBMMfzG5Jr1gqeK/28PlYp1AQr8b5zWrWoRod5+GD1DJOHbBN07nhzBtOAH2DxZkIUOVB0fEp1ElFgVhLRMh/Xb9RnyoyxTASkXBC/1S1fVelk57NsNFRY3RtubBjm+XUGIPDFtPfvSnVrpAnK3Ty3fTnHnI7W0jnOogmzMF9wM2uHzenDD4X47ZD/XGKCzFosyKfNwmJtp5qs8BQ5bFwJAwdKKnViKF5jyxypktsK855v3VkcM/X/fa/LRyrbMS97Cpfxf+n8QG2Lg4bP01DJSb1sOzsxHT/40RQ89ZX8wyA9PAeDt9HMiK6xGwNJbB9LTzdXO4D9dp5Mow0z+BOsVo/wPSW97dFXsW9y9ko6FUqstD9g4VMOk4exGpn55jTYE8k4DGxUxijXPWDMOc4VFHKZWfPlQ4iGEC4yOgZ2ugZRFTBdzjOCBHHooPfj5QcdGEnZ2miBhBn4yRBlM6wPdWDmADMQOI4eYWb8S2vlIjIPfo4yX3kjHo6AYkZVATXNU+Iaptw8o89S7eTgUCcdYoIfquOLeD+NIOBgkbkAmZwivE9bsRYQkx11svu62Cb1EbAtGlrCFP+MVjaRA4xuaNWykgIvze2hgAdN+yQiqAsi6rNsc4Q4elzYx2Ni40NXh9JWv2VL5FRE9EMJIVMIQywaSL08633HfhGAM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A9N5KEW+Pui99us+iSfZjk79lOoe8WKaOLINE0LeY5U+SNX8lo8xeS19+uc2?=
 =?us-ascii?Q?j4FmJ3O/lAUw9PJwm+rGCG9MxJIk1Hm5k/Ne5qVz0ApUmRe7C8yNuDWMU5Jx?=
 =?us-ascii?Q?gxDwwN3WPFpwMNY0hrsE4JvgjJPCxkOY3i7bSZSzSU4fD2juIcRUYmaj3J4b?=
 =?us-ascii?Q?MSh07vZSBYHzs4y5vgNqptuiJwV1qvrMjEhEZ8C6umocwqh6O91jNktZKgZL?=
 =?us-ascii?Q?7Rtu8jKxhHm0TF+Te/opkGLUioZAkTVeUs/vH71C6+ExzKSW8EbWBMZ2ym6s?=
 =?us-ascii?Q?wDkYN1F+e7Mt5iaCve92rUGSAN3Xq4urW/+zcn/Zrbq5D710/zq1aZ1BngYE?=
 =?us-ascii?Q?VQ6X/X4KUFpvleA1XyFKpk+DYT1NFXCWV4BmqZ3zcf/6NNxfE5kUqq/iZHEq?=
 =?us-ascii?Q?/LpBBhpGelxVABCCfgjj6pFY/NNaKS7vuV6VZrK6YoQd9bMl/bHfmXCu5mZ6?=
 =?us-ascii?Q?ibqOdaFvqPZ4qJ89f52bFvxeFu/lv/nD1S/SrEgKzFRjFWq/ps4sUbb2smvQ?=
 =?us-ascii?Q?LQLgwjxv2xwkBTNz+Imnr6tXQqMdMKN+lDM+oV1KPy4zJo2XXIslGJffTDCq?=
 =?us-ascii?Q?blCX3twsu/AykuHJpedGo1yyyDaFxt/kgqx/gk7XPLsxikaB65pCX/VGjTU9?=
 =?us-ascii?Q?ISApFwSbHkqDAqNYlyiiyeTQYch6kXji5FzQarhRLYMR29QQh4twnhOsrCk3?=
 =?us-ascii?Q?zzHcsLh/E5/jSGIz0kgWjK5GBAXUgRVPw5wMTcWNeuqeDZiQmPxYoiFFSlIR?=
 =?us-ascii?Q?qHg4uvr+IFIx5KP8i7eS5JsEARPOFVSwZ3hI6TmaUTY7Iv3xaNAnNSFLQFCu?=
 =?us-ascii?Q?CjB0QJUkeEgQbL0Din/F7WXGMLzxU82n9Lpko8jrs5AJRAu664PRNnTpM6Vc?=
 =?us-ascii?Q?wG8VpUq6kVteGN8iT3ktp70pY8G5kilNwxk9g/kkIXhM7ZySEMqIKqTew0YJ?=
 =?us-ascii?Q?5xpChnzQvMDsasESizk4VcpQjC2C/y5yb/t4tpV9baoWuMgfhgV5W3o/In24?=
 =?us-ascii?Q?vw2iJJ8h3dVqr6evDta/cpMn2lsJbHPrwJDmEJp06OqpaEURkB1WKBlF9RBx?=
 =?us-ascii?Q?8+wx302udhdxK4441piyaMjINwGgVqItzkH4m0ChmYDgcFeOu2XuIWdlyLXZ?=
 =?us-ascii?Q?sOuzFgNkTqtUOQ8IlOa7KAoAdSzeWRPLJT7Gj9bHi+V03rKXGyrAd/zeoNCo?=
 =?us-ascii?Q?P7qn+RpexsTnzu7ekbJrHq15f5KJBORRWY6L4pGs1si4Puriw+xjogGfMXD9?=
 =?us-ascii?Q?R6pjOkKWNtUnMNyHiHi/KlZ6w4okGPP9tskwjRWLTF7QnhNSwPuO4c+Qo9jG?=
 =?us-ascii?Q?OJE4i3coE6HBPDsEtfVTa3klK63eVdNIK9Ex3YQnvvP79npmlk/cZN0E1aCq?=
 =?us-ascii?Q?9LWpLeXUDc39iLyzq5dOMkntWsnX47njuD7T46ENiPa/6/4lrkCZ0FZ8XSIV?=
 =?us-ascii?Q?OsyW3Uxblov/qcdckSG4OKX3mjZ4B6m/YTZMZJlONKv3UwEJN5u7ceczc/8o?=
 =?us-ascii?Q?T5+sLgWDiOu+ueHEyDVoCXqYfU+ldNYlebADdxosiRYmSXO/7pN3hQzmOQgg?=
 =?us-ascii?Q?oNJcNHFNp15x9ecpzfPgCh4Ne7A2PK/RJdaHsht9TklnO5u1u8AILb6Weq3X?=
 =?us-ascii?Q?y6pWuzDApQJNHu9HgXQoDYVM8iYchvsEM232i9Qv12086ho5Ithdcb9blYW6?=
 =?us-ascii?Q?g2GBPXv9sqTyOiXRsybd6+uzcHWs+PvuEy2FcoAm0QDcnu8Tp6jTT+EsSjJP?=
 =?us-ascii?Q?7SDUKWBeJ+jbiBXI1kqy+pxKrONoFqBZI7PL5esX3D8SNXKkkIGl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3ac7cb-1a19-4dc4-79da-08df2f2af4f7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:22:45.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: feD5RibjDRhyIdFQrjrbjvbJENC1qN4TxCRl2X5F0/8t4zXfXVSxU8WjtudAmIKFldPQ+uQb/4pHQOro4J0Xyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3180

A vNTB endpoint can place DMA resources after an MW in the same BAR.
Limit the MW to the advertised boundary so clients cannot overwrite
those resources.

Advertise this support in LINK_UP, including when DMA is unavailable.
Older endpoints ignore the argument.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v6:
  - Split from the BAR-sharing patch. (Frank)
  - Advertise MW/DMA BAR boundary support in LINK_UP.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 46 +++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index e0016128b95c..56185870cba9 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -382,6 +382,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 	return ndev->barno_map[BAR_MW1 + idx];
 }
 
+static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
+{
+	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset)) : 0;
+}
+
+static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
+{
+	resource_size_t end;
+
+	end = pci_resource_len(ndev->ntb.pdev, bar);
+	/* The DMA submap offset marks the end of an MW sharing this BAR. */
+	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
+		end = min(end, ndev->dma.submap.offset);
+
+	return end;
+}
+
 static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
@@ -420,7 +437,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
+		*size_max = ntb_epf_mw_size(ndev, bar);
 
 	return 0;
 }
@@ -524,7 +541,8 @@ static int ntb_epf_link_enable(struct ntb_dev *ntb,
 	struct device *dev = ndev->dev;
 	int ret;
 
-	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP, 0);
+	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP,
+				   EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
 	if (ret) {
 		dev_err(dev, "Fail to enable link\n");
 		return ret;
@@ -707,7 +725,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	if (bar < 0)
 		return bar;
 
-	mw_size = pci_resource_len(ntb->pdev, bar);
+	mw_size = ntb_epf_mw_size(ndev, bar);
 
 	if (size > mw_size) {
 		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
@@ -739,21 +757,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 				    phys_addr_t *base, resource_size_t *size)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 offset = 0;
+	resource_size_t offset;
 	int bar;
 
-	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
-
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
 
+	offset = ntb_epf_mw_offset(ndev, idx);
+
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
 
 	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+		*size = ntb_epf_mw_size(ndev, bar) - offset;
 
 	return 0;
 }
@@ -851,6 +868,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 {
 	struct device *dev = ndev->dev;
 	int ret;
+	int i;
 
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
 	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
@@ -862,6 +880,18 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 		dev_err(dev, "Invalid endpoint DMA layout\n");
 		return ret;
 	}
+	if (ndev->dma.submap.size) {
+		for (i = 0; i < ndev->mw_count; i++) {
+			int bar = ntb_epf_mw_to_bar(ndev, i);
+
+			if (bar == ndev->dma.submap.bar &&
+			    ntb_epf_mw_size(ndev, bar) <=
+			    ntb_epf_mw_offset(ndev, i)) {
+				dev_err(dev, "Invalid DMA/MW boundary\n");
+				return -EINVAL;
+			}
+		}
+	}
 
 	/* One Link interrupt and rest doorbell interrupt */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
-- 
2.54.0

