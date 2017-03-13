Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbdCMWqZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Mar 2017 18:46:25 -0400
Date: Mon, 13 Mar 2017 17:46:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
        David Laight <david.laight@aculab.com>,
        Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>
Subject: Re: Neophyte questions about PCIe
Message-ID: <20170313224619.GF8232@bhelgaas-glaptop.roam.corp.google.com>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <9ba05c2c-57ef-b2c0-6a7c-457c392d98b5@free.fr>
 <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
 <c0a353cb-aa1f-25db-eccd-7a1618e655b3@free.fr>
 <20170313214024.GD8232@bhelgaas-glaptop.roam.corp.google.com>
 <826d0a3f-753f-0330-5792-e11beb78d6bf@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <826d0a3f-753f-0330-5792-e11beb78d6bf@free.fr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 10:57:48PM +0100, Mason wrote:
> On 13/03/2017 22:40, Bjorn Helgaas wrote:
> 
> > On Sat, Mar 11, 2017 at 11:57:56AM +0100, Mason wrote:
> >
> >> On 10/03/2017 18:49, Mason wrote:
> >> 
> >>> static void tango_pcie_bar_quirk(struct pci_dev *dev)
> >>> {
> >>> 	struct pci_bus *bus = dev->bus;
> >>>
> >>> 	printk("%s: bus=%d devfn=%d\n", __func__, bus->number, dev->devfn);
> >>>
> >>>         pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000004);
> >>> }
> >>> DECLARE_PCI_FIXUP_FINAL(0x1105, PCI_ANY_ID, tango_pcie_bar_quirk);
> >>
> >> And this is where the elusive "black magic" happens.
> >>
> >> Is it "safe" to configure a BAR behind Linux's back?
> > 
> > No.  Linux maintains a struct resource for every BAR.  This quirk
> > makes the BAR out of sync with the resource, so Linux no longer has an
> > accurate idea of what bus address space is consumed and what is
> > available.
> 
> Even when Linux is not able to map the BAR, since it's too
> large to fit in the mem window?

I don't think there's much point in advertising a BAR that isn't
really a BAR and making assumptions about how Linux will handle it.
So my answer remains "No, I don't think it's a good idea to change a
BAR behind the back of the PCI core.  It might work now, but there's
no guarantee it will keep working."

> > Normally a BAR is for mapping device registers into PCI bus address
> > space.  If this BAR controls how the RC forwards PCI DMA transactions
> > to RAM, then it's not really a BAR and you should prevent Linux from
> > seeing it as a BAR.  You could do this by special-casing it in the
> > config accessor so reads return 0 and writes are dropped.  Then you
> > could write the register in your host bridge driver safely because the
> > PCI core would think the BAR is not implemented.
> 
> In fact, that's what I used to do in a previous version :-)
> 
> I'd like to push support for this PCIe controller upstream.
> 
> Is the code I posted on the right track?
> Maybe I can post a RFC patch tomorrow?

No need to ask before posting a patch :)
