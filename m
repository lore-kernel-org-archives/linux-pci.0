Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358158039B;
	Wed, 23 Sep 2026 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194392; cv=fail; b=eSb1nDhZsFgIkUZfvyCorg4j0qCKPLkPM/mtFZg/bzjPd5097WiaPc+3O1i5MpB0d7fqVin8JM40EuZjEDw+lR0xql21eW4lJcgfzGALdM1zQVlEvxcKS7eD4GOTh8TSYYU7QqQ7iE8rAUNj2uYRiTntFM6q0w1KBXg1GPjTygE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194392; c=relaxed/simple;
	bh=byTIKMVBTsw7ofNxAtl3qxXYRykuJ3AtzGo18h7U+Ss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLSVAIXaOok9LkJtJf1HUTvhvAxvbLgq2J/7HKX54uV9G+vDdbaKjj0QofgolgXDDkH2W5+njwTnCumxnjUvytoZ/vBRBcyBWiAcElP6UrnDqkLiBDALM+9Q++Cvn6JnV3pJPgIRboitoeX0uq/1DkAl8QPYWstbMvyBVpu3gw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rD1ilyXo; arc=fail smtp.client-ip=40.107.200.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rD1ilyXo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxUn9mfuZ8WW9dX5U1geYEuiOQ1IZhF2/VEz6AAm4hzRxMDoS0aqbiMOlL1GxrvbNG0s1cUdOHRs0tFj+4RrtfOZSmvHu7L86D3GAQE+E71eNN6XaRyFkW4PUYivRW3iG/x6UjPySq+H1BBXy//OtExXtbcE1U+oXfmrYi//ELKZZeVG7Bxw5K1Z6sLmPNM8asJLcryusjceKFIUe8qShdXFo0Dqxxa2iVTkkPtMN563wUzyK7wsxxL0B5Rtluwh2fl2hgWDdpdwbUO52bFh4abNr54NKzp+75nIrx+cPvEsmnKMHiAG3yJUEpsmsiyAaLFJmatvzE6b9iIsRVSWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfndK0A+/yqgGnOXvx+QjMo3TqnDTESBk6QE8k75nkY=;
 b=BMouj6moAw+YohciMLe8mVHJn7ny0s+Amq0kP96XsQsaPF5ASeb7TfGSWGGVZUQDCzqtd0Ps7ZdKB3KimeEBTQJBfNypIJ7I3kYEANYqtLf7W5CnTVYYylSDmjFJaj7R8jGc2v1vDr9OFRpD1mt+JsywO6yOzmvnbrx+I1tfvYKFLVmqRjPWB+VZXHAcmRiwwmvR42zFhyghKkOCPO1t82hNmvMqfqX+IflvN7XY+JhRotwQ6NosH2GccUZdPxdMvTvIjEnUEQInpqNzLOKWEWHaS+fSbDwLCrVnrXZTMlN8cP+1JeXLHXJeuRaKE0GFCRD+IEAAEmj46MW5+ExXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfndK0A+/yqgGnOXvx+QjMo3TqnDTESBk6QE8k75nkY=;
 b=rD1ilyXoEOfniazQpHgibRRjETP2czBc0D6UAUVsa0ToRa9VGVsZIRO4QwURdBZnyIWjuC5PNzBsp2w/hfw5kYLjrE9zidu5Cc5xFrYp2tdS85ckKzNYzQ9+2tl7ecEzmdmil11PrJw4Zd7tAVDpxVrxdoUnsRAdk34KP8anzuc0Ge3v02hkP8L7MvOVghPe70jgwJYeCn3Uy/M67KoZ8Unnh5Ci4ll1P6EG+e6X4NGjec7vexxwSpsO7An5uOmfz5aPShFy/mxggZEG5jhM/PjvsWGtf1KLtaMO/gA0HyXFOui9BLKrDvfA6IWylC6amRvUbaiBWZJO5JIfiYiOHA==
Received: from MW4PR03CA0229.namprd03.prod.outlook.com (2603:10b6:303:b9::24)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Wed, 23 Sep
 2026 20:12:38 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::66) by MW4PR03CA0229.outlook.office365.com
 (2603:10b6:303:b9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 20:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:14 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:12:13 -0700
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
Subject: [PATCH v6 17/17] iommu/arm-smmu-v3: Quarantine ATS after an ATC invalidation timeout
Date: Wed, 23 Sep 2026 13:11:36 -0700
Message-ID: <94c7039fc6dcb15b86f79bb72d00e3c4eb11b4f8.1790188511.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5ff955-264c-4363-de41-08df19af02c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|10067099003|11063799006|5023799004|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Vhgx6XjtYydoj57fgxU9v31E9HOqEbybdCBuph99DWd0QQIJmIdMz4Y/f8uKQTqhQakBEGgksGrsBGZzznp+xszJS2EdaV4UxDzgqndcl9Ha69EsnmsrqoRUh8lL62jsMpRZVz9mrysGNvoqWqMZOLfUv5n2a4xAe+dOb69kMm8WwQzTiWQSjmSd8sIeTGeYR03oOBJWW7P3OqbC+4/iyLjkOlbctYRj9OXuuEMvPr+ZYsbMl/32shxrLsmhaZwfxcmeOog4webAMro8eQRSPJMSKJqjKZNf5iYL2vNNaUjVwDR+gxstw6CtMlR+9AhJhLsU316MkvwIQwT5XYebir6mTZywVG4yQmRZ5JTHexbJFTbKMrzec0jCLUkWez0GQOPONvJCyr2iQpsyBw2KH4hFBXD7C9Ckc65WY5luj7ggiRY9XIfmDcoxf18YqFXSK9bv3WIXIYREssIPr2JjmZAdbGiu4W4fOjnyWwGfiKBblkZcDqOZp2IGA3N58FbaTQFvln5H+7klTY9Fl8bBcMz2AUg0n/dUaxNij3NacRVJWB2WJb0IBv2jDcHxY4g8fp9R+QlprWGAcyAzaIuDYEYzfZhT8DJiICQAz8qxKViV5LH6OmN3ekIRJ4JYZqgZabQoFSku2k0Ft6wnexji5fvBNQkFNuMq/HvnJFZ8OZN0fp3kAkubqQrZPfnm+cnXf3hCBAtssyly7cvo/qWiSA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(10067099003)(11063799006)(5023799004)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4HU1JjtrEtZHx2P2rGJeBk1h8WlKq0bS0+ypNTPDvFkDp7aFStccJJl3vLo2VHxzzlFv8EeX3rZ5k4ixktHrKCFJ4c5ODW0BuGOPV2Sy2Jgc4ea0Ge3zBlLxQk75gvsiPBk1F6pLVVATUZikZOpll687Wc6VwGMEa8f1SbEifOQjsnk1VEzVY/0HHtuYSS6f9ZwN/W5UOrDx1a2cVfegzuhIfviNpTgSlTU94OeRFDxn2ABXdJXgBERDVJ6xZHP+q3WyBr6grLh3wtf4VQsoCM7uSeMU0pp8a/w5zguHP24TLF8mWRcDou3wyXBA2hRttDDiiXUhU36nRONs45AgqClTJbSeH5t0H3bUiHWNcPn2PMLxcZNxJoWzk9gYNb8bN5eQyRYTTh4pmRUN/n1Bu26EcQ564gZtfgZL+mYA2Wb/ZkN5CswyIUN7FHQv4VOY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:36.5292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5ff955-264c-4363-de41-08df19af02c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961

An ATC invalidation timeout is reported on the trailing CMD_SYNC, thereby
identifying the failed batch but not the CMD_ATC_INV or responsible master.

cmds->cmds is sorted by SID, so when an ATS batch returns -EIO, retry one
invalidation for each unique SID to find the unresponsive master. A batch
with only one unique SID needs no retry. This is the common case, since it
is uncommon for an ATS-capable PCI device to have multiple Stream IDs.

For each identified master, clear STE.EATS on all of its SIDs and mark its
ATS invalidation entries in every attached domain as INV_TYPE_ATS_BROKEN,
thereby blocking further ATS requests and preventing repeated ATC timeouts.

The marking must span every domain because a master may be attached at its
RID and at multiple PASIDs. Marking only the timed-out invs would leave its
other invs issuing CMD_ATC_INV commands that continue to time out.

Only mark the entries after the CFGI_STE completes successfully. Otherwise,
leave them active so later invalidations retry quarantine instead of being
suppressed while ATS may remain enabled.

The marking cannot take invs->rwlock for writing because the timeout path
already holds a read lock; taking the write side would ABBA-deadlock this
path against a concurrent timeout. Change the type with WRITE_ONCE(); once
STE.EATS is cleared, a racing invalidation cannot create any new ATC entry
and may at worst time out once more.

Use try_cmpxchg64() to clear STE.EATS without losing a concurrent update to
the STE; a non-atomic fallback could revert concurrent changes, such as an
S1DSS update. On a non-cacheable stream table, try_cmpxchg64() is unsafe,
so limit quarantine to coherent SMMUs. Non-coherent SMMUs retain existing
behavior of reporting every ATC_INV timeout.

Finally, force CMD_SYNC on every sub-batch containing an ATC invalidation
so the timeout is observed by the call that issued it.

Identification is synchronous; each unresponsive SID adds a CMD_SYNC poll
bounded by ARM_SMMU_POLL_TIMEOUT_US. That bound is rarely reached, since a
non-responding ATC_INV completes in error once the device's PCIe Completion
Timeout expires.

Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 202 +++++++++++++++++++-
 1 file changed, 199 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c56fd5c6b6242..db202b79bf1e6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -118,6 +118,10 @@ static const char * const event_class_str[] = {
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
+static struct arm_smmu_ste *
+arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid);
+static struct arm_smmu_domain *
+to_smmu_domain_devices(struct iommu_domain *domain);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
@@ -966,12 +970,25 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
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
@@ -995,6 +1012,10 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
 	    arm_smmu_erratum_cmd_needs_repeating(&cmds->cmds[0]))
 		return true;
 
+	/* ATC_INV timeout is reported to CMD_SYNC; catch at the call site */
+	if (cmds->num == CMDQ_BATCH_ENTRIES && cmds->has_ats)
+		return true;
+
 	return false;
 }
 
@@ -1068,7 +1089,11 @@ static inline struct arm_smmu_inv *
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
@@ -2558,6 +2583,177 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
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
+
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

