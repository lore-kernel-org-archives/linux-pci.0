Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013064.outbound.protection.outlook.com [40.107.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34644746AA;
	Tue,  1 Sep 2026 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255238; cv=fail; b=ZU9dC8flw4B7B6kuJSyS54sGEX2am04oAlWriwB/TVo+cHwMmHQHu2JCV0jGi5G1ECtXTmn80x0pfsJTrQ/ASmw7Zpek+KGglTkIUPXiWhWg5d7WBZQw95YnavFEQK4gsnaIEFi7r/qakrkAwBMGaHNArOczWn6SLMg7yEECfRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255238; c=relaxed/simple;
	bh=CdrSjnyMgvAr/PlF3O7bgT6Y9Qp4zRGbCD4vw0jgSng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K72R3UBcz4gom+smmQJFpDrwa939MHL7s2ghgqRMFM1j5tNAqiUyZTSY0DP1B7uOs21VF/Sdu2pdWO0GLeZiCEvQiNczBZdf4/s1CI+4y1lTvkJbSjwoweIGjM2URyfzJDNrVfkOmgB0MrXaA1SPF0bDnP5MThbjdXBQqoaN3jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OgAvu2BT; arc=fail smtp.client-ip=40.107.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OgAvu2BT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agnKNxCC6EHTlcDr5IN14sEZ5o2z+GlLFi3lpk7vFRbibWPxbu8+KRMaWO4QWG2SYUClPCh6r1Q945hAdFiFZDc2KR2kGpXwElmGZSuvTvykScXtMj2FB1Nmu+VPK4EQRSZHTX+o/rNrj6TXlhXffX3A2icyxCyn77kbX8o+lUD61Qqf5QijBb62U23CNjyX669oQ9W2MQRtqM4qp1FT+G5VyQplDrpCY1FpgnTxu6GLSHWdzlk4414wvKD3UVAFEiyrw/uLt0Oa4cDONXJVcbCXSDt4q6hP43kbUltiP58jjzwcOj5+atcCcOcFklWcBCqICrW+dgfuM9Tvf/S2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADrrE5khSKKQ1v9E8xOPt8dxuiFErbph9vBrdBu5y+A=;
 b=JYcODw2xKx9pkxUoUtzzGOTDPY4NjUU3Kt93i2oPOVeCgdan38Qvrq+n4bmElRuTQAveapnqADnZoatwJv0S2v2hcig4oA5Q/nuhjRaYBpcmsFPWAqNNsUAxceCDiAIaFYQ8wUJpqTbcVirt1LfLIwHhT1UGTYei1p6HJwJZp2MXTZEgJb7BFsJr7AWdCHceg+ioDuoVeTIBDgPQ2Jbc3RoAfHrHT77cwONOJoONrl5Qh+5ogM68p8An4GRVfaNEmNde6GGzGfXlMRDW+mZgVfMHyGeMt6qhPPLFxekxNNsAcYF26bjRcX08u82cqGDNkd5v43AOlav3KcQrnQcuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADrrE5khSKKQ1v9E8xOPt8dxuiFErbph9vBrdBu5y+A=;
 b=OgAvu2BTMayngCv0gkPNGSzFXLDpRMQMdTdguswkarm0ofZYnjMyAS9dBQKqPzfAXn8c56/U6deqstGBwyqaU+IwY/H3WmX7vApl8LxuIovMEJMDLMhE9sJRFpRIliPbKC70+aGVKT5xQ+a7zYj69plkqhcJW9qpl2HmGsRdrpq2XtP5KEmf2+23QLfa7bm0IIrTijac16gNGr50Ej4uA1RuWbryWuCpa07A/Egr5dN7bP2gaaOyuiBIDKtEEs9Ta01vHo6vu5NCIyVhtVwK1bQGRa9p/mWqdCvduji+VBOLNeXKE0OIimxyB1CbsWD7l8XnJ6wjO81PRC/QrtAjkw==
Received: from CH0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::27)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:33:39 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::24) by CH0P220CA0006.outlook.office365.com
 (2603:10b6:610:ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:33:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:24 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:21 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 03/19] vfio/pci: Add PCI recovery access guards
Date: Tue, 1 Sep 2026 10:32:01 +0100
Message-ID: <20260901093217.8539-4-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f13bc5-481b-4b22-5920-08df080c1af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|10067099003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SPnbmy/5Wd9HSIVNZ3c6Cqa3quljYpNwNd02Jqin734bFld/KNIW03cMo03xSumViIIKwM6/sxX6M2us5amvZREWHYw4XFu7tMSPsJTE8Cly5g6VdeO5YYbOigqvZL84rE56z6h7Npmuxgg5O1Fu2kph6oXQSqplhxY8Nvwgc8IvMlcO7qFf/g2T1jQQBSHKLDu8cC6ZZPNpeEJVgyl4hCMnenRmu2Ff7UaIyN3FyMPAQwQCxjYiLw6sFu+mu8wcifrPmage47MfrccAIkGa3UP8LGyLu/09U9s3MzJOnFquKO4wkFcdLRINzv//v241B+M7yQlQGN/DhGPuR9zBNdGjkiH9hAGMNNXLfLUlGLilXGyk7LZzkB2hFIF1iMzBIgMp0w2hqyYqVbSsaWEMivYXlEriH7qnTrXcWFmnvKFJQMaSbQDYfM62K8z7GBh3NrtCM3UltujChtko4ALe2g/4pQguRPOBZPFKomiYhTckRfIvJ406IVtsXge2JBRPsLPsHXOkUBgLK4sbKwiNi7FwSKxMpQ9k3u0MDcHLyeOxJ4lHy09ImfA09NzTuDse+URKYhfuYRsspXkFbz84uehAqfg5bPgG3xvsbjtytGe9vhb0onS/RfwgYYXTWfgGucZ1TG+Idi70akLDjz6DfWShdmPsy+P3MZ9lrbKoFDeFZs5XnAWdAtoEQNr82DOt7HXev06pxUpdJBfEB5mwCw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G54U9nfPVxeF+28tBrnnQeqKPqV45yF3ZiXLdcxN6fNfBwBtq6s5Cq+Tydw3C2Re9xz8mlyn2d23rms3nms7ZDuEjtn6Sq1jL7fzlK/7g4r4jf1XSj1nVdxhQoaTeiSLM4ox9O+I/vjAE3Fo0QKEVDcuhD05jrRrJvObWP3MDu2CxGr3iJd/kUrC7kNyZOnqWnNwjZHwNByMUsxUA3Mv21Sbj/rgJGGmI75woJsQ6UAb9+E9edUmFeQ0Fm/1nHVtRxAxUR7qmgyx35dsF5Ue6UEitpgZGN34PVW7RM8WMPEYnDp5Np3OJ7gaNd2AogKZJIySDWqlXdq4O4I4SMrQaoaY2Ly2tM8kuiq1wK3VSo0Rk7NEhfT21Zq6K/JnSx/fZ+g3e8Ec/SeLr9PWFtXc03BnRVyoWEvCR/tqWtj2EEBf6g4HylVWlsRP/KkZ/tqT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:33:39.3122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f13bc5-481b-4b22-5920-08df080c1af2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

Add a pair of helpers to wrap each operation which touches the device.
access_begin() takes recovery_lock for reading and refuses if the device
is not open, or if recovery is blocking access. The callers come in later
patches.

access_end() drops the lock without looking at the recovery state, so
only call it after access_begin() returned 0. On failure the lock is
already gone. Both helpers key off pci_recovery_supported, which is
fixed for the lifetime of the device, so the pair stays balanced.

The lock is taken even when userspace has not enabled recovery. Enabling
takes recovery_lock for writing, which waits for anything already in
flight. Without that, an operation which started before enable could
still be touching the device when the first error arrives, and there would
be nothing to wait on.

access_blocked is checked either way. Nothing sets it yet, so nothing
which works today gets rejected.

The cost is one rwsem acquire per guarded access on devices that never
turn recovery on. For BAR traffic that is once per width-sized access,
alongside the memory_lock read already taken there.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_priv.h |  3 +++
 drivers/vfio/pci/vfio_pci_core.c | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234a2e..6daf51669d05 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -73,6 +73,9 @@ u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
 					u16 cmd);
 
+int vfio_pci_core_access_begin(struct vfio_pci_core_device *vdev);
+void vfio_pci_core_access_end(struct vfio_pci_core_device *vdev);
+
 #ifdef CONFIG_VFIO_PCI_IGD
 bool vfio_pci_is_intel_display(struct pci_dev *pdev);
 int vfio_pci_igd_init(struct vfio_pci_core_device *vdev);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 8de586e4bb73..4194d44d6530 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1747,6 +1747,27 @@ static ssize_t vfio_pci_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	return ret;
 }
 
+int vfio_pci_core_access_begin(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->pci_recovery_supported)
+		return 0;
+
+	down_read(&vdev->recovery_lock);
+	if (unlikely(!vdev->pci_recovery_device_open ||
+		     vdev->pci_recovery_access_blocked)) {
+		up_read(&vdev->recovery_lock);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+void vfio_pci_core_access_end(struct vfio_pci_core_device *vdev)
+{
+	if (vdev->pci_recovery_supported)
+		up_read(&vdev->recovery_lock);
+}
+
 ssize_t vfio_pci_core_read(struct vfio_device *core_vdev, char __user *buf,
 		size_t count, loff_t *ppos)
 {
-- 
2.43.0

