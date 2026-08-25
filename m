Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2C37E304;
	Tue, 25 Aug 2026 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638892; cv=none; b=DpIuzobR5QWUAe92FLqWHtUE1VwhUiiwMoUqkPP204wEfpr7/xKA7vBIw24o1Z5BfEgwzcL8pSQXx0r+OoXaha1AZufjj0DpyrFj9x6GpBsQPN38vtdO2HIuOARGNPvm4+9Dl+S3kX8UIbP8MmcHtHyU6jIFztH7dCxlQWj/Wu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638892; c=relaxed/simple;
	bh=QUAM9RS8icsL4/z6H4MGl4gtj5LU2y89iPVMpBiUPys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WMr7Rz9dwVXbgde+8ThvZswplrxashBidlMvmRVT7wtrQ+cPQ/RDDrXr6xZkOui4KdoweNEpeiZac5zOD0bAdZkHbdH8c7rqgpUFgPZ0ZuUedl3y5Gp9F/aw+uPC+3ohH9BwLXIjJUwWKWl4TKUTJeCe7rIbI7h/oooFoWwudCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmpuNh7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmpuNh7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0BC1F000E9;
	Tue, 25 Aug 2026 06:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787638890;
	bh=XzZbcjupMANndqq3j0Wp8rn0C4yhYOf5hqIwAAFp1wo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WmpuNh7lOS3J1hBSnVJoLh6hNHCwMbuKlhIJ1RrpQdpCN9+A97giISs1XV3l3wrZM
	 CkGEzKvglF+zhxCHj4HUKZMEtLD6oXHh3zmGXz0nDT4qlhnWH6CyN/D4W9cz0Y4TJs
	 9peEvTemh7Mehq4ibBt7TK0LQVo1ZMqb/UW22KmaQcqP9GNFiJaj/mFzhdgLI2mJ+Q
	 WdtWghzj7u4lQrvmjrOW0VCLrFUfciAe1GOM2M6p1zqk7H2lNJb353z1pLuKkA69LD
	 tvbcfJh400oG/I4bxS0eNuegfQkkE6dMLLPqCf/y1GNrRkNKuNu1ulw/oVFQugbL8o
	 DxwwAseaPGnJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: imx6: fix endpoint init error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhijian Han" <hanzhijian1991@gmail.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260825060340.3767635-1-hanzhijian1991@gmail.com>
References: <20260825060340.3767635-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 06:21:29 +0000
Message-Id: <20260825062130.3D0BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a doubl=
e-free of eDMA resources in the error path of dw_pcie_ep_init_registers().
--

--- Patch [1]: [PATCH v2] PCI: imx6: fix endpoint init error handling ---
commit 7a1537796f53756a148ff0c98174d765555b3298
Author: Zhijian Han <hanzhijian1991@gmail.com>

PCI: imx6: fix endpoint init error handling

This commit addresses unhandled errors from imx_pcie_host_init() during
endpoint initialization, preventing the driver from operating on unpowered
hardware. It also registers imx_pcie_host_exit() via the devres framework
to ensure host resources are properly released if subsequent initialization
steps fail.

Link: https://lore.kernel.org/all/20260824152857.DB9771F00A3D@smtp.kernel.o=
rg/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 39790e66b98dc..f0fb4e1b0ac6b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -1634,7 +1639,20 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pc=
ie,
>  	struct dw_pcie_rp *pp =3D &pci->pp;
>  	struct device *dev =3D pci->dev;
> =20
> -	imx_pcie_host_init(pp);
> +	ret =3D imx_pcie_host_init(pp);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Tear the host resources down via a devm action so that, on probe
> +	 * failure, the EPC device created by dw_pcie_ep_init() is
> +	 * unregistered (also via devres) before the clocks, regulators and
> +	 * PHY are switched off.
> +	 */
> +	ret =3D devm_add_action_or_reset(dev, imx_pcie_host_exit_action, pp);
> +	if (ret)
> +		return ret;
> +
>  	ep =3D &pci->ep;
>  	ep->ops =3D &pcie_ep_ops;
> =20

[Severity: High]
This isn't a bug introduced by this patch, but could the error handling
further down in imx_add_pcie_ep() cause a double-free of eDMA resources?

drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep() {
    ...
	ret =3D dw_pcie_ep_init_registers(ep);
	if (ret) {
		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
		dw_pcie_ep_deinit(ep);
		return ret;
	}
    ...
}

If dw_pcie_ep_init_registers() fails after dw_pcie_edma_detect() succeeds,
it handles the error by jumping to err_remove_edma:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_init_registers()=
 {
    ...
err_remove_edma:
	dw_pcie_edma_remove(pci);

	return ret;
}

When this error is returned to imx_add_pcie_ep(), it unconditionally calls
dw_pcie_ep_deinit(), which in turn calls dw_pcie_ep_cleanup() and executes
dw_pcie_edma_remove() a second time.

Since dw_edma_remove() doesn't nullify the chip->dw pointer after freeing
IRQs and unregistering the DMA device, does this second call attempt to free
the same resources again, potentially leading to a use-after-free, kernel
crash, or refcount underflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825060340.3767=
635-1-hanzhijian1991@gmail.com?part=3D1
