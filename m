Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:58925 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932405Ab3B1QdJ convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-pci@vger.kernel.org:3:1>);
	Thu, 28 Feb 2013 11:33:09 -0500
Message-Id: <512F94D202000078000C2284@nat28.tlf.novell.com>
Date: Thu, 28 Feb 2013 16:33:06 +0000
From: "Jan Beulich" <JBeulich@suse.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "xen-devel" <xen-devel@lists.xen.org>, <linux-pci@vger.kernel.org>
Subject: Re: time periods of no resource re-assignment
References: <512F2C9E02000078000C1D07@nat28.tlf.novell.com>
 <CAErSpo6+bHeNkP9rc6NUGweGfLa0CRw6H=Nny9cV-FL2xOGKeA@mail.gmail.com>
In-Reply-To: <CAErSpo6+bHeNkP9rc6NUGweGfLa0CRw6H=Nny9cV-FL2xOGKeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> On 28.02.13 at 17:06, Bjorn Helgaas <bhelgaas@google.com> wrote:
> There is currently no mechanism for the PCI core to tell a driver that
> we're changing any device resources (IRQ, MMIO, I/O).  Since there's
> no way to tell a driver to refresh its idea of device resources, the
> core can not change anything after we call a driver's .probe()
> method.
> 
> This could change in the future if we support dynamic resource
> reassignment, but I think that would require adding some sort of
> notification infrastructure so we could essentially suspend a driver,
> reassign device resources, and tell the driver "things might have
> changed" when we resume it.

Thanks Bjorn! That should allow us to get things working for now
the way I have coded them up already, and I assume eventual
changes in this area (as you outlined) would imply cooperation by
the driver (i.e. if a device is assigned to a guest, it ought to be
possible to deny the re-assignment attempt if there's no way to
let the guest know of the change).

Jan

