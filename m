Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F8D37F8BC;
	Tue,  1 Sep 2026 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255227; cv=fail; b=jc8RUSQJslziEcJtF5eT7XV568M5w0eUymdzhHjlQ+3byQE4txeT7MGzh31H7MT8zLeCTsRvKRnDT44Fh8FQ8/Bhn2sSxChd8pn48p4j76B4zYSNWXRez8b8JwH8aKd/tdSR+DIO7JcSLFU1nbgP8CEQZaiFaGGi7rLMvskVIXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255227; c=relaxed/simple;
	bh=yE33GJ8HeMLWgED7+w0iJ/QBj4yS7l1cR26wRw/CIUs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=upYzI3YGhcLwIlTabEvrp9NWJrz22sym1R9+nxgi6RawLuxftJjL+DrXYtrJNoC+Cs6p7pYvp7oxxFZTknsrwn2bTgOAs4iHRt+eEB6rvFKrUiUqle9xh4bj9QEkORWHLvC9HgCilax2QV1g21/e0KRbesQ5ByE0vHbVGFTgHt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BimW9Gvx; arc=fail smtp.client-ip=40.107.209.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BimW9Gvx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXOrmoE96aDMn00Wp7zejwERb3edohQPvwBx7pGCCDyteiOzV/GsI4HHsJBfuZMpYtj258PhjE03r9gKWBZGTEKKGuDJxIkidRC9d+BDsVgk3r+WMw8XH6LWMps/TRePFDIYN1pke46Md6BbBwDI/LLP5KeYOqbfDl2M0WZa0uD21nhIQHIHECPyQh4lrCnFJ9YY34DZ7Sa9py2bs942bX7uz9/7o4OIKORTlgEqqDoT/kCnyS0Qh3vuSBIqsBV5syJYeZzOWIQlxU3q+WJJKXi+pCp9EDN+uj0QDW12jh7u2iE2d9jvn1a4I8NjRMCR/wlbnK76WnIgWbD4qS8JvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL6CXT2EWXA2XBHO0CEtlRgBdmlgAgFfCgQ0Ly7/cG0=;
 b=rfn+vp4tjeDvMS0ycKw3qrXOvL1CgIoWTSzvgPk71c9e5YiADp5glqrK5+ZP7YiF+9FDkaOjhCcBbUM3v/aesSd5CeEWFs2livyy8O5FeaIrppbnoqjCjZGsUf/9d7OHz6TeapvxzYCpdlRu3cl/6v70UnIeZP1PVQEnNX5ycdciFzdypSzTZW4Q0sIq8LGhZubVWHHV6u0/OZhA3bPSSV5OzmuL79UMS2WPV5fgFCuHH1BavJ/SfltlLvCyzkDXuhUVXWy0xY8p3jaVrsmky4JaFkn1HGYOqOEVb/FE5SeaHEHThUEizEad+I5uHNw0OhjpWjpVr82ED1pAIHuzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL6CXT2EWXA2XBHO0CEtlRgBdmlgAgFfCgQ0Ly7/cG0=;
 b=BimW9GvxsZlVtbO3bqUNN7YQH5PS2jLI/QBXu0J76ZVKeKhDCeze6pgj40TD8BqpsPJUijz8lfQm4FAXmn0n5CQGAfWOqqIX6ouJSIoCgCdIK/mhqI7yMvpFqbbO1LE+QM9iT1W9oAs1kEklgq5L73rwX/ckv/3gPaeUyWefhVQqDWKmcyR1byfzqUmgnt3115kkOsWlQoFhX5cEIjL/F3AalxVIK1GKH89mPCZ7+l72zhDua8qpy7fUu6voaLx73smP2HgVeOyghAY8pqpkZBGuNNE5pMM/VBa7ZcuqygtygTasKOQlI7q8R0TFB/wY6QxvGthT5EusY7RyJZiV8Q==
Received: from BN9PR03CA0277.namprd03.prod.outlook.com (2603:10b6:408:f5::12)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:33:30 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::a3) by BN9PR03CA0277.outlook.office365.com
 (2603:10b6:408:f5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:33:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:11 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:08 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 00/19] vfio/pci: Handle PCI error recovery and report state to userspace
Date: Tue, 1 Sep 2026 10:31:58 +0100
Message-ID: <20260901093217.8539-1-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 95fa5723-95c9-4b88-a50a-08df080c1584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|13003099007|6133799003|56012099006|10067099003|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	db6I6ba7tXbxsN6yyxW/YMCHl6frmjfj6sVX8Zv84FYp25T0cR2lOA9heTLALkzN5nBlmPie4LN6KDmRh3yD1GgJcmn3cnNQ5ADtOaz/9VTbU1m5JBCxQ9nwBPqxz8LDo4z7GQFqaQzfgtVEdDg1Q2wAz8+vyUJ47tFgtogqbiLiPQjqhPc61oKeuCLxOiBcoRxCRGOjGd8wUz8DGTFyIfXPZed8mWHIHRkdDOfaAWeiypZGRgMqNdjx0//5h6HEDV4C3H11ZnKKuj37kKl7+TEIfdc52AJEq0ZM0lzM3cDzwf6dFxjDGFUzH63ppMwa6sHzWU7bIB7EKrDhV+8kX2ZUhdw9bYWiQB6QJAkAHa8LNS8j8sGgTfXkBKhBVcRllwkcc4JDF7vk22QaSMIIFIvKsGzy3oszNTSxb9h2xxKJzLdRC/fu/xQ8yfZgF+WkY4WU3Cu2BuecHEIagb3ncwkbrjGiTSwjpughy2HxXa16T4KCoCRZAcY7oq7BuSiwn8jQNMDiQ/kZr1CC1XkfWro45SjScBiiu6BYRbNIsUt2UFItbHLmvYyHeCXVeWCI8ts5mAPMR2QRmKIaDfJWNJHeKZ70oW/o8TUed052/zR4dBzwJDYpb3J3GSxB5KOQ6wW2IOJYvv7TtogVOD1WGJAJMGU+pq7DsvlY3L8VLRdtChRsn7rgrdLqZ0TttdTcx8cC/sJ2917dTDH3gQYk4w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(13003099007)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v32BWMir26Bn0uPDD6Hwj22NZ8ilsU6qeqOfqbfjn42V87bpvbEI5UkhzAJ1Q5fOmjalCRAcA2zgWiED4K7G/M23PclHtGhLknPOCGpgEFd6X2na/XC52QolHBFnoLTwZLrNP8QJftgrH0A48fTItAbbj+IzwFo3eZknNMCxB3O/L8pkC1MVufPIfWO1E4r/sn+lRnvOftI/GuY1YIhbn479ISnxNiB/t3LHl35ewImvXqsySu4UbGXQhAkWLF9CWp/+7zyx655NbJ4IWhTrtdelMpg8uOFXzgB1O0kHYwpVO+EHxEsNL1VO28iPT8XEHtJNr0BtqmArhLVQSaKZEDXDH8XRvYO5KKCelehd/nsqS+oWZWf6O+JE/j/KSnPaMUGQY6r5vkyRvtUDG/C8yBTz8YbwvMr+A/NYlpx+5eScrNgmQ0H+mwp1ANsjBfp0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:33:30.1703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fa5723-95c9-4b88-a50a-08df080c1584
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259

Hi,

Currently, vfio-pci takes almost no part in PCI error recovery. It
implements error_detected() and neither of the other two callbacks. That
one callback ignores the pci_channel_state_t it is given, signals the
error eventfd, and returns PCI_ERS_RESULT_CAN_RECOVER for every error, a
permanent failure included. Nothing implements slot_reset() or resume(),
so vfio-pci never learns that the host reset the device, or that
recovery finished.

Userspace gets one eventfd signal with nothing attached to it. It cannot
tell a non-fatal error the host recovered from apart from a permanent
failure, and it is never told when recovery is over. With nothing to go
on, QEMU assumes the worst and calls vm_stop(RUN_STATE_INTERNAL_ERROR),
which the VM cannot come back from.

Any device assigned through vfio-pci can hit this. A non-fatal
uncorrectable error is reported, the host AER path recovers the device
fine, and the VM is killed anyway.

This series lets userspace observe host recovery state, and keeps it off
the device while recovery is running. With that state visible, userspace
can decide what to do with the guest rather than assuming the worst.

The approach here comes from an earlier discussion with Alex.

https://lore.kernel.org/qemu-devel/20260707161234.23ed28db@nvidia.com/
https://lore.kernel.org/all/20260818083754.7ccf76d9@shazbot.org/

Design
------

The VMM watches recovery. It does not take part in it. The kernel runs
the recovery sequence and tells userspace what happened and when it is
done.

vfio-pci already has error_detected(). This series extends it and adds
the other two callbacks:

  - error_detected() now records the channel state, blocks new device
    access, revokes BAR mappings and exported DMA-BUFs, and quiesces
    INTx. It still signals err_trigger as it does today. It votes on
    severity rather than always claiming it can recover: CAN_RECOVER for
    a non-fatal error, NEED_RESET for a frozen channel, DISCONNECT for a
    permanent failure, and NONE if our own quiesce failed, which leaves
    the rest of the domain alone.
  - slot_reset() is new. It restores config state after the host has
    reset the device. Nothing does that today, which is why a device
    comes back from an AER reset with its config lost.
  - resume() is new. It restores PCI_COMMAND, unblocks access and wakes
    waiters.
  - A new device feature reports the state and carries an eventfd.

A non-fatal error gets the same quiesce as a frozen one. The host has not
finished deciding what the error was, and can still escalate to a reset,
so the device is not the user's again until resume() says so.

The support is opt-in. Until userspace installs the recovery eventfd,
generic vfio-pci behaves as it does today. error_detected() takes its
existing path and signals the same eventfd. VFIO variant driver support
is not added for now.

The uAPI is VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY. It carries the
eventfd and reports a status word plus a sequence number, so userspace
can tell coalesced notifications apart. IN_PROGRESS is set while a
recovery is running. CHANNEL_FROZEN says the link went down.
DEVICE_RESET says the host reset the device. FAILED says the device
cannot be used again until close and reopen. ENABLED says userspace has
opted in.

A non-fatal recovery can complete before userspace reacts to the eventfd,
so IN_PROGRESS may already be clear by the time the feature is read. Work
from the sequence number and the status bits rather than expecting to
catch the event while it runs.

Patches
-------

  1-3    the groundwork: the recovery state fields, the open and close
         lifecycle so a callback never sees a half built or half torn
         down device, and the access guards the rest of the series uses
  4-13   close the access paths one at a time: function reset, config
         space, ioeventfd, BAR faults, BAR and ROM, interrupts, hot
         reset, runtime PM, info queries, DMA-BUF
  14-18  the error handler callbacks: slot reset, the INTx helpers and
         the quiesce that uses them, then resume and error_detected
  19     the uAPI a user opts in through

Locking
-------

Blocking access is the hard part of this series, and it comes down to
one rule.

  recovery_lock can be held while publishing state, and while draining
  operations that are already under way. It cannot be held across a reset,
  or across anything else that reaches pci_bus_sem.

The reason is the order AER arrives in. It enters the driver already
holding device_lock, and pci_bus_sem too when the device sits under a
bridge with a subordinate bus, and only then takes recovery_lock. A
secondary bus reset reaches pci_bus_sem. So a vfio path which holds
recovery_lock across a reset ends up taking those two the other way
round.

Seven places needed reshaping for this rule: device close, slot_reset(),
open, VFIO_DEVICE_RESET, the guest triggered config space FLR,
VFIO_DEVICE_SET_IRQS, and a guest write putting the device back in D0,
which reaches pci_bus_sem through pcie_aspm_pm_state_change().

Most access takes recovery_lock for reading and checks whether a recovery
or a reset is blocking the device. A few places cannot take the lock and
read that state directly instead. All of them fail safe. A stale read
costs an extra refusal or retry, never an unguarded access.

Interrupt teardown is the one deliberate exception. It flushes the global
virqfd workqueue with recovery_lock held, which can make the hold last as
long as a reset on another vfio device. It costs latency, not
correctness.

I am not sure this is the best way to handle it, and would welcome
suggestions.

Testing
-------

Basic sanity tests performed on a GB200 with an NVIDIA GPU assigned.

Kernel branch:
https://github.com/shamiali2008/linux/commits/vfio-aer-rfc-v1

QEMU test branch is here(This is just to test the kernel sereis):
https://github.com/shamiali2008/qemu-master/tree/master-vfio-aer-rfc-test

Software AER injection was performed using a modified pcieaer_inject
module.

Non-fatal path (pci_channel_io_normal):

./aer-inject nonfatal.conf

qemu-system-aarch64: warning: vfio 0018:06:00.0: AER error signaled; host recovery in progress
qemu-system-aarch64: warning: vfio 0018:06:00.0: AER recovery completed successfully (seq=1)

Fatal path (pci_channel_io_frozen):

./aer-inject fatal.conf

qemu-system-aarch64: warning: vfio 0018:06:00.0: AER error signaled; host recovery in progress
qemu-system-aarch64: warning: vfio 0018:06:00.0: AER recovery started (seq=2, channel frozen), device access blocked
qemu-system-aarch64: warning: vfio 0018:06:00.0: AER recovery completed with device reset (seq=2).

Please take a look and let me know your feedback.

Thanks,
Shameer

Shameer Kolothum (19):
  vfio/pci: Add PCI error recovery support state
  vfio/pci: Serialize generic device lifetime with recovery
  vfio/pci: Add PCI recovery access guards
  vfio/pci: Serialize function reset with recovery
  vfio/pci: Serialize config access with recovery
  vfio/pci: Serialize ioeventfd writes with recovery
  vfio/pci: Retry BAR faults after temporary recovery
  vfio/pci: Serialize BAR and ROM access with recovery
  vfio/pci: Serialize interrupt operations with recovery
  vfio/pci: Serialize hot reset with recovery
  vfio/pci: Serialize runtime PM with recovery
  vfio/pci: Serialize physical device information queries with recovery
  vfio/pci: Serialize DMA-BUF export with recovery
  vfio/pci: Add generic PCI error slot reset handling
  vfio/pci: Add INTx helpers for PCI recovery
  vfio/pci: Quiesce INTx during PCI recovery
  vfio/pci: Add generic PCI error resume handling
  vfio/pci: Coordinate generic device access with host recovery
  vfio/pci: Expose and enable host PCI error recovery

 drivers/vfio/pci/vfio_pci_priv.h   |  10 +
 include/linux/vfio_pci_core.h      |  60 ++
 include/uapi/linux/vfio.h          |  69 +++
 drivers/vfio/pci/vfio_pci.c        |   1 +
 drivers/vfio/pci/vfio_pci_config.c | 147 +++--
 drivers/vfio/pci/vfio_pci_core.c   | 883 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_dmabuf.c |  26 +-
 drivers/vfio/pci/vfio_pci_intrs.c  | 159 ++++++
 drivers/vfio/pci/vfio_pci_rdwr.c   | 142 +++--
 9 files changed, 1402 insertions(+), 95 deletions(-)

-- 
2.43.0

