Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E6313E24;
	Fri,  3 Jul 2026 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051693; cv=fail; b=qkLTJga2rjNpVQ7Q8AMiQFngU5gOgLJiK5bIiRnZswB3qy9iAmQyf3l9XDWaLFlQ871EttIAiW9svX7CGIea2BUCBShPqJ7e4Njd4L92Ur5QChtdtb3LugOf8IrjzzIZ1eyOH3Gg6evhhigtz5hsn8tgBG5G0MbozoGCCoWZl0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051693; c=relaxed/simple;
	bh=Kk2zimIdMs9VAcH36a0TbX5seDWHpTpeLE+gAbzawO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlZm5NCR/TTb7+Pn1YnmnLF8KYLiDl+LjHPee5P75RBDoZw0lzB57uC7opvj9NMcGNOuXlyWa8i+0tPf5nFUBJlg2gYQ87396G+4rLIUNRVEmSQdCr2Lnh0xUnp0uwJHyYObqb3kI+qo7razrw/gLscfHunY0dxdWaMAIHP9SPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yrtm48vL; arc=fail smtp.client-ip=40.107.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yrtm48vL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJsY/9rEDqxWgGwx9+njyLhdDfLRGJ3ABvHKgV/OCZ8STPioMhkRv3JOUnyO/tfXWt80SSvFDgFbJlUyyjt6DnQJbJazHQJ0jrKSCL73sd6k1MdRxTm9g0erm4G3dsCpdNXD7xZaRHgNGpOYxISL9sjxMSB/t8ex94wtWGpdF8Xe/hPPr+BNAWnptKdQkbG207eZp3k+fAKlEyAAU4m4x+3nhXBEQ5fFko60Mmz7mgVxT3wJ9b9AsiZxzIfbCild5gplMPkqQMnFfJ69M9cvamP1/i+JW3Vv8APJkeKFh8S81YzawEtPmvjKcf2kD1FrOWHPgQbaCmLvFNfo3yJlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyVuYfE/WcbSMij93SeiSMGhOsfNeY61vOvafw2essY=;
 b=IhY/XV78b0nRky47ZmKbx0T8e2NiSUOfcj8QqWmnKtD3YTe1HIIViUCVHB1KrF16cWutRmbaLzoycWKQUQC8X7YIIz+PTM5vfaHiwfSLojwNHuX3I69FmAON702p4FUlpwPDNqe8hBguskDryqwdeJB2fK+/a+qRclbd0uBt6rQhr7SzCsyuYmYvhf8u7e3XOpfRbnF//UVZWcM5kLlNhsVHU36cvaA/v7pEHuVpElJpEedIVXr8IXz7WEQJGNcYpbRErzX58zH0VO3hwg59EnhHxCj8sqBwD+Hf9F+JFpRdl5mZuyifo2YRIdw30vpG5SkxWaH/bkYAZuFNIbYzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyVuYfE/WcbSMij93SeiSMGhOsfNeY61vOvafw2essY=;
 b=Yrtm48vL+ZCxWvVwq2NQHOlWctFLqLrjucbiSPJVOpVzFqmOkRw3y9m762P0O5cz9+F1ilpijBcKrDOLx8Pv4PjeRgWp09XIkMd5T90c6O5xQX8ek4Zp+5eqpRdVKEdiJAm/7kxSbnQgsIzFR8Gc9N+1yO1FK7KSx0ePl6ZJEjeQFtvYEJEdSQ1l3KAzKO/uxwmaIfPgoS4idw3zbOLlOi9aKdPi5gryuHn/CqN57B9ZMRCafCeMnV09d7BoTxTht5c7kV5lz/eSal4qcY0BNe4k5rtLrjBcDJ8tIufcLYKb84Tgxexq4bbypjJlsloGL9+dnUVxtrgFepIeqBr25Q==
Received: from CY5PR10CA0005.namprd10.prod.outlook.com (2603:10b6:930:1c::18)
 by BN7PPF0FD1DEA27.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 04:07:53 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::3e) by CY5PR10CA0005.outlook.office365.com
 (2603:10b6:930:1c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:07:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:40 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:38 -0700
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
Subject: [PATCH v5 06/18] iommu/arm-smmu-v3: Don't rb_erase() a never-inserted stream node
Date: Thu, 2 Jul 2026 21:06:31 -0700
Message-ID: <9136477b9c737a50cecc38f2ee6704a01510169a.1783044582.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|BN7PPF0FD1DEA27:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c24dde-4a56-40e0-ba54-08ded8b8a7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|7416014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	2dLLXqvIoS9tkb7dZLm9dwI8gT8LP0bGblJ2iP9CaecuI9tSWDsXnX0B37UxXhkq4dFlKSs+sEoFRYoYAai9CN/6vX4XFujEMqGmRjTAqLkLqnHw25gYV/ri4nRj5ASxQd6GQ1JbuNxOHNeLTnAb7JotMEoIVzNqwSbNLLe8xbrrSaT8AJulb1DvHVs6nJxIOS5rr6Iyq8grv16tP8WbFFBNISAmJOC7OguHN5ChVCF/pWRcoQDQ5a7Y9+V3V1zm/oaN2J5vLDi5hfX+15yidldeRaVQ9uhiz+CTMbhlnLQ/XYLhGzaWhclBWfuloQTNgXUVI/3zrdfQysl1UpJYNMaGZ7W7G2JMmgsyrHugQGZCQwfkredwOXfSBXcPsxKJcTIqNFg/aoWWTQ0oqfoguoUJaF1rPzVRkiE5HVhhTqYdHkKVL10pDzKFdQ3P8ztq/FFim17WUkeqBkuHzbV7a4mlGGW0eyhx4eyzgegKmIoXWrLsrxRQs61CK0kFBeprowXV5jc5tucz4LOJQi8hECcmAtsvR+EtCdlmfMQwvpmYpA9HI5G+tSBgUsvrCKPD4+Wx4mEUQAdRZ/ku3Ugm++GgJFlsyZdLEaiwfPgHkz6iJptIQXghZzJXWFm46AhocXmMasXsL5zIM9PCBt4fU94PptSDyAmNHry0x6+7Yew7c9a8seNg535+lmAQAJoe+EztBkYUvQ46An/a8opvAw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6gH+R00lbbRsf1qBYYsXf6tBMqng7KIxtN1KohzXFlSvm2XeLnpMda8nHwTgOewW67d5WVuZ47BLQvOKvcJPlxhvjqKcZwQkFd8rIbZ4OTDgUFZ/DSaIme+MtM11UpSztLeKdWiM28uqNBiJT6wBg5amDszbLIPoyfeC8dvYnLkkNWdT2GNLBlRIpfR3CH3wLhdDDs+8NbVtgxTA/hq6IzlIzuCOlpziAbms3uIHjJxf1jtD8gmYYi/9ihYMY8RYU9a81K3jTq5+T8SNkpO6/M42gFPwVt9eHSLGhP8o/bB4WTHF+h8T1QU8jSv0rFAXQivs27rkswKoc/CcSs0AVrgXwnRmy6FbVAhKQbb4e59Nyq8wFmoJ5gOoBt7o0OdGeiN6B6Q9pRpWnR5kqVGfnXVva0KsE1LkKHwQEL95XVmlGY+ylkKlcvKasrb+4582
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:07:53.4304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c24dde-4a56-40e0-ba54-08ded8b8a7e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0FD1DEA27

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
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4f..d9734cfe6f989 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4051,6 +4051,13 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
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
@@ -4083,7 +4090,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	if (ret) {
 		for (i--; i >= 0; i--)
-			rb_erase(&master->streams[i].node, &smmu->streams);
+			if (!RB_EMPTY_NODE(&master->streams[i].node))
+				rb_erase(&master->streams[i].node,
+					 &smmu->streams);
 		kfree(master->streams);
 		kfree(master->build_invs);
 	}
@@ -4103,7 +4112,8 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++)
-		rb_erase(&master->streams[i].node, &smmu->streams);
+		if (!RB_EMPTY_NODE(&master->streams[i].node))
+			rb_erase(&master->streams[i].node, &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
-- 
2.43.0

