Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000177;
	b=m/+JrGSyYcNT02rB82U1AtVB3kEgmvWr3R6i3gYaA8HBC0U+gXI7rOMHUUKl+QgnbLx/
	 VhCkV16D/hFt9DqJEZ0VMYPxL37Hl8MeiaRMC6UPEac2jzroZc/O9eS8DwTUZ7ryfbHqZ
	 SXTschzfHBjzj2vg2MLhPHRKDbmIb9qoiMNdnLu7BoVuuTO0wU7Vv/GWaTDaY4Hc6CF8m
	 kSEL7H8GcQuy7EkdEWihQVFfYNBRWdEPIk1UBCrFA8rV7uLt6u4fi5hdS0F2lfL+yyGL6
	 vdA4pyNOJ7MovW4aSieKc+O+t85qFbVq5yF4lD+btn8MAumgOVyCy/jbcGhCPr/k6/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000177;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CYElCIksFrUchiP6GcA+BzunukM09zZQpZ6L0TF4Q4k=;
	b=QB1mxbMtdPzVz9I0aCwc8FkSsujTyoq8Nvfvia20TiP9xHjQArGI1SH1/00dJ/QQ5clh
	 hW6KSxm7e8qSp4rKfiRfOf5CvfGjlu+CezMxivBkQw1FRJ42mshdVGARgu2tv1H81/6/6
	 g/vvKrqN0cf+uVwUfx77g0XPAJ45lxv9If+hSxq3HaA5HR1jRxv8QuVJNxUYz/iIbopbv
	 J3wcLFYfG1vDl9e9Cdfa6TgtvjMcZ/zVdoawnIQgOquRpEc97PQrlU6ZoaKZmXnEF5LuP
	 rsvDjAf6STkjrgVcIq48ijQo6Rr3aYe2L8lg2qgH40LAu4gQwqHfOIF6uUggJKMHt5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L02M34u0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3486606A320
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L02M34u0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDCA1F000C4;
	Wed, 18 Nov 2026 11:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795000177;
	bh=CYElCIksFrUchiP6GcA+BzunukM09zZQpZ6L0TF4Q4k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=L02M34u0nFBr1xKK0auRg9hLPKDyK0pL6M/65fi4rYZgxGz9bPO334BzvNNikem1L
	 hbwMpJ+QyKa1zpah/xYWBHbNcqNTOsiAVP6bF+a14lXBwomOeJuw08YnCaLIEd5zZ4
	 OrmaP9GdCXwpDdKOdMc7C4SEc2D411g90j2ROMvPTL3cToQGk1WiIgyCSnRfrLjo6q
	 kpzLSEB37UT5ATZDfGqCYXsyk0l2BBiy5tSwxAt0e/RZjVRwYjBehyu8jcbqQ8rTaE
	 PMKLxNrkjwZWr0xbHkhSqP9juYQeTiVe3IKm16TCTwpfPjCI7qOABKlFS/pIkVX6U/
	 vM3yMA9Cd7CXQ==
Message-ID: <sashiko-outbox-220802@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] PCI/ERR: Clear error status bits more
 selectively
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org
In-Reply-To: <8ab33b2307e9136719f72ccc2d9f946417651eab.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
 <8ab33b2307e9136719f72ccc2d9f946417651eab.1794997749.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 11:09:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> After recovery from a PCIe error, all of the error status bits in the
> Device Status register are cleared indiscriminately, regardless of the
> error's severity.
>=20
> So when a Correctable Error occurs simultaneously to an Uncorrectable
> Error, after the former is handled, it is cleared alongside the latter.
> As a result, the Uncorrectable Error isn't handled at all.
>=20
> Conversely, an Uncorrectable Error occurring shortly before a Correctable
> Error may cause the latter to be cleared and thus ignored.
>=20
> Avoid by clearing only the error bits corresponding to the error severity
> being handled.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794997749.gi=
t.lukas@wunner.de?part=3D3

