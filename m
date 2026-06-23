Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C42BE051;
	Tue, 23 Jun 2026 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183968; cv=fail; b=I8tpdjOoI3VxRl9/zXK8F+KQy9htkS7idIhbgGkHxEKbirteO4XL/9iAuxYN/4y4SEB8VI27e9zcDRA/pjhBwjv4O7CgMFgKEHTkrsEsfq2Ty0x5Y6cMO3nlg6TQ3CzDXladSlVqriEHd/Og2kwJVV8/QZQo+3BOwSCYljDmnbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183968; c=relaxed/simple;
	bh=3wpktIlNCnCUJF/5Z+ICzmeSZTiPtyDHOUGRj2U9k8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HDZfcCr0SrBEYnhytdPtMVHdDoEcQGOVi8CJpqy0TkTRrKbUbxfq5B/g4FGdrMVOd48HO7w83sqFNiUc4eVya3j2vkRHuw4jNkoQYSlkagqLV4F10eImuaGtRR7Dj4VzkjKOo/P2Oo4HlJtJOYuZUdeIhFtBqbbfH8DID3MLwPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gFr5Jtvx; arc=fail smtp.client-ip=40.107.159.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gFr5Jtvx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKQm1LCEGLYsK0JJLlZXn0cnuMO8DX/hUG9iV7Aj2M7U/UdFWYq32XdPwSFaKyoHQlvN0B1dMOSDkVcK/gf7Xp2YBs1kSS6wZim9gwgfhV84Lv4VKc1crSOdKrDIU7ODgYIAo8EX+cd4G7s3fiOzurvmKXDx8X7tT/TgN1IOIAzckNtSuN9RjbWXefVF6g+MScU/00LHMLhC5zZL4zRFWm0YWl6KHbrl6a/pEMjbpwahcq2AYHnnST1vwqZKMSQotIVRAc2wuJKr3lht60Kg910EyWdKynLvXGBcMO0gh4MuBPQLZJWafuYqz+DCtt97rB/rl1UdlnuGx06Q4cHnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/PAgwfG9OX2u8oSIqiE9YemjGeL43rdbImwyNjSA7E=;
 b=cF/p2ZMIo5su/SEMJfhBxy4O4gOOdew2lHMguGuc9e+2q3DfbcrF++K20o/KLEwJNXQEhMGMLaxjZ4wlFoVIlOnou17COExPjPkqoCVT88FQg6UyN/7C/EVdJPUwhZOylKwav9Je9ME6UWzSRAa08w+mJxeKhrDENKbPANg8+bOleM2sY4hvxfMRpUtLkZUowQItWF7ZFfFT7ENd5c0Rj2YoQGzW6YW78RHhxU5yBeDAvbvw8akqMKUF00IGTKk5KUNfwVw9IVW0KfbJ5vydtbTVsLzCl/9VwxJxTztAdX5otOy8XronfedM0TH5xP8DY5YlG9M5jO9Cixc3k/DYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/PAgwfG9OX2u8oSIqiE9YemjGeL43rdbImwyNjSA7E=;
 b=gFr5JtvxA6dVSVznplf0D5ix/OiyA1yHNspwQqSImo1uM0maffoVYdxKeb33neAi0cTLvXUioVeL1SgzUwv/LFAfa4W1eBOZFnFUuk1jiL5lIHX5mfQVJraIQw3k1jxlOHXWtHfNhpQU0Pjlx29zocYKOjUFVwhZVApyf8bV/TVVHMy/YVtdot/COrSch540oHbs0rEyMnpJ6xGkSVneEePZAlHQn9TYGu41ff6s+UamXCuTA6IjHbjWaLUwZ8S+pHxtwGXmqMu6rgZ44NR7UscJcpsDfFTvRBQr04R1lwiLL33c6rG5c+2ayIL2FNzMdyQBdjuklI+Tdetmf5DmGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI0PR04MB12188.eurprd04.prod.outlook.com (2603:10a6:800:332::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:06:04 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:06:04 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	brgl@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V2 7/8] arm64: dts: imx8qm-mek: Describe the PCIe M.2 Key E connector
Date: Tue, 23 Jun 2026 11:07:34 +0800
Message-ID: <20260623030736.1421537-8-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
References: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI0PR04MB12188:EE_
X-MS-Office365-Filtering-Correlation-Id: 334ef043-8256-4a60-52c9-08ded0d45cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	299UGW/FpDYnE2AJf8kz3IYKdStzAzbDXb6Ajt4gXnbbCxGjuhnB4DchGV42zVc8VHeUghIT3RqSqax4ZGugsDJMc39b919XJUKDTNsSxROrxC/M3H2noofNzCcSc9E1rYyENLAx0KiY4qN++1+PJrV5GsUxR4Qwo74LJLuHp4VtlGhWNRh5TZkWGWmaSvTq8So7MWNwZZ95wL+jH+abDrDtaEkiyPifjA9oiy5IWqMnW9H6MF09ofl015jGp4R1rMnvYXY4xOnTITMAp/G8+wXgF49ADEBdNFDxuLI52XJiRZrVVYs8+Whoh1Z8WPNeZj3RX02T5TlE9Oqar3HVCGejX2BH3oFDVZKqzly8moCUaiJD2W2Gm4WwI5MV2G9tzms54MfjrMb0g2rBATxyU17mdUC3eXmlLk626YQMNGozNz+qGVnlmO3GuBXgkiyFwfvehlBSgPqKnljo5wrsMitCDXdjmqou678gsV4u2OvDMK0yS1Wmt4zJZoYFnf6vsxHX1F2qkE5AqC6fKd47YiROi6oFyNxo4V2flqTnUnCxiIZJhI7npgqeLrU7BZYms0PDBMWWp8bbx9jw/wfwCenVY0Z8Yi0YDZl1AXIXxy+YAvOTgeAV78tq4rwy3xCwNvtr9rSBS4+Oq2dOCJR9LiOwDgOhTHo5ttT6C8IuiZHpYsnbQYiMR+1JZomR04p4pR+nAu7Qc/2J17NLtr6d3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HV3k3Hk36DJj34hXaksqK1IAiNroH5hcPshuX5yoxoE+WkOFflqsv+f5FDF9?=
 =?us-ascii?Q?y4XYIh0DmoFhZfQWTTVWf8SEjnq236sFjLVqL/YAf5AUU8m4ftt0ciIzco08?=
 =?us-ascii?Q?VEnymWoeJrI8D1ZSVjW9Ura9nnJHuDtUv5PmtKIXy1cq2seNktSe5X9ZOOrI?=
 =?us-ascii?Q?m/ckXe5bw91gyAIcx7T6X0l0o1SnogWWy11FhEEPosRwSmESRDrf0czL26kG?=
 =?us-ascii?Q?NlsqxBvRcB7m0p/JVudYvB3DQ6JKim3yBRn0+UEricP5dFL85gksUkafhcss?=
 =?us-ascii?Q?T3hMZ8PQ8iQWQRo6445ov0bp6qpp1n5UUYZjDHM0hqgpQ4p1soh6yBfMgGHG?=
 =?us-ascii?Q?n7VmrBVh0QaD3gsQoQ83Ovwi7oL5f4WHI7VRaYByDBeCG1qQ7WNaRlpuXQXG?=
 =?us-ascii?Q?XS15x3Mxx50uVGtz30zlie2P1vu0hnxpSUJeUIIQmqHWYfiTfk+S+A4x9PY2?=
 =?us-ascii?Q?kmapuTR5FcgFXZ09qQ7kDiRsJFyXlUkm/K2PHroBojLOQ4GcLGJZ1zBsv8ca?=
 =?us-ascii?Q?gFzG6Dnfx5Vl6FAT+rVdx3oYR9w8PqUu+dCY0RxrRb56FsarOBzl0N/GFrZu?=
 =?us-ascii?Q?+fxf+pvTQVPEX7QQkQgxDfTkYkcipZPCER27BF2Zy8N8Otc5nV5533lDoC+7?=
 =?us-ascii?Q?ClyfAdutCVnvkSeGPeBRWdcyINCxG0vyCcq5vESeYLPmsU79HnoOy6LveuaO?=
 =?us-ascii?Q?fe+/22xP2b0963cw8lcYRZIr4ozNE0maykBsF8irVg8KTsBOl2Q/6n5LOawR?=
 =?us-ascii?Q?56ZgAEH2J8Uk3buZ/X/r+Ag0UOWfgkJ7C6JeLNVhIW0AqdoI6/5oUDl2YPXN?=
 =?us-ascii?Q?sYdz1S7XtKYS3uwTGcuxfjzcU7dSgpnbMSVaCDkgYrTWcb9DJYM5oWvAy1aZ?=
 =?us-ascii?Q?JGnijITckw4IYT5ea8Ns7gffIntuGVXzXSzwvayVTxQVHpJU6oAq/97rMbhQ?=
 =?us-ascii?Q?bAzakAuIhfdFZPetEOIZwvkJDt9qytUEgEavEVaQtlw9AtsDWZcr3DDP2iE/?=
 =?us-ascii?Q?5R9+Qjed8QFHCmVS/Npc+wBFj27y89fKtHYyOb7DRxb4HpGzuW7rN10d4AmI?=
 =?us-ascii?Q?yantRMPuz03Fauom0gOyNrmgCN7Lfgt+pOXq0LARmWHtgkkX8sgEsjD6GFM3?=
 =?us-ascii?Q?jGaG/X7xrCFYL6mQQKHr7BOg2fhSH4qPSfLrSWMmscxqjbJlvYQR8Kbt8j5S?=
 =?us-ascii?Q?zXODP51NCxKEcd0xOV20Y/jdWFYl7DSv3UBHHWtznZ6y6t4CUoO2bij00yyq?=
 =?us-ascii?Q?MYl/JKQeHZooDtI5oBlzh7jLRidH/j5BYYzKulyy3m5J7uhMbfkcN7jHIG5f?=
 =?us-ascii?Q?I2AnpabF7bRE1ucNY6LF//nZDYeQDWp7TsoCt3mXT5+NCNJQz+ZbhDFPh5qn?=
 =?us-ascii?Q?nciNr3u90dpv3f7kzrAksxIuRFVRqRNauBmYel4eNTVqP5ZlkSzyJl5w7mkp?=
 =?us-ascii?Q?z7N/B68B7mCt9Z0IqV570+ZsDtWUaA7zYve3olJNYHEFzGY1zA5wjqN654NJ?=
 =?us-ascii?Q?R0Ou31KhC37RRqL+vxC3efv/Di3eEvoElFW0TVGr9bLfEMIYDtuIs2D/4B29?=
 =?us-ascii?Q?qWX15Y4M2ypa5XLLVLlXm3VzBr793+rrbZGdjto8gvtmFVPhWxuvX++WEcqh?=
 =?us-ascii?Q?P5OzgdiLfbmsPWw73WHAj9dS9bqtSRHQgE3YSFNf7WPJOSJIqV/24rfPZOQJ?=
 =?us-ascii?Q?KvA9hqg3T1EWjx7Zm6743x7KVJr5MY6Zu4p46SMlJXtFieprsbWZbr/YshU6?=
 =?us-ascii?Q?qbnqmZG8kDXHwZTAThe0JVeLFOjAmhNZmeBayOqNSQx08xuuNmBi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334ef043-8256-4a60-52c9-08ded0d45cc8
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:06:04.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+H1X6lxdw7X5DgkfIjBfHtx6fKg4oO3dcdwnXQvP3UeZ5ZKsEAVDQYbWBlsDmDWMA4RhRyNMTfE/sJl+Ysa4TBQ7uOCloLX5d/lSCfhZDj+xVNYV7EJrwARPHYQKL/O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12188

From: Sherry Sun <sherry.sun@nxp.com>

The i.MX8QM-MEK has the PCIe M.2 Mechanical Key E connector to connect
wireless connectivity cards over PCIe and UART interfaces. Hence,
describe the connector node and link it with the PCIe a Root Port and
LPUART1 nodes through graph port/endpoint.

The M.2 Key E connector is powered by a 3.3V fixed regulator
(reg_3v3) on board.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 58 +++++++++++++++-----
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 5e725ad8aef9..4c02592cfe14 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -32,6 +32,39 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0 0x40000000>;
 	};
 
+	m2-connector {
+		compatible = "pcie-m2-e-connector";
+		pinctrl-0 = <&pinctrl_pciea_reg>;
+		pinctrl-names = "default";
+		vpcie3v3-supply = <&reg_3v3>;
+		w-disable1-gpios = <&lsio_gpio1 13 GPIO_ACTIVE_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+				m2_e_pcie_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pciea_port0_ep>;
+				};
+			};
+
+			port@3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+				m2_e_uart_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&lpuart1_ep>;
+				};
+			};
+		};
+	};
+
 	xtal24m: clock-xtal24m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -320,17 +353,6 @@ reg_can2_stby: regulator-can2-stby {
 		vin-supply = <&reg_can2_en>;
 	};
 
-	reg_pciea: regulator-pcie {
-		compatible = "regulator-fixed";
-		pinctrl-0 = <&pinctrl_pciea_reg>;
-		pinctrl-names = "default";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "mpcie_3v3";
-		gpio = <&lsio_gpio1 13 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_usb_otg1_vbus: regulator-usbotg1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg1_vbus";
@@ -718,8 +740,10 @@ &lpuart1 {
 	pinctrl-0 = <&pinctrl_lpuart1>;
 	status = "okay";
 
-	bluetooth {
-		compatible = "nxp,88w8987-bt";
+	port {
+		lpuart1_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
 	};
 };
 
@@ -818,8 +842,12 @@ &pciea {
 
 &pciea_port0 {
 	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pciea>;
-	vpcie3v3aux-supply = <&reg_pciea>;
+
+	port {
+		pciea_port0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
 };
 
 &pcieb {
-- 
2.50.1

