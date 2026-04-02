Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F173A544D;
	Thu,  2 Apr 2026 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124580; cv=fail; b=E9udhhm0vAnrUnd0DwPau1RcleLyyzwhJ+JW134iNdZ/tzt4fTeytCNIswY7sbiSIlkfUM69PbPBu/+ZtPuPgFtYkf0C3fwCCghtAZ9p11CM98Jh2ELP4ZlwmlVciZMSWjH5tiIOdZ2MWhhexk/BtUK9iO+SKDgTkF9dvz+ZZrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124580; c=relaxed/simple;
	bh=XMoCZ9PvdukFHLgeKUXyXgSYimHLunDq310RbLkiNtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pWs2fME/x14CdU5aR8FeFi1gdc8jLA31HHEY2ktakc90VClMIH/SGzI9tecbnfHq/ynz6f6z9IpOEYiTQxB9N/2PCNZ7bTk4OpsHQYhnxNkZ9mKHJne2TkCRnXz958aVt0KG+vtFBPU/Ao/X3NxylKaSHUyUTkH6HOaLca2fins=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b2o/sUCI; arc=fail smtp.client-ip=52.101.84.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b2o/sUCI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Id2xiso0mx/VVwnF8H8pG6a2Yck5qCcdzEoi5vfCuAXUfuMHu8zh2jA8f+IkAuDle+tzKOt2CZBQisBRVuRF7lLfD8GzPxIGc7+w+C1pnQ8Gx2lRee3u+pTY34Sx81u9Tyfxr6QqYI/k6abhU/Fc3NoiIUP72IqWysSYB0rSYOuJ/ojXOaL6lHKU7fxRBbDWLZngxWLCcUxv5BNd1t4Y0toJ4xYaj1Yvhantijwod7YWkGadZZr7IGPh6O6u37OLJaa27Q3VymHshNEFwQeKrYkKvS+27YoOl6GvrztP40Gg77IXN72IVQhAvY2HTJZkCeTzxOqN1lEGfoZDJULAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKPb+/ilMfuO9hUVmtTBl8B0kNYfVGuzOTBQx2pjacU=;
 b=CQGy07LD389B2HGrN0jsg2zBshELdA15qiEXeNvnYR/uniCtLRvS5H+HvOk2K010FbgrUFV+JyEa+2DdXaCswWU3vBZAr1wI5CaLMXD1d8tG7bmsLz/Ts3w9IdtLKnSv+yKvh4+iu0Au7hRPj0eWsfH8OdmCQrQhh1ro/OLa8zKofeu0dUbs2VTO+tV8WwPCRgTutz+EWS0vAD4bDDKCwyEidQrMqGE+Kvphmjz2UHfWaGTG0hTR4ndSRSn6FvV1ytWFiQmFy9r/VZZYo6tu2tF3HLpZTJwgXU7xcIaGBVZG2cpS2kLOX80TetW588SQI2/DyFYTfU25cZfv3KRB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKPb+/ilMfuO9hUVmtTBl8B0kNYfVGuzOTBQx2pjacU=;
 b=b2o/sUCI2fch6h9CoxP8FEJGRb63VJm+BF3+BowIItjUyATIaWZCKegpaFBV+C+kZquaXjvaTEWXsh/H1StODZzxqRZBoBaco5AvuBD836QUiqa6ea0OlRKtoEx4Y9GosNfAuc3u5OBAj1jufK3yQZ5G899taC9aUmGtfpjaLrRLB0/uUvV1AYh6OikQkP5nNQC30hE5RgO1NHJOuTSqrE6rruInPBTzjXojgeThLRa7BZVLtdvVEqx3v+vFW3aHMc4A6Q6WcjlDeB/zHyuPev4zGtVY82EIVcqxjKF4GB4r7oBcUzDweS/7w3UD864effg0FuGbINZBMz8KhHSxKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV4PR04MB11944.eurprd04.prod.outlook.com
 (2603:10a6:150:2ec::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 10:09:35 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 10:09:35 +0000
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
Subject: [PATCH V2 3/8] arm: dts: imx6sx-sdb: Move power supply property to Root Port node
Date: Thu,  2 Apr 2026 18:10:02 +0800
Message-Id: <20260402101007.208419-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402101007.208419-1-sherry.sun@nxp.com>
References: <20260402101007.208419-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV4PR04MB11944:EE_
X-MS-Office365-Filtering-Correlation-Id: 6120acbd-bd89-4a2b-68d5-08de909ff121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KYMSch0RYVghTdUSvZ/vDPcAOtJwMYRw6TRCtAO9MPRgfyHSrDm0AYxa62OhkwP1ypNjc5QijiQKsjs1O8SG1oWP/H21aHl5nSoUs3BJwhAl64yCvXP6RvyQa7p+DIBueH+yX3/ka+NoyfGb/WcBxHiHKPXblDZTiqltZg/8Brbi/6+wXqofGYBmZU8OTFpsF40j1C4/6wPVLHdrLfObRotvh2jyLPZ8/oKq+OOBZ1HAggVs1qXA3005AP165mATO0iL0Cl5521qiblv+QxQiIXnDpxkN0AdKIzAVWkCzPH7i3ddanhrfkXCu2WGEXIbnN615C4bn/eFCZ6X4h+T9bjovYUx7fSCv1wiRkZIlUHMQCy9U+1/ogy26YywULgyg18XKvKOZJsStgUpqRAOiNiY/66YeOEDub/HhzjY5zy8rEzwcF2FldTcqRFM1gPXDTWYYjKXzBIVLgh2X9AdzkNE96PoX9BFClRd00FGIj4PKawTfIjUL3o8bqpkOBcWsB7/QmVCrQVfVxJnI2SlC2CDECwVsyvXf8gIdNQImE8TgHbM30Cm93AKcz8lgt8DnKCi/Or3HRoaHOaT5JXexhPrkCcO94eEJRL2Hk2JIw1GQj7JXyxKt4BwG7PnT9eMaEHfz3VZpp50Otg7K3iVdQ2tfXJp6GwqfOHCxRMdPrNYWqSnasF9u+oSIq23mXG9eyM8/tawG5bMQvEnQfhjvnNmnIJmjhu6PDGsrCArLRoTcrFzfZYWy0AFy2XrAXFhZdJpNNIHpzgeYz9QpvtepsquiErmj21aNT2kWOYs0fB7FIKG7OSAS+mXumHMBrEE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PjA0jkrdQ3QVAkeB0EaLJZjV4tMfSUKMkd2FzQBeVLRK1Fko+V1YT45B/LON?=
 =?us-ascii?Q?nhdZGmtZVtFKA53z9c3hLtuvYKo1mYv4Hz6wjDufDnWfdRTbCFh72mT3bp4S?=
 =?us-ascii?Q?tYpes5aDI4cGzofL8eFYmhO9WPZofQ5waO4dLw3nwEhxsa5bZSpKGda8qlzf?=
 =?us-ascii?Q?1Nml8zGUjw1HK0dscMAsg2WFjhB6/4NOR82ag43k5cEo1gMlP3AhtTuT/Mlv?=
 =?us-ascii?Q?e75Q8/U+h2JI6Vd1RGEyRHbCxQB1srgXOJaz/dlNJRWUS4VgsZtNcaHVC8ud?=
 =?us-ascii?Q?ZqujrGm229OHsW2vW06RCdDZg2vN9UNuxYFGh+xY5jUQRXoXYUDIxAH8K9ht?=
 =?us-ascii?Q?bSyYgGTQTp0DQFUaYC2tDbwkyqgC8DjK6RUzTzdRAWu/LHv8QYclDfA26Jp8?=
 =?us-ascii?Q?38CI306AzR6Mw+i6WPXh0LXKMUYIBuhhcPeR6eUSakdSHy6tZopq0yEYVAD0?=
 =?us-ascii?Q?jGK2NthWhWS+0Pcp12TJjhwNPwKzzR740AGZMPBikPZCEA79/gF2ePpyT1ec?=
 =?us-ascii?Q?9zvyng+ofVj6J1i2lZT95esBp0puh4ophKMBSTKuQWDqj/2FumVuqGnx1I1Y?=
 =?us-ascii?Q?npDnp0LQO3qDNuX/Ze5Vv3yyZ5IcnmnqTwCWjRAlX+9Z9s1rNkzZklNp0S21?=
 =?us-ascii?Q?zK38ToFRfxS8H7t4lVjOGmYhOzC6OztVAguTXELuWRoIg5AoDzlaBB2LFIpC?=
 =?us-ascii?Q?V6yGY5Aq8Jadgh7zNW8VdXahwD4rJe0l8PYEhm79cXIncohbkA2dvNyCksUX?=
 =?us-ascii?Q?K50lsommwBcxeRkWo3tZT51l/TPbqiijGaFebXiuLoMz91n+4pSQ890F799i?=
 =?us-ascii?Q?NZwmsCa2csU28bzgMfTwueqkdjLkCevDyq60oTeiOJGxeM+Z7hLW0x+AW93G?=
 =?us-ascii?Q?0vtimBM4nFo12yO9E2bh+kgZdCbThLswPCGJkiguE+vouTR+6uiPpHCtf9CI?=
 =?us-ascii?Q?inABoSJZambdk7ozJI3X04q39LYXtK6n9Uu0a9ZSpF4MPZ31tO8VTwLqEMcn?=
 =?us-ascii?Q?xUttXHqFtorONS+59/OKCNjFlp8jpjJ4FOcDM3wwFJ0OJ8xbg4el/oqtq2qZ?=
 =?us-ascii?Q?nk6i6n9fQ9fcwdV8Gy6AxLTjVHXwUj6NvkMpwvtmTjI9IIij4LP4KOUPU6f2?=
 =?us-ascii?Q?ZryM6pcNV+3NQ4r0WMrIBOdEbgPAQ/N4sNBWPX4bPlAD4c/V4I6QuSih8JWg?=
 =?us-ascii?Q?29AaC/ijUr7FJD25KeLZWYuX8wQZ/NCg58D2iXsDCCK5vhSsY8HpOwUpaDmd?=
 =?us-ascii?Q?LIIufrFVeYoZKv4AMQSW3dsYj8lTgBzX+IlQUft+iFGjwSGsrhpCyvmrnC+y?=
 =?us-ascii?Q?K4uNYD56ZS5XWZbXRZlgN4HiU1OSq6gdiYBUI8GPebTZDVSX+orMo85UCJLa?=
 =?us-ascii?Q?mb8dnv6Z6NqAnVMIwkGb/hkv5xXEyHUx9NNhx0jgLtE/OkEDwxm7uDICqmp7?=
 =?us-ascii?Q?yAzoTvqybpohnjjY6r6Y8HPO9J66+N3WDoL2lXEexXSUCRytE2hcLYpIsmYI?=
 =?us-ascii?Q?bHcNV1JFSWWoK+or9m8rQoLY5E+5J/gbleo04M9f+hL0vBKHhsX/Bk8YsRex?=
 =?us-ascii?Q?sKDda0uJD58r8M5CKax/b1snCsr+hSjDYSa9O9Nd1mTglydlyUyBm+PRYvR1?=
 =?us-ascii?Q?PvcNW8FOutUXu5Svk4orz1F7ymgmxSRHj/leRCehgJxCA3R+PX5V41LW+ok/?=
 =?us-ascii?Q?bEXWmi0UcBmyJyLH0ykQ8TjmtvXAM0LIGQM9gowJjPL3fdP+JNk20tqPeVoh?=
 =?us-ascii?Q?lFU7mxtXLg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6120acbd-bd89-4a2b-68d5-08de909ff121
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:09:35.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lL7gvYlRg2V5JjF+1xb5dDCiJUUjqxR0HigjC4jXaL0OngAU7MHQhm4Sa/geOjeAkocqUtP8i5ugU1tOentfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11944

Move the vpcie-supply property from the PCIe controller node to the Root
Port child node to support the new PCI pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index 338de4d144b2..7633ba2139d3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -284,12 +284,12 @@ &pcie {
 	pinctrl-0 = <&pinctrl_pcie>;
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie_gpio>;
 	status = "okay";
 };
 
 &pcie_port0 {
 	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie_gpio>;
 };
 
 &lcdif1 {
-- 
2.37.1

