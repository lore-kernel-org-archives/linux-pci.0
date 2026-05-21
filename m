Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021139.outbound.protection.outlook.com [40.107.74.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA42F3632;
	Thu, 21 May 2026 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779344970; cv=fail; b=b3dutaIzpjMZLC1zzuCWqOXOlNrivdnX3x7Ed5lQqu44K7M3TZ79gcXYU/9N/XQVjgQWe2KOlbe5vMoS0Sfc/OiDEqKeRhKYUT0L2hMN6F48jYGYUQxx6VAvNcE5/eBmPtIhCrWoBMpGdYf8VrmB+Lsqi7su4TA1xHUVZV+KGco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779344970; c=relaxed/simple;
	bh=J7XZsXLhCtxzPRuU1QszvzPUMd3wI1puHbgxN+6bvok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XUQGPNnOJAN/irA3Pe62swznlPVvp7bZDF7bjiZQLQno8asoEc/wZLXdJW/uDEoeKgU4+6tG9HM8HnmINPa99tBKplaiblnp7skPUR1HDrdoaWhaBSinfHEKBiceDPQBkbjPl/3+0KIS2zReEEbyMjhhlycFPPi+O+wINl3IyfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Oqvlha2b; arc=fail smtp.client-ip=40.107.74.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Oqvlha2b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWm9woT9d6n8hH8CELxedlGKOAEjCGbWsTalJQt0W3UOx+jMiPWHapEi7cJvuQHophMZCOKxuqaSjazbcx9Z/vqZVSE7EnSqkE2fQ2e3pPhpaPHz5Nh3QOP+4aGQYuNcm4aMOPi/BtMBwLGkKO20AtqDWLNb5+x0KGpBer7nSuDDhiq4SSLmUWyBgJIFArWAH2j/wnrCWxWYP/ZOgLJtnw4aNBCDpurdRl/jSytVsByPJw+zjG7Kok65B9bLsCoFo9bIokmKOtQ7sLYfiC9PrRkXPmlDD/sdKB4PukKEyGMzCXKoypdqoG98hkx5a6n76Btdwp7iuD6Lgr32DYiOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9uGCR1igDvclB2t0JylEN52Bk+TkJzNLHnfe5OFuSc=;
 b=AwH2PdeGSZYUqECaYwynRgi13sEmJEyStCwlwUheaBo+JV3C1ddB5pZi+5bfHKUH75IZK2qFmaHhrQr/r3MDXico47R3wfEKXhc1chwrbz/amWbNd8oSMqUKKJ/nGmB/HcSC7TBVajLnXSNDUY7FhgfbRRrymYGbXZDVmbMbYthQHsdXNowi/ii4WMaxwEkMpo5jf8KXfIHrudmMY9qsVN9EZ7GgJ9VC0vH+ckfpbGzEh4ET+KQPTtMt8IRuXHjXJUC3hWNaUxHnpxd16L8Jl5/KPTBWO+PNJMtycqWHg9G5CjowsgRjiWGd1ERaPqpksKxapkOcP4HF/ZqBvIbD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9uGCR1igDvclB2t0JylEN52Bk+TkJzNLHnfe5OFuSc=;
 b=Oqvlha2bAC76ilkK3PRYhNcMbiX2JqI2yafmpCSwuMuFVRkeA7L3XbYQ6Q6CNsVTV2/yvAQxrZceQb/PvGUDtX4Tf7myxPFEtACszfX+Z5jd2INbMjhf2PG/5knGqnzfk0fPvcwMQf8/zxgcIua+p8GjVpMvVE1tmGQF3EaPPB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB1594.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:29:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:29:23 +0000
Date: Thu, 21 May 2026 15:29:22 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v4 00/12] PCI: endpoint: pci-epf-vntb / NTB: epf: Enable
 per-doorbell bit handling
Message-ID: <zgleppcjdym7hhoifhk3icze2ptualqwaalcyd45iwazmnwy4q@56dqc5uphi4w>
References: <20260513024923.451765-1-den@valinux.co.jp>
 <923e522c-c288-4ab1-8206-9b7654ec9919@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <923e522c-c288-4ab1-8206-9b7654ec9919@intel.com>
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB1594:EE_
X-MS-Office365-Filtering-Correlation-Id: e49db599-7165-4ef4-3797-08deb7024c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|4143699003|56012099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	nZOIolYyT6bmWeZ4DTWeMfEuftuNzePtTfFPFLxSoyHVKWfaPt5w4fX7CqmsPAQ3UWBnRo8kLi5J/Px3PCKesuE7+Epv8w4RiXPmTiIsG7Nh7UPLSLa57sZxHSmgtlIxQUpp41SEsvpkoJBNeaFa46vwJZd6aUCigsGBB+89CwSjVJ6X5As8RUDgDgutzBw9q1Uj7uYpQC0Z3BRSwiLsOjZkfQZ/g3Kt2FLBL0QViphtqtLGAzaORnktf84nUOy5+R7bPuB0ynpri9UoEcT4dwQEkAdEq4cpM8vYKlql7wYQpbJXZC2fG5jkfWYxbbOPJ8NsMyAC+I1Wf+F84JCiwCgt/HYFXM0g8oGtJ6Xc8n1XuVhlx2Q1Zyc3yXsKolFEM5W6E0FTenz+x2a28ZOUHCqrhhLX1QnISpQfmq0tKT+CBEs2NWXl3UCMyHCvGFDTmPdXIj8/BbgYnG4/6HHGaHyaHyYWRHaecQ3eRuH4NSW67cwr91uo4xQqAvnOt9EYgF8tgkB3lmzexNayhb1zytS5fjoU+ao0+YM30mkSzvTUG2cgYctBRm6kfqjuH305oDrfW5wbHIktKR5xMWnrfbVqpDlm6cpuO0kTWaVdBLcjREJXtRHKBY9n3vMDzLWJBtJRRnEDRuvjvBdFr/r+Hw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(4143699003)(56012099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xgNj2YllaO4fpQAtvlDrhn9CvnaeGyAA/gGmRjywhRL3cQuC1jpemhqFmtkX?=
 =?us-ascii?Q?a1ErC/Zi2hReeN18gmgKYMdRDGSkRPEs9lTRt8YPw84GK3/tBwvqq7mKZr82?=
 =?us-ascii?Q?I/mwIUe7QqLz2Ys7JNnEkvtLjfQIzC4S16woYbi2W1CIbjqvVjB33zhGwyCr?=
 =?us-ascii?Q?kVtKYSn/y1T8Aa4Z1HKAQsqJbOjRFzMBIgnhDl0q5bSlg5XUO3sDAvt1tFyi?=
 =?us-ascii?Q?sao7nA6WRIka3Z52++VW8DQvXXMKBoZr9eAlSPvCxzFtLgyrB0iUTbIRsErn?=
 =?us-ascii?Q?9uaIJr6/llw7PzlBzjqchvaHltI415qTl74HrX/+uOAJ7CtG5oph/LtRmct8?=
 =?us-ascii?Q?DqV5OOow3kpYfyf4PqGMsryXN/1l5jweNyKcIf3BLPqQZdtaoc++fwTtRHYH?=
 =?us-ascii?Q?7aqovx6BJwOuvBg/2fhGsDowefGTaHfzya8Tz0MHZgSA706iER801ysE9CEG?=
 =?us-ascii?Q?CCNlI70jCQkXe74WdG/Nct3Hqxb/eMM9phmcsbK4DzIM2MV3fSIisCTcNYwR?=
 =?us-ascii?Q?XHabcVIcFIoMqDnkRz3xoxQrvRXxzWbVjFk9deq9NYrqTyMH0SJUB+WjF15J?=
 =?us-ascii?Q?y7lZz1Z9SB3nGZGkEiw1a6BM4JwojGopZVclK26Ffcm1v6LEhivRb3TnU1Dq?=
 =?us-ascii?Q?UzckcHhJQNQsmjU6HRjWmhW6GV25UXjiP9/BPow4vRRvV96zrJD4ri8YVhYM?=
 =?us-ascii?Q?0E8dtcTWFRq2jWDh/Yr3Z85DIH8UNG/jLoIHv3qCj8icK6y4pxvY8fuB4fRz?=
 =?us-ascii?Q?Z+1fTwvOmVUTLp4a7pSt9fW1uE3SMxuWdsQ+eoFaoV8fnIYdbjE7M8653ubq?=
 =?us-ascii?Q?Yko9za4RlCt8fHbMMkl2aFY4KNb+sX/5LHz7PSGlywA9B/ovOsn/XFDiER2T?=
 =?us-ascii?Q?DhAgyLJ61qspDQFZnZBCFvKAcud43rhf0oKO8uhGV1EgO2OgCkIdXW1N7fXZ?=
 =?us-ascii?Q?TFKw4GduFh+YsLLSQ/BFOfpg6tEp2abl0VxTl+z+FCpMCpdht9ogFSmITz8m?=
 =?us-ascii?Q?bYY+L0wWCEPDaCkfjVjywUrfQnKRtqotRKzO2+ite7DTbmd6A3GljVRmeSeN?=
 =?us-ascii?Q?Z5Fr1RSdzd+HPr7/3UbXbrJruaoS4wgX6+zB38uVNNBmvEfbT3Ut+aewJ9Ci?=
 =?us-ascii?Q?TLZuAHbrIPukS79v9Kj6/dGrm4P5XBGZD/esHex0nWYdwyds6SkBVOR1XpSZ?=
 =?us-ascii?Q?QYadYAD02/xW08Dxl/iAUVK67Tp8QLHh/LqtzjgUc+VDJBjA4lwV+3LJg5m9?=
 =?us-ascii?Q?2iYuv2ZOvvTfzfc/YxqSAiargF2it4mbzIf3tl7yNFBEtRdKV3UWwahGAqnf?=
 =?us-ascii?Q?zLXTsW7UqNUH6K5l02IZO+nhpk997Qm1P2oh0Xbh81kiNL6Ltw5O3fo54ERY?=
 =?us-ascii?Q?tx0/g7AUKSwI1/ttFiUGjnYqoQztaro3NXWVXa5x7pWXToy27tLaeS8AAZf5?=
 =?us-ascii?Q?edaB7AsFymd7UMAgP0bUo9yM00ZDAOBAPzHaL8nOR6MqSs3ut5jjBbsf4RAU?=
 =?us-ascii?Q?IUYIvFroDmmQMpMq7DmRFlrapszFccwilkwfeM3LvyRspfGzbgWSwqaLne+C?=
 =?us-ascii?Q?tXtIhzz3jvmO9Oyhaj98Bs5zd8nT0jKmreHLtCxCEsA6mwt84HO+zlGju3+t?=
 =?us-ascii?Q?mWhTnIHTr03M4qHWeWFijry8jpabo2wpAW54qn/wIjG8gg9uTbo9z1PWbRVe?=
 =?us-ascii?Q?WaIzNX/p/u0XXcGxYMJmt/2pmitA5c5XQioMezRcrw9hOUqQvdPFu71yJcVN?=
 =?us-ascii?Q?Ua40PeX/ZL5hNKmTlMsy4WDePotMXe71PKIM2Jpc4fP2kHvjV/An?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e49db599-7165-4ef4-3797-08deb7024c8e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:29:23.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uq4Gt20+GObMFPWmH0wTxyPrybw0cpCY7xBAKi9Iihj2dQcdKSpxnzaupH+B8r8dyTQyVhWRFCC1V5/MJgclXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1594

On Tue, May 19, 2026 at 02:29:51PM -0700, Dave Jiang wrote:
> 
> 
> On 5/12/26 7:49 PM, Koichiro Den wrote:
> > This series fixes doorbell bit/vector handling for the EPF-based NTB
> > pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
> > per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
> > without changing the on-the-wire doorbell mapping.
> > 
> > 
> > Background / problem
> > ====================
> > 
> > ntb_hw_epf historically applies an extra offset when ringing peer
> > doorbells: the link event uses the first interrupt slot, and doorbells
> > start from the third slot (i.e. a second slot is effectively unused).
> > pci-epf-vntb carries the matching offset on the EP side as well.
> > 
> > As long as db_vector_count()/db_vector_mask() are not implemented, this
> > mismatch is mostly masked. Doorbell events are effectively treated as
> > "can hit any QP" and the off-by-one vector numbering does not surface
> > clearly.
> > 
> > However, once per-vector handling is enabled, the current state becomes
> > problematic:
> > 
> >   - db_valid_mask exposes bits that do not correspond to real doorbells
> >     (link/unused slots leak into the mask).
> >   - ntb_db_event() is fed with 1-based/shifted vectors, while NTB core
> >     expects a 0-based db_vector for doorbells.
> >   - On pci-epf-vntb, .peer_db_set() may be called in atomic context, but
> >     it directly calls pci_epc_raise_irq(), which can sleep.
> > 
> > 
> > Why NOT fix the root offset?
> > ============================
> > 
> > The natural "root" fix would be to remove the historical extra offset in
> > the peer_db_set() doorbell paths for ntb_hw_epf and pci-epf-vntb.
> > Unfortunately this would lead to interoperability issues when mixing old
> > and new kernel versions (old/new peers). A new side would ring a
> > different interrupt slot than what an old peer expects, leading to
> > missed or misrouted doorbells, once db_vector_count()/db_vector_mask()
> > are implemented.
> > 
> > Therefore this series intentionally keeps the legacy offset, and instead
> > fixes the surrounding pieces so the mapping is documented and handled
> > consistently in masks, vector numbering, and per-vector reporting.
> > 
> > 
> > Dependencies
> > ============
> > 
> > This v4 is prepared on top of the current pci/endpoint:
> > commit f5aa97125491 ("misc: pci_endpoint_test: remove dead BAR read before
> >                       doorbell trigger")
> 
> I can't seem to apply the patch set via 'b4 shazam' on top of f5aa97125491. Trying to set it up for review.

Hi Dave,

> 
> DJ
> 
> > 
> > plus these patches as contextual prerequisites:
> > 
> >   - [PATCH 0/2] NTB: epf: Fix ntb_hw_epf ISR issues
> >     https://lore.kernel.org/ntb/20260304083028.1391068-1-den@valinux.co.jp/
> > 
> >   - [PATCH 0/2] PCI: endpoint: pci-epf-{v}ntb: A couple of fixes
> >     https://lore.kernel.org/linux-pci/20260407124421.282766-1-mani@kernel.org/
> > 
> > (These touch the same code part as this series and would otherwise conflict
> > with it. They should land upstream first in my opinion.)

This series depends on the two prerequisite series listed above.

Best regards,
Koichiro

> > 
> > 
> > Practical benefit
> > =================
> > 
> > This also enables ntb_netdev's multi-queue performance scale:
> > 
> >   [PATCH v3 0/4] net: ntb_netdev: Add Multi-queue support
> >   https://lore.kernel.org/netdev/20260305155639.1885517-1-den@valinux.co.jp/
> > 
> > Each netdev queue maps to an ntb_transport queue pair. With correct
> > db_vector_count() and db_vector_mask() callbacks, ntb_transport can wake
> > only the queue pairs covered by the doorbell vector it received. Without
> > those callbacks, the NTB core falls back to the full valid doorbell mask,
> > so each doorbell interrupt can still wake all queue pairs. See "Testing /
> > Results" section in the above link.
> > 
> > 
> > What this series does
> > =====================
> > 
> > - pci-epf-vntb:
> > 
> >   - Document the legacy offset.
> >   - Defer MSI doorbell raises to process context to avoid sleeping in
> >     atomic context. This becomes relevant once multiple doorbells are
> >     raised concurrently at a high rate.
> >   - Report doorbell vectors as 0-based to ntb_db_event().
> >   - Reject unusable doorbell counts and guard configfs writes after EPC
> >     attach with -EOPNOTSUPP.
> >   - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().
> > 
> > - ntb_hw_epf:
> > 
> >   - Document the legacy offset in ntb_epf_peer_db_set().
> >   - Fix db_valid_mask to cover only real doorbell bits.
> >   - Report 0-based db_vector to ntb_db_event() (accounting for the
> >     unused slot).
> >   - Pass per-vector context as request_irq() dev_id instead of deriving the
> >     device vector from Linux IRQ numbers.
> >   - Keep db_val as a bitmask and fix db_read/db_clear semantics
> >     accordingly.
> >   - Implement db_vector_count()/db_vector_mask().
> > 
> > 
> > Compatibility
> > =============
> > 
> > By keeping the legacy offset intact, this series aims to remain
> > compatible across mixed kernel versions. The observable changes are
> > limited to correct mask/vector reporting and safer execution context
> > handling.
> > 
> > Patches 1-7 (PCI Endpoint) and 8-12 (NTB) are independent and can be
> > applied separately through the respective trees. They are sent together so
> > the two sides of the same legacy layout do not drift apart, and the
> > resulting code stays easier to follow.
> > 
> > The plan is still to take the whole series through the PCI EP tree once the
> > remaining NTB acks are collected. See:
> > https://lore.kernel.org/linux-pci/rnzsnp5de4qf5w7smebkmqekpuaqckltx73rj6ha3q2nrby5yp@7hsgvdzvjkp6/
> > 
> > 
> > Note
> > ====
> > 
> > Most v3->v4 changes are responses to Sashiko feedback:
> > https://sashiko.dev/#/patchset/20260323031544.2598111-1-den%40valinux.co.jp
> > 
> > Sashiko also flagged a broader driver-unbind lifetime concern around the
> > vNTB PCI driver. That is real, but it predates this series and needs a
> > proper .remove() path, including NTB unregistration and work cancellation.
> > I am keeping it as follow-up lifecycle work:
> > 
> > https://lore.kernel.org/linux-pci/20260226084142.2226875-1-den@valinux.co.jp/
> > 
> > This v4 only clears the deferred doorbell state added by this series around
> > EPC init/cleanup.
> > 
> > 
> > ---
> > Changelog
> > =========
> > 
> > Changes since v3:
> >   - Rebased on the dependencies listed above.
> >   - For Sashiko feedback on state added by this series: clear
> >     peer_db_pending around work enable/disable, mask peer_db_set() with
> >     db_valid_mask, and use __ffs64().
> >   - For pre-existing issues made more relevant by per-vector semantics:
> >     stop deriving ntb_hw_epf vectors from Linux IRQ numbers, pass
> >     per-vector request_irq() context, ignore the reserved slot, and
> >     validate vectors before BIT_ULL()/ntb_db_event().
> >   - Added adjacent hardening: pci-epf-vntb db_count range/configfs guards,
> >     bounded db_vector masks, ntb_hw_epf mw_count precheck, and helper guard
> >     cleanups.
> >   - Dropped Reviewed-by tags from patches that changed to non-trivial extent.
> > 
> > Changes since v2:
> >   - No functional changes.
> >   - Rebased onto current pci/endpoint
> >     e022f0c72c7f ("selftests: pci_endpoint: Skip reserved BARs").
> >     * Patch 2 needed a trivial context-only adjustment while rebasing, due
> >       to commit d799984233a5 ("PCI: endpoint: pci-epf-vntb: Stop
> >       cmd_handler work in epf_ntb_epc_cleanup").
> >   - Picked up additional Reviewed-by tags from Frank.
> >   - Fixed the incorrect v2 series title.
> > 
> > Changes since v1:
> >   - Addressed feedback from Dave (add a source code comment, introduce
> >     enum to eliminate magic numbers)
> >   - Updated source code comment in Patch 2.
> >   - No functional changes, so retained Reviewed-by tags by Frank and Dave.
> >     Thank you both for the review.
> > 
> > v3: https://lore.kernel.org/linux-pci/20260323031544.2598111-1-den@valinux.co.jp/
> > v2: https://lore.kernel.org/linux-pci/20260227084955.3184017-1-den@valinux.co.jp/
> > v1: https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/
> > 
> > 
> > Best regards,
> > Koichiro
> > 
> > 
> > Koichiro Den (12):
> >   PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
> >   PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic
> >     context
> >   PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via
> >     ntb_db_event()
> >   PCI: endpoint: pci-epf-vntb: Reject unusable doorbell counts
> >   PCI: endpoint: pci-epf-vntb: Guard configfs writes after EPC attach
> >   PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
> >   PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for
> >     doorbells
> >   NTB: epf: Document legacy doorbell slot offset in
> >     ntb_epf_peer_db_set()
> >   NTB: epf: Make db_valid_mask cover only real doorbell bits
> >   NTB: epf: Report 0-based doorbell vector via ntb_db_event()
> >   NTB: epf: Fix doorbell bitmask and IRQ vector handling
> >   NTB: epf: Implement db_vector_count/mask for doorbells
> > 
> >  drivers/ntb/hw/epf/ntb_hw_epf.c               | 133 ++++++++---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 210 ++++++++++++++++--
> >  2 files changed, 296 insertions(+), 47 deletions(-)
> > 
> 
