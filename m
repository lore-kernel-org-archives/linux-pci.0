Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61150 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbaAaP34 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2014 10:29:56 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH V3 7/8] pcie: SPEAr13xx: Add designware pcie support
Date: Fri, 31 Jan 2014 16:29:53 +0100
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	"spear-devel" <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <cover.1391077731.git.mohit.kumar@st.com> <201401301434.20188.arnd@arndb.de> <20140131042446.GD2618@pratyush-vbox>
In-Reply-To: <20140131042446.GD2618@pratyush-vbox>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201401311629.53734.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 31 January 2014, Pratyush Anand wrote:
> On Thu, Jan 30, 2014 at 09:34:19PM +0800, Arnd Bergmann wrote:
> > On Thursday 30 January 2014, Mohit Kumar wrote:
> > 
> > Ah, so this is what the ID gets used for. I would indeed encode this in the
> > phy node, unlike the configuration of whether it's used for PCIe or SATA.
> 
> ok.. ll use "phy_id = <n>;" in phy node.

Ok. Minor comment: the preferred style would be 'phy-id' rather than 'phy_id'
in DT,

> > > +static int pcie_miphy_init(struct spear13xx_phy_priv *phypriv)
> > > +{
> > > +	if (of_machine_is_compatible("st,spear1340"))
> > > +		return spear1340_pcie_miphy_init(phypriv);
> > > +	else if (of_machine_is_compatible("st,spear1310"))
> > > +		return spear1310_pcie_miphy_init(phypriv);
> > > +	else
> > > +		return -EINVAL;
> > > +}
> > 
> > You should never check global properties such as the machine compatible
> > value to make local decisions. You have two options here: Either use
> > two different compatible strings for the phy node, or encode the
> > difference in another property. If the only difference between spear1310
> > and spear1340 is the location of the register within the "misc" syscon
> > space, a good represenation would be to put the register offset next
> > to the syscon phandle in the same property. That way it could transparently
> > work for future SoCs.
> 
> Currently, there is only difference in misc syscon space. But, as I
> said few phy register definition might also change in different soc.
> 
> Ok.. I ll go with first option, ie different compatible string for
> different socs. It seems most logical also.

Ok.

	Arnd
