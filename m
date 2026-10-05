Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E993093C1;
	Mon,  5 Oct 2026 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183813; cv=fail; b=O42BuayaZzTelBnFCVMLBBWuvObOelPIzGSdrqOP22w5MqW976qpfWQru3udcXHiU7BxK/7eUeLDLyDaSQb89dXN7HBG+TsfQuurbwVJgFlF9NP9ncH1/Q+87gY3+t0XwP9PQ3rA3t6VJYZO8IbfXPjtF3CPLBTN1K/r489KRJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183813; c=relaxed/simple;
	bh=JHJt2l4/u7u7dWcXSgTZ+TXmKViHEMn+KFzZlJrDrv8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N5cKq1i4jSl0bqV25+yoI/wsJsvGFmV+6vkDYJVS9vvJnVy53knGkUM6NP9bhNzZYg5BUaEw5nRPk8x/n7GK1KMIRIjstRBy1rTOWHIH7ogS6TW3JDXNwJQ+MCOnNhuXcY4ouxyH1eYpugb/BZVontEdjlKOrp3GTi15uWEg/jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ed7obwr4; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ed7obwr4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCYw7oT3nW2iHyRgzzfsZ3YBDiiOJlJcLDBrp6+XNKIJKW7Jeo5x0Z2yjeb2E0843S9pF+avBtHcYS+wS+XKTA+4qc3gybP3ocHBM/xPqvg8xhlLTEHtMNrAcPk7a33xe/txyLpPC0fWLdaVjz+Es4bKwqgLGa5Oqal3RGqSA11C0EOcZspXJw/5OKwJbs7HOoKZ2HwlcReIpytboGKZPOoBNwbW33kqHPqlnUhMzsVhd5hFBhM82SAiOnZEY794qRkIqVpvLA6fE/Fghnu+R1y34xjvmSj/3X6hnbGDqDXq0YAjbjnuDD8bECR/bc1C6kzK2N2CoybWYKYfmY0IVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERARyNQzvISrQXkBnJnzxwwIIrVY4UcdUudFM0hz6OM=;
 b=q4346aSnWxj079NV3eUVdATQlNXB8uVtAJR9i0ozrtELXsEtZpES3iJqlVhqD+x0p6yQvAOvf0k5/VSW2aS1+0qDcm73e0+LokRzV6fT48x8Kg23VdVJ8gn2HEBheVWaFxHPRPaY8M0lvx9y+hsMEGKVfEhGlF9vzT7j8yLpioUPgSB1rrWZXHa74mTFZ41d3A8tHgepRw70xOlJEZKWpd5FXyC1YA/RESy4z3bBZaah6+qoT0uoFgH2nZNYoj0ZaWs4SmgWi6kkhmJBNlpw9Ph469A9s7DAS7tAnHUevrON3ddIDdHdnNo+eCebO0OCUGTN5Giw6EfS1+2emi114A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERARyNQzvISrQXkBnJnzxwwIIrVY4UcdUudFM0hz6OM=;
 b=Ed7obwr4l9yes10sBD54U3lgvUpkEx37NV63Iw1APgoqyNoGVHZdmZrG5Kd9RU49YH0mZXAUoCwxNrw4tQOFwIm4twKzYXXO4a1VtQ2RUJZ2H0hMF1+t8ZaETV9JT7uz9nSpWarWAqyESPSG195dsynvLqdOdRRlZ10c0Fnglnnm9wMkOEqishHr0d1lSBKhiQ1VBWNJxaW1XH4DUap5Uje139awj7kxY3X7IfJjoqteEnG/CW5eKbPEv+ww6HwEVHR35OWc2PEm4fXBzReODoHyGIuOrw7J0Mfh/Vf73/lk5JSWFWgXzyclg1E+z9IsAyQZLQUxqSviIyNZkPSGSQ==
Received: from SJ0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:2c0::14)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 07:03:26 +0000
Received: from BY1PEPF0002695C.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::86) by SJ0PR13CA0009.outlook.office365.com
 (2603:10b6:a03:2c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 5
 Oct 2026 07:03:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0002695C.mail.protection.outlook.com (10.167.244.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 07:03:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:03:05 -0700
Received: from NV-9TMPJL3.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 00:02:59 -0700
From: Ankit Agrawal <ankita@nvidia.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <jgg@nvidia.com>,
	<aneesh.kumar@kernel.org>, <aik@amd.com>, <yilun.xu@linux.intel.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <icheng@nvidia.com>,
	<bhelgaas@google.com>, <smadhavan@nvidia.com>, <ankita@nvidia.com>,
	<ilpo.jarvinen@linux.intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-coco@lists.linux.dev>
Subject: [RFC PATCH 0/4] PCI/TSM: Resolve TDISP coherent (CXL) ranges from precommitted HDM decoders
Date: Mon, 5 Oct 2026 09:02:48 +0200
Message-ID: <20261005070252.84810-1-ankita@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695C:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b9dd94-ab5c-461d-6dbc-08df22aec093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|7416014|23010399003|10067099003|56012099006|3023799007|11063799006|6133799003|5023799004|18002099003|10063799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	EpSWrUaX2mRd+RGzjetuXVeqzPKFY5yvQK8a513qPxDNpzLgVmk35NL4NiwYmAnxvKTNiklwpZoWDGqVaO8XnjXJoT2NA+VZYOwld2Dn3tTNh9MEXCJSZg7yyGziTI1Nej6maw6MnLp7b7ZgjuqsulWGUCfLM5jaUS8oh0ZIFDHTyBAt1+dRpzYRPUZ0vqO69NQuOxqkYMZ8r0zLFUxcTOiTqhI3PvjauulZAWrNmrNUvjThUDpEyjch5WW0nXsRVn1NOVc65SSI7QKvyKYnUZcLe5PJ1rN16QqsgxS+ZojdxZOFiSHz6wnhLgcuCIS8029y/qSuZYN+vibDzqb7JHAckhOnJZcOXe0e0Rk/3jkkMxr2pyRGOrjlh93un3Klvssk8UQxBbtQgudqlwIuR6pnLQSEZ7DUumvF59sxpUqa+TgegBWSLvkLIYHixKmBhmBc8J2To2Ct8VZB4qw7MsfIsucaZNMM+/9Z4DXJX5ptLbdz/kH5pObjBG6Q/OLM1YcwIvs9FUhTp1cWOBthntmM9LblzCju4scFmBbwftsVw/OxH7i8hLllDu6F+389nJEqUeoSa0EngHKMdNr3/mHCsORU3jgHtPaEiFN3vHt5wFbtstVAnrIqP+zVVNLm+DHuDZntjucfIc4N+mbdrGaI5mLxtcA4Y/SmYcgFvtBc3jY2mLmo1rdsPaLHEEXbIUt1UP+jOz8EuwX5pKS7cA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(7416014)(23010399003)(10067099003)(56012099006)(3023799007)(11063799006)(6133799003)(5023799004)(18002099003)(10063799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8Al/SFUSJSHUypZ8mXfGm8ljMIRBP1y6AmVENDc3kli6iuAaQKg5xooIzAbhef9LtGwskLeQdfs17CfW4ZNV3wrq5Qn/tygSumfZJSa49VNaY+3ysJiik5F/l2o1h/smAeUoRla4ZlKCtYK0PRmDbEvw5Bi6Qobtg4nE1lJ+TGpyCqnxvOC3Fcg7xuZNhtBAK9Ka7XPL93oTyqp0Z2xBVWvIM07x+0/VUKFaAXztbjzWaR9IsMKyOx7qGW9xaWJw/CTSzRSFeZddkZ12F+oUKNROD3y5aVJS7oU5EMv8jnRIBoCyZdBr93DaimIs+2OeNv/hFcnevtsZM7AbxnCt1U79NP+TYyX9OHHjuxapXyqcMKdwWIzilw6CiJl1STMBs3zpLhLF6cF8y6XK2j4nTXf9FvtW1mJ6yL4P1sCZcUB8CgmSI4mEz0YRFIhAEhqc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 07:03:25.9197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b9dd94-ab5c-461d-6dbc-08df22aec093
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002695C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416

=== Background ===

TDISP (TEE Device Interface Security Protocol) lets a Confidential
Compute Architecture (CCA) guest establish a trusted, encrypted MMIO
mapping to an assigned PCI device. The device's TSM (TEE Security
Manager) reports the device interface's MMIO layout back to the guest
via a GET_DEVICE_INTERFACE_REPORT response. The guest kernel should
parse this report and get the IPA for the regions present in the report.
This is required to validate the device regions.

CXL (Compute Express Link) runs over the PCIe physical/electrical
layer but adds protocols beyond plain PCIe config/MMIO access. The
one relevant here is CXL.mem on Type-2 CXL devices, which lets a
device expose device-attached memory (e.g. HBM on a GPU) to the
host as regular cacheable, coherent system memory (called CXL region
in this series).

A CXL type 2 device exposes this CXL region through one or more HDM
(Host-managed Device Memory) decoders - hardware on the device that
maps a System Physical Address (SPA) range, as seen by the host/guest,
to the corresponding Device Physical Address (DPA) range on the device's
own memory. The host (or VMM/firmware) programs an HDM decoder's SPA
(IPA) base and size, then "commits" it - after which reads/writes into
that range are transparently steered by the decoder to the device's
memory. This is conceptually similar to a BAR, as both are ways of
mapping device resources into a physical address range that software
can access. However, while a BAR is discovered and sized generically
via PCI config space, an HDM decoder's mapping is CXL-specific and is
not visible in config space or backed by any BAR.

On the systems this series targets, the HDM decoder for the coherent
window is "precommitted": platform firmware programs and locks it
before any software - including the guest OS - ever runs, and the
mapping is fixed and stable across boots (i.e. the guest never needs
to program or resize it itself - it only needs to know where the
firmware already put it). Because this window has no BAR, the TDISP
interface report describes it with a special sentinel range ID
instead of a BAR number.

=== What this series does ===

This series does two things: it first introduces the interface-report
parsing infrastructure itself, adapted from out-of-tree work [1]
originally developed by Dan Williams and Aneesh Kumar and built around
the common BAR-based case, and then extends that same infrastructure
to also understand firmware-precommitted CXL coherent ranges which
cannot be expressed as a BAR. Concretely, in four steps:

 1. "PCI/TSM: Create MMIO descriptors via TDISP Report"
    Introduces the report-parsing infrastructure itself. Only BAR-relative
    ranges are handled at this point. Cherry-picked and adapted from
    Dan Williams' posted series [1] (based on Aneesh Kumar K.V [2],
    co-developed with Xu Yilun), with the evidence-store dependency
    removed.

 2. "PCI/CXL: Populate and insert/remove pdev->coh_resource[]"
    Snapshots the precommitted HDM decoder's SPA base/size into a new
    pdev->coh_resource[] array early during CXL enumeration and
    inserts/removes each entry into/from iomem_resource so the range
    is reserved like any other device resource, giving later patches
    a known-good source of truth for the coherent window.

 3. "PCI/TSM: Derive the coherent-range IPA from CXL"
    Extends the patch 1 parser to recognize the coherent-range
    sentinel range ID (0xffff) and resolve its address from
    pdev->coh_resource[] instead of a BAR offset.

 4. "PCI/TSM: Support multiple coherent ranges via coh_idx"
    Generalizes the spec defined single 0xffff sentinel to a small
    index space so devices with multiple HDM decoders can report
    several coherent windows, indexing into pdev->coh_resource[].

=== Dependencies ===

This series is rebased on top of next-20261002, and requires Srirangan
Madhavan's v14 "CXL HDM decoder state caching across PCI reset" series [4]
that is also undergoing review.

=== Open design questions ===

 - Patch 2 adds pdev->coh_resource[PCI_CXL_MAX_COHERENT_RANGES] (10
   struct resource entries, ~640 bytes) unconditionally to struct
   pci_dev under CONFIG_CXL_RESET regardless of whether a given
   device is actually CXL-capable. Feedback is welcome on whether
   this should instead be allocated dynamically.

=== Testing ===

This series has been verified using an adapted version of Dan
Williams' devsec tool [3], modified to exercise the coherent-range
reporting path added here.

Link: https://lore.kernel.org/all/20260705220819.2472765-15-djbw@kernel.org/ [1]
Link: https://lore.kernel.org/linux-coco/20251117140007.122062-8-aneesh.kumar@kernel.org/ [2]
Link: https://github.com/ankita-nv/linux/tree/next-20261002-tsm-cxl-devsec-0410-2026 [3]
Link: https://lore.kernel.org/all/20261001092227.3004747-1-smadhavan@nvidia.com/ [4]

Ankit Agrawal (4):
  PCI/TSM: Create MMIO descriptors via TDISP Report
  PCI/CXL: Populate and insert/remove pdev->coh_resource[]
  PCI/TSM: Derive the coherent-range IPA from CXL
  PCI/TSM: Support multiple coherent ranges via coh_idx

 drivers/cxl/core/resource.c |  52 ++++-
 drivers/pci/tsm.c           | 370 ++++++++++++++++++++++++++++++++++++
 include/linux/ioport.h      |   2 +
 include/linux/pci-tsm.h     |  37 ++++
 include/linux/pci.h         |  14 ++
 kernel/resource.c           |   8 +
 6 files changed, 482 insertions(+), 1 deletion(-)

-- 
2.43.0

