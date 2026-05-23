Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012052.outbound.protection.outlook.com [52.103.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9230387345;
	Mon, 25 May 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716608; cv=fail; b=UFrViBlBWwlMet2NaPNapsXhCDPew5vVK9p7Wf8lqVRt1SNarTRlyRXzdrCCIrkp8mymhkPxT5uXB5oDSCzCqoKo/yR+miTZ0ea2zBAlj0oc1vxx9XzyQdjKsAO1fjlkzjZxIXsZppwF+WzPkziwzk5omir1i9r9xQ83oXIenVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716608; c=relaxed/simple;
	bh=MSbfciBL7CCVT1r3ULLuKAAqcT17mkLah89lUQva4PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dM+ahAlu+8PaRFTcUYL4LgzE0bLe/f3FwRCkO+QFgun5Vkxe0CSo29Mre37pvk/v4HgijLj8E6KyWGX+s+AKD3YDI6lj6GbfBxhHmauKkB8DJk2IivJNq+eka5R5dqE2oXjGSU7AGMxsUdCp+A1Sgtl2v5pSCj2kzfOobKYp4X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=aGIzS04Y; arc=fail smtp.client-ip=52.103.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="aGIzS04Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADoZQsFGOF+ayGY7SpqF8JnqxsUfOK27g9Zlxu27baYhOsTR67J5Ov28kbBqIpJlUAGRaqG41QohI5sKMiHb0zUhBsml2tWH2VuK2wo0Ebl5j7MdQwEriL5j5khOeMKnl5bgdASxT3xqaomXDWKHr6AtX9rHCEP8yDAQFYDTmTLp4GvKTHckaaAsaG2huDqsvA07rjSPwO/Sn9cmejH1P5I1cwNjPUIUd82s00dlKzpmtBKaxXqXM147CyJpgHVb1e6+rjSOKDsc9sOCul+zAYhia5zTO4X+RRj8/w8/NfLKaTb2zpyNfWhbNAAC0akwLFgFqXNZQIANwZicgmx90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyNhioPNzj7LD8f3Dp425sfrgtxosT+RExH5RiA4AJ0=;
 b=WAXnLmp3VtY3y41VFxVPdsRj20J5giJd8/Exps7gp6jBUActn8z6/39M3+aLfKE7bp9QroWD+1iyaQ/Xa366N/IKeI/cZzQGaemMrYrIM4CRYw68lDnSXFxjD4d0t7T2LmZVmp2m0R/Rqm5G9tsGO/Yg3PXnUgZm299kWiOs17sogXvcbXrc6HGo7nBjhvD8afvm1xn1q9t86kaEQ/r8rBxesJXLGBLRBQZugb17FDDVAC38vXNyrt+/waOGPKGAlYdaUGxjvzLpxVhTCPuVy4FbiV3AtFebvpNNgSiLijDCK+gGqN7i1KvpDonIfBdqAAPvUq0Aw6b+gs+Upar7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyNhioPNzj7LD8f3Dp425sfrgtxosT+RExH5RiA4AJ0=;
 b=aGIzS04Y4MHQ7btLhM88syatXNbPBj9iBo/06OI3AASn6MYANiewKRrdb1Nft0vZkXbJnFMr76xFsPlKnq4+R5k2Aoh70qomB89JM+Gs3sXLswijCvPdSl2dQVd2lhid7yKBUG7BJQNXVVIhp3CZZIlzHxf96+7YjT3mg/PN6nXLv7eHOIBeBaDrURYi8MXLimB5yaZxxNP2WaFrC6R34Eg/RT/tZiZXVwzClMjECcsxPhwZePsR4J3MNDX/JjW0/KAZCetWWhSkRgokizIKAo0TZT2msxoJsM/GefVewcR4/f0P4GrDGb4sSFtM0CjZwWXPWngkVTQryYNA4+NqIw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5718.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:43:22 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 13:43:22 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v8 6/6] PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()
Date: Sat, 23 May 2026 22:01:43 +0800
Message-ID:
 <SI2PR01MB4393E8272F07C8A636324730DC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779442182.git.wei.w.wang@hotmail.com>
References: <cover.1779442182.git.wei.w.wang@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <9a5f4bc952a89fbb3a1038c32c955c43b5e23707.1779442182.git.wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f562fbf-28d9-418b-ab66-08deba63961c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7042599007|55001999006|45011099003|16051099003|37011999003|51005399006|12121999013|41001999006|5072599009|15080799012|8060799015|19110799012|23021999003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L9+5XqUOTKFVr9yuNjTdgrCXMcGFWQrzPcCfS/bV41c3cFgsXPr6ixqL0maQ?=
 =?us-ascii?Q?tbTf/fJ9q4ywyxgqN9mjFbeaubbg1QQnNxVvV8dEefy4GJQClPhyOwt21cGn?=
 =?us-ascii?Q?bxKCwygKzoUh9UDrUqRmRloEvjFIRloy2YDS+Hwp2hjfXl/A/xIHWujXNxwz?=
 =?us-ascii?Q?ctXTgAoqWbdjO5nSS6+o87egEmFOK3aYCz/gVFs8AFmoLudZ8lUINFuL4ZAv?=
 =?us-ascii?Q?lz53YFwoUVuG4ScEZm61ojwgDYR0jbxGNkz4ydFAgOBREkAFzlK/nhkTb89Y?=
 =?us-ascii?Q?XpOS6e3YhnwUvclOpj1twvryhL7Se4rJ6ANxX8pFsqvchK/oR78lqeVZ6o6y?=
 =?us-ascii?Q?yhBSRaa5uKeBXw1Hb3a1kikBeBkCsJ9e5Onvi7QpMuq9ZPc1hIZ598K9vF63?=
 =?us-ascii?Q?EJD3IF43d9HGZJhHsiLuCgo5LG3Q09xu7AXB5vncJgMydUb4fDiNJbmQaDgQ?=
 =?us-ascii?Q?+uXYW12rjBqvAp157xuZj2WmsZ4A7k9AOnbImcH69NJ91HUEqtbygZDTvcmb?=
 =?us-ascii?Q?9kqUtkki1WaXj98CDdBRu202a+l9Z1gUhsU1lSjCL/kbKP4um77uttvbzOIn?=
 =?us-ascii?Q?yH1D8FxI3AjMAo1AmL9rLGvQJiqXbZSdOdgXBBR85z31zpwoSkinbNyMJdKZ?=
 =?us-ascii?Q?s3Bpx/LfEsbtThF52zbse8DDf+w/735uoivAfwMQ2ZJF9auHkXyt8vMxwexH?=
 =?us-ascii?Q?GiuL1RDiVYcwyN8CELS9zA8CCYyglIpDofsDUu48Uj9p46mxEQFL22sz/BNy?=
 =?us-ascii?Q?Oz2YYGm4hKi4H38rrK6wzmg/MJU0u+/jtriBEx/ienVS9DXrqT592FkrB/DV?=
 =?us-ascii?Q?TmQ4MqHrg8SEuh8yBFV3HSPZ0e2EVp9YPeyuWHBKMknkTLvJZVuUEsCeL14z?=
 =?us-ascii?Q?9anBI6MjtDGfokfZdBfAMJoXyKIi3jlWqFnwTVxdZT3xrQelujyk2fyMlz7U?=
 =?us-ascii?Q?EjKkuiWowg3XH/qIVz7XkVYBs07rrVpOzHeuCVjiR/ubg8x5CeRIEn5PY9tn?=
 =?us-ascii?Q?VSwuD+0aqgG0iM92EXxIHWY0TZNlP2jKJ4wVFNevd29HiFPY9Re2LlTXpYJq?=
 =?us-ascii?Q?9dblvcEXTNQ6ZKtBc5Pn0o/ADxfbSoKay7k4ZF4HglC0nfyJh5eoT5T2gbW0?=
 =?us-ascii?Q?8BNNz4cTCSH8meJBsTSX4V0U7CHx8O8K/Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?frmH2We6AfPhGFh82UilTK7Ws/LWnu93VZDd4Q7uOHipvz91/nix5FaIMz5Y?=
 =?us-ascii?Q?WLFG8XLeHt5v1sxyYqvFcCFtwqlewpjwKtZMIMwPi26pX4anYbJZxDr1PPqF?=
 =?us-ascii?Q?+0YTp03REc8lf9PCBTUW0X6Q30BTuXSNmkP2pTeSRP6bTVt0gHO06I6sGTNZ?=
 =?us-ascii?Q?rtj0ftc9pOdEs2LldCDpdZySTmGVw6DiCHJI9TnRvco3MVdf5R7C9vjjdGS5?=
 =?us-ascii?Q?r39oDDkzTtCcbzqtC+huQnjXdzzlRetgA3J0NPhujv1RvTYzztx9iUbiaJYu?=
 =?us-ascii?Q?pv8/JclcjdSIz+ryU8hXo55PoMQLkRXAtK3cdegclK1hr7+AgqklIq0+gSe7?=
 =?us-ascii?Q?bGrFCIqMCaXSi8hLDG14Xi4e3wJf5MNDfrn3HO/aFEiDHNNyPYgEv3Mo7b2u?=
 =?us-ascii?Q?8+QFMoEiYv9RtroesrgdH7EnFuvPfFmO0cAWP5pX1nuTihOGs1X8+kCLh767?=
 =?us-ascii?Q?YMCgoYCbPhHju5pdlIhpUuNHvN4QfUsk4bk2emul4nJhXFpBRCejwDFJ/PCh?=
 =?us-ascii?Q?iAArymz0laSnTgIuS32Gd9ED4fSQPNwn56rg5RQfIUKBcs3Jm+EsEY09m+1Z?=
 =?us-ascii?Q?YOedWaCqRZPqP4yaHlwC5CSfLmnDOp4t2gurssaxqbkzBCc4evXfFMphLqVW?=
 =?us-ascii?Q?58tMoW9UUjqtVm5u+dNlmC1hgpVq8/+Uoqb6UWWG9v7g1CsokYwHs6SNyJy6?=
 =?us-ascii?Q?dQOaPvzgSJZP4xS8hoB41XzgF5k/nU6gWsoGVPEscv73Q0EJdWRGMFS5tDsP?=
 =?us-ascii?Q?xzME/alIqtdTq/oMVhozBSi+0k5U6nR2bHPTTYssxwHVXDhRksEQtZj99EzF?=
 =?us-ascii?Q?7a7t4hOum+P1FxWOiG4LWGB9lJVfQNJ1VW7kw/tZrkxL0H6ZRtBzTQg4nqRz?=
 =?us-ascii?Q?m15NvLrWOB1cIlVaqcS50VyXm5tiE9kvdaPDEK/jBEYRI/hwON68f8j0PfcX?=
 =?us-ascii?Q?clPXBI1UnRwD6wJZDcM7JEfilV7z3GSf+jvuhQVL+nGjwP7XDrlFDS5oFe0t?=
 =?us-ascii?Q?Q1UmfVIeAwZcdcDfYEjlXxaTdD6LF97SpG5cyVWKa0Mj/uoCMAcfsyu5JHS8?=
 =?us-ascii?Q?O0eE6HSdQY5CkP+XeqXs0gF9qF+ljPxGOyX+NI9819haNJr5KoumtEnyhPDd?=
 =?us-ascii?Q?AtxvJXrFHwAL5eBKEoQ+iFBVVz5pTEQkh3+8lUuwMI1t7mseSEEeUpWiDCX7?=
 =?us-ascii?Q?nHN5Tn+zCnvmXvTzDTSREfcnuUqO0pB1Z4oBnGvHdYI2xq4yzoabMp+27G3L?=
 =?us-ascii?Q?u0XTP/RHyiPwDM2bsDUuLjq9EWI+165+MzW3/FG5/RpwBtEf3sqYBsTqNaHO?=
 =?us-ascii?Q?1NL0LMcWOT9ut9Ihqauw5g8wXdnRls6teJCXsrbOm+qwqCr6rcYswXB0a8M+?=
 =?us-ascii?Q?wRG/WokOF0t3yxi1lLK/EA+Te9QB?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f562fbf-28d9-418b-ab66-08deba63961c
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:43:22.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5718

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 348caa1e132a..dff721000850 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3573,6 +3573,57 @@ void pci_configure_ari(struct pci_dev *dev)
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
+	struct pci_dev *upstream_pdev;
+
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
+		upstream_pdev = pci_upstream_bridge(pdev);
+
+		/*
+		 * The USP Memory Target Access is only applicable to
+		 * downstream ports that have applicable Memory BAR space in
+		 * the Switch Upstream Port to protect.
+		 */
+		if (upstream_pdev && pci_dev_has_memory_bars(upstream_pdev) &&
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
@@ -3590,6 +3641,18 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
 
 	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+
+	if (acs_flags & PCI_ACS_ECAP) {
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
 
@@ -3648,6 +3711,8 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
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

