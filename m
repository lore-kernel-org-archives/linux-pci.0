Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:53466 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751768AbaAPLqd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2014 06:46:33 -0500
Date: Thu, 16 Jan 2014 17:15:54 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	spear-devel <spear-devel@list.st.com>,
	Viresh Kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH 02/12] SPEAr13xx: Move SPEAr1340 definitions to header
 file
Message-ID: <20140116114554.GD2290@pratyush-vbox>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189FBE8D5D6@EAPEX1MAIL1.st.com>
 <20140116091908.GC2290@pratyush-vbox>
 <201401161233.40811.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <201401161233.40811.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 16, 2014 at 07:33:40PM +0800, Arnd Bergmann wrote:
> On Thursday 16 January 2014, Pratyush Anand wrote:
> > > Though we are almost ready with v2. But few concerns:
> > > 
> > > There are Spear soc common register used for misc configurations of clock, reset etc  for all ips.  Few of 
> > > registers from the same area are also used for pcie/sata muxing and auxiliary clock configurations.
> > > For example: sata_miphy_init in arch/arm/mach-spear/spear1340.c also uses these registers.
> > > 
> > > We have moved all these sata specific spear1340 configurations in a separate driver.  On the basis of spear-ahci dt 
> > > Node this driver's probe is called, which further adds ahci platform driver.
> > > We plan to put all spear1340/1310_pcie_miphy_init/exit functions of patch 9/12 of this series in
> > > The same driver.
> > > 
> > > Now our concern is, what could be the best place to keep that driver, phy, reset or any other framework?
> > > Or we keep this new driver in arch/arm/mach-spear only.
> > 
> > I think this misc configuration register block resource should be
> > passed to syscon (drivers/mfd/syscon.c) driver.
> > 
> > regmap_update_bits should be used to update these registers and hence
> > to configure pcie/sata settings.
> > 
> > As far as place is concerned, that can be kept into mfd and can be
> > named as spear13xx-syscon.c
> > 
> > Whats your opinion arnd?
> 
> That sounds exactly like what I would have suggested, thanks!
> 
> One question remains, which is what driver should directly use 
> syscon_regmap_lookup_by_phandle() to get the syscon registers themselves,
> and which ones should use a higher-level abstraction from spear13xx-syscon.c.
> 
> We can decide this on a case-by-case basis, but in general I would suggest
> to have drivers use syscon_regmap_lookup_by_phandle directly as long as
> it doesn't cause significant code duplication between drivers.

Yes, I think so.

Regards
Pratyush
> 
> 	Arnd
