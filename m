Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381168;
	b=nscqIRQ/KbAyxkxn021P3gw08PnvR/mMzINCZBO9aWWyIL45RnsRmPWQubAV6oBgcXyj
	 UynzLdNAi7AjQ7QOi7VdNN+kPO8vVPUNcQNsPlOvOd4SXAe7eggSJmhHaPI2FgP5jHvXz
	 IWdDXs9d59JPr6B8naOwWwSnV42fSdBCwPT1MmfwYOWBZQZi22vSMfWmao3CNVAzPdF8a
	 m0e6qljuAQQMauYQPGb357eb/d+oEuUeFw4bXv59iToRPqEDB4SOZIDiMI+8MyEPeisOi
	 dzeRiUw7unrp7PVxr+zrdNHIMIuWeLgHcHCa9AwXBNyRUX7xcG27NREe68cgWuKsW6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381168;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=txQ/G97PjVZ5Ok80PODaAz6sqAwf6s+Iuvre8HARFnE=;
	b=3aR3QFWBDTMQk1uoJmUc63+26Q+YR5UqUdyIPoOsuSvWYeuSCPJqJEtbDLYrM09djRzO
	 fbgxCyZRgdzUqSEgVJFfuuNEML7nrWEuxco88Wr7zUD8hDjsABkOaFUR2ZqDwXPUCFmSO
	 yqYQo9yn1RFqF0t26YKxuaexiW6rdnTnZFE+v60FDcs6f7ol5pOW6IF23jZrykbN2mVwE
	 zvkLGpTE7kWad/EySeTDRMtRUwAyRK+ZiSA/JbhGzTs5M3NR28ZduL4KX6VHmgYkIWw8R
	 CsvBeIwXvaqzU2nKF949/M42F9O6aW0uXSc4OdRazfkJSAm2oUalw1WWPFvsPgmZfnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R2/Eyp00";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537E606A31C
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R2/Eyp00
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386C91F0093A;
	Fri, 30 Oct 2026 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793381167;
	bh=txQ/G97PjVZ5Ok80PODaAz6sqAwf6s+Iuvre8HARFnE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=R2/Eyp00+xVhZfjBx3brgUgs/mJ4QPTu/Ope88Eqm6MPQgoeFPoKuv3wdOPwalyxB
	 /lsgYZyM4r+x9E9Q1Sq452T+ixWx8jOQrFUtC4+VKwKCM/0+uJAYCixw1AAgw3tKCU
	 Pt9UOW6hLvUpfgog4M3mo4OjvkJrXg4xhGHFyz9/9i53alF4vh3PTziWrXTgUwx14o
	 8YwtS1TIGT0JI9APJGkUvsJ3lnqDXCj4vQKx7gOltILDoZpefwu9VXofbQ8QPcP2Cs
	 bYnb+lL5AHKZ1Okq+cIpAp+esfBUz0rBEpepJXHA05xs7+VD5BLEPH4SuzN9kNgJuu
	 wEafNJWV6z27g==
Message-ID: <sashiko-outbox-191336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] samples: rust: add Rust SR-IOV PF and VF driver
 samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261030171230.196717-10-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-10-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:26:06 +0000
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
> Add separate PF and VF driver modules that demonstrate SR-IOV using
> QEMU's 82576 (igb) emulation.
>=20
> The PF publishes a pinned API object in its private data and exposes a
> submit_request() helper. The VF calls this helper with its Bound device
> borrow. The helper performs the typed registration lookup in the PF
> crate, keeping the API object and its lifetime encoding private.
>=20
> Adapt the nova-core/nova-drm rules in drivers/gpu/Makefile, preserving
> their metadata, export-selection and MODVERSIONS recipes with the sample
> object names and paths. Set the PF crate name explicitly because its Rust
> root file has a _main suffix.
>=20
> Keep the helper out of line so the VF module has a real symbol dependency
> on the PF module. The module loader therefore holds the PF module while
> the VF module is loaded, and modprobe loads the dependency automatically.
>=20
> Each driver has its own module registration. The VF module can be unloaded
> and reloaded while the PF remains bound. Unbinding the PF disables SR-IOV
> and removes its VFs before releasing the registered data. The shared
> Kconfig option builds both drivers as modules or both into the kernel.
>=20
> Link: https://www.qemu.org/docs/master/system/devices/igb.html
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Co-developed-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030171230.1967=
17-1-xinmengs@nvidia.com?part=3D9

