Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:56071 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965587Ab3DTC6h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2013 22:58:37 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <qiudayu@linux.vnet.ibm.com>;
	Sat, 20 Apr 2013 08:22:41 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 92F13394004F
	for <linux-pci@vger.kernel.org>; Sat, 20 Apr 2013 08:28:31 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r3K2wR565177634
	for <linux-pci@vger.kernel.org>; Sat, 20 Apr 2013 08:28:27 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r3K2wUW8014516
	for <linux-pci@vger.kernel.org>; Sat, 20 Apr 2013 12:58:31 +1000
Message-ID: <1366426691.12260.10.camel@localhost.localdomain>
Subject: Re: [PATCH 1/2] PCI: Introduce pci_alloc_dev(struct pci_bus*) to
 replace alloc_pci_dev()
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	tangchen <tangchen@cn.fujitsu.com>,
	Lin Feng <linfeng@cn.fujitsu.com>,
	li guang <lig.fnst@cn.fujitsu.com>
Date: Fri, 19 Apr 2013 22:58:11 -0400
In-Reply-To: <CAErSpo7yPUTOPYsPkhKTpe2yxbo_XN4Y4iBesVLudAmbuRsJ+A@mail.gmail.com>
References: <516FB647.5030203@cn.fujitsu.com>
	 <CAErSpo65ARR_fZwsGCZDJqbPWktHYUkufgPt-2mWwur=nPR1Qg@mail.gmail.com>
	 <51711214.8050606@cn.fujitsu.com>
	 <CAErSpo7yPUTOPYsPkhKTpe2yxbo_XN4Y4iBesVLudAmbuRsJ+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-04-19 at 11:32 -0600, Bjorn Helgaas wrote:
> On Fri, Apr 19, 2013 at 3:44 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
> > From 906167d9a09babbe189f62944ecb8c0b198a0f64 Mon Sep 17 00:00:00 2001
> > From: Gu Zheng <guz.fnst@cn.fujitsu.com>
> > Date: Fri, 19 Apr 2013 18:12:32 +0900
> > Subject: [PATCH 1/2] PCI: Introduce  pci_alloc_dev(struct pci_bus*) to replace alloc_pci_dev()
> >
> > Now here we introduce a new struct pci_dev *pci_alloc_dev(struct pci_bus *bus) to replace alloc_pci_dev().
> > It take a "struct pci_bus *" argument, so we can alloc a pci device on a target pci bus, and it acquire
> > the reference of the pci_bus.
> > Since the old alloc_pci_dev() is exported, so we still keep it for a while but mark it as __deprecated.
> >
> > Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> > ---
> >  drivers/pci/probe.c |   21 ++++++++++++++++++++-
> >  include/linux/pci.h |    4 +++-
> >  2 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index b494066..5233fb6 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1199,7 +1199,7 @@ static void pci_release_bus_bridge_dev(struct device *dev)
> >         kfree(bridge);
> >  }
> >
> > -struct pci_dev *alloc_pci_dev(void)
> > +struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
> >  {
> >         struct pci_dev *dev;
> >
> > @@ -1209,6 +1209,25 @@ struct pci_dev *alloc_pci_dev(void)
> >
> >         INIT_LIST_HEAD(&dev->bus_list);
> >
> > +       if (bus) {
> > +               get_device(&bus->dev);
> > +               dev->bus = bus;
> > +       }
> > +
> > +       return dev;
> > +}
> > +EXPORT_SYMBOL(pci_alloc_dev);
> > +
> > +__deprecated struct pci_dev *alloc_pci_dev(void)
> 
> I don't think there's any point in marking the function *definition*
> as deprecated; it only makes sense for the declaration in the header
> file, so callers of the function will generate warnings.
> 
> > +{
> > +       struct pci_dev *dev;
> > +       printk(KERN_DEBUG "alloc_pci_dev is deprecated, please use pci_alloc_dev(struct pci_bus *) instead!\n");
> 
> I don't want to print a message at run-time, because users will see
> the message and complain about it, but they can't do anything about
> it.  And neither can we, because it will only be out-of-tree modules
> that call alloc_pci_dev().  The build-time warning is all we can do.
Yes, totally agree .
> 
> > +       dev = kzalloc(sizeof(struct pci_dev), GFP_KERNEL);
> > +       if (!dev)
> > +               return NULL;
> > +
> > +       INIT_LIST_HEAD(&dev->bus_list);
> 
> Can't you implement this as simply:
> 
>     return pci_alloc_dev(NULL);
Yes, I think it's better to keep the old API, and modify it to call the
new one, this makes the modules which call the old fashion API feel
smoothly. and the new modules can use the new API.
> 
> > +
> >         return dev;
> >  }
> >  EXPORT_SYMBOL(alloc_pci_dev);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 710067f..682de2b 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -348,7 +348,9 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> >         return dev;
> >  }
> >
> > -extern struct pci_dev *alloc_pci_dev(void);
> > +extern struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
> > +
> > +extern __deprecated struct pci_dev *alloc_pci_dev(void);
> >
> >  #define        to_pci_dev(n) container_of(n, struct pci_dev, dev)
> >  #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
> > --
> > 1.7.1
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


