Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493127;
	b=W2BUDLQ9ICbGUyGf4CTIiVW110/052RbKa1A32nks5fr8NAQOiyHMPiW++nJdvkJbJrO
	 k8PjrZk3K+pwxzqimfDhEEEowO2UhAVokrowYSG8pu4EkpS19tp3HMNs0yh+2w67YK+e2
	 fEo2/x0t8R4xx+ttk+4q767+73W0mVNogrN2mBmSHYDxRmDB3nov2eNCwupvImSyTQzXP
	 4jfdUjHsm1UQ9lQUEqfXQb5BLv6UEfZcyxvY4QZi+xH7oh+DiePD4RAXMUe/nPZXxt/nw
	 YQOHWSnmgPfWpq88CkQkfCMRF6IEUu1OGqWdmbpcTKPSYh6y17xQYW+56IYKvvE+BGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493127;
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
	bh=Z7lkUT0o0KoKTMgRbqVhzgzuNvCmDEebIILrSmFUbSA=;
	b=BY4i2eEbwsB9t/x4fCcQML070VTF0Vn6UT/ZAXMn4ZOSW7Styyu+jIJyVnwE8lIhYNTS
	 qrwGJzthvNgZ+jbq5kLhsnr+3v7Bs+PBUARh0lWQKdAeYoYugr/ReigOZtVHC7DA16kXa
	 ABwxFajfngOZ1sMExurbG3c2swCmNJJ8K8dBavddahlbj669UX2lwYh0LKLX97u7AGSYU
	 4j5qek8a9HkH7CHsQY4MTPk44DzcLYoe7ova6btIW3i2+QQj9Tbxmxs16yGEAijdbQf7z
	 hqIif1pTpb3Cz7/lvvyff2SJ0mvvyLTTAYqz326CxFgY2tRZfG/0fvXUagiqbRv9Vrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l8XT8oBr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.70
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6F260A260D;
	Thu, 12 Nov 2026 14:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F6F260A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l8XT8oBr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHclWYAp/L6UIlqAVBSumKJ9hL+FCl7x/PlFNTZJCkrgIS5I54FbBnd7nukUuPqb+ZPeV/y3CSKL16h6AGqKhQw55V3PnidAq+7pF4fzLK9yUBOZcviLVe/tpJlkxIxxBG6qJhOM5iFbJGEfQkSKrkO18h4PqJKol/HsQiFKRXbQZiqZwNY4pERv/Hxg86cYkyrT/nQi4HkdwPe3OxpSjch2MgI9lY7szhmA2vRGMQfMYOpyZ2LnVvV8e/kuWJHMDkMtpp8NhZ/5TYfzZoDdQxge/VFm1fJgaKKEQOfT6QlSCPNsIjMTuTgFQwSlMK+zQ5Hw/q1gkqsZiGoYEkNa9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7lkUT0o0KoKTMgRbqVhzgzuNvCmDEebIILrSmFUbSA=;
 b=nnqOP+0bG8tNeB6yDZVKfkUoqPvAq5j5Cnxeob3noIpZ8x993u/4OXpENmxQIcQXEgrNIlgGb/VXXMDQqWsoNj2H+RiQHUr9g5jDJACACkM2WIIHeYb8QYz9uvTFL3hRxiKgr7IPrVq0VZICuYD7LzwlZSlG7tfVi7dq0pTHpIqMtsGNr3gLso1kLQxsC8NCqttzSoYbyJLhjCChof9paf1nqv9rig1hh4js++RxjO6QN4vk68ozXUXtmhPtYgXRuVHXnhssFGNpKod8x8LL20cICPGsj4wSsOOZ263FJwetZ7dM5hoLg6iRK/SAMqsqZgck1qoSVE1LMv74qxIEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7lkUT0o0KoKTMgRbqVhzgzuNvCmDEebIILrSmFUbSA=;
 b=l8XT8oBrZazT3j6lB2DlSz0DSZxZFQxtc4115v5AvTdrlMU/Jw7N1yUMkEKJLYzl1zxTwvjLuXCVng00zAG3ITs7YszanlrH0vHWXWURNxoZ7nLWuDXXz8UOH/SYml8aBVJ3G0DGBY3htOUCIpshaefB6miBGeQYMcgluF0AO32y8eiaLhSXPxMqahjHJ8QUq8+w0Vu7hmog/Z/Ekxbp/T8F+B5Nu4Ei4RuurGTQBLHrNe7yoR+exjGkDKlQ6odxZlIFDUU9avIUpoMpGeCr6Gh/cvkoE4NPennGH4nAMig4FS2YhBRF7x4cHhkD3N/28p+eFgqcBzPz1IfC4nKzbw==
Received: from PH7PR17CA0023.namprd17.prod.outlook.com (2603:10b6:510:324::24)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 14:18:37 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:324:cafe::9c) by PH7PR17CA0023.outlook.office365.com
 (2603:10b6:510:324::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:18:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:13 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:09 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 08/20] vfio/pci: Use access ops for hardware IRQ operations
Date: Thu, 12 Nov 2026 14:16:20 +0000
Message-ID: <20261112141632.918954-9-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b672ef-e2ab-4f1d-35bb-08df40c7d75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|6133799003|11063799006|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|56012099006|261021123027099003|261021121427099003|261102130727099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	AIhLCOVBvcUR4STS9xzk/f4YW6X2gId06OAywdlvoRBWlx+P2ELhfNCtAsgpj8HOPPNArUHW+bW+5b/0Ic7d4LZrWmyEyStzWQZyFJxt3aWS5B0NK88wIImNA80WohrVzntkaoqusI2lPJlGUYGEqiv0LNy5qk3Rv63HBqA6k+xXu/6n8gp2MrbC0F1WtdClPfNqpbmRjFUMXN753DKhi8jDJFuIrKXY4NpGlYDV6JYsbePb6tbOxqit8xvHZFSFUvQ4XHKszNVCaP40bvgK+g8wGATVIBdjuSqpgHpKRw1f63Tl6v1fkTVgE6li29AUrVq9oF4lytPYN3Cy/xkU9h+fm2WYzTzz59X8MhaK+JcWWlaTt7dVeeEKXhOrrHineKM/VoPv5kP7IVEMGseXc/TmXZCPCf9NZ23lW6BtjZNZnAai9+fQeZb3cu4rAFdkbNIvuDa2OlC88JDFZoxdQGMGXFPR4kio1OKRMWYCp5OJfmOCi1jo655ma/UNV9SADhF9CyCHySjzR3+hUQHVzDEE8ssZP080x5LfaeqeIG507CpApaYhW0O0mmsVTgcOO3psrHWDGhQ8lDv6NEbYCy/rjokxvljGQ+HSBrhGrHscxbMS18jtobXFWEVT9KNdkVojmU5T2aDkMS4hkEQInTqTJmsr1RLHWqeDRpU/wRwRp6LTr6r7ou7VQoo4cVpa+ivOiby96vkVt/EwTClmiA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(56012099006)(261021123027099003)(261021121427099003)(261102130727099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8nz31UXmZ8x2TgIAYGuFoPDsPcwU5dv8vo55bCGLIaniPBuhArARFh5vo71BC5nfH6ZMf931+JmcdAefbzaluShNHck6+Up6uQsylGTSNqRq7k663w3OFumWH+tuXA3mC04phCgdVxD1HisFP7ZHrtfwpP246U52j97ctQWsgOqYYIooyj/HWSmAKIG6Wzg+Le/U2um9XUjlo9Uf6xJg93O6QW/YnYDgAQlY/TZsJ0Vs5wdrhdOsgSlcfG0SlVpZzwv258b5fxtcCIupe/w0mD9bDEeOvS8IjkpXIMUTWLQyr956w+nV3BRMb8N7/nxr3igxnkTKaeC9vPa+VlTiCJ6POY5UiOs0Qiq5D3W+HiXf9xNl4OhXt2eN1wmAMnEYlXKRUTM5HIlri+mmvmfqXQvR+cvg2pYpR6nahbapiZJM00B+kJeb83z0LLvDRlng
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:36.4544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b672ef-e2ab-4f1d-35bb-08df40c7d75b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849

IRQ queries and configuration can access PCI registers while recovery
resets the device or restores its configuration.
Use access ops when reading hardware IRQ counts and applying IRQ
configuration. Continue to hold igate for configuration changes.

Use separate SRCU read-side sections for the count query and the
configuration change so copies to and from userspace stay outside SRCU.
ERR and REQ operations do not touch hardware and remain available while
access is blocked.

IRQ teardown flushes the global virqfd workqueue. Waiting for an IRQ
operation to finish therefore also waits for that flush, including work
for other devices.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 78 ++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index b19721617e5f..de3a1c8b6d9e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1342,11 +1342,33 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_ioctl_get_region_info);
 
+/* ERR and REQ do not access hardware. */
+static bool vfio_pci_irq_index_is_device(u32 index)
+{
+	switch (index) {
+	case VFIO_PCI_INTX_IRQ_INDEX:
+	case VFIO_PCI_MSI_IRQ_INDEX:
+	case VFIO_PCI_MSIX_IRQ_INDEX:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static long vfio_pci_access_irq_count(struct vfio_pci_core_device *vdev,
+				      void *data)
+{
+	u32 *index = data;
+
+	return vfio_pci_get_irq_count(vdev, *index);
+}
+
 static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
 				       struct vfio_irq_info __user *arg)
 {
 	unsigned long minsz = offsetofend(struct vfio_irq_info, count);
 	struct vfio_irq_info info;
+	int count;
 
 	if (copy_from_user(&info, arg, minsz))
 		return -EFAULT;
@@ -1365,7 +1387,15 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
 
 	info.flags = VFIO_IRQ_INFO_EVENTFD;
 
-	info.count = vfio_pci_get_irq_count(vdev, info.index);
+	if (vfio_pci_irq_index_is_device(info.index)) {
+		count = vfio_pci_core_access(vdev, vfio_pci_access_irq_count,
+					     &info.index);
+		if (count < 0)
+			return count;
+		info.count = count;
+	} else {
+		info.count = vfio_pci_get_irq_count(vdev, info.index);
+	}
 
 	if (info.index == VFIO_PCI_INTX_IRQ_INDEX)
 		info.flags |=
@@ -1376,19 +1406,48 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
 	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
 }
 
+struct vfio_pci_irq_access {
+	struct vfio_irq_set *hdr;
+	u8 *data;
+};
+
+static long vfio_pci_access_irqs(struct vfio_pci_core_device *vdev, void *data)
+{
+	struct vfio_pci_irq_access *access = data;
+	struct vfio_irq_set *hdr = access->hdr;
+	int ret;
+
+	mutex_lock(&vdev->igate);
+	ret = vfio_pci_set_irqs_ioctl(vdev, hdr->flags, hdr->index, hdr->start,
+				      hdr->count, access->data);
+	mutex_unlock(&vdev->igate);
+	return ret;
+}
+
 static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 				   struct vfio_irq_set __user *arg)
 {
 	unsigned long minsz = offsetofend(struct vfio_irq_set, count);
 	struct vfio_irq_set hdr;
+	struct vfio_pci_irq_access access = { .hdr = &hdr };
 	u8 *data = NULL;
+	bool device_irq;
 	int max, ret = 0;
 	size_t data_size = 0;
 
 	if (copy_from_user(&hdr, arg, minsz))
 		return -EFAULT;
 
-	max = vfio_pci_get_irq_count(vdev, hdr.index);
+	/* Keep the userspace copy between the two SRCU sections. */
+	device_irq = vfio_pci_irq_index_is_device(hdr.index);
+	if (device_irq) {
+		max = vfio_pci_core_access(vdev, vfio_pci_access_irq_count,
+					   &hdr.index);
+		if (max < 0)
+			return max;
+	} else {
+		max = vfio_pci_get_irq_count(vdev, hdr.index);
+	}
 
 	ret = vfio_set_irqs_validate_and_prepare(&hdr, max, VFIO_PCI_NUM_IRQS,
 						 &data_size);
@@ -1401,12 +1460,15 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 			return PTR_ERR(data);
 	}
 
-	mutex_lock(&vdev->igate);
-
-	ret = vfio_pci_set_irqs_ioctl(vdev, hdr.flags, hdr.index, hdr.start,
-				      hdr.count, data);
-
-	mutex_unlock(&vdev->igate);
+	/*
+	 * IRQ teardown flushes the global virqfd workqueue, so draining SRCU
+	 * can also wait for work on other devices.
+	 */
+	access.data = data;
+	if (device_irq)
+		ret = vfio_pci_core_access(vdev, vfio_pci_access_irqs, &access);
+	else
+		ret = vfio_pci_access_irqs(vdev, &access);
 	kfree(data);
 
 	return ret;
-- 
2.43.0

