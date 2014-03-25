Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:51917 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753358AbaCYREz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Mar 2014 13:04:55 -0400
Message-ID: <5331B733.8090802@codethink.co.uk>
Date: Tue, 25 Mar 2014 17:04:51 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
MIME-Version: 1.0
To: Phil Edworthy <phil.edworthy@renesas.com>
CC: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v5 2/9] PCI: host: rcar: Add MSI support
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com> <1395766604-30926-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1395766604-30926-3-git-send-email-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 25/03/14 16:56, Phil Edworthy wrote:
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v5:
>   - Return IRQ_NONE from MSI isr when there is no pending MSI
>   - Add additional interrupt bindings
> +
> +static void rcar_msi_free(struct rcar_msi *chip, unsigned long irq)
> +{
> +	struct device *dev = chip->chip.dev;
> +
> +	mutex_lock(&chip->lock);
> +
> +	if (!test_bit(irq, chip->used))
> +		dev_err(dev, "trying to free unused MSI#%lu\n", irq);

Does the upper level not check for this?

> +	else
> +		clear_bit(irq, chip->used);
> +
> +	mutex_unlock(&chip->lock);


> +}
> +
> +static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
> +{
> +	struct rcar_pcie *pcie = data;
> +	struct rcar_msi *msi = &pcie->msi;
> +	unsigned long reg;
> +
> +	reg = pci_read_reg(pcie, PCIEMSIFR);
> +
> +	/* MSI & INTx share an interrupt - we only handle MSI here */
> +	if (!reg)
> +		return IRQ_NONE;
> +
> +	while (reg) {
> +		unsigned int index = find_first_bit(&reg, 32);
> +		unsigned int irq;
> +
> +		/* clear the interrupt */
> +		pci_write_reg(pcie, 1 << index, PCIEMSIFR);
> +
> +		irq = irq_find_mapping(msi->domain, index);
> +		if (irq) {
> +			if (test_bit(index, msi->used))
> +				generic_handle_irq(irq);
> +			else
> +				dev_info(pcie->dev, "unhandled MSI\n");
> +		} else {
> +			/*
> +			 * that's weird who triggered this?
> +			 * just clear it
> +			 */
> +			dev_info(pcie->dev, "unexpected MSI\n");
> +		}

You may want to change this to something that is either rate-limited
or is say debug level so it does not spam the console if something
does go wrong.

Also the comment could easily be made one line
	/* Weird, unknown MSI IRQ, just clear it */


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
