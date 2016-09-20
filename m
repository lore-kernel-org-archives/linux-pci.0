Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "M.H. Lian" <minghuan.lian@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH 1/2] pci/layercape: disable all iATUs before initialization
Date: Tue, 20 Sep 2016 07:25:08 +0000
Message-ID: <VI1PR04MB161515A0B98570FA6CF6C620E8F70@VI1PR04MB1615.eurprd04.prod.outlook.com>
References: <1473315950-6396-1-git-send-email-Minghuan.Lian@nxp.com>
 <20160914211053.GD13189@localhost>
In-Reply-To: <20160914211053.GD13189@localhost>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Jingoo Han <jg1.han@samsung.com>, Stuart Yoder <stuart.yoder@nxp.com>,
 Leo Li <leoyang.li@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for your reply.
Please see my comments inline.

Best Regards,
Minghuan

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Thursday, September 15, 2016 5:11 AM
> To: M.H. Lian <minghuan.lian@nxp.com>
> Cc: linux-pci@vger.kernel.org; Roy Zang <roy.zang@nxp.com>; Arnd
> Bergmann <arnd@arndb.de>; Jingoo Han <jg1.han@samsung.com>; Stuart
> Yoder <stuart.yoder@nxp.com>; Leo Li <leoyang.li@nxp.com>; linux-arm-
> kernel@lists.infradead.org; Bjorn Helgaas <bhelgaas@google.com>; Mingkai
> Hu <mingkai.hu@nxp.com>
> Subject: Re: [PATCH 1/2] pci/layercape: disable all iATUs before initialization
> 
> On Thu, Sep 08, 2016 at 02:25:49PM +0800, Minghuan Lian wrote:
> > Layerscape PCIe has 6 outbound iATUs. The bootloader such as u-boot
> > uses 4 iATUs for CFG0 CFG1 IO and MEM separately. But Designware
> > driver only uses two outbound iATUs. To avoid conflict between enabled
> > but unused iATUs with used iATUs under Linux and unexpected behavior,
> > the patch disables all iATUs before initialization.
> 
> Do we need similar changes in other DesignWare-based drivers?
[Minghuan Lian]  Yes. I think so.  
I could provide a patch for all the Designware-based drivers. 
Could you give me suggestion  how to get ATU number of all kinds of PCIe controller?
1. Add optional "num-atu" property to designware-based PCIe dts node?
2. The specific driver assign a variable "num-atu" before  calling dw_pcie_host_init()

We could achieve  benefits if   the ATU number is bigger than two (current default value)
1. A dedicated ATU is for IO map. It will avoid conflict IO and config access simultaneously.
2. Supports multiple ATUs for prefetchable and non-prefetchable memory and the memory size can be greater than 4G.

> 
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > ---
> >  drivers/pci/host/pci-layerscape.c  | 17 +++++++++++++++--
> > drivers/pci/host/pcie-designware.c |  7 +++++++
> > drivers/pci/host/pcie-designware.h |  1 +
> >  3 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/host/pci-layerscape.c
> > b/drivers/pci/host/pci-layerscape.c
> > index 114ba81..cf783ad 100644
> > --- a/drivers/pci/host/pci-layerscape.c
> > +++ b/drivers/pci/host/pci-layerscape.c
> > @@ -38,6 +38,8 @@
> >  /* PEX LUT registers */
> >  #define PCIE_LUT_DBG		0x7FC /* PEX LUT Debug Register */
> >
> > +#define PCIE_IATU_NUM		6
> > +
> >  struct ls_pcie_drvdata {
> >  	u32 lut_offset;
> >  	u32 ltssm_shift;
> > @@ -55,6 +57,8 @@ struct ls_pcie {
> >
> >  #define to_ls_pcie(x)	container_of(x, struct ls_pcie, pp)
> >
> > +static void ls_pcie_host_init(struct pcie_port *pp);
> 
> I would prefer to reorder the function definitions so the forward declaration
> is not necessary.  This would be two patches:
> 
>   1) Reorder functions (no functional change)
>   2) Disable iATUs
[Minghuan Lian] ok. I will change it.
> 
> >  static bool ls_pcie_is_bridge(struct ls_pcie *pcie)  {
> >  	u32 header_type;
> > @@ -87,6 +91,14 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
> >  	iowrite32(val, pcie->dbi + PCIE_STRFMR1);  }
> >
> > +static void ls_pcie_disable_outbound_atus(struct ls_pcie *pcie) {
> > +	int i;
> > +
> > +	for (i = 0; i < PCIE_IATU_NUM; i++)
> > +		dw_pcie_disable_outbound_atu(&pcie->pp, i);
> 
> It looks like maybe the DesignWare ATUs are generic enough that we could
> move the loop into the generic code, e.g.,
> 
>   void dw_pcie_disable_outbound_atu(struct pcie_port *pp, int count)
>   {
>     int i;
> 
>     for (i = 0; i < count; i++) {
>       dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | i,
> PCIE_ATU_VIEWPORT);
>       dw_pcie_writel_rc(pp, 0, PCIE_ATU_CR2);
>     }
>   }
> 
[Minghuan Lian] Yes.  And,  If we add "num-atu" property to dts node. 
Designware driver can directly clear ATUs and the specific driver needs to do nothing.

> > +
> >  static int ls1021_pcie_link_up(struct pcie_port *pp)  {
> >  	u32 state;
> > @@ -124,9 +136,8 @@ static void ls1021_pcie_host_init(struct pcie_port
> *pp)
> >  	}
> >  	pcie->index = index[1];
> >
> > +	ls_pcie_host_init(pp);
> >  	dw_pcie_setup_rc(pp);
> > -
> > -	ls_pcie_drop_msg_tlp(pcie);
> 
> Can you split this to a separate patch?  This hunk changes
> ls1021_pcie_host_init() so it does several things in addition to
> ls_pcie_drop_msg_tlp(), and it is unrelated to the "disable iATU" change.
[Minghuan Lian] OK. I will change it.
> 
> >  }
> >
> >  static int ls_pcie_link_up(struct pcie_port *pp) @@ -153,6 +164,8 @@
> > static void ls_pcie_host_init(struct pcie_port *pp)
> >  	ls_pcie_clear_multifunction(pcie);
> >  	ls_pcie_drop_msg_tlp(pcie);
> >  	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
> > +
> > +	ls_pcie_disable_outbound_atus(pcie);
> >  }
> >
> >  static int ls_pcie_msi_host_init(struct pcie_port *pp, diff --git
> > a/drivers/pci/host/pcie-designware.c
> > b/drivers/pci/host/pcie-designware.c
> > index 12afce1..e4d1203 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -172,6 +172,13 @@ static void dw_pcie_prog_outbound_atu(struct
> pcie_port *pp, int index,
> >  	dw_pcie_readl_rc(pp, PCIE_ATU_CR2, &val);  }
> >
> > +void dw_pcie_disable_outbound_atu(struct pcie_port *pp, int index) {
> > +	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | index,
> > +			  PCIE_ATU_VIEWPORT);
> > +	dw_pcie_writel_rc(pp, 0, PCIE_ATU_CR2); }
> > +
> >  static struct irq_chip dw_msi_irq_chip = {
> >  	.name = "PCI-MSI",
> >  	.irq_enable = pci_msi_unmask_irq,
> > diff --git a/drivers/pci/host/pcie-designware.h
> > b/drivers/pci/host/pcie-designware.h
> > index f437f9b..e998bfc 100644
> > --- a/drivers/pci/host/pcie-designware.h
> > +++ b/drivers/pci/host/pcie-designware.h
> > @@ -85,5 +85,6 @@ int dw_pcie_wait_for_link(struct pcie_port *pp);
> > int dw_pcie_link_up(struct pcie_port *pp);  void
> > dw_pcie_setup_rc(struct pcie_port *pp);  int dw_pcie_host_init(struct
> > pcie_port *pp);
> > +void dw_pcie_disable_outbound_atu(struct pcie_port *pp, int index);
> >
> >  #endif /* _PCIE_DESIGNWARE_H */
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
