Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36465 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeHFV75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2018 17:59:57 -0400
Received: by mail-qt0-f193.google.com with SMTP id t5-v6so15295827qtn.3
        for <linux-pci@vger.kernel.org>; Mon, 06 Aug 2018 12:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180804101402.10022-1-hch@lst.de> <20180804101402.10022-2-hch@lst.de>
 <20180806112310.GB18685@e107981-ln.cambridge.arm.com> <20180806123051.GA6997@lst.de>
 <CAK8P3a0XyK+j4Z+xhxOYKa=5gHmFnWd7=fU=6A3=VkBXxWjSsw@mail.gmail.com> <20180806145554.GE18685@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180806145554.GE18685@e107981-ln.cambridge.arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 6 Aug 2018 21:49:02 +0200
Message-ID: <CAK8P3a1wFw9HYKPAJatNL3bUQ-u+d_eVok1E7omYWaRf6P+Rbg@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: add a callback to struct pci_host_bridge for
 adding a new device
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 6, 2018 at 4:56 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Aug 06, 2018 at 03:54:13PM +0200, Arnd Bergmann wrote:
> > On Mon, Aug 6, 2018 at 2:25 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Mon, Aug 06, 2018 at 12:23:10PM +0100, Lorenzo Pieralisi wrote:
> > > > >     pci_configure_device(dev);
> > > > > @@ -2328,6 +2329,11 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
> > > > >     ret = pcibios_add_device(dev);
> > > > >     WARN_ON(ret < 0);
> > > > >
> > > > > +   if (host->add_device) {
> > > > > +           ret = host->add_device(dev);
> > > > > +           WARN_ON(ret < 0);
> > > > > +   }
> > > >
> > > > This looks fine; we could go a step further and make the hunk above
> > > > the default (weak) implementation of pcibios_add_device() that is
> > > > currently a NOP returning 0, I will remove it for v4.20.
> > >
> > > I'd love to see pcibios_add_device go away entirely.  But I wonder how to
> > > get setup the pci_host_bridge pointer for the remaining architectures that
> > > still implement it.  I did look for any easy way but couldn't find one.
> > > But then I don't really know this area of the PCI code too well.
> >
> > If the platform doesn't already have a pointer to its pci_host_bridge
> > structure, it can call pci_find_host_bridge(bus->dev) to get it.
> >
> > Ideally, platforms (either arch specific code or drivers/pci/controller)
> > should call pci_alloc_host_bridge()/pci_register_host_bridge()
> > instead of the traditional pci_create_root_bus() that is less flexible.
> > That way, the driver specific structure can get allocated together with
> > the host bridge.
>
> Yes that's basically the gist, it should be a matter of identifying code
> that creates the root bus (explicitly or implicitly - ie
> pci_scan_root_bus()) and patching it up, probably something to be done
> (and moved into -next) early -rc* since it is something that can easily
> break the world if we miss some code paths. I will have a look into
> that and can take this patch for that series if it does not go into
> v4.19.

I've started prototyping something now, will post something tomorrow.
I have an idea for a version that should be minimally invasive, at the
cost of duplicating some code in drivers that still use the old interfaces.

        Arnd
