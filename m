Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021131.outbound.protection.outlook.com [40.107.74.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE036CE03;
	Fri, 27 Feb 2026 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182665; cv=fail; b=lO9/jAp6Gyf8HYF2lO+JbXOcxtaJePdBFLlnx2uJjZeJBrBXPS0jl0FWuX/Hqq9urZzCLwDPznwtO80K6SBLFz9FE8HR6Uv2AaijIY0yKIrUXGI90ZIB+K1et3j1UMzpykgSxjcKk9uEbXe9LBOyXhKS5TIWOuzRIKnU5dZYBDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182665; c=relaxed/simple;
	bh=1q1e9ZVWfhpqTxuvelJeoLRI7NBrwEWwCUTtNa4fRXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rr9KqwcI2KzsDjVWwUBeB0esoRBtA6KIDzPbXRZn7uhj7wnO9yLdRCOl9BOfKX1coOm0Bs5HYmTObp3IheDTqV9/Nv3BBciF7ytpTkVVzA+YjxPqbczbJ7EgaY5BP6CBKhQfhCPIympjexOs8I4k1johJDVS+NHhEiknlN/EFEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bOCZ/n8E; arc=fail smtp.client-ip=40.107.74.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bOCZ/n8E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHaiwf6OCJ34kufxZgkgJQpu0DS8DsdIKV/Pg8fwxYrzuWWOL5RF9RWoqkBbu1a+1dDU3UI3bhZcluDmybQTJkPet8OakN0ij2IbEUkugfuawtyX574jy2GfYjv5SU7H+fkafDXgsXrEFVCvKanM0DfKk8z/s1bz7ub/x+b0aOZoUJTzToEvzMpWiCVgudMLaLTY4KTTKt3IMhOFuyF0Aov68UFroY2TJHi6xCaf3o0DLmg+oVhMXjP1lagV6beb8KB8oYUU0aNuIzldBmP6vOjoz5wRPl5rUFUMccOvNl7PMM77tXON1GpOA5WFNd+2s4IFa2Q51UDJFWehGJf52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phlVH2naBlyaCi1ZBSTZAu7sa7CBKM5i5/EVBHFRUTM=;
 b=r1p5FbJetB9VLqgLJyys7C1Ouqi+RP7ymN8PuMprN9GGukWwanx6E8ErJQa6foM0ud71qSypfj4fGdEsWCwND+Qy70G+EVrFr6B0DMRK1+qQ9AJC2PDMbj1avso7OVldC5fuaSBkmHq5w7wUVtBw8jOB9yZStsWXAPPV9PmTBK0wD84eXTaOmGzViPdQ8gHt3bvuHcZ2bxB9ZCz7RpjA1R4rd18l0P9A3T/nL6pHnEdGsbPHy+HViUl/mfvAO86yAj7YKOa/ey0BNKr9uY8Ihc5526Hg89+GLF4h3QGT5DeEOChk/iT4YVv5Pgn8p7uwfKFJLuSicKZPSEUrWw5sCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phlVH2naBlyaCi1ZBSTZAu7sa7CBKM5i5/EVBHFRUTM=;
 b=bOCZ/n8EAKfcU7pUJ71nj+T5+p/jKQBP2ujcOxeYhWyWcFmvq8BZX14KfDF+voz+o8X0JpTCq5r0UNiSPMXltbHb/VoeHT1upSFuUYoumwN54UqTcUZHuXhbXPdVMn5bXTz9MUAZOfLWZzLKmmybeCgLgFcFTFzaf4gOvEvlIe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6392.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 08:57:41 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 08:57:41 +0000
Date: Fri, 27 Feb 2026 17:57:40 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com, dave.jiang@intel.com, kishon@kernel.org, 
	jdmason@kudzu.us, mani@kernel.org, allenbh@gmail.com, kwilczynski@kernel.org, 
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] PCI: endpoint: pci-epf-vntb: Document legacy
 MSI doorbell offset
Message-ID: <jne6ovpgukznu36lopk7aydv7rmcp3tl4pstn2fo46r6rt5jom@zxz27fgjom65>
References: <20260227084955.3184017-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227084955.3184017-1-den@valinux.co.jp>
X-ClientProxiedBy: TYCP286CA0297.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bcd318-be6c-4736-a4eb-08de75de43ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	jABJ03fJ3otwUqLpRvvpXvmfRGRTug76A1eMONHUBnXAzsTucZ906aG8bD9D/ChQGR1aDwANIn7mXpsd6oh8q3kzVL3u2RA8MnBaxhfyC0IX5hdWWLFKpjen/5dWGeLsx1o0zBOKpt/AcU7TddHPRo7O4wfo7yPZnUfGL47XQMnEU4cIj5OA45DzWoAsn4MXyve4Yk/xadhYqrD3ic2g4GPA3IYJbz6AD/Y3iobIvl+uKoGQw8F2WeDY0igHAIgxRvv3mbK7DQFT840A8ZdnHPSgcbnbkFbgKbW+if84twbbo6pn0F70s8N/WUIAJ3LdoJt/XESGEu7t+a+YBsjp2iwke2QYQkRzqbO0Ltcte1lnCEQ9cgOq3a6riQ/rO+qmKCl3Tp7Ik80QnYRcwQ8RhX/2nQWUfsy4k1UES2UIUnf6m0y3fxr6sLYcNTYk6ZkHHxdCGO44/ZvFWkmJxmunr2QsKl94EIw2a38e+9k1zvT0yrVzCpRI4GPhqZTta32NyWc9hzj63dDkQZrw1Hu8+uZg1ccNGP9KnaxAejMWIahVkc9VqH80WbBzW2kl1UshYvYaUNNuQzu9ZRXxK/ArXBtzUZ12tNWfjT6bL7lBjIEiZp3e2kahUPRGIRxrQrQiqOgHFx1P+AUV65EirI1U9D5ww4GsG7TXry04KaONB9HN8Uxp9ExekVopZFVohhvK7QrjoGQWtOa5mCQEw/6IpxDcx69gHq91vymOr7xlRh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZnNK8Qk3rQu7sWyWVtoJgyfFN/KBPNmP/7l+QcW7H8wayr3+2asvKtSPQAE0?=
 =?us-ascii?Q?sKGtC4RwAhGrrEYDH8l/hjihEQczc2RTEld1QT2Sap85FxyREXO9qaQX0waN?=
 =?us-ascii?Q?ayjmbtmVGE9rXp3mEoPDiUSRQYlePET1cMX4jyUxY+lx8oTz4TXwfgn3NlP0?=
 =?us-ascii?Q?ktpmBYZpwOxsq/ZuTjbpRaYN/o9nsWr/dxTEDVObYGysKZbY2QyLDw5TZunZ?=
 =?us-ascii?Q?ZrjtRSOzD3DAeNNPZP4jydkaNeu4Ql59YMSTZC1SSV+cvl9u1b+POJmwSTxj?=
 =?us-ascii?Q?7LeenGA2vJeAlwd49wuOcfMcjj1rt7UQv7CSe6vhvK0pxHHwFMzk4b+fJgLs?=
 =?us-ascii?Q?p49GeDyQkDAmWPa7ckLZkfgQJjqMv5riAlZ9cVhng0hbkew0+ODgFrDy0ZWK?=
 =?us-ascii?Q?+B4/Xuf23OMx7W8USmalDMokioFgt4WxVqOnAy97IwqByXW6xLkIYAMW/rNd?=
 =?us-ascii?Q?9IDqvb5nw72lzBJhhQKwh8VsfmJxgHODsrMXbpYfTSRkDE3YwImG4flr/dVQ?=
 =?us-ascii?Q?L+PtdjzOc9Wj0319j3w8swbqlLzk0SCGR+p7Hd9scefsA16w5k4nckHxAqCh?=
 =?us-ascii?Q?YmfKBwDOx6X6bBz7OPX706zkayQ0vTvpGax1cVZkFHJz8KAupI+eB1WHFaV6?=
 =?us-ascii?Q?Sxu31gVQDd9axZFBJW2oIHrbcmA7Sagr/FxeLUno4b6Gyh8zeJHUi8h2Xkbk?=
 =?us-ascii?Q?Dn0jbJprj0IYTZ9LLGAovOuo9/vTf71BpKIbz3vVs2Cd+19q/W1JTPkXMGQ+?=
 =?us-ascii?Q?74lOjr1O8JvZ8p4aMzJCx1GG7tr0TiZZxdgT/Da9sxh0LWibJLsg6y5duNpi?=
 =?us-ascii?Q?AiThxBfsOBWtywV8d1mG0fhSD8ybGsdAQHvlr90kHrQO/Ytvd49yMtK23/Yy?=
 =?us-ascii?Q?LOTeBQu/whLF6zOeKGwi3A2aw6b+M2HNPN0tU0R6D7F7Lehkz9SNdvVaZ3qU?=
 =?us-ascii?Q?RYfHnNnmcQD+L+tzzI40KbHA0h5FY1y920Gh7sojvF55laKamE8iaqcLVGDm?=
 =?us-ascii?Q?DZ2mqybaUiAXugRdnUk68k+AeF9FkQi08aBNmLjA6aAmQL8vPjKWxjkvEEnc?=
 =?us-ascii?Q?kiGMFgqRAwofUCYuNDLfUNzjGBQ6MHWJ+RfsYJgL6yAoMUlpkMdJhJ1clqL4?=
 =?us-ascii?Q?gCjXIRC40F2Ow8YbXSJbOul9tEgFyKjjmv78fDZRdS/dSJJf+zlIRG7ZZRSg?=
 =?us-ascii?Q?EoQeT0D7iqN7suQqqlVOXKW0vFJLyGzX0diIC7EsyXoUOfav5t+D4Wspy1ZT?=
 =?us-ascii?Q?ph0eEPkJwQj8bAYGknppcak9QT7mbK9p5xId9SGqZ6NJL/PLi59f+ZKn3uET?=
 =?us-ascii?Q?vTE4SSlbtLCA4qlCsnwJvQMeSkhvHGgLkIhGVMotZLVuVw0LPJ6c9QzhjLbk?=
 =?us-ascii?Q?rpomLKDNfL5bPirwLODo6H4b9P9JP1JETXam/R264wVsQR72DULRQKBykBnv?=
 =?us-ascii?Q?TI5hsx/Cq0kDVEh9tau4w8Z/1Mk0YeORJ+O2JW4FTjTgC1rUWozlTSSqOjVv?=
 =?us-ascii?Q?WNjlGnskxnad0ob0K72oar96SfDoFe2HaM7q3vqkS+HGQSyYSnsVAdomtiHy?=
 =?us-ascii?Q?f7RV8jb6xio5PBlJa0tWU6wpjE6r3BDJ29fnfyIzazH+iWzIppzY8kn3+J9A?=
 =?us-ascii?Q?t7H7QEI+T2c8VM3qtUNZojm8iKK2IC9dfQVifZzdoFquncNTuySoBedDPddf?=
 =?us-ascii?Q?l7wRjhrJFo/N9nhwfwRHHR3h19Nkb1Abq0EpBMj1jxHoXNDeHX4oAD94F3+i?=
 =?us-ascii?Q?4LQCXvIDdmOGcDuwvsH0Kf8j4b3HW8S9yglBekXApSxYqyvsxhlT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bcd318-be6c-4736-a4eb-08de75de43ec
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:57:41.6516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLAHI9nsU579mWE4bsC5RSJKKIR0Q6zUkTHIFYhkk84auiwhpaC/gZmVvkG+Yg112IS46orrCnRxmj/JyEtOdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6392

On Fri, Feb 27, 2026 at 05:49:45PM +0900, Koichiro Den wrote:
> This series fixes doorbell bit/vector handling for the EPF-based NTB
> pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
> per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
> without changing the on-the-wire doorbell mapping.
> 
> 
> Background / problem
> ====================
> 
> ntb_hw_epf historically applies an extra offset when ringing peer
> doorbells: the link event uses the first interrupt slot, and doorbells
> start from the third slot (i.e. a second slot is effectively unused).
> pci-epf-vntb carries the matching offset on the EP side as well.
> 
> As long as db_vector_count()/db_vector_mask() are not implemented, this
> mismatch is mostly masked. Doorbell events are effectively treated as
> "can hit any QP" and the off-by-one vector numbering does not surface
> clearly.
> 
> However, once per-vector handling is enabled, the current state becomes
> problematic:
> 
>   - db_valid_mask exposes bits that do not correspond to real doorbells
>     (link/unused slots leak into the mask).
>   - ntb_db_event() is fed with 1-based/shifted vectors, while NTB core
>     expects a 0-based db_vector for doorbells.
>   - On pci-epf-vntb, .peer_db_set() may be called in atomic context, but
>     it directly calls pci_epc_raise_irq(), which can sleep.
> 
> 
> Why NOT fix the root offset?
> ============================
> 
> The natural "root" fix would be to remove the historical extra offset in
> the peer_db_set() doorbell paths for ntb_hw_epf and pci-epf-vntb.
> Unfortunately this would lead to interoperability issues when mixing old
> and new kernel versions (old/new peers). A new side would ring a
> different interrupt slot than what an old peer expects, leading to
> missed or misrouted doorbells, once db_vector_count()/db_vector_mask()
> are implemented.
> 
> Therefore this series intentionally keeps the legacy offset, and instead
> fixes the surrounding pieces so the mapping is documented and handled
> consistently in masks, vector numbering, and per-vector reporting.
> 
> 
> What this series does
> =====================
> 
> - pci-epf-vntb:
> 
>   - Document the legacy offset.
>   - Defer MSI doorbell raises to process context to avoid sleeping in
>     atomic context. This becomes relevant once multiple doorbells are
>     raised concurrently at a high rate.
>   - Report doorbell vectors as 0-based to ntb_db_event().
>   - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().
> 
> - ntb_hw_epf:
> 
>   - Document the legacy offset in ntb_epf_peer_db_set().
>   - Fix db_valid_mask to cover only real doorbell bits.
>   - Report 0-based db_vector to ntb_db_event() (accounting for the
>     unused slot).
>   - Keep db_val as a bitmask and fix db_read/db_clear semantics
>     accordingly.
>   - Implement db_vector_count()/db_vector_mask().
> 
> 
> Compatibility
> =============
> 
> By keeping the legacy offset intact, this series aims to remain
> compatible across mixed kernel versions. The observable changes are
> limited to correct mask/vector reporting and safer execution context
> handling.
> 
> Patches 1-5 (PCI Endpoint) and 6-10 (NTB) are independent and can be
> applied separately for each tree. I am sending them together in this
> series to provide the full context and to make the cross-subsystem
> compatibility constraints explicit. Ideally the whole series would be
> applied in a single tree, but each subset is safe to merge on its own.
> 
> - Patch 1-5 can apply cleanly onto pci/endpoint latest:
>   f6797680fe31 ("PCI: epf-mhi: Return 0 on success instead of positive
>                  jiffies from pci_epf_mhi_edma_{read/write}")
> 
> - Patch 6-10 can apply cleanly onto ntb-next latest:
>   7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link disable
>                  path")
> 
> Note: I don't have a suitable hardware to test ntb_hw_epf + pci-epf-ntb
> (not vNTB) bridge scenario, but I believe no changes are needed in
> pci-epf-ntb.c.
> 
> 
> Changelog
> =========
> 
> Changes since v1:
>   - Addressed feedback from Dave (add a source code comment, introduce
>     enum to eliminate magic numbers)
>   - Updated source code comment in Patch 2.
>   - No functional changes, so retained Reviewed-by tags by Frank and Dave.
>     Thank you both for the review.

Sorry, I accidentally used an incorrect series title.
The correct subject should be:

  [PATCH v2 00/10] NTB: epf: Enable per-doorbell bit handling while keeping legacy offset

For reference, v1 is:
https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/

Best regards,
Koichiro

> 
> 
> Best regards,
> 
> 
> Koichiro Den (10):
>   PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
>   PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic
>     context
>   PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via
>     ntb_db_event()
>   PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
>   PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for
>     doorbells
>   NTB: epf: Document legacy doorbell slot offset in
>     ntb_epf_peer_db_set()
>   NTB: epf: Make db_valid_mask cover only real doorbell bits
>   NTB: epf: Report 0-based doorbell vector via ntb_db_event()
>   NTB: epf: Fix doorbell bitmask handling in db_read/db_clear
>   NTB: epf: Implement db_vector_count/mask for doorbells
> 
>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  89 ++++++++++-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 147 +++++++++++++++---
>  2 files changed, 210 insertions(+), 26 deletions(-)
> 
> -- 
> 2.51.0
> 
> 
