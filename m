Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7C547A870;
	Tue,  1 Sep 2026 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255273; cv=fail; b=P39FWiV6+WDZNXep1/9KfMvDzaSF+a8KPY81Xn2fLWgRKc/o7uCqhXBcL1kL23QA05iIXWNCEpmNvL0cZg02f2ZGiQ08LuG7cdo1ZYwFjmG22Ua08vwIuQnMFQL1FJv2wck6b9oOXt48+XMq4nA8X577dKB8annTC3BsQeiyFNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255273; c=relaxed/simple;
	bh=LLSltA3mrYj9j1inrFwzTsGzs0szn7iFp2JCaGX7BD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAX3JXGVbwkV6GdbVaYWGlaOdcUUBP/zV/81D8J2jjIl46V+k0wRD0j/eij2COj6zo25Ovwlju+5HU3IA+JpyOA0VHjSZGOspwjZlvnynPJlhIV/VGXv1s4Bj7JcsWYNn+m2YS2rPfVenW9FXmyocGAMKILIAZ7a3qb1NyVLSKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T4zfCtxf; arc=fail smtp.client-ip=40.107.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T4zfCtxf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHFDvETAV4KaoGi6CMDU9MoAvOd99oSrfT5z+eRjOdfLpeNLWdcE0itBQg0IYBJk8SSPoSiknCNttw8tarWkE1Kz62tKZoaZsC4RBW6BpZ/kdGV4eojiP3g5MuHbRYzPtmXCdtAW2WeC++P8p9GNu/9O7HEixx4iaopTPg7ZxJOSrKDVHruTmG7bcJm+XaAGlqJi17iBEluctMvlW/4Ynknoh1YKlP7N9kHNdx12EA3WedgqLHMP5DHYHyzOh/xmI8NNolDVU8KyMs1hJ2E9B7xgd+RhItDM0g2C2xwX5JSWawmpe99YOILBpWs+gWUlXYI9ECUrvMTdG+vAj509mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljUXET5aIR959352MZTAkYp1UriNAa0g2vt67TAKO2E=;
 b=B/+2NVIdPd/Ss88b11sPSW9rmwI4sIAr/wGEtSFKRanIfbNTVXWyEbGe4lVe2djdf/2/3XwwWdso9snWf17IBF59GF9Ko9uFLu0YuT+JnU1/G+ur92qNm+5nDdazusZCHEHcTc6QLby1vIRaPeV8Yz2GSzJpIgTZ8brv65u3qPJv04oCcqR+7l1tBzkUx1X6uAk2g8Gf5DFDBAC97dwJw0QdDwdHw3u7sZS9BTQ7FsGkmdNg1eTwiFqUf9+3jHx2Mv7sOcmxxO8CK8TlffqpktaGssWWB+GU3MYVd4tK2hHa0ak7Q0fhtj6TAYoumUCrF3a6alBRLVC/ayphFSfs0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljUXET5aIR959352MZTAkYp1UriNAa0g2vt67TAKO2E=;
 b=T4zfCtxf70wZEvl2kremgBDaS+Rv5sztUPMqjkpNdtx9UG3wxwLFVAQmx5nidPHHVxx51ue8uGkhBBkIs1oGtKHsQDwDLcghlUqCG1w1bEMr1jgIqgOsVrKRaUDpOe+opHck3OHGQfokNZjAz/zYtXcJ7BSFDyIX+ZQd46j9D1nIDmFu2pXtSdzVXxTiwT1ndx4B8ct/q4SQamhzsGXOTMHiTV5XIe1lqaahnT8GZLMQ8xviNsdtqtC4WZNH+FzqBgZJgUC5bT3evi9sDMqpoZUkz6jREnUnJBFklQzZAYX3zuRz1HZiAI679Hn+ZXtnk0F4rTzPCsLRjkV+PSx0Ig==
Received: from CH0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::7) by
 CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.10; Tue, 1 Sep 2026 09:34:06 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::44) by CH0P220CA0028.outlook.office365.com
 (2603:10b6:610:ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:34:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:47 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:44 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 09/19] vfio/pci: Serialize interrupt operations with recovery
Date: Tue, 1 Sep 2026 10:32:07 +0100
Message-ID: <20260901093217.8539-10-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901093217.8539-1-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c28ef2-4fbe-489d-844b-08df080c2aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|6133799003|22082099003|18002099003|5023799004|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	HbQJHp6fKNo2ZeG1KiFKjyaQu2IWgf5LcyGKrxcbO9mXgroQgwRs7+cpQZc9oMknbrUgUAwsBMynpfIQruuqijv7THhBgns5iIrlJsslL1+PuO8716rE7C6XIkwh6IZbmEyy2owdaU+tnivX3oVNYfhB6niHFTz87zfJvywXp3z4zqdx4rW8aRuRR9AL7Je7wy0jsDwIhDRQpshenmJ5h7eNuV0aM33s2QLLLfqeIVYA7bt5Tyl5jXznfWjSUFOxBNovh7xL5PFZEffpiwYbZDwKfDKpfTvcwKap4j+uDCzj+eIU0gvpJj35tXoU+dCOnz7WdU+Ux1gCBHUEmW9OeG8qaxUNqwS4z5+4MUv2qo+GxuhyEZJm8t3DLSSGR/YcfkOsrqfWAzC2VK6m9b/QsWNZppDRKz/DObAwnjgAgfIgAGMKf+z/128/A771KUCN9TWEZ4FMOOc8l8MmJo6DL+rDr34eTFBebsWFhmDMjAZeGF8JbBnT9z6iFa1Ht9Srwj0i9HKPA4nWVirykk5m4TE6nXda5Cit442fp3Q8ULwtUQ1+/5mvzabMP3Ia39QA7On/rL0NL0b+C4tPMeicU5mxNt87MYedQBKoIIygphKyQvKgH13ppDtSwE6xmeklyRWwl2O5ENAtr6MQ1gw/v8q4jnv59eFiBHeqNtEeA1cnV5/kvJvteXnejxNycbIt9oLHXFeNto4+JIqy68gZGw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(6133799003)(22082099003)(18002099003)(5023799004)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BiYiVsXrubkednvnugmG9ZvwsbkXzW5o9feS4UeTamX+++3eqUcMKXDYPVcLWIxLcBa3k1GODq4vp90PbWy6q+zFBJdGZb1xep1DAPikCetra5Fe6+wlpcvibTrqOw+wECu/zrFcPC0524G13myXFNSPADXZzQS78R8eQv5vOdqTwpFYkyaMrkEeUz7Yrg8+9Vv5z6/yTFtvvU4Zwy+MO9hNsI3vj3/dmHHWqGQ6T9zFv38gGUkIySIwZHIaUf7Kqpv3Ka6m86C6ONDXfuvtj6OMFdd7r13lLXC2+8RRlsfneCLN4Q4f8C797oL4UZ8tsnyTn3zPJ14T84JcoviNq0wLMhSDGauYTXR99SfI4R/iyYnEHd1UTch0l8TnCeTt78FkCwFeaznFP+1AM/DPatLLkJT8KfduyekL7NqT860GEHLXDTuifnSlj9/Y1UVd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:34:05.8924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c28ef2-4fbe-489d-844b-08df080c2aca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202

Hold recovery_lock for reading around INTx, MSI and MSI-X capability
queries and configuration changes. ERR and REQ are software-only indexes
and stay available while recovery blocks device access. INTx is covered
by the same test even though its count comes from the virtual config
space, so that one rule applies to every index which can reach hardware.

The test is on the index alone, so a blocked device also refuses the few
requests on those indexes which would not have touched it: signalling an
eventfd for test purposes, and adding or removing the virqfd behind INTx
masking. Both return -EIO until access is unblocked, which for a
non-fatal error is the time the host takes to log it. Reading the flags
or the count of a request is not enough to tell whether it reaches the
device, and refusing a few extra requests for the length of an error
event is cheaper than getting that classification wrong.

Copy the IRQ payload from userspace before taking recovery_lock. The copy
can fault, and with userfaultfd the fault is serviced by userspace, so
holding the lock across it would let a user stall error_detected() for as
long as it likes. The count read and the interrupt operation each take
the lock for themselves.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 0b1b2398dc88..876ff51d6987 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1313,11 +1313,29 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_ioctl_get_region_info);
 
+/*
+ * Which IRQ indexes can reach the device. ERR and REQ are software only.
+ * An index added later gets no access guard until it is listed here.
+ */
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
 	unsigned long minsz = offsetofend(struct vfio_irq_info, count);
 	struct vfio_irq_info info;
+	bool device_irq;
+	int ret;
 
 	if (copy_from_user(&info, arg, minsz))
 		return -EFAULT;
@@ -1336,7 +1354,15 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
 
 	info.flags = VFIO_IRQ_INFO_EVENTFD;
 
+	device_irq = vfio_pci_irq_index_is_device(info.index);
+	if (device_irq) {
+		ret = vfio_pci_core_access_begin(vdev);
+		if (ret)
+			return ret;
+	}
 	info.count = vfio_pci_get_irq_count(vdev, info.index);
+	if (device_irq)
+		vfio_pci_core_access_end(vdev);
 
 	if (info.index == VFIO_PCI_INTX_IRQ_INDEX)
 		info.flags |=
@@ -1353,13 +1379,23 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 	unsigned long minsz = offsetofend(struct vfio_irq_set, count);
 	struct vfio_irq_set hdr;
 	u8 *data = NULL;
+	bool device_irq;
 	int max, ret = 0;
 	size_t data_size = 0;
 
 	if (copy_from_user(&hdr, arg, minsz))
 		return -EFAULT;
 
+	device_irq = vfio_pci_irq_index_is_device(hdr.index);
+	if (device_irq) {
+		ret = vfio_pci_core_access_begin(vdev);
+		if (ret)
+			return ret;
+	}
 	max = vfio_pci_get_irq_count(vdev, hdr.index);
+	/* Dropped for the user copy below, which can fault under userfaultfd. */
+	if (device_irq)
+		vfio_pci_core_access_end(vdev);
 
 	ret = vfio_set_irqs_validate_and_prepare(&hdr, max, VFIO_PCI_NUM_IRQS,
 						 &data_size);
@@ -1372,12 +1408,31 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 			return PTR_ERR(data);
 	}
 
+	/*
+	 * Interrupt teardown reaches vfio_virqfd_disable(), which flushes the
+	 * global virqfd cleanup workqueue, so recovery_lock is held here for
+	 * as long as work queued by any vfio device takes. Shutdown work waits
+	 * for its inject worker, and an ioeventfd inject takes that device's
+	 * memory_lock, so the wait can last as long as a reset there. That is
+	 * only a wait. Nothing on that workqueue takes recovery_lock, which is
+	 * why the ioeventfd write path reads the recovery state without it. A
+	 * callback there which used the vfio_pci_core_iowrite*() accessors
+	 * would break that and deadlock against a queued writer.
+	 */
+	if (device_irq) {
+		ret = vfio_pci_core_access_begin(vdev);
+		if (ret)
+			goto out_free;
+	}
 	mutex_lock(&vdev->igate);
 
 	ret = vfio_pci_set_irqs_ioctl(vdev, hdr.flags, hdr.index, hdr.start,
 				      hdr.count, data);
 
 	mutex_unlock(&vdev->igate);
+	if (device_irq)
+		vfio_pci_core_access_end(vdev);
+out_free:
 	kfree(data);
 
 	return ret;
-- 
2.43.0

