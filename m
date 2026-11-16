Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843627;
	b=IThDwGVwdnzy6y7Ao43Dbv/++MmnLeP+RG0Ia2oI+74Q0CplVvoJfv/essCyzqByceEX
	 xEzhYNFRNccUuNWXLeG4ePGSuGxPBXPDFNsLFutvtLjpcb/fv/CK59mreKpsMtlKdQg83
	 tvnIkzKAUgzsB2V8tEr8iPjMRpnggzevp8hprpRnnI/u9nhi703XoBxceYDOURmIEnvLj
	 Eb6VYKwOhS9/zX3wrVwB29vHx0W1iOtPJ5AMrbnkaL2BOTym4xrClbo2AHG6Hu913g1vr
	 A6qkVwjtxcQZ76dVt+vYJ5UvhF+rRl3CmIZgV7cilNNHJcbrUKfF35l8EAQZ5NKzUHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843627;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:
	 Content-Transfer-Encoding;
	bh=Z1RqDp5SVrAov4sDkfri2yFgVkNhSV3e7nfkBE4+w2U=;
	b=GNm1OZDp8WHyCq1SNXfBfMA55pQsSCKZ4+igIskkwx1H18RHUv6HziDQQLeyfNTWvCBI
	 RKMCUVi76uaHm2VrOGEbKup7W2ADwZC2qofOm1JsSWNEwZorzE8ngHdRJ7Fiq+b2JW9BL
	 JJRRGMipV4w6EQbSyY8BiimZgst2Rw1kzhmblxNohG3/Io3iETMojKD0m+Sij8P1nnwat
	 eUoW+/ZOkzBiSrH0WNTVe0oxjRREY8f9Y40dOcY58X1jNZzMfYP5cKBV21WBUwQ1FAWKy
	 loWLFctzipPz2971hj6Kdf4IfAfwR63CuTPT3RzBO1Nqm+osoj9KrqrpG4yiCOz3ItA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=fail reason="signature verification failed" header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=XLT6HZu0;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3516606A31C;
	Mon, 16 Nov 2026 15:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3516606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=XLT6HZu0
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3087F40E01E1;
	Mon, 16 Nov 2026 15:40:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SlQzc3L40ATu; Mon, 16 Nov 2026 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794843618; bh=poL8nuyiXIzqUO23vtCw4eNo0GCTM0RnMw4c3izJXXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLT6HZu08mkPkyhnpslZTCDZ7m3XBDccM3qvLY+rZNfKvyciphVOhLuXN4TOlyEq9
	 KCLzlWZIRCvPNJ1SMqCNzsSjtHxg69CRDfNsSBlMEOSFhA6RMW6AWvEcujXmv12PMI
	 FBexuXWaKQyIziMg3bSo+yGn8NswHQsA8G4PXz6YOuUnz2t28gP8AjA1Hgpj2hCPCj
	 LlF17vaK4BrBVySjqZhv4v+8GSIbLenyvu4xt3ZSKwNEMjhwIFF9MkfJssLnPuAKXR
	 3GGJi/5VDL10nXWyAiRWemv/6zc6lkymdPDRR9wMqTnQ8YYUP+SQ6abixDrfOIbtk6
	 e1jFkrEkuJB0qerZsT/lOGEkdy3OlB7joJTSA7HPZb4xfsY5zTR5ctH69k/NB4vnIH
	 iS+CL952/2dnfjdWF/EwjMUlnoyYB2MZHAqXCp/3f5caRJ3K4BiMSrHIKeBU8poBHi
	 kJuS72EfLbLSYKUa5uFqftGXFdgNz4u09gvuMGSFCgfK5s/XjNw0lM7RY/Q5kAo7Na
	 W9iVxyff+y7QWm8KjKH+HP/Qd3Ii9hTzKkV3m0xNcY4jL/asoGxpLY4Fn4YapLQuDy
	 8KTIo7f1EUsRf5cPH2QyltgKYRfhCEvCVsSiPESwk+AexRwZWmXDdNLZHxET7XXTmT
	 +SSicgM9+MywENSysoJSssaM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0423B40E015B;
	Mon, 16 Nov 2026 15:40:08 +0000 (UTC)
Date: Mon, 16 Nov 2026 07:40:05 -0800
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] i82875p_edac: Convert to
 pci_assign_unassigned_bus_resources()
Message-ID: <20261116154005.GAavsj1a11BRgBVtSd@fat_crate.local>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-7-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116152403.2672-7-ilpo.jarvinen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable

In addition to this, Tony, should we orphan this one too?

It is a P4-something-chipset...

On Mon, Nov 16, 2026 at 05:23:51PM +0200, Ilpo J=C3=A4rvinen wrote:
> The i82875p_edac driver scans single device and then attempts to assign
> its resource using pci_bus_assign_resources(). That function makes
> bridge window sizing disjoint from the assignment phase and is going to
> be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources() which is likely no-op in this cas=
e
> as it looks like bridges are not involved here.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/edac/i82875p_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
> index 869de8e372b3..59a92a209dea 100644
> --- a/drivers/edac/i82875p_edac.c
> +++ b/drivers/edac/i82875p_edac.c
> @@ -290,7 +290,7 @@ static int i82875p_setup_overfl_dev(struct pci_dev =
*pdev,
>  		if (dev =3D=3D NULL)
>  			return 1;
> =20
> -		pci_bus_assign_resources(dev->bus);
> +		pci_assign_unassigned_bus_resources(dev->bus);
>  		pci_bus_add_device(dev);
>  	}
> =20
> --=20
> 2.47.3
>=20

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
