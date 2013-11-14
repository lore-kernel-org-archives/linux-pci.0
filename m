Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13636 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623Ab3KNF7I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Nov 2013 00:59:08 -0500
Message-ID: <1384408745.30364.8.camel@yhuang-dev>
Subject: Re: A question about the patch: [PATCH] PCI/PM: Keep runtime PM
 enabled for unbound PCI devices
From: Huang Ying <ying.huang@intel.com>
To: mike <qiudayu@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, rjw@rjwysocki.net
Date: Thu, 14 Nov 2013 13:59:05 +0800
In-Reply-To: <5284423D.4090907@linux.vnet.ibm.com>
References: <Pine.LNX.4.44L0.1311131416110.1424-100000@iolanthe.rowland.org>
	 <5284423D.4090907@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-11-14 at 11:23 +0800, mike wrote:
> On 11/14/2013 03:20 AM, Alan Stern wrote:
> > On Wed, 13 Nov 2013, Bjorn Helgaas wrote:
> >
> >> [+cc Rafael, linux-pm]
> >>
> >> On Wed, Nov 13, 2013 at 6:09 AM, mike<qiudayu@linux.vnet.ibm.com>  wrote:
> >>> Hi Huang Ying,
> >>>
> >>> I see you are the author of this patch, commit id is:
> >>> 967577b062417b4e4b8e27b711220f4124f5153a
> >>>
> >>> I have a question while I try to understand this patch,
> >>> So I would very grateful if you or others can give me some reply.....
> >>>
> >>> ............
> >>> -       rc = ddi->drv->probe(ddi->dev, ddi->id);
> >>> +       pm_runtime_get_sync(dev);
> >>> +       pci_dev->driver = pci_drv;
> >>> ^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>> I see here you make the driver to initialize before probe,
> >>> But I have no idea of why you do this change.....
> >>>
> >>> and I look inside the code, it may be pm_runtime relate??
> > Yes, it is related to runtime PM.  In the PCI subsystem, runtime PM
> > doesn't do anything unless pci_dev->driver is set.  You can see this at
> > the start of pci_pm_runtime_suspend().
> >
> > Since we want the driver's probe routine to be able to carry out
> > runtime PM operations, we have to set pci_dev->driver before the probe
> > routine runs.
> Is there any situations , like in  probe state,  pci_dev->driver
> has been set. the  pci_pm_runtime_xxx() has passed
> pci_dev->driver NULL check, but at this point, probe fail
> occurs, and  pci_dev->driver to be set to NULL.
> 
> What will happen ? Or this situation will never happen?
> I'm confuse about this.

I think that will never happen.  Before ->probe(), pm_runtime_get_sync()
is called, so pci_pm_runtime_xxx() will not be called until
pm_runtime_put_noidle() is called in ->probe().  And
pm_runtime_put_noidle() should be done as one of the latest actions in
->probe(), after the normal probe actions succeeded.

Best Regards,
Huang Ying


