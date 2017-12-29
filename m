Return-Path: <SRS0=KYl/=DZ=free-electrons.com=cyrille.pitchen@kernel.org>
Return-Path: <SRS0=KYl/=DZ=free-electrons.com=cyrille.pitchen@kernel.org>
Subject: Re: [PATCH v2 6/9] PCI: cadence: Add host driver for Cadence PCIe
 controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, adouglas@cadence.com, stelford@cadence.com,
 dgary@cadence.com, kgopi@cadence.com, eandrews@cadence.com,
 thomas.petazzoni@free-electrons.com, sureshp@cadence.com, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
 <4b2b67ad54e14ee5e1f83af65e9932ce408e82ec.1513620412.git.cyrille.pitchen@free-electrons.com>
 <20171228230111.GB19819@bhelgaas-glaptop.roam.corp.google.com>
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Message-ID: <c34c6480-7297-8756-6bc2-8c8e6a451f0d@free-electrons.com>
Date: Fri, 29 Dec 2017 23:08:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171228230111.GB19819@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Le 29/12/2017 à 00:01, Bjorn Helgaas a écrit :
> On Mon, Dec 18, 2017 at 07:16:06PM +0100, Cyrille Pitchen wrote:
>> This patch adds support to the Cadence PCIe controller in host mode.
>>
>> The "cadence/" entry in drivers/pci/Makefile is placed after the
>> "endpoint/" entry so when the next patch introduces a EPC driver for the
>> Cadence PCIe controller, drivers/pci/cadence/pcie-cadence-ep.o will be
>> linked after drivers/pci/endpoint/*.o objects, otherwise the built-in
>> pci-cadence-ep driver would be probed before the PCI endpoint libraries
>> would have been initialized, which would result in a kernel crash.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> 
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index 7284a7f6ad1e..a66ddb347798 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -54,5 +54,6 @@ obj-y += host/
>>  obj-y += switch/
>>  
>>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>> +obj-$(CONFIG_PCI_CADENCE)	+= cadence/
>>  # PCI dwc controller drivers
>>  obj-y				+= dwc/
> 
> I don't like the fact that the cadence/ rule looks different than the
> dwc/ rule for no obvious reason.  With some work, the dwc/ rule could
> maybe be made to look like:

I've tried to understand why dwc uses obj-y instead of
obj-$(CONFIG_PCIE_DW), here is what I've found:

In drivers/pci/dwc/Makefile there is some obj-$(CONFIG_ARM64) rule to
generate the pcie-hisi.o object like there are other obj-$(CONFIG_ARM64)
rules in drivers/pci/host/Makefile produce objects like pci-thunder-ecam.o
for instance.

Then I compared both drivers/pci/dwc/pcie-hisi.c and
drivers/pci/host/pci-thunder-ecam.c:

Both files are structured like this:

#if defined(CONFIG_PCI_<controller_name>) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))

[...]
struct pci_ecam_ops <controller_name>_ops = {
	.bus_shift	= 20,
	.pci_ops	= {
		[...]
	}
};

#ifdef CONFIG_PCI_<controller_name>

[...]

static struct platform_driver <controller_name>_driver = {
	.driver = {
		[...]
	},
	.probe = <controller_name>_probe,
};
builtin_platform_driver(<controller_name>_driver);

#endif
#endif


Then the 'struct pci_ecam_ops' <controller_name>_ops is declared in
include/linux/pci-ecam.h:

#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
extern struct pci_ecam_ops pci_32b_ops;		/* 32-bit accesses only */
extern struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
extern struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 1.x & 2.x */
extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
#endif

And referenced by drivers/acpi/pci_mcfg.c.

So I guess this is the reason why the 'dwc' folder uses obj-y like the
'host' folder does in drivers/pci/Makefile: files like pcie-hisi.c must
be compiled when all 3 CONFIG_ARM64, CONFIG_ACPI and CONFIG_PCI_QUIRKS are
defined even if their associated CONFIG_PCI_<controller_name> is not defined.

So is it okay for you to leave the dwc rule as is for now?

> 
>   obj-$(CONFIG_PCIE_DW)                 += dwc/
> 
> I *think* that should actually be pretty easy.  Everything in
> drivers/pci/dwc/Kconfig selects PCIE_DW if set, either via
> PCIE_DW_HOST or PCIE_DW_EP.
> 
>> diff --git a/drivers/pci/cadence/Kconfig b/drivers/pci/cadence/Kconfig
>> new file mode 100644
>> index 000000000000..0d15b40861e9
>> --- /dev/null
>> +++ b/drivers/pci/cadence/Kconfig
>> @@ -0,0 +1,24 @@
>> +menuconfig PCI_CADENCE
>> +	bool "Cadence PCI controllers support"
>> +	depends on PCI && HAS_IOMEM
>> +	help
>> +	  Say Y here if you want to support some Cadence PCI controller.
>> +
>> +	  When in doubt, say N.
>> +
>> +if PCI_CADENCE
>> +
>> +config PCIE_CADENCE
>> +	bool
>> +
>> +config PCIE_CADENCE_HOST
>> +	bool "Cadence PCIe host controller"
>> +	depends on OF
>> +	select IRQ_DOMAIN
>> +	select PCIE_CADENCE
>> +	help
>> +	  Say Y here if you want to support the Cadence PCIe controller in host
>> +	  mode. This PCIe controller may be embedded into many different vendors
>> +	  SoCs.
>> +
>> +endif # PCI_CADENCE
> 
> Can you just use the same strategy as pci/dwc/Kconfig does, i.e., omit
> the top-level PCI_CADENCE symbol?  If we don't need it for dwc, with
> its dozen drivers, we probably don't need it for the one or two
> Cadence drivers.
>

done for the next version of the series.

Best regards,

Cyrille
 
> Bjorn
> 


-- 
Cyrille Pitchen, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
