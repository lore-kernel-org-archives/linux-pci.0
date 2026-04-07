Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA033932E0;
	Tue,  7 Apr 2026 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550522; cv=none; b=biDWrEBcTuiO4EcF+00akPVShx9yQqzYtarFl2d5bLun9YQYMMhp+UAAJTkrjXb1AG7xFgPUpMq8SFWfuMtfA+N9hA7ZEYLRzBMNu2I3b25f3cMyiZ+ozXvPIwrcZOMkyrezMHboyeXrVRGpgCU49RErfOT3iGbQNQ6qCF2MNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550522; c=relaxed/simple;
	bh=TMh/80eYOICAABN55OY1l1N30tdiwSXaZ15pdc7Mxt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZ8zNgd7jojKSswjAe2VzS6SrPuAH5zYnRc5N5t8bgJjhGcHlXhc+BFT4ymn/QmJcLShF63xyrmz01nbUMm/VJynCqahd+JXMkrEGq0NgKBqkTBNGRsn47syWdmWJycQ+ebp83PkEv1oUDKMfTaBMPd241+ijXkqk2WIbQBhr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTu8Yl9J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTu8Yl9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C40C2BC9E;
	Tue,  7 Apr 2026 08:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775550522;
	bh=TMh/80eYOICAABN55OY1l1N30tdiwSXaZ15pdc7Mxt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTu8Yl9Jj8JV1bw/7ldvOxasAu7ztPQxNLx0+ZuPCMzOppCRicYln7Ph/wjB0GPxe
	 rUWTj+b+ItrKgtIxfLQ6xiCjj6/H0EkluavhiuC1TDwnqdWrM0RtAcv/pNDKxsP4oi
	 hZd8mHWMLqGvzS2hN/60/Sf52sknbl2YDu1x8MngYBKUNCf6zQWJx7dB72HWObfSI8
	 dzZHGUCnSwHha4pYkAHfbYM8yN48lxTKdNJ2V4GEZr3RfF7WT8IOFVTObcDLIUVdts
	 ABIP/4P/lpkSeoRlV7edZ9rX5aRgWzAHR3ZHL8f5QvMk3/OgD3FzVGpDU4RAKzTuES
	 rnGqW+gbEmmIw==
Date: Tue, 7 Apr 2026 10:28:39 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [GIT PULL] PCI: tegra: Changes for v7.1-rc1
Message-ID: <adS_spOOPBkD8E1r@orome>
References: <20260329155040.1448158-1-thierry.reding@kernel.org>
 <ac5ZGItkKNEI_W1-@orome>
 <lduiidifejglrep2laxzk2hep5rxpm3ysz5cwhdsglf6ciyjp4@z2dmnlvi7nhi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jlfnayivx7qgsm5f"
Content-Disposition: inline
In-Reply-To: <lduiidifejglrep2laxzk2hep5rxpm3ysz5cwhdsglf6ciyjp4@z2dmnlvi7nhi>


--jlfnayivx7qgsm5f
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GIT PULL] PCI: tegra: Changes for v7.1-rc1
MIME-Version: 1.0

On Thu, Apr 02, 2026 at 10:29:34PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Apr 02, 2026 at 01:56:48PM +0200, Thierry Reding wrote:
> > On Sun, Mar 29, 2026 at 05:50:39PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <thierry.reding@gmail.com>
> > >=20
> > > Hi Lorenzo, Bjorn,
> > >=20
> > > The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5=
b5f27f:
> > >=20
> > >   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/=
tegra-for-7.1-pci
> > >=20
> > > for you to fetch changes up to a0c0906bb09ee2f64690b3b8ffb458b4dbbcb2=
6e:
> > >=20
> > >   PCI: tegra: Add Tegra264 support (2026-03-28 15:00:05 +0100)
> > >=20
> > > This is v3 of the Tegra264 PCI patches that can be found here:
> > >=20
> > >   https://lore.kernel.org/linux-pci/20260326135855.2795149-1-thierry.=
reding@kernel.org/
> > >=20
> > > This looks ready now, but if there's any more feedback, I will happily
> > > respin these driver patches.
> > >=20
> > > Note that the shortlog and the diffstat below include the dependencies
> > > from the Tegra tree, and that subset will go in through the ARM SoC t=
ree
> > > as well. Effectively what's new in this pull request is just the two =
PCI
> > > patches, the rest is only included here to resolve the build time
> > > dependencies.
> >=20
> > I'm retracting this PR. DT maintainers aren't happy about how I handled
> > this, so it'll have to wait for another release cycle.
> >=20
>=20
> JFYI, We don't pull from PCI patches from other trees. We only merge them=
 by
> ourselves.

To clarify this again: the build dependencies are non-trivial and they
can't all go through the PCI tree because there are dependencies with at
least the Tegra tree, hence why a shared branch seemed the best solution
in this case.

But I guess this is all too complicated for everyone involved, so we'll
just try to get in the build dependencies for 7.1 and then defer the PCI
driver until 7.2. That way everyone can follow their standard process.

Thierry

--jlfnayivx7qgsm5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnUwDQACgkQ3SOs138+
s6F2qA//a+OQJYBw431CJFZ/5pvCts7DHrWD7yWIkF0uQsS3WuYbOP4WNzIco+Lr
6j/hW5gVNgW7vulkEX1Ph49W+Fd2xp1JEztI2RIXxnqfqop1u1p6cjYLjeIUmAMj
pw4yp0Km60XBaJJPDcslqktWjrsl3jWzyB6OJVGXfiACyFgGfd4EB4kaabwIjY7s
PwMm/dHfrI0wzCYtcdcaS2z0/QYZRnlE8YBGVJUrVbTihDFUTIvP47p7WWcn3fJ1
Ef9PNAV/6oyQtkBxClPAKkwRYjeupR1LuLWsbSDKjkEW4CJcGPn3eN5viZg8vuuI
m6IOoEh5LEtffG+i34itIlYfzzZDGMaB/LHwu8ni/0E5i6P8i8pc9cn9FC2pr00r
rABcS4CQenbpAwxF8m13vWgKCwndU415ZMRKBVm2OFJfoemkHFTl6amdyoVsTxwX
3z1MNvSzOBbRBTQ4n9rL1aG18Q3qsoJsq9X8IySifnLm4UutnbVemVE939+cJ/jf
DgU2TYXJ5Iz9X20F4BPhmP1xFOaUnduf7Lp1avsUyUWj1Ya095MXnZYF1rIj4/wq
+YHBZHAAIjxtzMXetPGqjpvhmXUhGWf3YcmM4qYU8xGHLNzK82BlFCTTm3c9ku6p
UeE+OpiqjQfVvAo158P7KLs9f+wyMTkLES17Xq2VNk3mSsKNinQ=
=8ggv
-----END PGP SIGNATURE-----

--jlfnayivx7qgsm5f--
