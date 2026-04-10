Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92812BDC0B;
	Fri, 10 Apr 2026 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788179; cv=fail; b=fRG3pzcw7rTGZoW2malzkpwoHW+gh3PWfZmLdJAiBw0GDCj6IFOig6QurO/6cB8tW+G7MgoXcIpgAEPL54j/8OiSM3fBNNAaVYTUh/qofXlAyivAE3qS7USk4oDX1tOm6gLLnwt5TYkMDTGU+Utm4xwUigpoyCT/jMve/rECovM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788179; c=relaxed/simple;
	bh=5qTS4gj+hbhLQa/oPerZ/Y8/Pno8FcF6ysRjAWiuvtU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=paDTWi4prSuwr7Ee71imPZW29alQqycCelcFPdpwnYVs3EsyEfiJVl1lthz4GPpE0d9CO8iQE0R42mLSfHCv61oGF1GJlu1J0u+wP4105+QyRKU1AXcQTqxtSDpaREFaFxOkuLr5BW54tf21okp3GYlx0z2z3n4lwNZJVvaQxh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lZYXaDkE; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lZYXaDkE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3u+Y6VPxeJok5ZyLwRX90rUs0axkGm1u6bFqSp8zz0Xn/z2ZHIqbP3cikUkK0l41MaYlkfIrDNLDQbXl95f0JsWh+SYN86mcw/O/nn2ZVnUXOOpUbrUi/wLJkG8tuG784OQDwoSF67hcxLFOmYth+fetqwjauzAIPUoaWYryk/Kby3Ss8QscmCd+VMltpToAfzt20tCtWYBazS46IKgv/TBhoJ9RvIOraQsj3KPHINNrRNpfAtKIhKNCVa3N4Zr/TuDbacUgR42t4jlfBRSP3DYy+9Y+U4PBS6wLj2Ks+ic/xa8DWHTzZnTLIqnoJq5QzB6w3d9y2F44DhDab38Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7eMdwNpWEaI6jZq9E7pLihK/e00FZc2PVZBTDuWohI=;
 b=GGCLFzdVnLeVnnDFI+GzVhajiihk+ePFYUsLijp4f0Yj/s4j7y6oyBZh9MaYGA/LtVJQg8X8B3yEd5jz4mV+gDq08pD362zlZUw8L0Jt8NJ3Dje5+vU7emNmEzm75uj5kGrpaDEAUIzgeMFcpHvL7R1AZCAhQxq63dd+eAQf2tM9kTnWUJ5Dh+/lBjqL3/Vp/4lE9Jn+2X6e+cAo0ICdsOqnSTODf6/lsVnRNhGQRPjCaDtCUQXD3on1Frdz71S8Od3nREfqb8KZhgqnL8e/6NfJ9aUP1jLYTTjXRP0m5zm0MuglUkGF0pZ+UFGSoIlXOvT46TMXI5BEZuzrvbONBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7eMdwNpWEaI6jZq9E7pLihK/e00FZc2PVZBTDuWohI=;
 b=lZYXaDkEKc8XahR7y5V7XWrmk8581IRKaRfNK8iuweS0yR2cOE+yDUo+CQAiB5EYFddytWNf3H1JiWkFtlty3c/0PjVrz7ns3DvMmZyIRMjdCTXPAIqUHK2yT62grz+0s6GKU2Fny5GxSakAc1UmxD+k2E1rWv79vHpH4w1DWGDFc6NkDotCMx3dj1Qa6HKe+/Mc6QdLfs9yISbka75lipI8cwsAtUAU9DHtTK/gnH48qKuToumVji6fybTzi1o0fIhY2v0gyVw+gWIs0qRQONaAp6qlKpkpQG3pe49nEIVh6AfNfX7sc8R1lnm2HmNeu8OeV5FeXEj/RBTcE6s2Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB9826.eurprd04.prod.outlook.com
 (2603:10a6:20b:673::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 02:29:34 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 02:29:34 +0000
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
Subject: [PATCH V12 00/12] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Fri, 10 Apr 2026 10:30:43 +0800
Message-Id: <20260410023055.2439146-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 81da5969-5359-410c-7f32-08de96a900f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZZoEmpmLKTe1D6/r9HeUFW0WEQ6/o+0JJT3WVkmII382xi+HjJ9OPfWyX60fi91VupZl85sB8ubHnCaKnOKO8TabrdNZQhhJ1qWduwhJDsOtOAV6hJlE9hn3XQZi1rKpaGlBztAyoVB+t/maR4D8BK1Q9vwu8X8MJf+xlkHtYhDUwqGDCC+p1lUIrh8vketg5OkTpH/wvJIPGOmZU1sHhBFk5kDS0fms2tG2EofP5He8ANy4u0HecVWLPhtnJbmkdwlS/I0A+voyTsNn6XBEiCFro9ZRqT2vzZiPzAtx89haskoa5fhgFiddIgAo+fDgbjjfEd6DuZWpsJVcovcUcVSXf9QBWqgwlGVK3Uzczv3vG9O0zT0sWa+5LkZ5+gPC0JYYGxv4oaCbVgarGsC+KfDqBivXaxqsf5EZOuF8qHSFR8AFbzBg1ddVs4VpQf7RvvwOYtoCZqGCRjOe+CK+KPggIQHJHlABQM7qSlTYZtnip/7PRNAeDJUSC4lTuLh5PnD5yARUudPXMheCFgCEosNLwje4TXmZbLHmUo+FGUqj3rlhczp4iaQCd1yJzXUpVyubXiMz1k6unqPPe8s9XuzS3+5qDgo6r0WFHq2PfaPL6D0VzbqRXpMXzGBQcvJX+RLd32/hAMTCQ/NsoozN9lWd7Ofb/OOtIBIv/XNQXOT275iRIXIVKgwUNfbB5SDG1V7TwzaWiv1vEdCdbmcEHEQ5SAgJ8FfbfHgWDtrXHBattGhn+fDMFVsGCI8FMESwhiNeohTBotq2Qd1TZ8rurojiw5xC4O6uaBo1k1PMNVebmTdLF2RxQvTl83Rxe8l+IcaxS94VCNLn2Iy4V914KQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDN2em1vVllwUlBPTHpybS9QYzNHcCttZ3pwcmZnRExGeUVqdGV5R1BRZlRp?=
 =?utf-8?B?amtLVDJ2MzZsaU1jQ1lHMUxnSklueGZuaDZGUm5UNmsyamJYeC9lUHFROFFD?=
 =?utf-8?B?dGFtMkdJNUZ1aC9tN0hrRW9RRnAzeDdmTDlZK1Jaa0NJWmJ1UzB3TU12MG5k?=
 =?utf-8?B?QXMySnJ1eUNXaU9iU2NsZEk5U0w2d0VzVzFaSjFYbHQzemxWNlUvR2FTZlBq?=
 =?utf-8?B?RXlIOWRKTDVrRFJDb05hZGttem1UT3RYUlM4N1o1SFdIMGhLdnJabFFkemhE?=
 =?utf-8?B?L3NjWEVmd284blUvd1dZOWVUaXQ1ZDNLeldJUFJ0TUJ1NVBhUTF3NUtTV2di?=
 =?utf-8?B?R3Nvc1ZLL0xoUGJhOElKUFc2MkRpQVVPYTRoZUR2NmRVV2g3MzR4TjJZNVdi?=
 =?utf-8?B?bDdnLzJlZmFjdEhBSVZ6UWhRU3g2Rk5hM3d2bno4dUNZeGhSTjFzRTZyU2tv?=
 =?utf-8?B?M01oZmNVMzZ6bGRCTXZSUkhqVFJXMjRLallDMWlGRHpqaWtic092ZE5aTStr?=
 =?utf-8?B?ejgwWk1PNUFmaW4yUnNjSHJ2WHlRa3R0VmtLUUdLNklLSGNIZlBwWWw4bHhF?=
 =?utf-8?B?M1FMVVZFcytkS295UmRGZjFDVk03andKS2FPN0R2ZzVJV3pwMUQ4ekllaVQx?=
 =?utf-8?B?RDRIT0JvUExQV3kySHhLemdhbHVJRmc2YmhCM2d5blBTWFJxclJGMHc5Qndv?=
 =?utf-8?B?dWlSK0J1QlVjVDRwVXY0ekhERWVXcFAxTTN0NnJaY216MjYzL2hjMTZhVE5v?=
 =?utf-8?B?cUZDL2hLSHJNVWZ4YVpXZ0lBZkc0dTBzYWF6RjlveFVCLzNJMlU0K0lVY0h3?=
 =?utf-8?B?d2hrTzYvTGh1dU1zQjQrdHc0WkhNNWZubDU0cS9JaWtRUnhQUmZwc2Z6blBC?=
 =?utf-8?B?bHFmT3BnQ1JHZm1EZVF1eVJST0dmNzV0UnFhblBvRTU1aGZNS1ZXZ1hjdFhU?=
 =?utf-8?B?SUpRVlNMaGNjbDRxREhFaExwNzNiNVpEMUtaN2IzRkJQS1RFMzdFbWl4dzlQ?=
 =?utf-8?B?dVRvYVY5NnlMdm1ZTkxFTFpTdnFab0w1cU13YU9KL0ZDcXpyL1JiSlBvWjlU?=
 =?utf-8?B?KzZmRzAvRlBLcGNTZFdVTUVadHA4VEFNRTE5Uk9BOEZsWFhPbzM0SDR5TVpR?=
 =?utf-8?B?UlBIT0htSUQ1VEtDNjFMMlUyNUdkcUk3UVhTM0gxYjJ3RzhPR3BsK0lZbjYz?=
 =?utf-8?B?aTRpNkhjSTBiOFp4cjcxREFTdVJOejVLTFVZdmh3T1JYcFJxRkFEcnhjOVd6?=
 =?utf-8?B?SWFRUG9JMjVnbk5GYXc2dFhzTVFLRG44SVRmWERwOXFDV0JIdXZzOWFPWm9R?=
 =?utf-8?B?VWs3OGpIUU9kTCs3YXpDRVRFN3FvUm1qak9IRGZobGtDY3h5Z08zdGdWYjhK?=
 =?utf-8?B?V3JaazA5RHlCSStOckNKSFRQWEhUbTQ4dUdmYXVvT0l3OFU1d3FRbE9pL2N4?=
 =?utf-8?B?SVB4ZDM5YzM5NmNLZ0ZrcFREWXBiZlhxZlo1eWNjT21oTktKbTNWY1NEM3pU?=
 =?utf-8?B?K0ZBVDhDRmk1VmRJbUpmMzVmWUM2dTh0M3dHZ1piZUZEbXJRTmJ0dTllbjBl?=
 =?utf-8?B?NzJCZEg3cWM2QmF5R1ZUY0t5cTdwOUpnV1FValBmL3lJelFvVzhiOWJ1TjVp?=
 =?utf-8?B?dElsdDRISVQ1YVoyYXFVK1pWaXBiNllaaUlzSzFESkFyOFdKZXlLVWRzZURq?=
 =?utf-8?B?U09wRDZoTncyS3dNZE11M295ejdQV2VPWlpHQ01aNkpYbkJXV3IrOGdlNVpQ?=
 =?utf-8?B?OUhqTmsyRnIwVUdVdk53Mnd3RjQzbmRWQk9rQloxV2FiZy9jdXI0WlNtMzNI?=
 =?utf-8?B?dU5vRzA0V05vWmZYSWJERnlEc3FxL0Z4RCt6dkYzVm1kVmgvYTluS21rdXVD?=
 =?utf-8?B?V2VhWjdDbFpPNnRVN01WcVN2aXdyeWFwb2VEclRBVDNBMmxaaTM4ME1OTnRW?=
 =?utf-8?B?bUY5YUdKb1ZJMWxidXkwOWdOSkRCeG5DWjBBR0JjTVoxUWZZc3I3MU15ZE0v?=
 =?utf-8?B?dEdHTXhtUGdTeVlSdldVa2VqT3oyRjBDRUZ0ZGFPR1VnRmM5cWFCU2xLeHEz?=
 =?utf-8?B?Zzh3b1Z0T3FTOTVRaG8wWnR3SStpZzRnR2RiMjJDK01oclFXbloreTJsYTVU?=
 =?utf-8?B?dXlrcWo1WlczVVRsT0FtWHN3MjV1ZWphTEZ4eURIVlF4UlRTL0lOZURaaVBl?=
 =?utf-8?B?U2xJQWwvRTdjWEk5NGVtSXU2RnFjUEd6ZTlXYnh2Rko0dElPVUNxUlUwbExx?=
 =?utf-8?B?MHUyTmgvUjBaaEdqZnMwMnVPaDZwU3JYS29OYWhEYUlwcnE2cDk5bVBBL0JV?=
 =?utf-8?B?RWwrd0xVMGszUjRLL0ZjYTBPb3FMSEFlUUVZZDl0dXBocGoyTmpQdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81da5969-5359-410c-7f32-08de96a900f4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 02:29:34.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzyJVdRUdJ8tCNv04WsSO50aFby4sHW6oDcFZBaXn1hB8tzQvzUKayoLUWhw7DrqSx6Al/URSrpMBSRTy6urgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826

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
 drivers/pci/controller/dwc/pci-imx6.c         | 117 ++++++++++++++----
 drivers/pci/controller/pci-host-common.c      | 104 ++++++++++++++++
 drivers/pci/controller/pci-host-common.h      |  16 +++
 drivers/pci/probe.c                           |   1 +
 include/linux/pci.h                           |   1 +
 27 files changed, 454 insertions(+), 24 deletions(-)

-- 
2.37.1

