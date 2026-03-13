Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7F1D6195;
	Fri, 13 Mar 2026 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367672; cv=fail; b=sAFJ2XD2+/mNgAZpGaEbbGdhQMHB84IfyjBBMbhP9wfmbLDb6C3hjnWzXX2UWSDX+uRNeuMbwhuUJ3qsly53fCLjKneL+k3aWlHuIwBiDwM6voKCXwSm1ucwkbTyByvcEUa2JlCXYQDQPjMBCha5G57inOSZyobPMJea/jqvjrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367672; c=relaxed/simple;
	bh=T5lrmsBZmiE4EfFe5TQlv4k9Pe4mN22nnLZ7AmGqZT4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=O0ATo2RXW5vVPTspq/2c2/SGw2z89CwXonpzeSi9Q+iOGAHRf5nSUVwCeXol5sAX03vHlAWV6H3qu9mjflONvOmPaeBdOFQecYqflhRSe66wHtvr2ugRrOzMemW9GqyGtdGyFFYfWr4+NLF3HWvMD5klc70uT+NuxKS/uhEO0FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YEuN/R7t; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YEuN/R7t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8fYQRUc/50tvn3moYoU3Fs/CvGshwqdIggvDX8flA9rVE3Em7Ylb7tDkbkQZCZYcVHIjbwk3N8v6XEBk4DB3dIPfsJaIdWaogfpf/Q5v35v39ILxChavWXqXcpJ3WVwP2/sl8IfylB3A7Y/qw628lylR6hGhYLhMWdE4Lm6ZVplk0gArMZHBaaDi27+P25IAMdubAa/xNMiud34d+RwMrIjGjxevemSCwP9Qom2lCdfriBklBlYqOmvkd68drheZsrNbkYzX6+xLIZ77Kc7BZW/Tez0KxiFwDbBVUuZjahQcJPtJRvmctZbK/9uC3SWF/DOVDFSgkF0wrsUMs+f2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37dRsxn6OGRVyhry1/kBjIfCnP+ju3xuEAmCrctv6yk=;
 b=kCvSW/x32pSh/UQP8WNrFd0YXr4eaji5eZe/Tt8B8WgHTxISHb/DyzZiFel9VAfL0uMKY2uC/ks8dbVosFPhhRXNyaMYtN8i3Mg83DcYbcwbLvKhYHXidVY7v5Kn2789O44wJXU6kKIcCLShfS5wb2iqH5fd43X1z+m3LB19pKmTyzV1cluenBOdHfX4w8rNAS2g0sfaZI2lbrii/F5UaRXnp/F8TnEnNgH4PVQL1zDeU5/Me4uoUig11tL3g1ETkGTni4fVD/uXxtf/6kVCxqHbYpp+kxCuQXilI2ZjqeRwo6y2lIodoa4ZlpTk0EzGYEsn8Jhz5Q6vbsw/08baeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37dRsxn6OGRVyhry1/kBjIfCnP+ju3xuEAmCrctv6yk=;
 b=YEuN/R7typN3WsIZknZuhfhlprQwgum4zkyVpN4bVHLiJ8lh4IF6YuTUYTTbM15YnzQ7tNvydKWJCLqnM2y4Bmm71SGW7BkKW0wgJtonMysp4XnuevvJXbuvNAH6XsAMHPaoHos2b64qAIRxOFexlFp2HU2UshGcP+GFcIf7Ai1Qn71orFFIue9oBjmlrITsg3i7dbR87/b7OGGN3qlD+ERv6ig7AfpoPyf5sgqIcheXoQNbrpJfZtAy2v9qNsi/UkbPVnWHfRE9b39cqrUNZoZ3ExLVP23+MvfRX4vOesJuUbXPxVlMQoRxiinFn+c4BJ5kclHgu9lw4ywN38rntg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB8PR04MB6844.eurprd04.prod.outlook.com
 (2603:10a6:10:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 02:07:30 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:07:43 +0000
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
Subject: [PATCH V8 00/13] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Fri, 13 Mar 2026 10:08:10 +0800
Message-Id: <20260313020823.1592389-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB8PR04MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 7249bbf7-91b4-4710-260e-08de80a5500d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zHG4+ja5c05yBpEgj1GrzUihEnDuTwCkTtF+DuzQsGJUxshVzh6rNgvc54l2BXX4uk4xGtDdPU0ubFDYk4aed9DFpw3qNTCxt+Z8ihEQqwi5715l6OHmKPvc4cdogmQ3mHy6dqOIx904937MrQ0cTZ8sPshUnFJnkOtjuguHbirdPjHoIrWRbdwfooZok4U3yP2/RiaCwo05M006l+T6Rso7O68/1Nly+iAOgPuaOsbxUfFj+EFoJtgEb5eiIZRQ19+R0AUIBlgmZA9y7awNT64cQkWAzAN+xRiTIV45b8uOC2q1EvhDelWww/dMHD0nbfVsCblgb75eauyjAun1FH9b0ZEjOQ3a7ksEtLd/0Bzz5LZGFl3U7Y55OIRlKmAC6CfoAekNFAVpuQTLA73aJHiC0aZfDmGjRx0Ty9yCeW5+hOKwNFyIn9PCuz0a5Kdt4aexBKmcUjd2/WZriPUdtUsyc2Gpqaifpet/AxCDx7mKs/V1A9aALBu5lpugj3Ig0C0cyAnit6N0TBJGOz08vLNQ/3P2q2dxC3eqdVRQmF7vwA5pAsrPO81WfkJzMSRXskSGLawxu91/9MKIMKEHHYizVRSzOepyCJ3RskQPTbmg3rXDyHl7GIh5StpTRgsezXzJkA2qp0X9IF2RXS9S88Ao8D0ye4nI6zeOsmFHjRmQSdNqdkokGsHO6vDe6kvO2UBx7JU5Tuoc32rnCnITWSUe9wNYbryKcXo/Ndt9txxJvyGRApcKyUCqrCmid1rduKVwh7DzxjsMuHzIJ4nPmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mnd6NnZ5TkVrM0t0My9kbXNaQ0FvU1grTmtrWGFjWlZHMFZKRFhZT3dobmtZ?=
 =?utf-8?B?RDNwUm9ZdURuUTRCcmZ2TldibjZjOStpV0JkYVlEMmhjZ0drV25wT3NIRGZr?=
 =?utf-8?B?UmdoSTN2VndWb0xsL0h1YnpHbmUvWEhuU1ZjQ2REQVkwaUdLeUZrbVFtemlT?=
 =?utf-8?B?dG9TVFp4VUZEaWFGUG9nR2RrcjJQRVE4eG5GOEhwR2dpWitGWXJIc3VLTFUx?=
 =?utf-8?B?R1QyNUc3elBhVDY3eVB3Z1hWMWdzT08vOW9MWUVhOUpsd1ZLaUh2a1F4ZmIr?=
 =?utf-8?B?YjJIaHU0VHF3WFBaekZPSDJGcWlxZWhhbXZZbmtVMUZBb0xwK1JJcUhiMDBs?=
 =?utf-8?B?emthc0FhM2tnaFVCZ1ZrbGVkcWVLeEYvc3h6NmFhQmN5eFZGYlBQTnFud2dX?=
 =?utf-8?B?d1c2c1JGY2FJdE5iWlpMZ0kvR1AwSkVqZVBaTGNoejJ4aEV0V2JQbEg4Zksw?=
 =?utf-8?B?VWsxU2hwVFNQdWVKZzJNR0lIL2FWTTFCa1Nwd0lkTmF2cUVON2RoTEFLbjQv?=
 =?utf-8?B?NGRBd3VWaW55c0RxdTRLWi93WWJWQU5TZmU2dkJKTDFaVGdvRHFNbmRpcjNI?=
 =?utf-8?B?elV1WmxaaE9KblBJTnFZamtDdmYrYW4zemdPeWtPTlVLc2VrWUNxbzI0SnVl?=
 =?utf-8?B?a2JTWHp0aS9zQ1AvUHRPS0YrYXNUSGJpWkxyQm5wM2hsS1I4KzZZN3VOQ0JT?=
 =?utf-8?B?bU4yZGI0ZTZ0WDB5K2NVZGlHOVppWTJsUzgwR2dGbWxyUWJ6dUUzdDRseWtC?=
 =?utf-8?B?emJ3K3Z6Njk4aWZUL1M1UTRBblVORVUzTWc1Nlg1RXlWeStKSklqUDBTcEVk?=
 =?utf-8?B?QmRwaGJxbFJncEkvOXBXdGEvTWloK2YrbkhqaGdPdGUzS2pXZTY5czNLVkI2?=
 =?utf-8?B?RU9YRFNTdTArYU5LbWo0NnNObEl6S1c0TXB1Y1NPUHVJMFErU0hBc01hY1p3?=
 =?utf-8?B?RU42bFZMRERlbERseGJiUEppSUxGQ2MybWpodjM1aVQ4VnNTOFAybEJDWmtH?=
 =?utf-8?B?YVJ4VHZlbmhBbmVFREdqWm5aNTJZNDFiOXNOSVNpYklxcHlqWlllTHRWZDVV?=
 =?utf-8?B?ZFFkREpXSlJET2RlaWx4K2toZXZRWi9vTmpPWmx2UXI5Q3VIQ1ZVTTVjU3R3?=
 =?utf-8?B?aE1hMzgxdmNFQmEvaSs3R3kxUG1udS9Ud0tKZHhsWTZpdlcyRkhPNllqenlj?=
 =?utf-8?B?emYra3pEdWZ6MTBJS1VmY253SDgraXZBTHU4M3hhYmQ3bUV3N0psSFdBQW96?=
 =?utf-8?B?Qm8zaHRpbDNpQUd3RHBtUHcza2psSkMvWGJkNFQzUG5pOXl6VnUrSWVwSk5M?=
 =?utf-8?B?RTBYRm43RldEekpSczZyYnZYQU1LUUxyd3BpTnRnczBYY3JSSVlSWFFMeXYv?=
 =?utf-8?B?Qk4rUXArK3A5bzFmcFlZR2xUbThVUExFaGd4UjUzZ2lRT1ltTDVrUkM3enlr?=
 =?utf-8?B?c245ZVI4QStzVVczUkxWMW9Dd2o0N3FxUDF1WmdBc0VNb3BKVDNXZUR2bVpI?=
 =?utf-8?B?MklOTG9tOEhlYUdBL2lEUVE5dm1GNUpGbFpZakVuOTVxanZwV3VqOFdGdVJV?=
 =?utf-8?B?ZFpZQy91cjFzN1FXNmFBVjNQdmxqM0dSMitVS0xUNHQ1NmtVdGlIM1ZKcFRI?=
 =?utf-8?B?a1NNdDJuVG1HU0ZQV3VUZ0NET2VQMnBnRkhoOWNKeDF4bUp1NGZ2ZFVoT2J3?=
 =?utf-8?B?ZGpDNEhidUJYSGNkcWwwRy9TU016V1I2UzNVYmpHbko0N1dlU2F0cmJ4R1Er?=
 =?utf-8?B?bFRETzF3d2N1aEhoUnhSOHI1cUh4RkVwYjA0cTVnK0szaUZxbFdPSlZObXNw?=
 =?utf-8?B?WWlYdDBabWVuSm5pR2IreEJ2K21QZW16QWpsbWtDSEVxdWczRXloYXBzODEw?=
 =?utf-8?B?TC8wUUo4Z1ZBRktuTm1Cei85TWdPYTJSRzV5N1BkZWxOTEJKOGJYZmRNcVRX?=
 =?utf-8?B?K3lDMEphdWV5eEVqUnV1cFlNcHR1TGNobFpGbU0xaUYycjUvY0lTdXlRbXRY?=
 =?utf-8?B?MXhudlViRHZubFZFdFpEZjhFN3Q5THExTUlEbEVXbG9TakNKT1haYkVZeThU?=
 =?utf-8?B?OXE0QzhzamFrekhMWDlZRkk2QzVDTFY2ZW5QSW9DTjNob1N4SnNnT2FzTEls?=
 =?utf-8?B?MnNqcWZSRnFiWTRKN01VeXFkZ2NZb1RsTllpZFpsY1FmS3R5OWVvOXlKTlNU?=
 =?utf-8?B?R01UZUxremJyQ2tTeW4xclZ4Vkd1K0ZMVGJmc1lXVXpxY3hsbTRZUWw4WDFU?=
 =?utf-8?B?M3ZzWlVtWW1OWXI0QldQUkpPTllHUUdhbUQrQnhyRTg3Vi9LKzdOcTZaWVdh?=
 =?utf-8?B?UkxRMEJpcGIyMkxyeVB4ZHduY3lCV2Z4K0M3VTlmbHFoN2ZDZk93UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7249bbf7-91b4-4710-260e-08de80a5500d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:07:43.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1nWBH2vbIltfW61ijYj/zDEqSdUvwvokh21rLyhjMaanliRQwCH0wqhTp3h3sh7zRpSqErHXSw3U/s5gv7xIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6844

Note: This patch set depends on my two patches [1] and [2], which do some
cleanup work on the pci-imx6 driver. 

This patch set adds support for parsing the reset property in new Root Port
binding in pci-imx6 driver, similar to the implementation in the qcom pcie
driver[3].

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
framework[4]. 

The initial idea is to adopt the Manivannan’s recent PCIe M.2 KeyE
connector support patch set[5] and PCI power control framework patches[4],
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

[1] https://lore.kernel.org/all/20260306021247.991976-1-sherry.sun@nxp.com/
[2] https://lore.kernel.org/all/20260306030456.1032815-1-sherry.sun@nxp.com/
[3] https://lore.kernel.org/linux-pci/20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com/
[4] https://lore.kernel.org/linux-pci/20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com/
[5] https://lore.kernel.org/linux-pci/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com/

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
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

Sherry Sun (13):
  dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
  PCI: host-generic: Add common helpers for parsing Root Port properties
  PCI: dwc: Parse Root Port nodes in dw_pcie_host_init()
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
 drivers/pci/controller/dwc/pci-imx6.c         | 123 ++++++++++++++----
 .../pci/controller/dwc/pcie-designware-host.c |   8 ++
 drivers/pci/controller/pci-host-common.c      |  78 +++++++++++
 drivers/pci/controller/pci-host-common.h      |  15 +++
 drivers/pci/probe.c                           |   1 +
 include/linux/pci.h                           |   1 +
 28 files changed, 440 insertions(+), 25 deletions(-)

-- 
2.37.1

