Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CBB396D14;
	Thu, 10 Sep 2026 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024132; cv=fail; b=HjIyAvyKiMNml02AmImHKdbglGD4As6tvruEMpeEPDs5n6Ct5XazMwWa1X991Bzl8Zo5hfcqw45vK27vI8WC//SXFmt/6s3BjbixAFRg4NcooRM5gReFpMFWOqCRk0out8pKsbtGcPJQd9weB8qxrkMoVx3dcZhtasJ/x2qjFRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024132; c=relaxed/simple;
	bh=zIKAjpjcamAHIrvTsweYCyPu6aAkRKVNZbTZMhxw8x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZLnNROh29qH0RLDTmBLwb4XYXP8/Rh5bzmSW4gGs09dmLweWJfCavYJdux65a62E0323afOxc0H7v49zeEbt1Ik60xs6dRGfZvPTsrD1Eks6QX9LLI2+JzWf9/51FJ2vwPlFF//sD/kwas3lWWU4kLWMqmmxzDJdsJ8P6c96sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BuQdSYXi; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BuQdSYXi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+Wsmw78MqcZK1VS5hYhSTHBLpwTNGq5aq53rD6Q4U9NtUWJK2InYafUZAEIJXCKxxTPOoNZcnvrnytHdyMI6GU8DogLaiNoSQ38runInBO+ZwrrNbE6cTL2q6PtF26+ym7QsU2oJKq6Z3EXCgTpajIXVZykWCaoPHWaLTpjchJLhnvsLeUp9EeGHFwqgdQdeQ7p6QsrBQi3gybhsHStvOIDUP3Fh8xtZS9kR5OJKxUesO2PAUz4cXHMt1ouJtdRcYymF78CsFRWAHDBA0Y2CEAuckPTffd2GD+2mVKRkNN/Da00jJGlMiwBSr7lomg7sx8duGHfFJ+4J5Io8QOlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJ17mzLxD0l0hVsijqb/NWWgKxUy8vZ9VD/dYgjARoQ=;
 b=xVB8jKarCktJndqiwwd7Qzy1ZufZyFHeyqxQHnDcSzwCmCuBEHAEwekbqTTDScgXgsyookdM5ecF8rVQaaOB4Ocp1hL4aY19x+y/oxl1Qb1W/r6fcB5Aa0d41OPWeROckiPcUya5o4j8PrDHQWBMbF4US8WFUiXsTws+/oyzTDhNISGE1Vg3Ase+XmAwZKXx7lul7Ma/5n6UOmFpGjpQX/gwqhChdVFQEv/QPjH42GRxWWn4Cm8djVOEfw1Cn3Zdr+okWXP9QLYTnvLgOiKcfs8TUhnVtzycVW+jq2/KnrvvFiEWRfhqyihYpsF0YyOPVSR/eo7QWeE22tfKwkkK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJ17mzLxD0l0hVsijqb/NWWgKxUy8vZ9VD/dYgjARoQ=;
 b=BuQdSYXiI7NTnPAWjtYagBh9HAnZ4xFF7vtBPUCnYQc6RqQxwLhwxMJOAnExtopcdS++q+yTg9SLYETQRnC0HitZcQSz+wb/9NBMuo6aJfch470kjs4qzpp8WwWe9nBH7qaz+OzOnAcob5j3OztTGqTHzsJe2UtjlztYeIaMtVfsJoHmmQeCtnU4l4F02q2NLdmNM5AvOXUuYlRK6qHHJgo1VaYntLoc1/GzPOmbfb8gXTdvyK2XXkQH71pI0vfIHSTqs6bxrShgGGCB4EZUgDvaRUA2WWmiVhGpvYw8MRD5lZmla2eNd/U5ziqWFHx9M8QdtESGTysrqGQ6QIeWQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:08:25 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:08:25 +0000
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
Subject: [PATCH v12 04/12] cxl: Cache decoder settings on PCI devices
Date: Thu, 10 Sep 2026 07:08:00 +0000
Message-ID: <20260910070808.1444264-5-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910070808.1444264-1-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0146.namprd04.prod.outlook.com
 (2603:10b6:303:84::31) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 14243f98-eeee-4d1e-3bbf-08df0f0a4e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|3023799007|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	3TwwyRbD5aY97cHSOuF7+SXxx/2mQcKfy0mTVn48j7GJWNPfewO3m2tP+7pUcNwCEmTjT1KY6OCCoYC/HIYu4pSYmLXGAFaFqxxT+O4mAQ8DoelJ1Te+pjb+GWbwa8hviaRBsAmxEnu6Hv9hE5O3Mb60+bk8BkFdNLNzUYr/4G5xxT4M8Z5nrDMB6eTSpj+SPxF71ZZoD3yc6awPH2urrXadwLviLpXs3e1cQ4sLYQw5OaxedilTjW4jx8HGgPyEZ1UAG1XbipzslpmmynVbr+BWrhlkM6LyOoDPoaWtj2WlZxhLRDf2BZfXKq7NKBFPfJTiEJgSCuLArbhsTnBxFTOTVW3QfH9fR6rb3Z+bYQnkxz2YfzpZj17iHp6NL0xR6FhXqbrO5KiZm+hBgrez4nNW6+C3ggpENuOuAWt80q8NvV5He1YdZo92FXjiHaj8BGOXc+jJFzlob8JA6Q596r9VPTE/lx4zFIYiPZOPPJVzD/2SD+/oYCTT6wPQlLrwLlkgQ7wOd+Ln7wWzOUfk1D4wQA3tyVitQZA5XAPaYGbtl+XlOW6TnnWMpAlk1RLxxxDikTc5renakZKVfqvmXlX/fFZCb/69sEKdonBH+sJEMwiULUe31T68uUUsmCx6Bn35rG2IOHt+rEk/WB0orZwG1V2OpUi82Asv8wlBKV101xov5O0QU+bZ/AD0+nq4RLvALvoc+xSsHXCDjIjsNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nmfNY9JLzQgw+KhLcjitM8wvCmQkfd5yNTpBJ26o3UyDyN3lCSbH1zN/TGAu?=
 =?us-ascii?Q?+QoLYngFSdnXo44bSF/MPNqrlJF9Y+6wWHatWmhw9QbYggsgdXsKzFiuSg8Y?=
 =?us-ascii?Q?iNttwBf7ulMCcW5cHxMhA2HlWR8JvFfrxNfJ6Lt5msu3i4+mEobVlWGsf2dJ?=
 =?us-ascii?Q?5r8rw0w1LFrJsoCfIlgWrtxvjD2yyWoK1dQRcB+DMWy7B/Wz1Hr/sW4FVvNC?=
 =?us-ascii?Q?5O6QJH8G/uZB5jPtwxCBQASmy9PkXTMRmTFyclnqs5dcEGRnFbAoA0FXbjGh?=
 =?us-ascii?Q?fSy78shPyhHalJo3BziZHzNNXrSqz74eJk97gdYsdb+PtPgFiX0udd5YWHZJ?=
 =?us-ascii?Q?Nvx4LhNYV07k7mUAuQdbwv2KmwQXS6A3lPxlXKhmeG42Q9xta1snvS326pmA?=
 =?us-ascii?Q?LvLiMPNdxULjPi7XBaGPo095W+SdAVxhyhcIXmLQJ43UEEfHozlQWcKqaoXw?=
 =?us-ascii?Q?Owagg57yJ2VrH9gwZQZEM7F8fZGtx3YD7c6BOQTgBdkzXP+HEKmCbKqlm5Wm?=
 =?us-ascii?Q?cEv2nScJbaA8EftEm6EVLFYW+EK0xCKSnGlvhPndcKF0yHdIa+bggU9c8hiu?=
 =?us-ascii?Q?cgPQhKgvedhNo30s/czbPH90ne4sWOh2U4uL5WRq1lp56CJdy3kHjhsghLDH?=
 =?us-ascii?Q?jYrG9ATsxhqGYS+3pHVrsRnRFFpW2wNVgzQSRz1g2WQ73OxCnmjbP7Imo4XW?=
 =?us-ascii?Q?BMdWdT2Ww8sek7wRdPQnMUHRp2d+wjq07B/gG/fSvFsm9OkoV5vAHSm0CWZI?=
 =?us-ascii?Q?yjMv2kBURRV1bzzUFjy++5O3wzSHZEV7ho0gNYQTHqOSGhPWvrCMG9MGft+j?=
 =?us-ascii?Q?Ty8wsx8sM6emhyiVWYuqNVqh4S2EjDYwUFif1MS6+gYn+dN8I7aAYfauvPeC?=
 =?us-ascii?Q?07kd8MTvaE+O1TjHz9RDzBdluSVrN6MXk7tEJKlbO0xDe2y+pA0gKN6FSHcW?=
 =?us-ascii?Q?+l1kUIovGGSxYhFlZ/VoNRh7l1gWfb40d1xJQYIyFrYCdDYQ6eKNSGnFAG4E?=
 =?us-ascii?Q?qgMkVY2j0B4T43eOqBkjVSTUI3RRmx/gP3CgY+Wfc94oDhYNLXCrAw4EPUsz?=
 =?us-ascii?Q?aAxJobOemgHRO8zMTQsDX5SRu65TlLDgZ7hPK4aOtVsrAApBXaPNwMtmubJ5?=
 =?us-ascii?Q?u6z6knZxXtM7QtVTTxIG09FuXYasP+jHvA5jpZ7thfIYhGTxhHYIEXc2bh8g?=
 =?us-ascii?Q?/9kFtWW98+RCcMypAe6sTs9TGbe+CVP+/Su2aYcP6JXT/7qljrLib3KEnRRG?=
 =?us-ascii?Q?UzQd2WfSvUN75OKfKmxA/LvSI8rb6ZaHO2TqTpB6eoNlRQ8jgfEd3cGrRFZs?=
 =?us-ascii?Q?EiHvPPFkUmqCBS9vpBw8TBJEmgeyq+tY1ZGAhnWX+WttRRA9keyClI9MdzUS?=
 =?us-ascii?Q?M4yXnHXAu6tpZkEt0CzaxCBdorbIdcCL/NHYMtGqri5Clww75n6RQGVViRog?=
 =?us-ascii?Q?O8ggloGaMqu3TcTSBPHchsIxNnpYLTzgxycJ6TDwYXa+NayfadGfuzNHAxj/?=
 =?us-ascii?Q?CCZ8EBiKiXQHeScoR2hW1dC15oy94s9Wy9+V4QyfVXz2bGRrekM9boAE99GQ?=
 =?us-ascii?Q?GjA9iCSNMEQUzlKdbZzdCVSGPKrkimW3yCJXSXepqMeJ4yqblDps1XGNSUXy?=
 =?us-ascii?Q?mkL2Ap4prFtMP2JZmcwIHtjzpM1Kbs/s8rWrN+3CmZ5dWrfF3odXGIPHXvtd?=
 =?us-ascii?Q?uXQc+Rq6AMJjb8ENNVwY/H2YJB+je5GWuvhqEmz2s3cAB1+VCO0yxfiRp0OQ?=
 =?us-ascii?Q?MTZrni3TlA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14243f98-eeee-4d1e-3bbf-08df0f0a4e97
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:08:25.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2stpx9/Zhn84du3l70f6yuSjaMGpBWG5/1KoAxi9wCMwKWjqR2hEwilf+eVyiyJdEYZEIy29yiMCHhmL7CAhFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

Add CXL core plumbing to refresh a PCI device HDM decoder cache when
decoders are enumerated, committed, or reset. PCI reset paths can use
this snapshot to restore HDM programming without walking CXL topology
during reset recovery.

The cache is populated by PCI-side discovery in a follow-on patch. Until
then, the CXL core update path is a no-op when no PCI HDM cache is
present.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c | 68 +++++++++++++++++++++++++++++++++++++++++-
 include/cxl/cxl.h      | 12 ++++++++
 include/linux/pci.h    |  6 ++++
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d621d827f59f..0927036aed27 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -16,6 +16,9 @@
  * for enumerating these registers and capabilities.
  */
 
+static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
+				 struct cxl_decoder_settings *settings);
+
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 {
 	int rc;
@@ -84,6 +87,62 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->iw_cap_mask |= BIT(16);
 }
 
+static bool __cxl_pci_hdm_decoder_count_match(struct pci_dev *pdev,
+					      int decoder_count)
+{
+	struct cxl_hdm_info *info;
+	bool match = true;
+
+	down_read(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (info) {
+		if (info->decoder_count != decoder_count) {
+			pci_warn(pdev,
+				 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
+				 info->decoder_count, decoder_count);
+			match = false;
+		}
+	}
+	up_read(&cxl_rwsem.dpa);
+
+	return match;
+}
+
+static bool cxl_pci_hdm_decoder_count_match(struct cxl_hdm *cxlhdm)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(cxlhdm->port);
+
+	if (!pdev)
+		return true;
+
+	return __cxl_pci_hdm_decoder_count_match(pdev, cxlhdm->decoder_count);
+}
+
+static void cxl_hdm_save_decoder_info(struct cxl_hdm *cxlhdm,
+				      struct cxl_decoder *cxld)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(cxlhdm->port);
+	struct cxl_decoder_settings *settings;
+	struct cxl_hdm_info *info;
+
+	if (!pdev)
+		return;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (!info || cxld->id >= info->decoder_count)
+		return;
+
+	settings = &info->settings[cxld->id];
+	*settings = (struct cxl_decoder_settings) {
+		.id = cxld->id,
+	};
+	if (cxld->flags & CXL_DECODER_F_ENABLE)
+		cxl_decoder_snapshot(cxld, settings);
+}
+
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm;
@@ -778,6 +837,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	}
 	port->commit_end++;
 	cxld->flags |= CXL_DECODER_F_ENABLE;
+	cxl_hdm_save_decoder_info(cxlhdm, cxld);
 
 	return 0;
 }
@@ -850,6 +910,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxl_hdm_save_decoder_info(cxlhdm, cxld);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -1068,11 +1129,15 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	struct cxl_port *port = cxlhdm->port;
 	int i;
 	u64 dpa_base = 0;
+	int rc;
 
 	cxl_settle_decoders(cxlhdm);
 
+	if (!cxl_pci_hdm_decoder_count_match(cxlhdm))
+		return -ENXIO;
+
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
-		int rc, target_count = cxlhdm->target_count;
+		int target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
 		if (is_cxl_endpoint(port)) {
@@ -1107,6 +1172,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 			put_device(&cxld->dev);
 			return rc;
 		}
+		cxl_hdm_save_decoder_info(cxlhdm, cxld);
 		rc = add_hdm_decoder(port, cxld);
 		if (rc) {
 			dev_warn(&port->dev,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index c09492af8fbd..ed5237df510f 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -133,6 +133,18 @@ struct cxl_regs {
 	);
 };
 
+#define CXL_HDM_DECODER_MAX_COUNT 32
+
+/**
+ * struct cxl_hdm_info - PCI device HDM decoder programming cache
+ * @decoder_count: number of decoder settings entries
+ * @settings: cached per-decoder programming state
+ */
+struct cxl_hdm_info {
+	int decoder_count;
+	struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
+};
+
 struct cxl_reg_map {
 	bool valid;
 	int id;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..84d058b1b492 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -339,6 +339,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_CXL_RESET
+struct cxl_hdm_info;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -566,6 +569,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_CXL_RESET
+	struct cxl_hdm_info *hdm;	/* CXL HDM decoder reset state */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.43.0

