Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE002488DB6;
	Tue,  4 Aug 2026 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871822; cv=fail; b=nWb+tLEjA8v+TMAwHEd6P7ZV17TJPPVtkeg5UprgT7W0ydfol916SLe2rD3VHUHILjpgDYjnNC8sr8SSnWKJt+qH50PPnxMHzeNUwwPHFis8s93D5jh8ooxoPQMKyEh6Aly8n0TZHtrkW3lnnlBmKKWyKGcEIQv1qCUbPXFfiJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871822; c=relaxed/simple;
	bh=SrnbJB9b2cEheFAFAf/d3m3rTtO8SqEYF/lZTN79US0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SuE9R8pxu3BijOhRq8Z83JASVNl6Tl0aOM42B7Qg8KA2VqUrvyxS3r1u8rt/0wLjH2IaF6aMjcv18wVTIK3iSB1OAK20Dj2QJPcOspm4ulb/TO0J4nRhnYV+7/2uj3ryMIP/xv4EejJVTt/hyoRu4vAepIOI7Wf5aizka4wX3yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XFhVmDeC; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XFhVmDeC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1gBAFVo98gyNK0+Q49FmPib0Lyr0Q2Ddz8lac2Ff5zBTSdr0Ki4wuIQeDBxOF0BLfgmuHVA/bsfYidktb++rMW24IZ9WnQRhG+vEBOLvwb4lDA73hvIBeI/UpoNbzvnlMZDcReA345D7Bzgqafumrk7B5kbnwPIutZkM/I95YMghh87OTyz5/gxiMkTyXjg2p+N83+VlXF2xaRRCiDxwG7BYWunnhYSpbBl9ImdzzaY+A9kHtQpb5LapPURJufR5IlwbD2cJOSf6WqPGmdIzzfaPnDNC9JXfWiAcRoVlwSrnv5hv/IGi+AzSH5sLxpAI6mZFQQ0lX8MmcXN29Ij7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+udWGcHRv/jVa9O5+6pqM9DYqEzywtqCbJ8/ydgzEd8=;
 b=UXchXu5+OTP8PxWtSHSrXEbbPGUF4iOeETflZ5d9cm30PGTTQSLbXyyY5NQSzMd0lYe/vbusmsfXYz11kdorxtY4yd8hBq6OjS1Hsswrt/tQne9cpYzdHv2+utl/xHpTGTVSTqN1TIF8YmyZ5cFLGHHFRF80FaMMXaAmYLE4SpViWawRJ/T8hr8JBd1TtulOxbBdqm7BDjDMJJ61dVsdZw6ja/vL2+XlrFEmzrx8tLALYOu2QeHO09hY3QzyBf8ApBgcETxow+f70HLO0nhRdTDsQLhadcLPqvjFTfzkwOTtbb8H+obV4Ck9N0q3CLYXyPQyeBuiYFMdrzK1t0JqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+udWGcHRv/jVa9O5+6pqM9DYqEzywtqCbJ8/ydgzEd8=;
 b=XFhVmDeCo25nw9W+qD0PzLZ4WSx6YBbpPDJ6ZOdHy9Qp5CvjK6kI2aAO/ZvOmupvcwPmoXL9TL32tM9ku7oPb5XsZpltnuLEDxRN0wmleOgeXWCZKWMJ1zR5tIgmxy9kitE3jPegqjxBUOqBES13Ghapi2Ad4iGaI9RqBSvD8tkXzzq5NjhabQxcE1du7UqAZMQDfMxrouGk6sWz++mav1/X7LSF3Y0OOVj9MPXfnmPWskOdL2NHxBtg1Ey2ux3KmhYVpqQ9BPb/BujtI1RUR89Ly0SzfPffKz4iuNxwYNEHsP4yty21MMBCk3DndPeBZHKJxfQpJAj1QxGLXC/Rgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 19:30:12 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:12 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v10 02/12] cxl: Pass decoder settings to HDM commit helpers
Date: Tue,  4 Aug 2026 19:29:48 +0000
Message-ID: <20260804192958.1823952-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::26) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d63c2b-4e4b-4ec9-8263-08def25ecd8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	NoTPqA2YiTBgURgO8r7JokFxK+DaLzFvpFSPgnGnhXdpWLPUoV7xwXeLB/WE3nkXToJH3p5sOUo6VKx/uHATzQLNyDv9cvKxpdoNDOpF9+4ieAFbRPxMuZLjGr/2CtBHNKrGatN0BmmxmhttOOjKVBu0awR9EQdERUwh5HOGIGpAbE5LVN+P7v44SvfNYAvuQUadTrMWyAm+pJ824eF5kKTxn1d4NQiEQ3k6yJxBPdybSfPj+eIxxtYaH+KuGvJra18NIUHK2lN4c+d5wdTg1vF7QU8ubzBa/jWlXckgANlKm74YaYIiwiCmeavye/vh6soGpTgyDBmwEHEan+dQlgOZGmf8L/HxXGbHBZAGbRwjRVQpcL0NePO7tYZauy67jF44nqDAQMod/ZhCOTVxW29M5uMXu+ubU59GZVAiXRE8vmVsqW26Nytjvd6TnQSpyvGBnzi12UQGT0IMNbKs+Ouno75WEDsKY1QI9SnLFxUapHfm7A2oTVRKed+QlxkOaPjW1sG+lLk+FqBszZUbTIWyXqqBR2bXZmcrS2MrWZr0lIEjp8BVk6OoWII+7hc3yk2l1/nCuuT4Ltc+1+qWRC9j9BOYvWC4fF6MYQIdeyyeINebnB50MHCMPz8ZvERxk0sJ9nrqMgXTuW4c/L3cWUayu1iByAP6yD3xHuw4jhWmI8oAUf75nviExpMadGKTlB+vRlAXyK1Y5yqtNTP/0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lsNAdHiN5RofgF1e529zOUj5FBQvS5Hr7eU2IOK6lXxMWvdIkw7KJJfVGB0E?=
 =?us-ascii?Q?4O/OHyxpvPIc5eXfP0jUHpZ+UcN5nHJzqdyvVGCebTVeLVXQCFuyDUje/oF/?=
 =?us-ascii?Q?Pw6sxYeWsP+QcChY2YuqTOck9LkYwU7cxhI+ox/wXdnnR3PL4KAFxFv4HKXe?=
 =?us-ascii?Q?ijp9bbDgqWlsD+dLFgtPiAFz9u9PDILfwlEh6llP+19Vf2hrzDENudv3NycQ?=
 =?us-ascii?Q?OyXzOGGGOB58Hf3QYFBwheGVdjvdYcVe0Rj6eth0bN+iKojuCOVGBEkQTo4a?=
 =?us-ascii?Q?TglYss2i/WPfTRQ9LTr3eR1wSNmGUXGMiKD569K0uqeELArPzGmeSSBcSw6m?=
 =?us-ascii?Q?QNzIXlsEW6di4Lhog5nuyr5Jrvn+cdXi1CQ/OKOfDTShH/C+nhT6bIKAegRv?=
 =?us-ascii?Q?0WJHiYT/KJnXkwOgESffQZiMSsThgIHlmSHigSyb9qUVPNF9n/dngEVKlKI6?=
 =?us-ascii?Q?9I/jG+c0sNZcu3UeICT44fhreWOdlX+rlSFNCV81W62Jpi4k43hl+QCNWSzJ?=
 =?us-ascii?Q?dh30cjPOQWVJQBsbQ3nANQZgIQqE4koWflcWNiHJqpgRvmFLf4RiQZUo9AOu?=
 =?us-ascii?Q?K8wxy9kCwUWmuqjU5umnXyh3mCF3Q7qCzrre8OABGfvYUJHO+kWD+rEyM6Jk?=
 =?us-ascii?Q?ga02iCMWT076EjocTTOmEDfTROgYt7cCe661v/fiOsGZ6RnsqZK3vojYRx2z?=
 =?us-ascii?Q?Abq3e/aGU/X7oVZ+bKnISyyITs87DqmQ8+tiAg1hxZx5u44UKQFeXiIMD+el?=
 =?us-ascii?Q?AejRi7bMG1bBnMk6KtR/3Ftm3u6tFriQbqQWHS2t5eoy/FxKJqBlFVALdQ2g?=
 =?us-ascii?Q?8uP4RLvl3jtMQuuKA2X/Et2HPcOsrL7PuOtEFXDVDUDXjXq9JQjhXccQEGrT?=
 =?us-ascii?Q?U8gGQaC7NSw8UZF6Z654a4VMAKsXtHw0Ncm0AoI4XCXvFGh9kVGH7z5qRcvv?=
 =?us-ascii?Q?d9+hYE4Y7KkmBBk7t3b9Tso1SN8gdg7YbIr+OcYH9/YzbE5RkWPLfm2t0A/N?=
 =?us-ascii?Q?CVcx0G36XYpoS6hXGuHaaMDDD+nfCexyvclSzFUxB16EV9BoLNf94vYZSiN8?=
 =?us-ascii?Q?9COfMkTh/pjuiY27lsgry4Hm4Z4bxPWrRxXFo2Cl2U70sl+pvhmDh9Vk68Se?=
 =?us-ascii?Q?VObgUw6YT4KQLsJSr6lyeJYc/LsblfFuzumLB3LzvH/FenOhpFJtxRHGGjZ4?=
 =?us-ascii?Q?N+CesmEbtv3pCQ38iftoKxMevFkw6ShqXt18o+5fEVWCOYu9va2nEUMgr3Kh?=
 =?us-ascii?Q?pANKoz+h/dILvrm9S7MQ2hTFs/wOvvDd+IB3Bm4TX/k7wgP1YEyd8RU3nwe2?=
 =?us-ascii?Q?x0PJk3kzLCueK/PPyTOHGd2Wr3AikMJXS9+GTI5Gv+x2uQ45vb3/mGPALJpC?=
 =?us-ascii?Q?y5ksubiYu0p0EYwELh9CYzKZiZRtBfGKKm5w45yQn3YDHU3iMMmjUlAI2dIC?=
 =?us-ascii?Q?uXGUuuI6GRTl9q/7P5tH6ygLcq0TJ55NcZF9zkn+XhYpvG2BZrJD0BSqiwVv?=
 =?us-ascii?Q?pIlq78qVD/KRXuIXEaZUc+9+b2kC3Hc3OlRpKuKqfa9g+99A1J57eN4ZItNK?=
 =?us-ascii?Q?FRhBFB4dJi4QRVu3eN/OrV0AL5qPamyWMVvdGRViTfVJffwrczahy6iw70Pt?=
 =?us-ascii?Q?ukFDi/tCcYte97vn9etJM+S5D3mVmFL5T1No4sLDYNx9ytKac/T4AGVh0u8C?=
 =?us-ascii?Q?O1z6XTScMlXI5f13VBJ9PXFgEDIv15b9E1fl1k46MqOx3OLI0lrKBVAoH/2H?=
 =?us-ascii?Q?bmEGbuK/3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d63c2b-4e4b-4ec9-8263-08def25ecd8d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:12.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRUV3talm8QQQ5ozsmzSFIQilrplqLVgTiyQMydC7cNDektVWO2Z/VDy/0iTlQtu54jhk6wQNbnGz5XCT7oymQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

Introduce struct cxl_decoder_settings as a plain snapshot of HDM decoder
programming state and pass it to the shared commit helpers. Keep endpoint
skip and switch target-list handling in hdm.c, where the endpoint and
switch decoder types are available.

Split the helper entry points into cxl_commit_start() and
cxl_commit_wait() so hdm.c keeps the existing DPA-lock and commit policy
flow while later reset restore code can reuse the register programming
sequence.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/core.h     |   5 +-
 drivers/cxl/core/hdm.c      |  72 +++++++++++++++++-----
 drivers/cxl/core/resource.c | 115 ++++++++++++++++--------------------
 include/cxl/cxl.h           |  20 +++++++
 4 files changed, 133 insertions(+), 79 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index cb6853a92a93..1426254e6657 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -211,10 +211,11 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 
 struct cxl_hdm;
+struct cxl_decoder_settings;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
-void cxl_setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm);
-int cxld_await_commit(void __iomem *hdm, int id);
+int cxl_commit_start(struct cxl_decoder_settings *settings, void __iomem *hdm);
+int cxl_commit_wait(struct cxl_decoder_settings *settings, void __iomem *hdm);
 int cxl_port_get_possible_dports(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 6ae0b9f46ac0..9047b190c35a 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -16,7 +16,6 @@
  * for enumerating these registers and capabilities.
  */
 
-
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 {
 	int rc;
@@ -675,12 +674,44 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
+{
+	struct cxl_dport **t = &cxlsd->target[0];
+	int ways = cxlsd->cxld.interleave_ways;
+
+	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
+	if (ways > 1)
+		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
+	if (ways > 2)
+		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
+	if (ways > 3)
+		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
+	if (ways > 4)
+		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
+	if (ways > 5)
+		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
+	if (ways > 6)
+		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
+	if (ways > 7)
+		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
+}
+
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	int id = cxld->id, rc;
+	struct cxl_endpoint_decoder *cxled = NULL;
+	struct cxl_switch_decoder *cxlsd = NULL;
+	struct cxl_decoder_settings settings = {
+		.id = cxld->id,
+		.hpa_range = cxld->hpa_range,
+		.interleave_ways = cxld->interleave_ways,
+		.interleave_granularity = cxld->interleave_granularity,
+		.target_type = cxld->target_type,
+		.flags = cxld->flags,
+	};
+	int id = cxld->id, rc = 0;
 
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		return 0;
@@ -693,29 +724,42 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		return -EBUSY;
 	}
 
-	/*
-	 * For endpoint decoders hosted on CXL memory devices that
-	 * support the sanitize operation, make sure sanitize is not in-flight.
-	 */
 	if (is_endpoint_decoder(&cxld->dev)) {
-		struct cxl_endpoint_decoder *cxled =
-			to_cxl_endpoint_decoder(&cxld->dev);
-		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-		struct cxl_memdev_state *mds =
-			to_cxl_memdev_state(cxlmd->cxlds);
+		struct cxl_memdev *cxlmd;
+		struct cxl_memdev_state *mds;
 
+		cxled = to_cxl_endpoint_decoder(&cxld->dev);
+		cxlmd = cxled_to_memdev(cxled);
+		mds = to_cxl_memdev_state(cxlmd->cxlds);
+		/*
+		 * For endpoint decoders hosted on CXL memory devices that
+		 * support the sanitize operation, make sure sanitize is not in-flight.
+		 */
 		if (mds && mds->security.sanitize_active) {
 			dev_dbg(&cxlmd->dev,
 				"attempted to commit %s during sanitize\n",
 				dev_name(&cxld->dev));
 			return -EBUSY;
 		}
+	} else if (is_switch_decoder(&cxld->dev)) {
+		cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	}
 
-	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
-		cxl_setup_hw_decoder(cxld, hdm);
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
+		if (cxled)
+			settings.target_or_skip = cxled->skip;
+		else if (cxlsd)
+			cxlsd_set_targets(cxlsd, &settings.target_or_skip);
+
+		rc = cxl_commit_start(&settings, hdm);
+	}
+	if (rc) {
+		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
+			dev_name(&cxld->dev), rc);
+		return rc;
+	}
 
-	rc = cxld_await_commit(hdm, cxld->id);
+	rc = cxl_commit_wait(&settings, hdm);
 	if (rc) {
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index dd8bed3d3ff0..dd5e0cc82da4 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -15,21 +15,22 @@ struct cxl_rwsem cxl_rwsem = {
 };
 EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
 
-static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
+static void cxld_set_interleave(struct cxl_decoder_settings *settings, u32 *ctrl)
 {
 	u16 eig;
 	u8 eiw;
 
 	/*
 	 * Input validation ensures these warns never fire, but otherwise
-	 * suppress unititalized variable usage warnings.
+	 * suppress uninitialized variable usage warnings.
 	 */
-	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
-		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
+	if (WARN_ONCE(ways_to_eiw(settings->interleave_ways, &eiw),
+		      "invalid interleave_ways: %d\n",
+		      settings->interleave_ways))
 		return;
-	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
+	if (WARN_ONCE(granularity_to_eig(settings->interleave_granularity, &eig),
 		      "invalid interleave_granularity: %d\n",
-		      cxld->interleave_granularity))
+		      settings->interleave_granularity))
 		return;
 
 	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
@@ -37,42 +38,20 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
 }
 
-static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
+static void cxld_set_type(struct cxl_decoder_settings *settings, u32 *ctrl)
 {
 	u32p_replace_bits(ctrl,
-			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
+			  !!(settings->target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
 }
 
-static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
-{
-	struct cxl_dport **t = &cxlsd->target[0];
-	int ways = cxlsd->cxld.interleave_ways;
-
-	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
-	if (ways > 1)
-		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
-	if (ways > 2)
-		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
-	if (ways > 3)
-		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
-	if (ways > 4)
-		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
-	if (ways > 5)
-		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
-	if (ways > 6)
-		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
-	if (ways > 7)
-		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
-}
-
 /*
  * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
  * committed or error within 10ms, but just be generous with 20ms to account for
- * clock skew and other marginal behavior
+ * clock skew and other marginal behavior.
  */
 #define COMMIT_TIMEOUT_MS 20
-int cxld_await_commit(void __iomem *hdm, int id)
+static int cxld_await_commit(void __iomem *hdm, int id)
 {
 	u32 ctrl;
 	int i;
@@ -92,47 +71,57 @@ int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
-EXPORT_SYMBOL_FOR_MODULES(cxld_await_commit, "cxl_core");
-
-void cxl_setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
+static int setup_hw_decoder(struct cxl_decoder_settings *settings,
+			    void __iomem *hdm)
 {
-	int id = cxld->id;
+	int id = settings->id;
+	u64 target_or_skip;
 	u64 base, size;
 	u32 ctrl;
 
-	/* common decoder settings */
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
-	cxld_set_interleave(cxld, &ctrl);
-	cxld_set_type(cxld, &ctrl);
-	base = cxld->hpa_range.start;
-	size = range_len(&cxld->hpa_range);
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
+		return -EBUSY;
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT)
+		return -ETIMEDOUT;
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR)
+		return -EIO;
+	cxld_set_interleave(settings, &ctrl);
+	cxld_set_type(settings, &ctrl);
+	base = settings->hpa_range.start;
+	size = range_len(&settings->hpa_range);
+	target_or_skip = settings->target_or_skip;
 
 	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
 	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
-
-	if (is_switch_decoder(&cxld->dev)) {
-		struct cxl_switch_decoder *cxlsd =
-			to_cxl_switch_decoder(&cxld->dev);
-		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
-		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
-		u64 targets;
-
-		cxlsd_set_targets(cxlsd, &targets);
-		writel(upper_32_bits(targets), tl_hi);
-		writel(lower_32_bits(targets), tl_lo);
-	} else {
-		struct cxl_endpoint_decoder *cxled =
-			to_cxl_endpoint_decoder(&cxld->dev);
-		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
-		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
-
-		writel(upper_32_bits(cxled->skip), sk_hi);
-		writel(lower_32_bits(cxled->skip), sk_lo);
-	}
+	/* Target-list and endpoint-skip registers alias the same slot. */
+	writel(upper_32_bits(target_or_skip),
+	       hdm + CXL_HDM_DECODER0_TL_HIGH(id));
+	writel(lower_32_bits(target_or_skip),
+	       hdm + CXL_HDM_DECODER0_TL_LOW(id));
 
 	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	return 0;
 }
 
-EXPORT_SYMBOL_FOR_MODULES(cxl_setup_hw_decoder, "cxl_core");
+int cxl_commit_start(struct cxl_decoder_settings *settings, void __iomem *hdm)
+{
+	lockdep_assert_held(&cxl_rwsem.dpa);
+	return setup_hw_decoder(settings, hdm);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start, "cxl_core");
+
+int cxl_commit_wait(struct cxl_decoder_settings *settings, void __iomem *hdm)
+{
+	int rc;
+
+	rc = cxld_await_commit(hdm, settings->id);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_commit_wait, "cxl_core");
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 05a8bc32138c..85e895d9b31c 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -32,6 +32,26 @@ enum cxl_decoder_type {
 	CXL_DECODER_HOSTONLYMEM = 3,
 };
 
+/**
+ * struct cxl_decoder_settings - CXL HDM decoder programming snapshot
+ * @id: decoder id
+ * @hpa_range: Host physical address range mapped by this decoder
+ * @target_or_skip: switch target list or endpoint skip register value
+ * @interleave_ways: number of cxl_dports in this decode
+ * @interleave_granularity: data stride per dport
+ * @target_type: accelerator vs expander (type2 vs type3) selector
+ * @flags: memory type capabilities and locking
+ */
+struct cxl_decoder_settings {
+	int id;
+	struct range hpa_range;
+	u64 target_or_skip;
+	int interleave_ways;
+	int interleave_granularity;
+	enum cxl_decoder_type target_type;
+	unsigned long flags;
+};
+
 /*
  * Current specification goes up to 8, double that seems a reasonable
  * software max for the foreseeable future
-- 
2.43.0

