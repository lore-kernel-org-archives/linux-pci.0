Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119813;
	b=lcMwn3aazLLRRXaG43yLBJUKxn3J016ghTFDYYCMlHc+Rl8YJWqjb9B9yRfNlOiLycAv
	 XcYj8nuPDV2HODlHbP32xDtyPEAqH48HIPQdBllwClGfKyQ7N2+bOz/FmqsIVUUknB57a
	 wx9nn2W2arPkFBNpqRejcGAvsvs9lnroMm3FUQ4KRSA/WvpKWIlZbKxZDTeE5aqrrDydE
	 5SskPcVqoUDRpZ0fNVuc0pZ2MAEJSEEwFdpy5HRCaeI+oIvaZLWgbLvSCM6CIfakCvPBr
	 5C/EWMierTL9JYARegeWtm9f3DlcB/nk0Xg70tPn1squmC1g2eGyAWxcaW5UqeepwLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119813;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
	bh=j1CHra7rmNJbXqqfNxq6MXep67Lhx8y6Gc4Cjprwyvk=;
	b=MhyrcAO9vJPuAwhlM7mBmSs91Ck7JW+8Bgngf6jr2Wof5s1M/O0sETGhkQd0WYqzRo0L
	 7zwwj5fyXO0RFF6CHmicwOGJhi6LX7F5cLbUF+XkgeTwXtBJt4x87IbeaXz644TPrIJ8Z
	 b3YSfWgdGyk9TzQ9Fy894dLGon1TI/P74LfLcIsVPJIVpoX3ruFZc669aV2DwgERX6z9n
	 BaO8iGqi0Vb8uYxnFHoOQs1hC1bliFZ9KafpDyDjSqCSC1wwm0/wFqUpbPU5Aowxt+4Oa
	 pfZxC7vf/13zKsui27kGIa+yvlDoZxiyxr/nVQ+N8iqimb1r2fkNAUzNmbR1mJAfv+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0N8d6pmo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.5
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7EC606A326;
	Thu, 19 Nov 2026 20:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC7EC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0N8d6pmo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcXmYCzhN73E/4hgsitlC09Jaaa/PXe+OV2u49uevdI27BUrJk94Oh7gJk2qwqwkKBYjNXjCIAxg8A+PCiuqVrVyrtdIkUFSxqelcucAUEObWWjHs9W8z5Qvf7HdBTzR1/lnRbgIBk5WM1T3FpVpPpjBM4yL6m430IQsWhXutMvZQylFTiALvDPLZVAc61VDn8Roj1LTDJlnprDaOq/kPiBCMzTXP4532YqQ6xLK8eaeHd6O9jVXXRM5oTgGBfjQ0D/JXYuPBi+2Ey23IYOd1ErM+EllNf9KGEyHa2UIooeVCmXoL+L+F2u4DZaUO02/9lq7/RFh6tfpWG9Y4qJ1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1CHra7rmNJbXqqfNxq6MXep67Lhx8y6Gc4Cjprwyvk=;
 b=pT6mX9+4u1glC0lsCtau3O/AEEvnxahMp7offq9EnnZ6OQlDqoFS+6xtvROd1eC4RmV/p4hkA5AsaWEkwxj+m2H/Q2kXwBUjZeHAPUQWlPEaARZqgyjOPwiHdPB8qbnahJV4zaXV/B296WWwbArlBz9opeoeuGQB1fEI4dGJRCxFjxs7/BPEvlBGGYIyWGAoPwpwIROfOp3C02z6OFGkQac+1wxgOc2iZssEwMSN48zutnGrCizDtdQxFMPqaXzlL2eH1hsNRxFHlMFKJnstm4NUjRBCl+l3yVfTpJY0HtKCswR6KBsaTiScc5f6EYwNT9LOccsGIaY9+Rw0SJKN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1CHra7rmNJbXqqfNxq6MXep67Lhx8y6Gc4Cjprwyvk=;
 b=0N8d6pmoWL9/1hleQq8H8H5VEkkBpSmMywTIw9t2LPMgsakD0JzHTkalbpGq6Hfe9VeIrDuX14ULWeY92SyRwYLy5AqUvTHSeO/QZUj7se8RXTaFRiC9YRkDjBXEL4XPA6i5Aab9CcBYGAweGt0rXEy25nlAGBRgV/0tAKabWmM=
Received: from BL1PR13CA0135.namprd13.prod.outlook.com (2603:10b6:208:2bb::20)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 20:23:28 +0000
Received: from IA0PEPF0000003E.namprd03.prod.outlook.com
 (2603:10b6:208:2bb:cafe::5b) by BL1PR13CA0135.outlook.office365.com
 (2603:10b6:208:2bb::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.7 via Frontend Transport; Thu, 19
 Nov 2026 20:23:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003E.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:23:28 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:23:26 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 00/44] dmaengine: sdxi: add userspace control and management support
Date: Thu, 19 Nov 2026 14:22:36 -0600
Message-ID: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003E:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: d43880ca-99d7-4f38-3ed8-08df467af8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|23010399003|10067099003|261022075727099003|261026121527099003|56012099006|261026140227099003|11063799006|261022105027099003|261009223027099003|261021123027099003|261021121427099003|261022113327099003|261102124527099003|261102123227099003|261028144727099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	WGpnDmrzrV0ahhynTqLXleAz3458aO19jPY40nTJg0wf0yhVNruKfdAeWZL88ReJgbVs8QCSn4EXqBko+K+7OmacuivWhti0UBbCiqb245yOTLrBKrOFatk06exEqUjg7dJImHS1uba5S0KPYUArTgrAfp18dph8rRMXrbdbyUkNxCv5K7HrE9QVdDcsv7wXU1s+vVgpfy6hARiA3AWqtnELtG78K/z322gp63nQwOIf6u29j4u71wM9MhVTl9FuEkIdEwi1X79cfYrqJOnArNqhkPGhVSOCow2PEu+2iFMhlCUY+sPpXF698z9v/q0hZUKLfST3BT4pBnkFs4z8W+/D+hjkVVM+Ns5EZeGsgybWsljBLDJG2AzwWZV7jye/QdltGdhFgKKYyXjyM5kq7WYx8l3L9mcVCKMylu1WohchnNUSm/Uvqqc1d0aCRDyRZajIfyvyWB8IKQ6CyemfKwhRvznjzeQDLIP/O4DM72tq3iWSwSDSpGrpxDrFHT83s5gm4i4Oqbdr7rLTVGVwO2e/f7xbwoYnA9zaMQ4yy/RML4hbo/e1R+CtdgfHJfqabd+PT6P5U4uZpbedUuqhOorxeJTqy5Zo2R6L6Vo7jZ/qlpWR7dtHIU4mV0E8WWW04uCL8o0tXiLeaSyhTlIDGuXClaVk4eU7pWZ2FZj6ahA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(261022075727099003)(261026121527099003)(56012099006)(261026140227099003)(11063799006)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022113327099003)(261102124527099003)(261102123227099003)(261028144727099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pJzxJPwVtUyXQ99GsqYAQvGcuEDxpVi5ujwuOz8VBXuBSeM6T63dxJROUgm6X7uyqKFkYoXIkp+aZqP7hAScXQwyhhIjAFYiCkYz59PbC5x9HeS30UV7Db0Lw8RtxLsIgX10sRu3Q8/xFs8yX+NnFBt+zEKttytVyf+LHBNWN8RgDNZvXw+w+K2ZMllLAngWxJ1Dleqqkf4GTzwlHHz77fibZX6M45icE4xBDI43lUtq3XOLmjYH3tdRcunRO2BBVUTe8HOFKyQfE+yd6Z8qqNxAwskKk+iDxVajRtEqNjgS0hong8wFykARLtO63AflLZKWngTaT98v6pe42vNPiLmNexWAwv2z3UBuUFRDND+g/xm1sA/mq4JG00J6ftrxtFLVbDiAULsWFIhe5BDdU+8elfistrITYiJC9aDJM95PTr9zgGg+NqOik81Beagi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:23:28.3458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d43880ca-99d7-4f38-3ed8-08df467af8cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894

This series extends the existing SDXI phase 1 "base" driver with versioned
userspace-facing interfaces for the native SDXI software stack: device
discovery and management, process-owned execution contexts, and a
constrained vendor-extension framework.

This series applies on top of Nathan Lynch's phase 1 "base" v4 patchset,
ending at commit b8b01d7ab1e5 ("dmaengine: sdxi: Add DMA engine provider").
This series is available at:

    https://github.com/AMDESE/linux-sdxi/tree/sdxi-phase2-upstream-v1

At a high level, this new series adds:

  - A versioned ioctl UAPI and character-device interface for discovery
    and management.
  - Userspace contexts with process-bound context fds, SVA-backed rings,
    per-context doorbell mappings, and eventfd interrupt delivery.
  - A typed vendor-extension path that accepts structured requests rather
    than raw descriptors, plus an AMD QoS implementation.
  - Test coverage (KUnit + kselftests) and MAINTAINERS updates.

Patch map:

  - Patches 1-9: hardware and admin groundwork (feature gating, hardware
    layouts, admin operations, context hierarchy, RKey setup, error logs).
  - Patches 10-13: userspace-context foundations (resource separation,
    process/SVA and context lifetimes, eventfd delivery, and fatal-error
    cleanup).
  - Patches 14-27: versioned ioctl UAPI + character device (discovery and
    management, context-fd operations, vendor plumbing, tracing,
    suspend/resume).
  - Patches 28-34: AMD QoS vendor feature (capabilities, configuration,
    assignment, telemetry), with KUnit coverage.
  - Patches 35-44: kselftests (context creation, dataplane basics, error
    paths, ioctls), plus MAINTAINERS updates.

The interface is structured to separate management from the dataplane. A
device fd represents one SDXI function and is used for discovery and
function-wide management. SDXI_CREATE_CXT binds the caller's mm through
IOMMU SVA, programs userspace-owned ring state, and returns a process-bound
context fd for context-scoped control and mapping only that context's
doorbell. Userspace submits native descriptors through the SVA-backed ring
and mapped doorbell; context interrupts are delivered through a bound
eventfd. The kernel owns and validates context and key tables and issues
administrative operations for lifecycle and management requests.

Function-wide mutation and RKey management require CAP_SYS_ADMIN. Context
ioctls and doorbell mappings are restricted to the creating thread group
and mm. AKeys written by non-admin callers are limited to the local
function and bound PASID. Vendor handlers authorize typed requests. AMD
QoS composes descriptors on the kernel-owned admin context and is PF-only
and CAP_SYS_ADMIN-gated.

Companion userspace projects are available at:

  - libsdxi: userspace library
    https://github.com/AMDESE/libsdxi/tree/sdxi-phase2-upstream-v1

  - sdxi-cli: command-line tool
    https://github.com/AMDESE/sdxi-cli/tree/sdxi-phase2-upstream-v1

libsdxi wraps the UAPI and provides device discovery, context lifecycle,
key management, event handling, and vendor helpers. Sample programs
provide quick tests:

  $ ./samples/memcopy --dev /dev/sdxi0
  $ ./samples/cxt_intr --dev sdxi1

sdxi-cli is an SDXI management tool built on libsdxi. Representative
device inspection commands are:

  $ sdxi devices
  $ sdxi show sdxi0 --verbose
  $ sdxi attrs sdxi0

SDXI supports vendor-specific extensions. This patchset adds AMD QoS
management through a separate vendor handler (sdxi-amd-qos when built as
a module). AMD QoS userspace management is provided in sdxi-cli under a
vendor namespace:

  $ sdxi amd qos cap sdxi0
  $ sdxi amd qos status sdxi0
  $ sdxi amd qos assign sdxi0 --pool 1 --cxt 1

This patchset has been tested on both bare metal and virtual machines with
a passed-through VF, with the SDXI core, PCI driver, and KUnit tests built
as modules.

SDXI (Smart Data Accelerator Interface) is a SNIA standard for a
memory-to-memory data mover and acceleration interface, developed by
industry contributors including Dell, AMD, VMware, etc. The SDXI
specifications and related material are available at:

  - SDXI v1.0a and v1.1 specifications: https://www.snia.org/sdxi

Thanks,
-Wei

Wei Huang (44):
  dmaengine: sdxi: cache hardware version for feature gating
  dmaengine: sdxi: define key and error MMIO registers
  dmaengine: sdxi: define SDXI hardware layouts
  dmaengine: sdxi: encode admin descriptors
  dmaengine: sdxi: support timeout-aware completion waits
  dmaengine: sdxi: support the full context table hierarchy
  dmaengine: sdxi: implement synchronous admin operations
  dmaengine: sdxi: add core RKey table management
  dmaengine: sdxi: handle hardware error logs
  dmaengine: sdxi: separate context and submission resources
  dmaengine: sdxi: support userspace context lifetimes
  dmaengine: sdxi: route context interrupts to eventfd
  dmaengine: sdxi: kill user contexts on fatal errors
  dmaengine: sdxi: define the ioctl UAPI surface
  dmaengine: sdxi: add internal ioctl definitions
  dmaengine: sdxi: register core character devices
  dmaengine: sdxi: implement fixed-size ioctl dispatch
  dmaengine: sdxi: implement userspace context file operations
  dmaengine: sdxi: validate and copy key ioctl payloads
  dmaengine: sdxi: implement RKey management ioctls
  dmaengine: sdxi: implement AKey management ioctls
  dmaengine: sdxi: expose operation-group discovery
  dmaengine: sdxi: implement typed vendor admin transport
  dmaengine: sdxi: expose character device attributes
  dmaengine: sdxi: add PF and VF device naming
  dmaengine: sdxi: add SDXI trace events
  dmaengine: sdxi: support suspend and resume
  dmaengine: sdxi: amd: define QoS request formats
  dmaengine: sdxi: amd: add QoS validation scaffolding
  dmaengine: sdxi: amd: build QoS admin descriptors
  dmaengine: sdxi: amd: prevalidate QoS operations
  dmaengine: sdxi: amd: execute QoS vendor operations
  dmaengine: sdxi: amd: register QoS vendor handler
  dmaengine: sdxi: amd: test QoS validation with KUnit
  selftests: sdxi: add build scaffold
  selftests: sdxi: add shared descriptor and context helpers
  selftests: sdxi: test context creation
  selftests: sdxi: test NOP descriptor submission
  selftests: sdxi: test copy submission and ring wrap
  selftests: sdxi: exercise dataplane error paths
  selftests: sdxi: test device ioctls
  selftests: sdxi: test vendor admin ioctls
  selftests: sdxi: test RKey ioctls
  MAINTAINERS: cover SDXI UAPI, vendor files, and selftests

 MAINTAINERS                                   |    3 +
 drivers/dma/sdxi/.kunitconfig                 |    1 +
 drivers/dma/sdxi/Kconfig                      |   25 +-
 drivers/dma/sdxi/Makefile                     |   13 +-
 drivers/dma/sdxi/admin.c                      |  290 ++++
 drivers/dma/sdxi/admin.h                      |   45 +
 drivers/dma/sdxi/amd/Makefile                 |    6 +
 drivers/dma/sdxi/amd/qos.c                    | 1135 ++++++++++++++
 drivers/dma/sdxi/amd/qos.h                    |   95 ++
 drivers/dma/sdxi/amd/qos_kunit.c              |  180 +++
 drivers/dma/sdxi/completion.c                 |   37 +-
 drivers/dma/sdxi/completion.h                 |    4 +
 drivers/dma/sdxi/context.c                    |  980 ++++++++++--
 drivers/dma/sdxi/context.h                    |   74 +-
 drivers/dma/sdxi/descriptor.c                 |   89 ++
 drivers/dma/sdxi/descriptor.h                 |   27 +
 drivers/dma/sdxi/descriptor_kunit.c           |  150 ++
 drivers/dma/sdxi/device.c                     |  423 +++++-
 drivers/dma/sdxi/dma.c                        |   22 +-
 drivers/dma/sdxi/error.c                      |  371 +++++
 drivers/dma/sdxi/error.h                      |   18 +
 drivers/dma/sdxi/hw.h                         |   80 +
 drivers/dma/sdxi/intr.c                       |  320 ++++
 drivers/dma/sdxi/intr.h                       |   21 +
 drivers/dma/sdxi/ioctl.c                      | 1331 +++++++++++++++++
 drivers/dma/sdxi/ioctl.h                      |   78 +
 drivers/dma/sdxi/keys.c                       |  577 +++++++
 drivers/dma/sdxi/keys.h                       |   29 +
 drivers/dma/sdxi/mmio.h                       |   27 +-
 drivers/dma/sdxi/pci.c                        |   91 +-
 drivers/dma/sdxi/process.c                    |  200 +++
 drivers/dma/sdxi/process.h                    |   43 +
 drivers/dma/sdxi/sdxi.h                       |   96 +-
 drivers/dma/sdxi/sysfs.c                      |   70 +
 drivers/dma/sdxi/sysfs.h                      |   13 +
 drivers/dma/sdxi/trace.c                      |    9 +
 drivers/dma/sdxi/trace.h                      |  137 ++
 drivers/dma/sdxi/vendor.c                     |  138 ++
 drivers/dma/sdxi/vendor.h                     |   42 +
 drivers/dma/sdxi/version.h                    |   32 +
 include/uapi/linux/sdxi.h                     |  569 +++++++
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/sdxi/.gitignore       |    7 +
 tools/testing/selftests/sdxi/Makefile         |   35 +
 tools/testing/selftests/sdxi/admin_cmd.c      |  104 ++
 tools/testing/selftests/sdxi/config           |    2 +
 tools/testing/selftests/sdxi/context.c        |  343 +++++
 tools/testing/selftests/sdxi/copy.c           |   40 +
 tools/testing/selftests/sdxi/device.c         |  245 +++
 tools/testing/selftests/sdxi/error.c          |   24 +
 tools/testing/selftests/sdxi/lib/context.c    |  195 +++
 tools/testing/selftests/sdxi/lib/descriptor.h |   55 +
 .../selftests/sdxi/lib/fixture-context.h      |  126 ++
 .../selftests/sdxi/lib/fixture-device.h       |   44 +
 tools/testing/selftests/sdxi/lib/lib.c        |  206 +++
 tools/testing/selftests/sdxi/lib/lib.h        |   61 +
 tools/testing/selftests/sdxi/nop.c            |   30 +
 tools/testing/selftests/sdxi/rkey.c           |  413 +++++
 58 files changed, 9603 insertions(+), 219 deletions(-)
 create mode 100644 drivers/dma/sdxi/admin.c
 create mode 100644 drivers/dma/sdxi/admin.h
 create mode 100644 drivers/dma/sdxi/amd/Makefile
 create mode 100644 drivers/dma/sdxi/amd/qos.c
 create mode 100644 drivers/dma/sdxi/amd/qos.h
 create mode 100644 drivers/dma/sdxi/amd/qos_kunit.c
 create mode 100644 drivers/dma/sdxi/error.c
 create mode 100644 drivers/dma/sdxi/error.h
 create mode 100644 drivers/dma/sdxi/intr.c
 create mode 100644 drivers/dma/sdxi/intr.h
 create mode 100644 drivers/dma/sdxi/ioctl.c
 create mode 100644 drivers/dma/sdxi/ioctl.h
 create mode 100644 drivers/dma/sdxi/keys.c
 create mode 100644 drivers/dma/sdxi/keys.h
 create mode 100644 drivers/dma/sdxi/process.c
 create mode 100644 drivers/dma/sdxi/process.h
 create mode 100644 drivers/dma/sdxi/sysfs.c
 create mode 100644 drivers/dma/sdxi/sysfs.h
 create mode 100644 drivers/dma/sdxi/trace.c
 create mode 100644 drivers/dma/sdxi/trace.h
 create mode 100644 drivers/dma/sdxi/vendor.c
 create mode 100644 drivers/dma/sdxi/vendor.h
 create mode 100644 drivers/dma/sdxi/version.h
 create mode 100644 include/uapi/linux/sdxi.h
 create mode 100644 tools/testing/selftests/sdxi/.gitignore
 create mode 100644 tools/testing/selftests/sdxi/Makefile
 create mode 100644 tools/testing/selftests/sdxi/admin_cmd.c
 create mode 100644 tools/testing/selftests/sdxi/config
 create mode 100644 tools/testing/selftests/sdxi/context.c
 create mode 100644 tools/testing/selftests/sdxi/copy.c
 create mode 100644 tools/testing/selftests/sdxi/device.c
 create mode 100644 tools/testing/selftests/sdxi/error.c
 create mode 100644 tools/testing/selftests/sdxi/lib/context.c
 create mode 100644 tools/testing/selftests/sdxi/lib/descriptor.h
 create mode 100644 tools/testing/selftests/sdxi/lib/fixture-context.h
 create mode 100644 tools/testing/selftests/sdxi/lib/fixture-device.h
 create mode 100644 tools/testing/selftests/sdxi/lib/lib.c
 create mode 100644 tools/testing/selftests/sdxi/lib/lib.h
 create mode 100644 tools/testing/selftests/sdxi/nop.c
 create mode 100644 tools/testing/selftests/sdxi/rkey.c

-- 
2.56.1
