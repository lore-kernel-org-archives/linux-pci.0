Return-Path: <SRS0=Y0BX=2B=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=Y0BX=2B=free.fr=slash.tmp@kernel.org>
Subject: Re: Pointers for writing a good PCIe driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Will Deacon <will.deacon@arm.com>, David Daney <david.daney@cavium.com>,
 Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>
References: <ff099b5f-efc8-bb5f-41e3-493398844cc0@free.fr>
 <05046a8a-ba9f-26f9-4c93-f657f9da6294@free.fr>
 <20170207200656.GA11659@bhelgaas-glaptop.roam.corp.google.com>
 <20170207214758.GC11659@bhelgaas-glaptop.roam.corp.google.com>
 <0f22720c-e47d-59f6-b5f7-5e40f4a1759d@free.fr>
 <20170212165033.GA31833@kroah.com>
 <0d785dab-c830-b887-d9f3-a2cd5338695c@free.fr>
 <20170217143803.GA10663@bhelgaas-glaptop.roam.corp.google.com>
 <eff9861e-043a-7ecd-5d52-c8e18a52ece8@free.fr>
 <20170217175054.GA16671@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <0552ee82-a73a-ad06-4cb2-7eff05931877@free.fr>
Date: Mon, 20 Feb 2017 17:12:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170217175054.GA16671@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 17/02/2017 18:50, Bjorn Helgaas wrote:

> On Fri, Feb 17, 2017 at 06:00:53PM +0100, Mason wrote:
>
>> On 17/02/2017 15:38, Bjorn Helgaas wrote:
>>
>>> The native PCI host controller drivers indeed live in drivers/pci/host/
>>>
>>> I don't know anything about your hardware or environment, but I highly
>>> encourage you to use ACPI (drivers/acpi/pci_root.c, with a little bit
>>> of arch support) or generic DT (drivers/pci/host/pci-host-generic.c)
>>> instead of writing a custom host controller driver.
>>>
>>> The native drivers in drivers/pci/host are a huge maintenance hassle
>>> for no real benefit.
>>
>> I'm currently using this DT description:
>> http://lxr.free-electrons.com/source/arch/arm/boot/dts/tango4-common.dtsi
>>
>> The "legacy" driver sits at ~700 lines. It would be awesome to be able
>> to discard all of it, and rely on generic upstream code. But I don't
>> understand how it is possible for a generic driver to support whatever
>> crazy solution some random vendor has come up with?
> 
> You're right that the programming model of the host bridge itself is
> not specified by PCI specs, so it's impossible to have a generic
> driver that can manage it completely by itself.
> 
> If you have firmware that initializes the bridge and tells the OS what
> the windows are (bus numbers, memory space, I/O space) and where the
> PCIe-specified ECAM space is, a generic driver can take it from there.

(Mostly walking myself through the code and documentation,
noting references along the way.)

I took a look at drivers/pci/host/pci-host-generic.c
which is a tiny file, so the magic must be happening elsewhere.
=> drivers/pci/host/pci-host-common.c (for starters)

gen_pci_cfg_cam_bus_ops and pci_generic_ecam_ops have the same
.pci_ops, but different .bus_shift

$ git grep pci-host-cam-generic
Documentation/devicetree/bindings/pci/host-generic-pci.txt:- compatible     : Must be "pci-host-cam-generic" or "pci-host-ecam-generic"
Documentation/devicetree/bindings/pci/host-generic-pci.txt:    compatible = "pci-host-cam-generic"
drivers/pci/host/pci-host-generic.c:    { .compatible = "pci-host-cam-generic",

$ git grep pci-host-ecam-generic
Documentation/devicetree/bindings/pci/host-generic-pci.txt:- compatible     : Must be "pci-host-cam-generic" or "pci-host-ecam-generic"
arch/arm/boot/dts/alpine.dtsi:                  compatible = "pci-host-ecam-generic";
arch/arm64/boot/dts/al/alpine-v2.dtsi:                  compatible = "pci-host-ecam-generic";
arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi:                   compatible = "pci-host-ecam-generic";
arch/arm64/boot/dts/arm/juno-base.dtsi:         compatible = "arm,juno-r1-pcie", "plda,xpressrich3-axi", "pci-host-ecam-generic";
arch/arm64/boot/dts/broadcom/vulcan.dtsi:               compatible = "pci-host-ecam-generic";
drivers/pci/host/pci-host-generic.c:    { .compatible = "pci-host-ecam-generic",

https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/host-generic-pci.txt

> Firmware-initialised PCI host controllers and PCI emulations, such as the
> virtio-pci implementations found in kvmtool and other para-virtualised
> systems, do not require driver support for complexities such as regulator
> and clock management. In fact, the controller may not even require the
> configuration of a control interface by the operating system, instead
> presenting a set of fixed windows describing a subset of IO, Memory and
> Configuration Spaces.

For the only arm32 user, arch/arm/boot/dts/alpine.dtsi:

		/* Internal PCIe Controller */
		pcie-internal@0xfbc00000 {
			compatible = "pci-host-ecam-generic";
			device_type = "pci";
			#size-cells = <2>;
			#address-cells = <3>;
			#interrupt-cells = <1>;
			reg = <0x0 0xfbc00000 0x0 0x100000>;
			interrupt-map-mask = <0xf800 0 0 7>;
			/* Add legacy interrupts for SATA devices only */
			interrupt-map =	<0x4000 0 0 1 &gic 0 43 4>,
					<0x4800 0 0 1 &gic 0 44 4>;

			/* 32 bit non prefetchable memory space */
			ranges = <0x02000000 0x0 0xfe000000 0x0 0xfe000000 0x0 0x1000000>;

			bus-range = <0x00 0x00>;
			msi-parent = <&msix>;
		};


Compatible string depends on "the layout of configuration space
(CAM vs ECAM respectively)"

https://en.wikipedia.org/wiki/PCI_configuration_space


The register interface to my PCIe controller is:

0x2e000	REGION_0_BASE_REG
0x2e004	REGION_1_BASE_REG
0x2e008	REGION_2_BASE_REG
0x2e00c	REGION_3_BASE_REG
0x2e010	REGION_4_BASE_REG
0x2e014	REGION_5_BASE_REG
0x2e018	REGION_6_BASE_REG
0x2e01c	REGION_7_BASE_REG
0x2e020	DMA_RD_MBUS_ADDR_REG
0x2e024	DMA_RD_ADDR_LO_REG
0x2e028	DMA_RD_ADDR_HI_REG
0x2e02c	DMA_RD_CNT_REG
0x2e030	DMA_WR_MBUS_ADDR_REG
0x2e034	DMA_WR_ADDR_LO_REG
0x2e038	DMA_WR_ADDR_HI_REG
0x2e03c	DMA_WR_CNT_REG
0x2e040	DMA_RD_EN_REG
0x2e044	DMA_WR_EN_REG
0x2e048	PCI_ADDR_LO_BASE_REG
0x2e04c	PCI_ADDR_HI_BASE_REG
0x2e050	PM_REG
0x2e054	MAX_CPL_TIMEOUT_REG
0x2e058	CORE_CONF_0_REG
0x2e05c	CORE_CONF_1_REG
0x2e060	CBA_ADDR_REG
0x2e064	CBA_DATA_REG
0x2e068	DEBUG_0_REG
0x2e06c	DEBUG_1_REG
0x2e070	DEBUG_2_REG
0x2e074	CORE_TEST_OUT_REG
0x2e078	INT_NOT_MSI_REG
0x2e07c	MSI_REG
0x2e080	MSI_0_REG
0x2e084	MSI_1_REG
0x2e088	MSI_2_REG
0x2e08c	MSI_3_REG
0x2e090	MSI_4_REG
0x2e094	MSI_5_REG
0x2e098	MSI_6_REG
0x2e09c	MSI_7_REG
0x2e0a0	MSI_0_MASK_REG
0x2e0a4	MSI_1_MASK_REG
0x2e0a8	MSI_2_MASK_REG
0x2e0ac	MSI_3_MASK_REG
0x2e0b0	MSI_4_MASK_REG
0x2e0b4	MSI_5_MASK_REG
0x2e0b8	MSI_6_MASK_REG
0x2e0bc	MSI_7_MASK_REG
0x2e0c0	PHY_HW_TRAPS_REG
0x2e0c4	COMMON_BIST_0_REG
0x2e0c8	COMMON_BIST_1_REG
0x2e0cc	LANE_0_BIST_REG
0x2e0d0	CUSTOM_CONF_LINK_REG
0x2e0d4	CUSTOM_CONF_LANE_0_REG
0x2e0e0	PLL_SETTING_REG
0x2e0e4	DEBUG_3_REG
0x2e0e8	DEBUG_4_REG
0x2e0ec	DEBUG_5_REG


In the "legacy" driver (for kernel v3.4), I see

static struct pci_ops tangox_pcie_ops = {
	.read	= tangox_pcie_read_conf,
	.write	= tangox_pcie_write_conf,
};

#define TANGOX_PCIE_ENABLE_CONFIG_IO()      WR_PCIE_REG32(TANGOX_PCIE_PCI_ADDR_LO_BASE_REG, ((TANGOX_PCIE_ADDR_BASE & 0xff000000) | 0x1))
#define TANGOX_PCIE_DISABLE_CONFIG_IO()     WR_PCIE_REG32(TANGOX_PCIE_PCI_ADDR_LO_BASE_REG, ((TANGOX_PCIE_ADDR_BASE & 0xff000000) & ~0x1))

static int tangox_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
                                 int where, int size, u32 *val)
{
    void __iomem *addr;

    TANGOX_PCIE_ENABLE_CONFIG_IO();

    addr =  (void __iomem *)(
            tangox_pcie.regs +
            PCIE_CONF_BUS(bus->number) +
            PCIE_CONF_DEV(PCI_SLOT(devfn)) +
            PCIE_CONF_FUNC(PCI_FUNC(devfn)) +
            PCIE_CONF_REG(where));

    *val = readl( addr );

	if (size == 1)
		*val = (*val >> (8 * (where & 3))) & 0xff;
	else if (size == 2)
		*val = (*val >> (8 * (where & 3))) & 0xffff;

    TANGOX_PCIE_DISABLE_CONFIG_IO();

    return PCIBIOS_SUCCESSFUL;
}


I see that pci-host-common.c calls:
pci_scan_root_bus(dev, cfg->busr.start, &ops->pci_ops, cfg, &resources);

whereas the legacy driver calls:
pci_scan_root_bus(NULL, sys->busnr, &tangox_pcie_ops, sys, &sys->resources);

So the generic equivalent of
tangox_pcie_read_conf() and tangox_pcie_write_conf()
should be
pci_generic_config_read() and pci_generic_config_write()


int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
			    int where, int size, u32 *val)
{
	void __iomem *addr;

	addr = bus->ops->map_bus(bus, devfn, where);
	if (!addr) {
		*val = ~0;
		return PCIBIOS_DEVICE_NOT_FOUND;
	}

	if (size == 1)
		*val = readb(addr);
	else if (size == 2)
		*val = readw(addr);
	else
		*val = readl(addr);

	return PCIBIOS_SUCCESSFUL;
}


Problem might come from the
TANGOX_PCIE_ENABLE_CONFIG_IO() / TANGOX_PCIE_DISABLE_CONFIG_IO()
shenanigans.

Also, I see that the legacy implementation reads 32 bits,
then performs the shift & mask in software. I'm hoping that
the ARM core does the right thing for readb/readw.


Taking a closer look at TANGOX_PCIE_ENABLE_CONFIG_IO()
WR_PCIE_REG32(TANGOX_PCIE_PCI_ADDR_LO_BASE_REG, ((TANGOX_PCIE_ADDR_BASE & 0xff000000) | 0x1))

Register "PCI_ADDR_LO_BASE_REG" is composed of
pci_addr_base_lo[31:28] and pci_conf[0]

  pci_conf : if 1, the access by LBUS is a configuration request. If 0, the access by LBUS is a memory request.
  pci_addr_base_lo : lower part of the PCI address for access by LBUS.

So it looks like I need to fudge something, perhaps override map_bus method?

What is a "memory request", in PCIe lingo?
In other words, when do I need to clear the "pci_conf" bit?
(Maybe firmware can just set it to 1, and be done with it?)

Regards.
