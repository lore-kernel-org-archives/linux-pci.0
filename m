Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56195 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932434AbbDXIuO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 24 Apr 2015 04:50:14 -0400
Date: Fri, 24 Apr 2015 16:49:57 +0800
From: Dave Young <dyoung@redhat.com>
To: Baoquan He <bhe@redhat.com>
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
Message-ID: <20150424084957.GC23912@dhcp-128-91.nay.redhat.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
 <20150415005731.GC19051@localhost.localdomain>
 <552DFB56.1070600@hp.com>
 <20150415064803.GF19051@localhost.localdomain>
 <20150424080147.GC4458@dhcp-16-116.nay.redhat.com>
 <20150424082528.GA23912@dhcp-128-91.nay.redhat.com>
 <20150424083530.GD4458@dhcp-16-116.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150424083530.GD4458@dhcp-16-116.nay.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/24/15 at 04:35pm, Baoquan He wrote:
> On 04/24/15 at 04:25pm, Dave Young wrote:
> > Hi, Baoquan
> > 
> > > I support this patchset.
> > > 
> > > We should not fear oldmem since reserved crashkernel region is similar.
> > > No one can guarantee that any crazy code won't step into crashkernel
> > > region just because 1st kernel says it's reversed for kdump kernel. Here
> > > the root table and context tables are also not built to allow legal code
> > > to danamge. Both of them has the risk to be corrupted, for trying our
> > > best to get a dumped vmcore the risk is worth being taken.
> > 
> > old mem is mapped in 1st kernel so compare with the reserved crashkernel
> > they are more likely to be corrupted. they are totally different. 
> 
> Could you tell how and why they are different? Wrong code will choose
> root tables and context tables to danamge when they totally lose
> control?

iommu will map io address to system ram, right? not to reserved ram, but
yes I'm assuming the page table is right, but I was worrying they are corrupted
while kernel panic is happening.

> 
> > 
> > > 
> > > And the resetting pci way has been NACKed by David Woodhouse, the
> > > maintainer of intel iommu. Because the place calling the resetting pci
> > > code is ugly before kdump kernel or in kdump kernel. And as he said a
> > > certain device made mistakes why we blame on all devices. We should fix
> > > that device who made mistakes. 
> > 
> > Resetting pci bus is not ugly than fixing a problem with risk and to fix
> > the problem it introduced in the future.
> 
> There's a problem, we fix the problem. If that's uglier, I need redefine
> the 'ugly' in my personal dict. You mean the problem it could introduce
> is wrong code will damage root table and context tables, why don't we
> fix that wrong code, but blame innocent context tables? So you mean
> these tables should deserve being damaged by wrong code?

I'm more than happy to see this issue can be fixed in the patchset, I do not
agree to add the code there with such problems. OTOH, for now seems there's
no way to fix it.

> 
> > 
> > I know it is late to speak out, but sorry I still object and have to NACK this
> > oldmem approach from my point.
> > 
> > Thanks
> > Dave
