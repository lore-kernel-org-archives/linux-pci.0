Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B077E2673AA;
	Tue, 19 May 2026 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162006; cv=fail; b=ApQdH6FWAYxQ9S5fjfuAXe0MQXPZCuYyrVroPX7s9Dx+oQTFpk/SQJX/1/+CKSw+PQFgTimksba0g6sogcM3iAUzBNA5bHpv0TQivpDUlcxRuMNyUTqJQ7oOoz4g+NbeObxwHJYUKybA5yqmVybDuH2kgbzRz130+1tmDYJ+pWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162006; c=relaxed/simple;
	bh=xEwTPzLlSk9G5ESknKy5TySf3GuTmaNOeRRQsvWX1Vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGPrQvwbHmqrmrcRCBVxCaZFunEiVwoNFBJP/iLV1PBk7NQIMInw+Ji2QjdmSH0MVVQrQlHqmfuBVQL4HvEO2ju2BKkT9d16wCo0bamy/nJ7GIxyvyJoWAzOTrje7czF+KariF1/cQGIOGcw25boQ9dH614OsvpVdaJfci5VzB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iOClf3aN; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iOClf3aN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuoaiZTyM09hVXQQ9gYbaNWSHr8Xfpg0AMoiTywwnvBbwe+Zbj7ITXItRL2YbrKgnisFw4PiU5oBwfxUK+y97ntW3AfeRlShvW1YSi6aYbhiI5iW4aDJ5jEal/C61MhOKyre7rc/1GKFTYhW2MW3cKxK0wjqc8kkcnWojfIrT1O66ix39k9Wp2zNNj+QOgPu/yH7Tn9wSWgI4/w77XpnowIHBDnraf9CqWluqpCIWUR/GEdjPhsZKMRaE/NiO0L+w85e4hxtvYR/jymajEixGoOPNnEvBlf9b6kxni/GG3VaGlXTSra5G2pL5uFsPQkIoQZxQdP11/UWqrcqIcWU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpfLKjNCxUhlJxDKk6uv/7IkAP6/cHvj0ZExoLzKIMA=;
 b=Ci7sN5DTrOMSrMz2Eikj03XykynZhG2p6/WvLTvTKbUe+c/tbSJ0iJbYCaUw2auEMLoze98PXeFoOqKThNljS+oYnurTl37d/guNxXOr03RCo+OKWp9/wQ3w0V4HVPvkzg7murBVUa5Pcmjy9pOTOSFyJQrf1xXPsoGF4KxnFndotJGwSOZqRdPZVM5d5tpckUolKBzsd1szD5PcvEVnOC3idZ8g9TOb01R3sJa1Z3b0Cm9h4vWwsdxStPS0yrdrq9ffzrmeaAcjMKm0w8d9e9u3vsr1VYgezPaXeCqKiTi5YiPFaeXCwbJxzMH1gspmLvYVJ0SHosoh1fD+nmnPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpfLKjNCxUhlJxDKk6uv/7IkAP6/cHvj0ZExoLzKIMA=;
 b=iOClf3aNbWe1JrtONgAxaaR3EeIrHqHz72NdbtNnDxxrqDuWG5aqB4RLH0CqETtYJ7EsSth1W0fVNHi+l9X3/nMnScR4uIaY8dut22gYZ/ws/SifyRsQr3GcH49XBHc6Xr6g29FT1btGuqDc1BwxXFLtpPlgYIIg1cLr6fe+rbMgxrRnGA2OBJKcMdFKLuhI9FAQsi8Id6V4CG+5iX2jUG/IHwt2mt4joyOPdv7/l3Y1AbRzamB4y0lm3sEg+gBA9cIx/XkvB4c5JRlaCFyewPA5iJronZXIFWpH6tXKO9O4402xnVw9zJwQRmlofihGYAn9r0jx6OWyQxGZA9Ow4w==
Received: from DS1PR04CA0001.namprd04.prod.outlook.com (2603:10b6:8:44f::8) by
 MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 03:40:00 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:8:44f:cafe::84) by DS1PR04CA0001.outlook.office365.com
 (2603:10b6:8:44f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 03:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:44 -0700
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
Subject: [PATCH v4 17/24] iommu/arm-smmu-v3: Add master in arm_smmu_inv for ATS entries
Date: Mon, 18 May 2026 20:39:00 -0700
Message-ID: <2ea9edeaf0b23840670c62a57e71e7cf73f41ad6.1779161849.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779161849.git.nicolinc@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e82913-da88-47cd-058e-08deb5584dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	t25pnllxS2BRq/yXiSzheDk3sAMGjVwi43fkwlP3COdgKPnLR5BEUcggmEQwhm1TMYxHVO5aSAEfrQbKuXJEIFgDp9O5kRkuLiiVC4tBbincvFMlLb5pguWb4QwJQxuhesGUtBVPhSU08VMyG39ztnvBB8X99lEbqkrt22NIFSRBWiMDQx4I8oeUpYNGygaHzlPLXfxvKW6GWHNykT3SqS8E8SGZT2b5SF/vqFxmEm5SsKgopS2LfiwjhzuV6qlPk0Dj+borCXDwjOqcTd+z8WcgXtAbzEezyGyhWvylUMxfUVvLl3mhGBsGTMvnrYadjy2bfvGUp0+oV5pjMvsM+noTcBuNa/WlAqOHx9eHfUvTVKGIiXQ1cNItVN6R979NFVmOc2ao5cyTwsviLL6z3NTh0brpUUYIxF13aBn2Q3Bo+A8fExeeNaAQ6f+GLx+4D/1f/aHDQvFkFmcNDNHiVKdhbBM8S/2PNmwZvRx+DDBgh1Q5oTn78FrH4dYo0qs/tuWu3SD3ylyvAWa378dYDG4MyrDC9zUmYIvmdmT6r7rXiY9JL9bPM85DkrHmAfgPl999c7Gd/A8h9QP5m0edU/v3lZzQLZcW9Dvu/wxuzB5YYY3Z35DIjOJuDbm95S80c+BHPiFdW8IGSgshwE+ppw4pJ8B4IIGZRGq3/mSYyGbGvWQ1fMvILM3iLdIPkMETqZBjEnKdCSJQUByZpiRbaAEz5pwGH2XG0w9j0qnpoPc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/Q7dphSYCpP6X1ZHhn0XumsFKAfIC7vcAJhhGTz+p7yxfg9Jvax60VCGwOXqhUYeI2m9lFCfaNfkXsKFyGBi4sf6Mm3Lu04XhazToKsjKn4IRvnrxOenHFxdwFV7iU4sQU8WvoyIr7MIVKF30GqyjhhMs3lA6HdNu8hLRNQuhyhYQwlE0vn+ZirK/FBeDzk5i9ajmSX0FIpcRJVEhzXt6m/WhBcOA14ffcG9NZYlKG3W7lUPi5mzoo/LP0VPdBUNH9Nm8wc/kDiuu7A9lW/r5czznOGCPt4bPIfrGQrj/gbsu8l2MOldgyZniAlpJpd1j9wFlEkfrgn9b2/FQ5bZrXSTam7RFtnDw4hGEjiCbkYGN5rld6JuZxEfKiSDIkikHCJZdLHI9cONPwYsVYYxGQp9EePizW6u0m8ctB0tWBrLTlb7hertQlKKu4Xu+yrB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:59.7909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e82913-da88-47cd-058e-08deb5584dc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111

Storing the master pointer allows backtracking it from an ATS invalidation
entry, which will be useful when handling ATC invalidation timeouts.

Don't simply swap the "smmu" pointer for the "master": a non-ATS entry may
be shared across multiple devices (masters). An ATS entry is okay since it
is tied to a unique SID.

Master must outlive any concurrent RCU reader iterating the domain->invs,
because inv->master is dereferenced inside the read-side critical section.

Add a synchronize_rcu() in arm_smmu_release_device() before freeing master.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 604f7edf54158..df6e539f75274 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -738,6 +738,7 @@ enum arm_smmu_inv_type {
 
 struct arm_smmu_inv {
 	struct arm_smmu_device *smmu;
+	struct arm_smmu_master *master; /* INV_TYPE_ATS* */
 	u8 type;
 	u8 size_opcode;
 	u8 nsize_opcode;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0e4f34ed036c6..cde2ff2dcc49b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3211,6 +3211,7 @@ arm_smmu_master_build_inv(struct arm_smmu_master *master,
 	case INV_TYPE_ATS_FULL:
 		cur->size_opcode = cur->nsize_opcode = CMDQ_OP_ATC_INV;
 		cur->ssid = ssid;
+		cur->master = master;
 		break;
 	}
 
@@ -4168,9 +4169,6 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	for (i = 0; i < fwspec->num_ids; i++)
 		rb_erase(&master->streams[i].node, &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
-
-	kfree(master->streams);
-	kfree(master->build_invs);
 }
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
@@ -4244,6 +4242,16 @@ static void arm_smmu_release_device(struct device *dev)
 	arm_smmu_remove_master(master);
 	if (arm_smmu_cdtab_allocated(&master->cd_table))
 		arm_smmu_free_cd_tables(master);
+
+	/*
+	 * The iommu core detaches @dev from every iommu domain before invoking
+	 * release_device. So the updated domain->invs no longer references the
+	 * @master; IOW, new RCU readers cannot reach it. Wait one grace period
+	 * for in-flight readers to drop their references.
+	 */
+	synchronize_rcu();
+	kfree(master->streams);
+	kfree(master->build_invs);
 	kfree(master);
 }
 
-- 
2.43.0

