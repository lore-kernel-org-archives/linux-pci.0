Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926062EFDA6;
	Fri, 26 Jun 2026 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782441086; cv=fail; b=ix5T/J4HeKV7s9HDs2OFusOPoPtnvXNLvvzhUhX6SpWYKBrwEMoPqlE1LaOm3xDinVkofDG0ghHGnlYFBXpfr+ZNwWYmGNZSkBNrOv3G2WnJKe/VusxMcQMG9HQJ/SNQwUWejtlY9a1W/7lLSG4M5k+/0VhqZcWHPKeSirmU7Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782441086; c=relaxed/simple;
	bh=YYfCjtm78W7zrB1vpCPgH9+pibezgVe2FY5Ewc8ptuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GR4Xw7Ag31raysipN0DzqYkOlZ/IQ3PBRV7HevaAdqBsvZGgwsy6qtqhQhVS/nvcgaNiX2+iphx3kfM05AdQ9ZZmM+K6zqNywjkK5FWrke6dYjgG1fNSSGa76xC4mnGMpmThce0uTc+It8598o3SYy9vjhCcdxGdhxCK+4G2gKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PLzLBZpb; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PLzLBZpb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWniKAF50s9MnI2nCLQTTb2GTam0wC/pIHWkC6drPq1Tz4UkYKdzyejmhT9M9jCwY5NFrCZiIin+bK+/0cHhub5VPXDR1+pBjAbMydJudrvlgSWOwvWewcqxW7zi6EYa3vcVNnx+T7bqQSkc4M2hOFBeFL6wRjPhruUafQ/KlgamRtkyuDegm86ORIo8V0r+gWimK26pw/TZirGZUp/rhD7GvJ9T6VKDY+FO0mm7J/K5w3Luc9qdqmnLzRhL/l3mxl4dBUWHO0nDTXdko4ofo+sFicPAM+QcvJysge8ua6zQf2uDVT2RCMG8A9aITbsGP7r5wqXVAQ8atAOsuX7vdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f48RV4ofvmwfRHkoXli/oMlDLzN76hal50VkdpUe5W0=;
 b=QJdAJYXAoXHqleuVJ/RL445KzDieFTT6KDpRD8EBdvX82/RSX0+UgCy5Hv6pXLAMr0HWj3iQqu8FCBpdAcr/RN7bnrPQh6acOOhMzuUajuKY4GLLscA4W9QBKXg4K2kb7/j8SSPf/jRQpQDKSS9kptXn5HnaWCHmaZs7/b6kvV+PfKumrGuU0w1P5+NvFzYXR5gTRKZsSYEEutvITJT4J+ZxWEr+J6LJh5xvxqJoGNXtUcm1Rk5ybMn25Gnuf125ruxW2kXZWmolW7nCN54wGmr3SQOFtZiqaeVq14ODIwvoazRKXLLTTcBgh2R+u17Wf6VQnOLUvjWM/ast3H+Jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f48RV4ofvmwfRHkoXli/oMlDLzN76hal50VkdpUe5W0=;
 b=PLzLBZpbDXTB+HquKz7Ya/oOwlEVb9XU2l3TmdLcT+Ezt1sb3ULPEiHeDP98CBF2P1/plC1zISRYPYQQbVtTvXSDwSntxhPW8X0F7llEVrhWNsUMb63cXViwI8ATTpugQHdfjgPNjOJUWCugfFBu+eW66FwUQCvYHvrwedDnOn66T0p5e6SreAgJmdbZKGM3ESlPrBgQxhjc+JySJqzaQfta/ueeS9PfEA7SCMiTTvPUSDeFoepftSNPZ7pwWGauTSlrdNKd+kpJXovyqKrv91U5GPcHwI0mnIuXKjH1I/UxMsmGlNnCXc+9wARdLTQgTmhKznG33PDijjNlApH1pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 02:31:21 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 02:31:21 +0000
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
Subject: [PATCH V3 8/8] arm64: dts: imx8qxp-mek: Describe the PCIe M.2 Key E connector
Date: Fri, 26 Jun 2026 10:31:26 +0800
Message-ID: <20260626023126.2189931-9-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
References: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d96301-6523-4cba-a1cf-08ded32b02a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|19092799006|366016|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	7q0Y479zJDEm1Y9jnsRWxxW4pPSemJCCNyAPbDnwlZA35vbibJal0lCPVqJY7uqGtxH2yW9gpdMTHqqmRbyJdVFKGRUWVneIq9ufXkZjR28eHLU6dPAVwlLtDjjpkqZPNAage8jF5pVNLEzUnxr2ylC3om++XhxNHr7FCSuZ6hVtbwNMYmd/Bl1682XE6H58/gjN0Wlm3YB/6a6yRprNQ/Xd8nlJNDV2bctQH3c8bkdWlgn90l5Cy6HqLZLxbwk7Y996E4qGNWY1nIUNOjl9pbmYzTkQ2H7YgAwtvyJncjeqVGI0cwBq1S7aXiO4Mua9bvXzs0yydv8mWeKLhbfayRGJxssC/6vm2SJWvI7SNMLF712/dqWxIwg/GjK6wF7DF1V+WqieJdjjHPdFjBqa/zFOVNOqxSoZN9Ylri1TRJlr7psqU99v3z9CnSEKVKxrfPlB4srGIOljyG6JgBJtvEkB8FdKjpTJMupCdwm8T1xcYveEBcqt+244UTPKno00RqhKc2q7GsXzYgPPxq+kQ551+3c1rP2A2uob1agLdVAmSOmfGMFvMnWEJlnLxwufC+Ha/cIA1z36ByZEmW+sjoE3efqdDNlLpWiutQjo6gk4gAdYVB5A+Nxou2T4YDmgkxxBZctTgX7GUw80cASu+GRBsPliC43MOeyGLwhyWZm5mqrWADq5ryhNQ5TA6mEBNgUo2U5OqedThg0c6Fcegg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Aex8Q29olEc/xgL+JNaYbGu7wFrkj4XMDXK07UWXlvhdLOM3bukLwXnrddG5?=
 =?us-ascii?Q?6Y00sY6TfJUpxWSpVIdHQkbqtmWtaZ9Bl5g996PhBPP+vWe9ysRHLLyp7GOP?=
 =?us-ascii?Q?cuP/hA1wfrNzNSnmkCzCWTgPEDM7SWzy96YZ2ezPDC9Z7BvK0Eso2TU2DNli?=
 =?us-ascii?Q?DcBtG9r5tmgkIs0u+DDIr1I8WjOcy6zHKX3Y44hKoY6onlcjFXGGg8J1cOBX?=
 =?us-ascii?Q?47qmSgs/AodNeW8QxQMSk+3hrgcdz2Cf/TAdDIxxpDTMLOmsmOLaSZiWoLD/?=
 =?us-ascii?Q?39jOo/U4xsQM7grbdei5rI44OGCDQoHhpfz3Z/fcMGXptlKd3hxTorC131Gl?=
 =?us-ascii?Q?JC0rxnCkFaLcQ+xTXPVuXS52pMWzO7JXFpVXljHYu4eKv8JEagAGLRDwGRKs?=
 =?us-ascii?Q?N4uzCsf0JTZdhco7jbJyA7xZjcP4cU1BFvFFJJG6bqodAInFx91B0NkKHolJ?=
 =?us-ascii?Q?lESvOO+PdKXWyc2kiNfPtcclZrdGI8tEU1M9QbTg4pFPRCiyHlLmRes6/nzh?=
 =?us-ascii?Q?xK+yuE3Lf+6KY2uqf9sQ7XmqLWvsYRim9CO2s44LpCAghp9JOPIBmqamiuHh?=
 =?us-ascii?Q?4Bo3OdfeVTDJ9UNPCVw34UOgy7mJyecH6OB7a9FeeB0I3Vs9SGaDT/YjshEF?=
 =?us-ascii?Q?Oh13UmGNmBVetff4Tvv8o8CnwdW4u190JdFJRkoGxQdUY51ShzyxphGa7zZM?=
 =?us-ascii?Q?W5Rd3narGbbwUevYsllQxQV4VP6gL8zQUZkkdEVBCagScF7kMzEZDrndOj8i?=
 =?us-ascii?Q?6iIBJl5IQ0haClUQPQnkmaZr9zWHB8esf0y4qzhl7Fz7qrE7kxRIjI0cAyKM?=
 =?us-ascii?Q?T8nNt5FqjDGXoEB5VICXX508xOibNU/Sae4J6NHbzMpqO2g3kLkFB9A/vvGe?=
 =?us-ascii?Q?p06M5Pm0caQYFN76n3F2/2Uho/pXMgjDd+Sxs+2Io9NYPighwnk3ql34d48O?=
 =?us-ascii?Q?lC24StTFk67UnTcmadviHADvVROyc+YvKJiBKFu95PHJyobAf1xkcY44EphJ?=
 =?us-ascii?Q?qMftomYwbxKzrTBM91qrtJYWcrUvb/rmfGduK4xWobT1SLYAzFVEWsxE8lF8?=
 =?us-ascii?Q?wXgWRVpR3ohvZ1Yhqw2CI6/oei/Ie9IgxBSSeP62JpHc0Kl9LkFOzkjph8KN?=
 =?us-ascii?Q?yrVXE2U/UAw0bz4FW3HqIAXmUdwbVuTPkohDjJXn+UIp2XDmZqMVAWYQgxKK?=
 =?us-ascii?Q?tmpktaVAx/5+geMc27EK4q21BvhKz/TOBSPloyjMMV7rYz18eNVKOo39qtdn?=
 =?us-ascii?Q?FyXWG0MCdIFskwZ0nKlDvIbWLtOVe1/1FyzKB4FYDDPzUGGzZdTOvbUC2JtB?=
 =?us-ascii?Q?Mez2piM/pvJXhi0ay9HJvXcwCLF7aWC4r/8GpZ6Wz7BucCQAwZOr9l0orM0K?=
 =?us-ascii?Q?DQJ9G0YpJPMkG9LlFTRekDQd+d0onGrQYjQBFlCXH6mzJOPIcNGeLW3Ccwju?=
 =?us-ascii?Q?sr9iE2OlTJ9StnGpV9i7YzscwYbHT4UpRGZ4cfYZ2kEY/k0491oFQtXf1xtm?=
 =?us-ascii?Q?vBlm8fxJwpNgCCCFfww4qk/wIeWBskUPiaN27utmwJPk//A9oriZRnRISJUO?=
 =?us-ascii?Q?FGwXMim/pMV7Hl/rjH6tMW8d4TIKEaoRWScqAztHf3zLZ/LUdJ/AHANPBs7N?=
 =?us-ascii?Q?6nY3cQZFAH32QneeFkWk2Gc00ib0FQA8aifaQa3qrFYSXMwGHufhSJWwYPCm?=
 =?us-ascii?Q?+uq0bUtZr+IIxw//4KDljDackGYSRIR44ntLDliNC+CL3XAupbd8+RYjAZ2d?=
 =?us-ascii?Q?BOj4TpnuTfTwtXeceVfzwCPtwVZI98Sw40pJlzMXy3o59SmFWAOE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d96301-6523-4cba-a1cf-08ded32b02a1
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 02:31:21.5817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2BWpwH2S9/DcRlB6WGWYqZt4ZdRLkgJmXJXxGy1+miMhTSPQQ2t4uj4GGevrSe2LBqTC9ScxtGN7+NxLwVNBMaoBRXLiEdU4bs7STRey78e0KBj7xtwrLWWRj7jbHIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445

From: Sherry Sun <sherry.sun@nxp.com>

The i.MX8QXP-MEK has the PCIe M.2 Mechanical Key E connector to connect
wireless connectivity cards over PCIe and UART interfaces. Hence,
describe the connector node and link it with the PCIe b Root Port and
LPUART1 nodes through graph port/endpoint.

The M.2 Key E connector is powered by a 3.3V fixed regulator
(reg_3v3) on board.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 54 ++++++++++++++-----
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index a9b967d0a9be..c9fe4034cc2d 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -40,6 +40,37 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0 0x40000000>;
 	};
 
+	m2-connector {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&reg_3v3>;
+		w-disable1-gpios = <&pca9557_a 2 GPIO_ACTIVE_LOW>;
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
+					remote-endpoint = <&pcieb_port0_ep>;
+				};
+			};
+
+			port@3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+				m2_e_uart_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&lpuart1_ep>;
+				};
+			};
+		};
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -157,15 +188,6 @@ reg_3v3: regulator-3v3 {
 		regulator-max-microvolt = <3300000>;
 	};
 
-	reg_pcieb: regulator-pcie {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "mpcie_3v3";
-		gpio = <&pca9557_a 2 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_audio: regulator-audio {
 		compatible = "regulator-fixed";
 		regulator-max-microvolt = <3300000>;
@@ -696,8 +718,10 @@ &lpuart1 {
 	pinctrl-0 = <&pinctrl_lpuart1>;
 	status = "okay";
 
-	bluetooth {
-		compatible = "nxp,88w8987-bt";
+	port {
+		lpuart1_ep: endpoint {
+			remote-endpoint = <&m2_e_uart_ep>;
+		};
 	};
 };
 
@@ -746,8 +770,12 @@ &pcie0_ep {
 
 &pcieb_port0 {
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcieb>;
-	vpcie3v3aux-supply = <&reg_pcieb>;
+
+	port {
+		pcieb_port0_ep: endpoint {
+			remote-endpoint = <&m2_e_pcie_ep>;
+		};
+	};
 };
 
 &scu_key {
-- 
2.50.1

