Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58A4A340F;
	Tue,  4 Aug 2026 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871859; cv=fail; b=o0/hxZ5hWoK2E9RSGGs4jqfKSbmneSMbPvO/6cGrtG36ukkVQUcHGDIxSPUwt01X1lwGwkXlLxJXp0uoc4PMsD9QX4DNF2pp2640C6k3uNw4ufNm3DCQYr9fZQf5FKRFaDVpK/gZEjWhrLWLTvvT2vmx+WJxa9XTYTfez6zkCTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871859; c=relaxed/simple;
	bh=Ew/AGbFHJPcpReMzxSgim1BFqeBuNs2yQV0SQtmbc4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CPtbsZFvD77uYkekoz/lPcdDRSP5lPT8PA6MFV4W/+q98Uju0+/egoZSg++9lQE7mZW7sj78BywVYuwq0bJ5E4T39txcNLDE4k9lduqK87XEPeN2jo34t0+xnJ+Plw4B+9ULvIe/1cbg2n26u9/vWTixa0yX8P/pBW/SfosGB20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dnm2REqx; arc=fail smtp.client-ip=52.101.61.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dnm2REqx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7UxrcQ2XvD9IKEdZv9QS3cKjlWPICXcMMDMwH3OGu34i5bVYptdXOyYUKsE+jMXDybVSJd/FzXeV6jTsLtqteqfYShnp5gmi0Qfdo5dKlqV/fNB6vZ6k6aS/xcUM/QWRQxMhNDLS/7QEO+DUGiJW0shPGon9QjhBI0nTHaKMI72gul47uqImNNH94H5mVwve4z2XWx48IvU9Ku8+Uebjg9PPsK+hHJCDjyDuIdqXHf4PXWz9T5p9Ljw+ZkTMAwQDLT7gjVoM5OwHsa3Dp6kyBh3NQy3xLbsZMK88ijEw9zSWWcD8luxHSbsJ/shGb4VXr0dXxiVF98ugOg+2xIK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Amyo/+6qJOHbzvcwKj5D2aCeqATAHGY9fQ4xFrzLrw=;
 b=o7MS/ktHfDM26v54LRvJe9q6Xy3peP+s+6+hqRNNbpbYf8aa6JisYkErdIF6O/XtEk6v9OOrkxed+dPZsBHKOeFA3PvuT68mhNnuw2rx5mrTy2aL/WntQ6H+XRb1rTZ7uEnYYdjdisZSA1e3lhy3f59GS5X8DBGPRB5+cigb66fuCHoJtmCX/ruUwr7q5OzpjM2ydH4TJMHTTzibxbamuQHz1rBJBeUNEiRLTrhsGWn2MGOuLF4Noi4aIPREfTRY443qk5CF0icruaNRuNXNfuAO5KEevZDeI8VMdJUOYbBL+wOkpUJDaJT8HVTYoHFwN7uI9EIuFH8xDNulgpWZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Amyo/+6qJOHbzvcwKj5D2aCeqATAHGY9fQ4xFrzLrw=;
 b=dnm2REqxzsYkueF6I+aAAchYHUN3ONuqTGgktcBPcA5XQYlmHkSg79o610TC67hJmJoQzNKD4tp+v7CFOIs642d9hNs+utSLsYQOqZaUI0EkZZKa67NsUT3+oXZS7DAqQmzqeAMDFsmnLTS0cXaVpleS1wR6s/9GUb/OR08JhQ2V9WAUEpNH2sYmlFNEo8j/mz28jukBxlEPlcHniisIFzu8mAVMG5BmZ0DHzies/HieAHL6WFHvWNsuF0mCSOjOmADhff+Xnhl6vYYBBQnlBMLJOn+WrZcpQdgF5HPtaJ/QseA4ZdjkVqS6FOrcAD6RTDMB/cEKBVoa5kqrBeKS3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 19:30:53 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:53 +0000
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
Subject: [PATCH v10 12/12] PCI/CXL: Restore HDM state after CXL bus reset
Date: Tue,  4 Aug 2026 19:29:58 +0000
Message-ID: <20260804192958.1823952-13-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: cf543bf4-5c85-4211-f434-08def25ee5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|921020|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	RdYxrmohFWWuJPSTuQK0fbJp+fHqvb+tB7+HIS5NME14DdbGTziLUR0/iP/Pfr2QQpKQAWJdVB0I59xXiHamTLlGEw+IgNYSu2bl07MM0LffZ05MSU/Tcmar34BGeki9opr7PniHkRccWko6qfvtiRk5U/7pwE7Wsr6XjkcFdfUHSsK54W/L2rDxNmXTJU/weO5cMYZxqRR4/tYP1fBt4EmfktG6cXY9LdxOPNaEAUeTL39H/vjlUlFtFXlzZIsCDO3J+A9vdupamyddbjFRRPcviIv5dAuk4zlQF9kUbfzsIJ4HW9mnWIy00l/6CzYvAiJ5aGwOrT9Z04j+byRw8YCtVcc0pcnP0NF59AtcGqdHTRtZ5Ep6kPTf2AZv1fKpOtymofeEH8XaMucWmE0UGd3LSUmCu2h3ShcfWcOWMhDRjOkD/qQ7lKqYFgGpbTLuGP3b1clNGteoKhB5elN/l3Td4QNEdOHhrihP45H4zxHRZVJpiBhKA29suYIAsDYN1cgRNG7ow12rdtD7o7jLQSaiXqnhedJR1oE1cd3gZQJwolDtw845jiuUt4XLw6KfGYj8R3DlBrj6VJESTIfTMOdsQeV3c6JYGHbWgwYkqWY799606CEZua74+MSDrBzCzxhyokVBT3Dw3fOE1dPbRrMh8KHUlWDaWuQRLe/XsFCCyCq6xrdN17WV29Ms3yWv4NCGxliAgLBaNT4a+Yn4Ig==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(921020)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gUGSnaV9Qhe6wsV2XZxQEfFYc60UbvPebqyw7dUPuzq/CI8ryDCFXMMe/DGi?=
 =?us-ascii?Q?tzyRaX1Dxa6Nnp1hLUso8PK1NyFO3iP9PqyWFX5HIGoAqJXoz1ruBCMdRNZQ?=
 =?us-ascii?Q?yhvV/YWUYTaINlnPnqqDlNsJAy1Ea3Lmt+hJRzcwt0bpIFTA6Xs+Xj6+SO0E?=
 =?us-ascii?Q?l9eu5cgGaQwh+hMjduG1Gk7hGarl9YZ8kidvXnONc4jzppNkjZUjyibhoykY?=
 =?us-ascii?Q?MHAiKIb7yxhKxjbb/+vIea9B7DtQPx/EVa4WHIwObBmfqbHek5odL0WpPeis?=
 =?us-ascii?Q?+Mi295izJ6gGCCJN9xoS4g3RiIpnLfzgXjarI6OAwGLMykarhR0ZN2ymC/h/?=
 =?us-ascii?Q?bXKXGa7rSWSNO6ZgktQhQOBVP6eQW9tIDlQrksIwgj64M5w6qVai/hb4OCgK?=
 =?us-ascii?Q?XdPfCm3OHOWSHYqOs7V50ED0r9WMXpRsRpYuFmoz3m+OmweqLXMVYYEGTxmM?=
 =?us-ascii?Q?8h8iELXnXwRSpceALwqcBSUUY8wrtRq7Q5Dcx7vAGsOvH/rtc+7jp9iGoDiM?=
 =?us-ascii?Q?M8yAEf8t7lASxBizzo7anINp08+UCZp4qwM38XxEiEkew7Pn8gUP+ub8HihM?=
 =?us-ascii?Q?24XF6Nmk2iqt2biEg9C8GJ/cU4Brd1pmidLvnEA45fydAhMpcCifZok2BFjm?=
 =?us-ascii?Q?VWguyQtyG9vtG15Jfs32jvuVKIHF6BYXxNdJrHR3Ar/6y5ld1IBTBlHCf2DP?=
 =?us-ascii?Q?nGpOiF94DO1MtosF7Ynut5ScQbLLeRWHXRqxPgcB2cvtncYxXbNaVoLjW6mv?=
 =?us-ascii?Q?5CY7xuikm1qRPa0ajwq4Ln5rmBH8crKMmEpZACUJKR0pqBI9ete7anVoWGny?=
 =?us-ascii?Q?a+F1jQIqVYh6MOOz2LjfBwaF5K/TZnFkZfQ4yFDwuOitIQDgqvLNOetYQ77/?=
 =?us-ascii?Q?Ny1URLJF+sg8Z2Nx+tzBy4zYRTkxVAinoC9ILuLPaaZ+fG13aemgt9mvSWQv?=
 =?us-ascii?Q?CxZzo9fK6mQX9bgAW7M5qjT15Ycqb+qJWiH5Mn2Wp8Mba2OCFnJMSeuOCob8?=
 =?us-ascii?Q?n1wv1WH9S4uCEqXZkfGjosM0xSvU0CM8KU4XdTPwLBJHvKiLGwNbp1dQMEEo?=
 =?us-ascii?Q?+wsh75FD0uz8a381pc2ycExs30Vc8UjiQRLrbqZryjAxpZUbLt95ZaPcG/Ow?=
 =?us-ascii?Q?z9wwEvx51KLNrPJmBHl9EhqOmv1pDu2pona9FYr62k51XtwJTRx4eMRRju2y?=
 =?us-ascii?Q?vy2Sg2VDqVbJXs1MDxAYQWVz1fNiD2wnehyYLjhTbUGOo6RscDN7PTynjwjw?=
 =?us-ascii?Q?XonX8dLuuBs8Sg24KWG9AjzvYjd8oO5YCxpkKh8Q1Ye6pDKpJakAGtdP3H/m?=
 =?us-ascii?Q?PS5Nz972KSDC31pMo3A9pGBYGFNLWzxUKPYJM9//9IUG9CiHBYH03LFY1pYy?=
 =?us-ascii?Q?RbFBhphguzipe3KCIz8oTHUvi7vx5EAEeiCbm1zTMKvgvDvgYunCIYK3XQcX?=
 =?us-ascii?Q?K3nwIuO5FbwYtq6ERGhgPx8294MqgFgzRt8XMVWPtFHUEyubB3nq2J2FH4Za?=
 =?us-ascii?Q?NBZavtGG/OvBTcZl3kD9HE9wlH8WA2xOpxBm7ZwzgTVNB/W/abA8jnc/9NI/?=
 =?us-ascii?Q?Sfd+YRRRivuEdj5mpzGXnolyJJmprsDVzt6gXiT7Hh56wTjFWc117lm+pT3M?=
 =?us-ascii?Q?r98wdzeFbfT3AdLh4NLvBtqoTQMMfPwGM5Ib9WbIwkmLuKSU4u2QJ7N5jP6U?=
 =?us-ascii?Q?oE3mkw2GeBnOnnWN7pR8QHjl9Sz2n3TsgEb3VodJc1Z+xUSiUI2JQ0H9NR5o?=
 =?us-ascii?Q?2SS+5teeZA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf543bf4-5c85-4211-f434-08def25ee5bf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:53.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXYDHbo2mp+zhZMtcmrhzs1LS+toe3gxqjOvBy6D7k9Q+7klwmNcbT22HYu/gcZYwTpKbNAOLgjAeQjaE8oOXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161

CXL bus reset can clear HDM global control and decoder programming.
Restore cached HDM state after a successful cxl_bus reset while the
IOMMU reset block remains active.

Restore PCI config state first so BARs are valid before HDM MMIO access.
If HDM restore fails, save a disabled PCI command state so later PCI
restore does not reopen bus mastering over invalid decoder state.

Reject cxl_bus reset for multifunction devices, matching cxl_reset.

This restores only HDM component decoder state. It does not restore CXL
Device DVSEC range/control registers.

Reported-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 17 +++++++++++++++++
 drivers/pci/pci.c           |  6 ++++++
 include/cxl/cxl.h           |  6 ++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index ba0a26276477..daa5e7fa2509 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -834,6 +834,23 @@ static int cxl_pci_target_reset_prepare(struct pci_dev *pdev,
 	return 0;
 }
 
+int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev)
+{
+	u16 command;
+	int rc;
+
+	device_lock_assert(&pdev->dev);
+
+	cxl_restore_pci_state_for_hdm_restore(pdev, &command);
+	rc = cxl_restore_hdm(pdev);
+	if (rc) {
+		cxl_reset_save_disabled_state(pdev);
+		return rc;
+	}
+
+	return cxl_reset_save_restored_state(pdev, command);
+}
+
 static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
 {
 	INIT_LIST_HEAD(&ctx->ranges);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ef25ba5f7fe9..7d1e968a2aa2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4977,6 +4977,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (!dvsec)
 		return -ENOTTY;
 
+	if (dev->multifunction)
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
@@ -5004,6 +5007,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
+	if (!rc)
+		rc = cxl_restore_hdm_after_pci_reset(dev);
+
 	pci_dev_reset_iommu_done(dev);
 	return rc;
 }
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 8645d0fbd273..8e6e68751d88 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -162,6 +162,7 @@ struct cxl_hdm_info {
 #ifdef CONFIG_CXL_HDM
 void pci_cxl_hdm_init(struct pci_dev *pdev);
 void pci_cxl_hdm_release(struct pci_dev *pdev);
+int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
@@ -172,6 +173,11 @@ static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
 {
 }
 
+static inline int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev)
+{
+	return 0;
+}
+
 static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	return -ENOTTY;
-- 
2.43.0

