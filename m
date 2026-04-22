Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7138A26AE5;
	Wed, 22 Apr 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850486; cv=fail; b=evxlWBFwfyypbUaiZbPuvKqE8q4jZD/cNtYo+cKshSV6ZaQL/ZV1Mnjm+dT/BHt/ysw/W6F4U/6gnhy4o7KWBie6tyB/ijsg2GXvagvPgpv3Ogcq/ZA27ruMWtGVYLWr4eD0iPzAhkSxQQqD69cWwC0pTZJtS9UtFJUiZTUZvnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850486; c=relaxed/simple;
	bh=fZRl/SMkFc76E4prm1T7uIYPIy4F2JRd7pDCDS32v+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MyCdB2SWAcgJWCn6okyc9EAwo8jKSHtzFoxnHt3Gdg5FpZRI/7kLIDrXDblYy1AaATNHvzPEOawFi7KQXI7eYIHcDbNglIjvl4IRpbpAGVr6BEn2UIX/N2xnmMLvdIqR85lFg0ebcgGyX6gtIXoINrWR08l+6D8nOlDrbswLDQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W7wAw7Jw; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W7wAw7Jw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qy/CH4s1LKd+8PZlvLKuxDEulrwc/0U1Yp5B+gCdrRJ3HnCKO6RwLUZ0b1MA/R6mAPy3o8V9s0r7JbBTRg9U1sDyL9pP8fOQU5Q7Z9Rgitw2YMFlFTIXxJHPv6CpJBDVtoA9bfdDU1WyNcTV6VyHZBPj6pNEOtzN2mD2ZBh8rlIQhTGt7DTbcwkz+XxBW1IT7VLGEYWfpb2JTeebN4lISaPxxWpjnQfjRXRgsXHnwcYNZtMN48Rxw3n3u30t0iteYJLPDou0zZshgjt41s1/0q6onk/K/7asPHtu+SSqIgeNsMy60wM6JqrZBK77Xi0lk9bYeM6YXMFjGJpCdMtLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC9T6ZvCfI8ZSncwq/GUv5gX+E0Jdx5LCUfzOwlLyBY=;
 b=wt7LIpCScVFKMkooXr+hfAVko5kt3QXjEe4Ex+pRVFtJSKdr/dGZikxDhB791EoJD2jjZV5o5Q7mCUk0uHnHBlut1y6eg3ufq0X4InLNI7YBfoO7fC5E+JrFX3gTlj3PryKRKNB5CWVDJ1DRduhmVxi8yLtwfAdm07o8JZbKVuIARtgz0UVf9Cd755sD/fkVyd+OilN3hXHRnPH015Sf434Ydshp9rBqE8+RlbxwRZwSoCJ2jXEVyHUE+8G/Jqc04UBtpMvWJQK9BXo6cRWCP5kIHCbH0SbZKaYP1a0R8/hstAJGlWWHacqyj00avv6w7QH6+zzxnOPKdIBBkP8xUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC9T6ZvCfI8ZSncwq/GUv5gX+E0Jdx5LCUfzOwlLyBY=;
 b=W7wAw7JwwVNmwSYbgW7175bus0H1D2n0VmZCqaghGl5WxVEqR7c5BrqyjGfZkTY76hl/Z1lVMkRMhStnRCREvMvPxeMBD0uk3e81lDTSsNF6AH+zUC9yN7YjDHRo68VFxsIbtI8cuCNsW0ODS/AfoMv6ZgtWKmQ0rqXCqHF6KvvgtURfm9YxSBuUeDE8KCuhZzDnbFnWZsDykplv0MqpwdPkHqvkBhniHiP+Fp6kXH6YlkEOR+xKGloMmt7AlaU+pRs9rjfzLP6oaiRPlN6dEInSBhquRi4peHBx8qjLaVUORaPm+AE+j/YqmPgO3jIkP4P7m239ZDSUpTMWaqcqcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA2PR04MB10129.eurprd04.prod.outlook.com
 (2603:10a6:102:3ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 09:34:40 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:34:40 +0000
From: Sherry Sun <sherry.sun@nxp.com>
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
	linux-kernel@vger.kernel.org
Subject: [PATCH V14 05/12] arm: dts: imx6qdl: Add Root Port node and PERST property
Date: Wed, 22 Apr 2026 17:35:42 +0800
Message-Id: <20260422093549.407022-6-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260422093549.407022-1-sherry.sun@nxp.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA2PR04MB10129:EE_
X-MS-Office365-Filtering-Correlation-Id: e388e186-8a2c-4bb2-e671-08dea0526082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|56012099003|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	MoEuhYncdnkqT7XmQmtSlxWPwmCvSad12Bnge2fULcS5eErNcfG0yipVaKQN+bDKkBzoUyMEBuNfjx3SPrzfp0RlHkQG6aI20t1r79MVOhTKkLKvUBSsmI27CmkVNszOeCfU/t5+sw/Q9jJNPMNkoMWLtUjFBDNg4MsTAaTa3u3icoNjihL8Fqcihr7bZZvcEC0NvOntSDorXQtGhUn4iZPl9hD+VfiKZcZOgmx5+aF60LVmLJP4YvZ1j2t8llEYYjqhgxG3Ejl8n5EXkRAKy1hMoR22PrqcFU+0e5rH6Fw4rpmu3RLB+kQW/PhhOMVSRKRbd8wblFtQox0f0Np8HIcUx/H/iSp/fa8iEecMDcAXkMNdie/xTV5ftEzx9CIs1LHlfitMj7GSAjlTUSCmCM8Q3rucx1cEh6U8o2OGImKpGWHHihUZPnmJaUBBCplW4R9pOzCsB/toRsX9IxAJKIG1IioPdvUy9LF58GurAObe+b7B9zzjXRl+eWbxcCPSbd4McWhncSad1V3jH5MYskY8Ld/mT7Z4NyzYgtQbrufIMmYFOt6EbyBbowFOZFU8ahcYS3jVPtP2mmulrm5H1f7ZVqDZmiOAB3tYFdRGuS1hQu0d+cbQg2t4oZREr3juJCUbldOmuetTSqWotM1nq55Nb8uXf/UMnqpznE0vm/aO+V+ovWVQvpUQPBa6bA9Y/0roMuRlBJrnH0EfRwLLw8QD5gZ1QmYfdJ7trfviUB9qkkeMbKmJ+iLmvVmzvCKPpO27uZ2zQ880O+AM+nDAM705rlyZ9n2l45tZ/d7mC4RBUgRyyHVG72YactsNZp8X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qJ3lvwRGATV8t5QHJ0rJJ36pp9qA4zWl5pLXF2FWe6s8scZeOzDnXfI1rDsz?=
 =?us-ascii?Q?Ea3LglzGExW/XKKnD5TYUaw8CNCIaLT7dbf6C3K5WiN8XKV4uShwm0H9gXhS?=
 =?us-ascii?Q?unp+4TWpwzmuFKCgaZdz5mcikv4CPsay6MnP8RvSPykW4c4pAPZyjQEK1HpT?=
 =?us-ascii?Q?1JAfghJG0tgHpj7YaCbzsCQ2Pf07V/AJW0018re5ksI+PxLyjMThiCPz0meS?=
 =?us-ascii?Q?f9+9qOlBZoTxhBhlO+oVxzVb5yAGKQXH7mz31ezTDMYrbERhbmmxRgkd59au?=
 =?us-ascii?Q?cXM4oZ1sDrehLKxY4cGQaEBfyJqIgTy7KT/FFKhk0u/PI7UaRgprfCL3JKxc?=
 =?us-ascii?Q?2HqYNt44MC2Xst7eygSP688dfMW5l9c5SftvufmKn8RauP04RNSLj1WKUzsN?=
 =?us-ascii?Q?uecbcHDqdmVDGGS+WT69hF/uGIVRNu+NVhMnn4q6Drf/Du9XP1RxzQQNEjZe?=
 =?us-ascii?Q?cFXNUdQPHoF1WyfqkNjYzt0Ac9kKbtaOGolNiDnVUzGHAmtG8DMeJZUa8Tt8?=
 =?us-ascii?Q?96CWvf1x+HuO2oc2yw+UQu2kG1uy/QNgCVOFSTk6HetQf2VX8JG39soaC2aD?=
 =?us-ascii?Q?SH6tE5lvu/bA5HtxqmMG1VeHdpSlCWZFjJHqQhlCG2L1k9p0q/GYiZ6bByqc?=
 =?us-ascii?Q?eikztpPR0sKz1b3P0fzMaaGU7nxrxrBGeR32fFpF4pNTyq+oBgpDQQXN5c5c?=
 =?us-ascii?Q?6lNS9D91DbbTLQVi7OSgkLLnAymgxpdv3XjOAxoXEGYMwkHeeaxjgHh7Ytok?=
 =?us-ascii?Q?gv3RuRUZyPL6ZA8X4AsxuQ5jezNKun9Etw4XiqT6zG6R0K5hxYx0QRw6Svi1?=
 =?us-ascii?Q?RTMcdlrK7MPCfm/DIHyjxJDM/vCAJEbjBxkJZv5A2wWWfzswgiKvhsTy/8xk?=
 =?us-ascii?Q?8hErmUEiv9j3QmpZRE2GCMyfvy2UouljjAVBOZq09SkuCDzPgw0pAug/Yw1y?=
 =?us-ascii?Q?QTdC/CijCRCEC8EqkIpA38KJLav/5rlQpni+gmre2Ob0Fntct8Xmb1GKiXqz?=
 =?us-ascii?Q?DPvn20ZLHmqXkc4HCZYhb6pywIdSuHsfB3H+IL/BefXu23yy+qKuMiu2hQ3m?=
 =?us-ascii?Q?veB4+Hk/R+8fkToBORwaHWGc2369/jYpUgSFwBBPM2y59dypCVI15fKCUveu?=
 =?us-ascii?Q?q5OZt0Sz1dQ+MtYJs21qG1B2yQGJXM2y7b3qd1cr7mbY4+2ttHEiDk5l3xoE?=
 =?us-ascii?Q?lAOI8DBke08CU64+vlwjrBj6G8nlY/4NC5Q+q2SwEtnslQT9LscKj4vTOh8U?=
 =?us-ascii?Q?aYJ/jrhSyf18mu8fN1ofdLkmbiZutsBL5wOaqULrDsgxIdT6PfYudpMMU1n1?=
 =?us-ascii?Q?UxCMSQA4R7dZar4yvsEHxoCndDqlhbL9TYwuqkDoX0i505oRRZ0mTdoRUs7N?=
 =?us-ascii?Q?4LUI2dggcNhkzFzFlmNoEXSC8JnuCoAj1NzKNbzru6fggJbZlUnty1OjQWhM?=
 =?us-ascii?Q?5oTDlsvv7V9GVNGTFs8nkUlHSmCXE4+EiTAQgGxCMNOWt0YhYPxai1tj63Qd?=
 =?us-ascii?Q?5HKs91eXUlQmWLzC6rMYG2+8+Qe4TOObT3ocwRMdoz3sJSPcaeZAJwUDUf5l?=
 =?us-ascii?Q?sIO6f5srFwFT9+HVpjG1jAxeQpKQ/HkzmeIy2B0FPSZspt0g0KaIs9zVJZPs?=
 =?us-ascii?Q?KYNj5viaQyuy02lSJk2VvnT/zdEJ9uTX893nmPJ1bEnoQ6GaQGhnKSPZmsZ4?=
 =?us-ascii?Q?2n2nx6gj/tPBIjzc6LiLy5HQAg+vNmu7s1hHCRHVVPgo30kOZOI/GFA5WGni?=
 =?us-ascii?Q?yZ6cLbi3Ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e388e186-8a2c-4bb2-e671-08dea0526082
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:34:40.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itafy8+kyIWSV1KZ2uzAbsy3WwhcE/i7o530lSEW3dIvPqjXVEkiTlL0BWgXsZqOXbdhTJ4k/a/Bq+8qq9QCig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10129

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts | 17 ++++-------------
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi  |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi          | 11 +++++++++++
 arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts  |  5 +++++
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts b/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
index c78f101c3cc1..2ddd71f09da3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts
@@ -323,19 +323,10 @@ &ipu1_di0_disp0 {
 	remote-endpoint = <&parallel_display_in>;
 };
 
-&pcie {
-	pcie@0,0 {
-		reg = <0x000000 0 0 0 0>;
-		device_type = "pci";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		bus-range = <0x00 0xff>;
-		ranges;
-
-		/* non-removable i211 ethernet card */
-		eth1: ethernet@0,0 {
-			reg = <0x010000 0 0 0 0>;
-		};
+&pcie_port0 {
+	/* non-removable i211 ethernet card */
+	eth1: ethernet@0,0 {
+		reg = <0x010000 0 0 0 0>;
 	};
 };
 
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
index 4dc2c410cf61..9438862b9927 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -302,6 +302,17 @@ pcie: pcie@1ffc000 {
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

