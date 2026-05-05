Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437B53AEF5C;
	Tue,  5 May 2026 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002264; cv=fail; b=BxkshHD7vzsLlzeNTxcq7Kr343Gz8Uu9/xBYV0+Qgj2yhY67VbJS1SWPkBTFCHA2ye67tlTSTLxjUWiYd9cp4xFYqMi7IsU37nxIAjKEQH1YT41Yc66NFETl/r8OodTU9AcqtvNELH/YGQa5JVK6CkJJ3Qa/EGYkBvYJVtEJ9Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002264; c=relaxed/simple;
	bh=lRlV7tkrlLCTZwVQK645lpxpEkGpBz0uPRSyGio5aSQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RjOah60U1lQ0Fe+fm2oczkuzCv23apt5I1NMOXHJwbG870+zBJtXwb3U9/yDtxLXS8RWFAokDVrOHxs+adKMRVapEXdPzS0LzLLYzMmrdKRHdvdQRMzN1BBZ1ueJXXCiZJI4wASkLK4FuhCW9LBfERWGgUM8DNQDTQa/BGQhFdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pVQ5SR8U; arc=fail smtp.client-ip=52.101.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pVQ5SR8U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4JWHZq1l6kkKU8V2UifgecpVFYkchJsj5OSZ0CXu6uLg/Gps8qkSxIIiaVlUjOAJOow+CLd7kBLq+NlsFlpHkswMeppm1c+Y86oRnqjhvcSzK1fUKO/roMXywdR2aX96F/kSAb7TOqpIzajPDn2AYX0AQH6j1R9lHouI8As3rprjcTQrL9pcc3qdeGPlABQbBYRlgqyfK6J6EFgie3ljz/9THObGNbr5YDYIXAq+0b7LmtOn2MZitDe4i/1N3+5boN9geFjeYWCSUhbJMzuX17ShyIynkHznpIAmwLwod/X3tPl6GXLobG7GNenobfTiXCV8+jqIIlF1gC0/v6L3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIy2khnH7rpJhqYWKeBq15AMpSB3JAGXff1/ejF2vPU=;
 b=osehiSa/68BFLE3EJkNNHZ1El6WmdhbHfB3THiWfpSNmlr13TbNLefKBscrS3Kzc6ovmi8M6zZJxHGrjQzDchZbr+OOQzESC03bZVQ+2A0jnbVmGOiqkT8+R++u6+PPe1Aue928YuBaq5YAlXbH/c9fnJ4vtyJBJGEgh6yNxZhh2ktfZGYxwJIJvFGxyoiPUeYs+F7qvVslFtTuKZ3IiFRXvvUc98HfJoPtDvz0r+efhKf0CPcKW4rcVTLdBa1CTBtuRp2/I9rbJjjMzL9R3VfKD3sy4QSwVDcgzxZaW9uShA5i9LLctsTCGPzsGsc30+/qLrTobkhvocxw3MYaJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIy2khnH7rpJhqYWKeBq15AMpSB3JAGXff1/ejF2vPU=;
 b=pVQ5SR8UaAvoOQXD3Apm1lnSw6gTRUrI05bygCbY59IomQnBL8lZf2OJlAgENSO5pJkDi1UmvZ49YmsG4JdrWdf6JIRp4gTRQcgCbE1OL7KKE5gCNWZDgK2+MlWT5oq9hq+tmfyvp5fImbmkqGj8O3snhXO5PNO4yJJ6D7fkgT8=
Received: from DM6PR02CA0147.namprd02.prod.outlook.com (2603:10b6:5:332::14)
 by BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 17:30:38 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::71) by DM6PR02CA0147.outlook.office365.com
 (2603:10b6:5:332::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 17:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 17:30:37 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 12:30:36 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <djbw@kernel.org>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <vishal.l.verma@intel.com>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
	<rafael@kernel.org>, <xueshuai@linux.alibaba.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v17 00/11] Enable CXL PCIe Port Protocol Error handling and logging
Date: Tue, 5 May 2026 12:30:18 -0500
Message-ID: <20260505173029.2718246-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5a9199-5dc2-4f03-d1e8-08deaacc05b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	W+Vc2lYOEr2t0/a/Szb/1K2ucUYgh3PerWbd1dW8A8nxpP0/fHBQPDNVvV14zO5q4p8JQz7JjmSAJhTnw339+XRmbNDph8aSvQHu1WEqmWzWv6NxaNagYGXFIkZxV6AvIN3+ujxiKHlx1JI8tDte6gcWgjnM2YB53KcromrSoTakAqahoWiNm4OOT/FdnnSzxM6rchbAED79BPwHvXZ3WhQvx1awxyB71L1KxteVo8vun1iU7aEruDrB6u8ZGI3H2M2nayyD1j76EOvUBjGj0EU2HiEV6hFTVY1BODyxd+TYILwghTV6yMNEgz8MVX8eSBdmfqNxLxI0I4OGrBBYrt7ixVDW3J1B55TDHGip988PjGLP/2dVAmpdkzxzETUkpL9lXZqMD5+0XPWuuoqRSOhSItXkVAGB5bg1XSaqf0D+1VU6bnWfgdTyUpdFHuug82TMgBV/WW3tnTtgwe4RMRSkRe1L/Nqynquzgy59mjs0YA2WbPAHRveKEg9AnZTheeC3t7WZloEcEbRw4+4dZIdMQWo5Kt+z1yTazLzXXPJDMsD1ZKlz8ZgMReRp+pfZUxcKNXobM88LbsMHHFWQjZ+ujU/t7YfMGqcyBRTBARaleOY34DZq3ElY7KaoOVZsaPo6pzQ2fCzYhqIxVeaWxudWMPoMJKfVatXu+C+tLB0VuX+YbpMqppyz3b5XEB7pNgEkkYGlnLUB/CC/A9DJ+sr4rAZ2iHjeyaNsJGlyo6Wrmbl2sX66pRqDH/F0PAAoNU7XExcJbU8nBEww+vbFa8s/X44iA3HH/eI0Z0PD7H0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AEsTaW8Qp6joWli8WBkFfDVogMLxTxgast5ylv9cwj2C+ZzNes81M6FTe3jxazLF0gOsM2zuii7Vb4UtrZUrw23vYD6zKqnloxxhzE7tuuUxeVxwR88Qu0wd6kb7avCdUbZ2i3DcnjmV3+wjbtxgxQxqNNjLPQ2q8HVtwBM4K8uvQjR0RHUsZPK5mIENYqoHuf70C2px6P7w7dTkrTquhrYl4szSAVrJPV5yKj6zHQx2ZJgCYgzjhaVfDlLMS6VP0uo906Vxj8f7vfOBsRQaJYan0doYUVGBCrH1GLLeERY+CeZww7eQs0XS6ER/GXbc1YiLAEoEPL57selmc1ejX9osZkJ+SW20Tg4w25AOzZVbTd4utBTSHcCRIeMu4AR2obS66pKuo88KUvJNmjETrvoRk0+k0WLcpXznMcSq8bvMu41hDLGKea4mri53xO8m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:30:37.8301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5a9199-5dc2-4f03-d1e8-08deaacc05b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404

This patch series enables CXL protocol error handling for both CXL Ports
and CXL Endpoints (EP). The previous revision is available at:

https://lore.kernel.org/linux-cxl/20260302203648.2886956-1-terry.bowman@amd.com/

Today the kernel handles native CXL.cachemem RAS only for Endpoints and
Restricted CXL Host (RCH) Downstream Ports. Root Ports, Upstream Switch
Ports, and Downstream Switch Ports are uncovered. This series introduces
a unified CXL protocol error path for all CXL device types, in both VH
and RCH topologies.

CXL protocol errors are layered as a distinct error plane on top of PCIe
AER. CXL RAS conditions are signaled as PCIe correctable (CE) and
uncorrectable (UCE) Internal AER Errors. The AER driver classifies these
events using pcie_is_cxl() and hands them off to cxl_core through the
AER-CXL kfifo.

The cxl_core driver dequeues each event, resolves the cxl_port topology,
and dispatches to the CE or UCE handler. RCD Endpoints are handled
slightly differently: the RCH Downstream Port's RAS state is processed
first, then the Endpoint's own RAS follows the common path.

PCIe AER errors remain a separate plane and are handled independently.
This series tightens the CXL Endpoint AER UCE handler and removes the
Endpoint AER CE handler, which is now redundant since the AER driver
clears and logs CE status itself.

PCI_ERS_RESULT_PANIC, introduced in earlier revisions, has been dropped.
The panic decision is made directly in cxl_do_recovery(): the kernel
panics on any uncorrectable CXL RAS error reported by cxl_handle_ras(),
or earlier on link disconnect.

A fatal UCE on an Upstream Switch Port or Endpoint surfaces through the
AER path rather than the CXL RAS path. USP devices are bound to the PCIe
portdrv driver, so when a USP reports a fatal UCE, the PCIe error
handler provided by portdrv is invoked. PCI config reads to the source
device are expected to fail in this scenario, so the AER core never
retrieves UNCOR_STATUS, and the event cannot be classified as CXL. See
the fatal and non-fatal log excerpts for USP and EP below.

The last patch is documentation with a diagram conveying the above.


== Patch Details ==

Patch 1 - PCI/AER: Introduce AER-CXL Kfifo
Adds the AER-CXL kfifo in drivers/pci/pcie/aer_cxl_vh.c along with the
producer helper cxl_forward_error() and the consumer registration
helpers cxl_register_proto_err_work() and cxl_unregister_proto_err_work().
The kfifo is intended to deliver CXL VH protocol errors from the AER
driver to cxl_core. The producer dispatch in handle_error_source() and
the consumer registration are added together in patch 6 so the path
goes live atomically.

Patch 2 - cxl/ras: Unify Endpoint and Port AER trace events
Unifies the Endpoint and Port AER trace events into a single set used by
all CXL devices on both the CPER and native AER paths. THIS IS AN ABI
CHANGE FOR USERSPACE TOOLS THAT KEY OFF THE OLD ENDPOINT TRACE FIELD
NAMES.

Patch 3 - cxl: Use common CPER handling for all CXL devices
Folds the Port and Endpoint paths in CPER protocol error handling into a
single code path.

Patch 4 - cxl: Rename find_cxl_port() to find_cxl_port_by_dport()
Renames find_cxl_port() to find_cxl_port_by_dport() to make the lookup
method explicit and consistent with the existing find_cxl_port_by_uport().
Both helpers remain static to core/port.c; patch 6 widens their scope
when it adds the first cross-file caller.

Patch 5 - cxl: Limit CXL-CPER kfifo registration functions scope
Limits the scope of the CXL-CPER kfifo registration functions and adds
work cancellation on unregister.

Patch 6 - PCI: Establish common CXL Port protocol error flow
Dequeues work from the AER-CXL kfifo and establishes a common flow for
all CXL Port protocol error handling. It directs CXL protocol errors to
correctable or uncorrectable handlers, and panics on any uncorrectable
CXL RAS error.

Patch 7 - PCI/CXL: Add RCH support to CXL handlers
Adds CXL1.1 Restricted CXL Host (RCH) support to the new common flow.
Behavior change: an RCD uncorrectable CXL RAS error now panics, matching
the policy applied to all other CXL devices. The RCH trace events also
change to report by PCI BDF instead of memdev name.

Patch 8 - cxl: Remove Endpoint AER correctable handler
Removes the CXL PCIe AER correctable handler. The handling and logging is
already performed by the AER driver and the new common flow.

Patch 9 - cxl: Update Endpoint AER uncorrectable handler
Replaces cxl_error_detected() with cxl_pci_error_detected(). The new
handler decides solely on the pci_channel_state_t parameter and does not
access PCIe AER capability registers from .error_detected, matching the
pattern used by NVMe, ixgbe, mlx5, and other modern PCIe drivers.
CXL.cachemem-corrupting protocol errors are routed separately through
the AER-CXL kfifo to cxl_handle_proto_error(), so cxl_pci does not need
to second-guess the AER core's classification.

Patch 10 - PCI/CXL: Mask/Unmask CXL protocol errors
Enables CXL Internal Error reporting on CXL Ports and Endpoints. The
unmask is paired with the RAS register block mapping in
cxl_dport_map_ras() and devm_cxl_port_ras_setup() so it only runs when
RAS registers were successfully mapped. The matching mask is registered
as a devres action and runs when the cxl_port device's devres is
released.

Patch 11 - Documentation: cxl: Document CXL protocol error handling
Adds Documentation/driver-api/cxl/linux/protocol-error-handling.rst
describing the end-to-end CXL protocol error path: AER ingress, the
AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
cases, severity policy, trace events, and a source code map.

== Notes ==

- @Bjorn, I kindly request your review for the following patches. Many
  of the changes are to CXL-specific files in the PCI tree:

  Patch 1  - PCI/AER: Introduce AER-CXL Kfifo
  Patch 6  - PCI: Establish common CXL Port protocol error flow
  Patch 7  - PCI/CXL: Add RCH support to CXL handlers
  Patch 10 - PCI/CXL: Mask/Unmask CXL protocol errors

- USP/EP fatal UCE follows the AER path because of how the AER core
  collects status. aer_get_device_error_info() only reads
  PCI_ERR_UNCOR_STATUS for Root Ports/RCECs/Downstream Ports or
  non-fatal severities, where config reads to the source are still
  expected to succeed. For a fatal UCE signaled by an upstream
  component, config reads to that device are expected to fail, so
  UNCOR_STATUS is never retrieved. Without the status word,
  is_cxl_error() cannot classify the event as CXL and the AER path
  handles it.

- Dan's related series addressing RAS setup has more details:
  https://lore.kernel.org/linux-cxl/20260131000403.2135324-1-dan.j.williams@intel.com/

- TODOs for future series:
  - Add Port support to CXL CLI injection (Ben)
  - Move aer_cxl_rch.c to cxl/core/ras_rch.c
  - Move RCH traversing for handling from AER driver into CXL driver
  - Investigate if cxl_pci UCE error handler can be removed.
  - Support user-defined status masks
  - Add CXL Port traversing in cxl_do_recovery()
  
== Testing ==

Below are the testing results while using QEMU. The QEMU testing uses a CXL
Root Port, a CXL Upstream Switch Port, four CXL Downstream Switch Ports,
and four CXL Type 3 Endpoints as given below. I've attached the QEMU
startup commandline used. This testing uses protocol error injection at one
of each device class (Root Port, USP, DSP, Endpoint).

The test setup uses a modified aer-inject that supports CE and UCE
Internal Error injection. Because the QEMU CXL devices do not provide a
way to set the CXL RAS UNCOR_STATUS / COR_STATUS registers from
userspace, a separate out-of-tree debug patch ("test/cxl: Force RAS
status in cxl_handle_cor_ras() and cxl_handle_ras()") is applied on top
of the series for these tests, unconditionally OR'ing a Cache Data ECC
bit into the RAS status read. That debug patch is intentionally NOT part
of this v17 posting; reviewers reproducing the logs below in QEMU will
need it (or equivalent QEMU support) to see the CXL RAS trace events.

The sub-topology for the QEMU testing is:

                          ---------------------
                          | CXL RP - 0C:00.0  |
                          ---------------------
                                    |
                          ---------------------
                          | CXL USP - 0D:00.0 |
                          ---------------------
                                    |
            +-------------+---------+---------+-------------+
            |             |                   |             |
  ---------------- ---------------- ---------------- ----------------
  |CXL DSP       | |CXL DSP       | |CXL DSP       | |CXL DSP       |
  |  0E:00.0     | |  0E:01.0     | |  0E:02.0     | |  0E:03.0     |
  ---------------- ---------------- ---------------- ----------------
            |             |                   |             |
  ---------------- ---------------- ---------------- ----------------
  | CXL EP       | | CXL EP       | | CXL EP       | | CXL EP       |
  |  0F:00.0     | |  10:00.0     | |  11:00.0     | |  12:00.0     |
  ---------------- ---------------- ---------------- ----------------

 root@tbowman-cxl:~# lspci -t
 -+-[0000:00]-+-00.0
  |           +-01.0
  |           +-02.0
  |           +-03.0
  |           +-1f.0
  |           +-1f.2
  |           \-1f.3
  \-[0000:0c]---00.0-[0d-12]----00.0-[0e-12]--+-00.0-[0f]----00.0
                                              +-01.0-[10]----00.0
                                              +-02.0-[11]----00.0
                                              \-03.0-[12]----00.0

=== Root Port - CE ===

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
pcieport 0000:0c:00.0:    [14] CorrIntErr
cxl_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c serial=0 status: 'Cache Data ECC Error'

== Root Port - UCE ==

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
pcieport 0000:0c:00.0:    [22] UncorrIntErr
cxl_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c serial=0 status: 'Cache Data Parity Error' first_error: 'Cache Data Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 7 UID: 0 PID: 199 Comm: kworker/7:1 Not tainted 7.1.0-rc2-00011-g8cbf75633e69 #26 PREEMPT(lazy)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 vpanic+0x453/0x4b0
 panic+0x56/0x60
 __cxl_proto_err_work_fn+0x265/0x280 [cxl_core]
 ? __pfx___cxl_proto_err_work_fn+0x10/0x10 [cxl_core]
 for_each_cxl_proto_err+0x50/0x90
 cxl_proto_err_work_fn+0x27/0x80 [cxl_core]
 process_one_work+0x16e/0x3c0
 worker_thread+0x172/0x2e0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1bd/0x220
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== Upstream Switch Port - CE ==

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
pcieport 0000:0d:00.0:    [14] CorrIntErr
cxl_aer_correctable_error: device=0000:0d:00.0 host=0000:0c:00.0 serial=0 status: 'Cache Data ECC Error'

== Upstream Switch Port - UCE (fatal - AER recovery) ==

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
pcieport 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
cxl_pci 0000:0f:00.0: mem1: frozen state error detected, disable CXL.mem
cxl_pci 0000:10:00.0: mem0: frozen state error detected, disable CXL.mem
cxl_pci 0000:11:00.0: mem3: frozen state error detected, disable CXL.mem
cxl_pci 0000:12:00.0: mem2: frozen state error detected, disable CXL.mem
pcieport 0000:0c:00.0: AER: Root Port link has been reset (0)
cxl_pci 0000:0f:00.0: mem1: restart CXL.mem after slot reset
cxl_pci 0000:10:00.0: mem0: restart CXL.mem after slot reset
cxl_pci 0000:11:00.0: mem3: restart CXL.mem after slot reset
cxl_pci 0000:12:00.0: mem2: restart CXL.mem after slot reset
cxl_pci 0000:0f:00.0: mem1: error resume successful
cxl_pci 0000:10:00.0: mem0: error resume successful
cxl_pci 0000:11:00.0: mem3: error resume successful
cxl_pci 0000:12:00.0: mem2: error resume successful
pcieport 0000:0c:00.0: AER: device recovery successful

== Upstream Switch Port - UCE (non-fatal - panic) ==

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Non-Fatal) error message received from 0000:0d:00.0
aer_event: 0000:0d:00.0 CXL Bus Error: severity=Uncorrected, non-fatal, Uncorrectable Internal Error, TLP Header=Not available
pcieport 0000:0d:00.0: CXL Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00400000/02000000
pcieport 0000:0d:00.0:    [22] UncorrIntErr
cxl_aer_uncorrectable_error: device=0000:0d:00.0 host=0000:0c:00.0 serial=0 status: 'Cache Data Parity Error' first_error: 'Cache Data Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 7 UID: 0 PID: 54 Comm: kworker/7:0 Not tainted 7.1.0-rc2-00011-g8cbf75633e69 #26 PREEMPT(lazy)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 vpanic+0x453/0x4b0
 panic+0x56/0x60
 __cxl_proto_err_work_fn+0x265/0x280 [cxl_core]
 ? __pfx___cxl_proto_err_work_fn+0x10/0x10 [cxl_core]
 for_each_cxl_proto_err+0x50/0x90
 cxl_proto_err_work_fn+0x27/0x80 [cxl_core]
 process_one_work+0x16e/0x3c0
 worker_thread+0x172/0x2e0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1bd/0x220
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== Downstream Switch Port - CE ==

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
pcieport 0000:0e:00.0:    [14] CorrIntErr
cxl_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 serial=0 status: 'Cache Data ECC Error'

== Downstream Switch Port - UCE (fatal) ==

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
pcieport 0000:0e:00.0:    [22] UncorrIntErr
cxl_aer_uncorrectable_error: device=0000:0e:00.0 host=0000:0d:00.0 serial=0 status: 'Cache Data Parity Error' first_error: 'Cache Data Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 7 UID: 0 PID: 211 Comm: kworker/7:1 Not tainted 7.1.0-rc2-00011-g8cbf75633e69 #26 PREEMPT(lazy)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 vpanic+0x453/0x4b0
 panic+0x56/0x60
 __cxl_proto_err_work_fn+0x265/0x280 [cxl_core]
 ? __pfx___cxl_proto_err_work_fn+0x10/0x10 [cxl_core]
 for_each_cxl_proto_err+0x50/0x90
 cxl_proto_err_work_fn+0x27/0x80 [cxl_core]
 process_one_work+0x16e/0x3c0
 worker_thread+0x172/0x2e0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1bd/0x220
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== Endpoint - CE ==

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/0000a000
cxl_pci 0000:0f:00.0:    [14] CorrIntErr
cxl_aer_correctable_error: device=0000:0f:00.0 host=0000:0e:00.0 serial=0 status: 'Cache Data ECC Error'

== Endpoint - UCE (fatal - AER recovery) ==

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
cxl_pci 0000:0f:00.0: mem0: frozen state error detected, disable CXL.mem
pcieport 0000:0e:00.0: AER: Downstream Port link has been reset (0)
cxl_pci 0000:0f:00.0: mem0: restart CXL.mem after slot reset
cxl_pci 0000:0f:00.0: mem0: error resume successful
pcieport 0000:0e:00.0: AER: device recovery successful

== Endpoint - UCE (non-fatal) ==

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Non-Fatal) error message received from 0000:0f:00.0
aer_event: 0000:0f:00.0 CXL Bus Error: severity=Uncorrected, non-fatal, Uncorrectable Internal Error, TLP Header=Not available
cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00400000/02000000
cxl_pci 0000:0f:00.0:    [22] UncorrIntErr
cxl_aer_uncorrectable_error: device=0000:0f:00.0 host=0000:0e:00.0 serial=0 status: 'Cache Data Parity Error' first_error: 'Cache Data Parity Error'
Kernel panic - not syncing: CXL cachemem error.
CPU: 7 UID: 0 PID: 201 Comm: kworker/7:1 Not tainted 7.1.0-rc2-00011-g8cbf75633e69 #26 PREEMPT(lazy)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 vpanic+0x453/0x4b0
 panic+0x56/0x60
 __cxl_proto_err_work_fn+0x265/0x280 [cxl_core]
 ? __pfx___cxl_proto_err_work_fn+0x10/0x10 [cxl_core]
 for_each_cxl_proto_err+0x50/0x90
 cxl_proto_err_work_fn+0x27/0x80 [cxl_core]
 process_one_work+0x16e/0x3c0
 worker_thread+0x172/0x2e0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1bd/0x220
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error. ]---

== Changes ==

Changes in v16->v17:
PCI/AER: Introduce AER-CXL Kfifo
- Reword "kfifo semaphore" to "kfifo spinlock" to match fifo_lock.
- Defer the handle_error_source() is_cxl_error() switch to the patch that
  registers the kfifo consumer to keep each commit bisect-safe.
- Rename rwsema to rwsem
- Change CPER exports to use EXPORT_SYMBOL_FOR_MODULES.
- Add work cancel function.
- Replace kfifo_put() with kfifo_in_spinlocked() for multiple producers
- Add fifo_lock spinlock for concurrent producer serialisation
- Initialize the embedded kfifo with INIT_KFIFO() in a subsys_initcall so
  kfifo->mask, ->esize and ->data are set before first use.
- Clear PCI_ERR_COR_STATUS in cxl_forward_error() before enqueue so the
  device is acked for correctable events even when the consumer drops the
  event. Uncorrectable status is left for cxl_do_recovery() to clear after
  recovery completes, mirroring the AER core convention.
- WARN on double-registration in cxl_register_proto_err_work() to make an
  unintended second consumer visible at runtime.
- Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
  in aer_cxl_vh.c
- Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
- Update message
cxl/ras: Unify Endpoint and Port AER trace events
- Replace cxlds->serial with pci_get_dsn()
- Change 'memdev' to 'device' (Dan)
- Updated Commit message
cxl: Use common CPER handling for all CXL devices
- New commit
cxl: Rename find_cxl_port() to find_cxl_port_by_dport()
- New commit
- Drop the de-staticisation of find_cxl_port_by_uport() and the
  core.h declarations from this prep patch; both move to the patch
  that introduces the first cross-file caller.
cxl: Limit CXL-CPER kfifo registration functions scope
- Split from v16 02/10 ("Update unregistration for AER-CXL and
  CPER-CXL kfifos"); AER-CXL half folded into v17 01/10.
- Convert exports to EXPORT_SYMBOL_FOR_MODULES("cxl_core").
- Change register/unregister return type from int to void.
- Drop work_struct argument from cxl_cper_unregister_prot_err_work();
  it now cancels its own work.
- Remove now-redundant cancel_work_sync() from cxl_ras_exit().
- Add WARN_ONCE() in cxl_cper_register_prot_err_work() for
  double-registration.
PCI: Establish common CXL Port protocol error flow
- get_cxl_port() -> find_cxl_port_by_dev()
- Simplified find_cxl_port_by_dev()
- Replace and remove cxl_serial_number() w/ pci_get_dsn()
- cxl_get_ras_base() -> to_ras_base()
- Drop dependency on PCI_ERS_RESULT_PANIC; cxl_do_recovery() panics
  directly. (PANIC enum patch dropped from series.)
- Clarify panic semantics: panic on any uncorrectable CXL RAS error, not
  only AER-FATAL severities.
- Drop the redundant PCI_ERR_COR_STATUS RMW in cxl_handle_proto_error();
  cxl_forward_error() already acks the correctable AER status.
- Add is_cxl_error() switch in handle_error_source() here, paired with the
  kfifo consumer registration, to keep each commit bisect-safe.
- Drop pcie_aer_is_native() guard in cxl_do_recovery() (always native).
- Swap order with the "Limit" patch for bisectability w/ cxl_ras_exit()
- Reword for "any uncorrectable" CXL RAS error panics.
- Restore log messages for port-not-found and port-unbound cases.
- Whitespace cleanup (Jonathan)
- Update to get_cxl_port() documentation (Terry)
- Fix __cxl_proto_err_work_fn() to return 0 for transient errors.
- Drop !port check in cxl_do_recovery(), caller already validated
- Fix kerneldoc @pdev -> @dev in find_cxl_port_by_dev()
- Fix missing space in pr_err_ratelimited()
- Add disconnect check before access
- Made pcie_clear_device_status() and pci_aer_clear_fatal_status()
  EXPORT_SYMBOL_FOR_MODULES("cxl_core") (Dan)
- Move find_cxl_port_by_dport() and find_cxl_port_by_uport()
  de-staticisation and core.h declarations from the rename patch to
  here, where the first cross-file callers in find_cxl_port_by_dev()
  land.
PCI/CXL: Add RCH support to CXL handlers
- Drop now-dead cxlds->rcd branches from cxl_{cor_,}error_detected().
- Drop duplicate subject line from commit body.
- Document panic-on-uncorrectable behavior change for RCD path.
- Document trace event device-name change (memN -> PCI BDF) for RCH path.
- Rewrite cxl_handle_proto_error() RC_END comment to clarify RCD/RCH shared
  interrupt relationship
- Rewrite commit message
cxl: Remove Endpoint AER correctable handler
- Update commit message
- Add Reviewed-by from Jonathan and DaveJ
cxl: Update Endpoint AER uncorrectable handler
- Rename pci_error_handlers struct instance to cxl_pci_error_handlers to
  avoid shadowing the struct type tag.
- Restore scoped_guard(device) and dev->driver check around AER read.
- NULL-check find_cxl_port_by_dev() before deref of port->uport_dev.
- Updated commit message. (Terry)
- Add scope cleanup for port variable in cxl_pci_error_detected() (Terry)
- Drop cxl_uncor_aer_present(), rely on AER state
PCI/CXL: Mask/Unmask CXL protocol errors
- Drop redundant cxl_mask_proto_interrupts() calls from unregister_port()
  and cxl_dport_remove(); the devres action registered alongside the unmask
  is the sole mask path.
- Update title
- Remove unnecessary check for aer_capabilities
- Gate cxl_unmask_proto_interrupts() on pcie_aer_is_native()
- Add pci_aer_mask_internal_errors() and cxl_mask_proto_interrupts()
- Only unmask on successful cxl_map_component_regs()
- NULL-check @dev in cxl_{un,}mask_proto_interrupts()
- Drop static and declare in core/core.h
Documentation: cxl: Document CXL protocol error handling
- New commit

Changes in v15->v16:
PCI/AER: Introduce AER-CXL Kfifo
- Add pci_dev_put() and comment at pci_dev_get() (Dan)
- /rw_sema/rwsema/ (Dan)
- Split validation checks in cxl_forward_error() to allow
  for meaningful reason in log (Terry)
- Shortened commit title to remove wordiness (Terry)
PCI/CXL: Update unregistration for AER-CXL and CPER-CXL kfifos
- New commit
cxl: Update CXL Endpoint tracing
- Add Dan's review-by
- Incorporate Dan's comment into commit message:
  "Add the serial number at the end to preserve compatibility with
  libtraceevent parsing of the parameters."
PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
- None
PCI: Establish common CXL Port protocol error flow
- get_ras_base(), initialize dport to NULL (Jonathan)
- Remove guard(device)(&cxlmd->dev) (Jonathan)
- Fix dev_warns() (Jonathan)
- Remove comment in cxl_port_error_detected() (Dan)
- Made pcie_clear_device_status() and pci_aer_clear_fatal_status()
  "CXL" Export namespace (Dan)
- Update switch-case brackets to follow clang-format (Dan)
- Add PCI_EXP_TYPE_RC_END for cxl_get_ras_base() (Terry)
- Add NULL port check in cxl_serial_number() (Terry)
PCI/CXL: Add RCH support to CXL handlers
- New commit
cxl: Update error handlers to support CXL Port devices
- None
cxl: Update Endpoint AER uncorrectable handler
- Update commit message (DaveJ)
- s/cxl_handle_aer()/cxl_uncor_aer_present()/g (Jonathan)
- cxl_uncor_aer_present(): Leave original result calculation based on
  if a UCE is present and the provided state (Terry)
- Add call to pci_print_aer(). AER fails to log because is upstream
  link (Terry)
cxl: Remove Endpoint AER correctable handler
- None
cxl: Enable CXL protocol error reporting
- None

Changes in v14->v15:
 PCI/AER: Introduce AER-CXL Kfifo in new file, pcie/aer_cxl_vh.c
 - Move pci_dev_get() call to this patch (Dave)
 cxl: Update CXL Endpoint tracing
 - Update commit message
 - Moved cxl_handle_ras/cxl_handle_cor_ras() changes to future patch (Terry)
 PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
 - None
 PCI/AER: Dequeue forwarded CXL error
 - Move pci_dev_get() to cxl_forward_error() (Dave)
 - Move in is_cxl_error() change from later patch (Terry)
 PCI: Establish common CXL Port protocol error flow
 - Update commit message and title. Added Bjorn's ack.
 - Move CE and UCE handling logic here (Terry)
 cxl: Update error handlers to support CXL Port protocol errors
 - New commit (Terry)
 cxl: Update Endpoint AER uncorrectable handler
 - Title update (Terry)
 - Change cxl_pci_error-detected() to handle & log AER (Terry)
 - Update commit message (Terry)
 - Moved cxl_handle_ras()/cxl_handle_cor_ras() to earlier patch (Terry)
 cxl: Remove Endpoint AER correctable handler
 - Remove cxl_pci_cor_error_detected(). Is not needed. AER is logged
   in the AER driver. (Dan)
 - Update commit message (Terry)
 cxl: Enable CXL protocol error reporting
 - Update commit title's prefix (Bjorn)

Changes in v13->v14:
 PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - Add Jonathan's and Dan's review-by
 - Update commit title prefix (Bjorn)
 - Revert format fix for cxl_sbr_masked() (Jonathan)
 - Update 'Compute Express Link' comment block (Jonathan)
 - Move PCI_DVSEC_CXL_FLEXBUS definitions to later patch where
   used (Jonathan)
 - Removed stray change (Bjorn)
 PCI: Update CXL DVSEC definitions
 - New patch. Split from previous patch such that there is now a separate
   move patch and a format fix patch.
 - Formatting update requested (Bjorn)
 - Remove PCI_DVSEC_HEADER1_LENGTH_MASK because it duplicates
   PCI_DVSEC_HEADER1_LEN() (Bjorn)
 - Add Dan's review-by
 PCI: Introduce pcie_is_cxl()
 - Move FLEXBUS_STATUS DVSEC here (Jonathan)
 - Remove check for EP and USP (Dan)
 - Update commit message (Bjorn)
 - Fix writing past 80 columns (Bjorn)
 - Add pci_is_pcie() parent bridge check at beginning of function (Bjorn)
 PCI: Replace cxl_error_is_native() with pcie_aer_is_native()
 - New commit
 cxl/pci: Move CXL driver's RCH error handling into core/ras_rch.c
 - Add sign-off for Dan and Jonathan
 - Revert inadvertent formatting of cxl_dport_map_rch_aer() (Jonathan)
 - Remove default value for CXL_RCH_RAS (Dan)
 - Remove unnecessary pci.h include in core.h & ras_rch.c (Jonathan)
 - Add linux/types.h include in ras_rch.c (Jonathan)
 - Change CONFIG_CXL_RCH_RAS -> CONFIG_CXL_RAS (Dan)
 PCI/AER: Export pci_aer_unmask_internal_errors
 - New commit. Bjorn requested separating out and adding immediatetly
   before being used. This is called from cxl_rch_enable_rcec() in
   following patch.
 PCI/AER: Update is_internal_error() to be non-static is_aer_internal_error()
 - New commit
 PCI/AER: Move CXL RCH error handling to aer_cxl_rch.c
 - Add review-by and signed-off for Dan
 - Commit message fixup (Dan)
 - Update commit message with use-case description (Dan, Lukas)
 - Make cxl_error_is_native() static (Dan)
 - Make is_internal_error() non-static, non-export (Terry)
 PCI/AER: Use guard() in cxl_rch_handle_error_iter()
 - Add review-by for Jonathan, Dave Jiang, Dan WIlliams, and Bjorn
 - Remove cleanup.h (Jonathan)
 - Reverted comment removal (Bjorn)
 - Move this patch after pci/pcie/aer_cxl_rch.c creation (Bjorn)
 PCI/AER: Replace PCIEAER_CXL symbol with CXL_RAS
 - New commit
 PCI/AER: Report CXL or PCIe bus type in AER trace logging
 - Merged with Dan's commit. Changes are moving bus_type the last
   parameter in function calls (Dan)
 - Removed all DCOs because of changes (Terry)
 - Update commit message (Bjorn)
 - Add Bjorn's ack-by
 PCI/AER: Update struct aer_err_info with kernel-doc formatting
 - New commit
 cxl/mem: Clarify @host for devm_cxl_add_nvdimm()
 - New commit
 cxl/port: Remove "enumerate dports" helpers
 - New commit
 cxl/port: Fix devm resource leaks around with dport management
 - New commit
 cxl/port: Move dport operations to a driver event
 - New commit
 cxl/port: Move dport RAS reporting to a port resource
 - New commit
 cxl: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Correct message spelling (Terry)
 cxl/port: Move endpoint component register management to cxl_port
 - Correct message spelling (Terry)
 cxl/port: Map Port component registers before switchport init
 - Updates to use cxl_port_setup_regs() (Dan)
 cxl: Change CXL handlers to use guard() instead of scoped_guard()
 - Add reviewed-by for Jonathan and Dave Jiang
 PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
 - Add review-by for Dan
 - Update Title prefix (Bjorn)
 - Removed merge_result. Only logging error for device reporting the
   error (Dan)
 - Remove PCI_ERS_RESULT_PANIC paragraph in pci-error-recovery.rst (Bjorn)
 PCI/AER: Move AER driver's CXL VH handling to pcie/aer_cxl_vh.c
 - Replaced workqueue_types.h include with 'struct work_struct'
   predeclaration (Bjorn)
 - Update error message (Bjorn)
 - Reordered 'struct cxl_proto_err_work_data' (Bjorn)
 - Remove export of cxl_error_is_native() here (Bjorn)
 cxl/port: Unify endpoint and switch port lookup
 - New patch
 PCI/AER: Dequeue forwarded CXL error
 - Update commit title's prefix (Bjorn)
 - Add pdev ref get in AER driver before enqueue and add pdev ref put in
   CXL driver after dequeue and handling (Dan)
 - Removed handling to simplify patch context (Terry)
 PCI: Introduce CXL Port protocol error handlers
 - Add Dave Jiang's review-by
 - Update commit message & headline (Bjorn)
 - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
   one line (Jonathan)
 - Remove cxl_walk_port(). Only log the erroring device. No port walking. (Dan)
 - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
   sufficient (Dan)
 - Remove device_lock_if()
 - Combine CE and UCE here (Terry)
 cxl: Update Endpoint uncorrectable protocol error handling
 - Update commit headline (Bjorn)
 - Rename pci_error_detected()/pci_cor_error_detected() ->
   cxl_pci_error_detected/cxl_pci_cor_error_detected() (Jonathan)
 - Remove now-invalid comment in cxl_error_detected() (Jonathan)
 - Split into separate patches for UCE and CE (Terry)
 cxl: Update Endpoint correctable protocol error handling
 - New commit
 - Change cxl_cor_error_detected() parameter to &pdev->dev device from
   memdev device. (Terry)
 cxl: Enable CXL protocol errors during CXL Port probe
 - Update commit title's prefix (Bjorn)
 Changes in v12->v13:
 CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - Add Dave Jiang's reviewed-by
 - Remove changes to existing PCI_DVSEC_CXL_PORT* defines. Update commit
   message. (Jonathan)
 PCI/CXL: Introduce pcie_is_cxl()
 - Add Ben's "reviewed-by"
 cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
 - None
 cxl/pci: Remove unnecessary CXL RCH handling helper functions
 - None
 cxl: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core
 - None
 cxl: Move CXL driver's RCH error handling into core/ras_rch.c
 - None
 CXL/AER: Replace device_lock() in cxl_rch_handle_error_iter() with guard() lock
 - New patch
 CXL/AER: Move AER drivers RCH error handling into pcie/aer_cxl_rch.c
 - Add forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
 - Changed copyright date from 2025 to 2023 (Jonathan)
 - Add David Jiang's, Jonathan's, and Ben's review-by
 - Readd 'struct aer_err_info' (Bot)
 PCI/AER: Report CXL or PCIe bus error type in trace logging
 - Remove duplicated aer_err_info inline comments. Is already in the
   kernel-doc header (Ben)
 cxl/pci: Update RAS handler interfaces to also support CXL Ports
 - None
 cxl/pci: Log message if RAS registers are unmapped
 - Added Bens review-by
 cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
 - Added Dave Jiang's review-by
 cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
 - Add Ben's review-by
 cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Change as result of dport delay fix. No longer need switchport and
 endport approach. Refactor. (Terry)
 CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
 - Add Dave Jiang's, Jonathan's, Ben's review-by
 - Typo fix (Ben)
 CXL/AER: Introduce pcie/aer_cxl_vh.c in AER driver for forwarding CXL errors
 - Add Dave Jiang's review-by
 - Update error message (Ben)
 cxl: Introduce cxl_pci_drv_bound() to check for bound driver
 - Add Dave Jiang's review-by.
 cxl: Change CXL handlers to use guard() instead of scoped_guard()
 - New patch
cxl/pci: Introduce CXL protocol error handlers for endpoints
 - Updated all the implemetnation and commit message. (Terry)
 - Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
   pdev (Dave Jiang)
CXL/PCI: Introduce CXL Port protocol error handlers
 - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
   patch (Terry)
 - Remove EP case in cxl_get_ras_base(), not used. (Terry)
 - Remove check for dport->dport_dev (Dave)
 - Remove whitespace (Terry)
PCI/AER: Dequeue forwarded CXL error
 - Rewrite cxl_handle_proto_error() and cxl_proto_err_work_fn() (Terry)
 - Rename get_cxl_host dev() to be get_cxl_port() (Terry)
 - Remove exporting of unused function, pci_aer_clear_fatal_status() (Dave Jiang)
 - Change pr_err() calls to ratelimited. (Terry)
 - Update commit message. (Terry)
 - Remove namespace qualifier from pcie_clear_device_status()
   export (Dave Jiang)
 - Move locks into cxl_proto_err_work_fn() (Dave)
 - Update log messages in cxl_forward_error() (Ben)
CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
 - Renamed pci_ers_merge_result() to pcie_ers_merge_result().
   pci_ers_merge_result() is already used in eeh driver. (Bot)
CXL/PCI: Introduce CXL uncorrectable protocol error recovery
 - Rewrite report_error_detected() and cxl_walk_port (Terry)
 - Add guard() before calling cxl_pci_drv_bound() (Dave Jiang)
 - Add guard() calls for EP (cxlds->cxlmd->dev & pdev->dev) and ports
   (pdev->dev & parent cxl_port) in cxl_report_error_detected() and
   cxl_handle_proto_error() (Terry)
 - Remove unnecessary check for endpoint port. (Dave Jiang)
 - Remove check for RCIEP EP in cxl_report_error_detected() (Terry)
CXL/PCI: Enable CXL protocol errors during CXL Port probe
 - Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
 - Add Dave Jiang's and Ben's review-by
CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
 - Added dev and dev_is_pci() checks in cxl_mask_proto_interrupts() (Terry)

Changes in v11 -> v12:
 cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
  - Added Dave Jiang's review by
  - Moved to front of series
 cxl/pci: Remove unnecessary CXL RCH handling helper functions
  - Add reviewed-by for Alejandro & Dave Jiang
  - Moved to front of series
 cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
  - Update CONFIG_CXL_RAS in CXL Kconfig to have CXL_PCI dependency (Terry)
 CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
  - Added review-by for Sathyanarayanan
  - Changed Kconfig dependency from PCIEAER_CXL to PCIEAER. Moved
    this backwards into this patch.
 cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditio
  - Moved CXL_RCH_RAS Kconfig definition here from following commit
 CXL/AER: Introduce aer_cxl_rch.c into AER driver for handling CXL RCH errors
  - Rename drivers/pci/pcie/cxl_rch.c to drivers/pci/pcie/aer_cxl_rch.c (Lukas)
  - Removed forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
 CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
  - Change formatting to be same as existing definitions
  - Change GENMASK() -> __GENMASK() and BIT() to _BITUL()
 PCI/CXL: Introduce pcie_is_cxl()
  - Add review-by for Alejandro
  - Add comment in set_pcie_cxl() explaining why updating parent status.
 PCI/AER: Report CXL or PCIe bus error type in trace logging
  - Change aer_err_info::is_cxl to be bool a bitfield. Update structure padding. (Lukas)
  - Add kernel-doc for 'struct aer_err_info' (Lukas)
 cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
  - Correct parameters to call trace_cxl_aer_correctable_error() (Shiju)
  - Add reviewed-by for Jonathan and Shiju
 cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
  - Add check for dport_parent->rch before calling cxl_dport_init_ras_reporting().
  - RCH dports are initialized from cxl_dport_init_ras_reporting cxl_mem_probe().
 CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
  - Documentation requested by (Lukas)
 CXL/AER: Introduce aer_cxl_vh.c in AER driver for forwarding CXL errors
  - Rename drivers/pci/pcie/cxl_aer.c to drivers/pci/pcie/aer_cxl_vh.c (Lukas)
 cxl: Introduce cxl_pci_drv_bound() to check for bound driver
  - New patch
 PCI/AER: Dequeue forwarded CXL error
  - Add guard for CE case in cxl_handle_proto_error() (Dave)
  - Updated commit message (Terry)
 CXL/PCI: Introduce CXL Port protocol error handlers
  - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
    pci_to_cxl_dev() (Lukas)
  - Change cxl_error_detected() -> cxl_cor_error_detected() (Terry)
  - Remove NULL variable assignments (Jonathan)
  - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
    port searches. (Dave)
 CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
  - Remove static inline pci_ers_merge_result() definition for !CONFIG_PCIEAER.
    Is not needed. (Lukas)
 CXL/PCI: Introduce CXL uncorrectable protocol error recovery
  - Clean up port discovery in cxl_do_recovery() (Dave)
  - Add PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()

Changes in v10 -> v11:
 cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
 - New patch
 CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
 - New patch
 cxl/pci: Remove unnecessary CXL RCH handling helper functions
 - New patch
 cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditional block
 - New patch
 CXL/AER: Introduce rch_aer.c into AER driver for handling CXL RCH errors
 - Remove changes in code-split and move to earlier, new patch
 - Add #include <linux/bitfield.h> to cxl_ras.c
 - Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
   to aer.h, more localized.
 - Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c ifdef changes
 CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - New patch
 PCI/CXL: Introduce pcie_is_cxl()
 - Amended set_pcie_cxl() to check for Upstream Port's and EP's parent
   downstream port by calling set_pcie_cxl(). (Dan)
 - Retitle patch: 'Add' -> 'Introduce'
 - Add check for CXL.mem and CXL.cache (Alejandro, Dan)
 PCI/AER: Report CXL or PCIe bus error type in trace logging
 - Remove duplicate call to trace_aer_event() (Shiju)
 - Added Dan William's and Dave Jiang's reviewed-by
 CXL/AER: Update PCI class code check to use FIELD_GET()
 - Add #include <linux/bitfield.h> to cxl_ras.c (Terry)
 - Removed line wrapping at "(CXL 3.2, 8.1.12.1)". (Jonathan)
 cxl/pci: Log message if RAS registers are unmapped
 - Added Dave Jiang's review-by (Terry)
 cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
 - Updated CE and UCE trace routines to maintian consistent TP_Struct ABI
   and unchanged TP_printk() logging. (Shiju, Alison)
 cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
 - Added Dave Jiang and Jonathan Cameron's review-by
 - Changes moved to core/ras.c
 cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
 - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
 - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
   and cxl_switch_port_init_ras() (Dave Jiang)
 - Port helper changes were in cxl/port.c, now in core/ras.c (Dave Jiang)
 cxl/pci: Introduce CXL Endpoint protocol error handlers
 - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
 - cxl_error_detected() - Remove extra line (Shiju)
 - Changes moved to core/ras.c (Terry)
 - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
 - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
 - Move #include "pci.h from cxl.h to core.h (Terry)
 - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
 CXL/AER: Introduce cxl_aer.c into AER driver for forwarding CXL errors
 - Move RCH implementation to cxl_rch.c and RCH declarations to pci/pci.h. (Terry)
 - Introduce 'struct cxl_proto_err_kfifo' containing semaphore, fifo,
   and work struct. (Dan)
 - Remove embedded struct from cxl_proto_err_work (Dan)
 - Make 'struct work_struct *cxl_proto_err_work' definition static (Jonathan)
 - Add check for NULL cxl_proto_err_kfifo to determine if CXL driver is
   not registered for workqueue. (Dan)
 PCI/AER: Dequeue forwarded CXL error
 - Reword patch commit message to remove RCiEP details (Jonathan)
 - Add #include <linux/bitfield.h> (Terry)
 - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
 - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
 - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
 - Usse FIELD_GET() in discovering class code (Jonathan)
 - Remove BDF from cxl_proto_err_work_data. Use 'struct pci_dev *' (Dan)
 CXL/PCI: Introduce CXL Port protocol error handlers
 - Removed check for PCI_EXP_TYPE_RC_END in cxl_report_error_detected() (Terry)
 - Update is_cxl_error() to check for acceptable PCI EP and port types
 CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
 - pci_ers_merge_result() - Change export to non-namespace and rename
   to be pci_ers_merge_result() (Jonathan)
 - Move pci_ers_merge_result() definition to pci.h. Needs pci_ers_result (Terry)
 CXL/PCI: Introduce CXL uncorrectable protocol error recovery
 - pci_ers_merge_results() - Move to earlier patch
 CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
 - Remove guard() in cxl_mask_proto_interrupts(). Observed device lockup/block
   during testing. (Terry)

Changes in v9 -> v10:
 - Add drivers/pci/pcie/cxl_aer.c
 - Add drivers/cxl/core/native_ras.c
 - Change cxl_register_prot_err_work()/cxl_unregister_prot_err_work to return void
 - Check for pcie_ports_native in cxl_do_recovery()
 - Remove debug logging in cxl_do_recovery()
 - Update PCI_ERS_RESULT_PANIC definition to indicate is CXL specific
 - Revert trace logging changes: name,parent -> memdev,host.
 - Use FIELD_GET() to check for EP class code (cxl_aer.c & native_ras.c).
 - Change _prot_ to _proto_ everywhere
 - cxl_rch_handle_error_iter(), check if driver is cxl_pci_driver
 - Remove cxl_create_prot_error_info(). Move logic into forward_cxl_error()
 - Remove sbdf_to_pci() and move logic into cxl_handle_proto_error()
 - Simplify/refactor get_pci_cxl_host_dev()
 - Simplify/refactor cxl_get_ras_base()
 - Move patch 'Remove unnecessary CXL Endpoint handling helper functions' to front
 - Update description for 'CXL/PCI: Introduce CXL Port protocol error
   handlers' with why state is not used to determine handling
 - Introduce cxl_pci_drv_bound() and call from cxl_rch_handle_error_iter()
 Changes in v8 -> v9:
 - Updated reference counting to use pci_get_device()/pci_put_device() in
   cxl_disable_prot_errors()/cxl_enable_prot_errors
 - Refactored cxl_create_prot_err_info() to fix reference counting
 - Removed 'struct cxl_port' driver changes for error handler. Instead
   check for CXL device type (EP or Port device) and call handler
 - Make pcie_is_cxl() static inline in include/linux/linux.h
 - Remove NULL check in create_prot_err_info()
 - Change success return in cxl_ras_init() to use hardcoded 0
 - Changed 'struct work_struct cxl_prot_err_work' declaration to static
 - Change to use rate limited log with dev anchor in forward_cxl_error()
 - Refactored forward-cxl_error() to remove severity auto variable
 - Changed pci_aer_clear_nonfatal_status() to be static inline for
   !(CONFIG_PCIEAER)
 - Renamed merge_result() to be cxl_merge_result()
 - Removed 'ue' condition in cxl_error_detected()
 - Updated 2nd parameter in call to __cxl_handle_cor_ras()/__cxl_handle_ras()
   in unify patch
 - Added log message for failure while assigning interrupt disable callback
 - Updated pci_aer_mask_internal_errors() to use pci_clear_and_set_config_dword()
 - Simplified patch titles for clarity
 - Moved CXL error interrupt disabling into cxl/core/port.c with CXL Port
 teardown
 - Updated 'struct cxl_port_err_info' to only contain sbdf and severity
 Removed everything else.
 - Added pdev and CXL device get_device()/put_device() before calling handlers

Changes in v7 -> v8:
 [Dan] Use kfifo. Move handling to CXL driver. AER forwards error to CXL
 driver
 [Dan] Add device reference incrementors where needed throughout
 [Dan] Initiate CXL Port RAS init from Switch Port and Endpoint Port init
 [Dan] Combine CXL Port and CXL Endpoint trace routine
 [Dan] Introduce aer_info::is_cxl. Use to indicate CXL or PCI errors
 [Jonathan] Add serial number for all devices in trace
 [DaveJ] Move find_cxl_port() change into patch using it
 [Terry] Move CXL Port RAS init into cxl/port.c
 [Terry] Moved kfifo functions into cxl/core/ras.c

Changes in v6 -> v7:
 [Terry] Move updated trace routine call to later patch. Was causing build
 error.

Changes in v5 -> v6:
 [Ira] Move pcie_is_cxl(dev) define to a inline function
 [Ira] Update returning value from pcie_is_cxl_port() to bool w/o cast
 [Ira] Change cxl_report_error_detected() cleanup to return correct bool
 [Ira] Introduce and use PCI_ERS_RESULT_PANIC
 [Ira] Reuse comment for PCIe and CXL recovery paths
 [Jonathan] Add type check in for cxl_handle_cor_ras() and cxl_handle_ras()
 [Jonathan] cxl_uport/dport_init_ras_reporting(), added a mutex.
 [Jonathan] Add logging example to patches updating trace output
 [Jonathan] Make parameter 'const' to eliminate for cast in match_uport()
 [Jonathan] Use __free() in cxl_pci_port_ras()
 [Terry] Add patch to log the PCIe SBDF along with CXL device name
 [Terry] Add patch to handle CXL endpoint and RCH DP errors as CXL errors
 [Terry] Remove patch w USP UCE fatal support @ aer_get_device_error_info()
 [Terry] Rebase to cxl/next commit 5585e342e8d3 ("cxl/memdev: Remove unused partition values")
 [Gregory] Pre-initialize pointer to NULL in cxl_pci_port_ras()
 [Gregory] Move AER driver bus name detection to a static function

Changes in v4 -> v5:
 [Alejandro] Refactor cxl_walk_bridge to simplify 'status' variable usage
 [Alejandro] Add WARN_ONCE() in __cxl_handle_ras() and cxl_handle_cor_ras()
 [Ming] Remove unnecessary NULL check in cxl_pci_port_ras()
 [Terry] Add failure check for call to to_cxl_port() in cxl_pci_port_ras()
 [Ming] Use port->dev for call to devm_add_action_or_reset() in
 cxl_dport_init_ras_reporting() and cxl_uport_init_ras_reporting()
 [Jonathan] Use get_device()/put_device() to prevent race condition in
 cxl_clear_port_error_handlers() and cxl_clear_port_error_handlers()
 [Terry] Commit message cleanup. Capitalize keywords from CXL and PCI
 specifications

Changes in v3 -> v4:
 [Lukas] Capitalize PCIe and CXL device names as in specifications
 [Lukas] Move call to pcie_is_cxl() into cxl_port_devsec()
 [Lukas] Correct namespace spelling
 [Lukas] Removed export from pcie_is_cxl_port()
 [Lukas] Simplify 'if' blocks in cxl_handle_error()
 [Lukas] Change panic message to remove redundant 'panic' text
 [Ming] Update to call cxl_dport_init_ras_reporting() in RCH case
 [lkp@intel] 'host' parameter is already removed. Remove parameter description too.
 [Terry] Added field description for cxl_err_handlers in pci.h comment block

Changes in v1 -> v2:
 [Jonathan] Remove extra NULL check and cleanup in cxl_pci_port_ras()
 [Jonathan] Update description to DSP map patch description
 [Jonathan] Update cxl_pci_port_ras() to check for NULL port
 [Jonathan] Dont call handler before handler port changes are present (patch order)
 [Bjorn] Fix linebreak in cover sheet URL
 [Bjorn] Remove timestamps from test logs in cover sheet
 [Bjorn] Retitle AER commits to use "PCI/AER:"
 [Bjorn] Retitle patch#3 to use renaming instead of refactoring
 [Bjorn] Fix base commit-id on cover sheet
 [Bjorn] Add VH spec reference/citation
 [Terry] Removed last 2 patches to enable internal errors. Is not needed
 because internal errors are enabled in AER driver.
 [Dan] Create cxl_do_recovery() and pci_driver::cxl_err_handlers.
 [Dan] Use kernel panic in CXL recovery
 [Dan] cxl_port_hndlrs -> cxl_port_error_handlers








Dan Williams (3):
  cxl/ras: Unify Endpoint and Port AER trace events
  cxl: Rename find_cxl_port() to find_cxl_port_by_dport()
  cxl: Limit CXL-CPER kfifo registration functions scope

Terry Bowman (8):
  PCI/AER: Introduce AER-CXL Kfifo
  cxl: Use common CPER handling for all CXL devices
  PCI: Establish common CXL Port protocol error flow
  PCI/CXL: Add RCH support to CXL handlers
  cxl: Remove Endpoint AER correctable handler
  cxl: Update Endpoint AER uncorrectable handler
  PCI/CXL: Mask/Unmask CXL protocol errors
  Documentation: cxl: Document CXL protocol error handling

 Documentation/driver-api/cxl/index.rst        |   1 +
 .../cxl/linux/protocol-error-handling.rst     | 440 ++++++++++++++++++
 MAINTAINERS                                   |   2 +
 drivers/acpi/apei/ghes.c                      |  27 +-
 drivers/cxl/core/core.h                       |  22 +-
 drivers/cxl/core/port.c                       |  22 +-
 drivers/cxl/core/ras.c                        | 351 +++++++++-----
 drivers/cxl/core/ras_rch.c                    |  10 +-
 drivers/cxl/core/trace.h                      |  76 +--
 drivers/cxl/cxlpci.h                          |  11 +-
 drivers/cxl/pci.c                             |   7 +-
 drivers/pci/pci.c                             |   1 +
 drivers/pci/pci.h                             |   2 -
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/aer.c                        |  33 +-
 drivers/pci/pcie/aer_cxl_rch.c                |  17 +-
 drivers/pci/pcie/aer_cxl_vh.c                 | 149 ++++++
 drivers/pci/pcie/portdrv.h                    |   4 +
 include/cxl/event.h                           |  10 +-
 include/linux/aer.h                           |  32 ++
 include/linux/pci.h                           |   2 +
 21 files changed, 959 insertions(+), 261 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/linux/protocol-error-handling.rst
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c


base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
-- 
2.34.1

