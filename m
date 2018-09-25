Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E352C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 21:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF4D20843
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 21:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdFjK2rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF4D20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725734AbeIZEGh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725733AbeIZEGh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 00:06:37 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A0A220842;
        Tue, 25 Sep 2018 21:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537912618;
        bh=EkxMY/7ik6OYr8OZDNHQyEYe1W5jm6zenbE+mBtLQrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdFjK2rbC3EZjUeE+8TfnnPgNbo2Qa6DhXYpPWan2r3oXxVOh/533FFBX0nX27Luj
         h2MGtzMR3oelQIUto0dO/hw4FeJr94fE01WSxnjrW1i8jPaNP26gUkBnrTEePslEfD
         wICddg0smRCPItwjOo9czpaWxaQ02p5syQRQ0X3M=
Date:   Tue, 25 Sep 2018 16:56:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v4 6/6] PCI: Expose reset type to users of pci_reset_bus()
Message-ID: <20180925215656.GF80129@bhelgaas-glaptop.roam.corp.google.com>
References: <20180919163037.13497-1-okaya@kernel.org>
 <20180919163037.13497-7-okaya@kernel.org>
 <20180925205408.GD80129@bhelgaas-glaptop.roam.corp.google.com>
 <e89e160b-74dc-d912-5999-685069262b30@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89e160b-74dc-d912-5999-685069262b30@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 05:15:52PM -0400, Sinan Kaya wrote:
> On 9/25/2018 4:54 PM, Bjorn Helgaas wrote:
> > On Wed, Sep 19, 2018 at 04:30:37PM +0000, Sinan Kaya wrote:
> > > Looking to have more control between the users of the API vs. what the API
> > > can do internally. The new reset_type tells the PCI core about the bounds
> > > of the request.
> > > 
> > > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > > ---
> > >   drivers/pci/pci.c           | 18 +++++++++++++++---
> > >   drivers/vfio/pci/vfio_pci.c |  6 ++++--
> > >   include/linux/pci.h         |  2 +-
> > >   3 files changed, 20 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index b4f14419bd51..f11d29f32119 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5232,13 +5232,25 @@ static int __pci_reset_bus(struct pci_bus *bus)
> > >   /**
> > >    * pci_reset_bus - Try to reset a PCI bus
> > >    * @pdev: top level PCI device to reset via slot/bus
> > > + * @reset_type: resets to try
> > >    *
> > >    * Same as above except return -EAGAIN if the bus cannot be locked
> > >    */
> > > -int pci_reset_bus(struct pci_dev *pdev)
> > > +int pci_reset_bus(struct pci_dev *pdev, u32 reset_type)
> > >   {
> > > -	return (!pci_probe_reset_slot(pdev->slot)) ?
> > > -	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
> > > +	if (reset_type & PCI_RESET_LINK) {
> > > +		return (!pci_probe_reset_slot(pdev->slot)) ?
> > > +				__pci_reset_slot(pdev->slot) :
> > > +				__pci_reset_bus(pdev->bus);
> > > +	}
> > > +
> > > +	if (reset_type & PCI_RESET_BUS)
> > > +		return __pci_reset_bus(pdev->bus);
> > > +
> > > +	if (reset_type & PCI_RESET_SLOT)
> > > +		return __pci_reset_slot(pdev->slot);
> > 
> > I don't understand this code.  We have
> > 
> >    #define PCI_RESET_LINK         (PCI_RESET_SLOT | PCI_RESET_BUS)
> > 
> > so if either PCI_RESET_BUS or PCI_RESET_SLOT is set, we should take
> > the first "if" above, which always returns, and the last two should
> > never be reached.  What am I missing?
> 
> Yup, this is broken. I need to follow up with another patchset.
> 
> I was trying to cover the case where user said,
> 
> "I need a link reset. I don't care whether it is a slot reset or bus reset
> as long as we achieve a reset."
> 
> That's when PCI_RESET_LINK is used. We expect most drivers to PCI_RESET_LINK
> if they are interested in a link reset and doesn't need to know about the
> hotplug capability of a particular slot.
> 
> > 
> > > +
> > > +	return -EINVAL;
> > >   }
> > >   EXPORT_SYMBOL_GPL(pci_reset_bus);
> > > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > > index fe7ada997c51..0e80c72b1eaa 100644
> > > --- a/drivers/vfio/pci/vfio_pci.c
> > > +++ b/drivers/vfio/pci/vfio_pci.c
> > > @@ -1015,7 +1015,8 @@ static long vfio_pci_ioctl(void *device_data,
> > >   						    &info, slot);
> > >   		if (!ret)
> > >   			/* User has access, do the reset */
> > > -			ret = pci_reset_bus(vdev->pdev);
> > > +			ret = pci_reset_bus(vdev->pdev,
> > > +				slot ? PCI_RESET_SLOT :	PCI_RESET_BUS);
> > 
> > This is the only place in the whole series where a caller uses
> > something other than PCI_RESET_ANY.  Inquiring minds want to know why.
> > I'm sure it's the right thing to do, it's just that we'll need to know
> > how to choose in future cases.
> 
> Use PCI_RESET_ANY for the existing behavior where you want one type of
> reset and don't care if it is PM/function/slot/bus/specific.
> 
> Use PCI_RESET_LINK when you need link to retrain.

There are no callers using this.  Is this intended specifically for
the case of "the hardware wasn't smart enough to train at the correct
speed, so we fiddled things and want to retrain"?

Maybe it doesn't need to be exposed in include/linux/pci.h and could
be defined internally in drivers/pci/pci.c if it's needed there?

> Use PCI_RESET_SLOT when you know that this system is hotplug capable
> by calling probe functions.

I raise my eyebrows at this because (a) a driver generally can't tell
whether hotplug is supported and (b) even if the driver does know,
what is the benefit to the driver to specify this?  What probe
functions does this refer to?  If I'm a driver writer, I really can't
tell what I'm supposed to do with this guidance.  If I'm supposed to
call a probe function, what is it, when should I call it, and what
should I do with the result?  Am I supposed to know whether hotplug is
supported?  Why would I care?

I'm sure you have good answers for all these questions; I just don't
know what they are :)

> Use PCI_RESET_BUS when you know that this system is not hotplug capable
> and this endpoint will never be used in such a system.

How can a driver know this?  And what's the benefit of being specific?

> I can capture this into the commit message.

I think it needs to be more accessible, e.g., comments near the constants
and/or the function declaration.  We shouldn't expect users of the
interface to dig through the changelogs for it.

> > >   hot_reset_release:
> > >   		for (i--; i >= 0; i--)
> > > @@ -1390,7 +1391,8 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
> > >   	}
> > >   	if (needs_reset)
> > > -		ret = pci_reset_bus(vdev->pdev);
> > > +		ret = pci_reset_bus(vdev->pdev,
> > > +				slot ? PCI_RESET_SLOT :	PCI_RESET_BUS);
> > >   put_devs:
> > >   	for (i = 0; i < devs.cur_index; i++) {
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 4fdddcb85066..85f48e156753 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1128,7 +1128,7 @@ int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
> > >   int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
> > >   int pci_probe_reset_slot(struct pci_slot *slot);
> > >   int pci_probe_reset_bus(struct pci_bus *bus);
> > > -int pci_reset_bus(struct pci_dev *dev);
> > > +int pci_reset_bus(struct pci_dev *dev, u32 reset_type);
> > >   void pci_reset_secondary_bus(struct pci_dev *dev);
> > >   void pcibios_reset_secondary_bus(struct pci_dev *dev);
> > >   void pci_update_resource(struct pci_dev *dev, int resno);
> > > -- 
> > > 2.18.0
> > > 
> > 
> 
