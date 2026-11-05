Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894708;
	b=Z/VoYuj8Pv/EKrTnfjM9IutdIlkSduXni13gHtvxECLhdI3Z78qxYgypQW3C0ITvwA1L
	 dM6c+0XZwePkUlenq7aT1+OUAwYA3xcdHT2IQawVljtXtl04uHcnkh2FW92bVpnSfiIrF
	 XRVfyfdV2T/IbeN5UiStVZLm6KQNuAe1PCvT1DBjQ5laktMJoMz6jKny/laUcQdw2gxfw
	 w1ecsD/GsTJtn/Ct+gvSSyV4ZMStDVIV6bH8/Jtz9wS530qn8ykkHs0n8Pcvqcbl8HJvx
	 Y9kdXzswftkDef65PkfCzUYfjhAtZ581EmA8gUkmvmHzKFkQm1lYNTNpNKHBLWytmeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894708;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LQryCqHznad3TbpaeSo1ITP3E37VaIaXeeVCZq/moHo=;
	b=lldaqiupUmyqUECqihR22Wk7rYLuXz4XL+xlfY4Wr5XW+hpdsGRi0R2dFRt1JaJB6Kha
	 3IpstuCrb8y06elv8I6zrd/6/qPQgZypZqvOu4IsRAZzD3zpEAhwedKbiAg9UvjBcobkJ
	 Vg7+ItbJT99+v2B1x28TConYHbbk3RZis4jtyLzobCmXvchvKy1nRB/u3IwwBL4pGYE1v
	 mBmbIs39znPXFyvLpPipkEyxtDjAWaCzmw3W8p6aMGTMX+L0ux8XOtvGngacTC6V9Rv0u
	 KrEMkba5jCHD3VEMGroUcal+ka6Sif/6HPDVy5Jm3HRXnxKq6/1FFjZpVWF+U7yNC6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijFlF2KC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084916071D5A
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijFlF2KC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4CA1F00A16;
	Thu,  5 Nov 2026 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894707;
	bh=LQryCqHznad3TbpaeSo1ITP3E37VaIaXeeVCZq/moHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ijFlF2KCl9iM++ZQEEboShjFEOjg+uSn+JQ0StdjgOhIYhkklk8mCAb6ZDbhYZcK7
	 DJ2JR1y2F0gyBE2QdVHZ/t2NvJPg9TwEeIxNtuQyh1NqxYkjktEHRwdEfMRTqWKx7b
	 xcwvbtvsD80pQCONrpL8bQ2mJbiY/z+FXGSsrqV8frjil6HGo0jE8uVeLTTXNxYNkn
	 XreMiTxA+SLcXe/ruTHcJktTzctvclhTlLrQuNUruL7CBhfFqoILH7n3h7Xowg4Ckn
	 DZ5AA80yDybXfJT/dy2SlmH3QUI2vywkgSHWFLv5OPV7S8t7OtH9DwVSnS7ZFV/dff
	 4H2lbu3029bWQ==
Message-ID: <sashiko-outbox-199404@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] PCI: of: avoid allocations in
 of_pci_prop_compatible()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105153801.435566-2-elder@riscstar.com>
References: <20261105153801.435566-1-elder@riscstar.com>
 <20261105153801.435566-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:05:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Three compatible strings are formatted in of_pci_prop_compatible().
> Their sizes are known in advance, and the largest is 16 bytes.
>=20
> Rather than dynamically allocating the space for those strings, just
> set aside a buffer on the stack large enough to hold all three.
>=20
> This avoids a problem that Sashiko pointed out, where an allocation
> failure would cause subsequent crash because strlen() is called
> unconditionally in of_changeset_add_prop_string_array().
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/sashiko-reviews/a647bd56-7dc8-4fec-9d96-834=
622054cdf@riscstar.com
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105153801.4355=
66-1-elder@riscstar.com?part=3D1

