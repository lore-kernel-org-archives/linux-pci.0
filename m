Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V8 7/9] acpi: Add generic MCFG table handling
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-8-git-send-email-tn@semihalf.com>
 <20160603113810.GA24764@red-moon>
Cc: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
 catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
 okaya@codeaurora.org, jchandra@broadcom.com,
 robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 ddaney@caviumnetworks.com, wangyijing@huawei.com,
 Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org,
 dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com,
 cov@codeaurora.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <575572CD.60107@semihalf.com>
Date: Mon, 6 Jun 2016 14:55:41 +0200
MIME-Version: 1.0
In-Reply-To: <20160603113810.GA24764@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 03.06.2016 13:38, Lorenzo Pieralisi wrote:
> On Mon, May 30, 2016 at 05:14:20PM +0200, Tomasz Nowicki wrote:
>> In order to handle PCI config space regions properly in ACPI, new MCFG
>> interface is defined which does sanity checks on MCFG table and keeps its
>> root pointer. The user is able to lookup MCFG regions based on
>> host bridge root structure and domain:bus_start:bus_end touple.
>> Use pci_mmcfg_late_init old prototype to avoid another function name.
>
> "According to PCI firmware specifications, on systems booting with ACPI,
> PCI configuration for a host bridge must be set-up through the MCFG table
> regions for non-hotpluggable bridges and _CBA method for hotpluggable ones.
>
> Current MCFG table handling code, as implemented for x86, cannot be
> easily generalized owing to x86 specific quirks handling and related
> code, which makes it hard to reuse on other architectures.
>
> In order to implement MCFG PCI configuration handling for new platforms
> booting with ACPI (eg ARM64) this patch re-implements MCFG handling from
> scratch in a streamlined fashion and provides (through a generic
> interface available to all arches):
>
> - Simplified MCFG table parsing (executed through the pci_mmcfg_late_init()
>    hook as in current x86)
> - MCFG regions look-up interface through domain:bus_start:bus_end tuple
>
> The new MCFG regions handling interface is added to generic ACPI code
> so that existing architectures (eg x86) can be moved over to it and
> architectures relying on MCFG for ACPI PCI config space can rely on it
> without having to resort to arch specific implementations."
>

[...]

>> +
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci-acpi.h>
>> +
>> +/* Root pointer to the mapped MCFG table */
>> +static struct acpi_table_mcfg *mcfg_table;
>> +static int mcfg_entries;
>> +
>> +int pci_mcfg_lookup(struct acpi_pci_root *root)
>> +{
>> +	struct acpi_mcfg_allocation *mptr, *entry = NULL;
>> +	struct resource *bus_res = &root->secondary;
>> +	int i;
>> +
>> +	if (mcfg_table) {
>> +		mptr = (struct acpi_mcfg_allocation *) &mcfg_table[1];
>> +		for (i = 0; i < mcfg_entries && !entry; i++, mptr++)
>> +			if (mptr->pci_segment == root->segment &&
>> +			    mptr->start_bus_number == bus_res->start)
>> +				entry = mptr;
>> +	}
>> +
>> +	/* not found, use _CBA if available, else error */
>> +	if (!entry) {
>> +		if (root->mcfg_addr)
>> +			return root->mcfg_addr;
>> +		pr_err("%04x:%pR MCFG lookup failed\n", root->segment, bus_res);
>> +		return -ENOENT;
>> +	} else if (root->mcfg_addr && entry->address != root->mcfg_addr) {
>> +		pr_warn("%04x:%pR CBA %pa != MCFG %lx, using CBA\n",
>> +			root->segment, bus_res, &root->mcfg_addr,
>> +			(unsigned long)entry->address);
>> +		return 0;
>> +	}
>> +
>> +	/* found matching entry, bus range check */
>> +	if (entry->end_bus_number != bus_res->end) {
>> +		resource_size_t bus_end = min_t(resource_size_t,
>> +					entry->end_bus_number, bus_res->end);
>> +		pr_warn("%04x:%pR bus end mismatch, using %02lx\n",
>> +			root->segment, bus_res, (unsigned long)bus_end);
>> +		bus_res->end = bus_end;
>> +	}
>> +
>> +	if (!root->mcfg_addr)
>> +		root->mcfg_addr = entry->address;
>
> Let's hope that no one will ever implement a hotplug bridge with config
> space starting at physical address 0x0.
>
> Nit: You should define what the return value means. For success, once you
> return the _CBA address, once 0; this should be consistent.

As we decided to return CFG start address in root->mcfg_addr we should 
return 0 for the case (!entry) && (root->mcfg_addr). I'll fix it.

>
> Anyway, this function is not easy to read but it may well be fine, I will let
> Bjorn decide what to do with corner cases:
>
> a) _CBA is != 0 and you get a MCFG entry that matches its address (I am
>      not sure that capping the _CRS bus numbers is PCI compliant in that case)
> b) bus_end capping, either you leave code as-is (that caps also _CRS) or
>     just warn and fail if the bus->end numbers mismatch
>
> Pending Bjorn's opinion on the above (and commit log update):
>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>

Thanks,
Tomasz
