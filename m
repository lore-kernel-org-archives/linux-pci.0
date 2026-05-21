Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A837A37701C;
	Thu, 21 May 2026 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355852; cv=fail; b=iqcIbF4D3/WAkPmqhXdsL2OIjUP5Oq8GOg1oVCmm3p5E+iCMhcabzw4FzhxJ+T876LYOM7VmqknfURMihJ+eJ1SJ+x1evV6vkdmZ8GXacwrAabKDQpu1O1hpNUj9J56jAzEc0OOQ4gpPHZ5AEUCH/zGuUdRn2n11Yn1HQj1lUyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355852; c=relaxed/simple;
	bh=v6xzQDpOD/+7OMBiNwiwJ7L5KioVLHII5+pYaEKzsMM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=p8TlfdBYbdEePXI1jFFnYM3N5rmxPGrTbx4/DHnwR45nR1MQsApvnU5CPCY1M6eK+EuWVz0/J0cURRfpwYbD6fqndYB4DioFZBPnvXQlhcXwp3EpihQ8sVyL9Mq/xJEAxmoJ+pfEV+ICSNzrLJWSDdYN49mmfQGG82TjlfQG6eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XDiPJc7+; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XDiPJc7+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcgWc0fsk0E88kc9FRnOl6UTaOia9hXDUgkjMxFqDLEoX2tZYAH68yoSBonuIleNNvtRBIoP1RQA+y26AbT5LoaplTZQaXJ5BmzcHow2swr+22UpwvpG1xcffzcDPWi+dKoBb4XBkMhkoNLQ25jgL9wBeOWal3dkB/CXLPqcNmMbE5ZS+ow+Fg+OaV+DlM2XCig1io2+MJmNR7mOhMs7Od6RwnmgIK5MGr4B4KpqYPMsLi1f+hZavhN5u9RZ2zXwhrDVGsEQQiQZnQKVBWwPLyPj5lAXOFCMceIZer6r/cDnkdeIimwF2S8CpaQL6syr3yzYAcwF3xCOt6Gaa/c99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guGDZmZVlqypmsuatQ+w7LnceZbulMIBy1B73vKCvYM=;
 b=LoQlqKK+FsRO+0UjEfBgOwc+qK/9AGbW0d1OQLEYdgDOMFKHCH3+RwJmvJph/IrRdnYsNVh0BtXZvy9MqyQarCo9mvWEUbvn+YLZsNNQ1tJyImskBPavQY/qq6jwIfufRueeGMu3DBvPidAN1InqQgiz99fnD3akM0jSjBZ5esKF507fEGVKMMjfbvPnaRCmJTlLyl4Vnf9c1WLmZfK353FmYLuRDqUWUe7Z3AHNVgKrV5QnGbm4diYyU3pXJ+GKqPK111kjeTKinFgtDqMYymuay8Hk7n6iowgGpUikqRxR9lcUkbY3TLpleiLufjMaxt5Xex9KpP0NJ4TV+6iQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guGDZmZVlqypmsuatQ+w7LnceZbulMIBy1B73vKCvYM=;
 b=XDiPJc7+2VoOrY2gA0G7rDmcDR22FU7BsXHT+eg0roZuPV8YPIemiyr2ROvaAE0vsA9QRbMAGZFNtpyFnwztNMDz4ypKHJ+ipv32Y2tcwPQFaFw0i9nMVIxYi39c9QJ9lZMdH4VRFxmRZF8ivMJe0yHTLAzoJr7b3sEW5bY9+VBqpVWeQSLts86DvYBlLgrTgAlD2ONi/dXSEnjYKRVUGxxpcZpYbD3NJ+4Zzlf+nX12R+GxQ37FnmkqSyv6pLCRDwLWX76HrKfM5Zqmk7I6xXdVLFX4WQFFCAthAo8rMTRqObuvZN2aBSeG0b9LQUuvW6o3mAO7iT+CRCiEYB1lYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 (2603:10a6:800:317::15) by AM9PR04MB7507.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 09:30:47 +0000
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a]) by VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 09:30:46 +0000
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
Subject: [PATCH v5 0/3] Add root port reset to support link recovery
Date: Thu, 21 May 2026 17:32:52 +0800
Message-Id: <20260521093255.61585-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To VI0PR04MB12008.eurprd04.prod.outlook.com (2603:10a6:800:317::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12008:EE_|AM9PR04MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 751d68b0-d268-43af-4219-08deb71ba367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|52116014|921020|38350700014|56012099003|18002099003|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	23VD6lvUdb/FbM0wAvyUukelYtr1CN1yBn9Iny4nMP06jGee/dhh3J96/4GKdgCFVqjBNMqLXIB9XzSBjx39ai6MjkUGnGqCzGeMZg9k3AwFMhu8IDetbJilloQVdQ44VskLh/1ZmxE+zjMcHyOh2KppSdpwFjK0+HIUj6QSBgbwjeHZS5MWgJomYSHHsm7r3juEMHvLaVi2oICuPg11Spq1yzm+wKxrPVXyMTrrSVrN66sRJ8j/vA8GRt2U9I+R4Aw49poqp2YdWTKWG+O5DP15/EqR/6FB8ywW7ggCRk5/NDbCoOyEmO95g0mohhx3i02Cbx1wKzR3VMtkgps11V1uwNzBNFU3sJt4buTfR2hhSpFY9zYbaqFH/xZk4IYD0tdTDIVrW599x+SdMhwqohvUiObXKsrve7SqkcCLHXFX63SEa5/v8mkurxAL07f4YfOx8C+Vz0GvLZ51yo6dHnVKwv6NCNju443MQ6stSgOLrqSXe4dahyPn5Vkm+UMoFPhKFJwQ2kIySVDSLIQ5IUA+3M+/0MdXsk9Yf3TejS4xG923GLKi4HzLAL9PlanEfi6BQUUD4wwF0GgdIGDuuWeDovCjukl6l4XouLOq8yt3vGk3Z64gDyhe/CvqSnbPrOBB1mRKsr/nEBgV61Lh08xoDYMiKPW1Zlv7QKqahvN2nnhM3iq01ST77ykxscdgEkf12FhDGU3COQV3JSELZHNT14FD9+8TXgvfMLnrggycrJgq27qa+hpA5LElJUfUCgV0SzyJzmfhlCJLBPyPSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12008.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(52116014)(921020)(38350700014)(56012099003)(18002099003)(6133799003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qhEn/4wwoOzRG8Z2cHcZ1wKjujL+3oRNpQzoGacBGXfrrBoalbtoJH1YfCOS?=
 =?us-ascii?Q?7za92fjFhZmOip9gteOhih1HDp7Peid9801mJ9Dr+iak3iqlEbkbOPY8DKMJ?=
 =?us-ascii?Q?DgYiDp5wp4G+RJK4NHrI3fEKBM3GpM9FpdGG5Y00rF64WFbEziqKKoNFyepZ?=
 =?us-ascii?Q?DFcIeMvAGjNkj0xojU8708MrSWg3DnwUT3Xd9eIoQBrAA3+gb2k/87iK9Zn9?=
 =?us-ascii?Q?g45yRwH8iB2jSRqiBRMO6shLbkws64Ulm8C5ECrnhKex5ulxx2zJ0abwd3SK?=
 =?us-ascii?Q?F2DzQnf8SvejslYkqi6lP+64kwqdnG+zbE2DALyRu+rlItAntfHfcPsjH97U?=
 =?us-ascii?Q?ZCTFNZwQrhHudVZqK3hnaSMybRMmmUuSqewQDSGCVmsph8tGUob8XBOqpOc1?=
 =?us-ascii?Q?DuyJmvPAbzgXw9T6DuHm8c6zk+PpGe9oEYEzwrSxH2f89a/N4rnAVZA/cobQ?=
 =?us-ascii?Q?VYR4bgkg7D27+zdh8ahpbvcL+NEEBseavOUWH8l8yYM1MQmSZxwzJMUKXr9K?=
 =?us-ascii?Q?xrXeTp3IJt+IYnasuBLeWMSh8XEqWX5zqwOmnSRO9WXr/4xnH4N0j2IpNdKe?=
 =?us-ascii?Q?DFXFCOCGmGJtogRBQXWL311ztEF6+bwh0/7N4RuXcTLdSs1BpHUn/PWT9AHb?=
 =?us-ascii?Q?bB4emnuInNgeJpKURGyViq+GgqnfOqAgZnvKWT0r9Ar0G70NOgwMGett1XUz?=
 =?us-ascii?Q?dsxChXIEna4SCKR89c4zZF/W8uZv7iQ2vhjqRsEQogUy70L5h44p4Lnd5BOY?=
 =?us-ascii?Q?8s/v1KlHNjvu+t7puXFL52fQlLw7aBDWS+PGfKcmKkZJbfoLmC+x3VLiB9DP?=
 =?us-ascii?Q?ZzHADJQNPE86WQ1mFhODKk54xSQjeml8YkLgWRhSLdwyX9HdyV5cvTnSswIU?=
 =?us-ascii?Q?rp72vncCMKih5WeVJBawCIkWerLzb/scUrDWP88gHm7gpJsxLwC4zf9etAT7?=
 =?us-ascii?Q?LnIAQdoynaAI/+jbbTs3rd+7dmZuZYJKXpWX5vRrR+5cSJlAHOCWlye7M5wZ?=
 =?us-ascii?Q?la5VAmUEpx6ozOmcajrJESxAzmVaLeLnrLLTFfble3pDwcY04dOrHKZp2Haw?=
 =?us-ascii?Q?hwNE1gY23SRP6a9Kq1BJty9ZafvzP7q9iHRdm2muJkIpLelVTuqq4aEGqCra?=
 =?us-ascii?Q?EYg81rwmSxdTzAQeeL4bPVm+T3/BsLQcJRVSPBfXD2/ZBbCLVWmi1mMdb8vV?=
 =?us-ascii?Q?6ja8pGwbxinzYm3lb2H8sromdpBb5izyA/orH1JEkXHM2VokSsQTUlnW+LiV?=
 =?us-ascii?Q?jm3q31b7t2g9f0h6onW/XpG5sYYO+r4dqtZ72WydICsvfgxSayHhdg2Zjd6t?=
 =?us-ascii?Q?sxlCOVzkWTZAGQvGBFeKYUy4Dq152GetaZ9pCggXhE5rWKaKSME3q8XZb2zi?=
 =?us-ascii?Q?qyqITvnRlhico1+VoqBqkzUn2fOrxWtVpbdmTW21W8ifpqBOsVSdK8zLbOl3?=
 =?us-ascii?Q?KMtH4yFKUlXHgI+MjSVZSr8W5izEUi2yR8cxCIEIVesJ3y16tXJCzYBQhuo6?=
 =?us-ascii?Q?g0xlTHSc8nRHaXVGwQ0TxfEoXgu0HEsa0equQwIWJTlsAMdfDt7bFdGbKARj?=
 =?us-ascii?Q?Hl5G8tbdrbNGzIKYu7nYcdQuHaiCJM3IAoDQa87VMX8dh58m5DobYAirOeDt?=
 =?us-ascii?Q?pdhCrmpsSg0joKDA9g13ZQQU4EeBPd90hgEjdqRAnb8sMEvZHcBtKmN7F1fK?=
 =?us-ascii?Q?s91ihnSeky54olSeo48E65Ofxhdsdbgv6S3gRKycOfbfpRTiWmKX4AdGmhBR?=
 =?us-ascii?Q?qSyyGlI27A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751d68b0-d268-43af-4219-08deb71ba367
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12008.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:30:46.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: benZw51og9PKvcLTZVWnfcPJk9BOTeQ5+bgQXwGG19hm99JFSY8dKW41nIHsUzoWWn9i5I1/nUhj+AG/uIwGIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7507

Based on the following patch-set[1] issued by Mani.
Add support for resetting the Root Port for i.MX PCIe to enable link recovery.

[1] [PATCH v8 0/5] PCI: Add support for resetting the Root Ports in a platform specific way

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

Changes in v5:
- Update the commit message of the first dt-binding patch for clarity.
- Add explicit comment explaining that writing 1 to IMX95_LINK_DOWN_INT_STS
clears the bit

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

[PATCH v5 1/3] dt-bindings: imx6q-pcie: Add optional interrupt
[PATCH v5 2/3] arm64: dts: imx95: Add dma, intr, aer and pme
[PATCH v5 3/3] PCI: imx6: Add root port reset to support link

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml |   6 +++++
arch/arm64/boot/dts/freescale/imx95.dtsi                  |  16 +++++++++---
drivers/pci/controller/dwc/pci-imx6.c                     | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
3 files changed, 142 insertions(+), 4 deletions(-)

