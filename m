Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9A3081BE;
	Tue, 19 May 2026 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162023; cv=fail; b=I3Stnk5jI8u7PQX5DDyOI3XF2Ne1Qfu4ODt/7+aUwwd+oww5JPKEz1xh9L/XIGah6W5bzxp03JfeULEKMHrqmsMC9le81dYR4+m2NARrkV2QZa7wBvtObHSQXCjHoaFlpxZn1qkPw+2eLmlNHG955RtZV4kuI/KsHY52XtjUR08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162023; c=relaxed/simple;
	bh=oF5Jy68ZaWdxT3iOOLmQFfnScjyyGABuP082cp1M9tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjWVds9Ikc7AHtAOHW11N+Ut+R8i6k0ZQ/ifAHISg5DbBPzy6BWpPCiPG0ggJmAA/VQyZ6nG+171TVnK4Z8FNKES/UKavLi6G+s0eH1NRrL6miujqFcDSwM0E0Uxi9ewOHwLqDCBteccQOIhhXJOKzp+xT5pcNzy6snV6//lv6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eT6FYtJT; arc=fail smtp.client-ip=40.107.209.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eT6FYtJT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lx5iga0saOz8hamXzTe37RnEwo3S9I+geqcYyWaw4rEgQBE3v51k30jzWHKDeiHPh35WI2KLs5md91ke+26Oljn0x7dt+6+7CIisEuQTdIkiD7L3hOWg/2lph4Wk3NqBdE2W8aUExJE0vY0Dgwszhu4QXC3AWtqPWGpWbcSe9pYv1OOnf7i3UswV3jcuIK2xzLiF0l9MGKmJYV6qhLUG9EpEE3j+PMoWHIowcK+h1pW6L2r5V/0Tx1kTcjAuHjSEv+aB7hsO2u7JLSmIrupd2/wqZroZCjXbote3UVjt6VpSuh+AQa9FOLTovA7hfcQpFoxctSZnPA7cvj6rxppglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRn7rC49R8QJBXrjsZzryGmo79+1SFPR7NyiO61Zc5Q=;
 b=GyWpShQJEamjZze3yGwaR5zUeutWbQbPnQzT2xc7qIblgLYT9ODpyb6R0eHHy797j1o+DMcdrhtQubEhlMOwQ2hDnwNFAfP0GDvtJ1s21Gec5CyHnFJg0EdmAajjRLovy2tVdkBZQo2Q1SwjcTHLwOzf9slIurErFeVxr5lz2wwAF7a2/pTKsA56c7setiHwQlKptZORHf1G62TPqQdDP+sMwu9EGca+V/SD1Ketx2iCMY5nlAc0OO/A1n82/MttZXMmOQ52v1qsFGVDqb1jfK8A7+2S404IWq5A5ni4NsEipDwZGMCDqmuYApCuopMac1SdyuI44xdPtvdA8LyR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRn7rC49R8QJBXrjsZzryGmo79+1SFPR7NyiO61Zc5Q=;
 b=eT6FYtJT2hp69csNgwwHXZc/bgGalyvgcE3F52jPwsjRazKSAfjCpwNAWzV3qweDdPifiLs2UMZTNydz5+7VALe5kdcN8DoBedTOaGGr0dCFzq+08B/TEVCz1ncn/QMBA13NKYXwWF/ZqcjZTJzeIOM/Q++Q5VcU3ulju+ad/Q7njj0A7Cq164opaIRpVde50Epf54skBiE/VeRs/euxJvOjiTfnS2yGMYn3sDugXQeWJr+PupJbg1rZq7dQ2ulmikwlm/CuPFN1+xbg1lHWzXA9aZHbrG8YHZCS09i5i02Ps3s01KD7+/5GiPqZhZaY8F0Gd4xEbzdcmzqOLdpaVQ==
Received: from MW4PR04CA0133.namprd04.prod.outlook.com (2603:10b6:303:84::18)
 by CHXPR12MB999221.namprd12.prod.outlook.com (2603:10b6:610:2fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Tue, 19 May
 2026 03:40:14 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::29) by MW4PR04CA0133.outlook.office365.com
 (2603:10b6:303:84::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.25 via Frontend Transport; Tue, 19
 May 2026 03:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:40:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:56 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: [PATCH v4 24/24] iommu/arm-smmu-v3: Block ATS upon an ATC invalidation timeout
Date: Mon, 18 May 2026 20:39:07 -0700
Message-ID: <fdbbdb4efce1173e93c2e631f97a7f0689330c2e.1779161849.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779161849.git.nicolinc@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CHXPR12MB999221:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4a81dd-8e28-4253-251b-08deb55855c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|11063799003|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	59SuDuU+deiIcFs9yzCO8Wi9M16NFPAPZDHqA6aIhMXr/+nObv0+URYC2klnIHGLyBQ6xJE5aGx5Fqe+EssQWhFrVYDAnccv0oRuHzj6iRigbpNbrn0zLc2JjoDp7YwyuXfZ42zHu5NXHiWSGswUt9/WZ7yYh0DoguKOgHTdvzYwccRddAxbypJrayHWaw6W1YWG115EwLKrm715kmydcSAAkGWyCRAd8gZBrcBwoSlmMGDoI0/CuAI8GGCrig7SeBcBQ08F7tqEM3ihGGn60y3A0qvcJfn0d1Lpwq3vLPs50gzdDfb4Xw39h3m5EwgIWCMPUiixHzlUlV61neiLTcLep6ezSltQvSzrMjT4Ibo4Krhln+K+XlSRnnbIo2rgq6CgOWPVcOLR6wOEB42RXPf82u7FRrgp7zZQWfRePIvxun4w2PxtgJ1dt1qHvQeVHLtg7+ENnX+EQo0Cx2Eb9GAfOOhio/FQbamfk/wa+JHsvT57lnCfVQaSGaLVDmWNSk3cHg596cT+bNDmouNOJfk2vL61DbflfCxwYg0oDN/wKzLBfgpWpEPiJvPzjSUYd4+2dzDZSc+EaxSVJcuvXvg+H6sR/AyRi99mOOAETutUxYXHzkEuW/o4uTNcMEij3v0S0BlcddM48uT+sVGjLEkDLhY9y4fWO+X7gvzkPQx119S64kOc7TU3nPZrcxu8fp6442D7OLgKF2e0pyYBmm49LcL/MAQRmOM9acFox9M=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(11063799003)(22082099003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J5e8ZiQ3a3fnrJd0SKR1UZxttKLyJ/ta9u4g/QdQa4mX0vNQc2NIDrqMyMxNikN1LuBU8nOR3BTXKXOdpXjt8qfaJWV0YGQ7uaq7zMmelHDfucboxJkwAiYFIevLXSFM3vT00J5C2OODTzHjR8QxzL0IgDCVcEq5dSGH+gUFPxD3yZpa/aZhePic6+ZakwlhaqAUTAs29FhFqcsPZpxyAqTHLAZCFQQ4zvAJGWjuO+hXgMBsa0Y1c+icf//+NYxW1c/22xe+hJkH1Cswx9POV9841dqGIOntfC8rOFVOBP1uaXIrTpAAyL/ajR9kx7d1NPgwbO7pshAYAR74ue3PLFIYsRV3KiaGsNwa61qPDqA81gtYlvKkDr1fAzgO6m8FHGHuy9ja0h2zLkGf1HFGl8IERMBNw4Grm6PGXHHFcpEoXaUOWdEav9F3Ngfv+U7L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:40:13.2588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4a81dd-8e28-4253-251b-08deb55855c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999221

Currently, when GERROR_CMDQ_ERR occurs, the arm_smmu_cmdq_skip_err() won't
do anything for the CMDQ_ERR_CERROR_ATC_INV_IDX.

When a device wasn't responsive to an ATC invalidation request, this often
results in constant CMDQ errors:
  unexpected global error reported (0x00000001), this could be serious
  CMDQ error (cons 0x0302bb84): ATC invalidate timeout
  unexpected global error reported (0x00000001), this could be serious
  CMDQ error (cons 0x0302bb88): ATC invalidate timeout
  unexpected global error reported (0x00000001), this could be serious
  CMDQ error (cons 0x0302bb8c): ATC invalidate timeout
  ...

An ATC invalidation timeout indicates that the device failed to respond to
a protocol-critical coherency request, which means that device's internal
ATS state is desynchronized from the SMMU.

Furthermore, ignoring the timeout leaves the system in an unsafe state, as
the device cache may retain stale ATC entries for memory pages that the OS
has already reclaimed and reassigned. This might lead to data corruption.

Isolate the device that is confirmed to be unresponsive by a surgical STE
update to unset its EATS bit so as to reject any further ATS transaction,
which could corrupt the memory.

Also, set the master->ats_broken flag that is revertible after the device
completes a reset. This flag avoids further ATS requests and invalidations
from happening.

Finally, report this broken device to the IOMMU core to isolate the device
in the core level too.

Since the three steps above are invoked in an invalidation path (which can
be an atomic context), hold the ats_broken_lock instead of any mutex.

For batched ATC_INV commands, SMMU hardware only reports a timeout at the
CMD_SYNC, which could follow the batch issued for multiple devices. So, it
isn't straightforward to identify which command in a batch resulted in the
timeout. Fortunately, the invs array has a sorted list of ATC entries. So,
the issued batch must be sorted as well. This makes it possible to retry
the ATC_INV command for each unique Stream ID in the batch to identify the
unresponsive master.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  18 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 118 +++++++++++++++++++-
 2 files changed, 133 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e3eb4c4a62d3a..43d4a35500500 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -831,6 +831,24 @@ arm_smmu_invs_iter_next(struct arm_smmu_invs *invs, size_t next, size_t *idx)
 	for (cur = arm_smmu_invs_iter_next(invs, 0, &(idx)); cur;              \
 	     cur = arm_smmu_invs_iter_next(invs, idx + 1, &(idx)))
 
+static inline struct arm_smmu_master *
+arm_smmu_invs_find_ats_master(struct arm_smmu_invs *invs,
+			      struct arm_smmu_device *smmu, u32 sid)
+{
+	struct arm_smmu_inv *cur;
+	size_t i;
+
+	if (!invs->has_ats)
+		return NULL;
+
+	arm_smmu_invs_for_each_entry(invs, i, cur) {
+		if (cur->smmu == smmu && arm_smmu_inv_is_ats(cur) &&
+		    cur->id == sid)
+			return cur->master;
+	}
+	return NULL;
+}
+
 static inline struct arm_smmu_invs *arm_smmu_invs_alloc(size_t num_invs)
 {
 	struct arm_smmu_invs *new_invs;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ee864046f0baa..0323fd3f33b7f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -107,8 +107,13 @@ static const char * const event_class_str[] = {
 	[3] = "Reserved",
 };
 
+static struct arm_smmu_ste *
+arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid);
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
+static void arm_smmu_cmdq_batch_retry(struct arm_smmu_device *smmu,
+				      struct arm_smmu_invs *invs,
+				      struct arm_smmu_cmdq_batch *cmds);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
@@ -905,8 +910,13 @@ static int arm_smmu_cmdq_batch_issue(struct arm_smmu_device *smmu,
 				     struct arm_smmu_cmdq_batch *cmds,
 				     bool sync)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
-					   cmds->num, sync);
+	int ret = arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					      cmds->num, sync);
+
+	/* Identify the timed-out master via cmds->invs */
+	if (ret == -EIO && cmds->invs)
+		arm_smmu_cmdq_batch_retry(smmu, cmds->invs, cmds);
+	return ret;
 }
 
 static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
@@ -924,7 +934,11 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 	}
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
-		arm_smmu_cmdq_batch_issue(smmu, cmds, false);
+		/*
+		 * Force sync for ATS-bearing batches so the timeout is caught
+		 * here, not at a later unrelated batch's CMD_SYNC.
+		 */
+		arm_smmu_cmdq_batch_issue(smmu, cmds, cmds->has_ats);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd, cmds->invs);
 	}
 
@@ -945,6 +959,104 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 	return arm_smmu_cmdq_batch_issue(smmu, cmds, true);
 }
 
+static void arm_smmu_master_disable_ats(struct arm_smmu_master *master)
+{
+	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_op(CMDQ_OP_CFGI_STE);
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_inv *cur;
+	size_t i;
+
+	lockdep_assert_held(&master->ats_broken_lock);
+
+	/* Disable STE.EATS on every SID */
+	arm_smmu_cmdq_batch_init_cmd(smmu, &cmds, &cmd, NULL);
+	arm_smmu_invs_for_each_entry(master->ats_invs, i, cur) {
+		struct arm_smmu_ste *step =
+			arm_smmu_get_step_for_sid(smmu, cur->id);
+
+		/* EATS is safe to update. See arm_smmu_get_ste_update_safe() */
+		WRITE_ONCE(step->data[1],
+			   step->data[1] & ~cpu_to_le64(STRTAB_STE_1_EATS));
+
+		arm_smmu_cmdq_batch_add_cmd(
+			smmu, &cmds, arm_smmu_make_cmd_cfgi_ste(cur->id, true));
+	}
+	if (arm_smmu_cmdq_batch_submit(smmu, &cmds))
+		dev_err_ratelimited(smmu->dev,
+				    "failed to disable ATS for master\n");
+
+	/* Pair with lockless readers */
+	WRITE_ONCE(master->ats_broken, true);
+
+	/* Lastly, report to the core to schedule a full blocking procedure */
+	iommu_report_device_broken(master->dev);
+
+	/*
+	 * When a concurrent pci_dev_reset_iommu_done() runs after this report
+	 * (e.g. an AER recovery in flight), the broken_worker may transiently
+	 * block a recovering device. pci_dev_reset_iommu_done() will lift it
+	 * immediately. Net end-state is correct.
+	 */
+}
+
+static void arm_smmu_cmdq_batch_retry(struct arm_smmu_device *smmu,
+				      struct arm_smmu_invs *invs,
+				      struct arm_smmu_cmdq_batch *cmds)
+{
+	struct arm_smmu_cmd atc = {};
+	int i;
+
+	/* Only a timed out ATC_INV command needs a retry */
+	if (!invs->has_ats)
+		return;
+
+	for (i = 0; i < cmds->num; i++) {
+		struct arm_smmu_cmdq *cmdq = cmds->cmdq;
+		struct arm_smmu_master *master = NULL;
+		unsigned long flags;
+		u32 sid;
+		int ret;
+
+		/* Only need to retry ATC invalidations */
+		if (FIELD_GET(CMDQ_0_OP, cmds->cmds[i].data[0]) !=
+		    CMDQ_OP_ATC_INV)
+			continue;
+
+		/* Only need to retry with one ATC_INV per Stream ID (device) */
+		sid = FIELD_GET(CMDQ_ATC_0_SID, cmds->cmds[i].data[0]);
+		if (atc.data[0] &&
+		    sid == FIELD_GET(CMDQ_ATC_0_SID, atc.data[0]))
+			continue;
+
+		master = arm_smmu_invs_find_ats_master(invs, smmu, sid);
+		if (WARN_ON(!master))
+			continue;
+
+		atc = cmds->cmds[i];
+		/*
+		 * Hold ats_broken_lock across the per-master re-issue and the
+		 * possible disable_ats, so a concurrent reset_device_done()
+		 * cannot clear ats_broken between the timeout observation and
+		 * the quarantine action.
+		 */
+		spin_lock_irqsave(&master->ats_broken_lock, flags);
+		/*
+		 * A previous retry on a sibling SID may have already disabled
+		 * ATS across all the STEs owned by this master's SIDs. Skip it.
+		 */
+		if (master->ats_broken) {
+			spin_unlock_irqrestore(&master->ats_broken_lock, flags);
+			continue;
+		}
+
+		ret = arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, &atc, 1, true);
+		if (ret == -EIO)
+			arm_smmu_master_disable_ats(master);
+		spin_unlock_irqrestore(&master->ats_broken_lock, flags);
+	}
+}
+
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
 				   struct iommu_page_response *resp)
 {
-- 
2.43.0

