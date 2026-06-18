Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A02D73A0;
	Thu, 18 Jun 2026 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777337; cv=fail; b=dhf2nsJTQIYy5YjuUdyM3qxEIthdlJz2vDspnzJwRiO4EUW227wl7rxVPR83cEW8xP0YVOR/8uXpU66W3H9WM1f3rRF64VKjqvBmnILjhtOOfXoNBwLInjbhx1CoqaoJa/hEZW6A6L2SZv1qUscuDLv5Tg3gWX8g66s9WEwDkA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777337; c=relaxed/simple;
	bh=tUwwonqofHfKZnpl1wAORJ3tQIykfy776qrOGpSnLCY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j91PGFSVlcxNiEqS1YmNTPyXgPhdPn6xWUSmj7d0gkzc1PDDd/+gwZcCaE+/uGHitpXh1t+2NGgDRBdpiWJwz+PVz2cPReHgisMI34gWv7nYguQzXUzwQKc6NVkWRaZIIxwR9Yz2dPQhn1MxEakPfJwtL2OSoicWHPh7McyU/z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y9AivHeS; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y9AivHeS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoYDQ9r3zTHyo8IjbBPKJVw5X1w0Jx6IJ1Z/xJBIhCu8HCRvBdaPP3feG7dlPmL6uT+kSNe7fFqPHOBIzXw6TK0meN9kuBcQVg8y+5FL4gdWQGBqAiY1xRjjKBYu1PuMGFaLf+ZfOL+kJ9a4xWfQnznWOqe4X8Mm8FcSZLfK436QbJn7wR2f2ezCbppCGwnQbVT4lRQDIyu+vdPPeVcj6+P4kTUp1jB6WOhjkBRFzGnhZjkXyDNlkTop3YHoq4jBJ9rnr6ZXRGfAm43in1jzoEpX1XUoRwDY/5Q3gFyBlJygZikgSQlc4YT5pH6kuQkbPyxvUEab4fQumcCnoGUv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQgh72Tn8plXrugW1KYz69wIYcxA8/NvYhF/VKOg9EI=;
 b=f8cXC1npaOqoTfc5/zZPb1AlfVQhrtpEcajcAHnIVXlWEeZNBl5MxG06btx41Dx51sNWUeYciR0f1ErEjhbG1sbuDg0SNBcBHN4i/h1xHwuiIDZMHicbLO3yoBVQKsYxUeflXiCo6IaUPNoOSTfyvpKSvtr058Sp2+ygIibKyIlvFTDOnq8m7KtO1G/PAgqT3Vg8+8AKEqpgEcx5ipM92Y7zMs93hZz4D1Ds3xRvENZMsbgsVNT4cS6rzeHwHkV3zPJJL8EWsrVQR4ho1ADB0RTmw9VNiK4M1jhWzBxMQ6irQcMr+KCZ8pi6lelFA2tqhZnGrOt2tuqU9h9gym3LqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQgh72Tn8plXrugW1KYz69wIYcxA8/NvYhF/VKOg9EI=;
 b=Y9AivHeS5Zw2aa7SzStVNa7u6pvGa0xzfGA3KDMrVqZTcWqqoBDUOtgGbRPsEKnugPtGtbcqwR2I4LEtbv8ddNOHlcsGW509bmdtKMZVgY93ONtmHYqS4IFUUJyGUjtPq7Tx3YRlANc7Ucngu1mJx+ex1lhzGndngC9Z7w2F7kDQdXJqrxDa5j9szz+TsDDcWiuBJ7GcZQ8LEQC+ddkor+CNkC1M0OSFxareOVLIx0rdBTh5BuaI9rRgDKJWIcHZ3UZSGJPV5xwqoBBj+UYi0KOE7znt/f8l9+BWgfEjasipC5V0yH9QZryr42Y9TBfPAITj4IofbzW3r6ThllwKeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:08:51 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 10:08:51 +0000
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
Subject: [PATCH 0/8] Add PCIe M.2 Key E connector support for NXP i.MX boards
Date: Thu, 18 Jun 2026 18:10:39 +0800
Message-ID: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0246.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::13) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI1PR04MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c20aef-1540-42a6-24b8-08decd21983c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|23010399003|1800799024|921020|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	qdk2ksUCKuTKQ73b3W2FJ3LQqzhXtan24aZeyjtk8ayaeEK1tVIrEyf2ph9Bw97ztPoH/DR4FJk6fYA9pV/0vx6VZ1nRvutqKIN/XO5R3fmIQKDL70zzX9Cvz2s7sh1YiXrT9k3wdU6aYSj3veRvcGHkb76TPAcD5K1WoqQjjR1FUoDhlnMl2ZtgtESFX+iSZuQjylFFGGVRdGRer8QM4BjV+6CmYQji5jMVSApKALnHn/iAI7uxvH3pFwQrGqnNhz8MhQK3qpQBBzF2YviihtD4to0toX604tcII1nA4orrsSb9rrzO3w0KoHjPxesvP7o/737gPHyN4s8xKg4hcCH5qu113nzZXJ6dn8Sjcd0PedUxQDzBIcqETpzFAxUvzxNPL6cCYlqABlLyj00AKDkpz71hKpNqVBxl0nZFiN4wmR+P2tuF/zkAYL+Lv2KOqJzKLnEk0saqTNgQYdAbM2MQ0mw5LRvAp3+/+Dj5Wg2LZcVInDxh0oBnZkyRg1jLfmd7PnskJN9l8Asreuwyny/gscAzhgi34ZW34Oxdfn4J9hIVGaV7FsttFvJTJGFPo9UE5CnmEFjX6zuWaQ7lmNSrCrMPQnlCs2k9kmYhGcf1oI41eMrvb7FOn+pSftKf7IpU7lTMR9vunsMvOWy8/zowqQv7A8GErwcC3TYJhu5wP9Y9M2ZWP+dpXnnvK/KWj/8jUJBSWcVWhRxKCxt4ljpmQ8ALBro490wlx+F0GHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(23010399003)(1800799024)(921020)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ee/EnfOp+H5OVShYMhxhIWZefkh0nG0adm+oCeDb+C+kZibFodVxAuRMUDeT?=
 =?us-ascii?Q?FRjb/WuKAH14LeFDgzTR+ASgmVqL1xWzfTvBh2HeCb0+51PATn/Tp/ix2JTn?=
 =?us-ascii?Q?3uC/ZbTwX4t5Y/JIqJn7BzfFDVPgaC1TxEAZsIg+BrNTAChRns/1k+kDhAYD?=
 =?us-ascii?Q?p0B6czGWnxWY5xvQd1zHS+nzp6P1ORwdild6WXUZs0JtcI9zojtW8nINtWwE?=
 =?us-ascii?Q?Tf087lGQ+dIepCahil1qcffls4wrJyBKEDfQtQp31IKG9t34QGnboG2ajL23?=
 =?us-ascii?Q?eOkR8sX8AbNP4rUzzx+PyuRvPLl4S8lVjHzCFbQAXmDChIyN0M90tTBm539d?=
 =?us-ascii?Q?WXuDXdtytxU6ysSDm9BIX/rKMS/cmCCpTNh/4X5sVCFCT/5yWMItaa6REe1Y?=
 =?us-ascii?Q?AT4uKkd2nCHu0kbxGUBRFlKKOD9aSs0ZFQdw6UKLDPeLU3q5iWW/+6THzxHv?=
 =?us-ascii?Q?ry/jUId+M7XdYGgeQ1Ym96CAbDk2UBOMESvvvvle4dXSILaElq2VR4e5NEt1?=
 =?us-ascii?Q?r8cpP5h0UTgMGR58G1ic/CJTCwBZ7b/tQYIUTn8LMP1mFfIWQEt7OG4HHTPO?=
 =?us-ascii?Q?eCGeivqH6e3jtE1p5lwRcJL4J0iDtjqantNW6AE1B7gIIu2u0F5fcrTJ7R5h?=
 =?us-ascii?Q?ZlrZbGOCsNUqHRjunJ6JJqLx0tfh88kH4VrKWlgKuXrhhdRP2Ir+meBT7wom?=
 =?us-ascii?Q?ilqhyuM91Tbcz0Pvulqy12iNmhE0cjy90z1JBMLlJi1IDcjDOWvcfLxV8dmm?=
 =?us-ascii?Q?hWQO+YjGAP4QDo4I4y4QwqvZQtP6rS4Sg4/60rSWJHHPdIC6rcUW83uPeXNo?=
 =?us-ascii?Q?pqMac6HX/lpTwD1aq4MmKsUWUmaGe+6Z2x2FsveS0qNajlc2oNvF7Fam0jjW?=
 =?us-ascii?Q?dkZSbOIQuHmNuhTvkTABRb+Ez3TpKQpMp+N4wlYvwDVHNMuuzy7FyWzchG0E?=
 =?us-ascii?Q?qpjLi0sUwif3fUBGjbCC2gBiyWDbkXWSAwTV0+0gthwS30xWB3Lf83rEXzxw?=
 =?us-ascii?Q?3QFvuINk1WmmpqTO4ZVGHMUwdAZ6QhERmIe8Ij3Osw3h1LNUbpqPWrpWsDbh?=
 =?us-ascii?Q?7izfMGkgX+OjSOoEj1Ix4jaN9XwCQ7toq5jLAv9A6eYdXtitkAWsTbs5TXnN?=
 =?us-ascii?Q?+pL8G+FN2QU2EdHnVISuVH+1kQLOj/RpF75HyMcatDD9uCx3hXSLSYsay2e5?=
 =?us-ascii?Q?Hp0ZoUO6WNMk9d9UHw1tMXCcQyQPejONUl2qY7gwgWx7wnk2OdY+/gMhWTzJ?=
 =?us-ascii?Q?tM5HDeJyCA+FJlbY2EtL0Qjbow1sStb8hgPoYXiUTL9F2sRCMxG56yl/7G/k?=
 =?us-ascii?Q?L4vEMEsrlAbjP1lwj3yD6YntlpyfgoM0qfbFeCisN15REKBay7ilFPjjfZ7c?=
 =?us-ascii?Q?lIXJ0fYK4eMBMOQ1G0GKlvE71uO8sjNBnQuw3zM1zqKcwGphPKsDM/tA0Xj6?=
 =?us-ascii?Q?ysNgJ9rZP3t1DZ9fjTnrCilMnNXaLMysGGB/vKpASwbYoJ/ccVqANJGPh0Qy?=
 =?us-ascii?Q?MuDMmF1nBTJuveNxF5XJN7h0rgLru3Qu4G4FuidYBA1PyPkKPc4m1FSBodW3?=
 =?us-ascii?Q?QbEXeuUEjTXJJ5jzYPhbW/37VbIejm1eTYEmOTJAp4TYQ+dLD8StIHDiQapD?=
 =?us-ascii?Q?OSF5nqRZJI0tf8SWctLjng6fXBcOqjRyuwB0g4QIXLWu4rjUSZsAl7xHkxhJ?=
 =?us-ascii?Q?UtifqP7Vo6mZCw4FzqMvc+1uBv7lToZ3Nqe4HpnKmxWJf4eevCmXVt0UMtln?=
 =?us-ascii?Q?VCycRRN3YRhw6INcgIaPzemB0udjEei6vJfjo7C8KFnzTNcDhJ/S?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c20aef-1540-42a6-24b8-08decd21983c
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:08:51.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CBt2k9wMniqOqMcPBnjN4WWh6oTnJ7Ed8u/jRq8UgHOAnR/jNyVDgpmrx1ggzoNFIHLJH+Lndq75e9sQi3+cEhRo2Z37VoTu7TICrD+qAxE6/jzWGKx1EaDpC65adHF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905

From: Sherry Sun <sherry.sun@nxp.com>

This series adds support for NXP Wi-Fi/BT combo chips (88W9098, AW693)
inserted into PCIe M.2 Key E connectors on several i.MX EVK/MEK boards.

For M.2 cards that rely on PCIe L2 link state and wake-up mechanisms, the
card must remain powered during suspend. Patch 1 uses the existing
dw_pcie_rp::skip_pwrctrl_off flag to skip power-off during suspend and skip
power-on during the init path.

Alsp the btnxpuart driver is extended to obtain a pwrseq descriptor via the
OF graph on the UART controller device in patch 2.

Sherry Sun (8):
  PCI: imx6: Add skip_pwrctrl_off flag support
  power: sequencing: pcie-m2: Add PCI ID for NXP 88W9098 and AW693
    Bluetooth
  Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
  arm64: dts: imx8mq-evk: Describe the PCIe M.2 Key E connector
  arm64: dts: imx95-19x19-evk: Describe the PCIe M.2 Key E connector
  arm64: dts: imx8dxl-evk: Describe the PCIe M.2 Key E connector
  arm64: dts: imx8qm-mek: Describe the PCIe M.2 Key E connector
  arm64: dts: imx8qxp-mek: Describe the PCIe M.2 Key E connector

 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 56 +++++++++++++-----
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 44 ++++++++++++--
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 58 ++++++++++++++-----
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 54 ++++++++++++-----
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 55 +++++++++++++-----
 drivers/bluetooth/btnxpuart.c                 | 33 ++++++++++-
 drivers/pci/controller/dwc/pci-imx6.c         | 36 +++++++-----
 drivers/power/sequencing/pwrseq-pcie-m2.c     |  4 ++
 8 files changed, 264 insertions(+), 76 deletions(-)

-- 
2.50.1

