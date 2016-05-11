Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20160511101101.GA16101@red-moon>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
	<1462893601-8937-8-git-send-email-tn@semihalf.com>
	<CAJZ5v0hM8WAr9GGku89zKgiVKt6ArHf=9CntRUyBjyMNUvie2A@mail.gmail.com>
	<20160511101101.GA16101@red-moon>
Date: Wed, 11 May 2016 22:30:51 +0200
Message-ID: <CAJZ5v0hgw929W5PjF0PqT+ssiOHd8TeJoSQcz4NUiAovZY2pfQ@mail.gmail.com>
Subject: Re: [PATCH V7 07/11] pci, acpi: Handle ACPI companion assignment.
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tomasz Nowicki <tn@semihalf.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
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

On Wed, May 11, 2016 at 12:11 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, May 10, 2016 at 08:37:00PM +0200, Rafael J. Wysocki wrote:
>> On Tue, May 10, 2016 at 5:19 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
>> > This patch provides a way to set the ACPI companion in PCI code.
>> > We define acpi_pci_set_companion() to set the ACPI companion pointer and
>> > call it from PCI core code. The function is stub for now.
>> >
>> > Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>> > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> > ---
>> >  drivers/pci/probe.c      | 2 ++
>> >  include/linux/pci-acpi.h | 4 ++++
>> >  2 files changed, 6 insertions(+)
>> >
>> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> > index 8004f67..fb0b752 100644
>> > --- a/drivers/pci/probe.c
>> > +++ b/drivers/pci/probe.c
>> > @@ -12,6 +12,7 @@
>> >  #include <linux/slab.h>
>> >  #include <linux/module.h>
>> >  #include <linux/cpumask.h>
>> > +#include <linux/pci-acpi.h>
>> >  #include <linux/pci-aspm.h>
>> >  #include <linux/aer.h>
>> >  #include <linux/acpi.h>
>> > @@ -2141,6 +2142,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>> >         bridge->dev.parent = parent;
>> >         bridge->dev.release = pci_release_host_bridge_dev;
>> >         dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
>> > +       acpi_pci_set_companion(bridge);
>>
>> Yes, we'll probably add something similar here.
>>
>> Do I think now is the right time to do that?  No.
>>
>> >         error = pcibios_root_bridge_prepare(bridge);
>> >         if (error) {
>> >                 kfree(bridge);
>> > diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>> > index 09f9f02..1baa515 100644
>> > --- a/include/linux/pci-acpi.h
>> > +++ b/include/linux/pci-acpi.h
>> > @@ -111,6 +111,10 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>> >  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
>> >  #endif /* CONFIG_ACPI */
>> >
>> > +static inline void acpi_pci_set_companion(struct pci_host_bridge *bridge)
>> > +{
>> > +}
>> > +
>> >  static inline int acpi_pci_bus_domain_nr(struct pci_bus *bus)
>> >  {
>> >         return 0;
>> > --
>>
>> Honestly, to me it looks like this series is trying very hard to avoid
>> doing any PCI host bridge configuration stuff from arch/arm64/
>> although (a) that might be simpler and (b) it would allow us to
>> identify the code that's common between *all* architectures using ACPI
>> support for host bridge configuration and to move *that* to a common
>> place later.  As done here it seems to be following the "ARM64 is
>> generic and the rest of the world is special" line which isn't really
>> helpful.
>
> I think patch [1-2] should be merged regardless (they may require minor
> tweaks if we decide to move pci_acpi_scan_root() to arch/arm64 though,
> for include files location). I guess you are referring to patch 8 in
> your comments above, which boils down to deciding whether:
>
> - pci_acpi_scan_root() (and unfortunately all the MCFG/ECAM handling that
>   goes with it) should live in arch/arm64 or drivers/acpi

To be precise, everything under #ifdef CONFIG_ACPI_PCI_HOST_GENERIC or
equivalent is de facto ARM64-specific, because (as it stands in the
patch series) ARM64 is the only architecture that will select that
option.  Unless you are aware of any more architectures planning to
use ACPI (and I'm not aware of any), it will stay the only
architecture selecting it in the foreseeable future.

Therefore you could replace CONFIG_ACPI_PCI_HOST_GENERIC with
CONFIG_ARM64 everywhere in that code which is why in my opinion the
code should live somewhere under arch/arm64/.

Going forward, it should be possible to identify common parts of the
PCI host bridge configuration code in arch/ and move it to
drivers/acpi/ or drivers/pci/, but I bet that won't be the entire code
this series puts under CONFIG_ACPI_PCI_HOST_GENERIC.

The above leads to a quite straightforward conclusion about the order
in which to do things: I'd add ACPI support for PCI host bridge on
ARM64 following what's been done on ia64 (as x86 is more quirky and
kludgy overall) as far as reasonably possible first and then think
about moving common stuff to a common place.

> acpi_pci_bus_domain_nr() is a bit more problematic since it is meant
> to be called from PCI core code (ARM64 selects PCI_DOMAINS_GENERIC for
> DT and same kernel has to work with OF and ACPI selected) and it is
> arch specific (because what we have in bus->sysdata is arch specific,
> waiting for the domain number to be embedded in struct pci_host_bridge).
>
> Your point is fair, I am not sure that moving the pci_acpi_scan_root()
> to arch/arm64 would make things much simpler though, it is just a matter
> of deciding where that code has to live.
>
> How do you want us to proceed ?

Pretty much as stated above. :-)

Thanks,
Rafael
