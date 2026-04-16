Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688CC3A8720;
	Thu, 16 Apr 2026 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382222; cv=fail; b=FJDXZrvNRIXMQcm4z4zoiV2Ufk7cB3F+ew1iZA1Ekcy13ksoJm7wjtg7wEpXMRWRtAhaj81AJYakH8KLZiaKUTj93RMn4b9h3A/mU04jsRbGehAgKwKNi6Ogx78UT8j2uiv6NyCRWdi0cLLonkI8Q5xv9581dqzrP5rnIt+nhYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382222; c=relaxed/simple;
	bh=BZMBBeUiRqQJaOWG7bMBv2C5/f73ImUb0yKOTFRm/z4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYiu4qoqXxzVAlCjIpMg7UGz2YuPSlIDWVZEKmcPDjRAncrlTTEfL5ysG5KrqeTGj3EVO77godH8C6HJ6yYTO5149LrxSLSvkBrWIl05pEshjPiGszoBDEyLtDnKE7xg2PUcZ6+YDsmJ/8BlVCIuXSYzNn7gLySs5IbFBBXROBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HAVKbn8i; arc=fail smtp.client-ip=40.93.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HAVKbn8i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMQ7q6jDf2i8ztsQtM76nWKDCjWRt4wz0nSfyhLb9gGTNtMuE84z+wRZwDqU3SliZ3xF80GULRsPC7IKO7rjMt+eywEIORdPKKBO7v4jf38F5mFDREKQOAIvv4Og1BNJIP+TAm8A2tbozz9rU0YLFZokX+dHJVUMCz426n0eR2x6QzA6kDawft0rWuoEONw18gN8MiAiaMieHtjZDVVLJIDaFmwsjNe8t7CmxvHIX96IMvOS9kMiih8CsIXQ2CfG3OOa4pb66F6PAYEcs6vjDFpqqVUcLQYxLGpAjLRKuz0eYe0pkPAzTuGaJBg4vVblD9zHWr1EZypebtF4n7v/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8v2VF+E/uGiwaF8t4eiA68Qrp7GgNBrucQYc6qOzZaw=;
 b=uWiiWMhCGP+V6CnRonLeIgdfwb1/8mXZBkrzk+QDvjfv/5d4SwMLw8K8utRWodinX9uSOsNGhUoTJiebfewLx8vpYyG3Lw5r8cpUOg8CJwQRV8DaEvilbkv5DlT3ABdShW5kqy+O4OVXOwIxir8iC3jxMjPp+mUIfRVD/KS2suyL/dICS2ba2sS0VShEslt/AZPMcT2Rq5EU+rYGSKNysLh+lVRv884F1VeLQY2tDVHfo7NEdY3VG0OyxnKTe5h/S36u2yIozO5s6w3NMpD58wym7f8IhATYI31QT0s+iF2Ht6aJN9igwEm/W85Ufo3TBNUTxckZ+cDzFOIaHKzrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v2VF+E/uGiwaF8t4eiA68Qrp7GgNBrucQYc6qOzZaw=;
 b=HAVKbn8ij81Ke2eql+QdAACZ2tztY6IlGeuzxW8msShT6AGq57NQMaffozrVXB3x7bfc6QwN1GQNl3ijlG/yX+/MgVtv0gPHtk3A3/zxmWNHUhl8uGaeaYupFjgmpsWy6kiwLElI4uapwENOp785Ra1hWpZUMR32CrLKzlkVwm+7UigKG3bmeUG7e5PUvjGyW5zMzqxNA0BVytRA0gqn2IRw67v1bDOg/YHpLjnIDv1kjcpz4M6gpo0jV+Skz/NBqzTTu9isUHAgjtR2J6n/woIDOPbKyyULrNg40iVULYikAi8MZq4Cn3LSli2bDsw6t4WryTglVfHdVXLi3JxJxA==
Received: from BY5PR17CA0046.namprd17.prod.outlook.com (2603:10b6:a03:167::23)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 23:30:14 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::3c) by BY5PR17CA0046.outlook.office365.com
 (2603:10b6:a03:167::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 23:30:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 23:30:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:56 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:29:49 -0700
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
Subject: [PATCH v3 11/11] iommu/arm-smmu-v3: Block ATS upon an ATC invalidation timeout
Date: Thu, 16 Apr 2026 16:28:40 -0700
Message-ID: <5e2c2ddd25f80a165fc96db88f765b418a6ed038.1776381841.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776381841.git.nicolinc@nvidia.com>
References: <cover.1776381841.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b84d67-b811-465b-99b9-08de9c101bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jVPtvX/pNrb03MfdUO8k/xDoC8xakvDbrcsusHGK59d1IlRgdS2gAtQJwEcYipFBR7btGxPlDzrNwipu1UhMn4G5TI+oCI6DGJ4IdAyFqzqjvzkg0oT3mJ9UP8sZCp2QLpHp9qlJDw4M8XgM2MWISN3/hDmVdHdfT3XggugOZl5LKT0begfMMMEnxZvYAAfMAgJcJvkyOX97OBAcaLAI7w27HACejFL4r7XLv9EEPFBrYSHAY7pVbs5mkE7kUTF86X0+mKLYmblDjy76R757XogZQMcx9HRfhIGViQX1awUUP1TepDxgXv/0cR/CQXULVW12Wdp8+Z4vKX99RTkja35PyiR9x1lBakio2VuLljwcaNkDlDIF3oo68u6SvJ+AvS+anIf16Og6f0tilMXr9TwjmpDbWZYa/uiKBylzGKAZKFNCvvQJQKzGP6ehaNCyx4yP0CrEeCIRF1cTQQ781ufO+3CUol+L8mSI8RV756xg2ceoHEP4UpVULYF9ZRSobej3mTbLiwNz94mGmHjK4pfD5QDYCdf6hzsITot+eH9gYkfMU9KGD2KAUWBLzZK5ND4Vf5lh/Yk6+RiM+tOqlt6YAbvYmrI4tIbTH+TRqRAUfXqkVaQsMyMNgrXP12uE4R2TH7hNu4gbzymgutyQPIUxTWIMCsVNfJLDsrvfyfG5VWXvv3xcHwH8hvsCD+JVf7PvltcmifI4SFyBvi1O6Rxj9m8pbhkv28pmebkyLY3Z2LM+yiRUqZdF8GxRn6decdaP+mN0atpSGk7bSRcgmA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X7gPsO67FM26KGQPxCW2D2r4yU/OxGKZROyVtElUdeFJKYOefHWEO/jy9mzr11e4i1iX8Nh3xIVOVqgXJIy/RUAAOnSiRP3Rp724ylUHt/YIgff5MgVPnEhtZ5robK/rSl/++ISsz/CkbQuHnTbJppvkhx0n2sz7KqArRfPb9KC6OeIKdou1Nax7etlA4TLFQHDk9CSFoopBTxAlSHCErZoI8f/YgqMXVqZXcMyOpbGNFTLcyM6BUdm0wuc+q4K/G6KBbWLdOs7OM9cW44W0zzD5A0Z3LXt+Tdr7/in7D7OJMEKcCqcBjq1mfSWaOfqz5lHa3T+hUtPekp5cHWU4L3K6yJr/nf17/aLuTt7vRxy1uCmUG9NPpELbXmlCHtRON4g4l3Mhswk6zW8qV7p/KjoujNqhuxIHXtBmOQwGSs6Eie9uiPCwD6KV3soEUymv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 23:30:13.4564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b84d67-b811-465b-99b9-08de9c101bf3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464

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
the issued batch must be sorted as well. This makes it possible to retry
the ATC_INV command for each unique Stream ID in the batch to identify the
unresponsive master.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 100 +++++++++++++++++++-
 1 file changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5dead82cf1186..7dbd9c5834314 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -107,6 +107,8 @@ static const char * const event_class_str[] = {
 	[3] = "Reserved",
 };
 
+static struct arm_smmu_ste *
+arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid);
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
@@ -2516,10 +2518,49 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
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
+	__le64 old, new;
+
+	step = arm_smmu_get_step_for_sid(smmu, sid);
+
+	old = READ_ONCE(step->data[1]);
+	do {
+		new = old & cpu_to_le64(~STRTAB_STE_1_EATS);
+	} while (!try_cmpxchg64(&step->data[1], &old, new));
+
+	arm_smmu_cmdq_build_cmd(cmd, &ent);
+	if (arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmd, 1, true))
+		dev_err_ratelimited(smmu->dev,
+				    "failed to disable ATS for sid %#x\n", sid);
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
 
@@ -2535,7 +2576,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
 	}
 
-	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
+	ret = arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
+	if (ret == -EIO)
+		arm_smmu_master_disable_ats(master, cmds.cmdq);
+	return ret;
 }
 
 /* IO_PGTABLE API */
@@ -2682,6 +2726,55 @@ static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
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
+		int ret;
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
+		ret = arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, atc, 1, true);
+		if (ret == -EIO)
+			arm_smmu_invs_disable_ats(invs, cmdq, smmu, sid);
+	}
+}
+
 static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 					unsigned long iova, size_t size,
 					unsigned int granule, bool leaf)
@@ -2760,7 +2853,8 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 
 		if (cmds.num &&
 		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
-			arm_smmu_cmdq_batch_submit(smmu, &cmds);
+			if (arm_smmu_cmdq_batch_submit(smmu, &cmds) == -EIO)
+				arm_smmu_cmdq_batch_retry(smmu, invs, &cmds);
 			cmds.num = 0;
 		}
 		cur = next;
-- 
2.43.0

