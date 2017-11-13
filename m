Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:19130 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753978AbdKMR0y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2017 12:26:54 -0500
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Johan Hovold <johan@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: RE: [PATCH] PCI: keystone: fix interrupt-controller-node lookup
Date: Mon, 13 Nov 2017 17:26:48 +0000
Message-ID: <02ce9c8c8e1e4f3ea18989cc515e8ff1@ti.com>
References: <20171112122850.30804-1-johan@kernel.org>
 <20171113104306.GA27700@red-moon>
In-Reply-To: <20171113104306.GA27700@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----Original Message-----
From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]=20
Sent: Monday, November 13, 2017 5:43 AM
To: Johan Hovold
Cc: Karicheri, Muralidharan; Bjorn Helgaas; linux-pci@vger.kernel.org; linu=
x-kernel@vger.kernel.org; stable
Subject: Re: [PATCH] PCI: keystone: fix interrupt-controller-node lookup

Hi Johan,

On Sun, Nov 12, 2017 at 01:28:50PM +0100, Johan Hovold wrote:
> Fix child-node lookup during initialisation, which ended up searching=20
> the whole device tree depth-first starting at the parent rather than=20
> just matching on its children.
>=20
> To make things worse, the parent pci node was prematurely freed, while=20
> the child interrupt-controller node was leaked.

Thanks for fixing this. I would kindly ask you please to split the patch in=
 two since there are two bugs you are fixing at once.

Murali: please test/ack accordingly.

Thanks!

Acked-by: Murali Karicheri <m-karicheri2@ti.com>

Thanks !
Lorenzo

> Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
> Cc: stable <stable@vger.kernel.org>     # 3.18
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/pci/dwc/pci-keystone.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/dwc/pci-keystone.c=20
> b/drivers/pci/dwc/pci-keystone.c index 5bee3af47588..39405598b22d=20
> 100644
> --- a/drivers/pci/dwc/pci-keystone.c
> +++ b/drivers/pci/dwc/pci-keystone.c
> @@ -178,7 +178,7 @@ static int ks_pcie_get_irq_controller_info(struct key=
stone_pcie *ks_pcie,
>  	}
> =20
>  	/* interrupt controller is in a child node */
> -	*np_temp =3D of_find_node_by_name(np_pcie, controller);
> +	*np_temp =3D of_get_child_by_name(np_pcie, controller);
>  	if (!(*np_temp)) {
>  		dev_err(dev, "Node for %s is absent\n", controller);
>  		return -EINVAL;
> @@ -187,6 +187,7 @@ static int ks_pcie_get_irq_controller_info(struct key=
stone_pcie *ks_pcie,
>  	temp =3D of_irq_count(*np_temp);
>  	if (!temp) {
>  		dev_err(dev, "No IRQ entries in %s\n", controller);
> +		of_node_put(*np_temp);
>  		return -EINVAL;
>  	}
> =20
> @@ -204,6 +205,8 @@ static int ks_pcie_get_irq_controller_info(struct key=
stone_pcie *ks_pcie,
>  			break;
>  	}
> =20
> +	of_node_put(*np_temp);
> +
>  	if (temp) {
>  		*num_irqs =3D temp;
>  		return 0;
> --
> 2.15.0
>=20
