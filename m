Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C8528428;
	Tue, 29 Sep 2026 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703264; cv=fail; b=BwwQV2EPWMZbjez1pzwwgVk/sn0V1jIyUxwaTE+mThHoxIbvBpJKutFFxLlG+mA6kLC/q011aH1jSo47kOXfxTpPUrG29ndB7S/cUlSbblqdjmBW5pp8hFMqQyNEUTZ6Yv6WKsKAAsoqN2RTkByL2dhaVTqmmBAYf5E3UBrzO58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703264; c=relaxed/simple;
	bh=FArweSDzkZdVOnJdMNlHOwfdRd/Y2CY682cu3443Qlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4oMczVKwa9qjFymYdSzDaI47rE1CDzZK8Se+/LnosFYtiDs09AoxHyOrMVV6OH1VtV7sDs66QCg45OpJve7f9gXSSbDpoHusvdWF+pTCcwF2s6UVWFcWYoLc+OW8MUVBZzn9IIwcvC0EUTiTsc81Rpyit0Pd6xZujfPc3I5CP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m93yo8pq; arc=fail smtp.client-ip=52.101.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m93yo8pq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhhXcWXilbjCP7jcbsJLQ8Fx9bTaUfdBPiplcYUqvSbxfXoU2hpcDI8B2UCnSV6vpLfnI+lvpky4EauVdxnwYMjwM1BwMy/oSURy8rdimn9CHWH3VnsGaeJy84BSiEgOFyoz3KjiSt80k/oZdyOgsMj6JNBI0WssHnGkYWTjuaFYIJsN3iNmpigaD6akFduMAZ/4Dc3P7Nl5cQWN4GApPnIUNjC2pegtXsx7zX3JAfBmJp7j2hp8QQLwUeLl6JHIdwibZkBZQVXI7M/Dg74y4y/WODt/vd7LQlKA6K7yAwuy4H9n0cw30hE4ziSajAYjRckAqjwAH6iNEiL74ZpQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTzQZCY4kTMCGjqDQKlSnfg7J4Z/EiD7jj7DsPNQqE0=;
 b=j6UqAftmB/H72nNOXHRLj5tCbNBA8RENUh+wD2mK4cEiJk5ulQC+9tsm2UJTaeuy6c/3Jcfi3YbCUZRSS5yoUMevpONh2yKQoirRroJgu4+91a+8UCZlA2qdxfuUJjYakEZeLiS4J0eetCsIFAU1sCtbchbf3O7vmlncdodXFZqLS/2KM9k1i2vSa9cOj943oDJd0ZudhdUnMJDXkONGcnonXzeb6S7hUev8n/39ykASXTayXoXo71tDmHtLnHoFoHm7fZt8lFoCWQXoh/jYd2RxtTAmWnnT05X3mHRhQ4kUSskzClbqKJwQyqZkNG9oBEAdqy81DinKehpDm5R+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTzQZCY4kTMCGjqDQKlSnfg7J4Z/EiD7jj7DsPNQqE0=;
 b=m93yo8pqU6JCCoiX+KMgapUG0OEhF/g7VtdjM0Q3xE76fU+qO1+kjmIy7CeKD74GJnndoXFT7S7oTNqhYgOi3bGrSARzAYSIpXD/ENDl0jQWG3ntGH1BlgmyKwmbkOzFsUC7xyJRoNRHfjlImzlceHgFAetoT35au4ONHn9S5OFj1ya8Y6RusrYqCMbkKo1DFtOb9x0WNNxXnJXqL5OQZ+LAhf5+x6BnoDaWbq7/NnxvnTaqVHvnnp0tNJ6y01qAZNgHkbKsYiKb4Xl/IUiex8vNxYbvwHgbP0/vOFxuk8q2m728vNgqnR2R1/u/Q+ljUAdftns7YKBJR3Ds6Ji7tg==
Received: from PH7PR02CA0018.namprd02.prod.outlook.com (2603:10b6:510:33d::19)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 17:34:16 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:510:33d:cafe::3d) by PH7PR02CA0018.outlook.office365.com
 (2603:10b6:510:33d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 17:34:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:46 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:43 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 06/16] vfio/pci: Gate interrupt configuration
Date: Tue, 29 Sep 2026 18:32:55 +0100
Message-ID: <20260929173305.204856-7-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929173305.204856-1-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: dabc781b-615e-4c6b-c201-08df1e4fe2e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jXobjkAvNXn9IgZJ988s2lAj2S2u9dVgtUG+im2AsY4npKNR4xRny7yVQtxadN6CzG8EYNHSObcpBBICxGzC0jbA+8eDnJI2MOCXKOY6dAx/aZtJEnIaTZed+ysETE7hdwx+RIU5APCBhPwJz56c+QYz1xS/nUNQXn3HM+XBShdqOMM3dmb3CsbmuQWK7H9GbEYQFMknPhIWShuq9nhE+G25NklFANL5FancdUsHHLux5ApdsTOQ6MEQwypqJhgsQ+de7dRUZ/wkxlLWnW3tUE2XxFLzlU0FE6agBpnphUrKFVR4KfMAkS0o2rIJFx7Nz4rZ1c8qEMccSB8ehlcJB5zD9kcLrOBmteTrFmSY8jdwujliYNOiDGxZJkP7u5WQuwDlrkzEaYJ7EHzya7431tIAY8h6sCbjMNSr1RMfc9wEnIVLOtDO/MxdifAAKsN/R0dm2HIBFHsYH/KKbI2D/K4GDl9kLL1AG+pu9kqWxrbVrtFlTH9G2/nVVhpVOK0tL9A/F+kLaLCVmzPvu0HOc9PdBZgZO4hM06SzKfrqUMbzjzoM7dqhfmYZTkheW/MxM1EQHOorCgH8UBtxsa6zZfJnzC1D18lsLW2C0dBySG4daP7buQIOI+sDw3GaTblVeY03mrVHAErdQ4gvTbNKvvPCxypyY2x9f2O0VjaTORPbID5dKqDL4Cgs+XHirgVbAZ76qhBbbezJj5z0cIt8pQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Kwt4JW05syu0XLEZeu+eQAkGk500xSDK97ahVlQkzVqaZ1C8fPipu/UH5RTAC+ZDzWm7pk0qIsmPHqiGYYG2ACoOGWgK/SLaX81sl7mX5BabepwIav6pxWR7tp53mE8yCZ5/ZDU1xfE6rUVlg2YZtFP819PD62vnQO9P716G8eKairLA1CPLH4wPeAJwlFepJ90vQgkAn6yQKQIZmQatCD4r4lsQqakdmJMZIdxO3TvdlAtqjP8E9ekwPho9/524eFxkbZ/FR1dBhf8JFq0yqngh3p+umjN8R73eANSDoDqQnHxKkMzGyqCZh/vKY4w2w9SWvYLr4WHkjuT5RxDNEMj2Jkrwyyps5F19VKvt6WvWt8FnSe//0qu5vep7gNe9pgFjLjLIvk/kivF1wQmTAIhpkscCgtkHQNX5QLGOU7LYE+WXoxYY/F/jhghgnVVJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:16.6444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dabc781b-615e-4c6b-c201-08df1e4fe2e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

Protect INTx, MSI and MSI-X hardware accesses in GET_IRQ_INFO and
SET_IRQS with access_srcu. ERR and REQ only update eventfds, so leave
them available while device access is blocked.

SET_IRQS uses separate read sections for validation and configuration,
with the user copy between them. Recovery must also wait for IRQ teardown
to finish flushing the global virqfd workqueue.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 54 ++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1c8e39f3f509..91c92e8f3daa 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1266,6 +1266,19 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
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
 static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
 				       struct vfio_irq_info __user *arg)
 {
@@ -1289,7 +1302,16 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
 
 	info.flags = VFIO_IRQ_INFO_EVENTFD;
 
-	info.count = vfio_pci_get_irq_count(vdev, info.index);
+	if (vfio_pci_irq_index_is_device(info.index)) {
+		int idx = vfio_pci_core_access_begin(vdev);
+
+		if (idx < 0)
+			return idx;
+		info.count = vfio_pci_get_irq_count(vdev, info.index);
+		vfio_pci_core_access_end(vdev, idx);
+	} else {
+		info.count = vfio_pci_get_irq_count(vdev, info.index);
+	}
 
 	if (info.index == VFIO_PCI_INTX_IRQ_INDEX)
 		info.flags |=
@@ -1306,13 +1328,24 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 	unsigned long minsz = offsetofend(struct vfio_irq_set, count);
 	struct vfio_irq_set hdr;
 	u8 *data = NULL;
-	int max, ret = 0;
+	bool device_irq;
+	int max, ret = 0, idx = 0;
 	size_t data_size = 0;
 
 	if (copy_from_user(&hdr, arg, minsz))
 		return -EFAULT;
 
-	max = vfio_pci_get_irq_count(vdev, hdr.index);
+	/* Use separate SRCU sections to keep user copies outside access_srcu. */
+	device_irq = vfio_pci_irq_index_is_device(hdr.index);
+	if (device_irq) {
+		idx = vfio_pci_core_access_begin(vdev);
+		if (idx < 0)
+			return idx;
+		max = vfio_pci_get_irq_count(vdev, hdr.index);
+		vfio_pci_core_access_end(vdev, idx);
+	} else {
+		max = vfio_pci_get_irq_count(vdev, hdr.index);
+	}
 
 	ret = vfio_set_irqs_validate_and_prepare(&hdr, max, VFIO_PCI_NUM_IRQS,
 						 &data_size);
@@ -1325,12 +1358,27 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 			return PTR_ERR(data);
 	}
 
+	/*
+	 * IRQ teardown flushes the global virqfd workqueue. Recovery must
+	 * wait for that flush, including pending work for other devices.
+	 */
+	if (device_irq) {
+		idx = vfio_pci_core_access_begin(vdev);
+		if (idx < 0) {
+			ret = idx;
+			goto out_free;
+		}
+	}
+	/* SRCU drains accesses for recovery; igate serializes IRQ changes. */
 	mutex_lock(&vdev->igate);
 
 	ret = vfio_pci_set_irqs_ioctl(vdev, hdr.flags, hdr.index, hdr.start,
 				      hdr.count, data);
 
 	mutex_unlock(&vdev->igate);
+	if (device_irq)
+		vfio_pci_core_access_end(vdev, idx);
+out_free:
 	kfree(data);
 
 	return ret;
-- 
2.43.0

