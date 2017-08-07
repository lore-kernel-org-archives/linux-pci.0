Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1502097481.24341.32.camel@mtksdaap41>
Subject: Re: [PATCH v3 5/6] PCI: mediatek: Add new generation controller
 support
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Ryder Lee <ryder.lee@mediatek.com>
Date: Mon, 7 Aug 2017 17:18:01 +0800
In-Reply-To: <1501985190.8058.20.camel@mtkswgap22>
References: <cover.1501846816.git.honghui.zhang@mediatek.com>
 <2adcb5f915eb8bd5817592ea32974eb25da02e4f.1501846816.git.honghui.zhang@mediatek.com>
 <1501985190.8058.20.camel@mtkswgap22>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, yt.shen@mediatek.com, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, robh@kerenl.org,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com, bhelgaas@google.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2017-08-06 at 10:06 +0800, Ryder Lee wrote:
> Hi Honghui,
> 
> If you plan to send next version, then I would suggest some minor
> changes.
> 
> On Fri, 2017-08-04 at 20:06 +0800, honghui.zhang@mediatek.com wrote:
> > +#define PCIE_CRSTB		BIT(3)
> > +#define PCIE_PERSTB		BIT(8)
> > +#define PCI_LINKDOWN_RST_EN	GENMASK(15, 13)
> 
> PCIE_LINKDOWN_RST_EN

Thanks, I will change it in the next version.

> 
> > +#define PCIE_LINK_STATUS_V2	0x804
> > +#define PCIE_PORT_LINKUP_V2	BIT(10)
> > +
> > +
> > +static int mtk_pcie_hw_rd_cfg(struct mtk_pcie_port *port, u32 bus, u32 devfn,
> > +			      int where, int size, u32 *val)
> > +{
> > +	int reg, shift = 8 * (where & 3);
> 
> int reg => u32

sharp eyes, thanks.

> 
> > +	/* Write PCIe Configuration Transaction Header for cfgrd */
> > +	writel(CFG_HEADER_DW0(CFG_WRRD_TYPE_0, CFG_RD_FMT),
> > +	       port->base + PCIE_CFG_HEADER0);
> > +	writel(CFG_HEADER_DW1(where, size), port->base + PCIE_CFG_HEADER1);
> > +	writel(CFG_HEADER_DW2(where, PCI_FUNC(devfn), PCI_SLOT(devfn), bus),
> > +	       port->base + PCIE_CFG_HEADER2);
> > +
> > +	/* Trigger h/w to transmit Cfgrd TLP */
> > +	reg = readl(port->base + PCIE_APP_TLP_REQ);
> > +	writel(reg | APP_CFG_REQ, port->base + PCIE_APP_TLP_REQ);
> > +
> > +	/* Check completion status */
> > +	if (mtk_pcie_check_cfg_cpld(port))
> > +		return PCIBIOS_SET_FAILED;
> > +
> > +	/* Read cpld payload of Cfgrd */
> > +	*val = readl(port->base + PCIE_CFG_RDATA);
> > +
> > +	switch (size) {
> > +	case 4:
> > +		break;
> > +	case 3:
> > +		*val = (*val >> shift) & 0xffffff;
> > +		break;
> > +	case 2:
> > +		*val = (*val >> shift) & 0xffff;
> > +		break;
> > +	case 1:
> > +		*val = (*val >> shift) & 0xff;
> > +		break;
> > +	default:
> > +		return PCIBIOS_BAD_REGISTER_NUMBER;
> > +	}
> 
> Do we really need case 3? I guess case 1, 2 or 4 should be enough.
> 

I will change this as the following snippet:
	if (size == 1)
		*val = (*val >> (8 * (where & 3))) & 0xff;
	else if (size == 2)
		*val = (*val >> (8 * (where & 3))) & 0xffff;

thanks.

> > +	return PCIBIOS_SUCCESSFUL;
> > +}
> > +
> > +static int mtk_pcie_hw_wr_cfg(struct mtk_pcie_port *port, u32 bus, u32 devfn,
> > +			      int where, int size, u32 val)
> > +{
> > +	/* Write PCIe Configuration Transaction Header for Cfgwr */
> > +	writel(CFG_HEADER_DW0(CFG_WRRD_TYPE_0, CFG_WR_FMT),
> > +	       port->base + PCIE_CFG_HEADER0);
> > +	writel(CFG_HEADER_DW1(where, size), port->base + PCIE_CFG_HEADER1);
> > +	writel(CFG_HEADER_DW2(where, PCI_FUNC(devfn), PCI_SLOT(devfn), bus),
> > +	       port->base + PCIE_CFG_HEADER2);
> > +
> > +	/* Write cfgwr data */
> > +	val = val << 8 * (where & 3);
> > +	writel(val, port->base + PCIE_CFG_WDATA);
> > +
> > +	/* Trigger h/w to transmit Cfgwr TLP */
> > +	val = readl(port->base + PCIE_APP_TLP_REQ);
> > +	val |= APP_CFG_REQ;
> > +	writel(val, port->base + PCIE_APP_TLP_REQ);
> > +
> > +	/* Check completion status */
> > +	return mtk_pcie_check_cfg_cpld(port);
> > +}
> > +
> > +static int mtk_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> > +				int where, int size, u32 *val)
> > +{
> > +	struct mtk_pcie_port *port = NULL, *iter, *tmp;
> > +	struct mtk_pcie *pcie = bus->sysdata;
> > +	u32 bn = bus->number;
> > +	int ret;
> > +
> > +	list_for_each_entry_safe(iter, tmp, &pcie->ports, list)
> > +		if (iter->index == PCI_SLOT(devfn)) {
> > +			port = iter;
> > +			break;
> > +		}
> > +
> > +	if (!port) {
> > +		*val = ~0;
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +	}
> 
> list_for_each_entry(), since you don't really remove or free something.
> 
> I know you need to find port->base to write/read configuration space. I
> think it's better to move this part to another function. You can take a
> look at pci-mvebu.c mvebu_pcie_find_portmvebu().


Sure, I will add the mtk_pcie_find_port interface, then the code is a
bit more readable.

thanks.

>  
> > +	ret = mtk_pcie_hw_rd_cfg(port, bn, devfn, where, size, val);
> > +	if (ret)
> > +		*val = ~0;
> > +
> > +	return ret;
> > +}
> > +
> > +static int mtk_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> > +				 int where, int size, u32 val)
> > +{
> > +	struct mtk_pcie_port *port = NULL, *iter, *tmp;
> > +	struct mtk_pcie *pcie = bus->sysdata;
> > +	u32 bn = bus->number;
> > +
> > +	list_for_each_entry_safe(iter, tmp, &pcie->ports, list)
> > +		if (iter->index == PCI_SLOT(devfn)) {
> > +			port = iter;
> > +			break;
> > +		}
> > +
> > +	if (!port)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> 
> Ditto.
> 
> > +	return mtk_pcie_hw_wr_cfg(port, bn, devfn, where, size, val);
> > +}
> > +
> > +static struct pci_ops mtk_pcie_ops_v2 = {
> > +	.read  = mtk_pcie_config_read,
> > +	.write = mtk_pcie_config_write,
> > +};
> > +
> > +static int mtk_pcie_startup_ports_v2(struct mtk_pcie_port *port)
> > +{
> > +	struct mtk_pcie *pcie = port->pcie;
> > +	struct resource *mem = &pcie->mem;
> > +	u32 val;
> > +	size_t size;
> > +	int err;
> > +
> > +	/* mt7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> > +	if (pcie->base) {
> > +		val = readl(pcie->base + PCIE_SYS_CFG_V2);
> > +		val |= PCIE_CSR_LTSSM_EN(port->index) |
> > +		       PCIE_CSR_ASPM_L1_EN(port->index);
> > +		writel(val, pcie->base + PCIE_SYS_CFG_V2);
> > +	}
> > +
> > +	/* Assert all reset signals */
> > +	writel(0, port->base + PCIE_RST_CTRL);
> > +
> > +	/*
> > +	 * Enable PCIe link down reset, if link status changed from link up to
> > +	 * link down, this will reset MAC control registers and configuration
> > +	 * space.
> > +	 */
> > +	writel(PCI_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
> > +
> > +	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
> > +	val = readl(port->base + PCIE_RST_CTRL);
> > +	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> > +	       PCIE_MAC_SRSTB | PCIE_CRSTB;
> > +	writel(val, port->base + PCIE_RST_CTRL);
> > +
> > +	/* PCIe v2.0 need at least 100ms delay to train from Gen1 to Gen2 */
> 
> /* 100ms timeout value should be enough for Gen1/2 training */ for
> consistency.
> 
> > +	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
> > +				 !!(val & PCIE_PORT_LINKUP_V2), 20,
> > +				 100 * USEC_PER_MSEC);
> > +	if (err)
> > +		return -ETIMEDOUT;
> > +
> > +	/* Set INTx mask */
> > +	val = readl(port->base + PCIE_INT_MASK);
> > +	val &= ~INTX_MASK;
> > +	writel(val, port->base + PCIE_INT_MASK);
> > +
> > +	/* Set AHB to PCIe translation windows */
> > +	size = mem->end - mem->start;
> > +	val = AHB2PCIE_BASEL(mem->start) | AHB2PCIE_SIZE(fls(size));
> > +	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> > +
> > +	val = AHB2PCIE_BASEH(mem->start);
> > +	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
> > +
> > +	/* Set PCIe to AXI translation memory space.*/
> > +	val = fls(0xffffffff) | WIN_ENABLE;
> > +	writel(val, port->base + PCIE_AXI_WINDOW0);
> > +
> > +	return 0;
> > +}
> 
> Ryder
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
