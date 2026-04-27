Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E636E469;
	Mon, 27 Apr 2026 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269284; cv=fail; b=nZr9L4Fx3MY+Ngn7ipN5M2zIUH3yyGvuTlJBozrARgBa9rvVabBztS0HJCBAMJQhuYPBXfbhgkGdD8k70sgMDnXDygBs5SLvf1U6wk4B2Mp65EbjbVaUQxLEoyFyq3t92ZPXQj8ULkKsmAaOHM7dc+ivVPgqB0imzPdPUyOO5dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269284; c=relaxed/simple;
	bh=Yy6+OCvyof5hh+/KanJbfWK95/yJ9tczfE6CvIEFlZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/fwFNPFQ8p0Jou62kJv/FpGVTtekpm0osLGufgFBMa5ffY2eP4x3i0+KXfuLl3DXy/MOD2qVxcZM7UxHoAwMmkovALApXnc30Epi8WITY8D/BMCVfFBctZHXGo3rWSL4g7YGKEW5ZNhRpRTxjaCTVOzVK8d9js8eofU66sVbSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oKseFeC8; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oKseFeC8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quTI24/ya7Sweem6NUWgA2rs4DLRk2BHpPO/y+9BxaFMao6PiPEUf5W07aO9ou2jwCpds9ArqoU4CENAOF9kthO7RIALSto2oGDiRcYS6AR8pZgmqxBBg4YU8DigebCK1nj/sKhoR0iJYyUcUNvUpkbVFVXomNdpgLUjWbvbJ4x5nL6ckGcdG8mUP2MnMnYdvd4pypm/niNQhn0q7vEzjUv3Q51swOmywM7+7VHl991zIQDp5LO+0KSh+cxkAjnRrz2MNsObhSCQFbbrmgPwQ4OqrRtPw8c08BmBttGoGtba/gigI11ICzNPdwVVDSqqcsV9g846uoMjNqXPWtv3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WA26ZXMcbyPLMHwVMRJmwkF7x+GStFfCMKYbTLKdT8s=;
 b=QQGei1GNVe8cwknwwVGtxR6W49jKGc3dTZtv0vhEC0EVxNdbRYH29M7N7csuBC+tUAJm6SVJD1b/xh6OIWCu5rJ4HR9TyboFKzgk6KB3hcRM6JXRBniAjoS3cyui309mH6vE7ocVyJNDnifwzI/n9scrj99PD0ut/UyqEr1UBfrrzOEg07pfeDEjiS5f6RiE6BqIVbg1WfQd09UsgVzC4H7jfq1j+Jz04m4AJcSlRC4nJdVjx8nRDmXVD25LT0hmf/c1PBVmTmJq1TO7jyecO+twcjDZHvN1kE8bMw6FsWoJfKzGvalLdb1mMFRHpXo9WkMnDCdHAmkQwICEs1UQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA26ZXMcbyPLMHwVMRJmwkF7x+GStFfCMKYbTLKdT8s=;
 b=oKseFeC80LPbY7yF+vcEQtkz33H+qVqhS8Wzmq5OWAkIi2znVq7Qdm7fdfycaQPUTnOk/16GyM3OEYPkrgLLLGn6sSzEm6TVLgiAza6Bo+7+S6c69RdLMdUEC5tshi5HsciMrGqrC4zpAZ678nLboienS6tMH/9w56lj2fg+AItCqAilUSRAB1fTHRbsETvvc2h2VB1KfObU4VHP4wxWJog6KEp9kM+MkhgXSa09+Cem7a0uE0KdU4yfJW7Yz49YJ1l01XOkYNbTL/esRDIGmtXgwM4kbQfuwPiDxJD4jJoaBn/0aT9klV97OpxJVaKwR9NJ4ewDIb1XAGiNFlnT1Q==
Received: from PH8P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::6)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 05:54:35 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::5c) by PH8P223CA0009.outlook.office365.com
 (2603:10b6:510:2db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 05:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 05:54:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 22:54:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 26 Apr 2026 22:54:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 26 Apr 2026 22:54:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<vsethi@nvidia.com>, <linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: [PATCH v4 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Date: Sun, 26 Apr 2026 22:54:02 -0700
Message-ID: <7403163ebf59380f88c7503b3adf0dae07428df8.1777269009.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777269009.git.nicolinc@nvidia.com>
References: <cover.1777269009.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 915ee2ba-c761-4043-fcf1-08dea42174e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8i2vnFg4ZZ2/F2IVNzMjWd3UApDbfXHx+mZLjsnrZ5SvOGZVmnSYVsDS+T0nURS43d+Yk85Ie97DL/xKujmg1FLL52owQJyreqo0DWzcrEkbbvGD/WzUK1Aq38qNHohrx9xsa7sryn/MHXdl/o4I3grtYuNDN1krNTV2W8TrMFDPi+oFpN/59vFRNeSSn8LluFAYXqmrBLzjjBQ8rNqCcibYSV8UsidaEiao/mci9OGbiUMGWiElkbCec46OB2kuvj7CIpdPu+pEW4Jmk8gJYkXWSrUzTRURag9XhsTJsWEEg9jUl1NKPSZs5s9MWLdRSDjTZHuEsmoFI7/F1Cn81jyK7TWuKkWcq4EHiAtA3ziJ+nz0TsVxlBBugRVaIKiTUyVdRDOCD1vRmPg15BCsj99NraNaeU0TfGAJ1gQsd0Ir7TfQ65cSnRRSBPWtxU2kAEaI2bZodLmQ745vVlhAHYPu6kFBc2ztdcLDEwZAMaClmyRDFGMXwo++aVuvdecI9AO0wx9mcFLuDRiNxDl/QgG0telmy6lKNi5JquB8PR1mmAkHEIS7bPcrv4I9pDEaj+xOjF/C4+Ze9qiEWGwRI3QppazeeB9sKwX3U3p6FOQHPb5wUVCj4FaXlrzrxDHEwk4BP7zbr/SprcIjRiqS2uPDAi5zuyKJrttIGqFfI3mijym3s72LvnmDWnql13p2mN26+kbekXBPZMlBGGqpjhtGkzwNhlgZIANdDSf31yHRe2VkNhOUyspjyOjPtLa3Oqm7juxOVAf3MvEcW/XKqg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l++nAeyI0c0XnYBhqVvksEjeoPyfAEQIDrZZA5QiL1AtdhIRmnpq62ZjqSHuob9xQncOnm2MjtW5Wl7Etj+OjmRxtQ7+fwmDK3Ewxp0dsgxChFaKmFc+hc4Js0wXGIGW1hIjbZcpfoTOOkcTIUCy4UlAlDtx7uEje34XecPxMSL+12FQKAxPzBgarEEv6Pse77srucei+3JgSKzEl0qDSXFbf6Agp6sfoBaSlLjG5iOu/sPu93cvAjaO82BRvau7u7CSl1Eb3LzUE6NqN82PMJsrGsn+MfmYJjcuwfggqQfRr8CbTw0YkGvJmOGuZgTyYh1FmUivRaSwG4r1IWc1RVeGOA2PhCbI+QKBEclWvVr3SW0w2KgFupGVvb84g74FElAE9n+0ffJ7XM468KfsYef4raY1Ohko/uI8PnqhbbyGKyIY+8OmPr+be0AoyVEJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 05:54:33.4056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 915ee2ba-c761-4043-fcf1-08dea42174e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934

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
index e8d7dbe495f03..d478f148cd34b 100644
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
+	if (!pci_ats_always_on(pdev))
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

