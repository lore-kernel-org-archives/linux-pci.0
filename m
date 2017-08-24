Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 24 Aug 2017 12:01:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: [PATCH v10] PCI: tango: Add MSI controller support
Message-ID: <20170824170147.GN31858@bhelgaas-glaptop.roam.corp.google.com>
References: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
 <e32f8446-bd0b-0bc8-55b4-8dbebaeba101@sigmadesigns.com>
MIME-Version: 1.0
In-Reply-To: <e32f8446-bd0b-0bc8-55b4-8dbebaeba101@sigmadesigns.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Mason <slash.tmp@free.fr>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 02:59:42PM +0200, Marc Gonzalez wrote:
> On 22/08/2017 16:56, Marc Gonzalez wrote:
> 
> > @@ -76,7 +234,9 @@ static int tango_pcie_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct tango_pcie *pcie;
> >  	struct resource *res;
> > -	int ret;
> > +	struct irq_domain *msi_dom, *irq_dom;
> > +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> > +	int ret, reg, virq;
> >  
> >  	dev_warn(dev, "simultaneous PCI config and MMIO accesses may cause data corruption\n");
> >  	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
> 
>   CC      drivers/pci/host/pcie-tango.o
> drivers/pci/host/pcie-tango.c: In function 'tango_pcie_probe':
> drivers/pci/host/pcie-tango.c:257:6: warning: unused variable 'ret' [-Wunused-variable]
>   int ret, reg, virq;
>       ^~~
> 
> Hmmm, dunno how I managed to miss that...
> Is the kbuild test robot enjoying a well-deserved vacation?
> 
> Bjorn, if/when you take the patch, can you first apply this fixup:

Sure, no problem.

> @@ -254,7 +254,7 @@ static int tango_pcie_probe(struct platform_device *pdev)
>         struct resource *res;
>         struct irq_domain *msi_dom, *irq_dom;
>         struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> -       int ret, reg, virq;
> +       int reg, virq;
>  
>         dev_warn(dev, "simultaneous PCI config and MMIO accesses may cause data corruption\n");
>         add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
> 
> 
> Regards.
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
