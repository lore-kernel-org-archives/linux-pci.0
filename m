Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAFC580394;
	Wed, 23 Sep 2026 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194411; cv=fail; b=IcfLgtel5cOtuSWEeqLrK+fAoGWXyeidalOTm3hUzdoVGajazHSTJ+YVAD0nEQJ4goa9ftEiI79lFtu/RqWnIymU31J1htsJ03CsJAJWBOvQrQyXgWTlc4ICjRda8/lzvbPOLQghXI4xWCJVgq6d3DHOGsanavZjrM/4hKuQj4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194411; c=relaxed/simple;
	bh=dfCWSLVjaLxoebqDlvo11XnbpR5ZFtpgOXOkhkCGaWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I00+LD8yYaiVQ75Xr1UjMokWT0RK1vMJdXOi5tijnhVWvQOLDIFp926925bGWcgWfmpNHzdIG2PaaJhXcq743tibWMh+fu/dUqOO6UggXlCk2FurNV0V4i5ib/h5FcW3bcQsc5R2ycCexsPbOXrt2dx8Qyg27dx34XuEfHQb7ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e90o2maM; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e90o2maM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pc2DdGwUN3OsxIV9laBJASZ/hBj+tnq0+E7UdN2Lqo5djeffJDoPXOYqTZTL+BbeP+dIwEgjbzgjNN1KHP/Lv0zE4mQDS/NlJVPwC3I3Lb7RmzUSEvX6gmCDaWhdG6n9b4Zco4w2dtMQHyJL+C0vzo4kxTcHA1uu5MWyMQb2M20x2BJxBb4eDb7Zv+Cg2Fq2r7vBuFv+y5FaYeFu0fDDIrQwDdE+x4xATXnn6jG1rAhCdZ2lgAd+GyxwYx0dlyiegGBgg61moRMXdEdY02ytztGYX5HIhu7XF0HunHMVl+ZqdIIYoEkuGlflzmElAx4JUAdysrt7amtdqeVku3L7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymo3gRmQVBr56Ot6VYjwUZuuQ6vTgqFb3ZngTJs9wJQ=;
 b=nXj41vpQpFtCx4zcgc05Jo9LQYun9eZCjCFRCiTej9pxY3fqMbxrXrUO5aitrvZvnFWbkte+OMVqBeruMtcKm5MCZ8I35L27fyhyNIshpeqQhKWrQWcZvGQNNL3ClR2KVQOmYb4+kqJF+L0TDyrtKAqWSe5541PYNnZyWRBCVgv7vUWMjx5bUR7jnl1g5TDcaz9Vr81IQv2hdXJsU6Usexwe1/yVO+xLqMBZ+Wor1eQ8jGI2vtn5+aU0QA1RLqaBKng3/L4j3lJITtuKFzczdrJuG5BNklt0FkXULBRZ6oq8hDsRe6k2tnfXdmR3hKIay4M/nq5Jz2fV5+n0Ti8HLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymo3gRmQVBr56Ot6VYjwUZuuQ6vTgqFb3ZngTJs9wJQ=;
 b=e90o2maMzG4i2eyaMomDJlUTftU6Jv1c2iuqCRgyYa1B2UGuMMHVeQ8V4ZkF5yjCVRaY96uH75j3KzKysbHAvq47B79nswJ5Bq6MVDGNTKEiGGtFPh4QMh2KXQ3M2Pxtf05tubK6pfXM+J06e6BTa5HGlLY/tvvN8/KgmE0rFtbM0A5SjGvNo5GLblKgh597zR/tXD5ttrF8kPQyxZkugx/v8XuDVlnGc6aK6w/59MQQh19gEZz3xhWdtKc4Yrk7O8l16rn/RPhznZPXYKOc/GK2vxUtAfiYkvw7ZfPy0zCq+6yU5BjxIeRn67NDm422RN4ivI7OgPRFvnfLHr90Mw==
Received: from PH8PR22CA0016.namprd22.prod.outlook.com (2603:10b6:510:2d1::9)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 23 Sep
 2026 20:12:36 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::39) by PH8PR22CA0016.outlook.office365.com
 (2603:10b6:510:2d1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 20:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:11 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:12:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<vsethi@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v6 15/17] iommu/arm-smmu-v3: Add INV_TYPE_ATS_BROKEN for quarantined masters
Date: Wed, 23 Sep 2026 13:11:34 -0700
Message-ID: <d27ae4b7788ef8582c60fd5865f11c955e277174.1790188511.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dcbeeaa-c1fd-4501-2865-08df19af01fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|7416014|23010399003|1800799024|10067099003|3023799007|18002099003|22082099003|56012099006|11063799006|3613699012;
X-Microsoft-Antispam-Message-Info:
	xLRfSH0HcoQ6BPd0wJZb6ac6I6TI3rDhELf7jiQOpBG+ehJzWA03nX8TE2EymhNlJSIiVSP02BM+R2hQU3E8WiB5XZRfa+FVwdO/fRudeTKVZpXJNbrnAhduPdDFvHv1MJUG+b6Hx+SfYRLiJV/P1hvnghoR4sCumPHTPCc+n7SDFM9lhaff7Vpk0luTF9QvnX/PfjoZM83nUoC6z4XbyzaJez6e84+8B24FZ9QaP5yli0Su5B4BRrM1FTYH4UY8q/h51ckmnCI59iswsYgyDG28H5Y9gHEoMifAzxGo1bHiQJhppF3O0i4m0o1tP8Gz2N77cXjoSWphd7pyVO5JQo45tP4IvRLUWrH1e+6aFa36cA5pziLy59LbSJO0vdmOH5SS/gRbBJfKwTQoTR+ChYREcw682xUD0q+hu4VrWVE1t07ecJrMQdE2JmkmqY8pcoeYUmqD47TYWBWTDhfC83x2cQJCuz5tTAiCCXLP3SNvv4rnHIbHL758SLkosoJ+QJ4Jobo+AwUcixnhZ7b5Wm4FaQAJ63XuTL5QMIkwCov2ZGyLqye8I3LyNFWOXExpOfKkWggzUalpTn05WMZnm8VuVDtRT80TD5RNUR6xhqMrctzRdeLKIHXIK+X2U7TmRZBL0tRosgC+gLqUDflJjAUgyArbtIUap43hjWDyGf9K/rFssOekHZCjI+K6ApOIynNoZFD6tIvSooRNkVKaBUCDc9xVMjTgMU9kU6EbxEqmkcD5gv3C6kMVZEzauOiV
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(7416014)(23010399003)(1800799024)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wUnUYhqN0pDz0bcCQZX5k8LAyYMzQEloJWTaJTOBscamQxA6In1Ue/E7FdI5SpmURcg8qOzjEKdiGC7lirl5nz28CvGPPYWPN2QDFPPXzXQOCRReC+KhwDpKlbpdwsK7tBF9ngx+fx/CRfeDFF2LCN1WvIAgzyZjXWTpjeOhNeXb+0MRucv6bUkC+6FTDif13MYKwxOGBjbfb3N6PWo/4sQ7EJwBWmZS09pel+3T7lfAI649c1oZM1QlfptqkwmYR0mb2CRfUDLsBzXCJC7Ag6Z4L9Vs7mWvHqCnrsSmfaoYycIy83FHY/Wl5CRdswpYRzkeO1jdi15fsIaeHdSDzIiv8mO8SHnWWKd62dju3fByIwNWBhIbSs66NJlLEgUURcvXMUzRqAC+iqHegZ7aLpu8GucRbLMcsE8Au4/Y2Htz6edzBXbtbcnl9rutYz7V
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:35.2268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcbeeaa-c1fd-4501-2865-08df19af01fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103

Clearing STE.EATS makes the SMMU reject ATS requests from any quarantined
master, but does not stop the driver from issuing ATC invalidations for it.
Those commands would continue to time out.

Introduce INV_TYPE_ATS_BROKEN, which a subsequent change will assign to the
master's ATS invalidation entries. Treat it as an ATS type during iteration
and ordering, but skip it when issuing commands.

The subsequent quarantine path changes inv->type in place via WRITE_ONCE()
while readers hold the invalidation array's read lock. Since a u8 load is
already atomic, arm_smmu_inv_type() uses READ_ONCE() to annotate the race
for KCSAN. Whole-struct copies in merge and purge cannot use READ_ONCE(),
so annotate those copies with data_race().

A stale read at worst issues one more ATC_INV, which times out and causes
the master to be quarantined again.

Treat ATS, ATS_FULL, and ATS_BROKEN as one comparator class. This preserves
the sort position and matching identity when an entry is changed in place.

No functional change yet; the new type is never set anywhere.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 12 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++++------
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6fa4f390ad133..1394a14241fd3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -739,6 +739,7 @@ enum arm_smmu_inv_type {
 	INV_TYPE_S2_VMID_S1_CLEAR,
 	INV_TYPE_ATS,
 	INV_TYPE_ATS_FULL,
+	INV_TYPE_ATS_BROKEN,
 };
 
 struct arm_smmu_inv {
@@ -755,9 +756,18 @@ struct arm_smmu_inv {
 	int users; /* users=0 to mark as a trash to be purged */
 };
 
+/* cur->type may flip to INV_TYPE_ATS_BROKEN concurrently with readers */
+static inline u8 arm_smmu_inv_type(const struct arm_smmu_inv *inv)
+{
+	return READ_ONCE(inv->type);
+}
+
 static inline bool arm_smmu_inv_is_ats(const struct arm_smmu_inv *inv)
 {
-	return inv->type == INV_TYPE_ATS || inv->type == INV_TYPE_ATS_FULL;
+	u8 type = arm_smmu_inv_type(inv);
+
+	return type == INV_TYPE_ATS || type == INV_TYPE_ATS_FULL ||
+	       type == INV_TYPE_ATS_BROKEN;
 }
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 607246a965a91..359cbee20ce5a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1094,13 +1094,21 @@ arm_smmu_invs_iter_next(struct arm_smmu_invs *invs, size_t next, size_t *idx)
 static int arm_smmu_inv_cmp(const struct arm_smmu_inv *inv_l,
 			    const struct arm_smmu_inv *inv_r)
 {
+	/*
+	 * Treat all ATS types as one class, so an in-place flip to ATS_BROKEN
+	 * preserves the sort order and still matches the original ATS entry.
+	 */
+	bool are_ats = arm_smmu_inv_is_ats(inv_l) & arm_smmu_inv_is_ats(inv_r);
+	u8 type_l = arm_smmu_inv_type(inv_l);
+	u8 type_r = arm_smmu_inv_type(inv_r);
+
 	if (inv_l->smmu != inv_r->smmu)
 		return cmp_int((uintptr_t)inv_l->smmu, (uintptr_t)inv_r->smmu);
-	if (inv_l->type != inv_r->type)
-		return cmp_int(inv_l->type, inv_r->type);
+	if (!are_ats && type_l != type_r)
+		return cmp_int(type_l, type_r);
 	if (inv_l->id != inv_r->id)
 		return cmp_int(inv_l->id, inv_r->id);
-	if (arm_smmu_inv_is_ats(inv_l))
+	if (are_ats)
 		return cmp_int(inv_l->ssid, inv_r->ssid);
 	return 0;
 }
@@ -1186,11 +1194,12 @@ struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
 		return ERR_PTR(-ENOMEM);
 
 	new = new_invs->inv;
+	/* data_race(): a racing quarantine may flip ->type; the u8 is safe */
 	arm_smmu_invs_for_each_cmp(invs, i, to_merge, j, cmp) {
 		if (cmp < 0) {
-			*new = invs->inv[i];
+			*new = data_race(invs->inv[i]);
 		} else if (cmp == 0) {
-			*new = invs->inv[i];
+			*new = data_race(invs->inv[i]);
 			WRITE_ONCE(new->users, READ_ONCE(new->users) + 1);
 		} else {
 			*new = to_merge->inv[j];
@@ -1312,8 +1321,9 @@ struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs)
 	if (!new_invs)
 		return NULL;
 
+	/* data_race(): a racing quarantine may flip ->type; the u8 is safe */
 	arm_smmu_invs_for_each_entry(invs, i, inv) {
-		new_invs->inv[num_invs] = *inv;
+		new_invs->inv[num_invs] = data_race(*inv);
 		if (arm_smmu_inv_is_ats(inv))
 			new_invs->has_ats = true;
 		num_invs++;
@@ -2700,8 +2710,8 @@ static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
 	if (cur->smmu != next->smmu)
 		return true;
 	/* The batch for S2 TLBI must be done before nested S1 ASIDs */
-	if (cur->type != INV_TYPE_S2_VMID_S1_CLEAR &&
-	    next->type == INV_TYPE_S2_VMID_S1_CLEAR)
+	if (arm_smmu_inv_type(cur) != INV_TYPE_S2_VMID_S1_CLEAR &&
+	    arm_smmu_inv_type(next) == INV_TYPE_S2_VMID_S1_CLEAR)
 		return true;
 	/* ATS must be after a sync of the S1/S2 invalidations */
 	if (!arm_smmu_inv_is_ats(cur) && arm_smmu_inv_is_ats(next))
@@ -2737,7 +2747,7 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 		if (!cmds.num)
 			arm_smmu_cmdq_batch_init_cmd(smmu, &cmds, &cmd);
 
-		switch (cur->type) {
+		switch (arm_smmu_inv_type(cur)) {
 		case INV_TYPE_S1_ASID:
 			cmd = arm_smmu_make_cmd_tlbi(cur->size_opcode,
 						     cur->id, 0);
@@ -2771,6 +2781,9 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 				arm_smmu_make_cmd_atc_inv_all(cur->id,
 							      IOMMU_NO_PASID));
 			break;
+		case INV_TYPE_ATS_BROKEN:
+			/* Master is quarantined; skip its ATC_INV */
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			break;
@@ -3326,6 +3339,8 @@ arm_smmu_master_build_inv(struct arm_smmu_master *master,
 		cur->size_opcode = cur->nsize_opcode = CMDQ_OP_ATC_INV;
 		cur->ssid = ssid;
 		break;
+	case INV_TYPE_ATS_BROKEN:
+		break;
 	}
 
 	return cur;
-- 
2.43.0

