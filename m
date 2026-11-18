Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=140.211.166.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041060;
	b=yCyn6DSnnkT6IeuzL8nqpCA69TUotYMa3TYivU/1tsBRc6j9AILFV+yraOhT7X3kqNsA
	 5diW0KnfIQfo3EZnE2Sp0Dbcc/101ILntNwPgXLNZmofRJYJ8Lw9CID5njaU+JcoupSH8
	 7LxGnacvfD9nMtIkh3Q8HuIHgC3Ghy8kM9DDCGCFf0cddkr6GVnIKwW4p0nVV5LGdp0sW
	 SaY89AJ7PP6/zUFARspUZlrFXPbi9Qwogrb8vCagccfI476pM/hDQC1ab9eCOyS0c2n/9
	 A0aUm2BcOV1x9Yo768qwzbjH1FTscI6/mON26q5qkDuLpI2cpawRyZKsV95vMkhFzSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041060;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version;
	bh=YyI7TOzf2UvWpDcu5o8mNw71tdXHWAcQdrzoZghaDMI=;
	b=TYezmzkePK6vLmq5mVU/sIJ+hD3ztD9YHWQgOi/tIxfgVT1ZHjzG4qUEY9VS7+FEWsxj
	 DMGt1EWRZaF3sd/ErsmUkpKjp+bm6aj9HHwBdpbZfGQI3eBDzeQ5Q0e0g0+YdQFMs/NXR
	 kglKIQO/p3Y2EzsiCmG3FUi8ldGJd+6chmehb7+8fKdCuqwjXROo9axenqMIyL7bSxCFy
	 ejomw0oeRQaIzZ3bg1QADwHQtIysxX5fVy/5E4RtFprubx/Xh9+MMGHnXlRAyjsGEA5AL
	 h1zFVxAaFMllxSAEd3w7oLYiq6rTJlWAiWIYwcfYcoZ9LU5h2dkNv2311Ere312e2nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentoo.org;
	spf=pass smtp.mailfrom=gentoo.org;
	arc=none smtp.remote-ip=140.211.166.183
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EC1606A325
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 22:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10EC1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from 9.b.8.c.1.6.8.7.6.b.f.2.6.1.2.4.c.6.e.0.c.6.2.0.0.b.8.0.1.0.0.2.ip6.arpa (unknown [IPv6:2001:8b0:26c:e6c:4216:2fb6:7861:c8b9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: chewi)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4045E342592;
	Wed, 18 Nov 2026 22:30:58 +0000 (UTC)
Message-ID: <a112657de590aefc2b306ebc9e6771cbaa76ae82.camel@gentoo.org>
Subject: Re: PCI: dw-rockchip: Unable to boot Quartz64 Model B from NVMe
 since reset changes
From: James Le Cuirot <chewi@gentoo.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>, Manivannan Sadhasivam	
 <manivannan.sadhasivam@oss.qualcomm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, 	linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Shawn Lin	 <shawn.lin@rock-chips.com>
Date: Wed, 18 Nov 2026 22:30:45 +0000
In-Reply-To: <av3WcJyt_tRXNj2l@ryzen>
References: <08cc96c5171fc969b074371692e6d95d46eba60b.camel@gentoo.org>
	 <av3WcJyt_tRXNj2l@ryzen>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ebQo5WGk+sMw/9Rs5xM+"
User-Agent: Evolution 3.60.2 
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-ebQo5WGk+sMw/9Rs5xM+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-11-18 at 17:46 +0100, Niklas Cassel wrote:
> Hello James,
>=20
> On Wed, Nov 18, 2026 at 04:03:11PM +0000, James Le Cuirot wrote:
> > Hello Wilfred,
> >=20
> > Unfortunately, since your commit "PCI: dw-rockchip: Implement
> > .reset_root_port() and use for link down" (b376b3ff9cb0527), I have bee=
n
> > basically unable to boot my Quartz64 Model B from NVMe. Sometimes if I =
wait
> > long enough, it will eventually work, albeit very slowly. If I revert t=
his
> > (and 4e9f69d08253) against 7.3.5, then it boots normally. Here is the r=
elevant
> > output.
>=20
> There are some dwc-rockchip fixes queued on the following branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=3Dcont=
roller/dwc-rockchip
>=20
> It would be interesting to see if using this branch makes a differnce.
>=20
>=20
> Kind regards,
> Niklas

Thanks for the suggestion. I rebased these against 7.3.5 (with 85203c831a8)=
,
but sadly it made no difference.

--=-ebQo5WGk+sMw/9Rs5xM+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEDBAAWCgCrFiEE6qETVs4yu3Lfuc3XsNCJZ6jP87QFAmr+JxUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRFQUExMTM1NkNFMzJCQjcyREZCOUNE
RDdCMEQwODk2N0E4Q0ZGM0I0ERxjaGV3aUBnZW50b28ub3JnAAoJELDQiWeoz/O0
a4UA/2QTkaQulxaeDprLbiSZip0cFicH+VDzRL03fNgAgMvuAP4nCgw1WMjlWfmE
ycubVwztY7P4xsIOejROvHY5BecKBg==
=Df3U
-----END PGP SIGNATURE-----

--=-ebQo5WGk+sMw/9Rs5xM+--
