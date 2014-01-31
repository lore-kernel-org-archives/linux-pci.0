Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog122.obsmtp.com ([207.126.144.153]:34271 "EHLO
	eu1sys200aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753836AbaAaEY7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 23:24:59 -0500
Date: Fri, 31 Jan 2014 09:54:46 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V3 7/8] pcie: SPEAr13xx: Add designware pcie support
Message-ID: <20140131042446.GD2618@pratyush-vbox>
References: <cover.1391077731.git.mohit.kumar@st.com>
 <1c7f0dd04e9af55886dc74789bfcf92ce900e131.1391077731.git.mohit.kumar@st.com>
 <201401301434.20188.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <201401301434.20188.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 30, 2014 at 09:34:19PM +0800, Arnd Bergmann wrote:
> On Thursday 30 January 2014, Mohit Kumar wrote:
> 
> > @@ -80,6 +80,57 @@
> >  			status = "disabled";
> >  		};
> >  
> > +		pcie0: pcie@b1000000 {
> > +			compatible = "st,spear1340-pcie", "snps,dw-pcie";
> > +			reg = <0xb1000000 0x4000>;
> > +			interrupts = <0 68 0x4>;
> > +			pcie_is_gen1 = <0>;
> > +			num-lanes = <1>;
> > +			phys = <&miphy0 1 0>;
> > +			phy-names = "pcie-phy";
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +			device_type = "pci";
> > +			ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00020000   /* configuration space */
> > +				0x81000000 0 0	 0x80020000 0 0x00010000   /* downstream I/O */
> > +				0x82000000 0 0x80030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
> > +			status = "disabled";
> > +		};
> 
> Shouldn't there be more than one interrupt? Normally each root port has
> four legacy IRQs, in order to support bridge devices.

> 
> > +	spear13xx_pcie->phy = devm_phy_get(dev, "pcie-phy");
> > +	if (IS_ERR(spear13xx_pcie->phy)) {
> > +		dev_err(dev, "Could not get PHY\n");
> > +		return -EPROBE_DEFER;
> > +	}
> 
> I think you should only return -EPROBE_DEFER if you got that
> error from the PHY layer. If there is some other problem
> with getting the PHY, you want that returned as a fatal
> error here and not retry the PCIe probe function.

OK.

> 
> > diff --git a/drivers/phy/phy-spear13xx-sata-pcie.c b/drivers/phy/phy-spear13xx-sata-pcie.c
> > index 6adfa64..5eabf51 100644
> > --- a/drivers/phy/phy-spear13xx-sata-pcie.c
> > +++ b/drivers/phy/phy-spear13xx-sata-pcie.c
> > @@ -71,6 +71,80 @@
> >  	#define SPEAR1340_PCIE_SATA_MIPHY_CFG_PCIE \
> >  			(SPEAR1340_MIPHY_OSC_BYPASS_EXT | \
> >  			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
> 
> Please split this out into a separate patch.

ok.

> 
> > +static int spear1310_pcie_miphy_init(struct spear13xx_phy_priv *phypriv)
> > +{
> > +	u32 mask, val;
> > +
> > +	regmap_update_bits(phypriv->misc, SPEAR1310_PCIE_MIPHY_CFG_1,
> > +			SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK,
> > +			SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE);
> > +
> > +	switch (phypriv->id) {
> > +	case 0:
> > +		mask = SPEAR1310_PCIE_CFG_MASK(0);
> > +		val = SPEAR1310_PCIE_CFG_VAL(0);
> > +		break;
> > +	case 1:
> > +		mask = SPEAR1310_PCIE_CFG_MASK(1);
> > +		val = SPEAR1310_PCIE_CFG_VAL(1);
> > +		break;
> > +	case 2:
> > +		mask = SPEAR1310_PCIE_CFG_MASK(2);
> > +		val = SPEAR1310_PCIE_CFG_VAL(2);
> > +		break;
> 
> Ah, so this is what the ID gets used for. I would indeed encode this in the
> phy node, unlike the configuration of whether it's used for PCIe or SATA.

ok.. ll use "phy_id = <n>;" in phy node.

> 
> > +static int pcie_miphy_init(struct spear13xx_phy_priv *phypriv)
> > +{
> > +	if (of_machine_is_compatible("st,spear1340"))
> > +		return spear1340_pcie_miphy_init(phypriv);
> > +	else if (of_machine_is_compatible("st,spear1310"))
> > +		return spear1310_pcie_miphy_init(phypriv);
> > +	else
> > +		return -EINVAL;
> > +}
> 
> You should never check global properties such as the machine compatible
> value to make local decisions. You have two options here: Either use
> two different compatible strings for the phy node, or encode the
> difference in another property. If the only difference between spear1310
> and spear1340 is the location of the register within the "misc" syscon
> space, a good represenation would be to put the register offset next
> to the syscon phandle in the same property. That way it could transparently
> work for future SoCs.

Currently, there is only difference in misc syscon space. But, as I
said few phy register definition might also change in different soc.

Ok.. I ll go with first option, ie different compatible string for
different socs. It seems most logical also.

Regards
Pratyush

> 
> 	Arnd
