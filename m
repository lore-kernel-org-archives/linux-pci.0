Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30B329C49;
	Wed, 25 Feb 2026 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016850; cv=fail; b=CDQjyq8eC1AeTChW1PX/qoVQaT396iKk0DuJWh6oASTaGWE3EHcViDVdVIOdFzdONrBRVB8c0HVhQfalc9i6ejH2lD4cxWHGn4+hqefcOu0RKhgRVI7892qSK3rNNSycnqfoHvzXQcEn0sNBimGHA77931F6jlDhXzkNS2t9b98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016850; c=relaxed/simple;
	bh=EaSkzScY7IksHgNT1CJwikvewAkvIuJ55ThZBGnkRs4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=i6SOMAl1DGVx/wmWlmWMP57U8hVac5UZaLMYN4yk/tcl1/QceWZutOIK+hkoU0uwNIjZ8Sjd+fAnQ/57R1wTzP9WqCsraz/YMRT+FOPXTPnriseBXtYdF5Xgu4LhYOI4+vrJQ48ndWs3/rTSyyvK/mkEVRKvWltg5q+AEjzsNQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kJioHXgC; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kJioHXgC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmWyLdMzjXLpKrqbr4F4s8vWlzH3qAQB5L/CIeBbgMX1zrv1UtixSlFik+lNWy/QXSeWYr1OYTZRJqqjY76lQeILixGdVfsNG4u7nzXpwmXJ0J8PiFr4gK31MR3buCGyqorIKNCwS8k+eUxNi1TCBJFKzAYpxLIeES//0Tznvgvy/eYDPH4HKO4w5oY4p7ZgOrqeBpQ+TRT4h6eniZpvdBP84BavFKpQSKagUf1o/lcrBi5/SWBxSWY6JTkXoCbN/H9SrxwORaigpT2ygfm2ouDJfCkLMp2TGLhAYMCJBUXX3zqvlR/1gqrosg8e7XLyA4vrr9BbRRfG/ap41MhWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpYvFU4T8vSk2jgf8O09qoyRwhDDotcviQPnxTcB1p8=;
 b=VEO2vLfRtZpDCB8mTi8JCN0xvMiQNdZPywXqYxLLBw5zHJVWRbTzs0Ogl2wKUrZwF3TZrUAJT8UKOmPxoQK2sl60W05xrE1cR2M8mvy5bBH99ZMgMcobhGMwbbJs7bdC6nEIf9aCiWT8EIEnldfJe2x9W2oDLcNJpBPix0Gq22LrMJUIlJ14zRLPGGBXt4EM6/CF2mvquPBjphaLAnZw8ZRyf6Jbmkkl62sDCF8dQNX8j6Xm+GnhBnD0PWE2SVd/4q7FphzL19loO9LbotG9AW1/muASeeoEjBenlAVHiQk09dMjuQcV59FwDilWzdq9o9k3EBnzPg600qxhU485KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpYvFU4T8vSk2jgf8O09qoyRwhDDotcviQPnxTcB1p8=;
 b=kJioHXgCmWMF1/An5NFp+0dv2TnDSOxS6gEbQjQCAKpEa6zYwNWAKMRNjjq8gZ70kpxFy3pOHWRqfn28u4PXUGqgymO1r+n7HblcoQwfuSwpo6I1z4lk4S5n04OUeLlLmAvIZblmXQ6iADHSWO1IRPP2+a2zbKyeOtGDJ9CK1zZfGeI1/p09q/KNOLWRP+0PUL7G3DnEkNcihDXUdnNPD9prXCqVfrx/LKfKYOhl2wpZR53lykv1XjdOzYY7mXSvsnyohYGvfNvdpZYMg2y2XZ+pB5sCoP3s3bUxTb4COBAFNd1lOIqZLfiLi5+qt+e2vVDUqbWbh9LXRxWtAVWQ6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PAWPR04MB9837.eurprd04.prod.outlook.com
 (2603:10a6:102:385::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 10:54:05 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:54:05 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 00/12] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Wed, 25 Feb 2026 18:55:11 +0800
Message-Id: <20260225105523.748775-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 6651f4e4-225c-41b6-5135-08de745c31bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|19092799006|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	Q2ZMa3jOUkaR9dvItFHGvDN3qmDvZT/pFlpRVcHgs7fMt5nw5HA+qTIZJPyPk+SfV67q24c5ooDZZxiTj0NsNDRQG1Q1X9yKBmAnaVlSDoBqvy0Ej/1d1mCoEht9C6vlEicBqSfdvOZBDu+nyw0bh3H0Bw0WrkEa5ZpF9YfBMOIiXoZ6ISFT/+ObGqYqrF87ekYW4KYeszGRnHU2YQUleGOClGsKrdQtgb0i5wqvbiMorNpxNPenllOoIS4NEh9vdzZGkxzw/ddinMSQ+/Ivs02B8/AHeK/w4pxQSaVLTBWenFZk/i2LZ8XMkjuPPPGnFddv1iGAMMtsZYZ4A6LZKNQI2Wy/1wbh38MZb3ZbSIwsY6JCBcQBORlied6TGKgU/9QYcLMDUyfkntgMe0cZc14V4/EV8gEXRQtWSu0+BHS1m0rjPJUfg712CYGxTIBu59KwgE8G7kRnXy/72/wDx83Okw8+e5mV9TP6Xg15PN2em+xM+belzlBs5oFmYZlp+5g1gH53J5AfGR27JczgK2HfgXGM2Kt9wuePMcsD2GYeS3pBzAGRY0ceBXMcQqpEdE4CY+T89LiUEUyfocAFS0vZaKpDM0MIdA5sLTPKSBqekIugubgfp3ux22diaJPj3a/r35Z9g6RMsu4s4F2zyz/eTrgUkxzgwdYL9QNFQvlQU6H3K8z4hhL+R9NKNnBguyVwex1BfXGv/baOzCFNAlfxcX6mLzftNl3bBQQf4ygwEkd8CVTLyLeqz0Dl99M3pKw6/VnwEhXpj9fOAWSTK8WamqIzMUPMlzQzSYnTSUcHiOXFp7iMPAGuGl7DooV9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(19092799006)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmZoVHRhbjJ3VXlMUldEeFhZOXQwL1JRenBNZVh3cUhNcUhGS2k5Y00xQzRy?=
 =?utf-8?B?RnJxUjc3M24rN0hrN2llRldDSWpqcGF5TTVUdEdtTEVhcHZkdXNNK3UvTzkw?=
 =?utf-8?B?ZHpFMzVPdWpNc3VucTBRT3UvSnBSbnZWcHVTSzJIWEgwSzhOSnoxUFFsRURm?=
 =?utf-8?B?VURXT0FqcXdLVFBlV1NYZTlienRwQWhlcFhRZTlINlkyaVBPS2FzaDVXV2FK?=
 =?utf-8?B?SGMwU0VjSzlQdFcxV2lyWFNhYjhXQlo1YU1SQnBzWTRaWEhPU1k2VGdDeFF6?=
 =?utf-8?B?bXB2MGNPMTZYMElyNjNJV0x4eGpwS0J2ZFZxUmIxRVMzL2pZTXJ1R1VCd3ZY?=
 =?utf-8?B?dGw1WGJXNWk1Q216QXhHc3AwMnFDb2tIaXJhUThKSTMva241NXdhbjROaVpM?=
 =?utf-8?B?TG1VL24xSjlxN3VwbHVuc1M0c21hakRKZktzVlB0SG1yVEVIdVlrQU93MnVs?=
 =?utf-8?B?MHh6V0VTNDhETWFBZ1dJbFZyL3RyUHFpWDJ4QUlZZ3ZGQUhhcmdGcldSUEVt?=
 =?utf-8?B?UHFPNFh6eU14SDU2R0k5MWxkM0NXUWh6aDRBVWQ0WGdvdElHcUk5RkFLczc5?=
 =?utf-8?B?cGNLeC82N2dMWE9IWXdhUkZCMVdMeUZOWDdrdmVPYitadlBvait4d2hTL3V6?=
 =?utf-8?B?UWxTMGZoeGVrWm9LNUtBRUJETG02OVFZVjVyT3NTMDFac0hxMC9pNCtBU3Ax?=
 =?utf-8?B?cVVKTFMwc0ZyQ2YyU0RlSTRURTUxQUhrd2lRcGQ1YzFJVVRDcURTbWlkZncx?=
 =?utf-8?B?R2hZQ0NOWFRFREhHVy9CVVdrRHZ3ZUdtbDVvRjVGNkJoT3JMbFdraGZJNFM0?=
 =?utf-8?B?d3RsOUR2RWhVM3d0TUROUWN5QXpDaXhwMWZFNjVpQUUxYnAvVDVDVlBwYkRa?=
 =?utf-8?B?bndHN045cGZRZkk1M0NTYXY4TDZYNjJ2blQzZU9JVXNBWEdLQlpGNVhNUXFj?=
 =?utf-8?B?bGE1dWlGTVhTUjlxbzQ5RWs5Mk1mTE5aT1pjR2prRjkzUEg5VWtQbGhDU1Rx?=
 =?utf-8?B?cW51YktmNysvNW9QSVJISHcrVk9acDU2ekM1bks4RmlqeTUwbW1CbWJFUnJB?=
 =?utf-8?B?ck1KTmlpbnZnclhGcHRYK3pRaU11aVJwTXZPdHZZOHUxbC9nMytEOE44UkEr?=
 =?utf-8?B?K0UvdUM2dG10c0JaSk1YNms5MWNLSTFGRS91WXhEaGhJQ25TNEhiVXR6a3Uw?=
 =?utf-8?B?OVBjQXU4b1FWSDBVTzVGV21wb3lUclVVR1dDTzZJc0tGZEVrSktPUGVTTkN6?=
 =?utf-8?B?MEJLckozdXVKcHkxdEU1KzBwUWtFMHJxUStrMTFWZW9INlk3ME5Qc1phQmN6?=
 =?utf-8?B?bG1sc2k3b3c0T0lKMEtzUklOdVlUb0hLeVFtRS9hTjZFd28zdHNDcmlvUFpl?=
 =?utf-8?B?L0k2TkdiRWFnZ1BIS0FyK0NJZkowcUpPbHFEUXErMU13YVdYdU1oVFI0Z2ti?=
 =?utf-8?B?RzJKWUhaZVQrNUFnQzhaRDJwdks2WmF3dmpaRDYvSzJ6R0cyTXg2U1hXVTZC?=
 =?utf-8?B?RGt5VHd4UC9rUTJCdTloZ1NPaFp2Q3E1RGVVdUlRWEVLTXIrZHpQZjlkdENX?=
 =?utf-8?B?akF4L0VpSnprSkMzV0JhYkN1dktMUk8ydjJRYlRacWRqcGNod3VKQTZWVjJq?=
 =?utf-8?B?K0Y4b3p0SVVuaUtNdUpDSGVKUVlpbUpxQkp6QUFqQmI1bDhZaFBuRy83SW9k?=
 =?utf-8?B?dVVlQWpIQzN4TUtPbENzUE8vaUN5eHhYbVBnVmZCd1haSG11OGRnNUQvN0o5?=
 =?utf-8?B?ZUdLWkpVRWEzOWwrWWtmYXIyODV6OXAwTFBaRlpGQlVSMEJNN29LUitTVVBo?=
 =?utf-8?B?SzY4LzJUeGhtMlZuK0dQTEpUY3dkMGg4SEtuaXFLUTIvM3NuR29WaURiY3BT?=
 =?utf-8?B?MlFya3dOSGxlTjJiRWZqczB6c3E3eVJZWnNvYkI0cytBZHYwYTNXbEF2aWxH?=
 =?utf-8?B?a0dld0MyaWkvb0Zja3R3Q1FnVE50ckllVXpUek9tVTJDNElNY2pRM2drQTFn?=
 =?utf-8?B?TTNWOCtRUkNERGJCWTlLbGh0Q29tNE1NUGNNODFtTkdiUjUyK2VVRGQvczNF?=
 =?utf-8?B?NDdnOEx3TFVJb3B5M1R4aktTbXpLNVhQZ1R0eWppNzZXS2w4ZE9oYWFiempi?=
 =?utf-8?B?eW44TkhKZHZ6SkdSamw0Ui8vWVFxTFROcHRCbDFDRUtaa0k2Ti9HbVhuZkh5?=
 =?utf-8?B?cE5LT3B6MjRKZDF3RHZ6R2tkK0pjOEd2MDRMSGtCRWxiUDdVWGdqYk9CUEls?=
 =?utf-8?B?d3VvUzM1aEhFUUZFRzNMeTZPc2NSMGNJYUtIZitJN0FZaURIN0Zqd1FPV2Y3?=
 =?utf-8?B?Y1R0SjlsaCthYU8yVjdRYWRsYXhOVzJqeEZvb0h0OGY2cWd2NEZkZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6651f4e4-225c-41b6-5135-08de745c31bf
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:54:05.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EZqDUae9p5oMBEGMGiqmMTHbscKdG60f86Sch4rtHacSqL+lQ/EDzNJwYjEhtOFtLTP3DzckAu2oOWtLmWkiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

This patch set adds support for parsing the reset property in new Root Port
binding in pci-imx6 driver, similar to the implementation in the qcom pcie
driver[1].

Also introduce generic helper functions to parse Root Port device tree
nodes and extract common properties like reset GPIOs. This allows multiple
PCI host controller drivers to share the same parsing logic.

Define struct pci_host_port to hold common Root Port properties
(currently only reset GPIO descriptor) and add
pci_host_common_parse_ports() to parse Root Port nodes from device tree.
Also add the 'ports' list to struct pci_host_bridge for better maintain
parsed Root Port information.

The plan is to add the wake-gpio property to the root port in subsequent
patches. Also, the vpcie-supply property will be moved to the root port
node later based on the refactoring patch set for the PCI pwrctrl
framework[2]. 

The initial idea is to adopt the Manivannan’s recent PCIe M.2 KeyE
connector support patch set[3] and PCI power control framework patches[2],
and extend them to the pcie-imx6 driver. Since the new M.2/pwrctrl model is
implemented based on Root Ports and requires the pwrctrl driver to bind to
a Root Port device, we need to introduce a Root Port child node on i.MX
boards that provide an M.2 connector.

To follow a more standardized DT structure, it also makes sense to move
the reset-gpios and wake-gpios properties into the Root Port node. These
signals logically belong to the Root Port rather than the host bridge,
and placing them there aligns with the new M.2/pwrctrl model.

Regarding backward compatibility, as Frank suggested, I will not remove
the old reset-gpio property from existing DTS files to avoid function
break.

For new i.MX platforms — such as the upcoming i.MX952-evk will add
vpcie-supply, reset-gpios, and wake-gpios directly under the Root Port
node.
Therefore, driver updates are needed to support both the legacy
properties and the new standardized Root Port based layout.

[1] https://lore.kernel.org/linux-pci/20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com/
[2] https://lore.kernel.org/linux-pci/20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com/
[3] https://lore.kernel.org/linux-pci/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com/

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V6:
1. Drop the pre-allocate pci_host_bridge struct changes in dw_pcie_host_init()
   and imx_pcie_probe().
2. Parse Root Port nodes in dw_pcie_host_init() as Frank and Mani suggested.
3. Move the imx_pcie_parse_legacy_binding() from imx_pcie_probe() to
   imx_pcie_host_init(), so that dw_pcie_host_init() parse Root Port first, if
   no Root Port nodes were parsed(indicated by empty ports list), then parse
   legacy binding.
4. Add device pointer parameter for pci_host_common_parse_ports().
5. Add NULL pointer check for reset gpio in imx_pcie_parse_legacy_binding().

Changes in V5:
1. Add the Root Port list(pci_host_port) to struct pci_host_bridge for better
   maintain parsed Root Port information.
2. Delete the pci_host_common_delete_ports() as now the Root Port list in
   pci_host_bridge can be cleared by pci_release_host_bridge_dev().
3. Change the common API pci_host_common_parse_ports() pass down struct
   pci_host_bridge *. 
4. Modify dw_pcie_host_init() to allow drivers to pre-allocate pci_host_bridge
   struct when needed.
5. Allocate bridge early in imx_pcie_probe() to parse Root Ports.

Changes in V4:
1. Add common helpers for parsing Root Port properties in pci-host-common.c in
   patch#2.
2. Call common pci_host_common_parse_ports() and pci_host_common_delete_ports()
   in pci-imx6 driver.
3. Use PCIE_T_PVPERL_MS and PCIE_RESET_CONFIG_WAIT_MS instead of magic number
   100 in patch#3 as Manivannan suggested.
4. Use "PERST#" instead of "PCIe reset" for the reset gpio lable in patch#3.

Changes in V3:
1. Improve the patch#2 commit message as Frank suggested.
2. Add Reviewed-by tag for patch#1.

Changes in V2:
1. Improve the patch#1 commit message as Frank suggested.
2. Also mark the reset-gpio-active-high property as deprecated in
   imx6q-pcie DT binding as Rob suggested.
3. The imx_pcie_delete_ports() has been moved up so that the
   imx_pcie_parse_ports() can call this helper function in error handling.
4. Keep the old reset-gpio property in the host bridge node for the
   existing dts files and add comments to avoid confusion.
---

Sherry Sun (12):
  dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
  PCI: host-generic: Add common helpers for parsing Root Port properties
  PCI: dwc: Parse Root Port nodes in dw_pcie_host_init()
  PCI: imx6: Add support for parsing the reset property in new Root Port
    binding
  arm: dts: imx6qdl: Add Root Port node and PERST property
  arm: dts: imx6sx: Add Root Port node and PERST property
  arm: dts: imx7d: Add Root Port node and PERST property
  arm64: dts: imx8mm: Add Root Port node and PERST property
  arm64: dts: imx8mp: Add Root Port node and PERST property
  arm64: dts: imx8mq: Add Root Port node and PERST property
  arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
  arm64: dts: imx95: Add Root Port node and PERST property

 .../bindings/pci/fsl,imx6q-pcie.yaml          | 32 ++++++++
 .../arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi        | 11 +++
 .../arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 ++
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |  5 ++
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi         | 11 +++
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts       |  5 ++
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi          | 11 +++
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      | 11 +++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  5 ++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  5 ++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 11 +++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  5 ++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 11 +++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 10 +++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 22 ++++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 10 +++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    | 22 ++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  5 ++
 .../boot/dts/freescale/imx95-15x15-evk.dts    |  5 ++
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 10 +++
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 22 ++++++
 drivers/pci/controller/dwc/pci-imx6.c         | 76 +++++++++++++++----
 .../pci/controller/dwc/pcie-designware-host.c |  8 ++
 drivers/pci/controller/pci-host-common.c      | 58 ++++++++++++++
 drivers/pci/controller/pci-host-common.h      | 15 ++++
 drivers/pci/probe.c                           |  2 +
 include/linux/pci.h                           |  1 +
 28 files changed, 384 insertions(+), 15 deletions(-)

-- 
2.37.1

