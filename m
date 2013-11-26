Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63297 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752003Ab3KZUTy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 15:19:54 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Cc: Huang Ying <ying.huang@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: A question about the patch: [PATCH] PCI/PM: Keep runtime PM enabled for unbound PCI devices
Date: Tue, 26 Nov 2013 21:32:42 +0100
Message-ID: <2309058.t3ZWy0Bt5x@vostro.rjw.lan>
In-Reply-To: <52943479.9050004@linux.vnet.ibm.com>
References: <Pine.LNX.4.44L0.1311131416110.1424-100000@iolanthe.rowland.org> <1384419260.30364.27.camel@yhuang-dev> <52943479.9050004@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, November 26, 2013 01:41:13 PM Mike Qiu wrote:
> On 11/14/2013 04:54 PM, Huang Ying wrote:
> > On Thu, 2013-11-14 at 16:37 +0800, mike wrote:
> >> On 11/14/2013 04:25 PM, Huang Ying wrote:
> >>> On Thu, 2013-11-14 at 16:12 +0800, mike wrote:
> >>>> On 11/14/2013 03:53 PM, Huang Ying wrote:
> >>>>> On Thu, 2013-11-14 at 15:19 +0800, mike wrote:
> >>>>>> On 11/14/2013 01:59 PM, Huang Ying wrote:
> >>>>>>> On Thu, 2013-11-14 at 11:23 +0800, mike wrote:
> >>>>>>>> On 11/14/2013 03:20 AM, Alan Stern wrote:
> >>>>>>>>> On Wed, 13 Nov 2013, Bjorn Helgaas wrote:
> >>>>>>>>>
> >>>>>>>>>> [+cc Rafael, linux-pm]
> >>>>>>>>>>
> >>>>>>>>>> On Wed, Nov 13, 2013 at 6:09 AM, mike<qiudayu@linux.vnet.ibm.com>  wrote:
> >>>>>>>>>>> Hi Huang Ying,
> >>>>>>>>>>>
> >>>>>>>>>>> I see you are the author of this patch, commit id is:
> >>>>>>>>>>> 967577b062417b4e4b8e27b711220f4124f5153a
> >>>>>>>>>>>
> >>>>>>>>>>> I have a question while I try to understand this patch,
> >>>>>>>>>>> So I would very grateful if you or others can give me some reply.....
> >>>>>>>>>>>
> >>>>>>>>>>> ............
> >>>>>>>>>>> -       rc = ddi->drv->probe(ddi->dev, ddi->id);
> >>>>>>>>>>> +       pm_runtime_get_sync(dev);
> >>>>>>>>>>> +       pci_dev->driver = pci_drv;
> >>>>>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>>>>>>>>> I see here you make the driver to initialize before probe,
> >>>>>>>>>>> But I have no idea of why you do this change.....
> >>>>>>>>>>>
> >>>>>>>>>>> and I look inside the code, it may be pm_runtime relate??
> >>>>>>>>> Yes, it is related to runtime PM.  In the PCI subsystem, runtime PM
> >>>>>>>>> doesn't do anything unless pci_dev->driver is set.  You can see this at
> >>>>>>>>> the start of pci_pm_runtime_suspend().
> >>>>>>>>>
> >>>>>>>>> Since we want the driver's probe routine to be able to carry out
> >>>>>>>>> runtime PM operations, we have to set pci_dev->driver before the probe
> >>>>>>>>> routine runs.
> >>>>>>>> Is there any situations , like in  probe state,  pci_dev->driver
> >>>>>>>> has been set. the  pci_pm_runtime_xxx() has passed
> >>>>>>>> pci_dev->driver NULL check, but at this point, probe fail
> >>>>>>>> occurs, and  pci_dev->driver to be set to NULL.
> >>>>>>>>
> >>>>>>>> What will happen ? Or this situation will never happen?
> >>>>>>>> I'm confuse about this.
> >>>>>>> I think that will never happen.  Before ->probe(), pm_runtime_get_sync()
> >>>>>>> is called, so pci_pm_runtime_xxx() will not be called until
> >>>>>>> pm_runtime_put_noidle() is called in ->probe().  And
> >>>>>>>      should be done as one of the latest actions in
> >>>>>>> ->probe(), after the normal probe actions succeeded.
> >>>>>> OK, just as your description, it seems OK.
> >>>>>> But this is really a issue as I explained in last email.
> >>>>>>
> >>>>>> So I want to know if there are any side-effect of changing the code
> >>>>>> in pci_pm_runtime_xxx()
> >>>>>>
> >>>>>>      if (!pci_dev->driver)
> >>>>>>             return 0;
> >>>>>>      to
> >>>>>>
> >>>>>>      if (!dev->driver)
> >>>>>>             return 0;
> >>>>>>
> >>>>> If you make this change, we can not put devices into low power state
> >>>>> (runtime suspend the device) in ->probe().  That is expected in some
> >>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>> This means dev->driver is NULL ?? but pci_dev->driver is set???
> >>>>
> >>>> Because if use pci_dev->driver can put into low power state, means
> >>>>
> >>>> pci_dev->driver is set, but in the situation, use dev->driver will can't,
> >>>>
> >>>> means dev->driver = null, but I have not find any case that
> >>>>
> >>>> dev->driver = null, but pci_dev->driver != null;
> >>> Sorry I make a mistake here.  The dev->driver != null in
> >>> local_pci_probe().  We use pci_dev->driver instead of dev->driver in
> >>> pci_pm_runtime_xxx() because we want device to be kept in normal power
> >>> state (D0) and SUSPENDED state when unbound.The
> >>> pm_runtime_put/get_sync in pci_device_remove/local_pci_probe will not
> >>> change the power state of the device because of the check in
> >>> pci_pm_runtime_xxx().
> >> Yes, you are right, but what am I confuse is that, why check dev->driver
> >> in pci_pm_runtime_xxx() can't keep the device in normal power
> >> state (D0) and SUSPENDED state when unbound.
> >>
> >> May be logic issue ?
> > Because dev->driver is set before local_pci_probe() and cleared after
> > pci_device_remove().  But we need a flag to be changed in
> > local_pci_probe() and pci_device_remove().
> Hi Ying,
> 
> I'm now face one bug, and the root cause is this logic has some problem.
> 
> The other component calls the ops in driver during probe state, which a 
> lot of critical data struct haven't been setup yet.
> 
> This never happen in old logic, because dev->driver is unset in probe 
> state, it can check dev->driver to see if the device diver can work. But 
> for new logic it is really a big issue.

What is the other component and why is it doing that?

Checking dev->driver may not be a correct way to address this issue anyway.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
