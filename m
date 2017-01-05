Return-Path: <SRS0=oWCb=YT=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=oWCb=YT=arm.com=marc.zyngier@kernel.org>
Subject: Re: Need information on handling legacy interrupts
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <8520D5D51A55D047800579B094147198263B5640@XAP-PVEXMBX02.xlnx.xilinx.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <53d55835-3e6a-7846-6af0-ccec502f5776@arm.com>
Date: Thu, 5 Jan 2017 15:01:27 +0000
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198263B5640@XAP-PVEXMBX02.xlnx.xilinx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 05/01/17 14:40, Bharat Kumar Gogada wrote:
> Hi,
> 
> In pcie-xilinx-nwl.c, the bridge has legacy status read only register where the status bit is set when
> Assert_INTx is received and cleared only when Deassert_INTx is received.
> The above scenario is causing issue if an EP takes more time to send Deassert_Intx (we are mainly seeing issue
> with wifi cards, when we do wifi scan and not with other cards, where we tested Ethernet/nvme).
> Here is code in driver:
> 
> chained_irq_enter(chip, desc);
>         pcie = irq_desc_get_handler_data(desc);
> 
>         while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
>                                 MSGF_LEG_SR_MASKALL) != 0) {
>                 for_each_set_bit(bit, &status, INTX_NUM) {
>                         virq = irq_find_mapping(pcie->legacy_irq_domain,
>                                                 bit + 1);
>                         if (virq)
>                                 generic_handle_irq(virq);
>                 }
>         }
> chained_irq_exit(chip, desc);
> 
> So the RP driver will continuously loop in the while as there is delay in EP Deassert_Intx, this is leading to CPU stall.
> so we tried changing from "while" to "if", to avoid looping in while,  but since legacy IRQ line is
> high (level sensitive GIC again sees as new interrupt)  the RP handler is called continuously again not
> giving cpu share to execute other tasks leading to CPU stall.
> 
> In case of pcie-xilinx.c where the the bridge is different, when IDR register is cleared at the end of interrupt handler, the
> irq line between RP and GIC goes low. In this scenario the same wifi cards works fine.

But isn't that a bug of its own? If you allow the cascade interrupt to
clear even if the EP is still asserting its interrupt, you may miss
other EP interrupts if it ORs multiple interrupt reasons to a single
INTx line.

> 
> In other drivers (altera, keystone) I see that they have a register where they acknowledge the bridge after
> they receive legacy interrupt, but not sure whether it makes irq line low.
> 
> So which is the better way to handle legacy interrupts, whether to wait for deassert or whether to
> acknowledge bridge after receiving interrupt irrespective of Deassert and make irq line low?

I don't think there is any foolproof solution. The EP is slow
de-asserting the interrupt, and there isn't much we can to about it.

> This email and any attachments are intended for the sole use of the
> named recipient(s) and contain(s) confidential information that may
> be proprietary, privileged or copyrighted under applicable law. If
> you are not the intended recipient, do not read, copy, or forward
> this email message or any attachments. Delete this email message and
> any attachments immediately.

Please fix this footer. By the letter of this, I'm already violating all
kinds of law...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
