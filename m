Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907B304BB2;
	Tue, 19 May 2026 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162020; cv=fail; b=GVTquOowiSUKR74RXYtn40jWg8Dftu4/O7ninlV+N+OOymRbSAZ6nuJ/zZ2yJEXux1zaSbwjoLvBOoS6PlTff9xh3Y4RlvW0YWE7hblDqve3bOoADhR6cCAAGxSACSfN2tdIxuhizmK6Nw6o6REErsPmk/HS4v4W3C1aFSBYc5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162020; c=relaxed/simple;
	bh=T51tUcSdGMQVXbHUyEx1/nkgvmR0QtxkOCg+TfgkK/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPLtnK9sWPyEeCRJONvQf+mMZAObTS2U/rLlTzREur120EcYp/Kt4NDgl7BsjpslvMReRqdS74mLMCUEHFD69laqNF0KvPS3i0CBdoPydTtymCOYCp59atSk8JLg0sC9feTnvtLutqF9MxsVMmnYij1b3lC5xvZ86E4PlsywI4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SqfmSvIo; arc=fail smtp.client-ip=40.107.209.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SqfmSvIo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p97tbogOGrJXDJHj3BOTV8v2O+wXyX38torhtsXyonar2ffM07ysC/6yAwP/Ze1M4rpe4rFgjkbMFTtVO8KFAW2SHYldDnq/KRwZbf0dL6bYsNrQBKW0T2el3pD2cGfqweF2Ez6JdNJ1Ss/DrPFV5oV+3OK68MnxIAyWpCi9+1jSoVNE/T/R+NNeL/5xdJRFMLudfz+fUEUGVJWi/YwJQyiZzV/4KgGyx7ZpTCKiEPd5/XTZnjP2XVNCAr5Yui/D/mioCtcp9O60QXWpTZl7+4a9+6XSH2MZX2ZLtFfOaH6aRSoVaEPRtXC7z70Yj5iFS9wpnsGeT/hdP6yua2REXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UlGXjDvVXDgZudHIrIPROuqy4ey1Xw2b4fXp5zcl3A=;
 b=tX2equxchdqqhHi6iqfJCaUaXP8ImNG5q2Zzg6N+xkyaJ0fBmd/dQFFKFaNlCi/6pTKxGABY0iRt/NJDVFsfbnri1i0slTvfbeCDiIQjKWnvjHATTQghuMvlUsUhuAM+HgaxAbul5rNsFydByHf6zyO301OZPBr0BlniKDHD5Y7e5Y8R9eyh5EmvNfu09mnvAoyCgUbUr66ywDMOgf85uv0QjqVhpFj3I9I5uiLyBWP740nwgG9sax75oKt1CvVgyrdXe8TaNWhVIxZYJrYCLyr+iuFPiQwr70oqF7TxsWvLcbXHOU05HBtnLSz/NGGQF90gQQ2YbvlNTrQxkHsgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UlGXjDvVXDgZudHIrIPROuqy4ey1Xw2b4fXp5zcl3A=;
 b=SqfmSvIohxfKBOPfXKjFw+pVX+TZXPBjvkAdetdcwHF70gwXVglMdDYm4HZN/OQwpUtmHAMDaRoKWzMKdsxLE73AvcHuBj5TyBw0NXbNpx+7Epghp1InlGH6u5ySDV5cVMx++S1fh93PBgag69BSe0wXFBdgzBEuiBUYMVplUvEk20AacrMYnU2Rku3jZnZIIrlXLde4VkDQseoZzsJNaDYN+DiXa/Og84JP6PmV9LPVhj1lyaUmJaocbgh5ClO1x9b3OO/ILixnxCOFOCQWDd1zyAQMcTJjqwa68JvWKVUnptCDwehZydd1DNcbhcB58pEzmXqMoM6qHMTns5K7oQ==
Received: from DS1PR04CA0005.namprd04.prod.outlook.com (2603:10b6:8:44f::9) by
 SJ5PPF0C60B25BF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Tue, 19 May
 2026 03:40:08 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:8:44f:cafe::34) by DS1PR04CA0005.outlook.office365.com
 (2603:10b6:8:44f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 03:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:40:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:53 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:51 -0700
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
Subject: [PATCH v4 22/24] iommu/arm-smmu-v3: Introduce master->ats_invs
Date: Mon, 18 May 2026 20:39:05 -0700
Message-ID: <7fb3652c6448d757aa4b5e7bf32018333e1db1a9.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf07486-9003-4cf1-4ce0-08deb558528d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|7416014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	3YjgoxJdxDmC9UX49C8UKgFnlj55XABjT/5NgB6nGDtIu3O7Tv3n7WFJ4nofk1lBSmpaYRw3KFc3FiwSDsQ88ew5Et9k25WTJw3Ik5sQV3ZMQtJnIf3HVLHro8VroGqbwkWsyjemfL6JBxNZUIHlD5FPELxzu3YWsUDaEWvw0Y11N5/wW/4ilRfCaqm5U1dkcLXs24f4tLO5N30+KbpgGXcQ/mkxr0ugPhdZ9LySQB1yEERjSI19W8s8zCvcnYra9LNvWL1qtitc1AACSG9QZ6npwYnkl+Mv4d28v03Y/+bXd15TjOC9cPDTugTYKhfoXl5TbyrRxBwMqjXRszD/eOdKNxuHLodm96aXtBdLScUsgl7CqqCv2WI5/KaX4XlT6GR5Iuu2tUzif0PsecQHNfBe9bu0o4QfcVa1ffdOGQ9ak2yP4hW4xJcGMPQTH8VbWbr4l8NN/gaf1LLf6Q7q6InNIpZo0ePcrlXBqs/l4PHbXMtyhlUY1bx4Q7LvLMK2uuI7g0tjC3aHVz8ZJ8m568+hFi2aZJEd935R1M3vqMlEBEaj4PKURSKfINwrZsTb5K++KWcnhvWMWAHr0ViPd82TttSAcvf9TNuhI1TuCQcXYVsHVnrWd7Jm0aiVy/w3qSz5Q/WOM7fbynIOngKwspbagMY81nnM+xDrudNrTj/h86ewfoIGWXTMXycMOs+6K5hTWYPzXZ4X+k33ASck676apq88ZtNYW39SWmZZqPY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rKgOwzUkDDsIpOgoALZC/XddMbKKf5L23+En98P4/6fTV/Dbsc/94MHuyoQBCt4Rd+KtJiauWvLFRowKGPcfTe+kO//V48tCEhkIsGJXwU4NN27kqosdhOjzU8xTsy/ZcNsE/EuVS+YiBO1n9glfubrLUnaL1xAprQfP8qge8NWkBzNADhLf13zED9M1O5v/B7L/S/E3aYTlSfCJbuv8LAabfy9Y7CMs0DoVNt5pZZTSHpdHwywPp+NTF/t68S89Ds6BdS+FE3RuiFvG7BFHd7UdTtoOwwl//IYkLBt6SkpM7V4qzTigdpaDE2Jybwy6ITT3h5v3v8HEggZBZs2AlPwPLEmRG4V2eneLqFHSrOqrBe/PBnbqYUzw4I+3coecRXgIHMp8XNitLrBCysi/wrX8uqQbleodCWAa5wpVxFIa5Dsd5/c+tY4a/hOL984f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:40:07.8396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf07486-9003-4cf1-4ce0-08deb558528d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF

Similar to master->build_invs used by a per-domain invalidation, add a new
master->ats_invs to be used by arm_smmu_atc_inv_master().

Since arm_smmu_cmdq_batch_init_cmd() now takes an invs pointer, pass it in.

This will be useful by arm_smmu_cmdq_batch_issue() to backtrack the master
pointer from a timed out ATC invalidation command in a subsequent change.

Also replace the streams loop with arm_smmu_invs_for_each_entry() as it is
initialized (except ssid) upon allocation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 46 ++++++++++++++++++---
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index b5ace01c05a5d..186efcbed1ea9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1045,6 +1045,8 @@ struct arm_smmu_master {
 	 * iommu_group mutex.
 	 */
 	struct arm_smmu_invs		*build_invs;
+	/* Scratch memory for arm_smmu_atc_inv_master() to build an ATS array */
+	struct arm_smmu_invs		*ats_invs;
 	struct arm_smmu_vmaster		*vmaster; /* use smmu->streams_mutex */
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c95297acf2cfe..9591e4ab2b14a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2407,21 +2407,28 @@ arm_smmu_atc_inv_to_cmd(u32 sid, int ssid, unsigned long iova, size_t size)
 static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 				   ioasid_t ssid)
 {
-	int i;
+	struct arm_smmu_invs *invs = master->ats_invs;
 	struct arm_smmu_cmd cmd;
 	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_inv *inv;
+	size_t i;
+
+	/* No concurrent user on master->ats_invs */
+	iommu_group_mutex_assert(master->dev);
 
 	/* Do not issue ATC_INV that will definitely time out */
 	if (READ_ONCE(master->ats_broken))
 		return 0;
 
 	cmd = arm_smmu_make_cmd_atc_inv_all(0, IOMMU_NO_PASID);
-	arm_smmu_cmdq_batch_init_cmd(master->smmu, &cmds, &cmd, NULL);
-	for (i = 0; i < master->num_streams; i++)
+	arm_smmu_cmdq_batch_init_cmd(master->smmu, &cmds, &cmd, invs);
+
+	arm_smmu_invs_for_each_entry(invs, i, inv) {
+		inv->ssid = ssid;
 		arm_smmu_cmdq_batch_add_cmd(
 			master->smmu, &cmds,
-			arm_smmu_make_cmd_atc_inv_all(master->streams[i].id,
-						      ssid));
+			arm_smmu_make_cmd_atc_inv_all(inv->id, ssid));
+	}
 
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
@@ -4087,6 +4094,18 @@ static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
 	return cmp_int(*l, *r);
 }
 
+static void arm_smmu_master_init_ats_inv(struct arm_smmu_master *master,
+					 struct arm_smmu_inv *inv, u32 sid)
+{
+	inv->id = sid;
+	inv->users = 1;
+	inv->master = master;
+	inv->smmu = master->smmu;
+	inv->type = INV_TYPE_ATS;
+	inv->size_opcode = CMDQ_OP_ATC_INV;
+	inv->nsize_opcode = CMDQ_OP_ATC_INV;
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
@@ -4105,11 +4124,19 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		/* Base case has 1 ASID entry or maximum 2 VMID entries */
 		master->build_invs = arm_smmu_invs_alloc(2);
 	} else {
+		master->ats_invs = arm_smmu_invs_alloc(fwspec->num_ids);
+		if (!master->ats_invs) {
+			kfree(master->streams);
+			return -ENOMEM;
+		}
+		master->ats_invs->has_ats = true;
+
 		/* ATS case adds num_ids of entries, on top of the base case */
 		master->build_invs = arm_smmu_invs_alloc(2 + fwspec->num_ids);
 	}
 	if (!master->build_invs) {
 		kfree(master->streams);
+		kfree(master->ats_invs);
 		return -ENOMEM;
 	}
 
@@ -4125,6 +4152,13 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		       sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
 		       NULL);
 
+	if (master->ats_invs) {
+		for (i = 0; i < fwspec->num_ids; i++)
+			arm_smmu_master_init_ats_inv(master,
+						     &master->ats_invs->inv[i],
+						     master->streams[i].id);
+	}
+
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
@@ -4159,6 +4193,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		for (i--; i >= 0; i--)
 			rb_erase(&master->streams[i].node, &smmu->streams);
 		kfree(master->streams);
+		kfree(master->ats_invs);
 		kfree(master->build_invs);
 	}
 	mutex_unlock(&smmu->streams_mutex);
@@ -4261,6 +4296,7 @@ static void arm_smmu_release_device(struct device *dev)
 	 */
 	synchronize_rcu();
 	kfree(master->streams);
+	kfree(master->ats_invs);
 	kfree(master->build_invs);
 	kfree(master);
 }
-- 
2.43.0

