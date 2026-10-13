Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CFC352032;
	Tue, 13 Oct 2026 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908484; cv=none; b=gMckaLTFs6oz3dSK3+7gf5acuzTaVboU7myQAHNG8HUdUSUasQ0IWVlugwVrmITHJN9XNdCXugSpEhMJa3I6Z2O7p2a4cKICl8haknJOxaqBlAndiSzAVjLB9gJ6r7hmEKJk00lERJ1PAIdTJ66wkYtbpPaGlWnJMN2d8XsH6vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908484; c=relaxed/simple;
	bh=iaLpGPozs+lcxhbWVKUuCuOgErc+jjy6A6ykJAGe/Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltmBQjFvcPna00/KuPsHU23FGcqNFXD1BxXkm+wQWvDigqLTnt8dTja2PFQ6bWx1TTeTtO0WKqLkj2Ws2F5FVs6o/GJ+vN3fIgrV81eY5HMO8JM1zTaKCdD9XFLDh/JaBr0DI5OHWSh//jRdBixUTBev0rV+dnRJJLn7WA9JuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkKs3tVO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkKs3tVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00011F000FF;
	Tue, 13 Oct 2026 16:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908483;
	bh=4/N960r9v7bsfzgPbbFS0xVE+vxTj7/cpdvbyuoLrW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AkKs3tVO31Vti006Bt2XmFfdeWGPEjQtyXYAj27w6H8q77mkPNecZmr+MDKakL1YN
	 +XDPUi9wsGqLTK6SdQ0/WEyqVqlSGD7pgxtDI3U54csF0gZFjHrLQNbH5GX/F57NNS
	 1KrhD0NvWzFbCe1hFX0Uu/4QwvUpHdYNr7kkXw0QsgUpkp4m/HVomRvH3pXFYLFWyw
	 kbGPD+9ALAxL4o/fA7VC7v+WjDs9vVXQpW/uNoHU4gNJ+SUrO9GaLwqZiUarpRV+T1
	 u4LUeXrGyy24VEaLK0oFrZ8jwroSqLH9RukTIZMKg7U3M2HkMv2Lj+38DtcgpkwxBp
	 GR03rY4ab1XyA==
Date: Tue, 13 Oct 2026 18:21:21 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: phucduc.bui@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: tegra194: Propagate REFCLK select GPIO errors
Message-ID: <as5adjyCjltieSWK@orome>
References: <20261012094815.28160-1-phucduc.bui@gmail.com>
 <20261012094815.28160-2-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gmhx34dld5gay6lo"
Content-Disposition: inline
In-Reply-To: <20261012094815.28160-2-phucduc.bui@gmail.com>


--gmhx34dld5gay6lo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] PCI: tegra194: Propagate REFCLK select GPIO errors
MIME-Version: 1.0

On Mon, Oct 12, 2026 at 04:48:15PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>=20
> devm_gpiod_get_optional() returns NULL when the optional GPIO is not
> present, but may return -EPROBE_DEFER or other errors.
>=20
> The current code treats GPIO lookup errors as if the GPIO were not
> present.
>=20
> Check the return value and propagate errors from the REFCLK select GPIO
> lookup.
>=20
> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>=20
> Changes in v2:
>  - Follow the subject line capitalization style.
>=20
>  drivers/pci/controller/dwc/pcie-tegra194.c | 15 +++------------

Reviewed-by: Thierry Reding <treding@nvidia.com>

--gmhx34dld5gay6lo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrOWoAACgkQ3SOs138+
s6GgWBAAv61x3yEIfwh7djws4UsxaJLDwhkBPrKb/KfTHTBHEEZHzmuVmldhuf2a
HU1/O04A8OLW1yndlh55323rlQfgtz6TfQofeOx+1MWZoDt2O46zTRMuzbqzVPpe
iIyPXKh7v3ehA9KrlPy1d6q55cDRfnAPbFdaLyByzBJCXAJpuidoHvoVKgOw26mS
VEvvWVUydh49QZwU9Cd2NngxsDAiWUJzVH/3UIVVW4ct81WUugUzoUYsDf6g4SlD
XjXEC8pu419Km/KfJrcf72/pw/879efqHOTC2he187gJfBUkYbx8L6WKVgJP3Fgc
VuaB26V9vVOsvb7Uho6pxh/X7VvLBisJcSiA7bHxVs6DZPONvSvs9DtO8KMjKu3Y
gvek8V0grPc/xQMExaNKGGIU32kDjJRoO1l6NfSXk4/LeCCkjnPG85uLgp1TFww0
paZwncrg/5JWLd3uMnsqCvtTKTlaKFpcezGPKNw6wcN3cZIrUITEX/X4j4g9sTXb
rVxU8+3GnjtFyKBhvUVm6CXEDC/mgnwKJHBgV2KVoB3WI96sOGjddizAfnLHqUhX
b5YegwCjsAfZBj2DdO6sU7zNf63F3XlY7rtPz6KkFbSc5lWEi+CjHUKqSiuCGyMp
tBrnnDcXks9My5wQSJ6r0ibKatlmx9ECAhpGmGSAOXhAyU3y0Jg=
=a+Ne
-----END PGP SIGNATURE-----

--gmhx34dld5gay6lo--
