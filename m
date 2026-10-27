Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079142;
	b=yXGZd6r4BTXONV7lf0yQlrbXjUp/bdzHLhjXbBk3F8qPZF95Rxc29FiqLTcsV9Z5gBI9
	 sffk/kYVn7WOcRCv3GjRw0kGajFL2GCMdceMBUjSzeIr160P6dRURnNaghZbBuZqgFZoW
	 y91Ze+sgUfIze3qitaOyOX1CSqQL6oqn2JOTcilnIsDuBiBYj/ZTK2YabPXFevDUly/Cc
	 xKMeaxaU4jeLrizOIiQmle2mwXVZPe2RPYqbX6WtA7P59JpL+BK+Th0BM/JxBQZk7QiCe
	 slL8uUTS9DtMJBaGtQU71uf9WT4yWMxPKO2bIRp4mB43LfG57wTfAT7Lo+xJZhp+Uaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079142;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a8DpRlQdv4AdVm0sARSUy8YuT629Rw3B8k+TFoZY0WQ=;
	b=ue3MHURmm/wuEztNPMT3IoVlkpILSKtgJhSsvqk34m7fHWs7OvUBQ+Q8qzCIy1PMyP6y
	 OnpsFVilM9X31KX43y5qxFureS5GNzYGBh4cJ+HZcrjTGqk01o95wqB1VFpMYaogS6DkU
	 vMULx3OfY9KZAuPt5h7PuQ2mTA1CF3XGxNjXMKpAZn05j2G2HmcN/HWw7RGd72RInje2g
	 mvL4/m1u6xyuEq82zqSVRkv7jUi2uOZ4F1UYwP8/oRW8rFtJYgYDMgGg55eIOcwwwQAoI
	 Bbhbf3i2Ej+16Yn5Y1gGzrHl12txUxFUvlg3l9nht9jE/6AWeISo+FyYSURO+DaHezg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXpmORhd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738AA606A329
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXpmORhd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4A11F01825;
	Tue, 27 Oct 2026 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079142;
	bh=a8DpRlQdv4AdVm0sARSUy8YuT629Rw3B8k+TFoZY0WQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DXpmORhdEi0ROFte2VTwy4WxrAfG04kXC3ps61KTOdbSTeSFTcSXEuAZsOvlZo8SK
	 mugopyDKWWmG3zzkfIwIAgOzdkQ8xH1dwjjdq/5kummaMaiRuGYJPloBVhgEVX1TAc
	 GgpsHocVBIaiBPXSQ+tBQTpYXHU0c8H7E5RHGQ9IDWwrUo8y2YeqUrmCb2BBtIvpwt
	 l9gkwI+Q9JVrIihmbGOOocORxPVUzFF7D+74ZoHxzBRdFrislc3abuodLcOZQy+OZE
	 wK5eZCAffvx6UDFGKJW67wD1oEV2N2v5/OaFjNYCKCe8W7GqjYNoLtZ/qDKb8Hx90r
	 4tK+WXuTq84JQ==
Message-ID: <sashiko-outbox-186117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/23] X.509: Move certificate length retrieval into
 new helper
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261027052536.1722081-7-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-7-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:32:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Lukas Wunner <lukas@wunner.de>
>=20
> The upcoming in-kernel SPDM library (Security Protocol and Data Model,
> https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
> ASN.1 DER-encoded X.509 certificates.
>=20
> Such code already exists in x509_load_certificate_list(), so move it
> into a new helper for reuse by SPDM.
>=20
> Export the helper so that SPDM can be tristate.  (Some upcoming users of
> the SPDM libray may be modular, such as SCSI and ATA.)
>=20
> No functional change intended.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D6

