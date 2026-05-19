Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0E342517;
	Tue, 19 May 2026 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162015; cv=fail; b=lo1ayFonOlulPiVBALqwM+5Xks1GyxLiJF4z4lOzwjudUgVYgQBdBg5SmGUT4Siu/oWOQM4tJebYxgxvTOSs/t9G0mM38Hxt0fjvsc0wVgpZQBeHQj+b+Ob3Mamea4Lj69TU+oMpb5qdlFnMI3GcTnZcmzi1iqKuLjC3SDyRxQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162015; c=relaxed/simple;
	bh=Q/oQL4sqffxK11Swtc2gYS+fa1Qjz37viumjbRd+3ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJk2kb+YqMIOtLhuj80WX9qR3O78O7irB+fp9IgHmNaksaN1tgXhzLIfJgqUtBtsX1FgXKKcCOUUuIgY0u0aeSasGbhqycn8yCmZy4gRVVE7OTEbp4ZD0wyDzAtW+gZpX0GUUVHaXQiqc0kE35k7QdbKEP9byJo40bqkm1gciLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XPnlUEV1; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XPnlUEV1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1kHbsuhxbRsadq+zIC2d2MKVBdREX/ZdOtky/ng3BNHy0Uv3XnHk36n+4reFPUKznej7Uk/DCr1ExHDr7+/LdGQCVzoiygP9J9Lv5aAod3lChOxDyAlQBVOGSYJKZqnHVad1/qgEQ3srOBV8rYl+It/pbcl8Vkw6wAOvr3JgBJrcv+0A3BKKXEvp/8Aa/3ATJHH8RR6vSXJ100sN7k2JnNA3Gn1CvclYp5zfSa+ZuEUkwgrV0+ukSWLjJKh3PPTH8TS4CifqhqVGfp0mAVAXKSwIlerRfJTw4D7A3/AbZgpXzIxo0JEX1VpeCh/eaLoppHpIHirrxUUwPGfMqXLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sshM7qEvZYFRBt8eJTeC10ghlFPHi7qua8nT0LHpjgM=;
 b=QMJ7HvvrEbngKMMMEza68r6eT22FVHAi1al10+CmQLEPeP71B2DBwq3c+w0SM9mUf+g6mAMwbcNVq9iuFSM0fcrYlY9mNUqpDw0rdI5nwwC6HOHH81PMc2wOxVR+t3qELup29jZXTY8d64RydI7MD1c57WSdw55G6FOJlbcRTwAkBhPN/stnBbsVXYrzhQqnb8popkAQKVA+V7j/zwwETk8H0nAyvxp4EPlWI9ssy/w3dpY/rf2xV4t/uoqWL1/ovMvqF7i5hLiSisyfd0rewtxbUroOoi2HRKEimW3VMkI92tIeiwD0fRw9NJnS+AOcobpAykpLKmtv5pTNe0BJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sshM7qEvZYFRBt8eJTeC10ghlFPHi7qua8nT0LHpjgM=;
 b=XPnlUEV1Dg7gl8hX3ilm6I+AXgjYYpgfGcY4hm5nZjdbRvQ6Gi3LZhhFlsSYN2hKAqeWsPW+F8g57s5lghsjo9puK8RBjgvA6ywEYQ3Jg443ij3JwJ5ozP3qyERU1zgZxe4RWxEUOr3Lr1H45SgKoN1WuaB1pjbMG4oD3EMRNK8/n28NZJHwioks+AOFZe3G8ijjcNdehd6YVRw7xFzcTwg6Pimgw+si3cchEsAuE8eZ+UM4YDoSy6tIrvcu/RD0j3Jnn42o2MDsZCoPcs085c83XNmuiBXodL/5zOOAom8fYZUnV2AcF4ZUhA/Dwql26wP6bDjwDLHcsfffC1aLFw==
Received: from DS7PR03CA0105.namprd03.prod.outlook.com (2603:10b6:5:3b7::20)
 by LV5PR12MB9780.namprd12.prod.outlook.com (2603:10b6:408:304::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 03:40:09 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::fb) by DS7PR03CA0105.outlook.office365.com
 (2603:10b6:5:3b7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 03:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:40:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:53 -0700
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
Subject: [PATCH v4 23/24] iommu/arm-smmu-v3: Serialize STE.EATS and ats_broken updates
Date: Mon, 18 May 2026 20:39:06 -0700
Message-ID: <06f9a43b40a3d1e0d00abe1524f070c86609adf6.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|LV5PR12MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: 42531054-4bb9-4cb1-0ddc-08deb5585349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	VhEQQVmzE7z6DOLYb2l2BOMaDWsAz+nvFErqDiGMIblBmSvC2zxJ3Pw3ezyGxsIE4+yNCqWLHuEZhx0JKugpC9ALJG8kxemNlzxs7AeuuH2M/0svM24e/mnyJ5b8cbeqDF9sXAldQRsb7ON1CLh0jpcSpU3nT4V1q0v3upGyiL476snrm5/ouT8Xpjv5HqAOTSaVjo1kG1/6shAAuSyhqpX5VMtOVSWyTGLJJzdLOBHHhgsD9wuiDUFqVrPP7z0BT9UhAbymNH4vm3u0gGNqHiZxYy6mGLe3ghpw/2O/9HMMjqHI09CgfOqfhiR8rRSr1mVB4+C6PbOvKAMiUYqmUt6OzpdFRxYDVVVcNEnink9bEcQ9zSEj9duTbqRwGLFFs/Y7kkBxbb+TnFOgCrkhOgzDyCJra8WauoIhwk9AIvXM69R/EhVNbelouJgIXbkno9P41B0/VGD6RCVvUJkdfsNaQlIHKUbyUWkEABTCs8gHgv0DPt/fL0ZiDkGr5jl/I72clwqKNAEpbHT2uN+8hbCB8oSdE/umf2dRKhronYGKThvGvuQVEsMvr4/8KY6QktzovA92hZvcZkCXUDJR2MDxszSdjJJHj7aHKRSCbP3Dsl5pUCWFzrX/Y3R1Xa8UFe46IZz4dTXghH+fOM6bMCYQz1TR8Kl1LxagtVGz+xv4URb2mBXzkwhY5lIzCoUTsUUpkMVtng5UxGT4NQ3d6Cd2NmqjpGT8ktOHHP1Wksg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E4OB5t6lYFizcx4Svqn3LgtXyXLCvJRCaThgn1YUAKVh6mWFgsQTPAnVsafQ/OMUk0Y9X4c4x0DEnnCXuT2zADeUlET6I6kM8BF8RTuwRjA2rXW5cDGDOvzvR0F4msNpXyUL0sIGeUJ+1CtZcDAsRAlofwyhkklNIlJ5aK/hJeEykFAoUNXWaNy1+TgaVYunpNviZ5TCR3dCmLpd0/ArMhD7pJr4D3QB8NWp7TUXDrZSmYIJuij3/KAaZN92JijEoFu7NEVcbDMWsXVKGUHTAr5QGT9uv5W7NBgz54nk4zsVBCPmHwhb0xk5InorfbJTozsxcAPrLz6VgD+QTREbtcqOyGlrE/OqlFYaoFzKOebboQ7BL57L3iH5zPbOpQJ8oyoRYzfGy/QUb1YZfFb4esSVRzfNG7UD+zAbvgqpCajD2sEu07MvEOLKAQfCwEXI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:40:09.0698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42531054-4bb9-4cb1-0ddc-08deb5585349
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9780

A subsequent change adding an ATS-broken path will set master->ats_broken
flag and overwrite STE.EATS to 0 for a broken master. This will introduce
race conditions:
 - A concurrent attachment that read ats_broken=false prior to ats_broken
   being set to true could re-enable STE.EATS.
 - A concurrent reset_device_done callback could clear master->ats_broken
   during the ATS-broken path, leading to iommu_report_device_broken() on
   a pre-reset fault.
 - When the ATS-broken path reads the old_data[1] and writes (old_data[1]
   & ~EATS), a concurrent attachment could write a new_data[1] in-between.

Due to an ATS-broken path can run in an atomic context (invalidation), it
cannot use mutex.

Introduce a per-master spinlock_t ats_broken_lock to fence these cases so
as to guarantee that in concurrent cases:
 a) A master->ats_broken update is observed by every concurrent attach
 b) STE.EATS is never re-enabled while master->ats_broken is true
 c) data[1] writes are not lost to a concurrent ATS-broken path

Note IRQ has to be disabled while holding the lock, because an ATS-broken
path can be entered via a hardirq that might interrupt another caller and
lead to deadlock.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 ++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 186efcbed1ea9..e3eb4c4a62d3a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1048,6 +1048,11 @@ struct arm_smmu_master {
 	/* Scratch memory for arm_smmu_atc_inv_master() to build an ATS array */
 	struct arm_smmu_invs		*ats_invs;
 	struct arm_smmu_vmaster		*vmaster; /* use smmu->streams_mutex */
+	/*
+	 * Serializes arm_smmu_write_ste(), reset_device_done, and an ATS-broken
+	 * path, preventing races on ats_broken flag and STE updates.
+	 */
+	spinlock_t			ats_broken_lock;
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9591e4ab2b14a..ee864046f0baa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1791,7 +1791,23 @@ static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
 		.sid = sid,
 	};
 
-	arm_smmu_write_entry(&ste_writer.writer, ste->data, target->data);
+	/*
+	 * Fence against the ATS-broken path concurrently overwriting STE.EATS.
+	 * It's fine if the ATS-broken path writes after arm_smmu_write_entry.
+	 * Otherwise, we must clear STE.EATS before sending a CFGI_STE command.
+	 *
+	 * Must disable IRQs; otherwise a hardirq-context invalidation path on
+	 * this CPU could deadlock at ats_broken_lock on an ATC_INV timeout.
+	 */
+	scoped_guard(spinlock_irqsave, &master->ats_broken_lock) {
+		struct arm_smmu_ste local_target = *target;
+
+		if (master->ats_broken)
+			local_target.data[1] &=
+				~cpu_to_le64(STRTAB_STE_1_EATS);
+		arm_smmu_write_entry(&ste_writer.writer, ste->data,
+				     local_target.data);
+	}
 
 	/* It's likely that we'll want to use the new STE soon */
 	if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH))
@@ -3000,6 +3016,9 @@ static void arm_smmu_reset_device_done(struct device *dev)
 
 	if (WARN_ON(!master))
 		return;
+
+	/* Ensure the device recovery is seen, to flush any pre-reset fault */
+	guard(spinlock_irqsave)(&master->ats_broken_lock);
 	/* Pair with lockless readers */
 	WRITE_ONCE(master->ats_broken, false);
 }
@@ -4236,6 +4255,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	master->dev = dev;
 	master->smmu = smmu;
+	spin_lock_init(&master->ats_broken_lock);
 	dev_iommu_priv_set(dev, master);
 
 	ret = arm_smmu_insert_master(smmu, master);
-- 
2.43.0

