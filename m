Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116585;
	b=ERB7egLG6ISdRYuFuc0PRfoaQhPxUmarpi5SrWdalBGz9O7nNjKHc4Z7rgnLg8/w2iJO
	 6r5th2EEK2Cqog7HvtlBmSnmjzTXLf8WT2UCvv1ltPBzMoHO8HgAN0TfezEnvzxV12H3N
	 SaXSx3CSDL/PBUIiGNeeRU6mM+EQkoW1ByNR5xFEZtilIdWrloZhAXLjDfhm4BRP7bcMi
	 xycNWQwq1oFpPDtvbylxbUnQocguhS//Ljc01JCWa+Eb8Jbjs8rjUM/H1kRizcBD4XtRl
	 JH1bB6UcgchNPYnSI3q5A2U41YnTiEMK7Bi6KesB/B8emnub40Kdet6MRIMCHLFqi8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116585;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wg22hG69qfPIF768FAgfebPdyLr1DWKju9YZKfDnolk=;
	b=ncWvSBqroh4p1kZCWRt0NfQ16ioYDnPY0ucybemkuX5pTfItPmBwGoOtD+swpZlML4Df
	 eQMMayUMt+/qTM3OfP3Dl5D9aGSls03vdJ5dC7bC8tkX7gksr6Eo5aTWwprARok60SdQ/
	 cA451GH1gravHTHJiez2j/DpnOFzrWSleyqAV8USNYM8utoXnhgNuumNl/0B2giSvpGxk
	 6OKKv0jEKZ0mHmiraqZPr/BoEdRqUH/f8//HxsGRRF8aef4dgqG7SMdY2Qt92IVnMl5wq
	 V7RvF7LMJEW4cr8oDsPa4EBxcfbDkPj9eizya6NI+9tS/RibPQkRFd2sIGMV3iqs0+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMjB4+OF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A560A2620;
	Thu, 19 Nov 2026 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMjB4+OF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8321E1F000C9;
	Thu, 19 Nov 2026 19:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116585;
	bh=wg22hG69qfPIF768FAgfebPdyLr1DWKju9YZKfDnolk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AMjB4+OFaj+mst9MMgH8BKAMWo+BMD7bfzSV0JY6u0xCz9KQULHS0VK8N4KIwTLMT
	 L0wy+DqgXd9ui3rE5xc44DKTHoJNQHGGckMOOBvs0DxEMUZENVNDxbAQCYo//vCGW+
	 ic+JO37olO+ePI4LLp+AQdByHNrJJzLLOZpvHC2cjW5IHmxB42CxXF4RSJSWjVi+T/
	 M0EG4uXExgrb9eglnS9qRdbzxZAvAzX3OQtmGQxM8qFPkzkMqw407JDjLqTM9Un8LB
	 0wkbMdkJBh9HvxLOgi29kiaLbGmtK8IgoiDiKSVLZ31m2ueuA7d/rIA4o0IwLskbQl
	 /B2Zf1YztQ8bQ==
Message-ID: <sashiko-outbox-223911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 25/31] driver core: Document trust admission and
 initrd authorization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-25-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-25-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:43 +0000
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
> Allowing a driver to bind does not establish device identity or prevent D=
MA
> initiated by the hardware. An initrd that treats those as equivalent could
> authorize a device before attestation or containment is ready.
>=20
> Document the authorization workflow and the division of responsibility
> between userspace, driver core and bus infrastructure. Explain which
> decisions survive probe failure and unbind, and when queued probes may
> start, so policy agents can prepare the device before granting access.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D25

