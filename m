Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794011209;
	b=Y6nspXTZNU17dbTPz9xO4PoDd1aimOJR8JeKcYcrOhsb18gEInEW7Yc+h1vE732xGYSA
	 dVTitJNBEMMNkUe9WFVlnHoeRj1vtrxcz/7c0rORv1f4PvPOsNiW+1J+wi46+AZH6gbhJ
	 GsobXOliZFuusvYcGZ9Cwex5y6W02r2lDcFrhExKFWWejfgh25wbFOa9Tq0bXK+3RDt4d
	 rwKXDI+7Fkab9cD5+o8EDDaD64jXm48C0loCWe9xm0TxL5GhkTYNSUpe3KPej7Fmk0BEI
	 TB3Z1P0N1IreoHhnP+vJWdwDhz7du5p4g8Cmsvbfq5BJsAN7BNtB3n9xUXBDo94dCDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011209;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d7JRorTfw/osw2b9YEH/99z8aWnduyGD7JMHwBVaCP0=;
	b=jvDpapz8C8AOzNOJr9cCYxZCF7Wnz6srWfmLgXOKgPgAj0Zcjxbek6P/j6MRqIPkU+OH
	 Na8nXTmShDZfRa2cBrin+wmHNoDj26dJd0Iyc0HYLvtXkpgpecXCCny4pmg6aJw5Awvnh
	 rxeRb6rd0krHfCqXZl90ILVRF4DPnHIksUKlgHBRkB0bMIs7ODLsu+JI+aY3+txVSTUuV
	 hKGhsBOdNiAfuhxajflUGegSG/5G29oqYUoega5Ob/24kGI3mcw5XztdFrBr6KSIj/YYm
	 MgMMMRZ41D78yjBiRrlIzTlJLjorHdyl17JWpS1FvBq1/ySNOKWPN3N1aCf30zb7DXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuGlgpqj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32067606A326
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuGlgpqj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D43F1F0089F;
	Sat,  7 Nov 2026 00:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011208;
	bh=d7JRorTfw/osw2b9YEH/99z8aWnduyGD7JMHwBVaCP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VuGlgpqjYAngbmDedzqiy3Dc/caw7/Er0iE9N8VohU/bLSRqSlbpnNV/naCUc4bCL
	 ScLvv57WKAASZWGKVaKVwpXV0wHxceJQvhu7V1H4dxHU23GQYpf2SR9qszcxUJ5hii
	 kp+P5AJtjINbjVP5xuYrDyh3Tk4I5VAbuEVe2GkFuoaurht5IF8A6irHddOy4uNmJC
	 9+LWsYUePqRmvCZ6NH8F+X1qJbYAYShk3Hze8X7cyK/UbEHodht51M0i6655XGQzEN
	 /Gj1nccb8PA4S7hhJiUC6lRvqSx6whNF2C+MLQGNgvPsu760951fhV66DFl8OTjN1A
	 CBorE64m4pZYw==
Message-ID: <sashiko-outbox-202422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: altera-msi: convert to subsys_platform_driver()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Masney" <bmasney@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106-pci-subsys-v1-1-70da22799cdd@redhat.com>
References: <20261106-pci-subsys-v1-1-70da22799cdd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 00:26:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Reduce boilerplate code in this driver and convert it over to use
> the macro subsys_platform_driver().
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-pci-subsys=
-v1-1-70da22799cdd@redhat.com?part=3D1

