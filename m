Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45239 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab2IUHOm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2012 03:14:42 -0400
Date: Fri, 21 Sep 2012 16:14:47 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org,
	jiang.liu@huawei.com
Subject: Re: [PATCH v3 5/8] ACPI, PCI: change acpi_pci_find_root
 implementation
Message-Id: <20120921161447.46771be7.izumi.taku@jp.fujitsu.com>
In-Reply-To: <CAErSpo6VeKfwzVmv=WjH7wNPMf6_PLHpo99FeKoHXOrYPnYVPQ@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<20120918152323.48cb2703.izumi.taku@jp.fujitsu.com>
	<CAErSpo6VeKfwzVmv=WjH7wNPMf6_PLHpo99FeKoHXOrYPnYVPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 19 Sep 2012 16:03:27 -0600
Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Tue, Sep 18, 2012 at 12:23 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> >
> > This patch changes the implementation of acpi_pci_find_root().
> >
> > We can access acpi_pci_root without scanning acpi_pci_roots list.
> > If hostbridge hotplug is supported, acpi_pci_roots list will be
> > protected by mutex. We should not access acpi_pci_roots list
> > if preventable to lessen deadlock risk.
> >
> > Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> > ---
> >  drivers/acpi/pci_root.c |   13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > Index: Bjorn-next-0903/drivers/acpi/pci_root.c
> > ===================================================================
> > --- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
> > +++ Bjorn-next-0903/drivers/acpi/pci_root.c
> > @@ -265,12 +265,15 @@ static acpi_status acpi_pci_osc_support(
> >  struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
> >  {
> >         struct acpi_pci_root *root;
> > +       struct acpi_device *device;
> >
> > -       list_for_each_entry(root, &acpi_pci_roots, node) {
> > -               if (root->device->handle == handle)
> > -                       return root;
> > -       }
> > -       return NULL;
> > +       if (acpi_bus_get_device(handle, &device) ||
> > +           acpi_match_device_ids(device, root_device_ids))
> 
> What's the purpose of the acpi_match_device_ids() check?  It's not
> obvious, so worth calling it out in the changelog, and maybe even a
> comment in the code.

  My intention is to reject acpi_handle which doesn't represent 
  hostbrige. I think this is reasonable...

  Best regards,
  Taku Izumi

> 
> Nice to get rid of the list traversal.
> 
> > +               return NULL;
> > +
> > +       root = acpi_driver_data(device);
> > +
> > +       return root;
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_pci_find_root);
> >
> >
> 


-- 
Taku Izumi <izumi.taku@jp.fujitsu.com>

