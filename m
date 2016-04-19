Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 19 Apr 2016 12:12:38 +0100
From: Graeme Gregory <gg@slimlogic.co.uk>
To: G Gregory <graeme.gregory@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, jchandra@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>, rafael@kernel.org,
	linux-pci@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	Will Deacon <will.deacon@arm.com>, ddaney@caviumnetworks.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	okaya@codeaurora.org,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	robert.richter@caviumnetworks.com, helgaas@kernel.org,
	Jon Masters <jcm@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>, mw@semihalf.com,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [Linaro-acpi] [PATCH V6 12/13] pci, pci-thunder-ecam: Add ACPI
 support for ThunderX ECAM.
Message-ID: <20160419111238.GA8192@xora-haswell.xora.org.uk>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-13-git-send-email-tn@semihalf.com>
 <571607C0.10909@semihalf.com>
 <CAGCh1+=2vufNvw7wGg=GgQ-s8cH1JQoJBq2FSSc2-b=a6Qh+2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGCh1+=2vufNvw7wGg=GgQ-s8cH1JQoJBq2FSSc2-b=a6Qh+2g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 19, 2016 at 11:41:29AM +0100, G Gregory wrote:
> On 19 April 2016 at 11:26, Tomasz Nowicki <tn@semihalf.com> wrote:
> > On 15.04.2016 19:06, Tomasz Nowicki wrote:
> >>
> >> Passes 1.x miss PCI enhanced allocation (EA) header for fixed-BARs,
> >> thus these passes should use Cavium-specific config access functions
> >> that synthesize the missing EA capabilities.
> >>
> >> We already have DT driver which addresses errata requirements and
> >> allows to use special PCI config accessors. Currently this driver uses
> >> compatible = "cavium,pci-host-thunder-ecam" to mach against the errata.
> >> For ACPI case we need explicit errata number and corresponding
> >> DECLARE_ACPI_MCFG_FIXUP fixup code.
> >>
> >> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> >> ---
> >>   arch/arm64/Kconfig                  | 14 ++++++++++++++
> >>   arch/arm64/include/asm/cpufeature.h |  3 ++-
> >>   arch/arm64/kernel/cpu_errata.c      |  8 ++++++++
> >>   drivers/pci/host/pci-thunder-ecam.c | 35
> >> +++++++++++++++++++++++++++++++++++
> >>   4 files changed, 59 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index 1bded87..b7614b8 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -445,6 +445,20 @@ config CAVIUM_ERRATUM_27456
> >>
> >>           If unsure, say Y.
> >>
> >> +config CAVIUM_ERRATUM_24575
> >> +       bool "Cavium erratum 24575: Enhanced Allocation (EA) emualaion"
> >> +       default y
> >> +       help
> >> +         Enable workaround for erratum 24575.
> >> +
> >> +         Early versions of the Cavium Thunder CN88XX processor are
> >> missing
> >> +         Enhanced Allocation (EA) capabilities for the fixed BAR
> >> addresses used
> >> +         by the on-SoC hardware blocks. The erratum adds config access
> >> +         functions that synthesize the missing EA capabilities for
> >> versions
> >> +         that are missing that information.
> >> +
> >> +         If unsure, say Y.
> >> +
> >>   endmenu
> >>
> >>
> >> diff --git a/arch/arm64/include/asm/cpufeature.h
> >> b/arch/arm64/include/asm/cpufeature.h
> >> index b9b6494..a78364e 100644
> >> --- a/arch/arm64/include/asm/cpufeature.h
> >> +++ b/arch/arm64/include/asm/cpufeature.h
> >> @@ -35,8 +35,9 @@
> >>   #define ARM64_ALT_PAN_NOT_UAO                 10
> >>   #define ARM64_HAS_VIRT_HOST_EXTN              11
> >>   #define ARM64_WORKAROUND_CAVIUM_27456         12
> >> +#define ARM64_WORKAROUND_CAVIUM_24575          13
> >>
> >> -#define ARM64_NCAPS                            13
> >> +#define ARM64_NCAPS                            14
> >>
> >>   #ifndef __ASSEMBLY__
> >>
> >> diff --git a/arch/arm64/kernel/cpu_errata.c
> >> b/arch/arm64/kernel/cpu_errata.c
> >> index 06afd04..89c13d7 100644
> >> --- a/arch/arm64/kernel/cpu_errata.c
> >> +++ b/arch/arm64/kernel/cpu_errata.c
> >> @@ -97,6 +97,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
> >>                            (1 << MIDR_VARIANT_SHIFT) | 1),
> >>         },
> >>   #endif
> >> +#ifdef CONFIG_CAVIUM_ERRATUM_24575
> >> +       {
> >> +       /* Cavium ThunderX, pass 1.x */
> >> +               .desc = "Cavium erratum 24575",
> >> +               .capability = ARM64_WORKAROUND_CAVIUM_24575,
> >> +               MIDR_RANGE(MIDR_THUNDERX, 0x00, 0x01),
> >> +       },
> >> +#endif
> >>         {
> >>         }
> >>   };
> >> diff --git a/drivers/pci/host/pci-thunder-ecam.c
> >> b/drivers/pci/host/pci-thunder-ecam.c
> >> index f67c6d7..01de697 100644
> >> --- a/drivers/pci/host/pci-thunder-ecam.c
> >> +++ b/drivers/pci/host/pci-thunder-ecam.c
> >> @@ -11,10 +11,14 @@
> >>   #include <linux/ioport.h>
> >>   #include <linux/of_pci.h>
> >>   #include <linux/of.h>
> >> +#include <linux/pci-acpi.h>
> >>   #include <linux/platform_device.h>
> >>
> >> +#include <asm/virt.h>
> >> +
> >>   #include "../ecam.h"
> >>
> >> +
> >>   static void set_val(u32 v, int where, int size, u32 *val)
> >>   {
> >>         int shift = (where & 3) * 8;
> >> @@ -376,5 +380,36 @@ static struct platform_driver thunder_ecam_driver = {
> >>   };
> >>   module_platform_driver(thunder_ecam_driver);
> >>
> >> +#ifdef CONFIG_ACPI
> >> +
> >> +static bool needs_cavium_erratum_24575(struct pci_cfg_fixup *fixup,
> >> +                                     struct acpi_pci_root *root)
> >> +{
> >> +       /*
> >> +        * We must match errata code and be hypervisor, quirk does not
> >> apply
> >> +        * for virtual machines.
> >> +        */
> >> +       return cpus_have_cap(ARM64_WORKAROUND_CAVIUM_24575) &&
> >> +              is_hyp_mode_available();
> >> +}
> >> +
> >> +DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575,
> >> &pci_thunder_ecam_ops,
> >> +                       0, PCI_MCFG_BUS_ANY);
> >> +DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575,
> >> &pci_thunder_ecam_ops,
> >> +                       1, PCI_MCFG_BUS_ANY);
> >> +DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575,
> >> &pci_thunder_ecam_ops,
> >> +                       2, PCI_MCFG_BUS_ANY);
> >> +DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575,
> >> &pci_thunder_ecam_ops,
> >> +                       3, PCI_MCFG_BUS_ANY);
> >> +DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575,
> >> &pci_thunder_ecam_ops,
> >> +                       10, PCI_MCFG_BUS_ANY);
> >> +DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575,
> >> &pci_thunder_ecam_ops,
> >> +                       11, PCI_MCFG_BUS_ANY);
> >> +DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575,
> >> &pci_thunder_ecam_ops,
> >> +                       12, PCI_MCFG_BUS_ANY);
> >> +DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575,
> >> &pci_thunder_ecam_ops,
> >> +                       13, PCI_MCFG_BUS_ANY);
> >> +#endif
> >> +
> >
> >
> > I wonder if we can identify quirk based on _DSD properties, like that:
> >
> > Name (_DSD, Package () {
> >         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >         Package () {
> >                 Package (2) {"cavium,pci-host-thunder-ecam", 1},
> >         }
> > })
> >
> > similar for PEM driver:
> >
> > Name (_DSD, Package () {
> >         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >         Package () {
> >                 Package (2) {"cavium,pci-host-thunder-pem", 1},
> >         }
> > })
> >
> > Do you think it is right thing to do?
> >
> 
> Well if your adding new properties why not add a Cavium specific _CID?
> 

For clarity what I mean is something like this allowed.

Device (PCI0)
{
    Name (_HID, EisaId ("PNP0A08"))
    Name (_CID, EisaId ("PNP0A03"))
    Name (_HID, "CAV0666")) // Cavium Quirky Hardware

    ....

}

Graeme
