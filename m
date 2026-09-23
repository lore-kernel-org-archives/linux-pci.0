Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC4580395;
	Wed, 23 Sep 2026 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194370; cv=fail; b=Ukk8R+r0O4IyuscJBhi4lWd6Ymra4k7bwr4pxGwmAY8xneWseQgxVf3tmT5nRfAm6hpwH6RiZVHzam11Gd8AQTScFoBVtb+PJo6gb4dnz3PV2N5Ach+V2DNl6sz4Utwpnk8iRNCtLazF9yrY3lbnNfGPwzX9JaKmobMmY4zihlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194370; c=relaxed/simple;
	bh=AFawiuaPZUHS7Dep+0gx/Ui5iTnvWQP86H1Yr8NfzX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSh5a41mYB61RnvVdbNcKmOhpMOM4omGsAeLCIhwZhXNaWlEZiuBUgyzD72EEFiiGLn7sUc7zMWgdqQo6VmRHJmW98aW/ZT1j2rXYkJV/sxCNUbgNh65tEELRy388uFKOUS+E63J9ZGn3WPI8zSd665mfiE1SVfGs4omjPSEVOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=diFbOG3U; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="diFbOG3U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z67/2wg08gw0ijGI2W9NvYdXiT+jzHpjn/WNSiMvXJM0UT7dKPGF/ozw4Yqq7DBp+JFfK76qnvhv71sXob1SQQJaqsZirI5tim1bTlzOQyC42zdRRgf1SSafBYi5RsSoYpa1cZXnanCsYJiu7mZN5qvNTA3TvbiXOq1UrmaF3fU71PgDO2e4audyPwwG3jInjtVQcxHXietSiL1rsp+suJKMloX+zBxCbJi+UdSYGr+09M1l3EA/z+15Vc6T5/imvz29iwHTqVblt1eV+L4XXRwqQpPehW3y4tgQrWr81apqDEqpt/jT7SiGRGL9dIG6tRGegjSllZhDIYCNPPCHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg1IPqFl+HcrKHwCmKXAA5uKa3Uj6IIYSNlsYs8QmDc=;
 b=wfUxTR/r4m6rUp768ct2MnHxapBZwaPB9xwmUrqydiz+hjEv598sCL8hXlT7K13xgaQ4rdwtxM6z7VvIDEo/5sQ5P/YoKnJZtLWMUa7LgTXmZQ22SlU7W2uKUvGql0NCoqsLtv9IOvCdtA2lj5fo5aiAfe6bjeSsrRMo5BSX1cktHiHhK1VKVUDRXj8vggKCPJLfDGz/T+Mu0R9G4WbuE/TApEXzvjzgSx7EACS079AtQE04nxGmESWIJp7ys4rOm85cFvjrm32zIXQP7hP+Zs9qWLvlEd1CV+qVN+I44tnWhf5W6A9p488Miip7eQjFBBeIPlwzxsBErrRahPPHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg1IPqFl+HcrKHwCmKXAA5uKa3Uj6IIYSNlsYs8QmDc=;
 b=diFbOG3UEO7IoLzWrY4JhL5gdbr9aaY4aUZ2h0j9DiUFUfwl0td3jM/L5gyznXTTdvralF4zS4zIcCa4c/y/n3FDunlATvBO5ESbRQ9iJzwFAM854lRqQIvd2YD5k0H16wBWKE+IPN0mbHr/P/Mofsl73W/wq5nynb7qAtnWn+g7DgORR4jWAln55V/iUFccRx/FGQvPzhaF0Ff0uWqOBdwPFMx11f7rQIa13HWXLDfdx7HlmK9seJxUbRDRYrUUUbr2j1Y/6vizPgScEdpuESnFmJWRPoujI9ivOFrr9pNRCBzmycpouOrWU+drOfKiB86nlJTgUT2+14uxjU+j+w==
Received: from BL1PR13CA0359.namprd13.prod.outlook.com (2603:10b6:208:2c6::34)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Wed, 23 Sep
 2026 20:12:32 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::aa) by BL1PR13CA0359.outlook.office365.com
 (2603:10b6:208:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7 via Frontend Transport; Wed, 23
 Sep 2026 20:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:12:07 -0700
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
Subject: [PATCH v6 13/17] iommu/arm-smmu-v3: Add streams_lock for atomic-context SID->master lookup
Date: Wed, 23 Sep 2026 13:11:32 -0700
Message-ID: <5ddbd81323f86d045072ebf410a6f87da4f2796f.1790188511.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbf4151-6fc0-498a-de33-08df19af0043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	mJeB07DAE7B3C3IvZvwVkQlt0Qqww8FP7pf9+ARmlQ+5rx3ayWMaPyQOTfZzRLeLnW6FndPqOHUgckLnLSSbeKL4XRe+4oDiyTFHrZcT8rGy2wN9YAR6Y8wVn5TJ1BhWY/Ov1+6X647DRc7k7zOAczquwlJYnIq9pFZ0m+k4eodKgqZhk5vauE25wd59y1WBuxjR5WdFApO9IyNQMGA7hH7CHJGAadJsNv0OVfoRQ9xv87qkX83++7fn1qb+aTP6pjnC7WYvSg9I5srf6s1Lb57QlfmGQTCyF0luG2dbN2Uw0O3jozOTkg2JQ1zvevkQL02/uZsFFjLxo7IQ0Hj0RaeFBynHNn2hB8Hm1RuvF5Sgo2D9aJwW0Mk5yyV9rUmLwi+YV4N8WojxvqO9gu3/UqbVYhVU3HsGjXf5g7/yP0n9CmVEMJ4oVZjgvvhH11rMbsWHrCf7IEiZ7ctRXSsFYqwHDqDtBZOF7h7JRLMvmOy8cB6SUGrKQRk2MPSzHp/lmuN+ET61Y0W4k+bA9bJ6t9b57119uhYSpOJExH3bgzmjbPhBxLXaIRdFtI8uAb1040WizAT1WzykrVmABgGfwgBlULmXf4TUucn9KHeihd4WQcI+Ht3rC6sCYkIh+tGRtO8AV2RREUuYR+53sMIpMmRa6KG8C03EBIh5/4X7qX4SamelGYOg15+sTYNMYwqRKviyQF+wzFS5SalUhpxxXw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PDXwG+DkZGZ2MhQThuX4MqmdBLLjhAHPITdjDVq/UPfxcyA0mpnr+wdCdeijW8sMJjdcPFJcZJKFmexdAU8zlF95HpD339ClK1NQDgwI/g48/2yW1P5gOzGQb88LspTxve84u8ldvzb6mPZdJhsxW3452rkp5w1U5gWkU+bNPbKmxzQbj5d1HZ8AItez2BiCP+0GsaW10V57HMf03k2JEXhKILXD8qo0vOOdvEDls13jDOjoyQvrlyhHEvkl3yp2Dqetlc1gYyNToG/NFEq44CgjdhTZHxVmQ4dt1uqBcga/ph/huwxBXiRniZ/waLm2t88ec4lc/x1Uw66uJKLQDw7asLaDYkf0JdiQkTJe8Xkf5XbJFIM/uW+Fphx/XClzhQJjjdfd2mBW8KWAoNQXb6KAr+jgwclAjVuzd4ztr5BsBKMiPMI1eua5ZzxEqwrK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:32.2550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbf4151-6fc0-498a-de33-08df19af0043
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986

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
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 95 ++++++++++++++-------
 2 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ca8f52142b07f..2f8d22cc404ac 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -972,6 +972,8 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+	/* Held during rb_root updates; allows atomic-context lookups */
+	spinlock_t			streams_lock;
 };
 
 struct arm_smmu_stream {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c3c31d4010a0a..6f217e916ab0c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2126,7 +2126,8 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct rb_node *node;
 
-	lockdep_assert_held(&smmu->streams_mutex);
+	lockdep_assert(lockdep_is_held(&smmu->streams_mutex) ||
+		       lockdep_is_held(&smmu->streams_lock));
 
 	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
 	if (!node)
@@ -4191,6 +4192,51 @@ static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
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
@@ -4237,40 +4283,22 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
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
@@ -4289,9 +4317,11 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
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
@@ -4726,6 +4756,7 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 	int ret;
 
 	mutex_init(&smmu->streams_mutex);
+	spin_lock_init(&smmu->streams_lock);
 	smmu->streams = RB_ROOT;
 
 	ret = arm_smmu_init_queues(smmu);
-- 
2.43.0

