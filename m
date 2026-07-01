Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BCE3F4824;
	Wed,  1 Jul 2026 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903090; cv=fail; b=CCgtUwxBBz/OhKOoWeLEkh4gWD4zoNEW1TSls8DuspNF1Cv6R7+JOUxYL+s+scrI76gnGZQ50UBTPbSU2nlmYsLh0HgGd5b/+tODier0KDo1mFX6VHVWEnC1LI8jQtxFQbrWqrvddT5Z3vnzOVacO3crkdcJATJuT2q19hdwRww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903090; c=relaxed/simple;
	bh=XajvND7DXIw7TYYiWVRC9Uo4p85/3HyzWu45aXGjRTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwfhJUwsFaHx/AvT50yguupszsWZfm+dboxxXXx7ZMYSQqIMisEoHM1I9Z98MXZ3YWK0Kj15EOy+CiII7xfsuK7VFTj5vCiBOvk9xYMfo3RVSqw2544yUE3WKbqgUdDE4tSMrN62+eIfkuohy0HKH9dyz7EypCHveaVcpFi4ETM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tqD/QSnF; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tqD/QSnF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePtLHbMpryqpEpGdwJRtuGbeE0NXuUJkHVDBpbQk9cW8KZ8LUaHLTJINcFiXshGAjFPTIwyahrgA+e+VpS3yCSKGtOLmlmb12+cpUjfJRJHT1GZtxp9Ca5QIjmx2Grn+nmkJfSnv2fKEgup3l8Zbixf0yGmz2Tbqu3jjy5CTO7W16uOqVSRAZRTr7hFDYcqM6Fe0Xp+9h/9f46LyET1aKs5U10X2n5CQnEf/WNMs5JgfJAojsSJoMBE5DXWWUcV95nqN/KDY900V8/OCN7IOoGsKuWhBvayHHM27ocV+vgUVMh1+sSs2Coxz6V9u/28LrSXPKTlpdbW+QF8FBrTvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8pX4R2wWIhpaOpW/U2s4a/eNllLfWDUvEZPV5igRBY=;
 b=Z9etiAHrrFor1x7v7elCp7OWdBXW8o+9Re4spVM6+3HvemN3C3b2mG0tWtb7snkxvk1Ha+CAtivhTaSM81clWtI5Mrblg57j5w+uzvOYRrnLGuBLo5V54kxTuwpZfmDcMAIbrhdl1CwoaWNvq1zE/Xe+Ng+fJjQaX9F9gdOfj9UjDxivEpC4Xyuqu5iUijjUJttcEh9LG5Ehyb6khtV7IlWeyvDvthBChx63/3pe/DALS5SODYGmLzFDWqrxUzPY7wQuxi49fAwAowJaOtA6NjrDn97LTgv5E8KUwjlPu1L5B7pStgqPKrSypx/bW4I36VrYHhBtTybQBzuvSri4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8pX4R2wWIhpaOpW/U2s4a/eNllLfWDUvEZPV5igRBY=;
 b=tqD/QSnFGiSvYyBjwoUBq6eRb5QYM5EIYttbmHp56fjRBM5mOyJn71KWfTY7tXI5q299VdUGx1vcQ2Noy1/OnlKbwxmmgxNS1IxZwUwyCH0+fZyszwa934h2b/nBQegYxAwJqf58YKd/bMUR+5BW0UM7MTVplFM9zKvNQAHSqNfAjloBauhI1Xn56G5KNkgynygOr28oxd45GXnqAlca0xYiA/U0KphaWyzSK2P5m85mKBpG1u0kXbAA3aA5SIuDAymeMlF2TpHd5ZpIQunyetfouS7wdlHsultxh2aHKqOrncN8smrJvzxcQuCFrw2u1eyfdIviSuDRjdRWY2dKig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DU6PR04MB11229.eurprd04.prod.outlook.com (2603:10a6:10:5c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:51:19 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 10:51:18 +0000
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
Subject: [PATCH V5 6/7] arm64: dts: imx8dxl/qm/qxp: Add power supply properties to Root Port node
Date: Wed,  1 Jul 2026 18:52:33 +0800
Message-ID: <20260701105234.198987-7-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DU6PR04MB11229:EE_
X-MS-Office365-Filtering-Correlation-Id: e4cd5924-9bcd-4438-0873-08ded75eae4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|7416014|1800799024|921020|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UP41ROa+P40dwsDRyCfVDsFvIZBBfEyztxT6/d/A81SEeK0xat84whF8gQKlSUopijjOBanbQ5oXl91caJTALfYBuOiGwp5niMJZSCo7w/nIvwYf1ayabcBOdXqQ4lTYqMmIlz4aSoCrK6bQQ1P2R1KXnZUGKxquY+AqGzYIvwTVZk4tPSEtxtXve3GJBM+eCIhiSeCqRXPd2HnBJ0PYCORW6O2UxeFEPfcZl20aX0LYgD8D4B+Zagd6H8BNiGZM1oRQFaI83PBBUVowdZ/a98lFgbIrF1jJWWWKmtp8aaJrvt8yNC9WGMfU5Hdemz+eWZQR9hg7yuHHVdSvgL0/VTvQI8hFlmkvd1d6WdtxGXC3ceyvGUTtatU2KoIS7XkG4S8j7o1/msTXLnDBqOTjAUiMjQ/XU36oMoGX277xdpexWlyD23bn90ao/0DzaKiLtTjhc/OhqaEyEGHCAEEwwBOOwjo53zTIQoFGkiz98PaIj2PnDJGiCqTdnbdrmcmF7X0PWZfEu4NMNUweFR2XloxmGfBq6rK9UeLBp3yXQgxlyOe6H45KbzjVEDtQw/DV/dtgui2FU3f7Y3G1luFMLf6Pwi1CW4aZqkpvx5+3/GhlwH937gy5gx7gT7aYMUYXxU0OJEfKnjschA1A+PfoPDXHg7DzaLfpHLc3sGbyAIO0Wr4iDC1VyaABqRRlbhMq9vDmQw0DPj4EdwX2u9rjIg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(7416014)(1800799024)(921020)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N21F+OP3NvpZS44tuao9E6M3ndCjfdvuK97nG2ItN9aaZFs+Mw/aLgYcex3E?=
 =?us-ascii?Q?Ui5FSNu1ryZVUu8/rufCQVz+LSYZJ1Id/ZPvQXapGXeuRm0Px96uKZ9Q8sIN?=
 =?us-ascii?Q?+m2VmX78zrtjNc64ZpzIrWak+vIBxHlfmqHtjamhK1gZPv8zl1HEX2JgE7zJ?=
 =?us-ascii?Q?WTvshOzxc9rgXxsUkyIIVSXvjnVbhIAcMQaSx4ICT5xv2uNiekSU/ltn3f24?=
 =?us-ascii?Q?eKqgKthZbDcrc73jE+E5bN8l9eX6eXk32j8zad/OfCkch1TudRw2FTZdqCFX?=
 =?us-ascii?Q?HjkG5cCfKWCQJ1SUr4PVuPR8tq+XXheHYYeMBWdWkuGnmkU0riuHMdLMQipu?=
 =?us-ascii?Q?wZWN3y1g3hSUD8cFEWDTWTCb2567jjPjBLILPhM99R4+2erxPWwMwt+Pf6Nm?=
 =?us-ascii?Q?ORnO0gXM4ORcy2Mv7efUfSRMw0i/b/6/G1/6ITZ8mnAPuxwAvJXCJOEYyu4M?=
 =?us-ascii?Q?0pFBoJVz2PUjbiNF+C04E250aF4NIePp0g4CZI7cs9LdMlwFlr8KQCnlKVVN?=
 =?us-ascii?Q?lDgaUjSq23o9WIOA5KU9wnJryn33lVSwzcaP3vea36fZz53M2AltnDgn7PlY?=
 =?us-ascii?Q?KUrBn8URHMLGsdMG4Xaxnn5GJqHXWi0HLZQwSEIEyBIbdy0MeMtBwJUuARcn?=
 =?us-ascii?Q?vdA7UWBI9CsimW9lj5xkXERz7iPtsKRr7lQ7rNHNa1T8xP3XdCHItiFhSzQD?=
 =?us-ascii?Q?0FJQCTEDbRSa8AR3o2sh9qBTNxE/Urzuod6Bf5DnNK3ZGf/15EqdavCvZwF1?=
 =?us-ascii?Q?wi9Lt7JY+MB5E2vuq4vHZnpNSgAPO+FxnMGZVd361REQHubfwQK0e+Hun994?=
 =?us-ascii?Q?XcKfnN1nUEXlX721QxsLvRDO6ieiZCRTjITkpOtO8TNcTA0/LXGDyWTOZqW4?=
 =?us-ascii?Q?d/29PUKXpGJtKYdz1UDaCE15/Sb+k49fidEnkYQ1gO0NPBD5wL4jpJ19lD5N?=
 =?us-ascii?Q?LNsqqOHMukG/R0ar3N9TYh1RQKSQHqIVTYLAFDpYsHBGZQC6RVPaFJs1Iz1v?=
 =?us-ascii?Q?p6p9VBsSJvLaaBwzs1hZchyJloD6avChRGU4Ft4CSgFmPNMPb14L1vbRV4ti?=
 =?us-ascii?Q?fQqmeBpT0KOJ1wqT+HOAZLLWGx4eWba0Yq9+fmT9fpAD/VMPsC0MI7ZwQLO2?=
 =?us-ascii?Q?uq8luNaqtpUSD0yjt4ifXMFyuiH33Q64Tt0C+Z3G16XmVgdYpZxp/utVSJ6u?=
 =?us-ascii?Q?81Y9dwi0qS7ZTiM8veej2NU7TYh1rIIFhy8+wS0b8RX6k9MA1dOinTfRUwBE?=
 =?us-ascii?Q?gYiLbQjYhk8YE+EYTf9nt69sBu3vJunuoihaMi/QMDfyGl0yyxNRVd3kvUq0?=
 =?us-ascii?Q?FIShd2m/whLDDM4er4psOUlMiNQnXkugxT81CfCsr1LgIMbGfurSkvINNC1Y?=
 =?us-ascii?Q?wayRxhnunxgsSZ0SirAfAAaFUAJMKiSwRcj4WTNBSuOCbNxEo4IwXGMwxBhy?=
 =?us-ascii?Q?EeY9QLbrGSEHtQAVcUzqGXWPVu1S03jK+DtM8YU9qE0kgwIGivHD9idM4gQU?=
 =?us-ascii?Q?iZDclnzSSISo2waKYX87ubfppp0otkfFqqGXkLSoAX0lJuhbDGFlHl316O7l?=
 =?us-ascii?Q?7sz8KSR/MqNRljzKZzswowPdo6rf6M1B/2j55hHR4N+xJQZXYka1DfMdASfV?=
 =?us-ascii?Q?XOXJnPd4A7HQXjkqPiZX/xJFnkUJ+MTqhAIwRcrs34+/7dYwxmEMlXX307D6?=
 =?us-ascii?Q?NwQv55bYz4g8j473DTDnN34/yZNhVRgusd44GwAdgHJ/mbYnBKk/YVaZX6Og?=
 =?us-ascii?Q?xFvKEU+2dCExJ6hqVh7CnxAxkG1PH/JWPLa3+LNB06nyzgRMYRBn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cd5924-9bcd-4438-0873-08ded75eae4d
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:51:18.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrjXWebBwqXaPpu9Hsl01E6NHyRQwccB+n9kQVgUadXFmMO0S7d75MuYH2sg7WFrndSijSbdM4PNbJIrFZQGHNC+PlYks3w/HB4+HHGeNTP1zFMcyd/dVDN+mhri31Xh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11229

From: Sherry Sun <sherry.sun@nxp.com>

Add the power supply properties to the Root Port child nodes to support
the new PCI pwrctrl framework.

Legacy power supply properties are retained for backward compatibility
with existing kernels. New device trees should specify power supplies at
the Root Port level to utilize the pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 3 +++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 3 +++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 78e8d41e6791..0ede0c7ed422 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -677,6 +677,7 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	/* This property is deprecated, use power supply from the Root Port node. */
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
 	status = "okay";
@@ -692,6 +693,8 @@ &pcie0_ep {
 
 &pcieb_port0 {
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_pcieb>;
+	vpcie3v3aux-supply = <&reg_pcieb>;
 };
 
 &sai0 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index f706c86137c0..9e49ac377162 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -812,6 +812,7 @@ &pciea {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+	/* This property is deprecated, use power supply from the Root Port node. */
 	vpcie-supply = <&reg_pciea>;
 	vpcie3v3aux-supply = <&reg_pciea>;
 	supports-clkreq;
@@ -820,6 +821,8 @@ &pciea {
 
 &pciea_port0 {
 	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_pciea>;
+	vpcie3v3aux-supply = <&reg_pciea>;
 };
 
 &pcieb {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 2af32eca612a..857a6e512228 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -732,6 +732,7 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	/* This property is deprecated, use power supply from the Root Port node. */
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
 	supports-clkreq;
@@ -748,6 +749,8 @@ &pcie0_ep {
 
 &pcieb_port0 {
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_pcieb>;
+	vpcie3v3aux-supply = <&reg_pcieb>;
 };
 
 &scu_key {
-- 
2.50.1

