Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ADF372EC2;
	Wed, 22 Apr 2026 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850448; cv=fail; b=Ujwj13hl7vCMlhojRi7NPa/FdFKze90TYT9ac/FgJ37U4nLIz7eGzINc/0Qve64bYUhBJFvthUVZSOc1YR9/bK4KDclLhA3flUK9RXTr2cP/DMs7jR01eM+EVaaOnbcOZtjrckizHStdY9r9CHIVkTTC98x2zChwU96psxjytmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850448; c=relaxed/simple;
	bh=bXHRax0SaDEwnCwvyRCWsm6lmLnpknNkruCKU6I3/7s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NO8OnxY2sWdAsXDfkT9Ii3Zm2xCKStRZjGTbV9uNnSkp3yqvRxnokr35SO81oeEcf24LSkaGpq0niqQteYThG1RsV9WlFm0c5rHtOhhD3cwLZLIAI6l+3etRohb5cCVPRzLRal7bT/dZDJCtimGoxc6X2Nn5ky8js9HhINKX5Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kAaM+hOl; arc=fail smtp.client-ip=40.107.159.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kAaM+hOl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWzyAXmxxMv7U65XfIRhx/xJRdvglxbzVrC+b8WGBR/IvwSHg3RGAYn6UyoC7eSW9Y+sUJAnKNaPS19L153LfAzNJuLKky2BPrUA21rtkFdaJCy0k/b2UJj2BR2EQ/e3uQOttTw+ljErVr1hcbPy51a8Mn5pLij156B/5Y2ZDYAU071lyVmXLqN8YrHFNgtFg52Bh1kbr/AAQJkqDZ94JS4dxwi3SMCUey7Ivw+THpthPQO8QJHvqEqw5wUiRnkaJuHtiAGXCjOjvRCDRF7SiSDTAA+kTbGbUJ/EDOXItwyd3iRGu7DP4VgjPT/lEBpBStOiNQv+aoKmLsO6NcH0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYK67FMWg5onoP1n72XO2tK5fq4Lb3GCxsh6UhiSZ24=;
 b=OBt0ulC8PGc+Vq3r9y2LNcCJLZx4kDjCeIW4cGYD9Zcxwg9s6LW2w4yC2sH+LyyDbqGJVYBT41z2ZBMsIf1AFjIJ053qSVcURJBfkZge/Gj5uWJz8FUWwZAJtukF0J4rcIv8Vltpd8kcFux+fncW1yf2a9Fp4jRWK24w8bSXVoJaV/GZHV4TpUEEJYaLdCNg4h6+heTuQn9jaXkXUTOAXA5emrC9eySnNfyKrrlYF6VX74fta/Syybkg+QjqZ6uoOdjNUSW5qrSHj/FcPS1sa/bRyAfbHv9TUqVqu45hPrsVvxbcHNMmDYRFM59uXJ63ZalK8+WhGbPiKCU93Uq1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYK67FMWg5onoP1n72XO2tK5fq4Lb3GCxsh6UhiSZ24=;
 b=kAaM+hOlZ6n5GSYspoGfVUbsQejL4/ohj/ssarnSH3SGQ3jDvzqzdpfF207KudUJK1fIZ+9GcbZr49nOtv6rVgdk4xC6be0ZK8KREV12d6ythrjQUbVW/kJHrwWSQdl2NT0K2rsKRYEkfgLTZbkmSApHBop4VbdfzGhtBNr2jGpv9qpyKF54xLfq6DfVSFGazkSBi3QL0opfjWmS8mi1dFGxEn9HX7Xgvw5aR8j5QS9kPCdtySGgFDj0tV6HUaCLywb+Lhk2kQRLuUqp8jpPxM3ZXw6MWedWBSDL9E7U25BUG7yRTkiPiz+lz/Nzv2ZoXhjA9GpNu7NHpSlVp7ZXog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV4PR04MB11428.eurprd04.prod.outlook.com
 (2603:10a6:150:29a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 09:34:00 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9818.032; Wed, 22 Apr 2026
 09:34:00 +0000
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
Subject: [PATCH V14 00/12] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Wed, 22 Apr 2026 17:35:37 +0800
Message-Id: <20260422093549.407022-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV4PR04MB11428:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb3f8a3-e8c3-4c99-bd45-08dea05248c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bjD4fjH7YjojyY6uzH2VuwfLXhnaO5ReQdNWfB1rSw+EfSeRU7OkECCcd+n9qnxd96qK1vKbhRvJpYjIFF1JTqfGRaEmN42NEtdErMklfDvXtwRvAyMm6+yWylYTXEkeFctryY0hFpD2vX2t9AQlBWF4sKSwMkGNSL+sPtPYSXPF50E6COSDvMlCC2EQdItOWW2N1admwNnu0wCaBFNdECtiGTczpkznDbHCOgtdKKfG+9kdKhtF8PK9w11Ics473iRdA4YxxEw5yUkrk9j3twnhc/Dz6EdBsITHMA/Y8/IAs5t+XAvoG/p2/F3T4wA5FGUneFuZwwAMj7ZJPm9AM//Qqi3Iy7Vz6SweGk/15aJBEsH0z+f5zAPZKv8DR0auOUAoulCR6V2HjqK2Y+wC7hndhKFcKfeCf+icfDWsf9UxPySV2NQmQMtLkkge0Z/QlQF7oLgzjneZr0d92jh37kbv4vwTX1KZEDoiqJF5VlWIjOq2nMt+vPthW6LkTdmVhaWRnenB4mMu/p4fsgjunihA3+lXORFkISJpCvZlg1CXRVZk+Hljqf2VdomJU1hc4EZH3vAIX1B+d7RYdjtiw+6PrVJjnZlkEDSZXv3t3GVI69zBiz7uJnEvAZg0/c2b6ik79ecWEpS+qgxsHgC8h3K0fEnnJeOksK4182KfP9AsYxpTrrVf7GrbJ2Tb9NFRVLHLfYrjI1DJvYe8iW+3/o2RgJY/x4Jc0r4vpC7hYBZ93kuDJ7O+b8Ooo61MFI0M7hWEgE9XQ5Z4oMzKLLzRUDgaqWs1qw1fMin6JAf82kIa/unq5gQUenRXhnzedW8QhjfL8WF5GVEEMqZGLzinQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0x3K2lkM0lDVTN0cC9aSTNNUTBSYnYzalo3d2YxVFZFVWtwRmpiZm85eFMr?=
 =?utf-8?B?NllBbnRJMXNOaU5pSmtoN1NEYkFVTHJCRGdrcWxwa2RZUjRmUTlOeVNxWWpU?=
 =?utf-8?B?Y2JwM2FSQXI4azdwMVNGNmQ3ejFNLzFqMWZhdUttNmVpbkFEc1ZMSlhIWXFT?=
 =?utf-8?B?RXZxVTZKdzdHKzNhQkJLVS83UkxBakM4aVNlUnFNTmVWTFdBSTEwTFplV2lt?=
 =?utf-8?B?QkdwYWU3ekNGV1Rld2VZQzlKM3JxM21xRFdqZmRuK2I2NkNGc3IyV1BQaGR4?=
 =?utf-8?B?MEZ6WFZ2Z1c1VllDOHV5OExyZ0hZNG1jWFY1aUxJQmM1SG9uZjNkdDNtbnVQ?=
 =?utf-8?B?Q2JkZjlmRUIyWitwWmF6enQ1eWp0WDY5S1g2ZElBMGUrSDZYalVpOWlGcDNt?=
 =?utf-8?B?b2VPUWhaNGZhWkhGT1lCa2g3eHM5TXFkRHdOYjhXR1Z1YXhUeUJxS0FLRjRy?=
 =?utf-8?B?RFYzZng0c1NjalFLeklYRmRpNHpvMGV5ZVVRZlRQYXJpMzlWRUNBdytxV1lX?=
 =?utf-8?B?a00vaXVIbzRqajVsbXVvL2tDQ0hFaWJqSkJOVTFoaEpRMTJyRm96elNWeFV5?=
 =?utf-8?B?VVRzRkFaaFozdmRCOVplVnc1aGtsS3pxT0lJbGw5Tno3REF3d3FDcnFMM1JW?=
 =?utf-8?B?OHVuUHJOWmVONzZIaFFhK2VrbUhtSUQxeUcwSEp2LzdHZDgyVDIrcmFOdWta?=
 =?utf-8?B?YWVTbW92QzIrbHEyODNvbmJ0N0hOdGtYNjlVU254SGViVUZUTWVBdXJvUnoz?=
 =?utf-8?B?Rjc0cmlTa3QxMkdFTkdGR1BVbEVlL1ZzbHhzekJ5T2JZNUVOSmlJNTJ3eXV1?=
 =?utf-8?B?c3BQWUtFSVhpT1MyVnBqTGRNM0I1RDRFZGx5Sk9QcjV5OXdlT0JTQkt4STcr?=
 =?utf-8?B?UlFLTjBHMFI5NGx1WFR1bXBHMWZweUNVVXIyY2p6bFlOWk5PUHIyZEpIcFlK?=
 =?utf-8?B?YTU3MjlVRHdQUTR6OWF4dVpFQU51bXR0K1pyYi9ITE5WRXhYT040L0FtQjg3?=
 =?utf-8?B?RGNLdmE4TWoyZEdNWHU0RDU3UDB6SjU5OTFZUUhTZmpTd2JzSWU4TXBuWG9y?=
 =?utf-8?B?WnkwRXVvVG1wRm1JZmNkT0UyQmxmYVV6SGh0SnNZT1ZPZk5qRWlCcUk1Q3dU?=
 =?utf-8?B?MzBlS1lkK3dOM1JBdTVucHNGaE9BOFV5SUxkYUZnd3RJQStSY3RJNE8rQjdT?=
 =?utf-8?B?QXJ4d2NWenYzcTYxL0FXMG9iYkhCQVhDMHJuRmRBZDNnVUVpZ04wYUhDY1J5?=
 =?utf-8?B?SVJjclRMUnVFVXNteEpSMzdpZHJvTXdtY3ltV002dk01TTN4bkxlbG5UNHg5?=
 =?utf-8?B?WHgzUEl4R3FNdWhXOG5nTWNzVGlCdm1za1F4OGdKa2lhbmt2ZG5mVUpiOW9L?=
 =?utf-8?B?bU9BTzdJQzF1MFJ2MW82eDdmQnVRZWVkZ3NXUEREbzg2SU1FRUpnVFVWcGp1?=
 =?utf-8?B?aHpWYVJ6QlFrQTlJWms5OTArR1F3empaOUtDSEp2bEdxaEQ1RlNENTdVSW5l?=
 =?utf-8?B?SUNJbWpFQms2YWNlR3pWYzVnN2I0Q1ovMUo0eGNtL09KRHJWM1dxekhBdTE0?=
 =?utf-8?B?NUdWVFZubmRpTkFCQUpCOWxMUk83Vmx4d3c0MmNUS1ZDVHFDZjlUbldaSUZ4?=
 =?utf-8?B?K3BuRVBGc3NzQ1hPdWQxV3hjaklQZmxCa0ZoSlNFbnc3bGR3Y1RxTEp4Y1FX?=
 =?utf-8?B?RHl5dFB6eTdlcHI4RUUzcEhxTmtweVUwVDlYQXlRcmZ1TVdFc2cwZk1HUDBp?=
 =?utf-8?B?T25acFdNOGNJT0VkdTlHQlIxdVcwY0ZXNUU4ZUsvQWZrbTNpWlkvV3J2N0Ja?=
 =?utf-8?B?SWpSaWM4d3dlVms5NFFoMUhmVWpuT1cxK3cxREVZelVvaGFQMHl5MTFJaS9M?=
 =?utf-8?B?VVJWT3hPRzZ6blRhWGVEazRMeDNBUjF6eU9xcU5JZXdJY0QwZ082TDdFcmR6?=
 =?utf-8?B?STQzeWJBeUkrelMxREZLckh0ZHp5V0oxYk5Samp0S2xCOTRJOXZYMExodGRM?=
 =?utf-8?B?OXV2VzR4enVqWTlBTDhiaE1uUUYxcGJZblpMaFR0TEhHclZoRGtVUFRjTmRE?=
 =?utf-8?B?VHZEU3FqYkgyellwRVJNL2RQbnBwQnRKdE1HQVpTYWlmWitOZ2krNVJJKzVH?=
 =?utf-8?B?Tm5TZWYxbEllb3VJZkJSM1Vpb2JqZkUxazRoVXZ4ckpqWW5sSmpiTVY4eUlC?=
 =?utf-8?B?dTBFSFFaRHZvM0dmbGZxa1V0UklzbXVqVWFoRWlFZ0JoTXFsZWZDNjFYY3Q0?=
 =?utf-8?B?ODNoWUNiYmRzN01lUTNpOXdBSExSajE3RXhMZ3YvOHJsbnpnblJYMDBCYXQ4?=
 =?utf-8?B?cm5jMVhHNFlkM1BZNUZUeDQ0UFFpTnMxQ1hzVWFUcVFIcitNejFqQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb3f8a3-e8c3-4c99-bd45-08dea05248c9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:34:00.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBgGtgKBw8Z9UItIzouHRqHgVFjbEr70dMGY8GyQ6eQOscV2O1AdD2SW2ZNNcBpBqCVSq6XZ15EM4htT1fHITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11428

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
Changes in V14:
1. Add pci_host_common_parse_perst() helper to parse PERST# from all PCIe bridge
   nodes starting from the Root Port node.
2. Corresponding changes in patch#2 and patch#4 for the parsing PERST# logic.

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

 .../bindings/pci/fsl,imx6q-pcie.yaml          |  32 ++++
 .../boot/dts/nxp/imx/imx6q-utilite-pro.dts    |  17 +-
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
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  22 +++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  10 ++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    |  22 +++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   5 +
 .../boot/dts/freescale/imx95-15x15-evk.dts    |   5 +
 .../boot/dts/freescale/imx95-19x19-evk.dts    |  10 ++
 arch/arm64/boot/dts/freescale/imx95.dtsi      |  22 +++
 drivers/pci/controller/dwc/pci-imx6.c         | 132 +++++++++++---
 drivers/pci/controller/pci-host-common.c      | 164 ++++++++++++++++++
 drivers/pci/controller/pci-host-common.h      |  28 +++
 drivers/pci/probe.c                           |   1 +
 include/linux/pci.h                           |   1 +
 28 files changed, 546 insertions(+), 36 deletions(-)

-- 
2.37.1

