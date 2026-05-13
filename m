Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E134B1AD;
	Wed, 13 May 2026 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640544; cv=fail; b=kANjdPyrAYembw1bvFb6qRAY2teSqPWHNz5lpvqcTcgVEpEhYNU9kdoE/pI6f17JzYKccoDHRBQSFA9DZa2gC7HYAriCylHPSGT6DGe+D27VARwt/CuLXQZVzs2F61avBW3tmZSPxK42aT2xmju5Fxy+m3HH2hn+Ftn65Vlbh5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640544; c=relaxed/simple;
	bh=BDhW4bZAFNPH9QuDpRxTn7IzO4Um/Ji1DpaAJRIP7iA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hFyxdbVFHyAfLhe39GOZtTyhQjCayG6qAc4MwVaHA29OW4gdf9f369fY8/cLisusWfy4z+JTkxmYhG0qaRtNDbDB3aoIhMDhdQqGC3ftFPy9CYoUVM7nk0F7DyvIL+loS6wXrRfu1d8g5F4JaQNc9b7TiPIR8J8y2C7D2n/eOg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dUdsH0y/; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dUdsH0y/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enwbVocNBPcLhF7Lx6ZcDpggCyo9olMHMZ2cO99uq8KrD20ijvSxmpcqv848642flaLYnvxMjP/g8i1wxzy88TwtDNpFjVNsSlzf0pODaFqqgSjgQtwnMSTKyLoZXVZ+LknVXcbd1uEUw8AoSMno6DvLp/6ilcsvg05feMjEvOFsA90TFVf8YRH1eZKxvkxNpPw63L3qnN14LsUMDX53xG4/ego3eFxw/yOTH/lIDUGYCSnoJ8aDm6Wil8pDSLl2Gf1ss9QsW57yTgqfxpFivZA8pF9OCnpFtnWEIfW71xq2fMJG1gVgeLFTPrnNonfUetGM8QqlWXjTTqaG8suS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PW1M58tpd29WwbhOV5Jq2RAaBXYu1zUOI3XdAjEj+4=;
 b=L7aMu5kb2VWPfgFi3UwOBDHCklq2alghwde88Q/EcCddIp/dji7XwO8lhcBjEE4nEUo9xe9JfQb2z1383VmAsM6XwjI4HQJ/sw8pmqlujqEIM2bQ5HpTKHvlU/NqinaodlThdP36SqV9Uj6wnCoVBsMV5VSVsEr02zKf6UZgywflda0pZC2ODAVEsN/BSzB489cgxoYFZdQbMGiiYI0Wc8tScuiMvCMhsQ6oMlcLk6QgeaRAeFzBsU4W27vMvu37u/K6REqHXrZe2ZRg7b6PMR9RPcKQMiKqXeDLSQrsHv+sL7rDsRlR2tD+86TlR30E91BM+nbDfK/IrUNg4JGdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PW1M58tpd29WwbhOV5Jq2RAaBXYu1zUOI3XdAjEj+4=;
 b=dUdsH0y/xImyonO75C5H8/hNxUqAoF91q2KufktWfS9ukYMESHD0omH9IOkb8esUdQLRWXlevfYqBQitqSK1m+UyLY01C7mjyISsMpnu0f1N05e6ErSivpg9VMppY3sYmoKOzQd9P2x3MAkq1EMwhzKVeDC0KJDEfLVrWUcQEz/7lGqDXv/TfekHkE8aeFbXchgzy2IaUaXJysAeewoh9fr+0BRZhE4dCuTeWf6e4/Cgp5PZSlKcKJr49t11rhBb2pWt65Aifey+EU4FK56ZW6eORUy2FjHpOeIQ//yge+Y8yhgLScurP2IH3dlpn+gigYu14hGYMcb10m8Lwzs+JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 (2603:10a6:800:317::15) by DB9PR04MB9867.eurprd04.prod.outlook.com
 (2603:10a6:10:4c0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:48:59 +0000
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a]) by VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 02:48:59 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Add root port reset to support link recovery
Date: Wed, 13 May 2026 10:50:58 +0800
Message-Id: <20260513025101.1498104-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To VI0PR04MB12008.eurprd04.prod.outlook.com
 (2603:10a6:800:317::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12008:EE_|DB9PR04MB9867:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a3b22f-c7e8-4589-6c58-08deb09a2eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|921020|38350700014|11063799003|3023799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VUY9LYFLtNeKtGOaXNjQ1lwPmTWpPomyB8Y4cpJFhrcqekkY7F2JDhWfLYBatG5XYXZI77tbOrDrjzTF4dRsL6Xazlf0HMznlVIQR6tISPvtGNsf8q51UuHyCmardfjTCVwU3pygEBG45DKe/hmBjsoUQBWHB5nfNvKxmrwuU08MwV3xFbZCIsITLJDW+XMgdKWvHanCGhA8HE0jWAESzIt885CFRODS7kMEh7m/c52cSTuWTpQVVtt36oF2Yw1RBWa9L2EB2VaVAUMKVJcBAeK4Wpq3gQjaJN2Ksrv7WobrAriNIPS8ZlJ8zIWfqQONgcrE4PSnhz8TNYJn+fx7d7C6zxYA6VcPLJZlQcUdohg4LnsDTtPcxoSM7EzSKfc+1hGMvJt5FPCvZnWRuuuAPPkvKJqlnFwNfFClf2LnaCjWKE9tPeU5ImIKcjxf3mYbBxV5na/0gjE92XewsF6JvM+9iBVgIpc8yXPPuxiHrAC4QsbvjH6waVfd8vGRNe6ACGaZrdlZW0GTIOKnbhz4rdFmcRjBnPmS4lsHrV4Tz8dKmQC88XVRILEkojGfoqL2tfrKEYtIM0pOADUoqLdnT1gI3fGteapCFFbtBp621mvBbQKKGIkHrLv20oA0e9M5lJUlWQ3XCUFtCpSXb+zVRZQz75fVlivRbAlMoEhKzQss2/9o/hIu+KWljI5MQjC96ViAfdkArGjEk6dWkUeUVKMrii7J9FKrsenOmvFXPqE9ks6vbrNcp1Bh5FNUdamgyApB5SwIcXlIdu+A5An89w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12008.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(921020)(38350700014)(11063799003)(3023799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CyyYZIZEdIHgiLErNAkXsr762jqozCLkzV3dvfHHB89Qu7V6GqH4Eafv6dqy?=
 =?us-ascii?Q?MgDVOBXjdacxutOvis75nxqEEZ1+JAYso+V0LxTy03U0ZgIXnJPpES1tYyTT?=
 =?us-ascii?Q?zhJ/N3ZKIIWoFpJhg4olJEuQCGl8R2FG8WgOHxNdTzPom256B8Tlq8vYg6S+?=
 =?us-ascii?Q?gFlgql6QHoUCH5s4vWux3r+V7GzjnOc34sNQkJic/M1zGjlbQ7Wi4afw+aR7?=
 =?us-ascii?Q?unjbWXrKM3NZlTlmEFmYlV1TAHJtLTjvSa+5tNlyQpDtoETVe9dqN/YRIbYJ?=
 =?us-ascii?Q?d4VCl9baaNVrOl2UIkx9SbclhRpoMZ6/TfYwjWrWibN7Efm2c6WxVz3is1w0?=
 =?us-ascii?Q?K1RUBZMbVDvnXGKiio4TbzEDf2HFdBcSheuuiTAdsSlb85JITDEaBX6dy148?=
 =?us-ascii?Q?S7wfpUSwohB2jfrrldQhrJw5RzJdUK2lCZjNbeBA+GRUU9Z0PUcUTXuUV2b+?=
 =?us-ascii?Q?cueo0mXe8ieTrijXCuVckTr19UcrCHMrdmhnGzzsXCV0NxjHGKJ2hLmW2D38?=
 =?us-ascii?Q?p0sJA3GiceXlLdSwJWxKHHYpemPGfl4py4adJesm20/yC7E/OudQk51/FR/B?=
 =?us-ascii?Q?gpQbJS/zT9oQSXdtGyCoJT9XXOi0Fl6u+RMV8iUP8Bhv2ChzxnDQCwanYrby?=
 =?us-ascii?Q?ESSrdZ/u6x+8nrBMb5eicJLKRw5Up8B5OCQznHzge2xV/lOt2O5hhUX8IxQv?=
 =?us-ascii?Q?7w1klxHqSKDZxyIISICzN13e8GxfSdx1tMnZoypp0PsCiF7D7LZSWyH6Dkql?=
 =?us-ascii?Q?gdCd7bIi7IQNAht2eXsxsMmrN/kLIaiqRveRJrAF3nc0ekonIdH12tGAPsHd?=
 =?us-ascii?Q?RHJX+aWSInnsPuC+xkZsYOCtbgxOLnLJ0g7A2Tzh7lD2yuG4RZdVGE7XOT64?=
 =?us-ascii?Q?8hScyYpXk/HuX7Gyi/pejyIeFFtDdLhke+Glsn6kJL7bg3roVbUS8tTtCHAI?=
 =?us-ascii?Q?mm6JkVw3fDn5C9kU1fY0SqgJhFoPyzdO8jAba4lLaHTDqN+PCzgIrGy6yIFJ?=
 =?us-ascii?Q?Q7rm9FN/h0AEBVxhISEf88wfOqYC7M2G/cFGCLSoYgknwxGRMEY//cNEzJal?=
 =?us-ascii?Q?drEnthl6l3NF26OXeRh5fg3t5aTdpSRwU03aPT5/XBGd1H6lF8V/GIX3E08j?=
 =?us-ascii?Q?lYXPKmnO/G5EZYu17GeLFsrn6Fl2bfshdUW9wJfzquV/wOPuBebORJrnaD/O?=
 =?us-ascii?Q?7soNhNgOcBIAzPDNaKin7nPKvovq6L46JQAf+IhohNai7ShE0ZhUnD0hixZs?=
 =?us-ascii?Q?QSQUe+AgB227/ttnBclib2a4BgQtGZy5UQZF5Sf5lll9mAYsSQ9Eg3/8SIro?=
 =?us-ascii?Q?J0L7qt+6c71to4RTmgNsvKsronObURBUN1iHW7S5XByEeuaFOvbiUCaNwjar?=
 =?us-ascii?Q?sbrp67mzAykTTWAwVa+15SZ0ryCX8DhOdONf/ogbLpNcDxZeNJYB2L0j0reS?=
 =?us-ascii?Q?m/wjW0YaUjipQE2STnmFcaBWauV4KY6EgTufHrKCMnY2ZcDcOsbokBub9Nx0?=
 =?us-ascii?Q?p3XUOifQ0v+jltdCtspMvCOjhW9R0ATdAxsQobcEgheG3vHCul24lnxvsJJP?=
 =?us-ascii?Q?2utR4bTf62lIERk+5+IyG3BJ5CN96ngHm8gfbFKNgeZt6RSeo3yCzQCCYnGG?=
 =?us-ascii?Q?1PZ6hrIGzRAdPoAxezYDn4cx2DNVPUCHX4/0jRXJ84LCv7QM4dn6P0Mzbd50?=
 =?us-ascii?Q?UWu8k+IPDAz46TbQrZ6N7ivGLQ3scvs4IrOClnXjKUupa2YrX02L/x+AmW4Z?=
 =?us-ascii?Q?qlLHXHsAOQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a3b22f-c7e8-4589-6c58-08deb09a2eb0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12008.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:48:59.0315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZbUmvxspe6Y3XCm5FBf7HBrQP0TBydAceCEwrzPiClxvcZqheh1/uzagDVTsneVutMGrh4gjSX4l4/iXc7Exw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9867

Based on the following patch-set[1] issued by Mani.
Add support for resetting the Root Port for i.MX PCIe to enable link recovery.

[1] [v7,0/4] PCI: Add support for resetting the Root Ports in a platform specific way

PCIe links can go down due to various unexpected circumstances. This patch series
adds root port reset support for link recovery on i.MX PCIe controllers when the
optional "intr" interrupt is present.

When a link down event is detected, the root port reset uninitializes and
reinitializes the PCIe controller, then restarts the PCIe link.

On i.MX95 platforms, link events and PME share the same interrupt line.
Link event interrupts cannot use only an IRQ thread handler because the PME
driver uses request_irq() to bind the PME interrupt directly with only the
IRQF_SHARED flag set.

To address this, we register one handler with IRQF_SHARED for link event
interrupts and manipulate the enable bits of link events to ensure the same
interrupt source is triggered only once at a time.

Additionally, this series adds 'intr', 'aer', and 'pme' interrupt entries to
the i.MX6Q PCIe binding to support PCIe event-based interrupts for general
controller events, Advanced Error Reporting, and Power Management Events
respectively.

Changes in v4:
- Set these new added three interrupts as optional interrupt.

Changes in v3:
- Don't add a new if:block; Drop the maxItems constraint of the interrupts
  property for i.MX95 PCIe.
- Add constraints for the interrupts property for other variants.
- Regarding the ABI break: add descriptions explaining why these new
  interrupts are mandatory and required by i.MX95 PCIe.

Changes in v2:
- Constrain the new added three interrupt entries to be valid only for the
  i.MX95 variant using conditional schemas

[PATCH v4 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and pme
[PATCH v4 2/3] arm64: dts: imx95: Add dma, intr, aer and pme
[PATCH v4 3/3] PCI: imx6: Add root port reset to support link

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml |   6 +++++
arch/arm64/boot/dts/freescale/imx95.dtsi                  |  16 +++++++++---
drivers/pci/controller/dwc/pci-imx6.c                     | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
3 files changed, 141 insertions(+), 4 deletions(-)

