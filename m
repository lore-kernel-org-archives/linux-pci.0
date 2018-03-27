Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbeC0Ky3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Mar 2018 06:54:29 -0400
Subject: Re: [PATCH v6 3/3] PCI: mobiveil: Add MSI support for Mobiveil PCIe
 Host Bridge IP driver
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Peter W Newton <peter.newton@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>
References: <1519734051-32298-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <20180314175710.GE27868@e107981-ln.cambridge.arm.com>
 <CAFZiPx1bPp17aS40uUF48zt+cwqZDM3kO3rSPYng-n2-Nz6nJg@mail.gmail.com>
 <d1be2791-ff95-5b14-8171-9714d66f28bb@arm.com>
 <CAFZiPx1zTAgaH3xvpNqMKHg7X0b2VK2W2nMabwRnPudRAOBe2g@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <6da2d16d-a797-0733-a49b-426e41ba6623@arm.com>
Date: Tue, 27 Mar 2018 11:54:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAFZiPx1zTAgaH3xvpNqMKHg7X0b2VK2W2nMabwRnPudRAOBe2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27/03/18 11:42, Subrahmanya Lingappa wrote:
> On Tue, Mar 27, 2018 at 2:39 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 27/03/18 09:38, Subrahmanya Lingappa wrote:
>>> Lorenzo,
>>>
>>> On Wed, Mar 14, 2018 at 11:27 PM, Lorenzo Pieralisi
>>> <lorenzo.pieralisi@arm.com> wrote:

[...]

>>>>> +     irq_domain_set_info(domain, virq, bit, &mobiveil_msi_bottom_irq_chip,
>>>>> +                             domain->host_data, handle_simple_irq,
>>>>
>>>> This is conceptually wrong, handle_simple_irq() is not the right flow
>>>> handler for MSIs that are edge by definition (ie it is a memory write).
>>>>
>>>> Furthermore, handle_simple_irq() does not handle acking and masking, which
>>>> means that the current code is buggy (and INTX handling is buggy too,
>>>> by the way).
>>>>
>>>> You need handle_edge_irq() here as a flow handler.
>>>>
>>> in our hardware case, INTX and MSI interrupts are provided to the
>>> processor core as a level interrupt, tested with handle_level_irq()
>>> successfully, as expected handle_edge_irq() crashes.
>>
>> This hardly makes any sense. An MSI is a write from a device to the MSI
>> controller. There is no extra write to indicate that the interrupt has
>> been retired. So how can that be a level interrupt?
>>
> 
> PCIe host hardware retires the interrupt as soon as ISR empties the
> last entry in the MSI FIFO.

And that interrupt is *not* an MSI.

> 
>> You say that handle_edge_irq() crashes. How?
>>
> panics with following crash log:
> [  107.358756] [00000000] *pgd=0000000b7fffe003[  107.363004] ,
> *pud=0000000b7fffe003
> , *pmd=0000000000000000[  107.368470]
> [  107.369954] Internal error: Oops: 86000005 [#1] SMP
> [  107.374815] Modules linked in: r8169 pcie_mobiveil(O) uio_pdrv_genirq
> [  107.381239] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O
> 4.9.0-xilinx-v2017.2 #1
> [  107.389577] Hardware name: xlnx,zynqmp (DT)
> [  107.393737] task: ffffff8008c90880 task.stack: ffffff8008c80000
> [  107.399642] PC is at 0x0
> [  107.402162] LR is at handle_edge_irq+0x104/0x1a8

Well, you're obviously missing an irqchip callback here. Debug time.

[...]

>> Note that there are two interrupts involved in your case: The MSI
>> itself, and the interrupt that signals the arrival of an MSI to the CPU.
>> The former is edge-triggered *by definition*, but I'm perfectly prepared
>> to understand that the second level interrupt is level (that's often the
>> case).
>>
> Yes, so that second level one is level interrupt, our hardware
> engineer confirmed too.

But the interrupt you're messing with in mobiveil_irq_msi_domain_alloc
is not that secondary interrupt, is it? It is an MSI, not the one coming
from the PCIe RC.

> 
>>> is it OK to change this handle_simple_irq() into handle_level_irq() in
>>> next version of patch ?
>>
>> I think we need to get to the bottom of the above first.
>>
>>> irq_chip in msi_domain_info set already has pci_msi_mask_irq and
>>> pci_msi_unmask_irq; with handle_level_irq() in place is it not
>>> sufficient ?
>>
>> pci_msi_mask_irq() works at the device level. There is no guarantee that
>> you can mask individual interrupts there (think multi-MSI, for example).
>>
> most of the pci/host/pcie-*.c drivers are using pci_msi_un/mask_irq(),
> which would result in to pci_write_config_dword() of MSI config
> register.
> could you please point me to a specific example of other type of implementation?
Not from the top of my head. You should have a way to mask a given MSI
at the MSI controller level.

	M.
-- 
Jazz is not dead. It just smells funny...
