Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976913;
	b=nyR7ktz6OZj610P0gYgzSDIXb2sCPLSbIW1G8WVSNwvJQshfDl9LeV9Hn0AzoWg1AHbO
	 UVi2CNhYQpTGXPNT3sIMWwvTy874CJwZqMD8fAhsFkh2P/dN3BR+0cnPGcjDai9Imakwb
	 JDTfM6kwOBvFTwt+1dwqVVVhRin9r3i33cEJvmUAYK7xz9/Tp9qeAfBYDxoghAC3tlhgY
	 +eYZK8KIabuQd4xnSxBgXIOgYTGLnz95IQEO6e0XiciacKwjeQYQgCIypHgEk6o6DjMrz
	 nltBU0dF7NdAr94ZInOfsYDg71ssZLHA0P+38xm4wwP1lXLh1145I2ImwR2eKBvItSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BAoH1lgMs748es+TqvjWfn7vtmhz+5YsOXXvYObDCf4=;
	b=nuQ0S3JoUXNZAZNSujJE1RaMeQt//VQRSmJkSYZRfIu+OnEHUxJFpx8zUujqjzfDt7SC
	 Tsy/Qe7gDIh6lcJvlVLjaLiO0LWnpFTedtk5GTwssjX2EJWpcAljN1bp/xWuwBWfuFHhh
	 FDcbeaC6wHEIy2MH21r1gatU75tcKm506Pb2Eu12xlyL36ZMTxpAnKK1KSv2Oq7StUw2p
	 MHqCy5VsXjmZxVfCOPc57jyVuiXXXtjbIES2R1mbfQqq/C9TGITiob1QToAgZoGsSwDde
	 88AQPsKn7o2dUE3o6HsNildHXRxzKHXMlsBO8d9PZGnRO+ClHO5bFZpK72x254Jw3ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=notXAOU9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC0606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=notXAOU9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ED21F0089F;
	Fri,  6 Nov 2026 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976913;
	bh=BAoH1lgMs748es+TqvjWfn7vtmhz+5YsOXXvYObDCf4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=notXAOU9giEnQjWhv1kE3KU8v+HOKLhLio1i03LJrrdccAR7mWJuGgeadV8ZFYbgh
	 3FGDTWUbM3qvCqfWzf8qwQeaaVMtQBsXi0kE3Tx8OksGCsvgK0suQYV70CtNORQYl7
	 gY42X9mHYe/JnUm8xGaMZIUxaZvos+loRJl8lzCAJQ7gqQWqFZbYNkeo/cjAZPG+Gq
	 0QoYk2i2C5TncRexxgU0GAOwM3CcvjhXwWljTSgVrZAvqTb3B2GA1/Iq6m9h7Mpx68
	 cWhF9JmPVLg90IlOlDcWttApKPgyyVHLrfzgBI18A+KiYJbsiIGYxEio6NCtxElTvQ
	 9tTMWeiJBaJhg==
Message-ID: <sashiko-outbox-201626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/14] PCI: Place resources to either edge of the
 window
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-10-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-10-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:55:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCI resource assignment phase is based on a greedy algorithm. The
> resources are assigned in descending order of required alignment.
> Because the PCI BARs are power-of-two sized resources, it mostly works
> (bridge windows and VF BARs are composite resources that might not
> necessarily have power-of-two size but internally they are still
> composed of BARs).
>=20
> The resource assignment prior to the commit 9036bd0efcb6 ("PCI: Align
> head space better") placed resources towards the left edge of the
> window. Tha commit altered assignment for resources whose size is not a
> perfect multiple of the required alignment by moving the remainder
> before the left edge of the window if possible.
>=20
> The behavior after the commit 9036bd0efcb6 ("PCI: Align head space
> better") may result in problems when a bridge window consists of one
> [ ... ]
> Tested-by: Alexey Fomenko <alexey.fomenko@intel.com>
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D9

