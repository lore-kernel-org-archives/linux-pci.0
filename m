Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE64957F72E;
	Wed, 23 Sep 2026 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194369; cv=fail; b=eJdxjmK6l69hnBYrKEac+pqb6xBtQvkMGC4Rz6OF0H9JICj2F4X7TFCcuN1ryq8qhjcG3UdUeuTTtL3/7s43NOQyB+GVaoPdH4MnQEkrRc1Vs6F5PAdze3aHvIesOErnHfUDVOv9+sHL00243Dc9kEskaRqFVteH/E7YDCsVMAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194369; c=relaxed/simple;
	bh=+fm/xNx7xVYZNbuJ1oSrND8sQslsNSkUCRIXeqP9FBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EE0erymsPKNA7PvdEhU4Ql0uDWXfOYs1caDtTmMWspDorylBelhZ7fUu0tyh/tNehQvBKTINQTRNFzNrgp60TIGA5lx38e/MTcvfr+T9d+CWyoWQdKLqSpSa+W13WkkrRENybW5A5ckhJK7rsuHVkGQlVALNtioNc00Uo1ze5JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PIkWlKFj; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PIkWlKFj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmZ3sclxMWBCi58RVlptHRgsiJx4neWnJTGtu/xTd1pJbsC8JGLtYlA7ViJy97jNnp5G4+E+cL58pfm1oT/aBj7fKKWaPKHCgX/TywkGk1eslk3wSmS10PEe1oJopXo/IMSXk3+SHVR/OK37CX7lYgJvSzwTX1Mi3hkaHRcTYbI5zLDKajjfua8Y05hUbGf8HIshjoQ20BpyMngndsB7k9xa+G74j68hyctZ7b7Kk7Dn3Y/ToHtkq4YiuJnLElzIfHY68vCo8xE9M6w6asg7uXq/D2itlMuyTATVnWPp6+CLX2ApuNB/BH7R/AwLgzvn8bUTuB/N4cL7R5OFyWTacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSroU4LpTT5P4x+9bRTYRW1ncSdvF8ier3tLikt0e3I=;
 b=FAf83khimfaUsubBrv0Uzdk4f1kX2HEZqggpwxQXsbb/UjifTa3AtOEI8NewoeJDyhjmu67LTnEdp2e5sfkt517GvuiVOSG3f8hqbyNhM7HFbn6e4p0NopuL/uR49tvFS6utnTD9rqWODE7IMiFehI7Jqhja09JloBXymX+pfNXyKJYCoZxG/cSVmrEHh4+1bMMk8CAiQqXom4Bfa5OP/09ev7K6rINZbko2MwdiW8RkziiDYaKRATln5/Dlj1H0ypouwD6DXnps5wW+UZ340TB5J3XnFAsF4husdjX3wAL67kyXl+vYuyn37pDyPlUOQ7fFa6b8m7IReYZdVdMR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSroU4LpTT5P4x+9bRTYRW1ncSdvF8ier3tLikt0e3I=;
 b=PIkWlKFjh/MmifwX8k2w2UkeHys10+ma6yT740pvZZNofnMDLvrgeBlAjOIr871HnB+Vcyv1YzcsNOq6bhc+t3h6eJDMTHDKnG0zal5rjXftrPPJbcx0jFUujGY9bjdirGYUG75Dj/Uq6LfBYjZQWqZFY1fdOrwNyJVtEyGNg8LJ4GuqNncSBLS9BK6dzqyObgBwiHzFY2dEN84E7x4rRRv0/Um4zstqX9D2Yg3VhfLPD/pPEqhMFnqrhU+y64H/p4eK4ca7BZfyeF/viGiGz8vJnWmsomfTM9fMYm3TWlCsjglQO4/ktTN0GiCH2geIZOYV39/Oz30y+r7qXz7Bvw==
Received: from BN9PR03CA0166.namprd03.prod.outlook.com (2603:10b6:408:f4::21)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 23 Sep
 2026 20:12:28 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::76) by BN9PR03CA0166.outlook.office365.com
 (2603:10b6:408:f4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 20:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:04 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:12:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<vsethi@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v6 10/17] iommu/arm-smmu-v3: Recheck CMDQ_ERR in tegra241_vintf0_handle_error()
Date: Wed, 23 Sep 2026 13:11:29 -0700
Message-ID: <ad6d88de275100a5dbf2e78e796a8c88e2b5a879.1790188510.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdde52a-6985-4659-aefe-08df19aefdb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8skM8TVyHpjekN2yA6Sy3v6wS5RRYGsCtSLPIAy+fzA/nlYGMES3TwjHfbksaALBS4y9YuLFdQxDnYI8/7FppaoleTt8Sv7LmIzkyVybLZhj2nQcwhVa37rf+Q7aNhs6sMfWzBehF0KzY6qPDNjCaNdhuHl1PCTceXlbocG9F7ESK/M5h32GAYaZoOywFBdm1XNM2TkhSNh3p6lHoNmFPcGEDPFMR6Rd2VJ796ZjS7O/NSQFl2i6T7JfQZMOryBaoKlWgw+N6p0JurvBOR7l8GddpzN3qi+ETBwUh41fyp2MyJV9BrtkAp/2oWI8cz0+JBoGDLHljWIKYxF2d28LK8EO94ms6v9vPYQZPbT9DVfp3Gv4HVnRJQfY7oa7K0t/mtURL8rb7mKUIH99SJNRi7QVIp6jRzmYlmz0q4o/xvnacN617Vwzb7yCKljf+c9kT2pzYH/w0hBhv2q2bBMcXFCArXiIcbV9pUbmFioJqld7f8pYiRQj3/xzdiSvQKDvHY62kR5O4rtBom+nDYC2v9kRu3vA1FJfFJx/gWihISbfbQ3tvDcfAgzfAnYpnqwfbE1uWWOs44cSGe03fvofpdg/NYQ+uo6I/cyL5lzTfDOVx0w5WH8yIM19OLxD9yBhCf4T5GNx2a3ATXF1Sx6fNWoYmNK7QJLkNFMQPqbbuUihnQqcHHVPbs85wBJ5+1uWDkeJofHDumgJavgaNxDoXQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TRkhJ8oR4g69oX0+z3+o2his3xepR/ysLy+md/rQCufaeNqcepsjH8gBMuGYaIwPevE16CZi/sge1t/5yCycxI2yaWAnmAakEFQxEJMFkIOSuVtLy04l3I/g8WLQWecYJNli6s4qB511AgU7ypPZzVeBORHl8Doxdmaelp+n7Wf6RxTQVsIC0JsAct4Ty4XwpeW+ERsg2a0bzVonXGZoVOk6EgdVyRLfq7twpvO1WfTppi/VICrgHodeORdDLe38kC+RLmFrdiZtXvaFeiX5LEYIVlYRjbbie5uazb9hugalv0mOE0dhmEylVgazBM8N7gnPLfs4llbilpCtGOz9mGwQgHbxdRw1wcNGiaV1A9p/hif8CUFQe2fsQTgfmUHCyVGVV0pEG/SnpYsMnxQA80Wec4sGjpZhe3+cPsFElxYS6nBRoWXbY2sjG6H1A/c3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:27.9662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdde52a-6985-4659-aefe-08df19aefdb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091

A subsequent change will allow cmdq_err_handler to ack a pending CMDQ_ERR
concurrently with tegra241_vintf0_handle_error(). Take cmdq_err_lock around
the gerror read and ack, and recheck (gerror ^ gerrorn) & GERROR_CMDQ_ERR
before calling __arm_smmu_cmdq_skip_err() so a concurrent ack doesn't cause
us to skip_err on an already-handled error.

arm_smmu_gerror_handler() already covers this via its existing early-exit
on no-active-bits.

tegra241_vcmdq_hw_deinit() acks the same GERROR/GERRORN pair unlocked, and
the error IRQ is live from probe, so a latched-error ISR can race a VCMDQ
deinit during a device reset. Take the lock around that ack as well. Since
a user-owned VCMDQ never goes through arm_smmu_cmdq_init() yet does reach
tegra241_vcmdq_hw_deinit(), initialize its cmdq_err_lock at allocation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index a595769e7ecd6..cf008bee213c4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -323,7 +323,8 @@ static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 			unsigned long map_bit = __ffs64(map);
 			unsigned long lidx = 64 * i + map_bit;
 			struct tegra241_vcmdq *vcmdq;
-			u32 gerror;
+			unsigned long flags;
+			u32 gerror, gerrorn;
 
 			map &= ~BIT_ULL(map_bit);
 
@@ -335,9 +336,16 @@ static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 			if (!vcmdq)
 				continue;
 
+			raw_spin_lock_irqsave(&vcmdq->cmdq.cmdq_err_lock, flags);
 			gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
-			__arm_smmu_cmdq_skip_err(&cmdqv->smmu, &vcmdq->cmdq);
+			gerrorn = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERRORN));
+
+			if ((gerror ^ gerrorn) & GERROR_CMDQ_ERR)
+				__arm_smmu_cmdq_skip_err(&cmdqv->smmu,
+							 &vcmdq->cmdq);
 			writel(gerror, REG_VCMDQ_PAGE0(vcmdq, GERRORN));
+			raw_spin_unlock_irqrestore(&vcmdq->cmdq.cmdq_err_lock,
+						   flags);
 		}
 	}
 }
@@ -477,6 +485,7 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 {
 	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
 	u32 gerrorn, gerror;
+	unsigned long flags;
 
 	if (vcmdq_write_config(vcmdq, 0)) {
 		dev_err(vcmdq->cmdqv->dev,
@@ -492,6 +501,7 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 	writeq_relaxed(0, REG_VCMDQ_PAGE1(vcmdq, BASE));
 	writeq_relaxed(0, REG_VCMDQ_PAGE1(vcmdq, CONS_INDX_BASE));
 
+	raw_spin_lock_irqsave(&vcmdq->cmdq.cmdq_err_lock, flags);
 	gerrorn = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERRORN));
 	gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
 	if (gerror != gerrorn) {
@@ -499,6 +509,7 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 			 "%suncleared error detected, resetting\n", h);
 		writel(gerror, REG_VCMDQ_PAGE0(vcmdq, GERRORN));
 	}
+	raw_spin_unlock_irqrestore(&vcmdq->cmdq.cmdq_err_lock, flags);
 
 	dev_dbg(vcmdq->cmdqv->dev, "%sdeinited\n", h);
 }
@@ -1206,6 +1217,8 @@ static int tegra241_vintf_alloc_lvcmdq_user(struct iommufd_hw_queue *hw_queue,
 	vcmdq->cmdq.q.q_base = base_addr_pa & VCMDQ_ADDR;
 	vcmdq->cmdq.q.q_base |= log2size;
 
+	raw_spin_lock_init(&vcmdq->cmdq.cmdq_err_lock);
+
 	ret = tegra241_vcmdq_hw_init_user(vcmdq);
 	if (ret)
 		goto unmap_lvcmdq;
-- 
2.43.0

