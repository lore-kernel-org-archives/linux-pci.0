Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493093;
	b=lnzXy6Iq3EBScMDRRcydegXOciYw710Dh0JXfQ48AX7nETb8wWl4qfLk2lXOctQlGWSq
	 1xgN5AETVWi0EInvvKe+hMTspaSLC/7BZetCWog74cFiz+jtjNmchPCT6eSSqKw21DVE9
	 1G2X82gCdDpZUyWETNly64US7RvarOGE3KeRIc501/GQvWZSDbOTAePaVLRxo/kDrVYAg
	 0XEQSmLceb5Pix0gc7w8RP164IhAI3CxtcpLqHvuOIQyt9yORUjCLrI+uJ13dzpUOxYue
	 mDpXTeyhatYdrRRjHeIyJEAGJFdST9RaxsHn5hjPbSUMq9FgQWpSSSbPdBWWcazT5Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493093;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9F5/NdUmFVNjglcxI4qc/UTCvuxMH3qJ2Ow/N6AUNuM=;
	b=vv4q5tg12Cc7lUXd5meXEv8jhCHJYkONuDdlEmZLvPtGuiSZbJhmy8uE2pMHNxyB3M3S
	 ofRHIvdqq1CuL8SIs59gxDtapZVe88XcyrUQTq28AfOTA2v/F0vWsPxCKfhuRzy8TecdJ
	 3ntjpjRLalex6HARHZLQ2MVN9zNWDFlE3vgIQSI6ObNXtee01DTUjpf8+QgkgqTXhgZ1o
	 XoOGUGOPz5Tk5jGL4V1EMc1gj+PWLT0jHQICDMxeD+8LCxzK1rVNJ/J7gA3a73MT0Rv52
	 QPJU2WWMsi754h17kFBxcNYKfcDQ/CH4dt1oqEDQSWorToVIapb94NVWQlCFXrHXe1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="uXPYkY/Y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.61
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBD3606A8BC;
	Thu, 12 Nov 2026 14:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DBD3606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uXPYkY/Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYJYOiz9Lcibr/e+wfZACoGT1g5dA7go6zYBeYqpO1xCWq6R+RjjZO5gVl4F4KqdNHUKC9+c88Y7j/SY0Z6gM6Qw1ormh7sxIZluCESq/XmUpq5hHbSUqEejcfVEcYHGlWQVFPxeKTcBjrheOzIUf8Noac6jWEe3UywA8QmwhO1l0MGIQ0ryWF9jhdgjsDonDTZuP6gVDS/S8q7p40UtFy4fW0BYyjRpVREZz35jqkxERDUWH1Ghxa5S3McGbTv6ZfvI+BSPmnCZRnDEkqJ9rFZVT6x0/cnvug3+oD1igL0kHpNYHBxwAZXYmvMIUq+FjULyPRH0CKEBmPWbLBz9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F5/NdUmFVNjglcxI4qc/UTCvuxMH3qJ2Ow/N6AUNuM=;
 b=MG8YLQEQ6eCxxF+uwXr++5utHkQn0jR5OAPrd+8EShEZUVAJpNzz/Ya/IZoPvFpR+UhpyHU86E+eWZSfJf9N2AYtL8Y+twmm4eGvobm7VMs/U+oBw187Pr+22JG4HOy4p5sH5D5zG2sLtySYoJPRosU1mYuoERXhev61pY7OFON3Z9N8Yex98RVCKT4+WTZyr4l0BEE+5vLXIoL0sMpvnNIiOw1dMak1uHoQqKNtIykaubXlhhpDQy8K3GqkRTRnwnvXFu5FeiiwlZcAc9j8tZZJHEYQ0mTsA0t18pV2+ktARN/ELLT7QXEXdzAicIcggb0AFQyc/FCphddPtYJGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F5/NdUmFVNjglcxI4qc/UTCvuxMH3qJ2Ow/N6AUNuM=;
 b=uXPYkY/YluJasfYYXIi9l5RzwyVzmCsqxnwhgeKqlVFx1m2hueDE0VDeTKeCb/wkrKncwM7A4VZ9VYHY3UbJxg0nbNeabjRW+Ce0LnLVepjorxiOfCpDLqsujFiVoo4vBG20OIvEQFaoPcE22irjTl2ItBNsIsCaq5HwtueOtetHa8SLfdlnjsqBy4OVvtPK4ULKzQLeQ4IErsNRQAglWlqp1EgR6IJ2Tbxijp60030znQAaKnDJCi59OzIuUsU6+OlP4e8PZWBcTE1A8DwFRlYfT3W+IbgoCA6tB9KSbCooB23s/jZGjtvrNU8knFbvZ/WM2Aw3+VelJK5DT5xluA==
Received: from PH8P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::22)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Thu, 12 Nov
 2026 14:18:04 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:510:346:cafe::3e) by PH8P221CA0044.outlook.office365.com
 (2603:10b6:510:346::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:18:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:17:39 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:17:36 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 00/20] vfio/pci: Handle PCI error recovery and report state to userspace
Date: Thu, 12 Nov 2026 14:16:12 +0000
Message-ID: <20261112141632.918954-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c58ec8-589e-4786-dd1c-08df40c7c440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|261009223027099003|261102123227099003|261028144727099003|261021123027099003|261026140227099003|261021121427099003|261102130727099003|261026121527099003|261022075727099003|261022105027099003|56012099006|6133799003|11063799006|10067099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	b89TpTtfPEU1aiZC/Rx+3TskPQ8gWbC7fCx0jvH1CzR5edy0vLc9QFQt+NauWj876mtBVtFJrLgJrS0lqypuhDtc/rNBubLyfBRW+1iLZGvCTbOuydrXB904cDpnoxlDryTFUcCELyCx9cUBziZto98J5Y1bDx5Og8viM3YWKA8FBnJc5hwJLwxEC4uYhQEhUP0Shff8PQaKgJJEj0oAl8pALuD2Eu4KlvbF6LrzdfUzA4ql6aVY63UzfutBibldY7fWJTvXZfrq1gnHFX8FZTgdLvdOodNIiHwadJDUwHx8XGnI3OrvTGrMqAvjyTOobq8R7Sm6YmS5RoL7RB8yvt49Kz9fXuEGemNOYNE1oMbevkTUwmQLnCJgO2dcjaRGSQ6z2kMY6iXfwSoq21yaCov7GweTxGyw9M8c4LeEOwLb5JDNANuLi5bc//RUelxSMNoi3Xv3x3YYX1JbhE25/YQS4mPXroPM/8ITc0yteIzrdwyIAf4RQf0TizSDO3rN2WfsG+WBWkqH/LMGFqoXEvAEsE/wcDdotpKEol5cqQHVAQezLkLvi4VpqZFnBS7AgKJvIV+p3AXwd3snlFt51IP5dxbnB9p1QUViHmi54sqsKATswi5GIND4RaliOrhBtuniE0ak82ZoHOI6fgpFphRdM7sYK4xtS9to61Qn+3fZIeiI2IMWsiNaXgeR6RhNI4zNF2/wHVnFSVGoaIpbpQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(261009223027099003)(261102123227099003)(261028144727099003)(261021123027099003)(261026140227099003)(261021121427099003)(261102130727099003)(261026121527099003)(261022075727099003)(261022105027099003)(56012099006)(6133799003)(11063799006)(10067099003)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ynIp8OJYi7AiHlPffU07v5lpmzCQOdZrvOmUK7M3hlNUI2sqh1wtBbiIWv0YinVUZGDPP2VMVeZhVAfakANC4yckDJ3wxhIsUCuA9YzlE9fT/uhbBTfldlRLxxt/9W2Tx1ttCWbN0OBXEO45Qt9dT9722g6S+QVRvz7HkLHOOUlIMvY26ewRTLxArND1dmM+UZjgkv5qjo/cR+DkQPH0Z2zI3s2/DhO/oGxqzitPPIw287IuLzNvS9BDx0rVkRbSHP2/BQE0Pc6+9mUPcMwhrekW9Xbs3hhJPXeXeawgICgnmR9u9UhKTuJTbIr+n4GmNWEewzExfnnrqvPROSEbyRdoKjwNiFADKxitDZgwkISETAZxX6X0YSplUGlKqmJkr+I9Kt4dx7eN3FFjhZlVin5IvniMr8aDd4FSYAynNy+slmqXppG2jJtJqyhmco2B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:04.4088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c58ec8-589e-4786-dd1c-08df40c7c440
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798

Hi,

Currently, vfio-pci signals the error eventfd from error_detected() and
returns PCI_ERS_RESULT_CAN_RECOVER, including for permanent failure. It
has no slot_reset() or resume() callback, so userspace is not notified
when host recovery completes or whether the device was reset.

This series adds opt-in host PCI error recovery for vfio-pci. It blocks
device access during recovery, restores device state after a host reset,
and reports recovery status to userspace. The kernel runs host recovery
and the VMM decides how to recover the guest.

Major Changes from v2:
v2: https://lore.kernel.org/kvm/20260929173305.204856-1-skolothumtho@nvidia.com/

 - Rework device access serialization around live and blocked access ops,
   using SRCU to drain ongoing accesses before recovery.
 - Address the D0 bus-lock cycle described in RFC v2. Add
   pci_try_set_power_state() for ordinary transitions and use the locked
   helper during recovery to avoid taking pci_bus_sem again.
 - Fix INTx restoration ordering, recovery status reporting and PF access
   during VF information queries.
 - Limit enablement to supported native PCIe recovery paths. Exclude
   functions with VPD redirected to function zero, and Intel Ethernet
   function zero devices with VPD.

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
Open also rejects attempts while a recorded host recovery is in progress,
even when userspace has not enabled recovery.

Locking and open questions
-------------------------

PCI core holds device_lock during recovery callbacks and pci_bus_sem
for reading during the supported recovery walk.

VFIO uses access_lock to serialize recovery and switch access ops.
Recovery blocks new accesses and waits for existing SRCU readers to
finish. Switching ops also takes irqlock to serialize with INTx
callbacks, which do not use SRCU. Power transitions and mapping
changes use memory_lock.

The D0 bus-lock cycle described in RFC v2 is addressed by the try-lock
helper for ordinary transitions and the locked helper in recovery. This
uses the locking provided by the supported native PCI bus walk. It does
not impose a new locking requirement on every PCI recovery dispatcher.

Pre-existing(Sashiko reported):
--------------
  - Open and close were not serialized with the whole host recovery
    transaction before this series. That remains the case. Recovery
    can start after the open check, and close can overlap the
    physical reset. Restoration of closed devices is also still
    missing.

LLM tools assisted with implementation. I also ran local Sashiko
reviews.

Testing
-------
Basic sanity tests performed on a GB200 with an NVIDIA GPU assigned.

Kernel branch:
 https://github.com/shamiali2008/linux/tree/vfio-aer-rfc-v3-ext

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


Shameer Kolothum (20):
  vfio/pci: Add SRCU-protected access ops
  PCI/PM: Add a power-state helper that tries the bus lock
  vfio/pci: Avoid waiting for the bus lock when preparing D0
  vfio/pci: Use access ops for config-space accesses
  vfio/pci: Buffer ROM reads before copying to userspace
  vfio/pci: Use access ops for BAR and ROM accesses
  vfio/pci: Use access ops when mapping BAR pages
  vfio/pci: Use access ops for hardware IRQ operations
  vfio/pci: Use access ops for function reset
  vfio/pci: Use access ops for runtime-PM requests
  vfio/pci: Use access ops for hardware information queries
  vfio/pci: Use access ops for DMA-BUF export and restoration
  vfio/pci: Track PCI recovery state
  vfio/pci: Add INTx recovery operations
  vfio/pci: Use access ops for SR-IOV configuration and shared reset
  vfio/pci: Restore device state from slot_reset()
  vfio/pci: Complete recovery in resume()
  vfio/pci: Block device access during host recovery
  vfio/pci: Add VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY
  vfio/pci: Enable recovery for supported native PCIe endpoints

 drivers/vfio/pci/vfio_pci_priv.h   |  58 ++
 include/linux/pci.h                |   3 +
 include/linux/vfio_pci_core.h      |  36 +-
 include/uapi/linux/vfio.h          |  55 ++
 drivers/pci/pci.c                  |  37 ++
 drivers/vfio/pci/vfio_pci.c        |  88 ++-
 drivers/vfio/pci/vfio_pci_config.c | 122 +++-
 drivers/vfio/pci/vfio_pci_core.c   | 955 +++++++++++++++++++++++++++--
 drivers/vfio/pci/vfio_pci_dmabuf.c | 113 ++--
 drivers/vfio/pci/vfio_pci_intrs.c  | 183 +++++-
 drivers/vfio/pci/vfio_pci_rdwr.c   | 297 ++++++---
 11 files changed, 1705 insertions(+), 242 deletions(-)

-- 
2.43.0

