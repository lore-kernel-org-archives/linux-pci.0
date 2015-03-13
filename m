Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33713 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbbCMDJ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Mar 2015 23:09:56 -0400
From: Bandan Das <bsd@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH] PCI: Disable MSI/MSI-X only if device is shutdown
References: <1426137682-12287-1-git-send-email-famz@redhat.com>
	<jpgk2ylzs62.fsf@redhat.com>
	<20150313020919.GD32054@ad.nay.redhat.com>
Date: Thu, 12 Mar 2015 23:09:51 -0400
In-Reply-To: <20150313020919.GD32054@ad.nay.redhat.com> (Fam Zheng's message
	of "Fri, 13 Mar 2015 10:09:19 +0800")
Message-ID: <jpg8uf1twxs.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ccing Alex, he can probably confirm if my understanding is indeed correct.

Fam Zheng <famz@redhat.com> writes:

> On Thu, 03/12 19:56, Bandan Das wrote:
>> Hi Fam,
>> 
>> Fam Zheng <famz@redhat.com> writes:
>> 
>> > If the device doesn't support shutdown, disabling interrupts may cause
>> > trouble. For example, virtio-scsi-pci doesn't implement shutdown, and
>> > after we disable MSI-X, futher notifications from device will be
>> > delivered to IRQ, which is unexpected. This IRQ will not be cleared, and
>> > may prevent us from making progress, by keep triggering interrupts.
>> >
>> > Signed-off-by: Fam Zheng <famz@redhat.com>
>> > ---
>> >  drivers/pci/pci-driver.c | 7 ++++---
>> >  1 file changed, 4 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> > index 3cb2210..fb29c96 100644
>> > --- a/drivers/pci/pci-driver.c
>> > +++ b/drivers/pci/pci-driver.c
>> > @@ -448,10 +448,11 @@ static void pci_device_shutdown(struct device *dev)
>> >  
>> >  	pm_runtime_resume(dev);
>> >  
>> > -	if (drv && drv->shutdown)
>> > +	if (drv && drv->shutdown) {
>> >  		drv->shutdown(pci_dev);
>> > -	pci_msi_shutdown(pci_dev);
>> > -	pci_msix_shutdown(pci_dev);
>> > +		pci_msi_shutdown(pci_dev);
>> > +		pci_msix_shutdown(pci_dev);
>> > +	}
>> 
>> If the driver doesn't provide a shutdown method and doesn't itself
>> disable MSI/MSI-X, then pci_msi(x)_shutdown won't be called anymore,
>> no ?
>
> Right.
>
>> 
>> This is probably ok (but unclean) for a system shutdown, but could
>> cause problems for something like kexec ?
>
> Doesn't the reset in kexec clean this up during initialization?

I guess it would take the same path as a reboot.

> Without shutdown, anything in the driver is unclean anyway, for example
> free_irq is not called.

True, And that is why the MSI/-X shutdown functions are called here
because pci can't always rely on the individual device drivers to do
the right thing, but atleast can make a best effort at cleaning up.

> Fam
