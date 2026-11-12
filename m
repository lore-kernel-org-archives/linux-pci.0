Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493118;
	b=U3ATGjY9PAAOT92MYa6yKmRB60k1hzhPbayL1I0iqQ4M5bzo+NnPb3P3DmD6QXAIaV/C
	 aZuAEBl2cC4HSsQT3GRSRNIw5UEv8pRRVzjV9OWT+Fq6D0/FzkUMtMVQ/kw7D5LKjeuc3
	 3rRrbX431k80BhjkiOJEDWaJOR18oy3VJCQGk+DUlxOF1MFDrauP4DlRP1oGSU9CCIwio
	 0rlyBeG2ALN7FSGB/XaK9nU6RqVjeRmbuJZgAbnPZdY7vLVzF4zb4EFIUCvIBdyxOdA3j
	 PYLljv6V32JunNPF/wFydnSeRvaCFKqnoD1HYX4e3ZurZ+H+7P4jg40JCNQmclVY5xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493118;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rbWedsiA0P6jZ+Vw2/8Gk4BPYlKUnlGNUxl1C6iJ110=;
	b=HQU8Q1X/qSV61LiPZjo7mgroLRng6C4hjF80+gsjYAtDmgunxYUnL7t9zEJFZ4BmZcDJ
	 zwdC0U8Y1NHEdnUzB5Im2TiEuFY2ATT8WtEt8KfQslt5Af6lWioDRxp1Dml436wQsj4pp
	 C1hKaxxm52c/4XgaL+amUhU3WhjwwHHUQ+UwTMOOPR4BpxeuM2SS7mQfysKt1N+rfVzHx
	 8HVGTRlC5Z93rn70SI/7F9Uazy1yg5s1nmIkh6bbovnINXKqzb2gbVJtIQ26oIjJZ0DX/
	 UZCAi/OJNsTG1TWIXTogTHEwtFIJU1aknd3zCptzRHSkKX+FqNQ8bzCgqE7BQJHgMxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PTBNaSuL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.65
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402C60A2601;
	Thu, 12 Nov 2026 14:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9402C60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PTBNaSuL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpf9LOTvSQ5PvmHCbItWuywAKXk/ISi777CEpxYEkooRqb7AzOqi4QDmfqk65RjLZGr6cqVe/S5azwmXb22M9o8J3kQnKrGbIQDqrlPn2oJouGBdcnTHzToWmDczTZN2nB81k2KaIUZxwbiYv5xe+qkOVp2M0f80Imc2X/RdSs69syqG/7sW9b1cIPA9RTUqLmQiXZy+6iU8SGBoQF0uKebN1pBRlbpcbiLibwzGcZPvDn/RMkKb7hHUg8/srkys/d63FAUrkRf4kHKCSD1rspavW9EEVxseA6u/4/Ne3iiI8piR4E4IDcqml/nb1b8oJjoQmA7x7kaqgogPSbT5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbWedsiA0P6jZ+Vw2/8Gk4BPYlKUnlGNUxl1C6iJ110=;
 b=eZa013AHy9Csug/SSxmJ5yKIeaf7iAzTelRo6mi3ENJvBRAKCbfDogBCDjGWaOKpmMn+paBL2R1r41rq1L0VsjKEL2OeJamVr06J5CG5J3Szj2Mwsb9ecG3hcAJDxiQCE9mycqUnnXuR0QPElhQGsLSFpudOUujJzr1mSqbpVcYjWjzGgzaOEzRrkp79raVMAT5EIfsG1IUttf4Jr0FrGGx6hZG3mjOe8gukmXuNViwfMIgjX7rG7S7oBZ5kENj0NaA0UUF74WVQk9DP6ivEq6ke5f0vHsHM2c16y1J3V+WjHHU32bnclC6Wrm3CSjid2aZdLleyotpg6uMChDkfBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbWedsiA0P6jZ+Vw2/8Gk4BPYlKUnlGNUxl1C6iJ110=;
 b=PTBNaSuLXpZOIQjlo452exsgl5TIYZN1UrOYUz0o4130Teh/6M7JBu8RfUvkESFyyD9Osj/XZftH4iyRCayOfln9GHWOgkmoVW2SIskdnQjpUwMmdEzu54g+Sw+nXXk9s+gUzM3TCbRkl/Brw0ILTttdh1PXs9KkwKHBHvhctoixjR4BCbVSr7XqUXaS7YzzygnYRVvQ7DBDgV/m6hvsvIFt4MfSJ3WO4fDa5QlgX7WBrRoK9+QGeP+IoJhSLiBO4LLIn2TypgmVN9Vdjjf1foVHjVQSBDgWauJQYlMafHalJc5gfqScobeUFuPTKAOXr4ReYfrxHg7K7lnKeU2xcQ==
Received: from PH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:510:5::8) by
 CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 14:18:31 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:5:cafe::7e) by PH0PR07CA0003.outlook.office365.com
 (2603:10b6:510:5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:18:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:08 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:05 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 07/20] vfio/pci: Use access ops when mapping BAR pages
Date: Thu, 12 Nov 2026 14:16:19 +0000
Message-ID: <20261112141632.918954-8-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112141632.918954-1-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 4205ac55-db92-4636-482e-08df40c7d3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|261009223027099003|11063799006|56012099006|261102130727099003|261102123227099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|261026140227099003|261022113327099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	JIqt1K8qsZVLl1canKk27e1ublO30QnbORLw+oUZb2u/oNr7+U5CJzyp5fRZp8sPMjIzWasoJp4ZxvzI5iDI2VNGg9M4m7ko8RSLXvazMOmdnCWeEJjqJTUzMT8J73b1NubaHSWaRc1WdJMb9u8PXsATLfOZCIIWmmDwwAJUEgYTJdBtsmIUe6XG+wA/3jGeK8hNV/UA0LZNH2VGFl+exHxxTd93axqFc9oycO6RGwBbWGHyo94yBqqw4DLOZLMlco27BF+F6LX6anBe1Tqe4PWCNKujYqK+zvseUxmqLcZrTIInaDYm6NvuH/kT9fvxGYuNR1THUbqaieuWjc1cfHiy4dEEX3cRnNK6Y3U8m/Z/4aymldbIWnffh02oqAJpRmgMNa+ZiTMWoA9LR58nlZJFE+CWjeiVOv/IVa53Eq82YN5mvpb/+49mKwMxOB1WXMj1QK0+iDCThNKyfFinB3cHpFyYacg0j1HoM2FveSKq+H+26SnfzegPdYDFO1HDDfUCVL0+Cxew61p7nLziamd+VYF0QMZICWFyWYK4f5PFQpN2dIBP1m4+Yx4hFMMmqfZL8yKwmTq/KaM4KuVwoGJqPbI2yY68kGG8NAH6TnTgdbyIZVuilLGOXQSgiEEASG3tZwg265zxsDsKcGUGcX5Kj6zAfydyjBfY2eKNgTGoTXVVZmUaJ1MiPGtk0LZMGgNj5Mp8vZf3KyBQmVUEBw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261102130727099003)(261102123227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261026140227099003)(261022113327099003)(261021121427099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AQfFMzgcmKV/Qhzt6mugU2Vfs6ilOPsxcqB1HrVz6Imh+BWYr4NhHRj1RkhN67aXsvXz3BWi/PdcOf+vf7mL8oKqZnundr1a17iQQRtXHxqKbUDcNzfp9kBTTzCWHloQQZO83PHBBpT2FdekdUtt1C9tgntSj8ViMQHo2rNH9zrlOVS3D80jMjkd9rbNgAIYvQqFriDILuMBIAwhIZ2vCZJbomjctomRJmzT8s1M6FG5HIFTC2QbnjFLbA1TOONmKigYshDmrDossKMJt3wwoh+xGKir92oBlGPqvbXY+PZaw9khXndrdosUlESZcxcPGP6QRCQ0Nrd6O2jhhQjyKynS23hfD7fXLksC01DLXRRSnQYA6jgI+ZcI7x0uWUUgnHWvO5YEoLJMmy3stgPTfoq/PI3Vh7AAhTzARf3xPNzBLsqMmym6xxTORYLMyRUg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:30.2298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4205ac55-db92-4636-482e-08df40c7d3a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909

A BAR page fault can race with recovery and install a mapping after
recovery has removed the existing mappings.

Insert the mapping through the SRCU-protected access ops while holding
memory_lock. Recovery can then wait for pending insertions before
removing mappings. If access is blocked, return VM_FAULT_SIGBUS instead
of waiting for recovery in the fault handler.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 21c0dda37dd1..b19721617e5f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1880,6 +1880,24 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_vmf_insert_pfn);
 
+struct vfio_pci_fault_access {
+	struct vm_fault *vmf;
+	unsigned long pfn;
+	unsigned int order;
+};
+
+static long vfio_pci_access_fault(struct vfio_pci_core_device *vdev, void *data)
+{
+	struct vfio_pci_fault_access *access = data;
+	vm_fault_t ret;
+
+	down_read(&vdev->memory_lock);
+	ret = vfio_pci_vmf_insert_pfn(vdev, access->vmf, access->pfn,
+				      access->order);
+	up_read(&vdev->memory_lock);
+	return (__force unsigned int)ret;
+}
+
 static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 					   unsigned int order)
 {
@@ -1891,8 +1909,12 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
 	if (is_aligned_for_order(vma, addr, pfn, order)) {
-		scoped_guard(rwsem_read, &vdev->memory_lock)
-			ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
+		struct vfio_pci_fault_access access = { vmf, pfn, order };
+		long result;
+
+		/* Recovery must wait for this insertion before removing mappings. */
+		result = vfio_pci_core_access(vdev, vfio_pci_access_fault, &access);
+		ret = result < 0 ? VM_FAULT_SIGBUS : (__force vm_fault_t)result;
 	}
 
 	dev_dbg_ratelimited(&vdev->pdev->dev,
-- 
2.43.0

