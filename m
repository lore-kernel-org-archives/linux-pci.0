Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079200;
	b=TYpuI2KCsx9Z50I1MsHOPkf/sW9EVDtjPT+/b7NhKhmOL8jn5IzF6rXLJzUkz0rAW8TD
	 ligoRqqgm3setYsmGL3q6mohCwKV7ZYnj9avUq5hM+aMbR17UkLWZo7/yxNcuGnR3PmEu
	 OqBHBz23WF+8Uj6eN98zvSJjqxvu8isy6ki7qXkCIDofRAFLn6irWfNU8rEPjrJa53Tnr
	 sHTPocirkzfvkI5J31qLiy8ZROfaS1NuD9o1akldWcnfu4HzuMgHe5QSCuP1t1LGc/JTR
	 CvFCGG7syc+O/zxARR9kLKqMqDOw53sFHm4etAb4h+R2PzPENUc4JXlt1sMsU+EdiAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079200;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sfQnOo4lKezaZprymKe3wKRJvgkmPSyN8sLAyT+MbKg=;
	b=YpajgIcJt4/veLmUOfXwLAV2ksTsvScVISUokz92cWvIgjcMLhY810kYsyvfAhdRqmTV
	 6P9meXOjCEu/QOCUACkWLBCqj0NApfQcybRcFK4iRulwGjNFFraakRldcF7r9QfQ0p1A3
	 ici1SX8y8b5yH3UL/NML/QXksooruQMK2KxO3WWuqHnacQaTKhL9EelmB3B36kUeZTK4b
	 XO54GJ/ywyiOHCDS0WhICTiy9VwBhOTJ/WMR9nI1TuulRhpseoyVW3b6UHTqYLeBSJiSe
	 TJ7XVU8f3sdzXqSt0nhgB8A0uQOym1wm4+glytJ81MqXq+op/ziYmIMgDOpfs7BPOFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhRPkT4v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22927606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhRPkT4v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D891F01825;
	Tue, 27 Oct 2026 05:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079199;
	bh=sfQnOo4lKezaZprymKe3wKRJvgkmPSyN8sLAyT+MbKg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XhRPkT4vNzMs63/KZBn5mybX3Gy+TD/iD4Q3jDxWD/uDJevQOmVaA5j2AKl5fR7rK
	 UV31epTfTmRlypiimuqGF4ZGdhyqBd1rRj7zoNqZnCTtJ69MW4gWWuSJ3JgIy1bybf
	 3fGDBmBisLCB34XN/OO2qi+SWa9lcUknHlW8yl+6GVgr/fsmjhxDEPpzi9lDPXCy0N
	 KZiW/HsBb+3LISlRcgq9aFInck7dTNCyXxJWeILO2Flh3BN+kQWCBeYA7LTKuWxXJW
	 +kzQoBq/vDK8NwA8cmumesaL7HnS/BUmRQF6Sn6kBWZQl6XkBgmYKYFqREL6dG3SR6
	 yzGmZWD9YjzsQ==
Message-ID: <sashiko-outbox-186121@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/23] X.509: Make certificate parser public
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261027052536.1722081-5-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:33:19 +0000
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
> The upcoming support for PCI device authentication with CMA-SPDM
> (PCIe r6.1 sec 6.31) requires validating the Subject Alternative Name
> in X.509 certificates.
>=20
> High-level functions for X.509 parsing such as key_create_or_update()
> throw away the internal, low-level struct x509_certificate after
> extracting the struct public_key and public_key_signature from it.
> The Subject Alternative Name is thus inaccessible when using those
> functions.
>=20
> Afford CMA-SPDM access to the Subject Alternative Name by making struct
> x509_certificate public, together with the functions for parsing an
> X.509 certificate into such a struct and freeing such a struct.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D4

