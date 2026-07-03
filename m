Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6BD3290D1;
	Fri,  3 Jul 2026 04:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051711; cv=fail; b=ghWynlkIenSCG2ouwHnAbHE3dA/WUldGlblRLuDevPCklKS1NdoZd3MLQdtzvkrnYRkcqd6gBvw1rGBUac5HYCVtuj/vNNWFfnPLSmdb82qccb775EWLafKZ9S6gNxODn8/D0VcBTlLukCAMzJcNLHE6933Cmi/OjpYu1SI4Mdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051711; c=relaxed/simple;
	bh=m+QaF6HZ5eAtsbPRqoOxAzSiHYcOC09ZAiLm6gFnKss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsBtpzCTfr2VK5t2bxqzrmpK8pY3hGOtU9YNIpuoUDhyXfU2XnEgCjWJMhChTd4s0H3mcWZcxVVRs4TNkRvnvUuqiwM+ksoyjrS1g0TACfuN6efpV7K63sf/8+UVTTuPp5ZVuTkwmKKpMTb1fyTz2CYQWGz9Jl6vJwenWw+aNqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O5fE7A0/; arc=fail smtp.client-ip=40.107.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O5fE7A0/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFr0UpsqJ2tL1KtAPzv9t9QqVU6AE6MLltCDMG2+TT4MzV6LiS9Hkz4KE9n8cuap63/aSVD/zkSgNCs23Y4lGh1wE0aDBnS6VO8ykIVNjHhuslkyT7tLxGoqol08ybYQPyzq5kIMpCU5jIt5QzmUh42mApE5w1B/9AuL3gZNZt+iLQB8hhpOP2K5jETTLcjRRvv8B8t/Z9X2fykCKMmQ1Y3oz8K2ev8JuHFK7mN1ipI43RadyUTp4qfPWdyQ+Ba+Ch3QLe7H7irq8AswzQ3e7GbuJ5xq71+GFLj21Kb3EcOR7dPkD5bJ32XlD+rZaPnmqvPZFc+dsGFp0H76Dpog6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/6tvFHdTXaw9gJZtrDxI+Hv1XaGjw+thujkxPe/6Iw=;
 b=CZe7BDrympJUID9bzBt24D8JeCjgDW7hkH4uZs4vSgMxogVnV3ftx9RPauSkj3huuQ//Gegyj2J0W2sBKsvNTcausTvJVlkkI51Eum4fQrfUQnRaNvtNds20Tlxk2c+D+2wObjd2k5J7Ebxkot48AYk1YkV0P6XvhuVJySZ2n+ffCOFCe3TcoU0xtwPpgsCwIh4flFilQpin5Xy5NNvmWe+p8FgLmGhZcVulHvP+X4ABbvn5rFTdk9vu0vV09M9A+O4KB3FW2nHyzNosnJwAPBAxAWTUqVzA5UWy/DmjNkrW76a3MVeoB9IjyyH0idhrNmrAk1YZf3uLNAnxbFKRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/6tvFHdTXaw9gJZtrDxI+Hv1XaGjw+thujkxPe/6Iw=;
 b=O5fE7A0/sTJDFa/QRo57j50C1nnWeQxRxrw9mbVpitXQKUNvkv4OdjHdME+CyOMg9s+I0XvA4nu4ICNDPIZpgZTQGohpWbATx/N08tRFmk/vuhEsSRZlRNEgg5fbnBcKgJsR5st8WPdYGYrEPd3Od0qBMo3UW6X3NgiA4R2qRN0LmzU0BLAlpCVE0DKsYjEUkF/ATaMe0YGzY3R1OWNP7xHscifzYwIRNt6wV6Ws4cPIgf1Ok4KoTKutP2PyKhCsY0sHX1/yTTI7jnChR7Seuhl2Uz+w7+oA3kKt7uCGpbjsL2fjT5itVjkupdIT35xb1NojAnTWJrzZ8EzqarrEUA==
Received: from CYZPR17CA0024.namprd17.prod.outlook.com (2603:10b6:930:8c::8)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 04:08:05 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:8c:cafe::78) by CYZPR17CA0024.outlook.office365.com
 (2603:10b6:930:8c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:08:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:49 -0700
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
Subject: [PATCH v5 13/18] iommu/arm-smmu-v3: Add streams_lock for atomic-context SID->master lookup
Date: Thu, 2 Jul 2026 21:06:38 -0700
Message-ID: <3549540a84ca2fa0d6cb3e1ccad5ea787e55d1a2.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e89d6a6-01fd-4c38-7d86-08ded8b8aea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|18002099003|22082099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9IR7iYzDd2O/7UpcJwEJI3/JPijGB27t6xDvG6T4sMuc/cCkcjQ2Wj5h8SA4z9MjSw2hOrk2VO+u33XtHzb3qON/fbdWBkqSyoNA2As1GlofwXvWBoBNkt29Poqb3dPT6uWCYHe4bh2plnPo9JoBy3y/KZIExxXzqufLUv1bei0vCl1xyWlZDBZQQirFJo52I3GlV4MUib3p1fC8Zcd3Y5dAWvPWLGf2w+NXjdZQhBxa+Rsfg3yWrvadocx0GHa4hAtBV4P36SE3M8Md7/IdkYttzy0lXbSnlUpvnLpY/oSjSYwXwPUUbBfR14ViARwDrrGGG5lUHTkU0A1iFEdKBqt7ASI0IyZQ1zG/tYKEC+Ui+lI+yDlBjmTEnyqpHEDnq4TxSKUyQ5iHRZZN+NGDFbvO7YrsQNDnuGpIHX2CLeDAh5dEmYm5U9t5+t54QLFalY1HvRC36XjwnsQHrq+ddL6gzzVmqR/utGBPe097les0p8cCbBlf5R7YwY3uhU1RVkJn7CYDrTHS9KUdo9sCI+6B8KY4JoDxnzVA7N6ZnIjEwe9EZfPiNDmszWzaAdzf8DZeAZ91qxGZSwkhp6o3cg3pP1Xtx6CeBOvJyybsuHK8Ig/pdYH+o906OMX/jOXj91ZjgGYJd0FgV9jyhSxuBw3OPoKCXMTtoZ25rglY40IfzUaiOmRvwG5YOsUxVimB1V1wMmVtZp/P82P1Gzothg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	piDe8MRu/xbz6iFpJS/Tta4WtWi59GndFVFWpDbtdtu0ipW1L0UxhjBWOPmtoF/+Kvg9Zlvh2pAb8zF3sXhT9BdqTZ/6dEYKgcaRYzT7iyEKHcgHR4HF1uysDsEn3oi/sq2dzokG/Q7thPTx1KpaLAQDh/4etcZ0v4QtRn7hk/cynFLBSpsqz1S899uAbWuSJILlkjpe/QADMfBFxDLc+u4QokB+iRIvgfGL8Kzs9bNXsQsZs/kzHuCrBb9TxJv41BCPVDEIEtnfyVN+7MboFvAQJ+7ZvSY+THkNTD1q6IaVuXLKt4xOeD8rME/4Sfs6OCHpBpEIn0V02eyjs4NXXTauXjJmLzcbLFbi5HFdqJVE7h4fc29gl5XKoI7M7q0sUPsSKTLhxK99hpNDzQtRRA+mzee6dJCBes50qbiQPVDhUwi2lPLXsDgQKFnhbf72
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:08:04.7812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e89d6a6-01fd-4c38-7d86-08ded8b8aea5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027

A subsequent change will look up arm_smmu_master entries by SID from inside
arm_smmu_cmdq_batch_retry(), which runs with invs->rwlock read_lock held in
IRQ-disabled context, and so cannot take the sleeping streams_mutex.

Add a spinlock_t streams_lock that protects rb_root mutations alongside the
existing streams_mutex:
 - atomic-context readers will hold the spinlock alone
 - writers (insert/remove paths) take both

A reader under the streams_lock uses all the streams of the found master,
so the insertion has to be all-or-nothing: make arm_smmu_insert_master()
initialize all the L2 strtabs first and then insert all the stream nodes in
one critical section, making a master found via any single SID always fully
initialized.

Update the lockdep assertion in arm_smmu_find_master() to accept either of
the locks so the helper is callable from both contexts.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 95 ++++++++++++++-------
 2 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 86e934d046eaa..c34be7c59ad45 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -966,6 +966,8 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+	/* Held during rb_root updates; allows atomic-context lookups */
+	spinlock_t			streams_lock;
 };
 
 struct arm_smmu_stream {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6c099338a17ef..e2fa9d27c6586 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2061,7 +2061,8 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct rb_node *node;
 
-	lockdep_assert_held(&smmu->streams_mutex);
+	lockdep_assert(lockdep_is_held(&smmu->streams_mutex) ||
+		       lockdep_is_held(&smmu->streams_lock));
 
 	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
 	if (!node)
@@ -4121,6 +4122,51 @@ static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
 	return cmp_int(*l, *r);
 }
 
+/* Caller must hold the streams_mutex. Publishes all the nodes, or none */
+static int arm_smmu_insert_streams(struct arm_smmu_device *smmu,
+				   struct arm_smmu_master *master)
+{
+	struct arm_smmu_master *existing_master = NULL;
+	u32 existing_sid = 0;
+	unsigned long flags;
+	int ret = 0;
+	int i;
+
+	spin_lock_irqsave(&smmu->streams_lock, flags);
+	for (i = 0; i < master->num_streams; i++) {
+		struct rb_node *existing;
+
+		existing = rb_find_add(&master->streams[i].node,
+				       &smmu->streams,
+				       arm_smmu_streams_cmp_node);
+		if (!existing)
+			continue;
+
+		existing_master = rb_entry(existing, struct arm_smmu_stream,
+					   node)->master;
+
+		/* Bridged PCI devices may end up with duplicated IDs */
+		if (existing_master == master)
+			continue;
+
+		existing_sid = master->streams[i].id;
+		ret = -ENODEV;
+		break;
+	}
+	if (ret)
+		for (i--; i >= 0; i--)
+			if (!RB_EMPTY_NODE(&master->streams[i].node))
+				rb_erase(&master->streams[i].node,
+					 &smmu->streams);
+	spin_unlock_irqrestore(&smmu->streams_lock, flags);
+
+	if (ret)
+		dev_warn(master->dev,
+			 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
+			 existing_sid, dev_name(existing_master->dev));
+	return ret;
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
@@ -4167,40 +4213,22 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		RB_CLEAR_NODE(&master->streams[i].node);
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = &master->streams[i];
-		struct rb_node *existing;
-		u32 sid = new_stream->id;
 
-		ret = arm_smmu_init_sid_strtab(smmu, sid);
+	/*
+	 * Initialize the L2 strtabs before publishing any stream node, and
+	 * insert all the nodes in one critical section, so an atomic reader
+	 * never sees a partially initialized master.
+	 */
+	for (i = 0; i < fwspec->num_ids; i++) {
+		ret = arm_smmu_init_sid_strtab(smmu, master->streams[i].id);
 		if (ret)
 			break;
-
-		/* Insert into SID tree */
-		existing = rb_find_add(&new_stream->node, &smmu->streams,
-				       arm_smmu_streams_cmp_node);
-		if (existing) {
-			struct arm_smmu_master *existing_master =
-				rb_entry(existing, struct arm_smmu_stream, node)
-					->master;
-
-			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master)
-				continue;
-
-			dev_warn(master->dev,
-				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(existing_master->dev));
-			ret = -ENODEV;
-			break;
-		}
 	}
 
+	if (!ret)
+		ret = arm_smmu_insert_streams(smmu, master);
+
 	if (ret) {
-		for (i--; i >= 0; i--)
-			if (!RB_EMPTY_NODE(&master->streams[i].node))
-				rb_erase(&master->streams[i].node,
-					 &smmu->streams);
 		kfree(master->streams);
 		kfree(master->build_invs);
 	}
@@ -4219,9 +4247,11 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++)
-		if (!RB_EMPTY_NODE(&master->streams[i].node))
-			rb_erase(&master->streams[i].node, &smmu->streams);
+	scoped_guard(spinlock_irqsave, &smmu->streams_lock)
+		for (i = 0; i < fwspec->num_ids; i++)
+			if (!RB_EMPTY_NODE(&master->streams[i].node))
+				rb_erase(&master->streams[i].node,
+					 &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
@@ -4636,6 +4666,7 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 	int ret;
 
 	mutex_init(&smmu->streams_mutex);
+	spin_lock_init(&smmu->streams_lock);
 	smmu->streams = RB_ROOT;
 
 	ret = arm_smmu_init_queues(smmu);
-- 
2.43.0

