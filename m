Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116571;
	b=ViNh3+Tjc31BOomfH0vncd8FCqAzjWod2DYtExG4pc5oV1hDrUhn3LGzDD9FryVNoX/S
	 gosa5MckEx6VzNhfopw7YKpbepa624wUuv6wU5htorDoW2ponHbd/9UY+XmawdnTgpsix
	 6UnsUE803Uzrll7hNH3Zctdun+mWh1dviY9Yb3rKk3a1jy14ZKfXkqSfErdggKTMmKLdf
	 sncAoppiooW/Mp+OMiWEcws+DCpIDsVawWyKjvMb9EKGH8nameJccG44S53ndU3T3GMwi
	 1o+9xe+9l1/LTGo9p4tLo6O02DAm7s4UZtie0VjPUbLxhgBkU0e2e3IG2bpmAl/4hNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BF71VyjvOcQjCFx8g1YnlK0Qsu03HOg1k9EvcjzXylk=;
	b=SNBXcpfuWdjo56pukQQXLZJiV2IKB4pzX8snDWUsvz2wYW1gMblStobfCdJzj9e6dxvd
	 GKn6HaTZQQ8uEwW8XdJhSPxbg70vboB4jWmKH7K5YjOooIbiFoKl5aZ6EBYvwkXceOcc3
	 7kQ1c3pMur7kkf/kUJK2B57LvqtG1jjscC+4wBD00HBmEeyb5Pnjfltlq9Auba1YgYE9z
	 qxo/wMIQ/XgyuV21k0UH9Asz0QIPcIQlt/ku01UY3iFSOOAvTrd9WOZAHaOx7zZUcu7gz
	 fZ+gzvcxq00c3+EqhCz3oqSJmYDltJbu0M6/iAbpa4g9kpb3H8BDTA4lB7Afl7um+AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMHe+04T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF8160A260A;
	Thu, 19 Nov 2026 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMHe+04T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30271F000C4;
	Thu, 19 Nov 2026 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116571;
	bh=BF71VyjvOcQjCFx8g1YnlK0Qsu03HOg1k9EvcjzXylk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MMHe+04TlgNR9Rgckz6AgM20zhQjTljvQYNb4c8R2WSul4ape1SEvrj+swXHzqhb0
	 hqZG+2tXy1DkutKUN1ySwhhrgGOsb5p9eZFLaPPiD20FYDKhirHeT5PCqKx8sTEOWS
	 W9YAZm/g8+DHgavGqWYXrDrazXxCVaFxeZXk6HiW/N2LvTkoKTPNtrc+BR1n4mVub2
	 ZgTt6xGPHMxI8YLt+BUVHhH/5yeOl3EXIifMUS0VwusJKUtloLYybv/KflQG+8+moG
	 d42zlNBUPMqiTSPnUtwwu03/y6H6JEqKsphq+rjSXJmxLEmjp+LHkpmwUwlG1loCdb
	 NqxlddN3qTIOw==
Message-ID: <sashiko-outbox-223899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/31] cdx: Propagate DMA configuration errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-13-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-13-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:30 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D13

