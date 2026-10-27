Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079143;
	b=1al+txSzlSPdVMHYsJ1S660S7fnqO2I8kGQsaErJljxfygF5Yf+xukZFVj19d3UR7Q3J
	 njui+FjEa3ATwqPUcR8GY+uklnYqrc3lXB1sQzOizeYFjLcGpJEhsge/TAkLMASH3OTAY
	 3Hye+UX93l5mwSzEUTR39ok4WRloGBHlYHvgIDKZMwNpAl0SLbQ44wAG+++vWOfl2V75t
	 o5R9XkfIiRDc8bH4OBcX/w9rs4h4sEZqTV6ROhfPiwdbqeOJZQkr+FiaxRjSM8sXJlhHQ
	 aQQCrnwfjxf61ztCdVG2SSfiJDXnNhmIdE96mdr0yvX0/cOv8mI0fb+WrwVnfP7h0OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079143;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4HuaDa2ULA4gL6Mqz06Jikedv0mIieXR4v+VToYCgCs=;
	b=qj/MK5Gr0VgUcn1RmbHjauYbbwADQpz8MeegCizWD0IZPhLpLfvHGRs5R4Mt2+xGbW/3
	 f+dw3/Ir77t674iCPX+tOjBNK+jIav9tRjrJrBRKAiquIrXV0tgVA4BDSNZi/qf9wY8Hv
	 qjOiOFNlMKXkf1Hr3fborjuySmGKkSaallRDH2znVTbthGpcPSuN+B0sl+d8ixfsFSZn6
	 BVJnhUOm3Yl1TAijf+mpiI5iIjDBtW1Nn83k8c3XRghdrtfQyWKJuyIkihV8e5Ve1E5r0
	 VxgdlGwtl0g64WTD4Tj3m9XtnYzqwb2N8D/irVsVw/om+jQvQ3rYPHUHl2S78FHPk3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HGny/SQj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E6606A327
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGny/SQj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA0C1F01828;
	Tue, 27 Oct 2026 05:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079142;
	bh=4HuaDa2ULA4gL6Mqz06Jikedv0mIieXR4v+VToYCgCs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HGny/SQjAsHvJYcgdXbZLAVH3dpALIgl3vmyFlC0BbpF9J0Zx1MxsNWcFHrHCHL56
	 cZihWt6yk0ZwsONhfou4Xb7mfYsFO6DeLYqd/fqedBDKNruIkNDeqlDYAgzOZepooE
	 58OInnx8Qv5u0Rn8d+zeAwmN6OuCnFrVdpnGM2PV+/EXzGSP+SP8liiXAGpPiiHCSv
	 nz3qd/FN/yx1vUtwaLVIDwmTdvIgmujODjX7KFvA9Nwmh4nXSQTw/6TCr4XSzHrJWT
	 9Sr3JtnjBfwVGhOMT/eWmuwKMfnSQ3Kd76ZEYzj5n5glwkUUnR0E2GUw+kHxFkZX1O
	 qnYS/KJEsK1cw==
Message-ID: <sashiko-outbox-186118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/23] X.509: Parse Subject Alternative Name in
 certificates
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261027052536.1722081-6-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-6-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:32:22 +0000
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
> Store a pointer to the Subject Alternative Name upon parsing for
> consumption by CMA-SPDM.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D5

