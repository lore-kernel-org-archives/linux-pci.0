Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012055.outbound.protection.outlook.com [52.103.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4933B38C41E;
	Thu, 12 Mar 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306438; cv=fail; b=oAmPuEzEBD807gVDfP4zxBY6VN7UAFz1b0gJqrgFd8LZbayWpeis7X4ExtZnbcA3GCPrujrZPw4eDYbj81GER1/aP7Nu9dFyHJwPAWTPGQI+LtipjEgPHCZGhmVL242Z8pFOPgJwhTw6CC+759S4WkJXJ+YPpVaAyL7DyidsHok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306438; c=relaxed/simple;
	bh=qG9qatKLTEk3DNyN65jq2UvuMFi5IRUAXevIPJWyppU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ewseMkQSh4p/oVuyr44b0WVZB29lCMq4BReAwRi8PJsawcIyjnYpMob7OA2fbFXNmwMArEF0tWQLvfj4G96rjg0ZMz0hP0RZrDWOhOluhNST4pSY7PhEN8/jDMN1857s+F7x9ZClOnlu3YZUZCkB8jldq2iAjdCn/C4aIGzoAjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=JsoXURJS; arc=fail smtp.client-ip=52.103.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="JsoXURJS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzEeMucORp8H7IrRSUxq23yPH/R30MPgzXZdvcQK1Zb3jsIfdj2uL7xrrIOs2zJVpvq8nxSK3MPzzaMzzi4+Be796foSnWivP80euXpX90TwW8oNHrlLltz9DkCyxiDhHZTHdX0hUs1jsvD4RRujCPqd5Ou27d2Fq8OxlC45FrC0zCIUAWGeNAhRuF6pEsa91KVAd5gCi9IiJRm0Oq43BEz8wBpI82ql+TArjPpk8dTAQvtp3gAp73XJ8mKN3bDeCEok0kkUIN+M3BGHVKVY/UE6jFObO5cNGxgjrlNrjetxUQa/Eoeao2hzINeX6hEii4Zfj0yvZ7LuZN/SgEDm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6gFKOkyRjaDY7VOgLqq9LP6ptY9x+0BAUTeLa/+AgU=;
 b=ksO7DoXMeeNR06c2A5DmeNFQm4t5YX2vg591CAlhKzTgxEzLR+5Vh/hLBKe0BOi1LKUMpmHt6/pQ0H9QBwn0smftpqg/70i690g/SuWuLOPurtCguRgjtJhjsjcNONdrOXZIXdK/ViaCdFzEAj2XbccJRrjzPIqjC0JjV9dwXLouUrbTVg52x4imCe28NtN6+WECgHVsq1NrLVvmImfWy2J6x8UsQhXss6xf9qdIj4cA1p1/QdAjY+6SNpIO3SxcOu24tDfmsPxfDZusudlbPhifn4+v9KslNRcL1a91AJVNO1wTusholGUKMG65sVJtcd2BFRNUWnZtTBEZ31eQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6gFKOkyRjaDY7VOgLqq9LP6ptY9x+0BAUTeLa/+AgU=;
 b=JsoXURJScQR8X7j+s2QpvIKNMAcGHZPJLI7FTlASZQlLoX4eUmNr5b0lRxrzaREfJbLIbOkZeH2c8qCVwszvZ5PrsQJW6/gPMCPNTd5zBAAbOWLTS4kH9KPC8t9urICGKLSz8ky8yZNcGJvbG0Pik7FLP5hObf1Z5LUaFAtJlp5Bom1rGOnTJx/XAeKKoY91Js69hki9v71FdO6QHBjTtS8bp5AizdEVW2tRd0u1qv6/iB3hNio6xkb6ntED6dRzxWBf36grgUFSm/woB32cKDD6CItNXvN8FAkPzOamF2lOxefduDhxQs+crxTGwFuOH+gVvClRYcED+/xcdhx8NQ==
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13) by KL1PR01MB4704.apcprd01.prod.exchangelabs.com
 (2603:1096:820:c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 09:07:06 +0000
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75]) by SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:07:07 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v6 6/6] PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()
Date: Thu, 12 Mar 2026 17:06:37 +0800
Message-ID:
 <SEZPR01MB43997A01AC87EC9CEB97077CDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0100.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::15) To SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13)
X-Microsoft-Original-Message-ID:
 <20260312090637.71548-7-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4399:EE_|KL1PR01MB4704:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a66533-226e-4530-875e-08de8016bbea
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|5072599009|12121999013|51005399006|15080799012|19110799012|23021999003|8060799015|461199028|41001999006|37102599003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vGD8p7xcwI1IcJCzmaMjGw8PDVwcNIA4wYWBPDIZqMwl+xrxEpk7uOg4Lm79?=
 =?us-ascii?Q?p81hvOUfP6EA9xreYdNjEHmCqn7u+JUDnRhfGgZikmfeqA74RBUfc9p4rP73?=
 =?us-ascii?Q?yezx8B1GQirhnhnxSrAPJlbSg24FPVVm3biETVN7scFWlsDVK7TciVILEEXG?=
 =?us-ascii?Q?cSMiCs1TUhVHOuPWdYH2t9WYl88zvejxRoL3rXHv/Zcs06EahH1Bj3Gfu+zl?=
 =?us-ascii?Q?kJJYaETNWL+E/OprM74zr1IVWZkvyViiyfpvUwx60OohJdchBYyry9Fl+OA4?=
 =?us-ascii?Q?ws0KfkZoCKiUozLfvCgB+kjkrMsVGjkKPr3OakYLSd5+oDVxa1ftS1v/FiUt?=
 =?us-ascii?Q?nxQwxeVFykaklDsr5uj0N2fLgHzurLTQueb8s6V0aWPi29cqV/62kZv+zICE?=
 =?us-ascii?Q?tzM3n7B4crA4Ps7bbAtGF+aQfkq7JgL3NWwYD/9EVqwILDAcpkdjX+xUUn+L?=
 =?us-ascii?Q?/VXzIUDrysaTtr6YaHIhHDliwn87eT9T+WKeHlizvABN/JIt6+xMP3JA/3LG?=
 =?us-ascii?Q?RD7tL6xDSS1fBUdXmr71Q7DJcJJWp3vdsK4bIh6lvs9PxqFjn7BDfDdsHrfo?=
 =?us-ascii?Q?ngBqvpJXwbD6XtwnEO7AMV9zd/1Ep2+ZuZPETzG2ZAIdn70yVgGITAN0aEDl?=
 =?us-ascii?Q?/id5Xzm8kMzj7X2MV6D0KL45/Xt67/c3P4yBgRiaBSlpeODqL/QLNnGgLvao?=
 =?us-ascii?Q?mDgDagMaiM3VXfUhz/nkDMa8oeVlsEhc8eInUSWf/LnaD+pmLICLYi2ALrti?=
 =?us-ascii?Q?mdC1nXBYfrMC8HEVPY8Zus4di0d6q+yuxARQfpiGsR9eLMXoqM9iSAba24Qt?=
 =?us-ascii?Q?VDx8aOy6L+4ANEaXU4PgzRgOq9RZwJN8l2snO5yIVsI0qZn2P2MKC6DLl5uU?=
 =?us-ascii?Q?yMFQPnR3DCxMjDB8+6ZgQJdT+3wzVQqRpMtelFAw1WkPW9bxhld0YJB389JO?=
 =?us-ascii?Q?/PqgbkXHWkUK63yZysg2vj7aBckaj/ESosYnprgm0ddUJS/mJzk/tR/5OsZD?=
 =?us-ascii?Q?Wdqbg9cM1mDLX7QHB66n4T5FWGNLtJ//AvkhUnqULydIehqSFEIZgKmiLzgL?=
 =?us-ascii?Q?ferc6OOD?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kNlp2asrMQqoXc04NfX/SG1BseKmEzBrZn1ZeI39qfOB5JeDwDRearkT1544?=
 =?us-ascii?Q?kfYzYHLE0cUkSTPayBZIR3OuPUcvbvA06WL+Ly5FBo7qEE3z1qhlNB506FXb?=
 =?us-ascii?Q?gI2435v8a3Pf34S8xgyM0wKjgiTYEBKY9Pf52GGciWXNco9SW1nMZZjeDDtH?=
 =?us-ascii?Q?52b1/ECaEDST65jHnywMKXHAAT5Jkb56ix0t+h6RuoqHO/tn+RTTqC0V1kzc?=
 =?us-ascii?Q?M3Pb9QLDz6bC83bTA1vw1yEymoeNuRYw+9hxBd1a5HN2acYpoSkfzb4zn2HY?=
 =?us-ascii?Q?G3GBjRV05Z/3EubReelNQsG2p/S2iPjzxZjJECCgewYYAM+N9rWeSTQCynSM?=
 =?us-ascii?Q?DfG85NM5iQL7dhtaddcPuXhshcSDwlDx6tGPGfo2TNCwpPwP1Q7jmVF5vTGU?=
 =?us-ascii?Q?ECu+JpRjkyu3Iae3P9wSHKuDXNfN6osXTgkF5BnR1wz3E5a1PxQ+qB2pGOe+?=
 =?us-ascii?Q?eEAzZlmhexMPmy0M0F3/Eme3zTEq60y2ZOKVNk2d1aXYtXwCMuowO8AZ/Typ?=
 =?us-ascii?Q?zW058l9eWMC/Nb8SU45SSWwWcfDQG5ophkfRhNk439Vbf/4ElcUAGoL+209s?=
 =?us-ascii?Q?lo0Age3kuOaBKwZs6pTDAsoH+/ZpO3S04hM4s3qmQJ9VwFtOjRw//Tc7Os2e?=
 =?us-ascii?Q?ZnMgK+bs3Bx4mpVfzamlZD4odFSur4SvEIZ6XLG4Fp7wZOEELyvXuaG4jA8h?=
 =?us-ascii?Q?bjWBaiFEpNystmirN7vk9K3kJsyAuH+bei/l5Qal5BeReFXrnUcD0mlqmnyA?=
 =?us-ascii?Q?iTlZjX+7vdHObzZ9lPXEJIn68rJvXWDLa769o586ymlpC5QY0FhGOjoM8hfG?=
 =?us-ascii?Q?GKZFU4H4m7OIzdg3dAa0OQpYJ3AkKYfgQI67pWzEzUI62xx7Aj3ashxHWJJL?=
 =?us-ascii?Q?Qakr+i8inSgOLmTZojWytCVQnoV1E11XZkx/QRZjRIFiWIVow7nXrDNX3AwB?=
 =?us-ascii?Q?lCN5F5DfUDAS28RPbdkqtMMnoxszyBMo6/PSM5X+K5VvnbNT8pNI7WduQmKy?=
 =?us-ascii?Q?Ke/6K4NvXEH09BqIUmdI4wLH8kOWuaIusoooHdStSlS25qbDJ3Ztf8GWYBM2?=
 =?us-ascii?Q?UidTGOXZVQG6cuS6fNHNPjyF8pINbLGyRBfO3JSEwnjnYRFM/4GwckR33/1V?=
 =?us-ascii?Q?0odbxwodhojoaP7uDnqLD1xGcGIbn4s7x8FtBml2J0XS+bD5fGXQ8iKMOVph?=
 =?us-ascii?Q?s6UO2stk9MW3l1JLNqbrNygLM36xfsztH4Sno9dz3GnVONjnqudCtQN86sVq?=
 =?us-ascii?Q?MlKQ7cYnKgG8pFtbUBKj7f+Vkf46A68U7S4+92PtT5ozRR6CLA+VJ8i8kTJY?=
 =?us-ascii?Q?59ud+twFVZ8PHeLGRNQFONineh8DA73v9yfLaT3WyqBiSBorlmxEyrf8IA2U?=
 =?us-ascii?Q?oXUGyOJsTKMZUydeqdoqRHkkiARG?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a66533-226e-4530-875e-08de8016bbea
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4399.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:07:07.2152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4704

The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
isolation. On devices that support the PCI_ACS_ECAP capability, the
controls are required to be enabled properly:
- ACS I/O Request Blocking needs to be enabled to avoid unintended
  upstream I/O requests.
- ACS DSP and USP Memory Target Access Control needs to be set with
  Request Redirect or Request Blocking to ensure the Downstream and
  Upstream Port memory resource ranges are not accessed by upstream
  memory requests.
- ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
  areas that lies within a Switch's Upstream Port memory apertures but not
  within any Downstream Port memory apertures get redirected.

To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
support, pci_acs_enabled() skips checking for the capability.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2b36dc792d10..f1b77707a1c3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3561,6 +3561,53 @@ void pci_configure_ari(struct pci_dev *dev)
 	}
 }
 
+static bool pci_dev_has_memory_bars(struct pci_dev *pdev)
+{
+	int i;
+
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM)
+			return true;
+	}
+
+	return false;
+}
+
+static bool pci_acs_ecap_enabled(struct pci_dev *pdev, u16 ctrl)
+{
+	/*
+	 * For ACS DSP/USP Memory Target Access Control, either Request
+	 * Redirect or Request Blocking must be enabled to enforce isolation.
+	 * According to PCIe spec 7.0, the DSP Memory Target Access is
+	 * applicable to both Root Ports and Switch Downstream Ports that have
+	 * applicable Memory BAR space to protect. So if the device does not
+	 * have a Memory BAR, it skips the check.
+	 */
+	if (pci_dev_has_memory_bars(pdev) &&
+	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) != PCI_ACS_MAC_RB &&
+	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) != PCI_ACS_MAC_RR)
+		return false;
+
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
+		/*
+		 * The USP Memory Target Access is only applicable to
+		 * downstream ports that have applicable Memory BAR space in
+		 * the Switch Upstream Port to protect.
+		 */
+		if (pci_dev_has_memory_bars(pci_upstream_bridge(pdev)) &&
+		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) != PCI_ACS_MAC_RB &&
+		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) != PCI_ACS_MAC_RR)
+			return false;
+
+		/* PCI_ACS_URRC is applicable to Downstream Ports only. */
+		if (!(ctrl & PCI_ACS_URRC))
+			return false;
+	}
+
+	/* PCI_ACS_IB is applicable to both Root and Downstream Ports. */
+	return !!(ctrl & PCI_ACS_IB);
+}
+
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
 	int pos;
@@ -3578,6 +3625,19 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
 
 	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+
+	if (acs_flags & PCI_ACS_ECAP &&
+	    pdev->acs_capabilities & PCI_ACS_ECAP) {
+		if (!pci_acs_ecap_enabled(pdev, ctrl))
+			return false;
+		/*
+		 * The check for the required controls in PCI_ACS_ECAP has
+		 * passed. Clear the ECAP flag and continue to check the
+		 * basic ACS controls.
+		 */
+		acs_flags &= ~PCI_ACS_ECAP;
+	}
+
 	return (ctrl & acs_flags) == acs_flags;
 }
 
@@ -3636,6 +3696,8 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 	 */
 	case PCI_EXP_TYPE_DOWNSTREAM:
 	case PCI_EXP_TYPE_ROOT_PORT:
+		/* PCI_ACS_ECAP applies to Root and Downstream Ports only */
+		acs_flags |= PCI_ACS_ECAP;
 		return pci_acs_flags_enabled(pdev, acs_flags);
 	/*
 	 * PCIe 3.0, 6.12.1.2 specifies ACS capabilities that should be
-- 
2.51.0

