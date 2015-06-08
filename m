Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 8 Jun 2015 18:13:15 +0200
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
Message-ID: <20150608161315.GX20384@8bytes.org>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1433773583.2952.52.camel@infradead.org>
 <20150608152957.GW20384@8bytes.org>
 <1433778624.2952.82.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1433778624.2952.82.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 08, 2015 at 04:50:24PM +0100, David Woodhouse wrote:
> On Mon, 2015-06-08 at 17:29 +0200, Joerg Roedel wrote:
> > Hmm, I also limited this functionality to kdump kernels. Do we still
> > need to preserve these extended data structures even when there is no
> > upstream support for them yet?
> 
> We *do* have upstream support. The 4.1 kernel will use the extended
> root/context tables and will set the DMA_RTADDR_RTT bit in the Root
> Table Address register, even though it doesn't yet actually *use* any
> of the shiny new bits in the extended context tables.
> 
> So the code which copies the context tables needs to take that into
> account.

Right, I missed that until now. So what the code with my changes does
is, it sets the DMA_RTADDR_RTT bit as it would do on a normal boot. But
unlike the root entry table address, this bit can not be changed while
translation is active.

So I think we need to read out that bit when we find translation enabled
and if it is different from what we would set it to, we bail out of any
copying, disable translation and proceed as in a normal boot.

> Yeah. We need the same thing with hardware passthrough — currently I
> think we refuse to put RMRR-afflicted devices into the passthrough
> domain purely because we lack the capability to install the RMRR
> regions if/when we later take it *out* of the hardware passthrough
> domain. Although I can't quite remember the logic there; surely if it's
> RMRR-afflicted and we have iommu=pt, it'll *never* be taken out of the
> 1:1 domain? A device driver might come along and tell us it really is
> 64-bit capable and thus we might put it *in* to the passthrough domain
> where previously we'd kept it out... but taking it *out*... ?

Well, yeah, the logic is complicated. My hope is to move all that logic
to the iommu core code to have it unified between iommu drivers.

The way it should work then is basically: Every device (better:
iommu-group) has a default domain (which can be a PT domain) and if the
device has RMRR mappings, it can not be taken out of that domain. The
default-domain branch of my tree contains the beginnings of that, but
there is still a lot of work to do to get there.


	Joerg

