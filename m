Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F458123B;
	Wed, 23 Sep 2026 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194391; cv=fail; b=jw+qfrxwKJjLOgBwnVK0ibTDj431kpSJ5qaQ1tSoTSEI+q2Xk/QthAR0n2j8keqfkzGRUMPJb9lhPpGPkcP7w40ItCH0YbRNYRXwRI69uL5+Mab5reN/9QT9d78ufLjShFtrQkOr4Sjh+x+6BZkwU+QV/E9PSEfbfa6l1V5lmhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194391; c=relaxed/simple;
	bh=dvtJnr0TJKdpR+Ze3S3iHM3NUGV4fDImPvJDLnURoOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1TnqCcLyS3pOyfGimopn72kL9zP/PTh0jqClVqnX7+ScYVpA8dS80yJocfDQzEF2HrdB0en8nl7KOykHnsjbu04hN15q4V0rPFFDbi0cUB8GAK1TitYd60kxUa2DJNl5sl+r5NGIQVScR7Br1BORlk3imhRj0oDH5k0VyxDE60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X0n3OUQD; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X0n3OUQD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEafNyIYFR1Y1a+zffggn5olA8DDx5iejZaMvQeD+qGAaMXlvUEtk48XnahVZmEC7M7m29bxIQ7SaJTRRoA1g74n4dqRDhN2KvImRsnDitYg98x+0Dd+8DoBiGjUYTv2USPsIXsIKNmz3GIKMDwq7LZmcBuRjqp3FqO63MkqE3XqkTpCfnXRoB1j1GP8uM2DCt2INunc7pR0JAyopwKv0xqdkmaLCLL67ybPWVLHzTJv/aYZUVkck1/uyiDhuPWfYuZ4aCHFaD5vKRSAOiajjmrEDQNN2KvAhIxCrbR6uBsJxrlATfA6dIZu0mAppilzEDBzMT2B5tSW3Zu2FxLSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw5y6QSLpJ3OAucUpF1Oy8LdUdv5TzJMJ6nIpXoAbqc=;
 b=B9bVDPDpk9tuQ9fv1GDZypfYvZ8RJipl0dqdzbqxsTeL75wiUKhvAlVGSc+DlIbNy9ZmXpZcgfZlyZGG1e4rPvQHZWTkXk9/8ltbqpiXkIGmEO6mUHt+9Mc3jSfjCkhAKj7BgE3wJV6N7NmNB90Lutr9KfqcoiehGsDMzII9RA6sw2D67f2jmuyMnMOmH/63CC705CQy1LY201m1v6/pdxzUF0chrGt+B1fCiCk6cPd9USSUQ9Ag5hLB7Kk6SXXzXFNW2dAZc3Sdgo6AqTcUckok/e2jFWta2hKFcTJFyf/VpDinFduyjC0h8m5EfzW4WFcQNaEjckT3VDc/AkVwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw5y6QSLpJ3OAucUpF1Oy8LdUdv5TzJMJ6nIpXoAbqc=;
 b=X0n3OUQDNVtF7Yecx1qyAfpDNqSaOJffZysA+xfXMYLr4PUUASmJx8dNXklnc4JwImU7cpmKxEnjjhUMkNfThx8KscVf6HrbhBNAgKr6i6dLNO7oHv9SGqvYzOroQMmui6/ah3OAIig3DZMyKOH3iUFyoh8mGpoLF5nYVjqnd23cunxCUkDjRqx/8c20T2VgRb/ztpb7K0mDE2N2Xti/d5Nxh588D/ItBe239QuwVhXsDsS5LRGi9hK2kPThqL866wPvo+IoS6KcK7fk8EVM7rFqy0Rest1haTl1XZjhrq2RN1AvOzKK2wYEfyO0t1VYG4QKOR1zRj5oy8t/kwGCUw==
Received: from LV3P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::10)
 by IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 20:12:36 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::3c) by LV3P220CA0030.outlook.office365.com
 (2603:10b6:408:234::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 20:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:12:11 -0700
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
Subject: [PATCH v6 16/17] iommu/arm-smmu-v3: Thread arm_smmu_master_domain on a per-master list
Date: Wed, 23 Sep 2026 13:11:35 -0700
Message-ID: <c8b198a773d7de1bfd6202a9fa724e4786b5bf1b.1790188511.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 58163b5f-d705-4042-3a56-08df19af018c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7yMzhhZPmYpIqvKUUSPFWKwU+Zg7FTNiwgdGp+pzVS/PSVFRvoTS6vglHsT6MERK2DBVNrFGYn2AeFWiydhAtEdp5nXFXy17OWlBfOi0vcwLHihzR/74ICuyUYWt5IArLuJ7hiradrCnXEsPTMAMzj/XsvxlplFWcDZZtHfXbGIulHsYNhblufxhpCOMNauOW8vbezcE901UnY49QG1uRKHYOyxng4QSkgmlZsOkyMtnZUb2sGlPuavDjV+j3+fdrfRDsCKyRyz++5/iv5DwJ6HJtQSy5B6s5LXhFlXW9I670caad7hhbPURlpGOl76P7TVrfe6BzIc5jroWE18L5Nqc/7Ux2VgTBnXOQw4AovZgroJrJ+1FuuUunNjGzLn6nzXK3M7BPtNmp01D4Jmgqr7T5VarQqYJCjKoAx9PSHyj7KlDgPxhawT+6mQ/SqjIUzbMzdvw84iubYIPIgoXjtmharnwKB/L4KqT2AyUuYuaJC5meGNcg83GqRy2ueuNLdvldt1iA/C4KIneqKaOrEWqHkGX7Yxy7WmgRKnaYYlK2gYZTBKTSLm9Q/NmOHGQsN4Qa+m5ZMIRnNX8fAckTwL+qzh/n8pGz3r4p35lD4ORowAG2L2Lka2iHX4qgVeoDzxETYRaDk87CmKUzas8JpQ5cdKIUiuMzB8LMD/nmp2/XpXSlAceosNkfNwHIaXYlcPYXIG49nr8pEB+Rm6/Og==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TGemA9OG7TzGsVJXp5c/+P7jmBk8VQZLImWY4MBp4P+A2CVoUgFETKlmKft3xXGuyC6HfWVLsyPBPFN9B6t1/Eb10J8FLmBp+CeZ+ktgch9PwDOLeZygm81LLsvdkqj7f6XhrPcZWRQbjNjMS/dMjN1eoceJBDjMvBL890EGZ/rOyWykAs6jo5XbUEhOINHZmcJwo2qLpiPJLkeYPEVuXIni7QC5h6QD77mi5OBhqVu8F2ZXPehBgVKj465JMTTGtBhmq6v4he8k0Cv9Hu79eembRWj66CjiWHiIFHTA4Z8BVgzXfqsHUrDKB0pfpaYFmU0p3/ahY8WBFnsN+lGxSieGUQoIWkvWsQy5kNA2iGgG2+3Gm2+oLBliBI7lLVypfTUUZHlTBMD1lZCPhhgtUpbfHlC+t03v8AP16rWZJeCIYlHLm9Wmhgk/p3HIu5vO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:34.3975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58163b5f-d705-4042-3a56-08df19af018c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495

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

Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 4 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1394a14241fd3..1fa207c44763e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1035,6 +1035,9 @@ struct arm_smmu_master {
 	struct arm_smmu_vmaster		*vmaster; /* use smmu->streams_mutex */
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
+	struct list_head		master_domains;
+	/* Protects master_domains */
+	spinlock_t			master_domains_lock;
 	unsigned int			num_streams;
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
@@ -1129,6 +1132,7 @@ struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs);
 
 struct arm_smmu_master_domain {
 	struct list_head devices_elm;
+	struct list_head master_elm;
 	struct arm_smmu_master *master;
 	/*
 	 * For nested domains the master_domain is threaded onto the S2 parent,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 359cbee20ce5a..c56fd5c6b6242 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3431,6 +3431,9 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 						    ssid, nested_ats_flush);
 	if (master_domain) {
 		list_del(&master_domain->devices_elm);
+		spin_lock(&master->master_domains_lock);
+		list_del(&master_domain->master_elm);
+		spin_unlock(&master->master_domains_lock);
 		if (master->ats_enabled)
 			atomic_dec(&smmu_domain->nr_ats_masters);
 	}
@@ -3681,6 +3684,9 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		if (state->ats_enabled)
 			atomic_inc(&smmu_domain->nr_ats_masters);
 		list_add(&master_domain->devices_elm, &smmu_domain->devices);
+		spin_lock(&master->master_domains_lock);
+		list_add(&master_domain->master_elm, &master->master_domains);
+		spin_unlock(&master->master_domains_lock);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 		arm_smmu_install_new_domain_invs(state);
@@ -4405,6 +4411,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	master->dev = dev;
 	master->smmu = smmu;
 	dev_iommu_priv_set(dev, master);
+	INIT_LIST_HEAD(&master->master_domains);
+	spin_lock_init(&master->master_domains_lock);
 
 	ret = arm_smmu_insert_master(smmu, master);
 	if (ret)
-- 
2.43.0

