Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:48966 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeEVLuP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 07:50:15 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 74BA61E04A3
        for <linux-pci@vger.kernel.org>; Tue, 22 May 2018 13:50:13 +0200 (CEST)
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
From: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: Lose/not handling all interrupts when faced with MSI burst issue
Message-ID: <483332aa-e1a2-6f46-d1d1-63717f053045@synopsys.com>
Date: Tue, 22 May 2018 12:48:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I have been informed that when using kernel version v4.14, the root complex
driver is suitable to lose/not handling all interrupts when faced with a high
number of MSI interrupts.
So far I was not able to replicate the issue and I would like to know if any of
you detected this issue in any of your tests.

I analyzed the IRQ handling of 4.14.x and came up with an example for discussion
Reference:
https://elixir.bootlin.com/linux/v4.14.42/source/drivers/pci/dwc/pcie-designware-host.c#L57

IRQ handler:
57 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
58 {
59         int i, pos, irq;
60         u32 val, num_ctrls;
61         irqreturn_t ret = IRQ_NONE;
62
63         num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
64
65         for (i = 0; i < num_ctrls; i++) {

Let us assume for i=0 we got value as b'1101110101:

66                 dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i *12, 4,
67                                     &val);
68                 if (!val)
69                         continue;
70
71                 ret = IRQ_HANDLED;
72                 pos = 0;

Below code scans for b'1 in value from pos 0 to 32:

73                 while ((pos = find_next_bit((unsigned long *)&val, 32,
74                                             pos)) != 32) {
75                         irq = irq_find_mapping(pp->irq_domain, i *32 + pos);
76                         generic_handle_irq(irq);
77                         dw_pcie_wr_own_conf(pp,PCIE_MSI_INTR0_STATUS + i * 12,
78                                             4, 1 <<pos);

Here is the catch… let us assume when we have cleared 0, 2, 4 and 5th pos and
this loop entered to clear 6th pos, it is quite possible that H/W receives new
MSI packet while we are handling and clearing these bits, and if any of the
previous bit gets set again, let us say 0th or 1st or 2nd or 3rd or 4th bit gets
set again. Since we will not read INTR0_STATUS again and clear them, even though
we come out of this handler msi_ctrl_int will not be de-asserted until all the
bits are cleared here.

79                         pos++;
80                 }
81         }
82
83         return ret;
84 }

I think the callback dw_handle_msi_irq() would be called again since the the HW
will keep the msi_ctrl_int active until all bits (which are not masked) are
cleared on the PCIE_MSI_INTR0_STATUS register. Specially, because the
handle_simple_irq mode was set up, which is a level_edge basically.
https://elixir.bootlin.com/linux/v4.14.42/source/drivers/pci/dwc/pcie-designware-host.c#L263

263 static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
264                                         irq_hw_number_t hwirq)
265 {
266        irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
267        irq_set_chip_data(irq, domain->host_data);
268
269        return 0;
270 }

Could you please send me your opinion about this analysis?

Thanks,
Gustavo
