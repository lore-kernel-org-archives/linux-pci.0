Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D636197C;
	Tue,  1 Sep 2026 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222868; cv=fail; b=RoaQIAWQktdpG/FQqfCtq2/HsbogNSjE7hALf872ym+rHVtBbyjDyMgkn2IohsbYDZM38chvhIlUQs31UxbNwkcFk19cEYWzVSk9vYrxsdR+AjJmj4tFv2D5DWsXfXmjoUgSDZjkTSFw0oe8r0Zz73ZUeoMv8iVLKJ9d3yrqb9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222868; c=relaxed/simple;
	bh=sTiU8pvLi/Ky5PjV8hsOF1EOYOWqadnhoH1XIyqAq50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+CH3gqv/9UHxVa5ZDD7Nj/nY7LNGLOMK4YX1p15qzWVTxB6UFP985LP4eLvnBMl/OaSW1LXhfkX2fjLXotx5gizym5prssj/DQfLdGzNeVL1rJLi590teRn8zk4Ht8cmKnrYXOjNsJlpf2KCSFEZSTeVH7tb05EGirHm8AZwmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W5VSeBuM; arc=fail smtp.client-ip=52.101.53.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W5VSeBuM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5oZfZdalVScPROlyfO8RwBLRfl8YZErOeMItGtXKVFB2TYtz69iC44mYE3Ovw1xiuMzyEplkLyF93qoFdQO7hnyZvXU8E8uBzTOtzyjcJxnkbN1xNZ6n4IUKi5msxzhhsd6trtNNCqd/tc03jPCx+8a6RlJAT/KYjaJE2dlu7Vz1lYAmlMe+UXCAffsbObejGtCwkImUa0L8KbNFclGa+DZbU+jD2So9nq7RRsJbu3NORpMJPVwp6oOVJTcWg68XkO+vAbTdAyFx0hrvtLJ8nuu3vMYiHlGld+pB4rSvcRBOk7v9EuKXBUCKAAXIxNL+z46BY11Te2lZbZWkNLQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXlEqslKZvwiikH9vgVp+f638h9Qp4h657+zWuY6rNY=;
 b=FFxGf5v10GUJmECNHyVfmDMe40wX8KEoj2JrZap4dNdOuP5njxlvir9ofWNWpRFMwqJg+PUiXvXq1E47FwT2iVdmv61Xeqc2/0j/9K52SSMNULxy1iiGXAWOoJj8Kpih2YQukwkdHj0n2qITxA/buWrZrk/gw6Fmfx9noyYYRgPAXV3co7sY5Lwn7vCFVfFum4E/y0p1gy1fz8pFJ1DAbiGX64ioU4iL6WXJz5/RyO99r2qtA7OBtzUsAAce5E5G4xOJu9Mb/CU7do3+lS6HxOArfDVguHMckWkiSoq4vvO1mNwFNRTA0Z/yM17pV03vaZy45arkbQk+JkJ7MuJWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXlEqslKZvwiikH9vgVp+f638h9Qp4h657+zWuY6rNY=;
 b=W5VSeBuMHuRaQlyYBHCA3QDs027lpc28IQJc1zKUtq7txfthq5Sa0zTyD3kB4CUCDH3utOTGgQ0NZz6sS+t6UKBCOzzlY5D01sSSXv1k6za2BXejDtl2CymeW+04ka39ZGEu4ZwFwTMrIJT+mwEyodt8i+TOMXZN7CJpzsQ2wxCNw1hV+LjEfyLUoDQxO1tXexAjCnhBuo9x0V4FksxHK9p5EbHwJjEmExRsRIJyN0iWULe0KGC8JD7UfyCb8ribe1gxb9rSCTYNp9W212R1i0x5nhuMmyDEgGFToUgOG0AozTYJqdPQMsC5g03WARJCRDoNV3T+diBKzUZE5CzPbw==
Received: from DM6PR04CA0008.namprd04.prod.outlook.com (2603:10b6:5:334::13)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:34:18 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::65) by DM6PR04CA0008.outlook.office365.com
 (2603:10b6:5:334::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 00:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 00:34:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:03 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 17:34:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v3 01/13] iommu/arm-smmu-v3: Add arm_smmu_attach_release()
Date: Mon, 31 Aug 2026 17:33:26 -0700
Message-ID: <7dcf4aaa538a6a14626f5e2854141f14268250fa.1788222485.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 70bfef04-d3bb-41f6-0fa9-08df07c0c249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|7416014|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	HHKUUZWJluVTrHxGFPkt8ZeEgqHEoEP268hWvCt+V19E5vrA2OLYTMRX7EK7dLuCZQm4XLSdGToH8QFiPW9FJsZgImzjIX8o4Zl43kpLod5DMMVbiCuAfuWqM94lsSatrbK7q+NUAzSgn0FUhEEUAu1cUE7HYwjSTpWT3q3MrQ7BppUIYkZMv5B8tLsz/DLSOh3LG11UnnTPVULhrAQnhZFbqZml6K7E5thjIJDfTjXj+N2weKVHfvoAnT3aL5ghwG8dwxAq9J28tgI6g18KSDWZuQqpeDjyl9g/4GjmmyFIeY25kVXPFtqSHpNi9koSOFayfUl0CkQFQA6ChXwomwHA/huu6Joc6zjQbMANIs6PDcxkAFby46VHzx/2lr//K7qo3DNgzzpd3KdkEyOvjGzYI3uR6MOtB9dAyb+wt9gOpvu9UZFDuIErwsKLjrQmKpqWIclvHO/6JzEy/U/wtzBusak+dzhSEx4r1rI4iAr+01otbKvpkO+ewjYjGHPKoMcuYgYeiBsLlcuqeglFFwZkoHk9iXwCF8nnShT4BZEIBNe6b+nqVnkZqEWDhHonxfBlCQYOXNXXu4WtxXvjwvpOn1vBnN5gNgaRYRyomW/e0Eb+pT2nJ+4Hdzx8Kitx7gT7f+eAo2hkLeGk0f2jt+XXQ4HSiEAn6lsC3UVWBgou4G1PzyOsYyOZE8HPQuUXX/O153K9dU5sv+g4pvs7TA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+OQRhq7WB37kzEi2hvYT2DDxAC+y7+ZmzJCpwZ8mMzklOSDHXHmvhr8DNX/8AvgMeKGdWUzckYn0hsitQB1dojWwU//DqIL3iYkIvVzZqqHKAFLvdMJS84oE6KD61EUwRlDcJg5WJYiDwH5+0gEInxfIyUZGoGnj0Xrkx9prrleLkurxwXj1VqbX1Vd/M0zYjJ+L7qDcTrb7LvOrmuyl5qSfdo+5Jqhl3cPvFQuqG4Imp2xCNKhsblJTXZoUInJm1DcEjStZps73gKovKi7v4nwFhGAUETeidm6pJfQ5yRVb5B7ZoaLPgTj/HpiXRshAvUrPT0FJDYSeM8TodEDr2+2eTELAi29209g7Xn7j8KWSGFnCyyEUOzNxk2aJwXSMMdFTIi8IQ1bMHDHxVhK1RWiAYtCkTQQ7hPeRvGjmGdL7LR9WwTsvk9+eGDOwieTH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:34:18.2771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bfef04-d3bb-41f6-0fa9-08df07c0c249
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852

The IOPF teardown is done in arm_smmu_remove_master_domain() when releasing
the master_domain on detach, under the global arm_smmu_asid_lock mutex. But
the teardown must drain any in-flight IOPF (for the old domain), before the
master_domain is freed via iopf_queue_flush_dev() calling flush_workqueue()
that can block on user-faulting page-fault handlers. Doing so while holding
the arm_smmu_asid_lock would stall any unrelated attachment in the system.

Split the teardown out of arm_smmu_remove_master_domain(), to a new helper
arm_smmu_attach_release() that runs after arm_smmu_asid_lock is released.

Since no other device would use the old master_domain that is being freed,
it's safe to move out of arm_smmu_asid_lock (still under the protection of
iommu_group->mutex).

Note: this is a pure refactor; no functional change.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 33 +++++++++++++++----
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 50f8321e979ce..5b89bad71c102 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1204,12 +1204,14 @@ struct arm_smmu_attach_state {
 	struct arm_smmu_vmaster *vmaster;
 	struct arm_smmu_inv_state old_domain_invst;
 	struct arm_smmu_inv_state new_domain_invst;
+	struct arm_smmu_master_domain *old_master_domain;
 	bool ats_enabled;
 };
 
 int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			    struct iommu_domain *new_domain);
 void arm_smmu_attach_commit(struct arm_smmu_attach_state *state);
+void arm_smmu_attach_release(struct arm_smmu_attach_state *state);
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 25982bdbcbd9a..fce026efa44f1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -194,6 +194,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 	arm_smmu_install_ste_for_dev(master, &ste);
 	arm_smmu_attach_commit(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
+	arm_smmu_attach_release(&state);
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d..99baa59b39c9d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3285,9 +3285,9 @@ arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
 	return master->build_invs;
 }
 
-static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
-					  struct iommu_domain *domain,
-					  ioasid_t ssid)
+static struct arm_smmu_master_domain *
+arm_smmu_remove_master_domain(struct arm_smmu_master *master,
+			      struct iommu_domain *domain, ioasid_t ssid)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain_devices(domain);
 	struct arm_smmu_master_domain *master_domain;
@@ -3295,7 +3295,7 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 	unsigned long flags;
 
 	if (!smmu_domain)
-		return;
+		return NULL;
 
 	if (domain->type == IOMMU_DOMAIN_NESTED)
 		nested_ats_flush = to_smmu_nested_domain(domain)->enable_ats;
@@ -3310,8 +3310,23 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
+	/* arm_smmu_attach_release() will free it */
+	return master_domain;
+}
+
+/* Release the old master_domain detached by arm_smmu_remove_master_domain() */
+void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
+{
+	struct arm_smmu_master_domain *master_domain = state->old_master_domain;
+	struct arm_smmu_master *master = state->master;
+
+	iommu_group_mutex_assert(master->dev);
+
+	if (!master_domain)
+		return;
 	arm_smmu_disable_iopf(master, master_domain);
 	kfree(master_domain);
+	state->old_master_domain = NULL;
 }
 
 /*
@@ -3609,7 +3624,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 		arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
 	}
 
-	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	state->old_master_domain = arm_smmu_remove_master_domain(
+		master, state->old_domain, state->ssid);
 	arm_smmu_install_old_domain_invs(state);
 	master->ats_enabled = state->ats_enabled;
 }
@@ -3684,6 +3700,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 
 	arm_smmu_attach_commit(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
+	arm_smmu_attach_release(&state);
 	return 0;
 }
 
@@ -3784,6 +3801,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 
 out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
+	arm_smmu_attach_release(&state);
 	return ret;
 }
 
@@ -3804,9 +3822,11 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 	arm_smmu_clear_cd(master, pasid);
 	if (master->ats_enabled)
 		arm_smmu_atc_inv_master(master, pasid);
-	arm_smmu_remove_master_domain(master, &smmu_domain->domain, pasid);
+	state.old_master_domain = arm_smmu_remove_master_domain(
+		master, &smmu_domain->domain, pasid);
 	arm_smmu_install_old_domain_invs(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
+	arm_smmu_attach_release(&state);
 
 	/*
 	 * When the last user of the CD table goes away downgrade the STE back
@@ -3869,6 +3889,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	arm_smmu_install_ste_for_dev(master, ste);
 	arm_smmu_attach_commit(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
+	arm_smmu_attach_release(&state);
 
 	/*
 	 * This has to be done after removing the master from the
-- 
2.43.0

