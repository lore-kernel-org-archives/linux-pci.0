Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965429;
	b=fps27ZKNKX/Nr3rPsiueusCk4WpM79qfmpjPA/RMrr0m5+oaSJgc/Jm0Fp0Qzj3+ebT9
	 bDXlQhFGqODQ7PTi+GHYINQBAv0amQvw6DFm09WoInoSp7tt0X2zoh4AO9OrCF2VbbuC4
	 CFtq+yebUuJlYCZUy7cbqn4vNPZJ08L3EMrm2zDu0tvVKjN+C3UcMaqH+4oKSgL/5v7CS
	 G+66VT+YwX1NIvAI3n7qjSFkVrPNjqwm30fErCxxkqLDdoVnC5ddm9QVnn9pfFCsSm+K7
	 9n+Xk9TDEh1JKEQpPbHoryMcWtTVrVdQilndO4Hc9LKm0jByOi6n351BNE8voH8OAdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965429;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FJy/0bwBWyemWehYCdSHloCRQkZnpL9dLHys17RGT7Y=;
	b=mx7r1PeUYzm2udGL+Y6asNSuZJdt03xUHyqCHE0XpkuS0E9DHa5T7HKbVaP6CqA347+x
	 gwomhFM8IhLrHHDd+1vAq/fyCV0yaHccyKjQMrzf8a9pZ6jauPUr12kgjuU17r8k6Uu9l
	 e8eHFSG0QDBIaFrlUesXeS2YL6S4vWilgiJkH2XSxAN08XdMoXlyCim+6V6H/2Zf/kGb8
	 9lYh7URzkWQ9IRIRzrbCM+Dq0jqY2En7Yc2p329wpyxTyT7zdCUjylsNIGt66a5Eqwz1w
	 bU/MfcYR+u52nO8dj8+nCpD0O05w2BlMrDZYjmlEUFY02v9e5qrZ36ajfV5cpazG3Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXWROGPF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F1E606D831;
	Fri,  6 Nov 2026 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXWROGPF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A5F1F00900;
	Fri,  6 Nov 2026 11:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965428;
	bh=FJy/0bwBWyemWehYCdSHloCRQkZnpL9dLHys17RGT7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nXWROGPFL+IV2d1rww7vQ/3jPmuhRQ5CuXfxJqLbxFvAy4aFP3BXATAqMYjyuWLZB
	 7cV96Wuj3W4kHbrGdiD4niqIuMfNhlIvbjItFTWnKpnuSduYVxiIDjSI7KxjHUD3Ak
	 GJt34us1+BiiBtlYHAoJ5J9PLUYyNeOGjwVae8c4zMK8VmB9YocOmbOHMJuxDX5qQc
	 BsIP26l8OvqI5p8ojPxJI85Sa6nI82hSgMXRobt2GWI7Tgsc5bwGHNc2OsGeZ1KLWz
	 8hXdoNBhb9buXMB8/Hy6PV+NlLTqSZAb51ft4LyJaDwE22WiqOlKpVubjXl/TwTP3U
	 YnuT1/VgZyWhA==
Message-ID: <sashiko-outbox-201348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/17] driver core: Cover trust authorization and
 binding with KUnit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-15-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-15-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:48 +0000
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
> Requested policy, admission history and active trust have different
> lifetimes. Rejected or queued probes must not consume authorization or
> leave supplier state inconsistent.
>=20
> Exercise disabled authorization, asynchronous and deferred binding,
> supplier cleanup, resolver failures, pinned defaults across drivers, and
> irreversible commitment after setup failures or unbind. Cover driver
> scans past a rejected candidate, non-blocking attachment, exact boot
> policy matching and malformed command lines. Free fixtures only on the
> final device release.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D15

