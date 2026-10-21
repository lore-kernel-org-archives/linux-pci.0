Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792557404;
	b=Hl7arg+qGbGSBVcMcEHVOvIz4fUUK7JKK1GO/W9E9W/EctRtJWjIwko5v2qY93r48pOx
	 6lclv6AJB7UhO+XfJ+RFB5K6ZPRSlySNUkcziDhfrF+2m4LB7vBI7hndDcFCRyDHBH/rB
	 w2Ol+m41bmfVUITKPMRHUQW179Ew6oUmhdGdW4iP1OaL92wI5lTd9zGUB9CAhb+XwRVTP
	 O1C+zHtrDSgUtrLxeNxE5J9ENqEj8XlQMGsxWA5l0vEq1LkLRLk+fMR5yrKQE2lBVILmY
	 PS8nnt00dIulT6tKuEO6cuso8HREv030N1Hqjdl2niLat+LKMuQyCXUcwi48Ogq5xSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792557404;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xe6eQwfJBBlD3jIeqBh+DDtYX9fESUgseXsZNFfBH9I=;
	b=cNnCsR+4aEPi1mGI9a92NT649ju8a4Uuo6L4F1qYZ1AVeX+kUaR+th5VuIL7POpJ0RnG
	 L4uvOzGmxDiLxVm2loMJ0IcPYaGs3PiBT8ovM+fZ4EVy8NSWzU6EdZzNoBMCQu60QX5ue
	 Conx6I0pwjc0zos1ZLZ2E9pMojK0x5rGr9OO39Q726chILgyO1JoeHqnLS6cYhWNGvZg+
	 ISUr+MqVT//s5ERzDqJfZPMdDsfxU3fRamtzDwlqxDUR4fet8crXK3Of2mViHrBBwStFk
	 z2AE45SukVZavbKxsi8loEI6SQrRx6Nv4NYKPlnE91d015ElmWjAou8leRuUlXs0EZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgtbInXJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE76606A31A
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgtbInXJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EF61F000C9;
	Wed, 21 Oct 2026 04:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792557403;
	bh=xe6eQwfJBBlD3jIeqBh+DDtYX9fESUgseXsZNFfBH9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NgtbInXJDlXcYL/SFtoRJ0NDECWzjIeo2Q1KQ85hduazI7t5P1mBQ0XyV1ujxs9oi
	 nG7ErGmscgvUi4qDNbs8NEKF9U0dyAYabN4MnJybzXCVVl+NRU/U2RzaXQx4WhExUL
	 8a0v5XeTO7nN5+6AyXkWN373E/f+XIwdTT8mjyZlnjGQWfh8urHaWNIT1UPkfuG5nn
	 Z98jz5wpnggH+bI6zVsda4KcjIWNFwGASB01uji7Pu2Jwpkd+Y5aitT9PcWcDkQB2P
	 fqpZ96Aypw4+L1KcDtKQgZmgOl58Jd3zeXnYQEDtmGxgxaHURo3nQBh3B9ism7nQK3
	 xhuzEC2F/PeZA==
Message-ID: <sashiko-outbox-179787@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021042229.2280937-10-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:36:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A vNTB PCI function can now expose endpoint-local DMA channels to its
> host. Decode the extension and register the advertised channels before
> the NTB device, so clients of that NTB device can use the DMA
> functionality in the same PCI function. Endpoints without the extension,
> or hosts without support for its DMA type or with no DMA IRQ available,
> continue without DMA.
>=20
> Only DW eDMA is supported for now. Dispatch on the advertised DMA type
> and keep type-specific setup in local helpers. Support for another
> implementation can add a new case and its own helpers.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042229.2280=
937-1-den@valinux.co.jp?part=3D9

