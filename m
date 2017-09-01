Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752553AbdIAWRp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Sep 2017 18:17:45 -0400
Date: Fri, 1 Sep 2017 17:17:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] PCI: v3-semi: Add a V3 Semiconductor PCI host
 driver
Message-ID: <20170901221739.GA8970@bhelgaas-glaptop.roam.corp.google.com>
References: <20170809141455.22220-1-linus.walleij@linaro.org>
 <20170809141455.22220-2-linus.walleij@linaro.org>
 <20170822190137.GB6948@bhelgaas-glaptop.roam.corp.google.com>
 <CACRpkdbMqZpZT9te1oAw49t48XC3DRuXd4VRrUCCDDn9nD1maA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdbMqZpZT9te1oAw49t48XC3DRuXd4VRrUCCDDn9nD1maA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rob, Frank, devicetree list to make sure I got the config space
part right]

On Fri, Sep 01, 2017 at 05:49:28PM +0200, Linus Walleij wrote:
> On Tue, Aug 22, 2017 at 9:01 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Wed, Aug 09, 2017 at 04:14:55PM +0200, Linus Walleij wrote:
> 
> >> OF: PCI: host bridge /pciv3@62000000 ranges:
> >> OF: PCI:   No bus range found for /pciv3@62000000, using [bus 00-ff]
> >> OF: PCI:   err 0x61000000..0x61ffffff -> 0x61000000
> 
> Yeah it is called "err"
> 
> >> OF: PCI:    IO 0x60000000..0x600fffff -> 0x00000000
> >> OF: PCI:   MEM 0x40000000..0x4fffffff -> 0x00000000
> >> OF: PCI:   MEM 0x50000000..0x5fffffff -> 0x10000000
> >> pci-v3-semi 62000000.pciv3: BUS 0
> >> pci-v3-semi 62000000.pciv3: CONFIG SPACE window
> >>   start 61000000, size 01000000 (offset = 00000000, bus addr = 61000000)
> 
> But as it says here it is config space.
> 
> >> pci-v3-semi 62000000.pciv3: I/O window
> >>   start 00000000, bus addr 00000000, size 00100000
> >> pci-v3-semi 62000000.pciv3: NON-PREFETCHABLE MEM window
> >>   start 40000000, bus addr 00000000, size 10000000
> >> pci-v3-semi 62000000.pciv3: PREFETCHABLE MEM window
> >>   start 50000000, bus addr 10000000, size 10000000
> >> pci-v3-semi 62000000.pciv3: FIFO_CFG: 0000  FIFO_PRIO: 0000
> >> pci-v3-semi 62000000.pciv3: initialized PCI V3 Integrator/AP integration
> >> pci-v3-semi 62000000.pciv3: PCI host bridge to bus 0000:00
> >> pci_bus 0000:00: root bus resource [bus 00-ff]
> >> pci_bus 0000:00: root bus resource [??? 0x61000000-0x61ffffff flags 0x0]
> >
> > I think this is wrong.  Looks like this might be memory-mapped config
> > space (e.g., MMCONFIG or ECAM-like space), which is not a window and
> > shouldn't be added to the root bus resources.
> 
> So it comes from ranges, and I take it that actually the device
> tree is wrong because it looks like this:
> 
> reg = <0x62000000 0x10000>;
> ranges = <0x00000000 0 0x61000000 /* config space */
>         0x61000000 0 0x01000000 /* 16 MiB @ 61000000 */
>         0x01000000 0 0x0 /* I/O space */
>         0x60000000 0 0x00100000 /* 16 MiB @ 60000000 */
>         0x02000000 0 0x00000000 /* non-prefectable memory */
>         0x40000000 0 0x10000000 /* 256 MiB @ 40000000 */
>         0x42000000 0 0x10000000 /* prefetchable memory */
>         0x50000000 0 0x10000000>; /* 256 MiB @ 50000000 */
> 
> So what you're saying is that the config space should not be in the
> ranges but in the reg = <> property (second register range) so that
> the reg and ranges looks like this:
> 
> reg = <0x62000000 0x10000>, <0x61000000 0x01000000>;

Yes.  Documentation/devicetree/bindings/pci/designware-pcie.txt has a
little text about the typical way to do this.  Maybe this should be copied
or moved to pci.txt.

> ranges = <0x00000000 0 0x61000000 /* config space */
>         0x60000000 0 0x00100000 /* 16 MiB @ 60000000 */
>         0x02000000 0 0x00000000 /* non-prefectable memory */
>         0x40000000 0 0x10000000 /* 256 MiB @ 40000000 */
>         0x42000000 0 0x10000000 /* prefetchable memory */
>         0x50000000 0 0x10000000>; /* 256 MiB @ 50000000 */
> 
> So there is only a range for mapping the physical address
> 0x61000000 to PCI address 0x00000000.

I don't understand this; maybe a typo?  IIUC, the 16 MiB @ 61000000
region is essentially bridge register space: it is decoded by the
bridge, which then generates PCI config transactions with bus/dev/fn
determined by the register address.

> I don't mind altering the device trees, we don't have it deployed
> in flash or anything. I think we simply got this thing wrong when
> I first converted it over.

incidental: s/prefectable/prefetchable/ above

> > The driver still needs it internally, of course, and maybe could print
> > something similar to what we do for ECAM:
> >
> >   dev_info(dev, "ECAM at %pR for %pR\n", &cfg->res, &cfg->busr)
> >
> > (I don't know if this is actually identical to ECAM, so maybe there's
> > a better internally-used name for the region, but we could print the
> > memory and bus resources similarly.)
> 
> Sure, we just need to figure out if it should be in reg
> or ranges first.

> >> +     list_splice_init(&res, &host->windows);
> >> +     ret = pci_scan_root_bus_bridge(host);
> >> +     if (ret) {
> >> +             dev_err(dev, "failed to register host: %d\n", ret);
> >> +             return ret;
> >> +     }
> >> +     v3->bus = host->bus;
> >> +
> >> +     pci_bus_assign_resources(v3->bus);
> >> +     pci_bus_add_devices(v3->bus);
> >> +     pci_free_resource_list(&res);
> >
> > I think pci_free_resource_list() should be called only if an error
> > occurs, shouldn't it?
> 
> I'm not sure. I was under the impression that list_splice_init() makes
> a copy of it into host->windows and then we should discard it after
> use.

I don't think list_splice_init() does any copying.  In the non-error
case, we call pci_free_resource_list() from pci_free_host_bridge()
if/when the host bridge is removed.  The other callers of
pci_free_resource_list() are all in error handling paths.

Bjorn
