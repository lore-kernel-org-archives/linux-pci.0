Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F4D35957;
	Thu,  2 Apr 2026 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131011; cv=none; b=RMJUgtCDJOkg4QSSckfyfzq8I2GqUwXiliDHmEpMTMqhIC13flJkVMTpbK/LBDGXMPrvQzAJMBoMri3pgc29TAT4dbAdvgAqMxanbrD0rYouEQZG6gNEvdbbVCPs+VaiuRTaw35a0M+pMhN80UmBDsursVvp+U4R/ZrWkGT1Kfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131011; c=relaxed/simple;
	bh=qHCU7KuluEAoAYrPL6lU76Qh5ztSdBB3Rk7YSr8E/G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0fOaiksBLlAMo3xyCTHugs99SjJAn+wxgAhdQM6E06SKL1uriUHYGhs1c5yi6OlqjADTfW2qoF/be+R3mE5rbUwNG+v/LuVXf0mlmpaKNyWTwgDAvkTCc7PqDGnHVqCUEEip8Urhifi/q1s0mS/dy8hgglt9K9I37sxG6VGC84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpWiI7ek; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpWiI7ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC70C19423;
	Thu,  2 Apr 2026 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775131010;
	bh=qHCU7KuluEAoAYrPL6lU76Qh5ztSdBB3Rk7YSr8E/G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpWiI7ekZllBUgA55FaznDKG1bFcCKC2+4R4JtbHAzKkyWLLIyCXw7+2m0enLxC73
	 g6e6UT8G38pZA71oYvaJ8IkdSl8QAnHOHk+JYeLKX6+vmhRdext5FoJC0Y4TyWXKQp
	 AVhE0bVLVSNrhPs6WOFP0CZiY0AL5ybUqt4nlUDLm3zjKLizJV21M2taOlnn8G5KuM
	 o9Wll3Q60a//L2kHi9u6pa8whDvPksfddKcvgUfd9b3rhu4CmlPQUvGdT5NLbP9aSw
	 Wf759oAmL/lsxNZHVTKoYr07FbdfDGkL3fnIxm/Mb0eQ8eAy9JkoJxwIfVxBK4zSWx
	 rU2eAydACfcBQ==
Date: Thu, 2 Apr 2026 13:56:48 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [GIT PULL] PCI: tegra: Changes for v7.1-rc1
Message-ID: <ac5ZGItkKNEI_W1-@orome>
References: <20260329155040.1448158-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sqygtkd3gjj3h2rc"
Content-Disposition: inline
In-Reply-To: <20260329155040.1448158-1-thierry.reding@kernel.org>


--sqygtkd3gjj3h2rc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GIT PULL] PCI: tegra: Changes for v7.1-rc1
MIME-Version: 1.0

On Sun, Mar 29, 2026 at 05:50:39PM +0200, Thierry Reding wrote:
> From: Thierry Reding <thierry.reding@gmail.com>
>=20
> Hi Lorenzo, Bjorn,
>=20
> The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f2=
7f:
>=20
>   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegr=
a-for-7.1-pci
>=20
> for you to fetch changes up to a0c0906bb09ee2f64690b3b8ffb458b4dbbcb26e:
>=20
>   PCI: tegra: Add Tegra264 support (2026-03-28 15:00:05 +0100)
>=20
> This is v3 of the Tegra264 PCI patches that can be found here:
>=20
>   https://lore.kernel.org/linux-pci/20260326135855.2795149-1-thierry.redi=
ng@kernel.org/
>=20
> This looks ready now, but if there's any more feedback, I will happily
> respin these driver patches.
>=20
> Note that the shortlog and the diffstat below include the dependencies
> from the Tegra tree, and that subset will go in through the ARM SoC tree
> as well. Effectively what's new in this pull request is just the two PCI
> patches, the rest is only included here to resolve the build time
> dependencies.

I'm retracting this PR. DT maintainers aren't happy about how I handled
this, so it'll have to wait for another release cycle.

Thierry

--sqygtkd3gjj3h2rc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnOWYAACgkQ3SOs138+
s6G6Zw//QYfwJuUWFp0oCnT5XmsMnUIYQjEZ7Mb84h8F7NAoTGNuGU1SdZ/wMvWA
L67jiQNK1ZbML3KngD2kwrraSXGN8Sk1L421cBZq/kLbw4U18R6mmPlnoeWbYt2z
voD8D7NIr0queFKrNfsChepCM3UPOpMGIDi/De6fsj5Eir6wo0Lh28bXTSKiSN0w
elPFQ9r43OK9wTpz5HAC2ouKiGGg/2KBgofvNyA0iLGTFg+kWnk+sdrIWn+CaBrO
XqAqsbhx4tyduGA8ssg5y2nt8N14WoQWgFcRPS/d6XY/7/yrqyiNdN4EVtx/E2CC
Xa9wGUOYG3zTPU3OA/r8eDzvdjUTHhZtwkDQcmLdCcFKWKIS1O9cKdvNOXXlK9JE
/Qbi1rQ1Ryw89qRfTpu6FWQUC2uWVmK+n7+3mz8FAZXmWdsAByBiSp1wYA6wDdSz
NTjEcoU+QhwPhYel/n7OmxACCXL6UeAarvM8MJANKeOcNuZ9vKCLi8v1mbxNkGN+
T50bqdeyVnV/FQKvDTSswR+jg5x4gKnTQ3tXiKjNqubadyUc6e1Ucfm3Ee/YJ7JI
SIzEP3X+9FUF8y2DBLtCpmbenSLvJrHwf9yVkWDuPHL9uM1YLU3dXoU2KDv64/uG
4xxJd7Y3ALBFQxGkfs2wnXaURo49jytq9ClRcMh8/BhiuH6hQt4=
=DzGB
-----END PGP SIGNATURE-----

--sqygtkd3gjj3h2rc--
