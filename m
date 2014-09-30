Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33955 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbaI3UWI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Sep 2014 16:22:08 -0400
Message-ID: <1412108464.4285.154.camel@pasglop>
Subject: Re: MSI address mask quirk issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Airlie <airlied@linux.ie>,
	Alex Deucher <alexdeucher@gmail.com>,
	Brian King <brking@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>
Date: Wed, 01 Oct 2014 06:21:04 +1000
In-Reply-To: <CAErSpo4B6kuZJcKwreNvW1qC5sZ=1Ko71vbzNz7T8-_pjf7mww@mail.gmail.com>
References: <1412048401.4285.128.camel@pasglop>
	 <CAErSpo4B6kuZJcKwreNvW1qC5sZ=1Ko71vbzNz7T8-_pjf7mww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-09-30 at 09:04 -0600, Bjorn Helgaas wrote:
> On Mon, Sep 29, 2014 at 9:40 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > Hi folks !

(Adding linux-pci and Yijing, which I stupidly forgot)

> > Some ATM devices have a limitation in the number of address bits they
> > can generate for MSI and MSI-X (similar to their DMA limitations).
> >
> > This makes it impossible to "reach" the MSI regions for 64-bit MSI on
> > our POWER server chips since those must have some of the top address
> > bits set.
> >
> > For DMA today, we have the DMA mask that handles that limitation fine
> > at the arch level.
> >
> > However we have nothing for MSIs.
> >
> > So far, we've workaround it with a kludge. We maintain a powerpc
> > specific flag in some auxilliary data structure that we keep along
> > with PCI devices and we have a quirk in arch/powerpc/kernel/pci_64.c
> > that will set that flag for some known devices.
> >
> > At this point we have only added two known ATI IDs corresponding to
> > radeons we ship with our machines, but as you can imagine, that not
> > a very good long term solution.
> >
> > Ideally we want that quirk to be set by the driver. The radeon driver
> > "knows" what the addressing capacity of the device it.
> >
> > So the easiest way to handle that for me would be to move that flag
> > "force_32bit_msi" from our arch data structure to pci_dev, and have
> > the radeon driver set it before it enables MSIs.
> >
> > However that would have the side effect of also limiting other archs
> > to 32-bit MSIs while the 40-bit of address (or so ....) that the radeon
> > supports might be sufficient for 64-bit MSIs to work on these.
> >
> > The slightly fancier approach would be to have something like an
> > msi64_set_address_mask() where the driver can configure the supported
> > mask for 64-bit MSIs.
> >
> > This would allow the architecture code to make a smarter decision based
> > on what is actually possible.
> >
> > Any preference, comment or suggestion ?
> 
> Please CC: linux-pci and Yijing Wang <wangyijing@huawei.com> unless
> there's something secret here.  I didn't add them myself in case you
> think this is sensitive.
> 
> If I understand correctly, per spec, devices can support MSI with
> either 32-bit or 64-bit addresses, and they advertise their capability
> via the "64 bit address capable" bit in the Message Control register.
> And per spec, devices that support MSI-X must support 64-bit
> addresses.
> 
> So apparently these devices are not spec compliant.  I suggest that
> you move the "force_32bit" flag into struct pci_dev, set it via a
> quirk, and change drivers/pci/msi.c to use it to override the
> "msi_attrib.is_64" settings in msi_setup_entry() and/or
> msix_setup_entries().
> 
> At this point, I don't see value in adding the complexity to support
> intermediate address sizes between 32 and 64 bits.

Ok, I tend to agree.

Cheers,
Ben.


