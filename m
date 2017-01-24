Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0065.outbound.protection.outlook.com ([104.47.42.65]:51153
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750761AbdAXKTg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Jan 2017 05:19:36 -0500
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
Subject: RE: [PATCH 2/4] PCI: Xilinx NWL: Modifying irq chip for legacy
 interrupts
Date: Tue, 24 Jan 2017 10:19:26 +0000
Message-ID: <8520D5D51A55D047800579B094147198263CCFB4@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
 <1484997072-19276-2-git-send-email-bharatku@xilinx.com>
 <1ac7a4bb-26b6-7a4b-9bf1-030d87e6f8e6@arm.com>
In-Reply-To: <1ac7a4bb-26b6-7a4b-9bf1-030d87e6f8e6@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 > On 21/01/17 11:11, Bharat Kumar Gogada wrote:
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
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > ---
> >  drivers/pci/host/pcie-xilinx-nwl.c |   36
> +++++++++++++++++++++++++++++++++++-
> >  1 files changed, 35 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie=
-xilinx-
> nwl.c
> > index c8b5a33..e1809f9 100644
> > --- a/drivers/pci/host/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> > @@ -396,10 +396,44 @@ static void nwl_pcie_msi_handler_low(struct
> irq_desc *desc)
> >  	chained_irq_exit(chip, desc);
> >  }
> >
> > +static void nwl_mask_leg_irq(struct irq_data *data)
> > +{
> > +	struct irq_desc *desc =3D irq_to_desc(data->irq);
> > +	struct nwl_pcie *pcie;
> > +	unsigned int mask =3D 0;
>=20
> No need for this initialization. And if the function you're passing that
> to takes a u32, why isn't that a u32 too?
>=20
> > +
> > +	pcie =3D irq_desc_get_chip_data(desc);
> > +	mask =3D 1 << (data->hwirq - 1);
> > +	nwl_bridge_writel(pcie, ((u32)MSGF_LEG_SR_MASKALL & (~mask)),
> > +			  MSGF_LEG_MASK);
>=20
> Erm. This looks completely bogus. Let's say I mask INTA:
>=20
> 	mask =3D 1 << 0;
> 	nwl_bridge_writel(pcie, INTD|INTC|INTB, ...);
>=20
> Now, in a separate context, I decide to mask INTB:
>=20
> 	mask =3D 1 << 1;
> 	nwl_bridge_writel(pcie, INTD|INTC|INTA, ...);
>=20
> unmasking INTA in the process. Probably not what you intended.
>=20
Agreed, will do it in next patch.
> > +
> > +}
> > +
> > +static void nwl_unmask_leg_irq(struct irq_data *data)
> > +{
> > +	struct irq_desc *desc =3D irq_to_desc(data->irq);
> > +	struct nwl_pcie *pcie;
> > +	unsigned int mask =3D 0;
> > +
> > +	pcie =3D irq_desc_get_chip_data(desc);
> > +	mask =3D 1 << (data->hwirq - 1);
> > +	nwl_bridge_writel(pcie, ((u32)MSGF_LEG_SR_MASKALL | mask),
> > +			  MSGF_LEG_MASK);
>=20
> Same issue.
>=20
Agreed, will do it in next patch.

Thanks & Regards,
Bharat
