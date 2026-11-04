Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809318;
	b=Z4sF2PUrtzUmOSqmd1IID3vVDxonNKy5EI9NPZUe2UyNJPH8EzLtBUNvKxMPvesK9fNV
	 wsAzVM0h89JfRhNywgO4O9PoHqBenAwHfNAWt5WluUy0BFEQM09TjCA1Jyg5hBEnGJrNx
	 t8l03aSUrHptmNzYQ1sZRpWnMMKf5avgtCRN2Q84uWi2o1ZeII2MMwPi/h1gulYx+299/
	 UtwE2uWaXzA7lSkk2eqOJXNmuMOzXir3O8Ct3EgvPiH0EC78P7xEBQg2p3xiceet16qSz
	 UNZvs9sTHakQLkUpkFeBvFiTRRY8j2mbmhzYEDgTCdwD+FidR+61/DmbKmYaEygYqdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809318;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AVN9nyDpCZhXt9KAH9+aazfNpWjCw+ni2wNYVk1WN4U=;
	b=RHfv+Ony49OuDTf7zxcxjuyXnWRgYtTAkmnVaheQdxenGRghy7vKMbwhQJZePU5/ym5G
	 lmm4j0WbokcBbbigcv5VZCgtYAvO+QdtmhIcwYUGphasEiFMcpBoih9TUG1VAJSIuMxlw
	 X/ybV1aJ8JoiT3Ohxfr7Z6uzWwFhXdbOktGKyugcWVpJf93FYcXdzKk48lfL0fTT15tsM
	 +JABleIlVjUGrGp+vF7S119XunBu6LIk9sHY+fBDwegJn0srgOP0rs6/EfJ8BGCKMvfCX
	 IFFd0Bw7Em3AC7jH4JcMImvfml/RJJyB/WCkA3rxkisg2yZha8juJKd1xGoRIoV347g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQJEFoSl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16064606AADF
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQJEFoSl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCEE1F000C1;
	Wed,  4 Nov 2026 16:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809317;
	bh=AVN9nyDpCZhXt9KAH9+aazfNpWjCw+ni2wNYVk1WN4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EQJEFoSl8bbEDJPh85kaZjJTorb72Od5EC6/wy4SWiq2n54WqhO0yZLjKFLX5e7EP
	 nEmu2Ezvh/tzWy1irLdIeHSHlwvesyI0WTMcgVLR6IbxTXtsk8baasGJ3K+rpKlvoC
	 nRLAUcND0rbXgQOl1okmm38eirRegd0Tyt3zbcn+5lYOEfEYrD8ZJWcVf+jVIS51t+
	 yLvOlq/7xlcAqKpZiKzIFI12q0gN/CTMWQxx9mKldllud/wlgI+6JRrExZnhPz0yL+
	 LbxiGJVc0Leo50BsaXqIDAhkpuBx4qsOIzTrhFrjgtL/nCK4RUadW/NF4y1h7K0CSm
	 FdQ9irA1y3WLA==
Message-ID: <sashiko-outbox-197597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/7] dmaengine: dw-edma: Add trace support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161227.1742005-8-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
 <20261104161227.1742005-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:21:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Add tracepoints for LL publication, descriptor append and completion,
> and doorbells. Record channel and ring indices to help diagnose stalls.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Co-developed-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161227.1742=
005-1-den@valinux.co.jp?part=3D7

