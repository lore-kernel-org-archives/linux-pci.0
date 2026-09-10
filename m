Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970CB3A7F45;
	Thu, 10 Sep 2026 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082293; cv=fail; b=NA5KRrLK2y8ljudgLa1UL5Eoh0BbKqklI5HE+RnRr+C65now8wMq9exMQ9kx5SAEtuze4cc1MFltKc4ikzW0ACBUCYpaSUwXI4couFE+wafB3MdwnWuOPWfSA/kkq6k6aSIGseCXN7tzaPvX4x//uGrrAjA21ZJxDMTSk7c25Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082293; c=relaxed/simple;
	bh=PMzZWW7Nq7Q/Z+17HW2QCQHtYScpPznKFDtka29sdpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LORNczJxA1FxurfQvDT67Glo9/QXSgXx9yv70b9OCMf8J14ulznMqBndO35V9TrxGo1igQfyAadxBmBYnPYPgPgZf4h0VxTD4Q2m6UE6NzzD34FT0zzTZqcgW8WmKk61N3Prw6nooGWZEJM7ds0zOI762Z752OrZmuuJ6wyhb0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EDqL536n; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EDqL536n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqPw5mVCUCmKQqk7YZdjnaap3RnO6irNMwkrUao2RxE4XnLBxwhogCHyeGNdpzUXQPXWdcD5aje0Bwt/OzSLVrK9Q2MjH9t5mgKynCyYAp8Xd08aO7pJmWVeQ3aPjYZ/bfM7+DmJnRNdwFpMgFUJ5B8wWePKhNu6mABfviGR7WKvp2WRJ5gp9yfCUY9XMze+74Eb9Qtr/qsttT13FBn3r3Yud1eIhvnjGOz7MKxzKf3IkPQ+TT/zBk6DKBnecn/IddwNq0e/4iC+iqTOFNfUM9ViTOtLH4uaGJDk2aMGzrzT5ZC5W30r8kIzHoyXPlG2ladJjfHHzQeuMPe9EkdVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOx+d8c9aYrh9hzi8IXwNKWCTiqV5zGzppl29QMx48U=;
 b=mY85nBt39xZta4JTAt3VZO++v0srtg+sKjdNWUqO1Js2+VUzl6fA/yg6/jImaU421EMpgI3BBrcGK5ABwQjk7v697YAL9FT/hkmTx8XY8jcEQ6LB+Y2V1E3aMAY9oduA0HdGAK2d18aNbEaaM4w3Zx48q03VtTXgSW7xb2QhCGXfFNOFfGtbz1Sjyi61sLxAsLt4+Y7dYxG3QxsrpfHCOBIqFQ3FAn2i+PP7z1tzffN8wxyIZjP+NepsWWlOmKHU7Fc2qX4cMWuvFukeWyPK1CU2srQbNLWuNKSbvovgEdKrmewgskXl67iTNqsnYTRS6wByIUlFULLdHJeVRt8nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOx+d8c9aYrh9hzi8IXwNKWCTiqV5zGzppl29QMx48U=;
 b=EDqL536n7mBYT/nf3o+ZXPaN4bMUAA+YsBEI934JkMhvsXjVVNJ+J2nnA0H0gkpRfBTuMIyC/+/lsUyuI6TeHYfZENzKIe7CczVz0cAP2nxdPIyg1EZwcDNDI9YMAv+92KnfYSXCbqBxERk3yGDPnIvzWLJR6ckBSWZY+W6kYzRYJvICsuOTGTazkXB2BvS7dWesS1ybEj1JNvMTYRFbV1DqaTREfQxPz8eVPWkxSiLTXpJr57xdzBtnxOqB3s/hoL0iGm3CHBSB0nVuRNLb3oAjlW3RIisYA4mPWYX/YL7xmbBLdw6BJZlPdEZB5V9v6RibvvQtEp/Jt2r/rtJQhg==
Received: from SJ0PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:33f::20)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 23:17:59 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::4e) by SJ0PR05CA0045.outlook.office365.com
 (2603:10b6:a03:33f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Thu, 10
 Sep 2026 23:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:40 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:39 -0700
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
Subject: [PATCH v4 15/15] iommu/arm-smmu-v3: Enable PRI for PCI device in arm_smmu_probe_device()
Date: Thu, 10 Sep 2026 16:17:07 -0700
Message-ID: <7bab940a52ba306f7199108987fbcc165db92c81.1789081084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: f859c82d-6c40-4ee1-d5a3-08df0f91c137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|6133799003|10067099003|22082099003|56012099006|5023799004|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	cOpfIDh9xzgLXTxFvjttgLj8r+oQHHysRJtFuMqM++RhEP8MUZHlX8Mh0TexPic2qBPAOZC+cj/1fVZYjZpHZKgSXdhzfNG8s+W9BiL7tNhEjZ5HL1spXzTu6FUh7S6ejh/YbXtTVP4quz8jmKssLmujkR2tNpxZ5OyFirbQzZEZ5ucQxgxecZD3awArFv/vfzt8+lCBU2jW+teNp7t1Y9LvzPVlAqwUgn4oMDaIx/VgpbWu6KhtbwbHKbZ8/Zx3GDaL3aiHDwXlJzEezmAKQLFKXtKZE1SVQfsnKenkcnWyWxAYmihGxb3GeFSaHdWUuQ0Hfh6jgN6lZ/XuDEO83yxg5E/CMpCfTlci4kcjSs9mOhaU9F92VyjtkaYIoFNHkyvEqPWjDDec8ebz6RHTWi0selwI6w2UjBu3bdXJB+04iiknQVT3LaTqN1ITyx6fgZNE9sSh1UnUDx+TMnujgXs7heori4MSxKn6b6rJuMPwaQ6wSrqmm6+MiXhrFRLZsm5d+gnytSALmtbFrBZQEa2ORCL3cIEncNO6dAizAhlIFdIxA8CPwy2cJ2B8Nav2Ci6HVdPOXlEv9+XILmCQL2IAFuRVghBsMh814/wThbxiqd/FRck6e2lA6XhLzzvYq72Qbw5TmiyMlUZ3So+jfW+26iHtAscXvoQklG+HMHcfXd5y1G5qKYC09kYUcAYWPdAh0i/geFTFJh4gws+sDA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(6133799003)(10067099003)(22082099003)(56012099006)(5023799004)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+u3zerVgd4PZHzBlPvej8fZuUwzFbrXsb1dmpRfsnFiazr4VcRU7V+ac90594otGjFJOIeYgOG+Xq0YbuLgh1yGcuS2WNQUPuqfgrTrku67NKXgckBBjORcjdoWZx2RhxGoXp7xQG7TH0ihdxlNjmzU3IZ2zK9k+CFnhvlSDaAY4MeGnsHEF+c2ZxAfE1KAXawrcOd/aAk2NcuqcoVyjdqMGIjq7S5c3Goe86F2OpV2z7BmNrp0pQYZK4Ps5zCVe22Vv48nCVKglur3E8ldm4q8lh0pcdryOgq/p3mnVVSBjMaprIMXyL+WFiRQJli7BMeFZuRvYkybIea8cW8zq/dJCBbmW/PeEqXj4H18OB32Xro8c0XlI6181DSDn+j0+xr6BV04Q+hIDFVAf9HUq93HeQGmwvoDwLdlgETMTelYkISAh6Uu7dJc64GiE98MK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:59.5871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f859c82d-6c40-4ee1-d5a3-08df0f91c137
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808

PRI handling is now ready. Enable PRI when probing a PCI device, and drain
the PRIQ with the EVTQ when an IOPF-enabled attachment ends. Queued fault
work may still refer to the old domain when the detach call returns.

Note that PRI is enabled at the probe time, while ATS gets toggled by the
attach/detach routines, so a master could have PRI enabled when its ATS is
disabled. PCIe (Base 6.3, Table 10-14) sets no ATS precondition on the PRI
Enable bit. Its only ordering rule is that the interface must have gotten
successfully Stopped prior to an enabling, which pci_enable_pri() already
checks using PCI_PRI_STATUS_STOPPED. Also, a PRI-enabled device would not
issue a page request until it starts to use ATS.

Set the per-device outstanding request budget to the full priq depth, same
as intel-iommu's per-device PRQ_DEPTH choice. A fixed per-device cap won't
prevent multiple PRI-capable devices from potentially exceeding the priq's
capacity; priq overflow is recoverable per the SMMUv3 spec, and it is rare
in practice.

Select PCI_PRI in Kconfig like other IOMMUs, gated on PCI so the build can
stay clean for non-PCI ARM SMMUv3 configurations.

A stalling master resolves its faults synchronously, so it has no reason at
all to issue a page request. Refuse to enable PRI on such a master, so that
page_response() can keep dispatching on the master state unambiguously.

Refuse to enable PRI as well on any master reporting num_streams != 1, as
arm_smmu_enable_iopf() rejects multi-stream masters, so IOPF cannot be set
up for them; keeping PRI enabled would let a PRI request arrive on an alias
StreamID and get a PRI_RESP_DENY issued against streams[0] by the driver's
error-response path.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/Kconfig                   |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 52 +++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index b848a4253677d..a31d04f5b031a 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -80,6 +80,7 @@ config ARM_SMMU_V3
 	select IOMMU_IO_PGTABLE_LPAE
 	select IOMMU_IOPF
 	select GENERIC_MSI_IRQ
+	select PCI_PRI if PCI
 	select IOMMUFD_DRIVER if IOMMUFD
 	help
 	  Support for implementations of the ARM System MMU architecture
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3cc2d365d2d66..104b0e008eb7f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3513,6 +3513,20 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 		}
 	}
 
+	/* Same as the eventq drain above, for the hardware priq */
+	if (master_domain->using_iopf && master->pri_enabled) {
+		timed_out |= arm_smmu_wait_for_queue_drained(
+			smmu, &smmu->priq.q, false);
+		/* Ensure pending requests have reached the IOPF queue */
+		if (!timed_out) {
+			if (smmu->priq.q.irq)
+				synchronize_irq(smmu->priq.q.irq);
+			/* Pending requests might be in the combined_irq handler */
+			if (smmu->combined_irq)
+				synchronize_irq(smmu->combined_irq);
+		}
+	}
+
 	/* Lastly, flush the fault work that the drained events queued */
 	if (master_domain->using_iopf) {
 		iopf_queue_flush_dev(master->dev);
@@ -4445,6 +4459,40 @@ static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
 	return arm_smmu_alloc_cd_tables(master);
 }
 
+static void arm_smmu_master_enable_pri(struct arm_smmu_master *master)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	struct pci_dev *pdev;
+	unsigned int reqs;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_PRI) || !smmu->evtq.iopf)
+		return;
+	if (!dev_is_pci(master->dev))
+		return;
+	pdev = to_pci_dev(master->dev);
+
+	if (!pci_pri_supported(pdev))
+		return;
+
+	/* A stalling master resolves its faults without any page request */
+	if (master->stall_enabled) {
+		pci_warn(pdev, "stall enabled, skip PRI\n");
+		return;
+	}
+
+	if (master->num_streams != 1) {
+		pci_warn(pdev, "multi-SID master, skip PRI\n");
+		return;
+	}
+
+	reqs = 1 << smmu->priq.q.llq.max_n_shift;
+
+	if (!pci_reset_pri(pdev) && !pci_enable_pri(pdev, reqs))
+		master->pri_enabled = true;
+	else
+		pci_warn(pdev, "failed to enable PRI\n");
+}
+
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int ret;
@@ -4497,6 +4545,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	if (ret)
 		goto err_disable_pasid;
 
+	arm_smmu_master_enable_pri(master);
+
 	return &smmu->iommu;
 
 err_disable_pasid:
@@ -4522,6 +4572,8 @@ static void arm_smmu_release_device(struct device *dev)
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 	}
 
+	if (master->pri_enabled)
+		pci_disable_pri(to_pci_dev(master->dev));
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 	if (arm_smmu_cdtab_allocated(&master->cd_table))
-- 
2.43.0

