Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbeIRTTY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Sep 2018 15:19:24 -0400
Date: Tue, 18 Sep 2018 08:46:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc: linux-pci@vger.kernel.org, hch@lst.de
Subject: Re: kernel panic becase pci register more than once
Message-ID: <20180918134642.GB254348@bhelgaas-glaptop.roam.corp.google.com>
References: <CAMDZJNV6D_NCn5_n2DAnPH25DONAKRcc-GWwGbCXX098E+EJ1Q@mail.gmail.com>
 <20180917191503.GA54859@bhelgaas-glaptop.roam.corp.google.com>
 <CAMDZJNUg+d6um2tp20OwyhSYG4WW8jSbwLhDAU8qOsqfkO=EfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMDZJNUg+d6um2tp20OwyhSYG4WW8jSbwLhDAU8qOsqfkO=EfQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2018 at 10:00:11AM +0800, Tonghao Zhang wrote:
> On Tue, Sep 18, 2018 at 3:15 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sun, Sep 09, 2018 at 04:26:37PM +0800, Tonghao Zhang wrote:
> > > When I enable pci msi or msix more than once, the kernel will
> > > panic.  Now we just use the WARN_ON, should we add check for
> > > that has been enabled.

> > A WARN_ON() shouldn't cause the kernel to panic.  Do you mean that
> > it causes a backtrace?  I think that's the intended behavior,
> > because calling this twice would be a driver bug, and we want to
> > find and fix those bugs.

> Yes, you are right, but we can return error code when drivers call
> this twice.

That's possible.  We need a clear explanation for why we're making the
change, and that starts with a clear description of the problem, i.e.,
is the problem that the kernel crashes and a reboot is required, or is
the problem some messages in the dmesg log that look alarming but are
otherwise harmless?  I think the latter.

If we decide that an error return is better than the WARN_ON(), we
need to look at where the check is done.  For example, you currently
check in __pci_enable_msix(), which is only called from
__pci_enable_msix_range().  We should check for simple errors like
this as early as possible, which probably means
__pci_enable_msix_range().

> > > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > > index f2ef896..324840f 100644
> > > --- a/drivers/pci/msi.c
> > > +++ b/drivers/pci/msi.c
> > > @@ -958,7 +958,9 @@ static int __pci_enable_msix(struct pci_dev *dev,
> > > struct msix_entry *entries,
> > >                         }
> > >                 }
> > >         }
> > > -       WARN_ON(!!dev->msix_enabled);
> > > +
> > > +       if (dev->msix_enabled)
> > > +               return -EINVAL;
> > >
> > >         /* Check whether driver already requested for MSI irq */
> > >         if (dev->msi_enabled) {
> > > @@ -1028,7 +1030,8 @@ static int __pci_enable_msi_range(struct pci_dev
> > > *dev, int minvec, int maxvec,
> > >         if (!pci_msi_supported(dev, minvec))
> > >                 return -EINVAL;
> > >
> > > -       WARN_ON(!!dev->msi_enabled);
> > > +       if (dev->msi_enabled)
> > > +               return -EINVAL;
> > >
> > >         /* Check whether driver already requested MSI-X irqs */
> > >         if (dev->msix_enabled) {
