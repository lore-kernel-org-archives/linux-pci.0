Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843D3E3C41
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485842; cv=none; b=PXRF2ZhjSx+NOSkq8vJTbOELDo6T8YWG5ZwP9azlMRyMa1P5PNTnBSbOPW7KvGxoHoMxtJjOOPeWmWMeUJcOM2Oo48febG7YpkxGfuoKKaOnJFqIjbD0y1a8wVH1d4OhL/0k0/gxa+7PsbTcJqFghUhvO3bpoMAmkyq7MWoqmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485842; c=relaxed/simple;
	bh=vcj031Wc1kQS8ykJghfPG2WWW4TP7CPrY0uzc2LC1FQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=caQ9m3XItdVFM4dlfvhjeh6ljf/VtH8/Gt4bo9xAFx6J4EsAwvoSx2zRwbxaMGKqVZVNurwt23PJ4xUs3SoNnZF5tgKaCh9RRnYKQB/KyY5rVPKGHp8KiCA+4w5TKCb05g7GhXjgcZ15KB3SjRacU4uaz6z0UCCZWzusZQaK1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGAFGxoN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGAFGxoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D881F00A3D;
	Fri, 26 Jun 2026 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485839;
	bh=vcj031Wc1kQS8ykJghfPG2WWW4TP7CPrY0uzc2LC1FQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FGAFGxoNJkxu7ZwaeV8ArNUmbt4/qqExGvc/dxUAVTOzB9j8QAReH4jGgBWBUqU5F
	 a070NLAjbXjxdGYIq1MDv8P9DuoJxIBFg0sr8WSl5M+peT3zO4/u5Q/Md/UpgkRCBG
	 f2hqX9qEtVpHrO8hBwgBouiMq+T+dS+SBQaDzU+s8Hm0YOhH3Q6Y+mxJPryLdnOTPp
	 HpzquO8za+GTOaEgwmtmhDZTxXiLzpkKNzQEAZOIAJlx9qatjY2OSSv0XcmI3Rx2Fx
	 lTiJIZdECv0+hezoz4eCLqGcg/LzUGrD97flqI9Qb/5haFBst1x8gGD5uWNTT1zAcn
	 PBor9wsi3NqWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/20] rust: io: add I/O backend for system memory
 with volatile access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-io_projection-v5-14-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-14-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:57:17 +0000
Message-Id: <20260626145718.96D881F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Laura Nao <laura.nao@collabora.com>
>=20
> Add `SysMem`, an `Io` trait implementation for kernel virtual address
> ranges. It uses volatile accessors to provide safe access to shared
> memory that may be concurrently accessed by external hardware. Implement
> `IoCapable` for `u8`, `u16`, `u32`, and `u64` (for 64-bit system).
>=20
> This can be used for instead of `Coherent` for cases where a different
> layer takes care of mapping the system memory to the device (e.g. dma-buf
> or GPUVM).
>=20
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> [ Rebased and adapted on top of I/O rework. - Gary ]
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D14

