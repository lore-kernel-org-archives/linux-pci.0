Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Tue, 9 Aug 2016 20:56:28 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 0/3] Limiting pci access requests
Message-ID: <20160809185628.GA6729@wunner.de>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
 <20160809173633.GF27301@localhost>
 <20160809185654.GA32692@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160809185654.GA32692@localhost.localdomain>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 09, 2016 at 02:56:54PM -0400, Keith Busch wrote:
> On Tue, Aug 09, 2016 at 12:36:33PM -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 08, 2016 at 01:14:24PM -0600, Keith Busch wrote:
> > > We observe that error handling and device hot removal creates many
> > > unnecessary config and memory accesses to devices, some of which are not
> > > even present. While we expect command processing to proceed, we observe
> > > on various platforms that the unnecessary accesses create instability
> > > with hardware performing completion synthesis, and slows down handling
> > > of such error events as well as normal IO processing.
> > 
> > Is there some hot removal path that we've suddenly starting exercising
> > more than we used to?  Can you give us any details of that?  I'm
> > wondering if there are any more generic fixes we can make.  These
> > patches seem good, but a little piece-meal, so it feels like there
> > could be more places where we trip over similar issues.
> 
> This series came from testing JBODs of PCIe SSDs. I think the main
> difference with this setup compared to most other PCIe testing is the
> sheer number of simultaneous add + remove + error events while running
> continuous IO. We're not hitting any new code paths in the kernel, but
> we are discovering interesting software and hardware interactions that
> were likely less reachable before such testing.
> 
> There are still more places that we can remove unnecessary config and
> MMIO, though they're just micro-improvements compared to this series.
> Even those just repeat the same pattern of looking for a -1 completion
> or false return from "pci_device_is_present". So the "fixes" do look
> tedious and piecemeal, but I didn't see how else we could do it. Any
> thoughts or guidance is much appreciated.

FWIW, similar checks were added to pciehp with commit 1469d17dd341
("PCI: pciehp: Handle invalid data when reading from non-existent
devices"). So the general idea to handle such faults is already
present in the kernel, the only improvement I could see here would
be to harmonize (i.e. make identical everywhere) the way this is
coded (check for ~0) as well as the message logged with KERN_INFO
(your patches do not log a message at all AFAICS).

Best regards,

Lukas
