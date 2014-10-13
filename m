Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [207.46.100.145] ([207.46.100.145]:27936 "EHLO
	na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751505AbaJMGxF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Oct 2014 02:53:05 -0400
Message-ID: <543B767E.8000800@freescale.com>
Date: Mon, 13 Oct 2014 14:51:42 +0800
From: Lian Minghuan-B31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Zang Roy-R61911" <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] PCI: Layerscape: Add Layerscape PCIe driver
References: <1411888107-27640-1-git-send-email-Minghuan.Lian@freescale.com>
 <8584310.bgN0fYJaqP@wuerfel>
In-Reply-To: <8584310.bgN0fYJaqP@wuerfel>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

Sorry for delay in my reply.
Please see my comments inline.

On 2014年09月30日 17:18, Arnd Bergmann wrote:
> On Sunday 28 September 2014 15:08:27 Minghuan Lian wrote:
>> Add support for Freescale Layerscape PCIe controller. This driver
>> re-uses the designware core code.
>>
>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> I'm still not too happy about the MSI handling here. I think you
> really need to have a separate driver for the msi controller.
[Minghuan] LS1021 does not contains MSI controller.
SCFG contains only one register to implement MSI interrupt support.
And I reused pci-designware.c MSI API.
>> +/* SCFG MSI register */
>> +#define SCFG_SPIMSICR		0x40
>> +#define SCFG_SPIMSICLRCR	0x90
>> +
>> +#define MSI_LS1021A_ADDR		0x1570040
>> +#define MSI_LS1021A_DATA(pex_idx)	(0xb3 + pex_idx)
>  From what I can tell, the 'scfg' registers are mostly for MSI, and
> the MSI_LS1021A_ADDR that you have hardcoded here is actually part of
> the scfg area itself. You should never hardwire that in a PCI host
> driver.
>
> Please make a separate MSI driver instead and use the 'msi-parent'
> property.
[Minghuan] There is only one register in SCFG used for MSI.
I really do not want to write a separate MSI driver only for one 
register and two MSI interrupts.
It is really not good to use hardcode MSI_LS1021A_ADDR.
I hope to change it when adding LS2085 PCI driver support.
SCFG contains some registers used for PCI link status, PCI error 
interrupt and PCI PME support.
This is the first patch and will continue to improve.

>> +static u32 ls_pcie_get_msi_addr(struct pcie_port *pp)
>> +{
>> +	return MSI_LS1021A_ADDR;
>> +}
>> +
>> +static u32 ls_pcie_get_msi_data(struct pcie_port *pp, int pos)
>> +{
>> +	struct ls_pcie *pcie = to_ls_pcie(pp);
>> +
>> +	return MSI_LS1021A_DATA(pcie->index);
>> +}
> Does this mean you can have only one device on this PCI host that
> uses MSI?
[Minghuan] Yes. LS1021A provides  only one MSI interrupt for a PCI 
controller NOT 32.
>> +static irqreturn_t ls_pcie_msi_irq_handler(int irq, void *data)
>> +{
>> +	struct pcie_port *pp = data;
>> +	struct ls_pcie *pcie = to_ls_pcie(pp);
>> +	unsigned int msi_irq;
>> +
>> +	/* clear the interrupt */
>> +	regmap_write(pcie->scfg, SCFG_SPIMSICLRCR,
>> +		     MSI_LS1021A_DATA(pcie->index));
>> +
>> +	msi_irq = irq_find_mapping(pp->irq_domain, 0);
>> +	if (!msi_irq) {
>> +		/*
>> +		 * that's weird who triggered this?
>> +		 * just clear it
>> +		 */
>> +		dev_err(pcie->dev, "unexpected MSI\n");
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	generic_handle_irq(msi_irq);
>> +	return IRQ_HANDLED;
>> +}
> Since you have only one addr/data value per host controller, does that mean
> that you can have only one device on this host that uses one interrupt?
>
> How do you ensure that the second user that tries to call pci_enable_msi
> gets an error? Is there only one internal device attached to the host?
[Minghuan] I used the following code to reserve 31 MSI interrupt.
static void ls1021a_pcie_msi_fixup(struct pcie_port *pp)
{
     int i;

     /*
      * LS1021A has only one MSI interrupt
      * Set all msi interrupts as used except the first one
      */
     for (i = 1; i < MAX_MSI_IRQS; i++)
         set_bit(i, pp->msi_irq_in_use);
}
>> +	if (of_device_is_compatible(pcie->dev->of_node, "fsl,ls1021a-pcie")) {
>> +		/*
>> +		 * LS1021A Workaround for internal TKT228622
>> +		 * to fix the INTx hang issue
>> +		 */
>> +		val = ioread32(pcie->dbi + PCIE_STRFMR1);
>> +		val &= 0xffff;
>> +		iowrite32(val, pcie->dbi + PCIE_STRFMR1);
>> +
>> +		ls1021a_pcie_msi_fixup(pp);
>> +	}
>> +}
> "fsl,ls1021a-pcie" is the only one supported by this driver, so the
> check is useless.
[Minghuan] Ok. I will remove the 'if" and will re-add when adding LS2085 
PCI driver.
> 	Arnd

