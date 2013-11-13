Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:45501 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756598Ab3KMTUl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2013 14:20:41 -0500
Date: Wed, 13 Nov 2013 14:20:40 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: mike <qiudayu@linux.vnet.ibm.com>,
	Huang Ying <ying.huang@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: A question about the patch: [PATCH] PCI/PM: Keep runtime PM
 enabled for unbound PCI devices
In-Reply-To: <CAErSpo4T3poaKkamm1rqZDmSvom0R5PC7Yb1BU-jT0t+6iW95A@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1311131416110.1424-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 13 Nov 2013, Bjorn Helgaas wrote:

> [+cc Rafael, linux-pm]
> 
> On Wed, Nov 13, 2013 at 6:09 AM, mike <qiudayu@linux.vnet.ibm.com> wrote:
> > Hi Huang Ying,
> >
> > I see you are the author of this patch, commit id is:
> > 967577b062417b4e4b8e27b711220f4124f5153a
> >
> > I have a question while I try to understand this patch,
> > So I would very grateful if you or others can give me some reply.....
> >
> > ............
> > -       rc = ddi->drv->probe(ddi->dev, ddi->id);
> > +       pm_runtime_get_sync(dev);
> > +       pci_dev->driver = pci_drv;
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > I see here you make the driver to initialize before probe,
> > But I have no idea of why you do this change.....
> >
> > and I look inside the code, it may be pm_runtime relate??

Yes, it is related to runtime PM.  In the PCI subsystem, runtime PM 
doesn't do anything unless pci_dev->driver is set.  You can see this at 
the start of pci_pm_runtime_suspend().

Since we want the driver's probe routine to be able to carry out
runtime PM operations, we have to set pci_dev->driver before the probe
routine runs.

Alan Stern

