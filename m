Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbeADQLG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jan 2018 11:11:06 -0500
Date: Thu, 4 Jan 2018 16:12:02 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vignesh R <vigneshr@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dra7xx: Fix legacy INTD IRQ handling
Message-ID: <20180104161202.GB12239@red-moon>
References: <20171229114131.22296-1-vigneshr@ti.com>
 <20171229114131.22296-2-vigneshr@ti.com>
 <953c7aac-0429-8fc7-02ce-ace94aa735f3@ti.com>
 <ebf49e7f-7008-18b8-62d9-9f3dc2de6a54@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ebf49e7f-7008-18b8-62d9-9f3dc2de6a54@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 04, 2018 at 07:04:30PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Thursday 04 January 2018 11:38 AM, Kishon Vijay Abraham I wrote:
> > 
> > 
> > On Friday 29 December 2017 05:11 PM, Vignesh R wrote:
> >> Legacy INTD IRQ handling is broken on dra7xx due to fact that driver
> >> uses hwirq in range of 1-4 for INTA, INTD whereas IRQ domain is of size
> >> 4 which is numbered 0-3. Therefore when INTD IRQ line is used with
> >> pci-dra7xx driver following warning is seen:
> >>
> >>        WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:342 irq_domain_associate+0x12c/0x1c4
> >>        error: hwirq 0x4 is too large for dummy
> >>
> >> Fix this by using pci_irqd_intx_xlate() helper to translate the INTx 1-4
> >> range into the 0-3 as done in other PCIe drivers.
> >>
> >> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> >> Reported-by: Chris Welch <Chris.Welch@viavisolutions.com>
> >> Signed-off-by: Vignesh R <vigneshr@ti.com>
> > 
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/pci/dwc/pci-dra7xx.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> >> index 58aed0896468..892f93910012 100644
> >> --- a/drivers/pci/dwc/pci-dra7xx.c
> >> +++ b/drivers/pci/dwc/pci-dra7xx.c
> >> @@ -226,6 +226,7 @@ static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> >>  
> >>  static const struct irq_domain_ops intx_domain_ops = {
> >>  	.map = dra7xx_pcie_intx_map,
> >> +	.xlate = pci_irqd_intx_xlate,
> 
> Looking at this again, I think the mapping should be done in device tree using
> the interrupt-map property.
> 
> Lorenzo, can you hold merging this patch till we verify using the dt approach?

Yes and I agree that's a DT mapping bug.

Lorenzo
