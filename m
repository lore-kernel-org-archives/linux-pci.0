Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E47492513;
	Tue,  4 Aug 2026 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871815; cv=fail; b=On2G41f0i1qI1duum7jzUhiwRw8mIpEzbLopHjhGxXuuiRi//3n58u7skPg+H8hkyexBb+gj07tV63JQdbM+U3X+c4nXs5aHqnj1dTuRzdEwvSnbeTmo1eExFoGPRduKkhwz7vY6lfBKdl3M9cO7SXldUjMiIcvfZaO5xLSmZTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871815; c=relaxed/simple;
	bh=xo+F+/f9FbaLPE16YjMxfVL+R+Awt6xVJTNHARpg7JY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eEnMvNR6fHo2Tj9ojfIbbSKA547wsS4wwFR3k2XTbjiRCVQI1kz/3tAPcWh1cJdSR4kswqGLQW36dStCwS3L+KxunM34R+hb+ab/hXvyIkwuOlJRekeCIBaKXD8DzPVmk40dkfYMWdvcOwyO3tbluvsayvoQ/YZP33cYcjjmk/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GqxeEN5i; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GqxeEN5i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEcygEVOgzE4H7t7h6c/tu37qs9/LMYTnTqb72rrFk6aNHWz5TZTymmU1iEml5OUbPm1LMvZj+g5pDPbC6scRn3H6aSLUWfpvGeg6hfFsllseDzmjgcMIvWU8U1606fwQVT1X48K2wNhAcCgRW1xD1isAqDldWHVq1lmxz7lCrZYC41/jXpeeOH0gx/xFYJhe/ttMtanvDyBfz9kdh4EtGAvU2wG/Us2Nr1CzQdP8tO2nsUggapqEfRlkc0ngOj2vE0WNmOHCXm96YbS4iXpqCxXnXA6cU3pA5wKiSKSZhlHPI1NB0PZ2avwLQ7X4/NGLv00i3+pHXcbrxO+gtQbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L28ZgQcqQDniM/lAboqbOPsP0CWWTB0dKrelGKVLn4I=;
 b=pz1mKuc84pdLguNSEr/yxMVNBOZHjgVNBI4in+4Atr1UpzZDQKOs0m7MRn+ZQ8MT2m26WNPMsjNXOQzUy+0O86ckxrdeJ7b0VLRCEhLvUK33/1514x7zumEXTrh2kaI/ty45STqN340keFCT45KMq+OewJJbnZjCTdyo4AJpwaJOezhnindsNXIr7wLcVINeixVNjjgH98jfxFAoCW5HdBQdQAcV55YGTqaeILR7XoWZCEPkaMZe7bEA2uDqkCDverHgMEm3qznDWnqijUPQufre8VamxuRyo48EjlqNJh/UT+MHlfkzI6Ioy19W/1c7ERJBf8mkZPAwhRbXnGypkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L28ZgQcqQDniM/lAboqbOPsP0CWWTB0dKrelGKVLn4I=;
 b=GqxeEN5ikobWhs9K9xlW0KOYTFJvxtR6LHFT4a4PFch7RjR4UJTVG7u6LAT49VQVElalJxR65UShVj7zvoszZGV/LjrI6mecl72IwuMI9EDUIp8keySjVECwQgplCI/fc/7wp5EAm9KSYNGkFde6QkV4dS7ha87UKTtF9FSRL6k+fEzV8qIomrXC/IEoex4V9orl61K/1A3+saTWdWWxRWCcXif2SVRK5bap1q2qgD+tvpTzCawjB9QwJar3gTa/0u74TBnqezI1Zf+BaV4R0dzagraxZkRBeMfs08+IRlwxXIa+GTKnIhbMnrHc1CBW+SrMaOK8F45AVnWlI9QeLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 19:30:06 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:06 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v10 00/12] PCI/CXL: Add CXL reset support for Type 2 devices
Date: Tue,  4 Aug 2026 19:29:46 +0000
Message-ID: <20260804192958.1823952-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::14) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: e91adf33-e80c-4dd0-ab7e-08def25ec9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|5023799004|11063799006|6133799003|3023799007|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	6jXaVW2fVqTTigRtpDd3ZEKXfiIgLBFUa3f8D4utxruQ5XayxtcEejsQS90IgLMlDudZJmfIxQeXbAztF03wdOvPsnmYI8hUAJkm8vXpASXRWYRQewHsbsfm0FOxMW3747JA/HynFAH0nXQ613QUmItR987Wt7HTRghYJuKOJLRp7ceHcYzhn7DqwbMui7HLn4A7IvsucXA0guWcBNqFah5Uta4c+P4HHg0KZMZ6w3n9pnPlhQ4c7/B6kzF9n7bqsKc5x43ykGlfGeUqK7klNx77nDN9fOmEdtXBYIEw7k0gyeUJCR8+CSHrVmHbyzjb3Ep3cfy9NgGs+dAimnB0AcP7Pb08ueyBo5vcmTIhj4ucyR4kw7drsOF8uMw1jPlXTzlUuYzMdCyRtdQVRGSnXeCp6o6jMtQHQpxc5hhVtR2sXB5/iSRPWj24XIcITjHhX4Tzx2XTZGuTEDBMxieTSZmLXp274JOUTDeAGUIQ9ULywWPizT2ipXLZNxWP97xpNv1KXHJ4HIAd1mXNsVE3BH6au9JEU+jGmcMNp0tBdjR6q9Dk2l4zeHeH0AAgcToWwDH6nOZnir312DtZZpJ07SsTrw0vbRwJfzh7I49bAVzOyS43w8PRNb2q/f44IbTZBvQeGfEEFsccnJg1hm7fJrlkIFLyDMfc4u80UCtHK7CDSUqTpD3XCLJnzv5JnrfA3aYlVffVFI4UTe/A3rL92Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003)(3023799007)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xcvSWd28B3ha0oTO4/NDzWWBbmHC1Zi2UL8a03g2SFWoZUNT32gCW1qwp6AO?=
 =?us-ascii?Q?cDCTM4QSWpwspheO0TkSFOKmH7Hd/omiIrqOZvkY/wke33f/BxAXclhwBTRj?=
 =?us-ascii?Q?bla6x4LClR4E1Ebk/MN1hxKy9JTkszgay0Kez+36yIRGOLyROpQ5be/nYZuI?=
 =?us-ascii?Q?XGnYnBsV6i9CXqDbNGlN2z0Rr86HMwVib/8B67DVTiO6GMgOlDMd/D5cRxOx?=
 =?us-ascii?Q?kAK86YNlhpUfy+MIlPpYOJtQoQF9qKJU1bPyOSvn17x0WeqvsSdx2gVbt9V5?=
 =?us-ascii?Q?aMPr+Sd7UfRUt/113KpdAs+Rmc6kYAonBosQVpDs8k2AxTuDXKZOgUQi5doE?=
 =?us-ascii?Q?0oeKFbhSVRs4cOEgZrgbks1ggI+AmAfZCCCEyu4oPNwoQjlpajg80FPTwYjX?=
 =?us-ascii?Q?8DDNeEqpoJnJVlTahz8KXBr6G4Eby2pat8C8mYxEx3Yz3jPMLi7LJmK9NW48?=
 =?us-ascii?Q?nQfNJp0XZxZGe8d7RTKLp63p8Khq1KkyKu2bfirA5KOL70xGenkxAnKB4OWy?=
 =?us-ascii?Q?ALVgtHX2unOoiqxG97ZQ8UD4mNpi6ZsycfnTLlFi3TugtGZeiIp8PLIbE/NI?=
 =?us-ascii?Q?wlRZyS4iTnWkjwGgaahlgyoGJaOk1mOCwVun5c5cY+3mfTt84zvuj1PEewRC?=
 =?us-ascii?Q?eW8dRozb2s8U/MKq6xtaLJy9UUAgWWMSWx2cVTzgwYfYgY184YzThGJpD+rE?=
 =?us-ascii?Q?wIFaazAmzC8cuA18xzpIp0P5hGJ2Rgtb00cRzf0IHou+3ZuCH6tExuN25j6a?=
 =?us-ascii?Q?uPuvteh9XJ8BSqD+LBCDsdzgwSX9OtleBtbacVsxyV2h3Op8L3k1NcPHe2Gb?=
 =?us-ascii?Q?n2VnRByYTaAFmretvmdSeu5Secc+IdMi6nI13au1D5qzHYRBGFJesuPaJXiG?=
 =?us-ascii?Q?3uetboZIoY/dQ0E3XByBfAbhALmN/n4gYyhytjTLITtI3Gb6gSjocNpCuZZ7?=
 =?us-ascii?Q?tb0Z4SXU2tMe7x3KcyMtoE5MZlukqUBDH8dM78lKEVHQnfhU8O8MCdPYubaw?=
 =?us-ascii?Q?rd/1TS2PF+MfFftn9UgdayVzwhmVRS+9iixTCir4GZIYxw4a+KgH9iyiwCWq?=
 =?us-ascii?Q?lRkMR8xTeifZg1nCeZ+0RNcJL8nHNZdoJCxjMur9C73QuEMFkpXoQ/m9rsvO?=
 =?us-ascii?Q?Nfrc+9vWiUtL7Ho+vUtQTNflk8+1MbkPhPAsEazTZLmdomVyWRQeWbAI/uQD?=
 =?us-ascii?Q?NWC9ruHKXGzZZhi2WZa798XNcWK2N2Eqpq4y1aIt9elaes++TeMWatE0Dwxw?=
 =?us-ascii?Q?kcs7aYUdJ08l7c4f3G9ylxsmdVEVH81a/n+em+d+RF6FFmv3bOTTb4taIbka?=
 =?us-ascii?Q?KTfiIpDPaFAyMT46Uuk2RUnuWzTN8lAf7mXtIFFAn3tW9+g1xriyZSJ7crOg?=
 =?us-ascii?Q?7xKfFeEHIOHcfWUP7w9lkGv3CQh7f55MHxPyKgey0P8DklmixOq0rFcHQgxC?=
 =?us-ascii?Q?8raPvaCOpFNtRNQVKNx3c6Rk20kWTAxD0LUbkMJ/5sBOJ3oazBbcW+BQPpp6?=
 =?us-ascii?Q?SQCe0HNXyAP6b+14R7w3kEsZFimn9YRLsW+LXwDHVg5kL8gI/C3j0zG5deP5?=
 =?us-ascii?Q?+x1M9SRw4OndAlCUJEcj3gKhkjOy9ZM8XvrAyFZwoCytSoVJpf5VOCRih9km?=
 =?us-ascii?Q?NjD1lEjQzSRi83OV9RhJCrPgWwy6gVmt11IN1HxcCURYtpMVeSvG+zFPCex9?=
 =?us-ascii?Q?xwhdw4g1+tZAz7ySa/j8P9YtqoyBS/Yz0mTnO0bn2oqYYkulI0jqLARPFTK3?=
 =?us-ascii?Q?yP5PrcPr9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91adf33-e80c-4dd0-ab7e-08def25ec9bd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:06.0837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngcQebcMAkLiSwXZBw7VzhSCasd7xMT9BQ8Sv35qKKA3d/keqV104QDKYjIpAxniNmKBiuo3wmZFfzJlktJdcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

Hi folks!

This series adds CXL Reset support for CXL Type 2 devices through the
existing PCI reset_method ABI. The reset sequence follows the CXL 4.0
specification [1], including CXL.cache disable, optional cache
writeback, CXL Reset initiation, ResetComplete polling, and ResetError
reporting.

The userspace ABI is the existing PCI reset interface:

    /sys/bus/pci/devices/.../reset_method
    /sys/bus/pci/devices/.../reset

Userspace can select "cxl_reset" in reset_method and then trigger reset
through the existing reset attribute.

Following Dan's v6 feedback, this replaces the proposed memdev sysfs ABI
with the existing PCI reset_method interface.

v10 changes from v9 [2]:
- Address review comments deferred from v9.
- Split HDM decoder helper refactoring into smaller reviewable patches.
- Rename the built-in CXL helper file to resource.c and keep reset-specific
  logic separate from the decoder programming refactor.
- Add a helper to resolve a CXL port's upstream PCI device.
- Fix tools/testing/cxl Kbuild coverage for resource.o.
- Keep early HDM decoder parsing shared with normal CXL HDM enumeration.
- Gate CXL Reset execution on cached HDM state and current CXL.cache/CXL.mem
  enablement.
- Reject CXL Reset on multifunction devices to avoid reset scope ambiguity.
- Order CXL cache disable/writeback before PCI reset quiesce and IOMMU reset
  preparation.
- Restore cached HDM state without replaying transient commit/error/lock
  control bits.
- Update ABI documentation to match the implemented reset ordering and CPU
  cache invalidation behavior.

v9 changes from v8 [3]:
- Rebase the series onto v7.2-rc2 so it applies cleanly on a Linus rc
  tag.
- Include the cxl_bus HDM restore add-on as patch 11/11 so b4 orders it
  after the main CXL reset series.
- Address only patch application issues in v9 to gather feedback on the
  current direction. Other review comments, including Dave's code
  structure/readability feedback, are deferred to v10.

v8 changes from v7 [4]:
- Drop the PCI helper export patch.
- Drop the multi-function sibling coordination patch. cxl_reset is only
  exposed as a function-scoped reset method when the CXL reset scope is
  limited to the target function.
- Keep the reset-scope discovery needed to reject non-function-scoped
  CXL resets.
- Cache HDM location as BAR-relative metadata instead of keeping an
  enum-time MMIO mapping.
- Restore HDM through a temporary mapping based on the current BAR
  assignment after PCI config state is restored.
- Cache raw HDM decoder register state so uncommitted decoders can be
  restored as uncommitted, while committed decoders are recommitted
  through the normal HDM commit flow.
- Share HDM decoder decode and validation between normal CXL core
  enumeration and early PCI HDM caching.
- Put cxl_reset ahead of FLR in reset_method priority because FLR does
  not reset CXL.cache or CXL.mem protocol state.

Motivation:
-----------
- Type 2 devices need a CXL-specific reset mechanism beyond existing PCI
  reset methods.

- FLR does not reset CXL.cache or CXL.mem protocol state. CXL Reset is
  the architectural reset mechanism for those protocols.

- The PCI reset_method ABI lets userspace select this narrower CXL reset
  before falling back to broader bus reset methods.

Change Description:
-------------------

Patch 1: cxl: Move HDM decoder programming helpers
- Move low-level HDM decoder programming helpers into resource.c.
- Keep the movement mechanical so later patches can change the interface
  separately.

Patch 2: cxl: Pass decoder settings to HDM commit helpers
- Introduce a decoder settings snapshot for HDM commit programming.
- Route decoder commit through helpers that can be reused by reset restore.

Patch 3: cxl: Share HDM decoder decode logic
- Add a small helper to resolve a CXL port's upstream PCI device.
- Share HDM decoder decode and validation between normal CXL core
  enumeration and early PCI HDM cache setup.

Patch 4: cxl: Cache decoder settings on PCI devices
- Cache CXL core HDM decoder settings in pci_dev->hdm.
- Refresh the cache as decoders are enumerated, committed, or reset.

Patch 5: cxl: Cache endpoint decoder settings during PCI enumeration
- Snapshot endpoint HDM state during PCI enumeration.
- Cache the HDM register locator as BAR-relative metadata.
- Cache raw decoder register state in addition to committed decoder
  settings.

Patch 6: cxl: Add CXL Device Reset helper
- Add the internal DVSEC reset sequence.
- Disable CXL.cache, perform cache writeback where supported, initiate
  CXL Reset, and wait for completion.

Patch 7: cxl: Validate HDM ranges before CXL reset
- Collect enabled cached HDM ranges.
- Reject reset if affected ranges are busy.
- Invalidate CPU caches when runtime cache-invalidation support is
  available, otherwise continue after warning.

Patch 8: PCI/CXL: Reject CXL Reset on multifunction devices
- Reject CXL Reset for multifunction devices to avoid reset scope ambiguity.

Patch 9: cxl: Restore CXL HDM state after PCI reset
- Restore cached global and per-decoder HDM state after reset.
- Re-map HDM registers from the current BAR assignment during restore.
- Replay raw decoder state for uncommitted decoders and recommit
  decoders that were committed before reset.

Patch 10: PCI/CXL: Expose CXL Reset as a PCI reset method
- Add "cxl_reset" to the PCI reset-method table for Type 2 reset-capable
  CXL devices.
- Prioritize cxl_reset ahead of FLR.

Patch 11: Documentation/ABI: Document CXL Reset PCI reset method
- Document the new reset_method value and reset behavior.

Patch 12: PCI/CXL: Restore HDM state after CXL bus reset
- Restore cached CXL HDM decoder state after cxl_bus reset.

The CPU cache invalidation step depends on
cpu_cache_invalidate_memregion() support for the affected address ranges.
If no runtime provider is available, the kernel emits a warning and
continues after the affected HDM ranges have been reserved.

Example:

    echo cxl_reset > /sys/bus/pci/devices/0000:bb:dd.f/reset_method
    echo 1 > /sys/bus/pci/devices/0000:bb:dd.f/reset

Testing:
- Ran 100 iterations of cxl_reset through the PCI reset sysfs ABI on a
  CXL Type 2 device. All iterations completed successfully and
  ResetComplete was observed.
- Exercised cxl_bus reset separately with the HDM restore add-on patch.
- Built drivers/cxl/core/resource.o and drivers/pci/pci.o during v10
  preparation.

References:
[1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
[2] https://lore.kernel.org/linux-cxl/20260709010304.680422-1-smadhavan@nvidia.com/
[3] https://lore.kernel.org/linux-cxl/20260703220508.546528-1-smadhavan@nvidia.com/
[4] https://lore.kernel.org/linux-cxl/20260623032453.3404772-1-smadhavan@nvidia.com/

Srirangan Madhavan (12):
  cxl: Move HDM decoder programming helpers
  cxl: Pass decoder settings to HDM commit helpers
  cxl: Share HDM decoder decode logic
  cxl: Cache decoder settings on PCI devices
  cxl: Cache endpoint decoder settings during PCI enumeration
  cxl: Add CXL Device Reset helper
  cxl: Validate HDM ranges before CXL reset
  PCI/CXL: Reject CXL Reset on multifunction devices
  cxl: Restore CXL HDM state after PCI reset
  PCI/CXL: Expose CXL Reset as a PCI reset method
  Documentation/ABI: Document CXL Reset PCI reset method
  PCI/CXL: Restore HDM state after CXL bus reset

 Documentation/ABI/testing/sysfs-bus-pci |   16 +
 drivers/cxl/Kconfig                     |    4 +
 drivers/cxl/core/Makefile               |    2 +-
 drivers/cxl/core/core.h                 |    7 +
 drivers/cxl/core/hdm.c                  |  351 +++---
 drivers/cxl/core/port.c                 |   19 +
 drivers/cxl/core/regs.c                 |    4 +
 drivers/cxl/core/resource.c             | 1341 +++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   41 -
 drivers/pci/bus.c                       |    2 +
 drivers/pci/pci.c                       |    8 +
 drivers/pci/probe.c                     |    2 +
 include/cxl/cxl.h                       |  116 +-
 include/linux/pci.h                     |    8 +-
 include/uapi/linux/pci_regs.h           |   14 +
 tools/testing/cxl/Kbuild                |    2 +-
 16 files changed, 1727 insertions(+), 210 deletions(-)
 create mode 100644 drivers/cxl/core/resource.c


base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.43.0

