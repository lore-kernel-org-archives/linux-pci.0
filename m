Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3923976A8;
	Thu, 16 Apr 2026 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382217; cv=fail; b=nsq3iaRIaHyDqD+xDubsS35tGu8TIXaxpMFqWoDvCuu+L6UFXdxH0PJkq4hAikF11N3bj83o3+vH0tn5laBPXi1+y5yY631/IqjbfnDAXqcIF0CH93klEwdcmMl76xhIEjwvxslU4XIBdV1gVjKK60EH9tIwxohyaT3LEWE3jT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382217; c=relaxed/simple;
	bh=yDq+Cfmk12pGLtv6JD/6dMZacmjIxegiFlixuDRoLNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmHLBhrKQx/mjkY4z3wo4p0gicwFG5M6FHZs4BzCVqk9ehHIgC6Q/tkef1iGYjxVgosdWOfoAHp0JrI9UVfsTdgPD3RFHDqidfxd7k2f1s5Zp+NsICA5jpCxx0e66Vqjmu7DMr3C2BwlEDU8wG3ibuRB7ffRMFA1xzmP9795DbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DvwbMDdR; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DvwbMDdR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIFFGXvFJPPCldtaMr0Pvo4RrH/epPNVqlzEL3chLmDTuiM3Qz+kXgQwpyokxDQrZC8HXcziL+5EknFXHAV58CqwuJQmIfQj+Y04kZuMneG4Y5oV9U+oNFIiepaKTWG+QIWy7jYr812zbsRj0RKYpoewilHfCa8KZ/k3FspBo3WQ63CgkI79iIdx2ItEfL0ZCFYngfCUKNWFA4LTTW8mReiaCa+yuLzryCD86DaRFjB1D84wWhMVQxMZEaAZ9osM83jxTuRot8uUBV7IHeUg0gcF60aYcuqPfS0Y1WL2UorEzHDyEvYkxBt4YoH6Ccu0k1hkWtN9L3DLOaowxIoXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTWELt83k3g1C5gQ86XTAw7Bn0+qH7tYz0O1Q4yqYDA=;
 b=Sg+M9iPgtEAZ6me8MpY6lfo7tQhj5pEAnbYSz7b5MIdx5P5Or0bkJPK/yvWDoyIXx47adD/SbV9Sld/EoAZt3++VzLOYXTIjfTKyS0SghlszNkMFoHpfbbVkdmkEf9GYIxHY8N+W319LH23ZGYP5vOoZSd0swZYOZEI4xzPwdFfSLCo+t5OcfDPQekrBwjxJQfGbt0U8rcdjpXAKqFlCi7lzx0GvA4BXmld5o5pv52UzTAheyu2EqX4ZyrXVjVIrOUgd39EJRI3AHHl21x32LARZOb2yVSmBIMc7svM3ZqW9LitR/C69ouLOx0J72A+4vA287VFLRSx49PDZW0AiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTWELt83k3g1C5gQ86XTAw7Bn0+qH7tYz0O1Q4yqYDA=;
 b=DvwbMDdREg5Jq55sRenoYU5h0NxB9lDwfB1DWQO672z/dxyWSG2p7lud73+Kmgl9LiZELPYcise5WZWCfQYmrcHeQETsTaIgBBsaqsVriMEHZiaYo8u278rBFxJwVWENXipYhj8mOKmjJxkgxl19M4109nxlmornWZmnanE45cyA1Fs2pfl4ubVZ6AdXjLwyXJcgTCVbm7YFq5xQtynF0SyNqvwsLCqKwxu13H1+EwKQZLS/bt32JvZKYQ+idgCKZEArmbzF+F+GcjchHE+0f1OnpsxS26JGlI40XyC0LvA3kuc6rAgamaMvAavs4yQvhRGhkrzAzRzUdB0+6G3zKA==
Received: from BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23) by
 BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Thu, 16 Apr
 2026 23:30:10 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::d5) by BYAPR01CA0046.outlook.office365.com
 (2603:10b6:a03:94::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 23:30:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 23:30:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:49 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:29:33 -0700
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
Subject: [PATCH v3 10/11] iommu/arm-smmu-v3: Introduce master->ats_broken flag
Date: Thu, 16 Apr 2026 16:28:39 -0700
Message-ID: <b4344b8d30a75d5d8d0acdbd9f038d9cddb4147d.1776381841.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f18b5f4-6b3c-493e-4433-08de9c10198a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|18002099003|22082099003|56012099003|11006099003;
X-Microsoft-Antispam-Message-Info:
	h8/wZ0WnMrzk7tyGjFrjO44ziq1JtowcO8qrJvr2liKfeFIl114o/vSEYvKHvOH7CMxYCs3j9x6GzC+IJG5CV/Z3lBQ5ZaHmb4j6tSup1fB+3pB/E2QPQFAe2H640lq24QpuMwGy195eyM832Qm6yWCo1RnK0FmswVCoccDeZ275ilG+NPK3eYxAm1ha3M3mM/o+6jr3cBzICfEQSAdkOod1p3jX3Wl4ISlBYhz70R7lCQmFbqaXYBCXn1Y6yW3Xs8qrmfeLn8oxcxGYWdO8/qby0D7mhQ2fshAHClRL25tUkIlgCPqz7Wc0Y5jluRzGUHhMeHr7eWNc/E4BPLs+hdYx1xymFOiRQ0hANannaJ4DveoFZ4ZfBPUhg+kpzJHM9VBj8WEytHAUlMeGsbuYU+C6fy7bNv+tthojQGsgg7k18qIl0UrJkgy/JQYEgdG3NJiw7POr8cc+naxG+Avi/dJSoOu60mqS0dcXfhcPGMPiCFmc5peDHse9TXp0olDkkhOqyWMqe0dHIQj+8twBfj5UT6iH0KeGze0/3rIQCAj5cCcj6kOipDUTEyMfOIhqXsYXoye8emBl3VngcEGUek/tWZEIK57LSlg+EJ6W35Q2A6T4O/8JpskHtyDAKQfCDQeQh8WXDt22A1IKfPm1t9ZdmEI5vjtlhVS3xZ8zikvPr0lZ4yuVrntOsXHw6bGrpXVNBpG+2rbjqQGajB0hdcdR+JFutXzvqVKp+FDjnwEpHgS6lCP2xTjDMBOtoyYg/4PA6nZvL6oxRSpuIegoHg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(11006099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vpJJ+3c+4nJnCG81mwHINtEH/cDkt0E6RbB7H1qynykpKINfr6xv4FLGLIHDrzAT409uUku3PxyMRGfjU8RF/Te6PQp7oybIEfpdq0enGJB0GLBlmqd/FGIKUkxmCB1/3glLuOpJA/vtM1sSAtLT+2U3a/C+nIwLEmLCw8mmuFWL+RrIeh13bBP0tKmdewNZagMCMU7KCl3Eq1AVjuIbdCK5twKsDy0WHt4BgozUu/X9dfmfexkhYCO1AuYFd5mOjQCIs2qpppNKN1JWgEeFdUOdDAvPncI+NNP4JvPz3Y/AKcz/H/SiZ2ROHhNgzoI/9lHnENLz1nsgB8SDJgBDXbaiLOmoo6KkBx4WzHwxB2gDJntvElE8ErfzqQpmMFkE66xlOO+822xUEhVQMFni9M5AzYQaPSwGMEHQPzdkR8vUtChmqg5CEXTYn+4tezkT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 23:30:09.4579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f18b5f4-6b3c-493e-4433-08de9c10198a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996

The flag will be set when IOMMU cannot trust device's ATS function. E.g.,
when ATC invalidation request to the device times out.

Once it is set, unsupport the ATS feature to prevent data corruption, and
skip further ATC invalidation commands to avoid new timeouts.

Unset the flag when the device finishes a reset for recovery.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 +++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 26e0ee0bb5b45..95bce9966374a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -941,6 +941,7 @@ struct arm_smmu_master {
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
+	bool				ats_broken;
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 13f225f704e73..5dead82cf1186 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2523,6 +2523,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
+	/* Do not issue ATC_INV that will definitely time out */
+	if (READ_ONCE(master->ats_broken))
+		return 0;
+
 	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
 	arm_smmu_cmdq_batch_init(master->smmu, &cmds, &cmd);
@@ -2729,11 +2733,17 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 			break;
 		case INV_TYPE_ATS:
+			/* Do not issue ATC_INV that will definitely time out */
+			if (READ_ONCE(cur->master->ats_broken))
+				break;
 			arm_smmu_atc_inv_to_cmd(cur->ssid, iova, size, &cmd);
 			cmd.atc.sid = cur->id;
 			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 			break;
 		case INV_TYPE_ATS_FULL:
+			/* Do not issue ATC_INV that will definitely time out */
+			if (READ_ONCE(cur->master->ats_broken))
+				break;
 			arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
 			cmd.atc.sid = cur->id;
 			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -3069,6 +3079,15 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 	}
 }
 
+static void arm_smmu_reset_device_done(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (WARN_ON(!master))
+		return;
+	WRITE_ONCE(master->ats_broken, false);
+}
+
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
 	struct device *dev = master->dev;
@@ -3081,6 +3100,14 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
 		return false;
 
+	/*
+	 * Do not enable ATS if master->ats_broken is set. The PCI device should
+	 * go through a recovery (reset) that shall notify the SMMUv3 driver via
+	 * a reset_device_done callback.
+	 */
+	if (READ_ONCE(master->ats_broken))
+		return false;
+
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
 
@@ -4412,6 +4439,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
+	.reset_device_done	= arm_smmu_reset_device_done,
 	.device_group		= arm_smmu_device_group,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-- 
2.43.0

