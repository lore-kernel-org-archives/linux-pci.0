Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF243A9002;
	Tue,  7 Apr 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558512; cv=fail; b=j1fL4Ct8OfnUPe386pCdMSainEofGJbrffZISm6KwvYrS7fFni9czwhLw1wflOEf/W9XTJNZjK4iK6QZF7+1KkwisggX5kiYuqZwN7xGiPBRcamUFlAsrRdRMGyOX0rjbNRBiuahomkPY0mDWw43Of2NZ1znNGkeJ+3yhNZViPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558512; c=relaxed/simple;
	bh=8A5z1A8vBgQTQ3QUf2iKrcXUipyZNA3gOOM+XvGVLXI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dTeS+FgdoAW7MKItYr7q8VMGSrSIbt53cfg4BtM0bEyvxRbS3n4BY+vyMxuNdiWQVXocGUmoZBRjKKAhKtQAKLyBux22mlDfPZu3JdEr7cBHUr3nYacwsLbwkGRzVxKCs3ehPWtv6uMy8PgEEDLW7yGWnDHKdqw7439aBv0txFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jBJvXUOr; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jBJvXUOr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuu2IqhfyH6Bx6Oa9ds2tSxkZ8EZDhMgo17ujkDvvGV/1gho7cSqO4BAgdE8APzZbvI0H0dYaORW68xIloliSW8SOoXlCsZh9vC78Rvl/h1MWgI/ggKeH4om+ZheE1B22nCTaCSpbqwed5+UIh68onThc3LnpfUQSn4/redakYeVYSzoAS2ENmmgQlHy9X+uwjU0+vpLNJ3GZNZKQ4SPOOlF8ilB13b1MR/QaCxM5gu6BKRctS+ZGiuxFWq86LAoJUKqDIyQWJ+v5VAgfIHMxmx1zr3t+0e06ghjeXmIigVttW3jdAODyR2EuQncWeSHf+eoM/jf04R3VgcnMpus6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch0JC5e/2KOAKEijIdIl50TUHJy6P2CmvTMTqRV3MM8=;
 b=umuRC9qoA/0RwLmknK1Zj6YhujlRmISmrcouMrGCkKNWviOPbfPj/eIrhpRd3AhNSYQ+LVu3IO4yvtGK55HIABC0lMoxjD8FnlWgfhBcoJ6Fz//hXL+AiOMOPuQ+MIQjS9n8V/QqIQLJORqcdK6e1be4599LAqYmgnu0lDq5Ag9lwLvKCcojoRh2MCnDDSzprRE2r1otMECiRFJB3Mjb0QnzyokP/ttKcUJVV3DJ8fU1ToGKOyJd7CaCxUTVyVGYjzHd4xYrKBn4XkOJQtsEqTf90tnEhJocIlK8An/awhtkgYVVHqpnU88tXmGGBpILHPLINCoRo50Ey/esJguN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch0JC5e/2KOAKEijIdIl50TUHJy6P2CmvTMTqRV3MM8=;
 b=jBJvXUOrE8KApwgaML50wl7m4mkk12jMq7k5dVO0KeTKpNLeSHlwYACrouPxX/qSBDx09zcFfMS2yuyuatIWCBTD1+6zxLMMh1tilA/fnR0jliAVOxbuqGbu88FSrqvTsisemcWwAzq+H66EXzJ1cZMwTkJ99L+TVVXKKnJRm0KV10Zw47xfV7q3ahbQD1ZJsNlNoC93cxTMcS7INRMLeqBkabasIsGiQkaGTZa7T+RXNkcz8TsCc5ecFvDKhkMNIydSyd7LwcxBgg7ME5AmpqRMNcvJJPDx7bR0r84Mlvc+VLiblTB33mBaPvduezHjyEmwXajl9+7JPNdAPHtE8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB10500.eurprd04.prod.outlook.com
 (2603:10a6:10:55e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:41:43 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:41:43 +0000
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
Subject: [PATCH V11 00/12] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Tue,  7 Apr 2026 18:41:42 +0800
Message-Id: <20260407104154.2842132-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0060.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DU4PR04MB10500:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0ac0d4-6200-4b4e-ec28-08de9492423b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|1800799024|376014|52116014|38350700014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6CW2pBzN2JbxbEUPP56L1mJMFKA/o1koAH3dPs/7Z0GyLhgjC/twJbPwqPu85roT0Z1oyL40cc8k//+8Rl86l+aSvIwDAkEJKCfGGGfPATiCUtN5HdaJYfVmuBTCSQHb5QRnt8Gcv9rNCcKWNDTsleiwNS9CLCh4PonVJTFVQahXIy+9URWVJiO6oY5tAg0W61bUTpaIPKqkyYSJDYliT+D2Idd/xOCzwU19PDEjKYtcTK0oU0bjgwsJc4P3vabS+88VZq96lhAj3OMsPveMtpDBRCG4w8PrUM4HQG/1ccA38pOp3t4LMEs/2B7ZnQsDLkmtSoZ70CS3hSosuQwtLc2reMX25+Gj8nNVuUeyv42pOS/USMn/H2fwTUwBV3JSuh1Ms4QJrGEpIn09n+z8v+gjDfyRJ0RwS3Qhozk3XQzkXrSblHf8xkmCKHCX9aiOdNQnCgH6ktpoaMoYsbW8JVnozkqvGgVyI/O1rNNU3ce5FJ//+KR4Gqv5O7W208Pdh4pxFgbMxmHbNFu+KgfupCCqQ7IrIkqsjef1XT8/DSzy6YlYD/lhenLkYaqEgnHr5UBbC74YXh6jtgUiu821fXCfA09jV0TSL7EeUcF4j/Xe5rxbV+h1yVqBkP7QmWBFLhUUN+xzbXbvQI4OGlhC9c4A07piSyqQv2vMBZANEKWA7VvL5QiFNPTQgk2EICFur5O5sssVddCexlnmaQqa8hhLx1M+UmhqfjLfheAWjg0t0/G1lGx4obIsR6Qa6jQP/2YcMi/9WGl9q6ppjRwINprLaCKT6zZg1DzvrVWwLfO+3AASRHgWHyXVjQPXzoow
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(1800799024)(376014)(52116014)(38350700014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWNEa0hUMlBTNWJNK3FNeFBBcXlTZHVwdmxjNmQrWDB6YWgrbDFuSHhwNWI1?=
 =?utf-8?B?WVloalBLWnRpQ1hBUVhGMEZZNDNYcXRCODUyQU9SVTRtajZGRm15WTZWMGti?=
 =?utf-8?B?aVc1alVWdGwva1VFb3FxZHBSTG5yRDdaRDhtclhKZkg0ZE9YTkpIUXhjbXZY?=
 =?utf-8?B?em4wdzFSRWdMY1lsYXo2bVVsb05iUVZnR2FHMlhyd2Q1L0hDUmJnTnNGek05?=
 =?utf-8?B?RnRwaVd4MGZya3ExelhnZ21JRDltQUVtbDl3TU14bTJjY25TenkvakUzS3E1?=
 =?utf-8?B?VzBCMXhMMHhXUlVDMC9RSUxFdWNZMzVpeTZGVmZOaTRaZ05GWWw0cStsTGdE?=
 =?utf-8?B?Tm9BNlZkUnA1L2R5TTl5RjJNOWhySUMrSnhnV1U4RExyM2lMcG9ValRkZTlF?=
 =?utf-8?B?UytVSlQzS3JqWk5HUVMyTXBuOFlLd1lqYitndXJCbGliUzhCc1g1L2JGTG9a?=
 =?utf-8?B?QWNFVHp3dFAxU3NqaEZaOEZzVWdHdkRGSldTZi9UcHpZTnpVY1owcWVKNzZL?=
 =?utf-8?B?cUFCM2FZL281WnhxaFNFd1ZVcEViZnVRNkF2b0hjZlRJWDQ3dy9ucFYyWjM3?=
 =?utf-8?B?TFdzbjZhTlNienN0NjdDQWo3cFJORmE2WEkzNmZ1UWhzakJsL1BMc1JxTkxC?=
 =?utf-8?B?SEc1Q0plUXhSUkMvck9rdm9najRwc055UUJoYlhxbVRMbFFad1dLVFN2cmNs?=
 =?utf-8?B?TlFPb2UvNjhUVEpzYmx2NXZoSFZlTEM1aDlncGsyUTlNZ2c5MEhLOTZqZFBa?=
 =?utf-8?B?dTduVzd4dlpxanByOTd2eGNkWTgzWWlpOTNHNURCTEppM3Z0YTdNSjMvckdN?=
 =?utf-8?B?eWVRMDdQSkN2UHFNRis4VmNJMGhyb0tVUlU0NFF3Q25CRGVwWlM2NWcyWXJE?=
 =?utf-8?B?b0dPR1RpV1F0b2pLUExpREVhem1HaFpNMzJqM3kvbE44eTB3dVVCM3lIVzZD?=
 =?utf-8?B?YnZWSHZDYW41dy9BWDNrZm1VN1BkTVhUVW1KMWc1RjJ2VDFBS1M5SVkrSTF0?=
 =?utf-8?B?Zk5FL1AvWXdHbmZRc0xEQ0Y3b3c0Z21jNmZhMHRybjNjcktrS3hTblBNdEVW?=
 =?utf-8?B?Mi9XQkxIL3NYa3FaL2h4TzR5VERlTy95STc0TktIYnhscXIxRWVwblJsd1Bz?=
 =?utf-8?B?ZTVYcEtBd2Y0cUE4VkJ0VmpxUE5zOGc5djlyVWlVU2Z0T0hHK1plVmg2U2lT?=
 =?utf-8?B?cDRPdnRVekhDUlVxOVFHYkx5dEVjYkQ3RTl2VG5VZFMwZVk5MklyVkhWMnlJ?=
 =?utf-8?B?K1FuM1FIRHdhdTArRUdmaVFNTkFXRnFJSUwzWEtnSjNHUm0vQ0l3eGZpNi9R?=
 =?utf-8?B?Yjk4ajUxQjUrWFZHbjNxUlNneURsWVZ6R1ZqdlJEK3RWRmVmTFA2MWo5SUFQ?=
 =?utf-8?B?YkptR2lGQ3J1K3dYdjBObEhmcDl0TW9HdGc4SGZpbmpYQVFwQTA0dVRWQnl1?=
 =?utf-8?B?OU1EYzNBRGRvbGtwOWpadnRUVE4ySGxDeDNyYjR6VnRXcmMrbWFTZlpkZmQ5?=
 =?utf-8?B?TXYyR09RMUJ6V1RTcldoT08xZFNHcjJaYWlJemU2Q3RWMUNkZkp2OVZGL09G?=
 =?utf-8?B?M1U5RDNwakpFOGthcFFqWFcyaEZrREt5dlBtTVFOZDdnNVlRLzBMcXNKS3FS?=
 =?utf-8?B?LzhWV0JLVmFWVFptZnVqOG5GTmd3T1AzY3oxSDRvOEl0Z0M2LzhETlUyTUZZ?=
 =?utf-8?B?MEdaSnBtNFUrSDdOTTZIc1VsdTJtOUs4bjQ5NE9jR0N5VXdYcEhNaEZwTFVD?=
 =?utf-8?B?d1RxeVpjbVIyei9Kd0xJdWFMTmpqb2ZXWVlFbC9uUjhzQ20wMERRMUJ5K3Zq?=
 =?utf-8?B?T2hyTi9SZHdjNCtBOTJTakZYdWpjdUNETFlQdFFrZTcyRVdMN3NmTUJQN0Na?=
 =?utf-8?B?SWxpdFR0djA2OGVwb0xoS1NjWHNHWE04UWUrL3d6WkNBSWF0TzhkVTVLejNG?=
 =?utf-8?B?M1lnYUlsQXBhT054S09seGF4eGtCZDNBVXZFZWJMSUpURUtOUCs4eUtlYk1M?=
 =?utf-8?B?eFVGa0pXYy9oanVwVjFxc0E2ZFVBV0Fodk80N2Zmb1hFL3I0dzhHV3lGWWpo?=
 =?utf-8?B?MndkWTlkTkJsaHhXeDRGQUpJaHYzQkQvbGgrdGovbGdVY2tQOFZ5WnEyenVx?=
 =?utf-8?B?Qm5PUnRLci9RY1ZDVFpZckt3Z2JvWkx1ZkRSYU9lRDUxbUpBbUx2eDRtK0dx?=
 =?utf-8?B?dTFzRXk3TjVCSFJ2QWZHMk8rUXNEaGt1VWJGbDBmUThpQmRDZVB2NFRTbngy?=
 =?utf-8?B?ak1zTzdMRjdsM0xybXpNbjRGY3RjcngyVVV4SWxzVGJza0FWUXlXU0NGQ29x?=
 =?utf-8?B?aTB2MmZBUWMyU0tMcEZpOVRDTm02aFNVV2JteU53ZllpSFI2M1EwZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0ac0d4-6200-4b4e-ec28-08de9492423b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:41:43.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJfUMHTL+Nq4Cbu8UjW/CzvYGkIEaL+aho5HVrng8dEPtJ4DmA3xOl34LYtz3XSIuUDe6ycfYERy+vYR2Mbgvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10500

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
 drivers/pci/controller/dwc/pci-imx6.c         | 124 ++++++++++++++----
 drivers/pci/controller/pci-host-common.c      |  77 +++++++++++
 drivers/pci/controller/pci-host-common.h      |  16 +++
 drivers/pci/probe.c                           |   1 +
 include/linux/pci.h                           |   1 +
 27 files changed, 433 insertions(+), 25 deletions(-)

-- 
2.37.1

