Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021099.outbound.protection.outlook.com [40.107.74.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7103A6B7B;
	Tue,  7 Apr 2026 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575299; cv=fail; b=Yy58nqL/5oWFm1D49JXQpv3hZSGC2dpybrsJFzBLOkzdfnh+Kw43+/bADTZhEdhDoNZMD5Uu3jFodDDQT7Vm/lJCaoM4ynwYxqcPvXXQiXYyQDjzhoH3+F8NsrCYh9KQY2pgRjwMOsWO8Nh2XfS3k9F0hPMr1LBhF4uksA4G8bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575299; c=relaxed/simple;
	bh=S/sfmFCgO+5eXibei7uPJW1gCJKF04IIjw8QvE+a4nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tl2P11xvnekBvnSyw+FA+shDcF1us6+KC/q+fT1AppT4OyjlqV0znmw3Yz4bce1IVE2hk9zeAxu1M3I7QA65OlACAGuACLQqG4WepTHVma1lNYuqYM8irTa0zT6txvaBdb4DA0ruG89hpxuXnF5sewGQcBuP7sUDm2C/re5ZSuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SewMEJAX; arc=fail smtp.client-ip=40.107.74.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SewMEJAX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwnmkQH4gTCOeIMqPvcHUYuN4VeN9jPDIDOOLaR1Sq40mm8TyVJcH5O2dXRLmM7/gbMB6LHKfH9B0SCtpwXKZp6L9FTiOA8DhIHdtVo/JklWlrk9c42RPk/tjy4hk3wBYl5zOop2WMo/y/oJSfrZ0AyhcpwQkHUFHZHCoqrBBOFgPsAq3I87h9Qsy+apNih2QJkOUVZLKDOfz2zOqWOx/ISAs39kn5dUKZMSQVtKu8BtOqHsd9eWsgk7T67ABcGPHVRs7P8KyZKCCuGTM4b9WNmmhsfiqZSCCLQkAkpJF/sblppYxzTXIgr3IgLnCxbTXRAXmC6HR1uv+azgyHUa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3G3MR3ivdqdkNnwJELerpQp5AtQfVZe41NaSEGN1vU=;
 b=HBEGiK8uTUgdUU8dDBLiinvJkRMhS9XTut9X8MeWNgiPQ+PhCkg/kGdpUM/FD5LHaFMq5FtORddklG09cSNT/ujp7+HsKgGot4vFNE5MDE69F5HgaIyE/IH0KEKDkoZorQv5WTilUCaumTOWgg8JICjPjEWuDu38dx2H1hTr1NRuzdlhUl8ZueP+WpNc7FuEawZa0cqm9ehCPlHq+xTfd8trv8sYRYZFgWkUZYeV4EPiMm/9aN1rfAZWVxPr2aDT/sjh2GJBL4aCWu20TzUFJOfUUzsj5z506xNbD2mwAj5sdoChP18CoawauRUOm54PpWQssjlvzTnNmVMCdb9YlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3G3MR3ivdqdkNnwJELerpQp5AtQfVZe41NaSEGN1vU=;
 b=SewMEJAXSq84wg8p4+GBr6OR3APnue0VZKksdtlPUlQ1prLaOp5pW+S8QmwXFomk0UmVGxdAiN87iumxmTOa1mBlVQi7CLrB3tMCwmprSSPQuRXeU11k+zLLRF/j8tKQKrtaE9kfXKsUzhwfrK2PMDS9jxdt206OMj1JADA+c1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6323.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:40a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 15:21:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 15:21:22 +0000
Date: Wed, 8 Apr 2026 00:21:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>, 
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v3 00/10] PCI: endpoint: pci-epf-vntb / NTB: epf: Enable
 per-doorbell bit handling
Message-ID: <64nprproiiwijfwzcizxu2aorieyy7rhek5qq5imgxomtdlrsk@47fdrlbff6o3>
References: <20260323031544.2598111-1-den@valinux.co.jp>
 <7jkibbdz3m3vuq2kq2xxnkt2rjdt5v7itgowc7qormtwgnf6tv@krl5brfjul5y>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7jkibbdz3m3vuq2kq2xxnkt2rjdt5v7itgowc7qormtwgnf6tv@krl5brfjul5y>
X-ClientProxiedBy: TYXPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:403:a::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dbce5f-b714-448f-1938-08de94b953a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KRTGGcuhvvMJlC1HyZYopz23q43ebaw7k5+890i9XgA9Z4LLr2hDtuGmbzb3Xyntnkm3kEB/a8To0GKZ6ybiaEZqTTlYrLfMKVjDrCtW7ZRcBS1eAW7YR4GM8U93HGpBVwuj5EHfMSwhE8nLXxCjeTA0UXCrTKrBS4Ly8qauVHXXJIZ9ZX+GTUTaOG0wmZGnN7oMTjSchOS8jj8p1C+DGDdRTJBBY1baNs9OJ2wgBkASlxs75ZyJolbCyWI/sZO8yqS6Y/sYyz7n7v2zstdR/6WBDUC947F2QL8PfY2oWBeozMvqfWUCZj2tlMVcsesUXXRzW+eCs8a4nxXe0DT+C5AQJR7/D04p6Kzh3OULHkLHXtEbMxp2VLp7NV3s1LQIfaMwoGwauFqycKZNTXK8EOkgmSt5yWGjm/ft2vmWEmzzD3453NqKgoMlx8VC/jM9pWURZ6IewyGB60jzMHlXbfWuKh/vp06LQdn/JSnFTC5ecRyT7stwMDG7cUMKcznMKdAUlJ03rWEhBka5RLvRGMNlkmFlmNsF+dJyvPXQU/mB+fkBIOroe+9nBT3tY30f9FN/J6zaIrfJhfz4/L5VxRcvLHpmQT9zBoXwvSjkyqodZYoo7VNbt0uFXyHcfdNVyjCuUOkpHPoknei6q+TH1TQ/UJZbFOlwu89YWxJh/VfkynR4gBwlwYaTWEh8rv/B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Eh4j1b9T//6Luxi3VRmuaRKW2/UXsn1RCFaRkMg+Xlt74U9D7REqLsiS1Ut?=
 =?us-ascii?Q?ouEIRFiuEdybh7f1H1cAiUKQBSYpy6VcHLrIuKy9tIKuft10cMtnUW5TRXMP?=
 =?us-ascii?Q?wGQ0MQd9sbLgsbStQ7KCWdWBQnLfXQbVF8A1TG5lhMooE2itW9uJVLsv4dUU?=
 =?us-ascii?Q?nzzpNY4wfJoMqDTw2Ob3aQJuRTQjFvnx9auulSV+fFlFDK6Z4cc+qDPB3Cru?=
 =?us-ascii?Q?Y/Z2rSaYvfJMsIw23hEULLmH0P3SYVbK49kvfDNwMDOi6b5UKutuBq0elU64?=
 =?us-ascii?Q?X9JH6a0SFyOgDo6M35lLl2RwkFljga2ukTcTW1XfYSeXUq2Eo5O03fkG3JjO?=
 =?us-ascii?Q?sCMkvYUDcg07JebW9H8Rx/f8ZLZaoqsBMy5p9ApdrfaictsOGV6WyytNaINb?=
 =?us-ascii?Q?azdmBlBdsPLjpiSW/+lNt7VzwAzG2tuE1Rm7MOiaKs2+qAABytLA39+PK4n2?=
 =?us-ascii?Q?ag8cgaxGqSiq8b3gycPFhcmA8UsGhNAHmBsqUpbO+jXsp1VLLKz+t+B1UYjF?=
 =?us-ascii?Q?tSeSibDRgGwonZaX4Dz00W2uo1RbebG26O3JAeVIiB6rCEWUhGVLfK+5TETI?=
 =?us-ascii?Q?yLJXq91IgoxHYNUUZFqnAlx4Ba9Mbs1kYENcm/JjeDjVl15aI1+VsEWItCYQ?=
 =?us-ascii?Q?aqKViCX9TMw1bJQ7UcHxrZ1x8/Rud4tMSVW4i7bPJt7zwB9aQbJUkXaKEGpg?=
 =?us-ascii?Q?W3CuxR5nEfaabYXlzHfk7UawmSwcueXU4PK/QjgWFyjZeid6sdK5oZRi+rv4?=
 =?us-ascii?Q?rh/A7jlhJiusbzFwPTC0jd8sWuyGk6XVeHGc7j3PFzWIQGgfjVXIMCuV2iJU?=
 =?us-ascii?Q?M6tMJfm7Gaenp+/6m3mkDk9z894qQ4MdCMcAtordiIB84ntS512Czr+dkCoX?=
 =?us-ascii?Q?luIo7jI8ut8EMdrcrUbQ0+lY6QemDiDEDGkETTWHf59z0IXhFaReHW2QMhnW?=
 =?us-ascii?Q?0/gCMdBpgoMFhWfFHOon6DH9LkrQJkwMxZQ3fciPIfEyijInVQ2CdqbWpeX/?=
 =?us-ascii?Q?og7T9wpOn5i862K9eJQDV3sLVCRBajpCDEZQVYtVCwU3NvNDLdccbMyNFo3c?=
 =?us-ascii?Q?X2M78HcZbKan1ksgWsf7orm5nXnRbW6SZmcMQ2vuKQiDHVKkiqigTra0tZZs?=
 =?us-ascii?Q?vqKY29TLIJcC62NJ8wLQSVn8cvl6OI/sMwswYWCtwbMC9hE+Hh5CV9o98pfv?=
 =?us-ascii?Q?UtZhrYcqOhQrPtzDdnNeC++SxzWjBxEBzhOME/fUVZakjmNo1EakyJiA6B92?=
 =?us-ascii?Q?6/KUTe6uzedJTDXeDS0SuQebUPzgNKhEwjuKNYJb28pcKzG8C8S0Lz3Ip6E2?=
 =?us-ascii?Q?CZt/7JsSZAdWXqsmXH2jTX0d7lGxERJqn09PQPKL3GOzqzvu219x2g+Ik5pK?=
 =?us-ascii?Q?gy9x7dBgNoktvtSjdpiJo0TXINhNea/RAGBzMuYY1cP8EmewGbsnbkKG4QF6?=
 =?us-ascii?Q?Tc7ID3Yiwp7bzyCLiDOJsGi2ZhyKxsvCk9oiVdtbCKKbqQGPsbPlJugF1Idj?=
 =?us-ascii?Q?tbHbqYloQP1XeVLgdVbpZILBK5gaSkcIy2yP191Av2J4iv5LaxbWoUGeWgJa?=
 =?us-ascii?Q?WPowsby1RfOjp2Kc2ZWriQC2AmFSwazq+iudwZDBjGSXBYKcPjc9JXTjBYDB?=
 =?us-ascii?Q?mWyFixFyLxNKi+AIGdV/t8lJUQycgfYdy+vSQSxoXoz1cI9ZxryNN4N7lbCv?=
 =?us-ascii?Q?xaJs2QdDWim056dWTEtEBXZt+fxilKDYPjm4I6N6ZVGY5PtpOX3gMXN8Yi7N?=
 =?us-ascii?Q?7cqBqVvY6hQcJ7yh9IcKGbs9oOeV8ayg71FwPwiLfncnyrbNjmKc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dbce5f-b714-448f-1938-08de94b953a6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 15:21:22.7256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cS00GAeoGc+bMzkyQKIp2ux61KWP+ncuwfvnljixQDv8u6k3hKPdvpjmwDJJBJEtK0zW91LC7s3ZkCqENNCjYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6323

On Tue, Mar 24, 2026 at 12:43:55AM +0900, Koichiro Den wrote:
> On Mon, Mar 23, 2026 at 12:15:34PM +0900, Koichiro Den wrote:
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
> >   - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().
> > 
> > - ntb_hw_epf:
> > 
> >   - Document the legacy offset in ntb_epf_peer_db_set().
> >   - Fix db_valid_mask to cover only real doorbell bits.
> >   - Report 0-based db_vector to ntb_db_event() (accounting for the
> >     unused slot).
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
> > Patches 1-5 (PCI Endpoint) and 6-10 (NTB) are independent and can be
> > applied separately through the respective trees. They are sent together
> > in this v3 for convenience.
> > 
> > Once the remaining acks from NTB maintainers are collected, the plan is
> 
> Hi Dave,
> 
> When you have a chance, I'd appreciate another look at patches 6-10 (which are
> unchanged since v2). If you do not see any blockers, Acked-by would be
> greatly appreciated.

Hi Dave (cc: Mani),

Just a gentle ping on this.

I'd appreciate your thoughts on patches 6-10 when you have a chance. If they
look fine to you, an Acked-by from the NTB side would be greatly appreciated.

Best regards,
Koichiro

> 
> 
> P.S. Regarding Sashiko's feedback [1], my understanding is that there are no
> blockers, but there are a few points that would be better addressed separately
> as orthogonal follow-ups:
> 
> - configfs knobs mutability and bounds checking, including (but not limited to)
>   db_count.
>   In my opinion, allowing updates after .bind() looks questionable, and
>   returning -EBUSY once bound seems more appropriate. I'm leaning toward
>   handling this as a separate hardening series.
> 
> - ntb_hw_epf IRQ unwind concern.
>   This is what I was trying to address in [2], which I hope will land soon.
> 
> - Other lifecycle concerns.
>   These are largely tied to the current vNTB implementation and were part of
>   [3], for which I still plan to post a follow-up series that adds .remove()
>   implementation to vntb_pci_driver.
> 
> [1] https://sashiko.dev/#/patchset/20260323031544.2598111-1-den%40valinux.co.jp
> [2] https://lore.kernel.org/ntb/20260304083028.1391068-1-den@valinux.co.jp/
> [3] https://lore.kernel.org/all/20260226084142.2226875-1-den@valinux.co.jp/
> 
> 
> Best regards,
> Koichiro
> 
> > to take the whole series through the PCI EP tree. See:
> > https://lore.kernel.org/linux-pci/rnzsnp5de4qf5w7smebkmqekpuaqckltx73rj6ha3q2nrby5yp@7hsgvdzvjkp6/
> > 
> > ---
> > Changelog
> > =========
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
> > v2: https://lore.kernel.org/linux-pci/20260227084955.3184017-1-den@valinux.co.jp/
> > v1: https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/
> > 
> > 
> > Best regards,
> > Koichiro
> > 
> > 
> > Koichiro Den (10):
> >   PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
> >   PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic
> >     context
> >   PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via
> >     ntb_db_event()
> >   PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
> >   PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for
> >     doorbells
> >   NTB: epf: Document legacy doorbell slot offset in
> >     ntb_epf_peer_db_set()
> >   NTB: epf: Make db_valid_mask cover only real doorbell bits
> >   NTB: epf: Report 0-based doorbell vector via ntb_db_event()
> >   NTB: epf: Fix doorbell bitmask handling in db_read/db_clear
> >   NTB: epf: Implement db_vector_count/mask for doorbells
> > 
> >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  89 ++++++++++-
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 147 +++++++++++++++---
> >  2 files changed, 210 insertions(+), 26 deletions(-)
> > 
> > -- 
> > 2.51.0
> > 
> > 
