Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D333D6FC
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762621; cv=none; b=jHZC4kF1foauFEGIPl+fWgaek1GLL9otF8Maepp8+P43kjyFTX4667MfCOSzUG7uSU4jlFba9D+d7oA5iUxjmoWTqQW6KeCe4Eif8fpxZbwnJi0GONKP8i+EejaHhxEZMRcnljfDJwIadCUMeoXdU1jUp8RJCuOKmyCvVgLJU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762621; c=relaxed/simple;
	bh=u7FeibceXdvzpklNF21NJcINgKfQZmOuAM0ZaZyWUcw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tgoi30NhXON32Y+FD751h0w803o+V8tT+OELCK8uxKGblCkQqCFVdqNgeFL2i1+iDYHsXmVqScWkdrwFPnyyGRHLIkiLu1V6JUvziBVR9osgyNnebRDb7iiYw9gAvjA87cHz0rqiwdqoynWxzIY/kb+TIvXjm3rLpfroeUvndIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl/TOTRQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl/TOTRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811A31F00898;
	Wed, 30 Sep 2026 10:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762619;
	bh=9K4REY5HO3rnRHXRaxdoxxinRt8t1exNVx1jZE5GtV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gl/TOTRQiXwiE7LJeRfSctySVH0qSZgAAEx5G3zO19dzWCqDmcxkP3SxYSIhjUqen
	 7LcM392VRuBe7IR9/ecY2BCQ26Nc86rNAPOaEBs4rrTZkDVpdd2wupNtw1AMiqm9pR
	 BOd9Jn2PgiSMSvULAznOZgxrwGC0p5Nk/8x5BUKcFK8ytLsCgbXZYjVa0znQtoZ2x7
	 EQFGb39nGJ6jUACNXsSDCy1Mx9ittQgm8NMiAAlSrGehtM96A3LylqBnHjTQ9DLQhO
	 FE3j40dHPqGj87ZrtFZHzyfBhmEPd75AqNoF5fnd29x6xPQfE4hI2CQXXyW/1rNaoH
	 8GuB5l0D+9tvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: mediatek: Fix integer truncation in fls() for
 resource size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930094912.3069-1-sreekuttan2156239@gmail.com>
References: <20260930094912.3069-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:03:39 +0000
Message-Id: <20260930100339.811A31F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PCI: mediatek: incomplete fix for 4GiB resource size due to macro =
mask
--

commit 790d994ea56f0eba397f9698ea9390e70f3a8d1c
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: mediatek: Fix integer truncation in fls() for resource size

This commit replaces fls() with fls64() when calculating the AHB-to-PCIe
translation window size to properly handle 64-bit memory resources.

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
[ ... ]
> @@ -754,7 +755,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_p=
ort *port)
> =20
>  	/* Set AHB to PCIe translation windows */
>  	val =3D lower_32_bits(mem->start) |
> -	      AHB2PCIE_SIZE(fls(resource_size(mem)));
> +	      AHB2PCIE_SIZE(fls64(resource_size(mem)));

[Severity: High]
Will this still result in a truncated window size when using a 4 GiB resour=
ce?

Looking at the macro definition in drivers/pci/controller/pcie-mediatek.c:

#define AHB2PCIE_SIZE(x)    ((x) & GENMASK(4, 0))

For a 4 GiB memory resource, fls64() returns 33. The 5-bit mask in=20
AHB2PCIE_SIZE() restricts values to 0-31, which truncates 33 down to 1.
Could this result in an incorrect window size being programmed, causing mem=
ory
accesses across the bridge to fail?

>  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> =20
>  	val =3D upper_32_bits(mem->start);
[ ... ]
> @@ -830,7 +831,7 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pc=
ie_port *port)
> =20
>  	/* Set AHB to PCIe translation windows */
>  	val =3D lower_32_bits(mem->start) |
> -	      AHB2PCIE_SIZE(fls(resource_size(mem)));
> +	      AHB2PCIE_SIZE(fls64(resource_size(mem)));

[Severity: High]
Is this instance in mtk_pcie_startup_port_en7528() affected by the same
truncation issue through the AHB2PCIE_SIZE() macro?

>  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> =20
>  	val =3D upper_32_bits(mem->start);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930094912.3069=
-1-sreekuttan2156239@gmail.com?part=3D1
