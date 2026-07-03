Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C2331D757;
	Fri,  3 Jul 2026 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051718; cv=fail; b=qfBc4C6V4ik8dZFXtS72/dAKcI1RFrEYbWq8xdcM4YcPe+jSUuLvLHQLvsXDsPhc95EBqw4UbY+tnNz6qDqcS+YJ9CKYVIAbdD5gCijM+xWxwSpOcUNrPMCDT495oSi9RrkZwmGrNg/BMYGKiqsgOytlqQjH4WZa0mycOUlCVpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051718; c=relaxed/simple;
	bh=aLTt8AsMP0oNgcHyvDxDqABFgEEnQZRk/VHsbjQHXR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ax+oT0AduVaDUcq7ISmirsPhQ3faY/K13E8EOLnriuC4Dqzm9N2umyyivucKGE1lCJOMhNsGILa3XE2csUQEjXsgJT+82WV5vXWmZAUdEk3jeDC8ib7Pf7KBmwb+NZ46GxgESk0C2mDBe7vnDTTHjU5wTxeROM3YJW0SHOEHG/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jjUSQkOz; arc=fail smtp.client-ip=52.101.53.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jjUSQkOz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDULJw7BPuLAShqRaaJxgWgU40fceYHovfq8OkECaG+GMX80cWN8nFJOR2v/hsqGmG36hMx7bhfhGDltmjUETEBkXvW5tJoJwJsMHUL/u/oqaxMpoH0GkfyUpv85it9ykDHvCr/VIBYwiRtrSlYj4rzfqQzfRBCQmFZJY4PBa27UsNomuW0cxW/WdhZVtzNCc3pchH8uRdwUzXm07aucYCs5mcL5mzuF5LYPnJJzbfhkjrpYCv2meruc2YBJ36aXv48sTFGYaWjw0NVEZJK9rZ98qP9jq0tHPe4WCgVLFo7gy0B3Rg07jiJ081VFGcgwEMuSOzqcSt7sPSqVWmvreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI2pT8hzOpPde7TrF/3KPRMf+lt+gPsuoueEIsdpiKU=;
 b=Kggx0cCnUij0GVEq/ZGsID6nULwZvdR4GdAuIcxQeWqPz3qYh8fh38V8Ar0cEF+WWWON0SZVxa4yVqQvoQI+n3NBdByDK0X8kxLktIWFt2SXubCfysnRyq4OjQWNOw17yzQAPJ0E3h48YmThrVpKVBJvB2gsnmbkoNvP2wVIuN2karQtPME1MNaqOI5y5awYsL/CHA+O3gskeWB66L5NkcBNWuCqCUzUhkdNvm7k5uD7XsEwO5q0CPN0Q2bVoG4rbjOsJdX7mAgDYKlUOMRpj8GyZz3x7h7pvvDRBqzBurwsjQXuyPE57as3xwtAuljV5Bzr8cXPRWJ25M5MOl7rNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI2pT8hzOpPde7TrF/3KPRMf+lt+gPsuoueEIsdpiKU=;
 b=jjUSQkOz0huQRatN2p6eCbs6uaR/TqIbzIOq/fzW+SgeUME5o+xN1cD+W7DpPF8dY/6EVhyFrHYBrdXl5W7c/N1nl+U5l3PbGsXnWhCHfKC4Ahw4i6V2gO9hmbVoZ1ZvLPTBi/ZPrnp+bns4zpKHF5vXgJLHBzOeCr8J5KwKELH7imMt4q5mo461bJj5OnlHx+5e6Yf/vUOy16DgTlU3q+eVVHt+t+46+PYj5idOMtQWHKkuCH6hqY3YbDF+f0g0j38gE1Cc5cNRIFHoM2oBvpy557zSPrtH+JcPhU8Ee58xK/JiE/tk9GJrEJ+xMRzfMRi/w/xDifHZNOEDkP5Jhw==
Received: from CY5PR10CA0022.namprd10.prod.outlook.com (2603:10b6:930:1c::28)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 04:08:13 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::17) by CY5PR10CA0022.outlook.office365.com
 (2603:10b6:930:1c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:08:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:58 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:56 -0700
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
Subject: [PATCH v5 18/18] iommu/arm-smmu-v3: Block ATS for a master upon an ATC invalidation timeout
Date: Thu, 2 Jul 2026 21:06:43 -0700
Message-ID: <939885143f3064811685b3f31f6f30f8a713c89e.1783044582.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c65e5f-3482-423d-fc5c-08ded8b8b364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|23010399003|1800799024|376014|11063799006|18002099003|5023799004|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	tN1lh2wwpHDWTLdJhSE1+HqNEn4ZijBXpeCZOPkXTJxMnI8IVtwFcSKhpQPL+bi+oxxZC554lLcKQhH9uNenaqV0vGlOAe4Xfc2BmKTeEvZLXFMd5JeNz2gdhn1vs6EqW3ZmDtevHUtnepFKtPs2eVN3lMLVQ+ITUchq9yGMkVgX+2hXG0TCJIAnI+urR2EDJYWEfBFV7nfwaPJ0WGxh0TIcZXZXsPTDN9v8FRYfYCWH502miTCrLYcTTNBtd37W1HyrXoETM/DZOCIhwBhrJSy6UMuBGvmTD/jEbVs8UJTt5EBBLA4cnaJjNM5eqYGh7rTdiePAPixZfLDKp6ewpenUzZ76g7b2UfKD2zJPTH9VymrZn5VXI5eWKhYEx7zCN3o+/Au15pktOS//Vm80Rx9zPepaMr3BDT6ZA8sEUb/6DI4MWxFjvLybRtbCYYv8wmlXzJo6iRJliwDAQpcovgXSBTno29hOjOKzYU1WhrSXd1AuRvAFEeagaFG9HYdm6x/I7G4Pnup2JTAXoxRxfHEDwGh+Z8t/2+9hOmE6gby31xxYHxeVzu0915NUT+s29WAXujOkFeu6hmp1U3yrdhBiKbaG3Tx3wAQpjRKZl27NUwh+SxfM4Cm1zs9BH8AstWv/s3q2yTmjZw8fCRT4nWHACgXozvggWSmFJ32+6V5u87D0dwvKdplD2205jnLK8arGZulGtVoFdya2q9knBQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(23010399003)(1800799024)(376014)(11063799006)(18002099003)(5023799004)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QFHO1DcQrdw8sgPp8SbAP0YI4Yr+VFQfyaBmCUBnEigKUFEwHjQ+NkWlXOMFfDQLvUHfhGB7gKtbNKl64R1Wt7frlZqoqI4bvp1Z1F/z2feiFnHdzRF6XTSdLnjnzb4q9QUxK35ykoJYbxSfp3n2G7etgc3rIjn5uMC+6P0ygwv/mI+QVbtrONdDpf1fvcGlb9qzB7sokOZBiVbkBLMMt1Xw+iHYs7LYJa5jQXocPYfgVH1fEVTrlMFtor+oWh6pS6ld45ksGAyLo4b1zpQ44RuYDq1/5bORmhqmiML+v537QKjBa0NA/3eC5r0KTKaDyy+ScMFht4Jtg5hVvcxzyre8WdgW0yVe6/C+Owfn0jjl7qE236HEi6n7NA0F+5+GS2rtxbZfk7E4kS6Jm5TbLHCKEBnr7PYWlnnqI5i5Kl2vag7gM1+p55Ijr7OOzShT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:08:12.7423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c65e5f-3482-423d-fc5c-08ded8b8b364
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

When a CMD_ATC_INV times out, the SMMU stalls at the trailing CMD_SYNC and
arm_smmu_cmdq_issue_cmdlist() returns -EIO. The CMDQ HW reports the timeout
on the CMD_SYNC, not the failing CMD_ATC_INV, so the master that caused it
cannot be identified from the error alone.

cmds->cmds is sorted by SID, so arm_smmu_cmdq_batch_retry() walks the batch
and re-issues one CMD_ATC_INV per unique ATS SID; a second -EIO can confirm
which master is broken. arm_smmu_quarantine_ats() then quarantines it:
 - clear STE.EATS on every SID it owns
 - walk master->master_domains marking its INV_TYPE_ATS/_ATS_FULL entries
   in every domain's invs as INV_TYPE_ATS_BROKEN so later walks skip them

When a batch carries only one unique Stream ID, the timed-out CMD_SYNC by
itself identifies the target, in which case quarantine it directly and skip
the re-issue probes. This is the common case, since it is uncommon for an
ATS-capable PCI device to have multiple Stream IDs.

The marking spans every domain because a master may be attached at the RID
and at multiple PASIDs; marking only the invs that hit the timeout would
leave its other invs issuing CMD_ATC_INV that keep timing out. Clearing
STE.EATS makes the SMMU reject the device's ATS but does not by itself
stop the driver from issuing CMD_ATC_INV, so the marking is what suppresses
the recurring timeouts.

The marking is gated on the STE.EATS clear: it runs only after the CFGI_STE
batch completes successfully. If that batch fails the entries are left as
ATS/ATS_FULL, so invalidations keep issuing CMD_ATC_INV and re-quarantine
until the clear is confirmed, rather than suppressing ATC_INV while ATS may
still be enabled.

The flip to INV_TYPE_ATS_BROKEN is a WRITE_ONCE on inv->type, paired with
the READ_ONCE in arm_smmu_inv_type(). The invs->rwlock is not taken here:
the caller holds the read side for the timed-out batch, so taking a write
side would ABBA-deadlock against a concurrent timeout. It is safe unlocked
because STE.EATS is cleared first, so a racing CMD_ATC_INV forms no ATC
entry and at worst times out again.

The STE.EATS clear uses try_cmpxchg64() to avoid losing a concurrent
arm_smmu_write_ste() update to data[1]. try_cmpxchg64() would be UB on the
Non-Cacheable stream table of a non-coherent SMMU, and a non-atomic
fallback could revert such a concurrent update (e.g. an S1DSS change). So
leave a non-coherent SMMU unquarantined, keeping the pre-existing behavior
of reporting every ATC_INV timeout.

Also force a CMD_SYNC on every sub-batch flush carrying an ATC_INV so the
timeout is observed at the call site that issued the commands.

Identification is synchronous: each master that keeps timing out adds one
more CMD_SYNC poll, capped at the ARM_SMMU_POLL_TIMEOUT_US software limit.
That cap is rarely reached: a non-responding ATC_INV is completed in error
when the device's PCIe Completion Timeout expires, which defaults to a
short interval.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 201 +++++++++++++++++++-
 1 file changed, 198 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fd9a095154c72..528d816479d7f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -109,6 +109,10 @@ static const char * const event_class_str[] = {
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
+static struct arm_smmu_ste *
+arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid);
+static struct arm_smmu_domain *
+to_smmu_domain_devices(struct iommu_domain *domain);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
@@ -920,12 +924,25 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
 	cmds->has_ats = false;
 }
 
+static void arm_smmu_cmdq_batch_retry(struct arm_smmu_device *smmu,
+				      struct arm_smmu_cmdq_batch *cmds);
+
 static int arm_smmu_cmdq_batch_issue(struct arm_smmu_device *smmu,
 				     struct arm_smmu_cmdq_batch *cmds,
 				     bool sync)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
-					   cmds->num, sync);
+	int ret = arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					      cmds->num, sync);
+
+	/*
+	 * The CMDQ HW reports an ATC invalidation timeout at the trailing
+	 * CMD_SYNC, not at the failing CMD_ATC_INV. Re-issue each unique ATS
+	 * SID in the batch to identify the unresponsive master and block its
+	 * ATS so subsequent invalidations make forward progress.
+	 */
+	if (ret == -EIO && cmds->has_ats)
+		arm_smmu_cmdq_batch_retry(smmu, cmds);
+	return ret;
 }
 
 static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
@@ -941,6 +958,10 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
 	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
 		return true;
 
+	/* ATC_INV timeout is reported to CMD_SYNC; catch at the call site */
+	if (cmds->num == CMDQ_BATCH_ENTRIES && cmds->has_ats)
+		return true;
+
 	return false;
 }
 
@@ -1014,7 +1035,11 @@ static inline struct arm_smmu_inv *
 arm_smmu_invs_iter_next(struct arm_smmu_invs *invs, size_t next, size_t *idx)
 {
 	while (true) {
-		if (next >= invs->num_invs) {
+		/*
+		 * Lockless readers (arm_smmu_invs_set_ats_broken) pair with the
+		 * WRITE_ONCE() in arm_smmu_invs_unref(); num_invs only shrinks.
+		 */
+		if (next >= READ_ONCE(invs->num_invs)) {
 			*idx = next;
 			return NULL;
 		}
@@ -2505,6 +2530,176 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
+static void arm_smmu_invs_set_ats_broken(struct arm_smmu_invs *invs,
+					 struct arm_smmu_device *smmu, u32 sid)
+{
+	struct arm_smmu_inv *inv;
+	size_t i;
+
+	/* arm_smmu_atc_inv_master() submits batches with invs=NULL */
+	if (!invs)
+		return;
+
+	/*
+	 * invs->rwlock is deliberately not taken: the caller holds one domain's
+	 * read side for the timed-out batch, then taking another domain's write
+	 * side while a concurrent timeout does the reverse would ABBA-deadlock.
+	 *
+	 * This indicates some potential races, but they are harmless since EATS
+	 * was already cleared:
+	 *  - WRITE_ONCE() may hit a stale invs copy if an attach just installed
+	 *    a new invs, which might result in another ATC_INV timeout.
+	 *  - a concurrent invalidation may still issue an ATC_INV that may time
+	 *    out again.
+	 */
+	arm_smmu_invs_for_each_entry(invs, i, inv) {
+		u8 type = arm_smmu_inv_type(inv);
+
+		if (inv->smmu == smmu && inv->id == sid &&
+		    (type == INV_TYPE_ATS || type == INV_TYPE_ATS_FULL))
+			WRITE_ONCE(inv->type, INV_TYPE_ATS_BROKEN);
+	}
+}
+
+/* Find the master by SID and block its ATS at the SMMU */
+static void arm_smmu_quarantine_ats(struct arm_smmu_device *smmu, u32 stream_id)
+{
+	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_op(CMDQ_OP_CFGI_STE);
+	struct arm_smmu_master_domain *md;
+	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_master *master;
+	struct arm_smmu_invs *invs;
+	unsigned long flags;
+	int i;
+
+	/*
+	 * The in-place STE.EATS clear relies on try_cmpxchg64(), which is UB
+	 * on Non-Cacheable memory. Leave a non-coherent SMMU unquarantined:
+	 * its invalidations keep issuing ATC_INV and reporting the timeouts.
+	 */
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY))
+		return;
+
+	guard(spinlock_irqsave)(&smmu->streams_lock);
+	master = arm_smmu_find_master(smmu, stream_id);
+	/*
+	 * A concurrent hot-unplug can release the master while a stale ATS
+	 * entry for it still lingers in the invs snapshot being walked here.
+	 */
+	if (!master)
+		return;
+
+	/* Clear STE.EATS for every SID and sync to the SMMU */
+	arm_smmu_cmdq_batch_init_cmd(smmu, &cmds, &cmd);
+
+	for (i = 0; i < master->num_streams; i++) {
+		u32 sid = master->streams[i].id;
+		struct arm_smmu_ste *ste = arm_smmu_get_step_for_sid(smmu, sid);
+		__le64 old, new;
+
+		/*
+		 * A concurrent arm_smmu_write_ste() of a domain attachment may
+		 * overwrite the data[1] and set EATS, which is recoverable by
+		 * another ATC_INV issued by its arm_smmu_attach_commit().
+		 */
+		old = READ_ONCE(ste->data[1]);
+		do {
+			new = old & ~cpu_to_le64(STRTAB_STE_1_EATS);
+		} while (!try_cmpxchg64(&ste->data[1], &old, new));
+
+		arm_smmu_cmdq_batch_add_cmd(
+			smmu, &cmds, arm_smmu_make_cmd_cfgi_ste(sid, true));
+	}
+
+	/*
+	 * Only proceed to mark the entries broken if the STE.EATS clear above
+	 * is confirmed; otherwise return so invalidations keep issuing ATC_INV
+	 * (and re-quarantine) until ATS is actually disabled.
+	 */
+	if (arm_smmu_cmdq_batch_submit(smmu, &cmds)) {
+		dev_err_ratelimited(smmu->dev,
+				    "failed to disable ATS for master\n");
+		return;
+	}
+
+	/*
+	 * Mark this master's ATS entries broken in every domain it is attached,
+	 * so later invalidations skip the ATC_INV that would time out again.
+	 */
+	rcu_read_lock();
+	spin_lock_irqsave(&master->master_domains_lock, flags);
+	list_for_each_entry(md, &master->master_domains, master_elm) {
+		struct arm_smmu_domain *smmu_domain =
+			to_smmu_domain_devices(md->domain);
+
+		if (!smmu_domain)
+			continue;
+		invs = rcu_dereference(smmu_domain->invs);
+		for (i = 0; i < master->num_streams; i++)
+			arm_smmu_invs_set_ats_broken(invs, smmu,
+						     master->streams[i].id);
+	}
+	spin_unlock_irqrestore(&master->master_domains_lock, flags);
+	rcu_read_unlock();
+}
+
+/* Re-issue every unique ATS SID in @cmds to identify and quarantine masters. */
+static void arm_smmu_cmdq_batch_retry(struct arm_smmu_device *smmu,
+				      struct arm_smmu_cmdq_batch *cmds)
+{
+	struct arm_smmu_cmd atc = {};
+	u32 last_sid = 0;
+	int nr_sids = 0;
+	int i;
+
+	/*
+	 * Count unique Stream IDs, taking advantage of the sorted commands. An
+	 * ATS-capable PCI device rarely has multiple SIDs, so a batch commonly
+	 * carries a single SID, where a re-issue probe would be pointless.
+	 */
+	for (i = 0; i < cmds->num; i++) {
+		u32 sid;
+
+		/* Only ATC_INV commands can time out */
+		if (FIELD_GET(CMDQ_0_OP, cmds->cmds[i].data[0]) !=
+		    CMDQ_OP_ATC_INV)
+			continue;
+		sid = FIELD_GET(CMDQ_ATC_0_SID, cmds->cmds[i].data[0]);
+		if (!nr_sids || sid != last_sid) {
+			nr_sids++;
+			last_sid = sid;
+		}
+	}
+
+	/* The timed-out CMD_SYNC already identifies the lone Stream ID */
+	if (nr_sids == 1) {
+		arm_smmu_quarantine_ats(smmu, last_sid);
+		return;
+	}
+
+	for (i = 0; i < cmds->num; i++) {
+		u32 sid;
+
+		if (FIELD_GET(CMDQ_0_OP, cmds->cmds[i].data[0]) !=
+		    CMDQ_OP_ATC_INV)
+			continue;
+
+		/*
+		 * One retry per Stream ID. So, only try the first command since
+		 * commands are sorted. And each dead master costs one CMD_SYNC,
+		 * bounded by its PCIe Completion Timeout (usually <= 250ms).
+		 */
+		sid = FIELD_GET(CMDQ_ATC_0_SID, cmds->cmds[i].data[0]);
+		if (atc.data[0] &&
+		    sid == FIELD_GET(CMDQ_ATC_0_SID, atc.data[0]))
+			continue;
+
+		atc = cmds->cmds[i];
+		if (arm_smmu_cmdq_issue_cmd_p(smmu, &atc, true) == -EIO)
+			arm_smmu_quarantine_ats(smmu, sid);
+	}
+}
+
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
-- 
2.43.0

