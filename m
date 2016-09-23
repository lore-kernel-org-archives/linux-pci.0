Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Fri, 23 Sep 2016 18:14:02 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 2/2] x86/vmd: Add PCI domain specific LED option
Message-ID: <20160923221402.GA1272@keith>
References: <1473779140-4016-1-git-send-email-keith.busch@intel.com>
 <1473779140-4016-2-git-send-email-keith.busch@intel.com>
 <20160923143441.GF1514@localhost>
 <20160923165702.GA20686@keith>
 <20160923191223.GA16019@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160923191223.GA16019@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 23, 2016 at 02:12:23PM -0500, Bjorn Helgaas wrote:
> BTW, the "Volume Management Device Driver" config item appears by
> itself in the top-level menuconfig menu.  That seems a little ...
> presumptuous; is it what you intended?

Not really intended, but I didn't really know any better at the time. :).

I think drivers/pci/host/ is a more appropriate home for this driver. I'll
send a patch to relocate it, along with necessary Kconfig updates.
