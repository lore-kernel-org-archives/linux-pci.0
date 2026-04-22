Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E8138839F;
	Wed, 22 Apr 2026 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850526; cv=fail; b=PFljCOZdnuuvkBCqk/07IHVGnIQ4wXurMvTCeB/ixyY9UFchsbEXg31dD+zWU049daMXnU/CYwPSe1sOkoTZc+l08tpIHeqKfLEjVcUs1kYGWcnfaXAE5TgdnC4RprL5ui3W/itwKvd5zymgC53Eat8DdU0LgrxliI8Bg/M+yfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850526; c=relaxed/simple;
	bh=bhd7sdPMyTLTMWxUSfuz2/r3EYJn8I2Uwi0UkbpZwCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s8Tk5vaQA/hGG3QO6/wMB3ZmZLr0rN3tw2dboJN0WvL5f1NHeUkZU/e749/q0SWJpgBbs8Xl9BlB1fmUC8tEASQeSd1790TJfCflcA9iLx11YbzQPCL4jnt49z0WFAPrSypnPXiICA9fc6a+MBmNItjLR+ZkQ0xvKfdWSuTNPD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lo8LceGS; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lo8LceGS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RS3QN5Zo7WExcP5AmbHVXKEQqs9Q9Ygk7sfU8vIC8H06kBzJNG4hKklUlKsWmxfePbMf8atC0Skbe1mDNfaq1J+8G52I5lOju00t73mWYsLQZYkjBTOESUnaUPdJIsO4hrVG3vMaW/yr43K8gCw9Rmbnry0eHPA3GT5aYYGQO7r7zrtbADL3nKlN8+/qO3ETJzPxHlIbRBFQxzlqqMD/yugJSQ+jtsavuMPn6L+54mEil0k+iIlG2zDNLHJ9WbdndBrI/qcb3mi7C+6yB9U7LA4saudIZM5GuZb1fxkDF9wElL8fujfzMmJS1wKfDtOq7PohYC3Gr+Eph1U6DQbZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar1VoCQOfqxRn9JTafCIhUPdpnR3eh4akKNpCkBDLIQ=;
 b=fEI7/ZPB1DV7Uj89nhA207qVOQrhAz0T02wnpSUqVaWWLqZim4wPJ4EU0MBAaeGF+GLYsAab5IWtOwQPUVRsr9m1KRfVtQqIlabdd2Wp0uDfbq6ZfnK6xopCGLRrkY7XoC/xTHhvlVPPPSeUAtZpnh6tZ8xBCOeI2+cT3KbD6tMUcshNKWt4RGi3opDVNYx6lt5e7+TMDXZA9tonirQ9d6+aQp0AhjsOB5QjM/lJRyh+CLrtENys/z8vAGlQRuA2YPxkympjb7V+Oyj1jRrUzBt2qrCabMB7ArfVznCIwvn0rsP6VWuVx4E2xmSYK6zG/FMyGWJmpv83vj2aYaXUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar1VoCQOfqxRn9JTafCIhUPdpnR3eh4akKNpCkBDLIQ=;
 b=lo8LceGSceUhPhqesXBjxn2T7Ix6ITV7HL5TK4vssoWdeWgNcel7FYEffcVmcX5h754ketz9A+9k2lFLNISUm2NNzIzKr0FUmHPyXqiOuJI/r2KJBa5M3LkiZvq1IA+/Gei1TAVjhz7/k+BYg+bMvOfivTutq1EcY5iHamjE+i9NuKD1ILYtPjNO11FSJWAGwqZTCBT5dparEOnckfXN2YM/aUvWkRAVm53HTlIs9uaOOTu+hDlwP4XdsKntP+5eMHxauCN+QzbhQLcm70PoTtbrjNdQjX17cBObbiY7k5dpdBd47+xK5hJisSPDfe85q51juGCpU5Suj9zcYCL1fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV4PR04MB11428.eurprd04.prod.outlook.com
 (2603:10a6:150:29a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 09:35:21 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:35:21 +0000
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
Subject: [PATCH V14 11/12] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
Date: Wed, 22 Apr 2026 17:35:48 +0800
Message-Id: <20260422093549.407022-12-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV4PR04MB11428:EE_
X-MS-Office365-Filtering-Correlation-Id: afd03521-27e5-4eed-56ee-08dea0527956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QOHWqC8h8Et1oEgcoz2y5wTEoTPiBjpohbh+deUyrekZebScn9i+fPPvmbWF/V+537aMs2NYZveBHcq+4Sn4Wya9zjpz267BmRZ5vtKm/G1lSpod9M5WwoLplvv68KdmJax42vSlGexBJma0ttdAsM9ZHmtM2oJTNjhyRuMDNSjPF/AbQzVK4KoQKWE6AiKynZA4B1ctNMhR6AYhWE+nfG4fNrQ43SzTcfqqqN0w91el9sOrLQ+X3GeDBCJQPCgxoje0DollXpM9isb1p80RwpEHUWwNV3XDOeoPw68aXMtkehHaEp0unWZ54v1rmQPSnVWiz1t2onv++9BBS4jlzA5uXjUJHXb6PzvlelYanxzcCuFEp2vYDdv38+/DB0v1j8TunRtA6bLTuvHlFLEtg3uW05IhdAknKbrjC94NhE85wcrGXiT0aFMNtmaaa0RmfW3kn0VUqoB9hzWxMq4E+R3A9yC3qDWwiHeU4J61Skrq73SoV6xb9+dtxYLLjs5eOaMtpRw6oVltiInPSxW+FsVJhHZQZmTHOlc5HFr0q5VUiHPBrkn1TwG0KGcAzfVD8m9WdjeLjiP9s3fzwQ35kHw6AiNDLAwGGDGb6SQ3is7Re9rNaPo3I/DnOFgCCCaZ44XwMIXAK0E3l8ufQLy0hCRxblsc+neGr1gWmBAEuuU38zAEg49YE2z2p/hz8uI4Y7Ur3ds8KbGk7XWjPAM3hyc9QX7W0RpsUGyV9QFhQi0nl7ShOVkXVqHnQReYiCv6r+QI315epqpgXJaVo7eC6eR1uq8+8YIAbP8Ql7OavXBm9E5y3YV6ODBoOxivpzJm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mqIkVHU3JtEzq5VFdbEZg5Vk5M6wOTU3FC8qfMdgK61ilAhwGUTqh6ACISpg?=
 =?us-ascii?Q?AdmK9Z6/zXnA8xSEgrZWcTao6By14DFbugrKlrOPiNWSJ12AS26XTUMcjW0D?=
 =?us-ascii?Q?tp9HKTLDwMsSZlnlXAVEmAIGF2sgL/GhtVsyFsWOwmU0VepHkleRTLjGGcVO?=
 =?us-ascii?Q?0D7On9Ar+sRVQWH6l92jrgi2KgCJiZyGI0mkrO0L2HXw6WCvTbyHoRyXM1oq?=
 =?us-ascii?Q?OsA3APTiUsBIUv4wDBHNiXDiI0g8zZOeIfVxQVSLsF97+AEuM6d/TEX1Qo0l?=
 =?us-ascii?Q?hLMjpS8YqCCk9stwmwTLLlg7+dUKo/r6M7E87a1VXuCYAJyGHHbACTemhWOO?=
 =?us-ascii?Q?Nm3g/klmP1Ejmxn7lg0mpqOUxq8fY1X8Oic3AdALtSbKic8ijy8vimNNjQmA?=
 =?us-ascii?Q?NYwk1l1aoMQvoeYk0u0dU5YEFd7oRaUdHwSO4sRdtZr1uly3KFXjsJyfj28L?=
 =?us-ascii?Q?43fGe7Qw8cUeYfbBhHLLTp0e1AnwsgLyshvNYfvsVvgzYI2veWvBDqs4GtCR?=
 =?us-ascii?Q?pmfa8NguCWQ7qXEkWI8WWkZZZePpAWT0O5W0dnUZ2bdd1rhEeVLukLPgVI6L?=
 =?us-ascii?Q?Rf/9zlwpZ1eZbEenHPBUGs5eyc3OFp+F06lM7bh134oZUFy8V4Y71gCxb5L3?=
 =?us-ascii?Q?dTjiDqFPPGY/ruyJabRxL7tQN3HMbL8WiHgQk8sLuepVdEj66ARMoh1R9xzR?=
 =?us-ascii?Q?KgsB8oWn+O7xeDfVsYTEter93+pfrylvRNiQZSxz0ppmrLtdaIwPLOkjAcTM?=
 =?us-ascii?Q?b4iuH2doG0w8cs9VeNFZurmfNMBBIdmqUPh3oiPVuZmAaD2p48vQ+iMFvf9Q?=
 =?us-ascii?Q?F/0uklui4Dkt7kd9HvbPYbSaLnwjx+bMToS+n4wP9DAIX8z1JrBU8PZcGNIA?=
 =?us-ascii?Q?z3ZmaoBMrtmVzlJUaWcMMxlQtvVE80xAQl/R+WYCTp2BfaGmgAmK/vBflWqX?=
 =?us-ascii?Q?4dkBe2GetmqPBT9615ZdkT5DJByxEqzPv2PA2vTwyim36dHWSocaFMy8vLDm?=
 =?us-ascii?Q?Pizb0bOtyiNO5H9D+4FvTkflFsi/d+98zcv4YGxRk6OjJ8/Zo7To/S01FFkm?=
 =?us-ascii?Q?9GuTnLYtEttTWlUS0QinlsjyJNswwqA4k6E493NIUMo3Y3rEw3D5lcf7tiW6?=
 =?us-ascii?Q?nIooGrFBl/WmIDKFXgImFIQ0aXmLGTVGWYyTcTlEJ2FjQ5PRgiGViGvEIBCZ?=
 =?us-ascii?Q?0+WE8MkqdV30g6lzBczCsGtaEekDlVRprNKvqvbvawNFvO72XyblnabtCAHb?=
 =?us-ascii?Q?DPyP19jnqKpliGxltfH3jJoSts6e4lMB3cLEvvGuj38/+WfdMwoJD8nj1k03?=
 =?us-ascii?Q?Ee69WMGAv0/3Fzu7BQCPaHfXF3xGt/K4tJ3ZxkYES2llcXjZlpzS4Af4/qc2?=
 =?us-ascii?Q?2GWIavoKII64sNP9/+1OrPLP2e5M2ygpPxeF61LXPCcf78n4AgcjKWeqRfOU?=
 =?us-ascii?Q?ph+w+jaWd8gkz6jPznHFS92U8V7bdHyiS/+CRH4n04LkidGKhsayFoF8fAoY?=
 =?us-ascii?Q?sHvgUpJT6bhXPUFkpf1rChFcJ5yld3TA+CjcXlEPVl7tesObfJsXg38/5pWG?=
 =?us-ascii?Q?iWCcwWuC+2eBc3Po7UHvB/NJbnyk5fI9SfLNuXCOywWB6iWeqGRvLNf0+bsi?=
 =?us-ascii?Q?2Y7EBnSjRUk4Bmrs/VIjtde1GNiq+7heImOWsM+6U8iBgastsJCd9Td9emep?=
 =?us-ascii?Q?MnzxydBlk6SFKFehxmXm1x9jhsuisIWMYHrLwjuvZY1Xo1nl6VBP+cy261aQ?=
 =?us-ascii?Q?J/vDWEIWbA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd03521-27e5-4eed-56ee-08dea0527956
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:35:21.7704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7cq0XgDVa45icwRkU5noL6Wzq9wZj+q9pUErse1VeqLFjcLcK5etmARrGL0GRaAt3ydkMMad6hc1o4Rl5Ai0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11428

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      | 11 ++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  5 +++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 10 +++++++++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    | 22 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  5 +++++
 5 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
index 469de8b536b5..009990b2e559 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
@@ -78,6 +78,17 @@ pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcieb_ep: pcie-ep@5f010000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index bc62ae5ca812..39108a915f96 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -675,6 +675,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -691,6 +692,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &sai0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 011a89d85961..f706c86137c0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -810,6 +810,7 @@ &pciea {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pciea>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pciea>;
 	vpcie3v3aux-supply = <&reg_pciea>;
@@ -817,15 +818,24 @@ &pciea {
 	status = "okay";
 };
 
+&pciea_port0 {
+	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+};
+
 &pcieb {
 	phys = <&hsio_phy 1 PHY_TYPE_PCIE 1>;
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
+};
+
 &qm_pwm_lvds0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm_lvds0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
index f2c94cdb682b..2e4fbfe0ca16 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -41,6 +41,17 @@ pcie0: pciea: pcie@5f000000 {
 		power-domains = <&pd IMX_SC_R_PCIE_A>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pciea_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcie0_ep: pciea_ep: pcie-ep@5f000000 {
@@ -91,6 +102,17 @@ pcie1: pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	sata: sata@5f020000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 623169f7ddb5..489e174df4c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -730,6 +730,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -746,6 +747,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &scu_key {
 	status = "okay";
 };
-- 
2.37.1

