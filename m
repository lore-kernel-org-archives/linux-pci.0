Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863A3939CD;
	Wed, 25 Feb 2026 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016922; cv=fail; b=tSJkXccpHNRKqHR3xcKT9gollsnyZ+PoNZfyUgJBF027roEZTKz+hG8TlaQP36KwNdvQh3FDznAYi7hEVErU66wMjXCm8w7C1R3zuyWtoPvSfkhs6C2Xxh3LflRC1whziBVsJR05irrVSlYXYzeHqUcx+DMavqGiL2bMcsHP8/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016922; c=relaxed/simple;
	bh=c/gn1HlkPHMkjtsuvTDG57XBRjv8qGy/sdk4nwL5qho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yy3mHvu7ak3GpGvrwPdM7cMHnBcze/SIwxJ3J3eJQyTmSU7EEZ3Wj741tqQPh/B4XblCiQ5ViHmNcBGjwu2o/zHp3zka3kIWb+jziAFufUytcCR4b+3M8Ez1QyKhl8zCorEAR7v5ZeG/J2zKYSSPwNhEZoClXCUPk13RCeAfdwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WXzZFYj8; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WXzZFYj8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0lzmNKG0XBm8hKYbJ2msMdAi+7kayW3iGLnUAGsXdKpMvjuCWosomeQ9d1qikVfEztFbP/9OhGzZBwPtul8butdSXY63sjxV6ZGm1Jc1m9ynWWMsS6xkp6i7X0Xnxyc4z2GZL8Q4OqGeE6H6M+SKDX+KRsfHTYkCu0p7Ik+PPWsPDmKuzktHir8SdJAL1CnUaYoufbGSCuGZhTWNjaJD7bHTZnIUUwEs9qzpKxunm3aVwo/+PIbc3XCkBHqIaN+Cn985frIlXB/XlQanZ4vlfSqPaWLp/1JzV2M8yGh1S/sSDg6yMZNMnZzPzaPWTY7SUYViyk9OJvwuJKIBnNpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7w42lO/mWxDp/BZV+doM4rBKxlvzdjyqDCu633S3Ng=;
 b=oBajPYJkCig8nJRLK2Gwo4BIM0EoE0db8m2eNms1y2kNKKHwbWHRbfC0a/57bodnHVulu1Fup5edIsASzVhh/FRFdGEAUYd3sy8xFNOn0G1wswUYrvDxtkBVpbHfikdCHHuYoHOnkURVO/o01YCp1TrfpffZN7eKutY7efr8pqJUTrAptlpw9iPtLh7Is6CZSNm3uAJ2w0T12anyk0+iwhpPOYJVPha1rX/CjN94gUvGMtaAXsfCR2PD/pQh4YozT3TGkWa+VqwtHhWb0AMVFMH4ZCtVo0OE9Um12slPdwvaSq2Ri1e0c1QFHYBqVmwtsvvwkpjJ25bxxhE+O0HZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7w42lO/mWxDp/BZV+doM4rBKxlvzdjyqDCu633S3Ng=;
 b=WXzZFYj8mW5L3UVqirhPKsLvU6r2lYee/Zuz/WONE0Ec5r+YVSvmzrbLXMMAYssjiWj7yEz+QlHt5KWYK6QuofYF5gy0sPqZIFDTQ0cGr3Cp6MGqWYk/g3Oc4ptrEXPnaFTFNxhJN8yXxpC1xlWVPjDMbpzZgbT0G0J0dW5bDvTPWi09Q6dUe1XqZVxdgYTSdD5Ok/+IbGoNR1PWe/DfuiVIeLS2X50CHvNtteyiFqjdnpmU0/FFkKC+12ZFm9DkqJ72w1QerwXMSDuait1BHQnU3U4cisdgfS2Qn+/2qPEX6GU2zNrFX1WntqaScl1gb4+zKjY1k5bsIsOMEDs2kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB12224.eurprd04.prod.outlook.com
 (2603:10a6:102:561::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 10:55:15 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:55:15 +0000
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
Subject: [PATCH V6 10/12] arm64: dts: imx8mq: Add Root Port node and PERST property
Date: Wed, 25 Feb 2026 18:55:21 +0800
Message-Id: <20260225105523.748775-11-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260225105523.748775-1-sherry.sun@nxp.com>
References: <20260225105523.748775-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB12224:EE_
X-MS-Office365-Filtering-Correlation-Id: fddc8a30-6edd-4299-c2ad-08de745c5b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	96NTC4fEzNjz94hI8n5SWT9uf+3RoMDDX7K6YQTqFV13t6ze2HCEnRF6Q+5oovP+aXqZTJEtAE6O+eAIc7xWnr1SMyBkKy4gqn1es0MRmsXrUWd3fe/DXPjqUO0NwPGZLXdfEIS0furxlhWjPPoZ4a6mUmEG9/ca1Y5k4fS4+zi8KDmPl/tdScYpzGqayNQkNGyuMYHW2bLbzNHtnfAcK25J02+zKVW498tsMz6GdpZUAFsnBFcsdXTPAER7mQnnqZ4EaiK8x1ekYrOlIz+RRkycQMrvcpD88rShV3ZuFyGhRH06e/3MkyX9T8gaDvr1cvChMk3HABtGAmSaPlLJj6TD4QAHHxBn7x7UG/2KwzBoNhJqdAUXijLr31c9ExSfN2XHzeLCYlPHdQZPVp9RI8zRadAyMpcDXE2XN3YzwzvdBXDe0J8atrqOWY+VUe0F9mkfjwREcW6YD6iLCnp6vRderFfBDTOvwrfJovLRutOe9rTk5Kl4JBpAxiaVUGV89x/xgjhsLWyswAIPoP7prrzdNJioVgMNUGjxP0hMLVsgYfZKU2rAlCn2FXq32G/O0P5eEHQRtP2IBZ2uy/jElzAfpqEMLHRI4q9v5TNi3ljtzG35PcbQcjbpFIOF/SpArI1fx/pzMi1NvETUaCINA1KAL51kTnLTa63O3DaGuB3odbIthkMWEKdvVPe/QPoqVwg1YiJlQJxZerRYh9vZHtH5fk/1IF7jsJut2VQ4THU6har/ybDPldGO+0BCJ56HksTFHRM5zpqzs7kP232HvWncAhBv6akBSVbCySz77J+11ZPXGDXRr6H7qnum1n6b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jvrgHpHl1dGEnbUeb+nIni1htrxzD6+RLnpeJVZx+6xTE0nRu1+txiKGuP/j?=
 =?us-ascii?Q?fYoTpWjGw0URrWcEJnty9q7FWAzkyUPyCfTqwCXEbSPeThPKS9nZmvrtsz+C?=
 =?us-ascii?Q?poCt4AyVgVfGmVgK84g1cjy2KEUp/WJAhi9q+4xM1AlnNyZgYoqO/VZ8W/0J?=
 =?us-ascii?Q?jpI2O06bIJmkLGThEPooaFxG6i2WU8bTWTw39dEL4IQa8QGue+tJ0Z0pgKaU?=
 =?us-ascii?Q?C8e4chzM8fGjrLr2Shue56XhBLEGCx27XGElQe9CAJmfweroKp12zd0mXx6s?=
 =?us-ascii?Q?xidP0zHBjyETconl29NkAjQ3z2iaajLFZggJk7LSwg/mVGXJyzZTtHlig6YT?=
 =?us-ascii?Q?aCvNeDvk6v/pVaf9n3U6NGTKuJIM5twaJppkyKoBqzIqtnaUc334hQZBREI6?=
 =?us-ascii?Q?g9j8hrdT5dJaBzYC/ui0oYJHDDpybyBeFHzIX1FCk09uyNEJKnC6e2v3gW9I?=
 =?us-ascii?Q?933vMX+flAyOkcCfWjYJ3kBUVhbCiTqKl/zV+HCCY0K02sx6whUVGpff92rm?=
 =?us-ascii?Q?GRjVjvPpl8T6qjpxZMQbhzMLIsUlstdYmpbMMPkeCYrHH5mazZPNlTSVCNkh?=
 =?us-ascii?Q?4oK0DQbuZRX0Hr8RMO2i/+XBMIrVGYIFO2jVX8V9+tAwaRRQJXFkvOstP/QU?=
 =?us-ascii?Q?6i2V7NRGpzhoEaAWLeLcPJRgtfQjP0wWBigba5Of66eOk7t3tXGEogZ/WFBl?=
 =?us-ascii?Q?4fjzjC3pBh02OvczAE5Mh7f17Ny7xNBxY76SQr6nRvuGlM2+l21xKs01fpC9?=
 =?us-ascii?Q?c6arA/phrSpmE2vMDUqO70q6FxkiE0Sn/ZbPNh6KZLoGxdl41Z9+bFG1/Iua?=
 =?us-ascii?Q?9qG5iJ0JKKHYtipMOlzC9YrLKAv2ifiDtbJWhzDiQIbqqJnAM9RXCBqSIgcH?=
 =?us-ascii?Q?38nVg3kykGlbi//Kpqq5bzbMIp+KkM2h2n1dmrFTaA9y7ssmgpGYsm+dRS1O?=
 =?us-ascii?Q?BHdpoAM9L13qvksUBAlFIzkeUwLX2D4Eic0RqaoiMPKHzn7rpT4UtWqc/V8Y?=
 =?us-ascii?Q?LOHhrfbnP2bRFPksH4B3T0MU50sEpUXsoQPv9ZnoIe1yX7vvKF4TH5hOwHDv?=
 =?us-ascii?Q?/HUrQUXWq0iRPf2AlfV1aGW9tOFjwPgo/eNvPEFxT131AtczvK3yxi904HyQ?=
 =?us-ascii?Q?tcvyZFAQXweCPmMjB2z6sUG98v3rVh1tPTGBhBYmhWGLjnJ7NO8T/aPX5GA+?=
 =?us-ascii?Q?yNSOfzehyRc2jPRl7mTml0B1JRCnl+3pR4WmYJu8DtjffDQm/3ECI3eHYoTu?=
 =?us-ascii?Q?jH3nH2JGbasfy/yrQR4CKGzLlZsBS2qQ/uyNi/NfAKDUPuiQGOBa8tX9dkLE?=
 =?us-ascii?Q?ztbJWSKAt1ZNZh7ZTKrGi0T2dO4MzUo7rq7/0izAjELGPPeDLq/R9z4QHQSm?=
 =?us-ascii?Q?kSF9CbUY878Edt3h9/ZG/OGL+A9rweZgKtgyHPSPBIrphAa4+WMUegk0lZON?=
 =?us-ascii?Q?quHQs+33FVD7LQOfgEe/iEoZhYg1DsqE1C7V6ci2BKecanZNpaNLEjq1XTFC?=
 =?us-ascii?Q?rJpv4+HNkqJoahcdmzn9bxjyWdIuwUI2i4UolydkweFZjUxsuPwW7or1wf33?=
 =?us-ascii?Q?odbPizLI+2X4TGeWw9LN6DTpwerBYTmz29JWpZet05U3PSq4hSkWUrrLiid8?=
 =?us-ascii?Q?81ABKMv26kQ7wVcv7wBb7XeXC4CIe3T6ABMt0VyIyGvsuidrqoDJs3LjG/EU?=
 =?us-ascii?Q?tp3V+slqj9D5JEUM0WZSDgV+dU5tBYJnMZoFeJUuOvs0AVz+XnnJQDyGyVTh?=
 =?us-ascii?Q?JbWBFqL1vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddc8a30-6edd-4299-c2ad-08de745c5b86
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:55:15.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YzloSg8mPmRnliH3A36MmzstgRIGw1d2oceZ4TFM0IWKWJCZNCe1gO73a2ZkSZVWSVPb+SA+4JRTObM2tFEKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB12224

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 22 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index d48f901487d4..e7d87ea81b69 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -369,6 +369,7 @@ mipi_dsi_out: endpoint {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
 		 <&pcie0_refclk>,
@@ -389,9 +390,14 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie1>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 12 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcie0_refclk>,
@@ -414,6 +420,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+};
+
 &pgc_gpu {
 	power-supply = <&sw1a_reg>;
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 607962f807be..de2ba4ee9da6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1768,6 +1768,17 @@ pcie0: pcie@33800000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
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
 
 		pcie0_ep: pcie-ep@33800000 {
@@ -1846,6 +1857,17 @@ pcie1: pcie@33c00000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
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
 
 		pcie1_ep: pcie-ep@33c00000 {
-- 
2.37.1

