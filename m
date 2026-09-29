Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103052CCD8;
	Tue, 29 Sep 2026 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703299; cv=fail; b=eC15EbqgOMxov3fNyGNxXNAGvTU+0bNcCruINYF8CrU9jrxOc/pOT96d9Vgo+Su2eQS0wo+MuOeGC2l8rJr6EOM+5qKIOZQuDPLWIpjxA+zqWw3OHyGyPkWcVvfp1ay0oSWXs5EkMomybH5uc6M/PKgBGouV9RnIsrASromiGZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703299; c=relaxed/simple;
	bh=VOAZQMvOxMAMc2Kr/Er3tz4gXT5RRp5XfaURX83VV30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ob782YYr+e7YOv/didVTTkAD7EsTf7wz9oLesxbv7lSB0GV1RcjG55WvBIizx9G/7e1kMcqPDv1S5GFj0EI2NQxc30mYf5Ex4qNUJW7o+fMUwgqF7yj8UjMrTqmYM3Gb0KYqkXqLF4jYxlqYJkrIxltEywYDLGS1FngulEaItzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A42RjMaX; arc=fail smtp.client-ip=40.107.209.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A42RjMaX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAnSrXeS2DVo13gBlhJ553hSauP9dTrYaNfCaQAQHvmULOjLg1WdjfDfyxFV/qeBQAk0kdMMwI+cXJnOz+MUhAamBNDpJmTE/eEhNl/cGflwMepyYS+ynQmZ4z405m71NYqYeOlcSl8+Ot9MlUFDINTiBlEOdq+Sxvz2vGGUHofVFsUc1UednmCAliqnAu41lh9eYTdNfrQWXDBGe6RR62oHR8n7hb6O4V0IAwI7lR3RkqqedVbaF+yhps/ZF0TzoqDbuwHO1bG9RCuGoge7qaYtj4GcaimMD2ef0msGYXy+/4hBvwt+CMF22nENe3+5C6zRg1SZE9t4FL9exux8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ/ZMwXz3RpZnkETRZNz0r55bIo4t5MHN9yo/5/MV30=;
 b=S2yQvk5WfzuM//6uNr7m4XzPvlYQMmwxMG1eMwbsfD9zSOBtXelkKrsNvAngGk23Mmk6NPLenAzZlHCdEh2tucNBCmO92ejEMeMkjLQG1tFe1A1pwPevvpPCdHeH/kqS+RVXATwHbhgU7xQsuPYI5RKnRnpzUMCOg7hisUi1jpfvyxGjBmTqCOnvDmo14cdHj0k1xPTYgui80wYCwL7P8Pb+utRlK/fTeb3nlhx4fPchgloDksU95SGwNtKV6WrTx2I6UMRu8fS7S0S2rxQnFB4eZ6rrUUnqpGSSu94SgnBM7YommD8XnrP+qVoVab4MJ9UgdMZUOsr6nvUGq+HoAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ/ZMwXz3RpZnkETRZNz0r55bIo4t5MHN9yo/5/MV30=;
 b=A42RjMaX7G96rBU7I89UBjoAWOJFUggItMGFXUNz07ds0qWzLtOhYoTD4Y01T7unURb+Y1PWPA9KEGcTqK5ijrwEJDlgPgRVaTg8MiS0JthuZEi04kgHEChaW0+nGcD85yJZqoew8iA3NqgHl7Q8dLie+0oB0PNAacQ0UMCC7mtepQPId1KwIO0BIa+d+Ga3TXQLCiUFTcR4cJvTOlSIy8WbFcJipaf4eDOx39l3BiPkwStEhFrRk19Sohe9neVm/YPew0M6OHKuxiORDXOC3l0OHCOmaWXMYwYG/NRBdIwAN0fGNTEgrkdFInbMH/p9Ef+fGhktD06lysGaKUxXSg==
Received: from PH8P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::28)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 17:34:47 +0000
Received: from BY1PEPF000264B5.namprd02.prod.outlook.com
 (2603:10b6:510:2db:cafe::26) by PH8P223CA0018.outlook.office365.com
 (2603:10b6:510:2db::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 17:34:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B5.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:18 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:34:14 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 14/16] vfio/pci: Block device access during host recovery
Date: Tue, 29 Sep 2026 18:33:03 +0100
Message-ID: <20260929173305.204856-15-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B5:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 753f540f-ded1-4240-de4a-08df1e4ff52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|11063799006|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	h1rlw+NNocu5sm93KIqOc1f7cDG0hcDexWpis718E60yE+Dd8xXpMgv6OA7fOsXZ1FKIF5mlZyKWTvLqzlO+aX7TlYkRR1JdIjGBi1T5fCSeNIl4uZLKZRmFOuaFXANCwCNdCG5YFEQ3/XEdRMZrd6h0m0pQIHvQ0wLYkQmzoMOC3eNWOWWYHNQUb/NP9WqXkZzTB07/NDL4NYQ7U+4oTf2cTkZPZgLGYKAGPLGmjzVYLm3PtKUgyK2yKVLWSIkSafYUybBcVhNDzS3lmeCiCU7GsXx7+x44MAFVwXbeRCfQqWnoe6rvEMB3WQ/zChY85IFEt7S+GBMtnittqrOPlGQCHiU4ocb3Ic2BQShNs44cd55jWg0wtaNtTMVLGE1WytQ+gG3Ie3LaAM6vLsA4yS1v+YAsHdfVrXXJUVFFt7wIcmYpYYOb3UNZWmhGuZm7tcNTjWCNmbQ8fbsm3j508Lm1GlVGX4jXOutmknYO1x+56NvVvO68PYzTGmca0vDCSBG0VDA26va65/wMhOfg+6IjqO58DlEeHBWiahE5k5PAEyDgNm4Gowe9lLtQpaufmy0F1wlLj0iIL0NaJtESBEacdfokzj0ExKXhx9LilkLYr6oxfi9Pe8gaLf13AMxf5rUoIIZpIkvvlVSi4zt7zL95GXJm021dAswIlmVCY2uw+E3jEzpAWTo3F3xvEf7oroN4FPess+S0CGLQCJOMVA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hJTrTZo6p4R4nmESQTo7r4P72ssOYzhlTDqwNLI8aKfTTgPdfDanMREF5XLxdymIxCJFJWrdB5j4Oz3HqrLB3kcAkhCQh8ebRjIpAHWBGTskhIcaEjEJBDdXTA9CmnXpqqJdIVtwHOXKwmNYkKj9l1SgiMa4BJVBV844bmw8YI4lPcvoIJCgGVS26sVThLGuUkVm0UboTgXa6NExCadIEX4QXK9jOz+1RzBZ7Ac01ThpaAh9byTay4Balb2dThl0UntO3e7geL43R0puxPLVJDnzbhMMxjQRWuYfWcJmV76Z9v+2kf+j5xUoo1i1eGEHSO9PuNPrNGS+rv2vJx6Rp6slFAqOOMtltnq1Wa51bue5mfaEzQNpmCDf/17UUJnqAX4bueh1SlS1VfyfrBvxfZOoL0d8FHTRLDeAiRUOdA6nfAUiQHU76fYxaS0BJa8h
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:47.2990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 753f540f-ded1-4240-de4a-08df1e4ff52a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742

For userspace that enables recovery, extend error_detected() to block
device access and drain existing SRCU readers. Mask INTx, revoke BAR
mappings and DMA-BUFs, and disable bus mastering on a normal channel.

Return CAN_RECOVER for a normal channel, NEED_RESET for a frozen channel
and DISCONNECT for permanent failure. If saving PCI_COMMAND or disabling
bus mastering fails, return NONE and leave access blocked. Preserve the
original command and sequence number across nested events.

Track host recovery across close and reopen, including without userspace
opt-in. Reject open during a recorded transaction or after disconnection.
Clear deferred power requests at close and keep DMA-BUFs revoked while
access is blocked.

Reject hot reset for devices in ongoing recovery, but allow failed
devices so healthy siblings can be reset.

Reject userspace SR-IOV configuration while access is blocked. 

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
Note: The existing open/close paths are not serialized against the full
host recovery transaction. This series blocks reopening during an
already recorded transaction, but recovery can still start after the
open check, and close can overlap the physical reset between callbacks.
See the cover letter's "Locking and open questions" section.
---
 drivers/vfio/pci/vfio_pci.c        |   3 +
 drivers/vfio/pci/vfio_pci_core.c   | 166 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_dmabuf.c |   5 +
 3 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 830369ff878d..4887dd062c77 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -213,6 +213,9 @@ static int vfio_pci_sriov_configure(struct pci_dev *pdev, int nr_virtfn)
 	if (!enable_sriov)
 		return -ENOENT;
 
+	if (vdev->pci_recovery_supported && READ_ONCE(vdev->access_blocked))
+		return -EIO;
+
 	return vfio_pci_core_sriov_configure(vdev, nr_virtfn);
 }
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index d6cc34240b25..2ec8022e4a69 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -617,6 +617,15 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	u16 cmd;
 	u8 msix_pos;
 
+	if (vdev->pci_recovery_supported) {
+		if (pci_dev_is_disconnected(pdev))
+			return -ENODEV;
+		scoped_guard(mutex, &vdev->access_lock) {
+			if (vdev->pci_recovery_host_active)
+				return -EBUSY;
+		}
+	}
+
 	if (!vdev->disable_idle_d3) {
 		ret = pm_runtime_resume_and_get(&pdev->dev);
 		if (ret < 0)
@@ -860,6 +869,10 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 			WRITE_ONCE(vdev->access_blocked, false);
 			WRITE_ONCE(vdev->device_open, false);
 			WRITE_ONCE(vdev->pci_recovery_flags, 0);
+			/* Discard pending D0 so it cannot be replayed after reopen. */
+			down_write(&vdev->memory_lock);
+			vdev->power_up_pending = false;
+			up_write(&vdev->memory_lock);
 		}
 	}
 
@@ -1843,6 +1856,15 @@ void vfio_pci_core_access_end(struct vfio_pci_core_device *vdev, int idx)
 		srcu_read_unlock(&vdev->access_srcu, idx);
 }
 
+/* Reject new accesses and wait for existing SRCU readers. */
+static void vfio_pci_core_block_access(struct vfio_pci_core_device *vdev)
+{
+	lockdep_assert_held(&vdev->access_lock);
+
+	WRITE_ONCE(vdev->access_blocked, true);
+	synchronize_srcu(&vdev->access_srcu);
+}
+
 ssize_t vfio_pci_core_read(struct vfio_device *core_vdev, char __user *buf,
 		size_t count, loff_t *ppos)
 {
@@ -2521,19 +2543,147 @@ vfio_pci_signal_recovery_event(struct vfio_pci_core_device *vdev)
 	rcu_read_unlock();
 }
 
+/*
+ * Save PCI_COMMAND, clear bus mastering and set the requested bits.
+ * Reject an all-ones read from an inaccessible device.
+ */
+static int
+vfio_pci_recovery_save_and_clear_master(struct vfio_pci_core_device *vdev, u16 set)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u16 command;
+	int ret;
+
+	ret = pci_read_config_word(pdev, PCI_COMMAND, &vdev->pci_recovery_command);
+	if (ret)
+		return ret;
+	if (PCI_POSSIBLE_ERROR(vdev->pci_recovery_command))
+		return -EIO;
+
+	command = (vdev->pci_recovery_command & ~PCI_COMMAND_MASTER) | set;
+	ret = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (ret)
+		return ret;
+
+	vdev->pci_recovery_command_valid = true;
+	return 0;
+}
+
 pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 						pci_channel_state_t state)
 {
 	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
 	struct vfio_pci_eventfd *eventfd;
+	pci_ers_result_t result = PCI_ERS_RESULT_CAN_RECOVER;
+	unsigned long irq_flags;
+	bool notify_recovery = false;
+	bool nested;
+	u32 flags;
+	int ret = 0;
+
+	if (!vdev->pci_recovery_supported)
+		goto out;
+
+	mutex_lock(&vdev->access_lock);
+	/*
+	 * Track the host transaction even when userspace has not enabled
+	 * recovery. Reopen must wait for resume() or permanent failure.
+	 */
+	vdev->pci_recovery_host_active =
+		state != pci_channel_io_perm_failure;
+	if (!vdev->pci_recovery_enabled)
+		goto out_unlock;
 
+	/* Keep failed devices blocked until close. */
+	if (vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_FAILED) {
+		result = PCI_ERS_RESULT_NONE;
+		goto out_unlock;
+	}
+
+	if (!vdev->device_open) {
+		result = PCI_ERS_RESULT_NONE;
+		goto out_unlock;
+	}
+
+	notify_recovery = true;
+	vfio_pci_core_block_access(vdev);
+	/*
+	 * Preserve the saved command for nested events. The current value
+	 * may already have bus mastering disabled by recovery.
+	 */
+	nested = vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS;
+	if (!nested)
+		vdev->pci_recovery_command_valid = false;
+	vfio_pci_intx_recovery_start(vdev);
+	vfio_pci_zap_and_down_write_memory_lock(vdev);
+	/*
+	 * Serialize PCI_COMMAND updates with the INTx handler, which does
+	 * not take access_srcu.
+	 */
+	spin_lock_irqsave(&vdev->irqlock, irq_flags);
+	if (state == pci_channel_io_normal && vdev->pci_2_3 && !nested)
+		ret = vfio_pci_recovery_save_and_clear_master(
+			vdev, PCI_COMMAND_INTX_DISABLE);
+	spin_unlock_irqrestore(&vdev->irqlock, irq_flags);
+	vfio_pci_dma_buf_move(vdev, true);
+
+	/*
+	 * Start a new sequence unless this event belongs to an active
+	 * transaction. Publish the flags in one store to avoid exposing
+	 * a transient cleared state to lockless readers.
+	 */
+	if (nested) {
+		flags = vdev->pci_recovery_flags;
+	} else {
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
+	if (!ret && !vdev->pci_2_3 && !nested)
+		ret = vfio_pci_recovery_save_and_clear_master(vdev, 0);
+
+	if (ret) {
+		flags |= VFIO_PCI_RECOVERY_FAILED;
+		flags &= ~VFIO_PCI_RECOVERY_IN_PROGRESS;
+		result = PCI_ERS_RESULT_NONE;
+	} else {
+		flags |= VFIO_PCI_RECOVERY_IN_PROGRESS;
+	}
+	WRITE_ONCE(vdev->pci_recovery_flags, flags);
+
+out_memory:
+	up_write(&vdev->memory_lock);
+out_unlock:
+	mutex_unlock(&vdev->access_lock);
+
+out:
 	rcu_read_lock();
 	eventfd = rcu_dereference(vdev->err_trigger);
 	if (eventfd)
 		eventfd_signal(eventfd->ctx);
 	rcu_read_unlock();
+	if (notify_recovery)
+		vfio_pci_signal_recovery_event(vdev);
 
-	return PCI_ERS_RESULT_CAN_RECOVER;
+	return result;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
 
@@ -2926,6 +3076,20 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 			break;
 		}
 
+		/*
+		 * Recovery releases memory_lock between callbacks. Check the
+		 * access block after taking the lock as well. Allow failed
+		 * devices so they do not prevent resetting healthy siblings.
+		 */
+		if (vdev->pci_recovery_supported &&
+		    READ_ONCE(vdev->access_blocked) &&
+		    !(READ_ONCE(vdev->pci_recovery_flags) &
+		      VFIO_PCI_RECOVERY_FAILED)) {
+			up_write(&vdev->memory_lock);
+			ret = -EBUSY;
+			break;
+		}
+
 		vfio_pci_dma_buf_move(vdev, true);
 		vfio_pci_zap_bars(vdev);
 	}
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c1a0250af680..69c41c3146f8 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -350,6 +350,11 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 
 	lockdep_assert_held_write(&vdev->memory_lock);
 
+	/* Reset and power-state cleanup must not undo recovery revocation. */
+	if (!revoked && vdev->pci_recovery_supported &&
+	    READ_ONCE(vdev->access_blocked))
+		return;
+
 	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
 		if (!get_file_active(&priv->dmabuf->file))
 			continue;
-- 
2.43.0

