Return-Path: <SRS0=bnU8=3O=ti.com=kishon@kernel.org>
Return-Path: <SRS0=bnU8=3O=ti.com=kishon@kernel.org>
Subject: Re: [PATCH v6 01/23] PCI: endpoint: Add EP core layer to enable EP
 controller and EP functions
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20170405085243.18123-1-kishon@ti.com>
 <20170405085243.18123-2-kishon@ti.com>
 <20170405165254.GA17066@bhelgaas-glaptop.roam.corp.google.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <hch@infradead.org>, <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f02ddadd-239a-b559-ab85-0bed3f3e0112@ti.com>
Date: Thu, 6 Apr 2017 10:49:17 +0530
MIME-Version: 1.0
In-Reply-To: <20170405165254.GA17066@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wednesday 05 April 2017 10:22 PM, Bjorn Helgaas wrote:
> On Wed, Apr 05, 2017 at 02:22:21PM +0530, Kishon Vijay Abraham I wrote:
>> Introduce a new EP core layer in order to support endpoint functions in
>> linux kernel. This comprises the EPC library (Endpoint Controller Library)
>> and EPF library (Endpoint Function Library). EPC library implements
>> functions specific to an endpoint controller and EPF library implements
>> functions specific to an endpoint function.
>> ...
> 
>> +/**
>> + * pci_epf_linkup() - Notify the function driver that EPC device has
>> + *		      established a connection with the Root Complex.
>> + * @epf: the EPF device bound to the EPC device which has established
>> + *	 the connection with the host
>> + *
>> + * Invoke to notify the function driver that EPC device has established
>> + * a connection with the Root Complex.
>> + */
>> +void pci_epf_linkup(struct pci_epf *epf)
>> +{
>> +	if (!epf->driver)
>> +		dev_WARN(&epf->dev, "epf device not bound to driver\n");
>> +
>> +	epf->driver->ops->linkup(epf);
> 
> I don't understand what's going on here.  We warn if epf->driver is
> NULL, but the next thing we do is dereference it.
> 
> For NULL pointers that are symptoms of Linux defects, I usually prefer
> not to check at all so that a dereference generates an oops and we can
> debug the problem.  For NULL pointers caused by user error, we would
> generally return an error that percolates up to the user.
> 
> I haven't competely wrapped my head around this endpoint support, but
> I assume a NULL pointer here would be caused by user error, not
> necessarily a Linux defect.  So why would we dereference a NULL
> pointer?  And what happens when we do?  Is this just going to oops an
> embedded Linux running inside the endpoint?  Is that the correct
> behavior?

With the new configfs directory structure, this should be a kernel error.
However the EPF layer should be independent of how it's API's are used i.e
someone can create a new sysfs/configfs structure and the value of epf->driver
might be dependent on user actions.

I think I'd prefer not to dereference NULL pointers since we anyways have a
dev_WARN for debug. I'll resend this patch with return if epf->driver is NULL.

Thanks
Kishon
