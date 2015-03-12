Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50501 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016AbbCLXVL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Mar 2015 19:21:11 -0400
Date: Fri, 13 Mar 2015 07:21:04 +0800
From: Fam Zheng <famz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Linux Virtualization <virtualization@lists.linux-foundation.org>,
	mst@redhat.com
Subject: Re: [RFC PATCH] PCI: Disable MSI/MSI-X only if device is shutdown
Message-ID: <20150312232104.GA32054@ad.nay.redhat.com>
References: <1426137682-12287-1-git-send-email-famz@redhat.com>
 <5501BCF7.9080004@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5501BCF7.9080004@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 03/12 17:21, Paolo Bonzini wrote:
> On 12/03/2015 06:21, Fam Zheng wrote:
> > If the device doesn't support shutdown, disabling interrupts may cause
> > trouble. For example, virtio-scsi-pci doesn't implement shutdown, and
> > after we disable MSI-X, futher notifications from device will be
> > delivered to IRQ, which is unexpected. This IRQ will not be cleared, and
> > may prevent us from making progress, by keep triggering interrupts.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  drivers/pci/pci-driver.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 3cb2210..fb29c96 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -448,10 +448,11 @@ static void pci_device_shutdown(struct device *dev)
> >  
> >  	pm_runtime_resume(dev);
> >  
> > -	if (drv && drv->shutdown)
> > +	if (drv && drv->shutdown) {
> >  		drv->shutdown(pci_dev);
> > -	pci_msi_shutdown(pci_dev);
> > -	pci_msix_shutdown(pci_dev);
> > +		pci_msi_shutdown(pci_dev);
> > +		pci_msix_shutdown(pci_dev);
> > +	}
> >  
> >  #ifdef CONFIG_KEXEC
> >  	/*
> > 
> 
> The patch may be okay, but I think the bug here is also that virtio-pci
> is not defining a .shutdown callback.  It should define one and call
> free_irq (for INTX) and pci_disable_msix.

It's not enough. The device has to know we disabled msix, otherwise it will
send us IRQ, which is wrong.

> 
> How is this related to the virtio-scsi patch that you posted?  Do you
> need both to fix the problem you reported?
> 

This one should be enough. I was wrong in saying virtio-scsi hanging the
shutdown is because requests not being completed, it's more because of the
unexpected IRQ as explained in [1].

[1]: https://bugzilla.redhat.com/attachment.cgi?id=998391

Fam
