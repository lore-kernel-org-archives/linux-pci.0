Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C71F3438B9;
	Sat,  8 Aug 2026 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208667; cv=fail; b=UT+nVz5PR+aMgxhnkz/xW5S2SdNZi5kBIbvR3voB8dlryFYXa/DPDDk9wFM9kcQrJjQsdISucHR0ZMC9/KGG4tSLCBNxZ5DZ05KLf/dVeE9pnQ5elyJFlrawBcUpjdpAphjJ3pkcj1M8K9ryf6axCAIFMgLkKwjP2drQanxSdH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208667; c=relaxed/simple;
	bh=IYgt3eMq+Yh7uVlh+V6J8tNPeJ0J01S7Dhjor3z4SmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ECJJdPRiKcKNK+bJJxa/Ty1KovL4L7FxYXR+FTXd4vxD7ikG+OyH7KSF+jOIpTDCali4TcetLyhgpYDm3u3opp4kiPXOsCB0R/3NKCOpUqqDkKyGkYWW+h6/Fpq33K9epxKaZtOhbrFstEfv3jGh9QcZ9egtGoben3qA7Y7xaZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pFukO6AE; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pFukO6AE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TY1bawj3+eUltcsTkxSjsckNAu40CY7Kq9lW83cIaG0GMchsr5CvaV9mkuKRAnuCowsuBn9quS+o0yxYzFvlrZJdbqiO8YXcA7+XK1n7RKkB31XxloQPZTqZjfgnRRO53Y0bZf2XM2Xf+bn+j0KBKae+9uj0ZoD1TnGus0i3R4oCCOw4omKblt7XJkiUfUB01AlqA3Ly+K/MdPDvoNuzP6J7PiHpAWbE3Pwnh6VDha6/FzSD9Cp18pPuYyzPWc+EgIKRFMXSknGxTZLXkdaW+hxh53k/EJWnIFnm7HJiC+hj01Miomb/8srSOdFS7ujT7y7erfMohUPFShvbZ5MyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRNw2IPYz9a6JIknbwE9ZanV091LeZRNveD1MQ8VwCs=;
 b=pEHhfIUJNPu2Tm4fmBwej06CRLhrqoh77mX6ELU5kMM7NZ6/z9QaQJ0vLLhejV/C3m2FFDgsj4fzTluPDdVFrsqXHEqHXxMNvGgLGbXVIOFo+VDGak1FDFH4pgtBzaIInhf3fGt9wnAUATIqcUE2/j0eD16wSiQTt/6Hsvhs45UAHWyVJpsRWrfbyMqFlcVyBppnuW04RsLDIPIWtBFoaq5vat/0LaO2gtSv0oXT0TA/U/4P7/uWUUMp9f5rqtUXb7Q1S79GfLFKrMMSowSGiRSiB40wrjyFuUGdr0qtdYF8odJcWWovabhz+92HQyUbjH8tlm3ypn61EBQY13Y5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRNw2IPYz9a6JIknbwE9ZanV091LeZRNveD1MQ8VwCs=;
 b=pFukO6AE7vM4emlONW05cgnePLRataxF07lG5T58BvnRa/4IPxVgaxA0/6MC6nNJThozA3yVyLIFtTWRWnESCXO6RBnGzt2S5OSSVuNz1eRzcFl6srcyGbpMycao5arLKbKKM9srJBZ40znsX9UpZxCCxVU89L18NYC9nW2Jxak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6435.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:409::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 17:04:16 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Sat, 8 Aug 2026
 17:04:16 +0000
Date: Sun, 9 Aug 2026 02:04:15 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] PCI: endpoint: Expose endpoint DMA resources
 (part 2/3)
Message-ID: <jqxv55zfquwslvkechaxv3hf7wnmsnvn3gkj2725fkjbyqukna@lnscpsi2lvf5>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <anZDfAvWOGZOU_EB@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anZDfAvWOGZOU_EB@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0183.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d3bcc5-7518-40cc-8aee-08def56f1479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10070799003|18002099003|22082099003|10067099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+dCxpRDYiH1R0VP6xI8sr21nmzfAN52hWIbd9IDn6dMWjBfDKoy9NhnzCOHGXXYg68ouN/rQzcvwgmFaK5Aw1mepW0NwDIt2g2CwCFNWqDqa68e9Bq3eaDeSMFNf3STwkaJ/JJNkzuI+amJCnDrK52vUDIAnxI6q7g1gf9ez3N0d8s+9P1YOsJYBBUKVXhy/Il/e41HuwTQfm0VjALDYVWNqITeZZeodiSG+KBL+tE7psYgeZ1SZCS314CuVSteJDtJB0b4m50etOPUXjkkAJU91U2L/asylY3FUrQw+pO+RcpUJmkFAxDVHj0Xwusx5Ch7MOPTZSd7pncmHGzKKb10cFoCDmSPdbK8+oyOyDxtGhYrCleLiKZKPzrEXNrhj5EUpiptqSsM+4+JpJ3lQ2PLE7bGAhgF1QlwPM2Vfra+EEdA6sm2wl7XmhvMM4YOO9gAFFxPm0XcqrrtqCbqszOU18BT5+L5HCJ83jTdVJb6pmTghzR1tujGl9iFp9z9qEFej3m9aPtOE0g6cPBVvvmBM9qQ9cLRdflu+d2+s4sjCYIeC14z1A5M7tnP+PsAOgIZabH79PlUpYdc0lJI2fg+p3OtJWUUBwfFI+xeVSk9qu1xgcEOXI/R8tKH1zkZLDnd1hrHnsBQuai0UZk359mAG3/Lk9ZSf1zQTbqh0ORc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BFglrdkAmUPGbqzRg58aq1Mw3EpN+0FXeYRxN3xRQukHucbhKEZBXzMixeIM?=
 =?us-ascii?Q?Dpx1yA9tTghnGC8AqecmQQVAKWub43lrrazQGJuBhP/nk74gyR9dAvizImK2?=
 =?us-ascii?Q?gmwpLUGv2rRkV5ij2lUHPCfSO6CTIiYgK1rLS8W9sGhL78ycoFDnxQSYxLHn?=
 =?us-ascii?Q?/HPiGhP1UMsY3hy6XDDmfiGSkRHkZ0IwiFlEyoiNRiC0OELxnmIiwE18X+bV?=
 =?us-ascii?Q?fprowhyZYlkj0bztMU6/j3em7v3UBFGOVv/+IYqTV5Gh5Kq61+fyM/fUCJnq?=
 =?us-ascii?Q?K5DRHUJnALZPIkPlex05ybGLj3ihKwX4qynzXKjrNYc/TROO2/gLOdLzYtp+?=
 =?us-ascii?Q?un29nhMTSDqmZt3HiCc6oG2givJcGJWKKsUXV3oHCzri7f4PuB53ymQlEIoz?=
 =?us-ascii?Q?9HWMFnevVbEquPeqkzoftYd0yVGNEhilj6jZgt7A1CLrd05ObzquttdR7E1N?=
 =?us-ascii?Q?tftT+b1aNAOZeXxsOYuZMS0ZKz0b9sVw8IqC4aig/RpQjMtEiRwTJUjLNXsl?=
 =?us-ascii?Q?TNqKs5trhUuuQqT0e4/h3pK4Cwo6ebp/+pjmEUy7Ald15F+TnxPkNZQYn+0Z?=
 =?us-ascii?Q?ifMxPjSNHMBSEnjoRkSftgQoSO3Uto32XEDhx9FRz9ZqWgmXUJ1D60NCydZ0?=
 =?us-ascii?Q?+JNj0idQxNeveCIuWuPORLlUUqwByoD+KcL+yzYTEIp4gJdz7f3jATvqEmCI?=
 =?us-ascii?Q?ONXSU+plJ+lf574gKoDj7fnHWeajaYsYUHRP3X/B6fbJFjABOgaBK7CsK9dU?=
 =?us-ascii?Q?uGXGOVcYg+2lDHtSqVno1PjK24uvvqO4Ef4PTte5l2LYBVeNVrJUS+cAHvoZ?=
 =?us-ascii?Q?3uGlw1CP/nBRtc+qFepbKPAhXCw8fu2hQplcEJiXdhmcXb1P8kOQqCb7DTqQ?=
 =?us-ascii?Q?qZWE8rDQ2pfW37icU8zCJfbXU6KRpn3tuO5thxxjGwVFIeC8FofWMuk1aUDS?=
 =?us-ascii?Q?3w3rNnsGCbIZxJMXev4XDwqon1gKNPiLCXNfzU0MEEJAdDVtR49OXdToyFas?=
 =?us-ascii?Q?i4U7k1pCvq2Mrk5djcc1p6k0wM0PvpgXsuldJk9NhRHJZKwrxTMBZMuJBRl1?=
 =?us-ascii?Q?mFltFcUQov3v9cjeI1u8RwvkPnPWFu0xZ59W+hjmypjip+4BOjw2KpzLfDuk?=
 =?us-ascii?Q?gaBOe+Tuyk1OQzKug9e09PX1wgloOvIbQG9bU3nOKRptL3CVQBCqMyClqz6I?=
 =?us-ascii?Q?g8mA09OPIrf9ts0E3YtpbC2lIoHNFrRE11jhF9iQJenEMOl6UcoFAhCi6j0+?=
 =?us-ascii?Q?m90iLLkv9Fh4BHVRpseUmitvFQdms+ew6ZE3DKEM+narLHgUDT7IYMfBGHrY?=
 =?us-ascii?Q?+gwJqgeM3IQhOzBB9yhcoUk+JibbPweS1CKNnhplbzEQXxvoW69iWgxZLrKt?=
 =?us-ascii?Q?5j+CB2almz06psNTulvPHef+6UCver6R3fCffDAv3/o7gQXHVcYC11/Tnsk/?=
 =?us-ascii?Q?vQTvmi6CYddB0HBib/IZwwbaR1L3oFhRhtos11Y3Zrpt3iMMC2Ur13UU9HKF?=
 =?us-ascii?Q?Bo8Iqotg+vNDnnXaVE4gIq23S91/UbBtMj19FrGUZ28KcFKvPye0Y2Pef/q2?=
 =?us-ascii?Q?mEQaCVZNVXjI7Rnp/xGLyPQ9C9UiEkafaW8rld8GJgO2PLCJTEJqcXlFfFPv?=
 =?us-ascii?Q?zBqCW9d5rsY5F/n2DjXpQnO61M6xzWG+gmSne+q6gf6i8uwjhCm+gwfd9J7Y?=
 =?us-ascii?Q?X1q4bMrDGxYNlbdFdA8KcLDrBuu4aIyDr6Zo/FkiGfPTDeuOdVn3+onHWp6U?=
 =?us-ascii?Q?+5EgHUNgkVz2vHa1/js3EdekfMJlEciAMAoAmDWBIIH3MsbyKvTg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d3bcc5-7518-40cc-8aee-08def56f1479
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 17:04:16.7697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFxXapEPkbSdafv2hNXRJU8ZZQEEjJQm9Q+hq4AhjrU6TEAlIcW4GIOV8GbJOiZ3CiWsioBKy/HHfJIqy/DOVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6435

On Fri, Aug 07, 2026 at 04:43:40PM -0400, Frank Li wrote:
> On Tue, Aug 04, 2026 at 12:38:49PM +0900, Koichiro Den wrote:
> > Hi,
> >
> > This is v6, part 2 of three series for PCI endpoint DMA.
> >
> > The three series are:
> >
> >   * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
> >   * part 2: PCI: endpoint: Expose endpoint DMA resources
> >   * part 3: PCI: endpoint: Add PCI DMA endpoint function
> 
> This part only 3 patch, You can merge to part2. It will be easy to know
> overall picture.

Yeah, I agree. Previously, part 2 only included patches for PCI EP, but
after Sashiko's feedback about bisectability issue, I moved one dw-edma patch
into part 2 (since v4). So now there is no point splitting part 2 and 3 any
more. I just kept the splitting as is because I didn't want to surprise people.

I'll merge those remaining two series in the next revision. (I was just
wondering which way is more comfortable for maintainers and reviewers.)

Thanks for the comment,
Koichiro

> 
> Frank
> >
> > This series defines the endpoint DMA BAR metadata and auxiliary
> > resources, adds EPC operations for DMA channel delegation, and teaches
> > the DesignWare endpoint controller to publish and delegate its
> > integrated DMA resources.
> >
> > The metadata lives in a normal endpoint BAR, not in PCI config space.
> > This keeps discovery independent from controller-specific writable
> > extended capability storage.
> >
> > Part 1 v6 has landed in linux-next via dmaengine/next:
> > https://lore.kernel.org/all/20260721062815.4117887-1-den@valinux.co.jp/
> >
> > v6 is rebased on next-20260803.
> >
> > Best regards,
> > Koichiro
> > ---
> > Changes in v6:
> >   - Rebase onto next-20260803, which includes part 1 v6.
> >   - Use one DMA resource snapshot for bounds checking and array filling.
> >     (Sashiko)
> >   - Move DMA resource exposure after delegation support so every advertised
> >     channel is immediately usable. (Sashiko)
> >
> > Changes in v5:
> >   - Keep reporting a standalone doorbell when linked-list DMA resources
> >     are unavailable. (Sashiko)
> >   - Serialize irq_mode restoration with channel state updates. (Sashiko)
> >   - Clarify the provider-defined sharing-group quiesce contract.
> >   - Use guard()/scoped_guard() for new code.
> >
> > Changes in v4:
> >   - Rebased onto the new part 1 series.
> >   - "dmaengine: dw-edma: Add delegated channel request helpers" moved
> >     from part 1 into this series, next to its only users; this also
> >     resolves the undeclared-functions issue reported against v3 5/5.
> >     (Sashiko)
> >   - Lift the v3 PF0-only restriction on DMA resource exposure and
> >     channel delegation: part 1 now programs the per-channel requester
> >     function number. Delegation to PF1+ therefore requires part 1
> >     applied on the host side.
> >   - Move pci_epc_function_is_valid() up to avoid a potential error
> >     pointer dereference. (Sashiko)
> >
> > Changes in v3:
> >   - Decouple logical DMA channel metadata from descriptor memory resources.
> >     Logical channels now refer to descriptor memory by resource ID instead
> >     of embedding descriptor metadata in each channel resource. (Sashiko)
> >   - Replace the v2 DMAengine filter-callback metadata with EPC-level DMA
> >     channel delegation/reclaim operations, keeping DMAengine provider
> >     details out of generic EPC resource metadata.
> >   - Add the DesignWare EPC backend for DMA channel delegation.
> >   - Limit DesignWare endpoint DMA resource exposure to linked-list channels
> >     until non-LL metadata and host-side parsing are added.
> >   - Suppress DesignWare DMA auxiliary resources when the local DW eDMA
> >     provider is not available.
> >   - Reject VF DMA resource and delegation requests because the DWC
> >     eDMA/HDMA register window exposed to the Root Complex is PF-only.
> >
> > Changes in v2:
> >   - Follow the part 1/3 v2 channel-claim model: EPC DMA resources now
> >     carry DMAengine filter information instead of raw DMA channel
> >     pointers. (Sashiko)
> >   - Update the DesignWare endpoint resource provider accordingly. (Sashiko)
> >
> > v5: https://lore.kernel.org/r/20260717050635.2145014-1-den@valinux.co.jp/
> > v4: https://lore.kernel.org/r/20260710082156.2395844-1-den@valinux.co.jp/
> > v3: https://lore.kernel.org/r/20260620170438.3756593-1-den@valinux.co.jp/
> > v2: https://lore.kernel.org/r/20260525063129.3316894-1-den@valinux.co.jp/
> > v1: https://lore.kernel.org/r/20260521063405.2842644-1-den@valinux.co.jp/
> >
> >
> > Koichiro Den (6):
> >   PCI: endpoint: Define endpoint DMA BAR metadata format
> >   PCI: endpoint: Add DMA auxiliary resource metadata
> >   PCI: endpoint: Add API to delegate EPC DMA channels to the host
> >   dmaengine: dw-edma: Add delegated channel request helpers
> >   PCI: dwc: Implement endpoint DMA channel delegation
> >   PCI: dwc: Expose endpoint DMA resources
> >
> >  MAINTAINERS                                   |   1 +
> >  drivers/dma/dw-edma/dw-edma-core.c            |  91 ++++++++
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 205 +++++++++++++++++-
> >  drivers/pci/endpoint/pci-epc-core.c           | 105 +++++++++
> >  include/linux/dma/edma.h                      |  14 ++
> >  include/linux/pci-ep-dma.h                    | 170 +++++++++++++++
> >  include/linux/pci-epc.h                       |  62 ++++++
> >  7 files changed, 640 insertions(+), 8 deletions(-)
> >  create mode 100644 include/linux/pci-ep-dma.h
> >
> > base-commit: 9a4cdc958dd79fc6c3b20b51a10debec6ca09fec
> > --
> > 2.51.0
> >
