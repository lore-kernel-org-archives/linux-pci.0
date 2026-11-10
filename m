Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296117;
	b=OTd5n4h+KdmiolaR3hnVnqTmcigB/hBtSJVHuXz+G60wPb5nuAt9uUwPgpCUmsLA+2jn
	 9DxDvxiZv/mPye8ikQAUd+6oCZ3KNvuzEspopRdWeCy194OXncJq7HLekt3FRX2l0x7I/
	 yVwQIgmevp2GjHrt51OmAtGLex/c+NMhsGJgDPxdW2BDevesVItRNCwEc5h1wfy7yHglC
	 7A7i96i8qrdmQM12U6/1Seak5CtEkywfR9yxusSiuPOS2jPdGIBvocpKxd6A433RpxoeP
	 moy37U+trVcQbAyfavezhe32DZSKbG81QcFf2xWQ795I3eDnd3KS4wFCwJL+D1xcgaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296117;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AzbLQeik4XRSh52cjTUxS4MacBULADZNlQYpHP9gwQo=;
	b=4eEJ2n2vcan9YoCFw7x6owg0RfF7PUyP1BWLldvNtVmC9c/9LMNdAgd7muizRvuUa6Nc
	 6LFQrvjzT4VPXCdoPEyl2OqCjCLEv+Z19hd7O6+2JzVTWLAnx/5K+gzNBG29tWY1lWzwS
	 BaezKeoNbDa6/6tkHgD4RkdIEc5//kfckL1pmuUdvx84l7pVrl5ycG6KvJJ1aLLjgcttI
	 alOgtyO6C4BzwQucOqF18pqy4be5GiVpI2ayY2KfwNQCe7QItD6qtuTRbzkjzDVYttza1
	 UP7wjlLbRbKSOP/5023cga/awcRZTvINCgh9GvjJWGJTnb8/RqyQmAUbzJKIE68AQ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GimoIzhE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9C60A260E;
	Tue, 10 Nov 2026 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GimoIzhE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BE41F008A1;
	Tue, 10 Nov 2026 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296116;
	bh=AzbLQeik4XRSh52cjTUxS4MacBULADZNlQYpHP9gwQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GimoIzhEZ30EfQNUjQ9Tw4DuzXSGd3o/SSFmhI6tTF3bxKWLOGnrPG/BRWWxjEVaM
	 rIN5NdoQhThkAUk8tSvBbC0hNLaQDGOTGIuPsOcSnmfd2oz8Lo5DWRd742Na3VaXrJ
	 wnWlFfS3zfyRM7ZUy1fFpKQPwFvuEdkuEZG9ErgkSr7gKM1yxFYK0cNaodqsi7x9nh
	 /YjBZ34XdaW/Mf2sOTuY/V2SPRciSiKIqwf5VVvN3jRaFxlRAAfAucusv2VQc2IK/i
	 yhh5iWdkCKBhNC9vfzdF2VVrpFJYT5sxBiclr88nZ5ElHke1r2LFaCAzSxAfeGaGzf
	 C8Ls3Xeyw2ElA==
Message-ID: <sashiko-outbox-206506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/19] cdx: Propagate DMA configuration errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261109-device-trust-core-v2-6-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-6-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:16 +0000
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
> CDX reports successful DMA configuration when firmware setup defers or
> default-domain acquisition fails. Driver probing can then proceed without
> the required DMA setup or IOMMU ownership.
>=20
> Return the configuration result so driver core stops or defers probing
> instead of allowing a driver to use a rejected domain.
>=20
> Fixes: 2959ab247061 ("cdx: add the cdx bus driver")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D6

