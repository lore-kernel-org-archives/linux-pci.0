Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 3/3] PCI: Xilinx NWL PCIe: Fix Error for multi function
 device for legacy interrupts.
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "colin.king@canonical.com" <colin.king@canonical.com>,
 Soren Brinkmann <sorenb@xilinx.com>, Michal Simek <michals@xilinx.com>,
 "arnd@arndb.de" <arnd@arndb.de>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
 <1472553558-27215-3-git-send-email-bharatku@xilinx.com>
 <57C57975.7040306@arm.com>
 <8520D5D51A55D047800579B094147198258D239D@XAP-PVEXMBX01.xlnx.xilinx.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <57C59FE8.30307@arm.com>
Date: Tue, 30 Aug 2016 16:02:00 +0100
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198258D239D@XAP-PVEXMBX01.xlnx.xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Ravikiran Gummaluri <rgummal@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 30/08/16 15:13, Bharat Kumar Gogada wrote:
>> Hi Bharat,
>>> @@ -561,7 +561,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie
>> *pcie)
>>>     }
>>>
>>>     pcie->legacy_irq_domain = irq_domain_add_linear(legacy_intc_node,
>>> -                                                   INTX_NUM,
>>> +                                                   INTX_NUM + 1,
>>>                                                     &legacy_domain_ops,
>>>                                                     pcie);
>>
>> This feels like the wrong thing to do. You have INTX_NUM irqs, so the domain
>> allocation should reflect this. On the other hand, the way the driver currently
>> deals with mappings is quite broken (consistently adding 1 to the HW interrupt).
>>
> Hi Marc,
> 
> Without above change I get following crash in kernel while booting.
> 
> [    2.441684] error: hwirq 0x4 is too large for dummy
> 
> [    2.441694] ------------[ cut here ]------------
> 
> [    2.441698] WARNING: at kernel/irq/irqdomain.c:344
> 
> [    2.441702] Modules linked in:
> 
> [    2.441706]
> 
> [    2.441714] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.4.0 #8
> 
> [    2.441718] Hardware name: xlnx,zynqmp (DT)
> 
> [    2.441723] task: ffffffc071886b80 ti: ffffffc071888000 task.ti: ffffffc071888000
> 
> [    2.441732] PC is at irq_domain_associate+0x138/0x1c0
> 
> [    2.441738] LR is at irq_domain_associate+0x138/0x1c0
> 
> In kernel/irq/irqdomain.c function irq_domain_associate
> 
> if (WARN(hwirq >= domain->hwirq_max,
>                  "error: hwirq 0x%x is too large for %s\n", (int)hwirq, domain->name))
>                 return -EINVAL;
> 
> Here the hwirq and hwirq_max are equal to 4 without the above condition (INTX_NUM + 1) due to which crash is coming.
> This is happening as the legacy interrupts are starting from 1 (INTA).

I understood that. I'm still persisting in saying that you have the
wrong fix.

Your domain should always allocate many interrupts as you have interrupt
sources. These interrupts (hwirq) should be numbered from 0 to (n-1).

> And I'm  consistently adding 1 to the HW interrupt as in
> nwl_pcie_leg_handler I get 0th bit set from MSGF_LEG_STATUS if INTA
> interrupt is raised but my hwirq number being mapped for INTA is 0x1
> so that's I'm adding 1 to obtain correct virtual irq. Same case in
> nwl_pcie_free_irq_domain since hwirq starts from one I'm adding 1 to
> obtain virtual irq and free it.

I can see that. Nonetheless, this is wrong. Can you please test the
patch I provided in my reply and report what happens?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
