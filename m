Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E3736B926;
	Tue,  1 Sep 2026 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255316; cv=fail; b=Zoepe/A5xzuvrBXZGq+oTuL6/b+qruKoMIc8cZjQjGvtIytbudEhd1Bigg/xBrkpv/B71H0oFUUU17QF6ocOBSNFtDt6+Fl3h3vS6QcyZIxSW/O/QG3sJDIzz1hVvhFfRYAN3mloTqK+cj+38FOdfROQT4ybLMNNBqXwGK/nMiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255316; c=relaxed/simple;
	bh=cdTjF/dLO5TBEbaoYbpK+4WBjzOGDJaXlZLeezYJBC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuAaEyyr/hpRmwVxqILGpPybRsuhbxkkqgPJnHZz8xEEjJjDghFaYwe3Hk1Of7ExN+DqawvjGXLXdTJtkeJjFnu8Pokenpr+F8TEdsaYwd2VW4+gJBqWstCYqBKmI61LD+SkZpBs7dkM04vNfZLQhLKYQuGUdyTrse6QBIl5pgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HqPJ0+n8; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HqPJ0+n8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/PKQK9UyVXeU3q2qzRMCEZJSAWw7JDyZKw+S9Fs+P1GbGRp7vI2zSFj1oHe4S9RouJLSzqb4/JwzHsnXjIjCZcH+GlgmGPG1zyfP3QWHi6MGWYG+kuErhVggQnuz80ijgJZ6eg8puE7lQy+WoO7q992tzNMUkvLb/YruS/kgYdTeLTjluqI+ER+uUpxZXrtOWMOUfRnE5fnw9swDYZo5vB8ZxJ1MbYgIRC07wqZLeJE+OxyyM6zwPHxPtehLG7EJlMrRO+fHVlcx1jnit1sPKclRx3sRMI4G8BylhSQA+ewc7Vr1z8oJ0L0xQqYXY3p6hTZxQawfGd5kbHz0yCKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lo3lIu0Bg8ETd8dcbT7huGOHg8uGmD/rKWn6YJrzki8=;
 b=bTHZqqk90thRODhRRXeCqZnMfJZZ2hLYZ5x7r5rrOhvppPrP6HDZG5RcQDdpBWucucvKmUMq80+KQksig7f01Tr5SHDuEKuFFG49biLyphwK5g6OUnYbDacPPLzLx0Wb+jL0mIzopPDX23hJhXnAYI7xx9WWXX+xWF2KZjukn5/O9omAsDowiCsCOIGRreJdIjKygUq2kaTa26JuQCz3kBotvpWbAmu8bGAGKdDq7HnhIkFqwoZMwbpIpjwqosIIhIEkaiuTjSymtHwcEwVhYnMmF4H0S2OCHbT4/oaYRvgZwzjJbbvVKSI32IHuAYLL5E/PlG7UKtdrdH7+BT+94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo3lIu0Bg8ETd8dcbT7huGOHg8uGmD/rKWn6YJrzki8=;
 b=HqPJ0+n8epgbNZzvpY2XlWzfWjcqqMcGn2tgaxy2q31BZX6CndC1LJOmbqhb55DtjmEJQvr7pZuWYBxJiVT1eMBDAZUlsPqTnmlwcWHfc2KNpMixZw9fIEEGOK8s1wVqtL2V24adrRIYTxWr8fqFU+7ipjXlwbhwteeedYUJoHrIjErE7Rk5QSU71Zt+/l4a25mEk7nYrj7wag3EknmmPMUHzMBv0aJdWjSnTLPnkF2cEZKlxPStmeMRqzk6FQWt8LsNhn3OBS4xrXXHRtPUb5zIICRuQWGmGSWy7RoVJEtnMxJ2CLmhJZYltc/z6gqJ2g3/jgLUifPm3NkMuEN57Q==
Received: from CH2PR14CA0022.namprd14.prod.outlook.com (2603:10b6:610:60::32)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:34:42 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::28) by CH2PR14CA0022.outlook.office365.com
 (2603:10b6:610:60::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:34:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:24 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:21 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 18/19] vfio/pci: Coordinate generic device access with host recovery
Date: Tue, 1 Sep 2026 10:32:16 +0100
Message-ID: <20260901093217.8539-19-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fbcbaa-19ba-42ea-ef6b-08df080c402e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|6133799003|22082099003|18002099003|11063799006|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	HLTOKpQMD+xMqSxpCOnVUE3XbxerICdyStZSByeHVRbv8beu/yF+5VltqjlwLplg1HR261gel22/cORrVvaZYww+6+uJF23qk6BHEzpuXQel8X64qAs1tJK/S+TIu+yo1V4RVUhrQNghq3igNLY1yLxeRPvIjB89Bj9hDA4todsfgjybwULbHG/NBqXRqp56O3PWraqYvjLsoVWN6ovLv0t2yF5AM911gYVGvn5RexqntCvbgo0JifG69MWnhsj1V2hxxmgbtq9s0iN3ixs8MUKyAxVO6aMvQhjOg4Q5179BZynR5GgGhTr96/Ovt5b2P/YilWAIjo/Stj6TKv1VRXYeCXHHvvWEWj71Cea7mbvWS7G9i4Fpy0oGjlonFvpmMyOyvrpEQ0DkfN9o3LN8BfmQg6vUoE1EDMjK4wF2zSiKZYJvDsEPAMMD1/TrMlHUJPz0ki7GG5EBi79iJ+EcQFeqDIYmGV1qIa+0WuIkhlP4prFWiv10ceiha+wRqzTB2kvaba8zrmpPS/XlXJWjPztwQTXpmfy+UUjQBftNnv1l0KiGhU5N/sL4XcmuHybjWDZUxHYFr8IcT2ivKUtOKrybN7ir8vMZs5QZh2ZJD1rnYhmh60AMqhzb7yJ/CDA5VrYOlSKsYSlqOi8DON0itXCaBsdh4uDrdOpv7KvOdWYacMPU/rqybUy9SVs+JNSSt+a5dIYB57NOQ1AMw4e+ug==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mvbljsNGIz5drrL33bU5mn0wwkIPzl3Ueot91gBmgXEo/TqEnKUX0AhB4ATuhZq1qdqBz0H5FXBiVJ0ox635bwzgh9zOl6+37Z8C7KpzzStqqotVahkpze7NQfjlmQA1r6wAOgHRsXUQAo/blXIaLRToC6hxmvY90q0o97mhNOBX7y30Iw7l8eng1yxI307emcgk0wHwamNYLGklnQRYs2kOrqS/9MvvFnRvyAv6YGqM5EIQpdn+1nTWGO956hEpdSO7S/MOIg8LUvnfrtEAX3ziNso2ve8b/Srja7nIXe4Ilpbhyzh3cbPf/NLqh04KVgiFs+XmKXfzXBTHDFV1PbitapuBIw2ECmOw48OhtorrhVCHRNYosLLRxNDElp7NWd7IiOMthYOhCZOOzF6N4SesVckcglSg7Lwen+W+lviWLAxikkCNY8LraWdERmU8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:34:41.7708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fbcbaa-19ba-42ea-ef6b-08df080c402e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049

Wire up error_detected() for generic vfio-pci devices whose user has
enabled recovery. Devices which have not opted in, and variant drivers,
keep the existing signal-only behaviour.

Block new device access and drain what is already running, then revoke
BAR mappings, revoke exported DMA-BUFs and stop bus mastering, so nothing
touches the device while the host recovers it. A non-fatal error gets the
same treatment as a frozen one. The host has not finished deciding what
the error was, and can still escalate to a reset, so the device is not the
user's again until resume() says so.

Do not trust a command word which reads as all ones. A device which has
stopped responding still returns success, and writing that value back
would set every command bit while saving it would restore them at the end.
Treat it as a config access failure instead.

Quiesce INTx first. For a device with per-function masking, also save
PCI_COMMAND and write it back with INTX_DISABLE set and bus mastering
cleared, under irqlock so an interrupt handler cannot interleave.

Publish the state in one store. IN_PROGRESS and CHANNEL_FROZEN go out
together so a lock-free reader cannot see an event which is in progress
but not yet marked frozen. FAILED stays set until the device is closed
and reopened.

A frozen channel votes NEED_RESET. A config access failure of our own
votes NONE, which leaves the rest of the recovery domain alone. Only a
permanent channel failure reported to us votes DISCONNECT.

If a ROM unmap raced the blocked interval, its config write is left for
resume() to complete.

A second event which arrives before resume() has finished the first joins
the transaction already running. It keeps the sequence number, the command
word saved before the device was quiesced, and any reset a slot_reset() in
between recorded. Starting again would save the quiesced command word and
restore a device with bus mastering off, and would drop the record of a
reset the host had already performed.

An event which arrives while a VFIO_DEVICE_RESET has access blocked runs
as usual. The PCI core calls this with the device lock held, which
pci_try_reset_function() also takes, so the two cannot overlap the reset
itself, and the reset leaves the state alone once this has claimed it.
Suppressing the event instead would lose a permanent failure or a bus
reset the host went on to perform, which is the state userspace most
needs.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 166 ++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index eed0430c32ee..2d757d6a5fe1 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2746,14 +2746,178 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 {
 	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
 	struct vfio_pci_eventfd *eventfd;
+	pci_ers_result_t result = PCI_ERS_RESULT_CAN_RECOVER;
+	unsigned long irq_flags;
+	bool terminal = false;
+	bool nested;
+	u32 flags;
+	int ret;
+
+	if (!vdev->pci_recovery_supported ||
+	    !READ_ONCE(vdev->pci_recovery_enabled))
+		goto out;
+
+	down_write(&vdev->recovery_lock);
+	if (!vdev->pci_recovery_enabled)
+		goto out_unlock;
+
+	/*
+	 * A failed device remains blocked until close and a new open have
+	 * reinitialized it. A later bridge event cannot make the saved VFIO
+	 * state valid again.
+	 */
+	if (vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_FAILED) {
+		result = PCI_ERS_RESULT_NONE;
+		goto out_unlock;
+	}
+
+	if (!vdev->pci_recovery_device_open) {
+		result = PCI_ERS_RESULT_NONE;
+		/*
+		 * PCI core rebroadcasts permanent failure when subtree
+		 * recovery fails. Complete an event which started before
+		 * close so a later open is not permanently stuck on
+		 * IN_PROGRESS.
+		 */
+		if (state == pci_channel_io_perm_failure &&
+		    (vdev->pci_recovery_flags &
+		     VFIO_PCI_RECOVERY_IN_PROGRESS)) {
+			WRITE_ONCE(vdev->pci_recovery_flags,
+				   (vdev->pci_recovery_flags |
+				    VFIO_PCI_RECOVERY_FAILED) &
+				   ~VFIO_PCI_RECOVERY_IN_PROGRESS);
+			vdev->pci_recovery_command_valid = false;
+			terminal = true;
+		}
+		goto out_unlock;
+	}
+
+	WRITE_ONCE(vdev->pci_recovery_access_blocked, true);
+	/*
+	 * A second event before resume() has finished the first joins the
+	 * transaction already running rather than starting one. Keep its
+	 * sequence number, the command word it saved before the device was
+	 * quiesced, and any reset a slot_reset() in between recorded. Reading
+	 * the command word again here would save the quiesced value, and
+	 * restoring that leaves the device with bus mastering off.
+	 */
+	nested = vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS;
+	if (!nested)
+		vdev->pci_recovery_command_valid = false;
+	vfio_pci_intx_recovery_start(vdev);
+	/*
+	 * INTx hardirq and virqfd callbacks cannot take recovery_lock.
+	 * For devices with per-function INTx masking, mask INTx while holding
+	 * irqlock so a callback which passed its blocked-state check is drained
+	 * before the temporary command value is installed. Devices without
+	 * per-function masking were quiesced above through genirq.
+	 */
+	spin_lock_irqsave(&vdev->irqlock, irq_flags);
+	ret = 0;
+	if (state == pci_channel_io_normal && vdev->pci_2_3 && !nested) {
+		u16 command;
 
+		ret = pci_read_config_word(pdev, PCI_COMMAND,
+					   &vdev->pci_recovery_command);
+		/*
+		 * A read from a device which has stopped responding succeeds
+		 * and returns all ones. Writing that back would set every
+		 * command bit, and saving it would restore them at the end.
+		 */
+		if (!ret && PCI_POSSIBLE_ERROR(vdev->pci_recovery_command))
+			ret = -EIO;
+		if (!ret) {
+			command = (vdev->pci_recovery_command &
+				   ~PCI_COMMAND_MASTER) |
+				  PCI_COMMAND_INTX_DISABLE;
+			ret = pci_write_config_word(pdev, PCI_COMMAND, command);
+		}
+		if (!ret)
+			vdev->pci_recovery_command_valid = true;
+	}
+	spin_unlock_irqrestore(&vdev->irqlock, irq_flags);
+	vfio_pci_zap_and_down_write_memory_lock(vdev);
+	vfio_pci_dma_buf_move(vdev, true);
+
+	/*
+	 * Allocate a sequence for a new transaction, and drop the flags the
+	 * previous one left behind for userspace to read. A nested event adds
+	 * to the flags already there. Each path below publishes the result in
+	 * one store, so a lock-free reader never observes a cleared state that
+	 * looks like successful completion.
+	 */
+	flags = vdev->pci_recovery_flags;
+	if (!nested) {
+		if (++vdev->pci_recovery_sequence == 0)
+			vdev->pci_recovery_sequence++;
+		flags = 0;
+	}
+
+	if (state == pci_channel_io_perm_failure) {
+		WRITE_ONCE(vdev->pci_recovery_flags,
+			   (flags | VFIO_PCI_RECOVERY_FAILED) &
+			   ~VFIO_PCI_RECOVERY_IN_PROGRESS);
+		vdev->pci_recovery_command_valid = false;
+		result = PCI_ERS_RESULT_DISCONNECT;
+		terminal = true;
+		goto out_memory;
+	}
+
+	if (state == pci_channel_io_frozen) {
+		WRITE_ONCE(vdev->pci_recovery_flags,
+			   flags | VFIO_PCI_RECOVERY_IN_PROGRESS |
+			   VFIO_PCI_RECOVERY_FROZEN);
+		result = PCI_ERS_RESULT_NEED_RESET;
+		goto out_memory;
+	}
+
+	WRITE_ONCE(vdev->pci_recovery_flags,
+		   flags | VFIO_PCI_RECOVERY_IN_PROGRESS);
+	if (ret)
+		goto out_failed;
+	if (vdev->pci_2_3 || nested)
+		goto out_memory;
+
+	ret = pci_read_config_word(pdev, PCI_COMMAND,
+				   &vdev->pci_recovery_command);
+	if (ret)
+		goto out_failed;
+
+	if (PCI_POSSIBLE_ERROR(vdev->pci_recovery_command)) {
+		ret = -EIO;
+		goto out_failed;
+	}
+
+	ret = pci_write_config_word(pdev, PCI_COMMAND,
+				    vdev->pci_recovery_command &
+				    ~PCI_COMMAND_MASTER);
+	if (ret)
+		goto out_failed;
+
+	vdev->pci_recovery_command_valid = true;
+	goto out_memory;
+
+out_failed:
+	WRITE_ONCE(vdev->pci_recovery_flags,
+		   (vdev->pci_recovery_flags | VFIO_PCI_RECOVERY_FAILED) &
+		   ~VFIO_PCI_RECOVERY_IN_PROGRESS);
+	result = PCI_ERS_RESULT_NONE;
+	terminal = true;
+out_memory:
+	up_write(&vdev->memory_lock);
+out_unlock:
+	up_write(&vdev->recovery_lock);
+	if (terminal)
+		wake_up_all(&vdev->pci_recovery_wait);
+
+out:
 	rcu_read_lock();
 	eventfd = rcu_dereference(vdev->err_trigger);
 	if (eventfd)
 		eventfd_signal(eventfd->ctx);
 	rcu_read_unlock();
 
-	return PCI_ERS_RESULT_CAN_RECOVER;
+	return result;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
 
-- 
2.43.0

