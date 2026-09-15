Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F023E49F8;
	Tue, 15 Sep 2026 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490357; cv=fail; b=qV5UbJSd+Oa3cF6yAM3KJryu+0l7J+eSQw+XU5kHZZxdlF1jyDKdMBfVP190K97p+vyV7c2Ljw2opOxsbFgwjyE1caQ9igwzv1EH0cYx349/mYpHQIUA6cMGrCoKowNbYcv/ay0rBZPF+He4Notz3KAiUPP5hbkgDU5UZeHUPvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490357; c=relaxed/simple;
	bh=0iBcnz4SCH20pnHC5S7KT9cqPcYTnNbgsUzWoDMKnsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBCOjDUIowY7b+AC4w9TDvHQupciwfkf1amRNBGY2X1e5GKBOY+OTiv6Iic1c79W3eL4d/CbdpZtlk0lSxg7BN7/Ix5n5Eu85x665bMcQixtLhMFiPHgItSccV8K+WrqsHeZx4tpeGA6G8Mj6YXL10iy7UJ9dRnU7KIO2nXL3tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZdUB8XrW; arc=fail smtp.client-ip=52.101.61.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZdUB8XrW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQyLMg2I4pmBtkzxtZP44UmDLrpLxl4qKU1/GH1ZOuA5zzrAFr9mhYy6VEkJ4o0rMew2TuEwMmOG+aJKYUUHLn32dR7EcGVzKJbMPifsHwC//FPDpxTDYczFpYjoDOAnHu6dYu2L3kpm4HMKmwuPLnz1uJpYT59zrJjQ5MxLuoIjkirfbfGxBInkHrIHDdZFmO4wjjsu5VAcOScfLlJtI5LDVZ+m/vifDdEUxQX7wRpJTT0oSLdCxN5NhOL5NwHzqrKl4nh40xcd9rsg7ClWLf8bN3MnvUrZtvoAplsnt/gii/OietCbFP2B7vZoBknj0kGMEiuzIK8ZTLYT2srWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2vsnlqz70V/yrfRJ3ViBCXJA+3R9wGOl4e96Jnbrpw=;
 b=q9QQTDN/qpInS4Crisb26tb+n/gM7DzMDCTqPmN03i7JJGtYJkqxUOcDxKBz+U9JuduLyjKJ/NTLKVF9JSP6RFcwSH7EXdiepJgoFknI3WLrmMuAa2fqZrsLRU1eIVDerv9hwzcPH0w8i5wwj4bQdkfcR1P5FUD3G5AI0A6dWEGXTMu0fyzBOqmT8fAlaJl7f69V+h2ncpJbeIeRcOqaQcG9gsK+wSybGR90YCf+cr+vDhtJRJkZJBVzo386Azp97+LSHSZ1s3A0AZptyWIvoPCfG4AiywXwBMnqDc+12J8cXaQ7O0t9TgPPU2ZjuKCyg4ARtqWh8/snXZ+NcX3HGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2vsnlqz70V/yrfRJ3ViBCXJA+3R9wGOl4e96Jnbrpw=;
 b=ZdUB8XrWctW1/binWiRRKY+JPhoAPqJlo++wotkUBNJtwPUoLDLghZMxYC3zF3rVsNjd8zbxo7MEK7IGXqeghBkqcq8c2G37MMGvDHV4Pf5TcZH5m2vKzaZGejQCzXSP6sMEmk/I9V5dZ76wr9GsZxBI5pZyzTPWFgtPgn8llhDmfJceGVQOUlu6MigsMHH217SiaShBv4HFWU46e7R8R95Q1NpprFKm86NNAjCCx4SSAN1BW9eb0S/QjdP2KYycLqG5W/JIcrMv/G/Nt0ATos8gnk6QAEB6Hau3tLAQBy89ImbknaYrDEgT5WUo/N2325bnSgr5ppajvpejTM+r7w==
Received: from CH0PR04CA0075.namprd04.prod.outlook.com (2603:10b6:610:74::20)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 16:39:11 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::38) by CH0PR04CA0075.outlook.office365.com
 (2603:10b6:610:74::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 16:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 09:38:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:37 -0700
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
Subject: [PATCH v5 04/15] iommu/arm-smmu-v3: Drain in-flight fault events on domain detach
Date: Tue, 15 Sep 2026 09:38:16 -0700
Message-ID: <cc7eabdd07e7705c84e30b04c85271d4ddf66055.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ad45e1-2301-443b-215b-08df1347ddd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|23010399003|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	sZNLLKFTP8gduawHvka+wRtmLA1VL5R6NogAUiOeqRA5K9N/dthvh/MEkRVFiKkg6sIBvHWxLYa620liJbVa+Nk5lC6hhtQoaVh110IDUz1l6wghuMEj9jdM3nbBLt4iVWMunnEFGMsav/WRAkjFxoFwhTrSPDL9ytlbLZwYR3GJGtLCv8JUrqrEEpeOJCo0bW41m55LwnQjiYywBcVLqdyoJJwFVQCpa5unmtuCbZ9auIEuhzW14QW6gAeM6jGBaAkho9lCzOjwNik8EBhHE4xIHqes/y8+FGua0yzVuAuaXnYkm/LXaE/TW4BpZlsMcWjQW0WZsw1zlnfWd0sgmmsSAwCOW+LOyltSkrw2wRryTovYYIpAMwKdY3hPF4KELqW6BVmUmrE5WrRUTRHUJ0X8Dt17Scq1FrkRZDndjomrIZvVMBeQiWp/bfQzVwoBLHSSCbttQBAVrKaJWB/wosRMrmeAYHOJX4/L7bNDo12vc/sAeCi43j+/VOPCbdZAxwAFd67OWKXmfBkNU9VMXOUzFPrLsimo/5sWf8bomIA1PGfQ2yJ7gEdKxtYqN/1xLgwBylsjYbUEg04RCap8ul5WZMKuQhU6mjZSmm0FyYkLg39Qe9xYxCluEAM1hZX7GLxr9gmgGDF+22eXSbqcDRVHfmo2itKY+i0Tbvahxl6z2EgsQfHKz56HrUkBxhHT1DIKLW6cOBfKSpRFPy2o6A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O2aoU1bRc/P4MWmgdGUHhteORuG0+y3f5SbiU0kpRis3bAuNUuZCqmA5yB1a4ZKz2RY/9tM3khxcxjLiodBeDFZQ2btVnqaJ2h+v1oDqnyB+mWDVPz2gntl7pAyAs3slwF5I3JLQmpzW7geziYazFJTvPVHvM2MsXAqDPAz5WbRKGUxj9HR30FH/0c/DLm81Zb3PChpe4RJ9XBgeLbzvEw1Sa51AIHTttIX1H6JOetQpPg2mmgqJe9eHeQAvNUrikUp83OT/u6+TRVgUsIwh4icKcOoLw3fWffUFYMOtiMiV5zP+WQ/jr2lHnRx3f72WyxhU0uGF3UC6PuG7YG3aLoiReTpsboM8he2MLdlXVXbnrQNRECAxSza9dy1RRfCHzt4JY9kgnA1Zdq5fPU4zhjr9Gr1DaL/CySprZ/fQJdnS2txZlgrSpjI5MUqwm2z5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:09.3411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ad45e1-2301-443b-215b-08df1347ddd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427

When a device leaves a domain, fault events for the old domain may remain
in the SMMU event queue or the IOPF workqueue. If the IOMMU core frees that
domain before those events are handled, the work may use freed memory.

Start with the hardware queue by using arm_smmu_wait_for_queue_drained() to
count entries consumed by the threaded IRQ handler, and poll the EVTQ when
an IOPF-enabled attachment ends. This prevents a pending IRQ from queuing
old-domain work after the drain. Its until_empty mode can drain the CMDQ as
well during suspend and runtime PM.

queue_poll() cannot be used because it is an atomic busy-wait that expects
hardware to consume entries. The EVTQ and PRIQ are drained by threaded IRQ
handlers, so a busy-wait could starve a handler sharing the same CPU on a
non-preemptible kernel. The new helper sleeps, and might_sleep() catches an
atomic-context caller even when the queue is already empty.

Sample the deadline ahead of the queue state that it judges, and honour it
only after the exit conditions, so a drain that completes while this poll
is preempted still returns success instead of a spurious timeout. This is
the same ordering that poll_timeout_us() guarantees.

Note that a drained event is dequeued, but not necessarily handled, since
queue_remove_raw() moves the MMIO CONS before the threaded IRQ handler gets
to push the event onto the IOPF workqueue. A subsequent change will invoke
synchronize_irq() and iopf_queue_flush_dev() to close that gap, and it will
act on the errno of a timed-out drain too.

Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
Cc: stable@vger.kernel.org # v6.16
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 101 ++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index de7e4284658a1..21b00b9296b31 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -189,6 +189,8 @@ struct arm_vsmmu;
 #define Q_WRP(llq, p)			((p) & (1 << (llq)->max_n_shift))
 /* A position is Q_WRP | Q_IDX, wrapping at twice the queue capacity */
 #define Q_POS(llq, p)			(Q_WRP(llq, p) | Q_IDX(llq, p))
+/* Entries between two positions, i.e. how far @b leads @a */
+#define Q_DIFF(llq, a, b)		Q_POS(llq, (b) - (a))
 #define Q_OVERFLOW_FLAG			(1U << 31)
 #define Q_OVF(p)			((p) & Q_OVERFLOW_FLAG)
 #define Q_ENT(q, p)			((q)->base +			\
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b908a8af31442..9e657d075f387 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -948,6 +948,97 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
+/**
+ * arm_smmu_wait_for_queue_drained - Wait for an SMMU queue to be drained
+ * @smmu: the SMMU device
+ * @q: the queue to be drained
+ * @until_empty: target selection
+ *
+ * With @until_empty == true (for CMDQ), exit once the queue is observed empty:
+ *
+ *   cons0                cons                                prod
+ *     |                   |                                   |
+ *  ---+###################+===================================+--->
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
+static int arm_smmu_wait_for_queue_drained(struct arm_smmu_device *smmu,
+					   struct arm_smmu_queue *q,
+					   bool until_empty)
+{
+	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
+	u32 cons, prod, pending;
+	u32 drained = 0;
+
+	might_sleep();
+
+	cons = readl_relaxed(q->cons_reg);
+	prod = readl_relaxed(q->prod_reg);
+	/* The exit target: the number of entries in the queue at entry */
+	pending = Q_DIFF(&q->llq, cons, prod);
+
+	while (true) {
+		u32 prev, undrained;
+		bool expired;
+
+		/*
+		 * Sample the deadline ahead of the queue state it judges, but
+		 * break only after the exit conditions below, so a queue that
+		 * drained during a long preemption still exits with a success.
+		 */
+		expired = ktime_compare(ktime_get(), timeout) > 0;
+
+		/* Accumulate the entries consumed since the last poll */
+		prev = cons;
+		cons = readl_relaxed(q->cons_reg);
+		drained += Q_DIFF(&q->llq, prev, cons);
+
+		prod = readl_relaxed(q->prod_reg);
+		undrained = Q_DIFF(&q->llq, cons, prod);
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
+		 * Q_DIFF() will wrap and undercount drained: that could trigger
+		 * a spurious warning too, if the queue was never once observed
+		 * empty. Yet, that much consumption in such a short interval is
+		 * unrealistic.
+		 */
+		if (expired)
+			break;
+
+		/* The consumer might be a threaded IRQ handler. Yield to it */
+		fsleep(100);
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
@@ -3318,12 +3409,22 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 {
 	struct arm_smmu_master_domain *master_domain = state->old_master_domain;
 	struct arm_smmu_master *master = state->master;
+	struct arm_smmu_device *smmu = master->smmu;
 
+	lockdep_assert_not_held(&arm_smmu_asid_lock);
 	iommu_group_mutex_assert(master->dev);
 
 	if (!master_domain)
 		return;
 
+	/*
+	 * In-flight fault work references the old domain via its attach handle,
+	 * which the IOMMU core might free once this returns. Drain the hardware
+	 * eventq, so that a pending event cannot turn into new fault work.
+	 */
+	if (master_domain->using_iopf && master->stall_enabled)
+		arm_smmu_wait_for_queue_drained(smmu, &smmu->evtq.q, false);
+
 	arm_smmu_disable_iopf(master, master_domain);
 	kfree(master_domain);
 	state->old_master_domain = NULL;
-- 
2.43.0

