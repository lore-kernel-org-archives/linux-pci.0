Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013085.outbound.protection.outlook.com [52.103.43.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3308F4963AC;
	Wed,  6 May 2026 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076668; cv=fail; b=auNg4o/rkYOGbYRsIF0lwkdJexCATJK+a+Gr/T6nbyau33fZHPf7FPTdCUk1piMbxRpIAWAGBzzpicwbOJBH6gZJxVanGUdkVZRaatij17MEFauhLTwRD3p7z99xUz8IsCFAq3TduB77Maj0+F7d13GrigKCwkN4+za99IPS650=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076668; c=relaxed/simple;
	bh=QW+T+2t04MdAeV/k7F5xZkpElPaSZCfeDxZ51j/qkA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k07+9gfWjoHXbazm+jezH2RtQWzvj5hsC1SXsilj/gS0j0Em5H5kYzGmZoZFr79VBqQl1Zh0J9j/6bAYrkul3yKx/t5I0IdqqHfrke6ZSxfgZKinSrEFp5MNfHXaVrricEzx75uWnSpHmvlmbu2K/nm2acpcvCAmZAGn8XBDhxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=MFRhJdX3; arc=fail smtp.client-ip=52.103.43.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="MFRhJdX3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUcuUP7i1DdusZNCUa9plaepd0eunBDg5UXfOM7SwIHoYbCKGJKpRCqo9NO7AGtWtVGTjmLf1pIozRSdpT2lomr0w4dn5ezu59wwdU2dS8PXji6m2/ffo2yFLD2qK+gvpD0ZnV8SYCWgF6GXHz64ieJUSLrnP7DTp6F2WnK768+CXCYqWryX0YZ37yqAWZeqRBdd2Os7Wnb7A3X9sKhF4lPViGh9t4xNJMlLQxP8SrO1nRk8nkCPwK9dNPLbY9YJFKsOyWsbogHe0XhqB6k+yDMDhtzsVd95Z3ImjIbXNewaq67rAzlzIX2a51nGIzDCeJtoi5dBv2UK/XxYvbkkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAtxq1mNPpKifLQ60kmUMGKiWOLqHgLP0+3doiHr94Q=;
 b=OdGHvC8oaTzp/XbwGyxCpK2cZUXzHQsxzZhxCAGTzeNfZAnQ8hDJF2Z0VkpeGnt3AR5sz51qfVviDPxqfCWgJbOyfsbGbKrSL5CcCB84t8odyZa7LXLuRRpfghthvMDYBs18HSv28dOi/FjZ/6Ut/aNC1F+TuL9qfSxv796kaIpJDY4XqGdxOiuBHfiMDFMU6VIoPy78gyWiMrO2OWVV0v/x065FG+kgJx6cnIp5AnZE5jtddewr7h5YnpuUBuYIeZkwkPx2Mt5gfBQFHN6dHF4bdmwkTC1xmHgvr87zvybrDI8IsocAltBrLV7K34Ibz9rUPwPgmx+GgzgV1AUFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAtxq1mNPpKifLQ60kmUMGKiWOLqHgLP0+3doiHr94Q=;
 b=MFRhJdX382IHmmCtm0ry0K74nDzOCYgkf49xkrKMiCfVDLcVtN1XUcF51PaB7p4p8DJ/jCWjnvy9EkEDEm214ScfJNLfMH4bIF9/ugfEjpA19KP20LrnK7qvIvfaAvdpIlgXBjbcZqnFqchhVQB7qAGi4afSWo3iWSHtGPM/l1QAbjqtgsthrst4AdU+AgmoThrvrGGLXojK5jjghcLLox0bgk9vdH6q+69XV/8AmySvSYXKLMJEdi0QBd7Y23Dm3PdPvIEHDzZ3GuP8vrpyvCSxNYbQrXu21KdxnkHJwYgmN5LNxqZwGvLCkSZALJWNuJTuUaKFbVAV0ldgZ4Jp8g==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4454.apcprd01.prod.exchangelabs.com
 (2603:1096:101:70::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Wed, 6 May
 2026 14:11:03 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:11:03 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v7 6/6] PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()
Date: Wed,  6 May 2026 22:10:34 +0800
Message-ID:
 <SI2PR01MB4393E25E07CD496D60B994F4DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439385689A32A1DDA9CEABE1DC3F2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260506141034.1738541-7-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b32baff-cb4b-44d5-8e43-08deab794e4f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|8060799015|23021999003|5072599009|19110799012|7042599007|15080799012|51005399006|16051099003|12121999013|461199028|45011099003|37011999003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2n7si/rfpvBnUdj27bA2ChrI+tXfH2OiuWrMoR3zLn+Bl226+tJ/p1ALYqGL?=
 =?us-ascii?Q?fxggV4ReG1cjelglEe0omNFUSZAQnyzcuAWRjShhhAmYiaotwEEYpCFJojj1?=
 =?us-ascii?Q?GiOOYT7vo032zGI3OMtoggYSx+Rs9BYDk4kKqjyV2QwgyN0dlVRne7yTSY9v?=
 =?us-ascii?Q?kwfSvhmVYXiPplVs/uI9/SsRhrEqgOjqQ72vNuZl2KSHx+dDwjQgxHI3Ew1p?=
 =?us-ascii?Q?6spmI2oCHTckM+6OhAjr7CfRhDoZXY21ybJmGiS/TFd9a5B2/9AjlPRUCCsZ?=
 =?us-ascii?Q?vv67jTWPfqfMv0XQtgOR9AKHR/qkBOxAs2cEExGU9pNajTodjsKlEjxZwMVC?=
 =?us-ascii?Q?yl+cVL2vBhgMk+wXdxgmFT3LiZ38KRbsd+WcUWVNMkTe3PuxG71uZngHzTAF?=
 =?us-ascii?Q?vYDKiBHeclIgI0EoF01jKxLZG2sMjblZgnoVekQgxkKQGqNsU3hle0xgPB2r?=
 =?us-ascii?Q?7gwkiL/idm0GgzG2jSc4m+wy87RchovWP7IqO75C0NfyDZyNREmebSCodoN9?=
 =?us-ascii?Q?EzGERkD1V9qpoLwBTiOHm8nLsvXu3qYPAdvWKVab+UEMXrpASZQLCRzu5Szl?=
 =?us-ascii?Q?N+Rc04Qzn7UfAHLVf3bGAvss8q3iqnIDSurU7g16VMtNP9btQ31w5VhOSXD7?=
 =?us-ascii?Q?4dV+7t3sIKh8evdA4/NLY2lobKPG76pV37BHYMCzdr082IDXeQXme4Nt0C3h?=
 =?us-ascii?Q?h3eWLrYMWqS8e9AiuXEoLZmh2vOKrOB+IzuHOmXJgjkROlPiZXrwZhd6jqqx?=
 =?us-ascii?Q?zVMOkhrsH0Oy4Lw1Yf68owAcWGQQlmxum+oMCLYLN/rjHFNXKEqCXrG8yTM9?=
 =?us-ascii?Q?dTmKzurSBh8gChJCa9EOocTel40qIMxqI18K368GDM/LV8ALjd0MQRHvroh2?=
 =?us-ascii?Q?eQsTZg1FcxIZjE+nsJJYocFIU6UfmmDJTqk+euVuim52roXuw9MmCttJ0UQ/?=
 =?us-ascii?Q?J+BvbHd7jyvLW+uGJKawyIpfrndDcKOwcgsjW5RZLQauwDFkiZHU1m76w9p8?=
 =?us-ascii?Q?mkr5AVtZ2Yz+dVpq/MHwV3+XLsG3XlcdlBWuStJOhXdH02XWb75RXYrF5JOg?=
 =?us-ascii?Q?fulPQCoubCa1M0f1RHRm4/qqORhxc2G53mRWrIoxFZOe6SFdzgdWhs8+Sey3?=
 =?us-ascii?Q?vThyYdwxO1VB?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TzvrCcJml7macYbQ0OxJqcyvod6F+iRwXCm8C9wYLbjeB1OZC1Vgyn+R3SZJ?=
 =?us-ascii?Q?zzThAI8Jjw+f1xKX2L94Ev7JctwXcLyBuAP8PY++NqyNp6WSgYfCzv+HuMwx?=
 =?us-ascii?Q?7aHRmCqCfP+3ABaUYp688UKeMylqYcKStRt8n90zjoDQHKo4bhxpZtccBtcI?=
 =?us-ascii?Q?KB1GiuLJAiy8uiiaXu/VlIe5cDaZoLM1qIaEIunnAE1EaorbWCtN9EikAD1W?=
 =?us-ascii?Q?aUFhwdT4YErGfRnfM13ycTytsdEgdqKYD5k21fKuM+7u5cbw4rJh6Kc9kTX4?=
 =?us-ascii?Q?lYEm5O8pgamH+MmtNHA/wYqxuLncKDcsTE7pCN2/cFBwh8YyyqmJbB35I6XU?=
 =?us-ascii?Q?A8XSQvMi2gvjrWCpT47HoJ6FmZrGE5aBmLYvAH9Bj8iUDGSAz89HPIzpZGar?=
 =?us-ascii?Q?RvYwFmHZo27t7Jg5glGExGvKC11459+b01WkTI9tiHmpseLAezTEGjTpH9FK?=
 =?us-ascii?Q?U72fPxSbNHX2W4OhN+2Nu1sKyjG0CJX+Tg4UJud6Pmv+ugOlZENxfg90G8L2?=
 =?us-ascii?Q?axmD/RAtPJuLg/53IOVP3fi/w2K+AGEKXXhL1Vmix1HepXCwwLIQm2ye8TNK?=
 =?us-ascii?Q?RwY1OOXb1Vh1vukPa6n43j9arjMO3GIhvS8yrWicu8oVZxeVd3CupPz1nik2?=
 =?us-ascii?Q?9H026/5P9NWdC1+pV3Sfi6hRoykf0aP+RHH4uc/0hZj7oQZQAvJbrhYdeyuC?=
 =?us-ascii?Q?RdUDgix+I9T/AJoutLhPkgBjTe8syaknaJnHib1J6Fm06PzgnLzNM7+a+omB?=
 =?us-ascii?Q?OJeWYDKa9m3ENT3dsYz5bmkIJS2Jqw/tixTT6vZlqbgOsNHZT7J7oDQeYVCt?=
 =?us-ascii?Q?VyLmrcnBV6C6P2lqGOM3zEodhEp72HlNbYkthuoFA6cB2D6Nsmr4O2Na+9sE?=
 =?us-ascii?Q?+cA+rWbSvA32pB/IMm6nIA9T7/fnDKPW8p0smqp8u8t6VVXiEObZ2Ox6+riw?=
 =?us-ascii?Q?IcIfwMyaInMldkg1QLq5xBhuFiqAIiVBoDyrUufipkk6+LZdGWOPtAeQxDOZ?=
 =?us-ascii?Q?Axl0Rih86ogJK3ssc5FxqDYQlyJxWogEmQCajBW7s2eovhp+ptA+N3k4ibBf?=
 =?us-ascii?Q?uEFKOCGKfVbCCjIDmAXaU15Zh/mYjWvK+TKbZX4EtUuvaXrR29Sr6oad+DBe?=
 =?us-ascii?Q?za6UJn+BG/EKSsdk8S1kfQmg0EwdArOXPqIQ32dNE6MqZAdOyZFGv+GOFkEV?=
 =?us-ascii?Q?rhYK/SDB2vB2QGADdl2quDywZxba5e+bm7C78beTkWihMvLNI/zImyh7F34V?=
 =?us-ascii?Q?sgjjjf5UjslFcXI1lMuOhd/GotsAbky/eN8DiofQt0CGwfWp7sX5FGCqFbwd?=
 =?us-ascii?Q?nH5hwNHU3F+1gPFRCWD5V+mnfn6nb3gdhlCnGZkDKr4IjX9ffu3ggbq5mT0n?=
 =?us-ascii?Q?RMpAWN9fgCE4N2ww/WQnC0gQUh+2?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b32baff-cb4b-44d5-8e43-08deab794e4f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:11:03.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4454

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
 drivers/pci/pci.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0c15de0aedb..b684ae4e92b5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3551,6 +3551,53 @@ void pci_configure_ari(struct pci_dev *dev)
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
@@ -3568,6 +3615,19 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
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
 
@@ -3626,6 +3686,8 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
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

