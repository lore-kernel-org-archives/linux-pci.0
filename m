Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35426 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932944AbeFLHU1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2018 03:20:27 -0400
Received: by mail-it0-f66.google.com with SMTP id a3-v6so14185122itd.0
        for <linux-pci@vger.kernel.org>; Tue, 12 Jun 2018 00:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <1528785733-19442-1-git-send-email-kernelfans@gmail.com> <20180612065727.GA5195@infradead.org>
In-Reply-To: <20180612065727.GA5195@infradead.org>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 12 Jun 2018 15:20:15 +0800
Message-ID: <CAFgQCTvYDbw3fv7k-Y999F2fCfCs7TiGd4xd6isp0wZBr8dT3Q@mail.gmail.com>
Subject: Re: [PATCH] pci/shpchp: no claim on pcie port device
To: hch@infradead.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 12, 2018 at 2:57 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jun 12, 2018 at 02:42:13PM +0800, Pingfan Liu wrote:
> > The Linux Device Driver Model allows a physical device to be handled
> > by only a single driver. But at present, both shpchp and portdrv_pci
> > claim PCI_CLASS_BRIDGE_PCI, and touch devices_kset. This causes a
> > few problems, one is the wrong shutdown seq of devices, owing to the
> > broken devices_kset.
>
> How can they both touch devices_kset?  Once one driver has claimed the
> device it should not be available to others.
>
Unfortunately, it could be.  There are two code path for do_one_initcall
kernel_init->..->do_one_initcall->pcie_portdrv_init
And
load_module->do_init_module->do_one_initcall->shpcd_init
> > +     /* do not claim pcie port device */
> > +     if (pci_is_pcie(dev) &&
> > +         ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) ||
> > +          (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) ||
> > +          (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)))
> > +             return -ENODEV;
>
> No need for the inner braces.

OK.

Thanks,
Pingfan
