Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FFD39F18F;
	Thu,  9 Jul 2026 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559043; cv=fail; b=mr4Uk2VrFaY5ebhGGXmrRW2XsoSQDv/ytsxC4Ue3OVJFRE7lFjsIBriVNAJH2k4YD09UYqogGGCX/yQjKa0dmLBC3jTUeLSsYMDb1fKkED0qK6MHF6CJoSE1yLbIoNavIeLiYkrBYtf6VKnwFsEEYgkJLoCkyUxHiqM61g+dZGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559043; c=relaxed/simple;
	bh=Rr1PILbB/B54dW49SvwOVjfNroY5umR2avhhJOxtj0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M7FhawQHHxXE1G6QibrGr8hNhJVbhc2Ngm0FZ4f/L9DfFnqhQoHG5E4g0IlaD2rtrZ2eHdNseDRB1uE7aF8XD650oNjjBSI3HPKd8NoUbZ+ZWGC9+fbdkQFX+WgjmroXn7WTOkZwOeW0CbzFwellHWh+maLUYFsqrbv784cL/f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C4c6yAdk; arc=fail smtp.client-ip=52.101.48.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C4c6yAdk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyttqOFnEjJ5Kao3TndCTwscI/10/pX41LYpUrfHUPMoB6UUcH6j4uSmurhzizHEaH7gnzavZBwydykfcsmzAGNNCUYTvZM+wQtsow3W9SRH8cx6fiaw313OIvpraN0mleqTqFUw4/CgF7a+i4OhO3pLwDI/4S/EtFxUvXfsArodVv5SCCiUz560HP3xVEf9TWa9qRuDKCoiBidLZRfZezqt2GmSgL2LP7stW8hew/2DPY5c+vdhvu2yOeSaXQE4pFFsGxMlSKT6UMEWKbA3tE+dPzBX0fHySu9zARLHSBXzAup9/VzsGxtzsjX7VKUSlh4l5mD/awa4gDe3iW8ydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GypiP4RgZT8ftyQ41OxNsQwJsO6tSLxgxKdBcTnRXUk=;
 b=OQDJRv9oojE/LOz8TNznJaDW5sp3v2XgUexBFZPnNcM3fTHyNX7Ytc6Bf1X1aUixm4Chf3XhQrci6OKtzp38qbAjQp7TNymg04Qo6Z99IHEzfgSMMNbPtjsi0h//aDpM+16xcKWpv3h2K/nbS0LUjYO1AxWhKNtO7DYp6e9cNDdcwY7NA4KWMUe9mQVTBKOGemAkDF84gFI4fpPhi6ogM3jAtRnzIo8md9woNba6X8kozo8k5Sg3ZfW98eR04NqM/gGSXACRg57uXb1m1brUfMT/kfC2PITSqbKLdkBpNMt6L09y/Uxz8OKDecOrgCSnTjmOd0Y++4Ld4NkGITl6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GypiP4RgZT8ftyQ41OxNsQwJsO6tSLxgxKdBcTnRXUk=;
 b=C4c6yAdkxspXnuPSHp05wOY9MWOzcGAchfXwMwvYCYp63jKke2+N/1r00YJ5L9bo93PstKzLiNrUB05MPQ5JLOC4XqVvWBvZa3ZoL+1zz9hYxBtt+Y26sEeiv+kHFh51YZ9WSmmjyhHL79e4aIfbTTZHzIgGEoHGSFczqPfkkcGXwuRNmhnIHiBxM/xHxznh+pNA23fTbMFT0z0/CFU4TAt/MzyQY6GTPj5Shx9IMjB3RBEMFwsmxYoGtPHegS1qwwv4nQJQJxnosk+wzzsAh0z+GJsP6WGFDnuaLxJfvj3woXyG5tsFsYeYzulZ1IrLJmkitVFCFX7U6kXb32T9BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:03:57 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 01:03:57 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
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
Subject: [PATCH v9 08/11] cxl: Restore CXL HDM state after PCI reset
Date: Thu,  9 Jul 2026 01:03:01 +0000
Message-ID: <20260709010304.680422-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709010304.680422-1-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e8a356-c3d0-49b5-9fc2-08dedd55f406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	pDoWhu1sUbZzCU+p4smCXJS38EgTlJU3gs5R/UDTB5I61CYB7XLUkQQOf3985tYh1pUjUPmJMLWzrCOx9MMttuN3oGRHKa9ORqVOpqHjL4FxUW6Ap+me9QsV9mUVEriRkTrrivihMkrMMPnBRUHi+9w3sxNYuRzKhoG1MUtm7KJGFZJ2A5FxUAJx17OFRNqqZMmxZSe7Gm/scMlvahQnibQ+wgEDb6DW1Zjg6WtBveWh5s9iFPHQc2WpBUbIzbK2ipacjNpMKgpv6KT50EWMggzcBvlsRGhIV4LZIen9jQHUbSN0zpbVME+RN9CxDEvbXT6E3kk9+haKTQJK1VuG4b6IGDDlPDpJc0TpP2JfTuViQBd7xEyOlW8xcXipmop3bD05fYYr6ZUk5UlGPKy8Z3ipva/+HZzcn4g++hS3Fjknc/ySvFil1ROnmTdXED7drc3JcKHszprtSGRd+QwmP5Dg9Yn5mvf7vC6ThbeU1qLzlzsLO61eu8fU7vaB2KMIiAgRfqXoh00a7BBxzyBdd8BTo6cNseG7NsHLr/EVqwLFWrXDkX/3di/vTJq4TKn4KtJBYMYkBmO4ERa8oUnjLK5YcCL70PuqLEZF5p80bajGZp0r/yoZumVlgZeHNzZZMaVdx/CT/TKURoBV9UEPgyCHDW9H+F7S9xASmECphUySy0gyKpVo9TFEH2wHyfUXxZQ7V78BuM4RjTV+5/n7/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cHE6i7f/QuLmYwsQKVMWE9WOrKs6w3H3tKuVW8RNHtRbdhPZXuBOM0lKWBFa?=
 =?us-ascii?Q?7RoGjAuEkVXvwPvfsPZ2Y8hithgPt7/osNx9OLQ5t5aqvbv6NjIrYtmUc+ry?=
 =?us-ascii?Q?uv7UkjEn7fHgr7PT+Vdy6KYvVFNjM7Sht4ML3F41iU04mtvCV2R/gziV1bDl?=
 =?us-ascii?Q?biGGPAiKyYDWaysvbC97y/sZSgVB5Jut2Xzi3QXsMSimmRYvzetKP9U5f3fG?=
 =?us-ascii?Q?QiHlI7pbbFCiIEZ989ZFcYVKrdhkcAZUHzEKyzCIFt0PbBCT/OKPD3ejROjv?=
 =?us-ascii?Q?W+S4UguB1vciAx4YvTzy6oB/ZXcu7fn9UHl3QpeJFwcxOA4euqtlugP9Qh8r?=
 =?us-ascii?Q?rOfIj8slfVSkiG21DtCJUKPyBQtTlJe0u8kaYyZ1AWd4wuV47GWCredqpp0R?=
 =?us-ascii?Q?ueepV4hc2GlEfjuBjRttuaK8vj6X7j2cnyTz6fShFGbEg0Yg8pDUJf+7qSly?=
 =?us-ascii?Q?OrnQRVyqrRvZR9wP2xZsQICC9OVD0sFcV8kEnD8GiAGsaUFczZTBNfPHObHr?=
 =?us-ascii?Q?Y/kNL5cyVCiewnAvZyx6/VWAdB5ZIimjY17+Q7jW3CyPtahedT7CL5x907yn?=
 =?us-ascii?Q?SBAo4ZnxckGLhdwXtq2iA+a37EqFIMhaefWMZvZ+MiQb0LE8ZPiH3bnryMaY?=
 =?us-ascii?Q?NCi3zUaK8zU3Sft/zsux1JIYfbu34VRTAhBJU1e/ViwBqE48p9gCeDqPNpsd?=
 =?us-ascii?Q?JIFxTfyNym3bQFmP1DWjyUQ6SiFJZSeqwlvLf90b1F1xcC4I7h/4yY7S3kiJ?=
 =?us-ascii?Q?UnhaecwwXegRXQJZ2e3sJBYWvQmF4BDfs2ozub6ccAI/HFjZSYFhDYSWxKt0?=
 =?us-ascii?Q?QcQU49L7qU/p30TzqB4unwInGPQcMC5OuqELjUac5B19QBdMrMDX97qwJrFa?=
 =?us-ascii?Q?pRSM8Kiq/F2QFFt1P1+DuUhNHt2ar5Ciuy7BmmYLGoKWD9i30/HA8QJn9Xpm?=
 =?us-ascii?Q?jmqyXk0udrCTG4NZcvsueSxnpLvcDNe6B0dNk+36llKmOe50a2b/49CEjLEU?=
 =?us-ascii?Q?uOXz5+6fCyQ7ACQdoaxfVT8S/ZVKSD3KXIu7OJUP0u2PKpUIDGJsx3fQ1LXM?=
 =?us-ascii?Q?gkZoUKbbWPRbGBt+2ufID4XdxJmGUmfoIub1rQcKYO4RSJXQIr/nSnKoLuCX?=
 =?us-ascii?Q?MtL4FR2R/v9QEsQkKYo2g9ifYQsAwUrw9V04/CauZoS4uuihnN/ZhwFXLqEW?=
 =?us-ascii?Q?xppaCR7MVqNKR67PwSoGyEjZNBCy968BTQQifxDv9Y7z+w9icQ/iWY8CAb5k?=
 =?us-ascii?Q?gg7kszqgfgaGkJvzFp5EuwJ/r016gUuqhc0Eri85ao+s4pbxFva0x+KPcs35?=
 =?us-ascii?Q?AF/zsoEm+l1CuBIqTDOS5qPzUEqJMrcLr2VZvU3Qygcg9CJcRwBGisgX5wY8?=
 =?us-ascii?Q?pTaeIjWQoQih15d4b/yCpXR4SMWfPm6nFo+WJXwsHQ0d/EQeX06FqOATYiDo?=
 =?us-ascii?Q?OmNDwVqwFUdZO5HC1gUo1sPp6iluRr3Mn/m72lqytYTnRSqgR9xw9G8pPiw6?=
 =?us-ascii?Q?kmSGjkc1/AeTrYvoUVKVyUHKm/It3muEV5AKP/NZYsjG/w1inKGq3NNJI2DA?=
 =?us-ascii?Q?oc779jbWr7cfSul+ByEY5Ag2K1+Rs7rTLb+9bt7mnTcLjwcUZTkVE8yEmK2X?=
 =?us-ascii?Q?yx+JbNp4Ib+WpMIXJSRFhtCPqtweBvtqrWDT7PegpFeMTD3dAlBW2o6iJU0e?=
 =?us-ascii?Q?+CmVWA2royBk4Kk22Igf7xgkb0qrzr8pfg8YlgV/KWoUQ0k8kX8StvPlFto0?=
 =?us-ascii?Q?aw3u+89A8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e8a356-c3d0-49b5-9fc2-08dedd55f406
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:03:57.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2v2Ck8Uk8p9GCde4iFRfqN+rqPc6V87SwY2cteECCR2/QYmeFy+29i3ZqT45/gaqiLwM0VxUf73DChUMZHFWbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

After CXL reset, restore PCI config state enough to reach HDM MMIO,
restore cached global and per-decoder HDM state, and then run the normal
PCI restore callbacks.

Keep the target IOMMU reset block active until HDM restore completes so
Bus Master Enable cannot reopen DMA before decoder state is valid.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c   |   4 +
 drivers/cxl/core/reset.c | 321 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 311 insertions(+), 14 deletions(-)

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
index cdfaa699583d..f708c7b80acf 100644
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
 
@@ -1051,11 +1330,25 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 
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
+out:
 	cxl_hdm_range_context_destroy(&range_ctx);
 	return rc;
 }
-- 
2.43.0

