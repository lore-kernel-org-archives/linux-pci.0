Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 10 Jun 2015 11:21:51 +0200
From: Joerg Roedel <joro@8bytes.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, lisa.mitchell@hp.com,
	iommu@lists.linux-foundation.org,
	"Li, Zhen-Hua" <zhen-hual@hp.com>, doug.hatch@hp.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com,
	vgoyal@redhat.com
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump
 kernel
Message-ID: <20150610092150.GZ20384@8bytes.org>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1433773583.2952.52.camel@infradead.org>
 <20150608152957.GW20384@8bytes.org>
 <1433778624.2952.82.camel@infradead.org>
 <20150608161315.GX20384@8bytes.org>
 <1433854550.19447.15.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433854550.19447.15.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 09, 2015 at 01:55:50PM +0100, David Woodhouse wrote:
> On Mon, 2015-06-08 at 18:13 +0200, Joerg Roedel wrote:
> > So I think we need to read out that bit when we find translation enabled
> > and if it is different from what we would set it to, we bail out of any
> > copying, disable translation and proceed as in a normal boot.
> 
> Given that this is only for kdump and not the general case of kexec,
> that's probably tolerable. Of course we do still need to make it *not*
> broken for the case where DMA_RTADDR_RTT is set, as it is at the
> moment.

Yes, I just sent a patch for this and will include it into my x86/vt-d
branch if not objections come in.

> And I suspect if we're doing that, it might be simple enough to make it
> convert to/from the extended page tables. I don't think we want to
> preserve PASID tables; only the "second level" (i.e. traditional)
> translation. So we could happily pull the page table pointer out of
> either kind of context entry, and install it into either kind. I think
> there's a simple mapping of translation types too. I need to sort out
> the translation types when adding the real PASID support (imminently!)
> anyway.

What happens when we take away the PASID tables from a device? Can it
also go into some failure state?
When doing this, we need at least setup the page request queue before we
copy over anything and change the root-entry. Then we can handle any
faults that are caused by this and tell the device to not try further.


	Joerg

