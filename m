Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55352 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeERQCA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 May 2018 12:02:00 -0400
Date: Fri, 18 May 2018 17:01:54 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Create configfs entry for each
 pci_epf_device_id table entry
Message-ID: <20180518160154.GA20543@e107981-ln.cambridge.arm.com>
References: <20180402132935.32008-1-kishon@ti.com>
 <20180518142253.GB18605@e107981-ln.cambridge.arm.com>
 <5a4856cb-5680-586f-1826-fa2349a69328@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5a4856cb-5680-586f-1826-fa2349a69328@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2018 at 08:19:20PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On Friday 18 May 2018 07:52 PM, Lorenzo Pieralisi wrote:
> > Hi Kishon, Gustavo,
> > 
> > On Mon, Apr 02, 2018 at 06:59:35PM +0530, Kishon Vijay Abraham I wrote:
> >> In order to be able to provide correct driver_data for pci_epf device,
> >> a separate configfs entry for each pci_epf_device_id table entry in
> >> pci_epf_driver is required.
> >>
> >> Add support to create configfs entry for each pci_epf_device_id
> >> table entry here.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/pci/endpoint/pci-epf-core.c | 23 +++++++++++++++++++++--
> >>  include/linux/pci-epf.h             |  4 ++--
> >>  2 files changed, 23 insertions(+), 4 deletions(-)
> > 
> > Do we still need this patch after the recent discussion on the configfs
> > interface ?
> 
> Yeah, Since we allow multiple pci_epf_device_id entries to be created, I think
> this patch is still valid.
> 
> If someone wants to create a new pci_epf_device_id entry (maybe for configuring
> the driver in a different way), this would be still required.

Applied to pci/endpoint for v4.18, thanks.

Lorenzo

> Thanks
> Kishon
> > 
> > https://patchwork.ozlabs.org/patch/903494/
> > 
> > Lorenzo
> > 
> >> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> >> index 59ed29e550e9..d6787f39fd41 100644
> >> --- a/drivers/pci/endpoint/pci-epf-core.c
> >> +++ b/drivers/pci/endpoint/pci-epf-core.c
> >> @@ -15,6 +15,8 @@
> >>  #include <linux/pci-epf.h>
> >>  #include <linux/pci-ep-cfs.h>
> >>  
> >> +static DEFINE_MUTEX(pci_epf_mutex);
> >> +
> >>  static struct bus_type pci_epf_bus_type;
> >>  static const struct device_type pci_epf_type;
> >>  
> >> @@ -139,7 +141,13 @@ EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
> >>   */
> >>  void pci_epf_unregister_driver(struct pci_epf_driver *driver)
> >>  {
> >> -	pci_ep_cfs_remove_epf_group(driver->group);
> >> +	struct config_group *group;
> >> +
> >> +	mutex_lock(&pci_epf_mutex);
> >> +	list_for_each_entry(group, &driver->epf_group, group_entry)
> >> +		pci_ep_cfs_remove_epf_group(group);
> >> +	list_del(&driver->epf_group);
> >> +	mutex_unlock(&pci_epf_mutex);
> >>  	driver_unregister(&driver->driver);
> >>  }
> >>  EXPORT_SYMBOL_GPL(pci_epf_unregister_driver);
> >> @@ -155,6 +163,8 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
> >>  			      struct module *owner)
> >>  {
> >>  	int ret;
> >> +	struct config_group *group;
> >> +	const struct pci_epf_device_id *id;
> >>  
> >>  	if (!driver->ops)
> >>  		return -EINVAL;
> >> @@ -169,7 +179,16 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> -	driver->group = pci_ep_cfs_add_epf_group(driver->driver.name);
> >> +	INIT_LIST_HEAD(&driver->epf_group);
> >> +
> >> +	id = driver->id_table;
> >> +	while (id->name[0]) {
> >> +		group = pci_ep_cfs_add_epf_group(id->name);
> >> +		mutex_lock(&pci_epf_mutex);
> >> +		list_add_tail(&group->group_entry, &driver->epf_group);
> >> +		mutex_unlock(&pci_epf_mutex);
> >> +		id++;
> >> +	}
> >>  
> >>  	return 0;
> >>  }
> >> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> >> index e897bf076701..a30dcaafa6e8 100644
> >> --- a/include/linux/pci-epf.h
> >> +++ b/include/linux/pci-epf.h
> >> @@ -72,7 +72,7 @@ struct pci_epf_ops {
> >>   * @driver: PCI EPF driver
> >>   * @ops: set of function pointers for performing EPF operations
> >>   * @owner: the owner of the module that registers the PCI EPF driver
> >> - * @group: configfs group corresponding to the PCI EPF driver
> >> + * @epf_group: list of configfs group corresponding to the PCI EPF driver
> >>   * @id_table: identifies EPF devices for probing
> >>   */
> >>  struct pci_epf_driver {
> >> @@ -82,7 +82,7 @@ struct pci_epf_driver {
> >>  	struct device_driver	driver;
> >>  	struct pci_epf_ops	*ops;
> >>  	struct module		*owner;
> >> -	struct config_group	*group;
> >> +	struct list_head	epf_group;
> >>  	const struct pci_epf_device_id	*id_table;
> >>  };
> >>  
> >> -- 
> >> 2.16.2
> >>
