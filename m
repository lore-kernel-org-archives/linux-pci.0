Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53219 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661Ab3IXAXP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 Sep 2013 20:23:15 -0400
Date: Mon, 23 Sep 2013 17:23:07 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Xenia Ragiadakou <burzalodowa@gmail.com>,
	USB list <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] xhci: fix write to USB3_PSSEN and XUSB2PRM pci config
 registers
Message-ID: <20130924002307.GB5682@xanatos>
References: <1379695553-5891-1-git-send-email-burzalodowa@gmail.com>
 <20130923164529.GA16886@xanatos>
 <5240833E.6050508@gmail.com>
 <20130923204928.GA24225@kroah.com>
 <CAErSpo7_obVo0nLNBzv7c=ZxPzdzJaDiatDjOfVRS+CbF7rc-A@mail.gmail.com>
 <20130923214907.GA21695@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130923214907.GA21695@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 23, 2013 at 02:49:07PM -0700, Greg KH wrote:
> On Mon, Sep 23, 2013 at 04:38:22PM -0500, Bjorn Helgaas wrote:
> > On Mon, Sep 23, 2013 at 3:49 PM, Greg KH <greg@kroah.com> wrote:
> > > On Mon, Sep 23, 2013 at 09:06:54PM +0300, Xenia Ragiadakou wrote:
> > >> I had in mind that the pci_ops .read and .write defined by the PCI
> > >> driver will take care of consistent byteorder access to the
> > >> configuration registers. At least, that was what i understood after
> > >> reading the
> > >> chapter on PCI of Linux Device Drivers (more specifically for
> > >> pci_write_config_* functions, it states that "The word and dword
> > >> functions convert the value to little-endian before writing to the
> > >> peripheral device.").
> > >
> > > Hm, I wrote that paragraph (or at least I think I did), but I sure
> > > didn't remember this at all...
> > >
> > > Hm, wait, I do see this happening for the PowerPC cell PCI code, so it
> > > might happen somewhere burried in the platform-specific code for
> > > different arches.  You will not see it happen on x86 as there's no need
> > > to swap any bytes around.
> > 
> > Greg, with regard to Xenia's patch, is this an ack or a nack?  Since
> > you didn't include an "Acked-by" line, I assume you think Xenia's
> > patch is unnecessary.  In that case, is there any way to shut sparse
> > up so it doesn't complain about this?
> 
> At this point in time, I don't remember what the original patch looked
> like, and as it's an xhci patch, Sarah needs to ack it, not me :)

Greg: So you're saying that there isn't a need to convert values from
CPU byte-ordering to little endian byte-ordering before passing them on
to pci_write_config_*?

If so, then yes, Xenia's patch is fine and I'll pull that into my xHCI
tree.

Sarah Sharp
