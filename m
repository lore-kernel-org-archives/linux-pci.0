Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34C2F6918;
	Fri, 13 Mar 2026 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367725; cv=fail; b=cx2MWntDpAcNn8EwOUDlisJEghNa0jDINPpZrmcSLFgSJFpuyXQPfn1I8kq+SwqLDC1b3ceCzbd4gX0kUteYlkkT/outQ3mInEVENFdig6Dfq9lQCdUeF3+f6syU4zORBMeFN7MP0ghbwiU7MOX7h2/mdJTYD/mN+XXJB/xmh4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367725; c=relaxed/simple;
	bh=JFM0W56xpsazqyVZ7LaCHxqR38MWxGJijkOLJtpkbVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BJbvQX/sE45H3TMt8tliEqMUCxyat7/GkrvMbeEUmBaFS1hupsRh1DcpNLUlYMbDr7PbBLzgPLMpnWxjAuZB0/Q5hAFEfbKm+bD1xUUOymuEuJqjN6zZCrwgrO+lxHu7gZIzmcvaqO6wx+hgheTAo0fZt05MnqxxEnuvB968yG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=apaBY33o; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="apaBY33o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEpLwa+CKmLHviBsDtN7qA2yQ8noSpR1kLXDraGhn7YSf6mUSbxdFJw9Gwoi1We9gqqFYblnxRlo2ydzp31ZmmFIzz0AVFo+/ZqqM8UIhCYbbLxtKH03XqdSmc4SZGwOJb/I6SvWZgINLL8O422i143UuZ1G/uHzjTNKAWBPG5HdPffsT3533v3gumfNgIlBxvCEYGHlmMYA6vFxl1ZY9eXdy2UppySfuGgz4pV2MX4d1x5aEmtncFaaVPiNm7Gkk+txA/Gjp9VBUj4xmCdxCJUMEfzN16Wkk69aXp+CVBq/FCg3LdoZRyjDeSX1Yq/G42W0ksTzho+rqm6nXzNOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP6OD7tFDJDIiNf7kW6u4DXo8H/JX3P6OdoHBni5G7c=;
 b=WGX0evgan8XnBQGzsssnCCJ6SHMHOrK4sAP2vuXmgrHhDImm4fmWD2YK4OKG1ZoErizsl2p1lvUvsTRzd3sovbJ3/RChjij+KKtazM3nXUB6BvIXxNfqNZ8CSvPAYu9oLu7AbKdKVx11hN3xh9wJv+mf6AzabjmFOgD+PaEfHVJDGkPQHviluhriQhay6ogKdSCpuEzkWbZCrro4aBW2H/rec5qBNOnS3H5r/cOke9bGuyzVQQ2Vsvu2zGKuKy3ucDTJKDRB6+FbbSIsnEd5CmcZhzXDNUuWzWm7GbJWFrTAT9se2X5CVhm2ATr/GoVpyBDkoUgf148SszhfVe5etQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP6OD7tFDJDIiNf7kW6u4DXo8H/JX3P6OdoHBni5G7c=;
 b=apaBY33oBQU3ImHJ+ORH9A4FT7TWBHkgIvtdmuEyDEUO7rbNIcsnUJqhzlOSasnhTefDtseourKlQa4oE+6LsR2eDOFFoVu3jbc7Tk72KJAfQJuliLxVfaRS8EHTkW98e7AS9zdNZjWkrwiBA76vDixzsT9CU3SN8BESllA6neH25+VDneq1/wy+Fz/duqi2Lqu2CBIBJ030eQl3ySgf7N6NFyQETwuJlyujleEOg7tR+fwk4sLI95KmQ8Kvem1XNpjTblRtqMbcreg1ywk+HDvxF7zWWourrUaresgRxKR36shRlMF/lZcE80Pxz1F/pxcaDBG1DNit9kZKaFcyUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6844.eurprd04.prod.outlook.com
 (2603:10a6:10:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:08:27 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:08:40 +0000
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
Subject: [PATCH V8 09/13] arm64: dts: imx8mm: Add Root Port node and PERST property
Date: Fri, 13 Mar 2026 10:08:19 +0800
Message-Id: <20260313020823.1592389-10-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5cb81013-ae44-4358-6dba-08de80a5720f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7YMzXKEMs4Jfdakh07WPxqnddA+s75ttbeV3ykB/9ACJ67W1iFXGTdv0MJSxPJyKQgA+jWZZRp2ZMdkjQFxvYr8YL/5Dus+y3fK4lR1bQKV9ka1n8C2tLb5bwVrs0BQevvEvrlP66QWymIN+ZUNkWV+pkZRko1q6dGUmKl+7Ntut6Adb4WQSAn5jrHpRoDErOiKP0YHRR9hpYrLkc8y+VNmlOdRjR/Wl9Z/Yc+LU1rq78LmGmIl3daAasd6bDOngSyiv1fNu1ClzbNidhBY1A/nuNGx8jxrzYmjQqmFETo6X83fcl/W2Vdt49OddSCptzF4hcU4kkKmfUlk4csNGKanhbFeyiK6L1AwrTs2lGkPTtZ4xXwvPEuDBQpErLU6D0QuhgxDMvAl2vakk3F6Tnnp4esFEvieBHeQOpRsgdxITH50H646ZPuAHpTqV4bhgaDco3jSA2HxUwtbDqf5b3in2F1zcB5yMdUWW4KJhDsuVXLTi7y5Qd5tYJKzRDJeb6PuEOfwLuaO8gTOwEV5xaJ3kyzI8u8Yfa4n8xXbofY1dswX3Oe/FTQfTBD2cDq8a+JYPvgtRhIPu9aks7n4DanDIFWOmpxy5QaZSojgtyUwym2YIkJPwy98PZbUpUA0uPRkbjdrtuThEvDQTiYKRVbcAmwdkkLMKUk0SxRxl3LJjld+YgBzlZ/KDp/+cjZmK7O9aoXM/vqek+86d8iXGBTRzdcAmeJ4lwTj547nBIbysSG/BLS3T1KmeEeuTSlr0h/Fx/h0fqcT5wdI2TyLOymQjOydcZTkXyMBspCQXLMVNjEKdjpZQSLssqtZL1Q2r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E60TuwB/P1IHEgWMpQOj4dpQKLSm08adaQgmOOVb65QGGqWjbAZx5B+7NnKB?=
 =?us-ascii?Q?CTHDaAKiuvFheJkn4Pu+t1j9sG9uu5bq5sb5SYSykJLd4qzfLujp/bL0OpGO?=
 =?us-ascii?Q?elqJIqNKJqnRu9ONcbSu+6KXaE2yhG5jcyzWRLpsLQiZv4WHhh9taxPoVad+?=
 =?us-ascii?Q?j+PCQDD1Xf2maZ9mX3KZ3X4HeQ198bB9sXjAGDgLqfuttYfxcvZU4FNUw3iD?=
 =?us-ascii?Q?xDQuwcUQcv+OkRbXM1Y5mjlCq2l+WqSRFJfxMQMLgSg2LkCzIL7ClKiqmZ4e?=
 =?us-ascii?Q?jJf12TJlK11/Z27pZgi1nCkzSLDVHm/1MJxKPgKstvfKCvXRmESF8MX2xS3v?=
 =?us-ascii?Q?j2hlf/dZ1Ok0KTibqPZY2BjcRzarzfu8ZUC2ErerANs1qEvkFUaPL0jvd/WM?=
 =?us-ascii?Q?iUpr8OpmORJhCLh6Z024W9Vn7TB+JGKKmYw7OSDfoRjJ/02RdH+yEFCT3xUS?=
 =?us-ascii?Q?pL2Xmds99IqtavD6ovAXLVCY86AKmcgOal8p2EVqgoPS/o2xr9Sc+XZ4eANW?=
 =?us-ascii?Q?TupPaCeePXsnHl0eoKpRxiyf0Ko1ghrKRHZBSsrBdMmI7t7xi9UVVRBD3Wqu?=
 =?us-ascii?Q?6TyOexU61o6FVHghZx/JVG1IVD303jjuylrIsE1N1k+ivu3KE7i94d/IRADa?=
 =?us-ascii?Q?VBb4CY6j26GkcW47CK6xlOPPqqxkylKaxS8Z7kjmcra+BFYTLHh5ep98rL/r?=
 =?us-ascii?Q?SptGq1zPKq3LCtPLMLkgXVdhntQDeKyKmvQfTwsQSC3TWmXf5pOr/0eJkv5z?=
 =?us-ascii?Q?G79Si8gOg/OqhEHQ0qZy/tQF1y205+5b+TkH6za5EiPmlLkjB+skYqkk9HYR?=
 =?us-ascii?Q?4bEotXQPVZXaRJqkEwEN2eDRREi4cIiTzCXSjrV1RisKlAetAc9PGHrOp6eX?=
 =?us-ascii?Q?7WYngOTSFKqMXw23Dq67I7en6ROgLdmJQiM1u4t068xIZClQE3ZjTRahGXlI?=
 =?us-ascii?Q?ywTMmQkCL4Y0nBnIrG1PqN1hzMXB1qi0XNqn0VDFVvjldASyOuUnHgIIFXaQ?=
 =?us-ascii?Q?9krDi0beK1aBKMOs5jGBgSxE5I9LjSmoLOM8k80k85P2/P10pXN18Nhzdnl3?=
 =?us-ascii?Q?fv2+bky39Br1wm8951lz09ZfAmdXILR4a5wShK9eMSY7CkdaSIFL9DQAna3m?=
 =?us-ascii?Q?BbFLohATTyDMYAtdAZ6yeEFGZIS5q+SJ1oP1ymXkan7IJfsDy2bPuohBjWSl?=
 =?us-ascii?Q?Ko/MCu2EdxoAgYnbZZ7qerqGml8BN33nGznDW+j9xKT8j5P4RspakrC0rrms?=
 =?us-ascii?Q?LYx1LBuBbz1/HMSR+591Exj+RTGhbK7iURiulPHyEy2+ED0D27cEuiCBkiyM?=
 =?us-ascii?Q?NZJK4fpplhUymPnZMcKZXIJE0eWT8ZZTQCgWb/WmJ6LiRL4XhwaJFeQREKCV?=
 =?us-ascii?Q?06lgScqDkGE0O1Aulffgbf3ZGZZZ7mP8dq3QWyRNALulKI2S5pMKq6/4UHBJ?=
 =?us-ascii?Q?lWqXUohlckFDe20LKFX9mXbTlEscnwo6dP+orHx2vJ5BZvYaG37RhHpXiRpp?=
 =?us-ascii?Q?4GPMSt8XEahctNP5W3HA2K4Y7Ct51OFbhGrpMdsjkxRL8+CO/ouQahr5ogP4?=
 =?us-ascii?Q?bfhOtdyuX5fs0Qhk1efbcjF7moW7UgTVquW12DPQbxlWt6tEQgyhu/63rgr/?=
 =?us-ascii?Q?80iuiGplNFichIiqqpF2KNxxrgcRMLrbZ4tPhvd5p8N3qESjPFJ7LqvhfCAk?=
 =?us-ascii?Q?/bvFQJes5sL9JS99jIlxC/3yRFg/yTo27r/TzCXuaQzZ2aBgD6aiE9QNmcHX?=
 =?us-ascii?Q?E+SSA8QvSA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb81013-ae44-4358-6dba-08de80a5720f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:08:40.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIB5i2wE5Y4CvqWjSsdUORQsczJR01RYRpdvfH7xVjXOIOxNR4RriuVzfbIJRakOW4JixMaq+xOLQxD598kB4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 8be44eaf4e1e..e03aba825c18 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -533,6 +533,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&pcie0_refclk>,
 		 <&clk IMX8MM_CLK_PCIE1_AUX>;
@@ -559,6 +560,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+};
+
 &sai2 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index f2e1854f38a0..fa96432697ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1369,6 +1369,17 @@ pcie0: pcie@33800000 {
 			phys = <&pcie_phy>;
 			phy-names = "pcie-phy";
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
-- 
2.37.1

