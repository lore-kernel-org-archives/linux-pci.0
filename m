Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20595544D69;
	Tue, 29 Sep 2026 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703273; cv=fail; b=rzLavpIg8Ymyu8dbxefz/6d+BOCrodaMtmmq/RtqUpH/7svzHS/FK43oAT34UlKk4/2krA2MGE9ySKIECOPgOUpCmyS0Hip227TGKuKYUCWwQHmnAvwPpqU8Pwre/VY5gvOKrfSzoHRyTaMlHmfgJfhEmovd4gSDGPKZEU0jZ34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703273; c=relaxed/simple;
	bh=VgT4FL3WgiCf834EKT/JA817gz/VFNmVD32I5yX4lWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TL2j30c4+hmjXr1VvXdhpbNVkgwRDmvIAzhOnCSDDmfLmCcr97YZLx8BgYwjFPA6sy9lZDgPRXwFFz3s2kWT1DLPOaHPfGftSy+Q8fbmSRF12Ug9UelFvUTBvutw0tnr9rUHduK+qm+U6rvtAplp3rjIxvkBFqjlCAuMJMSyuVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JVO7KsK/; arc=fail smtp.client-ip=52.101.46.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JVO7KsK/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0tmub3QBO+/h1lb3InnpxOu4Zofgyj6ESUHk4PfTu3H1Zc+y88hJa0t3+w0TMcXh3tNSTsacjTRIcTuJDZZEk5MH8qL+Jy6ApepEVWsJbpnn6+7bfkjmmsiLFzQxyaMZ9eE5iKuI+OcQFgXhYA9JU3tdEj9TueIxzyMRQrL9YpDQodNTyRcRPRk0joZfxy+gbm4RZ2cDLZKIKqXHzaOzYdjKbJKSQgyXcFn/MFbVMn7oibTRDYSBZFeVHxvzDr4dp72RUoyNJqWWv/JrAvH0JnBE6VdG3aX1075bxgxoTy4DiJzer7Le80Dfd9j/OlMSVvxoVPWQPdigrHOqr+r5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmU40V3u3AoLZh4QGsjqP2AO4bNKNviG6wpgGibW0+4=;
 b=i9xb41V22R0pWHr11UIzn/p7kEnyE6EcL8A2JRP6mtZb9x3MrWFL+1Cye5zDoz1TF5YzA6wIwOvCqpTDCTzRVcQtBkhIBksIc28LRHmKYuOZULBgxgnod/PjDUA2Hww2mLPHXrpUEarDtNgH/E9tLDn5rvXz9OiT0khNh1uR3HcIN0l/ZMR9P/cI2JMX047dRUzU1pxa7cj/3U2X099uK7Inc+2jVXb7/MLKVylTbraaQjcPu+jJTKp1j2/mIZUM9OebKbDE+WU9p84PoVigVksBBzvXXJHgzw2YwtLmN58C6IQiguG+EMAiqrWRZlCEnnmls83zI3MWtIlBGVJnCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmU40V3u3AoLZh4QGsjqP2AO4bNKNviG6wpgGibW0+4=;
 b=JVO7KsK/V4v1Vpv0YohaVyGqv6pPKFcssKuo5Ke8YS99D5yb0oYwppoywXKW/dOQy1n5AYNZgMMQXRTpZ51Ldo0r9Gv2c99kokHuUnPeYRVWC9SO/D2oLDh5ApvILGo6IaA7Rh7WphBxXoiehK6g1s7CRr6paqW8ht36mGic6Ln/rwVEAe5SULLzhOQt2FwqaOyjqxKAJdIIYeRtPBfhrRbujPETaSf5QlAVXumYH0z7zyov0L+gpZt89xDBsjvOOJAYVZ8Plr7cKIFZ4WkGt/tGB5makbj713Z0RV/aK028JIZmZSJWoHlhXfqlJ2FNZNPh5tCRDX23uQ//7dlnmQ==
Received: from BN9PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:fb::12)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 29 Sep
 2026 17:34:23 +0000
Received: from BN3PEPF00022BC9.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::67) by BN9PR03CA0037.outlook.office365.com
 (2603:10b6:408:fb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 17:34:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BC9.mail.protection.outlook.com (10.167.248.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:54 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:51 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 08/16] vfio/pci: Gate device information queries and DMA-BUF export
Date: Tue, 29 Sep 2026 18:32:57 +0100
Message-ID: <20260929173305.204856-9-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC9:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: d764f94c-a08f-4dcf-97a4-08df1e4fe6fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	J8xDNKG7HOVLOjjh0osojbqndhkOm+Dh9oZK2toNf/Uaf90AQJQlkAINBfiKaDZTEfS7FqV7q89BeC+MBR5C5qFk0N42rivaQO4LfgcDl5j8zRjqouYJBnsmrcZwNTLdhTTO5S+61hh/JmcXcL8DWONMNVozOl+91LxEf6L/IPPLrZkuIyncHbmb4LIwanP2lslT7KbiOWQz8qRfrHvURKKbEtc/JgthrYo8UUk6BkEywq0WT4sWCAXlcNvAw2GZPuIgTmXvCsyszfYM2bFuhl3Y5XD3zw7xINszEx9HSkU4eOj51cU6KbF8YhL5NbMeGikHyXkkFqMpq9uHqfCZ9k7obYmdjJLZVQMxPxG/nrjjfGhTUeuj1fj3MLJjlvPxY5kU68DtwUiAIovYl8XYeIGoK6Vd9LmKU0f9FvTru96rdlQTSswRn2IxkFbrTx6ziZ/GLBeyTptDcbNSLWOuHK7O0S9cqeJCl/kYlnYH0HFws50EZo7nvgW1rRvzMUTGQ0Cxmpk8x6dNeSNMLNtYj8LY1/orGrgvkcRv0EV2UiTmKSRnoa0nOFU4P8z/bVqM9xx1SbpQPh81HQP0hTMMLqY/G4Rx79FzAW9AoV8v3R2geQaJp4xqw0kcQf/w6OP138txwas8NNxmlYQWawfSNArE08kOgb2+8PqSSttEF1v6SWNHEoDB6ycqqpDBQAaV+hIFyiUAhhuAAQMTAEEICg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	22zAHY6+1+yK4b5tponTori0PcszUfF+3hbBDP2jpjTZAHn4xC2mdMdQgzaJCWnB7ivB4cLWSU3QXahUEqLjnb4Rs1ArCSM9t45+mg+Zkb0Q0r3GeISwy1Nix4ssJkp5/ppBqqoNJYsEKYRcbeZf5M8XPPrrc2TX2AG2mw5v2Rjle+T+yk1DyoT7Mzp8CqcgxtINF2E4Y5BORTGINuGNixawAM2+QqRY+Y07RbZ0HrN8XbvLBRp5fVlpeXqEePfwY2fnAbF0o2o8dqWEnIbxROPjpdWWA6VqtFL3DUrfrE/4dRh07Vtgh3SjEVq9PZaRQnINP2gJO+SK1xvNF9CozItFV8SuQ6201ewtvpm0ByWynNNbjdCaEAadfObR7aiqwmdxw8hIdtgcN5iYUreG2Tg0IjsZa6L9pU8jD2Moc9Y4iTfG9YyBFY0VbZ7CiXX4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:23.4668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d764f94c-a08f-4dcf-97a4-08df1e4fe6fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388

GET_INFO accesses PCI configuration to report AtomicOps support, and
GET_REGION_INFO maps the ROM to validate its contents. Protect these
hardware accesses with access_srcu.

Hold SRCU through DMA-BUF creation and list insertion so recovery cannot
finish revoking buffers before a concurrent export becomes visible.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c   | 13 ++++++++++++-
 drivers/vfio/pci/vfio_pci_dmabuf.c | 16 +++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 38551bdedc89..92497224f471 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1112,7 +1112,7 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 	unsigned long minsz = offsetofend(struct vfio_device_info, num_irqs);
 	struct vfio_device_info info = {};
 	struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
-	int ret;
+	int ret, idx;
 
 	if (copy_from_user(&info, arg, minsz))
 		return -EFAULT;
@@ -1137,7 +1137,13 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 		return ret;
 	}
 
+	idx = vfio_pci_core_access_begin(vdev);
+	if (idx < 0) {
+		kfree(caps.buf);
+		return idx;
+	}
 	ret = vfio_pci_info_atomic_cap(vdev, &caps);
+	vfio_pci_core_access_end(vdev, idx);
 	if (ret && ret != -ENODEV) {
 		pci_warn(vdev->pdev,
 			 "Failed to setup AtomicOps info capability\n");
@@ -1213,6 +1219,10 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 			 * Check ROM content is valid. Need to enable memory
 			 * decode for ROM access in pci_map_rom().
 			 */
+			int idx = vfio_pci_core_access_begin(vdev);
+
+			if (idx < 0)
+				return idx;
 			cmd = vfio_pci_memory_lock_and_enable(vdev);
 			io = pci_map_rom(pdev, &size);
 			if (io) {
@@ -1223,6 +1233,7 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 				pci_unmap_rom(pdev, io);
 			}
 			vfio_pci_memory_unlock_and_restore(vdev, cmd);
+			vfio_pci_core_access_end(vdev, idx);
 		} else if (pdev->rom && pdev->romlen) {
 			info->flags = VFIO_REGION_INFO_FLAG_READ;
 			/* Report BAR size as power of two. */
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..c1a0250af680 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -227,7 +227,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct vfio_pci_dma_buf *priv;
 	size_t length;
-	int ret;
+	int ret, idx;
 
 	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
 		return -EOPNOTSUPP;
@@ -274,19 +274,26 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	priv->vdev = vdev;
 	priv->nr_ranges = get_dma_buf.nr_ranges;
 	priv->size = length;
+
+	idx = vfio_pci_core_access_begin(vdev);
+	if (idx < 0) {
+		ret = idx;
+		goto err_free_phys;
+	}
+
 	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
 					     get_dma_buf.region_index,
 					     priv->phys_vec, dma_ranges,
 					     priv->nr_ranges);
 	if (ret)
-		goto err_free_phys;
+		goto err_access;
 
 	kfree(dma_ranges);
 	dma_ranges = NULL;
 
 	if (!vfio_device_try_get_registration(&vdev->vdev)) {
 		ret = -ENODEV;
-		goto err_free_phys;
+		goto err_access;
 	}
 
 	exp_info.ops = &vfio_pci_dmabuf_ops;
@@ -311,6 +318,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
 	dma_resv_unlock(priv->dmabuf->resv);
 	up_write(&vdev->memory_lock);
+	vfio_pci_core_access_end(vdev, idx);
 
 	/*
 	 * dma_buf_fd() consumes the reference, when the file closes the dmabuf
@@ -324,6 +332,8 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 
 err_dev_put:
 	vfio_device_put_registration(&vdev->vdev);
+err_access:
+	vfio_pci_core_access_end(vdev, idx);
 err_free_phys:
 	kfree(priv->phys_vec);
 err_free_priv:
-- 
2.43.0

