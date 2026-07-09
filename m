Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB0408028;
	Thu,  9 Jul 2026 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592020; cv=fail; b=fNPiY9nqbgA2hBPBwY+9d6/GczbftYWImc8PMWMRso17+WkdEuasEgVbgoPH2uhjubGcNJHbK0Z+z6rqwNtQau9P2wwJVZRXM+Ov4HpSx7kS6VKh87Afg6w/fvovt8H2efKsP2X9o8RTOjygYrv3pQsZqPl9K32+IF4WagKbF4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592020; c=relaxed/simple;
	bh=yXE19QXcd8zUQ8Yn9GeUXvzH4rdyPni/nFGwBaHB4RU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=auIC/2dCIiTUey1On7VHNyYxnIXPR9Fwvnh6T90e1Zt3Uy7f4DIJShdlPEYda82s0UA4clussJ2jH7NRNipK2u0JZL9onkHYT3AdonX7MvZtyl0i3LO1uRCEYXSR0koPOsbrEYo99xqQP8bdWqMLk8pu7qnDK2aJBQCWM0OHJFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=L5TgO352; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L5TgO352"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5WLAOhxPjb44bEhUpn5OAJpXPukdioOjmAQLvFSVjHoVI0FxPi31LC1P48x2v0CxEZqK36g/Htvhd2jrVVgxdyKKPCVNtRXhROkIXFLFIl3KP5HGIDoXE2ikK8ylLH13PN6XvME7ykzgBG4icqJz0HeR2xfkj7Fnm12jU/tvn6VQvrOoZgcBRlE+I/DPRmrnt78jf/QQFvRDGlCK0dlfWFMc5xXtpRiXaz3/PFsvHmmOp9BYl9zewdXIdpMJnaw8fODHkIQyfpW+gRBiF4AlLWQAkBjceWU2qm/RQJaGDYwv3HFSg84B7lzS7xuWFJDRXpbRq32eIHIhG5PCC9/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8nAbYaMw5tEYtr+T3OG/ddjKAqjKgFZ4ekHdMp0M2I=;
 b=jij44cL3zwNTyxb9if4Rxrg+vDQTtgIY8nCiAZU25hswyzWVpxlyr3MutPsPVKtdlrc1/4IHddGe1FPb8HLrNnSYc/556KybCpBmqMPR5glqWmoF4DtVKmWRauK8DwSETs6upq54lqjPne5NvI3wCQSN5hQMPDEz2ZmYDnMYQHoBaSiX+9pLYTXgxcKwgt17x1YsxObmKwHlnuorZPO2vYRyVC3kbBIIRMout4W+awgmbKGAnMsCI1MZyTBSI0M9g6EiqKVZkwe1IFANcZ7v9wRrAAXER6ZUJxbPtZ7++3fyUy6foxVfKglC+YcrwvG8T45+5NB6PLuCDC9Ug3fVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8nAbYaMw5tEYtr+T3OG/ddjKAqjKgFZ4ekHdMp0M2I=;
 b=L5TgO352q24hOdNyW0c2+1kKMhCapQliNX2vLESCpwLXHYGY7OrV0c6cg8Q2mkVRjI9w+2/68ld5KTtRschbgKKdVIyksXtZ6hHJJb/ME5vYc0u1yPFR6f9zFr6Y6iI/4BgXDPmd+SQ+r4ylKRFkZhXpQ/xVNAqRx/akg/lOBCGiTTTHVq4wkboHQmbCRu/Fi7TTQZKFeOU8xtyM8MxNjgfV/MX6UMsatEXTKvufXpWamqS2yFUqUw8v61DsCrXNqap/GCIyk6w0IkYjQtOvKJuagT0CgtmUbW1Sif8aUjnkznluQ1eA5PQUFKK07XAJRP9n0KCSfshyTHCVfR0rZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AS5PR04MB9854.eurprd04.prod.outlook.com (2603:10a6:20b:673::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 10:13:33 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 10:13:33 +0000
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
	sherry.sun@nxp.com
Subject: [PATCH V5 0/4] Add PCIe M.2 Key E connector support for NXP i.MX boards
Date: Thu,  9 Jul 2026 18:15:51 +0800
Message-ID: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AS5PR04MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3ab8ec-8e6d-411d-6818-08dedda2bb3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|19092799006|23010399003|56012099006|11063799006|18002099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	Sw7iBDyRSiFARhR1TZhRsP0WYqRa81xUuM1tqN7k8tYJpmAzmRVbaQJn1gmvDNW8gH6w6TBepwElOYm8s04JmyKLWTGwrlkj6iylty5QxSlZcNlD0fbcdZomV5d2qFLkEZaX2rKYfGnbliRGUK0ebIDPOAzicG9eucjG8Enlyffo9fs1/v5K27BlrL+7vficG3BvFTXXv+SxR+vSbv3ZpVfS38m0oTefaBOV6Yrc43mAJ4gJ+P+7JBcE0ZGKJd1h8pzZhLc6XihIupQGvdukXAT0qpRrM4vDRRT017DQdF++5szEoqEpeiWhZrwlRhGcHTYJYrUATS4fRx2k+3MBzPY2CNBzYjyobEuYywm0G1lfglB+gwX1K7mLDzC+9xa83ayapUriWXqHUWaL8mY1XpCnSmjKtTlt9FlkseHpQLVT/6Px2fS49f7D4E8v7hoTpjIVjOwfUViPO/4kUsU8TsyI9bC016DL945YGVia+ZQvnR+n57rT/50VkUerINvPwTcViNJEZUXY+8Idu3GiCLOLSFpaHGh5P+loavj3Y4wxGYMBgMTOUfYuUT9HzCv8Kwk67PmnuvFIyO9BmLWOO5tRPLPNU16W1Y/rjST8yUgK3MlLh8lVHK7Oa/aSDUuW7/4wlbMhbHSKiqB6avyBzGtsqXYhMoCTH4K1Jsl6Q9dYXj/4nIUiMKFx6qIqe7FSqgbHp5/tX0/ZVu0fqkwkuA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(19092799006)(23010399003)(56012099006)(11063799006)(18002099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j1DLLGwWtCTts14Fs7mWRzg0NuBECJDROuRXTCzXiUuj+2rs2YidnS6JVQ1S?=
 =?us-ascii?Q?5wQixzbNpaZW8IVRuvQmSaBqyzfhQDRGqogh1ew73szd79COs6fpEy1WjJ8D?=
 =?us-ascii?Q?HZTcM4KNTZPN1cF9n7RIOpRjHqGPlDW24ASrXsrQ2q22bbkemThTCDZ28L7M?=
 =?us-ascii?Q?vgF6pYnr5vcFowNkGKAlZCDje1uFCfzJgJ9k2RstkGwy+ZU1evhGCE/ebXIW?=
 =?us-ascii?Q?xyzGf2PkiUZNCO0VTP5b4sAupSop12dXe94+ZwzZNfM+rrkU16PNiWZWvb7A?=
 =?us-ascii?Q?5JIWDEL/Cu5dNJ6UJd/UGCR30aS1JKjs7/WvyEbzZfbIpkYQepnVYFRkOoiX?=
 =?us-ascii?Q?/zgfBHbAF0QVQNxZIPKzDRGqTqi2X45Kz3nDTlxmyyJYgjZSuFdrQJbTK9Oj?=
 =?us-ascii?Q?IfpI08+9Aqoxk+GWOiTgAqde8dZeHGN2aaIdkZWhUGSwtACRxBYGUvPhAGxl?=
 =?us-ascii?Q?//PWaVdBWZhf5HkxacAxPTgxmoBGg2uoph2CosQtHmKVAanjUgJx8P7/tvdA?=
 =?us-ascii?Q?Dn+TWtKQNwE3S9dMhegEKzNjcoxhxnRBlj4xtY4niNdWjSM9eACuHBAHkC/B?=
 =?us-ascii?Q?s/f43XLPiINCVVcitBqCZKr6L1Vn3dT4jo0RWosoewOY/cXWeM1BAaiz6VcK?=
 =?us-ascii?Q?3+Q/d7pyHMzIyMgTP/OBhsp0dXvK8thV6UVroL+frGRdOiFPJiBKR4sW/m3A?=
 =?us-ascii?Q?vlScTrLsxn4PjbbBqkqk0nyfTpzqELvvSNNCyTqHd1ZyoM/hRdX4fgnaAM7a?=
 =?us-ascii?Q?yOuPst8uThn4Oe3po5S5J7yc/jXi3piuT8FbSbmo6eBzmBPSr2R2kCW8BE7L?=
 =?us-ascii?Q?UMPrFtUzhBh05tULP370gehH4IILiaMMddUx0W8Ijp+EW76hK6qSosVcb9Wj?=
 =?us-ascii?Q?jZnAsyXV5H0m6UXRqxUUeK5iNsDkMGup6xZqjtJHLgAmL2Ch+Aomp/o3qfKd?=
 =?us-ascii?Q?mYshwL3HWCXgXHdoWiDmiZLyr8vBZAEItHugbm4yNweaxPzoWYtmgaOz06Dm?=
 =?us-ascii?Q?IETwhakJ08JofHSIzu8+4A7dL6ZzyNcqEe9ESxASiPw3F4t5GwENnQYgXGpY?=
 =?us-ascii?Q?nd3KyaFl9ct2ImeOQdsEZdR83YEvIA4LPTiLeJAx6Wr0T/ubFcpN3WG/IYHP?=
 =?us-ascii?Q?IKeqfPme0/2uR2UwrjlRhuf86rOXmhhTsqxRdwm8jNxIepnjGaqvr5yt71QN?=
 =?us-ascii?Q?L4173xfO3HFTmBgXa4fzfJU+cqS5eyU/ozIBfXR+VLaTbb/7fGllJAM2zsPa?=
 =?us-ascii?Q?AEvp3niwUrclbfgkIPffQnL+GuoRWA5hTpfxtFwgc0YBvUVO0tvue8UiExm5?=
 =?us-ascii?Q?r4zwuYRnCjDn90wqPdFJgSiXgdz2/hHLGufj6ELwv967ggp1L8ZJH1nRfFN/?=
 =?us-ascii?Q?/CL3fbHytfHuN7YKoC2Rb72ADqoU9adiaMdpSVmdFG+Sto/qZmZTUH3OlvRA?=
 =?us-ascii?Q?rjw5QOAUCfAc03bxM8ntSt7x6koVQaWWChrpmI8joUB+Tww9uVD73cexghul?=
 =?us-ascii?Q?jHFK+XMjT2451gnPS4UHW41fpB+7oIWpUIbNkuH95ZsNYcy2aiy7PRbhwjfE?=
 =?us-ascii?Q?DK/mrHiHuzVBAZSUXNpNqY1J/coYT86P7ou6YJ+oqeES7Cyyb5GnazCKo7kV?=
 =?us-ascii?Q?reigx17dkr7+d0GZEs33lx/gX6QcE53aByD7CxYE0qbu/jhAZb0SCATUlrmZ?=
 =?us-ascii?Q?8iuy2hDo6ZBAZEuxUxHQq4Y2uDWjFrhedjSLFmE+q8ZnFrXm4kZgiF00dC0r?=
 =?us-ascii?Q?A7wiG27Y8vs4ozTdqYxyN1OuUTUwBDTIqr/IaByKYAN/iFbdbplP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3ab8ec-8e6d-411d-6818-08dedda2bb3b
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 10:13:33.5949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/3BNpaDZ+MHewZdVaEe+nGMtW5qQ/f7Jb/t0h0ZFA5YVN8R5Jkcz+wTf8M8IiLic5pu14GDcfAX8BzA+Le6j6u7YhPiLXf6Hj0JizUY9Rx/UWdR/K7ddQ8m4PgqVsyn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9854

From: Sherry Sun <sherry.sun@nxp.com>

This series adds support for NXP Wi-Fi/BT combo chips (88W9098, AW693)
inserted into PCIe M.2 Key E connectors on i.MX95-19x19-EVK boards.

For M.2 cards that rely on PCIe L2 link state and wake-up mechanisms, the
card must remain powered during suspend. Patch #2 uses the existing
dw_pcie_rp::skip_pwrctrl_off flag to skip power-off during suspend and skip
power-on during the init path.

Also the btnxpuart driver is extended to obtain a pwrseq descriptor via the
OF graph on the UART controller device in patch #3.

---
Changes in V5:
1. Improve the patch #1-3 commit message.
2. Remove the skip_pwrctrl_off flag check in imx_pcie_shutdown() in
   patch #2.
3. Add an explicit pwrseq_power_off() call in probe error path and
   nxp_serdev_remove() in patch #3.
4. Remove the imx8mq/imx8qm/imx8qxp/imx8dxl old platforms dts changes to
   avoid pcie functional break in some cases. For example, Uboot without
   M.2 driver support but use the new kernel dts file directly. 

Changes in V4:
1. Add a seperate patch to move pci_pwrctrl_create_devices() to
   imx_pcie_probe() as suggested by Frank.
2. Rebase the dts patches based on [2] patchset.
3. Drop pwrseq-pcie-m2 ID patch as it got applied.

Changes in V3:
1. Move pci_pwrctrl_create_devices() to imx_pcie_probe() in parch #1,
   similar to other regulator_get calls as suggested by Frank.
2. Collected the tags.

Changes in V2:
1. Rebased on top of 7.1.0.
2. Removed the power_off error handling in patch #3 because pwrseq_put()
   would call pwrseq_power_off() to automatically clean.
3. Collected the tags.
---

Sherry Sun (4):
  PCI: imx6: Move pci_pwrctrl_create_devices() to imx_pcie_probe()
  PCI: imx6: Add skip_pwrctrl_off flag support
  Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
  arm64: dts: imx95-19x19-evk: Describe the PCIe M.2 Key E connector

 .../boot/dts/freescale/imx95-19x19-evk.dts    | 55 ++++++++++++++-----
 drivers/bluetooth/btnxpuart.c                 | 34 ++++++++++--
 drivers/pci/controller/dwc/pci-imx6.c         | 38 +++++++------
 3 files changed, 92 insertions(+), 35 deletions(-)


base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
-- 
2.50.1

