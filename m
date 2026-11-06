Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965425;
	b=0ae8wVDZ6hTBUtH/QFSmrCvutf+xBsV0m+u7o0KbOD5tlOCaGeCRD8EZPP9oNK/lh0za
	 YTqw85XDFt0mkgxh2/PQUkStpdqRNNLAOb9rSyAyR6qf96K3WnRgtiZNbvwLfJSVpk8/C
	 fyLIGDwIaBD8DJR16K8PvnbxGLPLPPq9xOQPbrytTP92Apu5+eBq4d2c89POyUrTm+3gq
	 4fR3AZK2w2s4kbFBLdnPho22A+PmK6pyHr1UyTFz8fN1/pyjqI99Qv3qArGKg61W93RNA
	 7MtT2IEfsF1Q9zKg/k+YnXa5Xo0NnSa3syY6VCg6loeO6QUAnV1RzdTvWGo/PHnc6NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965425;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mYb9I/i4oN+5KPNAFfcvK38PK/l3XTbJLVCMxx9gZeM=;
	b=2qTtyqYJRtNWZ38rbsIZP8/mYdXQmtdBMKt09iY0WqGYHogi5wvr1XyS5Ote3I9D1SUC
	 kUSzQE37PO/glVSHH/0F6EjT/e3q231XhRijgaYaXmuqQ/JZw0O6ib1vqP+EWO/j5mgYL
	 9n1Eb+dOnHSaW7UT7Czd7xfrTPh5ujHj+dFD0g5JRz5xqzdTlj/KXWwkh8F0f6PT803JI
	 Uom5C4SxwvxYlS8oRF22hPmjdpGun2sL89oh/m6pRhBWSl40X2T5RGvjYdCD5QqwoWg59
	 uWThsaBmAh9BSoMH+qbJj53PcFyUUy9Zktp5X6P7mBi9wUBXKdDeY61Cri85hqFamxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+0t3ADs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A65606D825;
	Fri,  6 Nov 2026 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+0t3ADs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05211F008A1;
	Fri,  6 Nov 2026 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965425;
	bh=mYb9I/i4oN+5KPNAFfcvK38PK/l3XTbJLVCMxx9gZeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a+0t3ADsz/ZSGZOlJMLfvGb0NMz9fSvYrEgWP19gzLXKHb9wn24+5IJjP1JZHxQxU
	 xt7VBP+8lwjlikcu1gmO2YPXHlf/k+qOQZQQ7jDviT6D9WC3N0PcT6YcaeU9VSLW+Z
	 0LmvI5crgQj+c3VXpFPKlQY7Mq+g76DsSrMm5SV1scLz4cIglb+F9H7P4jIBRk5WyH
	 OuqOLx7momr9TBim0g9ohrbF6i6RY9eKLk+wQZp2DeJOi6hDrqFLxDujXyJnecr+7J
	 S3d/TAY6fZrb5dGolPLKYs4ORtou36p0lsSDOjBuOAb+h2R7tWKy1/ew8G8uq3iEnZ
	 QOZGiy0XJwCfg==
Message-ID: <sashiko-outbox-201343@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:44 +0000
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
> An initrd must authorize a disabled device after attestation even if a
> built-in driver already attempted to probe it.
>=20
> Expose requested trust_policy and read-only active trust. Allow explicit
> disabled policy to advance once to adversary or full, fixing that decision
> immediately. Reject later policy changes, including for a device claimed
> before registration, while allowing same-value writes on live devices.
> Keep initial unrestricted selection separate from explicit authorization
> and bind-time commitment. Serialize writes with probing under the device
> lock. Include the attributes in device ownership changes.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D10

