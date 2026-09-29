Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86C5452A0;
	Tue, 29 Sep 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703288; cv=fail; b=eN/sCIviRxwXSXYEImS1/E+wtn3rTAPm5Mi6Vp6zx+ZDD65pLsITeURFl5QThJmEQwvqM5aXtaBQ9k9xf8dyQLtJ8sNlxnBAIN1Oc6dyLZ4RCbZuUk+J6581SrfkN1h1PuZ+/GQe0jEuggoTtiMo3OxrO3S2khV9gbveIojDcG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703288; c=relaxed/simple;
	bh=KhecZfM1hVAcbSem1CPqkfnDblQ3JlA/hffunDSDaJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkNlJyQHiQWuqdp38VgbH+VCkIz3XsgqkHHzCv6QOvBneQTGcdIw8zJ4nlJ+nD2D70Bilvaavjb1c4Z75Y4oa1UhDg9OGY7pfV257EzbeOO4yYzMo8yBU+jWryLBW25INzBYSeejQb4lM2HU+raezvDKRYKr/3i4imh5LgafYh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=asAyP0L/; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="asAyP0L/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGymxyWDCpOa/HvW4WYF5VH9R/LEFzuDfxvDlkdKN9r8R2n7r9/QPkpb1yhcrI3wu1KiqRCIyLIMCWx8ZYiSZhLxLq4jEjWOGb8q7DBMvly27YBKdHNiSHrfpl9jE4kicfvbF0398iNjiJ4XeSw2wNGMdLrNMKZT/o31jfCVuQytJNVz8HkI1pkzA9p/d67HScX4o7esEqZyiBw0E0tT3SlsBQ3hKU5j2O9crzdkcFqfzBXlIl1KneAcLVYSm2cKOAo7epVbA4DLAvGNXqvd4tnclh4Yx5NXjSU1irnlHr8I8p6QAv83r1vMlcJwtuKsyvKi8RtkOBQKOZc4PaUcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqrKkCwtBkbPdI/K6Y0WPKTUfyWCHcjV+wtBt+RLuEE=;
 b=Fodze0DvSope/EuB9NobeLM43G/BTpiyHpi9811an7OgxJ9eItNFb1U+AqqE3xMXnAJhN5N3ICoG8GF5v5oTEtS5SnObxuuL/+EsJUPMaWOlVk3e5hk+10KFakMbpJXxiUKJrCxkNSPUapyIZp6N3NwpzVvXiGkMqlbbiOBA7LEw1ClrjXMeKdNYxPz1pFRPYCEZ6tENHu+tyn8lCkUPj/I3Mu7//+8ndiZhCYQdqiWnaXl6Uuy9/VS/pTXHX8lay+clyeEma4EYIKH4I6PX76u+dbacJelerBXcV/ajnJrBrYQe8LQP/sD2CDKq5PKFqqZw5W5vLZ2fU/9pvC3InQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqrKkCwtBkbPdI/K6Y0WPKTUfyWCHcjV+wtBt+RLuEE=;
 b=asAyP0L/h9BB11a0rXcc2sUjuPyafa0FzB48RJnavCuGlNN/fRh1FV0iQIL6VVCBKpMSoHf/C5tdrakqL47Dl5v9JOiW5r2+MKp95g7jQZKe1tUBmGwFnIRy5eXrGR8GdQj5A56p/LMVt22c5VBw72hJ1MfWA5T/43QgC+2QW1Gq6gL3nZVe5mj6ER1edrDIjvDsXhqReiO09EQBMipF+dpCCXzLGqsq1F/IwKRlEBI+UvtvQqBIiBdHdRAtRVLGOFpDKCGFBqr8MDf966C2REiNnTYDiMt5HgJ9OvgWmd9ZuST65KaHRtT/VVfeCz2WKyyMQ8Jal/wpR6rNg/+BPw==
Received: from PH8P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::33)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 17:34:41 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:510:2d8:cafe::94) by PH8P221CA0020.outlook.office365.com
 (2603:10b6:510:2d8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 17:34:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:10 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:07 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 12/16] vfio/pci: Restore device state from slot_reset()
Date: Tue, 29 Sep 2026 18:33:01 +0100
Message-ID: <20260929173305.204856-13-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e61222-4928-402c-90aa-08df1e4ff1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|6133799003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	0T1kTWo+52aN4JOxzZvlaiSiTx8UQ2JEZFYL/q8Wvgwu9gVmJXquY8VoFG8gbeJXAKt1W6UNcAQAeyJW50F6HhhBTgMVuZ2CWqgD0Y5NHtU8M50xUXrosm5T4YGJ7LogUGX4Hz7mQAtmV2FyP2zAT+kIpX8OvkbPJwnybL2You0AoYVCmwmxhtSTmNTJhvdcvQJ5BO20UREy6UiiJGQfRXY4ubBUq8QRjjPQdtIkPU6gNYdnpUafcxeivN+Zh99lf3YBRvxK1Kayg7poYv2xvSizkIW+LTR2uPxuIDK4v9HmiErweuBTnNfgKCHmqjpOZlcxDvKeeHEY0Ttom6W99ShTnRZe7WlwGs/bbStlMCJe7f1MIkvIoTRAVP+S6SqbBHaXf4NSnXnB2u3yiGVBqnpl9AtCDZ1Hzt5UTfNkQQPz5FdDhWUgMvxYz60l76mu6gdKrCUCOwYVoVw2rWKYl19CZgMxnqs7n47ESQjNSDZ5FedeL5QwcsZH3slGKyqw6k+USbflYR5QJhZpiAKs9fT9Am/N3PLcAuuYpzSbSHfspsoDIYH17zF2lv0sk1S5ifcqVjl09fM1EXvGOpttUE7B/odrsNOHjooC17z0nqCAI2+gMuZqFBl2V1AHzzUVMyDdL+H/jGUcSl2Kcw8FPFr+mInDiJodXbHbtBuuMwdG11G5DZpgzaXasdSRbYCqWbYXHutGvX5n6tp57Lv+kw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mb0jBomjDIkXEgf1vBnlhGCcD8fkvr/1usvZnZZ5In4o5I6XT4m0eHTme61HRcl0AUyQVYCkZwGzrhsLAYsJhzBBy3qfGOzLhATjfCVsXqZVQLKmZWw2BY8mNdyyWtl8GqB8ZctQSB73OSFKtn1xADVBNSLdNvI2Fgm8tx+rYMMv/DqtfISq0pLFPADhT7fuuQIXCO/G22QNOZG5KZWvEe89dmH6qh1FRVv/3Z6HpJnTISzFyPzOpCA7xGK8idSGc3NAixTaEADkibAuuu6hdWlBTHXIaUg92AuHAZewlBuhJLAGVNkYuU0soTSH3x93NepYoELD5zdoZF0/ZoQxAA+g+3HtOovI36iXcpYhLE3/n2vSaOOJGcnczh5oPB7tlBAEQIVxaTMG2GLs/TRfk/CG9o3LfvMKMLFT4kimWnaOhB+5CdkWQGb0PrkQ0P75
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:41.6038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e61222-4928-402c-90aa-08df1e4ff1c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651

A host reset clears device configuration. Add slot_reset() to restore
the state saved at open before tearing down interrupts. MSI-X shutdown
requires the restored BARs to access its table.

Load vdev->pci_saved_state before entering D0, since the power transition
may restore BARs. PCI core's saved copy may have been overwritten by a
user reset or D3 entry. Discard the stale pre-reset pm_save and update
the power state without restoring it. Keep access blocked and report
failure if the snapshot is missing or restoration fails.

Keep active INTx masked in the loaded snapshot so restoration cannot
re-enable it before IRQ teardown.

Use pci_set_power_state() as existing recovery callbacks do.

Hold access_lock to exclude close's interrupt teardown. Return NONE on
failure to allow recovery of other devices under the bridge to continue.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
Note: This series adds a VFIO recovery callback that can reacquire
pci_bus_sem through the D0 ASPM update while AER already holds it. This
can deadlock behind a queued writer. Similar callback patterns in other
drivers do not resolve this new VFIO locking issue; topology does not
establish lock ownership. See the cover letter's "Locking and open
questions" section.
---
 drivers/vfio/pci/vfio_pci_core.c | 101 +++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 667c5813f6c7..a7b7499e071c 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -311,6 +311,15 @@ static void vfio_pci_probe_power_state(struct vfio_pci_core_device *vdev)
 	vdev->needs_pm_restore = !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);
 }
 
+/* Keep recovery's INTx mask when restoring a loaded PCI state snapshot. */
+static void vfio_pci_recovery_mask_saved_intx(struct vfio_pci_core_device *vdev)
+{
+	if (READ_ONCE(vdev->access_blocked) && vdev->pci_2_3 &&
+	    READ_ONCE(vdev->irq_type) == VFIO_PCI_INTX_IRQ_INDEX)
+		vdev->pdev->saved_config_space[PCI_COMMAND / 4] |=
+			PCI_COMMAND_INTX_DISABLE;
+}
+
 /*
  * pci_set_power_state() wrapper handling devices which perform a soft reset on
  * D3->D0 transition.  Save state prior to D0/1/2->D3, stash it on the vdev,
@@ -2499,6 +2508,18 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_device);
 
+static void
+vfio_pci_signal_recovery_event(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_eventfd *eventfd;
+
+	rcu_read_lock();
+	eventfd = rcu_dereference(vdev->pci_recovery_trigger);
+	if (eventfd)
+		eventfd_signal(eventfd->ctx);
+	rcu_read_unlock();
+}
+
 pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 						pci_channel_state_t state)
 {
@@ -2515,6 +2536,85 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
 
+/* Caller holds memory_lock. Discard the pre-reset PM snapshot. */
+static int vfio_pci_recovery_restore_state(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int ret;
+
+	if (!vdev->pci_saved_state)
+		return -ENODATA;
+	ret = pci_load_saved_state(pdev, vdev->pci_saved_state);
+	if (ret)
+		return ret;
+
+	kfree(vdev->pm_save);
+	vdev->pm_save = NULL;
+	ret = pci_set_power_state(pdev, PCI_D0);
+	if (ret)
+		return ret;
+
+	vfio_pci_recovery_mask_saved_intx(vdev);
+	pci_restore_state(pdev);
+	return 0;
+}
+
+static pci_ers_result_t vfio_pci_core_aer_slot_reset(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+	int ret = 0;
+
+	mutex_lock(&vdev->access_lock);
+	if (!(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS) ||
+	    !vdev->device_open) {
+		mutex_unlock(&vdev->access_lock);
+		return PCI_ERS_RESULT_NONE;
+	}
+
+	/*
+	 * Load the open snapshot before D0, which may restore BARs from
+	 * saved state. Restore BARs before IRQ teardown so MSI-X shutdown
+	 * can access the table after the host reset.
+	 */
+	down_write(&vdev->memory_lock);
+	ret = vfio_pci_recovery_restore_state(vdev);
+	up_write(&vdev->memory_lock);
+	if (ret)
+		goto out_failed;
+
+	/*
+	 * Close clears device_open under access_lock before IRQ teardown,
+	 * excluding this callback from the teardown path.
+	 */
+	mutex_lock(&vdev->igate);
+	if (vdev->irq_type < VFIO_PCI_NUM_IRQS)
+		ret = vfio_pci_set_irqs_ioctl(vdev,
+					      VFIO_IRQ_SET_DATA_NONE |
+					      VFIO_IRQ_SET_ACTION_TRIGGER,
+					      vdev->irq_type, 0, 0, NULL);
+	mutex_unlock(&vdev->igate);
+	if (ret)
+		goto out_failed;
+
+	WRITE_ONCE(vdev->pci_recovery_flags,
+		   vdev->pci_recovery_flags | VFIO_PCI_RECOVERY_RESET);
+	mutex_unlock(&vdev->access_lock);
+
+	return PCI_ERS_RESULT_RECOVERED;
+
+out_failed:
+	WRITE_ONCE(vdev->pci_recovery_flags,
+		   (vdev->pci_recovery_flags | VFIO_PCI_RECOVERY_FAILED) &
+		   ~VFIO_PCI_RECOVERY_IN_PROGRESS);
+	vdev->pci_recovery_command_valid = false;
+	mutex_unlock(&vdev->access_lock);
+	/* Report failure here; resume() skips completed transactions. */
+	vfio_pci_signal_recovery_event(vdev);
+
+	/* Allow recovery of other devices under the bridge to continue. */
+	return PCI_ERS_RESULT_NONE;
+}
+
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn)
 {
@@ -2587,6 +2687,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.slot_reset = vfio_pci_core_aer_slot_reset,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0

