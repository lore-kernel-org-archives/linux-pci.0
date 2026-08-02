Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021099.outbound.protection.outlook.com [40.107.39.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE293AC0D3;
	Sun,  2 Aug 2026 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785670345; cv=fail; b=SclvCulmmU9dqLSYJ8L2VJJpLDv+RxiUAdlII1wrXamctOefvGgsedZQBZbUTkviYggbPYHsp/8tJbxZY9bY+kXfEAMQtS9EK/7Wqc4shbslHo+e7uo4IagEikDXnQwQaLr2h5ao9v9TV7mkvcbb0wnJkkpn3SoaUT3Xg6nCwlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785670345; c=relaxed/simple;
	bh=YBHh5zDfuKytgLi5EOKXvVW8wCPLSMRc2tam8E+4e2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HMsAyS+ZCl360ODm4YQAohLc5QsRYj8JSTlrNEl9jg2AMiQuELGeinRdpcxDiMd6Mw0Kij1OFqcOpWY0hrmZEiZqYgsdGz9PibxUkr5hgTnfTdYCf7OPEsqgOnpAnjIIpuXUU5huR05rmFeKF5oQNgeSAI4+3GcDCXE7iAHV2/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=40.107.39.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKbygtbyjWOF+XvZ9dIFrPRlK8MF7V5jHD3rc/K0ODUSZyUv9ce+sdudcVg+B6E8JTpus1x9xe+Mrj6oO5aBiFq3MDDMUw/VlUhgX5XVUuQh+gOKE2essb0JhyMDXEOKhUhCLyEKXra3ZApUb8jMAoWGD+gjWP+d0fXpBTKTuTfAPYvjg56wGP0pgOET6+GhuVAYKhC405LGTYhQVwPut2tVah3vubeXzqj/PaAJ6x1Ed8pPjatxajdtKh4Kh1BhZvVWfcUBN/t57r9PwV67mH4rY6GymtnF8eVBVABR2PTZrWXiNvukB5DW3D9TjS0Cbua2kD3+mAdSGkx3W8V6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXbNeU0lmDMNmK8jt3N/+pQUXs44kVtcYSH1F6H6qkQ=;
 b=t1arEa9Hhs5aPBCJesio8QN6zJpGBtkgDFcfaxYV83OPMv0DgPvlnMqH1oVkIEaEkAxCxHu7MikwQB9BxeoPZphaO7NovNnM5V23cURXFc4r6V6ctMcDgDDqL/2qv3Br6Rr2X35WMhh3V1BAHOvcSgiIaiXa843jdA1Y/luGnOU/Zt4kI3tPNrrN14yq/cX3JD0W0Kkxpf5mXJTLjVd4Wip4jNujcCR6dp5ENKriTqhHIxbmg9qOOU88zMW/VO++l0egaaMLLZ97SNdeVnPE6t8SfEbC/Vq3HbThv1A4EvAfp6s5sZeqLnC+unkxi/I/3C+x3zqOrXyLx3YyR6Cljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:279::22)
 by SY4P282MB3986.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:197::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 11:32:14 +0000
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd]) by SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 11:32:14 +0000
Date: Sun, 2 Aug 2026 11:32:00 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rudi@heitbaum.com
Subject: [PATCH 2/3] PCI: imx6: Use the external clock as REF_CLK when needed
 for i.MX8MQ
Message-ID: <563f057f26b1147a79392509b35dcb7f18113ba9.1785669457.git.rudi@heitbaum.com>
References: <cover.1785669457.git.rudi@heitbaum.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785669457.git.rudi@heitbaum.com>
X-ClientProxiedBy: MEWP282CA0106.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d4::16) To SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:279::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB4909:EE_|SY4P282MB3986:EE_
X-MS-Office365-Filtering-Correlation-Id: b720945c-2ada-4b7e-a491-08def089b334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OisZAVJGkXVMJ/mOPIshjggejD9HwPRxZMEn4gO5yN7I3vy5edELpLFyxdbxgQwfmUMkGVZPfKV94EaALNXWB3hqCJSIT5R+1qVRePfPHSYEOWECC/dsj6eWvAycSo1/7FlpCeNw/10KsbD9JUlcUb0XTtP6S3fdID7NdHXHPRcWrNuSne19va0Mu97fGlbRIZyBBEhQYZ03jEkvp4buEx1KXjkfY3ml4rQm5o5t96Hg4PzdB9Anj9y7ksRC5pK8CgJKP1LIeaBJRvTIPYTC7e5LNhTqujJidVTKz0qFFepHw+IOvFGsnoZeF7Nwc7FXiHGTYDksVHHlbtiD9Q4N3R05b34sxORkjqzgO2g5DXEBFxhLRS0q1RiwiyojRslDywjUBQUEhTWu5TxJw+arA0NzBdGWx/z0DphSpsTEcihppxyHrOAPusMn5BeTnjJekVUvwXZc3+i4rm0n5pOoFDue7ZxZZhXgbO43kW4NYe2/o6KMeIyuHiNK4rQ2jL0EGR/HMR8bTz0HorgtZmyECtgPF7DY2rO9WAcsk6b4gwBRyV6EBJU7dH/B8cuHLoWIEOus5E/Cr/EDIcr1PF0mrnMgmJC8WFBiugqjEdJ1AEJczZgc4uLU/6/VQQZ6yRZ5sse2nVymcWWlCwRyheaQRMr1TIYxJmq/ykPZrulC/S8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cDyFNLnDXYB5xNcjP5IrGizbiQTxpX2PrNBSapfseTDeuEgiCU6XmU52m+OT?=
 =?us-ascii?Q?V1iGxjX83xjsQV2d0tgfpemUsjWrcQlrb4OUDstvhzs9t6Ux6TKVKoiJv8Pg?=
 =?us-ascii?Q?17Ltp5s9+cDHkuxNU4HO/WkhOijfliBgOXKWC+qFm1N/OefrRi6oOwxqrBfk?=
 =?us-ascii?Q?rGXMdbk7yPFhc+ibr913XP1eT4oTMgrPJzNzUqsOhJFUT9GoggQYcrp3agTL?=
 =?us-ascii?Q?tJsottwkrto/N9aPBu4Eq9l7Nz87RdTGpUvCfiso+NKnsFRcjUde485BCH3y?=
 =?us-ascii?Q?mRRW8Ub2TOw4is4v1LYFu2Zve+i7S+V+4IgSZ/6oVucCiw2O+98a7OO9Xx3f?=
 =?us-ascii?Q?HUbs/LEp9CxWAUpzcMm2Z6WJakaMM7PdYb8iIYwobQHywiuopFPEl3FBH29x?=
 =?us-ascii?Q?dLqqDeQ2aSRMplT0/xzoKPrPKZyj31rsdiEM2i6hSNHQFFFHsA61xlyvw9vt?=
 =?us-ascii?Q?XznlkM2SvnrivH+Dj2Us2xDLegAJRPmC/J7bAifc7gxtV3BoJIhD9A+Akx9G?=
 =?us-ascii?Q?hU3hQ9ArGuEIIGpP60+RhdrhOLTObqaDj9yMCo2Q2G/ih5j8OaLlT6PKn5Lv?=
 =?us-ascii?Q?4kw19MuBzBMluY7FjPnmmUOxKcDpOTc1ENJzSNp5XsXLRuTQDSWD2F+0NmnP?=
 =?us-ascii?Q?ibwH6eV+dWmB1ygRpyXLPjBAoZgwL2OIuDwVoG2QSsWdBJl3LfakhrnzI8yX?=
 =?us-ascii?Q?DE8s/fHSDJQi6Hj0DpsbZlujU+4RYMscJA4Wo99JS7eYQQ9HZahFNFd9QMe7?=
 =?us-ascii?Q?KFFRpUiFCCXVXpU595myrQ6LfiQESbC+SibEjvz1b6vv0o2cI7bt8tgUIuiU?=
 =?us-ascii?Q?494y7/XI7QqXzV+UraGYSpzDM8/gZ5E0UbGOCdJY8WBStGyPhdHkgvpTDGHn?=
 =?us-ascii?Q?b4LNA2W7jNEGZMbJKusA3quCqnRurBiJKySgsDjeWAby07zrwLxtYsGa6NZI?=
 =?us-ascii?Q?Y6DI4mylAVhLfg5YlKt4Vv+whLOPl3H4ROTIhmxwtVx7JCiKI+81wzYaHoUy?=
 =?us-ascii?Q?7bZiukgdBmC6po8MWWkKEiB9Qzi/J/fpEnYb5XqrWV3ht7P4UBqTSqINdGK2?=
 =?us-ascii?Q?WIqt7+qSj8anebYQZ8wTq4bFidDMzvIJEUEE4xC6Imb1fD/UHRiVfU2fWOuk?=
 =?us-ascii?Q?m9NYfbo3d37557WMWwWy5psumjCh4yhy5jn5P1SGsF19kaPCY71ZzS3Nzb3S?=
 =?us-ascii?Q?8GoDusssfBAe67ORtT4cXJBwQJMzOg/FgdBKmxayKGyh/IFEMItcAipDz8Aw?=
 =?us-ascii?Q?/97imzOYRQiMXIYmSA+acp39oH09tEKAetKY9lVz4rgDaEv0R3TwVT6GluSJ?=
 =?us-ascii?Q?pt1VPybogOSZUVYvTPd6Ru2FXlwVcuyAm4rABz7Vms6ZWGaHyzch42+rQfZF?=
 =?us-ascii?Q?/2Cul8R7vP8FigJIQ+mWTdIZw4PC+AzX8BHa4IdbhmGEObtwroKcFtJ8phBT?=
 =?us-ascii?Q?jmSqnMcdaVYTtRLG0OLvvAZ/ffMoyqyPdq+eZPKWxnWX0kIyCPmWyrzZP/IV?=
 =?us-ascii?Q?iYKaHZD04fgxPJ+1HcyJnOFJ1WycK3W8rRfmXNU+DGfqyDALZea7SGu5DrxM?=
 =?us-ascii?Q?qWL5mfPh5F1qlID4Unlo4GVVxmzO5vDdLdHQtR/EGehuyZFjWNGxpGzCbkDf?=
 =?us-ascii?Q?shsOnEUg199yeLxc63Nk5U0Z0HP6SFUQJz1XNXw8SNM0eLZcemW8nwBzrqGj?=
 =?us-ascii?Q?wxtnZga6PZHmS5h5jFDGvq1+fRMMYy3aqIXb2Al693qrQ/H/?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b720945c-2ada-4b7e-a491-08def089b334
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 11:32:14.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTQcyKRowrpkLVdL0LlwkyBmTQtSGKafQnqtcoceatmo9IRRFQ19BhmCdgAx8UKHHk0k/jFtDDoxm7mVYntWuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3986

i.MX8MQ has two PCIe REF_CLK sources: an off-chip oscillator and the
internal PLL. The driver unconditionally selected the oscillator, which
is what the

	/* TODO: This code assumes external oscillator is being used */

comment refers to. Boards wiring an oscillator to the pad describe it as
the "pcie_bus" clock, but nothing in the driver looks that clock up by
name, so it does not select anything.

Reuse the generic enable_ext_refclk flag, set when an "extref" clock is
supplied, to select between the two, as is already done for i.MX95 in
commit d8574ce57d76 ("PCI: imx6: Add external reference clock input mode
support").

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index dcdeba1856f7..5a350b458782 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -445,11 +445,16 @@ static int pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
 
 static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
-	/* TODO: This code assumes external oscillator is being used */
+	bool ext = imx_pcie->enable_ext_refclk;
+
+	/*
+	 * Select the off-chip oscillator as REF_CLK when an "extref" clock is
+	 * supplied, otherwise fall back to the internal PLL.
+	 */
 	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			   imx_pcie_grp_offset(imx_pcie),
 			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
-			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
+			   ext ? IMX8MQ_GPR_PCIE_REF_USE_PAD : 0);
 	/*
 	 * Per the datasheet, the PCIE_VPH is suggested to be 1.8V.  If the
 	 * PCIE_VPH is supplied by 3.3V, the VREG_BYPASS should be cleared
-- 
2.53.0

