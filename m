Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <CAJZ5v0hM8WAr9GGku89zKgiVKt6ArHf=9CntRUyBjyMNUvie2A@mail.gmail.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
	<1462893601-8937-8-git-send-email-tn@semihalf.com>
	<CAJZ5v0hM8WAr9GGku89zKgiVKt6ArHf=9CntRUyBjyMNUvie2A@mail.gmail.com>
Date: Tue, 10 May 2016 20:43:42 +0200
Message-ID: <CAJZ5v0jq0NWEYw2Dj6j0pHYrWu-8syYiGP4Nqkm729Uu6hrO7A@mail.gmail.com>
Subject: Re: [PATCH V7 07/11] pci, acpi: Handle ACPI companion assignment.
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>, Liviu.Dudau@arm.com,
	David Daney <ddaney@caviumnetworks.com>, wangyijing@huawei.com,
	Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>, Mark Salter <msalter@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Jon Masters <jcm@redhat.com>,
	Andrea Gallo <andrea.gallo@linaro.org>, Duc Dang <dhdang@apm.com>, jeremy.linton@arm.com,
	liudongdong3@huawei.com, Christopher Covington <cov@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 10, 2016 at 8:37 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, May 10, 2016 at 5:19 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
>> This patch provides a way to set the ACPI companion in PCI code.
>> We define acpi_pci_set_companion() to set the ACPI companion pointer and
>> call it from PCI core code. The function is stub for now.
>>
>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>  drivers/pci/probe.c      | 2 ++
>>  include/linux/pci-acpi.h | 4 ++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 8004f67..fb0b752 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/module.h>
>>  #include <linux/cpumask.h>
>> +#include <linux/pci-acpi.h>
>>  #include <linux/pci-aspm.h>
>>  #include <linux/aer.h>
>>  #include <linux/acpi.h>
>> @@ -2141,6 +2142,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>>         bridge->dev.parent = parent;
>>         bridge->dev.release = pci_release_host_bridge_dev;
>>         dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
>> +       acpi_pci_set_companion(bridge);
>
> Yes, we'll probably add something similar here.
>
> Do I think now is the right time to do that?  No.
>
>>         error = pcibios_root_bridge_prepare(bridge);
>>         if (error) {
>>                 kfree(bridge);
>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>> index 09f9f02..1baa515 100644
>> --- a/include/linux/pci-acpi.h
>> +++ b/include/linux/pci-acpi.h
>> @@ -111,6 +111,10 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
>>  #endif /* CONFIG_ACPI */
>>
>> +static inline void acpi_pci_set_companion(struct pci_host_bridge *bridge)
>> +{
>> +}
>> +
>>  static inline int acpi_pci_bus_domain_nr(struct pci_bus *bus)
>>  {
>>         return 0;
>> --
>
> Honestly, to me it looks like this series is trying very hard to avoid
> doing any PCI host bridge configuration stuff from arch/arm64/
> although (a) that might be simpler and (b) it would allow us to
> identify the code that's common between *all* architectures using ACPI
> support for host bridge configuration and to move *that* to a common
> place later.  As done here it seems to be following the "ARM64 is
> generic and the rest of the world is special" line which isn't really
> helpful.

Speaking of which, at least one of the reasons why the ACPI PCI host
bridge thing on x86 and ia64 went to the arch code was to avoid
explicit references to ACPI-specific data types and related #ifdeffery
in the generic PCI code and data structures.  If you are going to add
those references now anyway, that reason is not relevant any more and
all of that can just be reworked to refer to ACPI explicitly.
