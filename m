Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0132.outbound.protection.outlook.com ([157.56.110.132]:41024
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751046AbaKDIKT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Nov 2014 03:10:19 -0500
From: Rajat Jain <rajatjain@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Sandeep Mann <sandeep@purestorage.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rajatxjain@gmail.com" <rajatxjain@gmail.com>,
	Guenter Roeck <groeck@juniper.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"Tejun Heo" <tj@kernel.org>
Subject: RE: [PATCH] PCI: pciehp: Use ordered workqueue for HPC events
Date: Tue, 4 Nov 2014 08:10:15 +0000
Message-ID: <9d8b44697a4e42a5a69012a5f3be1b26@DM2PR05MB975.namprd05.prod.outlook.com>
References: <1406933232-1560-1-git-send-email-sandeep@purestorage.com>
 <20140904211042.GD17125@google.com>
In-Reply-To: <20140904211042.GD17125@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> Sent: Thursday, September 04, 2014 2:11 PM
> To: Sandeep Mann
> Cc: linux-pci@vger.kernel.org
> Subject: Re: [PATCH] PCI: pciehp: Use ordered workqueue for HPC events
> 
> On Fri, Aug 01, 2014 at 03:47:12PM -0700, Sandeep Mann wrote:
> > Using an ordered workqueue serializes processing of hotplug event.
> > Processing an hotplug event for some devices can take a relatively
> > "long" time, which means if a device is added and removed in quick
> > succession (or due to flacky hardware), it can lead to multiple
> > outstanding hotplug events. Processing these events concurrently can
> > lead to unknown internal state and/or kernel panics.
> >
> > Signed-off-by: Sandeep Mann <sandeep@purestorage.com>
Acked-by: Rajat Jain <rajatxjain@gmail.com>

> 
> What's the status of this?  I see Rajat's ack, but there was a lot of subsequent
> discussion, and I'm not sure whether there was a conclusion.

Yes, we concluded that the patch was needed.

> 
> Given that, I'd like to see a bugzilla with the relevant background (lspci -vv,
> dmesg log). 

Sandeep, is that something you can provide?

> Also, shpchp_core.c has similar code, so I'd like to see either a
> similar patch for it or an explanation of why that driver doesn't need it.
> 

I can provide that patch. I took a look at the commit history of SHPCHP and PCIEHP
And I see a bunch of commits that switch to using the unordered work queues.

d347e75847 ("PCI: shpchp: Handle push button event asynchronously")
10959d72d4 ("PCI: shpchp: Make shpchp_wq non-ordered")
486b10b9f4 ("PCI: pciehp: Handle push button event asynchronously")
e24dcbef93 ("shpchp: update workqueue usage")
a827ea307b ("pciehp: update workqueue usage")

While I'm still trying to understand if there are scenarios where ordered queues can be a problem,
I'm able to find convincing scenarios where having an unordered queue will fail the driver.

Using ordered queues are definitely a requirement for cases where
hotplug events can happen very fast enough not to give SW the time to
handle them. (For e.g., for pciehp: PCIe link fluctuations may result in
such events).

Problem:
     Consider a very fast ocuurance of HOTPLUG->UNPLUG->HOTPLUG
     (fast enough that it does not give the wq to get a chance to run)

     If the wq can be reordered, it is a problem if the worker function
     is invoked as HOTPLUG->HOTPLUG->UNPLUG.

Why:
     In the above example, the final result should have been a device
     added, but if it is reordered like above, thre shall be no device
     added. The second HOTPLUG event shall be treated as a stray one
     since a device is already present there (""Cannot add device at..")

Thus we need to have ordered work queues. 

The primary reasons to switch to using unordered workqueues as far
as I could understand from the logs were (1) avoid using the system
workqueue, and (2) let the button events be handled asynchronously.

Do you think a ordered workqueue not work for any of the reasons above?

Thanks,

Rajat

(PS: In short, I think the ordered workqueues are definitely needed for pciehp, specially with the inclusion of link-state hotplug. I think it will also help the shpchp - but I'm still trying to understand if there are any uncovered scenarios).


> So I'll drop this for now, pending these updates.
> 
> Bjorn
> 
> > ---
> >  drivers/pci/hotplug/pciehp_hpc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/hotplug/pciehp_hpc.c
> > b/drivers/pci/hotplug/pciehp_hpc.c
> > index 42914e0..c4eedab 100644
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -681,7 +681,7 @@ static int pcie_init_slot(struct controller *ctrl)
> >  	if (!slot)
> >  		return -ENOMEM;
> >
> > -	slot->wq = alloc_workqueue("pciehp-%u", 0, 0, PSN(ctrl));
> > +	slot->wq = alloc_ordered_workqueue("pciehp-%u", 0, PSN(ctrl));
> >  	if (!slot->wq)
> >  		goto abort;
> >
> > --
> > 1.8.3.2
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
