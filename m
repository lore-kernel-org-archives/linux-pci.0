Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27D2F3C1F;
	Tue, 10 Mar 2026 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107596; cv=fail; b=qSyn+P2Fay9FCF9kaSEaD/ONE/F88VYgTz7DzAI12JM65szIHTk0utFwmyjjKIAcwnxJCp+g3hBiPdHnUl2Dgs5+ojb92GAMbbU8qw7kLUg8+DBVaABldXbw6u/zrad3rwdPNBW83SuF6tXB0iRbCaUElq90BeTQi6MjWbnB8yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107596; c=relaxed/simple;
	bh=anWn9XgcBsYwlH3FryDx1adeWrZfV6hZ3ELDv9/zNY8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d/lbCIUaqKZW1pSBIcdSCVEKdYmpGaj5mhSiTnlWabCKQPL8dEKDWySgfZrkBjbALTWAace1A+r4O6+saBvXVxPU3hyVP4TqnWAKiWKdLaZDq9hwB77MlxuFBgIVuPfpFOC8FL3sJpz/IpZd8N2MTvVhIYxj4URmPmGtOKYRLHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BzONUPw6; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BzONUPw6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aulRlq8R5xTh7q2Iz1fO10bxOk9n5LOvH2abDjUfdrvU6GykBVrZUwaREEZoAZMy6oHebpo07tFf740xk9gEfJWIirekQcUO2JNzDOYLzvQmR0FStzFuE+bfH6XoVlCl/MXbtyM0oa03M4z7Y7V/7L9TwU4FTXQGm9WqxUs5PC/Ad2nAEXYqucbz0vmjssgjfpEdUb+aQsa/IRQ63vzv65BpaFttYHsVlSlhYYcvZcGjED44sYDxJOLTl+wlIM1l0/S0C9X3Sckg1wOzaH25YlYwe5PW+aPegA9/qOCrLOXOFXuaVS2T+sI0CHLfF4MHy4af50TvAlmwhOeypg3+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BM21PPHOWLLe3mQuLYZfM29kOoYgcronPt2yuwfzGcc=;
 b=uqStGEsbPM0EiANxAgEpEBVfATCeBpODzIWNP8UhsckeMyMeEiY78RB8fA6wsJmLHyztDo+3zZn13f5cv9Jpl5Ff324GJ4gmNLq11vY9CyN1LoL+j091YGkfRPP6z0IkuPnmZILU4DNUyMewDVtAuemmB4SJt6GLM6ahv9LEjv67RaIKv7JDy5LcS1HwhEOFrfT99Abm6V5a+EFiKplY0gelk3FZTqTuDOIks11dnqKERC0UIrOQfxh6yOgLhgq3MC4bWn5bpQ2BcH7r0vRHWCTu+8c2le2snB7e9appB/PrzsG9TgolmgtarCbq8IfJjCk473E0uLqyeAVeAJfelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BM21PPHOWLLe3mQuLYZfM29kOoYgcronPt2yuwfzGcc=;
 b=BzONUPw6BZvUPCd14amijEu3D1dDHPfLLKtdTARacX3GFAriWTd3TDmieMkwDALa03fQcJywNWMrofxH9GTYFD2GZXjvOeKGsOAZbtgHLPIHKdU5vRGFjEEJtRqy+VdJwvhOPiee6rzERuW4F16iyp3db5LwYXKnxI+oWvzT8sXZz/ktY+e0teE6i6taUGyh0ddO2XEgcddCzvC5PT8fQWQNN+NFTDYf2QUokeQ6W04FfVtbThtIU3GUk7g0vPc4O0j+9dLBwgHJh1UYDZ0FBMTh+w1blvAkbpzMYGLkB//dsH3V0zXY9kaKw04oEl48SXG0zv3EagJ4rRV7Vm1UwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8889.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 01:53:05 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 01:53:05 +0000
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
Subject: [PATCH V7 00/13] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Tue, 10 Mar 2026 09:54:13 +0800
Message-Id: <20260310015426.365675-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: bacfeadc-4db9-420d-d683-08de7e47c55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	v2Cx1bn8rRZXnIPMBC9hPZM/w/H9RAS9lZeGBIklvnpCHmG/A5TmazKBkrudFCGkU48byXM0WKwSt51MlCcbYLhIr/dByQRXLUdr7DEIln2EqvMZfwGvfVdgZVTz/Eb7/iwhqZJzzOnYqVSsjKbr0OPpfX8W11UTnHdExXj7pyOPHmaaXPj8sIHbErAKP4rL2/AWSrYT5nSLOhCcoqZXVLIG2kc6kIpCDOYVN5uCQbg/0KWUhDPEyPVHEHD/ZSyfg5ljhXuWIAwAZUNn8cEGUW/2Am2V198ySiSWdtdu24QMNjVhdGGqLc/x6ErulY11aTB/R5nery3lQR/jLPgz2QMbwMIP35rGxf2N3Y9XdMa09UhqbSsovVzLDnhGtRosXv26xRT85CVVV+/XVAzMzVFQb35LG2c3VyKWmoAAZZYJAvglV0fEZECbtwh9BgKfTWqvB/GIYGcMVAO2ZzCeiu2nmp6XF1p5bf2bFWH0rW/jms4ghTjmdkA8HFayuPo1MhHkYUzVVrA7Qp5Mb+EfVKQl+blzLWos/ZfvzLAXBsy369+ptYrsg6FRTQrX962hdotwoTXhqVAfmQlGgHLgVNpN8rBoMuVQBxFe8/Ul1kED9CT873Kvh0bHRpEQ/3ioqaF/dB9OUt8YkCZDzzxT6koWNDtGpTPgRl0peMmzRVvjm0LAQtJYsu6jFRUFphstvRCGFKB4kKEJdzetiLNVkcWOzy0vncwQb9TeC/+pvoLUnfBanSIS0rYwKkZSH93Vnf4LandAK838uj3+W8gscD554mo7ZmVkjIsb9ZMfxYZTZIpHCTuxjtmnEV78Y8sm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWNSS0lXRjdoMnZWNEt6RVRlL3MrRHVRR0l4aEd6T0Zua2pHbTRGSDVITkJX?=
 =?utf-8?B?UzVqMTVCeVFULzFKa0ZialBzaTJzYmpJMGk3K1dWM0ZQRDBXUEJHV282QkVF?=
 =?utf-8?B?c0hxYVFxenRySzVQSjYzRjU5UGNvMVdIQXpVTUptVFo4dHlsQTBDeWdWQU50?=
 =?utf-8?B?bVlCQ04wS0tHWFpUOUpLTXdiQlhuN2k3TGx2U0RuUjNXNmpYZTQvcURpdUV2?=
 =?utf-8?B?VTJlS1NCcUNrV21sOUVHYnVRL3h3ZzgzK2dFUkI3MVRHbFdaWTUyKzgyM3Bw?=
 =?utf-8?B?VlBRRHdyV1F6ZVFqaktHNTFvcW9VMmowdW9xcU81clJZN2tCR1p2ZGJoMHMv?=
 =?utf-8?B?b1JyVGJGcjlNNzNrODloUmlYcGdlY2hxVE8weGxlTUlLc05aSzVJY1FidU5W?=
 =?utf-8?B?UUdma1VqcUg5NWphNEoreko4MUtBME0rZTJlQS9vZ0NsQ3RSL2NXdFROVVlZ?=
 =?utf-8?B?VHJEWmozY1dtK3ZYVk0zT3M5MTdHVWZIUFJpYWVlUTRjUURRTEdqSTE2SjJV?=
 =?utf-8?B?UG45eWFxaStlK0RwR3EyckV5eXdsdjdMSG5Jb2JzZmxYZ0kyeGNrd0pLMVJr?=
 =?utf-8?B?VXhKcldoc3Eyb1dCRlFISG1Lcnc1Rk5xRzZ1dkVkb3cvWDRuOUozbkVXZkZQ?=
 =?utf-8?B?YVJOMHp2QkdtQkYxYWE2Q0JkT0xndWY4QTdmQlUrMkZtQVFlVzFCNFF4dm9h?=
 =?utf-8?B?ZHJ1VGR2Q0tuVTY0QjhvZE1VNHpxamdXSkpJSXhCNUhodDZXY0hIWDQ0bXN3?=
 =?utf-8?B?T1UxaW9RbU5JWk9SZzIra0h2Q3F3bFlLb3BlaXlUMWUvb3Jnc3p0OFlCczBx?=
 =?utf-8?B?c25DMnVFMmtJT2UvMnhXamo5cmhUeTRxdXcrQlQ3Y1NnSVUybjdTeFBTcG1W?=
 =?utf-8?B?c0hMR2dYSGJwcTkydXpDMlFoemRjdW5kSEJQdngrYTNOc21FNmsvTGJJaEl4?=
 =?utf-8?B?bDlucllncUR2SGhabkJGR1JaWUI5eTRSdTNmbmRzNUl6Q0VWc0RGeXRPcVVa?=
 =?utf-8?B?RmZURWQxV0ZkMVd6YU5GTHVDVmJKajRub1IxaFRrUCtIRGZsa3RkaWxXT1Jk?=
 =?utf-8?B?dm9STFRQMnZtOVdWdm52TTA2WlZadmxqQkFST3RSUkdOOXJaRVlFUnNJWU1t?=
 =?utf-8?B?SHNTcnVBc29iRWhDWDRZTXJQRzYrOGN3cHBHNzJZc1o1Q2FvazR5N1o4YVNZ?=
 =?utf-8?B?S2Vhd0s5dXlLRTNySi9DVVZod0tlT1pXRkYzVGIxNXcyWjRqb2pnTkNvNmt1?=
 =?utf-8?B?TlI5L2ErWDQzK2ZEMW1ETitBbjhPbVpWWUd5L2FJbWNDREl3WUJtdThKNmRW?=
 =?utf-8?B?Z2h0R0N3aDBlenVBQk9wb05pQzNjNUdhYk9Fa3NrVGN2c0dBcmpQbFJlTW5o?=
 =?utf-8?B?dmVFTUJSampIUzZ6WmRLU1pVa0tGd2oyUnNqR2NHRTBWVUh0bEVTTWlFWldC?=
 =?utf-8?B?RVp6WEVuSHhCa1h0R1dMZGJIQVd5azNvY0J1b1lTemkyY0tRVExJa1BldzdW?=
 =?utf-8?B?U21zbUhNTEc5WnJLeEJCYzZrQldjaDRjaGtjYzZzOFNLcU8wdVJJRGcwTmY3?=
 =?utf-8?B?blZZRWt5MUdNeUcxNXlFeUM0ZEJjY29peExqSTB4NStlcGJaWDJLVkpNbFR3?=
 =?utf-8?B?YXladkxHSlhGOXNncThhcEFrOVB0RDdIaXEweFM1NFl5aEVPZTlUbWN2MDJX?=
 =?utf-8?B?Tll1VDRmaFFZR0U0SXFQR1F5aFFPdThyeTBjVVg5SDBjeVhmbWtrbVcwU25x?=
 =?utf-8?B?Q2VxcGxhWVZPdVRxMWd0MmpUUzVaQ2lGRVpIUWxWT3k4NjA1ZHdlQU5FWDEx?=
 =?utf-8?B?dVZ1TmdMZXBMMENNTE81VEVyTzFYZFNQd2JzYzdmOU9TZWNqS3daL1JacVJS?=
 =?utf-8?B?VlJZWWl6Z0xBWnFmU3MyYmtRNHBRUVhndnZpMlNMY2FIYmdXeEtUa3JSSkRy?=
 =?utf-8?B?RHYxWk13c0hBc1ZxbkdlS3doTHpkSkZLRE9SeVBYQ0FPUTV0M09wMHA0Q2x2?=
 =?utf-8?B?RTh4ZkZkUy95V0hxYmdkTExualViVWxCMGgxTHdjNkJZWENRNXhDKzI5bUdu?=
 =?utf-8?B?VThDZ2I1VUJ6M0kvZGl2L3p1dFF3MnZqeFRaLzJHdWN2cDBraDNHSjkxRE50?=
 =?utf-8?B?YVpsZzM2OU5qaW5BVjNhYXdDenRjK09CZGlPLzQ0SnNway94U29vSmdjMVNu?=
 =?utf-8?B?dU5uRTVLY3pIT1VoKzZHa0s5ZlpKZzI5YlEzeUZYT1RFRi9YV3NYMjJaWFQr?=
 =?utf-8?B?YXZxSUhIdmRWMWNnRlNRSllrajJyVUU0L3h4S3doVS81MEJRRDJKMFNJMGRU?=
 =?utf-8?B?bVgzdlRrM0c2TCt4K1Y0VHZDKy8yTHg3N1NLd2VuaXBpTTdveStxZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bacfeadc-4db9-420d-d683-08de7e47c55e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 01:53:05.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvE+R0AxTSoLHMDXmbbDnFbboXuRi1OXaLrwTqmc9JtL/VRREt10O50Rf2ZcAstPKpnOP7jT/3vjlwhOznktvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8889

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
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  22 +++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  10 ++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    |  22 +++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   5 +
 .../boot/dts/freescale/imx95-15x15-evk.dts    |   5 +
 .../boot/dts/freescale/imx95-19x19-evk.dts    |  10 ++
 arch/arm64/boot/dts/freescale/imx95.dtsi      |  22 +++
 drivers/pci/controller/dwc/pci-imx6.c         | 129 ++++++++++++++----
 .../pci/controller/dwc/pcie-designware-host.c |   8 ++
 drivers/pci/controller/pci-host-common.c      |  59 ++++++++
 drivers/pci/controller/pci-host-common.h      |  15 ++
 drivers/pci/probe.c                           |   2 +
 include/linux/pci.h                           |   1 +
 28 files changed, 425 insertions(+), 28 deletions(-)

-- 
2.37.1

