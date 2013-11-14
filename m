Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29169 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755Ab3KNIZk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Nov 2013 03:25:40 -0500
Message-ID: <1384417538.30364.25.camel@yhuang-dev>
Subject: Re: A question about the patch: [PATCH] PCI/PM: Keep runtime PM
 enabled for unbound PCI devices
From: Huang Ying <ying.huang@intel.com>
To: mike <qiudayu@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, rjw@rjwysocki.net
Date: Thu, 14 Nov 2013 16:25:38 +0800
In-Reply-To: <528485EA.5080309@linux.vnet.ibm.com>
References: <Pine.LNX.4.44L0.1311131416110.1424-100000@iolanthe.rowland.org>
	 <5284423D.4090907@linux.vnet.ibm.com> <1384408745.30364.8.camel@yhuang-dev>
	 <5284799C.1010000@linux.vnet.ibm.com>
	 <1384415609.30364.18.camel@yhuang-dev>
	 <528485EA.5080309@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-11-14 at 16:12 +0800, mike wrote:
> On 11/14/2013 03:53 PM, Huang Ying wrote:
> > On Thu, 2013-11-14 at 15:19 +0800, mike wrote:
> >> On 11/14/2013 01:59 PM, Huang Ying wrote:
> >>> On Thu, 2013-11-14 at 11:23 +0800, mike wrote:
> >>>> On 11/14/2013 03:20 AM, Alan Stern wrote:
> >>>>> On Wed, 13 Nov 2013, Bjorn Helgaas wrote:
> >>>>>
> >>>>>> [+cc Rafael, linux-pm]
> >>>>>>
> >>>>>> On Wed, Nov 13, 2013 at 6:09 AM, mike<qiudayu@linux.vnet.ibm.com>  wrote:
> >>>>>>> Hi Huang Ying,
> >>>>>>>
> >>>>>>> I see you are the author of this patch, commit id is:
> >>>>>>> 967577b062417b4e4b8e27b711220f4124f5153a
> >>>>>>>
> >>>>>>> I have a question while I try to understand this patch,
> >>>>>>> So I would very grateful if you or others can give me some reply.....
> >>>>>>>
> >>>>>>> ............
> >>>>>>> -       rc = ddi->drv->probe(ddi->dev, ddi->id);
> >>>>>>> +       pm_runtime_get_sync(dev);
> >>>>>>> +       pci_dev->driver = pci_drv;
> >>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>>>>> I see here you make the driver to initialize before probe,
> >>>>>>> But I have no idea of why you do this change.....
> >>>>>>>
> >>>>>>> and I look inside the code, it may be pm_runtime relate??
> >>>>> Yes, it is related to runtime PM.  In the PCI subsystem, runtime PM
> >>>>> doesn't do anything unless pci_dev->driver is set.  You can see this at
> >>>>> the start of pci_pm_runtime_suspend().
> >>>>>
> >>>>> Since we want the driver's probe routine to be able to carry out
> >>>>> runtime PM operations, we have to set pci_dev->driver before the probe
> >>>>> routine runs.
> >>>> Is there any situations , like in  probe state,  pci_dev->driver
> >>>> has been set. the  pci_pm_runtime_xxx() has passed
> >>>> pci_dev->driver NULL check, but at this point, probe fail
> >>>> occurs, and  pci_dev->driver to be set to NULL.
> >>>>
> >>>> What will happen ? Or this situation will never happen?
> >>>> I'm confuse about this.
> >>> I think that will never happen.  Before ->probe(), pm_runtime_get_sync()
> >>> is called, so pci_pm_runtime_xxx() will not be called until
> >>> pm_runtime_put_noidle() is called in ->probe().  And
> >>>    should be done as one of the latest actions in
> >>> ->probe(), after the normal probe actions succeeded.
> >> OK, just as your description, it seems OK.
> >> But this is really a issue as I explained in last email.
> >>
> >> So I want to know if there are any side-effect of changing the code
> >> in pci_pm_runtime_xxx()
> >>
> >>    if (!pci_dev->driver)
> >>           return 0;
> >>    to
> >>
> >>    if (!dev->driver)
> >>           return 0;
> >>
> > If you make this change, we can not put devices into low power state
> > (runtime suspend the device) in ->probe().  That is expected in some
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This means dev->driver is NULL ?? but pci_dev->driver is set???
> 
> Because if use pci_dev->driver can put into low power state, means
> 
> pci_dev->driver is set, but in the situation, use dev->driver will can't,
> 
> means dev->driver = null, but I have not find any case that
> 
> dev->driver = null, but pci_dev->driver != null;

Sorry I make a mistake here.  The dev->driver != null in
local_pci_probe().  We use pci_dev->driver instead of dev->driver in
pci_pm_runtime_xxx() because we want device to be kept in normal power
state (D0) and SUSPENDED state when unbound.  The
pm_runtime_put/get_sync in pci_device_remove/local_pci_probe will not
change the power state of the device because of the check in
pci_pm_runtime_xxx().

> I know I always been a question guy, i apologize for spend a lot
> time to reply this mail, but I really want to understand it,

Never mind.

Best Regards,
Huang Ying


