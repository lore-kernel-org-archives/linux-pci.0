Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760853DE43D;
	Tue, 29 Sep 2026 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703238; cv=fail; b=hPdRUQaz5CzdmaA965VT2WqIyZ8UDs/zbU957tiNNr3/dSYGDKlv0QOk5QSwdWv4FiKzY+2mJyi7I559lKJGiuYawFtJEK6ec8/jPDkMlwaEn7RImh4vlZB3xhSnsyZPlBlTDZwx4SrJAq9B2f5hrfizI+4cE/lrz8D1qJa2aw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703238; c=relaxed/simple;
	bh=QG5e9Gusx8Kklemi4OwAHNFZxLqEdv29TZb9DfszuMU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=svnRTqFvv21BQwvuGxypS4A1KWdF3/1HxRqyumszmhnmnIVwyAQsK7dmJj40P9zc/x1kmU9lV/BsGCYjRXTbjrjDd+GIgar6vO/9MwD4EyJq+UTQLn7ZQC04sCyT8lSbL13QtAwGYCL5VrOeIhQkgJSNnQqbxMhPowqVjdwY4nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mq34r/Sh; arc=fail smtp.client-ip=40.93.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mq34r/Sh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/7k8lYHN5gZKpB93QWOLP2tnUXLlfcNzTIltwJf0fmXYuwQV/A3XgTfsabplmCWoOuKLEPWIDNyzHI28vhv83YPETHwhdSmQl2GlXUtuKEGKaqwXrmLs7c7XnGMDtsnxGY9GeadNMvTgHjsz/0c3mmy6zKcr0IrP7VYoBrsYp6koWP/ipIi+f/IRfs7vpyO8PQmE68oGYsEMrSJpAYsi9v8juVVDibNSzIWiSVvoRuRNuq9RZLmq2JFy9f2QNNkSCIoXu0az5OnTDBwO9ffe6+NnRsGIktsqaBOKhX6A+g929EMoHkxTcA+Y+JaInKisRC9BMWI/w83XzrJlrUlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRl58GWjZOcUiiLORDDmtZCiS+aO9JxKIom7e/HFo1o=;
 b=H4a7iH2qX8Sg+pqQLGDDHuFGq8p1ymKdculHzHl+ylEmnWoJwcSBUmMPuo0afzsHgQv+oXBTndV9I3NMZ5HFsStfxtbM8kSKdZOP0vgI57NZTh7xzxOVO4L313T6ocyliTJYclJ1n1Y6STxrs38U2sYgfyM+CyjYxS9L+Omyq4Wl/bVUv7tcCfMACB0URaExPw1rgz0ZkUcD6DdpFvc3PlW1V0jSlB+pIL5THquGCjHpLrQWholYHqJe7KITReDlLOjt/Esdo2N9cgvTiQMoztzfcY5UQlJx1idJNPhKNBtedqwRieSZQ5qJbx1P+hY21jX2MDY4k0LXq9WHLvz46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRl58GWjZOcUiiLORDDmtZCiS+aO9JxKIom7e/HFo1o=;
 b=mq34r/Shv3YG45737wYg3zOSQFhKzObhQX+0kh9x40eymXw2NR/EH9Gm4ua0DXCYKzxpwseq1Waag+c+ezpmcdiwQXZdpdCOIStCs8XxUqm7D6/BwSyqlFSoACjN1F+JmVSLhCF+bMVBjMYLA2uQBvbAiJAnpDhLXd/Kwx59quvvoysJB5SnDlxwkRxWhVWDwmjRSMYUeRg2SFgFsGn3RqQMMdyCOMNZjD4CPZjU85qacHBxEcguY+Iz4RAr6eVqSk6/Zap1ATYp/+C385TzWJJLmB9dVaoHWM5lbSVSlFqVTLBM1EmC+h+sfiYiv+7riVzyrl4y8aQJltIxYx7NLA==
Received: from PH8P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::10)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 17:33:49 +0000
Received: from BY1PEPF000264B5.namprd02.prod.outlook.com
 (2603:10b6:510:2db:cafe::63) by PH8P223CA0007.outlook.office365.com
 (2603:10b6:510:2db::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Tue,
 29 Sep 2026 17:33:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B5.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:33:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:22 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:19 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 00/16] vfio/pci: Handle PCI error recovery and report state to userspace
Date: Tue, 29 Sep 2026 18:32:49 +0100
Message-ID: <20260929173305.204856-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B5:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4696f1-9457-4400-2dd6-08df1e4fd293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	2h1UjKfLbAQzdRbVMnERsha8YbrgZUJwwrdHFHkOUt57d5fBpD956Af2Im1zC3g6LfZYtzUtHMT0sdsBoweCCvIfFvrKnyc9kXmCaT7Wx/KowchK/ywRk1cBdL6Dbmbw/7ynji4ulHDfHSVt1E7NiRFHzUo3Gw0/CGTNZ+6sasuuYG2mccGEWS6RDs0JE4owUdCROAgscDgnD6uaIizB3XSJoTGrzkunrEEMqwGgiMyXT8jDXyq9LyEiQ1a29SR83dIdX0ispCm9slSr5rET3hG42mAubjCgO001r4laBbnZN20M6AXFNxdC289YuDehj487YYIVfuGUUNLbBGFHwSCIXXx4BD/lfupYmQHUQ4vP+1n5IrGwVC8cs6l1+Jw5yVQX1kCiRKp8B39YSo/2GMeMTjbXgczkrCWzJkudziIRFYoBmASiKAOLbYg0WXsLXHUAcFiUW1Njg/XxzXB1dAIwY4AS/eqRyGY1mmKd5y47Z8R6/WnSVFF4eRN54lr4gJhE6WHHXb+xLkTwHbLqRpnQvuMW4jbh2s/IWdjB8XL2cC7NBzQawfGm8bZ3jmlnC02ai9BeoyFB4/ScOA6FmCFp1DWA0wKWMoBtTRDKE/vjUFs2p9gnOlvaOHC9sv0eCia1Gp8qsxJm8hQlFqA+V5xpM33tK5gUCXaxtiJAMfzftTIGHKoEEaXgSoYh7R3qde0z+t4U26gKh0Izp6u6ag==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K94WZFaMvc7xuIobOtXBTRlO6Sa25pnUrF9h3TMo9bAv4lnn17tqtScknwRGzXDVOoxBDdNDuU9uXHcfbttlmHkikPKTr9URQ0ef842ttGI1BSmXHrtspX2gRF4shnpwt9FtyXAJ+Zys4di4VmEFSG7XqH/U/KkSF4tnP5Xr7yGGNWiIdlicDuEht/zGqqN/J8xTMKfplkVpAgxkHRcs9XoGxhsMe2Z7MmVPttsoCrCPdDgVxNwWHNjdk0hFM01JBnQ7tIteyd8yLrOzjNAaK+vndpyOUOlIaiLVSNf4OgKYvRFF7cGCgbhi08odOMRzqPmMIW4/DK2LjJ0B1AqCSkfylD0879mLZ6Q+ywtg9djRhPtg4eytWJlZR1sXeECGoftzDM5Aqx7803ASimob5CdcPvrSD+Y1vgug3O6GNQuFuV759oWHA7c6hCoEzE5B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:33:49.2678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4696f1-9457-4400-2dd6-08df1e4fd293
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

Hi,

Currently, vfio-pci signals the error eventfd from error_detected() and
returns PCI_ERS_RESULT_CAN_RECOVER, including for permanent failure. It
has no slot_reset() or resume() callback, so userspace is not notified
when host recovery completes or whether the device was reset.

This series adds opt-in host PCI error recovery for vfio-pci. It blocks
device access during recovery, restores device state after a host reset,
and reports recovery status to userspace. The kernel runs host recovery
and the VMM decides how to recover the guest.

Changes from v1
---------------
 v1: https://lore.kernel.org/kvm/20260901093217.8539-1-skolothumtho@nvidia.com/
  
 - Thanks to Satya and Alex for reviews/feedback.
 - Use SRCU to drain ongoing device accesses and reject new accesses during
   recovery. A mutex protects recovery-state updates. 
 - Return SIGBUS for blocked BAR faults instead of waiting in the fault
   handler. VMM handling still needs target validation.
 - Reject userspace SR-IOV changes while access is blocked.
 - Exclude s390 and all CXL memory devices for now as s390 and CXL RCH
   recovery can omit completion callbacks.
  
Design
------
Userspace opts in through VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY. It
registers an eventfd and reads status flags and a sequence number. The
existing error eventfd is still signaled.

The callbacks handle the host recovery sequence:

 - error_detected() blocks new accesses and drains admitted ones,
   quiesces INTx, and revokes BAR mappings and exported DMA-BUFs. On a
   normal channel it also clears bus mastering. It votes CAN_RECOVER
   for a normal channel, NEED_RESET for a frozen channel, and DISCONNECT
   for permanent failure. Failure to save PCI_COMMAND or disable bus
   mastering leaves access blocked and returns NONE so other devices
   can continue recovery.
 - slot_reset() restores the configuration saved at open after a host
   reset, then tears down interrupt configuration. Userspace must set
   up interrupts again.
 - resume() completes restoration, unblocks access and completes INTx
   handling. A restoration failure keeps the device blocked.

Non-fatal errors also block device access because host recovery may
require a reset. Userspace reads the recovery status to determine
whether the device was reset or recovery failed.
  
Without opt-in, the existing error notification behavior is retained.
The open check also rejects a previously recorded host transaction when
recovery is disabled, so closing the device does not discard that state.

Locking and open questions
--------------------------
Several locks are involved in recovery. PCI core holds device_lock
while calling the driver, preventing concurrent driver binding or
unbinding. During the bus walk, it also holds pci_bus_sem for reading
to keep the device list stable. Adding or removing PCI devices requires
the write lock. This semaphore is shared across all PCI buses.
 
VFIO recovery blocks new accesses, waits for existing SRCU readers to
finish, and takes memory_lock. Power transitions also take memory_lock,
but entering D0 can then acquire pci_bus_sem to update PCIe link power
management (ASPM).

Local Sashiko/Claude review reports a lock-order conflict as below:

 1. A guest D0 request holds memory_lock.
 2. PCI core holds pci_bus_sem for reading while VFIO's recovery
    callback waits for memory_lock.
 3. Removal of an unrelated PCI device waits for the bus write lock.
 4. D0's ASPM update requests the bus read lock and waits behind that
    writer.

Each task waits for another, so none can proceed.

One possible solution could be(not implemented):

 - PCI core guarantees that pci_bus_sem is held for reading before
   invoking supported recovery callbacks. VFIO uses
   pci_set_power_state_locked() in those callbacks, avoiding another
   acquisition of the bus lock.
 - A new pci_try_set_power_state() helper tries to acquire pci_bus_sem
   and returns -EAGAIN on contention. Ordinary VFIO D0 paths use this
   helper and handle failure instead of waiting while holding VFIO locks
	  
Not sure there are better ways to handle this or not. Feedbacks appreciated
on this.

Another issue flagged was(I think this is a pre-existing one):
 - Open/close coordination with the whole host recovery transaction
   was already missing. Recovery can start after the open check, and
   close can overlap the physical reset. Restoration of closed devices
   is also not implemented.

Testing
-------
Basic sanity tests performed on a GB200 with an NVIDIA GPU assigned.

Kernel branch:
 https://github.com/shamiali2008/linux/tree/vfio-aer-rfc-v2-ext

QEMU test branch is here(This registers the recovery eventfd and uses
pcie_aer_inject_error() to report the error to Guest)
 https://github.com/shamiali2008/qemu-master/commits/private-master-vfio-aer-test-v2/

Software AER injection was performed using a modified pcieaer_inject
module.

./aer-inject nonfatal.conf

qemu-system-aarch64: info: vfio 0018:06:00.0: host PCI error recovery completed (seq 1)

Guest kernel:

[   59.036988] pcieport 0000:01:00.0: AER: Uncorrectable (Non-Fatal) error message received from 0000:02:00.0
[   59.038326] nvidia 0000:02:00.0: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Completer ID)
[   59.038440] nvidia 0000:02:00.0:   device [10de:2941] error status/mask=00008000/02400000
[   59.038533] nvidia 0000:02:00.0:    [15] CmpltAbrt              (First)
[   59.038705] nvidia 0000:02:00.0: AER:   TLP Header: 0x00000000 0x00000000 0x00000000 0x00000000
...

./aer-inject fatal.conf
qemu-system-aarch64: info: vfio 0018:06:00.0: host PCI error recovery started (seq 2, channel frozen)
qemu-system-aarch64: info: vfio 0018:06:00.0: host PCI error recovery completed (seq 2, device was reset)

Guest kernel:

[  150.909306] pcieport 0000:01:00.0: AER: Uncorrectable (Fatal) error message received from 0000:02:00.0
[  150.909566] nvidia 0000:02:00.0: AER: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
[  150.909835] nvidia 0000:02:00.0: AER: can't recover (no error_detected callback)
[  150.910062] pcieport 0000:01:00.0: unlocked secondary bus reset via: pciehp_reset_slot+0x54/0x98
[  156.603467] pcieport 0000:01:00.0: AER: Root Port link has been reset (0)
...

Please take a look and let me know your feedback.

Thanks,
Shameer

Shameer Kolothum (16):
  vfio/pci: Add a device access gate
  vfio/pci: Gate config space access
  vfio/pci: Buffer ROM reads before copying to userspace
  vfio/pci: Gate BAR and ROM access
  vfio/pci: Fail BAR faults while access is blocked
  vfio/pci: Gate interrupt configuration
  vfio/pci: Gate function reset and runtime power management
  vfio/pci: Gate device information queries and DMA-BUF export
  vfio/pci: Add PCI error recovery state
  vfio/pci: Quiesce INTx while access is blocked
  vfio/pci: Add INTx recovery start and finish helpers
  vfio/pci: Restore device state from slot_reset()
  vfio/pci: Complete recovery in resume()
  vfio/pci: Block device access during host recovery
  vfio/pci: Add VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY
  vfio/pci: Enable host PCI error recovery for vfio-pci

 drivers/vfio/pci/vfio_pci_priv.h   |  10 +
 include/linux/vfio_pci_core.h      |  38 ++
 include/uapi/linux/vfio.h          |  44 ++
 drivers/vfio/pci/vfio_pci.c        |  12 +
 drivers/vfio/pci/vfio_pci_config.c | 104 ++++-
 drivers/vfio/pci/vfio_pci_core.c   | 636 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_dmabuf.c |  21 +-
 drivers/vfio/pci/vfio_pci_intrs.c  | 131 ++++++
 drivers/vfio/pci/vfio_pci_rdwr.c   | 169 ++++++--
 9 files changed, 1090 insertions(+), 75 deletions(-)

-- 
2.43.0

