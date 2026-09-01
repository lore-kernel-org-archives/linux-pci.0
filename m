Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2B367B73;
	Tue,  1 Sep 2026 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222870; cv=fail; b=tGMRO/OHlL3Q2OyYfe7C14B6GDha96SLX8sjbeeVHUWBJkLRQx8TvF4q6Yzd2tiEJ6rgm4pOExchzdIPCavlcXkM1V8nBJW3Cb9i/iR50iLGb1Vs6iyzP7l5H2PgmdqXI4C80RWN+sl8GL0eldD6a98F4VaL5IHrFCSM6rvlHI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222870; c=relaxed/simple;
	bh=Ovy8xRk/h2LWpHxFFFr1duFKN7D1/iTBtM689Lj8670=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pd8ulMIBmwnij7EAshADt5HZIYRlbqrFfQszm+mGBisaNfAMGdavaE+zoWNXMFU8dllyuhom8wCeBy7NLNGfhI8gEfbw7xHpibi4T4rjSyArOaBRk/P+zlodn87gi3RyhWdieBrpYBd3RjpqoPcE6NDTcgq2EgwLgQHWx8SInVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UjFr5zOX; arc=fail smtp.client-ip=52.101.62.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UjFr5zOX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUgpozimDEu+2gqcNnDUoAmtAwLftgLqPdmq2vUCFYVwLa7+eIJuf0TbyGxe9xsNDmCYemdGzUXKk1jifOjElvmhW+JDvji1BQUQFRlIIdoq/4S7/q+n13RCh/rUEg6Cc/ur4fJzvaj5IO1CD875pkg9aoeB1es0PLovgwUG7acG9QTC078lelEQ5yD6CCiZKpf7xLNLQBpK0sbWANHzL9richShVyFfQ61aHmWnvAbhDdjKU7xfYoYrFt1x7MKWPQMAIwO+9kc5XtsG5DWbQ/9emcthBkYuNsarbRVtM1MJvfXiixvdLBi4EKv8o91t5vPQ6pOCS8ZYcMT1bZC+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA0uujvRrMF7pf28GdhKo5X9jCtXs4/3Wv+WN9Q21LY=;
 b=il8MD7gmmOZYixiDxB8bPZfQB1fGoLsTZznaPyDpOUdHXyoMeomqK3dfq1q9JlTV+hvF6whzEm788S9acmnKnTDAMtxFGB6dPHRFu0zFlJLbGb6NuMPtJyS/ruW5Q0lUZTfebXopPy9rbSzH28j2r9Si4nElqTEfbmawLzH6YeqqoNhAV6Mwl0vtIKlc8uiH7YF1T8VVj5X/pQNpJrT9Cq0yd7d80DhoKHU4l9e1K5HAwIQcWBSu/+6iAP6DIzmy6kpPxaaBqHiBm1jEXW+CGYQaHonh3Ph8k9LDpdu7f9nr1TiHl6eXMx87uZmtD0+qMGl79V2LGHhb9o5Xhi8uag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA0uujvRrMF7pf28GdhKo5X9jCtXs4/3Wv+WN9Q21LY=;
 b=UjFr5zOXxsxQRjr+CkLyMW9+ektEmUhZP8z/z74d2g/DtBvYcZzvFYoGA9GMeb4bVnUXjuUOihtIFSqkpbAKs/bUjeP5/Owpkn6VQgs9IizflW2Fnu8EkM6OzmO3qGGmDNBJD3gmIkZuv5iVFAO5SKTzFDwmWo1E5sclPuUaNkCQoYttuUsAN0+Zfv8XwB4U9OWVeCM0FoNxJUoe4yZ0Sk6JU3uJghkfK+TsfHDm8+UMQa1jQJNuGsr8EKlYdTTq2Ucal8aAbNHfKWR84EpoqALZ6vD8YPPNo1adZN3aQ8DKuThG1rrVTme0VqvlEa2ox3RMlZE73R3tzwuQq0+bHg==
Received: from BYAPR21CA0021.namprd21.prod.outlook.com (2603:10b6:a03:114::31)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:34:21 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::2c) by BYAPR21CA0021.outlook.office365.com
 (2603:10b6:a03:114::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 00:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 00:34:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 17:34:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v3 03/13] iommu/arm-smmu-v3: Drain in-flight fault events on domain detach
Date: Mon, 31 Aug 2026 17:33:28 -0700
Message-ID: <8717f3329313f40308cff20006066283ebbb3a56.1788222485.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c04d9f-9e52-4f5a-b97f-08df07c0c43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|6133799003|18002099003|22082099003|11063799006|5023799004|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	sh1eLVDj1fa12dtoN3xhttq1VT2/WOIn0Db/TyZ4ZccYqLIaIWy9g7+ohnPOOqxwQbJmvpacjYXrb0YyzxHdTC+1P7SbjkIlrJ2m4HQVRg4vVy41U+H3K9nt0JkNhEAH6nvGeZpRWxdtIvQtCmwDhSM8koSi/F5wOr99kF7dBvOcmYCCbKiloK10J11gvQbP4wfnKzAgZsswGtugbbWKDMlZWaRmtCr501bd11M7nbkhhTsPgC481I2rnSPyKgVphbYUanZbKr3W5MEFCE90ZyGwEe8eRSYxZPkcOt276JKW2kZtbWJsAreunF1iSxXmzzw7jKz/jkp9blZgzwzzNdnSeX31/qiDo0GZN9wyqvDea3hvIlDdaUM1AdVUFHnKhtiUhnq5O1yqq8xVZWG9DPSjKIj1FOeYEihllAdNwAK2yJgbDW5mSqBubvgBVH4M1tZOY9CLt2q3vtoSsdTI0ccMOKVwmif39ti6QkLrlvBoyUuy/0jQR9Pubb0Rg21LISuH56zEGZ+2rftlRCiE43MyTuG5Pg05DAn/9oY7XAifq0IWwzkhR1w9Nc2hSny04mJh+TmUvSCm7Kc+cNqm3c2zCB4ejtiouz8I9A8V4bvd3qNexUdj3iDse4ZtqUjfKZVi8ya5HglXLKAPmmHt2Vhk5LZQBTzzDmsp4vtRLonPBLPZUrud2Xfxwl0KQVZzUVpfxzvRoVekFyvLw8Ostg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3e/vfpEtAYlh1PtApxGDw3RYtR18MuuuWK4JFeeOGhGu2BcOs2GAP3CpQ7o7gqEkpoX9VCevslOSzxhQYDnfK+BenGH19Lqp+yq3KjD9nbxqNumu3dDZQHGN8Dwo/8Y86K4diwDp8oyRw0JK7sXWFZVIPnPpYDcagFrJ9NYQjdKO05RKXrjglV7taXXMS2HF02c1i7djbJGEz4P44Ul+XMLeyTQCHJT3rQFmYQRUrJvVxgNia1jZlRhFt4KVJ9zGnRoL6g9q8AYAt/zEdVbV+4y0fLZ/a5yySBGBOiEoPA/Fj5LtWDYEarNSwQknpwWX6ZqKgF2z2ncSIup8FCnUQeEfSZgCJxHc91WRD9iFjU9+d1Cj5cGXMWvPzdT/KRJ9iNzivvhg2RwTi7XMd8GFRhTK3XZDbnQ49N5/KdJ5UdboDMFY5MNP20uE4gOgmJ6C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:34:21.6222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c04d9f-9e52-4f5a-b97f-08df07c0c43f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363

When a device is switching away from a domain, either through a detach or a
replace operation, in-flight stall events for the old domain might still be
on the SMMU's hardware event queue or on the IOMMU core's IOPF queue. Thus,
if the IOMMU core swaps the device's attach_handle and frees the old domain
before those handlers complete, the IOPF work might hit use-after-free.

Two queues need to be drained: the SMMU hardware event queue and the IOMMU
core IOPF software workqueue. Start with the former: add a counting-based
arm_smmu_drain_queue() helper, and poll the evtq on a domain detach, so a
pending IRQ won't let the threaded handler run after the drain and queue a
fault referencing the domain being freed. Its until_empty mode serves the
suspend and runtime PM routines that would drain the CMDQ. Any timed-out
drain fires a WARN_ON as well, since reaching the timeout would take some
stuck consumer in any realistic case.

The existing queue_poll() API is not reusable for such a drain: it is the
atomic busy-wait for the command issuing paths, and it assumes a hardware
consumer making progress. A drain caller is sleepable, in contrast, while
the EVTQ/PRIQ consumer is a threaded IRQ handler that needs the CPU: such
a busy wait would starve the handler throughout an entire timeout, whenever
the waiter and the handler shared one CPU on a non-preemptible kernel. So,
this new sleeping helper is marked with a might_sleep() as well, given that
an atomic-context misuse would otherwise hide behind an empty queue.

Note that a drained event is dequeued, but not necessarily handled, since
queue_remove_raw() moves the MMIO CONS before the threaded IRQ handler gets
to push the event onto the IOPF workqueue. A subsequent change will invoke
synchronize_irq() and iopf_queue_flush_dev() to close that gap, and it will
act on the errno of a timed-out drain too.

The drain runs before the IOMMU core swaps the device's attach handle, so a
fault event generated on the new STE during this window resolves to the old
handle, completing with IOMMU_PAGE_RESP_INVALID that resumes the stall with
abort: the impact is bounded to that one failed transaction.

Also run the drain for every stall-capable master, even when the departing
attachment did not enable IOPF: such a stall event has to be aborted while
it still resolves to the old attach handle, otherwise the threaded handler
could pick it up right after the handle swap, mistakenly resuming it as if
it were a valid page fault against a new domain.

Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
Cc: stable@vger.kernel.org # v6.16
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 92 +++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e00b6c88214f5..d255ff2519f9d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -948,6 +948,86 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
+/**
+ * arm_smmu_drain_queue - Drain an SMMU queue
+ * @smmu: the SMMU device
+ * @q: the queue to drain
+ * @until_empty: target selection
+ *
+ * With @until_empty == true (for CMDQ), exit once the queue is observed empty:
+ *
+ *   cons0                cons                                prod
+ *     |                   |                                   |
+ *  ---+###################+=====================+=============+--->
+ *                         |<--------- undrained==0? --------->|
+ *
+ * With @until_empty == false (for EVTQ/PRIQ), exit once "drained" reaches its
+ * target: "pending" (i.e. prod0 - cons0, frozen at the entry time):
+ *
+ *   cons0                cons                 prod0         (prod)
+ *     |<---- drained ---->|                     |             |
+ *  ---+###################+=====================+=============+--->
+ *     |<--------------- pending --------------->|
+ *
+ * Note that a drained entry is dequeued, but not necessarily handled: the
+ * EVTQ/PRIQ callers must follow up with a synchronize_irq() to wait for the
+ * threaded IRQ handler to finish handling the dequeued entries.
+ *
+ * Context: Process context; may sleep.
+ * Return: 0 on success or a negative errno on timeout.
+ */
+static int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
+				struct arm_smmu_queue *q, bool until_empty)
+{
+	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
+	u32 cons, prod, prev, undrained;
+	u32 drained = 0, pending;
+
+	might_sleep();
+
+	cons = readl_relaxed(q->cons_reg);
+	prod = readl_relaxed(q->prod_reg);
+	/* The exit target: the number of entries in the queue at entry */
+	pending = Q_POS(&q->llq, prod - cons);
+
+	while (true) {
+		/* Accumulate the entries consumed since the last poll */
+		prev = cons;
+		cons = readl_relaxed(q->cons_reg);
+		drained += Q_POS(&q->llq, cons - prev);
+
+		prod = readl_relaxed(q->prod_reg);
+		undrained = Q_POS(&q->llq, prod - cons);
+
+		/* Exit on an empty queue, regardless of until_empty */
+		if (!undrained)
+			return 0;
+
+		/* Snapshot mode: exit once the pending entries are drained */
+		if (!until_empty && drained >= pending)
+			return 0;
+
+		/*
+		 * A timeout means the consumer might be stuck. In theory, if it
+		 * moves 2 * qsize entries or more within a single poll interval
+		 * Q_POS() would wrap and undercount drained: that could trigger
+		 * a spurious warning too, if the queue was never once observed
+		 * empty. Yet, that much consumption in such a short interval is
+		 * unrealistic. WARN it only, as a stuck consumer is a real bug.
+		 */
+		if (WARN_ON(ktime_compare(ktime_get(), timeout) > 0))
+			break;
+
+		/* The consumer might be a threaded IRQ handler. Yield to it */
+		usleep_range(100, 200);
+	}
+
+	dev_warn_ratelimited(smmu->dev,
+			     "queue drain timed out at prod=0x%x cons=0x%x\n",
+			     prod, cons);
+	return -ETIMEDOUT;
+}
+
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
 				   struct iommu_page_response *resp)
 {
@@ -3318,11 +3398,23 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 {
 	struct arm_smmu_master_domain *master_domain = state->old_master_domain;
 	struct arm_smmu_master *master = state->master;
+	struct arm_smmu_device *smmu = master->smmu;
 
+	lockdep_assert_not_held(&arm_smmu_asid_lock);
 	iommu_group_mutex_assert(master->dev);
 
 	if (!master_domain)
 		return;
+
+	/*
+	 * Drain the hardware eventq, while stale events still resolve to the
+	 * old attach handle. Otherwise, the threaded handler could pick one
+	 * up once the IOMMU core swaps the handle, mistakenly resuming it
+	 * against the next domain.
+	 */
+	if (master->stall_enabled)
+		arm_smmu_drain_queue(smmu, &smmu->evtq.q, false);
+
 	arm_smmu_disable_iopf(master, master_domain);
 	kfree(master_domain);
 	state->old_master_domain = NULL;
-- 
2.43.0

