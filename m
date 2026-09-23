Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325E57F740;
	Wed, 23 Sep 2026 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194365; cv=fail; b=LUmyRJcKNK47/Z/r68W7IPxhuQjkKecs/5c9o/4/mShQZqI2ElY0zXXo/vOGkduvlH9EYP2IUbsT0kTDQ22d/Tul3D43iiEcTgPer/N1Gc04C0NZbxZ97G1qKD1OYYlHsYYvf7tG+AnwZp28NEGhhe9LrmVGVOzO9r37RD4DpTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194365; c=relaxed/simple;
	bh=PCVLObe71GmShPiAGx42oDiAXrfprBRtSfVQ8jbOD6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQrD2I9etf402tR+SBoVC69JCdk/Yl6Dujj4QP50mcyBaOWddB9ujUyoMt1/wvg4eh3cW+DaZbGfn3VnDvxont2M3n5iWjYxY7xebfkJxpGs6/IDmC1IrIG1SaoO1/Xs5O/ZiXQcRnWDkwGtMqxOD772Ut12DZdiTNgPSRdVXSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LoEWYUfw; arc=fail smtp.client-ip=52.101.57.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LoEWYUfw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCX+C1EXeTNqzT1gLlhy6u3FwkR7AJNAw2NMPvliIrtUEhb1++EOtB0ZHtzQ1Dxt6JJcTTHl7Iy2NfbnNwBP24JMh5tEdNjqRUEOQgRIxB58EcNw2CbjL6MZ2nzRQe4PGQqnm2goZ7AFC3dJ4xXUwyiI7SgLwo2AKLOZrFGY1qOOFhtmMbnam3ut7jflSliIx+RRYxVItdG7Pqje4dQBekCAyDMvKrmtN2BIeleZxEvxZ0BIRSfSF25euLZB76fW3Gy7DUVby07A5647j/G11wW90zd/pdybvM6cw9AiCM6Fc+ePZqlWk553ujwF5sMW7ipdJ9arPk77/3nq1iCyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b3IExpchjeYI+e5MUuRW90cYpOK26dTUZPzPuAGlR4=;
 b=hX16GwsH55sWvvyqwgyafGF3TiUfiPuIKxTtwrqNRmkbCoho1515eWqgAzraRjiVbA8FCEs2d/WFRF19kEA+/UaUkHsS12Vfnu8ifzbGducl/2JpK4UIkC5V/D0d7Vd/U2BFMYO9fT3Ntd9IzEYBq71xJaK89CR3komEKRRqMko69iq0Atjr64e1D8fNfjyv2G2px5D9sFOdtC4a+i5l+eeslml2ztMPsnOR1Qz2rCfoBnVHt2NHRrl/6d607MME1X68XiEOb0f8fB4rEVtTgoA+WV/DNN8S42qX8ED9ILWxKvGF6UQhhQXZQM3ghynf19ZthHs11l/EVAIrgD0Cug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b3IExpchjeYI+e5MUuRW90cYpOK26dTUZPzPuAGlR4=;
 b=LoEWYUfwvf7+sc8FAbzYgS9hUsyQ110sRM7i9XAsRPqHQiyqbKG7nphqYOgPNEafrnPbZXmC338vbY0M9GSuiwr7JElJjApIEapDYGsM29Sey9tft16O9x81pe92nguqJdq6zqnFypuvFh68cQ2C7bbZLiW2Xhb1LSWWer5YDg8eV4DwnQ6bLvheVvebnEr3QnjwaaxrGY7E84F67OPjrCiRH2amfg4u6VS4pIfl/gqmmrRfOkcz0UiltKRHZ2N/eSUiWIjVoCRuEjStoTo5ZW0AcRDnaCKLTKS+F6hNSuRKffUoG8m4l6f9NSRMhqPbXTIQw11VhC8C1p11UuaiWA==
Received: from BN9PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:fb::10)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 20:12:24 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::19) by BN9PR03CA0035.outlook.office365.com
 (2603:10b6:408:fb::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 20:12:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:11:59 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:11:58 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:11:57 -0700
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
Subject: [PATCH v6 06/17] iommu/arm-smmu-v3: Don't rb_erase() a never-inserted stream node
Date: Wed, 23 Sep 2026 13:11:25 -0700
Message-ID: <76c5f9dde30269995ef842a12a3a5e1ebaa3e6df.1790188510.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e4f782-9dc5-40f0-bb8e-08df19aefb57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u4umGZdUmBgN5LpUCANqodySTCTRbfvMLhrM/0GSRDN1KWg28OJ8a4UkS79ORY7e16mQYg8g7NldthOoD48qGyNjzllnaY7/qyJ921SlvEGdTm+RJ3gc9y4LWVwVFiseXGB/9DetMIOf/S3K5Bl7JO2ou/9Yaa2SThPGJ36JjeS+Qodoki0k6vpfvW+gcAwf2uk1Fd6V3p31laAIX85Zpv2BkjKJCnNpf6R3HQArYQamdFarC+jrEczXdPpa0q5vziBYAzQmYZXwTk0BoDkxbtthrwS2rpnBb9cUKwm4k9Nv3XtXSCyZhFDLkHxjAkejVK0327tWIPqPA/8h+19IPO2W3xgCI+U1mQHqxTLNju+TbVhUIYQwAKthf08mvVE7XVc6nPOq4Xy/CYnfnkRAwgIZHw4fbiv6iTGcy94SzI+W9QFMNFN7lZLgG0ah+59A5QDIr7v9vUy2I8eiSDeFDRqYLsUyyF3cv4TI8p891Ifpe6KuHa5BKua9/M1+oi7MlhN85kZWbPkf/IfCK6uIRWkqTRnI0/jy4xTxiJT2ypAFhsiqUo6kBX77rvIAPm1FgJ6akOfsSQukJnRAX25H5+V8DIcfIiiTSwiJyCX/DkljbPjxFMVaRDEG76TmSvO7+WQDcpaDvWtfNZkT4xN2sxXcMaqfn1UCi6+9voJe5yqqNCPqP1pbtLfXKJaxFKMop49rbYT2Ngxb4AfqH2pEGQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MIbUuEd1oa8wgYz/OOy+mahYejZg0hl/cFD7EpDRjA2WpLE6Yk0EI5TEv5U/1MRihxfqxVoTo27BQisKUnsprQVxfgNJAoDzjOindmMk74xEcCUyTMDKoaTymxpV4QZ0qs2CvaMRVIUY8rS885vMW0i0kOQisWYZJHDKElI6jBXB8JME1BdNIOdIUE1mI/shoVlpQo12zVnzbEqQZfIDOcDX4S96BclzekoGyz9NbDyIPIJoRD3u9Po2GpghBXlQ2aW8QaMH519pWrnncVZqOXsUpN4gmLXrNNBa4NTLaRJWF/zHxg+UybLWEkP+MHwyXhxjuoTEdceViUG+2R8yh3TEZrz6WsryGoEEVEoEVjErdQf5PyJNztOlEkHrUwJLRabJm8c9MhWIzfC8XLNzRBot7ojB4kZTIuAm9nI/tzwjusYzqcxOK7Ih/8bcQ/cp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:23.9837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e4f782-9dc5-40f0-bb8e-08df19aefb57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517

arm_smmu_insert_master() skips inserting a stream whose StreamID duplicates
one the same master already owns (bridged PCI devices can present duplicate
IDs), leaving that master->streams[i].node zeroed and unlinked from the
smmu->streams rb-tree.

Both the insert error-rollback loop and arm_smmu_remove_master() then call
rb_erase() on every master->streams[i].node unconditionally. rb_erase() on
a zeroed node sees a NULL parent, treats the node as the tree root and sets
root->rb_node = NULL, silently emptying the whole SID tree and breaking SID
lookups (and DMA) for every other master on the SMMU.

Mark each node with RB_CLEAR_NODE() after sort_nonatomic() reorders the
array, since sorting relocates the entries and would leave the earlier
self-referential RB_CLEAR_NODE() pointer stale. An un-inserted node then
stays RB_EMPTY_NODE() and is skipped in both erase loops; inserted nodes
are linked by rb_find_add() and erased as before.

Fixes: b00d24997a11 ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids")
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d..082da3dc09e56 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4122,6 +4122,13 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
 	     NULL);
 
+	/*
+	 * Clear after sorting: RB_CLEAR_NODE() records the node's own address,
+	 * which sort_nonatomic() invalidates by relocating the entries.
+	 */
+	for (i = 0; i < fwspec->num_ids; i++)
+		RB_CLEAR_NODE(&master->streams[i].node);
+
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
@@ -4154,7 +4161,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	if (ret) {
 		for (i--; i >= 0; i--)
-			rb_erase(&master->streams[i].node, &smmu->streams);
+			if (!RB_EMPTY_NODE(&master->streams[i].node))
+				rb_erase(&master->streams[i].node,
+					 &smmu->streams);
 		kfree(master->streams);
 		kfree(master->build_invs);
 	}
@@ -4174,7 +4183,8 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++)
-		rb_erase(&master->streams[i].node, &smmu->streams);
+		if (!RB_EMPTY_NODE(&master->streams[i].node))
+			rb_erase(&master->streams[i].node, &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
-- 
2.43.0

