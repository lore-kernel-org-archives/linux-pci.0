Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5A3264DD;
	Mon, 13 Jul 2026 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783909973; cv=fail; b=n/l6WXdorERJpAXrZa/vNu9Werx52Yfiui+sZXTdM/buwFr24QwD6F3az1GlmCeDOoM8DNXJeF08JR9mhkG+hXzVqrxVFsmXyQ9iwBVhUwWKo30tQnnVf8SXsyr7YDy0vsI/xw7zeskHhYeWrc30A6p9dLM99vCWL6W0uc13svg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783909973; c=relaxed/simple;
	bh=gaVlYUmID78Qdg0bjv4Rny3c5Q9MZrWFZqAysR8gksY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ip14GCjp98XSE70fK+zbikXCqMBHp3NeCKpJx/SDFq9Zx3qtmK4G0UhwgNeGe8qBw5GuFszuXBxXFtA6CrUDWFLbvz5EBPNKl0UmEohiYyN1/tNv6tGrPmLUUF+zYIo6QYJhaucfsXyhOUZOug6MGeqzrv+nL+8ozA/tyb8NnK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UPqofFh4; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UPqofFh4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dH7Kc+8FOIIi6JKyAo76qGJL6LaM/y3LNqt8z2CyF5BbvBno9dSbWgaEaZXkIRUM54QeJFRfWqUfeX/4HOrX+XJvFeieaX6YuZP0Sh8IK4akQX8Bs4nvUtpxsXUtES7tVrQHTh8F895flGDHCR08zhwHV294A7oSBTIXDgeITY1djQ/TfsdW/rAvm4VRYQLUV5JUk0prbJt0njRGKXbW1Kus1Tfd/wCvXrZ0sqi0CcI1usiaBcZTWWDfGIOqb8FmuPZ7fRR+blGGX2Hi1Q3vTjIP1atXHTvbIU5siy4U3pVFun14n7CnmZu4Ja9W2jEjrwijyrcF8mj5R/JlSWvhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmSlTgbiYGe/2JPvw3yUOYyOATLeHJ0hM/0WUrpKlK4=;
 b=eLUoWbNmXwuuKR4VB3C9XRiTU8j6VsibohBqmMVp7lP+J0kjQVg+v5UWMbVg4eVaUmyGEliY5dy7ldpSoHtaPMkzfxhAIj+cEvHXStE9orP62cNSxTlKJXwILa4OcUHxig2/GzuIcEj2jeYzJ9iOdVM3a94IeF0wbB36FLASvHUj9Y+O4uf8JGIO1XTVrxhN58szuh172gyL+Nk3y5GXjN3AFO4rIg4VGF/1hspBdOkFcqa9GtWrm19fumc59hfXsVEFtEjmoEAY0HdBcF5iJlvN+zYu69lmucJvd0JOpfAKQRRzdidAM/U4YUlDA3zx/M+1f8PMSuU4JROuIIp7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmSlTgbiYGe/2JPvw3yUOYyOATLeHJ0hM/0WUrpKlK4=;
 b=UPqofFh4nY1Yphu6H8JvsftBklHCWStPAfRRSRNPrRwckGwPMYQMitNib2oUVJXbpnHfb5LUDQ5MJQ8J4np2gHQVkQtdBi33FCtaKEinWP7L9mY9d+TNxMmv8rlXikTH5Nq1zY2knWapFXoAK0CkzCGzWs8qJ875q6h/KStBQhIfMwfcRL7tR9MG88/Diqu6m0JI9pp9FGc0V8wD6HqdNsRh3vUjucgnUFqz4SCJ2w/sTC/JrYr6RvueiBft9wbL3hpMiZsez5hbgN2uvNLmhLELza4+dpixeULKJGUGM1bK3ZXziJ7ghOQPL0G5YvT5Eq6YPE3IAzPmfYqIFHYJfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DUZPR04MB9983.eurprd04.prod.outlook.com (2603:10a6:10:4d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 13 Jul
 2026 02:32:40 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 02:32:40 +0000
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
Subject: [PATCH V6 4/4] arm64: dts: imx95-19x19-evk: Describe the PCIe M.2 Key E connector
Date: Mon, 13 Jul 2026 10:34:35 +0800
Message-ID: <20260713023435.235765-5-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
References: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DUZPR04MB9983:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a579bd1-18d7-486b-b055-08dee08702a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|7416014|1800799024|366016|22082099003|56012099006|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	7aRg6Cs6XkoHDqBhjteKS/rK1XLB0w2FeAwMfQO+HG5qpF4IpTl7bu+Xd9KI86aozTNn+vax8UFIa72IH+z5Pjfb1rZlmt0jReJ+P5EujE11aMtTqDOS4vD1ulH7bbVpNmV904b7n8WldxyOr66mJeSgACa4T+y6mIbiO7GnBaT9DAeHKtoM3PzEXG5IaM0VXHy4YBCHAkAEIFF3I35b++z+7E5wrHQV/kGLplHPoytkr4CaFDf5FJVE9JJGExWbI7LOUu/if6060tlLUqtk9vRnoBWHTgUQ6xVYEL3sg81DzB5woYJAOdj5r7y8CVBmZtPqqXc+lX3M928RqM4jfDuZJCnD5Tkeyet1wH1qw9CzfMrGQ2eyEMfeVbxgs0jCFyxJku7N/oULe7JI2KSUNrHw+UhH3dZg81vAfuk/WrByHJhIQlqxbwKxbvpYH0zTYWPaGT9HcYmcHyUBMrlgM8u1ACP1vO2FSHqLUHpHGjHcRXLS9xOs7Uq54tgFwbxIMKENwlDaSXrrfl4MIFCElizLIuybm2rHPyBSmFw/A7Ns1WVteIv0c0VeafE8sOEpmktlCsePriHxn71lrnihGMbj8zJ6qnhN2uriuhXFeCjyPCYDiSKOIGJoonqB32P3KdvbiO6m3wvQuzvSLmeh/yIAXHe1RQ2MiINAy+fDWCnT23S07pOiRie3jlNZMd6Ec2z8zbGpSxDGjsAdUWFiCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(7416014)(1800799024)(366016)(22082099003)(56012099006)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6hGSMH4mI3szqgMSvlHtZQ/3gq7n85Mq34FbgInroLpMe3EmjAPVgu9ugO5p?=
 =?us-ascii?Q?2bCmtVxfdNpz4aU2mnQbE4MuRBbYJQ10PvWfe8maJ1pX8u0AGVhj7Y68Pv+W?=
 =?us-ascii?Q?vGDUry9yxpth/PWi4ykPfXLChWvDku/l6i9nnFCG0Fu9JUsF2ay2szbK2s81?=
 =?us-ascii?Q?WsOzAiAq25uABBvkI5MNWOZ/nCz4w9HTTLKty3XoPXfra/d9gna6vhTRsU88?=
 =?us-ascii?Q?et7ZHUJb/SX5nBzg4RQyF+hBwjIcPZ6b/+owziMILpK/VdKuZB/sjUWqEb7o?=
 =?us-ascii?Q?pzc1zxV5ZP8C/s/OQ0DQVkfZXqa6ZpfMqbeAkfOkzB7rGvY9VWgXfsemwAsL?=
 =?us-ascii?Q?AbOmAA95O9J9s5R/n+sswxVVU5+BJtHMmckUDX+Bs4WTgdu67zyb/gdTYNGs?=
 =?us-ascii?Q?aCWXxvH9vqnO5x0QxgnGvuLxhTGRhuFQBGkN33hNCASs1e3kfnJ7sjnNYkTp?=
 =?us-ascii?Q?hCSRCkx0AsSxr0JwqlznjwL3fmP4vbcA8ecbXD0QO/iUgiyAgvpXhjW0YpSh?=
 =?us-ascii?Q?FQKmFtwm1meyoLkDrtU45c5yitcEdUZ9xoeKLWjesa0KRjwJClFJk2hP9NLv?=
 =?us-ascii?Q?J3iRcjOKs+k0gLwoVLG/Ykwpsppz361yHggf6syNCDupzjbRmeaoFaQoarMi?=
 =?us-ascii?Q?LCld853tyInsO+l00VPS06wmB+WUw7S+dDbROL8RzHiTyIT4Oxuk4eY3FiKY?=
 =?us-ascii?Q?oGYo+eQHyqEB0tFydkg/086LpXqCbr7g3i3hy6a0rnJs500skiMaSROGe10k?=
 =?us-ascii?Q?M6iSw4seCuoRqug1cIS82/URbW39wBx/M9Vft6rJkESBRo2LBZPUP1gEBbjQ?=
 =?us-ascii?Q?MSfInArFU7Mr9LQ61JzcVsCvLco7CtzvfKz/KDOHLzK3kFLxZ82eM/Idy2o9?=
 =?us-ascii?Q?wLGt2bgVO3yYYbx5ED6LXq+zzUBuBGd56tlwanEIcx8DS4f+bKHCHZMMTMI2?=
 =?us-ascii?Q?cHdJTwIHKh2eIZKQm/9Gi9Zpul0wHJUlP+vMf+r5TNanklbznEpA1FVTTBWu?=
 =?us-ascii?Q?Bz8o8Sl30zuhEJefxKdbA7vaIq1rp5nUDnKZoi37bP63atBSsB1SeTFZ55Db?=
 =?us-ascii?Q?F6IDORKd2NAwbTMUfysLUh64euRvextZXxs0jIN2bUdwC5PWj7mvFsfKohJ1?=
 =?us-ascii?Q?ua/QoBQoPPVQlH8wobw7VKoIPXpJmDv58PTs1A4TtLx6Ndw6zuvUaX10R5vL?=
 =?us-ascii?Q?tsGsDw2KcQ9/7P/llXIHf33C/+adM+Rb2QEqJIKu3pIoEPOC7MgU+MdLiDNF?=
 =?us-ascii?Q?kl6NMU1Pfs/FqYy4u3c9MRsUcs3zMbpYUKRIedUr0Ht7lqZZuQ+b3GZ4HU7s?=
 =?us-ascii?Q?+MYKpUo0qef9NVI1Fi/7NiDpIKhCbJatGarnwugQhOAZRncTnlIAQddTnO9/?=
 =?us-ascii?Q?1a6C9ctzWSYK3NlLhGpxuGZC2RvF5ThQ3qVKuMiP3RDUX/GotlcbbAj/TtTr?=
 =?us-ascii?Q?DszoFF0Nc2eTGhNy1MJCyFYm+2TPa+38CBKUL0eWSe/fiJmmaG0mYRTpiplU?=
 =?us-ascii?Q?TVtwAUUsN3Bp+vPYKS9qnFcrjZ8HWXugrjnaiv8Bd3FDRxEqhnjLR7RjDBY2?=
 =?us-ascii?Q?DoURVMW4SscRG3i+GcZAdDNxNsuRaAdaIE+u5IBF48Zk5WaKqAow6ClyVs5v?=
 =?us-ascii?Q?u6APeILQk4auEoLdG3xYABIneKQzJJCtoj1nTetgfFue4QBDhDDRNJBUflkQ?=
 =?us-ascii?Q?OOxqsIL24vgWg5SdYoQEA21PF1PdHauAnlwUB7anPPgrYZIq0w7WRyD6DbCQ?=
 =?us-ascii?Q?ablzlef3WYlWkIl1hpNrupQOwnaYVw9MZuvQnaQN6kCqz3Krg2oT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a579bd1-18d7-486b-b055-08dee08702a3
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 02:32:40.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Buzj9FagtqOm8oMRPMrPrOBVmwqhFBvlDjgWZYOXm6B6HQjW33Hbgd3E7j3AG38sGNniWA2QSqQMd7ecFBX+ra6juZMSiOvUw35siXLPbFObE5/QfIBjO0dicLSLzn6m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9983

From: Sherry Sun <sherry.sun@nxp.com>

The i.MX95-19x19-EVK has the PCIe M.2 Mechanical Key E connector to
connect wireless connectivity cards over PCIe and UART interfaces. Hence,
describe the connector node and link it with the PCIe 0 Root Port and
LPUART5 nodes through graph port/endpoint.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 55 ++++++++++++++-----
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 340ab0253ec2..1ed1a8282edc 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -57,6 +57,37 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
 
+	m2-connector {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&reg_m2_pwr>;
+		w-disable1-gpios = <&i2c7_pcal6524 6 GPIO_ACTIVE_LOW>;
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
+					remote-endpoint = <&pcie0_port0_ep>;
+				};
+			};
+
+			port@3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+				m2_e_uart_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&lpuart5_ep>;
+				};
+			};
+		};
+	};
+
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
 		#cooling-cells = <2>;
@@ -145,16 +176,6 @@ reg_m2_pwr: regulator-m2-pwr {
 		startup-delay-us = <5000>;
 	};
 
-	reg_pcie0: regulator-pcie {
-		compatible = "regulator-fixed";
-		regulator-name = "PCIE_WLAN_EN";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&reg_m2_pwr>;
-		gpio = <&i2c7_pcal6524 6 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_slot_pwr: regulator-slot-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "PCIe slot-power";
@@ -477,8 +498,10 @@ &lpuart5 {
 	pinctrl-0 = <&pinctrl_uart5>;
 	status = "okay";
 
-	bluetooth {
-		compatible = "nxp,88w8987-bt";
+	port {
+		lpuart5_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
 	};
 };
 
@@ -555,8 +578,12 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
-	vpcie3v3-supply = <&reg_pcie0>;
-	vpcie3v3aux-supply = <&reg_pcie0>;
+
+	port {
+		pcie0_port0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
 };
 
 &pcie1 {
-- 
2.50.1

