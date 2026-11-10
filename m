Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343192;
	b=mMJF+tvyfjxHnAMcNebOuKaGP7T4jkiSAeDRSRVGK9PuYhzVds3Ogib3NyG6HCzbapOq
	 B6plO2pto/pU13ioN3ev7btHqaeQCIL4E0YrTMpqrL7MaIe/7FEuVTlLEfoL8vgOeavS+
	 PD4i8/nKX9C1moTK4zS+aiKo5Z/c0mxcLHOh8moNINqXR1W6SFKAQ7DcWAs/HE7jvZkmS
	 WjUEiwLgWY8hvxGa3Hc4YvCI311YqXccvZhJ94j6E1q/55/j9t6129gpYtq5M/NOL67mT
	 Lwb3mEJHGjTIBOIMtbsCG/qFDMV++xJtvtAkEZW+mom1Cwv+bXcf8WjuF/2YBwQMkCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343192;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=iKb20DztR7iy0tg5GgLAvwfblsxqXMION1B8fe7Cnn4=;
	b=xXx3OJDlbj5AZn2tvCmJHAnOwqV0Aaq7Ctik3vP1tn6AygV+Ce3leCwz9wzUxvpmYRyg
	 iqTLyYyvTeJgbxNC8u6fC+tfReTPZwtssvPO30rhG/fmr0nncsxeGfq992Kz7thvmm0LY
	 faiyTi49xglzGIFS0Q3YS4N0hHIf+o5NbyiZl+A2El5iTNJJFnRqlDCN2/h0qmgLlZTPN
	 2/DcrXUeV/Vx+WnRTIyIyZk4LzvZ+WY+hS92JjGE7nizQstSCYVX4joNXIL0PUobUc8Or
	 UiC6erQWfHUr1GQhZLfq5FbzqrQGVbhEXrSzlzVOmk5QWQCw3UPGtNdLfmPB81OXVIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=CUMFB5EA;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF01606A33B
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 20:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CF01606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=CUMFB5EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=iKb2
	0DztR7iy0tg5GgLAvwfblsxqXMION1B8fe7Cnn4=; b=CUMFB5EAqsBXR2EdQOqR
	GXdIe5JrZQSz66Ga56BR0MdzoRydK76y1XEyTlJnGgvXsDGXwRmjToVNMe6hWjML
	TNW0LWRdKYvGt2wiWasR+KwmMbdOFA9BlQLnKmXWYGWNcTVx1jgAR63nzg/qBMeW
	zI1mhuc6g52y7kADd/22cjU8KnbxTCCpxZUvBf03xpow8lIjqF2Cnhh8dKOyGvDC
	Dz19rbg7f6Vzx3HSui/tL9E26hSC/CT9874A+x6OWr65RdriI8O0UZj8N9f3nQSP
	IQHnPuFV/ycfBVejNYHsnieYaslrBd2HrfufoEwnWqPy1CmC5+Oaya6AP7TpXbO1
	uA==
Received: (qmail 360371 invoked from network); 10 Nov 2026 21:39:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Nov 2026 21:39:48 +0100
X-UD-Smtp-Session: l3s3148p1@zCFVFPJfaNkujnsO
Date: Tue, 10 Nov 2026 21:39:47 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	claudiu.beznea@tuxon.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v7 00/14] PCI: rzg3s-host: Add PCIe hotplug support
Message-ID: <avOBDu8XaZ-kZIsF@ninjato>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <atphAmy8ZIjY_JNC@ninjato>
 <f1df2818-be5c-4019-a86f-4e782a70d3fb@kernel.org>
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
	protocol="application/pgp-signature"; boundary="Ph/woFXdrVo0PdRK"
Content-Disposition: inline
In-Reply-To: <f1df2818-be5c-4019-a86f-4e782a70d3fb@kernel.org>

--Ph/woFXdrVo0PdRK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

finally, I got around to it...

> I currently can't reproduce this on my side. Do you remember if you execu=
ted
> the below command before your test:
>=20
> echo performance > /sys/module/pcie_aspm/parameters/policy

No, I did not and it makes a difference. With the command above, removal
also works fine. But leaving it and letting the policy stay "default",
removal doesn't work. I don't even see this line:

pcieport 0000:00:00.0: Recovering Root Port due to Link Down

Is this expected? I'd think "default" should work as well?

Thanks for the guidance!

   Wolfram


--Ph/woFXdrVo0PdRK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrzgQ8ACgkQFA3kzBSg
KbYCQQ//W9ouE+6Vols5UoW5PMVR9+KT1GKbbTzsUhMl4ycQXhNO8VHAC9ULrNEW
KtZKq6mhGDZUB1onyp8YjmR1q0VlsxwcApu4ETTayhO8YGq5DOhq/JKWL3Kv+gdb
tz/bfAsYYDBry32StNPvOJ1QEmTWx04kTdwT5n8AdtZiPxJYPh7poLn9/UDoKt9n
W50P1M/E1GBbca7/BCV3syHi3X0j+034qcmAMdBeZsdw0BaFXNOGMRjPtSDDLsww
3AOM8kn/ywclHRQoyjNDHg/7w1pVfPYAjMBCNkE8Xx/5TZxmTukOPVXoqSaEAT23
pNmWiVbM8txjceBEMslxe5DgdzRM9OP74eBAFVdpEmLX8QKNneWsMFlOfhjPbRMu
FWxZ5DK5Ms6W5uIxxDboqF9+ZtTxwfZSo+Qd8nBcG7OD+C5zZkf8x1ywi6XKePwm
VrbEISUlSHTQ9gWirRH89XB9LKTtUWnC1MxjkUfChZM5E4ZojHZ5dDDD6zHLThpB
vOrpESpOicFElIF+KrQ9oVd52H9cvdL6Kw6LHi1LnT0QUgodeGKE96vTlw4E5EKX
zptEYLOqNs61VviuigJjfzAepCD7HxAjvNQagti/ZvE42vGrWqSbJiiY91JnVEo0
0zFD/rY+doqnnl5ieAtB3S+wXMyOEhdjvzG+ls8sMRwnnIVdDUo=
=SBvO
-----END PGP SIGNATURE-----

--Ph/woFXdrVo0PdRK--
