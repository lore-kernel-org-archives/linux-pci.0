Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Marc Zyngier <marc.zyngier@arm.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "robh@kernel.org" <robh@kernel.org>,
 "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
 "colin.king@canonical.com" <colin.king@canonical.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5] PCI: Xilinx NWL: Modifying irq chip for legacy
 interrupts
Date: Thu, 9 Feb 2017 12:01:06 +0000
Message-ID: <8520D5D51A55D047800579B094147198263E68AA@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1486364596-19699-1-git-send-email-bharatku@xilinx.com>
 <4b04e834-08b6-a728-8fe5-13106d50b3b2@arm.com>
In-Reply-To: <4b04e834-08b6-a728-8fe5-13106d50b3b2@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Ravikiran Gummaluri <rgummal@xilinx.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> On 06/02/17 07:03, Bharat Kumar Gogada wrote:
> > - Adding spinlock for protecting legacy mask register
> > - Few wifi end points which only support legacy interrupts,
> > performs hardware reset functionalities after disabling interrupts
> > by invoking disable_irq and then re-enable using enable_irq, they
> > enable hardware interrupts first and then virtual irq line later.
> > - The legacy irq line goes low only after DEASSERT_INTx is
> > received.As the legacy irq line is high immediately after hardware
> > interrupts are enabled but virq of EP is still in disabled state
> > and EP handler is never executed resulting no DEASSERT_INTx.If dummy
> > irq chip is used, interrutps are not masked and system is
> > hanging with CPU stall.
> > - Adding irq chip functions instead of dummy irq chip for legacy
> > interrupts.
> > - Legacy interrupts are level sensitive, so using handle_level_irq
> > is more appropriate as it is masks interrupts until End point handles
> > interrupts and unmasks interrutps after End point handler is executed.
> > - Legacy interrupts are level triggered, virtual irq line of End
> > Point shows as edge in /proc/interrupts.
> > - Setting irq flags of virtual irq line of EP to level triggered
> > at the time of mapping.
> 
> I'm now OK with the code (modulo the small nit below), but the commit
> message is a complete mess. How about something like:
> 
> The current handling of legacy interrupts in the Xilinx NWL driver is
> completely dysfunctional: Interrupts are handled as edge instead of
> level, and there is no way to mask an interrupt, leading to drivers
> misbehaving.
> 
> Let's address this by making it a full blown irqchip, implement
> mask/unmask methods, and use handle_level_irq as the flow handler.
Yes, will change the commit message.
> 
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > ---
> >  drivers/pci/host/pcie-xilinx-nwl.c | 45
> +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-
> nwl.c
> > index 43eaa4a..36f4fb4 100644
> > --- a/drivers/pci/host/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> > @@ -184,6 +184,7 @@ struct nwl_pcie {
> >  	u8 root_busno;
> >  	struct nwl_msi msi;
> >  	struct irq_domain *legacy_irq_domain;
> > +	raw_spinlock_t leg_mask_lock;
> >  };
> >
> >  static inline u32 nwl_bridge_readl(struct nwl_pcie *pcie, u32 off)
> > @@ -395,11 +396,52 @@ static void nwl_pcie_msi_handler_low(struct
> irq_desc *desc)
> >  	chained_irq_exit(chip, desc);
> >  }
> >
> > +static void nwl_mask_leg_irq(struct irq_data *data)
> > +{
> > +	struct irq_desc *desc = irq_to_desc(data->irq);
> > +	struct nwl_pcie *pcie;
> > +	unsigned long flags;
> > +	u32 mask;
> > +	u32 val;
> > +
> > +	pcie = irq_desc_get_chip_data(desc);
> > +	mask = 1 << (data->hwirq - 1);
> > +	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
> > +	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
> > +	nwl_bridge_writel(pcie, (val & (~mask)), MSGF_LEG_MASK);
> > +	raw_spin_unlock_irqrestore(&pcie->leg_mask_lock, flags);
> > +}
> > +
> > +static void nwl_unmask_leg_irq(struct irq_data *data)
> > +{
> > +	struct irq_desc *desc = irq_to_desc(data->irq);
> > +	struct nwl_pcie *pcie;
> > +	unsigned long flags;
> > +	u32 mask;
> > +	u32 val;
> > +
> > +	pcie = irq_desc_get_chip_data(desc);
> > +	mask = 1 << (data->hwirq - 1);
> > +	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
> > +	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
> > +	nwl_bridge_writel(pcie, (val | mask), MSGF_LEG_MASK);
> > +	raw_spin_unlock_irqrestore(&pcie->leg_mask_lock, flags);
> > +}
> > +
> > +static struct irq_chip nwl_leg_irq_chip = {
> > +	.name = "nwl_pcie:legacy",
> > +	.irq_enable = nwl_unmask_leg_irq,
> > +	.irq_disable = nwl_mask_leg_irq,
> 
> You don't need these two if they are implemented in terms of mask/unmask.

These are being invoked by some drivers other than interrupt flow.
Ex: drivers/net/wireless/ath/ath9k/main.c
static int ath_reset_internal(struct ath_softc *sc, struct ath9k_channel *hchan) 
{
         ....
         disable_irq(sc->irq);
         tasklet_disable(&sc->intr_tq);
        ...
        ...
        enable_irq(sc->irq);
        spin_unlock_bh(&sc->sc_pcu_lock);
}
For us masking/unmasking is the way to enable/disable interrupts.

> 
> > +	.irq_mask = nwl_mask_leg_irq,
> > +	.irq_unmask = nwl_unmask_leg_irq,
> > +};
> > +
Thanks & Regards,
Bharat

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
