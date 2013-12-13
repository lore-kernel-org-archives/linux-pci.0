Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:53034 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751797Ab3LMETL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Dec 2013 23:19:11 -0500
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush ANAND <pratyush.anand@st.com>,
	spear-devel <spear-devel@list.st.com>,
	Viresh Kumar <viresh.linux@gmail.com>
Date: Fri, 13 Dec 2013 12:18:35 +0800
Subject: RE: [PATCH 02/12] SPEAr13xx: Move SPEAr1340 definitions to header
 file
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189F95F669D@EAPEX1MAIL1.st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <9ae7b152da13c094b024c54d27187aab96e439b3.1386752447.git.mohit.kumar@st.com>
 <201312112348.06755.arnd@arndb.de>
In-Reply-To: <201312112348.06755.arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Thursday, December 12, 2013 4:18 AM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Mohit KUMAR DCG; linux-pci@vger.kernel.org; Pratyush ANAND; spear-
> devel; Viresh Kumar
> Subject: Re: [PATCH 02/12] SPEAr13xx: Move SPEAr1340 definitions to
> header file
> 
> On Wednesday 11 December 2013, Mohit Kumar wrote:
> > From: Pratyush Anand <pratyush.anand@st.com>
> >
> > Move SPEAr1340 definitions to header files so that theese can be used
> > by other code too.
> 
> This looks like a regression, we intentionally made them private and they
> should be moved into a proper driver instead of being globally visible.
> 
> > diff --git a/arch/arm/mach-spear/include/mach/spear.h
> > b/arch/arm/mach-spear/include/mach/spear.h
> > index 5cdc53d..4526f75 100644
> > --- a/arch/arm/mach-spear/include/mach/spear.h
> > +++ b/arch/arm/mach-spear/include/mach/spear.h
> > @@ -86,6 +86,61 @@
> >  /* Debug uart for linux, will be used for debug and uncompress messages
> */
> >  #define SPEAR_DBG_UART_BASE			UART_BASE
> >
> > +/* PCIe/SATA Base addresses */
> > +#define SPEAR1340_SATA_BASE			UL(0xB1000000)
> > +#define SPEAR1340_PCIE_BASE			UL(0xB1000000)
> 
> These should be in DT only.
> 
> > +/* Power Management Registers */
> > +#define SPEAR1340_PCM_CFG			(VA_MISC_BASE +
> 0x100)
> > +#define SPEAR1340_PCM_WKUP_CFG
> 	(VA_MISC_BASE + 0x104)
> > +#define SPEAR1340_SWITCH_CTR			(VA_MISC_BASE +
> 0x108)
> > +
> > +#define SPEAR1340_PERIP1_SW_RST
> 	(VA_MISC_BASE + 0x318)
> > +#define SPEAR1340_PERIP2_SW_RST
> 	(VA_MISC_BASE + 0x31C)
> > +#define SPEAR1340_PERIP3_SW_RST
> 	(VA_MISC_BASE + 0x320)
> 	
> The RST bits should probably go into a drivers/reset driver. Not sure what the
> other registers do, but I'm sure we can find a driver for these too, possibly
> they should be part of the PHY driver?

-  Perhaps if we implement phy and reset driver then we may not require to move these definitions and
it will address most of your comments on SPEar13xx pcie driver. I am understanding and working on this.l 

Regards
Mohit
