Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64D2E738C;
	Tue, 30 Jun 2026 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799521; cv=fail; b=fpwfiboLoaoc9hwy2wkvwVPIF+HZkE5qLWqspRCCecCxqn3meTBGDkFNYWW5uBhi+o7oa+Km9/4Fd5GMKsNOFK4V54wVtZAW5TXFtCcKSUrC1Up1K+2Y5RvUFbx0bUXxHbpUiOgPoV2WY35k8JJmjakCvq5ITlQwg2YghxJG9go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799521; c=relaxed/simple;
	bh=Xw8NkLrcUn6zKscFVqjqGeRFZdGCZzQNAsviJXMm0hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SbJPPs96k/AgO2aoNuUfrkXAVe28L0AQfmEjg6eY4oHGCMgmHovWumJMpjtT2Ljy/Js8EZW6bZMozmyQmcGtj40k5+2JIpL+tERi7DKzJdTOQBoQmPyXsny6SCTt24WnAnbVGi7Fe4XnTOKeVbaEyZnUPYcMQTPNkplzyHUlPUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qAEBwoCP; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qAEBwoCP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWa/sPJwZq4FyxTErrjVoqc5JQBxLERwSj++ZYNL/YyeeoOfvlILg2hsEoDP7jsNF/k1reBtkb2c1uLTfiTDtpB17AGZ3LKKVkx/PBno5cvrceTgAJlOTOh3+0mzDmzPUEM4QQmQNhcNQly3P9A/q45DxvF/Zoa3pHQFtOqxZQkqlYZC9HJ5Ybqvuh3YsRciCM9xxisOZSm3EggR6MGXD+RVp9dnDs0dRpps2y/4xsBmDVDYNrnKMXJPZ+AH67DgautivFQz34sCKp5rcrvJE/MjndO5BQ7AvKoJJgavGQZcjNa+vc6YTKF+vaVeAnMdu2fcK8fIp73C/8SqBiLNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEr4IgiCsvBIzjM04sTy2sQBbiqaB+sK0S+KHOrRLJ4=;
 b=JPItoH0HU4AGDUlW4BqkxlswKDgFlrvYh5o0t6xMG7c/DBenXa/PmsAeBXNGD3lw6QZtXCg0qfOfj/Qz6dGbVCdxxyI9lHWr8DDljOV5TjgvNwlcN4rIxYZlQngTIkzLf4SCKQkz9E6VLBlukUPYjkQJSUPWQWPeKX9vb2M4Ncor6lDf2ViXsIkHIVyl6+2PAK7awA8Jn1kal54KrzYp0W0ocLTV2nZ9ZNvJ6e4Xnm7HR+AAuSMkQvR8JAzAKZKiqRAVvNvnyRH/N49+AzKpf12PKybbGqXQyRFbb9sB3ANorz8bdPpvZzHkmY4SiOH+5OXacD1phmpWI2W7M4Ry4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEr4IgiCsvBIzjM04sTy2sQBbiqaB+sK0S+KHOrRLJ4=;
 b=qAEBwoCPHFe/XXD1RbQwTVA6xeRjBOb6ZP9oWumZR/9ki93g/7cGj7yzdt7ZFUuzrhWDIe4szppWCmtLgS8/Ypn3Zzt5TTMzIxamvjDb/VyUy9ke83RZimWPc2c8/5moMyQ9460zyTMjFjJgmBruF0Fd1DG5iKluh3wNLC3Bc7qQm+0efN6WX+bGEh9nu9nom6eaTM1CL3RFh0LK3tBtkbFIrK5nPj2IfKhXe6f6uKygkUQ8sGrLnwH3WjAZzmynnAtK0jYKZFQvogX6ePPYakYLDV9sCGOo8RFGnZEzBtTiSFkolD2+WpeHNckWDyMEjJshK3yFuwdAyBgzqd7g/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM9PR04MB8748.eurprd04.prod.outlook.com (2603:10a6:20b:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:05:17 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:05:17 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V4 4/7] arm64: dts: imx8mp-evk: Move power supply properties to Root Port node
Date: Tue, 30 Jun 2026 14:07:07 +0800
Message-ID: <20260630060710.3294811-5-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM9PR04MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d26aa3a-af06-473d-123e-08ded66d8ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|19092799006|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	jB4n0B87CvyYO6Cz4dUA63gkicyidpoLPNa3sWg6o60mZ2yxPtlf33Df3wFPfAp3GFD2wVgAoxGWOyRnc6WC+XAtPoBCX/Vw7VGmoVcIZCKDFXPPJbpK4tx6IwycYumysrtmC/gmYvor0JJfO/2qWJ2EywQapJbqZmUMOuI43WLlCF3JAPO+AnRN3Qem00Y1hS3onZPFpDqeFqoy/LDWkeGWJDmMvRxCuUp5CJekP2lpYWbZR42eLQWoebarw4uSIMH7AuT3CR+dV4wxEAy2SVIbAev8kDByobWVN5Ao/sGxZqlDj3wDjiLghq3dtsqGlMwKN/ISOJpo90MYX5EzkERGlS/5b25sgM0WJ2cNgya1JhQetfziGscHQsE/N2BmZwxWTzOJ7WjTNVzEZtrrdd0aOB8IJAydXfVNo8mmIoZo84f3gR4Z8hji7sFR6xbih9WZX0c5uLIFdM7v5NhkHPXS6PqRcXpT5YGZyi9+LnMEd1kC066VmLkRHdn8FxSIOAeIzBuIkNjtnGnGkKedgSNV+Dm33LnVpHIm6pHtMzgGVVfuKKFCKHqu6rzbCVgnBwuYXOHzXvjizdPDd0h28akGEWEYVnrS7/4IGRHcoN2/njXav5ILr+EIuc2OEsVUOGHLoPiVyHO49VpgJ5h+Txve4nxwKYBFBttZfA7zWurr6Cd/s5kiEoSlz3Qtf7fphKJKcqYdsijkAzu16mcBGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rruoEHAIP5nRduTkJnoWTdnO/7XZJINWKHsBZYb4XjXMBb3euCMxK0k66HJ1?=
 =?us-ascii?Q?iIH8BQhr7q28y5srvQmO+wYd4joK5beBPwk66oXRlOXJyGUEIFmRT+2lqTq3?=
 =?us-ascii?Q?Inf3w1D+KF5fd8jRh305Ez9022CxkwXfkvIEP8mO6Cp49QEoJphx5dakZGuN?=
 =?us-ascii?Q?g7AmhNgePD6zhQ/zaLSYSbeqjD5aJqirHCxOxw2mo0UHHSWzmvkwGUXsmnEC?=
 =?us-ascii?Q?udaKL/bh76+lB9Nhf7DpZo6i5bFtElco8ehIfmp02u1I7ormd8Wl/Qwo1nFV?=
 =?us-ascii?Q?BI0uQiCBxBLxHdzY2RXpVzR1JQkTc0HHoK8OsQNe+rnsFnxbDb+1tJRk+HzN?=
 =?us-ascii?Q?koZE/M6EWWYXA6gpd8xbqldu6l3sFLpGCA1rJzaTA9DA4gEJ0T1TxczLAn5y?=
 =?us-ascii?Q?1CpcmJgtiP8y0CIo3kmMR6Ttt2Mf0n2o8FEs8cRLK3FCLAyrm/fWwbxU+laB?=
 =?us-ascii?Q?ZmaLcQGrr0v81rVywi2MfMHQ9q31h6pMgIUbZENIH16r8ez3tPeElRmiMK1s?=
 =?us-ascii?Q?IjM1rqlZ4XexVyMDeIjcW6lNZ4Lio1XHZAmYfD0Xbyfgly+DKZIcNPyk0rkU?=
 =?us-ascii?Q?uA88f7KAA7oPQNZWqXAZGc2AzSuadM6IRBQnGbPHchEtJ9472uf3fqchIzk5?=
 =?us-ascii?Q?CjYHY3XUI824E6YgFnFfU4C8HlA69gWtP7OiisgrJN8iwWGm5QKrEqxUVLFK?=
 =?us-ascii?Q?Pi5Mn8K1GGmz+vqmLzi6rpkyq5wVaMqDdgN5zOGWn5eQz5HYJY+2hVPc7OjW?=
 =?us-ascii?Q?sWhF5ZTbsgHevWS1CcbV4IbXdlfnm+O3gMvyyNtego+Rb8HDZae0QjxOceOb?=
 =?us-ascii?Q?h3abr769KQDgKFyRLWIHZ6XsKpsdYXWfRas1H1Z/ozFTcDWCjmNCuMhuIVvZ?=
 =?us-ascii?Q?dhYM8SeJENy/hrqAFHdqmJBQn3XeXLK5YYt3v4HERSw9RyOYEHipiLrqSA7T?=
 =?us-ascii?Q?LohXKrJUlO6U5jSFUHLVLUJix9WVfe9mok5QpD9VehzW2H/UDqnllhwEo9LJ?=
 =?us-ascii?Q?LFviHXDGyDHhZVfsKyxSElo1Dcl4YVuuUQxAY81qyNx12AGKC0elw5FKzeex?=
 =?us-ascii?Q?PBvU3lEkCb1ajV6ZUpUj8mWdNpzvx5YGQg7HQQ8Tjpqoy0Apk6VqyGeA+Bi7?=
 =?us-ascii?Q?pJZJFLCeVd3egLRTlus+3mEcIPJMNBuEHVrBce1l5sKn/NiNi5lttd6xXEUv?=
 =?us-ascii?Q?nNeZKuOcTSXDJAfWCsZvB0AcnIYcqz0+Gre6+TDkv/ZIUFbsEFoaa1Ou0qn7?=
 =?us-ascii?Q?btfV5l0PVkuLAGZwK+NCbdFY5g8apPa9mUFeKQIvFJuJSnb4H45h7PJW6enP?=
 =?us-ascii?Q?yJAGigoAF6psDIdlMNvBDV1xPLgqiK3d5macJxyxK6M4hwfIyy4biegfs2DO?=
 =?us-ascii?Q?DcuzQf6PtTabDMquxugVd3rpXOLRErdeINV4LesV7/xwS6TEUr7I3fWSmSma?=
 =?us-ascii?Q?hmMW53+wr5Z8uYraHyMgN7s6ygdnYTEU+8QI5MiX/5XP55OT7urDdiZ9Qo6n?=
 =?us-ascii?Q?GvNipSRbK7Om1Kl2ERBl43umaKbDi9lwjbK4X9kCsZ8Ymh6ctCodqQhc+VKR?=
 =?us-ascii?Q?5I8kPW8fvnxB6q5VyOgU1as/fQnfdJ2fUwmQIoDTbMdFZ4RuWZacQ5j8xz/h?=
 =?us-ascii?Q?3phLb4WQ4WF5crIXT/LcqJ6IHlzzLb6rt6KmOzmVr29mE1LdzLuAvHCNrAiL?=
 =?us-ascii?Q?R7nDPuF8u0yIpJXPJwE9IFyqNhrYxpJTnrR+nveeLql3MYFodw1Js1Fb70K8?=
 =?us-ascii?Q?0JtAwB5D8Wiam/Z+HBM/fpRlTws1891DrKSPXhnSfUbJBBANwiXt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d26aa3a-af06-473d-123e-08ded66d8ec5
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:05:17.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1XIGswB6Rqtn8E4nxKyiLc/CEy38dBKgGHT4VIWTw7tZjYj2e8htVOysW/1Yt1oRubIzD2xgHqgDgqtfPGT9RuFQQERvL0LGzdgBT0Ow2KRtbFipz+2y14v7IaMyYTr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8748

From: Sherry Sun <sherry.sun@nxp.com>

Move the power supply properties from the PCIe controller node to the
Root Port child node to support the new PCI pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index a7f3acdc36d1..0c6829966f6a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -772,8 +772,6 @@ &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie0>;
-	vpcie3v3aux-supply = <&reg_pcie0>;
 	supports-clkreq;
 	status = "disabled";
 };
@@ -786,6 +784,8 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_pcie0>;
+	vpcie3v3aux-supply = <&reg_pcie0>;
 };
 
 &pwm1 {
-- 
2.50.1

