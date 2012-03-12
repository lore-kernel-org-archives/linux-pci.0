Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:57534 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab2CLQ5P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2012 12:57:15 -0400
Message-ID: <4F5E2AE6.3030404@wwwdotorg.org>
Date: Mon, 12 Mar 2012 10:57:10 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/11] ARM: tegra: pcie: Add MSI support
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de> <1331218291-16119-11-git-send-email-thierry.reding@avionic-design.de> <4F59213F.6070107@wwwdotorg.org> <20120312080023.GA13788@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120312080023.GA13788@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/12/2012 02:00 AM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 03/08/2012 07:51 AM, Thierry Reding wrote:
>>> diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
...
>> Free the IRQ descriptors in the error paths?
...
>>> +	for (msi = 0; msi < INT_PCI_MSI_NR; msi++) {
>>> +		unsigned int irq = irq_find_mapping(pcie->msi_domain, msi);
>>> +
>>> +		irq_set_chip_data(irq, pcie);
>>> +		irq_set_chip_and_handler(irq, &pcie->msi_chip,
>>> +					 handle_simple_irq);
>>> +		set_irq_flags(irq, IRQF_VALID);
>>> +	}
>>> +
>>> +	err = platform_get_irq(pdev, 1);
>>> +	if (err < 0) {
>>> +		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
>>
>> Same here, and undo setting IRQF_VALID?
> 
> Does it make sense to explicitly unset the IRQF_VALID flag when the IRQ
> descriptors are free'd afterwards anyway?

Good point. Probably not per my gut instinct.

...
> I'm also Cc'ing Thomas
> Gleixner as maintainer of the IRQ subsystem, he probably knows best how
> dynamically allocated interrupts should be cleaned up.

But yes, best to check with someone more familiar with interrupts.
