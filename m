Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380666;
	b=nRuXSNzhRdlrIb4WsvSAsjCB8QUdw620WJ8mM2nwczi7m4kj1yIvpZkoEC6tCx7VBSA2
	 oB0Lu6S4E7QibcrR6vW87z5+83GV9kBUJQOYhugE1Scy4HHEL4myUZmGz9BfpHqZbW6vg
	 zSHDCLyPgrSDe0DTkOa6VpNH+K33YKBShA8RMWYGDPjFjuxM5zBNEGalqUEPfB1PwRXgW
	 6eMFZPVpAAP35wUUnyq0OOztN1MmHvO4O7SGHq5++uZ762zV2xlffjh5DCbAsrILfd9Us
	 ptMTVLvs7QdynSzHZCxJaYuduwCpgUyuhTK+obgo1ZgykBDSAboT9A68udaEaGyOCYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380666;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vqX6zQOG30c3EjV+8rAA7lJtQFQ7OyFFxMiho0c8Yks=;
	b=s5N8DS8X1akaaa3jNekjHRHA+jN6kuLBg+qS6e4zwTIRMGs7xBaXWKNMRjSQEAbvqZTd
	 /Ksl8UmKCxm5KSoDDZk7qK5tXGYpfjMySGkcn9X1Lr86a0ub6Yu2wWXp4KUcTf98yPvOA
	 rbthIdjd0/lCPe6eyRI+rWv487vXZRZl+ECzJg7/44iGdWOHZlIwauU9zIBu6w1VaQrQ2
	 u0pQchSRtm3GUVm56EHJkxdVg5t3mxeHOBuZH8zocB1eydvp40MHtz55Zb5Rv/65OwoyR
	 p3VGNYJhdGCXm2/fog5wV7NvzGJnHjYh25xSfXDCQFbbcE9jrXRXeqmUCQVeYF1yGIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VW2y2L8i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC94606A31C
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VW2y2L8i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461471F000C1;
	Fri, 30 Oct 2026 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380665;
	bh=vqX6zQOG30c3EjV+8rAA7lJtQFQ7OyFFxMiho0c8Yks=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VW2y2L8iTf2skPhsO1oMm9n7sGDVsZyypNt7Ver3VZHGKNPlAqih1ZAMENfaacfrk
	 j07KwRFU8J4P0cxKJEG6RptBO2mjvoRyFyCESz0dRq6UJPodw+Y38BMpcC5hIA5J6J
	 8zNDsDeyK9qmOQ2Sp3oG8/T+ctGYsT7Tai0cFidVneKatNGdHIcJSHSWYgnEe+Fx06
	 7IvkEE/0ERjov0Y3pzITbV49xFQ686uEDVySGUSIxQFu49d1qeTZLM8OAXNBRdiNRf
	 6vd0MrMzcanHiXluXLEoJGSdlEi5woNoG7rekzn0CJ8h26vwPvNgfFJ2K2V86CdMOT
	 iPL78eF87tbMA==
Message-ID: <sashiko-outbox-191319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] rust: pci: add vtable attribute to pci::Driver
 trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261030171230.196717-3-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-3-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:17:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Peter Colberg <peter@colberg.org>
>=20
> Add the #[vtable] attribute to pci::Driver and its implementations to
> support the optional sriov_enable() and sriov_disable() callbacks
> introduced later in this series.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030171230.1967=
17-1-xinmengs@nvidia.com?part=3D2

