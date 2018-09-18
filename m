Return-Path: <SRS0=r7iM=MA=gmail.com=xiangxia.m.yue@kernel.org>
Return-Path: <SRS0=r7iM=MA=gmail.com=xiangxia.m.yue@kernel.org>
MIME-Version: 1.0
References: <CAMDZJNV6D_NCn5_n2DAnPH25DONAKRcc-GWwGbCXX098E+EJ1Q@mail.gmail.com>
 <20180917191503.GA54859@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180917191503.GA54859@bhelgaas-glaptop.roam.corp.google.com>
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Tue, 18 Sep 2018 10:00:11 +0800
Message-ID: <CAMDZJNUg+d6um2tp20OwyhSYG4WW8jSbwLhDAU8qOsqfkO=EfQ@mail.gmail.com>
Subject: Re: kernel panic becase pci register more than once
To: helgaas@kernel.org
Cc: linux-pci@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2018 at 3:15 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Christoph]
>
> On Sun, Sep 09, 2018 at 04:26:37PM +0800, Tonghao Zhang wrote:
> > Hi all,
> > When I enable pci msi or msix more than once, the kernel will panic.
> > Now we just use the WARN_ON, should we add check for that has been
> > enabled.
> >
>
> This needs a signed-off-by before I can apply it.  See
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n416
OK
> A WARN_ON() shouldn't cause the kernel to panic.  Do you mean that it
> causes a backtrace?  I think that's the intended behavior, because
> calling this twice would be a driver bug, and we want to find and fix
> those bugs.
Yes, you are right, but we can return error code when drivers call this twice.
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index f2ef896..324840f 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -958,7 +958,9 @@ static int __pci_enable_msix(struct pci_dev *dev,
> > struct msix_entry *entries,
> >                         }
> >                 }
> >         }
> > -       WARN_ON(!!dev->msix_enabled);
> > +
> > +       if (dev->msix_enabled)
> > +               return -EINVAL;
> >
> >         /* Check whether driver already requested for MSI irq */
> >         if (dev->msi_enabled) {
> > @@ -1028,7 +1030,8 @@ static int __pci_enable_msi_range(struct pci_dev
> > *dev, int minvec, int maxvec,
> >         if (!pci_msi_supported(dev, minvec))
> >                 return -EINVAL;
> >
> > -       WARN_ON(!!dev->msi_enabled);
> > +       if (dev->msi_enabled)
> > +               return -EINVAL;
> >
> >         /* Check whether driver already requested MSI-X irqs */
> >         if (dev->msix_enabled) {
