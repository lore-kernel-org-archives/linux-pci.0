Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F43F5BF8;
	Wed,  3 Jun 2026 06:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467754; cv=fail; b=WRyNT+94dGaZOi53hbOtAv5N3oilfYutmfVa0sbbcj0cXXkUfDBH4f+TNT/DZn5acbULjWTXOuesYgTdnAg2QUvu076oPX7/7uVu2pS0Gy0O4GoxS/1iEgHzAQXKsrkNe+ZIRy6DXC4EUyd4OfF/rw7C6rsg1Tr/9dTErmoqVpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467754; c=relaxed/simple;
	bh=s7XumtKl8zGwMrayc2aqeDQ3+1FXg1iULlFpwPDEGHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d4ayyTffdu3DMWeJZAlIqw0HUUeqwmHZ33+UnEBQNHntWHk2T1sclP/pBMVJd2Oun9sJYvtGMJo0IBoQQ+yH9qYGDr6xjkQuRhInvwitfA5yxerpdaDzpBN13s3/6F0oY54GgscHDo6X9K5AQnj8eQMu+iKEs5peOaEqkKDNp5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=c47QqiTC; arc=fail smtp.client-ip=52.101.83.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c47QqiTC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elk1vXHnFrUHZhMPsEkAcX7H8zvnBosO0RjxQU7SOZrHNgclLi4+xRc9x54LrHDhgWdEP0sFANZFW/2SRSOfqa1KvScR4Uumy8hZh2IGq8Hv5hUEACCBJGhaflcXxqDHzAl2RkVqlYL+3WMqxj33Bmg7EQ52d0ntAoNqCSwGxuMIIrLzW9wAxIJeZ/UpGSzHNQCswvmpfyGr9fQVx8ClQxS72w2yBqLvgQPJ2zAhfcuxt+zALVCzqpvUNZ1SaKxNFo06lEo1MYRZZmnoqkvfHX9P/7qsMVvyBrDvuVdP9SzLoDxrF7O/+QRRiOj/0qHzYjZ87w8148JMyLvbqdjyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pmLHNVQTwRhPPgDGD4+ceJg/sD4Ow1EkhP8RZ0rvm0=;
 b=Q3rVkYSiF9ZUhjSs7wa8Ui/OJb2siP4LSKPP+yKlvTyFovZby+/1biMiAm41DhlwZm14UuWs9OSU1FepB9N2l1Rz74J30OAG9H9vqLkuGehPFuVREJdZMiwGfF5nlENlix+VQHh9n0TLrCplgLdh5vmYa2JhcwVXmr7vMD4UJLhZt1vMTcFViGCyMd6UzPGifX05U3ExZ5iXdO9NBWxA4CWUdtAKpWdjPzOFWOm9OnfPR6f5Fpm+BQkFl3YNiHnYivV5KU8SwdE+FigEeB3HF971LB848qOzVXc3VBl/5qK3BpGaqDzt+fT4GP5UqjUN4tTuWky1hOfEmCrxztCehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pmLHNVQTwRhPPgDGD4+ceJg/sD4Ow1EkhP8RZ0rvm0=;
 b=c47QqiTCknA49L0EayB9pfdgP5zV1+C4CzzH5gZmiZPR6VpixjgKlXaqmGRrTlk2go62ZlrERl4q6wEC5ghOolVw78wwAGob9RkHjrB1rGEQtK6Sex23xtikAScbww/M8jcxVV7xel2gt+msQw1NP8Bok84iN2OA+4K8UG6UxiwguvP26hU68zq9Qpm8ky4+bQagjaLG4GUOtYeFyQA2G7p/fDcXWlHBeJzMvNT31XUSPAcivjgUxqAWo1umUNJ6rLrTvSWcndWZhZA5sQL1bqU3CAX0bHSPCQb8WJlf3W3JNe6upDOC7YiAQtb4TGINnZQJPw+9nbxWysuouOetpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by PA2PR04MB10311.eurprd04.prod.outlook.com (2603:10a6:102:413::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:22:30 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:22:30 +0000
From: hongxing.zhu@oss.nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v6 2/3] arm64: dts: imx95: Add dma, intr, aer and pme interrupts for PCIe
Date: Wed,  3 Jun 2026 14:25:09 +0800
Message-Id: <20260603062510.3767610-3-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603062510.3767610-1-hongxing.zhu@oss.nxp.com>
References: <20260603062510.3767610-1-hongxing.zhu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::25) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|PA2PR04MB10311:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ff97e6-b32f-481a-3303-08dec1387d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	3mh4T0gQB29ofE9RkXLYszWeJpC73++jOwbPH8nwVr/Vjd9TwWIbkZNchuc4s00Ok+0e7kSonfmXCPjbOVakoG37lLSNi7qDM8nF6FjIhelWWm1wmwgaNfmYIK3zFMqwWwZYAiHtWBAO3GT3Enhm6odZ8RhaMDX/9ASotmsJXFa3rbxJrSIWXcRovCJw1E3lIE5F1qsJQOhzS913dgH4MPVC0iD2P0S2m8FD+FAkyXOH/2T0JICGdCMuAGDiYohLPaAFU7zzohwf6++l2sylI5xWSiOsagvTTdsozr1ivycZB3Wz3xiH1I11AYJnvWIWtV6pbedn8PfMh/HNdSchuw3hedXIQJYp2qGuPGDv2C8PWcRsJ/a2LE/gu3fS/Ke0FHV+0Kp1oD8YjBtQcTAGi2EUQFuxL0Q2sIl9ualTC69//epCRyT1/E6YD+DbJAaXLX88hmFtIOHzuikwi2PPEyxZdjxX3U75uufYutpVTf4Dvm4reNyplNRNCuQMMfre7CMbwb2aifwDpySjpy1msvACBRwy0BzQIw9+HlY3tGzWNYIMdiZMuFS1PG5MwD8aD3a/dco9QNbAVrnvGgcaGTk8cssCj9hSUMZUD8C/77kjldx74olFg0H1oXCYIqMmoOOVvJbi+I3vH16hcNyCySo7tfQhTblZbV8EOWz83oxORvof4H9IncP5GpX4PMMbKMhLhHRdhazOHxrskG8iCFgM+OBXh8vDQz0/4CjFkdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DfX0c3iNj1q5F4Pi3cz458pH7kNZhLeM3L1RftGtc1neLvxtWEWvmQiSNiJP?=
 =?us-ascii?Q?42tgJ+pbC6HS0bsq9cC9tFchLQu+NQ9RCMbdLHSUnIaUYa9/g+Q0uHb1P80H?=
 =?us-ascii?Q?6dhV8qNt/yk31pLw79Iyp6mEegBvUBBQMYbEmrmD9oiRcyY8cDCO35W4javq?=
 =?us-ascii?Q?tNBmlW857AuxzdzBKPTNUGFXejfcRmDaZ+DPjx5FjFRUDUwfAmVf6PwwpAO4?=
 =?us-ascii?Q?TYBMT3copXJIddB3sJ2sEYkdAvFLt7ty+lMewD/tY1esMy0s4xoDfaMcBqC1?=
 =?us-ascii?Q?znZO2m/hBx0hWroXZUz2YOuGHlclszRasiBR2N7ywVyQZJbL1sT/0+2+x0vR?=
 =?us-ascii?Q?QkbE431mKNcRtQn2fCh95cxTYp67D73RRLd1genKH9KQTutmajMXaQxUS3l4?=
 =?us-ascii?Q?qnhEjjR67+Ce7uLX76yt5OXVw37gUX7R6Lg3KWlbedqmHHa/sbhRTHAjbr5v?=
 =?us-ascii?Q?n9PetH8HzvhW1lmkXd4ihuzm+jTNNWzwM0NiWihoWU/TGY0nt6SheAyJ8enN?=
 =?us-ascii?Q?d0vrqtu0dyBF4GnshjHn1DvglF/e+2lJqfnfOtAYqc2weCk4XWr0ueha9cVh?=
 =?us-ascii?Q?KY1guEFjQPS8JtHdfxUdW9p03L68R0j3G2LYCGi2IM7O7qz6/1G5bAyJL1TI?=
 =?us-ascii?Q?7a+ray/cWJ1ygP0PtAjgdTgQ0eYoNvpST/5LvLl74Oh5mYPoXNN9xdhObG2+?=
 =?us-ascii?Q?+On8r8fHOz9b5hrdJ7KADs62xAx+ZxkesVgpbkkjr/TMfoWYqtD6IyMN9feE?=
 =?us-ascii?Q?ROEHH0o+AMjabafJwHns2O4cf2Bn+lvp7wb8nmgKruIUOVyVKi2zzR4kviET?=
 =?us-ascii?Q?t7D75tgUuwToQywQpu7UDK7wl9zBtvGOts5GE+Ma+JbwAYjbxfVuZtCoRH5g?=
 =?us-ascii?Q?/UO2gooy+4OID1HioBRLAo2P96xjmGqpO8bSY5x7ljQi3E4VPqBPkyCRX7dJ?=
 =?us-ascii?Q?OPQ/RxoHRDthLkx9f0nLA6Q/neN/FiLjoZUlJpx53okIwLxXzH9t06jfE50o?=
 =?us-ascii?Q?X5O2uYFdLbhD4nyipCuNmrrJfgZuYdSUJlrNkMoCIkTCBhuoUipPtrwNn5eQ?=
 =?us-ascii?Q?KtXZFmCyBIBP4zasZzAMpifqtH6bQfCbFaICdwYf7gDGQqb9Cx0C+R+cJuaR?=
 =?us-ascii?Q?axItAPSRrS7a0rQXY2DtbN2msSPsUu0mkCND9uLeDp21JcugV3zHY6SbkMzv?=
 =?us-ascii?Q?xi+9eToL69sX7t49RzefBSf9QJVyWMs6Mxv+m/kLrmVRw+jwRgOUgf4p12G5?=
 =?us-ascii?Q?DQL3+jUzNNyuyVbfdanWpsfHTQxnYf08t7zmTIi3xWsAt6SmYWP9vbx4/fWq?=
 =?us-ascii?Q?o6djVyc3LN7kl4Hh6E9WHG+4hJ8uwfxvk0+j2eP+F7awh4+3ikUr5+ito1ZN?=
 =?us-ascii?Q?qTr2uAZN+ZmLXi8OkEgfxg1rpdg7uAn5YqPMVw9e4fmgsN831UBRLaaYwZGx?=
 =?us-ascii?Q?7TqqEMIvNe1F4nwIJ1FM0zWuye9tooCeDDnPMs9c9g8Y8WNdwZxiMxKHfG3I?=
 =?us-ascii?Q?adKWOrceB7vQjmMaNd58ldgl6cWUogF7cGrWiyEjQkxnZzdR41X+34M29U7D?=
 =?us-ascii?Q?6XallMkKzTJIdpp5Qca3ChpCw715J7WJeXIk8OVS8xou6YInwvonSLcdli8A?=
 =?us-ascii?Q?QlAd+xb17rq1GklS9QMXA9nVA6uwS1WfIohfvKXqy2tD3P/B9XxEzSxHsqEW?=
 =?us-ascii?Q?teJydsX4Az6MDzkjm4PX7tpNQVlAlpYBV5OFAsXby3+qK4hP7+kghOL2aacR?=
 =?us-ascii?Q?qYRXG4y8MiD3dHEBRZJ4dIln0S2KPot++O2F4JeZB3l7/KOhLY53?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ff97e6-b32f-481a-3303-08dec1387d4c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:22:29.9918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3O+k6+R+f5ZxnTecGgnCDmbrWzPbPfmJxCK82IUrcGvuVk+SMyP3ibrhIs99RYuARmLu+0eNxobPttmf+nvh6d5lKpb3aF62wKS8ncgRDS4QZaxMPWwA4t2y08UeUOK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10311

From: Richard Zhu <hongxing.zhu@nxp.com>

The current PCIe device tree configuration only defines the MSI
interrupt, which is sufficient for basic PCIe operation but limits
advanced functionality.

Add the following interrupt lines to pcie0 and pcie1 nodes:
- dma: DMA interrupt for PCIe DMA operations
- intr: General controller events and link state changes
- aer: Advanced Error Reporting interrupt
- pme: Power Management Event interrupt

This enables enhanced PCIe features and capabilities that were
previously unavailable due to missing interrupt definitions.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 3e35c956a4d7..1a9803f96790 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1945,8 +1945,12 @@ pcie0: pcie@4c300000 {
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
 			num-viewport = <8>;
-			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "intr", "aer", "pme";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
@@ -2020,8 +2024,12 @@ pcie1: pcie@4c380000 {
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
 			num-viewport = <8>;
-			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "intr", "aer", "pme";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1

