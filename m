Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD8F3FDBE0;
	Tue, 30 Jun 2026 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815464; cv=fail; b=UKW1MxI9HxClm3AjhkhvVZ/CZ7YsV0OWn2P6+BhInIv47NibEEo+9vjd3For594erQyFHnXg+3z9T5IPb/7MArgIhAf7Zmzdns5sK3vq/DHibWhH57Q13KU+3ir9ylWxZ3AHWcOGzzrC2QtfHr2r2zgq+uhJAgCEeommTdBF0AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815464; c=relaxed/simple;
	bh=IQN/8pp++gafSBiCwjT/BSJpOMAWnwdBKX3e5EJWyeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RavEP3fgdCWEAPKFXI1to8Z2s9kmtqQ/3ddHP3TqvM8JQH0Yh3eb3Y9gB2H0NJfL2M2r11c22iEm2NX6sEdemd80T9BPXbF2w2Pki+G3Oue+vaTnj4K7IwSapR3JoYh6ggUyluTo3laetci/gNHmX4RBnF47EO52SZoJYwTi3C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=a8pk65kg; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a8pk65kg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYLpphNPkOsvovWI1ckIBwxKbaeiLf7BC8RxoAAbBAJh/0W794LhcHGVQLgw9zdZXZ+9UPKBNmDL87cN3M8tJFSMWsuxlrwjqLbz8u2Bdp61xqKlzXleJ85h2tU5k64lt9GYlJfLJSjCdGHIfqGS/Pk9tPzWC4smODqPCfdLgC1XU3PZD54PRp+jO6/f9lR9zeROQfb8LGM+H15pN8YR5CblEWb8oIv7CjsPYhr5Pv+R/SBSsSTvUXrqz0rP5AJyUoZ9tS8nvZ7dgPHLU++kDHQja4SWlUCy554ecCn6d5xiYOjEJxEkYpESrhtS6OJrIZYFS/oIV5E7AzJtNj+jjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXavQD6T0JR6CFZ2ewknrlLBs3Hm4cdm4zNeMO7YoJk=;
 b=MegkLPyXmLyvvKg0mjpwh44RT/aYYSKpZmNP1TLQZJng4DTM5OAoM565l2XcL3GwlUykv9H+tpqilSU7HbJMHLZICEnt1s1zFX76Rw3eqWtIGEqmDvEXogAvqE4PoTNAt4X7s3Pqmj7EAKGJ6jmFxem1JuTUncAjQERRAuIkcV1dLnqTviytfR8NDZPMVafwwRvrpRrXgHgovH0i7zdoj3fwvqT6b+5cHk5CqlVnBfizPjfXfTYeHMJXanU09pdX6mFUIQOaSQyvfqcuESa9RlronJnvlEqZLmviblvoccch/2J0AHS98a2cyrX/tgQRMBHtMt68iEHffMoHuJK9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXavQD6T0JR6CFZ2ewknrlLBs3Hm4cdm4zNeMO7YoJk=;
 b=a8pk65kgAORjWSbOzWE/wJ+2YUekUIjAnXOhqGDf/Fv9rNwkkgIS2Deoc6gi9/xW2xfjXiIGAWGesNnHrihhy0sJ28gG9idlNQRJIGjWSe5WXYz4q8F9EYy5B6EpbNklJ+KL0wqNN1nFkDn8Dt60FwV+Aa+5rzs1z5/wLneQpf/gClvpRdzajZlZJKtpqqb60TogTSkD8jue6fRj7Mj8RQIkOFEYOLWRI7uXR7aHZerEXQlUiw6l0vrIGw6MmI0/lrRRnNPKMQ4f3PeTV6I49B3H4xTI8O6tN09jJRwF9+ZyD8EAerYX5kshqrW3OGcfnkspadGqXAhSUynBbLrfmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI2PR04MB10220.eurprd04.prod.outlook.com (2603:10a6:800:229::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:30:59 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:30:59 +0000
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
Subject: [PATCH V4 6/8] arm64: dts: imx8dxl-evk: Describe the PCIe M.2 Key E connector
Date: Tue, 30 Jun 2026 18:31:37 +0800
Message-ID: <20260630103139.3823329-7-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
References: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::7) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI2PR04MB10220:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc46b64-d411-4d72-f23a-08ded692acea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|7416014|23010399003|22082099003|11063799006|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	9J6FOlBXX0xSasOyrdfXQ1rxa2L9E+y2MUR6+lNh1hWGQDgQ4amD2hsdWNqyS00JuwCaZWkP7bhvl6oIe1tybTQtin8VtgYbnPaW32KtEdqzwzTj3ni9R7bOPhLjsjtfF4MyoOnQ+D3ixtJzWy+U3u0HU9M3gc2I6k+Cwk/KMpHdwy1A5D86QV3wFQ30Bo3dC8Q0RCrLhT6Rx+WWkF5LoCJiAShv8BoFyUt/6tBVYcz7RZzrF82EXOnBhAi/ZCiiSI1BussQxgrLmjfQAfIvfhLWnwHivfVi27LahxLe+AMUJnvcz/vhUR4xwGcEHhPRmdC60Ekv6oaTfW/axC+jXB5ZdzoBPiTjMaSaCuD7YY5JmVpt3K+ALa+1MhBq2LQ+lcwvUG6EZ1jvv8Sh/BWce6ojBfUBwTSXj2seWWEIOwXfo+S8EMpAphcran73saWCwfQppqJXCWhwShrn6mIW/lBw30jhVQLdhkjoGixwxwBRbhCl6he97M5zXvRVrvKbxyo3M07yyO8bE2mR/3vXvCT4fPa3g3ynYtW5jChm35Zu6bMoQBGf7DPxHKxxTYf8CKzqkiGtJux6YGT15JsWrg44HigTkL1XCFPH6qZMKf+KDvroId6y61CDbIN6ZExtHhrmFuN9cU1Y8hL3OHqX7LGgU3ohv08GL7POGTMraNiIrx0FaXuggW/vJRxlXDlwVXrEIyR6ywmXMimN8XUMWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(7416014)(23010399003)(22082099003)(11063799006)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tUETL84CVaCmvgUo0tdqMsU0MrWPozeetXmC1offwDPr5YfqtHJfNg0gDqzr?=
 =?us-ascii?Q?FD8J4cj01mGCHX0dmGsvQCGrkwJjKBfG0wc+PzYPcJFEbrXdRXe7ZErsAckQ?=
 =?us-ascii?Q?nKuYfkyCCHBSPCWSx6EdvlzMKiwpUWfMLjeUC7bHemXoxq7K8y97dbQNoPVe?=
 =?us-ascii?Q?dPKHoSVakoN16/TEB/C4MojOgiLeSdcDpqYgmyA4Zi/3FPwrR9QOpEdJ0yVC?=
 =?us-ascii?Q?OmI3PwwQpFckCb3HWduGQvkqrzAoK3zk+NM26OZqDn2MmvXEEiYK09mJQm7C?=
 =?us-ascii?Q?QB/fy/Ih0Oaq0Yk6Visgyha7CjE1fQTPVL2z0t3pSasTGCRvG2MJeExQ3cx7?=
 =?us-ascii?Q?80MIG0NiqrsqCGnSFU4zbHzBPYMxPI6D8wuaEQI9zMl9DKfus6V96G/gJSyq?=
 =?us-ascii?Q?6YJC2btCgfHk1u5FmO5QVZ41M1Fs6DS+7jTxWU8IIjzT5qktjFWjKof5f/BG?=
 =?us-ascii?Q?7QmMsA/kax/xAlfhdXAF5vWh0L1ILiBef2kgjt6byjzBUfD3c9ZEDF7ZrjD7?=
 =?us-ascii?Q?95WcEXtVJAQ0/40R4qCpi9UHC1iWH+lRybVSXG2ana2vbrpguk8h6z1T/0U9?=
 =?us-ascii?Q?k+i7Kc64syzBSvvmNom2lDm0Go1vkuowO31EDDOLSJ9bZ0vQFchTSKHgk4ln?=
 =?us-ascii?Q?zNIFIuNlSe2MTQ9V6PgcYOwZGIT/iLwXeoHrMP43nT0T7VZtF+DX0ed49/o6?=
 =?us-ascii?Q?XSxOPthipX1irFvrCHAGbsgQUudxUznaxSj4kPauydz9nKIU6fK8a25oBYHV?=
 =?us-ascii?Q?W0mb0/6S9qU6CgpxohdH0ioaeiPWCtdN2VKhnb4Mkdx3V94oVcPaAq/8EVpe?=
 =?us-ascii?Q?SR9JdCCHWKrTCu69pEJXv1EDWFZPpS8pPK+oEzsVFwYO07nipFwTdBq1jGEa?=
 =?us-ascii?Q?8lWLD6DrXB1k+lSJzxIFwR41M2mGcCMSx2klDTkUOg1xm5nu72GbDKbD38ff?=
 =?us-ascii?Q?EmYUOSdYOLJEYcB1Qrzt4LP+3zRk2oMaAAwJTEJrH8KYpgbxtbdlHPo3XEBz?=
 =?us-ascii?Q?KJEcHxQJd3cM1xEsCiVH6cdxLffsIJO0Eca9JE6tRF2gkwTEHvGhL15ARUZf?=
 =?us-ascii?Q?vb2ld6Q75m6rVTJPeeeN95ywVZ2+XwZYjRSMhEENAtKVoFu/tH9NEiJJofoB?=
 =?us-ascii?Q?ahil1Pkkdz9RIWxi2Qe8jYXqZw73snP0/B5QR+lsxSEMrzV9oj8ipKSiDIYl?=
 =?us-ascii?Q?aFRTXDTLP/G5ksLiEE/0kRdDF7s5e0AWvbM+hJdm2Sm+hVYCYaX8Eo/dGUKf?=
 =?us-ascii?Q?n2jLAvhRAFthtywSHtorbN8b/QM+Cfmj/stwFKCzvCmGC2qoV5spqXfHQ7Tv?=
 =?us-ascii?Q?hakhmU9/Vk24j9UR4TY+gTos5tr+5BD74KInj12abs4Vqa4ilQEwLVZXUmgZ?=
 =?us-ascii?Q?ktvuMVLr/zlFSzYz95TE4KpzAp2mvo6bbD45rEAls8E5/XetTrIvW7u/PeO1?=
 =?us-ascii?Q?c9pzlonFM05W7nKFf8bOox58jIG8+f4unRPsWgFXCJbiwLf5aQy8z6LHS2h0?=
 =?us-ascii?Q?TBBWzepqBqHJGJKDsYiQGLWvbyR0zspNr5BCh+hgxVmdWb7jMppAm7tKzqgy?=
 =?us-ascii?Q?5Zx6F7qhHbAY6JedsR/xjGvsbHNAogZHt8+j89RjoMoljH9u0noiaHF3a8OE?=
 =?us-ascii?Q?55Kb3xt4ALYHQabkawnCWnkPSMbeQPJWmxJ8uRMxdDHfkxMrXAEx8IKqjNVE?=
 =?us-ascii?Q?hRIysef8+EpyN8YgCHTueKSc18RyCK+/Zr8awWYiNx7zXWpVqIU5LVamo53G?=
 =?us-ascii?Q?O2JgHX1Tck9jj/oJhu2h/JVFerpaUjAJtoDMUPfxLuzzflnVNEXV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc46b64-d411-4d72-f23a-08ded692acea
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:30:58.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHE8z6s8IZSq/G38sbU8A65S4YSrcVKbt+LIdkb/OGOmZr754ssDcWa97vVSuT1ONmsToHOpJxTu6eZZv90rCSTpw2ETZcZh67dq6D23CDfKu7zybjupg0UIj7TKDpd2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10220

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
index 59d9fe687aaf..6afee1f1a9fc 100644
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
-	vpcie3v3-supply = <&reg_pcieb>;
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

