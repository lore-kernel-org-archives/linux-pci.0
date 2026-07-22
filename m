Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625636212F;
	Wed, 22 Jul 2026 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704054; cv=fail; b=XiazPFSU+xpkzWu6Fc2URUmUhXiHq7lKimNeLAqa5fiKfnpGZ7VQDG8gsdzwik1efrMOODLZXbgcR91s49iVo6rYPeyb677LzUCU7ryZ9X+9gZ8/vo7NaJtbRP1C2S22gfwVhAm/idiBXqJR/7aPNgcRLP7auO/7Hv8L0xmMPW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704054; c=relaxed/simple;
	bh=wcj2AmD6ZzpcXY0L/BcjQmO929BjP6kfD2o3Kqa542A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Rg7KZoaRdyIHGv8yTP/VvMw4I0k8055mnCylQtPJm2LrIY0sW+5toGKDOZ0oBJYPl8k2rfu8lIyStGdzXCJNNrUK4nTYUiUUPTCei+14fXzg3Tu/wa47hPlLTJ02DXHmHbW2ANl5sjhduk9iDYsaupRqDrU2oGfYPe3mcTG0QSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nmts4jEJ; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nmts4jEJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOANiBKORjLxJ9SLLAPq0PWFK3kIfpHrZvI+DJCqcPDnGumZ6UDRw7vPhEQPipvOuUcW6P3VtX5z8jCzsnjB8uYdcyVn6X+ko90sQus2BBcyIWadVYvWD4neI1CYlOu6sDUV495xOMpJuXgspWGEg8yx7ujWComWvrnZuWykNXajLK5tQXSl+ssfmzm9H7+lP7yG8rli1awlCyLilpaP99f6CSgW2JfQpfE1Y3SIXpsONy+pgLciy+wEiJpBoMt4b5567jxKmGcIO2+BRpr6GXyrRQukalKlmm1KU5WSBu/S/M2uKwmdBb7lv2iSCTJpBajfhKmSLfGBRplk9UkOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/i2h3fXqCKYIETEcTeDcQ3hXjI3p7AUtM6QhRAHkXE=;
 b=W8ml8ODWJUHXDsussCSb7VJ5azP7L6EwCFzTysaklF8tAaa/eDudLRkLDJoV/HHX8n4jes0iklYvEcF62HLTjW1xsG6ile+awb5zAVYBlHlrG7ymQL437OwdMnhAtezUsyA1VZZPe0bDuFcggInzwcb7vC0gzZRZQPSjBB/zz6wh7SaINQ3xnXhf5B/lyHYtMD9+5aTKadbCnbBzt2FqhH/N0gnEt4AaMWDlAQ8qwhVizx8/aa3EXgYoT5egvh8LXcKWF7B7Gvb+767d/cHct8dPgpUWh2XSS9sYLq78sFlFWiq7BXZWB7llm6KHOiyV7sqzBSZErlARVTW2hKK5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/i2h3fXqCKYIETEcTeDcQ3hXjI3p7AUtM6QhRAHkXE=;
 b=nmts4jEJ/S837EjOqX0BdxUzZf9tBLuijo8I7bag0ldc+FGBDv2L9Qy+T0bIEobOYK06Ihyw1Ok/cYBJqSxDpme0u8gZp1rk/VRBkr/32T7PXtR/GClyWgs3r5qW65FClEleQPbRFHDFPfVSV1yG946YWS1AVPVX0gy8ULsLpaK3u/FPIIWdfLuuuFWHLIrf6eMyF58nMNfyw6QUB80jDowVaQIYieXdKhqJy8zK4ncyYrDM2QlwacdvFw8fSfDX+EYRaVCk3U3n09x4Yd33TNja1Gn3RF4QsGMLi1ofWpp/T7zgpc04CAW8uCEXmKfDdXjm5SG33zQgBuc653Hruw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:07:27 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:07:27 +0000
From: hongxing.zhu@oss.nxp.com
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Leonardo Costa <leoreis.costa@gmail.com>,
	Leonardo Costa <leonardo.costa@toradex.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4] PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing
Date: Wed, 22 Jul 2026 15:10:30 +0800
Message-Id: <20260722071030.2504711-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::11) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|GVXPR04MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d24d209-4be0-4ba9-728b-08dee7bfe34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|23010399003|11063799006|5023799004|56012099006|10067099003|18002099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	buDd5ctUjlSGNlpYLTir52srOTFjtYWARFdxZ49yfrzPZl9IUvupSlCn4v+fET/joW1Ktlq/fUdNY4knVPcD+/8q1HyVfobApMsxFe45RSwDeRgN1R8LJMH0jkpIUlV0oCLxv3f9pXVAapoq2PNPiwK8TedSPjQ1JVA9GvALkv+oKg+A7zBXtosfYPXSg6OL2pI6PPT7Ghrxtbg9iFtHov823ghfPRDCHrKEPmQFnBJptZa9+2oovwCyMYAqPZZXqaMkVeU1/9LyHBDqblIsGk2u/LBNg6dCah21rHZa9wEQwizZ7YUR6GNjaTzU3+tWfh1Ev9nbgysYH2bbcPZTwxCPcTW0Tg0OMiB/0X9AzuxJJCehkoRqtrbwi6u5/fA4bxFVOA/rK1Pu4mQnD3ZMinOLCQB+SocO3G7b5NuemlfXl7rN7r/9OQs5OuMYd18ZU2JAG+7wySHG7LOgeocHUvxnLUmoGS/Crl6dAQnlgx+K8Md5VH6wwJX/eeWFT/J/D/rlYgLElObloVlWBefvlcD4lAOvSCSC2NToln+UrRb+UkJTVjYNG/AjnOfbDQYNOYpsQqT9T9hh7nXj5MfzVIe33MrQb5QinU20JWwdIaI8+9R+/4oVVVLi4J8iE1Vw5tz+u/XgwfKlj2or/4dzZ1DoMj4HzRAsbyWOz3QdDm9+pRYk9ORs+/lBfTctS6m122iJvgdnP58N47gV07TF1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(23010399003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2FkeG93aVkwaHZMc3JBdGpSdlVsZmpiZUFNSXpLWndpeTZDSVhDbmdVU1FV?=
 =?utf-8?B?TlpPZUpyclpxUEFyUzFDbjZFNmNYMGROU0FvZjhxeTdiNEM4ckZPZTR4V0c1?=
 =?utf-8?B?OUVBd2I2aHNNb2t3Y0hnWkxwWlZ3emlVVTB3S1dkeHpnQjlRQm9pYWkvU0dY?=
 =?utf-8?B?d2pCWGpOYjltbmQxZW80eEtoTXRWRjlJNG9aMXJqbFBUNDFYZXV1S3FXUmZG?=
 =?utf-8?B?VllCZ3p2Vkg2WW1KNzhNRFJ5SlZNd2tOTXNPOUhycFBWT2UyeU5FejdMbmQy?=
 =?utf-8?B?ck9lQ3dRdEEvZ1d4MEN0OThCV0lNZFpvQm1Oc1BSMittcjJXK2Nkc2Z6Mjly?=
 =?utf-8?B?OHVCUFYzTTFtb0w5TXh6a1pmVXJpQWFqcFRudkJhclgvWTArQ01Ic0pwTm5u?=
 =?utf-8?B?cWpDZy9nalRBV2p3MzN4WGF5N3E0L21DVm8xUWcrZEJadVdLR1VvWVBONTF6?=
 =?utf-8?B?TzQvcXpROCtRWDRmaHlZbDVZVTZVaTU2SWxENC82MS9iaGttK0xpdndlN25i?=
 =?utf-8?B?Y0c0OTRscFJ1aElwd0dWWXZWOHdWY09ZaXgvZERubVRidGNhd3FjQ2plMGhL?=
 =?utf-8?B?ZWtBTG1oZ3BIa0dKbTlCQitURFhScm9wdnB1RG5BZXArakQ4c2JYbDg1TlJB?=
 =?utf-8?B?aGs3N0IweWo0MmZ1OXFJMHJ0aVpSSnl0Y1VMUlBSMjBZWGVUZ1Y4djB0Tmdp?=
 =?utf-8?B?Sjl3UXZtTlQ3UHRSbmF6K0djV0FkUGx6c0hPNmEvbm54dzhWSmhWZWkzZnZQ?=
 =?utf-8?B?OWdwNDRwOU94anhtcUhTNDNZTGllanFvOWllbzF6aU56cjNnTm8rM3h1U0ZT?=
 =?utf-8?B?VmhweVRsQ2dmNWxraERvK3dCcWNwTVlOSCtGWkZMRk9va21iTmNKUmhuakFM?=
 =?utf-8?B?M0VkT0dUYWFrTmtZY3hob3Q2OGU0Zmtib01nMmtRV0xYYk9SRUtqNWpUR2kv?=
 =?utf-8?B?QWtBYUFKcHFhUE54TDcwQkplT0NvZDA0OW1lSEhkTC92aEtGd3FJamtuR1FI?=
 =?utf-8?B?aEZQWE9IbmdWUkd3SFR2M2tiN2ptMmU1L1VsaHRKaXJORHJFSmJMNkhXWWhp?=
 =?utf-8?B?SFo0YVQzU1dXY0xuZWFUR1ZwTzZ4TWUzTjNmdi9mcFJQZUFZSEVjQTYwN0l6?=
 =?utf-8?B?a2R2Szk3ZG9CSE5pbnpGWFBIZzBVVWlkb3Z3aUtGK0Fta3ZON1F5Ly91Q3JP?=
 =?utf-8?B?OE1KYUJpV3MydktRazBmTS81RmJranVKRmVvMWZjNGxLMjJLZjVjeEozSnZX?=
 =?utf-8?B?clFheFBYTEliRmluRzd4bHBNeVMxVVc4VklwTXgvc3dQY2xuWVBxNWxnR0JF?=
 =?utf-8?B?UmFnQ3pVdG0vQUdKNW1teXhSU3dZM2RsdXJZMW15bXoySnpIczlBR3dkZHMr?=
 =?utf-8?B?R043MGloKzY5UkR3eWZhTlUrUjFGU3ovVzNHSFVvS1FRR21MbmlqQ3JsNTRq?=
 =?utf-8?B?U0dveW4xWlFrSXVvSDZZckxkeW92RXF0NWU3N3dUS3BobEtEVmFPSWNLNEQ0?=
 =?utf-8?B?c1VlMjF5SHJKTHExN1FzUVBBb3NJR3lNcEsydmFRZ2QvZm02QXF6MTNMRTl5?=
 =?utf-8?B?aEwveEhDOGE3U0o1TlpSY0lMVEVkOVdOUi9oVTFCcVpNRldVSGZ5L1pyRG8z?=
 =?utf-8?B?VGowOXJ6OHVZT3FCckUyVi9zVGpyblRlNDRicGlzZ0lYYXVYWU01WmNDNjY1?=
 =?utf-8?B?MXZLRVJ2MHA3RS9VaC8rUlBEa1NyUkY5a2Zmd0NUeWxwZVNwTm4wRDd1djhR?=
 =?utf-8?B?Sld6aWFSM0ZhSktQeEh0bVgxeTd2RUgxUWw2cVRyRmt0enlEVzA4SWxaOTZN?=
 =?utf-8?B?NWZYUmk5aWJVR2pQVW93Q0JkeUVHNHF1c0NmWlJ2Ty85U0hURmtGZDZOQ0lC?=
 =?utf-8?B?TlpPWFl2NzR0emROUVdGU3c5SXRVcDhjM2xIRm9PZzJKU2pMNjVPUHNpUW9z?=
 =?utf-8?B?RXdIS1hrUmZldGYvR1c1cmpyeFRpSG8wR2l1Y210ck55ZU1hK1dvNTFjb0F6?=
 =?utf-8?B?bkg3NGRpUjhxVGwwZWdqTC9HbDNkNi9NWDJJcmdhL1lqT0FmNDhja3JnVWJ5?=
 =?utf-8?B?dTBWdDJaYWZ5MzZHeXIrNlY1UU02aGt3UnFXakJ0Um54Y21mVDR5MGZQcTRh?=
 =?utf-8?B?K0hEVEdmRjhOWncrWTNQcWZIWk5ITXdocXVWZ090a2ttUWxoWFFlcWFmeGVM?=
 =?utf-8?B?TUJHZ0tCUWxPVUtleEtlMEVFOVZVY2VVU1ZVU3JYd1c0anIwQ0JmeTZRWWhw?=
 =?utf-8?B?ZmxBZGJUNm9XTDFNMW5YYmR1MGt0SXZSb0hkMUtIRDJXaWlJTDlJMkxZNjNi?=
 =?utf-8?B?OVQ1T05yZXV3TjFrNjVZWHQ5SzE2d3R4c2hJY1VFaW5iR3h0V0tlNHowRDlM?=
 =?utf-8?Q?JcN2CMTSx48TmRo6SqckWoZAAHU6RWui32o39?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d24d209-4be0-4ba9-728b-08dee7bfe34c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:07:27.6656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHihtgPWHGEVW0QuT0RoQMmpF+hId+Hmv+CXWYxP+oyndwLyt2ODrhKMxHdT268C5rss3TWK6CXVg3of+j2lXkMvBTD8Sn14GslpVCEmda9DhwYYaiEi9J8oyl0BQ+2Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9952

From: Richard Zhu <hongxing.zhu@nxp.com>

Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
introduced a boot hang on i.MX6Q/DL variants by reordering the
initialization sequence, which exposed a critical PHY power control issue.

Root cause:
Before commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators"),
the sequence was:
  1. imx_pcie_assert_core_reset() - asserts TEST_PD, asserts REF_CLK_EN
  2. imx_pcie_clk_enable() - clears TEST_PD, asserts REF_CLK_EN
  3. Link training starts with TEST_PD properly cleared ✓

After commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators"),
the sequence became:
  1. imx_pcie_clk_enable() - clears TEST_PD, asserts REF_CLK_EN
  2. imx_pcie_assert_core_reset() - re-asserts TEST_PD, asserts REF_CLK_EN
  3. imx_pcie_deassert_core_reset() - does NOT clear TEST_PD
  4. Link training starts with TEST_PD still asserted ✗

The reordering caused TEST_PD to be cleared prematurely in clk_enable(),
then re-asserted by assert_core_reset(), and never cleared again before
link training, resulting in the boot hang.

The fix requires two interdependent changes that cannot be split:
1. Move TEST_PD control to imx6q_pcie_core_reset() where it belongs
   logically with reset operations
2. Remove TEST_PD manipulation from imx6q_pcie_enable_ref_clk() to
   prevent premature clearing

Applying only change #1 results in device detection failure because
TEST_PD gets cleared too early in clk_enable(), then re-asserted in
assert_core_reset(), then cleared again in deassert_core_reset(). This
premature clearing disrupts the proper PHY power-up sequence.

Both changes together ensure the correct sequence:
  1. REF_CLK_EN asserted in clk_enable() (TEST_PD untouched)
  2. TEST_PD asserted in assert_core_reset()
  3. TEST_PD cleared in deassert_core_reset()
  4. Link training starts with proper PHY state ✓

The previous delay in imx6q_pcie_enable_ref_clk() was a workaround for
async reset synchronization when ref clock and PHY power were coupled.
With proper sequencing, this delay is no longer needed.

The i.MX6Q/DL PCIe PHY requires approximately 120us between TEST_PD
de-assertion and link training start. Add usleep_range(200, 500) in
imx6q_pcie_core_reset() after clearing TEST_PD to satisfy this
requirement.

Additional changes:
Add explicit imx_pcie_assert_core_reset() calls in error paths and
host_exit() to ensure no power leak.

Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reported-by: Leonardo Costa <leoreis.costa@gmail.com>
Closes: https://lore.kernel.org/lkml/20260629143439.361560-1-leoreis.costa@gmail.com/
Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
Refer to Sashiko' reivew of v3 patch.
- Adjust imx_pcie_assert_core_reset() in imx_pcie_host_exit().
- Add the delay explicitly after TEST_PD is cleared, since the PERST# GPIO
might be optional.

Changes in v3:
Update the commit descriptions to address the following items.
- Clarify the root cause of this regresssion.
- Describe why both changes are mandatory required to fix this
  regression.
- Justify the delay removal also.

Changes in v2:
Per Sashiko's review, invoke imx_pcie_assert_core_reset() explicitly
in error path of imx_pcie_host_init() and imx_pcie_host_exit().
---
 drivers/pci/controller/dwc/pci-imx6.c | 41 ++++++++++++++-------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e25f938eefe23..c94b5e991aecd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -681,21 +681,12 @@ static int imx_pcie_attach_pd(struct device *dev)
 
 static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (enable) {
-		/* power up core phy and enable ref clock */
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
-		/*
-		 * The async reset input need ref clock to sync internally,
-		 * when the ref clock comes after reset, internal synced
-		 * reset time is too short, cannot meet the requirement.
-		 * Add a ~10us delay here.
-		 */
-		usleep_range(10, 100);
-		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
-	} else {
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
-		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
-	}
+	if (enable)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	else
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				  IMX6Q_GPR1_PCIE_REF_CLK_EN);
 
 	return 0;
 }
@@ -826,6 +817,12 @@ static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 
 static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 {
+	if (assert)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD);
+	else
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				  IMX6Q_GPR1_PCIE_TEST_PD);
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
 			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
 	if (!assert)
@@ -836,11 +833,15 @@ static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 
 static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 {
-	if (!assert)
-		return 0;
+	if (assert)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD);
+	else
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				  IMX6Q_GPR1_PCIE_TEST_PD);
 
-	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
-	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	if (!assert)
+		usleep_range(200, 500);
 
 	return 0;
 }
@@ -1451,6 +1452,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 
 err_phy_off:
+	imx_pcie_assert_core_reset(imx_pcie);
 	phy_power_off(imx_pcie->phy);
 err_phy_exit:
 	phy_exit(imx_pcie->phy);
@@ -1470,6 +1472,7 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 
+	imx_pcie_assert_core_reset(imx_pcie);
 	if (imx_pcie->phy) {
 		if (phy_power_off(imx_pcie->phy))
 			dev_err(pci->dev, "unable to power off PHY\n");
-- 
2.34.1

