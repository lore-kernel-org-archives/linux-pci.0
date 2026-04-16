Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0D37C91A;
	Thu, 16 Apr 2026 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337966; cv=fail; b=c8xDmuHwqjKNaPeRfec6juxukaBiTWorRBjBP5QZOHl5AJN146wRbSxnc991Qk2lM/hQoVMCIdOj5ba1OfvDmGZgsHrj+9QnFiOjYmbB5/6JhYGjMi7JnW6zs835pmDPZBta/8XsY7X41ibrRBUC6yRwQ2Edz+/w1W+iJAFOPH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337966; c=relaxed/simple;
	bh=uUK26eLtGoW+V8ur/UgosLrLIyBGJrTzgqExaJrLucU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BQ2EkyiGK9pLLDPDWSZAL02KaVHTpHeQOhJtZSvunLn4uGdAF0QsNlFozW2vFy2ZnBsiWXEWMsjEWZIY9JlNH6bwL6Pi8q6ulaVwKKmzTPsHuek5T84x/rVVDKKjhcbVAKByNg/NsIA6+Ih6zytVDJNdlkdGfWBN6Q4BS5jRUmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=euADaNqw; arc=fail smtp.client-ip=52.101.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="euADaNqw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxMdt4sht0ybBpbewTf8/ntQlYnhVdEJZUDAw3M25A9i26ceC538ojpqV62cBRLvm6Nd4/iDDB/shdxsN7EyZi2wFcjA+It44AhfuAGqAGgw26mQoT5TgwBIP4DTuFBGHndOClxhDltxnSgwEC6WR5L+GwJBNZl9qHGnH8TT0KebtvNsdBL6nvEhfQZokI6TCD8K/HpAM9B+CZ4LtkmLRwCP1FySDIbE/xwP547SS3m35SnpPBYY2I4znYDxBF+zGsykj0aVLgP3bqg5EsS0GWGMLfpJSDHjkHM1A6qD4+58E20LbPt/ENN0d622y/njmeTv4l0Pl1FEBuXLL+iaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpUfJY0SkOSV8BOOWgmIKTeYhrT/v7kIWkS0ujnuXnA=;
 b=yl37hbUDawEIRDuZ9Unb5W7ZMZ6PXrhrG0nfO4J1bdfcztl87yn6Mn3pDjSfDP6DFjYlN5JdSV7WyKEcKNSWKMMlRz/CrgHy8P5zN7Y8whxqP0tO8kF7h8ESxH1NUpMKuIkVw5FichX8uznDdDsky4vwapSH6WK3PEvwhs+gSuTfCLUwSSV1KGAXH6sgDadC8uZcrQevxGvyKfMjY5+83Yj2jnOpjAnVhKxRNx9rgtF8x/wglKQR8mi2KEyqiIliswlBkbkM63RG5eMgICePevT8BKpQVZfpSkj5LGMHDTOENjHts8eTIfwrPevoGoCe60eL63qfv7eEXoV1Oq0KLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpUfJY0SkOSV8BOOWgmIKTeYhrT/v7kIWkS0ujnuXnA=;
 b=euADaNqwv1Ut6NbO32suMYqEwKqyoB0WoUWFZGjR2S9qerXwDC0Q/O48ZhHyJ7RQOevfj9Q0sKHs3YSPVMM3l0ZjsnKXgiVVYGvHpjBIDYdYikXtt1+UulEhEjd0mhWLReEWKVz38AsCt8wk2NtP+Xk0PgdK910Or5YcSyS9GkL681f/gBTz9v30uXaOMy49OIdz/RtWm1uNMzQ78n6uecHe5f3wyY3lMwtAZIAI/gPIYbcFdcNH5o3IMNSfSvZWNOrzAsxSYvQVsPQ+Nm28XwBVqxIIVi/+LSL19W7MZNklDISoIOJ7HyCXeP8P4ldvjD9l1NcesntzXs3emFFDXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB8804.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 11:12:38 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 11:12:38 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V13 00/12] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Thu, 16 Apr 2026 19:14:10 +0800
Message-Id: <20260416111422.183860-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS8PR04MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ea7ee8-8479-4fa8-4600-08de9ba91191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|7416014|1800799024|19092799006|18002099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	4ILHi2ZNz7RtzrmCLQ2NSELMKwyQOzh8UtvlJnNAWVATVHD+V52MeGiRgCNPuGSnv7/j+jMR8g2wa0xttOzHjFK//MA2Zm6cUVNzjFiHbyVMeNr2rF6MOm4gN5IDLIbtiKKVPXgk3vfmg4CUL3Py/KkC8yK3CadRYRIYIXqWGOmsqyAxT5rRQF+RyTuNMm541c5hzrBfFVxVn0Kt/DaehORUDaNpk0ETEMXjz6emuEOP3b42IAA1G3p7Z01ih/igmPGWLL47zIDfUfcvNNqyWByich1FrFYQ9kNfpXGrKclezY4XSfEB9xaO3puDRHMBVzz3wx01ag1lI+yJMN8l1ajn41iphqvHkp6j9JSK9Lbkq07Ok4a8+IIOA6SZ2K0CsNSgVFIbu2r68OOUTtHRspy5KSOl0t4+IlGp/kUZ4FWJAn+FJB8fmOw66QbZlx8MhXk05MCJ3zTNF64NDZQodijOVsSOLSPQTjJxUsRQ7kBq9mJOpt6JNQAhJZ5mHoz0TTSMwJ4HRpTZsxyHu+QpA8pRJ8/KYLDkugMxtb48+Nt+yv7T8PCocze/2oKWCqD3ahGh4dt9MDP9WOYFwaxUy0K7/KwAAHpEd4cbp3ae4nFyFvOiulJr98XrueyjC3xVDMMEmlKx9flms26SFxDYBz04yKMv/+d6qbo/tekjUluGl/V5Ya1orykS1utbBkV7BHl2TepA+5kaDGu0zX7B5fP/NjCsObuBx+PHgEiJ6e5muNPnY/1X5IQYCiRyremk+NW7CgAAjHy+QVp+DZAzPSnw/63S3u1PqcvnZVPYmZhHbuAFTZZs/DZvnXB9Dzebi5JWE8ZxJ9FSSbsGp6LMoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(7416014)(1800799024)(19092799006)(18002099003)(56012099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjdScld3RzB5ZXRLS2JIWVFNQ3E4RjByemh5V1FRRjRsVjVNZ3ZzcitLSWxU?=
 =?utf-8?B?S3A1aDV0UkcrdG4vTVZsd2c1dEZJNlBvbXFsSWxjMlZ2aTg0SDAyT0NQb1Fo?=
 =?utf-8?B?Mktod0M5eFdab3VXTTZsZm05SVFkdE0yOFpOSmgzWEhJVlhKbzdYQmFQRjdu?=
 =?utf-8?B?NnNkK3JXV2ZrT1NJNFI5aFZ1U0JmaUVvWnBWd1V3VXdJUTI2REVZZkFFYWt0?=
 =?utf-8?B?R1F1UE1aSGpYNFBqMjBLckUxY2pVbHNvTnBpdlpoQ3hMTlVuaUR4VGN0eUQz?=
 =?utf-8?B?WXhuYmg3b29yTnJMWGFzd1U3eWRjZlpTb3BrUnhzT05iNGtseEpPbVpiVk9k?=
 =?utf-8?B?U0Jha0VCU2VKVTFZZFRCd3EzMGFZanJMK2ZkSHp4MTgyR00vMlFEcnJnbElo?=
 =?utf-8?B?V21ZbEdWTWtmcVRObG80Mm9CNHE2NmtKdnR3c0d2Wk9EOGpLL0dnalBiVmRC?=
 =?utf-8?B?TUVUcGlTYmw4Um1LL3RieUNrQjBWWGxDN3ZoMGROQTlZTzN0YlUvN2cydEwx?=
 =?utf-8?B?bXpLT0lZcFBYUTZmazBBcGlHYTBkbE51V3QzSFV1d09UZURyVHhSVjc3SlBO?=
 =?utf-8?B?OExPYzQzWk9KNmpyOTd4RzQ2VGNIc2tzblV6WS9ZejQ2L0JzY2VQRW5wajJR?=
 =?utf-8?B?U0ZITk9DT29oS3RUL2xKTmN0Y0hST0c4RkZXZGJmd0ZZL2NJanZPMzdIemRY?=
 =?utf-8?B?VkFVZkhlOXI3WWE4OEVxaHpaSDI2ZzVzcFRlNjVKdkpxaTMxVW9LWit4QWFM?=
 =?utf-8?B?NWNXdmlYamFmU3cxRy81SnVSVlZtSFcrazkwRUVsWWNRb1ZTZC90WWlldHZn?=
 =?utf-8?B?V1FxR09sYmRXckZRVmh6WWJaRFdiZGNzQ3ZtUVh5NEhEMzFkVTQ5K1FjTVdS?=
 =?utf-8?B?dldwbXBYWCtGOWNBV0JQcERGUXdyTTI0ZGxyNHhYeVk2bHc5S1B4UzU3MERo?=
 =?utf-8?B?c3ZtOXE1d0dWeVV2MkszZ2NvQzV1dkxLWWRwZEtnTHpMTEdLelYrMURhMzc5?=
 =?utf-8?B?aVZQcjdacTBXUjU4S1lYSzNZN0JrSlh3NSs3Vk9QTmNKb3RRcG5FYkE4VnRY?=
 =?utf-8?B?SXZqMDYxcDlIZk5hV1dOMUxvcjg5WTZEa0Z3T1dHRXhoTFdlN2c2QXpib2Fi?=
 =?utf-8?B?UDdsQW00QjRMeVV4TWhXSUMwbW9ISXhSUTBGcEJkeDFmN215cHFWUVdEbXBh?=
 =?utf-8?B?blN5WTg2V0xIbmlZR2xMcnJDVExZc1EwOWFRVG5sY2g3cWJqc01JYlZDeXNX?=
 =?utf-8?B?Ky9DMDlmSFVTMVhvcFFSL21hZ0hRN0dFSFh0eC9Yd0FEd1ROMDBBREkwdmFh?=
 =?utf-8?B?L2M5eldUMnhaS1Bka3J3Yk1QZzNsUXBHWFlVSEJDeExLZGNsMlc3NklGcjJZ?=
 =?utf-8?B?QzN0eE9yNGwxWkVxLzN4cml2UHZnYXNMMG5PbGxoQUFaYzBqWUtYMzg0cGlX?=
 =?utf-8?B?Vkt2UmZPdlA5azU1bVVaN2lyUmhmNkpScnZmeGM4S1h6R01sRVpyL3NUZDBx?=
 =?utf-8?B?ODV0dGJhVCtXZ2U4akExQjNMajdBRHpZNW80SzhGeEhQTGpETmpvYnNxaGdF?=
 =?utf-8?B?K3FjN29yVDhhdU9sb3JFWHd1Y1hzV244QjE2Ykh5VlNuOGtacWt5c1pwOVRK?=
 =?utf-8?B?ZW1tZjBBYXU3UTRITExiNzVDK3lxZk5tcGxZNVZmZHM1YloyNGJpVzBSUUlI?=
 =?utf-8?B?K0N5Q1pMemtDeGtPV01hSU5rRUhOaXFVNmttL3JMeXhVWi8wYXBnNmUzNVFt?=
 =?utf-8?B?c01nNmRDWTU2TlNHN28rWEtwV1U2MFFMUkFCZEw4RXhnMWQwdDE4RVdoZXZY?=
 =?utf-8?B?WTdHTkE4M1hEa0N3UDNxVFUzdlV0TXg0QUdFZ0lCd0lzOCtCVWdyZGxiUXpJ?=
 =?utf-8?B?WGlhOXZZUjc4M3plaW1lTlFCVnk4ODZ1bmpQYVA4UHRWOURvV0xzcktLeTF4?=
 =?utf-8?B?am84T0N1bTJ3U05pZlFJcnlxOHVWMXBxbWpKeG4yODJGV0hqMHZndTQrM0lw?=
 =?utf-8?B?d0M2WW9kNjF2SDVqSVpxOGFpSW1COVVvN0pNakJHUXZTN2JKOWNGdllmbUNz?=
 =?utf-8?B?emRJTFRpMXdHbExFK0FrTjgyWDhxZWtsbWVOcldjLzBwTHMxZTMrM1pFMTBq?=
 =?utf-8?B?VHdtbzV0eXgwWldRRDhmSDNWb2tPN3ovMk42bTM1bXczYXg1dHNkakt3Vm5J?=
 =?utf-8?B?aFpPellNWC92Q2dPOXUwenRDTjJ5LzRGRzFOZE1HbGxNSHVKZXUwRWJUNzU3?=
 =?utf-8?B?a2R5Mk1vcVp0ejcvNFlTOU1ORERLRnRabFZaZlhGZHI3L1RORmlmY3EwSHN3?=
 =?utf-8?B?NEQzOUdha0V4NHgxakdOQUptRCsyY0tibUpPTTRRY3R1QWV1Z2doQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ea7ee8-8479-4fa8-4600-08de9ba91191
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 11:12:38.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeetSXoYnNPWKLLJnFC3MEdNqHJxNHMoJoW/V3pdCIqRALyHFmJTpr1eEFqhHiFq2ckprV2VkqcS5M3Gcs6mKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8804

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
Changes in V13:
1. Use of_property_present() instead of of_property_read_bool() in patch#2 as
   reviewed by sashiko.
2. Add reset Null check in imx_pcie_parse_legacy_binding() to avoid
   unconditional deassert delays on boards without reset GPIO as reviewed by
   sashiko.
3. Delete the pcie@0,0 port defined in imx6q-utilite-pro.dts and use the new
   pcie_port0 label in imx6qdl.dtsi to avoid to defining the conflicting node as
   reviewed by sashiko.

Changes in V12:
1. Improve the pci_host_common_parse_port() to correctly handle three scenarios:
   PERST# found in Root Port node & PERST# not in Root Port but found in RC node
   & PERST# not found in either node.
2. Add documentation noting for pci_host_common_parse_port().
3. Add err_cleanup handle path for pci_host_common_parse_ports() to clean up any
   partially parsed Root Port resources.
4. Optimize imx_pcie_assert_perst() to avoid the linearly increasing deassertion
   delay if controller has multiple Root Ports.
5. Use mdelay instead of msleep in imx_pcie_assert_perst() for noirq context
   safety.
6. Remove early return in imx_pcie_parse_legacy_binding() when reset is NULL to
   align with pci_host_common_parse_port(), allowing port creation even without
   PERST# GPIO.

Changes in V11:
1. Call pci_host_common_parse_ports() API from pci-imx6 driver instead of dwc
   common layer as Mani suggested.
2. Improve the commit message of patch#3 to avoid confusion as Mani suggested.

Changes in V10:
1. Use gpiod_direction_output() instead of gpiod_set_value_cansleep() to
   ensure the reset GPIO is properly configured as output before setting
   its value in patch#5 as now the reset GPIO is obtained with
   GPIOD_ASIS flag.

Changes in V9:
1. Improve the error handling in pci_host_common_parse_ports() as Mani suggested. 
2. Move the list_empty check and the comment to imx_pcie_host_init() to make it
   clear that imx_pcie_parse_legacy_binding() is a fallback as Mani suggested.
3. Export pci_host_common_delete_ports() so that it can be called by
   imx_pcie_parse_legacy_binding().

Changes in V8:
1. Add back the cleanup function pci_host_common_delete_ports() to properly
   handles the ports list instead of simply using pci_free_resource_list().
2. Improve the patch#4 commit message.
3. Remove the irrelevant code change in patch#4.

Changes in V7:
1. Change to use GPIOD_ASIS when requesting perst gpio as Mani suggested.
   using bridge->dev.
2. Add a seperate patch to move vpcie3v3aux regulator enable from probe to
   imx_pcie_host_init() and move imx_pcie_assert_perst() before regulator and
   clock enable for pci-imx6.
3. Add device pointer parameter for pci_host_common_parse_port() instead of

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
  PCI: imx6: Assert PERST# before enabling regulators
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

 .../bindings/pci/fsl,imx6q-pcie.yaml          |  32 +++++
 .../boot/dts/nxp/imx/imx6q-utilite-pro.dts    |  17 +--
 .../arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |   5 +
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi        |  11 ++
 .../arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |   5 +
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |   5 +
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi         |  11 ++
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts       |   5 +
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi          |  11 ++
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      |  11 ++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |   5 +
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |   5 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  11 ++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |   5 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  11 ++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  10 ++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  22 ++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  10 ++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    |  22 ++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   5 +
 .../boot/dts/freescale/imx95-15x15-evk.dts    |   5 +
 .../boot/dts/freescale/imx95-19x19-evk.dts    |  10 ++
 arch/arm64/boot/dts/freescale/imx95.dtsi      |  22 ++++
 drivers/pci/controller/dwc/pci-imx6.c         | 120 ++++++++++++++----
 drivers/pci/controller/pci-host-common.c      | 104 +++++++++++++++
 drivers/pci/controller/pci-host-common.h      |  16 +++
 drivers/pci/probe.c                           |   1 +
 include/linux/pci.h                           |   1 +
 28 files changed, 461 insertions(+), 37 deletions(-)

-- 
2.37.1

