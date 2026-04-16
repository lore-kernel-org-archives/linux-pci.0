Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF83A6F15;
	Thu, 16 Apr 2026 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338022; cv=fail; b=KuwZQS+xHq6tX+2usLShJUiv0umIDJHxFIIK2Jm0JuAPd2L9YGQpRkOc2vOx/dSJS6m3Zb76oVnKZFlncstFhH9Qj8lC8m8qQJj+MyApSdK0WX7kbVCsqHbSLA6G3iiwABtpV3+kXdgiHiSWnENw09v0vBHOi6iRRlvnb20IKt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338022; c=relaxed/simple;
	bh=2QrNdCAJJCRH6qpVacd7O539pJtn47HWWp4UJch0H+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzKp5JKAyJ7yPjEy0MX0gvP0CH9JJNfBGsbg8iJLH9f/ThN1hkdGp2YU9n0RYFfvDQSib+nmuJc7S3wsaLx2PN78GUU19HxG2r640s0p01JwKbNTArQt19NO7IYJw1HUHmUsFOBWu1gVnLgNWbyllCYgCEhoWGMVhXs0+faFkxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VBGt9Df2; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VBGt9Df2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvICwBPFM3ScEEv86Ci3muE9d4eU8nNHLEHU9pmWvmSTc4z8SAUlGDUGXzwCJ8THjrC36PSeFp9TSJCDxk+NxirGQSK2l+nApMKv+hyqwBb0adDSwt/yN0swwQqGwewA9YBdEgP9thtVdMWHa542kx3Yn6/Czb1Gsz+JXUtm8mjN9L9Z9q8/WpFSbk4Ffk7akLPiV7LZlbJhrmOtvfj8XlaAIR/M4uQjYpINVPeCYyW/Z4fBYJG9rwXyNJWfRRGPxesD6JVRp7OgLOqJNc0iPp5BIULpmkN0ucNtLKbWr2xWpTQXjoNNXu+jGU6hXlpY8mbKNDCdxRBUbZ42H2O+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=bQcrPvPu9MQUW0jDeqHkk7SWkyZrhZkFpbO0lPWMnas9M1XurQ8r2i9z/OryPAR54rtq90rl5/wta9pNaa9TJ0XzJ5RLPYk9iEihiguXMdLCjtxkknXd1f6C+pu8tmi+CdsoXQHpLjYkR4K6TsLPu8DLukME9JywrwhWimYVkhOnnIH4H8LmLlthPSYPkOwNRy/+sKcI1+j29BKPYDJxi1gdn/abpB61YFRdL1FOKmpspHET7JGVV10FKzhOMc67drxWOVvOl21asU+JxNGI4XJ6Zh18CA0/nfwgh4cCVc7aDJFaBBEQ0qetW1rHxmVJ4TD2EmWJaZ/sRG8aE638Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgr/Jjp3ApT/lbu19qZvUztjyAkB4ugK0PPupDQNwg=;
 b=VBGt9Df2AGsg4w2HlYRHKQlgW+g3Zb1bKktbi+GXnnk/ZkdRAqJ7Vjl3/L7cVSxbY0vktfon2OM6DvVAmCs9/W9o9PGtpwOLcjXPwVNz8fc0UCQs1hFu0ugwXkbUNpidqZ+LArG3Y9LysiEcPP4eZuEDSuOlEdyxO88HZCXlI6ploMwIJinsGq6Gaqi8SPt9wPnQtfjJJPCXazJ5rxqlxSvsQKu65EdMuadHk3xlbKG9q225F1mFMH0hIECPPRTYCKjNPR0xlKKYwyq2Ir5Er7W6zCZPYFMrYPu8L8m81neoJA40iUdWOvIUL7Q8Dz8/p/UMRIw9pM6y3lbB5hqfbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB7668.eurprd04.prod.outlook.com
 (2603:10a6:20b:2dd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 11:13:35 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 11:13:35 +0000
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
Subject: [PATCH V13 07/12] arm: dts: imx7d: Add Root Port node and PERST property
Date: Thu, 16 Apr 2026 19:14:17 +0800
Message-Id: <20260416111422.183860-8-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260416111422.183860-1-sherry.sun@nxp.com>
References: <20260416111422.183860-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 534e992b-1f9d-4d3d-aa48-08de9ba933fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|38350700014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xk/DpJfE8E26ACtLKD/EM50oyiEB32IGIxV6S0wH6ZQX5hxY9fWegt2wvwrNmvg4DgKEKiwihY/zdnECvCSkimrOrKIRw6YPiANkHxadOd4hDA7QOum7XWeKKpAs6QxcUp4jnpAtEARqMR7+rZPXY16l79CwnwjOcVQRFk3IK2M9OTVrwWRDAkWf90meYW+BK0dVtkNjxJrqMQXmFdQTy8NXO8n3crtzlUXXrPP2jX0qn8FKxjq7PTvzxt6HcZS/YWObpLj0NC63Y+P0N0go4Hif6SHveaKPgjL/avI3G5AdjfGA1Mx9spdVAKt469ikWS3RUKAL2hkP7GJvCiqmNA2XfehDeqeiV9+VwGuDBBpsc5wlkGF4St/ZVYhd/TPFKcCBDsjM2+Kj1Mr3xjvoyBbNFNTXbh88/enkVvvlsUQW2ez0Pp6FwIxJP/fJIAgT/MTJphU7DCOHcewPp9V1ULpsFoMuerQMi7hUYQ3ILzaK4+zh5Y4AavZ841CLaqrcaHmgiXLf++QkrrKrs6egO+GlSQJaF6dSjHqqJ/hFteGjP9o2sH9q75pyrloqcDrpeXi/lFFM7023vhZbeu+MKh9ou4IUPrtukOHyKBgthoV7+U3xB0zSz3UZY6nNRXiLVz9qFru+CFhYmUczFZyr/j4wg3YEcM7rPYpYT3cbZAa5hJQqLSCHAw7D1y3tNt0Q1Ui6rhZmsZvvGRCHDAVCIXOQV+n02ygdpGQiw1ZY8DzP4wuBug0cBj8weY4igzB7TMWyz342ZwV2umhbLOV3tgFFmcDhvlF2LV+yfRR67DfmAKo73J0bLK5Q1IfPsbPj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(38350700014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DjVAC9kWZpD3c9mTN4mt4+rQFLFBoZ8sTM6fvGNax5TzUCYopH12pF9emV9a?=
 =?us-ascii?Q?AgXZacLPY7WwIoWUlHSq/8RUv5JjA+7RJEaYVbTkZyCrBuVJnAyMD9nTuuoy?=
 =?us-ascii?Q?NO82Vkoy2167Smchj+Fd8BF9JC9FozhK/MBqyggWKSkfXRKVAmgAbHH20y+I?=
 =?us-ascii?Q?kcqhrsXpozOTxKiM/gJChuzgJJy3eO5DiPaK8X2KDKMoFJQrN6GxsT4vrfw3?=
 =?us-ascii?Q?uLpeX6vS+PTQhQSDeTyj/Oi2pGNp1iTiCYf+aDUvm6AHbx5ypXI/RRxrvPlw?=
 =?us-ascii?Q?sIoqkd+GMp06ZJSw20bZZoKZ2oiENZjCsbjw/Wsy0mG5ANlpvYtrwMxmipT8?=
 =?us-ascii?Q?yoC7q2ce8+yQm6Awh0CW2ev0QwdsGIKpmf0JBZoOKT9/tSlunXtA/UlUoICM?=
 =?us-ascii?Q?qk7Hbgn/aJSDJYVzHaxO6E/qSNxduFfYG2nlhTj6IiQSlWPEyg+bGTR7/Bdq?=
 =?us-ascii?Q?U/1YHAyiIhvGgGbDbFZxymIQwiOcHuklMEBrEk/OrCLoeCVYf26k8mb7Qsw0?=
 =?us-ascii?Q?fobb8F+4nGZ3g6m4DnkoRWmWhHC9y8uRHIq+bvdbNXLUlbw6xmDQOT0Wgjxe?=
 =?us-ascii?Q?buDmvAubpEnMaPZCBnaa8+5/F3IX7EHhlcHS6A+e+FjgnGDMqssHqtgxefQH?=
 =?us-ascii?Q?LYOXLnHPYH9PyZstnq01EkT1PRnP3oKpz+NL0CFMElxm7nPMGs4YipUxmtAY?=
 =?us-ascii?Q?qMFgQWCgoCcn2vN0mxfB5qsmtQn32rIj+A5kJwbiVz4GyQLuwS0adITf3sD5?=
 =?us-ascii?Q?XvlF0p5Xr6l2AhvcGbsh19Ku7QrPsu15djq5oKnhF5pJhS8K/HGH658us6XU?=
 =?us-ascii?Q?e6oBQAewNoVe+e8b7ZAIZKhJtnnqSUKFTkAtnUrw0mbWv8ipFs25ovBhh5Py?=
 =?us-ascii?Q?CE65IyMYm925LpyC8TxShNrsgzsn5OzVA7/Em/Z7Nmf00XUkYHwMHtQjhw0v?=
 =?us-ascii?Q?zE9zN8oWqMJ51fr7psGXQhtA76d9qe+msZM51j3U6ldl/++md9pUGUWKmIkQ?=
 =?us-ascii?Q?W6ZwNiCHH1yRGTtK+0CmqftEKUfEAs0vtMj1jenL3MMN3SpJS8fuMTPGyxwS?=
 =?us-ascii?Q?nJ70nfgMQ92LF7p6gTvwuUMsxh3t8+DKvT042beGVD9dia79wHfcVMTmADPC?=
 =?us-ascii?Q?m2be/WYuzU+63RBqJ8Fg04nA67lcwloXCsyojLTJn8GOjh1GfZdOFTmcg71+?=
 =?us-ascii?Q?8wSib9IgEnSp7yfe6k1beMHv5kswdX3NAlMkKvKeV2d4YkchP1vCxPyigZzA?=
 =?us-ascii?Q?T7MYQf0l5MWKz2T5rQXAUnm7KE7JLrPjFRlRjefXMbEu1NKY9zvt6qtUI0YN?=
 =?us-ascii?Q?6bL1DWrAJZqGVPixzW3sMkj8X/iMoZNysENiSBtOA3mwOcrpxVHgY/cIyUzC?=
 =?us-ascii?Q?y8W+PoIzaMLoXOAy444V6UHwsQMnNHdTajFJARmRpxNh5+aISmfMAmV8SkAb?=
 =?us-ascii?Q?AOUJYCbplYJaY8W2z7o8zAxgnckzZvBVzPJ06XwIC3W02wEChiHtt3xlRTps?=
 =?us-ascii?Q?hI37BC1AuO9F+RK72O6antx4k90TdEFUxMavJxVWGzJ9Us1UXRNyjiDV85IF?=
 =?us-ascii?Q?fV13QykkpMWQgH+VO9gsnvn1/NsrsrYY81Dzs1IlW9aZdrmxP+9nPeGXfVMf?=
 =?us-ascii?Q?2chuNTQ2UGgtHu6iPFDh3RBkwCWZkqZ/j7AqKfFOE8iZj7LZrIMFSarvIz+b?=
 =?us-ascii?Q?p28Fx3/9uCNlFRQJmpQagdJ6oaNrIIyTp1R4oYT19cWLKjGkkQ12HihF+qy4?=
 =?us-ascii?Q?MK4b4iEHdQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534e992b-1f9d-4d3d-aa48-08de9ba933fe
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:13:35.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkzoWoS882sNAZ59yX+cjWp/89o59WfDQIwjHC2PY/ztMpsvmY8aaAUkGpQ91KTxO4w9vWlb/n8C4hxsMdcHlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7668

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi    | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
index a370e868cafe..0046b276b8b9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
@@ -456,10 +456,15 @@ display_out: endpoint {
 };
 
 &pcie {
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&extended_io 1 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&extended_io 1 GPIO_ACTIVE_LOW>;
+};
+
 &reg_1p0d {
 	vin-supply = <&sw2_reg>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
index d961c61a93af..3c5c1f2c1460 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
@@ -155,6 +155,17 @@ pcie: pcie@33800000 {
 			reset-names = "pciephy", "apps", "turnoff";
 			fsl,imx7d-pcie-phy = <&pcie_phy>;
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
 	};
 };
-- 
2.37.1

