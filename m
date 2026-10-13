Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E167519914;
	Tue, 13 Oct 2026 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908445; cv=none; b=n9xIapHsOBLewH+4RE54VxJnxG4PUDnQAjfrbtO8QheBDAd4m6hRweD/9o0FfKHXZ6SoKrUP7a7a7RA+PMs1WaSuodgr1YKSaZGXBdpW5hM8amDFkWVnQbv1hStvLSIntPhj2lkqQHdV/jtiHZz3yI3HTff6ke/UpuKj8kq3cAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908445; c=relaxed/simple;
	bh=IbeZGNeQdX4zNHtKAEl5D+Z8c7tmAp6pWxJBUX+4t+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4eQBqgQeR3MADE3YvLAkt2Z91AtAeJA4+2K1Kpw2aEmyN2qvkpa+ZCUPlIrMxoui3UkZ3w/mHSzajkNz7p2PBRQpbKYE7o4PIRrXANsawdYo3lZqEMiBfHqwzc7KlnNMjfG2bM7oDpDv/62GZFm4joeqXDtxhYunBzH6w8UE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtCs1P3z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtCs1P3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0EB1F000FF;
	Tue, 13 Oct 2026 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908443;
	bh=iDX/r33ACF1gN19OAeYUXWdl1mueW1lcEtLS2OKMvFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YtCs1P3zjNoAlzVH2bQ12QTEBH18qidPKXqPorLs/0P44+i37h4wAu9QI0A6sUVxx
	 iMn6GKHefc/ba0rsMUEEKXK+P9W0jF0SNukv6BYsNhQmISMkByNNY+UmaVoxPxjVxC
	 WjA9Z+WLX93uIQ7GmB+SeCRxc76lXiBtzmqCNV0TvkcbcIP01z8TZR1ll/7oPpNf8M
	 vcan39YxM4br/2KXatIrtxM5uP49MTEfTUMIstYu+DES13fubZbJod83soKdJn1FtP
	 dHtETUxstjI5KQxyrLHP3L0GGRVPVberappR+3sFwKS6W6Y4e/+8boGrsl1/8GftLw
	 Vob2irlA0Kumg==
Date: Tue, 13 Oct 2026 18:20:41 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: phucduc.bui@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: tegra194: Use dev_err_probe() for PERST# GPIO
Message-ID: <as5aUXOL7YoHsLE2@orome>
References: <20261012094815.28160-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sp7y6i2ftncg2vab"
Content-Disposition: inline
In-Reply-To: <20261012094815.28160-1-phucduc.bui@gmail.com>


--sp7y6i2ftncg2vab
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] PCI: tegra194: Use dev_err_probe() for PERST# GPIO
MIME-Version: 1.0

On Mon, Oct 12, 2026 at 04:48:14PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>=20
> Use dev_err_probe() when getting the PERST# GPIO to simplify error
> handling and properly handle -EPROBE_DEFER.
>=20
> Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>=20
> Changes in v2:
>  - Follow the subject line capitalization style.
>  - Use "PERST#" in the subject, commit log, and dmesg text to match
>    spec usage.
>=20
>  drivers/pci/controller/dwc/pcie-tegra194.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--sp7y6i2ftncg2vab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrOWlkACgkQ3SOs138+
s6Gn3w/+PpoJmJexn1tK9/HjwGoGdE5uaF4eVZQNmDc1hZWUWJo4JAv+dsgP5EFj
irDwjhL6XebzMk3XMUn11XvP2iS7MBw9Cg8Gk7IqsY1Y5/UUfTzKLmuy4LYJDW9I
qvno3kmgEHfk5rsH5Je9vVRmCwiSGN5dUQWfSpVmHoyoSv5q4ljEQgiJ+SeFpugF
+YCYkxbcC408Xfd8tLYYiFDoAHypQW7SHaxLcOcFJ1hAjmM68c21HayH9V7rLTQp
mSDjjjZJXCd75ZAoQ0v/XJ7WSBmScO8BXRvowVTQM+Cqo0vxL/gzsykNV6mQsx5y
HQPKeemRQt1tvBp/68T+YDgg52oMHQUGc0MQKy81QTYgbQrbtma3IVkEmQN1oapk
LSj7J6LsY4zLcBMZ5PPXQHcPpEd/dzgSacft4DQZixnf2fpnOkiaTB+sSUnO/IJG
Bp1soDg2Sp7j3TPK/8rckT08xPPmeayq4YUKHB92tx+K1ib6XZRv5Y7ff/yce8XW
IcNlRy5Oj6VYbjB8RtZ5T8KihU4KBhzWUAAYFDvzdN5UopEdwVehK1zCSiTFVGD/
04HSS/srQElbxjOTxKow1WcXKVJjcpvRtZEQhsESBqu2tpjtiJS+dIdgx6cP7Upz
u85zUpWJ6VsAdhxQgEOEWqTubyK5IP6q+7ML7rL9F1MpYceTIWM=
=f/kQ
-----END PGP SIGNATURE-----

--sp7y6i2ftncg2vab--
