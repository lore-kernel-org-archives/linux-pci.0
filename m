Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Fri, 6 May 2016 13:06:46 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCHv4] pcie: Add driver for Downstream Port Containment
Message-ID: <20160506170646.GH8503@localhost.localdomain>
References: <1461882288-31506-1-git-send-email-keith.busch@intel.com>
 <20160502202538.GK24851@localhost>
 <20160506162027.GA20010@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160506162027.GA20010@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 06, 2016 at 11:20:27AM -0500, Bjorn Helgaas wrote:
> On Mon, May 02, 2016 at 03:25:38PM -0500, Bjorn Helgaas wrote:
> > 
> > This looks like a typo; I assume you meant:
> > 
> >   ctl &= ~(PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN);
> > 
> > so we *clear* (not set) these bits on removal.  I made this change on
> > my branch.
> 
> Hi Keith, can you double-check and confirm that this was indeed a typo
> and that what's in my next branch is correct?
> 
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=next&id=26e515713342b6f7c553aa3c66b21c6ab7cf82af

Hi Bjorn,

You are right, that was a typo. Thanks for the catch and the fix.
