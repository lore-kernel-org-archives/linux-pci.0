Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160526123459.GA23794@red-moon>
References: <1455069384-22323-1-git-send-email-dhdang@apm.com>
 <1456330151.5681.46.camel@redhat.com> <56CDD767.6020103@arm.com>
 <CADaLND=mrkxOWOzcEb8os16Rb=SDHfnn_8eSgB4bQYH3UguS3w@mail.gmail.com>
 <20160225173822.GA6349@red-moon> <CADaLNDnywVPER9QhmK4C6JyCLhta_M_cVSOuSkEHnmnLPFo3JA@mail.gmail.com>
 <20160526123459.GA23794@red-moon>
From: Duc Dang <dhdang@apm.com>
Date: Thu, 26 May 2016 13:49:23 -0700
Message-ID: <CADaLNDnf8SRbUkBN9fZMvrvsnTQs+DLyqnZfVpWqVyyY8Hk=1Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI boot
 for X-Gene v1
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
	Mark Salter <msalter@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Feng Kan <fkan@apm.com>,
	linux-pci@vger.kernel.org, patches <patches@apm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Loc Ho <lho@apm.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Thu, May 26, 2016 at 5:34 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Hi Duc,
>
> On Wed, May 25, 2016 at 04:13:35PM -0700, Duc Dang wrote:
>> On Thu, Feb 25, 2016 at 9:38 AM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>> > On Wed, Feb 24, 2016 at 02:28:10PM -0800, Duc Dang wrote:
>> >> On Wed, Feb 24, 2016 at 8:16 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> >> > On 24/02/16 16:09, Mark Salter wrote:
>> >> >> On Tue, 2016-02-09 at 17:56 -0800, Duc Dang wrote:
>> >> >>> This patch makes pci-xgene-msi driver ACPI-aware and provides
>> >> >>> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
>> >> >>>
>> >> >>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> >> >>> ---
>> >> >>>  drivers/pci/host/pci-xgene-msi.c | 35 ++++++++++++++++++++++++++++++++---
>> >> >>>  1 file changed, 32 insertions(+), 3 deletions(-)
>> >> >>>
>> >> >>> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
>> >> >>> index a6456b5..466aa93 100644
>> >> >>> --- a/drivers/pci/host/pci-xgene-msi.c
>> >> >>> +++ b/drivers/pci/host/pci-xgene-msi.c
>> >> >>> @@ -24,6 +24,7 @@
>> >> >>>  #include <linux/pci.h>
>> >> >>>  #include <linux/platform_device.h>
>> >> >>>  #include <linux/of_pci.h>
>> >> >>> +#include <linux/acpi.h>
>> >> >>>
>> >> >>>  #define MSI_IR0                     0x000000
>> >> >>>  #define MSI_INT0            0x800000
>> >> >>> @@ -39,7 +40,7 @@ struct xgene_msi_group {
>> >> >>>  };
>> >> >>>
>> >> >>>  struct xgene_msi {
>> >> >>> -    struct device_node      *node;
>> >> >>> +    struct fwnode_handle    *fwnode;
>> >> >>>      struct irq_domain       *inner_domain;
>> >> >>>      struct irq_domain       *msi_domain;
>> >> >>>      u64                     msi_addr;
>> >> >>> @@ -249,6 +250,13 @@ static const struct irq_domain_ops msi_domain_ops = {
>> >> >>>      .free   = xgene_irq_domain_free,
>> >> >>>  };
>> >> >>>
>> >> >>> +#ifdef CONFIG_ACPI
>> >> >>> +static struct fwnode_handle *xgene_msi_get_fwnode(struct device *dev)
>> >> >>> +{
>> >> >>> +    return xgene_msi_ctrl.fwnode;
>> >> >>> +}
>> >> >>> +#endif
>> >> >>> +
>> >> >>>  static int xgene_allocate_domains(struct xgene_msi *msi)
>> >> >>>  {
>> >> >>>      msi->inner_domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
>> >> >>> @@ -256,7 +264,7 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
>> >> >>>      if (!msi->inner_domain)
>> >> >>>              return -ENOMEM;
>> >> >>>
>> >> >>> -    msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(msi->node),
>> >> >>> +    msi->msi_domain = pci_msi_create_irq_domain(msi->fwnode,
>> >> >>>                                                  &xgene_msi_domain_info,
>> >> >>>                                                  msi->inner_domain);
>> >> >>
>> >> >> This doesn't work for me (ACPI probing on Mustang) unless I change this
>> >> >> to be pci_msi_create_default_irq_domain(). The problem seems to be that
>> >> >> the MSI probe happens after the PCIe RC is probed so there is no MSI domain
>> >> >> at the time the PCIe root is initialized by ACPI.
>> >> >
>> >> > pci_msi_create_default_irq_domain is the wrong thing do use, specially
>> >> > if you have multiple MSI controllers in the system. I certainly wouldn't
>> >> > want to see it being used on arm64.
>> >> >
>> >> > This is the usual dependency hell. You try moving the probing earlier,
>> >> > but that may break something else in the process.
>> >>
>> >> Hi Mark and Marc,
>> >>
>> >> I have modified Tianocore firmware to have MSI node declared before
>> >> PCIe node in Dsdt table. With this modification, the MSI driver will
>> >> be loaded before PCIe driver and MSI domain is available at the time
>> >> PCIe root is initialized.
>> >
>> > I am totally against this. We should not hack ACPI tables to make
>> > the kernel work (on top of that with unwritten ordering rules that may
>> > well require changes as kernel evolves), we should have a standard set
>> > of bindings that people use to describe HW in the DSDT and the kernel(s)
>> > has to cope with that. If there is a dependency problem in the description
>> > we may solve it at bindings level, but I absolutely do not want to rely
>> > on DSDT nodes ordering for things to work, that's fragile, no shortcuts
>> > please.
>>
>> Hi Lorenzo, Bjorn,
>>
>> (Refresh this thread on this merge cycle)
>>
>> I tried to use _DEP method to describe the dependency of PCIe node to
>> MSI node but it turns out that PCIe driver does not check for the
>> dependency (only EC (ec.c) and I2C core (i2c-core.c) use
>> acpi_walk_dep_device_list to check for dependency before loading
>> dependent drivers)
>>
>> Do you have other suggestion/example about how to ensure strict
>> ordering on driver loading in ACPI boot mode without changing the
>> order of ACPI nodes in DSDT?
>
> Before doing anything else, I would like to ask you to report the code
> paths leading to failures (what fails actually ?) please, and I want
> to understand what "this does not work" means.
>
> In particular:
>
> - Why using pci_msi_create_default_irq_domain() works
> - Why, if you change the DSDT nodes ordering, things work (please add
>   some debugging to MSI allocation functions to detect the code paths
>   leading to correct MSI allocation)
> - What's the difference wrt the DT probe path

The MSI allocation happens with following code path (I use PMC pm80xx
SAS driver as an example (drivers/scsi/pm8001/pm8001_init.c)):
pci_enable_msix_exact
    pci_enable_msix_range
        pci_enable_msix
            msix_capbility_init
                pci_msi_setup_msi_irqs
                    pci_msi_get_domain
                        dev_get_msi_domain
                        arch_get_pci_msi_domain
                            return pci_msi_default_domain;

In my failing case: pci_msi_get_domain return NULL, so MSI allocation
function (pci_enable_msix_exact) fails.

The expected MSI domain is registered when X-Gene MSI driver is
initialized and is attached to each PCI bus by calling
pci_set_bus_msi_domain during PCIe bus-scan:
pci_scan_root_bus
    pci_scan_root_bus_msi
        pci_scan_child_bus
            pci_scan_bridge
                pci_add_new_bus
                    pci_alloc_child_bus
                        pci_set_bus_msi_domain
                            pci_host_bridge_msi_domain
                                pci_host_bridge_of_msi_domain
                                pci_host_bridge_acpi_msi_domain

+ When booting with DT: X-Gene MSI driver is initialized early
(subsys_initcall level); X-Gene PCIe driver is initialized later at
device_initcall level (using module_platform_driver). Because of that
when PCIe enumeration happens, the X-Gene MSI domain was already
registered and available. So when the driver of PCIe Endpoint devices
gets loaded, the call to pci_enable_msix_exact (to allocate MSI)
succeeds.

+ When booting with ACPI: acpi_scan_init is called at subsys_initcall
level (the same level with X-Gene MSI driver):
acpi_init
    acpi_bus_init (GIC is initialized here)
        acpi_scan_init
            acpi_pci_root_init
            acpi_pci_link_init
            ...
            acpi_bus_scan
                acpi_bus_check_add
 ...

Currently, in DSDT table, X-Gene MSI node is defined right after
X-Gene PCIe nodes. So PCIe driver initialization and PCIe enumeration
happens before MSI driver is initialized. During PCIe bus scan, the
pci_set_bus_msi_domain gets a NULL  irq_domain value from
pci_host_bridge_msi_domain (as MSI driver is not initialized), so
there is no MSI support for PCIe bus.

+ Using pci_msi_create_default_irq_domain() helps MSI allocation
succeed as pci_msi_get_domain (in the code path of
pci_enable_msix_exact above) can fall back to get a valid domain from
arch_get_pci_msi_domain (please note that PCIe endpoint driver gets
called later (at device_initcall level (using module_init)), so at the
time PCIe endpoint driver probe function executes, the MSI driver
already register the global MSI domain with
pci_msi_create_default_irq_domain)

+ If changing DSDT node ordering, to define MSI node before PCIe
nodes, then X-Gene MSI driver will be loaded before PCIe host driver.
At the time PCIe enumeration happens, X-Gene MSI driver already
registered a valid MSI domain (by calling
pci_msi_register_fwnode_provider to register the fwnode provider
function), so all the detected PCIe buses (and PCIe endpoint devices)
will have a valid MSI domain attached to them (as a result of function
pci_set_bus_msi_domain)

Regards,
Duc Dang.
>
> When we have a detailed view of MSI allocation code paths and failures
> we can see what we can do to fix it in ACPI.
>
> Thanks,
> Lorenzo
