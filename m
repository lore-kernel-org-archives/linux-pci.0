Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD973264CF;
	Thu, 26 Mar 2026 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521951; cv=none; b=KCxAlKC4+J54cY1f6E2yV73KR0xcpkB9F6Eep0gAoNZD9LXqpd2dzDefjpji14kloTOKJzvUpjL46TpcaKrRL8tMJHKYGEobjsp+C0Lx/RibzGDems7Mhwhj7aLLbJipnXkCwYKrFdnjgC/ctH1ITUAnpJ4B+jWsc/KBo3UBo0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521951; c=relaxed/simple;
	bh=gwmCgv72p7sCD6+T1WGsdcT7PHp8sVZciEnbe/CsLEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R74/08czz4LhnyCSoRWDHDI2RaNxLA6oXIQa02T7YthiyPc8bH5sRnGzeUNLKL9cxHRGtBE+4f5Rz2pWdqO0TtXE7yxZw431mmNnR7tZ1qrvRAgLYtRC63Ncmois+Rwkgh6J1krhqXzgusw2M7mtnAs3ZsrFr6batQtl5uuLaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7LM5v7h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7LM5v7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B191C116C6;
	Thu, 26 Mar 2026 10:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774521951;
	bh=gwmCgv72p7sCD6+T1WGsdcT7PHp8sVZciEnbe/CsLEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7LM5v7hUqc6AYZdOKx0KGSLX1S2t8ChtUpAOf57+pimivLWHFIHY+6Q+xba43/Vp
	 oLc80cpqq5Mf1bxahvXuqlMBWqrxvTtqqyeGO7PQHeoLRlXswFZwPeTWHBqtbADrmO
	 KzIOx4uv1S6lyR5ltjuB56jfRjiV6VeLfRUmjK2Gd+HwRzrx4TaIubc1+Mw9oeUurm
	 +tPhHX//hlLbVE/WyP42RnRdmYd1gy4kCJRKy4Kbn/UAzkNIos7Bl2r21nZo+hZwws
	 ZX2PWlST4qKPdImBzwwewaVWdmfgVVAvr7ogw43sOGGciMeU5qpTE8/LSPcp2jEAif
	 W1HB9PrYVWqkQ==
Date: Thu, 26 Mar 2026 11:45:48 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: tegra: Add Tegra264 support
Message-ID: <acUFJlWDAQQsr6Tm@orome>
References: <20260320225443.2571920-1-thierry.reding@kernel.org>
 <20260320225443.2571920-5-thierry.reding@kernel.org>
 <177441053067.494795.3366002972241434311.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v3xfvdas2vxthsof"
Content-Disposition: inline
In-Reply-To: <177441053067.494795.3366002972241434311.b4-review@b4>


--v3xfvdas2vxthsof
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/5] PCI: tegra: Add Tegra264 support
MIME-Version: 1.0

On Wed, Mar 25, 2026 at 12:48:50PM +0900, Mikko Perttunen wrote:
> On Fri, 20 Mar 2026 23:54:36 +0100, Thierry Reding <thierry.reding@kernel=
=2Eorg> wrote:
> > diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/contr=
oller/pcie-tegra264.c
> > new file mode 100644
> > index 000000000000..3ce1ad971bdb
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-tegra264.c
> > @@ -0,0 +1,527 @@
> > [ ... skip 123 lines ... ]
> > +	err =3D tegra_bpmp_transfer(pcie->bpmp, &msg);
> > +	if (err)
> > +		dev_info(pcie->dev, "failed to turn off PCIe #%u: %pe\n",
> > +			 pcie->ctl_id, ERR_PTR(err));
> > +
> > +	if (msg.rx.ret)
> > +		dev_info(pcie->dev, "failed to turn off PCIe #%u: %d\n",
> > +			 pcie->ctl_id, msg.rx.ret);
> > +}
>=20
> Ideally we would distinguish by message in these two cases. I suppose
> the %pe vs. %d does that, but it's not quite obvious.

Agreed. I think something like:

	"BPMP transfer failed for PCIe #%u: %pe"

would work better for the first message. That's roughly in line with
other error messages for BPMP message transfer errors (as opposed to the
errors returned from BPMP as a result of a successful transfer).

>=20
> > +
> > +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
> > +{
> > +	u32 value, speed, width, bw;
> > +	int err;
> > +
> > +	value =3D readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> > +	speed =3D FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> > +	width =3D FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> > +
> > +	bw =3D width * (PCIE_SPEED2MBS_ENC(speed) / BITS_PER_BYTE);
>=20
> PCIE_SPEED2MBS_ENC takes enum pci_bus_speed values rather than
> LNKSTA_CLS values. Perhaps it should be converted to a static inline
> function to catch such issues.

Nice catch. speed should be indexing pcie_link_speed to get the right
enum value. I've fixed that up.

>=20
> > +	value =3D MBps_to_icc(bw);
>=20
> The result of this is unused.

Ugh... this is supposed to be the value that's passed to icc_set_bw()
but I forgot to plumb that through. Fixed now.

>=20
> > [ ... skip 271 lines ... ]
> > +	pcie->ecam =3D pcie->cfg->win;
> > +
> > +	tegra264_pcie_init(pcie);
> > +
> > +	if (!pcie->link_up)
> > +		goto free;
>=20
> This path causes things to be freed, but the driver still probes. The
> remove callback will then try to remove things again.

I think the intent of the original code was to allow the driver to
continue to probe, so that the root complex would show up, but with no
devices enumerated. I don't know if we really need that, since we also
have no hotplug support there's never going to be any devices added to
the bus if the initial link up fails, as far as I can tell. I'll turn
this into a failure for now, we can revisit this if we ever need hotplug
support.

Thanks,
Thierry

--v3xfvdas2vxthsof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnFDlkACgkQ3SOs138+
s6EUgQ//Qtl0L+Adza0Be9PMofDMHUbj2CJ+zETl/Jb9o0fkh/STxEFnWW3VyR7r
dY+Rpqr9+ASIiolDErnwnX5bkvo5Rpcxcq+1FEQwm5OtD7YbfSBovtbee2AKo5HL
0XyEzMq2oysUzNjN1NYvjdgF43B52cU7LRMzu2SVwIRt1pXa89RQEyGof/9J8UH+
E+ZhKdZiLiwOtBLSR9G3s6oL6zd44swEStrtmDftEU7gF89n08h6Ciitzycm/pww
HB4J9fjoQVtedXaTegd4IL07SZ3nOdgo3m8xFDneL4YvMil2oourWl+PcQ8NmU0e
8anjZ8IgKDnIjnpuoENz/RGRah//Uu4Xr9ZtUUvjhWaK3yvDTvgE5Onl6OP0FKiG
D4QR3jGAl/zdH1siNuCVyYEp6DuY/s0BEt7IAS5Aj0dqt3oVYg4DrUVH7GrkAeHB
/5bHVfudgY4w9cg/p2diGi5Ue9R0N3qItJoTQ0D0+5oLfjAj1ZQdkVwHikzGsF3H
PR/7wgTDr2PQEpbYL+EjBvUGgo5NgCBwW9JhhYKGw6QZrtpHShnenj+H1assjrDj
Dsi99ZJrBo9e1FAVxV2tMXetYVfFa845ziSJ9L4cotB0VP3zEugegAvd4nQhLQ8j
eI84IunPCxiW7byJoxBtUg8KY5SZz3K3RdTgDy02iXYukc9i4pE=
=Gviq
-----END PGP SIGNATURE-----

--v3xfvdas2vxthsof--
