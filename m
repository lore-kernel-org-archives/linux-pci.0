Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933435AbcHYNPq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Aug 2016 09:15:46 -0400
Date: Thu, 25 Aug 2016 08:15:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard van der Hoff <linux@rvanderhoff.org.uk>
Cc: linux-pci@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Hotplug not working for USB 3.1 docking station on Dell XPS 13
Message-ID: <20160825131536.GA9554@localhost>
References: <57BDCE15.4080201@rvanderhoff.org.uk>
 <20160824201511.GF23914@localhost>
 <57BEE0E7.7020300@rvanderhoff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57BEE0E7.7020300@rvanderhoff.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 25, 2016 at 01:13:27PM +0100, Richard van der Hoff wrote:
> On 24/08/16 21:15, Bjorn Helgaas wrote:
> >[+cc Andreas, linux-kernel]
> >
> >On Wed, Aug 24, 2016 at 05:40:53PM +0100, Richard van der Hoff wrote:
> >>I'm having problems with a Plugable USB-C docking station, with my
> >>laptop, a Dell XPS 13 (9350).  ...
> >>My impression, and feedback from the linux-usb mailing list, is
> >>therefore that this is a PCI hotplug problem.
> >
> >Please include a pointer to the linux-usb analysis.
> 
> For the record, here:
> http://marc.info/?l=linux-usb&m=147204147226274&w=2, however:

Huh, turns out you and Oliver were right about it being a PCI problem.
But it would have saved some time to know how Oliver decided that.
Otherwise it's just "he said, she said."

> > From the kernel's point of view, plugging in the dock would be a PCIe
> >hotplug event on 00:1c.0 that should be handled by pciehp.  Do you
> >have pciehp included in your kernel?
> 
> I did not; now I do, and it works perfectly. Thank you! A case of it
> being incredibly obvious once you know what you are looking for.
> 
> >01:00.0 and 02:02.0 are ports of a Thunderbolt switch. Since they
> >don't appear when you boot without the docking station, the dock
> >connection must be between 00:1c.0 and 01:00.0.
> 
> This would strike me as surprising - the dock bills itself as a
> USB-C device, and the Thunderbolt devices look like they are part of
> the laptop chipset to me. To me it seems more likely that those PCI
> devices are part of the laptop, but are powered down until something
> is plugged into the USB-C port.

Yep, I agree, that sounds like a better theory.  Glad it's working
now.

Bjorn
