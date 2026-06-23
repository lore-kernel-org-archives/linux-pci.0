Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013054.outbound.protection.outlook.com [52.101.72.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE241A6835;
	Tue, 23 Jun 2026 03:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183920; cv=fail; b=WY8b12t9RJYmnrToS0KnT8F946Fa5WROfwJYwjmZRVQH9IGAe0ISErVLR5PVRp97iJxRkz1fOcpDhGRRmjr96jqsC5qP4LPTCmcAdtu3E6eL4ElgK+VCbF+YgkpuOkvhumGVIxydPU2aUe6HSl9IJc/uVxZslI/NRnF83TSTos4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183920; c=relaxed/simple;
	bh=vpUUvY8qAUeEItL1TZCTz9Dd8Kbqt/2v/WXOsDy/t4U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KlX18MMPxsCfzKPk5UozqfMra5sXrbuR9wv/OiPDgkpqAecSa9aB1R9olzYTiy97U7zCxLagiHl30dFs6RyKjh5BHB0LWP6mjkAOSoOCYYUwxhvVQGcnfA1vYscUMIHMRfF0pEp8o0vlvO61bk4LhczIx9HvZTcnUEtx+hkdifU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=V0mLOuNk; arc=fail smtp.client-ip=52.101.72.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V0mLOuNk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5EMHQ4FZHV4zZKL+OSlH/akGI5ujc3LMBKQ47JBiyay/AsO0vwAfvIaoJUrtVqvZa2jqYP+VeXSyhDjSDZUObHWylkBQWmr7xJzCYuoaCPFlZlbGUGhJ4qz45jkK9DqL9WQsiLjy+EoO2AlrG3A3C6eQHwy+rSuZo/6b9HdPNoDlhSWuhWor8mQzTyPKu55dkIkzAJav5vn0CzGUtL6ix71D9h/U25Ri1RX3FHJTvxnl5nRyAP26/Fg3WkwzVvcXKiFj6yCjaVzvZdCm9v80+S7ESkZ3N92S/myG8ne/LORdAn6ruAvehwIeIy4pgxYh6PRsHzYMhvWGHB63fbSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=En/yUf9IZBkB4xKITEIDv9ReMxigCkNcRMhPkyzBuZU=;
 b=dQ2AV1lqAi+taWTcwosbEG3ojTSOcC3kPD9D2YHnnnfGJTdQ48SZ2MUZ94xH4CL9MFT40UTaxzWrMgyllivghFQxR8fR9CRX5KCYvDjpMCIulRLkLgNaaEsN9OmeBAIRob16ZSUYyncjUtdODHGv8JEt8le1wkYko4Qp65GkhzQaVzD6cvXzr9j20p7niMSCIljM7jokIY0g1eSqs/0H9653cPNAG9ajMAcOCQTwUBQ8NnvAZnNs009wRF4cUMyRLP3X39V1Lukrx2tKZOTbghW3XduM/WPGmzbTO4QRCTtaUuTpxYKelzYLVXvwfT/VAR0gaRX32OXb15/L673n1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En/yUf9IZBkB4xKITEIDv9ReMxigCkNcRMhPkyzBuZU=;
 b=V0mLOuNkc2I1wU9VdLfawoe5rXP2Xg8RbmE2IqdXocPBp9Zqw09lRYfxTOUvMDydU+RgMfk6X5WG1Vn29VnaWHKnbXiVJz4XdEHviLmhmQelKpQB8bcuMn/ATIxgYBHqWx2k88t90TYhMIwndFeqZF1i5Us73ocW3QYZgTxQIej6ST3oR11C7EUujxUWNmSBLOwkwjZ/RqmGWqpQa4lm6lrY2iipP2W9HjM+niocHRKi+ZT6Be9UrKBhyM5AojEm7DAtI+lrTXqgwkVR0uBD9Kvc5VJbh5qlFCdGX5jmzjfS7C2F3snqIf3TSMDKCWsl0aEvwJgvXk9zZd6BB989mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI0PR04MB12188.eurprd04.prod.outlook.com (2603:10a6:800:332::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:05:15 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:05:15 +0000
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
Subject: [PATCH V2 0/8] Add PCIe M.2 Key E connector support for NXP i.MX boards
Date: Tue, 23 Jun 2026 11:07:27 +0800
Message-ID: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI0PR04MB12188:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b59244-ed90-4f61-3467-08ded0d43f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|921020|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	IO7dFASUo5b1ndMWaemCSw4iZEmRklo9n7K2lzzFMJS9sjj9fmqWPfoYmH6BdpJMtDuub1gtr9b2gg2jbL0ipo5X8WCLyRr4mYU3oRVL9ULUWqoaiBMKXtShMo0FTPVBnTYniZ31j1EkxpGkpBQ39AKcTrhcOdhljc5LBfKLDN6bm5Z9+FQRREukC11QyYoZa30THRtsNdCYt8XuO3N/Bk0/BmZ/Ve2yONUrDq9V04CinOIzTe0I811Lpqa5S06z+KEXwv+bHI8Wc98zv7C9V1Lvi0MhTtg+PytAH+Sf8tzaymElCeSWjLXIYMdBv4FAiZOwlte5hQJbxe6LbtIF/mvRKr78Ma0WeuO7NGbWRX0hF2GoEBNnSXzAWWB8hgsXj2T8+E7UvyxQnLx+exiQxyLqeT5XVPcK9x/BqCa+ikzL7y6+cS06L2B52S3IhLohKsm/I1GH/tYvhOlgs+7p8ASN+f6J+mX/BnfN5cKp7geYoHr8w82uREri02CRMqMRztDuJfqAcS05E1+N4mMKZrxWlBtM5MzsgLs/dDZzhwxvqlrnjOPH5FBGvv8vtAjnsT2/zjqqZa04sVwdkSm/+keCHzbbz+8onAEQnFvqv7A99IL8QA1RsqmIP7e7RuQVMbsGIIOMogMEgRZldjhFjtw4nJv8zH0mmcPngmU1pRGOkpRkvBJZ9Hu37IfqvAP28EL76tKWSr5dgdqMVKzddg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(921020)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jj3pdV/uwL0ocbKrEu0zzvFlCDumwV32dQxyrWaAgN5tY5yMwrOboruzRUvU?=
 =?us-ascii?Q?k1/ngtLB3DTc2cg51yhyaZR24Y2sJ0ydqdWnBTGFqarVaUsVLI2e1y3c7QX1?=
 =?us-ascii?Q?rJdRxft6Sa874icaOfCaYup0biDoyk/uBRTX7pWzJiLzbtBmxDbAfcLyvvY5?=
 =?us-ascii?Q?nRca/7d2hak80ODtQVGcg+E8EIrDDa5CvDaJiCjGeNJU4VvBNK147sHZipxU?=
 =?us-ascii?Q?TNfX6BS+yo8Q9t8hFb69m9lXUjgUxp9oKfEhYodD4JFb3wvGVgENToiiP0h/?=
 =?us-ascii?Q?9hs8J6gqQubkLscR6TFCv7bDRnHz3tEb/kEqoIcoavPT6JqJikMIA2NtOyS5?=
 =?us-ascii?Q?6EEhpo/NrNkk1vOv3MHeW8qIZA5sniUF/3eRKh9Sx99TxEmsL0T38qUA9oJQ?=
 =?us-ascii?Q?UMRLre+QwD4j/3TntE9IPfenIpe8u++c5mN2ItU/5nTWcVYQvoiKVTfmKwIF?=
 =?us-ascii?Q?O3E17UQsnLKDaW2AgjQ6j+qntFUMu9bOdcnMcuAv7H+SvJG2oO6dhk1SRKtU?=
 =?us-ascii?Q?l+SaNlCLhnB4nc4+ojSmvVv29y8O2tnLx0M5Ob77AI4Y4NGbSAIkXZe3rTB+?=
 =?us-ascii?Q?WvVeM3JECBHhtjlBhoyEwAbA4SS143576GHoNT/xL6O61tbmaQhnjBEed+MB?=
 =?us-ascii?Q?Q1hqlqrRXFl5jcLOvSml95zp1ORinyJQg3vNgq4qJ9SD/ewKa5/kprS9S5qB?=
 =?us-ascii?Q?V0P0qFE63D84YXSvt5og9I7EaMb1FQPuxk6nkmvF5os2JD/iA5C52Xzf06jy?=
 =?us-ascii?Q?aAeDx9MzAULYyiuAZo4zlF4q2+ztKyILCon661uFBiZ1uJIJH8hAR6LYVukN?=
 =?us-ascii?Q?V152VxVEPPPlqXEyN40o3lbId8sn705j4MLiajJA96hVjvnHS+nWj4YioUc4?=
 =?us-ascii?Q?PD4gkARgsvn8f9hULgyrUNZ/VqbYWDSA1vGV+G5a29joDXQ/KN8e1nJ6d7Ct?=
 =?us-ascii?Q?JSIVGjAjUvu3AMd0YjQb/UhQi9qRnU8Gevme0Nf+mYj3EP2YtGFedCjzeIo6?=
 =?us-ascii?Q?3IO+A682PdRQ7qjNChvyicySzZ0g3vDS37cMP6LQj+Tk+GuDUSTCoGuIubMb?=
 =?us-ascii?Q?x0DCxWRPsT45u3qArbRaYFlcjqMQE1vFfX6AOr0r3BzN01NmdqlENEVvF35Z?=
 =?us-ascii?Q?//yzaruHFZWWiWbbHdTvaXs8rGPyumOFc/iIibNgjgrErQndNzGgi+HiTwwF?=
 =?us-ascii?Q?g3RHB2P7NZBWrzxjlL2cB0gmfZGHTa8XJJw6GDMdBRRgSq2J/yUOmYRr9V1L?=
 =?us-ascii?Q?dCgMfg+OnQCJC7cYbrnISTELzfACnGXpYTQdwoIC7XZNBKz4KRGZB8/pgFIP?=
 =?us-ascii?Q?8YDKEhyHGmeFJhqm4rcE2ymgDpMXmJsbO/ijZLhvgoEXyZAfvhW+C2B8oUPW?=
 =?us-ascii?Q?dSrptLqlwMTVuhCEiFCUjaeSISAZynXBqRfb7PO+fEKjE4UKtOWpMSAC3tm1?=
 =?us-ascii?Q?UpJa+g189Ml4OceHl5AfZRBE94awzxBG1oHeePL0ochlcbhI5zhgmYBIZzyG?=
 =?us-ascii?Q?b6ajnex+J9zHPDkqoesK9hV4mQ61eYLrvqqzxNNKv8GmCfrRcxkw+WrZtzbu?=
 =?us-ascii?Q?qO5peFoELugotwD7LcVYBMSBViD4K5Y6TENMxvJHS9+aEmzfSY8jwFUAOaxj?=
 =?us-ascii?Q?yKFueLd69KkrMY+u2sMMJaTWfNnpTqoWn4TV0RpG9xWjMw7IBSf7XJPPxfaT?=
 =?us-ascii?Q?eIio6YFyam0Rpv2J9vXCVjoLW2DNFJMZlIwOAL8jLBgsP3f0oXjYGUrhCzHN?=
 =?us-ascii?Q?3djb6DAH6WdrSK9U3aWpLldEH3Ia7X/SdJ7SFhXJ7ASfJ+FR5uz8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b59244-ed90-4f61-3467-08ded0d43f3c
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:05:14.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mZx8MekaLWZbhbgHiQ1DzWRw2moGbCw3mkoW73wWsGzhFdPnFK867nofdsXTKVsizOHRBlTyhD7neoH6MVDHCltIX42JKp4fyYOh3BMJdc5PWrzeZdHax+DLl4CqCgv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12188

From: Sherry Sun <sherry.sun@nxp.com>

This series adds support for NXP Wi-Fi/BT combo chips (88W9098, AW693)
inserted into PCIe M.2 Key E connectors on several i.MX EVK/MEK boards.

For M.2 cards that rely on PCIe L2 link state and wake-up mechanisms, the
card must remain powered during suspend. Patch #1 uses the existing
dw_pcie_rp::skip_pwrctrl_off flag to skip power-off during suspend and skip
power-on during the init path.

Also the btnxpuart driver is extended to obtain a pwrseq descriptor via the
OF graph on the UART controller device in patch #3.

Note: Patch #4-8 in this patch set depends on the following [1] and [2]
DTS patches.
[1] https://lore.kernel.org/all/20260616105201.3214395-1-sherry.sun@oss.nxp.com/
[2] https://lore.kernel.org/all/20260520084904.2424253-1-sherry.sun@oss.nxp.com/

---
Changes in V2:
1. Rebased on top of 7.1.0.
2. Removed the power_off error handling in patch #3 because pwrseq_put()
   would call pwrseq_power_off() to automatically clean.
3. Collected the tags.
---

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
 drivers/bluetooth/btnxpuart.c                 | 14 +++++
 drivers/pci/controller/dwc/pci-imx6.c         | 36 +++++++-----
 drivers/power/sequencing/pwrseq-pcie-m2.c     |  4 ++
 8 files changed, 248 insertions(+), 73 deletions(-)

-- 
2.50.1

