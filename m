Return-Path: <SRS0=Jw/T=XQ=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=Jw/T=XQ=redhat.com=jcm@kernel.org>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
To: Mark Salter <msalter@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Duc Dang <dhdang@apm.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <1480620053.4751.30.camel@redhat.com>
Cc: Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann
 <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <0e7e7181-94f5-0d09-b571-61fb71537f02@redhat.com>
Date: Thu, 1 Dec 2016 14:26:29 -0500
MIME-Version: 1.0
In-Reply-To: <1480620053.4751.30.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 12/01/2016 02:20 PM, Mark Salter wrote:
> On Thu, 2016-12-01 at 12:33 -0600, Bjorn Helgaas wrote:

>>> +	csr = &xgene_v1_csr_res[root->segment];
>> This makes me nervous because root->segment comes from the ACPI _SEG,
>> and if firmware gives us junk in _SEG, we will reference something in
>> the weeds.
> 
> The SoC provide some number of RC bridges, each with a different base
> for some mmio registers. Even if segment is legitimate in MCFG, there
> is still a problem if a platform doesn't use the segment ordering
> implied by the code. But the PNP0A03 _CRS does have this base address
> as the first memory resource, so we could get it from there and not
> have hard-coded addresses and implied ording in the quirk code.
> 
> I have tested a modified version of these quirks using this to
> get the CSR base and it works on the 3 different platforms I have
> access to.
> 
> static int xgene_pcie_get_csr(struct device *dev, struct resource *r)
> {
> 	struct acpi_device *adev = to_acpi_device(dev);
> 	unsigned long flags;
> 	struct list_head list;
> 	struct resource_entry *entry;
> 	int ret;
> 
> 	INIT_LIST_HEAD(&list);
> 	flags = IORESOURCE_MEM;
> 	ret = acpi_dev_get_resources(adev, &list,
> 				     acpi_dev_filter_resource_type_cb,
> 				     (void *)flags);
> 	if (ret < 0) {
> 		dev_err(dev, "failed to parse _CRS, error: %d\n", ret);
> 		return ret;
> 	} else if (ret == 0) {
> 		dev_err(dev, "no memory resources present in _CRS\n");
> 		return -EINVAL;
> 	}
> 
> 	entry = list_first_entry(&list, struct resource_entry, node);
> 	*r = *entry->res;
> 	acpi_dev_free_resource_list(&list);
> 	return 0;
> }

This seems a lot safer. At some point trusting firmware to provide the
correct _CRS for the RC in use is better than hard coding for every
possible implementation configuration of an X-Gene SoC.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
