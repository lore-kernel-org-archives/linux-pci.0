Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA02D3E833E;
	Thu, 18 Jun 2026 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777402; cv=fail; b=OlosvspgG3NuSa6X3jRk3Dk4dUbRAjYINPp1jzMXJUufYPkcNr/m5Q54yokfQ1rGTCZyI5iTaKlZQEohrmiU2ceXdhXkrrEhBEtQiiiKUY5C16OOKt/Tj9/PGylTTSpBDkA5HRcVuzFKIgoQAajIGe1CjNzOMzU2MEa8p5nfEw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777402; c=relaxed/simple;
	bh=YYfCjtm78W7zrB1vpCPgH9+pibezgVe2FY5Ewc8ptuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkFZNAFRwa+6H4STNi50KSmMXX00WRO0qxkCF9J61f4MIGuPZe1DmavkhVgJDytp3C7GbgqcvdTrFlYFphYnu38pLeY89/QOWP3QCicRq8mnaNSg8l+ihaMfldnEMb7lp3umKb66EE8dK4m8o2OrhZjwdG4AF2OzbtBgEFWQs9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UB1sDxQ2; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UB1sDxQ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf52diWsSGIULb4RRA9bFdJtA1/fPgTpKA0c2qGhcKhgjJLgsc42V9JW/pVW4zEQwWxmwk/UDgDjHLSKNKJQIQuujGQFMwfDMz6gsJixeiPjJJesFtir0s4qXCa8sHPclu4bkfGFS+7mx682EgcZdZcAu5vl4OTqAhAryuBJG653R/Lx0XRaB9QafJuwWB3A7t9NHgZT36RRpikXRLtgYzw/FdpZj/h8mi7Vl9Jxc8xHD6WzeuWqFzT8mlmlMxkzwTi449E6nrJ7Sh1QaiLk6EgCH1oOsfY4lEKht5MPVPY7e3mLqr1AMewZzjBpTMG7RMI96/QFmvV8ULhZcPwuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f48RV4ofvmwfRHkoXli/oMlDLzN76hal50VkdpUe5W0=;
 b=T231C9Vv2ZUPPjotMM0SuvJPbwvN7C9Xrub8K4v31w7axTd9St8ijblSvKzD6a+rgcjWP0JZSrNEgaSUtLeAocNCPCxqV8L1d1Nj/KTh+9anUzLQ47kpou62vcT808A/UIbWl5830Cal/Is39bytE7hQUJbZP4qNrq9HQ5ccN0Ef7wloaqUi8LCtD3gkVNWXPlmwWMZlSche1EayzCEieKcBCkWa0HlL0kAvGOJkZ3LHVV0JTCL6el1Kt+bLuJDbIPGuADR8eV0pJH3n1y5y7lU13xyQe1PSmbZECX3kW/cD8xPbfIvORHzxO1DQsj5gCy6EtysQzK0yqup98ePXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f48RV4ofvmwfRHkoXli/oMlDLzN76hal50VkdpUe5W0=;
 b=UB1sDxQ2rT6fDii+OHgCQaa758zXrzXc2xLPaeike/BXCT0/vJRn6kOV842cvkFfTdBXin+bzugZcGYKLQHJLKD5hRQb6MpCxPu2XSVYt2ht7nTWiN/MftboGHY5/kNXhKYCcCmZRwzKfMxvNnDpuuh8RnB0BfWdvVKavdKZrFNJKhutNx9MKgUvtdi4KRRKypmN07AxDoPNVxdA9RUMUjbydpQC9agRq7wTMWc/+mRADWSiKLi0vONBT7CuDc8gkysDNeZlusBZVvoKVRqbT2x2xq/PNu6sNW7izYeKQaAQH9uJmA7W4VUUO0r6/2/Izp3QAziFGe6cSnaM7oYi7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by PA1PR04MB10818.eurprd04.prod.outlook.com (2603:10a6:102:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 10:09:50 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 10:09:50 +0000
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
Subject: [PATCH 8/8] arm64: dts: imx8qxp-mek: Describe the PCIe M.2 Key E connector
Date: Thu, 18 Jun 2026 18:10:47 +0800
Message-ID: <20260618101047.4185497-9-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0237.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::13) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|PA1PR04MB10818:EE_
X-MS-Office365-Filtering-Correlation-Id: c23b1f2b-c379-4f2c-2335-08decd21bbf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|19092799006|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	jR6OOT7Mp7JM/85VnDwtYn9ndN+1Jbu38JfFdgXuDTtno061aRJpTVQjdB5ug5A/jJDk/o9hjgLPRIRHzqFKout34NWXEnx+NDwzTU5HzqGAgPKm21GcwbFXtPR0gkeNbGlwOeTFWccpQ4X7X9KIRbD5y+gjgrU1H/GEaPLNOItr6qe6M0tYDKSTuqDfiWYErda3RxhM2CuWQ3T3pXksLj2GYdUbjjZkSSj8HuPbElOdcoOEDTejs1NF/rwd2yQn0J5vT8pgYv1mSDO+FOB/SpF/xHgnWfv/ouxiN52bqJtpV2R2XSSaVIwN4hwfHnysHpRVj92rbLKyj1JOMpGN1nkpAL9sQCv1/MT707x7YotW3TWvE+8jmWnb9wuozC0xPIn7I+FaD1wXnXDrCEfx2qQpuKiHBEZ8EpBYoubgPE06KDswL+LaSoB6SqOyxL7edb8tN5/uTj2Hlrf8ox9G8Y8vfHxh6N4UkoZ8ByqzjnSfts0xSrIcMwnlLL6TlmrInDEF7IDkPMYcvvnH5Z/cCEwcj3RKrfoMo9RGc+Cf6nC+vve/w7pgbQieBQZHJCpktbMgk4mT4tpWAMMEfdMeNFL3PNKucovMhq06/G4WSeQlqouqbvd2ayame4kjs/x/aG/V73Wi47nHCMJbLES2HTE/9zCaRPdruYd1GhpuwAHomMBFoMg/ARY38aifyBmMuJ3By/lLFOgvksHm6rpLSdUZzGhnz4TxoOhNNEnPf1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(19092799006)(11063799006)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WYSxWsraHR+x0xzp1FDVf/FDBRMaWta4R5CDuc8cIUZgyKmid1p+0zpL/m4s?=
 =?us-ascii?Q?2UXqnYU2fUMPVY4lf1PoKFBNG2yt7lO5nl6TOqlX0lTLgy6vScBGObD7eWDv?=
 =?us-ascii?Q?Xri7sP5oeSn+BPA10N2dolrgPDJA6QG+ZauoTXn8aSh+igUFS5Iuq0JNGXWH?=
 =?us-ascii?Q?G9VNV5HhTlN9VzYlLtGFxuU9lfLzargWk05SX/00+uFG+y/FTpJ0ld8KFwBe?=
 =?us-ascii?Q?rz8nrTVxyLVr8GtwrkmFboLmaWqcOiSDSWrxpjFnbXKPI1JNrmSDDytdD1vD?=
 =?us-ascii?Q?Rs82Ob6B4lnkrRE6BPxazw73OfC5kRwUPojk3W7Ou6UhDW5mjV4ChR8KW9xZ?=
 =?us-ascii?Q?AbFCBFgbfOgzml2WqCC6E4Pk8xX0nffk5GBJnNIL6dBYPgDxuuu6DsRrxy6F?=
 =?us-ascii?Q?O7tG3j2AcnZWUbzz8VboxvurFXhBfqs3xd13VzboTsZy0L3ml+r64m6mTn1P?=
 =?us-ascii?Q?tOTBd4znUkA9YAO7k7SHge4c/LKqZyGOkAi9J++0iFWAvtAQITq62SQf/RRG?=
 =?us-ascii?Q?l9vGbf+brfoF8Fq771UxqPZahPbmboVt3RGvtvgYGs2p8DpSeE3U4sReOOn7?=
 =?us-ascii?Q?15xTAdGMEdIQmYO8HhoZ/qE4qUaJ6kBi8E3xuackV/IGFSnnBuunoNinLgQo?=
 =?us-ascii?Q?T+d0PzrkWG5lKK47bW5kHRBaATGf3zRk81cVHZUnf4IN94yFKB5KyPTUyL2a?=
 =?us-ascii?Q?PTdzcS5dYXF6RPWfjnyUa7OmuAJE8KG4xmQnvN3VI0xA3/8l7Ct7FRf+ajfj?=
 =?us-ascii?Q?1WBiWiO52De23/wnvF7me4sSOy7M8Rfm53emNkcArttiQ/7KVJZdYzDE/x1s?=
 =?us-ascii?Q?gV+oUH5TU2rd5zOYqyYOct9Le30SYhO+4om2/dMvLBNCmgpfSQ306MeMPdtJ?=
 =?us-ascii?Q?lKm8pM+pYz+ljhZPphEAtwwgw+NTgRHynGSePyKLFiONQxqU/7awAifXDyYq?=
 =?us-ascii?Q?h2jEpM9FvAbvMfM+JsYxNL76YHTV3oBXsDGzoYmBEHu7Vf8HjBQVb6PgD2s9?=
 =?us-ascii?Q?P8ZDkrHIM1KIYDLUBHZ9YUdkuiQWhMqliv/C4YdgXJcnGxz8PDdj/dc4BRP1?=
 =?us-ascii?Q?03iPfPaFfJtU2Whlki8MW+OsL39xeEHLNZq1KyjcQ85YwZ1VN4sy8dIMksfN?=
 =?us-ascii?Q?bKqrsaMgpTPVxuOvRuuJ/gtrCyTdDlamdEShAgTwIwrILri8TLOr4C8KnHqe?=
 =?us-ascii?Q?GdBbgTILswJV0tqq1U+8E3c7qPZ6xcKZu4K/67+6f5Jq4NSVfYblnlADuwXx?=
 =?us-ascii?Q?6XzlygvtPp3jTrDFHmY8LbljfD813DXnDixIQfCAnpkip0nm6kqaVO2+VGQx?=
 =?us-ascii?Q?uC2Sgk86O9+qW2jia10pKwYtHNUnBbfL4K9NBZRYMOevUj0kolTQYpMz9HBZ?=
 =?us-ascii?Q?5/9EQwOHrhtyAhuvTth0jfXoWLqHAxrkWKiFkfEHIAX0777eDUhqaLseax3I?=
 =?us-ascii?Q?g+FXAkYDliClHl8TAAeEm+gRjbTq2qEYjL3G8BSsGPb0SI6tx9PaJAfPv51J?=
 =?us-ascii?Q?JMzK6cJ6gfzJJJwM/1AF9kbvROQt0NgXWicwbv5Elo6elxj+BTYiH7OaWZFP?=
 =?us-ascii?Q?Fjd3zLdqPOeu4SzAL5l0yzuNdQKg6PbMG8oOwNRO7r+IIyVWYWPOzvNrv1xk?=
 =?us-ascii?Q?HVoZOgw+3AKKHKI2W/vFd9rUStpTJ8cckiCi0XJPFK9EFtdq6M6AI2Dxb2OU?=
 =?us-ascii?Q?HeFYUcSJEkHnP1+nQfFtPlsR7vKPh86GYWtQo0HMfC1siDC1fw2329hD1AGD?=
 =?us-ascii?Q?qb0AGjNwjJbFxOnnUNy1f1ZWkg4soUh0tiFNp78aKLxajXcMu9Ni?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23b1f2b-c379-4f2c-2335-08decd21bbf8
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:09:50.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3HIHQL6mUAxIaoRv0Hq9x7sYf+6CJ55NnjeHQlRZVQCT7cRcR/Y1Ua+RGPLKTB/1mbdZTtZHsRPjtNDftsEmkmQyfhI4fVViM0sdXWV3xJS8Iiwh78lJhz226ecJzA7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10818

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

