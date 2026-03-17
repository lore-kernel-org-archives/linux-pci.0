Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DD33FE12;
	Tue, 17 Mar 2026 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775003; cv=fail; b=hP2E6ycvxoxzkRXmGnymh6RstPeLJkzoh8CPxjwOxgS1UWqP5Gv6lmD5yry9Foe07qUaQTzf69NUD7B7UfQ/wyDqbOzArKvZ706cCB2dOwItjenx4YAAcB7FanXpaQDsAXPOd11gxnzxhTV1MtYUbwcrG+gcZU0JTmg6IgymwH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775003; c=relaxed/simple;
	bh=auMTp9G2OzurJGsLGt5pqpS9fCw0gu3TYFDdtf4Zsrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIu2k70gixECRWHNSlW8eSwC5FlC4ErEl5h8TNRRDAPGBiZC9mpGp68pcDom7wgaKviaaTIzxz/PQOe47g6cGxklyI3QlCMC9azvD484T8zOOTxk2ZETqD4pqgFms9DxF4xukb6nKz0NjPJ2DBcM0uQ6GksbX2a815yZHvmpImE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oMytbCuX; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oMytbCuX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aurWpxOxT/ScEQS/5t+Gq3aSVmZ88bxNr1LNZp1muDfMN8QUFXIeyIe71l9579SRPgif30WKwN+LVIk+PjRxJi/Lmhmsp2lkLAQ2UtmO1KA7uqCJgfBIDiRrnpj0rznEpH53t63HHNKShO1YM715zik0PzECFPPpE/989flQ2HMVpt0CNs2TZxo+1Qp2idvDImCyzUjHGk1ytCsyiVfEBjjuhxsCY14tJ1Ws8T42AdFazXn2t6Hv3rGnnJSHyNhUPMsmTEqoamzrE2vPx0zKi1a6MtHogF5Fr5U4a4v49azUD/pKq52Ev5inYo2ujz2C7b1oYEts/27IypQFRiDV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVWk3sfJaF2Ksf1YdGaLHlvw0naTKX8iYWmZ1jhpkRA=;
 b=ApS7FX7M4XAOVo+nqdabl5lAU0R6Y58BWpxJE3jlpOfYexvG1voRwIe4ujNX8stwnPROZFJxVM0OsYYW5Ui30ADtesX9e177znoFgPk6SIWDFQC1ay92zS3j/tHl2RWMbTAn73VnrLDZQrlhS78ZVyax/Kn8leaDHFn32rpMi7uVn0K70tKBZFf0kvMxI+tK3vqgIH38maKH+3cLk7sktIi4ziLT0PMb1nSUpRsHqA5Z/4PfoFG5XH2BbC5J9DBSo3v10c0vuxXw0gJgHccSoHe/3JQA0fVuMwqvQxsBlzy32RQOym8cYYIO/95PXWp912VpcDo9+5Lu8K/Nt6mSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVWk3sfJaF2Ksf1YdGaLHlvw0naTKX8iYWmZ1jhpkRA=;
 b=oMytbCuX787STTXrLUuoABSFR0TN3a8wxYgDRu2eA4HlRO7BYADEZS71CRyYKZ0KrxHf+pOu6lSYAbTcE3OYTCCHX93unoy91cr41+DzQTDXV+ar3DtgBXoRXYCyXEC8QU6XssXVkk6Yfs0915wWvaA+2R2gNZtxx/dCH2HVC5m7OBvIiSvuJ+DheIcFeXRgYocDobIYsQ0wEct66FweXbMXekf9+ATiiEiEayFujdLs7AUB8OidQzxhZGSbCDg5F7QVcR1SN8D24oJmjpY/zcrMSQTrispbEb1pZofMrZ429x8wLKohZ97OOEqbk7RJmT4SswLgy1RTdzCxpVa2Lw==
Received: from BN9PR03CA0191.namprd03.prod.outlook.com (2603:10b6:408:f9::16)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 19:16:34 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::47) by BN9PR03CA0191.outlook.office365.com
 (2603:10b6:408:f9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 19:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 19:16:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:11 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 12:16:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <xueshuai@linux.alibaba.com>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: [PATCH v2 7/7] iommu/arm-smmu-v3: Block ATS upon an ATC invalidation timeout
Date: Tue, 17 Mar 2026 12:15:40 -0700
Message-ID: <7e21e14faddeb0e3af692356f4fefbae2dfbebda.1773774441.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773774441.git.nicolinc@nvidia.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f86d5f-db41-4f1f-e4b2-08de8459b38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MrCzGpvo5qoVsQY1dK2yha9kaGnizShQu9UWvH24RnxRUBMQT/aCVERPKEnJF0EDX1yWYF8/+CI1bU1JmQQ/xe7AI3kpwSPy46fJjSEPjLJnIWUG56Q+8TYeAKenxPMc/ZLlHpNvwg0hG22/vfC+jnhT0PgKyHw2DVVQmuHMkYvZeUwSW9jnjJXRm5ue0v84EEg66fCdr17MCAGsgGW8rPzCxyxe8zEd3Q5tlGmAE/Tdph6VLvuGnRpRQY6b69EMwScRcNDL7GBy5Pk5C8ctZ8V5xHCkyd0SdW6MSrZBQ3Hm0bi6bkxp65Lr5BoVzibidiOPM6MoJzjwsEKlE1JPLysZeD3SO1vo+HPAOPYHXwx6cXV0QmuHOt9EYihfZzHgy4UMHyX8+368z4SOwnVEBGccJEUoNJVfPXW3UMWg25oL6S+SY3/98CaXGVsix7txBtB/MSFUyPetNS7aHk/DWk6+5bzbVfitmJSLAsgVYQwD+OrPdhQ9m1xsHXSimL6JgRd2mRfmMUU8cRdnvrDUqYik9SyNrculjHSIPnFXu05Sfh/OtvKLVKnod/kAQXDCrw97h2jXIFPvk1Mz7NLaxsZVyb/OF7adNn4RxYbf5GvPxjHyQ2iKm7MM/ZKutE53UCVMx7s77mYwbfF6ajXr10W7LAnMlUqBf3J8+aPlB3MfTv7MfUkX2Dw0dGf5lFDZhvXupsbERYR5dy3xNW5UW/8XOQpdpnWCAlXmUDRx3ZL3GtxZxY89l5/mApCkWv8NgRu6+aeV6Sb+YBeSlwxSRA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oBn2F3nNq2OWFW3epPw3NaDjBuiEsXggcJzf0S6FB8ONjxvF+bKTUtZoQnx0IyAPT63+AYu64CsJap4WLTYsFdpK/j964XjzHqdxGfCTZ0ztC8bFxwbpE5SnfX8cQH02DRPRg9TOAnoHM2zPxjszZyWV43PVIJSwCvpncfjOuev3cSM4Y7yTsK/VnmjratbYHuKsBWZSuUCzPIL9zTO9rFj9mm+VgM7s0y6CtU5iX+tCJgiRlguJonkSn/BP0Njk6AmfxGT0pVRajSkpIZKptlBUmCvKO2BtwMY+uFlPBC0J95TtBFBAm3zvUOEc3H13dXhotcTUtrWQFUhUYBR2KgTf+2Hwyyqakrxje7znywZQQa1N2/+nSGHGLdEsXSccUuwQIF6R9s0BDckV+QgSMOWY+jaiQfHwg7Nv8I/ER4tytuTZjvdgWVVT7HA/XLe3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:16:33.0499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f86d5f-db41-4f1f-e4b2-08de8459b38a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778

Currently, when GERROR_CMDQ_ERR occurs, the arm_smmu_cmdq_skip_err() won't
do anything for the CMDQ_ERR_CERROR_ATC_INV_IDX.

When a device wasn't responsive to an ATC invalidation request, this often
results in constant CMDQ errors:
  unexpected global error reported (0x00000001), this could be serious
  CMDQ error (cons 0x0302bb84): ATC invalidate timeout
  unexpected global error reported (0x00000001), this could be serious
  CMDQ error (cons 0x0302bb88): ATC invalidate timeout
  unexpected global error reported (0x00000001), this could be serious
  CMDQ error (cons 0x0302bb8c): ATC invalidate timeout
  ...

An ATC invalidation timeout indicates that the device failed to respond to
a protocol-critical coherency request, which means that device's internal
ATS state is desynchronized from the SMMU.

Furthermore, ignoring the timeout leaves the system in an unsafe state, as
the device cache may retain stale ATC entries for memory pages that the OS
has already reclaimed and reassigned. This might lead to data corruption.

Isolate the device that is confirmed to be unresponsive by a surgical STE
update to unset its EATS bit so as to reject any further ATS transaction,
which could corrupt the memory.

Also, set the master->ats_broken flag that is revertible after the device
completes a reset. This flag avoids further ATS requests and invalidations
from happening.

Finally, report this broken device to the IOMMU core to isolate the device
in the core level too.

For batched ATC_INV commands, SMMU hardware only reports a timeout at the
CMD_SYNC, which could follow the batch issued for multiple devices. So, it
isn't straightforward to identify which command in a batch resulted in the
timeout. Fortunately, the invs array has a sorted list of ATC entries. So,
the issued batch must be sorted as well. This makes it possible to bisect
the batch to retry the command per Stream ID and identify the master.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 92 ++++++++++++++++++++-
 1 file changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 366d812668011..418ee2f40d96d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -107,6 +107,8 @@ static const char * const event_class_str[] = {
 	[3] = "Reserved",
 };
 
+static struct arm_smmu_ste *
+arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid);
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
@@ -2495,10 +2497,43 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
+static void arm_smmu_disable_eats_for_sid(struct arm_smmu_device *smmu,
+					  struct arm_smmu_cmdq *cmdq, u32 sid)
+{
+	struct arm_smmu_cmdq_ent ent = {
+		.opcode = CMDQ_OP_CFGI_STE,
+		.cfgi	= {
+			.sid = sid,
+			.leaf = true,
+		},
+	};
+	struct arm_smmu_ste *step;
+	u64 cmd[CMDQ_ENT_DWORDS];
+
+	step = arm_smmu_get_step_for_sid(smmu, sid);
+	WRITE_ONCE(step->data[1],
+		   READ_ONCE(step->data[1]) & cpu_to_le64(~STRTAB_STE_1_EATS));
+
+	arm_smmu_cmdq_build_cmd(cmd, &ent);
+	arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmd, 1, true);
+}
+
+static void arm_smmu_master_disable_ats(struct arm_smmu_master *master,
+					struct arm_smmu_cmdq *cmdq)
+{
+	int i;
+
+	for (i = 0; i < master->num_streams; i++)
+		arm_smmu_disable_eats_for_sid(master->smmu, cmdq,
+					      master->streams[i].id);
+	WRITE_ONCE(master->ats_broken, true);
+	iommu_report_device_broken(master->dev);
+}
+
 static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 				   ioasid_t ssid)
 {
-	int i;
+	int i, ret;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
@@ -2514,7 +2549,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
 	}
 
-	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
+	ret = arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
+	if (ret)
+		arm_smmu_master_disable_ats(master, cmds.cmdq);
+	return ret;
 }
 
 /* IO_PGTABLE API */
@@ -2661,6 +2699,53 @@ static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
 	return false;
 }
 
+static void arm_smmu_invs_disable_ats(struct arm_smmu_invs *invs,
+				      struct arm_smmu_cmdq *cmdq,
+				      struct arm_smmu_device *smmu, u32 sid)
+{
+	struct arm_smmu_inv *cur;
+	size_t i;
+
+	arm_smmu_invs_for_each_entry(invs, i, cur) {
+		if (cur->master->smmu == smmu && arm_smmu_inv_is_ats(cur) &&
+		    cur->id == sid) {
+			arm_smmu_master_disable_ats(cur->master, cmdq);
+			break;
+		}
+	}
+}
+
+static void arm_smmu_cmdq_batch_retry(struct arm_smmu_device *smmu,
+				      struct arm_smmu_invs *invs,
+				      struct arm_smmu_cmdq_batch *cmds)
+{
+	u64 atc[CMDQ_ENT_DWORDS] = {0};
+	int i;
+
+	/* Only a timed out ATC_INV command needs a retry */
+	if (!invs->has_ats)
+		return;
+
+	for (i = 0; i < cmds->num * CMDQ_ENT_DWORDS; i += CMDQ_ENT_DWORDS) {
+		struct arm_smmu_cmdq *cmdq = cmds->cmdq;
+		u32 sid;
+
+		/* Only need to retry ATC invalidations */
+		if (FIELD_GET(CMDQ_0_OP, cmds->cmds[i]) != CMDQ_OP_ATC_INV)
+			continue;
+
+		/* Only need to retry with one ATC_INV per Stream ID (device) */
+		sid = FIELD_GET(CMDQ_ATC_0_SID, cmds->cmds[i]);
+		if (atc[0] && sid == FIELD_GET(CMDQ_ATC_0_SID, atc[0]))
+			continue;
+
+		atc[0] = cmds->cmds[i];
+		atc[1] = cmds->cmds[i + 1];
+		if (arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, atc, 1, true))
+			arm_smmu_invs_disable_ats(invs, cmdq, smmu, sid);
+	}
+}
+
 static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 					unsigned long iova, size_t size,
 					unsigned int granule, bool leaf)
@@ -2739,7 +2824,8 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 
 		if (cmds.num &&
 		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
-			arm_smmu_cmdq_batch_submit(smmu, &cmds);
+			if (arm_smmu_cmdq_batch_submit(smmu, &cmds))
+				arm_smmu_cmdq_batch_retry(smmu, invs, &cmds);
 			cmds.num = 0;
 		}
 		cur = next;
-- 
2.43.0

