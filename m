Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2092.outbound.protection.outlook.com [40.107.237.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1D17279F;
	Fri,  5 Apr 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343737; cv=fail; b=oXac8wrac1fQnWmY+PLj7xUhRFI94i38cCcg/IrlNCLMRetlTzmw44NY9MUCh3ZSse2D6tCPlYKgclG85+ajZJDJVVuoVBoZaNDCCmM8MDVdQie688d74vMRw6ec9KtSYyS4o8D87uqW5NrOJ31ueGqhfJNtcX2mqloFALZmjfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343737; c=relaxed/simple;
	bh=GQ0nWJikW+reN4/wbNOg65r/tDP60ZLh20GXlXUb99Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r0/DcJX9AG0xKAyS4hWKX/9FlCuKYmW9Ay1KjD1FFPKIhs9GLR42Sji5AQF+PgimSUezSvisSA0IShIODDloOph6TIrU50OkE83xn6wz7QB+U+piB7Os7foMyCOEisH8CXWvJgrrbyzHtxbzBgdlmxvhVqB5aLeFcb+DPaGtUcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cZ87+9Uq; arc=fail smtp.client-ip=40.107.237.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cZ87+9Uq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKqPs4k1NT/57Y80qLs4OAfTtZwsvbSbYCrKfmISUWRZZByjAUzz3BimitJrjq1ETh5qs3OQb4nmVZDfCysD4Xm033SYZVL3zrIOUCKegPMThoKHWqgcFOQks8gO6FENwTzZRS8FWC9ucm37028yYPXYQNwcYT2kB7eV87WBJMhJFNR7wl2BEhReF/qb/aeJg5Y2y1HG4BN7VgfcCZ7zoLygjrQWwp5Tt3eSnZIiw4KEeBlH2u6ZUuHmsAY2e9E6gJszN5rMk+57t3JfdjJvVEJpzv3oF9ZPtal7fveoX9F+cg0YeMRhSM2G2sbM7/B+094vl5iLWgxNYNjrkCXmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5/howhzwmFpKgSDW7od0YgRvVKjqfQejxEtrVYTumE=;
 b=Z35mT7OrD3mRorB6U6vVTPW5L8fNDciRWowe1hV7H1NcTx8zqdC7LuRp1fMWd4MBnA+H9zNysZ8/bijD6+ACKUnjk9dXDbrFehJDZZydOszwJfPm+O2H4mKg/IjjxJeXk/HiQvB/fErQdTN3kvZlZru/vovy4Amn8JErZhrWdSJRyaMngNp3ptOnVan8vA4STwYm0xtH67DWr2RP95Tsp3ol+5e7hxw5DoxoYYHilbDpSKkw7qgnfA4AGvmhqcdMzB3JI0+eilx2kaqiKZCwi/0xYGr+v/1ChzyaupiE15aOhxdpUCqTQua2ag+hdK+0xIIVI750UCHlY7bjyejIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5/howhzwmFpKgSDW7od0YgRvVKjqfQejxEtrVYTumE=;
 b=cZ87+9UqS+7EJfqnFZt3tUySmtIZwMFcTpoZMnL29OFdKY0LfjBWXCeCSEPYRzwFGtkTnBIsK1ipDvmDgw2EwLxOv6pMJs9w16wtSr+ie5A8jTdhGv1fxidNmr+mGdLB7GvyJdKrcjLzSK6ZEH6TySUaPJzL9cKoSfsKv8mjflf4ttAKVM/aRRyEMWCh9TUhH3IsA+uDUABoxVteH0US5h5RoKFr7vSdl+9FZolXPtf5S9Bxl5+HdHb0VELs1kP89HbrbJ2cbIL3/H/Nkav30KZPl3HI2gGC/GtNvI504+5C0E39rhzCEBRhGb2nUB4dptY19aMAAOWglWMrQu7ahg==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB8587.namprd12.prod.outlook.com (2603:10b6:208:450::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 19:02:10 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 19:02:10 +0000
Date: Fri, 5 Apr 2024 16:02:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240405190209.GJ5383@nvidia.com>
References: <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org>
 <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB8587:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SCPWvIkBIaX/1c7AgZvy6051FF9iHdQORbTfwK21tRzOHKlm22yupCR3s+XUnHrQO228OGlA/5fH0MWLE5YKmTAdyIieLXIJF+dvjwiORYXxGJfEk3TbqrqyDthTfjvAqxnCjHOeoHWRGWVKKdbFynKM7EY9wHoWsn8fq7dSxo91YTlTwHhq33bayEICspkIDQDL7hUJQsgHKRCLRZqvnm+Q+Ue8zSz1zagbHKJ4TUYdKkk1XwXazuLFTksPGJQNsHM8JXlXO3a2HudhLa0nCGuI+bLi4ZZCjJSG6fjNsmshkORt91aytjKnIa+5mht5t82tz9mSuDMgq4TQSRNbZEaVBRU6CAVQ4W4+Fgi8WlBFKnse4ZxlwOAAMR18zKnxNOq6Ywdo3Jd0yzqXKE6eLqnFf+SixYKiXCa+OdVbOmUNM1B+DhmnHKBVqoo7t1pNz+GrAXpmfn5PcnB9dWclalDsmUfTvwJnO8tQ1eDv6yosiNzBFNoBykyoGod48DMP4WpRt34+dfr4PF6Dqcg2l/tdWdiOabQ7OSL6e4LboLkGcz2CAOvZnpY3BJKVniPxZIkzdaJrUHAHqz62hVUhSJDGpXVhviY5QBZv6FbdzqtDlFG04N8XqWGrjrY+noUhQTEf5LLKLG+tIOwyIRWSmtm0bgiH7Thlnx41Z2fr1LM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SVV+Ud10zSGhSVjmy/EaTkebnL8Z3c4SOJAxUWHn0XoV02+PFJpWW5DAsYKj?=
 =?us-ascii?Q?0M3b/d/j3FRZ7oHYKuWF/uudjCHQGjoWYieoqbIQzUpGiijlYwzP+tVxrOHX?=
 =?us-ascii?Q?s7UaRoL3MIM0Pj9PIe7EFiRiRKUFIYDgtjgBsoMH3eH5TQTXMOO5G3iRBcXk?=
 =?us-ascii?Q?TPGFXYkE6ceoRDjGFtKFaqIvqcfC2rJ84S3ZvfKpkoYjY/vKn8ogacFKqadS?=
 =?us-ascii?Q?f/3m7J1hOLnXxE50x8UY+ia7Zcj3GKQEouFGdiw70V/pJiX+ffNaBbgc7Zwn?=
 =?us-ascii?Q?jskxzdLSq0x6OaGQrGb5b1Ky4xZh6AQgrAD/D4n+z/q2WiFFjW1l0uamgiiC?=
 =?us-ascii?Q?pxB7Rt1YDzWnrIrj6eOJoTwd9vaxUjthBWnp2IOo289IEcYWlENypDAzPzHY?=
 =?us-ascii?Q?33EXRf6BvcQfJmOB7jKZMGT7T2y0uCif+Ul44OuuEBNE+D2246VdO5BHH3lu?=
 =?us-ascii?Q?QccztuwSLHM3zSpvckAeIiddvBTcozfSG6i/gOORHbf+tRQfXPunBAK8RhC1?=
 =?us-ascii?Q?ogtqIhrHuVZhcQaCt3mDc5Es33kgZunjBawc0h50/d9/xuOs6hiR3ICZEirs?=
 =?us-ascii?Q?BySDEcMMbTHXG3yVWQxRJ0Et3X1F81NdN1tA8xDD9szAaaYFO0ATJcpNlNWm?=
 =?us-ascii?Q?lYPUl/ebgnrGhjJIFcB3y3FcwZuIYVFpoEFLjR4FXoLJvIxUc4lAiyEAzMO/?=
 =?us-ascii?Q?JOrg5mpLfOaa/bIeE88rD+EosdSdQgpS1I63Ndkf0v035unD03uXkrs1XP3U?=
 =?us-ascii?Q?9BaFVgbtKk1hIvCshN8vV1haxGpQ5IVGONjuFotk6cVOIwnfcNRAjngrXhiJ?=
 =?us-ascii?Q?XOXi6sWdYq7vAcmxoMZkl7Mkvm7LCyT0Hndre+jzUcdVDhhV+yAgND0KOJ79?=
 =?us-ascii?Q?I2qUelsvfkOWmeEb2geiGRBujCoizI5z94LjmV8gk+MhnEVhmeerI+xdfUJ8?=
 =?us-ascii?Q?YycHTVdqN3/sZeFKzCIwctBBuzUvU3h2758jhz/YsI6HFFJaoYAChds0fURZ?=
 =?us-ascii?Q?Bbn/V99roe21AR586pRYyEmUhmn6BanmNyb3Msfk4+wh+Me3MwKA/bXUp/8v?=
 =?us-ascii?Q?Vv5ah8MpYc1DNzMVJ8ZPy7jqWCyBfrDKOIHanQ7BEEA162T+ko+g+mD3fV4j?=
 =?us-ascii?Q?qxsvak2t/EO6phIBYOYZaZ/+rLxtrrXiA009laHDQwAgu6Z+73GmzTtLTvSS?=
 =?us-ascii?Q?MqQE34xQw7DmaMYKgT9M6L3sq5cj8DliJ74U0yjZYqpGoaH6b7AveywzueqQ?=
 =?us-ascii?Q?sogcVeZULpw4w9KsrjdMt9W1H4BFDkg8Wf1Z2zeWL9PRQikS6DZgFTuQdF/z?=
 =?us-ascii?Q?WhG+ey152qldv8LYQsXSiKo7s86cpngyWPZIJTm/HKX/ryqkm1V7da1BFT+s?=
 =?us-ascii?Q?zrrQJ1X3HOQeMg3kSO2UIjeQItNyzNulW53fkAXj9ETe8rQ5wWjYsy+x3cHB?=
 =?us-ascii?Q?SeMeirVhW7+4zDuvCWPdY6XMldcsm5Q0WxcJGQQ3OqD95GXCq/UVpelgs9p8?=
 =?us-ascii?Q?83u+1l9XZr+BAXewmHjuVEH0De6lzvTjBl75oL3rCOR8dBe2sN7mXyy9zRgr?=
 =?us-ascii?Q?qQyQSQTG3NQvJOokizRo5Uyq+izuEz7NW6SKDwGk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624efca3-e709-4864-bad2-08dc55a2e575
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 19:02:10.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELvrOjzuSr39aAwMUXkkyGETmBDDjdU9T/YMw/H+3i+1RcWxMP4hi8s5j9dMY6IK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8587

On Fri, Apr 05, 2024 at 11:38:25AM -0700, Alexander Duyck wrote:

> > In my hypothetical you'd need to do something like open source Meta's
> > implementation of the AI networking that the DMABUF patches enable,
> > and even then since nobody could run it at performance the thing is
> > pretty questionable.
> >
> > IMHO publishing a qemu chip emulator would not advance the open source
> > ecosystem around building a DMABUF AI networking scheme.
> 
> Well not too many will be able to afford getting the types of systems
> and hardware needed for this in the first place. Primarily just your
> large data center companies can afford it.
> 
> I never said this hardware is about enabling DMABUF.

I presented a hypothetical to be able to illustrate a scenario where
this driver should not be used to justify invasive core kernel
changes.

I have no idea what future things you have in mind, or if any will
reach a threshold where I would expect they should not be
included. You where the one saying a key reason you wanted this driver
was to push core changes and you said you imagine changes that are
unique to fbnic that "others might like to follow".

I'm being very clear to say that there are some core changes should
not be accepted due to the kernel's open source ideology.

> Right, nouveau is fully open source. That is what I am trying to do
> with fbnic. That is what I am getting at. This isn't connecting to
> some proprietary stack or engaging in any sort of bypass.

The basic driver presented here is not, a future driver that justifies
unknown changes to the core may be.

This is why my message was pretty clear. IMHO there is nothing wrong
with this series, but I do not expect you will get everything you want
in future due to this issue.

I said decide if you want to continue. I'm not NAKing anything on this
series.

> I'm trying to say that both those projects are essentially doing the
> same thing you are accusing fbnic of doing, 

Not even close. Both those projects support open source ecosystems,
have wide cross vendor participating. fbnic isn't even going to be
enabled in any distribution.

> > You have an unavailable NIC, so we know it is only ever operated with
> > Meta's proprietary kernel fork, supporting Meta's proprietary
> > userspace software. Where exactly is the open source?
> 
> It depends on your definition of "unavailable". I could argue that for
> many most of the Mellanox NICs are also have limited availability as
> they aren't exactly easy to get a hold of without paying a hefty
> ransom.

And GNIC's that run Mina's series are completely unavailable right
now. That is still a big different from a temporary issue to a
permanent structural intention of the manufacturer.

> > Why should someone working to improve only their proprietary
> > environment be welcomed in the same way as someone working to improve
> > the open source ecosystem? That has never been the kernel communities
> > position.
> 
> To quote Linus `I do not see open source as some big goody-goody
> "let's all sing kumbaya around the campfire and make the world a
> better place". No, open source only really works if everybody is
> contributing for their own selfish reasons.`[1]

I think that stance has evolved and the consensus position toward uapi
is stronger.

> different. Given enough time it is likely this will end up in the
> hands of those outside Meta anyway, at that point the argument would
> be moot.

Oh, I'm skeptical about that.

You seem to have taken my original email in a strange direction. I
said this series was fine but cautioned that if you proceed you should
be expecting an eventual feature rejection for idological reasons, and
gave a hypothetical example what that would look like.

If you want to continue or not is up to Meta, in my view.

Jason
