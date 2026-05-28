Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79523655C3;
	Thu, 28 May 2026 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955226; cv=fail; b=e88Bj0n2N7mwRkllDfKftJV897nPapxKmcDBsSKL4XTDpfps4vVeBKmQQEFAfDi1ysQOdEe5BaFGbZ1J8GT3zuK0TggaiQ0oEPVfVmFEBaV2vSlYhvcr3GxD09m565sw3rzyRpeVtGy/aAglrrwcU1uK5IKcvuEiLYcHd4qU+dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955226; c=relaxed/simple;
	bh=xSvJ4yc2VkJJMPENA9tcDPkowpoRKHiP3tRj9AUXqag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwe+4tToS3K1nazVZrKC/bmKVCRbS9jDNlRaj5r59WXc4NcrZz3Ic6a/GjFC8zd2nFnn+ym28fiYUwju7bLG6ogkvENvziIu99sT3CAXgLiHAXkMFeefxrz/bvWbzC0nzwlESmlHsBwNtrPm3Md/ToR6SabS57FhjjsTZYcn79A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hfJ9mF5e; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hfJ9mF5e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8P4BNdCdC6TaeQaG35+AxXhwip1Aqp4bN0kXGR8m354eDAMBpKe9tOCjF94FAg5+zKXTIAG6Nrh8MXgaEIGCj5j63ZOAP3RB1+rqSt/dZLJCB8kidYm3cZgLYyvZebXgyU3FXz396lgXLLrpwR+jlHjKKIYi1mwcyEObLRjW8DazdWFIAO3W9QUWY51SadcsfrM1nn6afwxk5uWHPJmspIaWcX76Jzu9QwLz7SIOFAMwVa6Pn8D8PkYBSvU2RtAGN5pCb1dMzCLESIT6WMAOZ3lfh8UWCGYEcCEcDIzKb7juz7/FIDXt8VYWYyqK10+0ufoCuKkKaub7VI0q1L6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziW/hIHuo6+Z3Y9Z68vP1BSAha3IR5CSrxty7qoM9V8=;
 b=JXJ3uyh8hetcT7Hq0O0XpZSpfu7fYlaYZyYLsGaLyQ2zWDOC+Ogo3rtZmsWpReJopfI3o905U4NCoUTaiBtktJgps7FViNm2B1CFptTIEcSju/mDZtTBC+Ytyd62IQCPDeDoP3Z4Bb7rVYDtOL25k1xgr2IAP+BFUVPnRv0R48vlTXSvwlPpjU8coNza+bQFCUo8PjcdPT66SkdKiMQNA8TaFEMMb8o1uyqI5wRITfjb9DLjsIkqo3v77gBxrKGtKKsTZABMUBah8xU5n8X8t3KTKCEgfqeCNZM1bw8OmJodliw6zzTr9LQD924xDg5818MdoXt0oIRl1bEgH4ER8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziW/hIHuo6+Z3Y9Z68vP1BSAha3IR5CSrxty7qoM9V8=;
 b=hfJ9mF5e50F9Pz7nKASFFh3FwVhHgBvSzJnbmcofQO6Vc2JjkBW/3lo7f79+ih8kyk5UKRKNVbIGtzPV0Ara/2k7lKSAiMu2sXdihWj6k35/tjfl4TsqYhmIuq8DWnEz7MxzaREb5x4X58PJykoPex4z7dq7ar7SjwKlUlqxFGFIsZMyw998giXV9AuGFbe8w/UwMSvCzIU/fXwqORgRDD1y9UgkQuSMoDvsOM4VqaHHlH7zu4J12OyTBKXBRupcXodsr3mCBx4cpWwQ0rm8AOj49x/VKzhb1b1OI11LZSr+E1I3lexLlWkgL2B/mH1b+1CZKMkT96E9eKgsYJRiig==
Received: from PH7P220CA0063.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::30)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:00:16 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::83) by PH7P220CA0063.outlook.office365.com
 (2603:10b6:510:32c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 08:00:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 00:59:58 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 00:59:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 00:59:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>
Subject: [PATCH v2 01/11] iommu/arm-smmu-v3: Add arm_smmu_attach_release()
Date: Thu, 28 May 2026 00:59:29 -0700
Message-ID: <7771eae55f8c21dc7a90a52b9298486fae1ef63a.1779944354.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779944354.git.nicolinc@nvidia.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a246681-3084-43a5-002c-08debc8f2751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wPDnVxmAbYnbUJhPSNHmUPSZfJxGPO2uwn2S3zp+Q81kLzvlq7BYFGHqqPNKx8eQsV0KL/ZqQHYROfo1PchJUamWnhbc47hR42hpD/OhoSlyGdWrT3jveCFdVPXVn9P2A6cno1GcNIsTMhBaoByuJ05H0Dt3EHmiw0CtrKP9cxCMCZ5dm+YvHu9l3XTm1Pe0qKwUenk04upEPSJRHwN3xssIPvajgoGMBNncfhKYh/wJ/YQKGbjQg8Q4wYc5lWkakHH1+4M7XaJGS5Izrj5GmXl/hZCGecHSTDyYTL4OKHgNlItRiJCyv520VfhyRtpAwShQxaAhRZQouKCmO48eChJTXDI2O4YuRG7eLPsYL827cqMOpCu09CTLL6yTo6NvtM5u9PcPdnnwguDwpDwDAU59R8MAE5INt+NWIbbfx2KVamgnkfDNXWDpgHIRrumV/nSQ3+ZChFGsnzZ6w5bpT4KD2BcUzhAFL/DIYoWIBYWYFoYG2SZhPuz1o2877eeS9y/atuhT1x1U24xXJQ1ksppTOEyfAkolMZP9hIWsT5+n+jDHYCjPi30RaVRPyCJ7o8GrVqtnIqEQRdSoXN7745+ApZ8mrNznMqfJjj2jQKPtdiHZbVbWfYBFQmHM1C2L1PGY4y2iffEkuonZuzEaOfblPzlmkCNRZdZNNxCydgVp8+1ZS0vqoRHPK5O2YfzLh/IRAePiypZzlbTxfKd7LPs5ucmmN2VKXm94hJxsh4Y=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wyn0VxIHBV27A4jMLLuVMHwPOkv13yFzF3BhYYUZioN2e6knjkppeU+ScHqRgpS2jeEq8r+Gj2qt3nVvz7eUgyfaW3ZsYdFmQ3jBC81b3ncF9ADU5UFrTx+B5XCZPUAh6GGCZNBB3X5uQ233fk2x12yEcY0yU+dMZmLZQkPOTH4yVfaK6FjSTWrlpEFTvb9hunLaXXKXoZQFy5xqgOhz9SjjCfHf9HuLqNfheqZt87g5okhpi+Us/yuB2uvHC4ow4HyPaMXdqARsYXl/IGe9i/gT+7bUwMtvR6eyG6TloWjHlYXQksLL7qBH1qrg+GltP64vTcygnc3noij52tNxJH8oozAHrqz+K3mhsuB9MU7sTUYQvovK2oWR+/SvMSCvNp3dNpeOmC5dOl3DyTaR2caWtYzrWORMs7XURK3QA6/0aeGw405CtNFH1G1Ck/R1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:00:15.6373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a246681-3084-43a5-002c-08debc8f2751
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

The IOPF teardown is done in arm_smmu_remove_master_domain() when releasing
the master_domain on detach, under the global arm_smmu_asid_lock mutex. But
the teardown must drain any in-flight IOPF (for the old domain), before the
master_domain is freed via iopf_queue_flush_dev() calling flush_workqueue()
that can block on user-faulting page-fault handlers. Doing so when holding
the arm_smmu_asid_lock would stall any unrelated attachment in the system.

Split the teardown out of arm_smmu_remove_master_domain(), to a new helper
arm_smmu_attach_release() that runs after arm_smmu_asid_lock is released.

Since no other device would use the old master_domain that is being freed,
it's safe to move out of arm_smmu_asid_lock (still under the protection of
iommu_group->mutex).

Note: this is a pure refactor; no functional change; it is a prerequisite
to apply bug fix calling iopf_queue_flush_dev().

Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
Cc: stable@vger.kernel.org # v6.16
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 33 +++++++++++++++----
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 16353596e08ad..2bb810e4d5fce 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1197,12 +1197,14 @@ struct arm_smmu_attach_state {
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
index 1e9f7d2de3441..e53c8e97ba190 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -191,6 +191,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 	arm_smmu_install_ste_for_dev(master, &ste);
 	arm_smmu_attach_commit(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
+	arm_smmu_attach_release(&state);
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8ce3e801eda3b..620c67811df48 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3195,9 +3195,9 @@ arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
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
@@ -3205,7 +3205,7 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 	unsigned long flags;
 
 	if (!smmu_domain)
-		return;
+		return NULL;
 
 	if (domain->type == IOMMU_DOMAIN_NESTED)
 		nested_ats_flush = to_smmu_nested_domain(domain)->enable_ats;
@@ -3220,8 +3220,23 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
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
@@ -3519,7 +3534,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 		arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
 	}
 
-	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	state->old_master_domain = arm_smmu_remove_master_domain(
+		master, state->old_domain, state->ssid);
 	arm_smmu_install_old_domain_invs(state);
 	master->ats_enabled = state->ats_enabled;
 }
@@ -3594,6 +3610,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 
 	arm_smmu_attach_commit(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
+	arm_smmu_attach_release(&state);
 	return 0;
 }
 
@@ -3694,6 +3711,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 
 out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
+	arm_smmu_attach_release(&state);
 	return ret;
 }
 
@@ -3714,9 +3732,11 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
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
@@ -3774,6 +3794,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	arm_smmu_install_ste_for_dev(master, ste);
 	arm_smmu_attach_commit(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
+	arm_smmu_attach_release(&state);
 
 	/*
 	 * This has to be done after removing the master from the
-- 
2.43.0

