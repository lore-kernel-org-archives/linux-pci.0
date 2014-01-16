Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35285 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751905AbaAPTkh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2014 14:40:37 -0500
Date: Thu, 16 Jan 2014 14:40:35 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	USB list <linux-usb@vger.kernel.org>,
	"Chen, Jamie" <jamie.chen@intel.com>,
	"Tsai, Gaggery" <gaggery.tsai@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: EHCI host broken -- interrupts disabled
In-Reply-To: <CAErSpo6v-QLkthigN3HdLizCa_7QxOS+dZ61Fse2jz5KJRdh0Q@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1401161435350.1109-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 16 Jan 2014, Bjorn Helgaas wrote:

> I think dev->irq is supposed to be valid after pci_enable_device(), so
> it seems like it would make sense to clear PCI_COMMAND_INTX_DISABLE
> there.

Okay.

> I don't know why a BIOS would leave PCI_COMMAND_INTX_DISABLE set for
> the EHCI device.  Does it support MSI, and the BIOS assumes the OS
> should use that?  I don't see any MSI support in the EHCI code.  In

As far as I know, there aren't any EHCI designs that use MSI.  And
there is no particular reason why a BIOS would leave INTX_DISABLE set,
although come to think of it, there doesn't seem to be any reason why a
BIOS should leave that bit clear either.

> any case, this doesn't seem like something we need to depend on the
> BIOS to do for us.

Could you post a patch for Gaggery or Jamie to try out?

Alan Stern

