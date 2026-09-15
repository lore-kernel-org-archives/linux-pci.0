Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2234AEBEC;
	Tue, 15 Sep 2026 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490358; cv=fail; b=HiVkk7IzF8oFMgnpv1dttwHwpAwUtGX5vTkTbHzCa9dR+fOYMYYcRw/IpX+8PwJxPe9NsCNK8rxXz6tIA6UmAtj/4Rm9xP5hAFraRV+oeUWbjo6SgvjBcsFRwD9Dsi5SjozAQjDnF8NOAeDMu/BzlJEiipkiSRKb301CrGKkidA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490358; c=relaxed/simple;
	bh=Tz4hOaP9VO7GCTHLby6B7vZCWpyE6JReie7ZMaGBQ7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nj+p3FJQ9LPJKkYabA8TjQ8juZHFM8KHvkjJFAPONpzdImxp9S9GkL5qXG3hqiKA125PcGRKfhgkl6RTdfDG5PFHJQT8UiPsSOfUcc/sp47H/5GapxK4HP/7aukcb6MSfLRklh6xgw6oW77jMSGfFFDd9IhWF9rS9oWznCdUdQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0753HYQ; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0753HYQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtOmV+yGzv0MEBw6VI8yxySFQt6YOEdoT/FAGKh9ZG8hLZxR8C0MW5BV0eDwmCwr+om26rkis/rus0/6tfwAZAERzE9YyZmKQlEiGuDNofnST+NRKSjAklV7ZIM9Afw0GDP4joFefjB/3N1NzByZn71Qtknk5Ys8qLbTGplQz4T0V5JGBtMlrBO5So0npspXXcGjZJ1/3M0FzE19cAJXm7Dhy+85yl9BtISMtbnSMLDVruMwhauXy0DQ+0RicLYASoBp3yPDxh0CDxTPYTjfQP9YYilRw+lqCsdwYK9lIg9XNgzXogIhHPWtxusSzMegi3dtt2sZXV1WWiBBQ6Aulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXECQG4jdvKyyrDOOlug/fq3sBDI4dEHQZge2h4FDns=;
 b=KLChtCZBM1Qh96vKjmqMsJOR+kgJesnc29uNNB5SFiIOPpEt4fXvIbL9MrzQsskls+TKo5KAXXelF7BfPpuj4elHrYqh2TkCw3WPPJyiiXcnxsMb/tMDeVH3tqc5RfVhi3tSjCm+j5bsrAzetYJS/+9jRjXDET9+VbEBOXxhS6/Syd70JRFrwNuV6wHbS+//VietJ2qOOfbiA4mJwmztnZRKRaqjz/5dgYUOZGhdFCfrAO9p7barLj4kf15mlJZVZQhq+vTLfvo8CcPkhiCkZjsTH0vioxduoUFL0dMRXBoFIIxLpFGwq9P8myWQuI8yCXXpJSV0VeTHSPTQ44dMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXECQG4jdvKyyrDOOlug/fq3sBDI4dEHQZge2h4FDns=;
 b=c0753HYQpInU5/6A8JyiDS0hCIyBMrR7MVL3fGqeWw57+LftkrZhMY6GGnJkTsM0lVQmxYcC3qCj06sCmKI7BD4/hbmsD5WGkiyEgz/8zZeEcjw1SvczQ91c1SPdKDIuDQ9cqaxG+zsJw+QBcuqst+t4vmNG/7NdMc11BO5EbHFf5ad102rsf1YAaNU5EtNsAsszg9uuA6hk53YRfQ4L04SROPsvfq1lxAw2ouSXCrBNxO6IVCqXfKpFGm57ydmToXiNwPQdeolO+YychfOXa0qdlyLmwNxA0MmTchNVzz4os3qn00j6ViKyY5TESJnkbqjfm4T/nF8yMVmO5i2qeQ==
Received: from MN2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:208:1a0::20)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 16:39:04 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::5) by MN2PR07CA0010.outlook.office365.com
 (2603:10b6:208:1a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue,
 15 Sep 2026 16:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:38:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:35 -0700
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
Subject: [PATCH v5 02/15] iommu/arm-smmu-v3: Add arm_smmu_attach_release()
Date: Tue, 15 Sep 2026 09:38:14 -0700
Message-ID: <f74817bb45a4bfcda966d9b5ca366c649b6dfe46.1789446520.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: dc222062-2015-4634-9077-08df1347da6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|7416014|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WfjUZ6ccdXOCDmHf/8Ws7tg3UUuiuf4rn8hsuKcaZ6px4L81GX1TrMyCxBzx7+ZeniJUJ6Ge+W2B7tUO84oxKxss6sk21Cwp0GrYNZhX3LmjVBuHeiKQf1+31NiBKXKNmTLYyaHP9KwQFuiCml/W+Lfq2jSNaTuPC1G4KuLcAIhF+L5YQLNVNIOE73jBvX3gl6EGk4F+AnCNlgV5bYv/Vo0YimqwwMh5Gq7tmLhoW9lpdDypikhUQS3kUjo9XgMyafRK05o1mRPhd/yY0RMNBHxdCCXY0bhWWFUEdtG30Vc1a44fMliOy3gYa9o/Yw9VDHoRBP0HTa79wriJEeNmTjDSesV8kUBppJnu8J1NAC2rwwcMARo636SKcuEaeayYL5dVKBlk/SSMhBqc04223yTHl8zOZBsnMdITjJDJxoobJqt6XacIeBw8m5LLUs4hb25r/EgVYQT9vmG0jLSg0CbvFEjmX9PKFGo4/eNDcSIZHuxl/xUiy0JHdQpzjasYW2MUO0tkfh9MJCsyMEBsc9M3jlcYdJPOa5+haJ1FrmccQ8CXppjjcRqQUWKoypTRtGnqoD/3/xzGi50kFzbwtBEs0iSet6p/XIkngzXsfwWLlNXEqADRCGHKxoD0GAJc8TGwImjOntta0nSOrUhznn7Rn0sZxE3mZoyBNMixbywimphkCHBzrBFRpFHNvTbiwOuS05m2nbJsdMZxDaVsbg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(7416014)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RidbRLEDh7QeXc+cvImsqB0amhtP8vwTrL1LkE18SdXAcKE4MDu3ELhI09d+7FPc6frxcsK2yYX5ne9rOUZO/H5LgC5ZXiOUHXPiMiVJhnZHT/MiJH0S8/sUr0OGLtFV5ZUu8a6kzYPCLZtQrnhzo8ZX8FlP3SEk6CduGkBdbZ2jOzjkohRzS45ACvUdEAdNEmBIkLdpl5ReIqQTcIHq8QGu3hjnQCJXSv0QU8OC8dE1tBnO5oHltW3xAYojSDKDtH+WLkGt1ZKjdfPvu4s/27VO8JQjPpq2iYH+J5wX+2MVm2v6FW2m12yi38J3kPefhCKl8mpyviiUpDZ3WhlFS35fyEx8TXOFWtCKTsoSx4ZIiyD/7jmpIAc30GokwJlHMnyHa3EKRbziOxH/yGc8c98H63B1x9H/YEkU6KjVo98sj+IxQt17lz3Y4f53J1F9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:03.6441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc222062-2015-4634-9077-08df1347da6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965

The IOPF teardown is done in arm_smmu_remove_master_domain() when releasing
the master_domain on detach, under the global arm_smmu_asid_lock mutex.

A later change will add an IOPF workqueue flush to that teardown, which can
block on a user-faulting page-fault handler. Holding the arm_smmu_asid_lock
across it would stall every unrelated attachment in the system.

Split the teardown out of arm_smmu_remove_master_domain(), to a new helper
arm_smmu_attach_release() that runs after arm_smmu_asid_lock is released.

No functional change: the old master_domain belongs to no other device, so
freeing it outside the lock stays safe, still under iommu_group->mutex.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
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

