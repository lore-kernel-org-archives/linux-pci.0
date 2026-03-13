Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F4D29994B;
	Fri, 13 Mar 2026 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367745; cv=fail; b=duuzudQ4RhswP7CyKg3kWp4VYavGB06pqaB/5ln8gqa+Hnv4gbBOTVCsG2C/HMZl2a05JZRnCuM9O3Nxh49lbKqoa9A9Yj07pDQ9r6YDfj+JQqgFOIm8m8dktdOvRPWoILWTBRrp6PJSAo2G5kkUnYNf4bZrdJfyXbwQ/y0ZSj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367745; c=relaxed/simple;
	bh=lXPxyHTx3z6rbz5mIXWBmnOJcdOXlkWs0orjbI6LUb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2KpbyVwzOwu7+S2jD546e0xLl+80YPSl02NIpdyIj7NVNpf1KISoTQca3o30/yAnahW/gxFT6TUK2pTLdtaiyMJKoaiGupEKt0DY8dCkK14no1bZSsWbE3P8JK8tpGkXFPJ45u3cmV6fOUrJcNhxhR8l4Qgj2MS/QD5KWXyRlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TUf2YFQ2; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TUf2YFQ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwbBTeVe/T2JaCu93eW/ACdSXtZOVFmc0RRLlL7UrVpoYvgfcmglzqhr8WL2Vnvm5EsEmBxUYxb7w0WtU5KMjVSErbZLwgQlbX4MxzPZyaJiQxAm3zEdT071AKZ9Qu4jSH+IThBwyB5F1wZOcVejoHkcHZfgzRnJweEtd5/bJKK1UqDlkPl+0vA2fPlyWEkgOZlzxmyDuxVBDOAKz/kigkH9W9Chf8ZScz/7QoOqkdy8SmCnPkhW2cWonfvlabRX0fO77iu9+/3GYDHWrj6bPVyL6PeMu92q/gxXgGsTm6c65Z76W1yZLDFpsHDbalNmHiPHk88NL1A9YZ5wmU231g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCy24QXHvyxpiC6tC/9ukxRP+QZQp+WH2riOBrAV2nE=;
 b=vAr6WQwuga735zG54++0+p5vLW9rdbUljQUgd8PEiImIBVqBpmq4QQIPuVwG/6XJUAzwoLPK2wcKu/0ZvVH/Z77OXqrB3fn7U5ykzQ8apIQtdl8GCiXfnpv0xv/IyxGLYTmgATi3JiLa0xFGvY59stKfW9Zel6BAza5CgePULLGelSPOxJFNMP7qcQwL0TfNL/eT708MrCrVbtNGwJmHe0IR86cMERLc0vXwjMUIQRhiNypVBgmUxm18qwsjUeoxKkyXCyyMzNLtXnyhlTJ65f0dAn9O2/aqKTChETxYxMZru0IREWkz0EPxsWUS6CWnpzNeR9K3L4HQlHuiTwX7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCy24QXHvyxpiC6tC/9ukxRP+QZQp+WH2riOBrAV2nE=;
 b=TUf2YFQ21UHBp/V27rCf52d8+uE9+0bBQ9euxeowcy8Brm3b99nXq0h8N0Gy8rDlFTdDPo5aXkULbMfy1lZq1MvXL+e9Uj9GtD8JwZbA9ieON2jgr4fOOl/KuvmyMutE9RTiVosH5C0BNmow8VoPBH2ba7YQGXptomCeKyQQxDKHI8dh+HDVccdrK6L8WI7M17Eihtk2m74AVRMFjx/MAVqtHxHPo/ZTR5EoOPI4l+9gO8/UaoonhxDPGek/M7s5dOula49Y6vXBG5v3rLq2vhg0rDbbh+nv6s7BMKY17O9iYLlvteDciDLby//+kixYVrgle+NBDZ+rFaeqZ8c0fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6844.eurprd04.prod.outlook.com
 (2603:10a6:10:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:08:46 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:08:59 +0000
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
Subject: [PATCH V8 12/13] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
Date: Fri, 13 Mar 2026 10:08:22 +0800
Message-Id: <20260313020823.1592389-13-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260313020823.1592389-1-sherry.sun@nxp.com>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ac8ab0-a050-4c07-4a63-08de80a57d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tiMyZliSJSUJapt/KXqMO1e6m0HL8UqZ5FpSTZpvFXmcICv+IBCvImk3KGn+eTLTK9D6Nj7tGU98Fs501rxilvHhrp2svWoiZDJf8DcvSRxq5rw76H6QYrL5tRnbG8yOnQZe0eMw2aY4IkvAvdxqzaOhsHBAj1DDw+waoAhgK7EJygp/eenKPUQGNJ/CUmjJNh4bjmjhM57v4d5ehz3uxbbcS9z4NqFSuN8ATC4zulpYDjMq7G8B2/BbCnT1N80HD5/brjHprlrs8foApsOFTFPTeV6RWzYjxvcSBKYCSq7Yg4yjO1oq5IQ9dm16c/DCsVGHNIU5T8F4UyafgsmHbk6solU0l5kX00Babz7eTYQcVxim+zhkvSxKcRANJq2xXgDSfX1EwnZhuqmkphop5DTMK4CjesVxwZjsiJUl32Xq7RR7nOlwTwWmnSmTgQ/J22rwRy7TsRK4Snwx1A9IHstvAE/RVxwJZQHc9Y7Re7BUfKyMNdaXU8IwM/2Kf9PuYeK7usYhZPqVwXxn5P6vWMmiLXkFuvvdDJrVlYOngovjCwaMYnGJrCYjprB8jDwWtxgiU5zHvyiU7nnU9ns5ScaDpb8ntwcbe3JhumjqQcIVRgd7SuwUi4TuQdV6LPS0p7cfXuwErOhIxz6ZSVmwYtPWHr63djPrkdLUyslixyDTfbuGV4RHijLqLcFJu2gWpc1BFazt0hsgm+k23SWEXh9wSUoWg9As5h7lp2zZ0rPBY37mMt4bpmHXiJVllhIjMApt0ktRqqaPOYetSAHYGdJlOyxR/OW8JWfvdAPAijG1tfJsXej0xUfQxuRSVbMw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CpssV2N7ktX4E07obqOIzBb3AtDIJivV61IJtFdyqeaaUgF0aZDuEJgH7xg4?=
 =?us-ascii?Q?fQ/9GJOKgT3CeRq3tYROvopOujvqd2HsJhJqrVCDHE0wkII5Q4htxjSDfgE8?=
 =?us-ascii?Q?BPVv4pMFFc/2CGSsZpH/YZ3eCADgXcQCFvAequaICQs/xytDJB1skK37sPEs?=
 =?us-ascii?Q?1JOZ8InCv1/C3zLcVTY63fp+mLhbhySuVAdaNxwBI89vOPIzflUvbuVndWHJ?=
 =?us-ascii?Q?sJCm21RJLycIXgK3s+PyvNKhod5U8IAAnmYAL2HA1DXvADCPNOxv3IfDBW5E?=
 =?us-ascii?Q?wTsc+BrlZcNfh5BFtAtTpPWFbqkF+FE5EQPSMOVfcVjYJFEfYYlQTXqQHS3V?=
 =?us-ascii?Q?ZfOq7A3iXnr+iDdqBC16zjwP9irxOdUCA5fkHtAUwDctQ+aPFCiEGhSk7DUH?=
 =?us-ascii?Q?LRNtwMBwVNxjMy3hMBu+HwH1qFB4bp84YTCRszoYNLYJ61fkEvVy0w1dRib3?=
 =?us-ascii?Q?3Pp91hwU3ogyn5ZRn9V5BKpGoEutqduNuF434Ac6GK48+fs7dV4hHwQpZqTb?=
 =?us-ascii?Q?/i2ZAGMGjFrBMYihISAL3/UV/hZDuQSMPQ7hexbNoS5htnJXtW5qShhRxINu?=
 =?us-ascii?Q?DBM8u4fpHPLUNoch5JvSHrYR50UBoCEPWaXGzS1vlpI9H5w3hjiu+R1lOurk?=
 =?us-ascii?Q?PcyX735E3FGWtaLkYycLGxITE6NFq2cRCdK5OvsW4u8q2FfCmwvpezqBBhEK?=
 =?us-ascii?Q?s1RiK/+GH/J9YUEu+vomO8rQiXUpjcSGF/5f8jb46MvUROXCyuoW+CU2VeSq?=
 =?us-ascii?Q?MmThUSwX37OPfATLEYQaoC0fiJ5niAQAawbMtd4ylOgHClCuNs2SnRwISMBR?=
 =?us-ascii?Q?HluIbZMW5KxcyOeprVpbMxFbD29g9hnL31FPi4SMFbrJ+GFw0l+fsNKgnOro?=
 =?us-ascii?Q?Nv+zV5UW7N75jos/3NbB87pdfWcBEJbm8g+tss9C7w1BQDMcaeDnlBsX7ThO?=
 =?us-ascii?Q?zZBr02SKMO6FNvDXkaG9Oj/r1TX0LbZBU2psw7c1HiPM06RjAOE4W6XYKNlr?=
 =?us-ascii?Q?PHxlr+4u4XtipnmMTnGtPCbgZ+82l274bTd306/aNxcryTRGN9lMfaiK8A5c?=
 =?us-ascii?Q?AMjESLjRIQaFFw3iIKgbC3HuOJzCbhT8ShT6HltSFuJ8rHhEOyZP+0MkSOYB?=
 =?us-ascii?Q?z4Z/koRuAxsdtkWUE+VWwwDortE302piE09rsDF8SnpezkGmz52Hf7lYyhhv?=
 =?us-ascii?Q?0wK0ooioQ9ig4M/zxcoLmpIWJOnGkhT5Edd0DHyA2Q8+r1DDHpsiu1Y0itIr?=
 =?us-ascii?Q?VSjUaEMFPooQXSTwFdb2s/DzM9nozr2u9GwaBFGOq1NSTPMaJFprT86ApS5D?=
 =?us-ascii?Q?V1udpTht+n0Ps0p5YFd0KNnak+uPOiBp6eg3t+btv0bMEgPgJ1NP2oCnOD4z?=
 =?us-ascii?Q?KW532uw6Mcetx2nwy/kemsYGeEHdc5CBhDUKt+XWGAwTj0U4aYlag7H0WaXA?=
 =?us-ascii?Q?GOzKJtjsn3Qx4fCkCsb/ZnX0h+BYDmgxzqU6ju4iYPv6NTcD3y7hwi+KFqnZ?=
 =?us-ascii?Q?nfF8R+XjTAehL85qBfbawkMmcAS2Y/zUTpy5bFsTDZEddc18dHOgG4clL+z5?=
 =?us-ascii?Q?9+VVAFl+anGP7rG3zXRLnbuEXMoyvcIUc0/U9CBQBn8yxspSKy5bPQBItLfj?=
 =?us-ascii?Q?2zLdOMLFBwnnu/xK/+xo22RpWyRdpK6F5fsBvf4mDCGbUmdFPF+MQFmnL/B1?=
 =?us-ascii?Q?lm4Jon6MgSK4D8u87719uvmqYtPux15ft2gMootK+MFenfB5Dbuc6zjF0KJk?=
 =?us-ascii?Q?xj1torG6HA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ac8ab0-a050-4c07-4a63-08de80a57d4c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:08:59.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhRKNfFvatgGzTZn81MghZB/DsVfI2bWFNLtvMo2coMkuARHIGuGlWwvRWU2maS5LCP8UE5qOMMCn/eNBJh93g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844

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
index 5c68d33e19f2..8f2c2bd00cde 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -651,6 +651,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -667,6 +668,10 @@ &pcie0_ep {
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
index dadc136aec6e..02f7589bd860 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -802,6 +802,7 @@ &pciea {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pciea>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pciea>;
 	vpcie3v3aux-supply = <&reg_pciea>;
@@ -809,15 +810,24 @@ &pciea {
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
index 40a0bc9f4e84..cd127d0a0a75 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -722,6 +722,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -738,6 +739,10 @@ &pcie0_ep {
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

