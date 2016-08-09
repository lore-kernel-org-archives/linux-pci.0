Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Tue, 9 Aug 2016 14:56:54 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 0/3] Limiting pci access requests
Message-ID: <20160809185654.GA32692@localhost.localdomain>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
 <20160809173633.GF27301@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160809173633.GF27301@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 09, 2016 at 12:36:33PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 08, 2016 at 01:14:24PM -0600, Keith Busch wrote:
> > We observe that error handling and device hot removal creates many
> > unnecessary config and memory accesses to devices, some of which are not
> > even present. While we expect command processing to proceed, we observe
> > on various platforms that the unnecessary accesses create instability
> > with hardware performing completion synthesis, and slows down handling
> > of such error events as well as normal IO processing.
> 
> Is there some hot removal path that we've suddenly starting exercising
> more than we used to?  Can you give us any details of that?  I'm
> wondering if there are any more generic fixes we can make.  These
> patches seem good, but a little piece-meal, so it feels like there
> could be more places where we trip over similar issues.

Hi Bjorn,

This series came from testing JBODs of PCIe SSDs. I think the main
difference with this setup compared to most other PCIe testing is the
sheer number of simultaneous add + remove + error events while running
continuous IO. We're not hitting any new code paths in the kernel, but
we are discovering interesting software and hardware interactions that
were likely less reachable before such testing.

There are still more places that we can remove unnecessary config and
MMIO, though they're just micro-improvements compared to this series.
Even those just repeat the same pattern of looking for a -1 completion
or false return from "pci_device_is_present". So the "fixes" do look
tedious and piecemeal, but I didn't see how else we could do it. Any
thoughts or guidance is much appreciated.

Thanks,
Keith
