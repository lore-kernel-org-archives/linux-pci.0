Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F083A6EEF;
	Thu, 16 Apr 2026 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338013; cv=fail; b=dgpletAU4pj3IRwXMIhsbQVs8TDXNRT0QrD5pZivJr1qPALQyhxBRMMKxvcBue6gRepwtqfBXhvoCMe/83N6zZn7/afKgumYCGc8LyuR12Cswd+rb9RIYZgGekdd0Qp6reXXDRT0ohkWWUhp/M35mEIBIpnlWC+xpSvxYmLXwls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338013; c=relaxed/simple;
	bh=A6iRAkqRTnQwRrqLsS8rJAbdrZY3jnB8fB01H7L3KCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OfybyyYqyZTcb2ykMVq4GuiveWjqDnefhf2hZgjYeua/t/A/LPecpcCKmegWx+989/Lrv3qJ2ayQl7DeKv+WIqTw06rGYSXFSdkC604YyeUY1ZdDcdsurxt868lNWC6QHg4uRZRZPDBVsA1wxj4kcMR7I21NetfKK6KHEb5/wj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AKAVCnUw; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AKAVCnUw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPKASYsw7txEU2YRMQGw8GC8ju6wm/b6lKBpwoeZJY4Dz3mqTF+/mIbPGpwE18ZIZNaOwxxgoqUN5j8yGLd7xEyZx/pXS4oOy0P9Q36OHdcTdUWnOOGEoPK2UTUvZmrfBlwoL4Ck70nV+TQeJ7F9x6EQZnE1+iVIRSy5oxKm1K2j5X4ZD2bVZiEJOKMhrEU5du8shM8kHIKsnY3ZM+At4/VgpotPIcrz9a5PxUzSZivkpLLC49qMk/Qs2pvv4W+jYsqPAuNgfFK4fnHBuvEwDAGfLVkskSmChh+OyelNQ3udmsrUK7YP3y+vc1AXQKMzVM0FyYKZ1TALwlko1krILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5tYCDpWv6EjTF2fSdSpZ4GDpJKWb1qXmwlQ8MhQsyc=;
 b=PyiTvGmeAEYEMZ2j5fGIJKiM6MsiQFc8pS0Pu2Wm7vJ8YpwMyAY4W0BhdfRe4roxABKdzb1uhlCazTa8/bDhygw6Xn+DjQDGRx5DaESPfyVVA+ghmHOIjIplRMoSrIMSSOFJC6uzyeMjyt7k3eGGLLyQnUQakwFruyU+hOej6XxxdV7VNLLJ9t/8TZ3NihYxqe+qZTtaR/0DCjdVqSiG0bzzJ4phm9s9fqjH6nlUoM5JepW8QFnO2LZEqlffOOdibdQa3Mczdig8RLEjABs1r5XvoC9PKAqZZ4kXFozK8fKx6ld4sUIXX7jBjf9sS4kf7n8H4OECl5MmEj8wX7OCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5tYCDpWv6EjTF2fSdSpZ4GDpJKWb1qXmwlQ8MhQsyc=;
 b=AKAVCnUwJHIPaVbXBaydDGhUI03o8Sc71aAWo81PYmZ3j4vxAcg6V7lqdyuMwvFhWTXbapVIpJAVoWqhjsCO/LksIP2n220x8luOpv9inMbSGWtAjq4Z0ZTvA4D3dQL2iWMEI9VwkLtwTwM3zP53lOu8dq0ae/Lmn5hPFcgFsvvcz0zx2LseW7jeAhCMi2axZaunsN3/FIcdEtmHL2qx3noeKRuvaLN8E9PKfNE0Bs5Dki1RIPie2zux5IzbNHpocUITH2tt0eMFmLaahcVGQuRBB3yrgs/zURptOOPFTvcJAUhcLYZGbESGJXzu2vzGojrEOFb6ms31pFo1AFJfdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB11533.eurprd04.prod.outlook.com
 (2603:10a6:10:5e2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 11:13:29 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 11:13:29 +0000
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
Subject: [PATCH V13 06/12] arm: dts: imx6sx: Add Root Port node and PERST property
Date: Thu, 16 Apr 2026 19:14:16 +0800
Message-Id: <20260416111422.183860-7-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB9PR04MB11533:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4e067e-62f1-48dc-1c9d-08de9ba93044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|18002099003|921020|38350700014|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uiMgtrbAH/4m6KHcgxTjjZEE7EdU7GngLm5x/L9o7QvRxqQf1bDM2BSXnSN8evteEhP8QIlTWookyB5Fsc5hlzw6IYdzne5itlYYCOiaK+b2eJ/EG8IU01mMtjqHJuCSLHPakjS78BCTmcBpYlYi59StP4pEiPUWcCjYVn8O/u/Y3q1fVOWqwtKu8oM+8M0jJCEuxNFuqPzC1owMe/4ofccO5V0VDht3Ddh+/jXRSD1cKqNHJ42uZMxqfciGD6IFd9FFGd6e7Bur6QbvCULTfu9gS/qgVi6MXatI0WIn5ErXkiVrMLjHvlNevHaRfXsKKRoCbxewBYdm0c81Y/0AS7eS+BJFgyflVImjX2T/4ELGum4pC3RT5sNoWbA9X98oroMSZiTzuQcfEgXP10iahYtjUhZjirhFtMvB2cOUCfuAs9BuK54AlsNKSjXt3Va8bNgyHWeXGotRGTC0Eoi3WVO/d3Z6Cb4y8Q3QP4joDDcDllGurAOBbFjM687BtsJE4Ilr+8hcgFDJjiodI/2e4Q+q7+GtMg8FoxxAND/70xA9cafIpqMM5RX/jjUiEQervbXXdNxODrWU8+kF8q8zuAzNSP5BY1AVZPZhc45LLmioPMiCD1wayqfMx2iSZJ2eGLzk+O+1cxKIXO9jS7uz+Evh7ki0eDayTfsmSwfkNY7A3TiwaS1lhnl9lBLOHXvzAQbPFwB74tdBIO/dEdzduEN7wsfgZdd3lP8QhGhDy+iCpo7pbDY9JPKZ5N0BjYf74THx+356nlNx93teSlwjGYB6aJfQzNN8CZykgje74njHwj8DuOWVYhdfixeWpc7o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(18002099003)(921020)(38350700014)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nuw2+yJ7Egpt/VWftiS8tDIVlC7p8XpOIJAg+EC5CV4kx1GkeDzbmC5u7mAD?=
 =?us-ascii?Q?46xxqmq8gKRo1yzM6tQnQx0hEUaO2qBrQqOla0L6Y+yyxlRS3qw7qFSxFYuw?=
 =?us-ascii?Q?5BciSasLC5l2uJg3fg8hYa1LCOC/kbKVebUG6GSYGj3iOdYFZUn18H6XIOM9?=
 =?us-ascii?Q?miTDMQga/16w2PBhH9rh/nP3V4GE3CYN/onaAtv/WeQ2xPMlV/UgS7g9c41O?=
 =?us-ascii?Q?O0M3C4oLtRwFmq1BYm93PWBq0daf2C2NvixAvjkpiowjoqVl4CrMX4s0Byfc?=
 =?us-ascii?Q?2VWprsGx2WH/td2sUbhYti5aTneG3fgQQvDSwOuEDNCG3ssuBxP3VXL6nOsJ?=
 =?us-ascii?Q?qKiZgiDhDOMylW3jV8G/BqH3qsyREaopT22w4tgEQi/fW0Yw61b6d9xc6J26?=
 =?us-ascii?Q?gHSTjegXdGt54QQdOb+PlEfFrrByWbM+mD+7mNQ9nnvT5KjJp7t3lntokUjx?=
 =?us-ascii?Q?roXMv1PGdy8gxGbjnSdcK04jnFg+Vy6p6LmmE+wF1WwJWCuChvddPHce3kur?=
 =?us-ascii?Q?1CGBLn83WyMST7Yk+lKmVAl4CVKo+pxeZi+oRhEG22gCds1vqzEwLafnzV8q?=
 =?us-ascii?Q?rQGrck68Yrg7naN1KjShLdHwOudPyv/5fNoo2n+2VLrIyL58cSJDyeYqqlvq?=
 =?us-ascii?Q?/VUAfpNGF7jII8tiYzTXz4pv0r9ADa79zhh2p0lf5MDZvxYOXWzkGqCoOrUg?=
 =?us-ascii?Q?ot12DOxKtVRK4SVDnfhPNhsYJl2DXaC2lnjFFBxM2fmHyooxBQPdf7l7J4+q?=
 =?us-ascii?Q?WroJ0TzHRFuKInyrt5J5Lv6jkscwlR9eygpGgaj05wPS4wz5Uhkmk7g+PJ24?=
 =?us-ascii?Q?56WRMoqEkSjuv/HDa3s8lgE94UI6rym1+HpQ2mOMimcuPFqxzvsow436Qvx+?=
 =?us-ascii?Q?NFVpAjFr8UUoJW3SymF3hUAPIKLNU3f5CCvFHVIpQeLb2koqP2JOUo07yXuC?=
 =?us-ascii?Q?COLbkDNjiKlJ2tqVe4ZeSQu0jOwPgOj5meqMbfuTo+oFe1KxM1qQPjS3q1c5?=
 =?us-ascii?Q?t85Od0dCmLkcpJbOl3IMSc6azFksfC+w8c9FmRHsYLQU4aa8D/GtoMQOABar?=
 =?us-ascii?Q?OCT9rt14loTcoJD2el4fCVKRRULa3TT3M1r3THVNcRDcusavvYawM0NcLdIW?=
 =?us-ascii?Q?8I/LQlWahr8IicBxhgK5Y0W2x2/W8ia/OGuYstkMEE3ZoYcbdyQ6xFY0YOVb?=
 =?us-ascii?Q?rQKlx1PRP6uKe824PPEw64RIDN6jbNJBh2v14xiyRu6i5q3hlx/yI2ac6QBj?=
 =?us-ascii?Q?8sDaCcTa0+LTEmbpX7U67T0/B6B2XgFy1Azr/b5BBfL1rFs+usN29N6rpMOk?=
 =?us-ascii?Q?+Y8eDp0ACzKe7E53IaQCi5FGrgEREAJXxtQlfLnnK9Rg/6SZDvI6w8DmuDOb?=
 =?us-ascii?Q?gWlkobFPbfZzq5Pwi5Oeu42PF497BUgUfLh5aCD8hmPMLWds9lKj6IqK1mNN?=
 =?us-ascii?Q?wsOLdICmZc1VlrPfGBL2fv8zWjnkdxixDi72P/Cnf8cCMDFMC1Hh+CuPhbtq?=
 =?us-ascii?Q?3BHVkxDQKdBNASLFcXGMzCaN7lQ2DRER/uVRAru26eSr3whl8csEfNh2Cs4h?=
 =?us-ascii?Q?ByENtAPR1VFAUcK1sCgOcG/EPpJiXVt55+nlbHKfp5TiWOKi6LBQzV1YFMYS?=
 =?us-ascii?Q?PiGymMFNxa3RJBBUGgACp9+tdspEch5H69JN8A1UBLecM/cMcPK2HIwzz3AZ?=
 =?us-ascii?Q?mNcJ1otVekdyDWBR4sFPIx4bOxSK5ASDZvWlODBF2R+5UYk8TdPadRX+sdDV?=
 =?us-ascii?Q?LZ+0AJAPrg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4e067e-62f1-48dc-1c9d-08de9ba93044
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:13:29.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny3itMXYOqxAgbOnBap/QiYeCz/x6L0I//FxAsdrL2ksR5PkI2JqToFgs/E5EyQYBkYOqsKUMypAereOBveQTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11533

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi     | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index 3e238d8118fa..338de4d144b2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -282,11 +282,16 @@ codec: wm8962@1a {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie_gpio>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+};
+
 &lcdif1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcd>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index aefae5a3a6be..5484c398aa37 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -1470,6 +1470,17 @@ pcie: pcie@8ffc000 {
 			power-domains = <&pd_disp>, <&pd_pci>;
 			power-domain-names = "pcie", "pcie_phy";
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

