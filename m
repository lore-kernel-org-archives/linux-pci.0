Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5185835838E;
	Fri,  3 Jul 2026 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783116343; cv=fail; b=kxx983yQZI9cMFSRDKL+AeeAPFx2LU6yuvVrqB7hpAOWL7LR+mUTU/LtkDKOrtGAZ5PQSBuB5hai5oEFm2Sv2Gywa2JEhP23ZPugmW+16uQ/tHphvZ6ugeQB5C0E1ygDAg+P0aJai+c3nkibuYSZkoU0nOslb4BMqqMxIMfLXbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783116343; c=relaxed/simple;
	bh=+Zv4Xc3oF9wCihk6ACs+eVkNXSG+1wiKLt0OmeYqCYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNrjYbFcPNyaCVynDnhaB/bd7+qROdtVLrTnua5E3iBtCwgq6Bfkzm8jRkkter9XvDRv5rJuU9xa9vIQheIdCSkzD75fDiUwvsyc15RvDHA10EBajzB+1qWN9Z9Byvvcsq7t8DrzcvJ5sfR5qI2ppL0S40GdC3CBOHtX8TTPPNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rGZTvQR2; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rGZTvQR2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIvcrJKUUKzwT01xufQhiCY3HMhSHsdZ7cYYK76a4q/mdduytb2Q5ZEFXIJbiBOIJm5S05/ll/KGc/Bf58RP0tN2rFVp6HESfsGLjoeEahedi4tzocp2Sw24xbTO02fbVWKZfuHa5U1xphuNe9gFjgJpHlh9tsTspQf8pyTbHUlSRsLzkP4y/OOYThui+LgxUdQwLgl5NsQTElI9AVbAwq1ibyYr7aVBDBdNxpee2X4Z8ZOyXAM0xCIMvuWTY6uoMp3DTTSszhFX+YvutP1oqTRSG7K6Cl3V5Fi9i3hE4q2WBmkc/LTm0Nq+7nW4MynNT3CfbMEjKA7tiCAG2m38Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QRHANFPXBVO69DSN8+RRj0jliMq2KjTSJwlaVAV8UQ=;
 b=j0Y/VihgxBWST8ODOh7MhKiAgmAu0i1abQA+dv2ebGlAS3RItIxYGQwYeXfW/vm2u0ff4ohv4AlGWP2F7aelqTHTCtUQ3Ajgy6CqHxPmMvuMl38+qQuEpiZFbPb0mU8pm7hiH1UEhXmpW3XGH3NqgYV9Ayr+feZZ3uvv94PLJSmRdmnB2cHb5MRtEzybEZjwsZX2kp/zciU+i3pCEzOI1u2yvMGTUv6iDBA+7JrE78s4Vu59pjFTzfxSCY/xajRS1mlO+EcqkqVcyiM5ybebsowAS8rg4j8xXDfl8lhRMTEtWAFK+fQlgDWCcakComZcr1uc+pgRFWdl0c5CQ6hHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QRHANFPXBVO69DSN8+RRj0jliMq2KjTSJwlaVAV8UQ=;
 b=rGZTvQR2qEzeaIecNWGjL+1wHDnIZPy1ZDS4sujzqLEwVZsjW4Pv9tCg0enzgCtA69nUkOjersyGGjrRyqNt/xAB9yoBtjUZ8xD1lFCO8Zra2vziPXFMEs6gTfzNskvEDq0MyAKwA82VieOUYdsc3L06VuPKOvXh+dsRzXc6Z69QFTkGy8RlfH5ZX95zX8SdQkqWOtIIWVGM+JWVRsWLUjRk25JDb1AZj6XUJha1qwk73wec6fI7fd/p93ajiFClh2siX+05Krwpk6FAz9ZWxdMtJSsXMXbKeByEzsf/C54npCUdmdEgnbdgEa71cXrhGKSKyoEi1kZmjaFOepFkSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 22:05:31 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 22:05:31 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v8 08/10] cxl: Restore CXL HDM state after PCI reset
Date: Fri,  3 Jul 2026 22:05:06 +0000
Message-ID: <20260703220508.546528-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703220508.546528-1-smadhavan@nvidia.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::23) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4d5ab0-34de-4ec9-5bf3-08ded94f331b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	eyfqoKqTP5QDoNLfvNYeGYN27COB413PSqL4V1eU49VF3PzBqC6MgTIm0cgHTSHFx/ihLOqVSNFdRYeZcU4drARcaLumCRagx6R1pQ82KceoskPS9hSbSO9vWoADu1TfG2kivPsdNwmN5tXUJLqOx7if/3yBYIgFlpm5QL9JRYITA9wSm/7kfVz1C3C5enETCiyTJ84vtZP21Jud7WzovGUK/cgjyZny0M9BDloDYmOiBPlzyO7AXzXCY5IM4daXjGNdRifBHicm/vCBsQHr06Q8x8W6lT17U9x1LUPKyZF9CsTWu9B56krZvmWurEripz36Vh7mIHg0/30F7wa4EPUuzGczk30DwAUzQ9o12Xx0kX45f2CTx5+f0G6ZrmedtrniswO3epWbwqW4etONdJu3lFWDSoVH2au53iILRWtwukYHl61JuJtd2SzUdV9EaxS+EIMbwL8KToqsLOx3KhUQ0N2QcLXbbhXdv/3J3SZ/XWHb9Bkeg34F6YeNJKXNeoucci3/6nr1E7ZRgWjhBvcAJd4+/xphO0VoJFXt62qWVMN9jJ7zX8b1OMWJsdppq0N9DdJLTQdXGIbMq5Xgd9kso5108YIUDGmpcMLyiKeRsdBDGZTY3X//uDXkhDNZY+Q+Uufxx3xOshRjGdeATuxF5ABDxk/QtnF86gmqiZUQUQxl8CKt7RBgeSJVpubD8+tL7Xbnsdmc+qSQdj4Lng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w/uOzsn2pstqZrPHvL7CXPmOmZFwpo1O7ExgGGFLuQ9WAh60/+ym6LuprRdf?=
 =?us-ascii?Q?FdFZoYIsMXkm8bE1yrjHXCsxs2+YVA+yfdjjkwkWNsVvbKeIR9ISu7qTwKqK?=
 =?us-ascii?Q?hivIPKs1Kh1y9DRPahuna6QrSBqc6WieP45ZctbdZCLN8SwpOMMUC6lXrbAS?=
 =?us-ascii?Q?A0/mzcVEHoWtE6fpIVUGlvXcUm2rqnq8PMbg6Mp7qadLOPaa7Bksiy13qvZN?=
 =?us-ascii?Q?V/WIccxIBpVXHSydjmOyXiAFYBxDz6YoZmOR7O+vJ5L7pyME+fnMQ8it4CCy?=
 =?us-ascii?Q?wZgJTJ01ihj+wvH3KCixfP7EBoHoUq3ioknt4AFF6G4OhUDn+WWozT0aMt9e?=
 =?us-ascii?Q?kEcHcI1p96Na/zyqk7iuUphOOWUCWz5iBJNnWAgjOSHBozGi/avW6uaZDDgr?=
 =?us-ascii?Q?s1S94d/l4JMdbz1op1P3LluN8IXmt4jlX8TzvnpRxMFAtwGK/aZ9JUZxVk0m?=
 =?us-ascii?Q?CrVr/gugIYn9qjua/5KsoehTN9BJDTkp1fJdKqh5VFwcEPOt0BlT10r7KDbS?=
 =?us-ascii?Q?Dk8pY8w/608JfeRLvrCdTCDPTDRYTVui9PT7bCUZqdLxFd16Oi9u5v3SudgX?=
 =?us-ascii?Q?FdlYdLq242aaiSPNtF5BGRZAZYcJTk/morKmPf6gWwbnpXW7xIYKk+SI9V1g?=
 =?us-ascii?Q?4ss71PfzeecMH9ukk9MlYcFHb1fvEJjPu07n1065+nkBZfejxgDYV856QbOV?=
 =?us-ascii?Q?IQ+1LVdnz5+m9Ju+wItr5EBAcF1BJo6ADnMocVaYk4Ubq+K9UR9eP5H8ksT9?=
 =?us-ascii?Q?WEdNooXV1lF4FbQdHNbK2pqjbM2K25gQems6qN0nfY88wjchcJyP2gnZ05Te?=
 =?us-ascii?Q?zPFEjjJtrwubOTMAmfyzMxcDr4b95SpcfguNKEyQviqee6Hj+Ukt+mpcJ3ky?=
 =?us-ascii?Q?4EmPREzQ8VewAkUwUepc46/MpfRCdwejOEm1vg9jjMkEfrAmHJ9Vaw6i9Knp?=
 =?us-ascii?Q?z2cPY5zglt46PGwVKGRGSulr7UIcYrkF7CzBokfuu6y/Tb2/t1nrjS42pQjl?=
 =?us-ascii?Q?V67bpQasuvfURuyP3Wi6xYlXAkJQel0dS17qv/imCtGz1Qg/MWgfWTJ6Ngfe?=
 =?us-ascii?Q?DBgf4gHf5NgunjKeUu8EnSvM0yHQzS8RJG0A2Y7OKPzY8OcdHTfGYYGhVA0b?=
 =?us-ascii?Q?Qw1u7xWp7FgqnkyoIb8jtU1Q2VTzXwM79o95AWXHeGR/mRT6jd8x0rO0oDX8?=
 =?us-ascii?Q?ljF1jp33ueqkqaVBPjqmlg+4yVYq7ifiyPdBZGCGf0Gw9FBsMPhAYnmsVmP+?=
 =?us-ascii?Q?20ptaC4+sxUO9K3UYZT8jMPyM5C9WeSd0+LsLJMjCr+q6PpdAwJ623f0C2jX?=
 =?us-ascii?Q?ujDuNrsitqcntN7mZYaoPpaQXkjrpOH8zfMRc9tsOKIzKId0JAdv/eXZmW+x?=
 =?us-ascii?Q?meDmg0j4lHEgggH0c6c2j5F9YAIDGPNuLzOXw8hEDzJKStMyvbeFi1iAHOx3?=
 =?us-ascii?Q?xfaBZSe8WM17JnLUqHG/rgVtzDWhNEa5Wl3I2VsUI2QF9V3uWlmzP7tg19HZ?=
 =?us-ascii?Q?0lkEmVMK4fl4E/lH8wvUfN1jsYe9TSYfRT/nkXlSm6EbRKWSmcrmo4ShrwhF?=
 =?us-ascii?Q?N6MIPgKnnpojUk4/ct1+b4tziK2/k2/ThS1r2atZ9feZv0OQOJ6B6/GBxpl7?=
 =?us-ascii?Q?Tu7Npr0Ozw2ar3IjbR5EIdZ+C3xxra7wD8UEYa+2t0kwFG8h4Rl/Z3qdrVTt?=
 =?us-ascii?Q?JfgFU5VWm8llsLBRRPzIAtasKsI+O/F3He9ZkoytiBcD1oeAPVU1U4udSzR/?=
 =?us-ascii?Q?Mg0RjuWVCA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4d5ab0-34de-4ec9-5bf3-08ded94f331b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 22:05:31.7606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKcgwav7DxU6PHAGak8QC2bNOqme1s8SHL3kg79557qLjLN+wvrxW2mrWLlxWRZ3EREck4HW5/lJQbgyGQhp5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

After CXL reset, restore PCI config state enough to reach HDM MMIO,
restore cached global and per-decoder HDM state, and then run the normal
PCI restore callbacks.

Keep the target IOMMU reset block active until HDM restore completes so
Bus Master Enable cannot reopen DMA before decoder state is valid.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c   |   4 +
 drivers/cxl/core/reset.c | 320 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 310 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7a1ade846c9c..96f0de889073 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -137,6 +137,10 @@ static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
 	if (!info || cxld->id >= info->decoder_count)
 		return;
 
+	if (cxlhdm->regs.hdm_decoder)
+		info->global_ctrl = readl(cxlhdm->regs.hdm_decoder +
+					  CXL_HDM_DECODER_CTRL_OFFSET);
+
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		info->settings[cxld->id] = cxld->settings;
 	else
diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index 8e80e7588046..cfb9b5101c28 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -83,6 +83,21 @@ static int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
+static int cxld_await_uncommit(void __iomem *hdm, int id)
+{
+	u32 ctrl;
+	int i;
+
+	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
 static void setup_hw_decoder(struct cxl_decoder_settings *settings,
 			     void __iomem *hdm)
 {
@@ -92,6 +107,8 @@ static void setup_hw_decoder(struct cxl_decoder_settings *settings,
 	u32 ctrl;
 
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	ctrl &= ~(CXL_HDM_DECODER0_CTRL_COMMIT |
+		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
 	cxld_set_interleave(settings, &ctrl);
 	cxld_set_type(settings, &ctrl);
 	base = settings->hpa_range.start;
@@ -249,6 +266,31 @@ static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
 	return hdm;
 }
 
+static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
+						 int bar,
+						 resource_size_t offset,
+						 resource_size_t size)
+{
+	resource_size_t hdm_start, bar_len;
+	void __iomem *hdm;
+
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size)
+		return ERR_PTR(-EINVAL);
+
+	bar_len = pci_resource_len(pdev, bar);
+	if (!bar_len || offset > bar_len || size > bar_len - offset)
+		return ERR_PTR(-ENODEV);
+
+	hdm_start = pci_resource_start(pdev, bar) + offset;
+	hdm = ioremap(hdm_start, size);
+	if (!hdm) {
+		pci_err(pdev, "failed to remap CXL HDM decoder registers\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return hdm;
+}
+
 static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
 					   void __iomem *hdm, int id)
 {
@@ -261,6 +303,40 @@ static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
 	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
 }
 
+static int cxl_hdm_enable_mem(struct pci_dev *pdev, u16 *command,
+			      bool *restore_command)
+{
+	int rc;
+
+	*restore_command = false;
+
+	rc = pci_read_config_word(pdev, PCI_COMMAND, command);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if (*command & PCI_COMMAND_MEMORY)
+		return 0;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND,
+				   *command | PCI_COMMAND_MEMORY);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	*restore_command = true;
+	return 0;
+}
+
+static int cxl_hdm_restore_command(struct pci_dev *pdev, u16 command)
+{
+	int rc;
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
 static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
 				    struct cxl_hdm_decoder_state *state,
 				    struct cxl_decoder_settings *settings,
@@ -455,6 +531,164 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
 		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
 }
 
+static int cxl_hdm_decoder_uncommit(struct pci_dev *pdev, void __iomem *hdm,
+				    int id, bool *locked_committed)
+{
+	u32 ctrl;
+	int rc;
+
+	*locked_committed = false;
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
+		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+			pci_dbg(pdev,
+				"CXL HDM decoder %d retained locked committed state\n",
+				id);
+			*locked_committed = true;
+			return 0;
+		}
+
+		pci_err(pdev, "CXL HDM decoder %d is locked\n", id);
+		return -EBUSY;
+	}
+
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		return 0;
+
+	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	rc = cxld_await_uncommit(hdm, id);
+	if (rc)
+		pci_err(pdev, "CXL HDM decoder %d uncommit failed: %d\n",
+			id, rc);
+
+	return rc;
+}
+
+static void cxl_restore_hdm_decoder_state(struct cxl_hdm_decoder_state *state,
+					  void __iomem *hdm, int id)
+{
+	u32 ctrl = state->ctrl;
+
+	ctrl &= ~(CXL_HDM_DECODER0_CTRL_COMMIT |
+		  CXL_HDM_DECODER0_CTRL_COMMITTED |
+		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
+
+	writel(state->base_high, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(state->base_low, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(state->size_high, hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(state->size_low, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	writel(state->target_high, hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(state->target_low, hdm + CXL_HDM_DECODER0_TL_LOW(id));
+	/* Ensure raw decoder fields are visible before restoring control. */
+	wmb();
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
+static int cxl_restore_hdm_decoder(struct pci_dev *pdev,
+				   struct cxl_hdm_decoder_state *state,
+				   struct cxl_decoder_settings *settings,
+				   void __iomem *hdm)
+{
+	bool locked_committed;
+	int rc;
+
+	rc = cxl_hdm_decoder_uncommit(pdev, hdm, settings->id,
+				      &locked_committed);
+	if (rc)
+		return rc;
+	if (locked_committed)
+		return 0;
+
+	cxl_restore_hdm_decoder_state(state, hdm, settings->id);
+
+	if (!(settings->flags & CXL_DECODER_F_ENABLE))
+		return 0;
+
+	rc = cxl_commit(settings, hdm);
+	if (rc)
+		pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
+			settings->id, rc);
+
+	return rc;
+}
+
+static int cxl_restore_hdm(struct pci_dev *pdev)
+{
+	struct cxl_hdm_decoder_state *decoder_state __free(kfree) = NULL;
+	struct cxl_decoder_settings *settings __free(kfree) = NULL;
+	struct cxl_hdm_info *info;
+	resource_size_t hdm_offset;
+	resource_size_t hdm_size;
+	void __iomem *hdm;
+	int decoder_count;
+	int first_rc = 0;
+	u32 global_ctrl;
+	bool restore_command = false;
+	u16 command;
+	int hdm_bar;
+	int rc;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		info = pdev->hdm;
+		if (!info)
+			return 0;
+
+		decoder_count = info->decoder_count;
+		hdm_bar = info->hdm_bar;
+		hdm_offset = info->hdm_offset;
+		hdm_size = info->hdm_size;
+		global_ctrl = info->global_ctrl;
+		settings = kmemdup_array(info->settings, decoder_count,
+					 sizeof(*settings), GFP_KERNEL);
+		if (!settings)
+			return -ENOMEM;
+		decoder_state = kmemdup_array(info->decoder_state,
+					      decoder_count,
+					      sizeof(*decoder_state),
+					      GFP_KERNEL);
+		if (!decoder_state)
+			return -ENOMEM;
+	}
+
+	rc = cxl_hdm_enable_mem(pdev, &command, &restore_command);
+	if (rc)
+		return rc;
+
+	hdm = cxl_pci_hdm_ioremap_current(pdev, hdm_bar, hdm_offset, hdm_size);
+	if (IS_ERR(hdm)) {
+		first_rc = PTR_ERR(hdm);
+		goto out_restore_command;
+	}
+
+	/*
+	 * Restore global HDM control before per-decoder commit. PCI config
+	 * memory decoding is enabled for MMIO access, but IOMMU reset blocks
+	 * remain active until HDM restore completes.
+	 */
+	writel(global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	for (int i = 0; i < decoder_count; i++) {
+		int rc;
+
+		rc = cxl_restore_hdm_decoder(pdev, &decoder_state[i],
+					     &settings[i], hdm);
+		if (rc && !first_rc)
+			first_rc = rc;
+	}
+
+	iounmap(hdm);
+out_restore_command:
+	if (restore_command) {
+		rc = cxl_hdm_restore_command(pdev, command);
+		if (rc && !first_rc)
+			first_rc = rc;
+	}
+
+	return first_rc;
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
@@ -476,6 +710,7 @@ static const u32 cxl_reset_timeout_ms[] = {
 
 struct cxl_reset_context {
 	struct pci_dev *target;
+	bool target_prepared;
 };
 
 struct cxl_reset_walk_context {
@@ -627,6 +862,38 @@ static int cxl_reset_validate_function_scoped(struct cxl_reset_context *ctx)
 	return wctx.rc;
 }
 
+static void cxl_pci_target_reset_done(struct cxl_reset_context *ctx)
+{
+	if (!ctx->target_prepared)
+		return;
+
+	pci_dev_reset_iommu_done(ctx->target);
+	ctx->target_prepared = false;
+}
+
+static int cxl_pci_target_reset_prepare(struct cxl_reset_context *ctx)
+{
+	struct pci_dev *pdev = ctx->target;
+	int rc;
+
+	if (!pci_wait_for_pending_transaction(pdev))
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+		return rc;
+	}
+
+	ctx->target_prepared = true;
+	return 0;
+}
+
+static int cxl_restore_hdm_decoders(struct cxl_reset_context *ctx)
+{
+	return cxl_restore_hdm(ctx->target);
+}
+
 static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
 {
 	INIT_LIST_HEAD(&ctx->ranges);
@@ -672,9 +939,11 @@ static int cxl_hdm_range_add(struct cxl_hdm_range_context *ctx,
 static int cxl_hdm_ranges_collect(struct cxl_hdm_range_context *ctx,
 				  struct pci_dev *pdev)
 {
-	struct cxl_hdm_info *info = READ_ONCE(pdev->hdm);
+	struct cxl_hdm_info *info;
 	int rc;
 
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
 	if (!info) {
 		pci_err(pdev, "CXL HDM decoder state unavailable\n");
 		return -ENXIO;
@@ -824,8 +1093,9 @@ static int cxl_hdm_ranges_flush_cpu_caches(struct cxl_hdm_range_context *ctx,
 }
 
 static int cxl_hdm_ranges_prepare(struct cxl_hdm_range_context *ctx,
-				  struct pci_dev *pdev)
+				  struct cxl_reset_context *reset_ctx)
 {
+	struct pci_dev *pdev = reset_ctx->target;
 	int rc;
 
 	lockdep_assert_held_write(&cxl_rwsem.region);
@@ -866,6 +1136,25 @@ static int cxl_reset_dvsec(struct pci_dev *pdev)
 	return dvsec;
 }
 
+static bool cxl_reset_hdm_available(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info;
+
+	/*
+	 * pdev->hdm is owned by the PCI device and released with pci_dev, so
+	 * reset-method probes and reset requests can test availability without
+	 * a CXL driver bound to the device.
+	 */
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	return info && info->hdm_size;
+}
+
+static bool cxl_reset_scope_hdm_available(struct cxl_reset_context *ctx)
+{
+	return cxl_reset_hdm_available(ctx->target);
+}
+
 static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
 				  u16 clear)
 {
@@ -995,18 +1284,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
 	if (rc)
 		return pcibios_err_to_errno(rc);
 
-	if (!pci_wait_for_pending_transaction(pdev))
-		pci_err(pdev, "timed out waiting for pending transactions\n");
-
-	rc = pci_dev_reset_iommu_prepare(pdev);
-	if (rc) {
-		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
-		return rc;
-	}
-
 	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
 	if (rc)
-		goto out;
+		return rc;
 	cache_disabled = true;
 
 	rc = cxl_reset_update_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CXL_RST,
@@ -1030,7 +1310,6 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
 			rc = rc2;
 	}
 
-	pci_dev_reset_iommu_done(pdev);
 	return rc;
 }
 
@@ -1051,11 +1330,24 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 
 	cxl_hdm_range_context_init(&range_ctx);
 
+	if (!cxl_reset_scope_hdm_available(&ctx)) {
+		rc = -ENOTTY;
+		goto out;
+	}
+
+	rc = cxl_pci_target_reset_prepare(&ctx);
+	if (rc)
+		goto out;
+
 	scoped_guard(rwsem_write, &cxl_rwsem.region) {
-		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
+		rc = cxl_hdm_ranges_prepare(&range_ctx, &ctx);
 		if (!rc)
 			rc = cxl_reset_execute(pdev, dvsec);
+		if (!rc)
+			rc = cxl_restore_hdm_decoders(&ctx);
 	}
+
+	cxl_pci_target_reset_done(&ctx);
 out:
 	cxl_hdm_range_context_destroy(&range_ctx);
 	return rc;
-- 
2.43.0

