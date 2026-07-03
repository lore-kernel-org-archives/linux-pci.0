Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D032AAA0;
	Fri,  3 Jul 2026 04:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051714; cv=fail; b=r0qes8IK3r6ucP9wz9UrhB/OdfzGWBu3oBicHWYl7NZEnneiETlzNur165fU3awTnW/TZtK4TcMYCNh364PeLwptZmYxG2O2Vw6QjLlzR8Gf1h7QFglYmNrZXJksUp71BjToZYkv/XbiYQnwhKjc7rYhMJK6YE1PkZmFnJTVMsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051714; c=relaxed/simple;
	bh=2ZixHCV72AUsxWrWOHH6panRdQBZU6mMSfGQEoEGe3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0M+GmKR/bB1LgPxyzmJ037Dw2iZFnN3cT4cWMGJlIMblbCyT8sWWDPm6S+Cmkau4vZO1EWInb6cLMBHJifeeV2mlZ6W1yKAplvkHlonyg1jsLOxAXlPtkr9sq7bKgs+yU/iJkAyR+bIEYARP5gTIjllcxeUFgKSQI502EbeZT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZvGhCaos; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZvGhCaos"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsuFC/2TC1vDnz/E/H/c5jtfxs5dS2BYQaZeeGaH1q8SBb0M2QnVU/TFaOu/E8Zi6kXdspJLRwpV1Q+Gn68sWW3er8WQlEFwxgaWvn3p0z1afbhcr5m0A5hxdQjRw1p96A4e8d6sSCfVUQZ1uYy6ibTUN2ugvdZFPHoonF8cNrAAa1Bf1AIoywvirzQ6ifONnJy/k652qNmXr6Ai47wB1PIRTsoHpcgLTVVIVPJQQ7DVT5UQsSP1u8nm6+d0vadu5Jxpk9sh7+8xqPahhUEfaaG8beYtnrCLyVHCzqMj+/5ecfrTe6DtFjFFgUZJIDUcF5X2ypUhEJTemiNREvRzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYOrpsabiF+ESxJf8xOYKA4nb/WLEXPqguX49OngdSU=;
 b=Tjg7ehwIVZ9sDx+y4cvm0s0hERSqjSE1w1l7ByhRZLr5LN8Vo5gajBow6zsERJzCvJGi9BST+QEcDyGHMScf8PT/bKfszqvAfwXnuY1GDG5i6OQYHIxoU5ggyCFFmU/74KnJnzmaEIAE8WXKQPW2PYqULFRMQBx/ei4mJjJFtReLzz0JIT9OodbPgqGHQ90a9YPZ431Z4Z9CmCQ0C+USlWQHgWjyMbyWjbhpOAyIYGl3U4Hf4oMPLrYEe6YKL6ZtgdA6zvu169tEMhxtubjrQEfJj2tJiuUpRrj7bRQL7bCPPuv7+NfeWD/BPheHFcnsFbFjEHFChfMlqK95035g1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYOrpsabiF+ESxJf8xOYKA4nb/WLEXPqguX49OngdSU=;
 b=ZvGhCaos49txPZtIHy2/j+1zmLLLqZQlTk5O22aFnLcB7jfPqLUgIB2SJ/vlt+cR5ofyM/n19QySRylYZ61j5rhwp7N+M80sLve3MiBl4oVUIaPypX20zesN78Nz044LI8V+Dphvhp6pulvlevnxpoaAnLDpcsWGB7y4cZbyA2PLa4hiP+oLOMbjwQDwF7KEsuQrBtRJs1zBSEwYjb5V0EGq8KGRTmh6NVGfxn2SNh118TmOzjYY1Tsgn0/eLW8riDFirr5XuHngN9Q65leQhpHzHegZSlCtoqCO1BaQCv86bVzLGoJW2nTc3aOuqagoUGBI4gawaAQuB6ftLHQO7A==
Received: from CY8PR10CA0017.namprd10.prod.outlook.com (2603:10b6:930:4f::6)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 04:08:12 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::97) by CY8PR10CA0017.outlook.office365.com
 (2603:10b6:930:4f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:08:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:56 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:55 -0700
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
Subject: [PATCH v5 17/18] iommu/arm-smmu-v3: Thread arm_smmu_master_domain on a per-master list
Date: Thu, 2 Jul 2026 21:06:42 -0700
Message-ID: <125050356f56c476c772b6348b09c0bd95a3377b.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: d1161087-3d2e-4174-327f-08ded8b8b2f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|23010399003|376014|82310400026|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	PHwrELTlMaSksnte+X6FuBuV954TmTVNPyFINwhc2bl+BwjsM536oAlCh55Jrf7sLGfl3/8tAG0GdX/Oq3zA3JToNBmYFwZlR3AcVqs6rytTK3rRPvmpXcOs8jhJmxnKdp6VXW4MgBp3LGf6csjesY3htzYaSChCwN4tR5fD1omkfX6KZP1V4vMzVYCwejE/F+vbCRa9VpgUPlnf4d9u+rFFb93yTPLdR41BlvXICy2/nnHuGjqLj+GbznTLnmXTRboEtw26/XgNzRc7IODTE/1PLjnoRPYN07MmoMOkca0mbERZ76EUPFiLTBouQfljwjwLvCIIrvXglgcB1kQ7jGD4da90nCfrMlYfOP8wDNDMzWTGDk5SIemKar52J4kZUGLJ6pcXMwrrURD+iQ4iFVjFlJGhaOS+EXKE8loOTd1T/BxAcVnD2BNrs4I17yIxtCh9eOzDwAeC+YzrDI2ht8IugyGQ8fuJwg110cAQuCnfpVBczqdsCPW8Hy8jP8ah1VvvP+H86Wc5e+vUGTwCi3J1v66TSmlL8Ub6apkGp/E073ZlCBoquJTQg6pHoxERT4Fs3kwKpS/Q5m1wGZcJa9bXqxEroEWAFZ/FETk1lIXR/exyR/2SeoUycBp6o3N8D9xoQI+A5iL8RfVFfq6Szo+yFU5v7krjuhyeBgL+dr5Olhc0IIopiuv83duPeqXVGH2wBHlxUOz6icGrU2JW4g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(23010399003)(376014)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yY2trB2CC7JdG0oRxTDGHG8Futblo6LJcX+FSqICyU1JONGNXciEJVq087bwfwQgLXkWnFeAo2K5qMiG4wNnLAifhixJj5mjT2Kq5IKt72GS39BvWIDhSNLBwxKGzPGR0lE21JEOSD14otAHs19XU5g3dnv0Q+LOZjJkWF2XCfEX9DvlxebNbB/QQtJHMWqTJ+rtsr+sY73YNVYOOb2hrN5oVBrEPXOWRX+axV/WXLQOpK35oGQhmac7+frTuybKv7EN5rDGHsxhBFiCVRgW0LELmu2z0Y3imoG4EgEHh5MI+w0yfSPXUv0Ssj4WlC+1XRmBEg9LNwfYUe3rV7YCVi2tU5DrtAEwtMTy8sp7cMzljFaMN0r3jmQ7eK9kZcxFxBn4OgGKMTcu2ZE9hjBdHplMe+XwdaNdNFQy/pQ0cMP0wZq9Uw/ZPXzmBP5kN8Vj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:08:12.0250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1161087-3d2e-4174-327f-08ded8b8b2f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193

A subsequent change needs to enumerate, from the CMDQ error path in atomic
context, every domain a master is attached to so it can mark this master's
ATS entries broken in each domain's invs after an ATC invalidation timeout.
The existing per-domain smmu_domain->devices list tracks the inverse
direction (masters in a given domain), so introduce a per-master list.

Add a second list_head master_elm to arm_smmu_master_domain, threaded onto
a new master->master_domains list under master_domains_lock. The CMDQ error
path walks the list while holding smmu->streams_lock; that path runs under
the invs->rwlock read side, which is itself sleepable on PREEMPT_RT, so a
plain spinlock_t suffices for both. The attach and detach sites now take it
with spin_lock(), nested inside the existing devices_lock critical section
that already disables IRQs; it is a leaf in the lock order, so no inversion
is introduced.

No functional change.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 4 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8eb5684696316..4aa0c5fedff71 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1029,6 +1029,9 @@ struct arm_smmu_master {
 	struct arm_smmu_vmaster		*vmaster; /* use smmu->streams_mutex */
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
+	struct list_head		master_domains;
+	/* Protects master_domains */
+	spinlock_t			master_domains_lock;
 	unsigned int			num_streams;
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
@@ -1123,6 +1126,7 @@ struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs);
 
 struct arm_smmu_master_domain {
 	struct list_head devices_elm;
+	struct list_head master_elm;
 	struct arm_smmu_master *master;
 	/*
 	 * For nested domains the master_domain is threaded onto the S2 parent,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0697bbc558d0e..fd9a095154c72 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3372,6 +3372,9 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 						    ssid, nested_ats_flush);
 	if (master_domain) {
 		list_del(&master_domain->devices_elm);
+		spin_lock(&master->master_domains_lock);
+		list_del(&master_domain->master_elm);
+		spin_unlock(&master->master_domains_lock);
 		if (master->ats_enabled)
 			atomic_dec(&smmu_domain->nr_ats_masters);
 	}
@@ -3622,6 +3625,9 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		if (state->ats_enabled)
 			atomic_inc(&smmu_domain->nr_ats_masters);
 		list_add(&master_domain->devices_elm, &smmu_domain->devices);
+		spin_lock(&master->master_domains_lock);
+		list_add(&master_domain->master_elm, &master->master_domains);
+		spin_unlock(&master->master_domains_lock);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 		arm_smmu_install_new_domain_invs(state);
@@ -4346,6 +4352,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	master->dev = dev;
 	master->smmu = smmu;
 	dev_iommu_priv_set(dev, master);
+	INIT_LIST_HEAD(&master->master_domains);
+	spin_lock_init(&master->master_domains_lock);
 
 	ret = arm_smmu_insert_master(smmu, master);
 	if (ret)
-- 
2.43.0

