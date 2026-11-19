Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116571;
	b=qdNejGdn3wmmr3RTt+mfFqlhQzHnmR2/ERGJPNqCZ/kVVFUJmlN4K0ZncYhP5FhDoD3g
	 bGqXZxZzqKCmyDPPtwvo2dsyJ4+14H2oGQLOEukyzX1aPh0D7embbmlWmqpn7SYHn5jVD
	 3I11norpDnVsDQxOneZHmNdedtAdbtmRZ5F3zNyZtCiyyMvwbTnNLFhYlYnTN/RwVQBUn
	 p8T0V9V9PoqQ1DS+nO4nt4blLcSuU8jLfZUTjv88nvt6ST+X6txZ5n6ww1KV30vBJnjbc
	 oWn9ra064EUuNH1dTJKh/I96T3sakhOM09PJn0k8NxTPKE6Fzth7rcoLxoq4HarE5kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=17jzkN1pkKb0rYxYr6aSPtJdilGzKt3krnXCvhAcS7M=;
	b=tiU6nxRh0oiQlCWkUUgN7757iP2AbAIVMh7x/k8UvJVPiXL3n0/XvS2Rf9GpL3iX5Ahj
	 pJT/RYRwG1TyLfJzs5FsY8bAKZjpSPCpYlyxyzfehabXcdaMSrYCxGIg/533zXLyro4cg
	 ARvVoJuNqBtx/3LbNAaKZ1Y7mYs/zCf1pVzqQvIwgY/hH508NEZHanjOwDWaOqzztnBpi
	 LAD31wfy37TUgCEyAsnAAwFnbI//3obFttdAXn+T6s6F470Foni+BuAksUSZgi6ckYd3k
	 hmPkBBG8r4skqfIOWxNK7qhe/LMfmmXbuAZC6G5SMhBqI8cVIRdOvkc0sXlfL6FZLVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4gVDqhd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4431606A334;
	Thu, 19 Nov 2026 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4gVDqhd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A311F000C7;
	Thu, 19 Nov 2026 19:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116571;
	bh=17jzkN1pkKb0rYxYr6aSPtJdilGzKt3krnXCvhAcS7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y4gVDqhdsI3fo/Oo5JnRTg4lJLdrzYX2muI7cyK5DJJGxirqu/eHR9Pl/RmhM03zy
	 yFuIA/Oj1aLhypDXlIFMOCk1TVDL2I0mV8m+sg45d70QOOse/cuvov+7scR/B329gT
	 7BqV4lOxAuCnEcmo7fe3/W/y0dzrQQdWePUrpF62edMaxCbdZyt26lvingrHlQ/pnt
	 E4CHSJ5OGpgcA1NNItCIuicUIOtTWc3AzYklrUJpbCOrVR/klU+2RgHtE1jPD7MpyA
	 weRBNYJX8+ztb+FvCdFHGMg6QkUD0XCYU6ebiv/EVjBdtr36U/1RrvebZG4vEtkIYF
	 6+RatZq3zyQxQ==
Message-ID: <sashiko-outbox-223900@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/31] driver core: Report deferred probes through
 sysfs drivers_probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-14-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-14-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> commit b8c5cec23d5c ("Driver core: udev triggered device-<>driver
> binding") introduced the concept of "Systems who want to control the
> driver binding with udev" can use the drivers_probe sysfs to trigger a
> driver bind based on the kernel's match list.
>=20
> If attaching the driver is deferred before its probe callback runs,
> userspace sees EINVAL and cannot tell it should try again, maybe after
> loading other drivers.
>=20
> Map that deferral to EAGAIN and add missed documentation for the
> drivers_probe sysfs. A deferral requested by the probe callback itself
> is still not reported.
>=20
> Fixes: b8c5cec23d5c ("Driver core: udev triggered device-<>driver binding=
")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D14

