Return-Path: <SRS0=Bk9x=AA=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=Bk9x=AA=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 30 Aug 2017 08:02:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Mason <slash.tmp@free.fr>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Possible regression between 4.9 and 4.13
Message-ID: <20170830060237.GA2782@kroah.com>
References: <599D3410.9050504@intel.com>
 <251c41c0-a4fd-8aae-88e0-5d5928ce45cf@free.fr>
 <599D62EA.7050100@linux.intel.com>
 <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
 <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
 <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
 <59A3D6BF.7010400@linux.intel.com>
 <0b089b17-00fc-5a7c-baa3-e6141029b191@free.fr>
 <59A56C15.2000403@linux.intel.com>
 <20170829235310.GA20214@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170829235310.GA20214@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 30, 2017 at 01:53:10AM +0200, Lukas Wunner wrote:
> On Tue, Aug 29, 2017 at 04:28:53PM +0300, Mathias Nyman wrote:
> > This tight check was originally done to detect pci hotplug removed
> > hosts as soon as possible.
> 
> In Mason's case, the parent of the XHCI controller isn't a hotplug port,
> see this lspci output:
> 
> https://www.spinics.net/lists/linux-usb/msg160010.html
> 
> Please check is_hotplug_bridge in the parent's struct pci_dev before
> assuming that the XHCI controller was unplugged.

How can you guarantee that this is set on some systems?  Will it be set
on cardbus devices?  What about on a "normal" system where I can just go
and yank out a PCI card at will?

I don't think this is a valid thing to check, and again, why are we
arguing this point?  It's been this way since the 1990's, this isn't a
new thing...

To get back to the original issue here, the hardware seems to have died,
the driver stops talking to it, and all is good.  The "regression" here
is that we now properly can determine that the hardware is crap.

So, how do you think we should proceed, delay a bit longer before saying
the device is gone?  How long is "long enough"?  How many bus errors are
we allowed to tolerate (hint, the PCI spec says none...)

Maybe someone wants to get to the root problem here, why is the hardware
suddenly reporting all 1s?

thanks,

greg k-h
