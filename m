Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176E39CCE3;
	Thu, 10 Sep 2026 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082275; cv=fail; b=NtekB2bbGHpdTFd7hrKb0DQfPKTdIHR0ZkXyzpeVgrzAQy2izRWE6OmlE9UJLAK5WSIFhdDTNkPgRzvi9VP9cn+AFSy2xxHVdqrFyhsw72MQQkdD43kTY6Euc8vOYk6z3xJj2Qmx0YJD55+8bvHPH/celXLG7JQMqAHLZbQhs4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082275; c=relaxed/simple;
	bh=CQXuWdjCL2tPa9sDknwQt3c7zvms00BMP+TABmT/ziM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxfTgYMsrhVk0OR+fT7PQwjftNVjSc8QmUmDToDi5kjZDkJC8ZM6zoRMcEif2rUG8IoR+g486hrOxhcHZtgZRvw9EaYOEIxY+l76eyK8JP11Tm3We/KnkT4u6DQQPUY8rBtpEUs3wavo5jsHkBQQRWb/PYBBfwwh0+nXFPCxJmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C6Ib3KRq; arc=fail smtp.client-ip=52.101.62.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C6Ib3KRq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ityIL+/qkLKHRRd6SHk82rnSQ8qSLN5KfOPUqoY/ttvQahwcafxJD6cfPaejFaGGLZA4xZRXDBhDOVYm7d1i+h8XqEMqAec+fhc5Ytpig5Mb2ZEhfy37H5EKfQTC/aJ53zwkzuePCRQybNHw2KKASxTWUcDrZKJSZI6qjJf0h9oMTqA6Bs5uv5XZUS8Tdn7FfRCaP1eWcxKl2RpgZVY/ar7OHRPFlzYDBbEqMwXkCqCVihRBkuEstXe6GP0Pb4abIdRVqtkYPZhEQhA//tP4vxAdG8nkiUABgnAgYfpFSbK/dnxWOTwM/Its0UBbYdYjzdvUCyKYjlcNz/4NR7p/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc3Ola2Z2aOfE6ye4NjlM+gAwoatuni+M2UeHMjcmBg=;
 b=fnbj4xPBg+8idZlq6g3GT28NW5xGB23no8zoUpnWD3BVcqb/xZ2jgdF5Saqm97e9gjXjXT3n+KKX39BLjKwniNDOlSwvjRm8VutckwwejmOXNVmiY7Gze4LdyWKh+gM+BXqtpxBwLmwNCsc1MFgRbR84kCWuDwq0+OKzhX5nyTDJvHeTPdqG0XthhiQlSg9j1YPVEiwCz+hwOunGX85dqN14ZNWTIuwIXZ+ClOvXpKwc4Z9pQVAVeB+DNeRy2BNpKIJGIlRLjb4hGabZP3Oe+sEeVSfza0FRjwZAGl9R14NAnnLc7agZcCfamM2rJxU7e5BW3+Ifm5Rw/ZJYQXhXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc3Ola2Z2aOfE6ye4NjlM+gAwoatuni+M2UeHMjcmBg=;
 b=C6Ib3KRqqpF7qFpjUYQ4EuJjuqWyJqVoGB4BeMOYOMjR/NOplFl4xC5cSYmaH5wj4tzcR11MU8/nLTW6BQnCIcVPyFd8c5cmGpx/cfVIXKykX7EhkVvGXArFWcgLfD6lWqdtTjFaFp10YQC2TTKJDQaIByFBz88Kpm+aZynsOeaPAu9wQnk1lMR+naj8mM1G0+NwgzP1yTOY8zKIWDKIxnUF6sYLczyQ4jK8TqUrKbx41AgnKekwXB5qUrckI19svrU+0YntIIOkNU8NccWLw+NST6jRSPKPXxE+FAL6P3rCVATO7l5DzuYp7wSxHNMjDk7vM7XsEWtK4eb+RSBS3Q==
Received: from MN0P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::26)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 23:17:46 +0000
Received: from BN2PEPF0000A892.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::7d) by MN0P221CA0002.outlook.office365.com
 (2603:10b6:208:52a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 23:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A892.mail.protection.outlook.com (10.167.248.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:27 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:25 -0700
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
Subject: [PATCH v4 04/15] iommu/arm-smmu-v3: Drain in-flight fault events on domain detach
Date: Thu, 10 Sep 2026 16:16:56 -0700
Message-ID: <e98a3f1b8964c9f4785ec6dd6c001b7aba4f1cdd.1789081084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A892:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: f9096f0b-e814-4391-706d-08df0f91b8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|1800799024|36860700016|6133799003|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B0Fj0SkqJP0UzBJRdKeMoz0mQbhQRsGL2pZIRfi4xq8Quz32q7hqS5+euALbmXZSyI6YEFGWOiWRhYmP6Y78HlQ1QUGbwXwsaJ7HdLOLCy/AdVqe3dalLNQr0ZcUeBl7Vle3BgGBTus27CyywzhmFks/JKgHgiV8mQhHMO41aqArlKoLaIQr5vKUd+sYYhKHWiRgjsRbpdjfqYEojBXrHJjk3zcUugGsi+JugD5HKiwwHv1OTIPXFlB2YEAA9OaMdNkvL2oaY/gXrzdROGwCMllipiFCoWr2JQPyHLyfpP7DewhO+OPNh4EhCXJheICSO5vknjO4KtHAyk3Td+kf/2bAhCjNH9wpim9wH1wN1Knv/K8Oc28IHF6hIP5MipjfETK7i+1MB0eicmNwLl81C5jc5a+j0vDB0o9zXgE9qamDWAZ45kcmSpgH02Ch4Kc3mbqdhRoSN2SeDei6OJIFqa9w+Sj00bWD8IAIvVwxWchuxbaYdwIrdPejK7dhzqfj2w9Y0jkNQqGgyomb8uY1Jd3lh0RnKM9zdk8ODndg4gdYsydJoLhmWK5672/EJln6bj0Gyxv5QHMygsKC1typ2g8jcdChWp5Sw61qnfY/IOa6/N4ujEcnY2cj43zPrz09oAmotqnLh6CABG1jIQeOG+dlEzQNDrS14czG/eMblYzWFhdU5/pyk2l7a/W2tsePBU+ipkLMBlHZiNV+7qLyNw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2q/7BFQvvWRAclYJkHcsZaCOHdpIYA9eAYGnboXZ8BD+ZzQhSknf5JR6QG/FEhCt7FbhJ0o2XldGYrguEPpWQvRs6GnuA8cS2eNqVqiLIGfHypPa8+eGbVljdg2OZAYsgXcHhqAXXQX93ICsgaY1jmUs5sMX6cn2F7nj64aK87jEl2+HmLT/EbtfNpCuPEO+FbcTyw6cTU3TNoD/HdkVOcMYPIgxAse+nQ343vR3eAjXvDawurw8cBlk0GrBy2ZtRBALopKuwJyrK8Lh0sVUqu2SSM+ZlBUAzloBUfkY/i0+6HQ6/Zst4DVarDo+gK4Zccf7j5RYtSeoSnUbIkM28+3fYdLWNThWQcE0NaQaOoNInMhG3SQ9QvjVn+c3Ci3lmDrfXufoejLtvyLJ4jbpwPWk+M1hCnyKr+gqXyn0ugEPZpLRM3d/EXKlzPcyRgAg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:45.4045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9096f0b-e814-4391-706d-08df0f91b8db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A892.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

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

Note that a drained event is dequeued, but not necessarily handled, since
queue_remove_raw() moves the MMIO CONS before the threaded IRQ handler gets
to push the event onto the IOPF workqueue. A subsequent change will invoke
synchronize_irq() and iopf_queue_flush_dev() to close that gap, and it will
act on the errno of a timed-out drain too.

Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
Cc: stable@vger.kernel.org # v6.16
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 93 +++++++++++++++++++++
 2 files changed, 95 insertions(+)

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
index b908a8af31442..ef1fddad7868e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -948,6 +948,89 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
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
+		if (ktime_compare(ktime_get(), timeout) > 0)
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
@@ -3318,12 +3401,22 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
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

