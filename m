Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog123.obsmtp.com ([207.126.144.155]:41720 "EHLO
	eu1sys200aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750910AbaAPH0R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Jan 2014 02:26:17 -0500
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush ANAND <pratyush.anand@st.com>,
	spear-devel <spear-devel@list.st.com>,
	Viresh Kumar <viresh.linux@gmail.com>
Date: Thu, 16 Jan 2014 15:25:41 +0800
Subject: RE: [PATCH 02/12] SPEAr13xx: Move SPEAr1340 definitions to header
 file
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FBE8D5D6@EAPEX1MAIL1.st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <201312112348.06755.arnd@arndb.de>
 <2CC2A0A4A178534D93D5159BF3BCB66189F95F669D@EAPEX1MAIL1.st.com>
 <201312142002.38423.arnd@arndb.de>
In-Reply-To: <201312142002.38423.arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,


> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Sunday, December 15, 2013 12:33 AM
> To: Mohit KUMAR DCG
> Cc: linux-arm-kernel@lists.infradead.org; linux-pci@vger.kernel.org;
> Pratyush ANAND; spear-devel; Viresh Kumar
> Subject: Re: [PATCH 02/12] SPEAr13xx: Move SPEAr1340 definitions to
> header file
> 
> On Friday 13 December 2013, Mohit KUMAR DCG wrote:
> > > The RST bits should probably go into a drivers/reset driver. Not
> > > sure what the other registers do, but I'm sure we can find a driver
> > > for these too, possibly they should be part of the PHY driver?
> >
> > -  Perhaps if we implement phy and reset driver then we may not
> > require to move these definitions and it will address most of your
> > comments on SPEar13xx pcie driver. I am understanding and working on
> > this.l
> >

Though we are almost ready with v2. But few concerns:

There are Spear soc common register used for misc configurations of clock, reset etc  for all ips.  Few of 
registers from the same area are also used for pcie/sata muxing and auxiliary clock configurations.
For example: sata_miphy_init in arch/arm/mach-spear/spear1340.c also uses these registers.

We have moved all these sata specific spear1340 configurations in a separate driver.  On the basis of spear-ahci dt 
Node this driver's probe is called, which further adds ahci platform driver.
We plan to put all spear1340/1310_pcie_miphy_init/exit functions of patch 9/12 of this series in
The same driver.

Now our concern is, what could be the best place to keep that driver, phy, reset or any other framework?
Or we keep this new driver in arch/arm/mach-spear only.

Regards
Mohit

> 
> Ok, very good.
> 
> 	Arnd
