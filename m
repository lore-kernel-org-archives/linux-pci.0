Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37433 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTOmF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Aug 2018 10:42:05 -0400
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de> <20180817102645.3839621-9-arnd@arndb.de>
 <CAJZ5v0jjZx3xCbPK5vfx-OCRNtMt59WQOxCYkWNj33Js_2Xi=A@mail.gmail.com> <CAK8P3a1KWn0=xwrqZ+sF27O-WE6paDxQPg6PPZFcgCrgXGaX2A@mail.gmail.com>
In-Reply-To: <CAK8P3a1KWn0=xwrqZ+sF27O-WE6paDxQPg6PPZFcgCrgXGaX2A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Aug 2018 13:26:39 +0200
Message-ID: <CAJZ5v0htQ0KZ8M1BpE7H7weRS89jJWPtA0xvgAUmN53jx5DSYg@mail.gmail.com>
Subject: Re: [RFC 08/15] x86: PCI: clean up pcibios_scan_root()
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2018 at 1:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Aug 20, 2018 at 10:31 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Fri, Aug 17, 2018 at 12:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > > -static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
> > > -               struct pci_ops *ops, void *sysdata, struct list_head *resources)
> > > +void pcibios_scan_root(int busnum)
> > >  {
> > > +       struct pci_sysdata *sd;
> > >         struct pci_host_bridge *bridge;
> > >         int error;
> > >
> > > -       bridge = pci_alloc_host_bridge(0);
> > > -       if (!bridge)
> > > -               return NULL;
> > > +       bridge = pci_alloc_host_bridge(sizeof(sd));
> > > +       if (!bridge) {
> > > +               printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busnum);
> > > +               return;
> > > +       }
> > > +       sd = pci_host_bridge_priv(bridge);
> >
> > This looks fishy, as bridge->private is not set at this point AFAICS,
> > unless one of the previous patches changes that.
>
> bridge->private what comes after the bridge structure, and it's allocated
> by pci_alloc_host_bridge() passing the size of the structure we want
> for this private area.

I see, sorry for the noise.
