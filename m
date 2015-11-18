Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Ray Jui <rjui@broadcom.com>, Marc Zyngier <marc.zyngier@arm.com>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"tinamdar@apm.com" <tinamdar@apm.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"dhdang@apm.com" <dhdang@apm.com>,
	"sbranden@broadcom.com" <sbranden@broadcom.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	"Robin Murphy" <Robin.Murphy@arm.com>
Subject: RE: [PATCH v8] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Date: Wed, 18 Nov 2015 06:51:41 +0000
Message-ID: <8520D5D51A55D047800579B0941471982585CEB1@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1447223619-30945-1-git-send-email-bharatku@xilinx.com>
 <5649F2D9.7070902@arm.com> <564A5255.3020603@broadcom.com>
 <8520D5D51A55D047800579B0941471982585CBDA@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20151117092100.76babf7f@arm.com>
 <8520D5D51A55D047800579B0941471982585CD78@XAP-PVEXMBX01.xlnx.xilinx.com>
 <564B31BB.3010404@arm.com> <564B54CF.5010307@broadcom.com>
In-Reply-To: <564B54CF.5010307@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: [PATCH v8] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
> PCIe Host Controller
> 
> 
> 
> On 11/17/2015 5:55 AM, Marc Zyngier wrote:
> > On 17/11/15 13:27, Bharat Kumar Gogada wrote:
> >>>
> >>> On Tue, 17 Nov 2015 04:59:39 +0000
> >>> Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> wrote:
> >>>
> >>>>> On 11/16/2015 7:14 AM, Marc Zyngier wrote:
> >>>>>> On 11/11/15 06:33, Bharat Kumar Gogada wrote:
> >>>>>>> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> >>>>>>>
> >>>>>>> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> >>>>>>> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> >>>>>>> ---
> >>>>>>> Added logic to allocate contiguous hwirq in nwl_irq_domain_alloc
> >>>>> function.
> >>>>>>> Moved MSI functionality to separate functions.
> >>>>>>> Changed error return values.
> >>>>>>> ---
> >>>>>>>    .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   68 ++
> >>>>>>>    drivers/pci/host/Kconfig                           |   16 +-
> >>>>>>>    drivers/pci/host/Makefile                          |    1 +
> >>>>>>>    drivers/pci/host/pcie-xilinx-nwl.c                 | 1062
> >>>>> ++++++++++++++++++++
> >>>>>>>    4 files changed, 1144 insertions(+), 3 deletions(-)
> >>>>>>>    create mode 100644
> >>>>>>> Documentation/devicetree/bindings/pci/xilinx-nwl-
> >>>>> pcie.txt
> >>>>>>>    create mode 100644 drivers/pci/host/pcie-xilinx-nwl.c
> >>>>>>>
> >>>>>>
> >>>>>> [...]
> >>>>>>
> >>>>>>> +static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct
> >>>>>>> +pci_bus
> >>>>>>> +*bus) {
> >>>>>>> +	struct platform_device *pdev = to_platform_device(pcie-
> >>>> dev);
> >>>>>>> +	struct nwl_msi *msi = &pcie->msi;
> >>>>>>> +	unsigned long base;
> >>>>>>> +	int ret;
> >>>>>>> +
> >>>>>>> +	mutex_init(&msi->lock);
> >>>>>>> +
> >>>>>>> +	/* Check for msii_present bit */
> >>>>>>> +	ret = nwl_bridge_readl(pcie, I_MSII_CAPABILITIES) &
> >>> MSII_PRESENT;
> >>>>>>> +	if (!ret) {
> >>>>>>> +		dev_err(pcie->dev, "MSI not present\n");
> >>>>>>> +		ret = -EIO;
> >>>>>>> +		goto err;
> >>>>>>> +	}
> >>>>>>> +
> >>>>>>> +	/* Enable MSII */
> >>>>>>> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,
> >>> I_MSII_CONTROL) |
> >>>>>>> +			  MSII_ENABLE, I_MSII_CONTROL);
> >>>>>>> +
> >>>>>>> +	/* Enable MSII status */
> >>>>>>> +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,
> >>> I_MSII_CONTROL) |
> >>>>>>> +			  MSII_STATUS_ENABLE, I_MSII_CONTROL);
> >>>>>>> +
> >>>>>>> +	/* setup AFI/FPCI range */
> >>>>>>> +	msi->pages = __get_free_pages(GFP_KERNEL, 0);
> >>>>>>> +	base = virt_to_phys((void *)msi->pages);
> >>>>>>> +	nwl_bridge_writel(pcie, lower_32_bits(base),
> >>> I_MSII_BASE_LO);
> >>>>>>> +	nwl_bridge_writel(pcie, upper_32_bits(base),
> >>> I_MSII_BASE_HI);
> >>>>>>
> >>>>>> BTW, you still haven't answered my question as to why you need to
> >>>>>> waste a page of memory here, and why putting a device address
> >>>>>> doesn't
> >>>>> work.
> >>>>>>
> >>>>>> As this is (to the best of my knowledge) the only driver doing
> >>>>>> so, I'd really like you to explain the rational behind this.
> >>>>>
> >>>>> Might not be the only driver doing so after I start sending out
> >>>>> patches for the iProc MSI support (soon), :)
> >>>>>
> >>>>> I'm not sure how it works for the Xilinx NWL controller, which
> >>>>> Bharat should be able to help to explain. But for the iProc MSI
> >>>>> controller, there's no device I/O memory reserved for MSI posted
> >>>>> writes
> >>> in the ASIC.
> >>>>> Therefore one needs to reserve host memory for these writes.
> >>>>>>
> >>>>
> >>>> Our SoC doesn't reserve any memory for MSI, hence we need to assign
> >>>> a memory space for it out of RAM.
> >>>
> >>> Question to both of you: Does the write make it to memory? Or is it
> >>> sampled by the bridge and dropped?
> >>>
> >> No, write will not do any modification in memory, it is consumed by
> bridge.
> >
> > Then you do not need to allocate memory at all. Use whatever memory
> > you already have. CC-ing Robin, as this may have interaction with the
> SMMU.
> >
> >>
Ok, I will try with some random address, without allocating any memory and test it, and will
update accordingly in next patch. 
> >>> What happens if you replace the page in RAM with a dummy address?
> >> What do you mean by dummy address ?
> >
> > Any random (and suitably aligned) address. 0x00000deadbeef000 for
> example.
> 
> In our case, I'm pretty sure the writes make it to memory (RAM). I can try
> replacing it with a dummy address, but I'm pretty sure that will not work.
> 
Thanks,
Bharat
