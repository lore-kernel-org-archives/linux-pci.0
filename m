Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40294 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbeC0KmR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Mar 2018 06:42:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id x4so8434003wmh.5
        for <linux-pci@vger.kernel.org>; Tue, 27 Mar 2018 03:42:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d1be2791-ff95-5b14-8171-9714d66f28bb@arm.com>
References: <1519734051-32298-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <20180314175710.GE27868@e107981-ln.cambridge.arm.com> <CAFZiPx1bPp17aS40uUF48zt+cwqZDM3kO3rSPYng-n2-Nz6nJg@mail.gmail.com>
 <d1be2791-ff95-5b14-8171-9714d66f28bb@arm.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 27 Mar 2018 16:12:15 +0530
Message-ID: <CAFZiPx1zTAgaH3xvpNqMKHg7X0b2VK2W2nMabwRnPudRAOBe2g@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PCI: mobiveil: Add MSI support for Mobiveil PCIe
 Host Bridge IP driver
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Peter W Newton <peter.newton@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 27, 2018 at 2:39 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 27/03/18 09:38, Subrahmanya Lingappa wrote:
>> Lorenzo,
>>
>> On Wed, Mar 14, 2018 at 11:27 PM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>>> On Tue, Feb 27, 2018 at 07:20:51AM -0500, Subrahmanya Lingappa wrote:
>>>>  Adds MSI support for Mobiveil PCIe Host Bridge IP driver
>>>
>>> "Implement MSI support for Mobiveil PCIe Host Bridge IP device
>>> driver".
>>>
>>>> Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> Cc: linux-pci@vger.kernel.org
>>>> ---
>>>> Fixes:
>>>> - used relaxed device access apis
>>>> - removed memory allocation of kernel buffer for MSI data, using the
>>>>   MSI register base instead.
>>>> - removed redundant CONFIG_PCI_MSI checks
>>>> ---
>>>>  drivers/pci/host/pcie-mobiveil.c | 204 ++++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 202 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/host/pcie-mobiveil.c b/drivers/pci/host/pcie-mobiveil.c
>>>> index 4270387..4b92dc0 100644
>>>> --- a/drivers/pci/host/pcie-mobiveil.c
>>>> +++ b/drivers/pci/host/pcie-mobiveil.c
>>>> @@ -14,6 +14,7 @@
>>>>  #include <linux/irqdomain.h>
>>>>  #include <linux/kernel.h>
>>>>  #include <linux/module.h>
>>>> +#include <linux/msi.h>
>>>>  #include <linux/of_address.h>
>>>>  #include <linux/of_irq.h>
>>>>  #include <linux/of_platform.h>
>>>> @@ -56,6 +57,7 @@
>>>>  #define PAB_INTP_AMBA_MISC_ENB       0x0b0c
>>>>  #define PAB_INTP_AMBA_MISC_STAT      0x0b1c
>>>>  #define  PAB_INTP_INTX_MASK  0x1e0
>>>> +#define  PAB_INTP_MSI_MASK      0x8
>>>                              ^^^^^^
>>>
>>> Must be a tab.
>>>
>>>>  #define PAB_AXI_AMAP_CTRL(win)       PAB_REG_ADDR(0x0ba0, win)
>>>>  #define  WIN_ENABLE_SHIFT    0
>>>> @@ -85,8 +87,19 @@
>>>>
>>>>  /* supported number of interrupts */
>>>>  #define PCI_NUM_INTX    4
>>>> +#define PCI_NUM_MSI          16
>>>>  #define PAB_INTA_POS    5
>>>>
>>>> +/* MSI registers */
>>>> +#define MSI_BASE_LO_OFFSET   0x04
>>>> +#define MSI_BASE_HI_OFFSET   0x08
>>>> +#define MSI_SIZE_OFFSET              0x0c
>>>> +#define MSI_ENABLE_OFFSET    0x14
>>>> +#define MSI_STATUS_OFFSET    0x18
>>>> +#define MSI_DATA_OFFSET              0x20
>>>> +#define MSI_ADDR_L_OFFSET    0x24
>>>> +#define MSI_ADDR_H_OFFSET    0x28
>>>> +
>>>>  /* outbound and inbound window definitions */
>>>>  #define WIN_NUM_0            0
>>>>  #define WIN_NUM_1            1
>>>> @@ -101,11 +114,21 @@
>>>>  #define LINK_WAIT_MIN                90000
>>>>  #define LINK_WAIT_MAX                100000
>>>>
>>>> +struct mobiveil_msi {                        /* MSI information */
>>>> +     struct mutex lock;              /* protect bitmap variable */
>>>> +     struct irq_domain *msi_domain;
>>>> +     struct irq_domain *dev_domain;
>>>> +     phys_addr_t msi_pages_phys;
>>>> +     int num_of_vectors;
>>>> +     DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
>>>> +};
>>>> +
>>>>  struct mobiveil_pcie {
>>>>       struct platform_device *pdev;
>>>>       struct list_head resources;
>>>>       void __iomem *config_axi_slave_base;    /* endpoint config base */
>>>>       void __iomem *csr_axi_slave_base;   /* root port config base */
>>>> +     void __iomem *apb_csr_base;     /* MSI register base */
>>>>       void __iomem *pcie_reg_base;    /* Physical PCIe Controller Base */
>>>>       struct irq_domain *intx_domain;
>>>>       raw_spinlock_t intx_mask_lock;
>>>> @@ -116,6 +139,7 @@ struct mobiveil_pcie {
>>>>       int ib_wins_configured; /*  configured inbound windows */
>>>>       struct resource *ob_io_res;
>>>>       char root_bus_nr;
>>>> +     struct mobiveil_msi msi;
>>>>  };
>>>>
>>>>  static inline void csr_writel(struct mobiveil_pcie *pcie, const u32 value,
>>>> @@ -204,6 +228,9 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>>>>       struct irq_chip *chip = irq_desc_get_chip(desc);
>>>>       struct mobiveil_pcie *pcie = irq_desc_get_handler_data(desc);
>>>>       struct device *dev = &pcie->pdev->dev;
>>>> +     struct mobiveil_msi *msi = &pcie->msi;
>>>> +     u32 msi_data, msi_addr_lo, msi_addr_hi;
>>>> +     u32 intr_status, msi_status;
>>>>       unsigned long shifted_status;
>>>>       u32 bit, virq;
>>>>       u32 val, mask;
>>>> @@ -222,8 +249,8 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>>>>
>>>>       /* Handle INTx */
>>>>       if (intr_status & PAB_INTP_INTX_MASK) {
>>>> -             shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT) >>
>>>> -                     PAB_INTA_POS;
>>>> +             shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT)
>>>> +                     >> PAB_INTA_POS;
>>>>               do {
>>>>                       for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
>>>>                               virq = irq_find_mapping(pcie->intx_domain,
>>>> @@ -241,6 +268,39 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>>>>               } while ((shifted_status >>  PAB_INTA_POS) != 0);
>>>>       }
>>>>
>>>> +     /* read extra MSI status register */
>>>> +     msi_status = readl_relaxed(pcie->apb_csr_base + MSI_STATUS_OFFSET);
>>>> +
>>>> +     /* handle MSI interrupts */
>>>> +     if ((intr_status & PAB_INTP_MSI_MASK) || (msi_status & 1)) {
>>>
>>> It is not clear to me why you need the intr_status state given that
>>> below you loop by just reading msi_status. Using intr_status for
>>> MSIs seems redundant.
>>>
>>>> +             do {
>>>> +                     msi_data = readl_relaxed(pcie->apb_csr_base
>>>> +                                     + MSI_DATA_OFFSET);
>>>> +
>>>> +                     /*
>>>> +                      * MSI_STATUS_OFFSET gets updated to zero once we have
>>>> +                      * popped not only the data but also address from MSI
>>>> +                      * hardware FIFO.so keeping these following two dummy
>>>> +                      * reads.
>>>> +                      */
>>>
>>> Nit: Please reformat and capitalize properly this comment.
>>>
>>>> +                     msi_addr_lo = readl_relaxed(pcie->apb_csr_base +
>>>> +                                     MSI_ADDR_L_OFFSET);
>>>> +                     msi_addr_hi = readl_relaxed(pcie->apb_csr_base +
>>>> +                                     MSI_ADDR_H_OFFSET);
>>>> +                     dev_dbg(dev,
>>>> +                             "MSI registers, data: %08x, addr: %08x:%08x\n",
>>>> +                             msi_data, msi_addr_hi, msi_addr_lo);
>>>> +
>>>> +                             virq = irq_find_mapping(msi->dev_domain,
>>>> +                                     msi_data);
>>>> +                             if (virq)
>>>> +                                     generic_handle_irq(virq);
>>>> +
>>>> +                     msi_status = readl_relaxed(pcie->apb_csr_base +
>>>> +                                     MSI_STATUS_OFFSET);
>>>> +             } while (msi_status & 1);
>>>> +     }
>>>> +
>>>>       /* Clear the interrupt status */
>>>>       csr_writel(pcie, intr_status, PAB_INTP_AMBA_MISC_STAT);
>>>>       chained_irq_exit(chip, desc);
>>>> @@ -276,6 +336,12 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>>>>               return PTR_ERR(pcie->csr_axi_slave_base);
>>>>       pcie->pcie_reg_base = res->start;
>>>>
>>>> +     /* map MSI config resource */
>>>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
>>>> +     pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
>>>> +     if (IS_ERR(pcie->apb_csr_base))
>>>> +             return PTR_ERR(pcie->apb_csr_base);
>>>> +
>>>>       /* read the number of windows requested */
>>>>       if (of_property_read_u32(node, "apio-wins", &pcie->apio_wins))
>>>>               pcie->apio_wins = MAX_PIO_WINDOWS;
>>>> @@ -431,6 +497,22 @@ static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
>>>>       return -ETIMEDOUT;
>>>>  }
>>>>
>>>> +static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
>>>> +{
>>>> +     phys_addr_t msg_addr = pcie->pcie_reg_base;
>>>> +     struct mobiveil_msi *msi = &pcie->msi;
>>>> +
>>>> +     pcie->msi.num_of_vectors = PCI_NUM_MSI;
>>>> +     msi->msi_pages_phys = (phys_addr_t)msg_addr;
>>>> +
>>>> +     writel_relaxed(lower_32_bits(msg_addr),
>>>> +             pcie->apb_csr_base + MSI_BASE_LO_OFFSET);
>>>> +     writel_relaxed(upper_32_bits(msg_addr),
>>>> +             pcie->apb_csr_base + MSI_BASE_HI_OFFSET);
>>>> +     writel_relaxed(4096, pcie->apb_csr_base + MSI_SIZE_OFFSET);
>>>> +     writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
>>>> +}
>>>> +
>>>>  static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>>>>  {
>>>>       u32 value;
>>>> @@ -501,6 +583,9 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>>>>               }
>>>>       }
>>>>
>>>> +     /* setup MSI hardware registers */
>>>> +     mobiveil_pcie_enable_msi(pcie);
>>>> +
>>>>       return err;
>>>>  }
>>>>
>>>> @@ -559,6 +644,116 @@ static int mobiveil_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>>>>       .xlate = pci_irqd_intx_xlate,
>>>>  };
>>>>
>>>> +static struct irq_chip mobiveil_msi_irq_chip = {
>>>> +     .name = "Mobiveil PCIe MSI",
>>>> +     .irq_mask = pci_msi_mask_irq,
>>>> +     .irq_unmask = pci_msi_unmask_irq,
>>>> +};
>>>> +
>>>> +static struct msi_domain_info mobiveil_msi_domain_info = {
>>>> +     .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>>>> +                     MSI_FLAG_PCI_MSIX),
>>>
>>> What about MSI_FLAG_PCI_MULTI_MSI ?
>> This hardware does support multi-MSI, we'll add that flag and test it.
>>
>>>
>>>> +     .chip   = &mobiveil_msi_irq_chip,
>>>> +};
>>>> +
>>>> +static void mobiveil_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>>> +{
>>>> +     struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(data);
>>>> +     phys_addr_t addr = pcie->pcie_reg_base + (data->hwirq * sizeof(int));
>>>> +
>>>> +     msg->address_lo = lower_32_bits(addr);
>>>> +     msg->address_hi = upper_32_bits(addr);
>>>> +     msg->data = data->hwirq;
>>>> +
>>>> +     dev_dbg(&pcie->pdev->dev, "msi#%d address_hi %#x address_lo %#x\n",
>>>> +             (int)data->hwirq, msg->address_hi, msg->address_lo);
>>>> +}
>>>> +
>>>> +static int mobiveil_msi_set_affinity(struct irq_data *irq_data,
>>>> +             const struct cpumask *mask, bool force)
>>>> +{
>>>> +     return -EINVAL;
>>>> +}
>>>> +
>>>> +static struct irq_chip mobiveil_msi_bottom_irq_chip = {
>>>> +     .name                   = "Mobiveil MSI",
>>>> +     .irq_compose_msi_msg    = mobiveil_compose_msi_msg,
>>>> +     .irq_set_affinity       = mobiveil_msi_set_affinity,
>>>> +};
>>>> +
>>>> +static int mobiveil_irq_msi_domain_alloc(struct irq_domain *domain,
>>>> +             unsigned int virq, unsigned int nr_irqs, void *args)
>>>> +{
>>>> +     struct mobiveil_pcie *pcie = domain->host_data;
>>>> +     struct mobiveil_msi *msi = &pcie->msi;
>>>> +     unsigned long bit;
>>>> +
>>>> +     WARN_ON(nr_irqs != 1);
>>>> +     mutex_lock(&msi->lock);
>>>> +
>>>> +     bit = find_first_zero_bit(msi->msi_irq_in_use, msi->num_of_vectors);
>>>> +     if (bit >= msi->num_of_vectors) {
>>>> +             mutex_unlock(&msi->lock);
>>>> +             return -ENOSPC;
>>>> +     }
>>>> +
>>>> +     set_bit(bit, msi->msi_irq_in_use);
>>>> +
>>>> +     mutex_unlock(&msi->lock);
>>>> +
>>>> +     irq_domain_set_info(domain, virq, bit, &mobiveil_msi_bottom_irq_chip,
>>>> +                             domain->host_data, handle_simple_irq,
>>>
>>> This is conceptually wrong, handle_simple_irq() is not the right flow
>>> handler for MSIs that are edge by definition (ie it is a memory write).
>>>
>>> Furthermore, handle_simple_irq() does not handle acking and masking, which
>>> means that the current code is buggy (and INTX handling is buggy too,
>>> by the way).
>>>
>>> You need handle_edge_irq() here as a flow handler.
>>>
>> in our hardware case, INTX and MSI interrupts are provided to the
>> processor core as a level interrupt, tested with handle_level_irq()
>> successfully, as expected handle_edge_irq() crashes.
>
> This hardly makes any sense. An MSI is a write from a device to the MSI
> controller. There is no extra write to indicate that the interrupt has
> been retired. So how can that be a level interrupt?
>

PCIe host hardware retires the interrupt as soon as ISR empties the
last entry in the MSI FIFO.

> You say that handle_edge_irq() crashes. How?
>
panics with following crash log:
[  107.358756] [00000000] *pgd=0000000b7fffe003[  107.363004] ,
*pud=0000000b7fffe003
, *pmd=0000000000000000[  107.368470]
[  107.369954] Internal error: Oops: 86000005 [#1] SMP
[  107.374815] Modules linked in: r8169 pcie_mobiveil(O) uio_pdrv_genirq
[  107.381239] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O
4.9.0-xilinx-v2017.2 #1
[  107.389577] Hardware name: xlnx,zynqmp (DT)
[  107.393737] task: ffffff8008c90880 task.stack: ffffff8008c80000
[  107.399642] PC is at 0x0
[  107.402162] LR is at handle_edge_irq+0x104/0x1a8
[  107.406758] pc : [<0000000000000000>] lr : [<ffffff80080df014>]
pstate: 000001c5
[  107.414141] sp : ffffffcb7ff81f30
[  107.417432] x29: ffffffcb7ff81f30 x28: ffffffcb5827f018
[  107.422726] x27: ffffff800094b000 x26: ffffff800094b800
[  107.428020] x25: ffffff800094a4e8 x24: ffffff800094a4d8
[  107.433315] x23: ffffff8008c897c0 x22: ffffffcb6f872410
[  107.438610] x21: 0000000000000000 x20: ffffffcb57dadc20
[  107.443905] x19: ffffffcb57dadc00 x18: 0000000000040900
[  107.449200] x17: 0000007f8d1be010 x16: 0000000000000000
[  107.454495] x15: ffffffbf27b598f8 x14: 0000000000000001
[  107.459789] x13: 0000000000002ccd x12: 0000000000004e16
[  107.465084] x11: 0000000000000040 x10: ffffffcb5d5864a8
[  107.470379] x9 : ffffffcb5d586568 x8 : 0000000000000000
[  107.475674] x7 : ffffffcb57dadc00 x6 : ffffffcb57dadc00
[  107.480969] x5 : 0000004b7732f000 x4 : ffffffcb57dadc00
[  107.486264] x3 : 0000004b7732f000 x2 : 00000000000008ef
[  107.491558] x1 : 0000000000000000 x0 : ffffffcb57dadc20
[  107.496853]
[  107.498331] Process swapper/0 (pid: 0, stack limit = 0xffffff8008c80020)
[  107.505017] Stack: (0xffffffcb7ff81f30 to 0xffffff8008c84000)
[  107.510744] Call trace:
[  107.513175] Exception stack(0xffffffcb7ff81d60 to 0xffffffcb7ff81e90)
[  107.519601] 1d60: ffffffcb57dadc00 0000008000000000
ffffffcb7ff81f30 0000000000000000
[  107.527418] 1d80: 0000000000000001 ffffffcb7ff81ecc
ffffffcb7ff82b38 000000007ff81edc
[  107.535231] 1da0: 0000000000000000 ffffffcb7002f300
ffffff8008c59a00 ffffff8008c59a00
[  107.543043] 1dc0: 0000000000000000 ffffff80080c3608
ffffffcb7ff88a00 ffffffcb7002f300
[  107.550855] 1de0: 0000000000000000 0000000000000000
ffffffcb7ff88a00 ffffffcb700e5b98
[  107.558667] 1e00: ffffffcb57dadc20 0000000000000000
00000000000008ef 0000004b7732f000
[  107.566479] 1e20: ffffffcb57dadc00 0000004b7732f000
ffffffcb57dadc00 ffffffcb57dadc00
[  107.574291] 1e40: 0000000000000000 ffffffcb5d586568
ffffffcb5d5864a8 0000000000000040
[  107.582103] 1e60: 0000000000004e16 0000000000002ccd
0000000000000001 ffffffbf27b598f8
[  107.589914] 1e80: 0000000000000000 0000007f8d1be010
[  107.594768] [<          (null)>]           (null)
[  107.599458] [<ffffff80080da774>] generic_handle_irq+0x24/0x38
[  107.605192] [<ffffff800094819c>] mobiveil_pcie_isr+0x19c/0x3e0
[pcie_mobiveil]
[  107.612396] [<ffffff80080da774>] generic_handle_irq+0x24/0x38
[  107.618119] [<ffffff80080dadec>] __handle_domain_irq+0x5c/0xb8
[  107.623936] [<ffffff80080814cc>] gic_handle_irq+0x64/0xc0
[  107.629315] Exception stack(0xffffff8008c83da0 to 0xffffff8008c83ed0)
[  107.635740] 3da0: 0000000000000000 ffffffcb7ff88a00
0000004b7732f000 00000000007a4e78
[  107.643558] 3dc0: 0000000000000016 00ffffffffffffff
00000000339a1326 0000000000000f97
[  107.651370] 3de0: ffffffcb7ff8794c 0000000000000bdf
ffffffcb7ff8792c 071c71c71c71c71c
[  107.659182] 3e00: 0000000000004e16 0000000000002ccd
0000000000000001 ffffffbf27b598f8
[  107.666994] 3e20: 0000000000000000 0000007f8d1be010
0000000000040900 00000018fdaaacc5
[  107.674806] 3e40: 0000000000000000 ffffffcb57f18000
0000000000000000 ffffff8008cf5a78
[  107.682619] 3e60: 00000018fcb6c6ff ffffff8008c58770
ffffff8008c9e59a ffffff8008c87000
[  107.690430] 3e80: ffffff8008c87000 ffffff8008c83ed0
ffffff80086a3b10 ffffff8008c83ed0
[  107.698243] 3ea0: ffffff80086a3b14 0000000060000145
ffffffcb57f18000 0000000000000000
[  107.706054] 3ec0: ffffffffffffffff 00000018fcb6c6ff
[  107.710909] [<ffffff80080827b0>] el1_irq+0xb0/0x140
[  107.715771] [<ffffff80086a3b14>] cpuidle_enter_state+0x154/0x218
[  107.721759] [<ffffff80086a3c10>] cpuidle_enter+0x18/0x20
[  107.727055] [<ffffff80080d1818>] call_cpuidle+0x18/0x30
[  107.732262] [<ffffff80080d1a88>] cpu_startup_entry+0x188/0x1d8
[  107.738080] [<ffffff8008928c9c>] rest_init+0x6c/0x78
[  107.743026] [<ffffff8008c00b40>] start_kernel+0x378/0x38c
[  107.748407] [<ffffff8008c001e0>] __primary_switched+0x5c/0x64
[  107.754137] Code: bad PC value
[  107.757189] ---[ end trace c796721eadf25175 ]---
[  107.761776] Kernel panic - not syncing: Fatal exception in interrupt
[  107.768110] SMP: stopping secondary CPUs
[  107.772016] Kernel Offset: disabled
[  107.775486] Memory Limit: none
[  107.778526] ---[ end Kernel panic - not syncing: Fatal exception in interrupt

> Note that there are two interrupts involved in your case: The MSI
> itself, and the interrupt that signals the arrival of an MSI to the CPU.
> The former is edge-triggered *by definition*, but I'm perfectly prepared
> to understand that the second level interrupt is level (that's often the
> case).
>
Yes, so that second level one is level interrupt, our hardware
engineer confirmed too.

>> is it OK to change this handle_simple_irq() into handle_level_irq() in
>> next version of patch ?
>
> I think we need to get to the bottom of the above first.
>
>> irq_chip in msi_domain_info set already has pci_msi_mask_irq and
>> pci_msi_unmask_irq; with handle_level_irq() in place is it not
>> sufficient ?
>
> pci_msi_mask_irq() works at the device level. There is no guarantee that
> you can mask individual interrupts there (think multi-MSI, for example).
>
most of the pci/host/pcie-*.c drivers are using pci_msi_un/mask_irq(),
which would result in to pci_write_config_dword() of MSI config
register.
could you please point me to a specific example of other type of implementation?

> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

Thanks.
