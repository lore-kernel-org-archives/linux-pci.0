Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425940;
	b=knz69J9JBMGd9xbAO+RQj/dTGpL6NIdm26opWsg76gA/xGor9/DRmbCF56c7+gAAEGvn
	 SiqTXSGoINXjuxQD+vmVx2zB2U+OrF48OtNRKkGm8Df2U3YHxYn5odb60dr+Xljg0jHFG
	 hTSdVDTk9qpjXTnIRi1J/2OH962WIebWvpVijSOyTOczMIasKEhY56vqqNBInvzyUgGhB
	 tOeYM9xzAg+shWa5pBrOOtibYdvNrbxXUFKn90XnCL6sskFI6SR7D88reLt6zvV1prlov
	 HinZy+872KK16SS0D25TQuY2Gt/s1+Kd79Yvv0rDI+Q7HhR0yZA/OEtSf42RRMbnlKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425940;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/uwzYM2V4S/TcmXLwvAqE6rhtl/wFP1SG2AT8iG1aSg=;
	b=vxsPATcfJt22zxBR1KGM5dH4haci+nKlOt1SAgcEf9OUuCqpOtA0adgoqOfLjimpVesw
	 BSEpLvjRkgtfuSHHfZzmjmFpFxieGHZMjOsG3X6VDV22CTMKnwO++Y4gfGBO3eGvc1r0o
	 duNxg9d+Q/Iaild/GiNzwNEduRRptZPmS5x7hPFEPVg1h6UZvZWY3B6zRoVaKV4RYwgeC
	 Hvba31Iu+4oNQ5TY872I6r/T4CmM6Em1tPyeXyNr2x6R3OJto2dnibVR2d40P08JB92WY
	 k97jnHEnDPQtNY880YhQwqGSwlK1MBS7+cXEAJbjl+ASYPafNcxwhaHf2frBWaATxxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXHD1y6g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E0606A327
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXHD1y6g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0011F00A07;
	Wed, 11 Nov 2026 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425939;
	bh=/uwzYM2V4S/TcmXLwvAqE6rhtl/wFP1SG2AT8iG1aSg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eXHD1y6g8rUHEhPNrnJ0mGImMfaT2xy+vc7EmGP5UkAZAPVWDG1X/eF3PJeN064mI
	 DldaPuEgIsQGWUEJC2XRqJPnezIVzhjNf8B7Igo89fhQWoMhQolW+QfQkWv89fSFA9
	 TBaz/1BZQJbpFrhK1QhS+m2EJuFTylw0Foqs8fIioG3pz2rhnjvVvL2kvWx4jJpR66
	 JHf6zkWuQKOHeKExME16lSMVnLkfRCMtU+pJoopbXvQj9byAYP3uLaHBOcAkyAp4AW
	 VhAHRNnxFxXTo4gQpW9Dx/PSVbxiKUl0Jva05MJZolNPZ76FhAmW638cL1V0x+TIbJ
	 82YNm84czKGGw==
Message-ID: <sashiko-outbox-209581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/7] vfio: selftests: Add vfio_pci_find_mem_bar()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111192411.4133780-2-dmatlack@google.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <20261111192411.4133780-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:38:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Mina Almasry <almasrymina@google.com>
>=20
> Add vfio_pci_find_mem_bar() to libvfio to locate a BAR (or range within
> a BAR) of at least min_size bytes that behaves like ordinary memory and
> can be safely read and written without device-specific side effects.
>=20
> Detection is backed by a table of known devices, starting with QEMU's
> pci-testdev (1b36:0005) BAR 2 when configured with membar=3D<size> and
> membar-backed=3Don.
>=20
> Suggested-by: David Matlack <dmatlack@google.com>
> Cc: David Matlack <dmatlack@google.com>
> Cc: Matt Evans <matt@ozlabs.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>=20
> Reviewed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192411.4133=
780-1-dmatlack@google.com?part=3D1

