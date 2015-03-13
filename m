Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37333 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbbCMENq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 13 Mar 2015 00:13:46 -0400
Message-ID: <1426220023.3643.93.camel@redhat.com>
Subject: Re: [RFC PATCH] PCI: Disable MSI/MSI-X only if device is shutdown
From: Alex Williamson <alex.williamson@redhat.com>
To: Bandan Das <bsd@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Thu, 12 Mar 2015 22:13:43 -0600
In-Reply-To: <jpg8uf1twxs.fsf@redhat.com>
References: <1426137682-12287-1-git-send-email-famz@redhat.com>
	 <jpgk2ylzs62.fsf@redhat.com> <20150313020919.GD32054@ad.nay.redhat.com>
	 <jpg8uf1twxs.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-03-12 at 23:09 -0400, Bandan Das wrote:
> Ccing Alex, he can probably confirm if my understanding is indeed correct.
> 
> Fam Zheng <famz@redhat.com> writes:
> 
> > On Thu, 03/12 19:56, Bandan Das wrote:
> >> Hi Fam,
> >> 
> >> Fam Zheng <famz@redhat.com> writes:
> >> 
> >> > If the device doesn't support shutdown, disabling interrupts may cause
> >> > trouble. For example, virtio-scsi-pci doesn't implement shutdown, and
> >> > after we disable MSI-X, futher notifications from device will be
> >> > delivered to IRQ, which is unexpected. This IRQ will not be cleared, and
> >> > may prevent us from making progress, by keep triggering interrupts.

Won't it be disabled as a spurious interrupt if it's retriggering that
quickly?  Is there something unique about virtio that makes this worse
than bare metal?

> >> > Signed-off-by: Fam Zheng <famz@redhat.com>
> >> > ---
> >> >  drivers/pci/pci-driver.c | 7 ++++---
> >> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >> > index 3cb2210..fb29c96 100644
> >> > --- a/drivers/pci/pci-driver.c
> >> > +++ b/drivers/pci/pci-driver.c
> >> > @@ -448,10 +448,11 @@ static void pci_device_shutdown(struct device *dev)
> >> >  
> >> >  	pm_runtime_resume(dev);
> >> >  
> >> > -	if (drv && drv->shutdown)
> >> > +	if (drv && drv->shutdown) {
> >> >  		drv->shutdown(pci_dev);
> >> > -	pci_msi_shutdown(pci_dev);
> >> > -	pci_msix_shutdown(pci_dev);
> >> > +		pci_msi_shutdown(pci_dev);
> >> > +		pci_msix_shutdown(pci_dev);
> >> > +	}
> >> 
> >> If the driver doesn't provide a shutdown method and doesn't itself
> >> disable MSI/MSI-X, then pci_msi(x)_shutdown won't be called anymore,
> >> no ?
> >
> > Right.
> >
> >> 
> >> This is probably ok (but unclean) for a system shutdown, but could
> >> cause problems for something like kexec ?
> >
> > Doesn't the reset in kexec clean this up during initialization?
> 
> I guess it would take the same path as a reboot.

If we were to kexec, the only thing I see touching MSI/X enable bits is
pci_msi_init_pci_dev(), which unconditionally disables MSI/X as we walk
PCI and discover devices.  Why is disabling there any different?  A new
instance of the virtio driver hasn't yet been bound to the device to
quiesce it.

> > Without shutdown, anything in the driver is unclean anyway, for example
> > free_irq is not called.
> 
> True, And that is why the MSI/-X shutdown functions are called here
> because pci can't always rely on the individual device drivers to do
> the right thing, but atleast can make a best effort at cleaning up.

A concern with this patch would be that some drivers potentially don't
implement a shutdown routine because they rely on pci-core to do this
minimal cleanup.  I'm tempted to suggest adding a call to pci_intx() to
disable INTx as part of the PCI-core shutdown, but that sounds like
asking for trouble with broken legacy devices.  It sure seems a lot
safer to make a virtio-scsi-pci shutdown function.  Thanks,

Alex

