Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C27E332907;
	Wed, 22 Jul 2026 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784689818; cv=fail; b=laQnJ1xM8rhYr7cmVRp+Cw0tr9/O5Ae2lV67X0XIcD9+Gzym8tqBXUNtceV6ws1ymf5LUL49oEMKyKwcnuq+GaY9Xf+cqT3WUPK9OQeQc4vRlYepiO277HewMA41yiUNuWlbFT5gTRD4YT6WNSXzMtksJeijM/Njvg4/jOYtGQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784689818; c=relaxed/simple;
	bh=XbhmJU3gvhycAyee+F8iRFIXzrntBjKHO+jfcxBAQ68=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OS6lOu5ND4q54n9dpTDufPnXCz/TbrIYlCyiQfMHMvuYhRGYvFPLPFMloTXjrHZHpG1RwjEOCrdpmVd04JZkOMCw/YTk+M8Ev3LW8HD6jKrHA0ONOuwLfNK2f6sCSHm/43Ao16bFxyllW3JRBRS7XDvgCbV41Gb5F55F9NSGUX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=yMuRiVgp; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yMuRiVgp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwMjNnm2SeVa+eChYNXxu0A6BsR2/pZsdX5j4IrhrCzRif3dhXdA5jQM+yFQ2+hTIHTVGAzPl0A7rZEl1ly56fLMvroPXU+4FEs8wRONC2vsN7Kk6mM7rV8rRtnc42vgGjOf+iuxdcF4jZs9lYZh3l9SYhWYsQ4xSeS28UhHD98AeFs4zxetzsNFGbQB6NKwA9aH8UvXwvlY7jYjql2gcvA4PxDvWMmUYhYw4Nmw+Bw3Pa97/FI3+AN+6r4RE3hPp4LJyNOBrjC1Joh9H3koADZQgq99yGF/RjaeNcIOxvQUQntzhbySd3A9KJkM43U1VXdfzDx1ckjnSl3ybq7MzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20Wohngl3c2We6rvBitcIoVuG32HCrcoKQvwdDGMzA8=;
 b=kMslhzuDcWqrZjagFVPzSS/Tb0otbVa1LVsp/EWSRSj9XKtwHrHoHg2hRl7SKqhjQXmLC7tHWy+AXRaMuYe5eeClza40kQfkEOXbWSmxoGSfrb2RzQ6lICHKZ0o1KvTrQVmxioM/vPpGGA+EB1iqX9IHn8y3mVs/RQqG35rmDHubBWyzlGZfzrMGtP5W99W4hxAhXy6iU6jrI9+41pogzIlsdQo13ufP+1VoMJu18wjyQ4C1dY+PPlbctasHmtxilXdt9tTygntYNon5kPvZZWV0tRfEuxV10Sh8hWS5DN/tUGi84jIHYRbX1EuXw7QPYI46OROPfo6jBI180w+BvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20Wohngl3c2We6rvBitcIoVuG32HCrcoKQvwdDGMzA8=;
 b=yMuRiVgplDO7bziqrtIELklF4ctYck3/qcsQdktIxiRNj4hI6G0gwvV6cnbtv3Hr3VQqgGOh5Nnj++ZWhjOFsFqjHl1xHAvDFfxEcTwklckZY4Ul/8m1RA/7FAqzDUYwD/KlGF+FWTMIQzNP2lJtmyqrzbYyXNiGzzLcagUeRjmBU0Kg+rXCp84J/sTBhfUgJwMi0bypPAuuQFuvn235TQQcDUBIFQqlrHV4oTAzPQ6gFle6mLdVctscx/7/kqWu7gSoozt+9bn1zskb8nwp8Kn0fJW8BSkFFy+yEbU3rR09lXhSsqWZuWF8QG4mq4Xm9BicXYT1IP8Cr7RuKruLvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by GV2PR04MB11884.eurprd04.prod.outlook.com (2603:10a6:150:2f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:10:12 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:10:12 +0000
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
Subject: [PATCH v3] PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing
Date: Wed, 22 Jul 2026 11:09:35 +0800
Message-Id: <20260722030935.2328278-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|GV2PR04MB11884:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fd920a-bcd9-4564-5f30-08dee79ebe7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|23010399003|18002099003|10067099003|56012099006|11063799006|5023799004|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	+cb0TGVavwLctqlPfBq+qm8KJ5gnEtu4eUkV4nAWfWk/Ny3ZHHuVTdsZoKGQOFgaPM1Dq2xiq4l7UQnaUda6iPQbpVWjHkkfcB6tzVABrPLO1toRaEH+HlYLp69R++zBABFdOUYcRl6KSFoXi2xIRwfFX8hobfme9DduNVX7WYvv9iVP7RMdwCcihbswitgEH4NPhFXyqu9TMPdGtWBF52qudC57UAl4iKocGGSlJDXKvZqOqL5t/bQyqRyfCLIc+VtPSbnMUu4upcfzuB/L8J1rtro7lIBB//YRda0bjfJakbQfOF6p+VqMoiKfPDBTVOsS/8IKXdsVDHPQLXRmVL5yVhSlApyocJlEMEqjL7ngMNKx+GmPMfJ0n2HyAzQoJdjdaIV3V3R+hYSKyNBvYlOyyF8GzvtGWfdQaCYKt3Z5dhVzFWBhsyDRjtywoeqToOvhGDtqxyUv1Jr6p4zMB0Wrq2PWsZ+qk/0gaVXz48CGb3WwIElpdL3yqop1F3GDl3jVEK5OvP6/KGZa2aXg0s9t1PY+5prExn455EXdw1k98Tgu+KUpfKB+cNXF5p82ul9Ef/ShCKoM3uZnQPoCTtqF+2rIRco/Dl3aSvZjaipoBtN/LRqtYfyeDMZrr8150WUDJ9fEBAZs5MSvk9fRV0u2oJYknNoOOtDBtdu9wKbDSlB6G+t4uGTf8/8DAL4KjzXknGgMbZ655af2yny/6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODJkTmQvOVJROUVIV3R2TmgrOWZmOThWQkxJT3lwdERLZkR5dkdSbmdlRm1L?=
 =?utf-8?B?UXM4akFObzQ3UTlXMFg0N21DZ3hleVhJVmpHNWRobVlVUDgwUzZDVUdvRlpT?=
 =?utf-8?B?QVlJUCtYdDB6a1RjaW10RnNKeklxbFpqdGhnejgwU0FUQktoTktuNytUSWIw?=
 =?utf-8?B?RnJ1amFDNmRray8yTmJFOGhva054V28zUnlrMUR2Z284aU9QMEZXS1djdDJr?=
 =?utf-8?B?c0ZvUVM1UytIYnJYM3JCa1BVWEpJK1dKTWhTdFd5V2pGRmpBOXVLTURXTWtQ?=
 =?utf-8?B?N3cyZ3hQTXJBQ0szTk1idDd5c3dIQ1pjdUJoMi81Y2pvaXN0eHVPY1BveHo2?=
 =?utf-8?B?OU0xWmk2RGg1T2V1SUQzTXhxRlRleDQ0ZUM2dHVzaVVGOVIwU0Z1OTVRaC9H?=
 =?utf-8?B?di9rQzVYTjFrcmt3MVFub1laQStpc1hyZWZ4VzB3Y1dxcUhZREZiWjFVMDk2?=
 =?utf-8?B?dFhrK0xMM25HTWw5Q2xldG9GdDRLTHM3dnVTQmpGcE9FZDc0L2FtNnY0UjhL?=
 =?utf-8?B?RVVKS1B6RTVhTTY2M2RLUU1nUzFlc1IxQmcvMGkyTGttMEZOTTd0enQ2KzA4?=
 =?utf-8?B?T0EzYkw2V3UwTVp1d3lvQlJGMmt1Wk9ld2RNZUJiVXJIM25JK2RVUmp3ZXY5?=
 =?utf-8?B?UVJ6aGdGckRPNFNFMmkvT3hVU1Izbml1YzdodHdpNmZlaDBEZWhPMzRjZUcx?=
 =?utf-8?B?ajB2U2M3YWQvNE5yMXVFbWRWVnNFcVNpUG5xTDBOZytlWk9NUnlGUE9uY1BV?=
 =?utf-8?B?Z2h6RWRKSjUxdGltdTZrNFExa0YzOGF5T0s1SUJCNUFlWU40MEhlWGQxR2Nk?=
 =?utf-8?B?clpHUEpLNEtSNmt0cENlRzFnOEVqY3hQRWZ0aHlsZUdLN2ZNeDlPY2p3ZEMv?=
 =?utf-8?B?RjRVdDdrcHBNYmpzMXdHdmFGVkRtak95NFZYMUI5a3duRnNieVJaU25vM2gw?=
 =?utf-8?B?NHprQkZMdlZFQ1pMQS84bUNLeTJCVG81OUlySnBvc3B1OTV2RnZ1bXBtYzFW?=
 =?utf-8?B?L2lSQ09qcmxoMm14bXdYYitXNFRHMDJSa3hta2s1MkNaK1VWTnRuNjFSTWlj?=
 =?utf-8?B?dnphazlQNlNFK0FHd0V2RElZNE4wK0ZNWlJxUDg3MGVOQVJsZE5xNkhuVllh?=
 =?utf-8?B?L1BOUzgzek1wcXloVmxERWVUSFI1ZjBteWlHSVZyR3ZUV0p6NXprK2Vwa0xE?=
 =?utf-8?B?Mi9YbFJxOWZTR2hQSDI2MWI4M0Zld0YvTktpaDlpallrSkxMRTFSbkFiUm0z?=
 =?utf-8?B?OFR1ck1wQ09jdTdSdG8xRWJsZnpsOFljRy9vdHFXZVRmdHZKU1VHZ2JNclhL?=
 =?utf-8?B?R3VvRjRvdndzOXBsUWxuZkh4Ulk0RXBnakZmUEMzWkxiODhtY0Fqb3AvWEVK?=
 =?utf-8?B?dlE3SnpDZzlxOEFMM0pqQXRWbVlXT3NtZUI5dFlBSmdncFg4VDlJTGFwcW1V?=
 =?utf-8?B?TnBsL3dPelc2R1ZUU2dPU2IwdUlSa01DV2RubUVIQjZBeXZSOFJJa0MvRFly?=
 =?utf-8?B?V3E4NmYyZmFYVys4cC9Gdy82K0xVWVIxRUt2TUk3TU0vUGE1VFduNW84WFQx?=
 =?utf-8?B?TE15ZHYxc2l3T0RZbmFHVEdldTQ4azhWbVpjSjR3dzJQMWJzT2hxOWREVlNx?=
 =?utf-8?B?VDU2V29CNjlVQm1sL2daUVAwS2dmb2x0eGg1Tk12dm5nSmtUTC85TGxQOWI1?=
 =?utf-8?B?RURtQVpmMVNtWnNZbnMvVkxycEwxSU9PdGdDQTVmcHl0ZUtHVzh2SWJLdGls?=
 =?utf-8?B?MTQ0NlVneU1MOEhnVXQyQTZqaWtjdFViMzFDMGdjZEVqYkJZTUVpNFQrazRS?=
 =?utf-8?B?L0NJaGgwN0NOZHVUb2Vac0U1aEp5ckVDSUtwMGlqSWQrZnRGYzgzLys0a3g4?=
 =?utf-8?B?bHFLUVh0MmxFY0traFBMV2FXdGx1TWhpNWpvbTBGV1JyUHQ5Z0VwYlRDOUw3?=
 =?utf-8?B?THpTVHVIUHZnUkxBK1FuaCt3Vk9YcFZnZEhBamJGWHlzemZvb01xdGtGM0ll?=
 =?utf-8?B?RUpvWFNGblR0K3lKU0JBckJTcmVqQ3orL0p0RmlaTmJJTlYzNnNzQ2RtS2tR?=
 =?utf-8?B?VzA4VFNnVWxQcTV1K2lPWnY1bmtNYmJQYTdFNlB0TWo2OWVWZ2lYc3JneHF1?=
 =?utf-8?B?dEwwd0FnZUZKNldrd2JZT0JnVWZHbjdqVmZQdDNmcjliMVMxcldUeHR4dXpz?=
 =?utf-8?B?WGQwWUxzYlhucFMvOTVXR1RhYTFMd2NYR3pWRWxkQVBaMUlqVWJnWDcrRloy?=
 =?utf-8?B?VW9RVmdmYkE4QjJyU0hlUFRjanBUZ0dsQlRIM0c1cjJlOEFZaVVheUhULzJY?=
 =?utf-8?B?di80Y1U5YmR4eTVXMExTdjNOYnV0WjRVclBIN3F1eEdkZTVtelhkYno0OGlJ?=
 =?utf-8?Q?7kc4UpqRl3P0ey09NioIeovjgfYGUS5+uQDjZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fd920a-bcd9-4564-5f30-08dee79ebe7d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:10:12.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVRjvtdRapJPJJhLr4dWGdPthJIvnXj8kS44mTEa1LhnM1l9uxk/LK3KyGMBkqWUB8WkfVJW9qq24JMM8mpQKUoI0PJXH0Z1uv73FbmpORXpT/LTgUV57BnAqcoPqX9w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11884

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

i.MX6Q/DL PCIe PHY requires ~120us between TEST_PD de-assertion and link
training start. This timing is already satisfied by the PERST# toggling
sequence in imx_pcie_assert_perst(), which is called after
imx_pcie_deassert_core_reset(). The PERST# assertion time is much longer
than 120us, providing sufficient delay.

Additional changes:
- Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset() for
  shared PHY power management, avoiding code duplication
- Add explicit imx_pcie_assert_core_reset() calls in error paths to
  ensure proper cleanup

Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reported-by: Leonardo Costa <leoreis.costa@gmail.com>
Closes: https://lore.kernel.org/lkml/20260629143439.361560-1-leoreis.costa@gmail.com/
Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
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
 drivers/pci/controller/dwc/pci-imx6.c | 45 +++++++++++----------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e25f938eefe23..45ab21c9769a4 100644
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
@@ -824,23 +815,23 @@ static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 	return 0;
 }
 
-static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 {
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
-			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
-	if (!assert)
-		usleep_range(200, 500);
+	if (assert)
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD);
+	else
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				  IMX6Q_GPR1_PCIE_TEST_PD);
 
 	return 0;
 }
 
-static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 {
-	if (!assert)
-		return 0;
-
-	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
-	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
+	imx6q_pcie_core_reset(imx_pcie, assert);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
+			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
 
 	return 0;
 }
@@ -1451,6 +1442,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 
 err_phy_off:
+	imx_pcie_assert_core_reset(imx_pcie);
 	phy_power_off(imx_pcie->phy);
 err_phy_exit:
 	phy_exit(imx_pcie->phy);
@@ -1475,6 +1467,7 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 			dev_err(pci->dev, "unable to power off PHY\n");
 		phy_exit(imx_pcie->phy);
 	}
+	imx_pcie_assert_core_reset(imx_pcie);
 	imx_pcie_clk_disable(imx_pcie);
 
 	if (!pci->pp.skip_pwrctrl_off)
-- 
2.34.1

