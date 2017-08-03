Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:49213 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750829AbdHCFHx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2017 01:07:53 -0400
From: HARUNOBU KUROKAWA <harunobu.kurokawa.dn@renesas.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "horms@verge.net.au" <horms@verge.net.au>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: rcar-pcie: Fix memory leak when no PCIe card is
 inserted
Date: Thu, 3 Aug 2017 05:07:47 +0000
Message-ID: <PS1PR0601MB14659C69D22D403547B9F1B4C5B10@PS1PR0601MB1465.apcprd06.prod.outlook.com>
References: <20170802071320.28674-1-harunobu.kurokawa.dn@renesas.com>
 <20170802090307.GA24167@red-moon>
In-Reply-To: <20170802090307.GA24167@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi=20

> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: Wednesday, August 2, 2017 6:03 PM
> To: HARUNOBU KUROKAWA <harunobu.kurokawa.dn@renesas.com>
> Cc: horms@verge.net.au; bhelgaas@google.com; linux-pci@vger.kernel.org; l=
inux-renesas-soc@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] PCI: rcar-pcie: Fix memory leak when no PCIe card is=
 inserted
>=20
> On Wed, Aug 02, 2017 at 04:13:20PM +0900, Harunobu Kurokawa wrote:
> > When no PCIe card is inserted, there is a memory leak as
> > pci_free_resource_list is not called before returning.
> >
> > Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> > ---
> >  drivers/pci/host/pcie-rcar.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-rcar.c
> > b/drivers/pci/host/pcie-rcar.c index ac80fbb..9b06de6 100644
> > --- a/drivers/pci/host/pcie-rcar.c
> > +++ b/drivers/pci/host/pcie-rcar.c
> > @@ -1190,14 +1190,15 @@ static int rcar_pcie_probe(struct
> > platform_device *pdev)
> >
> >  	return 0;
> >
> > -err_free_bridge:
> > -	pci_free_host_bridge(bridge);
> > -
> >  err_pm_put:
> >  	pm_runtime_put(dev);
> >
> >  err_pm_disable:
> >  	pm_runtime_disable(dev);
> > +
> > +err_free_bridge:
> > +	pci_free_host_bridge(bridge);
> > +	pci_free_resource_list(&pcie->resources);
> >  	return err;
> >  }
>=20
> The error code path needs fixing but not like this (with a single patch l=
umping all fixes - well, actually it does not - together).
>=20
> Step one, patch below. Step two free the &pci->resources list (which IIUC=
 was not freed even before commit 90634e854079) in a separate
> patch.
>=20
> Am I missing something ?
>=20
> Please apply, check and repost the patch if it is ok, thanks.
Yes, I'll sprit the patch and repost them.

Best regards,
Kurokawa.


>=20
> -- >8 --
> Subject: [PATCH] PCI: rcar: Fix error exit path
>=20
> Commit 90634e854079 ("PCI: rcar: Convert PCI scan API to
> pci_scan_root_bus_bridge()") converted PCI root bus scan API to the new p=
ci_scan_root_bus_bridge() API; in the process some error
> paths were not updated correctly which may cause memory leaks.
>=20
> Fix the driver error exit path reinstating the previous correct error exi=
t behaviour.
>=20
> Fixes: 90634e854079 ("PCI: rcar: Convert PCI scan API to pci_scan_root_bu=
s_bridge()")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/pci/host/pcie-rcar.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c =
index 246d485..007523e 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -471,10 +471,8 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
>  		bridge->msi =3D &pcie->msi.chip;
>=20
>  	ret =3D pci_scan_root_bus_bridge(bridge);
> -	if (ret < 0) {
> -		kfree(bridge);
> +	if (ret < 0)
>  		return ret;
> -	}
>=20
>  	bus =3D bridge->bus;
>=20
> @@ -1190,14 +1188,15 @@ static int rcar_pcie_probe(struct platform_device=
 *pdev)
>=20
>  	return 0;
>=20
> -err_free_bridge:
> -	pci_free_host_bridge(bridge);
> -
>  err_pm_put:
>  	pm_runtime_put(dev);
>=20
>  err_pm_disable:
>  	pm_runtime_disable(dev);
> +
> +err_free_bridge:
> +	pci_free_host_bridge(bridge);
> +
>  	return err;
>  }
>=20
> --
> 2.10.0
