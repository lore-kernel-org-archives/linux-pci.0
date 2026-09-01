Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE447798B;
	Tue,  1 Sep 2026 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255300; cv=fail; b=OKu9xpNuh5HNctCwrNrcyHDjSivQfDHtcfsjOS3sqZ7PibKWPj7LX3NstQKMuznyqXjFkd1OOY2OdeqImTmb2nPtWOafzE+5BqWzLB6ueegcEryHbdAONlwA7k2sm4Vd3CXl7J7RXiP1d0PccrRKFyhW9T6iRdqDmd0b14MsNU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255300; c=relaxed/simple;
	bh=4jsXGs+J2sCiGycsIrxOIo3v+w4WmYuwD/LU5IBgkrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=In/qcbp+2YAqr1dR/U4WlHFjAQu41flKOZ07I3rFrGJkGCgQrD8Cc/Gax+7qy+ozkqaMlhAL5mIgbjttmPHCK/JH5uPpDTyLXcOJ9hdo5foc++ELNTyMP1BJgOQgePx44vSBn9BPBioPdOcGh7qyAVTZFuhgpnOnwr7qFzW0v3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWV1aYHD; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWV1aYHD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGFVeBvi06zugAyzINHbJW+bVEA8CEIgoJLPLDzA4nne4oQ/6xTYyrvrc0KuHp0ISkQjBjtnsTCxqJnjHLycTH073E+ehJlkpiN/+W/Kh6IJ+qJVYkzl8RddU5LVv26iVjvLVf3ldjxUJfhKlJIL+xmC0tYjYVxlV75H28w0GdmyAMknTDUagCXqc00ACxVw3xjbZ+N6cJr8IcWpZCq9WOA1LVW65AopsvOn3eC02h/CT4o35R9bYAUObuHnQkAy2jDpDNdWhgT4UDwTL8KTYGDvNVIqP0tDKqLr8IR/Wp7bxarOzuwRh8hO/pand5pU0LXT18EB9NiETvIlIMUeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bL/NEcWNk17n+4zOtixjgiWBmQVQWkTOJJ47AnFrEk=;
 b=NGbGSufncm0EAyvHfzT+3ANF2IMKjnErhos5A+rTkxiX76CLZOqFGZA/SarXAbxvzfx8jsg2M/W7iczsr3+EWWnH2jmYJBpcmFkOE4zoozVJUOh6rnw1pm5zG6WGJOZRkM2doy8KQ7N8fCm/WivroFjJqxRX/mhdSqRi+VHT9XSNy+XMWs4XB4fDlGcqwwFdF6Cvyvw3+D3PJokvD1MFRXwkS5pwGBIO7UXzf+rz8ej4aC1y01igvnsO1cGUZGUQApwdQXJdSepV4g7GkillG0BG1CnLhIBjezHKH8r1m8Yo2wXRi5GYUOdDL/KRKDybcUXLSnjg6Uh83+cR1JhbVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bL/NEcWNk17n+4zOtixjgiWBmQVQWkTOJJ47AnFrEk=;
 b=KWV1aYHDkIY5OrSj+mbawAoixBhMUEVbDANsbRVvlsBIGqz2O1hshA3VBiD6b6Hv6fERhwLqpmgQI3VtZmlLEpQevqYUsiQ2qQRHl/xHvgJX5/VSGdHCCC1t58WKEVYdGgUSTU6PzrFCTjwjGlQH/uYLCOyVdodxA4DDtH95zXtWRWpEpwINO/mBJxfcUcSRmWp6CJevMoCPWxSsT6fKDApaPcJC2aqi5vWR4ZTjc4WptPT6zsYIt7ujupHn42Ioz2lPzeO+GHMfmBdF7OB/muE6f4NGmxVeiPYJzhysq5ow/AWzZDhCNgc4ybVhN4UMrMs5GXpIkNPJhfLxcPtRrg==
Received: from CH2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:610:50::12)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 09:34:36 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::7a) by CH2PR16CA0002.outlook.office365.com
 (2603:10b6:610:50::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:34:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:19 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:16 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 17/19] vfio/pci: Add generic PCI error resume handling
Date: Tue, 1 Sep 2026 10:32:15 +0100
Message-ID: <20260901093217.8539-18-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ddda40-c5a5-481d-4812-08df080c3cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Vougr2qrhI14Ie2DIFIaLI1N7Lelq0jHlZGLQA5LJ3zYzWGVicuzjwzaw88nBa7ngQqPalrbTckrGtMcjbZMpGZan5jgq2DCa6q4B68VGFCEs54aNZp/Mgvy/e2XCyiO6eNes8Ei48+oqCiH4278Sf1WMAvt13wU/j7qQci50bHAowp7Nhby67k+Iobc85L39WjZ+rM6gOAyBkcGchWomj3744V0tnWovi6ED9ppFcRFx/X+STgHZJi722NWdY4qNpUOXagkCcixftOjpTYsvrOvUtkpsM1F/rcJtnducx3WfcYzrvo6JRRbDLOPgiOQjww2rWLrTdXugjdfeQwsP+LiwnNFYdNa9/USRzvHoG6LAWLnGMo9lncTn7XHvB5Z8mXvqrlpR8aKbB4QcKAjo/ptUe0EwNwoV3fbR0fTBXxqH+T4HPvNnPciIsJbgcD6XJ4Xo9y6wBdSzbsgClynHt0DCYy9LiW/vS1f/A4VwCLghskyrWL0QkS6XOfKz6CwlyjW+QPY2OKVmfcfWr/3QJr4UHosMe/qmC/xowQ6l5aZl2B2dYkWwPxmMdzT1RX9wgGXqNQYBvA4kRTCgZEvEyT0dGLXtqB2nIaLAOUUTo4G3HH/OQ5GN1c3g4zZGBoYUci0FIrydYjJoCWBSJEQgkWPEGBnsaYNOmjY3/1RH/sYxQR0GNJs/BlVqYhFXFAPyIpJZeNkeZckXb54PAWtKA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y9Ybdfs5TOyx3N/oWZp629wQBlZMKGHIrYxSB/kLSohCrn5i0LkLFRvxE9zrsBo1NphRBxA8gAkeDz87p9bbDrcNyux/QeG0DBEdD/HTsEICICPwTqiT5wk40W39SfmmRrSAXvqUl5sPUIPlDiRUYt0vxKeJmUU+RsC8T6PdZsQbIvXsBMXCvq6QLUr5AWL08MJ8l9PjbP5Qqk7RUlpH9dJPXZMDRuF5bolniLeRlTg2dLeIEaFXKNghoi5v21Nc7BOJWrzL3Q9uHufAHhUwL2zH9y8EJVyIUE4rggwKOsAD2o5YYOqyvK4U8hBCiKVFxc48/LDVtSkwIX35b9Qc5eo8MFz4p/3Mx2Prnc9VzaSLe8RWjw65nWQXEPhGZ71I5cvDcFvO987Un48w1GsCVWnZCIvDTTfCVFd0Mgf7E+aMvk87Js+DBqwRVdupokGY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:34:36.2302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ddda40-c5a5-481d-4812-08df080c3cdf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215

Add a resume() handler for vfio-pci-core. It ends the recovery
transaction and makes the device usable again.

INTX_DISABLE is taken from the INTx state rather than from the saved word.
The handler can have masked the line after the word was saved, and
restoring the saved bit would unmask a line it still believes is masked.
The replay is what unmasks it.

Restore the command word saved by error_detected(), unless the device was
reset, in which case slot_reset() already restored the whole config space
and the saved value is stale. Then unblock access, un-revoke exported
DMA-BUFs if the guest still has memory decode enabled, clear IN_PROGRESS
and replay the INTx state recorded during the event.

If the command write fails, keep access blocked and publish FAILED.
IN_PROGRESS is cleared and FAILED set in a single store, so a lock-free
reader never sees the intermediate state, which would read as a
successful completion.

Pay any deferred ROM decode disable first, before the in-progress check.
A failed transaction has already cleared that flag, and the disable would
be lost. The helper skips a closed device on its own.

Until a later patch starts a recovery transaction, only the deferred ROM
disable runs here. The rest returns early.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 68 ++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 658cccecab12..eed0430c32ee 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2828,6 +2828,73 @@ static pci_ers_result_t vfio_pci_core_aer_slot_reset(struct pci_dev *pdev)
 	return result;
 }
 
+static void vfio_pci_core_aer_resume(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+	unsigned long irq_flags;
+	u32 flags;
+	int ret = 0;
+
+	down_write(&vdev->recovery_lock);
+
+	/*
+	 * Pay any deferred ROM disable before the in-progress check below,
+	 * which a failed transaction has already cleared, or it would be
+	 * lost.
+	 */
+	vfio_pci_recovery_rom_disable(vdev);
+
+	if (!(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS))
+		goto out_unlock;
+
+	if (!vdev->pci_recovery_device_open) {
+		vdev->pci_recovery_command_valid = false;
+		WRITE_ONCE(vdev->pci_recovery_flags,
+			   vdev->pci_recovery_flags &
+			   ~VFIO_PCI_RECOVERY_IN_PROGRESS);
+		goto out_unlock;
+	}
+
+	down_write(&vdev->memory_lock);
+	/*
+	 * Restore the command word and clear access_blocked under irqlock.
+	 * The INTx handler writes the same register through
+	 * pci_check_and_mask_intx(), so it must not interleave with the
+	 * restore, and it must not see access blocked cleared while the
+	 * temporary command value is still installed.
+	 *
+	 * INTX_DISABLE comes from the INTx state rather than from the saved
+	 * word, which can be older than the last mask. The replay below is
+	 * what unmasks the line.
+	 */
+	spin_lock_irqsave(&vdev->irqlock, irq_flags);
+	if (!(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_RESET) &&
+	    vdev->pci_recovery_command_valid) {
+		u16 cmd = vdev->pci_recovery_command;
+
+		cmd = vfio_pci_intx_recovery_command(vdev, cmd);
+		ret = pci_write_config_word(pdev, PCI_COMMAND, cmd);
+	}
+	if (!ret)
+		WRITE_ONCE(vdev->pci_recovery_access_blocked, false);
+	spin_unlock_irqrestore(&vdev->irqlock, irq_flags);
+	if (!ret && __vfio_pci_memory_enabled(vdev))
+		vfio_pci_dma_buf_move(vdev, false);
+	up_write(&vdev->memory_lock);
+
+	vdev->pci_recovery_command_valid = false;
+	flags = vdev->pci_recovery_flags & ~VFIO_PCI_RECOVERY_IN_PROGRESS;
+	if (ret)
+		flags |= VFIO_PCI_RECOVERY_FAILED;
+	WRITE_ONCE(vdev->pci_recovery_flags, flags);
+	if (!ret)
+		vfio_pci_intx_recovery_finish(vdev);
+
+out_unlock:
+	up_write(&vdev->recovery_lock);
+	wake_up_all(&vdev->pci_recovery_wait);
+}
+
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn)
 {
@@ -2901,6 +2968,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
 	.slot_reset = vfio_pci_core_aer_slot_reset,
+	.resume = vfio_pci_core_aer_resume,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0

