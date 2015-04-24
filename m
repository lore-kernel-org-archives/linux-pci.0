Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34391 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242AbbDXICb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 24 Apr 2015 04:02:31 -0400
Date: Fri, 24 Apr 2015 16:01:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: "Li, ZhenHua" <zhen-hual@hp.com>, dwmw2@infradead.org,
	indou.takao@jp.fujitsu.com, joro@8bytes.org, vgoyal@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump
 kernel
Message-ID: <20150424080147.GC4458@dhcp-16-116.nay.redhat.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
 <20150415005731.GC19051@localhost.localdomain>
 <552DFB56.1070600@hp.com>
 <20150415064803.GF19051@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150415064803.GF19051@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/15/15 at 02:48pm, Dave Young wrote:
> On 04/15/15 at 01:47pm, Li, ZhenHua wrote:
> > On 04/15/2015 08:57 AM, Dave Young wrote:
> > >Again, I think it is bad to use old page table, below issues need consider:
> > >1) make sure old page table are reliable across crash
> > >2) do not allow writing oldmem after crash
> > >
> > >Please correct me if I'm wrong, or if above is not doable I think I will vote for
> > >resetting pci bus.
> > >
> > >Thanks
> > >Dave
> > >
> > Hi Dave,
> > 
> > When updating the context tables, we have to write their address to root
> > tables, this will cause writing to old mem.
> > 
> > Resetting the pci bus has been discussed, please check this:
> > http://lists.infradead.org/pipermail/kexec/2014-October/012752.html
> > https://lkml.org/lkml/2014/10/21/890

I support this patchset.

We should not fear oldmem since reserved crashkernel region is similar.
No one can guarantee that any crazy code won't step into crashkernel
region just because 1st kernel says it's reversed for kdump kernel. Here
the root table and context tables are also not built to allow legal code
to danamge. Both of them has the risk to be corrupted, for trying our
best to get a dumped vmcore the risk is worth being taken.

And the resetting pci way has been NACKed by David Woodhouse, the
maintainer of intel iommu. Because the place calling the resetting pci
code is ugly before kdump kernel or in kdump kernel. And as he said a
certain device made mistakes why we blame on all devices. We should fix
that device who made mistakes. 

As for me, periodically poked by customers to ask how iommu fix is
going, I really think this patchset is good enough. Aren't we going to
do thing just because there's a risk with tiny possibility or not perfect
enough. I think people won't agree. Otherwise kdump could have been
killed when author proposed it since crashkernel reserved region is
risky and could be corrupted by 1st kernel.

Anyway, let's comprimise a little. At worst it can be reverted if it's
not satisfactory.

Personal opinion.

By the way, I tested it and it works well on my HP z420 workstation.

Thanks
Baoquan


> 
> I know one reason to use old pgtable is this looks better because it fixes the
> real problem, but it is not a good way if it introduce more problems because of
> it have to use oldmem. I will be glad if this is not a problem but I have not
> been convinced.
> 
> OTOH, there's many types of iommu, intel, amd, a lot of other types. They need
> their own fixes, so it looks not that elegant.
> 
> For pci reset, it is not perfect, but it has another advantage, the patch is
> simpler. The problem I see from the old discusssion is, reset bus in 2nd kernel
> is acceptable but it does not fix things on sparc platform. AFAIK current reported
> problems are intel and amd iommu, at least pci reset stuff does not make it worse.
> 
> Thanks
> Dave
