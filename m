Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5EA4AF16C;
	Tue, 15 Sep 2026 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490359; cv=fail; b=nsKx4aNhkolqcbwUl11QssNURQAqVHN9fcGt1xYfzzD+yLDSvlnHl+a26N1EbguE9mbd52zqw/EKh4o+1toh2cEA9o87K2Fbj5Lldx/UyDzHoqS9PVCrUhlQW9duWx2bpCeujNn6NUbVuoZ1mv+ZckC/WoJdLCgGo5un3abx1ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490359; c=relaxed/simple;
	bh=qWcZKu/AsFR+rGUV2mLLnzSgHjRkDaqMyEJ9QRbk1ys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7C1oSXjifumyQvOiN9AaTOzMN3LrmCMK/RRrYquoYHXcNKzuCwYwhp1wLfGj6xKghku4m/AzXi6SAUkAXQ4KqR7NBPDBomaEuGua6tlAN8LJiDi/YInNI0xl1hG92LAnzrd7AK3V1Jy0sB35ktO5lpXrgFUQjFTWfjd9dpDcjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i8N1ybs5; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i8N1ybs5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+K2WyySU17h/PHYguf+MhNKgScfUdW1F+QHhBXSSRMAKAKl8zMQ/Ko/lFad2jn24ublXe1q7sLfeATzqhLyowCAw2N8z6DLefVula4/5weJ5ZvL6NJ351nV5GGhGklVYfrFcYfDcgH6a7q5QioXuyhCXSro9Rj/2sA0aKAx51IoOZhU51LMgCwCXkkx03PqSb+Wcvh4tYVXlNZmLFUYV6K+3HRs80WXc62ciCkxnrVxD4eVXmvalOv3Iz9UQS60qbiCSVyQF3PRgeIpqq/QZm7myIP4k6DOXf9BaPpujPJTqnvjjkZ3v++yAEB/2/Mmv2/qa7POsLh5KeAPUWkhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0eu18qlquM9qr6OxOQPs210MZqNEDwN72B+Ur7q8kQ=;
 b=SxrxTWEc0Pi/BYTXJqkKLpOKJD19tqOT+3QqB4ZARIqU6kqlo7YV10U9jNiCuknRQuesjPBJDpB52EshnjHT33GWZ2h4Kdrs4zIRFUIbGfiHtOZEbICbpeMkXlffcHf5w43s7T6/6KTho47prRGxx0kNU+RKWDCo32YX3roAhd6/PFrQonkS6ce5TKbLjk2cMn06pfSI4RuzkuSi1yerc8ker0d0VzxgJFpRflFqYjF+xnDw5TSx80mnILvpeEPMVJULvt8Emc8ny9EHw1hgkDPjiylqTYo05tl7oBU9hJD2i3KpgScGwBfggzqrxXPIMvsTWCOBFXWQ2nFH89aA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0eu18qlquM9qr6OxOQPs210MZqNEDwN72B+Ur7q8kQ=;
 b=i8N1ybs5Z0KZeJ5snLu9OhS7hsxGHVcncNO8kPlJPjFYZOvoVMpz/XTr9yx8QDxYUJD9rrZ96FkM6CyAwxvsHejdtDIvbqsNOeXnAXskCIOyGQQecnwf30vUb/GAPyWirZn04RaVuzQtchfX1JgTN2lMBK6NVvGNjNjA26jAM7o2nvP1zAZsnAPwqOaT5yeLbcfdkThV5X0Kk1b07/ctmdsvF3eK5fg2IYYFCfoDblFvxWDbiErJrZ2yIN7R/steYhby8hjU+r11v1i6w74NDicO4IiRuJadPVWdZu4VSxHvatqGbX3KuAU+NuOWWmQvBISxvIa+oqjUMYg4kSg51w==
Received: from CH0PR04CA0070.namprd04.prod.outlook.com (2603:10b6:610:74::15)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 16:39:11 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::5d) by CH0PR04CA0070.outlook.office365.com
 (2603:10b6:610:74::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 16:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 09:38:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:38 -0700
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
Subject: [PATCH v5 05/15] iommu/arm-smmu-v3: Flush in-flight fault work on domain detach
Date: Tue, 15 Sep 2026 09:38:17 -0700
Message-ID: <9692efc467c4dff1de7ad58bfce087ad0d263bd9.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 17bd6832-8dc1-44dc-14a4-08df1347de9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|7416014|376014|56012099006|11063799006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QDsTuFkR/lzyBjS574Fk8+jbnHiYpoMS8qn+J13MAf1L1onDWp7zJWJCbWkf4M7OgcNWzQDLiOOp58VA5dljC+7K3U9ot2TVAMtQ6tIPFDmMIl1RAp7ANLbAe+xwkggWqM38NUKJ2L4TqgS70SprQz55gngde5IyNQTE3h0hyoG1iqhqocZAhUzHWmk3B/o0fST3NmFUxw0ygdu9NcQ8+Fpq3P2fJ840Pw9v1L84/0QFIBT0L0ZewMiwaFMm5d6NIYBOpSs7fFNHz3FeSFdrHZ0/1Kxsrr6drr/jr9sU2zA48T8mDa5ZaYrYeJ7LXBxIGL6wmXTiQ1b9vjWJrGaarhpB7th8S6miIrcfn97ynTT0jX7NLqg9y8/TLzlFdTXkF3Thbk2TjblWVZ3/XpMS0IW0tkoMdiZcst90yUUdvtCMV551KqUy7R46+OJVSQa/JqRFjHLX+FJFr7tjILd3oLPzRKSHc7CQH4z2WluVALAjOzrkGwgiC/RZluwfSKMl8LJuQM8T/jR5KW2o9O59UR2cX/AJ9/PpLUZRVmR8b9YT+i37H1IBRyoKeMH0MiiyILEsTriu4DBl62bhgEdONgeK0Vo7elPr1S0wX0/w8+4JKee0YiFUIeEMrd4swgGhcOrdpNENJ2mKeWPvoXUdnS07Phul/6eEYzixP77kUd8TkPiGlgcIpxoLrD0zW3f/iPwzAq+2nYrqS5+JnBkMoQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OBECK6cmqoaAP0bNSPtqdnAt+wM3mzwhe7eE+RUvVCF4msVhEG2+QZ3GMl3OjAVh9fmy6OGRFCDkKZEh+G0kmp0BzopfFsxgtvzfOzQfSuCQTF2mpNBn7417XLcF7IV/JCRIdcFhRgvvQGBpcLylwyTlz7LQ3us0KbSqxOhDck2aFKJQbFvdSACy4Vbgq4PSzOLg26gjW88GdPeQnKGo5s+FzqvZ1NfHhbFpvBJm3ufgaepa89yrG8B5HcgrdmnSYcy8F139AFloCK+bbwneykUHox/cqkZarxCuFmZSnNmh3l9LPXwS1MpuebzH9VqLiQhJh/oD/45M+3J5kLKwuRq8ljN3SSEAZHyqUL0bA7qRVPl/BfKYoz/hs1x95jdjBF2JVeVe4cMyu6Az+Zykw7G12JtDG3JUbWv60nQcJs6zXVxiFIrB+1E+Do7X671g
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:10.6334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bd6832-8dc1-44dc-14a4-08df1347de9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

After the hardware queue is drained, an event may still be moving from the
IRQ thread to the IOPF workqueue, while earlier IOPF work is still running.

Synchronize the EVTQ and combined IRQs, then call iopf_queue_flush_dev().
This finishes all old-domain work before the IOMMU core frees the domain.
Skip synchronize_irq() after a drain timeout because a stuck consumer can
otherwise leave it waiting forever.

If arm_smmu_wait_for_queue_drained() times out, fault work may still be in
flight, and iopf_queue_remove_device() would free iopf groups that the work
also references. Skip the iopf teardown and leak the master_domain, rather
than risk a use-after-free.

The skip also leaks the iopf refcount, keeping the device enrolled on the
IOPF queue, which would strand its fault parameter on the queue list once
the device teardown frees dev->iommu, crashing a later iopf_queue_free().
Reclaim the enrollment in arm_smmu_release_device(), where all the attach
handles are gone so a straggler report cannot queue a new fault group.

Note that a residual race window remains between an iopf_queue_flush_dev()
and iopf_queue_remove_device(): a fault arriving in between still resolves
to the old attach handle, as the IOMMU core publishes a handle change only
after the driver ops return. This window predates the drain narrowing it,
and is only closable by an ordering fix in the IOMMU core. Furthermore, a
timed-out drain shares exactly the same window, given that it must keep the
device enrolled on the IOPF queue, where iopf_queue_remove_device() would
free the iopf groups that any in-flight fault work still references.

Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
Cc: stable@vger.kernel.org # v6.16
Co-developed-by: Barak Biber <bbiber@nvidia.com>
Signed-off-by: Barak Biber <bbiber@nvidia.com>
Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 46 +++++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9e657d075f387..c8fb1c38090d1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3410,6 +3410,7 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 	struct arm_smmu_master_domain *master_domain = state->old_master_domain;
 	struct arm_smmu_master *master = state->master;
 	struct arm_smmu_device *smmu = master->smmu;
+	bool timed_out = false;
 
 	lockdep_assert_not_held(&arm_smmu_asid_lock);
 	iommu_group_mutex_assert(master->dev);
@@ -3422,8 +3423,38 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 	 * which the IOMMU core might free once this returns. Drain the hardware
 	 * eventq, so that a pending event cannot turn into new fault work.
 	 */
-	if (master_domain->using_iopf && master->stall_enabled)
-		arm_smmu_wait_for_queue_drained(smmu, &smmu->evtq.q, false);
+	if (master_domain->using_iopf && master->stall_enabled) {
+		timed_out = arm_smmu_wait_for_queue_drained(smmu, &smmu->evtq.q,
+							    false);
+		/*
+		 * Ensure pending events have reached the IOPF queue, unless
+		 * the drain timed out: a stuck consumer would also block an
+		 * unbounded wait_event() inside the synchronize_irq().
+		 */
+		if (!timed_out) {
+			if (smmu->evtq.q.irq)
+				synchronize_irq(smmu->evtq.q.irq);
+			/* Pending events might be in the combined_irq handler */
+			if (smmu->combined_irq)
+				synchronize_irq(smmu->combined_irq);
+		}
+	}
+
+	/* Lastly, flush the fault work that the drained events queued */
+	if (master_domain->using_iopf) {
+		iopf_queue_flush_dev(master->dev);
+
+		/*
+		 * A timed-out drain may leave fault work in flight, and
+		 * iopf_queue_remove_device() would free iopf groups that
+		 * such work still references. Skip the iopf teardown and
+		 * leak master_domain, rather than risk a UAF.
+		 */
+		if (WARN_ON(timed_out)) {
+			state->old_master_domain = NULL;
+			return;
+		}
+	}
 
 	arm_smmu_disable_iopf(master, master_domain);
 	kfree(master_domain);
@@ -4407,7 +4438,16 @@ static void arm_smmu_release_device(struct device *dev)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
-	WARN_ON(master->iopf_refcount);
+	/*
+	 * A timed-out drain in arm_smmu_attach_release() leaks the refcount,
+	 * keeping the device on the IOPF queue. Reclaim it here, since every
+	 * attach handle is gone: a straggler fault can no longer queue a new
+	 * fault group, so the queue turns stable once flushed.
+	 */
+	if (WARN_ON(master->iopf_refcount)) {
+		iopf_queue_flush_dev(dev);
+		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+	}
 
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
-- 
2.43.0

