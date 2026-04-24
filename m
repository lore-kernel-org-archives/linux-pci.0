Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8593305057;
	Fri, 24 Apr 2026 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776999375; cv=fail; b=UWRSC2ZlJwlyqbNxOgv1+rg4fPTHfDSUxuviDXRYFHL4ebJsPYl8VdSD2v0S1fZhk3UBNrqwGYqh0MBJOtilTHy8ZbDFuI9ZTTxFZdekHnYFnvGC0VSUFoVC8MP+6V7ee7IH4eUs5E3coFpBBj/XmepAhk0DGpQMuSVY0zu460s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776999375; c=relaxed/simple;
	bh=T6k1+ZmlC/ImqCJKsI0vywvm2DA8OqvZUQU3LZdDovk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jBMm+zx2lHEdFxtY92pVNTHIxsnMt0mu9sL4ngafC+/i0c0BRA+xs9dvSNM1rvyX2T0Kg5Z5nyk7AtPtO/iLZ6t8HzNezgeErQKDSSAqi8crnGf0WB9wGN0XcxgV4YGVQZxeA60VEe1pdGUQa/2OysH6kmSggbzWilCiYt7tLEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P46jce4L; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P46jce4L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxYtrU/hGxBVv95GARc04Rixv/YMx0227alx+Jvu2Q23bgaQQ50hifPnLZkD2eD1VA0lXljfXL4bPkB0PWKit4V/pAAHhivKVEIccPHKrpGrjyxtZz//IbRQGf9qC4PKPhjE97l9Cz7OioieswCfQ3X9vSbzAhTBur82u4hUmRw1yEuy/3FMCuHEFYwxL2Yg9cViyRIQ5nFP6SWs0haj9iQOKhua2A7WznXF6tY9HsRyhadxTetbapAU/MhZWk+uCA6VYScr5scWOCfNRtsZseWIQNkKBDu0AK2hSaaJ8QXMPrlx8JiZDS36YJqXLzhhxI5F3lV+PlkbmtAiZodn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QADazFGs8a0/GnpYdxaWb+nGmsud2GZz5RcuzUcyXnA=;
 b=eEnwFdNxafQM5Sgwi4X6Cba8cb5G0Q6cvAw6twwZoq7X8FUUceJLdj/kUeG/9NEZgJDmyhRVsHX/TU1qTaSD8e4a6gqYiEuCzOFkVv3Xr/vcx3rLn1Cp5xRYBW8DcNVyMriJ2181az2G6w9BkUTWGD5c1gZvY2Ae+fvZnl8eJFQWdsm26SXrqyx0AogH0BfdW+QWcwzEmZRyPDYFZVVHQAPi2yUI+h8bqkbKnSNBluNCkRdXvZt0ZkC43xG9QBdB5uvcs8Fp+TJ1wnwJafx4gI1D/8Ked9XurvIHQb9heXy8oql/taL8xrPpY17nfsgj1SC/upjInNEpaCxpFCBejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QADazFGs8a0/GnpYdxaWb+nGmsud2GZz5RcuzUcyXnA=;
 b=P46jce4Lg+OT+6Z8cFjSFvm2V24PZXCBmgmRZxaZM1q9WHtAEuKAG1cEw5Ix+8Tv3UHWTNmwgEgz+gj74OyQDZ4zcTAf4kiSv1h9ltk4ER5fWeSAYUb3/XHp+c6lKUYX4hWm1RlHoTZ3gG/GmAuDlGNuiPq5+ZYSEYSZofwUxec8S4EJgC1i0ebIkRD1zKxuGaWuovXbp0WRGnmDMa8rrOh7XMNdzPO9X0lulErqS14YsBN9MO9ZJ9mJcch9BOADknBqQe04LEVUel4T9q9C+p9zx3d3K7Q2NaXA1m/b3Cgw4QT8PRjMzKGuIbiHMwu2fTN6UMaZkIxJi8+fhwvO8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5222.eurprd04.prod.outlook.com (2603:10a6:20b:11::12)
 by DU2PR04MB8791.eurprd04.prod.outlook.com (2603:10a6:10:2e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 02:56:06 +0000
Received: from AM6PR04MB5222.eurprd04.prod.outlook.com
 ([fe80::374c:87:282a:63a3]) by AM6PR04MB5222.eurprd04.prod.outlook.com
 ([fe80::374c:87:282a:63a3%4]) with mapi id 15.20.9846.016; Fri, 24 Apr 2026
 02:56:06 +0000
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
Subject: [PATCH v1 0/3] Add root port reset to support link recovery
Date: Fri, 24 Apr 2026 10:57:32 +0800
Message-Id: <20260424025735.1490772-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0223.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::9) To AM6PR04MB5222.eurprd04.prod.outlook.com
 (2603:10a6:20b:11::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5222:EE_|DU2PR04MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d75f1b-0b08-41a4-ba97-08dea1ad075a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|56012099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	KDtckg38tOyDVxOYuSVw2LwzV4wUqU3+DOrAF086C2k8snyMng1HBAbiC6rqqZJjHLPiWZ8ehM7HaujSYg4dkz2emv2alvp97ODiWEDKNkN1fTuPLE5XGPPnSNYMQQcRLgFrI4AIWCsfeYjwr/oHQ80Nz7IHEStA1QASqK0LdJtrzuD6Tggmokv+eY2ppXHyzsb4IBGzYFxRCPzyZBmLzOp3hG6JEhSlgltmfsfJiUcIFq6GjQQgxj9JKI3gQ2/hBYKsWm54hGKiw969aI73NU6JVkyd9a0VEblgigqNITW3SOoFcjLh2f88zc2HoJbqojShSkZeobVxgI2GiIAbUElO2C2R4ax2VX+Rbj8IPuH4r+7kjHmya3wyUkDShoQ/Kx+5Ydj8v5D//YJKzaz3gN9JJANbXqP/rQmKTxAwD7S0AyUKukFVl+ky1LSKVkqhYxd1Or3+BvLW63+zz2kiRyteExU/jCGRB6srv08pdt92S12aYxJP9iHwxqgqL2bXm0djCOkJ2LSlpMkVAp+cuCRQxeKYFyKXKiNxOTS80gO5xUy8CygcOg0OthC6KXQ//2cun11njP/TUEOn1WQZw//9VoE2aL92QkZApxENSYzx2MbUOQUsK17Z4oTSf2yOxoHBnFry0nBwPOy0opcGygbhJwAKyBAB0Hsu9xpfMxjQkVM+LBEA2MDWVSSeCDSakEjV5yXr7g9xR4VB0DKkdL9eRCuB4i5NvYitNpwbgn/eZi/YB4HGFAtPvVK3jIKeKhjqkmPJR/SKn+OKwkfIzwQeVo8pOjgSXFiATiiLghVyrkZfUcDspz7AZDfHbve+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(56012099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SF+ph8vKakQSU7WUpmcCvDlkjaKqIg48HrG+HzKoGd238fWXQnyDaXspvac7?=
 =?us-ascii?Q?bypXWP5MIRdn+XJs8t8q5I0qf+8JlI0j2gL2K2PRUJIehf6gFtiptNOJZ1wm?=
 =?us-ascii?Q?UOWYJmCy3oyOeMRzWR8CFl2Eye6MtynWuh7gpYRSaCEbxdeUIUKr6tXSFk2R?=
 =?us-ascii?Q?7VwRFmSjuuIlhcrXghtV+fzx7J7PZSFVLKbCMUe4vmaHS5VkU0Cfb69JgLAZ?=
 =?us-ascii?Q?UDdIhvwSNUoL0qQ1H+ENPXqK4Nayy20u9YOhCdjGxWMEY82ncmVWxp7Kz0IT?=
 =?us-ascii?Q?r4jiblJzNF8rYBbpzuPfrnuyM3aiaegVoDr1IZ27XxNKOiFTOudIVeP/VDgW?=
 =?us-ascii?Q?bzirsp8agTY2zJcWElEnjT42rp8P1qwIlPVuAjQLT3y8kBERCxPnp+NCkyay?=
 =?us-ascii?Q?RUb/m1k1V4X3CW43pcj+u8/xG9WlafHV1D+uOOgyd/2nbURI9W8z4M25xs20?=
 =?us-ascii?Q?1FK4c/bvRO50EFMja1yFzDsDwmOFfeZve5VOypu2ZHJU/krIT6JAmykBymg6?=
 =?us-ascii?Q?iHiBD15PGDyrqbfDNfJ8pKAlUv5WbpU+RqFFH6qTT2/4gGm6Iu2ju8h4wQJ9?=
 =?us-ascii?Q?DmloYIR1l/XLzjJMpgCRZutQSakQgQrNYYsINZOWanM/aMm3Pzh5hgOMWrKr?=
 =?us-ascii?Q?CIbzda2U9dT2DV01rLnKXbke/Xf9sItKqyI8mlbXNvvjVINujRMUh80m43cf?=
 =?us-ascii?Q?xZuebQQDW0D4h85zm6GLaHuKFfOTSNTeqR5pVRV4ivjS/kAaU71bQoDioYyX?=
 =?us-ascii?Q?zdZfwmmzHrykRjs2PeWSRLzLcsNoELe4onSe3xnP5+womKXEzD79mIA+kGb4?=
 =?us-ascii?Q?vJ4EClL9MhuY+8tyc1Co5leDQ4sK976QHM/vjh1J3E9s0wqqpO4I1xFhr/Wa?=
 =?us-ascii?Q?Ro3mkLeOkyOCpnFegJ/SUUp6O327ML7hmIrmq40JXaCr3bUcLLa4cO0Ij6GA?=
 =?us-ascii?Q?6TAMun7w05qCAK3cNzYRyxfostPFAvqbhvzKkbINWtayYp0g6Uj1asQoWI0/?=
 =?us-ascii?Q?yANZSIdv72d44PmX4Oc3bWTdAaV9YX2kKvsc0Zo5Hhw86TQGz4D0LKnvLSbg?=
 =?us-ascii?Q?w1Y/Utxzqq4QheNv/VHFGKHuyIKCTdsOP9aN+M2IlPs29X3cxQzzJuv+lhkq?=
 =?us-ascii?Q?MABypcHYzD6rOhYyaYqs9oMeQ2jsrEvbG1RUU1oBPyg6hSy+zL/6xgyT1aQY?=
 =?us-ascii?Q?lTRFdGTqmk1smFgkQmmCOX1Jro7iBg1KnMa5k89pG8IhKNpFv2ctIeDD49qo?=
 =?us-ascii?Q?Sou1XhLSL42i1PzyOrz3rx2hT6335z9ZKHO7dEEpkk79nBtkq3iDR1I3H4LD?=
 =?us-ascii?Q?1v9FN+iy16xal6R0Q1+4U7SnekvC+RRMi0G3EP3IxW+eX9DrEXFhBASLaI//?=
 =?us-ascii?Q?3gLGZeAfMBaZuKD+py1AVWdFVoGcjYpVto2yitudQ3ojLlcQr7VycpxN7B6m?=
 =?us-ascii?Q?969iq4fqtfUesbeFgj3WB+l5C9Iju4L7NI2vjhN+3W22kOHb77vl+HhOOjrM?=
 =?us-ascii?Q?QwPjC7EOlSX6E6D9MZsecycJYhiw0/bFXQSwoPnHRjPv451nZAETybVMYsak?=
 =?us-ascii?Q?vdoLLl2pldTD8Qupn4QrKmInSDs3CVKbA8BBFCJKIY2Zq+/E3T5TBA6KC0ac?=
 =?us-ascii?Q?fK5zNv67N0uwwQ16x4lJGHyRlhBJUBt+MXzFZKRnR33NPLQYvGuhIPw4gaCE?=
 =?us-ascii?Q?WzGDQjwnjHVHfMczTskG61cpkwDgjLl2khjRCgczWQK9MLLql1REZpvSeK4a?=
 =?us-ascii?Q?+ryugYsXOg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d75f1b-0b08-41a4-ba97-08dea1ad075a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 02:56:06.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTA4lfBywO4NlKLiyy1NGXX+zv1ymMzvMHf2M64LBRD+sPVS3aHNf4uGFCLtn0NNhMWcZxeVZG9KGmmo+cwieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8791

Based on the following patch-set[1] issued by Mani.
Add support for resetting the Root Port for i.MX PCIe to enable link recovery.

[1] https://patchwork.kernel.org/project/linux-pci/cover/20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com/

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

[PATCH v1 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and pme
[PATCH v1 2/3] arm64: dts: imx95: Add dma, intr, aer and pme
[PATCH v1 3/3] PCI: imx6: Add root port reset to support link

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml |   6 +++++
arch/arm64/boot/dts/freescale/imx95.dtsi                  |  16 +++++++++---
drivers/pci/controller/dwc/pci-imx6.c                     | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
3 files changed, 140 insertions(+), 4 deletions(-)

