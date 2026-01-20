Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FD3AEF3D;
	Tue, 20 Jan 2026 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948013; cv=fail; b=nu7h8pUUXzNsR7ojDfsIgBXAvqGMozcb+XgcnGChkx50BBjhnIIett/ttAL6ul+qWpbIeYiFWifNAjHmZESf25mG9e9HZquOpuGmm8Gzv+pEA0UZBgxD24H400On23gOnEJ2OBjSl8lqFKQozYTtngbdrqccNIKP3N9JqwY1JoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948013; c=relaxed/simple;
	bh=/1tU2p2EBx+ETmfRT4ogsTVZQN2DOZSZCYAHVs9+m30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c7b/nXbsmRd/OQKgNA/GDnARwaMaY9/9iZOsGndAop2f13/mKfvYPOnVWSL/98XyfPM13WS+cGFOAX8CoeDe52b+Q9fhA6k1dK3tKEcsbJIox7A/xFLL/C+8wmLT59QsfUIqJanAyKDkuaE3IoRxHWEceILTIS+d63cEJBNmO+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KEcPBSS2; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KEcPBSS2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDS9JAYjIESzUtVNZ74YLV20bkLqB2ee74SWUVwrNXMleHaEfhFj75at22CidTxS4nxDiWeoqowuW2249BnCOs2FdKcbEfdrQkwY40O4iMPH5g9/qW/kPOBY1gbEO9oWqtMpMDemfLrHBWY4pQXMYUrkDyhvWPolT2VF60fyx1wOyeAmRRPiutQBBJqkz9QifApVEdFNLsJg8gUOlCm4wlsUJ4rjk+DSdFEcd4+llz8cjDbToquQmoDWI4KYuVqM+j5olt5TBrL44E7/EVfZVWgk1ar+qiFNFfb3jeVNOLpq1yqwa3q6/bbZ0TNC9w2uxCDrJGLeDU42gfzaic0m7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/SwtUYOTAagxk01floqj8sybIs78INf4LZfZUEjukE=;
 b=ReWKWFPeSEqM2ZMrjBX2LuOZaYvF8XuKUnypwy4Pv50pI15uw93tp3ZozRvEcqhunP5UHGGmvLQXt3nbaZB1LHnCsh/jH2yKlp8O/MJChvEr/O6wz54+BDmhjWRXRIVVqzg2cAavDpAZ1GqiyqiQwt/xuR+7i1f34hhp3v4Vfz5HwPN/6AXFrxJ/+k7T2pJXQu0EN0u/kOEyo5+AYwWs90JzrftBk63AsH0+XALRfzKiWgvJ77bILlB1/dKB8f6xhL4llb+njvN60RLBXpdxVBO8k4jxQ2iJVA+CgoMC9LCESuqzd2U+BMe293Q7UHs2QMH1AI9mvm7jTYDUJ/pmAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/SwtUYOTAagxk01floqj8sybIs78INf4LZfZUEjukE=;
 b=KEcPBSS2kH7zHKjb+ujEbqao0JBcmeKIqQzNIc49PITP7eR6dMHe2aAP/YX5EgVGAzMaD0sUp6cHrN4ewLCHuyEjQHX4MmHp8awctR36PKu5jR3OgWvi1lA7AzGNdp35qLXwc6DyVb6ud8DZBFH+50/iT6W2G2btsTI0UIhUxJew1hzMDQc1eGQ23pc54i4av5oL5O6JcSXjWzPjtGg+PcbHS/ACcXRJ6ad2hxloQkOj1rN8zCf99CENlYjOWczSqQlo2BoWua3/888P/UmoTCdToXDGZT+j1DnutBtBAOT+4qbqKvMWcbr+btbQ+K+5JVQL46DClss+9LtFEzpHpA==
Received: from SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) by CY1PR12MB9675.namprd12.prod.outlook.com
 (2603:10b6:930:105::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 22:26:37 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::e4) by SN6PR2101CA0001.outlook.office365.com
 (2603:10b6:805:106::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.2 via Frontend Transport; Tue,
 20 Jan 2026 22:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 22:26:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:16 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:15 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 20 Jan 2026 14:26:14 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v4 0/10] CXL Reset support for Type 2 devices
Date: Tue, 20 Jan 2026 22:26:00 +0000
Message-ID: <20260120222610.2227109-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CY1PR12MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f914ce-3021-4d62-e109-08de5872f99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?auMVkVeN3A7gbhWiVO3XCdmxXy6tk7aNL5v75watGwf0o9yAned1CHYDiwjN?=
 =?us-ascii?Q?aWuqzZP3J61Umh9FyfEDR3/WaklH3wTziZSp3ZSdx1+C2gK8e0WQRUD67++v?=
 =?us-ascii?Q?6eKc4c6rBlbUNSgzolZndoHypaARvWN6dPG3zMVwAyCBA5WxNDxAab6YqETC?=
 =?us-ascii?Q?rDm17L8RleoHCaZVIlL26bmLYqMeQI4ewXw73cK5o2GjusLq3wxqGhM4mYNw?=
 =?us-ascii?Q?1+DiHdCocv5ujvXlT38tokY0rDa/t+Hoss0UsF5SzGst6m8ae5nOwYlK+wT8?=
 =?us-ascii?Q?Z4qWuydfVEILid4tmb+Oxo8zxjN36jD8vTlyiGx/DeJHLKt9SE3hGQBF/jUt?=
 =?us-ascii?Q?cg+CIjVhaxtUn4xZ4uZhXcgGtYG+1xtF8E9CxvlVOcS4w3aZpUZQZVCwQV6q?=
 =?us-ascii?Q?HciIBOhQq6XSHVAJBsttUtZNGON8bS6Ogb+zK98DmtsNdZ2xC0rWcobTlu7O?=
 =?us-ascii?Q?RN+jgWJuTRkRtBu4/S0nlmW6Gu5k33MdG0HX517qF86A3pGv6+1bHpRYjXfz?=
 =?us-ascii?Q?Tm06AE5iX1rBMT+zpzLkviuogPbh7Dhg4ekao1MfgZ+2bEM3u6zxuG2oxUyN?=
 =?us-ascii?Q?qDdRUmIxYvL/J/dVQF2KeyqDwTcSpXoMpyadgJ7ufP/x5iUBe4p+6QX1P75T?=
 =?us-ascii?Q?1pxy+0FFZK+bWMtJB9FzmPd72HJw6aKQ2L0Z5eieoWWqFxbk3pnl1eiQt9I9?=
 =?us-ascii?Q?n8GBULp4jAKnerueHAdQIjVWU6tn1+VJwJ11w6ivMt4ZKGSIbWsvKmPJIXt9?=
 =?us-ascii?Q?Os+iOoinVwIPaPpo1bgOWY9FvnRdsFhvvdyLHIGioEiPaiMbdVDgbIHN/PUF?=
 =?us-ascii?Q?t9mWwT1XsMoE0QRJOOPFziVfwgly++2J3/ifxCmIXlRsNlUK1pTEW6hBycjc?=
 =?us-ascii?Q?OPzg2st+Ogpv91K1oMO5GwItZvBkyIc6GC+zAT1o83s8KBx5vXYsREouPf4z?=
 =?us-ascii?Q?d9WET4+TF843zr65IQURIJHtg4e/YfZIvjQ9Vzcl0mw5zN7SGMO6FbbABkVW?=
 =?us-ascii?Q?a3SFVMn0wQsyNjpQw5AmJSawRtVzo600sS5Bo7HGhbvW7xCpnnBU2QxhmuZS?=
 =?us-ascii?Q?WGBcBE+yHtyFVYMh+r9vN+d2o49J84YUkQWcKrL0VEkwbXsxKaxrvP4mSTF3?=
 =?us-ascii?Q?9qvX0hEz60MGG83sRB5PA43gOzd+JrW810T6ZtJdwt/3qsnD5a9hWko+NXe3?=
 =?us-ascii?Q?ECZ4N/aMk9EcUMKa2k116XZHeRbPne1A4xi32ye9Jl2/9AEFCrigWzPD3RKI?=
 =?us-ascii?Q?3EvkNZSP/1YHob1YOhe7B92yg6HOI7U8u2rz5FLRCT4puHz3whwf8PXoJUUl?=
 =?us-ascii?Q?pVz8lHxoQVANHaR95gyNONAIANtt/o0r8uOyIfJ8Lq2G5VfHZHhTS432X3Va?=
 =?us-ascii?Q?aa4v19/IUbZasjs8pGN6fU3UFcQ8eQOJSwWrn5m3YR5pxqdNksFPGzGz+pi7?=
 =?us-ascii?Q?4QcCUIfCb0GqEbKCZVPqd1wQuzJKT/JaNm2P+PHn7n9NxHjQyMnQLTdy5cwj?=
 =?us-ascii?Q?huuTm/OcQqGVNwzQJZKj5YyhKz0d6ta8H85zCMF4YK46B/BjZiOUtHdctvpq?=
 =?us-ascii?Q?Ts3g0hCN18bi4oEqXZSKO2gy+JAP09R6ZtjryD64187YY7M3SK3NO8WDSlZO?=
 =?us-ascii?Q?JaDh+W51fepowTW5NnjWbCRmMUp/8SWI372X1VxsNND/CjobE6x+uM4hR4KE?=
 =?us-ascii?Q?dZsMfEMi46zE9Mw9LpuYx4l/nRI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:26:36.9366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f914ce-3021-4d62-e109-08de5872f99f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675

From: Srirangan Madhavan <smadhavan@nvidia.com>

Hi folks!

This patch series introduces support for the CXL Reset method for CXL
devices, implementing the reset procedure outlined in CXL Spec [1] v3.2,
Sections 9.6 and 9.7.

v4 changes:
- Fix CXL reset capability check parentheses warning
- Gate CXL reset path on CONFIG_CXL_PCI reachability

v3 changes:
- Restrict CXL reset to Type 2 devices only
- Add host and device cache flushing for
    * all sibling functions on multi-function devices
    * all sibling devices in a given region
- Add region teardown and memory online detection before reset
- Add configuration state save/restore (DVSEC, HDM, IDE)
- Split the series by subsystem and functional blocks

v2 changes:
- De-duplicate CXL DVSEC register defines under include/cxl/pci.h
- Fix style-related issues

v1 changes:
- Added cover letter and dropped the RFC

The RFC patches can be found here [2]
v2 patches can be found here [3]

Motivation:
-----------
This change is broadly useful for reasons including but not limited to the
following:

- As support for Type 2 devices [4] is being introduced, more devices will
  require finer-grained reset mechanisms beyond bus-wide reset methods.

- FLR does not affect CXL.cache or CXL.mem protocols, making CXL Reset
  the preferred method in some cases.

- The CXL spec (Sections 7.2.3 Binding and Unbinding, 9.5 FLR) highlights use
  cases like function rebinding and error recovery, where CXL Reset is
  explicitly mentioned.

Change Description:
-------------------

Patch 1: Move CXL DVSEC defines to the CXL PCI header
- Consolidate DVSEC register definitions under include/cxl/pci.h

Patch 2: Switch PCI CXL port DVSEC defines
- Use the shared CXL PCI header in the PCI core

Patch 3: Add Type 2 helper and reset DVSEC bits
- Add helper to identify Type 2 devices
- Define DVSEC reset/cache control bits

Patch 4: Add the CXL reset method in the PCI core
- Implement cxl_reset() method with capability checks and reset sequence
- Restrict to Type 2 devices

Patch 5: Add reset preparation and region teardown
- Implement region validation and teardown before reset
- Add device cache flush for all sibling devices in a given region

Patch 6: Wire CXL reset prepare/cleanup in PCI
- Call CXL reset prepare/cleanup around the core reset flow

Patch 7: Add host CPU cache flush and multi-function support
- Add host CPU cache flush (x86: wbinvd, arm64: dcache_clean_inval_poc)
- Add device cache flush for all sibling functions on multi-function devices

Patch 8: Add DVSEC configuration state save/restore
- Save/restore DVSEC registers (DEVCTL, DEVCTL2) with CONFIG_LOCK handling

Patch 9: Save/restore CXL config around reset
- Save PCI and CXL config before reset and restore afterwards

Patch 10: Add HDM decoder and IDE state save/restore
- Save/restore HDM decoder and IDE register state

The reset sequence: validate device type, check memory offline, tear down
regions, flush host CPU caches, flush device caches (all functions), save
config state, initiate reset, wait for completion, restore config state.

Command line to test the CXL reset on a capable device:
    echo cxl_reset > /sys/bus/pci/devices/<pci_device>/reset_method
    echo 1 > /sys/bus/pci/devices/<pci_device>/reset

[1] https://computeexpresslink.org/cxl-specification/
[2] https://lore.kernel.org/all/20241213074143.374-1-smadhavan@nvidia.com/
[3] https://lore.kernel.org/all/20250221043906.1593189-1-smadhavan@nvidia.com/
[4] https://lore.kernel.org/linux-cxl/20251205115248.772945-1-alejandro.lucero-palau@amd.com/

Srirangan Madhavan (10):
  [PATCH v4 1/10] cxl: move DVSEC defines to cxl pci header
  [PATCH v4 2/10] PCI: switch CXL port DVSEC defines
  [PATCH v4 3/10] cxl: add type 2 helper and reset DVSEC bits
  [PATCH v4 4/10] PCI: add CXL reset method
  [PATCH v4 5/10] cxl: add reset prepare and region teardown
  [PATCH v4 6/10] PCI: wire CXL reset prepare/cleanup
  [PATCH v4 7/10] cxl: add host cache flush and multi-function reset
  [PATCH v4 8/10] cxl: add DVSEC config save/restore
  [PATCH v4 9/10] PCI: save/restore CXL config around reset
  [PATCH v4 10/10] cxl: add HDM decoder and IDE save/restore

 drivers/cxl/core/pci.c        |   1 +
 drivers/cxl/core/regs.c       |   8 +
 drivers/cxl/cxl.h             |   4 +
 drivers/cxl/cxlpci.h          |  53 ---
 drivers/cxl/pci.c             | 621 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c             | 150 +++++++-
 include/cxl/pci.h             | 134 ++++++++
 include/linux/pci.h           |  21 +-
 include/uapi/linux/pci_regs.h |   5 -
 9 files changed, 929 insertions(+), 68 deletions(-)
 create mode 100644 include/cxl/pci.h

--
2.34.1
