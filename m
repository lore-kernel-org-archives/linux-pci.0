Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600242E738C;
	Tue, 30 Jun 2026 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799515; cv=fail; b=ZjouVO1eJFukBK0wNsxySRv45lf3Xny4VSfgWTUPv5FoOUBBPpbv0ZdMyCQv0u5SkT2SbLqzGHGveg0DuacwN5uNA5CDulrehzBpz/BnERVJ/OR1sIGFzBb07qmIAU+uwHG5HF/t27At2WGfWEuuk/wngXXhULeV4OGH2lE4HDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799515; c=relaxed/simple;
	bh=K8nHBvwhbX8ObgiI5gVA/UWkeMNHjj57nPGkrSSuANU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RfSqMUO/sIsS43ZOzN86UJpRBbT5n4EIip6RqC7z7CZdY4cMrQPbV+LjnYGreBBpZ2rR9FMZQSJxXJ5a6tkUaM5Zc8LP8B9svUejaymcUNv7qN5fTCqofNch0/OTB+Ur8zKK26+S+gvgEHdX451uaywNsPrTVAT6/NHdkc9PqO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HAslLJP7; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HAslLJP7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkD0H+6bf4Qq/Wd5iz1uGvpJtsV2cXlI+/aURmD6tkFWMWm+tqKYM/dk8/TNaf9G8uRs+AYdKJK7mnKWWG4izFR8ystqJU7C0KA9aHz+4k+4hiNe0zM+x/3OBpDHELlSDNqopm9oir3STVli+6exhKoJN9+6kg16UW6HovemXfA8EJeLjTlT0zv+UbCXsEwooOm1vWlVkQM9r6R+1k8+m5kxNzSoVvD9pQ5jv+1jyyE5F899uot29Ugtd+Oa8dVlzxWseycLVE25RgdPpRv7EuxHMgDJAMieWAZQDGiJJPZnmUorRxCwcO5rGmOrouYWhqjTkXLxOtTQL1XbzIfKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E27BnH/IW6ktR5hRmrdmgnIucf8iQUdmmWBfR4DBJRs=;
 b=rlsoSkGxS5k1Swq2qgKkEqftowQXWA+A4RKZFF+x3wIq9H+ZCFY2PV1IWCdIDI41e+sSw3wnXk04VYj1zwcrnBW9NlOQ/miRLm4xlLtenKoGPXAf3GjVvN0VuaucO5RY6qPxSWAwJ1pI0QPsToFURDS7MF7pRnkxWVSBWeLWq+yb0fi/xRw7JE9woyxQpx5deUpeNDOCmeWGXRiJW2vGcdzweRpX1F7ST/v8mijvIukm5DW7qhecT0MteJbonSLr8iUmICvTO1JvhCoyFQ3wSKACunr4ULIZ6NrZVaWH13stIYzl4Uzwj7qt271q9lhJNf3NGg0HcGOG3Aki11+Qfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E27BnH/IW6ktR5hRmrdmgnIucf8iQUdmmWBfR4DBJRs=;
 b=HAslLJP7B7vZecpNqIb61iTE1obD5On3C51ux89Sb0zFAEkgKrtgvrQywkIs5u5F3IgeSidCD6lTqv7jmFR+P8DCwLahPIqPD15ndm8WzozSdT/NDraVYcW8t0zmqzOhIYvneaN2WopUfrlDhgsRd7vg2GbHxjN0QV6y5YgFrUKGgHHl2mvLXJGStHAsaccZqz6NKkTyxU8AlJL3Nkh1eUm6Lqr+MYHinsTyBG+fGyk+ESib6cP24fjGoMf1aibH5NZ0iY/iPc08p5T0SHgkrsr1F+XN8796HMKDKTv7kZm1muzPPVZRM7aVG9O57lZHczXXypcFEcqFbgb0pz+h0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM9PR04MB8748.eurprd04.prod.outlook.com (2603:10a6:20b:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:05:11 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:05:11 +0000
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
Subject: [PATCH V4 3/7] arm64: dts: imx8mm-evk: Move power supply property to Root Port node
Date: Tue, 30 Jun 2026 14:07:06 +0800
Message-ID: <20260630060710.3294811-4-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM9PR04MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 7102d9e9-0dbe-4d36-d343-08ded66d8b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|19092799006|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	+EYuwEetCjvIg3bbS4Vpuw3XaVYyYujlg+yV0gxlMD87PFjRK2EmCEzp3oj/nVnTz8NVLGrrjciXyiJWCbcHrWf/Bqr3MdHlv6BwYtLKUNTphoSEFsL2iicLtbfuYLQ+wyrHKG+u4hpJQsLH5RRWsm5AUgKJx34rvBlyd0vVoTpSWcZPeJdw3p3txCpPyl6GGMu1Q0ZFR+7DV/oR64VNqu7t5AdmWCSNRCGE1NXYp0wB8TSYnNVV4V5Oi/2c2UYXhY8rdUiWz5Gdiy0dRtg7TCyQRTqUxelR8M4Sc8AHwuMB02eXOjxl6Cn/w/LGVpNPYIrsBMc+hvM2PixMs6jbUKflRxq25xIOvGHHGt7itivyEGu3knKu6gJ9LWhkDdiSUOqLQaWj82KF+vF3NtF0sMnbOzUoPL/5f7QDKAZcRQe5fNzMuIjkJMXuD7/fbpaq7YMfIIMakxJTOHswoPfTW0yNzY9LF6FpvvfMtOukHGRjNvZCT8s5M+hTOv+Knpy+KnKy5AXyBxmmjvFdxNXgeytxS124CV8vjEa3nKf/7W5djuFximQD/j3KMDjNlyRnSqb+Eryf+8iN8Y+hwnQlGjKMVhzmrrxdcmYEFAuaBYWKvRp1+R9mXjCFOPyPBzKK/L32VxUmGa5ZZImRZM1f68HUHMK7GlH4uGTv8FtBk3RJZCvYujcRCPEOq9WA0sUiQXA7OOXHCbHprQCEBxLN+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s6RaAPsyMqW692rKs7zSl+GhaLHz1cNCc4WduJfQeM4qmEwPfbA43bREN0v+?=
 =?us-ascii?Q?jwRYscOov3ehUy8xXgnXszPCtVMXJN8G7ZqrLLiVg1CIfztBv6U9vcQSuZxd?=
 =?us-ascii?Q?Hdh3j4derpkCW+Cc81DGTkjOqfx62OpLSXtBPQD5jIYKkwfpKYGiRBlnOqwW?=
 =?us-ascii?Q?qRM/0GmMiD3vx+Ge5SQnGO/ev2iG28cw5jT+i78izp0mA60/4AfZM8qOrfJR?=
 =?us-ascii?Q?2yYu1eNu2TWXZzlhn55EV1tMiyZ8BVRAFQjxBGRS/riXePuvsAUPL7C+khEM?=
 =?us-ascii?Q?r3V+znwXXMB4PS6h+5sb4PKGasEKVVpwufq9JSgAqJtvZAjPTyVBvx1Uphoh?=
 =?us-ascii?Q?sNRjOSUq8oFvgb2E3ax2SLgv4YmpVPiNm7B1sq4USe/XFytJUf3VPKQSfqsY?=
 =?us-ascii?Q?SpVYwSCSP7E5/EJosknN1k+74wXyQjbHfsEGcCT6ccoPheG7/NXott4MrYpG?=
 =?us-ascii?Q?i7isJS8JkduHGi19sMBU5KxkIUkllxCDvG3WdlYk5ktZyqcWcmZrBS6AW+kn?=
 =?us-ascii?Q?1GTLeB7dPPXwrcaLf9ARfsCAun3bOQUiZX1GsNUKgmF3Ao6YHhb475ip1OMM?=
 =?us-ascii?Q?4ZvIoBCCkau0vxTuKyTJaJvmuXZZa2wamkcHsf7AVpMU83ppd9YjCjEwnozH?=
 =?us-ascii?Q?k3DumFidUXW+LYKcxqRBNeSCTUGheR6SbWL5EyCNO27vJRWxJzGU/nV/EpRR?=
 =?us-ascii?Q?oNvgTqgHU7IEML4DzR7kmdU5aROPMRXXCYbiVhfZJB3NbKcu+rFn+OMNtaO9?=
 =?us-ascii?Q?x/1GOtvwAj/QFIu0OrDloXzyYtoZ8gOZzvCLYtHbuj3fmewtnfWzHyT/USPW?=
 =?us-ascii?Q?PvSAXz10Om38DSfICDJZwnSuM1z53fiB3apXCrbQ7b1m8sHLKo+zd6ercnmJ?=
 =?us-ascii?Q?65wYUmcOxyZMsYF+LxgRjxx9PGaZ1x2dMthQo+/Y0nkfQCSUaFiuVJ81IgMd?=
 =?us-ascii?Q?hXeDgoU81sdMuxEvRBcV/SYQXQVr9v5Mbbgd14w5u/TLVrWWq2+zn59KBP0R?=
 =?us-ascii?Q?/91Op8aZfvJZ6ewmbqVb3M3ZxZsr9DLG1Dn/u/5ukoRLbs3/N5IA7T4RlokG?=
 =?us-ascii?Q?P6WrqRxCrOjXUupmIeTnhTru5gfK1XIXNgYfvOMaRTAJZ3t7kL11rBUWH9/r?=
 =?us-ascii?Q?EIXEetnQP2JO/+nv+Ez+S+8WIbxweoEuL332G0m/qls2/NRLfn0xvenONw4k?=
 =?us-ascii?Q?V6bUjpHy8lt/2q4fW9cxb7K7mhgpJIVqn7c3UVMIRAXknclo9z7EnJ4DYLj6?=
 =?us-ascii?Q?NLP6K+zZDH4wk3wr+/1FuDrYsKAighKOwj3Y2kgBNpHjnji2JKDKgm8jS5Vg?=
 =?us-ascii?Q?q5RPXdI/pragHBNsA10L5UkcqFvzTVdnMtgAwt74p1UFJkkoFMp/SZ0ODEqk?=
 =?us-ascii?Q?iOaswUY+Gk9Puen2nPgA+VRgBH4hsTglBxKLYGCTlZvUNWnlp8ioLO0L+3h6?=
 =?us-ascii?Q?XOnT2YOgzkfR+jpRlPZbg3Rx3tteuXS8thiAp70Zha07wx4ALjwvx3+exWDr?=
 =?us-ascii?Q?wtgj6jgXDuTosYJ7Fwyw6IbCOvpapPEpjZCnVb5TBUjBMVgcyE3ji0N+XQlI?=
 =?us-ascii?Q?noZPTDWg81HPAbgmKgHVzS89eEGxecrWCeyXqSjdEW7mw0vZMdO/wwqAi5dY?=
 =?us-ascii?Q?kytpgePTHNbKWEPIGVdN8/O6376ir8zA5zUbFMrVj4FG4cJmcJkRRHW3/dxH?=
 =?us-ascii?Q?N505gawa5X3OevVqztAsTPmmLArigkFrL6zOFPVn0s1lTX2zGFgv3HB1ETIX?=
 =?us-ascii?Q?no9fjuzbogEjw9cUiUgIHdMUDOJIz8HV4oqswrl3WxoVdQjrjpm9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7102d9e9-0dbe-4d36-d343-08ded66d8b23
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:05:10.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyCcpY4sSVFsnOVT608qJ4JgTvuwfqkQ1l1c5ztiXsHitcMyNZ8cJqq6LeNkNa25nmIWrx8aBKZtgB3iuib5HkjWEAGFUgi/AcZn4gMy5Xa95QVChDJRKk9BFuySX52q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8748

From: Sherry Sun <sherry.sun@nxp.com>

Move the power supply property from the PCIe controller node to the Root
Port child node to support the new PCI pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index e03aba825c18..3205798614a3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -542,7 +542,6 @@ &pcie0 {
 	assigned-clock-rates = <10000000>, <250000000>;
 	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
 				 <&clk IMX8MM_SYS_PLL2_250M>;
-	vpcie-supply = <&reg_pcie0>;
 	supports-clkreq;
 	status = "okay";
 };
@@ -562,6 +561,7 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_pcie0>;
 };
 
 &sai2 {
-- 
2.50.1

