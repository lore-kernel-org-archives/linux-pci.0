Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021128.outbound.protection.outlook.com [52.101.125.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10AE395DB5;
	Mon, 23 Mar 2026 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280639; cv=fail; b=SN6LsbDX58Wi6DZBI4dThPAqyDTxQozrIjDt+0KyNti4VilhDzzYwku3DjIhYtL0Fkd18O7rGMBR96k+40zKsuxopu0JGR5Uex8Axeqon0EI45w/ygAkbXw+nOLBMVfEUOOJbxTuThFV6WTwnzIY1inHbUQR0/aAivCYQ6D1OEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280639; c=relaxed/simple;
	bh=oV5R/CdH03FCzQdJKkIs8BZP0QY1s05FA4OXTy1Jijw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q8PfOO4frRJcdRXqOwL04bXnhAy0tpFnobi0Y7n17QGY8lZVBfe7h1wPi+cMEzsjXbH9Kh9cMpeaZ5PLnO9cJDaAE/pVm0T/utH9/cxGFq9eRcS0eAcGQPkyzJRQ4OXRxji2m5P/BbyCpJhZlFh+I8+/9SlAmPQlOSi5qBfjEPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=F/wj1jyF; arc=fail smtp.client-ip=52.101.125.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="F/wj1jyF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbVXt65sCDjcy/fRdusl4lL0dtw1g+7vGnFQ3CXO+qt97Hrod4UFctlbjy29rgl7V28f6zu8MPOeU7jI2Hn+EPkaQG7CltuovJH8WIojDTpFOJMwOP2b8ld1PaHWsK0vVdPVw+z26CiWinrM+8JW/h7MKhMezzbYnq+HOgTXDZc/WpRqfIlgdWdzhCkzCDqFvArb0JQl+JdDLlOvL0BS8XNojO2CpDDuFGCCV3Uub86tkKLrC2ahCAaLGGrVUdf2LG4JSEzvMekhRxoVhqQCzSS1dLBH9hFv9lmbVd2I3OJxh+F6VBed0bwB/2Wf2yY4KiV2ymMl4tNp+aK1cxDTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DarHAnZPTp0LE89v+oMDz1wBrOvzh/7TTPWc/n2yniM=;
 b=maaZ788PgEuUoLNA3Kukzsn4KDtFA/3W2yOekVPfDsQrETNxVNE+iHjEJFy7UjLfHVKpSfd2xP9k9WtgGdCqwHQtd/5ZfCY2GCdlRqESeOb3Zek0YQ020wswNHFlQAuqt0COFgCUAQikedd3Ymu4v+hJfT8Y5XE7HTnFGZbxvvfrywr6tHNc5uA71AqWWxKoiZErpRX30KsODHE8SKAqvaIDxQp0bjQDvmJGMpw+rFzJZXdy20kyhRmza+5kAsIqvDLiyadwomOIXa/JDac7kjoMB9oKgZ/ONQqTHU7S/yrjfu3IjmH7huMLjzwn/9wjKl5QPCKYqyAdGJ7R1q0kEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DarHAnZPTp0LE89v+oMDz1wBrOvzh/7TTPWc/n2yniM=;
 b=F/wj1jyFy+cX0z9yE3tG897MGQf+sONSVDfgTEIPqsZSpHvXbu1CD4NdxmmhwsBUftG/fL37ghfJx+8xtBQ8hvSymmAI0Z1h7POYH4AkGjrZYQHG197re/PKxmnsc/iw6oLySn5kLOv4aQVKkbfQm38t5UMcCvK0sFSh1jJIpzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2728.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 15:43:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 15:43:55 +0000
Date: Tue, 24 Mar 2026 00:43:53 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v3 00/10] PCI: endpoint: pci-epf-vntb / NTB: epf: Enable
 per-doorbell bit handling
Message-ID: <7jkibbdz3m3vuq2kq2xxnkt2rjdt5v7itgowc7qormtwgnf6tv@krl5brfjul5y>
References: <20260323031544.2598111-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323031544.2598111-1-den@valinux.co.jp>
X-ClientProxiedBy: TY4P286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2728:EE_
X-MS-Office365-Filtering-Correlation-Id: e989b76c-b107-4b9d-b2b5-08de88f2fd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ysZgIwoPIWYsAQk8HLk6Heg4a2KWvQkWixJ2+Wqql/S5MDhajB41wvL0DWM2GorqHTBp/RGF9HqBealLnEy83XuYxpo+3CMcgeOr1yDno1JgE3lQfR3jVOcK7Uow05+HOvg5/Rikf2eEHe+dUehGGiwvhudhgq7XmAd424Ncy9V7VYbqMpX+dZA8p7ukiASDOS+TvaimV0Nwvo7wOvUhgxZJR0DllNmRujWu1asO66EFpPIUlbhreg0sHNtnglmK9+1kH1C4FbPCGgUx6KRXb7ftvVACOshBa65sGz6UJYam93ELN4s3VehRQ64i1wwFcgK5r98/UtHjmv+leqvjGuIRNdmrQtcpNHwLcFZZfTH2Zp9msdXZA+knKgdei2C7vejDiLQfA6T+EIASao9ahusQJT2IHtWr9ZMdepfIHW9EOebGVI9bpF6LtzY+zRaszO1urcFZo+rLj5P0ZwH5tgkFmFXJNoyzWsk+7TE9gzxlrPhczIJas6w7VkCRYytuj9NlTkcFIyUoHOe9KzNVCF2nWXfGFSioyChHbC6hN7gIqeGygPI6CTSYybCQZQW7bYijULKtFvBDoSZ+NizXWONpCYwmq8DtCTED6kFKaLY1ml4o3wQcPO3eVYFbElB95PdB2Ub6yq2gYUKQg3DUvvT2wiaHdmI2CkSCd206Pwie9HPY3bztJpQ9ws0LP2ozS22LQ+2DhwIzmhqcIqd2dGsaF2uMdF9pdbjWvMdnJrY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RMeeEFIloKkbMFwRaa9+JQWz/rE6hycO3iwo11zAz32/lfqKeMLc51v1KmcB?=
 =?us-ascii?Q?YYGcqy6NmlwbE9kuu8JRSI9Sok9oMMDzOBzFpwGb6Bvgl5p7a7+Vxsab2Xxb?=
 =?us-ascii?Q?Kx9cIID5vjc/2dvnZVX2JfrpvDs3o7BJUm/OWhfAmjx+pxCho0d6DqOSrn1W?=
 =?us-ascii?Q?Y1vBgocGNoKt9i0gPIegwI47H75QT5lLOz2Z5Ck7cbH5otw+aC0kEaJKP9To?=
 =?us-ascii?Q?a8o6YS4lOkZpxf6OucSnRNI3hYIpbT1EDrbbIJhO1IOHBod57gndHiBKnz1j?=
 =?us-ascii?Q?t1GAltoTL2YxA8LjAy68qpG9dTMg7mYb90nCK0YzwGMebk7NuXC4zICMV6nA?=
 =?us-ascii?Q?D5hntCd6++LBIwVZsKVfQT51GOn4aK0IpdxX5hVLRQiKViWvD61utmgQwf28?=
 =?us-ascii?Q?II4XestsF0G1EtUuGYa5jT1RCOFz2nY7GWoBY8yxy0toaBJwN9LMvpI6+Zj/?=
 =?us-ascii?Q?a4GS6npRImyzEAXugbI7k6p3MdwY517RlIi+c22oeTlLE2FlnJ+CyELCbIFd?=
 =?us-ascii?Q?y3lFukC7acO3Bm6uAzInDBQo7wGVszLWC3ANAivh4SR7Z2oFFu2Kxp4edvEi?=
 =?us-ascii?Q?BgEQsr+UG80yo+3XDVjnVm8EScjMn4fqFLVg06uPf02RnHMkU1SxtQxRaE8v?=
 =?us-ascii?Q?mNqvPRfaOfy1HgD2rpumk4WMKlw6mUwitb5IfO6uQoRCs2ySR1yrL/yVNJLf?=
 =?us-ascii?Q?5V6vUSm7QADS82i5m1meAGamcZRSKTf++S4gBzO740ThjhAEwTiQw/33x7iW?=
 =?us-ascii?Q?kdKEBJRXoDEPzIopgg69MRra/4L6dvL0kbt5C826Mj6UbMF/dlKfprawaZmB?=
 =?us-ascii?Q?vOGUl/yTK4Dj2Xa90sMojlMVK62jHSbrtqi5FoJd1kob5ceOH64PkXnaqfVq?=
 =?us-ascii?Q?/kQiu6bRLyjt0+HDRr0oyXIAH7g60zKUSQvxoWN+ZoL5sSpxmGXjWnOomCva?=
 =?us-ascii?Q?QOnA/fTyh19Bxnw5R8A+nyq0qgboJ2w3l2DLlMUrdlsgtPCetJGcfUdWLaVd?=
 =?us-ascii?Q?axSfrzN8CwFoaPtFOEFABqOfWoojtZW5dGtXxN25fNk9sFQoo8ODD1WUOMSL?=
 =?us-ascii?Q?csYO7KYCfuzY+AYggPbEUo9Gcqu3D+JduX6bBmQ6LEzAyAlKIx4BaCk+k5cD?=
 =?us-ascii?Q?NuVRaELegz/fQghId9EfMAW/ipuMnPe5tgxFR8HX5bskY6ZCxg0crL0ExC9J?=
 =?us-ascii?Q?/6yl4wZE+kSDREAdQYCpb870fNq4rm2FAM+VSwbTmIPZCtLBw0y6WavcrPyv?=
 =?us-ascii?Q?4k9OlqXNfPT5RV8UGXloGCb+8ryhCLfx7pkoJBnLi2lqk1b2dME+ssRuBKbQ?=
 =?us-ascii?Q?2bK9eNaKjNAAkqsb61CZgBC5JMF4StA0kp3xdxoy0wxeTK3FNR1zClGkK11/?=
 =?us-ascii?Q?UuyDN3DNeGUDPU91sP/x0Leu2LleOW8/1VBbBaQY3ON6HfKNGh9dPW5tvyvV?=
 =?us-ascii?Q?DSYYYkQlc1d4DyGaeK/jmvbbknmRIJSO4DvxyOV2PsOe3WzEK7J3Tyfikspu?=
 =?us-ascii?Q?eHqVUikdXikFFG7X6aUK1TA9rM0engaKD6C8k01UXQ9pEqjlXzxBaF5KpthU?=
 =?us-ascii?Q?FcxWEfl7A8glegrHZHPcIEEJAxPZb0M4ByPXHlXfvN6PbEzF8JjGey2L7FEB?=
 =?us-ascii?Q?EpHb1g59qmKfYytSd8bCvoPYzeml3ENKAUfKZ17IIbXc50PTkuO1O9Xzcsbv?=
 =?us-ascii?Q?Wj4M5QIXbWdQTZt3xX49/YUbOGO8MAsUcX5G9zm2LB9Kafh0/1xcfWt5VJzH?=
 =?us-ascii?Q?M8dAXXMa7Cuhw2LrMxObEIgLzUFOw/bL7N9UHik0zCwiUrQoewCo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e989b76c-b107-4b9d-b2b5-08de88f2fd91
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 15:43:55.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0q5HG/8GvzshgI4ED95QNhpDKKl38maoJnHOaZeAIKmcPmRSXJ8hP9WN4Px6EY+KQmMcnmcWX71/jpBp/jDYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2728

On Mon, Mar 23, 2026 at 12:15:34PM +0900, Koichiro Den wrote:
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
> applied separately through the respective trees. They are sent together
> in this v3 for convenience.
> 
> Once the remaining acks from NTB maintainers are collected, the plan is

Hi Dave,

When you have a chance, I'd appreciate another look at patches 6-10 (which are
unchanged since v2). If you do not see any blockers, Acked-by would be
greatly appreciated.


P.S. Regarding Sashiko's feedback [1], my understanding is that there are no
blockers, but there are a few points that would be better addressed separately
as orthogonal follow-ups:

- configfs knobs mutability and bounds checking, including (but not limited to)
  db_count.
  In my opinion, allowing updates after .bind() looks questionable, and
  returning -EBUSY once bound seems more appropriate. I'm leaning toward
  handling this as a separate hardening series.

- ntb_hw_epf IRQ unwind concern.
  This is what I was trying to address in [2], which I hope will land soon.

- Other lifecycle concerns.
  These are largely tied to the current vNTB implementation and were part of
  [3], for which I still plan to post a follow-up series that adds .remove()
  implementation to vntb_pci_driver.

[1] https://sashiko.dev/#/patchset/20260323031544.2598111-1-den%40valinux.co.jp
[2] https://lore.kernel.org/ntb/20260304083028.1391068-1-den@valinux.co.jp/
[3] https://lore.kernel.org/all/20260226084142.2226875-1-den@valinux.co.jp/


Best regards,
Koichiro

> to take the whole series through the PCI EP tree. See:
> https://lore.kernel.org/linux-pci/rnzsnp5de4qf5w7smebkmqekpuaqckltx73rj6ha3q2nrby5yp@7hsgvdzvjkp6/
> 
> ---
> Changelog
> =========
> 
> Changes since v2:
>   - No functional changes.
>   - Rebased onto current pci/endpoint
>     e022f0c72c7f ("selftests: pci_endpoint: Skip reserved BARs").
>     * Patch 2 needed a trivial context-only adjustment while rebasing, due
>       to commit d799984233a5 ("PCI: endpoint: pci-epf-vntb: Stop
>       cmd_handler work in epf_ntb_epc_cleanup").
>   - Picked up additional Reviewed-by tags from Frank.
>   - Fixed the incorrect v2 series title.
> 
> Changes since v1:
>   - Addressed feedback from Dave (add a source code comment, introduce
>     enum to eliminate magic numbers)
>   - Updated source code comment in Patch 2.
>   - No functional changes, so retained Reviewed-by tags by Frank and Dave.
>     Thank you both for the review.
> 
> v2: https://lore.kernel.org/linux-pci/20260227084955.3184017-1-den@valinux.co.jp/
> v1: https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/
> 
> 
> Best regards,
> Koichiro
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
