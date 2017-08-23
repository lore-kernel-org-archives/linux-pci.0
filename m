Return-Path: <SRS0=RmmH=7Z=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=RmmH=7Z=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: Re: [PATCH v10] PCI: tango: Add MSI controller support
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>
References: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
Message-ID: <e32f8446-bd0b-0bc8-55b4-8dbebaeba101@sigmadesigns.com>
Date: Wed, 23 Aug 2017 14:59:42 +0200
MIME-Version: 1.0
In-Reply-To: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 22/08/2017 16:56, Marc Gonzalez wrote:

> @@ -76,7 +234,9 @@ static int tango_pcie_probe(struct platform_device *pd=
ev)
>  =09struct device *dev =3D &pdev->dev;
>  =09struct tango_pcie *pcie;
>  =09struct resource *res;
> -=09int ret;
> +=09struct irq_domain *msi_dom, *irq_dom;
> +=09struct fwnode_handle *fwnode =3D of_node_to_fwnode(dev->of_node);
> +=09int ret, reg, virq;
> =20
>  =09dev_warn(dev, "simultaneous PCI config and MMIO accesses may cause da=
ta corruption\n");
>  =09add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);

  CC      drivers/pci/host/pcie-tango.o
drivers/pci/host/pcie-tango.c: In function 'tango_pcie_probe':
drivers/pci/host/pcie-tango.c:257:6: warning: unused variable 'ret' [-Wunus=
ed-variable]
  int ret, reg, virq;
      ^~~

Hmmm, dunno how I managed to miss that...
Is the kbuild test robot enjoying a well-deserved vacation?

Bjorn, if/when you take the patch, can you first apply this fixup:

@@ -254,7 +254,7 @@ static int tango_pcie_probe(struct platform_device *pde=
v)
        struct resource *res;
        struct irq_domain *msi_dom, *irq_dom;
        struct fwnode_handle *fwnode =3D of_node_to_fwnode(dev->of_node);
-       int ret, reg, virq;
+       int reg, virq;
=20
        dev_warn(dev, "simultaneous PCI config and MMIO accesses may cause =
data corruption\n");
        add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);


Regards.
