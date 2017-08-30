Return-Path: <SRS0=Cx9C=AA=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=Cx9C=AA=free.fr=slash.tmp@kernel.org>
Subject: Re: Possible regression between 4.9 and 4.13
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lukas Wunner <lukas@wunner.de>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 linux-pci <linux-pci@vger.kernel.org>, linux-usb
 <linux-usb@vger.kernel.org>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>
References: <599D3410.9050504@intel.com>
 <251c41c0-a4fd-8aae-88e0-5d5928ce45cf@free.fr>
 <599D62EA.7050100@linux.intel.com>
 <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
 <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
 <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
 <59A3D6BF.7010400@linux.intel.com>
 <0b089b17-00fc-5a7c-baa3-e6141029b191@free.fr>
 <59A56C15.2000403@linux.intel.com> <20170829235310.GA20214@wunner.de>
 <20170830060237.GA2782@kroah.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <678490ce-9381-e63e-7a12-33d3eff7f894@free.fr>
Date: Wed, 30 Aug 2017 10:55:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170830060237.GA2782@kroah.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 30/08/2017 08:02, Greg Kroah-Hartman wrote:

> To get back to the original issue here, the hardware seems to have died,
> the driver stops talking to it, and all is good.  The "regression" here
> is that we now properly can determine that the hardware is crap.

Before 4.12, when I unplugged my USB3 Flash drive, Linux would
detect a few "Uncorrected Non-Fatal errors" via AER, but it was
still possible to plug the drive back in.

Since 4.12, once I unplug the drive, the whole USB3 card is marked
as dead (all 4 ports), and I can no longer plug anything in (not even
the USB2 drive that didn't have any issues, IIRC).

It seems a bit premature to "mark as dead" something that remains
functional, doesn't it?

Disclaimer, there are many variables in this setup, and I've only
tested a small fraction of the problem space: only one system,
only one USB3 board, only one USB3 Flash drive.

> So, how do you think we should proceed, delay a bit longer before saying
> the device is gone?  How long is "long enough"?  How many bus errors are
> we allowed to tolerate (hint, the PCI spec says none...)
> 
> Maybe someone wants to get to the root problem here, why is the hardware
> suddenly reporting all 1s?

I'm afraid I won't be able to make any progress on this front,
unless I can get my hands on a PCIe packet analyzer.

Regards.
