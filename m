Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0053.outbound.protection.outlook.com ([104.47.34.53]:34944
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752169AbdBCNhx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 08:37:53 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v4] PCI: Xilinx NWL: Modifying irq chip for legacy
 interrupts
Date: Fri, 3 Feb 2017 13:37:44 +0000
Message-ID: <8520D5D51A55D047800579B094147198263E04CA@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1486120110-15205-1-git-send-email-bharatku@xilinx.com>
 <3c78506f-9bcb-0b43-4625-27229ee1f642@arm.com>
 <8520D5D51A55D047800579B094147198263E03C4@XAP-PVEXMBX02.xlnx.xilinx.com>
 <69159364-f20a-c4e9-3e0b-187593d206fb@arm.com>
In-Reply-To: <69159364-f20a-c4e9-3e0b-187593d206fb@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 > On 03/02/17 12:16, Bharat Kumar Gogada wrote:
> >> On 03/02/17 11:08, Bharat Kumar Gogada wrote:
> >>> - Adding mutex lock for protecting legacy mask register
> >>> - Few wifi end points which only support legacy interrupts, performs
> >>> hardware reset functionalities after disabling interrupts by
> >>> invoking disable_irq and then re-enable using enable_irq, they
> >>> enable hardware interrupts first and then virtual irq line later.
> >>> - The legacy irq line goes low only after DEASSERT_INTx is
> >>> received.As the legacy irq line is high immediately after hardware
> >>> interrupts are enabled but virq of EP is still in disabled state and
> >>> EP handler is never executed resulting no DEASSERT_INTx.If dummy irq
> >>> chip is used, interrutps are not masked and system is hanging with CP=
U stall.
> >>> - Adding irq chip functions instead of dummy irq chip for legacy
> >>> interrupts.
> >>> - Legacy interrupts are level sensitive, so using handle_level_irq
> >>> is more appropriate as it is masks interrupts until End point
> >>> handles interrupts and unmasks interrutps after End point handler is
> executed.
> >>> - Legacy interrupts are level triggered, virtual irq line of End
> >>> Point shows as edge in /proc/interrupts.
> >>> - Setting irq flags of virtual irq line of EP to level triggered at
> >>> the time of mapping.
> >>>
> >>> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> >>> ---
> >>>  drivers/pci/host/pcie-xilinx-nwl.c |   45
> >> +++++++++++++++++++++++++++++++++++-
> >>>  1 files changed, 44 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c
> >>> b/drivers/pci/host/pcie-xilinx-nwl.c
> >>> index 43eaa4a..e4605f9 100644
> >>> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> >>> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> >>> @@ -184,6 +184,7 @@ struct nwl_pcie {
> >>>  	u8 root_busno;
> >>>  	struct nwl_msi msi;
> >>>  	struct irq_domain *legacy_irq_domain;
> >>> +	spinlock_t leg_mask_lock;
> >>>  };
> >>>
> >>>  static inline u32 nwl_bridge_readl(struct nwl_pcie *pcie, u32 off)
> >>> @@
> >>> -395,11 +396,52 @@ static void nwl_pcie_msi_handler_low(struct
> >>> irq_desc
> >> *desc)
> >>>  	chained_irq_exit(chip, desc);
> >>>  }
> >>>
> >>> +static void nwl_mask_leg_irq(struct irq_data *data) {
> >>> +	struct irq_desc *desc =3D irq_to_desc(data->irq);
> >>> +	struct nwl_pcie *pcie;
> >>> +	unsigned long flags;
> >>> +	u32 mask;
> >>> +	u32 val;
> >>> +
> >>> +	pcie =3D irq_desc_get_chip_data(desc);
> >>> +	mask =3D 1 << (data->hwirq - 1);
> >>> +	spin_lock_irqsave(&pcie->leg_mask_lock, flags);
> >>
> >> I've asked you to use a raw spinlock for a reason. If using RT, this
> >> gets turned into a sleeping lock...
> >>
> >  In include/linux/spinlock.h
> > #define spin_lock_irqsave(lock, flags)                          \
> > do {                                                            \
> >         raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
> > } while (0)
> >
> > The above API invokes raw_spin_lock_irqsave know.
> > So is there any difference between raw_spin_lock_irqsave and
> spin_lock_irqsave ?
>=20
> When using RT, yes. RT upgrades all spinlocks to sleeping locks. We're tr=
ying
> hard not to break RT, despite most of it not being merged yet. So your pa=
tch will
> work on mainline Linux, and will break horribly on Linux/RT.
>=20
> So please, turn this into a raw spinlock as requested.

Thanks for the explanation, will do it.=20

Regards,
Bharat
