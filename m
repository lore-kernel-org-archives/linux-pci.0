Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B505433023;
	Thu, 27 Aug 2026 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824971; cv=none; b=XeQSnBOzg+wuY0EyUwvhkse8ZKSYWNOdmAX0zfnqmKb5IUY2v82pll3REDbuaD78uneddw6Fy4lX7aE0kGB/EMvUAnR3VVc2iinNPfNzDtzHFh5TQ+6f8jcBl1xZkql0ZcGeLpzMrwJZ910k4hv0W3IAgwDoWXBgFpLpHQ6HL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824971; c=relaxed/simple;
	bh=BNdLXxak5kdHC+TC0oFhL1qzrsX05HV9fmdJDJghaH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzTuoczLNmdJl0z9mSwOzDT3k8PdQ+9NXJvkJBx0UhoHE9QJbwy3d1/uMGoXPw3bcnj0B28NN6U668zA3x1C9m5nHsxUO+z+krTrBr6K2JqA+AjaZ4pIKgmy62HWOsvxsTe/lDyNsX/A7Nnv8YVqSKQTXoVcm9fyP1ehB//cvfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+v36roJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+v36roJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027CE1F000E9;
	Thu, 27 Aug 2026 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787824961;
	bh=dQf0EcSPG/lL00BAwpznv3if/aUi/WWdO+E51TS0eTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N+v36roJgN1Ahe2dnmlEaZJRhN+0vnoYut+6+gaRFcmNzEDBRENNAbZQ3t1LOynZA
	 XENvmXFHrSTJj97NRtg70JHTt4ZCKbuWEbfDD1EzxqM+qYLJlhisiVxuYMzEdujJll
	 WJt71F59aR3ugO6fRFnOttOF/o2lyXkGThSVx+VmN/cDta3AOBwgo3No4osnZXo0o9
	 VqiOEv/fNWC0B5/qgcS72B21M/iz1/BIc6ughR9b06qnUxul0cXz9Pp77QpXOoW6dT
	 NlV8f7b6x74p2/cDEoC4sYXTqawtjzfPZnqFJIDYSMymfvhBY9EgMAaTvBBjNQN+i8
	 1OyIy2qRXLJCQ==
Date: Thu, 27 Aug 2026 12:02:39 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, jonathanh@nvidia.com, 
	mmaddireddy@nvidia.com, linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra264: Fix Link Capabilities register offset
Message-ID: <apAK-s-gl3moinqH@orome>
References: <20260827093919.2825467-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gh5ulkgsrpklu2rd"
Content-Disposition: inline
In-Reply-To: <20260827093919.2825467-1-lilinmao@kylinos.cn>


--gh5ulkgsrpklu2rd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] PCI: tegra264: Fix Link Capabilities register offset
MIME-Version: 1.0

On Thu, Aug 27, 2026 at 05:39:19PM +0800, Linmao Li wrote:
> The PCI Express Link Capabilities and Link Status registers are at offsets
> 0x0c and 0x12 from the capability header, respectively.  Since the driver
> uses 0x5a for Link Status, Link Capabilities starts at 0x54, not 0x56.
>=20
> Reading a 16-bit value at 0x56 returns the upper half of the Link
> Capabilities register.  When a hotplug-capable port has no link during
> probe, tegra264_pcie_icc_set() consequently derives the maximum speed and
> width from unrelated bits and requests the wrong interconnect bandwidth.
>=20
> Use the correct Link Capabilities offset.
>=20
> Fixes: 01c3c27a0ef6 ("PCI: tegra264: Add Tegra264 support")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/pci/controller/pcie-tegra264.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Yes, that's what the manual says, too. /o\

Acked-by: Thierry Reding <treding@nvidia.com>

--gh5ulkgsrpklu2rd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqQCzwACgkQ3SOs138+
s6FRuQ//Vn0cL2b/y8ldJhDUysOzenaabLXoX7Z15e3HRF+sf44gq2J8yZ4I+CbX
QnyQxilOGf32BYtDDP8gp5NtCNslPF78Ae7oJCn+ptK7IE3gGPPG7Krg22TwHEJa
qogcYeoIUM+qO1tAEwgXBCTgTaDV2g/BEn3ob5e3AywJpMYdOlTB5oft5fjmafNh
brS3ph0grpaMSbIJ/xI2a51PzYFrJrkBDXrhGVOpCPXICbTJFtObuSIPeK6vU9IJ
UF+RfPcxGvmc8bw7vMnzx5LZ4C7UHJA+fEhXTHvvN7M4zLoR6OKhlzOT/xQtLNSl
e3dAkN9Z+eIErStCH+fY8/AaRf8JAvOlAU7sredi6SX9NpnU/Ye75jJNbsyhmrWW
sUC44nIc2ixZ30NyVmdS3UOga19W+/ntnn4uLTIyPHBfIFsztGOF2jfhJmsudTlU
rIHBQDDdMuTh5otP+Djyj8BDlHHpveP+cX07TkxFhTMe1vRZdhpW55CWOOgwmvMl
npfnPltQd8bvAIWTnNnBR0zuznjEbxMXaT/KR1llKL0k1VWb+rSMZ7TZ1+mir8jH
Jze2EzqiPVgFunC3ujsyz1SAFdgWW0ax+i0q/yBjMh97l83oxoU49qc7RpSVgeNc
QdedTartQuTNkIAYuox7EtedWQvjPeOF68S37ok5pZsJHxk8fNE=
=vrY+
-----END PGP SIGNATURE-----

--gh5ulkgsrpklu2rd--
