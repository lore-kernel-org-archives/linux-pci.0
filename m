Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC939A4CF;
	Thu, 10 Sep 2026 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082275; cv=fail; b=lzFxbD3oRkTIg1oWy2gSA7ZmGFzXaRJUWEBJ6a+CGGWjNaPNHO9VufwpIrU3VM0WSasYA9blO8rQnk0YetvDdfZPcckOk9f/aZfzl7nN/r0cfrFGnD/514/CJazp/74D8Yz9TcXfTg6ptAbZ2bYOuHbDMQek1ze31bw7m3323+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082275; c=relaxed/simple;
	bh=L2vigyv5t3d9kWpNdXiUa79nRsO0L2Ia98otwOZknC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Me3vPj2FzFjmg5oS7jQoEBlk+glydDFoi0rtqyVCTPcTrEO7kIaDOBfQ9MAF/47uDxKQy2GhTRRKVMsZPmvOw9r1L55hw2dTpa6A84S2AADmQJbmqY6MvbhHS5jKQ1fd9PwQqizTxQS9n8q58CgVLViMMgqk2HWIvTkicMqXA+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Id8sLHzQ; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Id8sLHzQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAZpozu6gjFk9yGfWO0E6q5BOkLBcJDWCeqfeKxi/sE9ToIWtzl6hs8uFV+E2uOp6Jfw1HCfd44aK3I97G3ijguIM9f9NRu2mUCAIFixMC8C8Bir6VbNzIg68rIzUGbWuGhwBT+HTExZl1kiX27qnaDVDBLhZRGCg5ToXi6pk6/zyCMkwCzQKlwVLdyUrxlqoWXanqE0mx3Ta95eKr6OxsvxyRgtYiKfZ4kTw1nHgvTXIAcA4ECJN7Av8WhA+RmdLAKzKusyzc04tkMZSwB/MMMNHEPW0JqHhuvzhMi8qqJEo25X23RBy/fJ5jM5J6oLUNH32lxbc+AhIx84C5L5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLFQy4cGriJHMFgx/kJ8/j/Lz6gEm4kM/Wb4uKs4Jwg=;
 b=O4tC+N8BoZApWJa4wRg97f5Qz/DPXnVXviEHYsvWZmW5r5VSiIYgJ8fNZpNzoKfGp+rvKteT5vFk1YbRHK23m3XFfI5uyUaiZajnlWv8Ph15Rum3nIzndkQDJTCZcgZC9EbxyNDiro0MDWqx2yNMP1A+71mM/PbGbhpvfKaJ3s9h/g0DfnMLB/r22PsjBP53JOYD1UdH9pZ7Ciz1o+wXFooq8d77jQzsdrBRbL95ySqALGlaKS5NT8SCDmr1OtJWJ4t4rhW7DD0iTFI3UsqAigvxS5F307Q2ZLKhGGOdOA8c+W6U+mHQkWgW7+4MgReF717L3LY2pM/2NC7N72yTlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLFQy4cGriJHMFgx/kJ8/j/Lz6gEm4kM/Wb4uKs4Jwg=;
 b=Id8sLHzQgNfLh4ZYw97zg1KaTS9YQxZo5qaV+3TuB5oiHUougQg9H6mmadZFYQpMCWMJJiULUZhySJ1PQOWxEinh4HuFfBhuC6Gv3Kvloy15i/rISn527NWobOcuHoANe1TjOjckxy6oTOauL/dfdcUs8eAJa+YDs87vutmrTbfMo9/CbKp/M3A3fu16tv76vcwfdqlH/+2QI+NbsQvxp04BbJLXbNFmB54iSs5uIrDHouRiXlqRoFc1AFwOvqUFI08ehpvq7FQMtSJcwdlsBAFPvNFfL3y5W6LPIBgQnbE5ls2rXglqaQz2GX3i4cFiV1jTsFJGeP79TymcT3mOCw==
Received: from SJ0PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:33f::20)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 23:17:44 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::8c) by SJ0PR05CA0045.outlook.office365.com
 (2603:10b6:a03:33f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Thu, 10
 Sep 2026 23:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:24 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:24 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>, "Jonathan
 Cameron" <jonathan.cameron@oss.qualcomm.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, "Eric
 Auger" <eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v4 02/15] iommu/arm-smmu-v3: Add arm_smmu_attach_release()
Date: Thu, 10 Sep 2026 16:16:54 -0700
Message-ID: <8594c8e42e846da3b87f96f1e196c143fe4d517a.1789081084.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4f52cd-34e2-4458-05bf-08df0f91b83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700016|23010399003|10067099003|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZinOwctoaVrPuo/zbFLi5PTLAGpzFvbbserfjQc0B8gtFaYvMHfS7G4XJAocCyXBxOX9pFiSKLiOehqGWKHQa1HlIwsF6ZDJWGBOlcAAxHvWu3vZeS5Krs5k1md0rcPLrASTHtSO+xelRuRkv1/gM3lgxBtXmYTaeBb0WAgDzJSPK9Mj1G9ORScGfDfOzwOXphw9w0NQtGPwSB59QbUYsfBHftzeabJGSybj37R7WE3yOjvmE+TA4iUNgk/3yNFDSh3PRb5W+4+I//UXb7N+eLFdOgU74TxPR1YDbWD0wtcIWuZcXwsBpCBGUgC+wz/DNHG4qHBnoIJXCXuWE7a+0P/C5zfsaxO39Sb4SeEwB1HfArM1nKi04MU8bSx+BlGBsLe/hrtOKclgIWLJo+w9vVBsx6lG5je+QRR+8hc/nPZe1K1zjVBSe65+84KQ8jd1RsxaVkvrSLkcTfcskVwPIjhbwv65S7t1EtRIfP7VDid/+IaNpmEk9PHrWxxNzqxX+FO/xlRfoUThWzmsfJ544qz8/4FFOiTUpUSRx7NC3Vn/0RFUq8OHWpgtmPbqeLS8p0t7T3333yPyhG0Yyi+8BEiWyyQQeNaMu0/T0lFtrLObkMRDg6bODZA6jkR4YVDeeS8YqUCBXioXIPVKBpd7WMT+sEdZSLNVJLWT+UQ4iOY/m5/EQTBE+TltW15KY3HjM3qowm9cnld2IOy0SqQ/yQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HprwVUwrfsDLopNT8mjX/FbuJOKm8lJh0FWnXsZMsNFgoCE1EzHRbX49+KhcxoU18atdebOIrILCCy/dixSWA+XK3eHJUAGYWydq7OJ0kZup1m4yyZkWJIsToEZ/yaBOn3dr3MoLz0NQ5yWEfRz4V9eFlqND37QJ14bnCfU8RnG43hyL4bok//Rc08xFWfVwDnH68JTtxebGbdGHv7oZUFl0L+64LT2ObOgPUa9Ys5J2oGCPcsI5qlbV39CDfdu2tkJ/lWiYOvSlDucHrOJX/NG23vP9JlAe+menn3rP2C68jvar39JI1o9W/aYXKZe5uExbjJrrXN8iOCDSFxikpVFqJJvDfcB3ei4LetXIRUmwKpjpy0PAaED5rODjNMjz8F/edT+c1LeS5JO1JLd9Bs3cD2/p5uDSIeZhqDSxK7t/vVqve+1km1uLtBtmCHu7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:44.5396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4f52cd-34e2-4458-05bf-08df0f91b83e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206

The IOPF teardown is done in arm_smmu_remove_master_domain() when releasing
the master_domain on detach, under the global arm_smmu_asid_lock mutex.

A later change will add an IOPF workqueue flush to that teardown, which can
block on a user-faulting page-fault handler. Holding the arm_smmu_asid_lock
across it would stall every unrelated attachment in the system.

Split the teardown out of arm_smmu_remove_master_domain(), to a new helper
arm_smmu_attach_release() that runs after arm_smmu_asid_lock is released.

No functional change: the old master_domain belongs to no other device, so
freeing it outside the lock stays safe, still under iommu_group->mutex.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 44 ++++++++++++++-----
 3 files changed, 36 insertions(+), 11 deletions(-)

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
index 81baafaffc410..759d0e1126b30 100644
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
@@ -3310,8 +3310,24 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
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
+
 	arm_smmu_disable_iopf(master, master_domain);
 	kfree(master_domain);
+	state->old_master_domain = NULL;
 }
 
 /*
@@ -3609,7 +3625,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 		arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
 	}
 
-	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	state->old_master_domain = arm_smmu_remove_master_domain(
+		master, state->old_domain, state->ssid);
 	arm_smmu_install_old_domain_invs(state);
 	master->ats_enabled = state->ats_enabled;
 }
@@ -3684,6 +3701,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 
 	arm_smmu_attach_commit(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
+	arm_smmu_attach_release(&state);
 	return 0;
 }
 
@@ -3766,8 +3784,10 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 
 	mutex_lock(&arm_smmu_asid_lock);
 	ret = arm_smmu_attach_prepare(&state, &smmu_domain->domain);
-	if (ret)
-		goto out_unlock;
+	if (ret) {
+		mutex_unlock(&arm_smmu_asid_lock);
+		return ret;
+	}
 
 	/*
 	 * We don't want to obtain to the asid_lock too early, so fix up the
@@ -3781,10 +3801,9 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	arm_smmu_update_ste(master, sid_domain, state.ats_enabled);
 
 	arm_smmu_attach_commit(&state);
-
-out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
-	return ret;
+	arm_smmu_attach_release(&state);
+	return 0;
 }
 
 static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
@@ -3804,9 +3823,11 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
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
@@ -3869,6 +3890,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	arm_smmu_install_ste_for_dev(master, ste);
 	arm_smmu_attach_commit(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
+	arm_smmu_attach_release(&state);
 
 	/*
 	 * This has to be done after removing the master from the
-- 
2.43.0

