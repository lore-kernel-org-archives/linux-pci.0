Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079466;
	b=bLJjP8C1jJroesOsUgYNNMnTi6xS/yq2xCmFtDsvhqSYsAhqIU7uNbyJcgy/kxQtPOAH
	 ecmPwl2aB10CGlsS5MwOJ8fxyBq7tvxxR+woiAvmlbq0eie6NxtGv4gJyysOMj+FR3BNA
	 5ME4/XviNJObXT5wX297giwr728aGs9lrNoZuK+unbHbIvuzkDCWUDgbZMe3jG6lABqY6
	 DSzfs3U7AQiau0GabntAwUvTeqWibj2VTLpzgGDV8RX9e3igO0s2TPkuLT4Z1tbDy7pbg
	 DfZx0NHAfobDKRKlWc6psNxhIaf3IuEe5JtN6sbcOaSK+Wr2PrhdZoUhBycRf0FezlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079466;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UzYG9rfd/ORh10u0JMAs/LZxAnQBJA5+yAM9Gi84Wzk=;
	b=0eH5Ng4C9u0FwSviFwtvaooOQaIjMzsfAmjPXZyMmZ4f93sP4slOOaMqn4mpZMhuJsUD
	 IL8oXCianjv81rQ0Vy0BVptBikq91hFaGBI8WeBCI3TsfAZZhMGYh47NILn94E56HVpL+
	 TCTbWUG0BcBlfhwf7FE+K/xQh2D5PA8CD6qL8vm1thBOz/fBtEk0Cn0wcs9M1yAZie3ni
	 OmzJiFRaZuyRU0nVtD4seCkuJ2MnTSvSGr+2z/G//kHkJQZgQT78R0hqXC2Tq2wW+q5rm
	 Xz1oO6MFRY9WnB8bI+mkH3zBbOiVnC/Zd9KWZj8EchL+0rEGdEKnQOZ10RNOGcuQrag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8zsUS6U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C946606A329
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8zsUS6U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884821F01828;
	Tue, 27 Oct 2026 05:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079465;
	bh=UzYG9rfd/ORh10u0JMAs/LZxAnQBJA5+yAM9Gi84Wzk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=d8zsUS6Uha6SsIxQPijj/G5K5Ty0pqMHY8LNNwd8O9esiPReSfBMVqZDDdNpzB9MI
	 McUYNS7UC4glHL1/yT59sIMjAt2l6755VeVRr4WYzQwLkGnQccDFHJlPYUpNnDMHuI
	 FDfD6pbNeouFki11L9yK/1fxhl83N/7nhi1UnL7MNRHTt+igMpkr2Qcz2FFkk59W46
	 EsgBBz+VrTJOCvtpDO70scoUqqbofBrvId2TYXVs3UShi0/VN9PW+VDacA+n2gE4Ma
	 WO+Z45526FNIwqWZu6u8THQy3zroirAyuz/1IyGBbIoY2G8RTpQ75nmsygxO3GgC3S
	 wwX68Ph40yqKQ==
Message-ID: <sashiko-outbox-186128@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/23] PCI/CMA: Validate Subject Alternative Name in
 certificates
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261027052536.1722081-14-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-14-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:37:45 +0000
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
> PCIe r6.1 sec 6.31.3 stipulates requirements for Leaf Certificates
> presented by devices, in particular the presence of a Subject Alternative
> Name which encodes the Vendor ID, Device ID, Device Serial Number, etc.
>=20
> This prevents a mismatch between the device identity in Config Space and
> the certificate.  A device cannot misappropriate a certificate from a
> different device without also spoofing Config Space.  As a corollary,
> it cannot dupe an arbitrary driver into binding to it.  Only drivers
> which bind to the device identity in the Subject Alternative Name work
> (PCIe r6.1 sec 6.31 "Implementation Note: Overview of Threat Model").
>=20
> The Subject Alternative Name is signed, hence constitutes a signed copy
> of a Config Space portion.  It's the same concept as web certificates
> [ ... ]
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # except ASN.1
> [ Changed by AF:
>  - Fixup a few issues caught by Sashiko
> ]
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D13

