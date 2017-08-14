Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1502673155.7754.1.camel@mhfsdcap03>
Subject: Re: [PATCH] PCI: mediatek: add msi support for mt2712 and mt7622
From: honghui.zhang <honghui.zhang@mediatek.com>
To: Ryder Lee <ryder.lee@mediatek.com>
In-Reply-To: <1502499441.31707.6.camel@mtkswgap22>
References: <1502454469-29230-1-git-send-email-honghui.zhang@mediatek.com>
 <1502499441.31707.6.camel@mtkswgap22>
Date: Mon, 14 Aug 2017 09:12:35 +0800
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
 linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com, bhelgaas@google.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2017-08-12 at 08:57 +0800, Ryder Lee wrote:
> Hi Honghui,
> 
> On Fri, 2017-08-11 at 20:27 +0800, honghui.zhang@mediatek.com wrote:
> ...
> > +static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
> > +{
> > +	u32 val;
> > +
> > +	val = lower_32_bits((u64)(port->base + PCIE_MSI_VECTOR));
> > +	writel(val, port->base + PCIE_IMSI_ADDR);
> > +
> > +	val = readl(port->base + PCIE_INT_MASK);
> > +	val &= ~MSI_MASK;
> > +	writel(val, port->base + PCIE_INT_MASK);
> > +}
> > +
> >  static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> >  			     irq_hw_number_t hwirq)
> >  {
> > @@ -460,6 +574,18 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
> >  		return PTR_ERR(port->irq_domain);
> >  	}
> >  
> > +	/* Setup MSI */
> > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +		port->msi_domain = irq_domain_add_linear(node, MTK_MSI_IRQS_NUM,
> > +							 &msi_domain_ops,
> > +							 &mtk_pcie_msi_chip);
> > +		if (!port->msi_domain) {
> > +			dev_err(dev, "Failed to get a MSI IRQ domain\n");
> > +			return PTR_ERR(port->msi_domain);
> 
> Just return -ENOMEM. PTR_ERR(NULL) will cause a static checker warning.

I will fix this in the next version.

Thanks.
> 
> > +		}
> > +		mtk_pcie_enable_msi(port);
> > +	}
> > +
> >  	return 0;
> >  }
> 
> Ryder
> 




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
