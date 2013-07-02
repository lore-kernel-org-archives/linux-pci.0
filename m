Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:57817 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab3GBDqJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Jul 2013 23:46:09 -0400
Date: Tue, 2 Jul 2013 11:46:04 +0800
From: Sean Cross <xobs@kosagi.com>
To: Pratyush Anand <pratyush.anand@st.com>
Cc: "=?utf-8?Q?devicetree-discuss=40lists.ozlabs.org?="
	<devicetree-discuss@lists.ozlabs.org>,
	"=?utf-8?Q?linux-pci=40vger.kernel.org?=" <linux-pci@vger.kernel.org>,
	"=?utf-8?Q?linux-arm-kernel=40lists.infradead.org?="
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Mohit KUMAR <Mohit.KUMAR@st.com>
Message-ID: <2E3BDF14016345FA887E3BACAE05DADA@kosagi.com>
In-Reply-To: <51D15513.7020101@st.com>
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
 <1372662947-27160-4-git-send-email-xobs@kosagi.com>
 <51D15513.7020101@st.com>
Subject: Re: [PATCH 3/4] PCI: Add driver for i.MX6 PCI Express
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, July 1, 2013 at 6:08 PM, Pratyush Anand wrote:
> On 7/1/2013 12:45 PM, Sean Cross wrote:
> > This adds a PCI Express port driver for the on-chip PCI Express port
> > present on the i.MX6 SoC. It is based on the PCI Express driver available
> > in the Freescale BSP.
> > 
> > Signed-off-by: Sean Cross <xobs@kosagi.com (mailto:xobs@kosagi.com)>
> > ---
> 
> 
> 
> ...
> 
> > diff --git a/drivers/pci/pcie/pcie-imx.c b/drivers/pci/pcie/pcie-imx.c
> > new file mode 100644
> > index 0000000..664679e
> > --- /dev/null
> > +++ b/drivers/pci/pcie/pcie-imx.c
> 
> 
> 
> Should go to drivers/pci/host/
I'll pull from arm-soc rather than from Linus' tree and place the driver there instead.
 
> > @@ -0,0 +1,1049 @@
> > +/*
> > + * drivers/pci/pcie/pcie-imx.c
> > + *
> 
> 
> 
> ...
> 
> 
> > +#define ATU_R_BaseAddress 0x900
> > +#define PCIE_PL_iATUVR (ATU_R_BaseAddress + 0x0)
> > +#define PCIE_PL_iATURC1 (ATU_R_BaseAddress + 0x4)
> > +#define PCIE_PL_iATURC2 (ATU_R_BaseAddress + 0x8)
> > +#define PCIE_PL_iATURLBA (ATU_R_BaseAddress + 0xC)
> > +#define PCIE_PL_iATURUBA (ATU_R_BaseAddress + 0x10)
> > +#define PCIE_PL_iATURLA (ATU_R_BaseAddress + 0x14)
> > +#define PCIE_PL_iATURLTA (ATU_R_BaseAddress + 0x18)
> > +#define PCIE_PL_iATURUTA (ATU_R_BaseAddress + 0x1C)
> 
> 
> 
> I may be wrong, but from these offset it seems to me that it is SNPS 
> controller. If yes, then please go through comments of
> "[PATCH V1-10 0/4] PCIe support for Samsung Exynos5440 SoC"

Exynos5440 appears to use the same port logic controller.  However, the PHYs are different.  I'm not exactly certain which comments you want me to notice in that series of patchsets, but I see references to splitting Exynos-specific code into its own project.  Based on that, it seems like the best approach would be to:

    1) Move Exynos code into its own file, say, pcie-exynos.c.  This would leave only Synopsys-specific ATC code in pcie-designware.c
    2) Rename generic exynos functions to reflect the fact that they're designware-generic functions.
    3) Have pcie-imx.c reference this generic designware ATC code.

I'll rework the patch and re-submit it following these three changes.


--
Sean Cross

