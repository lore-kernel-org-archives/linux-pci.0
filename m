Return-Path: <SRS0=K1PJ=72=linaro.org=ard.biesheuvel@kernel.org>
Return-Path: <SRS0=K1PJ=72=linaro.org=ard.biesheuvel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170824164211.GH31858@bhelgaas-glaptop.roam.corp.google.com>
References: <20170821192907.8695-1-ard.biesheuvel@linaro.org>
 <20170821192907.8695-3-ard.biesheuvel@linaro.org> <20170824164211.GH31858@bhelgaas-glaptop.roam.corp.google.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Aug 2017 17:43:08 +0100
Message-ID: <CAKv+Gu-K7wqROca9wOPGppEJyrsWCZFzJisqKwObZtFSGkC6vQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] pci: designware: add separate driver for the MSI part
 of the RC
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 24 August 2017 at 17:42, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Aug 21, 2017 at 08:29:06PM +0100, Ard Biesheuvel wrote:
>> Most drivers that currently exist for the Synopsys Designware PCIe
>> controller in RC mode hardcode the relation with the embedded MSI
>> controller. This makes it more difficult than necessary to use a
>> generic driver to drive the RC, which is especially unfortunate
>> in cases where the firmware already configures the RC to the extent
>> that it can be driven by the generic ECAM driver. It also makes it
>> impossible to use an existing driver but use another IP block for
>> MSI support, i.e., a GICv2m or GICv3-ITS.
>>
>> So add a separate driver for the MSI part, which can be referenced
>> from the DT node describing the RC via its msi-parent property.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
>> +static int dw_pcie_msi_probe(struct platform_device *pdev)
>> +{
>> +     struct fwnode_handle *fwnode = of_node_to_fwnode(pdev->dev.of_node);
>> +     struct device *dev = &pdev->dev;
>> +     struct dw_pcie_msi *dw_msi;
>> +     struct resource *res;
>> +
>> +     dw_msi = devm_kzalloc(dev, sizeof(*dw_msi), GFP_KERNEL);
>> +     if (!dw_msi)
>> +             return -ENOMEM;
>> +
>> +     /* get the control register and map it */
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     dw_msi->regbase = devm_ioremap_resource(dev, res);
>> +     if (IS_ERR(dw_msi->regbase))
>> +             return PTR_ERR(dw_msi->regbase);
>> +
>> +     /* get the wired interrupt that gets raised when we receive an MSI */
>> +     dw_msi->irq = platform_get_irq(pdev, 0);
>> +     if (dw_msi->irq <= 0) {
>> +             pr_err("Failed to map IRQ\n");
>
> dev_err()
>
> I'm not sure "failed to *map* IRQ" is the most informative text.
> Other callers often use some variant of "failed to get IRQ" or "no IRQ
> resource found".
>

Good point. I will fix that.
