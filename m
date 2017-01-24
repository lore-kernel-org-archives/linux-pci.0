Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0076.outbound.protection.outlook.com ([104.47.33.76]:58353
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750714AbdAXKPk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Jan 2017 05:15:40 -0500
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
Subject: RE: [PATCH 1/4] PCI: Xilinx NWL: Fix, do not check for legacy
 status in while loop
Date: Tue, 24 Jan 2017 10:15:33 +0000
Message-ID: <8520D5D51A55D047800579B094147198263CCF96@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
 <ec10b089-acc5-7764-6346-9dc1869d05c7@arm.com>
In-Reply-To: <ec10b089-acc5-7764-6346-9dc1869d05c7@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On 21/01/17 11:11, Bharat Kumar Gogada wrote:
> > - The legacy status register value for particular INTx becomes low
> > only after DEASSERT_INTx is received.
> > - Few End Points take time for sending DEASSERT_INTx, checking legacy
> > status register in while loop causes invoking of EP handler
> > continuosly until DEASSERT_INTx is received.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > ---
> >  drivers/pci/host/pcie-xilinx-nwl.c |    5 +++--
> >  1 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-xilinx-nwl.c
> > b/drivers/pci/host/pcie-xilinx-nwl.c
> > index 43eaa4a..c8b5a33 100644
> > --- a/drivers/pci/host/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> > @@ -342,9 +342,10 @@ static void nwl_pcie_leg_handler(struct irq_desc
> > *desc)
> >
> >  	chained_irq_enter(chip, desc);
> >  	pcie =3D irq_desc_get_handler_data(desc);
> > +	status =3D nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
> > +				  MSGF_LEG_SR_MASKALL;
> >
> > -	while ((status =3D nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
> > -				MSGF_LEG_SR_MASKALL) !=3D 0) {
> > +	if (status !=3D 0) {
> >  		for_each_set_bit(bit, &status, INTX_NUM) {
> >  			virq =3D irq_find_mapping(pcie->legacy_irq_domain,
> >  						bit + 1);
> >
>=20
> But even if you only handle the interrupt once, it is still asserted, rig=
ht? You exit
> the low-level exception handler, only to take the interrupt immediately a=
gain. So
> what is the gain here?
>=20
Whenever masking of INTx happens (like as in my next patch[PATCH 2/4]), the=
 irq line goes low,
but  status bit will be set until DEASSERT_INTx comes.
In this scenario if it is always in while loop, even though line went low i=
t will not be seen=20
until DEASSERT_INTx, unnecessarily invoking EP driver. so instead of while =
loop =20
using if condition so that this change in line is noticed.
> As an aside, please add a cover letter to your patch series. It is immens=
ely useful
> as a summary of what is being done, as well as an anchor for the patches
> themselves.
>=20
Agreed, will do next time.=20

Thanks & Regards,
Bharat

