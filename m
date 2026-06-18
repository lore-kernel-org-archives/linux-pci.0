Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB93A7593;
	Thu, 18 Jun 2026 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777385; cv=fail; b=UWS4ZdsplEHe0qEkGcljJIJAwO+SdULr+TShvnxQmvoAagRrQdZbuSpkUn1GyZOR3k1LLuZqC0Az8BFsj2PG6mmwxbY0urtMepetwlsYyZwcqljzsb9NrmWWiOHxja756Jkyt7MWNvf9yc0Vk/aV7QnSzdO78UuoHrzdA38MU2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777385; c=relaxed/simple;
	bh=x6E2UBc1Wr0f+S+3Gfl8t4FdwuG8wJl2j0CMh1yF0Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PNR9/Uil7tp5+UMebiMEeWZuclcDJ3SF8/Kyx3ltZ8ZIoQM54bAqe/TN1Js5+zbRz7dP6BLRfyGUBapeHoBr4zwVDTTJUNYL8ZAH3TLy0ep0HY27ABo3zl4ZJ2ey7CddzhsYjQQBERXjh5gvg9tiba39cbjAq19UnNsPCTu/9hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NF0bu28H; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NF0bu28H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9vslghdUZtPlVM2n7Jltyo/CnvwXG5MhkdR2K1dVcOQPeyN3q30eSxqb4cdwcrm184ON40Ai8+/m1AI0zpuHi8+oCWGFUr9i6RPI+VVofVO2+0aZgaxpwyu15ew7HTDWc9t8uzGyPcB5FzLIttlAEIVwz0dUtIaGeEqL+XHAXQtwyu9lZGHMFhx0zB8Y7K1O6oJSxqcFPnzGQZ8cwlQqaztfgirc4SMTXb4yULJDGleioTXc5ZP18nbXkvXCnbQUGc7PRiucDH4BucrE54OhRZl2+QmBK5tkzVQMsN1ZEycIYE8nTsXbL/X/E0Tv7tLfbkpq1/jCj+kK9TvCaVTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khbBAqF0X6yEhA27tOY5BT9dAoL+hAJc/LaqySVfBwA=;
 b=NUklfqhoVd/odhftgsba37VdeZZZxUbymLOQj7ag+4Tcw2mt+hnaqaCRPEL8dXmQMSCynAttAu83ppdXjKsrH12Bru6fa2suVcriafyAriSrWVOM3FeXrgYVMRam6/W31VtWwR5iozp6pwZ0KdEhgMsPeXQityn1AmdWJM/ORneCXInWtSA+AeGLjL1u4CGRbA5XiXceq7TzZr4IWxENbNEnv1zS5Mg2szg3VsUKDVkqmZL5y4ROX4RlvXJZI+Nlm/7Mknp0SoooPh0Ak7Uzpw/ZOJutG5rEH2/jU84kiDihfTL+FBpvBqL7DnTBPoG4fK1+piIMANNvMk5io/yXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khbBAqF0X6yEhA27tOY5BT9dAoL+hAJc/LaqySVfBwA=;
 b=NF0bu28Hm2G0/Acbp1OqHFOyild89PmBqqALAZ3iM4pOAqT4A5L5LgRUEIHU5g74SWgfKSTVvqtmYNCfCwhUaEbE7Pov1k4PrJEpxpYu087ySlKR7bsQcsQb4R8oEM+hpn8vKkJg/IVVohXsQ9F9Wa2gvpXqMzHMN1t9e5Aq3n2rP21zdTIeSaVwxOTdr9xg5Cux8VHMVGSWZ7D2nBIkRhEd7qyfAKNVXcu0q7wjcpYGs5AadeKldJnHpkqNFmro2m7+1MBTr0ppAFD3WC7xferxyER2nlMv531IpqPB+P+aXEWur0+gH7dY6SRoVutBT2OcfG3dEiYTIoGOL8Ft5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by PA1PR04MB10818.eurprd04.prod.outlook.com (2603:10a6:102:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 10:09:36 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 10:09:36 +0000
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
Subject: [PATCH 6/8] arm64: dts: imx8dxl-evk: Describe the PCIe M.2 Key E connector
Date: Thu, 18 Jun 2026 18:10:45 +0800
Message-ID: <20260618101047.4185497-7-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0221.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::9) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|PA1PR04MB10818:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8c7dd0-6fe0-4807-7f2b-08decd21b3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|19092799006|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	6WU7wxOGR2gvDyHyfLm/mEzmLnUNtIj/Nj+UDRWmaMtED9WmsiofYXgzCuHM5x9W2M4pmFEWJZjiBnTdwcUje23edOELl57Vo43rIuTXpuNNRgqq7RUXvOcXs7ZUB4TShOL/A6pd6IG7fQFmcU1J2EOuRbPEXmqa4jjI+GJihibkrgElW4gh4m1Q2hjqiYWXLa8vsBgEOfr6612/ztkRNQHB3OAL6CE85cuGF73Nd51gUrvtXKglw2ectcZws/IeGzeWFwdUcW+J8KEoey3SAF3S+jZUjz0szw1RckmqAXxCRZ3zCC4Cb14/7Rg9W2ZcEdk7j3l4Hj5ouvN4iWgdRrsZu4kJRmwKtwB9+en/grpp8vAOryK5UyupM4pu9SviIoe/X3z8xQDw8Y711DztCxRepVtkSiIHAaMGht2uXIDezyKFh4fZIawbQbk9JXvPVQB4MMc+rr7iKZKEZUh13t6L9Ern2kY25XouR6eCu+HoIZE8XNowZE+3/Lvu/aRrWTzvnDZEkwH2ykbn5EsriQH8ISaX7+lYmf3mhWqS3kr+iFU4NhFtosDN1YJtCjLyUg3Ersd3DjG8mj9QVdXaKjh2b3aW7qKNawCi+dLlp4qkTDLPRUR2oAIRNfT0FNSaH0+a9UBUpdMjDAijRFn4C85qMKve5hnhGHLQRP8yEFYEfMUPNU5XQm/d4VgvU9LGv2eSC58XhcS8qHIDM2IOxhT4hYs8PQgJCSaJlsojDQo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(19092799006)(11063799006)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iCXO4YZxu+BULo0ehqO24RaExieHyXXc8+c01dTw312cyNnpiUFaQ6lFs+Uo?=
 =?us-ascii?Q?cB0m2DBEdDDWsX31TH7H3Vs9J+YIguq2VFUbFbRdEhKP9WDutO838QmqUjYV?=
 =?us-ascii?Q?sZPAVBFfesbd0LFxVModnpPxAWOfDI9esvtepvo4HFZT8JluMWPUNt5jrCnz?=
 =?us-ascii?Q?VAQ47GjiVb1QJ1tg1Wck7wQ2HqJqAntpYiHyUQPVk7ixnqNkuNQjA0HB+57H?=
 =?us-ascii?Q?nyuGdoElnirytB93gRz3Tt0BUG9NGwoqYRng4oUJUswq2iu+Y07bgz1UZZoe?=
 =?us-ascii?Q?o9mMMkLIrcpXGd/Ruw7wOFp38Hiu1uzxT/HFw5M0wNLzMrVVuSQWEziehQvg?=
 =?us-ascii?Q?7LBBq4zuesZn85hNBGDary4oikgUJNXFUtkbPTjU2u0/MIpHQ6E+JpdrhYYY?=
 =?us-ascii?Q?BN4pHNXvgCiV8eGUBb5fT39pyHz54T05Pmu4KXX6VS3p1h9Eu0vkdHGzg1rU?=
 =?us-ascii?Q?Obfh/7dHwYpiyD9R74fJ/3rHZzxXcgABl7riO/3G1iRmtAlZGYcBbKqtjCIw?=
 =?us-ascii?Q?J/nr8YC7AN6ufQl7n41u0Jyuy72P21+8qrCAkzVJmRVdULPWFGqI4XKqhCh5?=
 =?us-ascii?Q?r5GqPbIHYocHwnpn9osvsZ+PjTZ6byHmJg6CEg2+8V68sc0Kx37TrNumishP?=
 =?us-ascii?Q?oG1SD4c5h3qZyZFLTxj/tOrW8WlPvSz76TO49+FjQJw7q3Gm+GE3vKp/LHLd?=
 =?us-ascii?Q?6k7qhsVf2a86DdzqTHNl5pzIi6TQJJeolCLTv8p6NH4+kLmhp79ZgLwrfq9B?=
 =?us-ascii?Q?hXavK1XNYP8JWJyk8FNLCDrs3EGf9mbLq5D0nkZZSIKO16Oc1alfFNZisPQ+?=
 =?us-ascii?Q?aIqUhb+ch6P6A3l5a251sHl3ZGzeW8kGJ6liHhCq4wtjdQ8MlblAtHUdYzwA?=
 =?us-ascii?Q?sYAlV78N2GheXHR0Qo5hgFrR2HbkOHQi6bfw1xPWKqd+V4YmtUML9MpiPxZg?=
 =?us-ascii?Q?O4XU7T95E1hdlBgGOxy0fm6TSKeAezgsrs5uDWbhTo34H0n2qLphHqHT0avx?=
 =?us-ascii?Q?RW9rdnMyIV0+YO8g7nCp2/WQDKVjkFhe+9F8XqzVRkakAFJl9EQvAJY6ShNu?=
 =?us-ascii?Q?bIUIj2yyoL2ZHS3zl505mp66iVW4f8/myUFeCZ0hHsuV4QXpxjLNhTHZstrL?=
 =?us-ascii?Q?SFWiJmMKM2/J4/ADwxavcKgFiasiww0isb9G34wZWI/7lfj3UcKNRVjWRGyr?=
 =?us-ascii?Q?heArLeZm9wEdD/4X0QESpniHc7z/IR8Niu8rpv1lIOmPFJXSoMnQQn6k3lOH?=
 =?us-ascii?Q?EaCncAsJkuPoiCG/laDBxqpnh1JlZMcKw97fjeJPurDo218x4kBGD4UPIhGA?=
 =?us-ascii?Q?ilP+WxR+DclFGKtba0xpaZNH+7mjpiyt2YOCGTJL0LxftAMORl6I5gK/etaV?=
 =?us-ascii?Q?4LsfCnKIo6MlEyGojSBaiJ0bTn4Bh+B4eiPmNqEMz11GkQgHfv76iqN3vWe9?=
 =?us-ascii?Q?bb80HTTnAvJzWxK02039c/sADzGevCaBdHThApUMMtCmhMrVWWE8ekYGpxml?=
 =?us-ascii?Q?RG7Z0TsshaO91rbOPB5/U/kZ7Q76LI4oZGyiFQSQX6ME9KEJXQOdyx/AlLOF?=
 =?us-ascii?Q?nuuqzysnFImU0V00z5RE+Hxt2EUJQxxJEJFcHQH6ks9whJQslXu6GLY+bJlc?=
 =?us-ascii?Q?DrEUEkXgRpwiiSQXBVXKXxUvjxKI1rZbuPxQay/cc+5WZJpA6QHhf7Tlw4J1?=
 =?us-ascii?Q?dzVEziMcXHhgIibJ9IxtujrpGltzpsCCq1fGWZiOe9SRvNIrHVWcpFsgvZWG?=
 =?us-ascii?Q?14y6YSI5YNmWvfypoStEqXQJ+pLT1QKLX5ujVvbqf5gamXW9vcJP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8c7dd0-6fe0-4807-7f2b-08decd21b3a4
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:09:36.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5MKqU2c7xeN31dufsZZtprl7FFCOqF1+ksl/J7aZe8uRs3wBjyZdW0jP8a8w6voqTsTM0cYsFCkZbvyMVen192pLnw/ZkFRq48sSkAfEFto+tIg5nQEsqTQdnjSl1l/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10818

From: Sherry Sun <sherry.sun@nxp.com>

The i.MX8DXL-EVK has the PCIe M.2 Mechanical Key E connector to connect
wireless connectivity cards over PCIe and UART interfaces. Hence,
describe the connector node and link it with the PCIe b Root Port and
LPUART1 nodes through graph port/endpoint.

The M.2 Key E connector is powered by a 3.3V fixed regulator
(reg_audio_3v3), add a reg_3v3 label to avoid confusion.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 56 ++++++++++++++-----
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 1084164d1381..6afee1f1a9fc 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -42,6 +42,37 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0 0x40000000>;
 	};
 
+	m2-connector {
+		compatible = "pcie-m2-e-connector";
+		vpcie3v3-supply = <&reg_3v3>;
+		w-disable1-gpios = <&pca6416_1 13 GPIO_ACTIVE_LOW>;
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
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -182,15 +213,6 @@ mii_select: regulator-4 {
 		regulator-always-on;
 	};
 
-	reg_pcieb: regulator-pcieb {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "reg_pcieb";
-		gpio = <&pca6416_1 13 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_audio_5v: regulator-audio-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "audio-5v";
@@ -200,7 +222,7 @@ reg_audio_5v: regulator-audio-pwr {
 		regulator-boot-on;
 	};
 
-	reg_audio_3v3: regulator-audio-3v3 {
+	reg_3v3: reg_audio_3v3: regulator-audio-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "audio-3v3";
 		regulator-min-microvolt = <3300000>;
@@ -623,8 +645,10 @@ &lpuart1 {
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
 
@@ -690,8 +714,12 @@ &pcie0_ep {
 
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
 
 &sai0 {
-- 
2.50.1

