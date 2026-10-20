Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484599;
	b=aib1G55jRJKCensBiTjgypGRKoUh/Tekg5o64lm91NvlRkgHCJqKOa2pmMbOlZsWGvxd
	 u2GeDURe+nYOEIzBVdN6X+Ssh7u0cF04bzQqhi17rCSAH+h50Wyldp3AzaeoWn9l1BB1/
	 1181X86RtGj/HSB5JpRwwnmeZTiW3x6H3YHs3Wg5kvwUfqKjsOQzh/iYnsuyWslJ9x1qf
	 IMtnJ1m0ofTQP5ZxUl73OE1JQXxY4ZtNOZTBFTUtLSNiYUmTRUXQCtwnwvlG98R1PcHJa
	 JFrtDHJPl7LboFTHPg67Rdv/5vRn1mqbedDxA6unwxB8X180O0ibLYApo2jnG0KoMMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ke7SyMTMRaqyyM5Pl9a/Rkfj60Et6iQyVevSI0QXVzQ=;
	b=iMKKli/HYOxbZH+kJQvh/Qbw+XLz4/K9UAsHFTBM1hElt22b5XNy4aVttXageiWLiLah
	 kS3swVw/1CaNDcmT+ZjTt6tE5JT95MN5P6WVCiY9Y0EHUyc6DFoP3XteBO60w6gF6bHGG
	 qrY+qxpA6VrLH90+UkW8HD7r2TJyver/3lilvvS316qAc4AKsd2l2hn7Z7wxqXzr31q20
	 2ieT7HkKa9T0n0+e/p7bO3yI/C8l2Aba5aDDfE3tVJusgK2n8E0hGWFu2+iCveDRAXJ/r
	 O/yYUnoI1KMxIeghMOGQpj3pP+3kpfMO9TvvwQHgEZJogXdR9pIO4KhSY+o6zabCyZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecDyQJ6E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B07606A322
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecDyQJ6E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A1C1F000C4;
	Tue, 20 Oct 2026 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484599;
	bh=Ke7SyMTMRaqyyM5Pl9a/Rkfj60Et6iQyVevSI0QXVzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ecDyQJ6E8j0Ba7Df9U2tHMJrEjqpWPAhg5+FHFU6neGix5NSH4EsEZ4dWEOSrnmBd
	 p5nrYBHV4djK3eadjYlLeGbnCufRQeMDqncMUcb4Seh/oKAwQpDSf9P2unmWxCExNE
	 2/JBAG3aYsXZEGvXc+BWYR53ab7FAUsBwgWrPUAPxA7MClvimzkDriBioHILrpmLBO
	 dELRNWGcigLw9TX/ha1qiGeZxQkvWA81R2UG7Lnzv+dy2gl8i5cwFciOezmZ+ei6Ab
	 45AWfmQbBsjxmO7iN8A/MZrnoHcfKo2hQ4N1SUUHfxzuUSh0HsyiRNevq6B7CweswS
	 mcn2m1ft1fd5w==
Message-ID: <sashiko-outbox-178535@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/17] PCI: rcar-gen4: Separate hardware setup from
 resource acquisition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-9-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:23:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Factor out the hardware setup needed by Root Port recovery into helpers.
> Recovery needs to reset and restore the controller while keeping its
> clocks enabled and the R-Car Gen5 SoC PHY initialized.
>=20
> - From rcar_gen4_pcie_common_init(), extract the power reset and mode
>   setup. Leave clock enabling and Application/Local reset control in
>   common_init(), so recovery can keep the APP registers accessible.
>=20
> - From rcar_gen4_v4h_v4m_pcie_init() and rcar_gen5_pcie_init(), extract
>   the SoC-specific register setup. This allows recovery to restore those
>   settings without taking another clock or PHY initialization reference.
>=20
> - From rcar_gen4_pcie_host_init(), extract the Root Port register setup
>   and PERST# release. Both paths need this host-specific sequence after
>   the per-SoC initialization or reset.
>=20
> No functional changes.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D8

