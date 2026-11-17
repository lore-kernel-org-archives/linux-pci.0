Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794917848;
	b=Quvx8dfj+rwuDo1ehhy9Ug11QRfxj8Vk2yZUZceAKch2xCZOMIrU7epprdTDRQUhIDdK
	 U273Fv9LLX1KlPxQiV8KOq5Z097TBr0kPUK7DoyB5kYnf4fxucu9004NCIttUfh0keP9/
	 C/hZss5mMVnvcxyirZcyIGePrBT4oUNPVNHvJTS8moC9D/m+Hwm3lXUroeCEYwuX49Kk4
	 bUblWkXA/YxBN7HT/24JPtXw3F2bpEIMPlX5Zr4Ir42AGdIJCOjltnoIkD6N7qIvf9oss
	 CdtW5Pviq2e23jkDND1SFDKksoxaNOvpas5YrSg36uBVfPyMLPdwnnIxaMz+pXUTJ0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794917848;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jNT+l6BO0P+Rjx7Z6tCld6ldi+lTIwnNQobYF9qXSic=;
	b=4abL+8MmsyLDzqRa85C6Z5O3foXVsx5L0a9/cHJfbAhWE8C+w2c+Z9N1tGZvLpj39jy7
	 NINOp4iNTCFgGWvQm0snzIXAzk6njJaNl530Dx0UvrWk2zAbglgePwYAqyz+cQ2GqDGkL
	 a+/X9GMPb39JKSZE+I9pNbxENtjwPr0nfDze5CxjxE3uyzD2Sp72iVCD9G7nmIveZ9B3L
	 XSFJp7yvVe1Q6KiiheF1BZ1yTytVca+qNPjv+jrEg2nK2UL4pLepMCQYtxCWiVTwkGoiv
	 54oIU8G8yiehLIosHIv/jY/M8K2YahW+tFsuiIz6K6rP4YKNqzcEYxAbOSVKbcIwMHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hfa3r9c5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C2606A33F;
	Tue, 17 Nov 2026 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hfa3r9c5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99431F000CA;
	Tue, 17 Nov 2026 12:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794917848;
	bh=jNT+l6BO0P+Rjx7Z6tCld6ldi+lTIwnNQobYF9qXSic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hfa3r9c5j2esRkqiN9wTo1ASYUJcd4lQRrLzXuUgcpQ29+BpAFDi609CQXVmux5H5
	 lRHvc97eMFBhPkUoZZAEX7o7iR6lSyJgytpQqfTRkkR4WTx4H4L12VuVXVY0A+Vk/z
	 kg2lk8Z7OqOguGKRg2QtOxkAWn05TW8NDb78Yz0eB1p92bXkh11kUj6lO00J4IElsK
	 pJMMxu1tgbjtMdNIHxLUS6Z2jx1Pk/7TV95dBsRDfZgDl1v4BDv8ovNx9jk1UJuRW3
	 +zC399Cr6wD/HHgGv6D84FczMP7AOtiFWtsBqm9vwwsrmc7lDy+zl0UnkE65S0Wpjo
	 UD68dsWKtMUcg==
Date: Tue, 17 Nov 2026 13:17:25 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: tegra: Add node for the GB10B GPU on Tegra264
Message-ID: <avxBUt6Yo3oKbEZI@orome>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-5-4d843dda0b02@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stybnbzoyez3jyff"
Content-Disposition: inline
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-5-4d843dda0b02@nvidia.com>


--stybnbzoyez3jyff
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] arm64: tegra: Add node for the GB10B GPU on Tegra264
MIME-Version: 1.0

On Thu, Oct 29, 2026 at 12:32:07PM +0900, Mikko Perttunen wrote:
> While the integrated GB10B GPU on Tegra264 is on the PCI bus, it
> requires a BPMP power domain to be enabled or it won't enumerate on the
> bus. Therefore, describe it and the power domain in the device tree to
> allow the power domain to be enabled prior to enumeration.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra264.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra264.dtsi
> index 5ab34cd09a3d..4c8b320ecc40 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> @@ -3597,6 +3597,12 @@ pcie@0 {
>  				#address-cells =3D <3>;
>  				#size-cells =3D <2>;
>  				ranges;
> +
> +				gpu@0 {
> +					compatible =3D "pci10de,2b00";
> +					reg =3D <0x00010000 0x0 0x0 0x0 0x0>;
> +					power-domains =3D <&bpmp TEGRA264_POWER_DOMAIN_GPU>;
> +				};

My understanding is that the GPU is the only device on this PCI bus, so
wouldn't it be simpler to add the power-domains property to the bus' DT
node? I guess that's just another interpretation of how this hardware
works, and I like how this power control for PCI devices allows
individual devices to be turned on before the bus probes (there's a case
like this on Jetson Nano where Ethernet needs a GPIO pin to be pulled up
in order to start enumerating on the PCI bus, though I don't remember
how we ended up solving that, sources don't have any indication of that
GPIO being permanently set high or something).

Thierry

--stybnbzoyez3jyff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmr8RdIACgkQ3SOs138+
s6GMShAArcrx6nhaieugr5wJethsjuUbTSbYRpsOgOzwxZ5OYxgBA7fVwgTlx4AP
Rcvd+tEvW90FBxl7Ngm1M3/TJpSyydRF31CWUMFGIzMXvsiFJHkFhCt5R+TtQKCN
lg7WW7vkq5ElEdxc8w2qSLBV1idfcLSPYuznmRnn0lMsZbWXBDRcEXBS9zfFn//E
NZmOX3J1GGj29deR18rC3C1QcLYQnj68tBKQTXrePARhuelB5Ir2N95Eg3ah+yjW
LrGGSsdmTJ4OPeSI5RNdaM9r+1v6E7bUQUVnnTv+cAFJq+y3lllduzXXynaPH1kV
sZi41EKUlmL116fQShE54WDyOCq9nNdoNP2C5bsx6dJzeOIHSsg0UytwAYAPDUhB
e01jIJ6w8hAg9BFx8ChZuOrFRkn3J73a4gFXFe3Uci/+tzaGcjJ0F4E1rF0EOgkd
6WBPFXrxDjzfFTAu9/AeBWi5dJXiSf8G6ieJgkXcwQ74QJC/5vPMMudYTcKhi+eW
3UE2gRgSapL0QDlEp6EANfa8huV7s1+PII9xymHqFzdQhjbDW/6rFeVJH91BRlV0
Ai68z3yOmDYKtEP5nqxTO1cfKMivXcM69q1vxmcYgSVlRqaf3vJBwMzUBZ264mUC
iIA37350bQBA0Y0Og11yeT9aZ1oMwDpcgO1SMjGKLbOMUqNbBDg=
=BBt3
-----END PGP SIGNATURE-----

--stybnbzoyez3jyff--
