Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274F730E856;
	Tue, 10 Mar 2026 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107680; cv=fail; b=p3Xn/2v4BkZ8qgLmFcw8ox05Q3AkaehywfQz3x5sWtiTpnWdHfrJ7paqJNeJcEOHY6ZuyF/dL4MacXhu2rC+ssowBiwEB4gCG8pAcQljkXOq5HalOlIRCjeIufiMZriAFOeiaNALKdkEx7E4d9q6dSLpnDONJZDwPbiUaiGsmTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107680; c=relaxed/simple;
	bh=TB9G8cHydqva9M971aY+RbsmjdA24fxUMKy0mCVwjDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z8aIqxdnCV7jFDhosp+T+X7E0wqmqF4cA40Bfa4E8mNtFvIitGa7cnqDPoh0XIYA6nxUm4w8v26hso9IWnXvd5gGMaGy9iqpJa4owcLJfhvPJ5Y4pQmLFm1LcL/1brT+ixB37fdITxVz/sVN70NpC7b5lEVnrm+SnHHwgzT3w4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aMMriYDw; arc=fail smtp.client-ip=52.101.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aMMriYDw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7hi17SyykVFUvEnhTyZRCq+xYYUX+GQFVmkAwLqxi3PihoqkgZiuS0a/JgAqLddIifNX40fbPDSuc9mA3Zwjx5dwtINa0iev8726jKpb64zh2xPBUOFhSW8EPvRV5WALONnSCGtYrOPXd44gQ+Z1Do2Vjf4BqnE8T7NdLNA3d/vD96yQQVgF+9THuuJCJEejH5Sbd4nffK0A0WjT0r7dIojEteyVF+OSqQ+kgMWYAX0BV5RmHksG2Ojh0lUbsBMB6nYPx4aFiiN58zAINQUD7kDX7GW39f+Sa/eBZUL/JVYw/1nG3YLQDV+TFXWojpz3h3ZAV1iBkgS7P+oKjuzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJb9oHe7kobPyTsQ/blsu7kFAjj9YJd9yLolL0/IInY=;
 b=ZUxJDTn0cxOcFFO8mshQR0j0qohjbFe+F5oEzn2VPUZvHP+B++WLiSehzGi4xek7PwUqYCR82osYH/Fs4VyweA6e/7SJfzPLorleoZ9j2/Ae7A2HpoErOU431OSW8ZmabQlCS0+jmlLcLovhlpDjOTjwJb9gBMyCCgdgWWS6lvc6eOTmkGVNBr3ZD74CsKl9sBuCvcUwXEaPjaOPlZoh/WvNTKxx8C3dO0ru55lyO+dsSp1Kz1cavZOHFiHidZPO1W+7pUC6Y9oQ/a8GSefDnw8pth0dhiDWC9rlr0WIPmea/MgFngWpTvMBPMvVbrSevtT8gBdN8EmgRz0Tjq32wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJb9oHe7kobPyTsQ/blsu7kFAjj9YJd9yLolL0/IInY=;
 b=aMMriYDwYOrjA26Uud8uMeSUZ2gntfrltxxDgAjsVnvRrhYElWXT0RKIohTFq9rxC4p01FWRGOn48nBJlZARm/4buJtjZyJ41T0MlP9zjKnOOkG28bwWNMmsCvEKFJnH/NB08YSLteLRT+Z/q3urq4frjqDpJZ6JHmcyeshhlMtRh3iWa3IDxaFBOnq8JUyKDJnodAO4Fd31iyYuEPtEEfDfKovkSvfDCZhPL6D5TvBIKLMcfloe1cqBmXVuYXz7NdTc/P6VADFVnQARBMiMyxKUs2YTIKAzYIKKvuXWAZCfM3F1mjc7llSazbSMaouoc+VfVB5n0h/CtrREDcPaEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB8434.eurprd04.prod.outlook.com
 (2603:10a6:20b:406::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 01:54:26 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 01:54:26 +0000
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
Subject: [PATCH V7 13/13] arm64: dts: imx95: Add Root Port node and PERST property
Date: Tue, 10 Mar 2026 09:54:26 +0800
Message-Id: <20260310015426.365675-14-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS8PR04MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: d7615ce3-ee2a-4bf7-057e-08de7e47f5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	zYn/GreNHoUbUzK16II1DNoVM6ajJS96N5YJhl594ehdId5KxzpkjsS3jWfsdNRi8p1TX8fYuBei1uQeOgn16vGwf4+RvxqQUBAeSbnmJpfEfV8rT5SfKsqOe6Ab4z8c934UYqBUjETxaPAOYu/vJR8cwDQLm/oYTnsG+LH7hj2LHrQ5uZbEW9SYryieAc0l4lCBhPAOVz0LwuW4btjpgZWjNjh1iSJ2DNIx6oS8HPFatNwO8+DDj69TO51REakSwKfN/6nbGYDJDQMYRzUWRu3LRdapg6KHQ0Tc99T1Pg45X2l5BUBtv+IKLCS3PetKQnzNFVuFj7Dxo+1QDpV3CMGsLly6X2ofWX6kGmvX2dvVrhVbo7swycGQf1gSPELmGpA3mX9rQtT43G6TY5HZUDZ4/dZCJSIksZ9SXLJM+SPpzSn0j142iSjJgKDzU07Q80YPWo+1Jyupr8nl/mqVbUCWK1VJg8mv3cAGzTBi4betxXINTw2o4lzTFEreSjzhVaAZtf2aSPrITDOGNJ6/KeGc1dfJ6QlTJSTqeh+Ckm8zSl+kxZPGul27PpLxMNdSm3d1ZzYFH80bADo0QdZc0mpzU9WucVKebrNJ7H/wn4HEBnMrRtGKBxwvrVuz1w4VRevaJHxR08oEQ6OKfPoEdKEyzEtX0k5AkuI5ixI+gnqEKG3WIqwBuiB0MV/DvBsvHkpU1DvkURrBiUqpCQ3a0noNuh+isxLWmCWDxnZPQDJht55fDdCMlSN36L9jVxpqetrymLF5ie19ralhp6BwWBGxWSCvKkYHJ2ghM8N+LCsVJv0IZPFkc51wVTkqDHrF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?95jQ9/+MLJ7qmE6iXceUSVzQiqeKV3hdL5GO3rh/WGGWCE9LdL7ubduwmZL2?=
 =?us-ascii?Q?fEBZ4KJJmxfi14/4tqFDcN8JV+LOpkDreq/2hANJ0Y2cVRYmd716JKY4uk1e?=
 =?us-ascii?Q?guLe4PQVmArX/bxJg05EqzO1y3E8vRqUK/F0hmh3crIbvxmCtW/t8t1HwsJZ?=
 =?us-ascii?Q?mfHUi5hCQdKTabWnf3DAkXfL35lcsGeAYgr+WtxQuGO6e6W1uG3PjDdc9946?=
 =?us-ascii?Q?aUZFp3c5fDg3OFJWeyua6DoOhdnQKtMgz3IZyDzzxpAfzWYyQ/jYEelEtp4f?=
 =?us-ascii?Q?W8GLgBVtN9HufpS4uFXX7Dj+uHrNrhi2YSkWjgDso6nN+p8aGw7wWpOVndEe?=
 =?us-ascii?Q?MIxv8iaSltL77Vt3F9grAMAgVDBZmI47DfpJ8qRQFxaoqOUD8GZ3/RzCKvwf?=
 =?us-ascii?Q?UNrBqG0vvFRVppvLHGFw5GcIWLOb+c08vF/jpCqxdYtNAiu/tegKzN2KPIfa?=
 =?us-ascii?Q?/7gbWWV+b+xFt1ZwliI9zfII4987w2u8XGf0d+P8UQ4G9Lrtl7nlfb2Ovueo?=
 =?us-ascii?Q?y7XCqUHhbcqwmVpza6ciu2oUkDsq+g6o1CaQQltQxp0fDtxdO+s1AjKDcd72?=
 =?us-ascii?Q?a6ZtuKLjuE+i7oVpO/YpdfY3EHkzCgvILFgizjyvJmZdk1kJ6YAOY3Dv34Mf?=
 =?us-ascii?Q?Uli/Ygsd/ebpV+vy9WQOmvDbOL0x1ilCY3rUnEUcNdZk4pzenNVRceAGNCDX?=
 =?us-ascii?Q?hxBnDplYIcr2N66OHZroN9Wj4x5b2kXHY2HQeXOBQeDDkBtazfb8mN40Q2TK?=
 =?us-ascii?Q?5A8o3aItawnEHBXX73l4Y44bdQ06T3QwY76z2JJ7GgVur7K83845A6sF4mmS?=
 =?us-ascii?Q?qPoCZuz2mlhGUB2r8nUF/hHBVwLfUAbgYZdO9exBo+ZN92QBTF7KRDQOViFq?=
 =?us-ascii?Q?obS7SkvCQKSnMfUCHbERXhRkp0RVSs5834g6PVF13lVLq8SRXy/HdbQ5QXKD?=
 =?us-ascii?Q?3Vl7Fg0maAaiWm+1CztzAWJXFN/9+1OO8aYolRZ0m0QUs6+dvtef/Tf81R66?=
 =?us-ascii?Q?fOlIA/8R/84qT0Wkm5wh/svn6hf6hi4RVyqnxrWMDAe8bYr8CM25soPc+beZ?=
 =?us-ascii?Q?hZwyeZYzNf+4UtseDHX7u/K6H2WPbohmVDyDrvQ/wtFKAtvJICAvhYe55x+w?=
 =?us-ascii?Q?DnWyt2/jvTllft/+GuxBoO5w00VTeuHvYK28Ts7Poe8PLnnSC6LQuwkn+Xtr?=
 =?us-ascii?Q?f8MbDDX4nBIpPvvn11beMJGkLPeWB9Fw1zastvXMBn2pt1i61lACg+Ht4nt+?=
 =?us-ascii?Q?OlgdDHjKRmox7y2caMj3ZXx3F8dbLLcr6r58BUlt9zJ0rps9d6VGijSp7qAh?=
 =?us-ascii?Q?wEpzpDhSxcBlrL8InE1h7nrMzvxroR62qpMjh/wDGiwUstHFTluFoJDskk4k?=
 =?us-ascii?Q?V2OQnIlihNpUCzmg3Dy1spj0Q08q68MiJ7bVAYB77nHM3PcF9eV1O3Very3Q?=
 =?us-ascii?Q?h81nyn3odsWM+ZiFZMJcUGxFvfdb27D25lFNxcz/s2eNfNXTAhW7NNZn/hrg?=
 =?us-ascii?Q?oOr81unoGk4JrlPIJkJ3EDRhFQMUpU32rXva7He1l+awUCm4ityN1RdcqgRb?=
 =?us-ascii?Q?9kfM/xeVGt1JnUCyadGNzHdlSffeHpBgjSx8HHjj12t9nOJzZtDkHDPVJXm6?=
 =?us-ascii?Q?ETUaxpTMoGAlptHyVBxilUx1ioDLVmOWb+VT+Ho5+mSFECxUK3n6qyW6Udt6?=
 =?us-ascii?Q?HeytWPAkATEXct4jDYQobme3ad6qj0EvAEC5Rzj1ayrKNopBmtiP8fwIY93U?=
 =?us-ascii?Q?XmqjPwMSWQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7615ce3-ee2a-4bf7-057e-08de7e47f5cc
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:54:26.6993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dkpsy91DMAs9+enbUeIX+GzzTBDm2dUj9CVqai/uhebDQpV5D+OhanG5G+etrOW43tAFyZkdZ6WRUEqKYh91JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx95-15x15-evk.dts    |  5 +++++
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 22 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index d4184fb8b28c..42bc09e48b80 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -554,6 +554,7 @@ &netcmix_blk_ctrl {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_m2_pwr>;
 	vpcie3v3aux-supply = <&reg_m2_pwr>;
@@ -568,6 +569,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
 			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 041fd838fabb..6f193cf04119 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -540,6 +540,7 @@ &netc_timer {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -554,9 +555,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-0 = <&pinctrl_pcie1>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_slot_pwr>;
 	vpcie3v3aux-supply = <&reg_slot_pwr>;
@@ -570,6 +576,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 5f61866e9df9..752236afce11 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1890,6 +1890,17 @@ pcie0: pcie@4c300000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
 			status = "disabled";
+
+			pcie0_port0: pcie@0 {
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
 
 		pcie0_ep: pcie-ep@4c300000 {
@@ -1967,6 +1978,17 @@ pcie1: pcie@4c380000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
 			status = "disabled";
+
+			pcie1_port0: pcie@0 {
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
 
 		pcie1_ep: pcie-ep@4c380000 {
-- 
2.37.1

