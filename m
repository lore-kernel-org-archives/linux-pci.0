Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA866302750;
	Tue, 10 Mar 2026 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107635; cv=fail; b=Ez32Bc/QOV9EMWVWWc/m/YWwT20GaeeUvjm2fthp6z6BLtHQf5awt1ruYfXs5F7eYBnxQ+hig3eP+hr0F1EdDiuba7lvPvVzhQBv69LnebAcFAPP3GU5F3xDCHBdHItImq5mdN2JbAj40cKnn6ugD1kL7ORr1XLrQJNaKkqq6TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107635; c=relaxed/simple;
	bh=bsCqGmkv2u1Exe8rVk/RPtpssCoCE9tOWWvSplVk7Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LOZfywTtGDSeOZAPu9WrOoEV46fP78hvUR/TmNEx+3Bb+wL9GMlMdtTGtcgBimbKcUn3QLxB3WrbyWTulkOaDYHbBycdMPZjkweKF2OGvBF4TU823UecFtfzxowfw8P00M47QlauvxTr/ONzNBXDjcvN8lbAodZ00V9kSZGU9Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xi+1WPAP; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xi+1WPAP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcLU/LOpdyeCjma1KGXdnyoUy7yWC/UyDEaFQSkndprjFeAeUT6STAJEzo+f7nK3w+gVpDIK6OuAWkIs3c1UK1wwL7QkJ+I1KmPMGq8mkjaK3PeAcZr4MemUC932eEtxOxzgAuTsrAONIRgKWYR8eWzbxb/KmON0NZ9LuXP9Kf/fE8y/4/l5t0vbFJbkC2OR2vFBzhwoEQoo5GnuxwnLJM+ho1A37Ku5GNTWAu+oitdWNJgLCfSmMV8o9QSzK669NKnRvsei0xTQ7eRKKyv5cT8LJM0/2+c8QtNC1JLLInzJiT6zdN3hHTTBCQhY98wN82FAyIZHmaZODQnmZdBi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e87oTYFo6x0wcbv2G/DM3RlOz3RZ3sk7332K9QNWF+A=;
 b=fsXvJi1vAIK/qgJduQ/yzAel1wU8jdHS2Rgh2ZRsM5X0qfRaZMYD+h5w+BerzaRcoKoUreRIpVG20WTtaWkIT9u03aDy8mx3KJ9i61+QYDw/OUvx1g+ZK16RryP31J+vmLxmKgIpmsYzfzjCGUjR2+0oZ3PhRz1WvEekd5DEH/vqdBpY5q9p2SkQa9jWDpFnwBi4SUWshCibALHBk8Gx+UM5tJZAHe+S6C6KZcqpaoJK87R4QJ3weDlVpXkOvsfgWrQo3fg8bmgvTIyo47v7geJ22KsboVDhxe8vtAEUo2yTuNkayHMR03U0R7ds6O+cfyIlGebqBLEKXAcmMRJDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e87oTYFo6x0wcbv2G/DM3RlOz3RZ3sk7332K9QNWF+A=;
 b=Xi+1WPAPX7o+w1qHuTpR3/SUO3L1LmLFIVEr4ixwYm+bLFs4mSvu/zLd0dj3AIOHDbsTctbCPu6yngRBFQdokHI+3EbvKjEWvXYzEKnTA/3Mc93LnVxQeDtjbdlAOsx1LedoOOVXm8WDTIELru0s6w5VR7y3En30iVJdhMUQJriP/lnjttKScCmhiDAe5Aiq0Pi72rmjkp4pDcwYlw574jfkl9d56dV0cQ6xO2PYakdad8r8fcmGslv+SMbJpVDX13EUDuu8VRM/BpXik2i9t76RUkcqAlmjD62b1+dHJbvytfSvtPiY26a5llhCMNTyYdjRhYYDi4VBz40bmu0rUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8889.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 01:53:43 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 01:53:43 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 06/13] arm: dts: imx6qdl: Add Root Port node and PERST property
Date: Tue, 10 Mar 2026 09:54:19 +0800
Message-Id: <20260310015426.365675-7-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310015426.365675-1-sherry.sun@nxp.com>
References: <20260310015426.365675-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 049cf702-1e99-4bd8-bd33-08de7e47dc57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	M+I9zD4KRiHAcXMSZ9VeRs/Q4RSTCSgwMDnnsqUo6YQb344RNhO1nDYvoSi8qd0gfTI6YHX+5oTtQ+vLd5st8ROH4IJxXwo0FlhctmWrwiXiGSla04rfBI8MfUgeaQFenC47OOwJZRiZiaASlEMrqup92gyixQ9QC2QPiEjTKOOkloRgU4pvFIkRMrIZHUgN6Hea+D9hNi1lxmLVwxBrxDS2yl1l9MQou0MTDc/5+lDwPXk9rNxWrQrg/sjOV+f9JbX4+fcBJEa3QJ6A6sddMHQc7EM2X2++IvxluTbrRdQIiTuBrZFEACEdAi+dlDZ9TLdWHuT+hJDSrXzV0wyMXPw33ckL9dpKbEaSeuAP4SNGm19cKGbgzlU9EaEkFQtNgZOar6fTeiSpWdjRW45aTPNF6JaUNZCy9jATNXhRtdLLIoT+C+77vq7L0evkLXLyLBTfm/XMr3PZgyq1ciNeg/t+NjT7LcVj7WfryywgLyO0Oq5NhFLpKIxPZdHRy5gNv69PNZIlJ2e6ihnBsIAlPNicmw7Xm5157CP+Hv+nJC7+CTDarPqbrqPPAyomdreAr6r3nwD2JhhMlUNLxWrdOe3bIWakyc/HXpROTLCRb/ergKZjRmidW4CXgP2c0sMUPVOzs4F68HV3TwDiTGaUQn6Z8m1e63iBWDyuzxL4U93Hd/wj2siUCAwgfVvoX+uz/88MeluJEHNHxLBHYfVW+9x2MwqSIwHJTtRHmvXUcd4vjQcKL3YqipF18SrfthCcK2jh6m0tqfq+1F/38TdcawqIlbv5oQctYggbOfJLOWchjDio2qkJKeZS9q8w+8CI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gXp0jMJy4GoucmaxH1KUTGZ86QOL6uSnheykUCdkWFIm2Ibgha2/3pAQKayF?=
 =?us-ascii?Q?Hs+st0N2dz79ZA87jQ3pKpUxAMnnox9JX+7pf0yPFbO7XLA0Smoyb/2cciFr?=
 =?us-ascii?Q?P38SxWkNIooPKMXS6lAQUwdL2O1lGWLmfTDTO+5jjAVh/aFGLPH0kH2IVsFs?=
 =?us-ascii?Q?hvEVF/ZWgwm86cWqt+DddhYRsTjlIoSszt6SyQ+adXlXvUV7jWskoKi+GP3V?=
 =?us-ascii?Q?BaJYhwT+Vi4OBqjmc0Xc45q+bR/aW750eXb0YNBIMwfsThp2vWow2qIOplXZ?=
 =?us-ascii?Q?jOd+GiQIrVEEPFY8h0zuBF7i3gaD+NdjGVMysTREcjkNtfof+bxNeugSFhLf?=
 =?us-ascii?Q?QXlDuIgF7wyuJ1a3oEPCBvfRNQJJWpoLiHeqFdgwYHGtFNDRiheFtv2nObNW?=
 =?us-ascii?Q?P0fOE+NDO7jDMU+fMj1AerVVLpSM6bMBXzFA5dA0AHeQyLuMoxF4EeKZG4fl?=
 =?us-ascii?Q?0WXTCzT9W88dCQ0iK4r5LennTtZnrIy3abykNVdNbTHfqr8cJUFsDdf6MHx1?=
 =?us-ascii?Q?DXMdDheFZZijdn78dABkQSCQovsJArxCdGIkoxwQM6fO2WuRURyhTrG9cBlO?=
 =?us-ascii?Q?4lfr3GLKVzv1wg6cDpbwn5ipiic16sojUf96tifgQ4ZO0Cbe1xn2nLc5Ym1Q?=
 =?us-ascii?Q?ccrGJ+KjQkoOPpCtFygr3Xxt+kjHsYOidsS8Eo1nATCNqrEMMli+iOSePD6D?=
 =?us-ascii?Q?Hf6ZW+YOgxNPVf+ovFx5+Ebm8k15kRdovbbm3QfpoTAOFV0jaAF/FY+UF6Ga?=
 =?us-ascii?Q?l9uGNkEzQNvh50mYzl3qA8u9tUK/EWdXYLLGvRia5nbED1JF9NmYqCAUQR4y?=
 =?us-ascii?Q?DuokM1qn0ClY99uts+BO2CDNIntSncBOplYsXXQQ1YmVEQPHA+Ar5i0V9Ih5?=
 =?us-ascii?Q?3E8c4A9hnEO/EBoeBKRMScHRLHp2MQb5LEtl5PmXJJ9SO+J2RJyHVuPkYz+f?=
 =?us-ascii?Q?VCuzsJZ6tGZ66P8MuDvwA6hmgCjNAhorfA9ZchXdOoQ0hOUKZQ3dKmUlga2h?=
 =?us-ascii?Q?ZbMtAlsCWcWA9U/JabVd3a12KhJVHMdf3RH0sqOdaaw18Jd0i4X7u2TGu+/O?=
 =?us-ascii?Q?UijNNBtQbqNgUTYDKC+IuPiM5vqsp9ItR1/Ok9YuSG8IArN11Jw8ZOjTwEZf?=
 =?us-ascii?Q?cIjcefrH5HrotXhUXu8UjE6ZM+pMpTOu9H/C2IkMWbGtnmrb3PfNbVhqT8vn?=
 =?us-ascii?Q?liuIqwDnCBclUelPXZTPiZLdVvM3+W6Hl/akqgxBiff8cBbdUY8c17evEZNA?=
 =?us-ascii?Q?iJhOM1Ge0YV5VosICyQdLMCVQp5e7cfj+MzGL367PwLk7Ii70ZXihQJiCBVk?=
 =?us-ascii?Q?5UvFtTvoEAN4sIMC6KtvwADG/I3G1vFBzrkTOf/FRRYyAsABChB1LU5IyF60?=
 =?us-ascii?Q?ePR/FTK9vYoBf6GS4lyufovvSJCyRG5yTGmSnEBAWn6o5ETrG9oLcsvY4EnD?=
 =?us-ascii?Q?dMnGoOZixu1S7zeNN0MZVr7F8yT7wjCp8M36aukElwm4Mf3IgG6sEcQgP2wF?=
 =?us-ascii?Q?uBEuxgntVRzwrcKkgyyMehLFd7vuSaUfrmZVgd7hBROyBSLVdpsWNxPiKJ+/?=
 =?us-ascii?Q?FJ/rfjVsw3Jb6AeoauIWAHlc1q4j3fbMsZAoogOjvL27ABi4k4V0O+0nFI2h?=
 =?us-ascii?Q?phDCrYyAxKD+FXbyDvo6NKqYl7yCfeR52rldpwJdl7gaeqzcEkCKhN5NhleZ?=
 =?us-ascii?Q?OuI0E5DeXkr593jgu2H9urQapX+Gz1wPfool9zgHA01a9aUxZwzWWSrZne2w?=
 =?us-ascii?Q?kCzI56Qr4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049cf702-1e99-4bd8-bd33-08de7e47dc57
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:53:43.8444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXH5F06N2NIC5HWwlxOeI6dRhhvCyfMXWWfRNK6yOm8kAieM1OBQEBqUs/UnnYCai8BIbL2pgthmuhESqzcvpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8889

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
 arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index ba29720e3f72..fe9046c03ddd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -754,11 +754,16 @@ lvds0_out: endpoint {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index 76e6043e1f91..eeb376193398 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -289,6 +289,17 @@ pcie: pcie@1ffc000 {
 				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
 			clock-names = "pcie", "pcie_bus", "pcie_phy";
 			status = "disabled";
+
+			pcie_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		aips1: bus@2000000 { /* AIPS1 */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
index c5b220aeaefd..6b12cab7175f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
@@ -45,10 +45,15 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 };
 
 &pcie {
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&max7310_c 5 GPIO_ACTIVE_LOW>;
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.37.1

