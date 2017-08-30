Return-Path: <SRS0=Bk9x=AA=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=Bk9x=AA=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 30 Aug 2017 11:22:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mason <slash.tmp@free.fr>, Lukas Wunner <lukas@wunner.de>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Possible regression between 4.9 and 4.13
Message-ID: <20170830092201.GB16835@kroah.com>
References: <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
 <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
 <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
 <59A3D6BF.7010400@linux.intel.com>
 <0b089b17-00fc-5a7c-baa3-e6141029b191@free.fr>
 <59A56C15.2000403@linux.intel.com>
 <20170829235310.GA20214@wunner.de>
 <20170830060237.GA2782@kroah.com>
 <678490ce-9381-e63e-7a12-33d3eff7f894@free.fr>
 <CAKv+Gu8QSWO8jYc1L6eJyMg58gtVsoa9zYuymSc-PdEm60HzxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv+Gu8QSWO8jYc1L6eJyMg58gtVsoa9zYuymSc-PdEm60HzxA@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 30, 2017 at 10:07:59AM +0100, Ard Biesheuvel wrote:
> On 30 August 2017 at 09:55, Mason <slash.tmp@free.fr> wrote:
> > On 30/08/2017 08:02, Greg Kroah-Hartman wrote:
> >
> >> To get back to the original issue here, the hardware seems to have died,
> >> the driver stops talking to it, and all is good.  The "regression" here
> >> is that we now properly can determine that the hardware is crap.
> >
> > Before 4.12, when I unplugged my USB3 Flash drive, Linux would
> > detect a few "Uncorrected Non-Fatal errors" via AER, but it was
> > still possible to plug the drive back in.
> >
> > Since 4.12, once I unplug the drive, the whole USB3 card is marked
> > as dead (all 4 ports), and I can no longer plug anything in (not even
> > the USB2 drive that didn't have any issues, IIRC).
> >
> > It seems a bit premature to "mark as dead" something that remains
> > functional, doesn't it?
> >
> > Disclaimer, there are many variables in this setup, and I've only
> > tested a small fraction of the problem space: only one system,
> > only one USB3 board, only one USB3 Flash drive.
> >
> 
> Please don't forget to mention that this is quirky hardware that
> depends on BROKEN because it multiplexes MMIO and config space
> accesses in the same memory window without any locking whatsoever
> (which would be difficult to do in the first place because we don't
> use accessors for MMIO in the kernel).
> 
> So how likely is it that you are attempting to read from the xhci BAR
> window while a config space access is in progress? Any way to
> instrument this in your driver?

Seriously?  Ok, that's crap hardware, sorry, I don't feel bad at all
here.  You are going to have worse problems than just a single USB
controller issue if that's your hardware design, go kick some hardware
engineers for me please.

good luck, you are on your own :(

greg k-h
