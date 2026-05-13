Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020110.outbound.protection.outlook.com [52.101.228.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D482390985;
	Wed, 13 May 2026 02:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640574; cv=fail; b=ulmQYqEPwObNMMMfe0THL/U9xRmN/O4+aNypqNjy9OD0MXhf7ki5WnnoREtoMNQe4LJyIaSD1A4ALnuoxmgJn0ew4DoYwtLNOwzRLfumNhPzVcGcu+TiWIxArd+y/FqsvhjnAi3uBEGIij641OSLhZZwkQPLNYwm9uXBI5XA67c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640574; c=relaxed/simple;
	bh=xNjLTJ3VhrP2wlXb9AMgyK1oO9fEyRY7XVXPrOGPZ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KqDYiFqeEj47hIBD/TTiurbba9TvS4GchoGxCToTMOn9kGhCUBvbYcnH8ZebyiyG4GXP3riPcJDNVqKPPbj3kuTg9gfG3dSOTVMd1dJ132uM/7Rz3LMpwy/+pMeFDDayp8ONi6laR+6+wa0NpXM1JrDgnDok5TGkawnrMGtma9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lpHNDSvq; arc=fail smtp.client-ip=52.101.228.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lpHNDSvq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZN6HZNHpN+Cdq4tFWhGB0h7C+Vq9k/HhV6vCYg0LxXvre4/T+jFrVCrHTbbJSL6lFjlko1LMzx9eXpjjHKZTwTdgx/QgFTN2p656tRT/ubztZ6oibdxr4OrEmFwDK5cbZ1CJihCdmbkhpkR89kpaznPjYTl5Ha4lydqSWEgjMXJIa/TrqyPrVUfX/86in+seTQ1GXlJWtPiiZUSRXlyboW6F+vTWK+J0CXL4hW553Tzru2cVhFUlAtyqq5xuoBO3mh9BkzkCJXpMQQcMoi/S7ZEqgZtc2Ki7ps01PUCswAoyn2AuuDmjB+xSqPlFP3URavXkq9JW218kk9bexdGItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkOqEc90oIu1vw9/euoFXDLSM5ZetP/9ZvYw7E+jXds=;
 b=VePP0GfqR1VwCHhae3V1CTqgVhup4tl0tzetEDIbXo4AVzOE9NcEZmlrnfZ+popI3wDT7+5xoxiQF6kuyDHkculhTW7vcVujyO3NYs3UMPvXlv7vbRJprJhIuQSettIEwXyWlZTMXfEmaRHjNfH4jKkfdAwms+vACZpyf18zMo0prSZgeQw31pC2bK/ANZHAcGiY4sIql15cP8ZtxbPUqFJAN6ORr1du67U3PJ7ExTtUKoPiBTuuUo2vBJRiZZl69cSbPAE6gXBTRrRfBuahAL8GtSvH6RL7Ks+RQXfwOlOKxtJfyTxJJT5j+tC5lmYi8pT5urmHig/2sWM0Bo17Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkOqEc90oIu1vw9/euoFXDLSM5ZetP/9ZvYw7E+jXds=;
 b=lpHNDSvqcqzlLRfpQmxRXFGiy+ddYl3DlmfXaS2GD9wpTayTsXYbjOT3Eu0LNNQk4cnOb5lwXp2DKJi9ru5Zgk+slKACkb4GEwkHv/MFuLmugLV/SjLj5KJRctvDAmg2qf+41ZI2E8iCRQ6EH/g4WbRPcWzBMrAO6+/tHFk1OJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5170.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:161::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 02:49:27 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 00/12] PCI: endpoint: pci-epf-vntb / NTB: epf: Enable per-doorbell bit handling
Date: Wed, 13 May 2026 11:49:11 +0900
Message-ID: <20260513024923.451765-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0277.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 23636b60-d653-4769-0e08-08deb09a3f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tcFoJneNqbWH3YbyELkQ3mY5+lBw4eUWMVef/yAuVvcAbcvPNwIC6izA9vS5wiC4OVI58PF3pb33l6FwFeGcs3tsDc/DRrfcgY11TrWGixZDFatm33WxbwyywUJNEFekyWBeA5oFN/CjDWphD/d2/dhO6qrkUJb0GC49qzTNcAO6ZI32hGpKo+QHQvrHrRq0oWXU1MXQ7aLlsyiCjRf3v8elwb+4lOJ5a5JwrW1WKZ46vU2dx+9XhRDfIpqxVA/I5Pt53uZCHXqWk2eTIN9VOLBm03c0huk555wI3Hf4DLilJcxE1SMHOuShpoJ/W6NIcupfC+1Vw685noNuk7Z7SsbIPXDao+9CWlx5D2X1ANJqgs8p9LZ/ZuWH6tfFnp0n7QcZm91XuEFDf7j6hYxKz8DZh69ornxBdF/rm5CG2dren/8IQw8LcAvphjGRVDLyPe09LqVYyXCcmWDouYl5+AaCALCPAmUXT1SxHe2Z3A8NR3u8c+/ULEY/ycfHuJFdER9GAC7uKCf4D5WIAQM53b/5iftiu9yItjA+6RiMzRvECaBm9fJwEo8VYclKEh7BGycP55+J8djI4AyxNq8Vv41n4NqJUuJ+8F9R3OQM0+eHETZokDBMj90Jh05nm6HLQtfq3bkeDb3QW3J9hh8hdBbC+fAJULMoANAT0d0u33R7kfZeqD+Fg0xTBvRSyADz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cu2StfpMizOWlflzOwC3yt50mDFwNf9AOGCIEMoqGxwsWj73IkugeK1fRDgT?=
 =?us-ascii?Q?jDearqOaxM6AmsMzGcB2i26a0AxpAiruRVMgnADWNbuKySLIGWx5DFfkaMXh?=
 =?us-ascii?Q?jROPjaR78skjmuG3Z11Sixdsr32YWQhvdZDjB/HzkJVLTR1uqOLy0mO17gw1?=
 =?us-ascii?Q?/fLaNFizw76DQzM6WVNqcGzWPcldXbvEkv0UV2m9QX8MacAHsjz4fX7Lz0qX?=
 =?us-ascii?Q?gF+GWxiB+XdDG4dA9CtMdHtlIebzqrkx4kgHI5eMez30Z1zRRtLEGXzaSPdS?=
 =?us-ascii?Q?nWFQ/xNyAtW5gVC8kgocO784zqyPT94lNnurJIIDM95jYlMW1W6pxuNVdet3?=
 =?us-ascii?Q?xjN06UwRahb1XE9kRM0q3wgJ13rlOXC/MoAv9WNJJa+wYUAwt1FSnwY41fAj?=
 =?us-ascii?Q?4ncBxJQ+0OHlFhx2eHM7GyOillq9vJlsZKPS5s4E7Iz1Lb4+sFbu94iUHAS+?=
 =?us-ascii?Q?C97xs9ttLpB3YfMnxlTL2uEHf78BEQfHBJWyGes9fQs+X0SVijRDv6sDRZEd?=
 =?us-ascii?Q?gtb1o26xV/W3VR6r3XZJBAlpfFaQPbSig4i6cSJtbcYmksysWdTarQlq06Ue?=
 =?us-ascii?Q?9CFYZJJXOOEN4qmIifK5WenL1GqIKTfsx+cKYeAre41VJ/Sbq7yhHxjBtJWo?=
 =?us-ascii?Q?Yd8V0Fj2gkn+FdA25KFvrYVRNEC95gJ/66JO47WVIOh5TO7EhBfPwF2KXCPd?=
 =?us-ascii?Q?Q8jKFq2JqOLUegEXr9lsf5lNQU5P1X8yaaVvj4zvvsqVxWdOJk1Sq0/bgTVa?=
 =?us-ascii?Q?eaH4GGpUyShLB/ZAGN9xaGDdD19PKyqWGEvYLZ0v5BSS0Q4WNYcPaXeu06Wp?=
 =?us-ascii?Q?3PhPDx2MlvRtbUScphbYD3rfxFQYGiJli2rupAwP9YE9yrCfZUyTLj8boVAS?=
 =?us-ascii?Q?8F0kK8ORuPExM2OZ932J3+U6lsVwsl0GCh2QZ6Cis1KQ8LNccNKJAyFo6QWM?=
 =?us-ascii?Q?NCY/Y5hMF0VuBkKUVyIh45KggFhukMd96kl/jkDoZpsxQrXbFtkm12DGmyxg?=
 =?us-ascii?Q?bSX9+bpzUX+zqP/8PLA79y43GIkLLzioMVNDIOUJs2uqZCEA3l9NjWnFXEcO?=
 =?us-ascii?Q?g1APbisH5ultGUxwCzeoMX+XKuvYcXnm83a/OjFaQjGBCPjzkm94TCoyFFFe?=
 =?us-ascii?Q?gEgJfdpFWx6yrj1olyoZE4VDtOLlF3C9oQ8P7X0uJBvIc+NYDQTiuCIcIs1T?=
 =?us-ascii?Q?8Qrq6W8H66vPN2JbybU7X+Lt1NUiaLGUJWSxVNHibda7HuJ+Z0gAvUHjJnF1?=
 =?us-ascii?Q?JEvVCLc9+8jNT2J37b92JKfnijCDi5lgpqHM3jQUKn9gg9oTvKlEXVvntpCb?=
 =?us-ascii?Q?6OlHO58Q6uoxPJvr11UwPwMx8ejakelwWF+MjYO0o4nDDT/ZCW3cw6bVUd3g?=
 =?us-ascii?Q?8XncCucxlTmkYEs0j9ibqjxnzEFAZRANHizqucj/I2WrU6e1EFglJj0XjckM?=
 =?us-ascii?Q?R+OFMgPzaEu9olSKZMN1IWGFyTkJaJ6yDTzJ3pY4A7RqhpwNrsbZDerMSqmj?=
 =?us-ascii?Q?N7WcjInieLHDCn/hWrIxKRBedDGu4MmcdMXOUogagekg5+Tacj6/yzjsmk6/?=
 =?us-ascii?Q?P7RfyqLWT3mL16uk7N2n24ezvuk4+mtesSMaFYH0iLq7n2OM+zCnjf1rtcbc?=
 =?us-ascii?Q?TGaTXqG95TJftJNpHRoFjy+Xv1dWzr0e+Owqa+YsMmbHaoQ5CNuDcz1gg83+?=
 =?us-ascii?Q?AB3t44hsxpmr8LEca3NmWNVxvZI5XQGrZ9KOIg5c55QqR/dzsh+k/HOh15j4?=
 =?us-ascii?Q?cGz0Ijl1HslkH3A8BUEOIm4a1SFaGeeqMBRA2naQEoehl83h31Fu?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 23636b60-d653-4769-0e08-08deb09a3f86
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:27.1201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/uB0KD+ghA27A4sQutd7zjg4EcQj8LKVNKaw9kuULXj+3Gk1sp7XcELl//+uQCHo3dbayIDLuVa8+ENgPFYCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5170

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


Dependencies
============

This v4 is prepared on top of the current pci/endpoint:
commit f5aa97125491 ("misc: pci_endpoint_test: remove dead BAR read before
                      doorbell trigger")

plus these patches as contextual prerequisites:

  - [PATCH 0/2] NTB: epf: Fix ntb_hw_epf ISR issues
    https://lore.kernel.org/ntb/20260304083028.1391068-1-den@valinux.co.jp/

  - [PATCH 0/2] PCI: endpoint: pci-epf-{v}ntb: A couple of fixes
    https://lore.kernel.org/linux-pci/20260407124421.282766-1-mani@kernel.org/

(These touch the same code part as this series and would otherwise conflict
with it. They should land upstream first in my opinion.)


Practical benefit
=================

This also enables ntb_netdev's multi-queue performance scale:

  [PATCH v3 0/4] net: ntb_netdev: Add Multi-queue support
  https://lore.kernel.org/netdev/20260305155639.1885517-1-den@valinux.co.jp/

Each netdev queue maps to an ntb_transport queue pair. With correct
db_vector_count() and db_vector_mask() callbacks, ntb_transport can wake
only the queue pairs covered by the doorbell vector it received. Without
those callbacks, the NTB core falls back to the full valid doorbell mask,
so each doorbell interrupt can still wake all queue pairs. See "Testing /
Results" section in the above link.


What this series does
=====================

- pci-epf-vntb:

  - Document the legacy offset.
  - Defer MSI doorbell raises to process context to avoid sleeping in
    atomic context. This becomes relevant once multiple doorbells are
    raised concurrently at a high rate.
  - Report doorbell vectors as 0-based to ntb_db_event().
  - Reject unusable doorbell counts and guard configfs writes after EPC
    attach with -EOPNOTSUPP.
  - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().

- ntb_hw_epf:

  - Document the legacy offset in ntb_epf_peer_db_set().
  - Fix db_valid_mask to cover only real doorbell bits.
  - Report 0-based db_vector to ntb_db_event() (accounting for the
    unused slot).
  - Pass per-vector context as request_irq() dev_id instead of deriving the
    device vector from Linux IRQ numbers.
  - Keep db_val as a bitmask and fix db_read/db_clear semantics
    accordingly.
  - Implement db_vector_count()/db_vector_mask().


Compatibility
=============

By keeping the legacy offset intact, this series aims to remain
compatible across mixed kernel versions. The observable changes are
limited to correct mask/vector reporting and safer execution context
handling.

Patches 1-7 (PCI Endpoint) and 8-12 (NTB) are independent and can be
applied separately through the respective trees. They are sent together so
the two sides of the same legacy layout do not drift apart, and the
resulting code stays easier to follow.

The plan is still to take the whole series through the PCI EP tree once the
remaining NTB acks are collected. See:
https://lore.kernel.org/linux-pci/rnzsnp5de4qf5w7smebkmqekpuaqckltx73rj6ha3q2nrby5yp@7hsgvdzvjkp6/


Note
====

Most v3->v4 changes are responses to Sashiko feedback:
https://sashiko.dev/#/patchset/20260323031544.2598111-1-den%40valinux.co.jp

Sashiko also flagged a broader driver-unbind lifetime concern around the
vNTB PCI driver. That is real, but it predates this series and needs a
proper .remove() path, including NTB unregistration and work cancellation.
I am keeping it as follow-up lifecycle work:

https://lore.kernel.org/linux-pci/20260226084142.2226875-1-den@valinux.co.jp/

This v4 only clears the deferred doorbell state added by this series around
EPC init/cleanup.


---
Changelog
=========

Changes since v3:
  - Rebased on the dependencies listed above.
  - For Sashiko feedback on state added by this series: clear
    peer_db_pending around work enable/disable, mask peer_db_set() with
    db_valid_mask, and use __ffs64().
  - For pre-existing issues made more relevant by per-vector semantics:
    stop deriving ntb_hw_epf vectors from Linux IRQ numbers, pass
    per-vector request_irq() context, ignore the reserved slot, and
    validate vectors before BIT_ULL()/ntb_db_event().
  - Added adjacent hardening: pci-epf-vntb db_count range/configfs guards,
    bounded db_vector masks, ntb_hw_epf mw_count precheck, and helper guard
    cleanups.
  - Dropped Reviewed-by tags from patches that changed to non-trivial extent.

Changes since v2:
  - No functional changes.
  - Rebased onto current pci/endpoint
    e022f0c72c7f ("selftests: pci_endpoint: Skip reserved BARs").
    * Patch 2 needed a trivial context-only adjustment while rebasing, due
      to commit d799984233a5 ("PCI: endpoint: pci-epf-vntb: Stop
      cmd_handler work in epf_ntb_epc_cleanup").
  - Picked up additional Reviewed-by tags from Frank.
  - Fixed the incorrect v2 series title.

Changes since v1:
  - Addressed feedback from Dave (add a source code comment, introduce
    enum to eliminate magic numbers)
  - Updated source code comment in Patch 2.
  - No functional changes, so retained Reviewed-by tags by Frank and Dave.
    Thank you both for the review.

v3: https://lore.kernel.org/linux-pci/20260323031544.2598111-1-den@valinux.co.jp/
v2: https://lore.kernel.org/linux-pci/20260227084955.3184017-1-den@valinux.co.jp/
v1: https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/


Best regards,
Koichiro


Koichiro Den (12):
  PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
  PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic
    context
  PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via
    ntb_db_event()
  PCI: endpoint: pci-epf-vntb: Reject unusable doorbell counts
  PCI: endpoint: pci-epf-vntb: Guard configfs writes after EPC attach
  PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
  PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for
    doorbells
  NTB: epf: Document legacy doorbell slot offset in
    ntb_epf_peer_db_set()
  NTB: epf: Make db_valid_mask cover only real doorbell bits
  NTB: epf: Report 0-based doorbell vector via ntb_db_event()
  NTB: epf: Fix doorbell bitmask and IRQ vector handling
  NTB: epf: Implement db_vector_count/mask for doorbells

 drivers/ntb/hw/epf/ntb_hw_epf.c               | 133 ++++++++---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 210 ++++++++++++++++--
 2 files changed, 296 insertions(+), 47 deletions(-)

-- 
2.51.0

