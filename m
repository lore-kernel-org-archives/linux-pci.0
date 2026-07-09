Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175B3612FE;
	Thu,  9 Jul 2026 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559015; cv=fail; b=dT5RxPqjI8Ikj7njtPNqJe88XbnHD2LEvFvHb3wez2ew9np5YuP0zdGsLq532bcmrWodFlFp6QBsHJZESTOe0q6vGIZdhBy4jkPZnjE8fLaafKx0nyFc3REB54bxUdjiKn333vQjRFL77wOMbzQte9H3Dqenp2yaoJkytsvXRk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559015; c=relaxed/simple;
	bh=t7Py3lIqI2PgdAuu0V7svEKApgiRm9popUb82sQlddE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ntl/KwadZL1wOpia/eoE0yWX/6LeTHaiZ5DiXrramk6VyXlbOAw4iWDA0N3el615td3sN2U34DVramjkb2kAsQ0e9u5pJ2mBaDFMS+JrQktAqYl5vu/h6SUI8aUEUhfrptHTNaEIakJzgwXBd+A06PMcAZzeV2gGIUq5/r5Q1nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VMAIu8Od; arc=fail smtp.client-ip=52.101.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VMAIu8Od"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIkV8uJxzIjKPPKadREi18NaDO2huoBqOKmDHy9Y52rEtCcA0y7XNsJKtCrBtJt7Mu5EqPXsYvSH6nRq7Tj1mcfRE44akw+7oF8hTAeEH5DE07axfEnZFtTEi0tutMhPq90oi5F9me96B0fJ23JHuvYZBEJVot8RF0vLRCoIaNCrOxX+LHhgaqtRa5IKzKHZgEwbe25ruXeRTccvILNpWn0Wi9BniPC3Uumv+MDURESfDx4o2pYyhsaVvXeR+rYOGRH2IMH1+OZWeIWC/yoR5PChfUZeAiCslshiryNLg5n0ulWVfHC1LCQSiX4SudYQD9lvGNMa1hDqpCeb/iodlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6A+D5kIntHrS4ROIftTTjmil+rdoyK8tygD2s3hgsw=;
 b=QsW9mNvJm7/ikUKE5XwYYk1t2vzJn3ahHgCe38+ZqZWr+7vrLobYYol9jjsu5sXcDzjkMwMKqmLWK6zWdUMXBaVRNSpAfAg5Z+p7bgMGX1zGKJaRQbrGeSHCHdWg8JTBIKCF+fzouTxao+vdUzHDrruwWwIXY37HMfai/DgESyt6yrMh3m+9IUYq92qTl/vWSEa3WgEaFalVGeM239oJsqKUsPWSiCWZ2swmK+3TiJykKIpUmXltNRdeQ3EkHOgmExcIvxDvwV3h0bn771qAIfN26JrZrPaG6uqfFoB3pXgeHE9FyfvigS2lAvIOq4DR83nd6+78BW127QCnNSZMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6A+D5kIntHrS4ROIftTTjmil+rdoyK8tygD2s3hgsw=;
 b=VMAIu8OdmcY4f/ulENtrBfY/lkxZ393oWOkPq6dYiU9VWaWUecR4Zcbn1j/mwl88zyzwCJXMg45SydXEcZDGJvvcAjpXPD7jg0XuHQZAe0IsGYmJt8Sv3pZU634JwQKg1ltwCNxPYUNmH7dYTCaLaAI2z6fUhjpjpGHLBUTg3G7Qy8kkIndLtIirBU0soTAt0kLe82bZl0DjB/28TF0eAswAP7vn7Hd08fAypPlz9B9lGiVTyJxTrLNVdgTxneYYH3D+d2YcdKJuFM9ib26RSfDfzeOKFEGewpRhwullrdXHbQfzY6dhJP8DGillewRjBDsnM0JZyGTHwNzPtthb4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:03:27 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 01:03:26 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v9 00/11] PCI/CXL: Add CXL reset support for Type 2 devices
Date: Thu,  9 Jul 2026 01:02:53 +0000
Message-ID: <20260709010304.680422-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:254::34) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf266d3-f64a-4777-c1f2-08dedd55e1f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|5023799004|56012099006|6133799003|3023799007|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	llUMY20/C9mNfuY6X35x00XQFiblpykzY/UnuJYIDa3V6xGhWqN5rLthqgkh/cOcBYvp7ZByT7brcpqcKw6ZruPcOxdGlyLme2IHh8Ph3SNN7HZnlCJBTZmqdMeMxuTgCHl8rNL8ihVbLMvIim1OZT2i9thOPE5EEw2kw+kCubE6FoES/hMQ5ekr16h5+RoqbK9DndYIYTYqimJbFYOKgVrKO1pPKsHPJTQP3V7Pu+swGm3lVeB9FtWXUpkrwQWyYb6cgG/ljqGnVnyok6GU7yBr6TBJ8zYTL/T3qUvozrKfJzKGZjoV/NyJbSYi+wtLp3CZack3RQ71BbTh14AWBSCuZkihrSXjUKvjvvJHNiarYOoVgOZXiLIV2MngxKUcic+t5xJim3dsjmpRjLw2WOPM7i9h5Jcrj83egODxwv6dZNzog1qDWDdKlRX8QchRqXCNJmBeN3SaTH4U/zuhtwNpO1GT4HyVksWsCeuiujf+NHbE1mDUzD9/4AWt6GRMP720MNudiiLCUigZBlHRyH32e+YLGydHZRIt2n3cXh3HgVjN8ytKF7Hg4bLkywe1v1Sykgx0JwJCZseCvZvEmPx2fVTasJ1tBxvodisLnOsxV7mmpHO4xLN119n9glgztJib1Y2jc5LLDTCYgwBsq2oHXuPIFJGCFrdgMeB1wCfKk/6clt19sgSsXl/WFnWxQg15bUZaVWzYfWOHuzLCfQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(5023799004)(56012099006)(6133799003)(3023799007)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ttu7P4OuzJnhCfPtXTe2evUgsTiIg/10TN43hnVuUvLt8nK4FsI2kjSKPkHc?=
 =?us-ascii?Q?yuDQ5hqXvTJvf1JCi7QkmsmbVv+y1JDiPwYUacgHMx38iNdmzijhkQhxRoqb?=
 =?us-ascii?Q?evW6OGTYBdUc6CZX0SpBEKCVk1o3nqpZdpvPOiQry41gBlelg2I6oFG4hNfi?=
 =?us-ascii?Q?CsxQp/bCzwM95cm2CY1orq9vis40rqx2kd4f4U9NqfVspCleHT0wCgVZpOal?=
 =?us-ascii?Q?dU7g6tWZBObmyXqltcLQJiqxxSQ0PrTygXhfFrAUXer9t4aXxk+46X6NFqEf?=
 =?us-ascii?Q?a8+zCREcIZTaST6cSfJe1hfC59nsTGDNR5sgpw9h4opvrnpcJa6xReB2NrwC?=
 =?us-ascii?Q?YNbc/OB5ffS78UsYktTBLthDd2KFPJnYu9NyVW+ZuLjaPURz4oIcHFfpflkr?=
 =?us-ascii?Q?7XqbaUIl3LmILhiowDgWE6uQRD+FHb23EJPHSnlvLxhXJwVeTG69r1+RBJUe?=
 =?us-ascii?Q?k12NFa/PH9jd0H1CmKA4ts5nCne9GRdZ7kUzDpv0fDgu9gA2kWt9Dq1fbBWg?=
 =?us-ascii?Q?eF/kdIqsXQXPPOeNrFupYyKzLuoMH6ATy0U5j2O4fhstlIjVJmi1m2LwGk7w?=
 =?us-ascii?Q?H/DjTBVw17PmJkKTpWGgvL5SiHpZY+O5s3Eu0GYlhaHaupI7/gKh4x0DpKXj?=
 =?us-ascii?Q?QUbhkFYQE+5prTVcstNdbTB8RwkbUrtGmL38CO8H9CMGV3RaiT/rKWC564V+?=
 =?us-ascii?Q?NMKyIvZntV0HMdyk1hJ2aq9SBfapn5D45u8hEoLnXyX+n6n9O2Ro+AYvKjlK?=
 =?us-ascii?Q?MlKyRkfQVIeLkntDQiRSBsXE/oMwHW08pYMNe34Z9Bei1fsYmHPk6YMk5tGj?=
 =?us-ascii?Q?9AUuDK2+gAOiiGz4p5E4+Tjv7CPjw2U98CTouDeXXA8RaO7xXsTRUtkkR8Xk?=
 =?us-ascii?Q?9FQxeQh6hpHemMnWodTxR2SOT0hcN+WWMvfmlF3tiMozGqF+vd2rJyaYwTUt?=
 =?us-ascii?Q?MZ5n5bZodze5UJGngvIzZ+fT7Ac91WvIMAdGNK6afK8d3QUWIhi1HyRxxiyQ?=
 =?us-ascii?Q?fv3Cn6/HykbdBrpf37mgbwo7W68vuwGm13zuG6AVtM+hwjhNKZhJT4cUoack?=
 =?us-ascii?Q?YNDSnwS0K5PBH7qcQAlvqE/hSrc4FHruiUxdctyyvx/nLEjM4ujOS+YBO5PQ?=
 =?us-ascii?Q?YCAHFihLQwt9tUs0kybTnG5RDEfEcPNan5r4l5XfOcM25Alpxgiydt/zSIjH?=
 =?us-ascii?Q?lq51busAy1Lnq6emPFs5yWx7FDCgCAOycCFZnEI4srLKZK8q9QtRNxsre2Qy?=
 =?us-ascii?Q?f1spMlrbaW5YQTgeh/bL2JCeWCvSmSzJXJxLkzlnHsPG5HoiTYFLdQU2X9nd?=
 =?us-ascii?Q?22Lo7vwqHLW4binlHXF3gBvhOUSYPkQyCEBjBzw2doD28J5oqcNb+LHXjNdx?=
 =?us-ascii?Q?akl9cVSR1Uc5mxTjbqme0U70y1JmWgHk8Dfx/AoQNhFZ+MaGThFttZeNEx+i?=
 =?us-ascii?Q?GQ8EdH25tqJGG1CVIJFEJW3HKX6cqT+xt9ZpUhKPEb+D6dPDI8L09fuMZKqY?=
 =?us-ascii?Q?8f5r5/K7Nr0jm2+mPxSEz7zs0jdndv6w9uGklVtJAOfTHByzfeWfdi4aDQQS?=
 =?us-ascii?Q?GC2CKNbxaejc+7T0IFBwUthdfbOMJAFoSz0nuMJfKwnmiaEKGAhKaADMPhmE?=
 =?us-ascii?Q?lx9J1kMb+c7i7WkCixkLir9sIQ0YufBqXPwuEVuwlLleSN8vyjdD8eRhzZnb?=
 =?us-ascii?Q?vP6HtNWkscEdsVV/F5ZpsomYiOKCxq/a0jbTXnCKLDhKa9EO4LRMPfd37JKU?=
 =?us-ascii?Q?Bt8/A9R7UA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf266d3-f64a-4777-c1f2-08dedd55e1f8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:03:26.8006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5Z1cPkfDHSYwsGbt4N6ySHKltm0jsj8u/DBd4hjuHO19My38UvKY0VOqF3lkCQZxeOEQ1QE7qIKpg5KldqUwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

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

v9 changes from v8 [2]:
- Rebase the series onto v7.2-rc2 so it applies cleanly on a Linus rc
  tag.
- Include the cxl_bus HDM restore add-on as patch 11/11 so b4 orders it
  after the main CXL reset series.
- Address only patch application issues in v9 to gather feedback on the
  current direction. Other review comments, including Dave's code
  structure/readability feedback, are deferred to v10.

v8 changes from v7 [3]:
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

Patch 1: cxl: Split decoder programming into a reusable helper
- Move shared decoder settings to include/cxl/cxl.h.
- Factor low-level HDM register programming into cxl_commit().

Patch 2: cxl: Cache decoder settings on PCI devices
- Cache CXL core HDM decoder settings in pci_dev->hdm.
- Refresh the cache as decoders are enumerated, committed, or reset.

Patch 3: cxl: Share HDM decoder decode logic
- Share HDM decoder decode and validation between normal CXL core
  enumeration and early PCI HDM cache setup.

Patch 4: cxl: Cache endpoint decoder settings during PCI enumeration
- Snapshot endpoint HDM state during PCI capability initialization.
- Cache the HDM register locator as BAR-relative metadata.
- Cache raw decoder register state in addition to committed decoder
  settings.

Patch 5: cxl: Add CXL Device Reset helper
- Add the internal DVSEC reset sequence.
- Disable CXL.cache, perform cache writeback where supported, initiate
  CXL Reset, and wait for completion.

Patch 6: cxl: Validate HDM ranges before CXL reset
- Collect enabled cached HDM ranges.
- Reject reset if affected ranges are busy.
- Invalidate CPU caches when runtime cache-invalidation support is
  available, otherwise continue after warning.

Patch 7: PCI/CXL: Discover the CXL reset scope
- Discover whether CXL Reset is function-scoped using the Non-CXL
  Function Map and CXL cache/mem capability bits.

Patch 8: cxl: Restore CXL HDM state after PCI reset
- Restore cached global and per-decoder HDM state after reset.
- Re-map HDM registers from the current BAR assignment during restore.
- Replay raw decoder state for uncommitted decoders and recommit
  decoders that were committed before reset.

Patch 9: PCI/CXL: Expose CXL Reset as a PCI reset method
- Add "cxl_reset" to the PCI reset-method table for Type 2 reset-capable
  CXL devices.
- Prioritize cxl_reset ahead of FLR.

Patch 10: Documentation/ABI: Document CXL Reset PCI reset method
- Document the new reset_method value and reset behavior.

Patch 11: PCI/CXL: Restore HDM state after CXL bus reset
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

References:
[1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
[2] https://lore.kernel.org/linux-cxl/20260703220508.546528-1-smadhavan@nvidia.com/
[3] https://lore.kernel.org/linux-cxl/20260623032453.3404772-1-smadhavan@nvidia.com/

Srirangan Madhavan (11):
  cxl: Split decoder programming into a reusable helper
  cxl: Cache decoder settings on PCI devices
  cxl: Share HDM decoder decode logic
  cxl: Cache endpoint decoder settings during PCI enumeration
  cxl: Add CXL Device Reset helper
  cxl: Validate HDM ranges before CXL reset
  PCI/CXL: Discover the CXL reset scope
  cxl: Restore CXL HDM state after PCI reset
  PCI/CXL: Expose CXL Reset as a PCI reset method
  Documentation/ABI: Document CXL Reset PCI reset method
  PCI/CXL: Restore HDM state after CXL bus reset

 Documentation/ABI/testing/sysfs-bus-pci |   14 +
 drivers/cxl/Kconfig                     |    4 +
 drivers/cxl/core/Makefile               |    2 +-
 drivers/cxl/core/hdm.c                  |  257 ++---
 drivers/cxl/core/region.c               |    6 +-
 drivers/cxl/core/regs.c                 |    4 +
 drivers/cxl/core/reset.c                | 1359 +++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   43 -
 drivers/pci/pci.c                       |    5 +
 drivers/pci/probe.c                     |    3 +
 include/cxl/cxl.h                       |  108 +-
 include/linux/pci.h                     |    8 +-
 include/uapi/linux/pci_regs.h           |   14 +
 tools/testing/cxl/test/cxl.c            |   10 +-
 14 files changed, 1628 insertions(+), 209 deletions(-)
 create mode 100644 drivers/cxl/core/reset.c


base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.43.0
