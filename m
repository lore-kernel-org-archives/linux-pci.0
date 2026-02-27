Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020075.outbound.protection.outlook.com [52.101.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A43A0E85;
	Fri, 27 Feb 2026 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182204; cv=fail; b=D3l+ZgIgTU4Apr2ruU8WiIHjzNKdwgxf9QhEKlZV+nNwa9nM7NUvSNwvEwibAqq39uGnMq11pbZv0HsxRxP5xj7dIV2SHQBcWCWq/dQ5ngKbXhZ31SFlCkslmUKV8HRIB3J9y5lqbVJKRkqcvWj6UqAjwD5Hz1JqRPlRW4q55qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182204; c=relaxed/simple;
	bh=KLmzbUjELz1kImOy6cbc/YEaIlEZFpsWO0gVRRk5VrU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qOZ+vatoRrdZU8rM4qCTV7yAK7LiUs9/fGvQiyLAl01evn56lCOj1V766EGkYth+RSUTlLo+3uvw2vOu6xGMqGApKhL5UwUW6lJOc2kKBNozdR7skn47R357lRxGNp5Hpd12AP2knXOXzWB2Ewrfrra0m4on8JBWUldHEvk7JuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=n9hQqHaS; arc=fail smtp.client-ip=52.101.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="n9hQqHaS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ht6loUl0ka65fg+73XlVPYUussQMRNE5ju74pGPQuxW86rd+joRlegVsDysWDI2Nu4CjKOk6wF7xzcB9FH1ZiYJkRp+DctTtbsNlj/L2S8k588sJmBXqzNYj0cBjjFRY3CMoNAW5nz7SbqQafKlHibDywdRyLtRiTY+QxwqYRD01EmmdtS0F5Ug+3sWPDpDZTCUAZf6M9GSk+9LEMIslFIKK6qBiXYIbm8M6GJ2gwWlJ1N+Ow1UMdJVDW80mhIS4+xJi3ZtpGjxItBpE/Z83W3ColhTdmD/GUiBoGegbdZuUw6Mm1lyk9FacCkPg/vgQpmu2F7xh/QebafIWMKT/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7J7OsmZQIxF+sM+80GULm20MxOzcz6Lr5COd2W6Kac=;
 b=umVHTt9Pz5th6r3mN/7F8pArz3n4iluZwb9Vmc/kWhndcX9RRxz+wkMrrSdr+ZK12+a8wJveVhJim3zvYLB8DdyXJ5nL3d7zMEjpK1wJXmFeiynAfzR03jJy5cxl41TKM+d9Biseh+OnVvy0DlirBThgIEeqh3Du3VRXiS+j5UI9/by0HT6ye7Z47q543RFrDqSh/snOADQbCLQ3QU1UFQbR/zGwzH9VlzHoKnWmg8FqCrVm344g4TcKERPlk2+v2jA4XL9EWfJzsYoj7BYQ+5kZ/rTNwE2dn0C2/HlhyCqqnOA20alDYMTwSRH7r/ME4wnkFyTn/gYQglOElWJxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7J7OsmZQIxF+sM+80GULm20MxOzcz6Lr5COd2W6Kac=;
 b=n9hQqHaSrcEppJns3pOTgf5eGjunQplFjEP0knu4X0NVeJJbhCvIqY55ZbA0VT7XQT6hNV21RDa2kNsEvlXz7Whi5Qc41hj5YDr4Uv4ktscX0Ui3FP96WUsUt5GyrN4k9SG+Aj72+2J5FJfE11wLMuXiCyPT6dckCbLDHQjWg5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4075.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Fri, 27 Feb
 2026 08:49:58 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 08:49:58 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
Date: Fri, 27 Feb 2026 17:49:45 +0900
Message-ID: <20260227084955.3184017-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee73bb8-364d-4062-dbe8-08de75dd2f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	crTwoK4oXXii+Lf3t82EKX1ku1/dLYKIDUthLrdUHRAFuHGr+3bWKeftubhmtQPjmcZTlhlGd7U+F1+WtEHkLL01SZD6PHPzHp0fmpG9gAwBKBXFqY9MF0dGmrEc4LKIydZqZmDLpaYzbhp4WAVnipRTjuCa9pTUfAEqCR3AMblP5XYPFQK5oTQ94y8QdeoP09vntU2mJWprFrVyBKARB1FQ23i94roMuTOA8AhIBgabO9YWWV+Gd2sSDebneCWOyLBbQI7OtQzp1DHmcNYmAHYvATwfS5VPJO/h+IGGpB3y/vpkMLQcw8tzz56JA3o37X2Tu7Wz397aCBhaPP2IHalIyomuMQ8LqStSMxz4r3Aub5IOoO1ns/0AIrZ85d/X47ie8nPBNiYRoeWkKT09g4/VPMowh/pXeVdYgSyKMW4QID9Mz5ObNu3rnGZgw1mGabq+EOTSeZPk9mfWAqe474wX3RgTjeJuvNPkM140vU9SugZ8OfM6ue0Wn7JZY/YYMnscD8LwhRKj8rD3xKj94bGRuIFfBPYclcR7UBRAjaqJGWgva/+muG/CZrwFVvafYI9+yDjpTlUoCdQcBGLdIdPrdA2M4gIqlVVqGg1NrtY7H9gS4kNPRf+4AE1SZ1oyiMFqbKW1EhAbZ8rdvgxpxzbP6f2CsyOwvi2qYCJf1iU7JlmIi081+N7Fjb8OrmHb0fwpfYIa5jeJ7l/AJ6e+iZdRdIXf7GGbnUwayarhKfOecSTcmSv/MOCt0Jn+JROXBsLBQBGrdrPTdhWqFLiY4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fnZD7eP37ATIt4QOLKaD59e0HYtdwRpi/W+WnCO+mhp1WwDWFKZIH4GwXqUl?=
 =?us-ascii?Q?UOmGTS+Ottd32JjucRNCL8EvaCnVJWkYyEtswUBneoyXXDUzLD/axB0vnd1Q?=
 =?us-ascii?Q?itXrNImJljboMPZN/1Hd+eMniMmmAJi3US1KoTWuCD31RvANF+KW30AelHV9?=
 =?us-ascii?Q?3sZB1BVDDpza6kH3pDXkUleofQF3gfLwn5KJavUqxJlQglPDL+41NJtgDrWV?=
 =?us-ascii?Q?cWfdqe0LPl32kUp9BTTiBMKBrlPtRazy+8o62O+ZhXXTPqDJS0j0rccP4gW5?=
 =?us-ascii?Q?do6g7ZQQI0fcITe10IdtLw4/fYaC9/fNp1AgBUWGq3E5X25p7hx7cuPaUabm?=
 =?us-ascii?Q?etLjL2y6Cx3Q67XHDchgJK+iJouIRIa3RbDWlYUADRx/ENaSDJPy5vVRXZT7?=
 =?us-ascii?Q?0LKBi2OyQLIUqMg0elHRMa1txGWcOr5iAbDgBsONdlvDbhsZEdUZXDkFKv3B?=
 =?us-ascii?Q?CEBpE4fu/igGF5kXSJSCTUDUkOPyIb7SjEUKf83Ooy2mAF8ZUIFeiS5HZftV?=
 =?us-ascii?Q?DBodMsQBb25hX/SiDGwl1Y5OJU/cpBf5du8F9g0WyVQIsC13ap2ASRb06L1h?=
 =?us-ascii?Q?fkm5DgU2bEodhmgV3AXCzcQmRjN6oNMofIhqJdr/xxuJglbmH1lxWVl6ntvp?=
 =?us-ascii?Q?AGNEAGzZJ9WHIH8AsZCJ3Qam49SLV5CfnHMgB9/thaoKZ73TqHvgMxE4bMba?=
 =?us-ascii?Q?aYxgXjRy0+vdOvblMyn86D/XbdA1IgUZjVwIG4SJSfCZTayCDreIWmBMiD8P?=
 =?us-ascii?Q?V3Gl3xXrDQzZT9hFUmwP7pDIsZS1GKGF6CCHxFkewIJDqmMW+GWBlnr9FUQd?=
 =?us-ascii?Q?RJk3gEiqvY6OveXx+u/H2U2pwmqX8GrennynU1UsYG5YMVMaLX2Rppn4JYor?=
 =?us-ascii?Q?MQxZzySLAhs90rR1D5gdIrYYZf36b41S5762TEOuFUBTIoHy79aFEIt//tTJ?=
 =?us-ascii?Q?sCs4BHyP2IvBTE5DMMJR9FbYDw96bzHnHW8pzrVkb0eLCUk/BG2Tdgo5wIy/?=
 =?us-ascii?Q?FV22AAi+eYee4UWzKO2m+fL/+AxtmCiwUFbktdgsr906cbwMeKijJE8zSIAJ?=
 =?us-ascii?Q?u7LVQlo3KJpLQRdyacog3eubhmgz2gpcpzCXMj7ChlMODIT40IEcPnJN0cMs?=
 =?us-ascii?Q?UaL9NfBn1LZ8MM897RDaBu+WgWNGcFjZSN4bPznspUNhbaOgqgfXQD5h4dP9?=
 =?us-ascii?Q?LXdcxTuEq0GbWzJjxmij1P4lE2tE6we2ass/hRl2Zn9oeIfVb20UGP2b21gh?=
 =?us-ascii?Q?k6nFz8LweV0inkTbWfitKYhHkzMVzHDBjiABZRjPyeO+k9Bm5Ca3HyKwDeLe?=
 =?us-ascii?Q?R5m9ghDvnl1jyoUjVDzWgxODM+XEpD6v40Jpd9BpB/X87n/GlS64jB2FAlXf?=
 =?us-ascii?Q?A64zvIY94T1K8xP69+Xy2+DmG09rIb+hRXPquukZZdZ+hUr1AaIONgTnARCE?=
 =?us-ascii?Q?NWvsKBin96jKI8oi5HUOKUN6WoZJUTNCj2yJ9QBLoMoZvjxD1mCzfEB1vLau?=
 =?us-ascii?Q?i/2iqC/2b0DqiJRxbZR9z7eUQXey1KuiM0p/Ct+LLpuJE6fqT5Mda3IXnfxH?=
 =?us-ascii?Q?YxZUbqgpwTF1069CX14dRvgZJ2QUhmQbb0kWfxzG4lczt/8i+FVXBpSqMaBx?=
 =?us-ascii?Q?8DVZnraEbLDVnpjkACNkqnBQ2rChdIjuaccxLCJUjGVfnxfAIZ/mE+7lYJSv?=
 =?us-ascii?Q?J8Ow8oZyEzjTQftPT/DZqjgGjhIR3yY1b/6Z434dm79f9fBu6vs9+ylf3PkG?=
 =?us-ascii?Q?S43ivQ3SZt7LB88ibOmMnE23+DofFBRuJ0fb+gdgHJh/Dgy9RbO8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee73bb8-364d-4062-dbe8-08de75dd2f8b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:49:58.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbKBTyDn6Ja4FVezm8gHebusa4TJU662oxuQZz5lAOqiAQNtUAEcp1+HT/um0BaXeHP+P1z/UEL5fRva2NBjaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4075

This series fixes doorbell bit/vector handling for the EPF-based NTB
pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
without changing the on-the-wire doorbell mapping.


Background / problem
====================

ntb_hw_epf historically applies an extra offset when ringing peer
doorbells: the link event uses the first interrupt slot, and doorbells
start from the third slot (i.e. a second slot is effectively unused).
pci-epf-vntb carries the matching offset on the EP side as well.

As long as db_vector_count()/db_vector_mask() are not implemented, this
mismatch is mostly masked. Doorbell events are effectively treated as
"can hit any QP" and the off-by-one vector numbering does not surface
clearly.

However, once per-vector handling is enabled, the current state becomes
problematic:

  - db_valid_mask exposes bits that do not correspond to real doorbells
    (link/unused slots leak into the mask).
  - ntb_db_event() is fed with 1-based/shifted vectors, while NTB core
    expects a 0-based db_vector for doorbells.
  - On pci-epf-vntb, .peer_db_set() may be called in atomic context, but
    it directly calls pci_epc_raise_irq(), which can sleep.


Why NOT fix the root offset?
============================

The natural "root" fix would be to remove the historical extra offset in
the peer_db_set() doorbell paths for ntb_hw_epf and pci-epf-vntb.
Unfortunately this would lead to interoperability issues when mixing old
and new kernel versions (old/new peers). A new side would ring a
different interrupt slot than what an old peer expects, leading to
missed or misrouted doorbells, once db_vector_count()/db_vector_mask()
are implemented.

Therefore this series intentionally keeps the legacy offset, and instead
fixes the surrounding pieces so the mapping is documented and handled
consistently in masks, vector numbering, and per-vector reporting.


What this series does
=====================

- pci-epf-vntb:

  - Document the legacy offset.
  - Defer MSI doorbell raises to process context to avoid sleeping in
    atomic context. This becomes relevant once multiple doorbells are
    raised concurrently at a high rate.
  - Report doorbell vectors as 0-based to ntb_db_event().
  - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().

- ntb_hw_epf:

  - Document the legacy offset in ntb_epf_peer_db_set().
  - Fix db_valid_mask to cover only real doorbell bits.
  - Report 0-based db_vector to ntb_db_event() (accounting for the
    unused slot).
  - Keep db_val as a bitmask and fix db_read/db_clear semantics
    accordingly.
  - Implement db_vector_count()/db_vector_mask().


Compatibility
=============

By keeping the legacy offset intact, this series aims to remain
compatible across mixed kernel versions. The observable changes are
limited to correct mask/vector reporting and safer execution context
handling.

Patches 1-5 (PCI Endpoint) and 6-10 (NTB) are independent and can be
applied separately for each tree. I am sending them together in this
series to provide the full context and to make the cross-subsystem
compatibility constraints explicit. Ideally the whole series would be
applied in a single tree, but each subset is safe to merge on its own.

- Patch 1-5 can apply cleanly onto pci/endpoint latest:
  f6797680fe31 ("PCI: epf-mhi: Return 0 on success instead of positive
                 jiffies from pci_epf_mhi_edma_{read/write}")

- Patch 6-10 can apply cleanly onto ntb-next latest:
  7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link disable
                 path")

Note: I don't have a suitable hardware to test ntb_hw_epf + pci-epf-ntb
(not vNTB) bridge scenario, but I believe no changes are needed in
pci-epf-ntb.c.


Changelog
=========

Changes since v1:
  - Addressed feedback from Dave (add a source code comment, introduce
    enum to eliminate magic numbers)
  - Updated source code comment in Patch 2.
  - No functional changes, so retained Reviewed-by tags by Frank and Dave.
    Thank you both for the review.


Best regards,


Koichiro Den (10):
  PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
  PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic
    context
  PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via
    ntb_db_event()
  PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
  PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for
    doorbells
  NTB: epf: Document legacy doorbell slot offset in
    ntb_epf_peer_db_set()
  NTB: epf: Make db_valid_mask cover only real doorbell bits
  NTB: epf: Report 0-based doorbell vector via ntb_db_event()
  NTB: epf: Fix doorbell bitmask handling in db_read/db_clear
  NTB: epf: Implement db_vector_count/mask for doorbells

 drivers/ntb/hw/epf/ntb_hw_epf.c               |  89 ++++++++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 147 +++++++++++++++---
 2 files changed, 210 insertions(+), 26 deletions(-)

-- 
2.51.0

