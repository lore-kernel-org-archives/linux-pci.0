Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47896 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbJLK2I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 06:28:08 -0400
Message-ID: <1444645685.3364.8.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] PCI: designware: Move LTSSM state definitions to
 pcie-designware.h
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, pratyush.anand@gmail.com, m-karicheri2@ti.com,
	linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Mon, 12 Oct 2015 12:28:05 +0200
In-Reply-To: <1444645188.3364.5.camel@pengutronix.de>
References: <1444355306-21486-1-git-send-email-festevam@gmail.com>
	 <1444645188.3364.5.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 12.10.2015, 12:19 +0200 schrieb Lucas Stach:
> Am Donnerstag, den 08.10.2015, 22:48 -0300 schrieb Fabio Estevam:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Move LTSSM state definitions to common pcie-designware.h so that other
> > drivers can make use of them.
> > 
> > Also, in order to avoid name collision define LTSSM_STATE_MASK_KS, as
> > keystone uses a different LTSSM mask.
> > 
> Why? Is this some kind of difference between the DW PCIe core revisions?
> 
> I don't see the other drivers using any LTSSM state value that would not
> fit inside the KS mask. Can we just use the narrower KS mask, even if
> the others have one bit more allocated in the register? This would spare
> us this needless differentiation in the software.
> 
Actually the TRM states that i.MX6 is using the same narrower mask of
0x1f for the LTSSM state, so another reason to just use that.

> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
> > ---
> > Changes since v1:
> > - Fix build warning noticed by kbuild robot
> > 
> >  drivers/pci/host/pci-keystone-dw.c |  4 ++--
> >  drivers/pci/host/pci-layerscape.c  |  1 -
> >  drivers/pci/host/pcie-designware.h | 34 ++++++++++++++++++++++++++++++++++
> >  drivers/pci/host/pcie-spear13xx.c  | 33 ---------------------------------
> >  4 files changed, 36 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
> > index 3cf55cd..004b677 100644
> > --- a/drivers/pci/host/pci-keystone-dw.c
> > +++ b/drivers/pci/host/pci-keystone-dw.c
> > @@ -25,7 +25,7 @@
> >  
> >  /* Application register defines */
> >  #define LTSSM_EN_VAL		        1
> > -#define LTSSM_STATE_MASK		0x1f
> > +#define LTSSM_STATE_MASK_KS		0x1f
> >  #define LTSSM_STATE_L0			0x11
> >  #define DBI_CS2_EN_VAL			0x20
> >  #define OB_XLAT_EN_VAL		        2
> > @@ -445,7 +445,7 @@ int ks_dw_pcie_link_up(struct pcie_port *pp)
> >  {
> >  	u32 val = readl(pp->dbi_base + DEBUG0);
> >  
> > -	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
> > +	return (val & LTSSM_STATE_MASK_KS) == LTSSM_STATE_L0;
> >  }
> >  
> >  void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
> > diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> > index b2328ea1..f02752e 100644
> > --- a/drivers/pci/host/pci-layerscape.c
> > +++ b/drivers/pci/host/pci-layerscape.c
> > @@ -29,7 +29,6 @@
> >  /* PEX1/2 Misc Ports Status Register */
> >  #define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
> >  #define LTSSM_STATE_SHIFT	20
> > -#define LTSSM_STATE_MASK	0x3f
> >  #define LTSSM_PCIE_L0		0x11 /* L0 state */
> >  
> >  /* Symbol Timer Register and Filter Mask Register 1 */
> > diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> > index 35123d9..97d6558 100644
> > --- a/drivers/pci/host/pcie-designware.h
> > +++ b/drivers/pci/host/pcie-designware.h
> > @@ -22,6 +22,40 @@
> >  #define MAX_MSI_IRQS			32
> >  #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
> >  
> > +#define LTSSM_STATE_DETECT_QUIET	0x00
> > +#define LTSSM_STATE_DETECT_ACT		0x01
> > +#define LTSSM_STATE_POLL_ACTIVE		0x02
> > +#define LTSSM_STATE_POLL_COMPLIANCE	0x03
> > +#define LTSSM_STATE_POLL_CONFIG		0x04
> > +#define LTSSM_STATE_PRE_DETECT_QUIET	0x05
> > +#define LTSSM_STATE_DETECT_WAIT		0x06
> > +#define LTSSM_STATE_CFG_LINKWD_START	0x07
> > +#define LTSSM_STATE_CFG_LINKWD_ACEPT	0x08
> > +#define LTSSM_STATE_CFG_LANENUM_WAIT	0x09
> > +#define LTSSM_STATE_CFG_LANENUM_ACEPT	0x0A
> > +#define LTSSM_STATE_CFG_COMPLETE	0x0B
> > +#define LTSSM_STATE_CFG_IDLE		0x0C
> > +#define LTSSM_STATE_RCVRY_LOCK		0x0D
> > +#define LTSSM_STATE_RCVRY_SPEED		0x0E
> > +#define LTSSM_STATE_RCVRY_RCVRCFG	0x0F
> > +#define LTSSM_STATE_RCVRY_IDLE		0x10
> > +#define LTSSM_STATE_L0			0x11
> > +#define LTSSM_STATE_L0S			0x12
> > +#define LTSSM_STATE_L123_SEND_EIDLE	0x13
> > +#define LTSSM_STATE_L1_IDLE		0x14
> > +#define LTSSM_STATE_L2_IDLE		0x15
> > +#define LTSSM_STATE_L2_WAKE		0x16
> > +#define LTSSM_STATE_DISABLED_ENTRY	0x17
> > +#define LTSSM_STATE_DISABLED_IDLE	0x18
> > +#define LTSSM_STATE_DISABLED		0x19
> > +#define LTSSM_STATE_LPBK_ENTRY		0x1A
> > +#define LTSSM_STATE_LPBK_ACTIVE		0x1B
> > +#define LTSSM_STATE_LPBK_EXIT		0x1C
> > +#define LTSSM_STATE_LPBK_EXIT_TIMEOUT	0x1D
> > +#define LTSSM_STATE_HOT_RESET_ENTRY	0x1E
> > +#define LTSSM_STATE_HOT_RESET		0x1F
> > +#define LTSSM_STATE_MASK		0x3F
> > +
> I know this is just copy-and-paste, but can we use lowercase letters for
> the hex values please? This would make this fit in better with the rest
> of the header and is much more like any other part of the kernel.
> 
> Regards,
> Lucas
> 
> >  struct pcie_port {
> >  	struct device		*dev;
> >  	u8			root_bus_nr;
> > diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> > index 98d2683..920d399 100644
> > --- a/drivers/pci/host/pcie-spear13xx.c
> > +++ b/drivers/pci/host/pcie-spear13xx.c
> > @@ -84,39 +84,6 @@ struct pcie_app_reg {
> >  #define APPS_PM_XMT_PME_ID			5
> >  
> >  /* CR3 ID */
> > -#define XMLH_LTSSM_STATE_DETECT_QUIET		0x00
> > -#define XMLH_LTSSM_STATE_DETECT_ACT		0x01
> > -#define XMLH_LTSSM_STATE_POLL_ACTIVE		0x02
> > -#define XMLH_LTSSM_STATE_POLL_COMPLIANCE	0x03
> > -#define XMLH_LTSSM_STATE_POLL_CONFIG		0x04
> > -#define XMLH_LTSSM_STATE_PRE_DETECT_QUIET	0x05
> > -#define XMLH_LTSSM_STATE_DETECT_WAIT		0x06
> > -#define XMLH_LTSSM_STATE_CFG_LINKWD_START	0x07
> > -#define XMLH_LTSSM_STATE_CFG_LINKWD_ACEPT	0x08
> > -#define XMLH_LTSSM_STATE_CFG_LANENUM_WAIT	0x09
> > -#define XMLH_LTSSM_STATE_CFG_LANENUM_ACEPT	0x0A
> > -#define XMLH_LTSSM_STATE_CFG_COMPLETE		0x0B
> > -#define XMLH_LTSSM_STATE_CFG_IDLE		0x0C
> > -#define XMLH_LTSSM_STATE_RCVRY_LOCK		0x0D
> > -#define XMLH_LTSSM_STATE_RCVRY_SPEED		0x0E
> > -#define XMLH_LTSSM_STATE_RCVRY_RCVRCFG		0x0F
> > -#define XMLH_LTSSM_STATE_RCVRY_IDLE		0x10
> > -#define XMLH_LTSSM_STATE_L0			0x11
> > -#define XMLH_LTSSM_STATE_L0S			0x12
> > -#define XMLH_LTSSM_STATE_L123_SEND_EIDLE	0x13
> > -#define XMLH_LTSSM_STATE_L1_IDLE		0x14
> > -#define XMLH_LTSSM_STATE_L2_IDLE		0x15
> > -#define XMLH_LTSSM_STATE_L2_WAKE		0x16
> > -#define XMLH_LTSSM_STATE_DISABLED_ENTRY		0x17
> > -#define XMLH_LTSSM_STATE_DISABLED_IDLE		0x18
> > -#define XMLH_LTSSM_STATE_DISABLED		0x19
> > -#define XMLH_LTSSM_STATE_LPBK_ENTRY		0x1A
> > -#define XMLH_LTSSM_STATE_LPBK_ACTIVE		0x1B
> > -#define XMLH_LTSSM_STATE_LPBK_EXIT		0x1C
> > -#define XMLH_LTSSM_STATE_LPBK_EXIT_TIMEOUT	0x1D
> > -#define XMLH_LTSSM_STATE_HOT_RESET_ENTRY	0x1E
> > -#define XMLH_LTSSM_STATE_HOT_RESET		0x1F
> > -#define XMLH_LTSSM_STATE_MASK			0x3F
> >  #define XMLH_LINK_UP				(1 << 6)
> >  
> >  /* CR4 ID */
> 

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

