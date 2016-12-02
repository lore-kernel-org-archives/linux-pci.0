Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 2 Dec 2016 17:39:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
Message-ID: <20161202233943.GF9903@bhelgaas-glaptop.roam.corp.google.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <1480620053.4751.30.camel@redhat.com>
 <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com>
 <20161201230736.GA17948@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLND=Ss8d-jv7wffbrtytrjj=SUnjDn9bognKUszhKguRV1A@mail.gmail.com>
 <d77e403c-81e9-114e-6ec6-bbffaa4ac36f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d77e403c-81e9-114e-6ec6-bbffaa4ac36f@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, Rafael Wysocki <rafael@kernel.org>,
 linux-pci@vger.kernel.org, Duc Dang <dhdang@apm.com>,
 patches <patches@apm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Salter <msalter@redhat.com>, Tomasz Nowicki <tn@semihalf.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 11:08:23PM -0500, Jon Masters wrote:
> Hi Bjorn, Duc, Mark,
> 
> I switched my brain to the on mode and went and read some specs, and a few
> tables, so here's my 2 cents on this...
> 
> On 12/01/2016 06:22 PM, Duc Dang wrote:
> > On Thu, Dec 1, 2016 at 3:07 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> On Thu, Dec 01, 2016 at 02:10:10PM -0800, Duc Dang wrote:
> 
> >>>>> The SoC provide some number of RC bridges, each with a different base
> >>>>> for some mmio registers. Even if segment is legitimate in MCFG, there
> >>>>> is still a problem if a platform doesn't use the segment ordering
> >>>>> implied by the code. But the PNP0A03 _CRS does have this base address
> >>>>> as the first memory resource, so we could get it from there and not
> >>>>> have hard-coded addresses and implied ording in the quirk code.
> >>>>
> >>>> I'm confused.  Doesn't the current code treat every item in PNP0A03
> >>>> _CRS as a window?  Do you mean the first resource is handled
> >>>> differently somehow?  The Consumer/Producer bit could allow us to do
> >>>> this by marking the RC MMIO space as "Consumer", but I didn't think
> >>>> that strategy was quite working yet.
> 
> Let's see if I summarized this correctly...
> 
> 1. The MMIO registers for the host bridge itself need to be described
>    somewhere, especially if we need to find those in a quirk and poke
>    them. Since those registers are very much part of the bridge device,
>    it makes sense for them to be in the _CRS for PNP0A08/PNP0A03.
> 
> 2. The address space covering these registers MUST be described as a
>    ResourceConsumer in order to avoid accidentally exposing them as
>    available for use by downstream devices on the PCI bus.
> 
> 3. The ACPI specification allows for resources of the type "Memory32Fixed".
>    This is a macro that doesn't have the notion of a producer or consumer.
>    HOWEVER various interpretations seem to be that this could/should
>    default to being interpreted as a consumed region.

I agree; I think that per spec, Memory24, Memory32, Memory32Fixed, IO,
and FixedIO should all be for consumed resources, not for bridge
windows, since they don't have the notion of producer.

I'm pretty sure there's x86 firmware in the field that uses these for
windows, so I think we have to accept that usage, at least on x86.

> 4. At one point, a regression was added to the kernel:
> 
>    63f1789ec716 ("x86/PCI/ACPI: Ignore resources consumed by
>    host bridge itself")
> 
>    Which lead to a series on conversations about what should happen
>    for bridge resources (e.g. https://lkml.org/lkml/2015/3/24/962 )
> 
> 5. This resulted in the following commit reverting point 4:
> 
>    2c62e8492ed7 ("x86/PCI/ACPI: Make all resources except [io 0xcf8-0xcff]
>    available on PCI bus")
> 
>    Which also stated that:
> 
>    "This solution will also ease the way to consolidate ACPI PCI host
>     bridge common code from x86, ia64 and ARM64"
> 
> End of summary.
> 
> So it seems that generally there is an aversion to having bridge resources
> be described in this manner and you would like to require that they be
> described e.g. using QWordMemory with a ResourceConsumer type?

Per spec, we should ignore the Consumer/Producer bit in Word/DWord/QWord
descriptors.  In bridge devices on x86, I think we have to treat them as
producers (windows) because that's how they've been typically used.  

> BUT if we were to do that, it would break existing shipping systems since
> there are quirks out there that use this form to find the base CSR:
> 
>        if (acpi_res->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
>                 fixed32 = &acpi_res->data.fixed_memory32;
>                 port->csr_base = ioremap(fixed32->address,
>                                          fixed32->address_length);
>                 return AE_CTRL_TERMINATE;
>         }

I think this is a valid usage of FixedMemory32 in terms of the spec.
Linux currently handles this as a window if it appears in a PNP0A03
device because some x86 firmware used it that way.

We might be able to handle it differently on arm64, e.g., by making an
arm64 version of pci_acpi_root_prepare_resources() that checks for
IORESOURCE_WINDOW.

> 2. What would happen if we had a difference policy on arm64 for such
>    resources. x86 has an "exception" for accessing the config space
>    using IO port 0xCF8-0xCFF (a fairly reasonable exception!) and
>    we can make the rules for a new platform (i.e. actually prescribe
>    exactly what the behavior is, rather than have it not be defined).
>    This is of course terrible in that existing BIOS vendors and so on
>    won't necessarily know this when working on ARM ACPI later on.

> Indeed. And in the case of m400, it is currently this in shipping systems:
> 
>                Memory32Fixed (ReadWrite,
>                     0x1F500000,         // Address Base
>                     0x00010000,         // Address Length
>                     )

> >>> [    0.822990] pci_bus 0000:00: root bus resource [mem 0x1f2b0000-0x1f2bffff]
> >>
> >> I think this is wrong.  The PCI core thinks [mem 0x1f2b0000-0x1f2bffff]
> >> is available for use by devices on bus 0000:00, but I think you're
> >> saying it is consumed by the bridge itself, not forwarded down to PCI.

I think this ASL is perfectly spec-compliant, and what's wrong is the
way Linux is interpreting it.

I'm not clear on what's terrible about idea 2.  I think it's basically
what I suggested above, i.e., something like the patch below, which I
think (hope) would keep us from thinking that region is a window.

Even without this patch, I don't think it's a show-stopper to have
Linux mistakenly thinking this region is routed to PCI, because the
driver does reserve it and the PCI core will never try to use it.

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 8a177a1..a16fc8e 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -114,6 +114,19 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 	return 0;
 }
 
+static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
+{
+	struct resource_entry *entry, *tmp;
+	int status;
+
+	status = acpi_pci_probe_root_resources(ci);
+	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+		if (!(entry->res->flags & IORESOURCE_WINDOW))
+			resource_list_destroy_entry(entry);
+	}
+	return status;
+}
+
 /*
  * Lookup the bus range for the domain in MCFG, and set up config space
  * mapping.
@@ -190,6 +203,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	}
 
 	root_ops->release_info = pci_acpi_generic_release_info;
+	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
 	root_ops->pci_ops = &ri->cfg->ops->pci_ops;
 	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
 	if (!bus)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
