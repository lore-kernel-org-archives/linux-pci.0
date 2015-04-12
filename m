Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51681 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbbDLIwG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 12 Apr 2015 04:52:06 -0400
Date: Sun, 12 Apr 2015 10:52:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 04/10] pci: don't disable msi/msix at shutdown
Message-ID: <20150412095848-mutt-send-email-mst@redhat.com>
References: <1427641227-7574-1-git-send-email-mst@redhat.com>
 <1427641227-7574-5-git-send-email-mst@redhat.com>
 <20150410183304.GA28348@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150410183304.GA28348@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 10, 2015 at 01:33:04PM -0500, Bjorn Helgaas wrote:
> Hi Michael,
> 
> On Sun, Mar 29, 2015 at 05:04:11PM +0200, Michael S. Tsirkin wrote:
> > This partially reverts commit d52877c7b1afb8c37ebe17e2005040b79cb618b0:
> > 	"pci/irq: let pci_device_shutdown to call pci_msi_shutdown v2"
> > 
> > It's un-necessary now that we disable msi at start, and it actually
> > turns out to cause problems: some device drivers don't register a level
> > interrupt handler when they detect msi/msix capability, switching off
> > msi while device is going causes device to assert a level interrupt
> > which is never de-asserted, causing a kernel hang.
> > 
> > In particular, this was observed with virtio.
> 
> I'm not questioning that this hang happens, but would you mind outlining
> *how* it happens in a little more detail?  I'm not an IRQ expert, so I
> expected an "irq %d: nobody cared" message or something similar.  It seems
> like a kernel hang is a pretty severe way to deal with an unexpected
> interrupt.

True. I intend to look into how this interacts with spurious
interrupt detection some more. Avoiding spurious interrupts
seems like a worthwhile goal in any case, right?

It seems clear how this will cause hangs when noirqdebug is set (later leads
to softlockup detected messages, or crash if softlockup_panic=1 is set).

> Is virtio the only way the hang could happen, or is it just coincidence
> that it was involved?

Well, you need a driver which doesn't handle level IRQs
when it enables MSI. virtio is one such driver.


> It'd be really nice if we could reference the bug report here.  I think you
> said the original report was private.  Can we open a kernel.org bugzilla
> that contains just the public information?

Ulrich Obergfell did most of the work on reproducing this,
Fam Zheng did most debugging, so I'd like one of them
to do this, so they get the appropriate credit.
Fam, Ulrich?

> > Cc: Yinghai Lu <yhlu.kernel.send@gmail.com>
> > Cc: Ulrich Obergfell <uobergfe@redhat.com>
> > Cc: Rusty Russell <rusty@rustcorp.com.au>
> > Reported-by: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/pci/pci-driver.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 3cb2210..38a602c 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -450,8 +450,6 @@ static void pci_device_shutdown(struct device *dev)
> >  
> >  	if (drv && drv->shutdown)
> >  		drv->shutdown(pci_dev);
> > -	pci_msi_shutdown(pci_dev);
> > -	pci_msix_shutdown(pci_dev);
> >  
> >  #ifdef CONFIG_KEXEC
> >  	/*
> > -- 
> > MST
> > 
