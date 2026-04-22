Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646243C3BE2;
	Wed, 22 Apr 2026 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850494; cv=fail; b=myOClSuA93e/zh1Kl/cuAFks9+u36jAAm0EBaLQkKoOPkwKr4c9eWstH01mI6Qi7sclLke3yOcIxJGghJRmtHy4rD6GxwIwmKpw4LkBvlSTbUGZxQ07l7ckPQEuPKJJxi8aKyxR5hBxsjmspuFXlliWQnP2rpuLzdbvXn2R7VuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850494; c=relaxed/simple;
	bh=A6iRAkqRTnQwRrqLsS8rJAbdrZY3jnB8fB01H7L3KCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3x384GKbdVyfAl90qqFrnAKaadbIMRFFlMG4idPzfKRTDsU+Eb1sQ4ENuFFlBE3pS4r/yMfZd9Rbpn3VeMDR6qN0u8QPZydEUoIxwdzOQtZVX6+cOZA6n22gYXiLHfVUKJm6VjoVfXjJ25JwV/RChwesR5iVLnyldLV3vlZ3Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z9+vi8Vw; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z9+vi8Vw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXF13XYYroTa3tXriTdS05pdQrcMBZuFuN79hoja7hmjp5XQy2xRz3+/ebObcOnASDvo+ro5dAXPtPwp10xWpSXapcBDToIEWdd8nGCKaws40Vr8SYKnMOhCN6isPAz7DIKQ8Wchg1grnOch7ZAVGWPv5IXfEuMoLbbXjXEC54WYOfbSnMShEsbg9jc7oge7IbeoJ8UG0WnIPRj+ALTFzIIC9fpg9jFbodPjMoFhrhN1Lr+4iLMfX+bQcTBlg/qE3DDJDSc0mLnI4ReE7gGvBSF8fTJajreYa1AU2JDT8uJciXv+Zp0Jeq0RfCObNxXOQ3z0TGtKDD8IQzplVholYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5tYCDpWv6EjTF2fSdSpZ4GDpJKWb1qXmwlQ8MhQsyc=;
 b=r01xXF13GCcQlOIqpsMmZ4iFF2b4vqSj6j6Tou+dyGbtJh+El83DmIgVLAD10xEMqGtmj3v5F44nFoNWOrEY1mrOMru3mpdmNUzY/W+/RD5TVnpUTefvH+sxUovdeMurnPU0BEuTS0Zv6Z0o0qigffg2DRqQCnWKbM0Zj/2m9nFUNnQpf2EgRrm1omR7XAqsdRmteWOmfeNmWwby7SUEYhOS1qbTxg/ReJs1wIxwu1jp93COGO9+e2cyaFB4fkboMm5X6SZ2RsYDqHA5AOCj6phJz8yuk3u5wCckaRiLOuuUqeWGWSaY/vIvGb6DyG5RzFdkQQCBLU3n55wnbx3UEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5tYCDpWv6EjTF2fSdSpZ4GDpJKWb1qXmwlQ8MhQsyc=;
 b=Z9+vi8VwUYYo8jVREa8jRcqUN9mf0gxkEDoxP+OaBKaXAYNb2hNa9pWuhMtXE9U6NZc7oxiuubi4oDDPPmF0XseeuybH65Pse1hqhLxeaWudgj3ntwmw4SK2Qp2BlEenD2/IZPvcr254EokcRBWsnUjyj3A40ZfwphsCBi85Em48vE17opiP/ggIEaKCIg6GNMLBrS7Y4HjNXB0TWsRT2hWXJGlJtyOw6uzH24hPaEQFzeZ/ET9WH1WkPEpcESRkDTjtYNBINx+Y/fCJL8VKbArfGxd13YG+69xAKRun98QplJB0AYslTvC8QkkANI4/kek/GjW2e8y8R6Brsiszog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA2PR04MB10129.eurprd04.prod.outlook.com
 (2603:10a6:102:3ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 09:34:46 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:34:46 +0000
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
Subject: [PATCH V14 06/12] arm: dts: imx6sx: Add Root Port node and PERST property
Date: Wed, 22 Apr 2026 17:35:43 +0800
Message-Id: <20260422093549.407022-7-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7962a439-66a8-4c78-f641-08dea0526417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|56012099003|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	TT64RGJK2bgsvrBSNsWKoOKVxrNvdRJt9wIlqjFe1wYYaWAjv+ndv4NLAwWsVip6NI6w/5rqU2uX3fe/hKUY00f7RTeZqvDoWFQtlXeRzsKmImLp0vO/3deI3BizGokTyJ3wlkPmuYQcp9+0PMAuGxwY5dnRzXezxchP3a7uWX9Qwelxc2JbWcNVUXVLcf+qEnOVEcVUfpvVg3xDeAHSkYM4kMQ2iJFUma2wMUKvvN6PifxtKS4X4ghFjPE0PWpyI+kricIA8a8l9WBOJ1mExR/+NiCVGLbFv6VoHLsEDUes422SBYdaNT37MZnenwm4I66VyEh3eE8bYWkDrIhB2DoPcHduyZiNgBXMSXY2zFuH8AZ5H6kEJimdUqIxRTDfW46sICkzjBBL8DzdUBIFIUpmBu/fvV32AcmLWF94VoIo+R214tkIPev6xAYu+PfC//+GWCW3ibhMLTfSiC9FVr/0ZfXm49W65Z2czh8MlUHamF4HbIO7ZZseyr67ic05vhLdb8tipr6YqLcIKKz3J/+jUap6cLp4mjb7YkeW4Bet3giYhce4K7yJgKpxb8ZYUGYio0uw9FcveAyDZ/J+y+3XLx9fFDidQNMp1RvTU7f8f+43NbGQSv3fGws9+LK4njAIBp+rttBTBLucumcK+c+YUkuzZ9u/D0eZv1j7I4AXeIGJS/4c9mjdsHUgMLgX2kBK0X7L9p574hnA2dtTK33xHIeAwJI71Y4+hY3JvKQKO/Fjsi8ofGuLVTWQ0wuUnnTaywWcsW4wGBaERZ4JkrcCy2ReF1BGbgKnaHmwwQAD29teUDMK0T4cL13voOWD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qT4O8pnvlTl0XNOmpxWWtvpeJF8qmWKkeSTewBW9ab4jsEzHwXzBGw/IFggZ?=
 =?us-ascii?Q?5Th8xwL3mG8wy3yASSEfAKP01oYqJfc8mw9M+DSi0UhCVVUi4Wi9dAmQSWxH?=
 =?us-ascii?Q?a9s1+QxNznDV9WXVS3Lv9V/QfGJ+flxXv5S7A7qJO2IafgQf+EiNYTpJLwDk?=
 =?us-ascii?Q?hRZ7vGjzW4OqeiWPWhkcFXGXm78udZdv3QsXOILQQ2f+22bhMcnjdwyK/ywo?=
 =?us-ascii?Q?ww9BeQ0m19I6ObjVHyfLKTy1J56cj6rIBvIKNG42Y15So4MIdaVoPOOSX4DB?=
 =?us-ascii?Q?JJV70vJ4UbC9aHSsaSr6WtNIPk7pWlTOOTdrlIA5OzCtJ1LXl1VTi/37xuNU?=
 =?us-ascii?Q?vNiDBcAeXSR8BV1R7zqTpHd8xneKuPSQZS7nBV6SrpDi7mA5Caa14T5U/wZH?=
 =?us-ascii?Q?Lslb55pnvtfFSWoZjk2C1SkdK6LVony5MKO5FGnHmWRqZeej3u2DhFEUCUZ8?=
 =?us-ascii?Q?lwsH4Iat95IL7FfbS63adgMlc3d7Vu2NXePSNmADZKJwGAB4cv/wxFzNuJYi?=
 =?us-ascii?Q?G5N10p8CDggmhQ9cgkEIfj6EhosVopDsne02fMfrOJn41V4+arqfMPL8diQi?=
 =?us-ascii?Q?p68IhPuBKG8oGq1n3WCxSboJqR1WesSUwLrGXUE4xG9NOGtuZ4K+KVr3Uey1?=
 =?us-ascii?Q?FK5y9+bWlY9RwkcLtnAOVZta+OnIJiOLCxWP86MEX63AgpCzofnSATPYSMMV?=
 =?us-ascii?Q?spxXFAw+deaYEklKvGR4ByasjxxIGd+CKGG4hhUBfLoE3PYb/bmTugvXXg/T?=
 =?us-ascii?Q?9z3rj8rfSCQL+wiBByigcjmDqkloLk9C2HNO2MrT29IRUn8Cik1+5AcUfgEf?=
 =?us-ascii?Q?xA6SU/aJ9mjBGNdnh/243Ni/S1ZWBk/4vlicQ3T8m+DkWAOYJ2S9FiWCRPjr?=
 =?us-ascii?Q?h8mTY6sgGSW+ubUFz8+kfGiKkV+rvssuzBOKW14emYL5jvAmvx38K+Tu2bzL?=
 =?us-ascii?Q?UK0KxqoX1e+gBQzRCd1bu4K96CgQSR5YnOdOB3G2EWMO0ASw9jzi0eGVRzNx?=
 =?us-ascii?Q?S3PtW1fydw8q2oard2Cj0GddxXnvXeoixYx5jYQc5mp744bWETLS23nntl9N?=
 =?us-ascii?Q?nLlMWHb/CyA8GpKMe6tRZ31u1PLV/x8KJtfx3fy3RPYwqMmukdYHy12x+9C3?=
 =?us-ascii?Q?p+2PbHddAEIiBSGiGh3jBGzS39o8RINaVCoQjnDCVcqZnBtxABwsux7E3dpt?=
 =?us-ascii?Q?SMtHm5Nfqf0nYrbElGkfgIz2d4RPlSV5oEptRPndQEvpuNOZLGj0oOysad8Q?=
 =?us-ascii?Q?06EfQzZi4Mps4N+kMG5oAO36Kllq+fL2lLhkZG3eUdziyn5xXne6FIxMRcli?=
 =?us-ascii?Q?aFGcfx3wOu74c2ISDb9rod2nawyOFyhu2ROBsDy71Q8c7ZGh3BaVz8VjXqMr?=
 =?us-ascii?Q?s1G3hguPvixKUxhzRH+VrdUCjGcrei2zxdaI6PGeFE6xMgHdUCGRdzWQ8YK0?=
 =?us-ascii?Q?SPUFWhXplnA78w0NpY9puf4yCmdnTHBuumnZv1Up8muMN8Kmtgo4JW+11+yc?=
 =?us-ascii?Q?I7jFxhqikoJTDSpPAl2SXQy+EghtqWyqGgsBCQR1O/QgICDmBQkVko22wuYg?=
 =?us-ascii?Q?T3S1MvH9pZcdzG76VrGnNqAZZNfBe3Sxn/ujm244IKcqgvuA/eW4kMmpJqKh?=
 =?us-ascii?Q?l5dg80h2vyO95/mgsJ7RuSDvRfD5HnO7zrlg1SK30qL0RyL5qiwngEn7CmKE?=
 =?us-ascii?Q?eH9R5jXKxrWO4EegkM/lOCrLe9qz8NszbTWprbEMSOtmqWAnrr5mrL9jBrOf?=
 =?us-ascii?Q?1lg8k2ecPA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7962a439-66a8-4c78-f641-08dea0526417
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:34:46.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUzYmH5vtDCrXMhVG0cRWCpK/cqW0YoVP9D+UjRyOHxRpq54mdp88ZPKeLGa1TmltF/C3WrPDsGdvHrWJhNpAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10129

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

