Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Mon, 28 Nov 2016 13:02:14 -0500
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20161128180214.GF2609@localhost.localdomain>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <20161118232544.GI28386@localhost.localdomain>
 <20161123160906.GB16033@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161123160906.GB16033@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 23, 2016 at 10:09:06AM -0600, Bjorn Helgaas wrote:
> Sorry I haven't had a chance to look at these yet.  I want to think
> about them a little more because it seems like these should be
> optimizations, not really fixes.  If they improve stability by fixing
> Linux issues, details of those issues would help.  But maybe the
> improvement is from avoiding things the hardware doesn't handle quite
> correctly.

I also think o  this mainly as an optimization since it significantly
speeds up the hot removal of larger PCIe hierarchies. If this also happens
to improve hot plug stability on hardware (which I understand it does),
that's just a bonus, but the patch should be able to stand on its own
merits without considering hardware issues.

It also is a fix in that it blocks config space access to devices known
to be removed. If we let the config access happen in a hot swap, the
config request is rejected in the best case, but it goes to the wrong
device to potentially undefined results in the worst case.
 
> And I'm always hesitant about things like flags that say "this device
> is being removed but hasn't been removed yet" because the remove
> process is already complicated and we've tripped over races and
> ordering issues in the past.  That's not to say this is a bad
> approach; it's just an excuse for why I need some time to work through
> these patches.

The flag is really just saying the device is physically removed before
we've logically torn down the software resources for it. This is similar
to how many of the Linux SCSI driver's have target specific flags to
know when to return DID_NO_CONNECT for previously configured devices
that were removed without going through software first.

Instead of 'is_removed', would a different name for this flag, like
'disconnected', be more appropriate?
