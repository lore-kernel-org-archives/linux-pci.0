Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF8362120;
	Tue,  1 Sep 2026 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222871; cv=fail; b=aja9VedzzzlskaicZDyhhTU7AxmhuzqCIJDrlls5rAuLgv9Z3eV/zTleYH6us/f06W8Zl6p65ItjBRFK6xzqcWkSxkmfF53rlPjJJrizkWngV90PDyXZOduV2TwZyFiMcPHAYK+cGpo2O+KrOGIWj5MKQf5+XUVrz+DV7AhMLNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222871; c=relaxed/simple;
	bh=4QSE2Nyy6PxHImrUVWNgdWnJwtJuGI39OkZNG1n8VjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgyySjDcmpPBybcaGmsarmB1g0adY8RnikqR9SpNMq26r6yXtDymtaN2B1Cnl2WpchuoNFiDMuatssh1uSAVnzJZgxalhF8I3RfUYsjZtm7bQF8GgtQLTA+QqdDUkX+DCaGf3wGmkyiZPHPijDeEMuGELh/NIg3znTN2l4PuM+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YIBQHAa0; arc=fail smtp.client-ip=40.107.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YIBQHAa0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X18ZasLQ0n6yczj3ZQrQcu14o2cRWYs/yRha2khBNXlVLWehKvaXW+nuXl98R3hqkDZdsRNGYqdRImrAKP6/Qw07A87WCG8dx26pHXYfe6MDYC+HJZspHdRBlsheLHvVkRaxU252CLMWufxk2iiDe1f3J+Ix9so//VSDlFNFL0MH+1OI6X3fl1pZREcFCSxX9PzXTk1kM7jLGncqTMd7iggsdKOfFIc+wA4EX2b2fZwCqmzI9NgIBzPzRPieGKn5+ix54hAKNkWIecH8cl7cSAbbh3Byf/m6F5iSnacITjcyDJrrLPWKh2dRkC0i71CEorzY3WUNAEX67lszpwHOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKi2h9fQq6glmYu6hIBoR7Iwn/e3kX9/6py2fyekxlI=;
 b=lORqi0UEXMzT0yNheGeX5Vzpats/o3WUbqf8QurHnRbnV/wXNjje9eRj03q6a2MSU0+I/Is8HNvzrLUQtjL+hvR8gUYccSPjHM0yCwtyn7BZcyg33pgaYU3pdeeVKPdMCrZc1uKrJmOSx4zgtlnyjxPMY2/MgCTof0Cudt6yoEiMFHDR4DWlZFcPB7kTTpWqG4Gna/zhiAnh+rU72cOS4DhDwm7HDkUKPY+VxKY9+fZotDcGJZ/Ln560yE5hHk+C5dTMJ4a414vPp8OLBsQcftZRd0+/GdGY3Tjjw6Ys8G0vmjOolvjaOVjMFSonmUwmCMxfAlOVG9S1E1l3/acE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKi2h9fQq6glmYu6hIBoR7Iwn/e3kX9/6py2fyekxlI=;
 b=YIBQHAa0HgB6d6TJSHICk+tK6+rwi9/7VPAtE0u0zeTz45paxp6iInj1jyHGTSdOdwrr3PuCAyV53C5PXZDdrf+ZseugYj4XO5UHfJy4sDtrPTzPrkyn/z2n+8D+oPeTxh5+grOg2DUIYgbnHhoWwfEDUFYUxdp4m/SnJzqp3Wqhf3i0lY10fWuR865rYuGBdZHQQ5DwRCdN67/HthPi77svZzRk+RoTAsppU3thqMcrJ2j8f1I9waCgSd2T8Ayjh52N/J60EhxyluZrajmL94MmNLCH75dZJDVhYoS/JfKag8UZiTXGA6oVUO8kWOeSjZprgemgOQNkghuId0Y++g==
Received: from BYAPR21CA0006.namprd21.prod.outlook.com (2603:10b6:a03:114::16)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:34:23 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::35) by BYAPR21CA0006.outlook.office365.com
 (2603:10b6:a03:114::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 00:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 00:34:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 17:34:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v3 04/13] iommu/arm-smmu-v3: Flush in-flight fault work on domain detach
Date: Mon, 31 Aug 2026 17:33:29 -0700
Message-ID: <45b6e8c6dab5b67a91ba54c32bf11ab3347d80f5.1788222485.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b7d1db-cda3-4909-c8ce-08df07c0c500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|23010399003|36860700016|10067099003|6133799003|18002099003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	CrZaMd9g8Lhhh6gb8iMA+ln9bc7LYNB56knm267tFda0kGWxZHUGiEGImWDszBnJCObTSOdbVE+4AKWscZ7bd+kPf0rTEBLyHyfePpkj5mr2X2IA/Cw/JsN36tw6jyLdPrYdvbdbc6114FD55f1/ygU9APCMdFuTHhTLMOjL1Ch5yojOZ/Yk/F4AVkMHivTXZmPYuulWWi6iUqBDzHi5J9M8pq7advEAw9Ax0WbioCVSNrq6GMJODM6piHNh+c2lDDn6nOMoGso1LvoKo5BBzkcRtJYMYvNHosV9SBhq51ma/KedQaRClSxIROGEkfafF2Mry8FRIaXssQ3uLVnGSQbNSdOaD+KZ2P2CnoSMw2bb1bbBzO4frdN6l7SSy3UHOT5QLMhLQi3NLPyFgHw5QBJ8tVA7IC8SFeuXqVkJJuOsMlyeAwRnBv1V4viDZ3J9qMfzwcuRMN5x9mqoJPWFkt/+A3HvljMqA68dE+UOb3NCb1CtfdNrCJTOgIZANHDsjjvO3BhrjasXTZdUpCSj+DLpzuYM4URq+EsikMuEDBLSorNt79sSUhHufdzEXw6k3kNuO8bnbF94g2XQNsRMvIbZGO5SZma+lQP7uA5TROkbF7oD6UHzevoT1PtKwdLs/jRadz5Ts9UOuZR9yZAXgxDj37qeNiiC8iQLuXS/mGnjhsf5mZq0BFEHOCl5eEFHvSVrBPeddSXTtCPEgquWMw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(23010399003)(36860700016)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UAwZAaXu2JmP545ysNXhBjPou0Ccf9B3dg4QiHmSxQGHgid+d0DXSTzHDMXBGqU+LM1C6mmZ6HUIIr7+a2BHjF8WY0FEu2/L0JcYJVNMNwGLDXoz5qzSAQAGAA52FBEVC3kaJI2L9GSABhs/1Xg7b++HAVzb7wbqBnmcUG29hyzl3C+MtC85H892yMdmNjGGcn1gTGHBsdLdOEG0a0C12cxZ8c6zto64Wu6NDfMRiyQesVBWGv7oi5bRhvXdkBI1eghj9CBD0/yo0eSG8kHuHi4tlhz7BOdPytHAiMFLmPG5k6siw/UTx55rMbh43GPr+qopY1sjWB3C3eEjIf53Gy9YQ3y0YOSQCx5EC2N04OhyABDF61C42OSSZVJZelBSueveoO51ZTV/+lW2eoMxrMYE2igcHNSrxdsHyIY7Mi3wnaAbESzBCCXjYnHJ7yV4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:34:22.8815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b7d1db-cda3-4909-c8ce-08df07c0c500
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

arm_smmu_attach_release() polls the hardware event queue to drain all the
in-flight stall events for an old domain that the IOMMU core might free at
any moment. However, a drained event is dequeued, yet it is not necessarily
handled, and the IOPF work for a handled one can still be running.

So, first synchronize_irq() on the evtq and the combined IRQs following the
drain, in order to guarantee that every dequeued event has reached the IOPF
workqueue, since synchronize_irq() waits for an in-flight IRQ thread. Skip
the waits on a timed-out drain though, since a stuck consumer would block
the unbounded wait_event() inside synchronize_irq() as well.

Then, invoke iopf_queue_flush_dev() to finally drain the IOPF workqueue, as
the fault work references the old domain via its attach handle, while the
IOMMU core might free that old domain once the detach call returns.

If arm_smmu_drain_queue() times out, fault work may still be in flight, and
iopf_queue_remove_device() would free iopf groups that the queued work also
references. Skip the iopf teardown and leak the master_domain, rather than
risk a use-after-free.

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
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 48 +++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d255ff2519f9d..1851ee7ec15b9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3399,6 +3399,7 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 	struct arm_smmu_master_domain *master_domain = state->old_master_domain;
 	struct arm_smmu_master *master = state->master;
 	struct arm_smmu_device *smmu = master->smmu;
+	int ret = 0;
 
 	lockdep_assert_not_held(&arm_smmu_asid_lock);
 	iommu_group_mutex_assert(master->dev);
@@ -3412,8 +3413,40 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 	 * up once the IOMMU core swaps the handle, mistakenly resuming it
 	 * against the next domain.
 	 */
-	if (master->stall_enabled)
-		arm_smmu_drain_queue(smmu, &smmu->evtq.q, false);
+	if (master->stall_enabled) {
+		ret = arm_smmu_drain_queue(smmu, &smmu->evtq.q, false);
+		/*
+		 * Ensure pending events have reached the IOPF queue, unless
+		 * the drain timed out: a stuck consumer would also block an
+		 * unbounded wait_event() inside the synchronize_irq().
+		 */
+		if (!ret && smmu->evtq.q.irq)
+			synchronize_irq(smmu->evtq.q.irq);
+		/* Pending events might be in the combined_irq handler */
+		if (!ret && smmu->combined_irq)
+			synchronize_irq(smmu->combined_irq);
+	}
+
+	/*
+	 * Only IOPF-enabled attachments queue fault work, and such work
+	 * references the old domain via its attach handle. Flush it, as
+	 * the IOMMU core might free the old domain once this returns.
+	 */
+	if (master_domain->using_iopf) {
+		/* Lastly, drain the IOPF queue */
+		iopf_queue_flush_dev(master->dev);
+
+		/*
+		 * A timed-out drain may leave fault work in flight, and
+		 * iopf_queue_remove_device() would free iopf groups that
+		 * such work still references. Skip the iopf teardown and
+		 * leak master_domain, rather than risk a UAF.
+		 */
+		if (WARN_ON(ret)) {
+			state->old_master_domain = NULL;
+			return;
+		}
+	}
 
 	arm_smmu_disable_iopf(master, master_domain);
 	kfree(master_domain);
@@ -4397,7 +4430,16 @@ static void arm_smmu_release_device(struct device *dev)
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

