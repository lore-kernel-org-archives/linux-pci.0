Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B7DC282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF7120685
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 18:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388884AbfDXSDr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:03:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389062AbfDXRTq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5585EC0B2C45;
        Wed, 24 Apr 2019 17:19:45 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 254CF5D705;
        Wed, 24 Apr 2019 17:19:44 +0000 (UTC)
Date:   Wed, 24 Apr 2019 11:19:43 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     <Alex_Gagniuc@Dellteam.com>
Cc:     <bhelgaas@google.com>, <helgaas@kernel.org>,
        <mr.nuke.me@gmail.com>, <linux-pci@vger.kernel.org>,
        <Austin.Bolen@dell.com>, <keith.busch@intel.com>,
        <Shyam.Iyer@dell.com>, <lukas@wunner.de>, <okaya@kernel.org>,
        <torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Add link_change error handler and vfio-pci user
Message-ID: <20190424111943.376d7d24@x1.home>
In-Reply-To: <44c43b8c1739488181930c074bb6eddb@ausx13mps321.AMER.DELL.COM>
References: <155605909349.3575.13433421148215616375.stgit@gimli.home>
        <44c43b8c1739488181930c074bb6eddb@ausx13mps321.AMER.DELL.COM>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 24 Apr 2019 17:19:45 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 24 Apr 2019 16:45:45 +0000
<Alex_Gagniuc@Dellteam.com> wrote:

> On 4/23/2019 5:42 PM, Alex Williamson wrote:
> > The PCIe bandwidth notification service generates logging any time a
> > link changes speed or width to a state that is considered downgraded.
> > Unfortunately, it cannot differentiate signal integrity related link
> > changes from those intentionally initiated by an endpoint driver,
> > including drivers that may live in userspace or VMs when making use
> > of vfio-pci.  Therefore, allow the driver to have a say in whether
> > the link is indeed downgraded and worth noting in the log, or if the
> > change is perhaps intentional.
> > 
> > For vfio-pci, we don't know the intentions of the user/guest driver
> > either, but we do know that GPU drivers in guests actively manage
> > the link state and therefore trigger the bandwidth notification for
> > what appear to be entirely intentional link changes.
> > 
> > Fixes: e8303bb7a75c PCI/LINK: Report degraded links via link bandwidth notification
> > Link: https://lore.kernel.org/linux-pci/155597243666.19387.1205950870601742062.stgit@gimli.home/T/#u
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> > 
> > Changing to pci_dbg() logging is not super usable, so let's try the
> > previous idea of letting the driver handle link change events as they
> > see fit.  Ideally this might be two patches, but for easier handling,
> > folding the pci and vfio-pci bits together.  Comments?  Thanks,  
> 
> I think this callback opens up a can of worms where drivers can ad-hoc 
> kill a number what otherwise can be indicators of problems. But I don't 
> have to like it to review it :).
> 
> >   drivers/pci/probe.c         |   13 +++++++++++++
> >   drivers/vfio/pci/vfio_pci.c |   10 ++++++++++
> >   include/linux/pci.h         |    3 +++
> >   3 files changed, 26 insertions(+)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 7e12d0163863..233cd4b5b6e8 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2403,6 +2403,19 @@ void pcie_report_downtraining(struct pci_dev *dev)  
> 
> I don't think you want to change pcie_report_downtraining(). You're 
> advertising to "report" something, by nomenclature, but then go around 
> and also call a notification callback. This is also used during probe, 
> and you've now just killed your chance to notice you've booted with a 
> degraded link.
> If what you want to do is silence the bandwidth notification, you want 
> to modify the threaded interrupt that calls this.

During probe, ie. discovery, a device wouldn't have a driver attached,
so we'd fall through to simply printing the link status.  Nothing
lost afaict.  The "report" verb doesn't have a subject here, report to
whom?  Therefore I thought it reasonable that a driver ask that it be
reported to them via a callback.  I don't see that as such a stretch of
the interface.
 
> >   	if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
> >   		return;
> >   
> > +	/*
> > +	 * If driver handles link_change event, defer to driver.  PCIe drivers
> > +	 * can call pcie_print_link_status() to print current link info.
> > +	 */
> > +	device_lock(&dev->dev);
> > +	if (dev->driver && dev->driver->err_handler &&
> > +	    dev->driver->err_handler->link_change) {
> > +		dev->driver->err_handler->link_change(dev);
> > +		device_unlock(&dev->dev);
> > +		return;
> > +	}
> > +	device_unlock(&dev->dev);  
> 
> Can we write this such that there is a single lock()/unlock() pair?

Not without introducing a tracking variable, ex.

bool handled = false;

lock()
if (stuff) {
  link_change()
  handled = true;
}
unlock()

if (!handled)
  dmesg spew

That's not markedly better imo, but if it's preferred I can send a v2.
Thanks,

Alex
 
> > +
> >   	/* Print link status only if the device is constrained by the fabric */
> >   	__pcie_print_link_status(dev, false);
> >   }
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index cab71da46f4a..c9ffc0ccabb3 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -1418,8 +1418,18 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
> >   	return PCI_ERS_RESULT_CAN_RECOVER;
> >   }
> >   
> > +/*
> > + * Ignore link change notification, we can't differentiate signal related
> > + * link changes from user driver power management type operations, so do
> > + * nothing.  Potentially this could be routed out to the user.
> > + */
> > +static void vfio_pci_link_change(struct pci_dev *pdev)
> > +{
> > +}
> > +
> >   static const struct pci_error_handlers vfio_err_handlers = {
> >   	.error_detected = vfio_pci_aer_err_detected,
> > +	.link_change = vfio_pci_link_change,
> >   };
> >   
> >   static struct pci_driver vfio_pci_driver = {
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 27854731afc4..e9194bc03f9e 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -763,6 +763,9 @@ struct pci_error_handlers {
> >   
> >   	/* Device driver may resume normal operations */
> >   	void (*resume)(struct pci_dev *dev);
> > +
> > +	/* PCIe link change notification */
> > +	void (*link_change)(struct pci_dev *dev);
> >   };
> >   
> >   
> > 
> >   
> 
> 

