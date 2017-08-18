Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0076.outbound.protection.outlook.com ([104.47.41.76]:43319
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751107AbdHRNmr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Aug 2017 09:42:47 -0400
Date: Fri, 18 Aug 2017 15:42:31 +0200
From: Jan Glauber <jan.glauber@caviumnetworks.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.daney@cavium.com,
        Jon Masters <jcm@redhat.com>,
        Robert Richter <robert.richter@cavium.com>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vfio/pci: Don't probe devices that can't be reset
Message-ID: <20170818134231.GA3464@hc>
References: <1502957663-5527-1-git-send-email-jglauber@cavium.com>
 <1502957663-5527-4-git-send-email-jglauber@cavium.com>
 <20170817070017.1e9c9456@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817070017.1e9c9456@w520.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 17, 2017 at 07:00:17AM -0600, Alex Williamson wrote:
> On Thu, 17 Aug 2017 10:14:23 +0200
> Jan Glauber <jglauber@cavium.com> wrote:
> 
> > If a PCI device supports neither function-level reset, nor slot
> > or bus reset then refuse to probe it. A line is printed to inform
> > the user.
> 
> But that's not what this does, this requires that the device is on a
> reset-able bus.  This is a massive regression.  With this we could no
> longer assign devices on the root complex or any device which doesn't
> return from bus reset and currently makes use of the NO_BUS_RESET flag
> and works happily otherwise.  Full NAK.  Thanks,

Looks like I missed the slot reset check. So how about this:

if (pci_probe_reset_slot(pdev->slot) && pci_probe_reset_bus(pdev->bus)) {
	dev_warn(...);
	return -ENODEV;
}

Or am I still missing something here?

thanks,
Jan

> Alex
>  
> > Without this change starting qemu with a vfio-pci device can lead to
> > a kernel panic on some Cavium cn8xxx systems, depending on the used
> > device.
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > ---
> >  drivers/vfio/pci/vfio_pci.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index 063c1ce..029ba13 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -1196,6 +1196,12 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (pdev->hdr_type != PCI_HEADER_TYPE_NORMAL)
> >  		return -EINVAL;
> >  
> > +	ret = pci_probe_reset_bus(pdev->bus);
> > +	if (ret) {
> > +		dev_warn(&pdev->dev, "Refusing to probe because reset is not possible.\n");
> > +		return ret;
> > +	}
> > +
> >  	group = vfio_iommu_group_get(&pdev->dev);
> >  	if (!group)
> >  		return -EINVAL;
