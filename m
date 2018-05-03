Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40147 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbeECFiM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2018 01:38:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id j5so28040764wme.5
        for <linux-pci@vger.kernel.org>; Wed, 02 May 2018 22:38:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180502112859.GA4871@e107981-ln.cambridge.arm.com>
References: <1525063223-8705-1-git-send-email-l.subrahmanya@mobiveil.co.in> <20180502112859.GA4871@e107981-ln.cambridge.arm.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Thu, 3 May 2018 11:08:09 +0530
Message-ID: <CAFZiPx10qZagZLmtC1J7wUbb=TEm=Qh_c1is5WUb5VSDExm5_g@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] PCI: mobiveil: Add MSI support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Peter W Newton <peter.newton@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lorenzo,

On Wed, May 2, 2018 at 8:20 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Apr 30, 2018 at 12:40:23AM -0400, Subrahmanya Lingappa wrote:
> > Implement MSI support for Mobiveil PCIe Host Bridge IP device driver.
> >
> > Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: linux-pci@vger.kernel.org
> > ---
> >  drivers/pci/host/pcie-mobiveil.c | 207 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 203 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-mobiveil.c b/drivers/pci/host/pcie-mobiveil.c
> > index 02b1f5d..2470095 100644
> > --- a/drivers/pci/host/pcie-mobiveil.c
> > +++ b/drivers/pci/host/pcie-mobiveil.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/irqdomain.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/msi.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> > @@ -56,6 +57,7 @@
> >  #define PAB_INTP_AMBA_MISC_ENB       0x0b0c
> >  #define PAB_INTP_AMBA_MISC_STAT      0x0b1c
> >  #define  PAB_INTP_INTX_MASK  0x1e0
> > +#define  PAB_INTP_MSI_MASK   0x8
> >
> >  #define PAB_AXI_AMAP_CTRL(win)       PAB_REG_ADDR(0x0ba0, win)
> >  #define  WIN_ENABLE_SHIFT    0
> > @@ -85,6 +87,17 @@
> >
> >  /* supported number of interrupts */
> >  #define PAB_INTX_START               5
> > +#define PCI_NUM_MSI                  16
>
> 1 tab is enough.
>
> > +
> > +/* MSI registers */
> > +#define MSI_BASE_LO_OFFSET   0x04
> > +#define MSI_BASE_HI_OFFSET   0x08
> > +#define MSI_SIZE_OFFSET              0x0c
>
> Please make the tabs uniform (ie 1 tab).
>
> > +#define MSI_ENABLE_OFFSET    0x14
> > +#define MSI_STATUS_OFFSET    0x18
> > +#define MSI_DATA_OFFSET              0x20
>
> Ditto.
>
> > +#define MSI_ADDR_L_OFFSET    0x24
> > +#define MSI_ADDR_H_OFFSET    0x28
> >
> >  /* outbound and inbound window definitions */
> >  #define WIN_NUM_0            0
> > @@ -100,11 +113,21 @@
> >  #define LINK_WAIT_MIN                90000
> >  #define LINK_WAIT_MAX                100000
>
> Ditto.
>
> > +struct mobiveil_msi {                        /* MSI information */
> > +     struct mutex lock;              /* protect bitmap variable */
> > +     struct irq_domain *msi_domain;
> > +     struct irq_domain *dev_domain;
> > +     phys_addr_t msi_pages_phys;
> > +     int num_of_vectors;
> > +     DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
> > +};
> > +
> >  struct mobiveil_pcie {
> >       struct platform_device *pdev;
> >       struct list_head resources;
> >       void __iomem *config_axi_slave_base;    /* endpoint config base */
> >       void __iomem *csr_axi_slave_base;       /* root port config base */
> > +     void __iomem *apb_csr_base;     /* MSI register base */
> >       void __iomem *pcie_reg_base;    /* Physical PCIe Controller Base */
> >       struct irq_domain *intx_domain;
> >       raw_spinlock_t intx_mask_lock;
> > @@ -115,6 +138,7 @@ struct mobiveil_pcie {
> >       int ib_wins_configured;         /* configured inbound windows */
> >       struct resource *ob_io_res;
> >       char root_bus_nr;
> > +     struct mobiveil_msi msi;
> >  };
> >
> >  static inline void csr_writel(struct mobiveil_pcie *pcie, const u32 value,
> > @@ -194,13 +218,15 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
> >       struct irq_chip *chip = irq_desc_get_chip(desc);
> >       struct mobiveil_pcie *pcie = irq_desc_get_handler_data(desc);
> >       struct device *dev = &pcie->pdev->dev;
> > -     u32 intr_status;
> > +     struct mobiveil_msi *msi = &pcie->msi;
> > +     u32 msi_data, msi_addr_lo, msi_addr_hi;
> > +     u32 intr_status, msi_status;
> >       unsigned long shifted_status;
> >       u32 bit, virq, val, mask;
> >
> >       /*
> > -      * The core provides interrupt for INTx.
> > -      * So we'll read INTx status.
> > +      * The core provides a single interrupt for both INTx/MSI messages.
> > +      * So we'll read both INTx and MSI status
> >        */
> >
> >       chained_irq_enter(chip, desc);
> > @@ -232,6 +258,39 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
> >               } while ((shifted_status >> PAB_INTX_START) != 0);
> >       }
> >
> > +     /* read extra MSI status register */
> > +     msi_status = readl_relaxed(pcie->apb_csr_base + MSI_STATUS_OFFSET);
> > +
> > +     /* handle MSI interrupts */
> > +     if (msi_status & 1) {
>
> Maybe rewriting it like this makes it clearer (and remove a level of
> useless nesting):
>
> while (msi_status & 1) {
>         msi_data = readl_relaxed(pcie->apb_csr_base + MSI_DATA_OFFSET);
>
>         /*
>          * MSI_STATUS_OFFSET register gets updated to zero
>          * once we pop not only the MSI data but also address
>          * from MSI hardware FIFO. So keeping these following
>          * two dummy reads.
>          */
>         msi_addr_lo = readl_relaxed(pcie->apb_csr_base + MSI_ADDR_L_OFFSET);
>         msi_addr_hi = readl_relaxed(pcie->apb_csr_base + MSI_ADDR_H_OFFSET);
>         dev_dbg(dev, "MSI registers, data: %08x, addr: %08x:%08x\n",
>                 msi_data, msi_addr_hi, msi_addr_lo);
>
>                 virq = irq_find_mapping(msi->dev_domain, msi_data);
>                 if (virq)
>                         generic_handle_irq(virq);
>
>         msi_status = readl_relaxed(pcie->apb_csr_base + MSI_STATUS_OFFSET);
> }
>
OK.

> > +             do {
> > +                     msi_data = readl_relaxed(pcie->apb_csr_base
> > +                                     + MSI_DATA_OFFSET);
> > +
> > +                     /*
> > +                      * MSI_STATUS_OFFSET register gets updated to zero
> > +                      * once we pop not only the MSI data but also address
> > +                      * from MSI hardware FIFO. So keeping these following
> > +                      * two dummy reads.
> > +                      */
> > +                     msi_addr_lo = readl_relaxed(pcie->apb_csr_base +
> > +                                     MSI_ADDR_L_OFFSET);
> > +                     msi_addr_hi = readl_relaxed(pcie->apb_csr_base +
> > +                                     MSI_ADDR_H_OFFSET);
> > +                     dev_dbg(dev,
> > +                             "MSI registers, data: %08x, addr: %08x:%08x\n",
> > +                             msi_data, msi_addr_hi, msi_addr_lo);
> > +
> > +                             virq = irq_find_mapping(msi->dev_domain,
> > +                                     msi_data);
> > +                             if (virq)
> > +                                     generic_handle_irq(virq);
> > +
> > +                     msi_status = readl_relaxed(pcie->apb_csr_base +
> > +                                     MSI_STATUS_OFFSET);
> > +             } while (msi_status & 1);
> > +     }
> > +
> >       /* Clear the interrupt status */
> >       csr_writel(pcie, intr_status, PAB_INTP_AMBA_MISC_STAT);
>
> We discussed this before, in particular the edge nature of MSIs:
>
> https://marc.info/?l=linux-pci&m=152214807332582&w=2
>
> I was wondering whether the register:
>
> PAB_INTP_AMBA_MISC_STAT
>
> has some form of ACK on the MSI interrupt so that it can be added to
> the MSI bottom IRQ chip as required by edge IRQs. Isn't there in the
> controller a register that works as an acknowledgement for MSIs ?

It doesnt, as I have mentioned in the link you gave above,
PCIe host hardware retires the interrupt as soon as ISR empties the
last entry in the MSI FIFO.
There is no special ACKing bit in any registers as such. So local
ACKing function is not needed right ?

>
> >       chained_irq_exit(chip, desc);
> > @@ -267,6 +326,12 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
> >               return PTR_ERR(pcie->csr_axi_slave_base);
> >       pcie->pcie_reg_base = res->start;
> >
> > +     /* map MSI config resource */
> > +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
> > +     pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
> > +     if (IS_ERR(pcie->apb_csr_base))
> > +             return PTR_ERR(pcie->apb_csr_base);
> > +
> >       /* read the number of windows requested */
> >       if (of_property_read_u32(node, "apio-wins", &pcie->apio_wins))
> >               pcie->apio_wins = MAX_PIO_WINDOWS;
> > @@ -416,6 +481,22 @@ static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
> >       return -ETIMEDOUT;
> >  }
> >
> > +static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
> > +{
> > +     phys_addr_t msg_addr = pcie->pcie_reg_base;
> > +     struct mobiveil_msi *msi = &pcie->msi;
> > +
> > +     pcie->msi.num_of_vectors = PCI_NUM_MSI;
> > +     msi->msi_pages_phys = (phys_addr_t)msg_addr;
> > +
> > +     writel_relaxed(lower_32_bits(msg_addr),
> > +             pcie->apb_csr_base + MSI_BASE_LO_OFFSET);
> > +     writel_relaxed(upper_32_bits(msg_addr),
> > +             pcie->apb_csr_base + MSI_BASE_HI_OFFSET);
> > +     writel_relaxed(4096, pcie->apb_csr_base + MSI_SIZE_OFFSET);
> > +     writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
> > +}
> > +
> >  static int mobiveil_host_init(struct mobiveil_pcie *pcie)
> >  {
> >       u32 value, pab_ctrl, type = 0;
> > @@ -445,7 +526,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
> >               (1 << PEX_PIO_ENABLE_SHIFT),
> >               PAB_CTRL);
> >
> > -     csr_writel(pcie, (PAB_INTP_INTX_MASK),
> > +     csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
> >               PAB_INTP_AMBA_MISC_ENB);
> >
> >       /*
> > @@ -485,6 +566,9 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
> >               }
> >       }
> >
> > +     /* setup MSI hardware registers */
> > +     mobiveil_pcie_enable_msi(pcie);
> > +
> >       return err;
> >  }
> >
> > @@ -540,6 +624,116 @@ static int mobiveil_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> >       .map = mobiveil_pcie_intx_map,
> >  };
> >
> > +static struct irq_chip mobiveil_msi_irq_chip = {
> > +     .name = "Mobiveil PCIe MSI",
> > +     .irq_mask = pci_msi_mask_irq,
> > +     .irq_unmask = pci_msi_unmask_irq,
> > +};
> > +
> > +static struct msi_domain_info mobiveil_msi_domain_info = {
> > +     .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > +             MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
> > +     .chip   = &mobiveil_msi_irq_chip,
> > +};
> > +
> > +static void mobiveil_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> > +{
> > +     struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(data);
> > +     phys_addr_t addr = pcie->pcie_reg_base + (data->hwirq * sizeof(int));
> > +
> > +     msg->address_lo = lower_32_bits(addr);
> > +     msg->address_hi = upper_32_bits(addr);
> > +     msg->data = data->hwirq;
> > +
> > +     dev_dbg(&pcie->pdev->dev, "msi#%d address_hi %#x address_lo %#x\n",
> > +             (int)data->hwirq, msg->address_hi, msg->address_lo);
> > +}
> > +
> > +static int mobiveil_msi_set_affinity(struct irq_data *irq_data,
> > +             const struct cpumask *mask, bool force)
> > +{
> > +     return -EINVAL;
> > +}
> > +
> > +static struct irq_chip mobiveil_msi_bottom_irq_chip = {
> > +     .name                   = "Mobiveil MSI",
> > +     .irq_compose_msi_msg    = mobiveil_compose_msi_msg,
> > +     .irq_set_affinity       = mobiveil_msi_set_affinity,
> > +};
> > +
> > +static int mobiveil_irq_msi_domain_alloc(struct irq_domain *domain,
> > +             unsigned int virq, unsigned int nr_irqs, void *args)
> > +{
> > +     struct mobiveil_pcie *pcie = domain->host_data;
> > +     struct mobiveil_msi *msi = &pcie->msi;
> > +     unsigned long bit;
> > +
> > +     WARN_ON(nr_irqs != 1);
> > +     mutex_lock(&msi->lock);
> > +
> > +     bit = find_first_zero_bit(msi->msi_irq_in_use, msi->num_of_vectors);
> > +     if (bit >= msi->num_of_vectors) {
> > +             mutex_unlock(&msi->lock);
> > +             return -ENOSPC;
> > +     }
> > +
> > +     set_bit(bit, msi->msi_irq_in_use);
> > +
> > +     mutex_unlock(&msi->lock);
> > +
> > +     irq_domain_set_info(domain, virq, bit, &mobiveil_msi_bottom_irq_chip,
> > +                             domain->host_data, handle_level_irq,
>
> The flow handler should be handle_edge_irq and


Below is the discussion from the above linked marc.info link about edge handler:

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

So my question is, it looks like kernel is also considering it as
level interrupt and handling it, as
our HW is interrupting the CPU with a level triggered.

also other than tango and hyperv all others seems to be using either
simple or level handlers for MSI handling.

pcie-designware-host.c: handle_simple_irq
pci-aardvark.c:  handle_level_irq
pci-tegra.c: handle_simple_irq
pcie-mediatek.c : handle_simple_irq
pcie-rcar.c: handle_simple_irq
pcie-xilinx.c: handle_simple_irq

so isnt it because they also have similar hardware implementations? so
can we continue with
handle_level_irq for this driver ?
>
> this means that the
> irq_chip needs an irq_ack() method, see my question above.
>
I agree, So I had asked this question I couldn't get an answer for
Marc for that:

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

Would you be able to point me to an example implementation of PCIe
host driver which are NOT using
the pci_msi_un/mask_irq() API
s and implementing their own ?


>
> We need more HW details on the registers layout for MSIs management to
> understand how to add MSI support properly.
>
Sure please find the registers and their operation in detail below :

/* MSI registers */
#define MSI_BASE_LO_OFFSET 0x04
#define MSI_BASE_HI_OFFSET 0x08
#define MSI_SIZE_OFFSET 0x0c
#define MSI_ENABLE_OFFSET 0x14

MSI managing hardware monitors memory writes coming in from endpoints
to the 64-bit memory address programmed in the
MSI_BASE_HI_OFFSET:MSI_BASE_LO_OFFSET
register pair, upto MSI_SIZE_OFFSET size of bytes.
and it starts monitoring opearation as soon as bit#0 of
MSI_ENABLE_OFFSET goes high.
These writes are done in mobiveil_pcie_enable_msi() routine.

#define MSI_STATUS_OFFSET 0x18
MSI_STATUS_OFFSET registers bit#0, indecates there's a new MSI data
available in MSI FIFO registers.
MSI_STATUS_OFFSET register gets updated to zero once we pop not only
the MSI data but also address
from MSI hardware FIFO registers, MSI_DATA_* and MSI_ADDR_* explained below.

#define MSI_DATA_OFFSET 0x20
#define MSI_ADDR_L_OFFSET 0x24
#define MSI_ADDR_H_OFFSET 0x28

above three registers are top of the MSI FIFO.
MSI_DATA_OFFSET: register holds 32 bit MSI data
MSI_ADDR_L_OFFSET: register holds lower 32-bit of MSI address
MSI_ADDR_H_OFFSET: register holds higher 32-bit of MSI address


>
> Thanks,
> Lorenzo
>
> > +                             NULL, NULL);
> > +     return 0;
> > +}
> > +
> > +static void mobiveil_irq_msi_domain_free(struct irq_domain *domain,
> > +             unsigned int virq, unsigned int nr_irqs)
> > +{
> > +     struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> > +     struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(d);
> > +     struct mobiveil_msi *msi = &pcie->msi;
> > +
> > +     mutex_lock(&msi->lock);
> > +
> > +     if (!test_bit(d->hwirq, msi->msi_irq_in_use)) {
> > +             dev_err(&pcie->pdev->dev, "trying to free unused MSI#%lu\n",
> > +                     d->hwirq);
> > +     } else {
> > +             __clear_bit(d->hwirq, msi->msi_irq_in_use);
> > +     }
> > +
> > +     mutex_unlock(&msi->lock);
> > +}
> > +static const struct irq_domain_ops msi_domain_ops = {
> > +     .alloc  = mobiveil_irq_msi_domain_alloc,
> > +     .free   = mobiveil_irq_msi_domain_free,
> > +};
> > +
> > +static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
> > +{
> > +     struct device *dev = &pcie->pdev->dev;
> > +     struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> > +     struct mobiveil_msi *msi = &pcie->msi;
> > +
> > +     mutex_init(&pcie->msi.lock);
> > +     msi->dev_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
> > +                                             &msi_domain_ops, pcie);
> > +     if (!msi->dev_domain) {
> > +             dev_err(dev, "failed to create IRQ domain\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     msi->msi_domain = pci_msi_create_irq_domain(fwnode,
> > +                             &mobiveil_msi_domain_info, msi->dev_domain);
> > +     if (!msi->msi_domain) {
> > +             dev_err(dev, "failed to create MSI domain\n");
> > +             irq_domain_remove(msi->dev_domain);
> > +             return -ENOMEM;
> > +     }
> > +     return 0;
> > +}
> > +
> >  static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
> >  {
> >       struct device *dev = &pcie->pdev->dev;
> > @@ -557,6 +751,11 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
> >
> >       raw_spin_lock_init(&pcie->intx_mask_lock);
> >
> > +     /* setup MSI */
> > +     ret = mobiveil_allocate_msi_domains(pcie);
> > +     if (ret)
> > +             return ret;
> > +
> >       return 0;
> >  }
> >
> > --
> > 1.8.3.1
> >


Thanks.
