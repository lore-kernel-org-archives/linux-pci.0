Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: dra7xx: mark dra7xx_pcie_msi irq as
 IRQF_NO_THREAD
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1448027966-21610-1-git-send-email-grygorii.strashko@ti.com>
 <20151204184619.GD20125@localhost>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>, <tony@atomide.com>,
	<nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <5662042A.3090809@ti.com>
Date: Fri, 4 Dec 2015 23:22:50 +0200
MIME-Version: 1.0
In-Reply-To: <20151204184619.GD20125@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/04/2015 08:46 PM, Bjorn Helgaas wrote:
> Hi Grygorii,
> 
> On Fri, Nov 20, 2015 at 03:59:26PM +0200, Grygorii Strashko wrote:
>> On -RT, TI DRA7 PCIe driver always produces below backtrace when the
>> first PCI interrupt is triggered:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_percpu+0x14c/0x174()
>> irq 460 handler irq_default_primary_handler+0x0/0x14 enabled interrupts
[...]
>> [<c00891b0>] (handle_simple_irq) from [<c0085514>] (generic_handle_irq+0x30/0x44)
>>   r5:ee4a9020 r4:000001cc
>> [<c00854e4>] (generic_handle_irq) from [<c034a7d4>] (dra7xx_pcie_msi_irq_handler+0x7c/0x8c)
>>   r5:ee4a9020 r4:00000001
>> [<c034a758>] (dra7xx_pcie_msi_irq_handler) from [<c0086f08>] (irq_forced_thread_fn+0x28/0x5c)
>>   r5:ee1d0900 r4:ee4b59c0
>> [<c0086ee0>] (irq_forced_thread_fn) from [<c00871dc>] (irq_thread+0x128/0x204)
>>   r7:00000001 r6:00000000 r5:ee4d2000 r4:ee4b59e4
>> [<c00870b4>] (irq_thread) from [<c005e2fc>] (kthread+0xd4/0xec)
>>   r10:00000000 r9:00000000 r8:00000000 r7:c00870b4 r6:ee4b59c0 r5:ee4b5a00
>>   r4:00000000
>> [<c005e228>] (kthread) from [<c000faa8>] (ret_from_fork+0x14/0x2c)
>>   r7:00000000 r6:00000000 r5:c005e228 r4:ee4b5a00
>> ---[ end trace 0000000000000002 ]---
> 
> The backtrace might be OK (maybe slightly overkill), but all the
> stack addresses are certainly irrelevant and distracting.  We only
> need enough to recognize the problem.  I don't think the modules list
> is relevant either.

I'll take this into account. Is this blocker for this patch now?

> 
>> This backtrace is triggered because dra7xx_pcie_msi_irq_handler()
>> forced to be threaded by default on -RT but, in the same time, it's
>> IRQ dispatcher and calls generic_handle_irq(), which leads to
>> handle_simple_irq() call. The handle_simple_irq() expected to be
>> called with IRQ disabled.
>>
>> The same issue will also happen if kernel will boot with "threadirqs"
>> cmdline parameter (CONFIG_IRQ_FORCED_THREADING).
>>
>> As discussed in [1], the current DRA7 PCIe hw configuration supports
>> 32 interrupts, which cannot change because it's hardwired in silicon,
>> this is a single status read and assuming that only a few (most of the
>> time it will be exactly ONE) of those interrupts are pending at the
>> same time is pretty much a sane assumption. And recommended fix for
>> this issue is to request dra7xx_pcie_msi IRQ with IRQF_NO_THREAD flag.
>>
>> [1] https://lkml.org/lkml/2015/11/3/660
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>> Changes in v2:
>> - comment in code truncated
>> Link on v1:
>>   https://lkml.org/lkml/2015/11/5/593
>>   drivers/pci/host/pci-dra7xx.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
>> index 8c36880..0415192 100644
>> --- a/drivers/pci/host/pci-dra7xx.c
>> +++ b/drivers/pci/host/pci-dra7xx.c
>> @@ -301,8 +301,19 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>>   		return -EINVAL;
>>   	}
>>   
>> +	/*
>> +	 * Mark dra7xx_pcie_msi IRQ as IRQF_NO_THREAD
>> +	 * On -RT and if kernel is booting with "threadirqs" cmd line parameter
>> +	 * the dra7xx_pcie_msi_irq_handler() will be forced threaded but,
>> +	 * in the same time, it's IRQ dispatcher and calls generic_handle_irq(),
>> +	 * which, in turn, will be resolved to handle_simple_irq() call.
>> +	 * The handle_simple_irq() expected to be called with IRQ disabled, as
>> +	 * result kernle will display warning:
>> +	 * "irq XXX handler YYY+0x0/0x14 enabled interrupts".
>> +	 */
>>   	ret = devm_request_irq(&pdev->dev, pp->irq,
>> -			       dra7xx_pcie_msi_irq_handler, IRQF_SHARED,
>> +			       dra7xx_pcie_msi_irq_handler,
>> +			       IRQF_SHARED | IRQF_NO_THREAD,
>>   			       "dra7-pcie-msi",	pp);
> 
> There's similar code in exynos_add_pcie_port(), imx6_add_pcie_port(),
> and spear13xx_add_pcie_port().  Do they need similar changes?  If not,
> why not?
> 
> I see your discussion about DRA7 hardware design, but my impression is
> that this problem affects anybody who calls dw_handle_msi_irq() from a
> handler registered with IRQF_SHARED.

Issue fixed by this patch is not related to IRQF_SHARED. 
It will happen on -RT or if kernel will boot with "threadirqs" cmd line parameter
- in both cases these PCI IRQ handlers will be forced to be threaded and,
as result, generic_handle_irq() will produce above backtrace.

Personally, I don't have strong opinion about "should similar change be applied
to other PCI drivers or not?" And I think, that owners of those driver should
make such decision.

-- 
regards,
-grygorii
