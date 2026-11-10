Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296126;
	b=Gm4MiULDBExAelpawbbIbyDrPEan97Gj07yyXaOo7Yf30kauabHBsSR84keAe0aQjzlj
	 cTfaOLvJHdzh1qc5M5ieUm8OnCz4Oe9ZdSC5CYHoJzBeTSxic94AbPknlF5TsEnQC/1S2
	 lOOze1Zxgxo16kEXgpviHmArQ7t/8BQgTfi7xhNQI2hKMokO8HdlQmdPrS+tcJKjE8PXG
	 oRhL0w6bXXMlauIe90efmHtrcXjUHDHmiPBYO/ZAjuO/2czKKIpxdxUClZKeccVHCFNAb
	 G7IyWJs2qS0W1mfNQmNze+mJ+gHXpWukA/nHVIqP7LYwpxrhsvlq0UKnWJsNbxGf/Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296126;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q+yJXt6spYj6cFd13Oy/u8WgXewaen8OtT+ASGGqLYE=;
	b=SQ9xTINyzcKX1aRUyMZaHFQbhlsrzhaQZBxUrGUPvRB7tnHEa7wrmCTIPiaIRMXpr+z2
	 c3bMvhwvno3jFRtys5erJ5MxuKkpfaU2XDCOxelGBWBUu7jEpyZO0px/ddWhFl9GYINQW
	 +mmO3/em4y7nB+fmP3Es8oSQGKsjTw8JK/N7SOyMsDWH5Xwlvoc5YJRvelRdJH4elSEcT
	 nz4KCPqW8FBkSKGKZtjRqnZUkBd+raMfy/g0Xxe2WKiYHeDiO2wYPyF46SUSMPP++yBku
	 X7/PVB31S6n7WzZPYlgTwMeK8Y8QYb+ZBoG1i8AGRPOMogxfsDv2lQdTp8oRZ4amEUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYnvWBab;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34160A5BC9;
	Tue, 10 Nov 2026 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYnvWBab
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA781F008A5;
	Tue, 10 Nov 2026 07:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296125;
	bh=q+yJXt6spYj6cFd13Oy/u8WgXewaen8OtT+ASGGqLYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mYnvWBabC6mZ9f4CmsUDgsNCBC4Sh69qio8Xw/vhXHWgGqQgeifIqHre6wxk7Cq6u
	 SD6CEOfyYwQ+CmLEfo5AEk1pV3zFvFlhIC+yPEWhfPzyZR2nhJi/epWC+d+zYU6NGI
	 7oRuhi+o8nYSFPHCi8NBnq+LmmQBhLqEgzVyOq16yOsOHr5BPxRea8H96Ezvs4xaRm
	 pfS1XmRVtk/buipxoMtGDlXE9M9A67QfDaCG8DdtD+2fhptnTRSp06RrC7KXIhFS8/
	 A10rdgtvwhMgbc34rukW0NGs5aQ2O3x7yNQuhA9d4s6pC8R2CtnGNM3tW/cwoSR460
	 Iwf0H9Nff6b9A==
Message-ID: <sashiko-outbox-206517@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/19] driver core: Document trust admission and
 initrd authorization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261109-device-trust-core-v2-17-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-17-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:25 +0000
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
> Policy agents and bus drivers need a shared definition of authorization,
> commitment and active trust across boot and device lifetime.
>=20
> Document the admission state machine and disabled-to-authorized initrd
> sequence, including built-in probes and pending work. Explain DMA domain
> preparation, binding restrictions, device replacement and current userspa=
ce
> integration requirements. Distinguish attestation and containment from the
> permission to bind a functional driver.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D17

