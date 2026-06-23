Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0B2EB874;
	Tue, 23 Jun 2026 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183975; cv=fail; b=mGXbZnvuZBnU0FrVr4on+mFlgGNX5QWOklkNAJ1nh8tNk+9iq6YEUm4Vt3LFgQTzYMYG9vaN9/vLPxxdQ+oBCSbc4XE6QVr5+3RhwmNr+8ZcFv6Xruu9zgKeL00uh+0ymNL5q0jo2Tj+gg5DZY0dl3KZQqT29VXsGelXPQ/7t4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183975; c=relaxed/simple;
	bh=YYfCjtm78W7zrB1vpCPgH9+pibezgVe2FY5Ewc8ptuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PA03hlaTZhp3MD6CmqEGUauy9+J66SEhtQSuQQzXw+qcuDkIBYgHBlpYvW5z2902AI+UXgWnEOMh04SkJ8YjuWREgMRQxKMJn+j+WKP6L0bOItZJQ3eW73SfErKYS1UoBvwwRVrA9b/HDY/Kv9nTSE8Z80tt9hMmbdu1hOhzLVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=s1AI/Ykh; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s1AI/Ykh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rt+kQTf7g9lG3vuQuDluR50+o7uzWJ5aOJeDYGh5jGbsCjaDdzhW3T7ABHU2pZBiyzg3Yo7kenCmT1s1DmtQ4RYF4jt2YwpVhW5o7J6BNtB4/JydBU/pqzNL+492gmfaMJnPrKz0MTW0MjcEKpAemI17Gwgf4skKajosP1ZdjOjYit0gH+1NQ0BQJdziT1VoqMSFFIyW6lvOn0O377G622y6889vTQVbdu+KwuAMHZErEe0mvUWRxXszrFTPXtddjypMsG1a6+ZmxngV+pFAIHfpgOGSkio4SAOmGorVM00YXHSOEbG2MXk/aEyMQbciO5DUHy07aPsQJuZvF7ddOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f48RV4ofvmwfRHkoXli/oMlDLzN76hal50VkdpUe5W0=;
 b=GOw6Xq5TLuQ85P8TbqC42qCfXIDngJ4hp+dGO3F4YcHaj1BDY1wsOQ8rZoKCXt673VDg1Xk/ilnpbzyu9/ycmhpRUpXwMCOH8X8Lr6rCXCwHCyiD6yUlttVRmNKBIn1laGZHwbYg3p/nG8f7Fdcaru/OY/k0lKbcu6juIGGsr9vLn6zMkB60j3mdk4kJOaO1kp+KxkR4AkRRIKqXnIeC7kdBoueteERteMcNcoqmyFq166/VI+CYmPDxeHYUjkoqUgfOGTFM6JVLL5zOiF5arnS/+ufM7019zywVX0zrRmWPOxeGoxVKUIM2oaj+S9Sej8+dRQVjretEJ/JSFEJO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f48RV4ofvmwfRHkoXli/oMlDLzN76hal50VkdpUe5W0=;
 b=s1AI/YkhL+uDOXvg7XGGXy+3Ygz5GjH7ifdLyEi0RR7vYWy57r+j241SjhO31HTDKuC0ilkCVnVhcShjtcB+i3ZZ6NLRbKTbXbFs/Dh8yeeLttdjO9GdYMVrxEXQSQJW0OlUTcqI5/ioYevPLXxoNbusZoZ6vY1b4zdI3cGghlCZWdx44i52QpkR25hp/dVCq3Cvk7+STD2kP07TphBVMfJ3tWHN0sc+76rG+gcpzqjsBWpfEFA6eoVDd6cEXsbjMmW/5timflgvw9DoxQhUczwEmJUABGW8W5wV6KJUnNicUbBx22lx4e7RGijD7KdxITg+tGfTW19xmPChA8WDeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI0PR04MB12188.eurprd04.prod.outlook.com (2603:10a6:800:332::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:06:11 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:06:11 +0000
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
Subject: [PATCH V2 8/8] arm64: dts: imx8qxp-mek: Describe the PCIe M.2 Key E connector
Date: Tue, 23 Jun 2026 11:07:35 +0800
Message-ID: <20260623030736.1421537-9-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
References: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI0PR04MB12188:EE_
X-MS-Office365-Filtering-Correlation-Id: 59864ad8-0b7a-466b-aa3f-08ded0d460ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	rNpZuzN9SikXXqaeyfbDPjRwGOZO4nJbwnpGVzDotDCPCi6rdw+b6OVgN7z+PdpsXf/HXNNqcFGKHJjBfBPNUg7H77AMbyZGWzmowG4GnbgYA5PBjCzQ4mVlq5glGhj0GGRpcGfoQpiCRpod0tg33F13Zp2IYfgtYeHLxDdyGzQUTC5S0FP69ZjKGudZ3a6ilIOOj7IjQrp/Wup8f3bdkXfPWwYSctvus9g4NSBmImrC+9lIsLkYjQ5Ifar+cDUPGIAwrpW4rdygzHuE9c5AGUwcl2oC8AdzlAc5x1dmZmb89/OO1ZfHLPmgzFPJsL9D/ijOh5YLI07n+wzVOBKumJETeH8MW0YY0r7jWmsKGbTzuLbqJg4aflm5FpoYWNwpA8SV4XmOd9PQmabT4aQ42Z2LZ/Z3oB/Fnuu7OPXnqTStHw/JjZFLTwI7/mVglZ/tVGOVCayUDS0Snm+8SMTNgBNGmecRXqo2oEAESwkGtU6ma+hm5k+ug0h1e/NTfQ5BkK5ChMRUfYmKqAhj5erVE87ZSo1vDnD0DLe2zvB4qs+/782IfXPphq9sjHOSAEqsDlNenEDBUufdycDRf3ZJAxXot8YmHEAlr8Ym4zYQMCHyPan/T6+Rdy/AyyUXxFk0o45IxThIgsfCRJhfYduOA2aDYN3UHl3TcQcusOnhJnn+Uqf6fWtwbLHYD4vxys0inRbrTMEQVi8CwFNj+HBDmw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JU/aGD20U4FYc+QlUcnu/iO0ox4Wmz71D7wd+6yo74vI/qn9zaxMzxVy0z+s?=
 =?us-ascii?Q?wyMuCw7dEg5o0juAtABvvdMJ+3Xcg20JG9bc+OwRc94B4tmxx58S0uDNPmSk?=
 =?us-ascii?Q?JbSWxTTxpRIkxywn8NDV33gmHAHNxj8KKncC3sIzc+UcsL/+S4zpW3tXOevk?=
 =?us-ascii?Q?UaRDvKr2TGtgaRsqOqULjlEkjEY5UsRwMKU9YQ0X13YBdDlynDdIGAqFVRxZ?=
 =?us-ascii?Q?vLClS0E4Jf5+aDOZOGFx7MrZrf/1+LGZ1PZD7O+eUUm5kRkmEvU1gY7lRPD1?=
 =?us-ascii?Q?KtWv8EB9Y1LgAtA6IQhXDkOsfZo2uJ01/pkEJz8HiC1QpOmaPeVzWGcVHqbS?=
 =?us-ascii?Q?jq/XqxCo7blY8KXt9NFtQ2FiVh7oHXxAyQsK8F2tmayENTgzLsSHwNZu/cdV?=
 =?us-ascii?Q?VEIBC1ItZ3aL4CMmVTiOR7qgyb60VkjYsqFiz9VJELb06Gy5GuMHbBRCMs6/?=
 =?us-ascii?Q?2xlrv5iYG3Fz952as48KnkWHiJqA+C+oxGMDdfn3bvxZgQcpd87gHC7w9sB6?=
 =?us-ascii?Q?KG6NSSD/2GEcpZPpoBtR1q4WHY7om5rXxWpuyiXYhDE4U+G1aQLdj/a2cao/?=
 =?us-ascii?Q?5s/5P9ufrnpFTKFI+kvznQI39/xj2nR5Ph+C8Mf+qeC9xsKdSmZjVN1GKGSU?=
 =?us-ascii?Q?SReJaIpFzaFXrlV491uq6JbTBCHgzTHDhp6lHKKAZSKlBex76O0KzxoBYiO+?=
 =?us-ascii?Q?7pakVj24wAhj6PlrNnjELoMOvbvZSS78SuOufMBH29QcgNYvMHFWJgjtwOvZ?=
 =?us-ascii?Q?ZpivCFk+1oy0eCvye9N8JX2MEs5d9x8tROMrCdVzRiN785z7tNb7KEOYOl4g?=
 =?us-ascii?Q?Jm7agpCUaE7tBKg+omH+xwIAEZlzTO+GOWLsumN3lc20B9AVsYYb+uD3ZJxy?=
 =?us-ascii?Q?FR28muQfJUy+qXQd54/2YJfqUsJANEA0nw7PiqVFhLHhSmYVQWonrkv/YUqe?=
 =?us-ascii?Q?r7XzZuARP77azWC79CDl0JrZx0JKPj6ZdmXvAcHdd7aIG7VSi31hB9jTsDOg?=
 =?us-ascii?Q?7crgHM3yS3VBXs73H+6LXgWvu6lO1a4xWK0uPodi+O5ItlPgaLz+gtOwrrO2?=
 =?us-ascii?Q?xCiFI8z99jpaSwYeiyHqC17Y7seGAD3ckSCWr5DNpeTjVLx9ZU0x/E6Gh4/Z?=
 =?us-ascii?Q?8XldfzNGBf5CYDcoqR9OiM+AXlIXkx/TQAr4x+/Ax1Lr4pUqzu3gh/2+96DR?=
 =?us-ascii?Q?LASevAE8YlR8uSFHoUXXibjk0bsc6GNA/BzXNjHpUFSfQEw/8K6lFCQaj9hM?=
 =?us-ascii?Q?jwYl3kB48+XBYYFOLDSkaWE0El9ZxtZJcYSjIn/F0JtPmUgkBZ9Z3X1eFE2U?=
 =?us-ascii?Q?5Mmxkwz0Fbpg4Y1ODhVOq1fj/r0LnxG3uCgVjYNjTIoCxogi1uudFgQQFAD0?=
 =?us-ascii?Q?smTNdr16oO6sn5UEFVyuOQnhSB7M06IJRvE4gT3gjyxSyHfx8a9EF1XzqUHY?=
 =?us-ascii?Q?N3TP8fzB/hUtTUU0/dC9EUI4fxlR2GSCt1kfMUDZ4KuzKQnAaS4IqksCQQW7?=
 =?us-ascii?Q?UqtCS6nWFz27quyqEkd5L6LDgEqnB7eoGB3IGQqxKfDdBU53+cTL67swdsGr?=
 =?us-ascii?Q?nwwyV151EkUyJf8hfQUX6RRlRexzKuAwN83jGixmCx2x/xmy8OFdQPtPqUAn?=
 =?us-ascii?Q?P/Ci1KDMwm9ra+HlBuvVwNPGhhZKnrYC6xFdrNrdgpujmGxwS0TxRaZChlyI?=
 =?us-ascii?Q?pYZJplORTbDgwkEhbqmEEDumlLfhlg32q+CpQGDvYOOSMxGX6ImXLb6sdPMI?=
 =?us-ascii?Q?a2xS7i0OvbDfIHB2ZN+t0EX1MLt7n/Q0a+Hm1loXpP0FyRLpfeay?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59864ad8-0b7a-466b-aa3f-08ded0d460ee
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:06:11.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFpcJaECiJLC7JjzkbDj1lMO5ADgTUkOgbhWeScXNqBQ5jxwMQgxaDtrTRzk+GLFBCTzZKTAg4pJdqn4THOq6VaLjeTFyxTESweloI//CnKeed8d2IC7/aSyKHEi2B66
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12188

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

