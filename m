Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E55476EE;
	Tue, 29 Sep 2026 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703290; cv=fail; b=bmXL7+JymdYgIxGF/p9TiIDv01rxMAP7tfuwNSqdRkpqPitKJTk1qMrVC1cGyebT7JbXQVxEv/2qLriRTmkxZDsIloieAMYdAWkxi+mao1vtjPTe38zuiDkFeAjKShB7YurHZGP6dXL6ADp5mlx5jFul+JD1fUEU1OnD0ONeXpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703290; c=relaxed/simple;
	bh=JIoMWzXNgBZ4hvOxbhg0bxu6PWF/v92ThMCpQtTaKQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dld/tIr+fPK07ljHwcUGbYTG+5vdkch2egKWAyaBob89K4WV2ydZULjUuu248L7jF6OnbvDtMPfIlffMJ0etEn5F7plyqmeHJO96g84dJVn9wFR2lTLDmaxMkI6U+eh8x1qTGCi94v3hsSCdBH8Pyp1QluayGg9lXZ+BaayQgIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MatdLEZ7; arc=fail smtp.client-ip=52.101.56.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MatdLEZ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YL3/8LqlRYa+ZmYAvQAjKRf9eQsrvJnWbcLJlv0HPkjSi88Usoi28eR5JGGNKXcbqAEVXw2DGeBN3q6d6pgdUuRxXl/q+DFLlZrtTYB7Rel/tn9F2DlkwOqYz5N9ur6cYPIGhPr8DleXPWpoa2+KY8y4N8vynYqToNerLjtrQEpGFP+qrbrwDysS/8pcN2Wt5qtKlWyHsoZENzXz/jp+bV4FvX5hNWclIxAajutBOHOCFTKAt8wr6d5Dc4xBSJ2sf9HlINpjpeo0QGi5qdpDtzkHBEvu6zP152pjGcUYODFGMEZ5IPDbN7542+2T3SBRz1TG5nW/eTR5ZrC560FJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LYlS8uTu5twY3z9auWFM/vIHbJ7KAto0yDf9LLgIdA=;
 b=Q51ZiTwr5JIO5gYTbwGaXjzBtmw4jcV8WoDoNnOLJeg9Bujwxa28gXwv7njrtnkNnbQjzXaVpBgghBH6MRRuIo172Arh7O6XKpY2XxX+PmPRwXAyEh1E+ZGZZPhqa/muWeJ9XJOkGaoheB0kNDaSc2fIzmZxLS05zpyAKNwFzqIaGRufe/9/A/pD1npqWYo6T4UaJMWbmpKUNFxnIqrUkVsGWAEdvwFH5Nsjc8BniGNkH0xTwriE8tfGJCZYR3xL+43orQV1zGkvVRQCCqTn9c7YGrmn7PATZgcIoMdZQEcAsmDP2TXaGGh9Jtri5ACbP/3B8ZKozjeVN9Nkr+sT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LYlS8uTu5twY3z9auWFM/vIHbJ7KAto0yDf9LLgIdA=;
 b=MatdLEZ7KnBVmqDg7wTFr1j4Q/yzZnt9l4zBzEO8xbc743gwydugu4AxexX5TJOegzzVHcn6F6KNPv2qDGRUSBH9HQCULrS437he9JFR72oH/f0eg/trxQbO6zto3bSyftbEZWWK9rqF5J8xxEuV+ddYl+gVi2SEqhTDCT0h1ukqpeOutyYoxRprw6nkVXyL7iZz36tnrBUniswbPyscyc7vIgofcjsUEFj14Kac45i41btwf3UNs4TShGsaLwi8x5GQpK0vEaPzsjvo8BRp8hnQfYtmNVDiurdlYBcs5RgpjDm/d+/gMvCkACq1BVMSlAuXPdZ34axhgnKdg0CavA==
Received: from BLAPR03CA0075.namprd03.prod.outlook.com (2603:10b6:208:329::20)
 by DSVPR12MB999192.namprd12.prod.outlook.com (2603:10b6:8:496::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 17:34:43 +0000
Received: from BN3PEPF00022BC4.namprd05.prod.outlook.com
 (2603:10b6:208:329:cafe::1c) by BLAPR03CA0075.outlook.office365.com
 (2603:10b6:208:329::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 17:34:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BC4.mail.protection.outlook.com (10.167.248.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:14 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:11 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 13/16] vfio/pci: Complete recovery in resume()
Date: Tue, 29 Sep 2026 18:33:02 +0100
Message-ID: <20260929173305.204856-14-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC4:EE_|DSVPR12MB999192:EE_
X-MS-Office365-Filtering-Correlation-Id: 487e9c03-00ff-43c5-aec9-08df1e4ff27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eJFDGDaZZxrUgsXenY3qFp5TaBTvWei6odbKY06g4qziw071KJ+RcqPiEoK3EsbYsZGPmKYuTEgGlirdQWBUWJ/xUrbj5pWekukOTUJH2SJmtOfARYnJDuDPdIrkWjhrfrwOzn71Kkg9Pfmja8CCaPZ/hcU5PBSJi6+gt7eHyOOAuQ+FY2FAprd8IYIZSeLX440gJaY/kTL7nZckVz2PBQLM8q2ln7cjrgVZ/0lINMfpb/89WmsMTTZiblg8KuHXIn2N6btR02wyds/V8AhgSFpVFES7HHHQ13C0dMq2TnJCEX3WpVzdhyvUoA+0LlADf82n6QV85CF5VXy1fKFpTXr0mqYAb+hg6A6Rf2OdfHZxQBlhCp06OOm/M2J2RTf13aqSa9s660s8ZfwsMdCt95Hiu3coBh5RGW22RD6GDKBogQ+sy0MEiw5U5+ozSLEhI5XV1SL6/gQ/fGaKs7cbka5D9jSOiocLyJ4BtR2r3r0vTHyss0V+Qfi4ju2/cwxtGpz/p9LgAy6T6JKg8uLXj47Q7fEHzwNmqhYzKCQKzLq6NHdCS6lEj9QtsM0M/d+t3dFCY7KF7owsnH18rqLVDJXdPchkLG49g3sp/9qtHPxtmLblZGov5GfuycM94dF95jkW0j0nqz/GiQzwscB4MtVP51jwM5AUZDum4wYFrmAHDA4je3JMlLk8/LLdo80RRxbK81epYTEK9ia+HGyQTA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EOgOM0lsos8qOnhmnkrXJ2urGWCMjdKUzlFa4qNCZVE8CwqLcDayVXq9OIMwtDDLhFgTW8nAQDk+U6CBvl9JhvlYjmXqqY2tWHl01rvfGBvdCkmRzk6xTDlnBcCBW3jPWCpLcGK7pJ5aNnm/MgivQdD3EDd/P6eBR/5tKSBf8PYCwYkFr1hk8W0x9Oo7XgMQ0UDtvKHyUX2BTrRC5PHdMRD6wIOq0CYOfTAVQEcnouxaLg7Tf0ajbmFH/R4YSHFZNRnry4iP1jh75luckELQiBW0C5ZQqu41L2X7Khg4u8QC152bG4QLzxlK1R7Eh0v3ZwMqfewwhiww8xY08yLwwlUR+l+3KQqAAcPbQ9siM9Nsp7yf2tfUQr8FyTpu1U3NhIwrAcdb3QvPp7hmu92N6QWggTH5uHeoVH3HJQuyP+01MQg4IjY5ZVc6uF4rUwcX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:42.7735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 487e9c03-00ff-43c5-aec9-08df1e4ff27e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999192

Add resume() to complete the host transaction and notify userspace.
For recovery without reset, apply a deferred D0 request before restoring
PCI_COMMAND. After a reset, slot_reset() has already established D0 and
restored the open snapshot. Use the existing VFIO power helper to retain
pm_save handling. Keep active INTx masked when restoring pm_save while
access is blocked, until recovery completes.

After restoring device state, disable ROM decoding unless the ROM
resource is marked to remain enabled. Then unblock access, restore
DMA-BUF availability and complete INTx unmasking. Protect PCI_COMMAND
and the unblock operation with irqlock. A power or command restore
failure leaves access blocked and sets FAILED.

Clear the host-active flag even if close or a local failure has already
cleared IN_PROGRESS. In that case, skip the per-open completion work.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
Note: As in slot_reset(), this series introduces a VFIO recovery path
that can reacquire pci_bus_sem through the ordinary PCI power helper's
ASPM update. This remains unresolved. See the cover letter's "Locking
and open questions" section.
---
 drivers/vfio/pci/vfio_pci_core.c | 83 ++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a7b7499e071c..d6cc34240b25 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -371,6 +371,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 			vdev->pm_save = pci_store_saved_state(pdev);
 		} else if (needs_restore) {
 			pci_load_and_free_saved_state(pdev, &vdev->pm_save);
+			vfio_pci_recovery_mask_saved_intx(vdev);
 			pci_restore_state(pdev);
 		}
 	}
@@ -2615,6 +2616,87 @@ static pci_ers_result_t vfio_pci_core_aer_slot_reset(struct pci_dev *pdev)
 	return PCI_ERS_RESULT_NONE;
 }
 
+static void vfio_pci_core_aer_resume(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+	unsigned long irq_flags;
+	bool notify_recovery = false;
+	bool power_up;
+	u32 flags;
+	int ret = 0;
+
+	mutex_lock(&vdev->access_lock);
+	vdev->pci_recovery_host_active = false;
+	if (!(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS))
+		goto out_unlock;
+
+	notify_recovery = true;
+	down_write(&vdev->memory_lock);
+	/*
+	 * Apply deferred D0 requests before restoring PCI_COMMAND.
+	 * slot_reset() has already established D0 after a reset.
+	 */
+	power_up = vdev->power_up_pending;
+	vdev->power_up_pending = false;
+	if (power_up && !(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_RESET)) {
+		ret = vfio_pci_set_power_state(vdev, PCI_D0);
+		if (ret)
+			goto out_memory;
+	}
+
+	/*
+	 * Serialize with INTx updates to PCI_COMMAND. Keep masked INTx
+	 * disabled until vfio_pci_intx_recovery_finish().
+	 */
+	spin_lock_irqsave(&vdev->irqlock, irq_flags);
+	if (!(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_RESET) &&
+	    vdev->pci_recovery_command_valid) {
+		u16 cmd = vdev->pci_recovery_command;
+
+		cmd = vfio_pci_intx_recovery_update_command(vdev, cmd);
+		ret = pci_write_config_word(pdev, PCI_COMMAND, cmd);
+	}
+	spin_unlock_irqrestore(&vdev->irqlock, irq_flags);
+	if (ret)
+		goto out_memory;
+
+	/*
+	 * A saved-state restore may leave ROM decode enabled. Disable it
+	 * before allowing access to shared decoders.
+	 */
+	if (pci_resource_start(pdev, PCI_ROM_RESOURCE) &&
+	    !(pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_ENABLE))
+		pci_disable_rom(pdev);
+
+	/*
+	 * Finish restoring hardware state before allowing accesses.
+	 * Serialize the flag update with the INTx handler.
+	 */
+	spin_lock_irqsave(&vdev->irqlock, irq_flags);
+	WRITE_ONCE(vdev->access_blocked, false);
+	spin_unlock_irqrestore(&vdev->irqlock, irq_flags);
+
+	if (__vfio_pci_memory_enabled(vdev))
+		vfio_pci_dma_buf_move(vdev, false);
+
+out_memory:
+	up_write(&vdev->memory_lock);
+	vdev->pci_recovery_command_valid = false;
+	flags = vdev->pci_recovery_flags & ~VFIO_PCI_RECOVERY_IN_PROGRESS;
+	if (ret) {
+		WRITE_ONCE(vdev->pci_recovery_flags,
+			   flags | VFIO_PCI_RECOVERY_FAILED);
+		goto out_unlock;
+	}
+	WRITE_ONCE(vdev->pci_recovery_flags, flags);
+	vfio_pci_intx_recovery_finish(vdev);
+
+out_unlock:
+	mutex_unlock(&vdev->access_lock);
+	if (notify_recovery)
+		vfio_pci_signal_recovery_event(vdev);
+}
+
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn)
 {
@@ -2688,6 +2770,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
 	.slot_reset = vfio_pci_core_aer_slot_reset,
+	.resume = vfio_pci_core_aer_resume,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0

