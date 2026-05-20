Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E49360722;
	Wed, 20 May 2026 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306419; cv=fail; b=u4ORBNg+MUU8H27A4DKVFAb7KKbVtKPWrzz91favDDFX/m/weh2k0VDLG0Vv8tIygGcqnJ5v6eZMfHvB6uzzuAHoNoUfDBE+EtElEGhgxYgJdSVeRt9kQxAWTnXTGTXbPdiUVlpNUM8sIJqbLrwatfRz0xiuWy1nn3iM/AXT7gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306419; c=relaxed/simple;
	bh=DAFOKCr55XkbvgymQ+QVx40T2qtAPwh5H+EwSvgysJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dl5WpZOIIo5Kuq2MalpCsCVHKGBfBpebTo+tPyMDccQslvcq4p6+qHWY0S5e2jjvZLFUtkrDhaOzN3qtoh/mC/AllPczmKOwRO2mW2URampSUTFvlACzhvTJ2mTZnUCYx6+gvgG0jiAfnpJdQo3We0rnkrVGLpob4uVIL35kzEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CB9ZBNHE; arc=fail smtp.client-ip=40.93.194.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CB9ZBNHE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpMD/MhcP8UvrLX9n9nfD1CJP5gnkjTTHvZ/nJXNNLKdHza2AfJTxQX592BcWE7uwH10yPD88BxkWnDc5vUGecs3mYOuerd0PoacJtGrt+6BPmjg4dcJ9ItY2etXVePxajAoKG8NKxqECIh76PzaVpNH5bDqJa1Zv4YGAXQ0arFZlQ7B0wwQdfEd4qCfE0MhBBBanAtuy8TqenPHrFudGBQvfJ9kiYnhmjW1YzKQs8llh22mreTqeKIMeYtbFRaQfdEznUAGG3uHCKAFLIR6Vkw6I49X7aANOPRwoqac0wzBCXHZQKizgBK/8CY33aZRkRHTfbXqHiZLA3p1pGIZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m/jdYLRKbRkOwHs29D8L7wx6k3gXHQK3PEXRGOq01E=;
 b=F4j3YJSNib+YDUP6cp7qU3ZPJYpJwuogIMB9fyl+W51auZV8H2EF1Yo57C8vVyXPhjCuPwgdjL6/4J7R3ypdOVDC/lNXEyqYB3ssUqNtTuauI4vTkJjdx6mqGTP91VyhZW17BFRfnwZ9LUe0NqftEDJF0zY0SGYrrJVqq4ath0QyR+dr5LEtQ3aNjHe+A4uVf+V7HDE0LBJL+1jY98NAD/nPeUPYkZ5fx7qPdo5GgbEyOS6rMLO0Jfd2Y7/diR/O8Z8TP+tO5uVHyZ31cJnD9qpLRF4G+gfWv39qta1B0lWdPyRTRSfVljEY8rLLEj0hy2An3l68fjZzGvdZCXxlZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m/jdYLRKbRkOwHs29D8L7wx6k3gXHQK3PEXRGOq01E=;
 b=CB9ZBNHEOKD7IsTC447EOuuRQvfvlSM0yjxeffF4L5IMGDNp1S/u5f1E208V9b26teB3PtuQyb83X8bpFe7ZZFHSts+8d/hhJjm+llNcbhLVRZJrZhYTt+hJ/szAkSgyw/mwX05lZPbUFNqCqbQSuvrr1j2414S3mgvwVH0Bljv+4japdWymb+so0Qdx+2jqmluoGH759Fj8ZPUspOe++SDylcJE1Lz8gEoFPoN8UUG7zMjNgacrwVv3W3D1+OpEYLkqpTOCkU9aXSCXRdGNPPb8U2O0bV+Pjd4XxbfLXenODHlGCzFS0FxF/V8ThVjgy99YRnm8FDf51xY+YaCLpQ==
Received: from SA9P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::12)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 19:46:45 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::b5) by SA9P223CA0007.outlook.office365.com
 (2603:10b6:806:26::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 19:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 19:46:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:46:26 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 20 May 2026 12:46:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 12:46:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <joro@8bytes.org>,
	<bhelgaas@google.com>
CC: <robin.murphy@arm.com>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: [PATCH v5 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Date: Wed, 20 May 2026 12:46:10 -0700
Message-ID: <b6d2f24356621c504e47633d9e96a7274c2859f3.1779304390.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779304390.git.nicolinc@nvidia.com>
References: <cover.1779304390.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 352f1114-590c-47b9-4183-08deb6a88569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4iz44O936WoXyo1nI+/jn0b//rgQ8hBS45ofW+KqL7U/kaVbVpy1mvkMEX4Sio92NrsXJ7PjqRh3VBbdCit0XW+fJXLgzC31IpG0Uds/gIcbBzrV1YI+intFibLuuIMyT4o0fWGV7ujtlBy2xW5pP9DCpxIaoDlxpGBDL4QK7SjG3iAFk9ZU3FZ9KXKeCekduuX9YGaaxucbUddged+JwPT1mBSx6LRqhI7avaXpyWr+lUYipjxEcDhkGgLH5Kl3CKYPtfiMSXwB1ipG6S2hhFgDBiUbWEBCZ8D0rNR2muTAscbSf2K8ixQWjOZ3Sp5i35eJXJkLw66vzsJeOB053rbhrDhT2CLLDFR3uBm9PILY1nOzGJmR5XnsHQa44/KKE9bxJidS1J24BpbgfzuGRH4rnRrSN5Bw7W660U5fnEVwjSAiF+5YWT/wlkCAubL7mRPuYGDXHuVDX+bHFtwDaBNW6wVXnCWYg3Lg9/loPhoY16temrzQC6ZFtCKLUiUfvnzNFsvt0Skq6PFw2jJ1kcqpH5irpH6RXHip88ao+8ujTCNreuVXRGWDLPA1fdRJmTprPK7t89WcpLlzlbqMDHapIo8SggHmdqkg3JdzfFaO4GE7k9G8A6pipntGMRq2lYs+M0/YNjHTd9+ZZXfIN3WLroGqgBwjQNF4VwzAF3a27Uribav4BrAgRaszngHpRSSP/i/IzooPp7yhEq4EB7APcPOVHIrTQo6LHM5FnDg=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZAYCgotm7nJ9/4NpXVkDef+drb5M99Ip5UYi93oJodSBNOmf0FUiS8EYTFGoEn8xE30sC3qfPEJDmwSfC0FJ8SivmFbqj+ut2rP0K42n0VZNHTFnx86hnxBiLvUV8A8vsVqkdtNgS4/jMP0+7fKpXMqEDANbcDe+r9YpBdyNG3b6qvPD+WBAGuUtv/oCvqBT7fEfFIZ8wNGDbUVv50Eh2wA76Bwvqg5LTCWaUSffJOWRN1OiLs05sZY0x4dn4jtMbRmf6ftkuM17pNq4n904D0vG3XkUgsnN6P0j5ivYoFGKx1q859JoAk1RiiqOWhxTPRJCL4UCjRnoKd44ItF/7gcwKA7BsBwPnjzu8SjzH1t8tBDdgLZqqZVq2Rg6/5rml06fTXmZyEpP58a4zcM151f0cHhvd4+5z/6M9nYqrq6dh6jKkJCn9Wo9VDdi19kj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 19:46:44.0897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 352f1114-590c-47b9-4183-08deb6a88569
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039

When a device's default substream attaches to an identity domain, the SMMU
driver currently sets the device's STE between two modes:

  Mode 1: Cfg=Translate, S1DSS=Bypass, EATS=1
  Mode 2: Cfg=bypass (EATS is ignored by HW)

When there is an active PASID (non-default substream), mode 1 is used. And
when there is no PASID support or no active PASID, mode 2 is used.

The driver will also downgrade an STE from mode 1 to mode 2, when the last
active substream becomes inactive.

However, there are PCIe devices that demand ATS to be always on. For these
devices, their STEs have to use the mode 1 as HW ignores EATS with mode 2.

Change the driver accordingly:
  - always use the mode 1
  - never downgrade to mode 2
  - allocate and retain a CD table (see note below)

Note that these devices might not support PASID, i.e. doing non-PASID ATS.
In such a case, the ssid_bits is set to 0. However, s1cdmax must be set to
a !0 value in order to keep the S1DSS field effective. Thus, when a master
requires ats_always_on, set its s1cdmax to at least 1, meaning that the CD
table will have a dummy entry (SSID=1) that will never be used.

Now for these devices, arm_smmu_cdtab_allocated() will always return true,
v.s. false prior to this change. When its default substream is attached to
an IDENTITY domain, its first CD is NULL in the table, which is a totally
valid case. Thus, add "!master->ats_always_on" to the condition.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
Acked-by: Nirmoy Das <nirmoyd@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 75 ++++++++++++++++++---
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ef42df4753ec4..8c3600f4364c5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -943,6 +943,7 @@ struct arm_smmu_master {
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
+	bool				ats_always_on;
 	unsigned int			ssid_bits;
 	unsigned int			iopf_refcount;
 };
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f03..5c9d4bb542249 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1742,8 +1742,11 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
 	if (!arm_smmu_cdtab_allocated(&master->cd_table))
 		return;
 	cdptr = arm_smmu_get_cd_ptr(master, ssid);
-	if (WARN_ON(!cdptr))
+	if (!cdptr) {
+		/* Only ats_always_on allows a NULL CD on default substream */
+		WARN_ON(!master->ats_always_on || ssid);
 		return;
+	}
 	arm_smmu_write_cd_entry(master, ssid, cdptr, &target);
 }
 
@@ -1756,6 +1759,22 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	cd_table->s1cdmax = master->ssid_bits;
+
+	/*
+	 * When a device doesn't support PASID (non default SSID), ssid_bits is
+	 * set to 0. This also sets S1CDMAX to 0, which disables the substreams
+	 * and ignores the S1DSS field.
+	 *
+	 * On the other hand, if a device demands ATS to be always on even when
+	 * its default substream is IOMMU bypassed, it has to use EATS that is
+	 * only effective with an STE (CFG=S1translate, S1DSS=Bypass). For such
+	 * use cases, S1CDMAX has to be !0, in order to make use of S1DSS/EATS.
+	 *
+	 * Set S1CDMAX no lower than 1. This would add a dummy substream in the
+	 * CD table but it should never be used by an actual CD.
+	 */
+	if (master->ats_always_on)
+		cd_table->s1cdmax = max_t(u8, cd_table->s1cdmax, 1);
 	max_contexts = 1 << cd_table->s1cdmax;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -3851,7 +3870,8 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 	 * When the last user of the CD table goes away downgrade the STE back
 	 * to a non-cd_table one, by re-attaching its sid_domain.
 	 */
-	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
+	if (!master->ats_always_on &&
+	    !arm_smmu_ssids_in_use(&master->cd_table)) {
 		struct iommu_domain *sid_domain =
 			iommu_driver_get_domain_for_dev(master->dev);
 
@@ -3875,6 +3895,8 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 		.old_domain = old_domain,
 		.ssid = IOMMU_NO_PASID,
 	};
+	bool ats_always_on = master->ats_always_on &&
+			     s1dss != STRTAB_STE_1_S1DSS_TERMINATE;
 
 	/*
 	 * Do not allow any ASID to be changed while are working on the STE,
@@ -3886,7 +3908,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	 * If the CD table is not in use we can use the provided STE, otherwise
 	 * we use a cdtable STE with the provided S1DSS.
 	 */
-	if (arm_smmu_ssids_in_use(&master->cd_table)) {
+	if (ats_always_on || arm_smmu_ssids_in_use(&master->cd_table)) {
 		/*
 		 * If a CD table has to be present then we need to run with ATS
 		 * on because we have to assume a PASID is using ATS. For
@@ -4215,6 +4237,42 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	kfree(master->build_invs);
 }
 
+static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
+{
+	bool s1p = master->smmu->features & ARM_SMMU_FEAT_TRANS_S1;
+	unsigned int stu = __ffs(master->smmu->pgsize_bitmap);
+	struct pci_dev *pdev;
+	int ret;
+
+	if (!arm_smmu_ats_supported(master))
+		return 0;
+
+	pdev = to_pci_dev(master->dev);
+
+	if (!pci_ats_required(pdev))
+		goto out_prepare;
+
+	/*
+	 * S1DSS is required for ATS to be always on for identity domain cases.
+	 * However, the S1DSS field is ignored if !IDR0_S1P or !IDR1_SSIDSIZE.
+	 */
+	if (!s1p || !master->smmu->ssid_bits) {
+		dev_info_once(master->dev,
+			      "SMMU doesn't support ATS to be always on\n");
+		goto out_prepare;
+	}
+
+	master->ats_always_on = true;
+
+	ret = arm_smmu_alloc_cd_tables(master);
+	if (ret)
+		return ret;
+
+out_prepare:
+	pci_prepare_ats(pdev, stu);
+	return 0;
+}
+
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int ret;
@@ -4263,14 +4321,15 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
-	if (dev_is_pci(dev)) {
-		unsigned int stu = __ffs(smmu->pgsize_bitmap);
-
-		pci_prepare_ats(to_pci_dev(dev), stu);
-	}
+	ret = arm_smmu_master_prepare_ats(master);
+	if (ret)
+		goto err_disable_pasid;
 
 	return &smmu->iommu;
 
+err_disable_pasid:
+	arm_smmu_disable_pasid(master);
+	arm_smmu_remove_master(master);
 err_free_master:
 	kfree(master);
 	return ERR_PTR(ret);
-- 
2.43.0

