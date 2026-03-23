Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020086.outbound.protection.outlook.com [52.101.228.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E926ACC;
	Mon, 23 Mar 2026 03:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235763; cv=fail; b=Y5hbyM/pKgHsCzTzqIMqLkEse9MUTMLBUnlR6v8216Fq5PNscGnQzOM5+9U0MA7K7osDFDawBJdn3XbqvSVDIIQX8sjmGlQa/i09AxAfSZPg7rWo69PcFO5il+c9IIfvcz0+GAn/nc7KMKEThjhxsV49NbP2ifE4gjIdaHN/aOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235763; c=relaxed/simple;
	bh=ha0hthIkrWes04dW69m70Hm3rPHw1BnSHDnj/X7hLlI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UvLQbZF6y8PG4G+IIqV9JzQDMR+hYig46M9YZO8rOkB8lISWyBg48B1nUxjr7XDkp3TAqOfYeArUgmoeqzPyAcB8Gq6pqWN80yT0tGxvEbGLYgtTKrl+01BA6Yu8tt5udHsZwIhxHcVnCVmXl6GUBxMWyCsQuhx9+5S1pbVGiCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=adA6eCaB; arc=fail smtp.client-ip=52.101.228.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="adA6eCaB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8AVNTXih4Qq5ks9JxeFL6QBGK3HW1ftTe60h0LsHXDcyND8r2u8UneIabyUalxOrkwamd/SP0vl2emn/FLA4uoyR4FjDC+mw5l8oZitDyqg3AbRZMamEwPTNZzW8s0Ay714qaq9JfJJT7/GZUgwMnqGSn50GpLu6audQZj6rgyjUpGA9b9ROZxwCo13Negp+G+RaY1QCVQNaLUrVccHWCc5mxhjvUQVKJQzIOFGQtgjyb8sV7+ANmY0BRE9MdDNTeT5eVz7AJP1mdKDoiupBivUFh2AX0PfQOX0CUKHZ3dEnMcq/+QpG1kFyhK60Ca8C1mlehl5Koe8CPvl4tcjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8qiZjUtKMXnM7Z6Yi1POgu4GOU/PyaxTp9WGzuYNhc=;
 b=sFQtdLqYOJTxmI48JjiVCSoBCFkzQS+av/j0a/YcfrBvkZN94Ot0BwaMDQVNKayeS+vG1Z99NlfqNeYvtZb/NgaLz6VyThxBdhXyhcFfMbb9kNSn0JnCu+yfYAJ5neetDOuokspwYGpBcjaQYicXJlUSMse/rfMxS4zOiXBiF8LL0zvPOAlZIkhct45Ae73w1Pf46gsEf4y3mutPi28YXViHN608w/FKqtm7k/ZUHHSBvdToD8cZBQTIv1AS2LE2DGgEtNisGjyFHmYq0PWDi1FFZT3NvjoADyPVC6Ff6TM8x2kyaLZDasGzZ5J8CoQBN7I6Oj7zbqw3f58fIIkp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8qiZjUtKMXnM7Z6Yi1POgu4GOU/PyaxTp9WGzuYNhc=;
 b=adA6eCaBp0D5EMT32qpxxgOuuNi3H3lro1p0Sa4jxG9i8tlijqqP/J5rMjYIW0WJN0N/CTaYNibRn46eishZRli/UfZ/r7UFH2K5i8FGWxNkppJMiqgmvV3E5DS60LIA6CKyMJHQKm+A+uhGK9IGKOSoiQq5JhDAqDPdIt6Ylnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TY4P286MB6894.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 03:15:58 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:15:57 +0000
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
Subject: [PATCH v3 00/10] PCI: endpoint: pci-epf-vntb / NTB: epf: Enable per-doorbell bit handling
Date: Mon, 23 Mar 2026 12:15:34 +0900
Message-ID: <20260323031544.2598111-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::18) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TY4P286MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0008c5-acba-4c12-6126-08de888a8084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jljOeZe70Oj5L8fdFKter/bJ3hK4JqL/2PM+8+17x+M2kDPT8qdsDulj6O0rGMFz3NYXNSp8RbVuuUyaISxj+cpANtwXGyF3sS1whxNQMpz4PrWUH0cdhJY//4AJSzqwQCF7tT96mZwqvwk/pRk4O1LXWgfxX/VpWeZYX3Ml2JlMd0XBaIj6mjgJFbW9Q1xuOlRA88+prjmbTyAVOq+rVFb4cNOGwVONBvVH3nJfoHi9zwkGmLTFjaQ06pPwnAXqhA8o9P03z+sNZYp8FbhPlbMm4f3Qujmh5Mzq+65ZQHmYscxrrcE8Awm1paH7XuznDg696YQ7xtrIzmZTj5OZdukQbVb/exqxan0ev9GOQm4RX8NINFomaCk8ZCwTrOmrIp7H9NcP+igRoJW/Z9gIPo5YxkkQCglViL1UHVArzb1Bw2fSWIfUuoDs5k3m0OZ40UU16CIUvEtzC+yT5x4H9nPTRwxBNIYvZGsDHnwklBMB/QQ//w7n71VXngUlAOZtikPJ7shlVZKa7ch6eoGJVJ6mEX4W+KEi9Bkxyqkt2BxWtqnJTTv8Z7ewIuuGiZ8F3ExOhTD6tgUkFutUOPBN3JqlR2HdtxRvm16ypcGkiQZCKc9in8VhdqGUuPiH8vhCiUMnRidiWVy5hbDkiUp/FVkpe+6rgdfL8Pk35cl+IBDklTPRvRnlFbJ8WQh6b/7PgdOKk81SQL2nSekxk5Tch7w1hXqMQImeMe5HVm7Du0Ul8b4gGqFgPGDlbc7yPrsk6mS0s8s+gk42FSQsA337Id9K7upRe+9ZgyRwdsWjKS4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7J2chpVSk0m7mdTe0sLYmoo7oG4uOXfOgcfa0jAovsOg3WC9YVt66xTanzm9?=
 =?us-ascii?Q?uJQWpVdoVSVf1kGXitkA/0nC5zFP8qUuqzvoLszOyvSJfQla6fkeBXLJSSwQ?=
 =?us-ascii?Q?eN0tQ8oI6LlA6C6SULoN90Hv3E9DPcYP5jrlH7UiGYnxg9Xfj7KrtioSc73j?=
 =?us-ascii?Q?ZLS3e/+AaIarPdnFC9BlBJ6hlKuI4mkGvsPkH/3+XvECTOtmVUHzgDRZAKAy?=
 =?us-ascii?Q?I7vlLqIZISNgwyOCrB+N1azMk+90yR7iEF8JCdrM+ZxU6XkDbsls1JzUXzDs?=
 =?us-ascii?Q?lU6xMldy6OC5tMSYVtE8mv0JnvFJKGPz8OaUKcwta5XGnErBgCmlePJAgJ25?=
 =?us-ascii?Q?IinQHnrlD8AsO4m28wWyj0hnqb9OV/S8NR2/ZiVBxsVAA1ZCcJgZ3AgY2wFs?=
 =?us-ascii?Q?18bp536An0shSqwxYOT9jNhA6N+OoicP8oRbd8TgGygsQ/7WQjp4NkFEkHKU?=
 =?us-ascii?Q?a92L1vGDOu6pLIUfrm+K15654owW10DzHNs3gNIcqKjy0k8pPsxEIVw4NthQ?=
 =?us-ascii?Q?nIZGNMDF9lDNV7S3hy5M7c/18UJTAP7G/tW5NPNuIyEYM+Fd+r/60yJTJWYF?=
 =?us-ascii?Q?dzQb+H8dq45WB/r+2i/D0m1LbX9EZMyiJqna6TZFCtTlYamBIMybFTRQWuGh?=
 =?us-ascii?Q?bPgS7jIzYXquotIu9BQ1ZJELme5Kb0HC7o4LIphFPlXmJqhktu7qpDlTi8u/?=
 =?us-ascii?Q?BXNp2DH5cPpivbyInPKLUNUlXTa8V+TRdNDikj9qNXOOzAV3l/3tBMIYsVcx?=
 =?us-ascii?Q?nbinCSabLfJDkb46gyPLkh2l9iILIC1vNLP2UOVY+NXJBCkTMPQDq4Qwc7zM?=
 =?us-ascii?Q?tr5eF93tEKSj12/0xwykmVhn904PRLaJhsKbTz9v/oj8WZsJcklVd7KBSriq?=
 =?us-ascii?Q?Cx0RQTlg5tNgDXnbzlgeAG9JgC6VSHgvvUwgPoX/M+6WFtoK0ti/GJJUpOeW?=
 =?us-ascii?Q?yBgJ9Qnim6SIjvxReNp0d4Xfg6ygZVAmUBySFtYLdtv4Z9tNw2TdsRgjNClJ?=
 =?us-ascii?Q?9YpyrRrpsXTH2zyR94AEsbArBKi73h+3e7Cgiy/89zUaLQEULbhFciEIw/qO?=
 =?us-ascii?Q?I3HtyfdJ+yQullzXUFsSTYsUnzKKJYptkCB4bJN1te595Tm9gps2YOm2WLTn?=
 =?us-ascii?Q?Ffe0/qQobmOsSQpW3wh0s8ik1raLQVpQ/XDekEtlCRLYH6YLcnZfmo+GspzV?=
 =?us-ascii?Q?g7AwhCX3qgYRy/bAqMr4r+YcnY+oWlmuyphKBu/jx4bhCE6DKuZVLGXKxTF8?=
 =?us-ascii?Q?O5CxeCGrI56EL9u/4P/CGbb7Ta2y0K6rhm/vobULfhdUeRmBohxjEjkyCVPs?=
 =?us-ascii?Q?CYihegcz5NUatEaLGiF16lcpIAf6gIC5Y3BaNxEYKKB+jHgAjyqEO6GDlQ75?=
 =?us-ascii?Q?PbqqI3h2WVVBUaWFuOq64fbXTGWVIvm4ia9nQVW1WKxMS/9UWuidA44V6kXc?=
 =?us-ascii?Q?61Bj+J61RZv5J9ZW3S24W2hoKri4tgzrh2reKUECNdCse6JS9scfmi66mnmK?=
 =?us-ascii?Q?vs4ckV3c9g5ngvP+hNTFa6lWoEyyZjU98sKNSnd0kCms41cQkEGCLf+Sv096?=
 =?us-ascii?Q?KaEQhS1NpSAN24IIsqp01xH4nS61pb8qhZli43gLt48gqtFYv+mIk6uc0uxl?=
 =?us-ascii?Q?UhY89O1NiIfYnuwUBnd839TCl3EnayS0YYXqZsx019O/d2P66boXcJbRiCMn?=
 =?us-ascii?Q?EFdPHyOqiYU9EHi7FCX+9xfhaL1vBvGLqwLRJL8j5mFv5fi3tvCFhow+BTuK?=
 =?us-ascii?Q?1vrm0Jc5Q/1pRC9RTwOFUlf5V2kdIclIUvhbsfj53fmYTpe1OKND?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0008c5-acba-4c12-6126-08de888a8084
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:15:57.7206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83RDMUlah5uIgeBfRNqObSn5tWRAdC9aqPG59Epb7J8E+V1ZcI/J8BDaPOg6lDzr49mqxvouCJqKkyDoDQaZ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6894

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
applied separately through the respective trees. They are sent together
in this v3 for convenience.

Once the remaining acks from NTB maintainers are collected, the plan is
to take the whole series through the PCI EP tree. See:
https://lore.kernel.org/linux-pci/rnzsnp5de4qf5w7smebkmqekpuaqckltx73rj6ha3q2nrby5yp@7hsgvdzvjkp6/

---
Changelog
=========

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

v2: https://lore.kernel.org/linux-pci/20260227084955.3184017-1-den@valinux.co.jp/
v1: https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/


Best regards,
Koichiro


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

