Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: dra7xx: mark dra7xx_pcie_msi irq as
 IRQF_NO_THREAD
To: Bjorn Helgaas <helgaas@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <1448027966-21610-1-git-send-email-grygorii.strashko@ti.com>
 <20151204184619.GD20125@localhost> <20151208090555.GA19438@linutronix.de>
 <20151209152423.GD31930@localhost>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>, <tony@atomide.com>,
	<nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <5668831D.1050300@ti.com>
Date: Wed, 9 Dec 2015 21:38:05 +0200
MIME-Version: 1.0
In-Reply-To: <20151209152423.GD31930@localhost>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/09/2015 05:24 PM, Bjorn Helgaas wrote:
> On Tue, Dec 08, 2015 at 10:05:56AM +0100, Sebastian Andrzej Siewior wrote:
>> * Bjorn Helgaas | 2015-12-04 12:46:19 [-0600]:
>>
>>> The backtrace might be OK (maybe slightly overkill), but all the
>>> stack addresses are certainly irrelevant and distracting.  We only
>>> need enough to recognize the problem.  I don't think the modules list
>>> is relevant either.
>>
>> I would shorten it to the bare minimum. Also the patch description
>> itself could be truncated to the required bits…
>>
>>>> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
>>>> index 8c36880..0415192 100644
>>>> --- a/drivers/pci/host/pci-dra7xx.c
>>>> +++ b/drivers/pci/host/pci-dra7xx.c
>>>> @@ -301,8 +301,19 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>>>>   		return -EINVAL;
>>>>   	}
>>>>
>>>> +	/*
>>>> +	 * Mark dra7xx_pcie_msi IRQ as IRQF_NO_THREAD
>>>> +	 * On -RT and if kernel is booting with "threadirqs" cmd line parameter
>>>> +	 * the dra7xx_pcie_msi_irq_handler() will be forced threaded but,
>>>> +	 * in the same time, it's IRQ dispatcher and calls generic_handle_irq(),
>>>> +	 * which, in turn, will be resolved to handle_simple_irq() call.
>>>> +	 * The handle_simple_irq() expected to be called with IRQ disabled, as
>>>> +	 * result kernle will display warning:
>>>> +	 * "irq XXX handler YYY+0x0/0x14 enabled interrupts".
>>>> +	 */
>>
>> …not to mention this piece. d7ce4377494a ("powerpc/fsl_msi: mark the msi
>> cascade handler IRQF_NO_THREAD") fixes the same bug in arch/ppc so they
>> bypassed you fixing it.
>>
>>>>   	ret = devm_request_irq(&pdev->dev, pp->irq,
>>>> -			       dra7xx_pcie_msi_irq_handler, IRQF_SHARED,
>>>> +			       dra7xx_pcie_msi_irq_handler,
>>>> +			       IRQF_SHARED | IRQF_NO_THREAD,
>>>>   			       "dra7-pcie-msi",	pp);
>>>
>>> There's similar code in exynos_add_pcie_port(), imx6_add_pcie_port(),
>>> and spear13xx_add_pcie_port().  Do they need similar changes?  If not,
>>> why not?
>>
>> You are right. The request for the handler exynos_pcie_msi_irq_handler(),
>> imx6_pcie_msi_handler() and spear13xx_pcie_irq_handler() needs same
>> treatment.
>> Additionally we have:
>>
>> arch/mips/pci/msi-octeon.c: if (request_irq(OCTEON_IRQ_PCI_MSI0, octeon_msi_interrupt0,
>> arch/sparc/kernel/pci_msi.c:    err = request_irq(irq, sparc64_msiq_interrupt, 0,
>> drivers/pci/host/pci-tegra.c:   err = request_irq(msi->irq, tegra_pcie_msi_irq, 0,
>> drivers/pci/host/pcie-rcar.c:   err = devm_request_irq(&pdev->dev, msi->irq1, rcar_pcie_msi_irq,
>> drivers/pci/host/pcie-rcar.c:   err = devm_request_irq(&pdev->dev, msi->irq2, rcar_pcie_msi_irq,
>> drivers/pci/host/pcie-xilinx.c: err = devm_request_irq(dev, port->irq, xilinx_pcie_intr_handler,
>>
>> which require the same kind of fix…
>>
>>> I see your discussion about DRA7 hardware design, but my impression is
>>> that this problem affects anybody who calls dw_handle_msi_irq() from a
>>> handler registered with IRQF_SHARED.
>>
>> … brecause all of them invoke generic_handle_irq() from the requsted
>> handler. generic_handle_irq grabs raw_locks and this needs to run in
>> raw-irq context.
>> IRQF_SHARED could probably go away. The IRQ is mostlikely exclusive
>> assigned in each SoC for MSI interrupt demux.
>
> It sounds like we should fix all these places at once.  If you
> (Grygorii) work up a patch that does them all, with a more generic
> changelog, then we can solicit testing and acks.

Sure, will do:
- change will be applied for files listed in this thread only
- IRQF_SHARED will be left unchanged
- commit message will be made more generic
- i prefer to keep comment in code for dra7 as is.
Is it ok?


-- 
regards,
-grygorii
