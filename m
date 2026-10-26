Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030115;
	b=okOt67aj6WHbI262TGyFwS9KmRcERUBci7sX6UTLIu/BSnbbyY+ixEx6QPxPIr1Gdyu0
	 lQk8h+4HrioQdK3BvhgQR4UOPwyDpxIGN8U4LGx6pYTkZFKqFjyc/Y4N0rAHKIzcc7Gp6
	 7cuOroe5ivvaRSe4LNEdfk4JisvG6heGNiWH/sAXjLoSqNtiXlG/n5XgDiH+PgNJpmvrJ
	 Ei17HgIeKiLIirrDPYGhgsXpcLGg0iNTnTr3UgqssY47QUqYLQAlYENiCm5tmrdXg59FV
	 dx5YQ5UfKTCtWGK5xMZsJlDFGlqcZesfq+MnDAL24Y/c8X1aUDXGM0p9j3c3VgRZyUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030115;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O6fMUrp+ecvD7VPfYPqHE9Da38OHDKRWYoo9wThltRY=;
	b=C+nyLqKdnNoRqEAw82RpSq7OrAMmtEY5ynpTGPWltVsvUaMqsgOpxUHwkpSSRm4h3cAy
	 SWIo9mmFg7OABjfUtJVHPRAyGVRZ1U4xzEfnojOHm4mvWW9m0jrogfRqbb81dKQh01cqB
	 d/xdTXH2RB4w4YxDbKwHqhiP10YwfQF7asAeobR67nZpM+3+iL21wDA6RZNa08VI8qT/O
	 iPI7N5Wytrr5VNsafWzcMuQIad5VnFID2scevWV2Bwp/Risf/WhcaplbtvMEzZiHcboN9
	 McmLudIsEiQSwTFYiV/4LEHMcdaJIHCebFCZ8lm7xNJsw5nV32muKPzygNiA5KR5HNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ln8IwpPK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2408F606A31F
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ln8IwpPK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0F51F01825;
	Mon, 26 Oct 2026 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030114;
	bh=O6fMUrp+ecvD7VPfYPqHE9Da38OHDKRWYoo9wThltRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ln8IwpPKyjinhBlu5ggshhvm9/+Tj5e6uIW9849XGZJlnjt0BjNnYNI+sHP9gtpAQ
	 9Yd7Oj1gJS+o0coJedxNrAZXpNxh7qg2eydGB0/VGwswmXuZ6LzJqonLuhtKnRUpi1
	 9kiYwpM4e3CCfzRESaS7BBbbMYk1xZZqT3wFLkeiTW2TKL3RHMklGwOUvmxD+fxF1F
	 5antIbvogMsTz/DUs4ow0ScqvYbbRlt7Qqd7Z+vi7PVwB3uN9prUs1DJkxfqORGzf5
	 jBKWJMaLttItadI+F3EBmuTv5Jj3Sey2kka0zy81c3zTVHPtQlS4kfV56kgUsskypY
	 fm693xK8g5vbg==
Message-ID: <sashiko-outbox-185469@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/amdgpu: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261026-vfct-regression-v3-2-fe9586ed6978@amd.com>
References: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
 <20261026-vfct-regression-v3-2-fe9586ed6978@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 15:55:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present. Compare against the bus number captured
> from the firmware bus assignment before bridge renumbering.
>=20
> Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikza=
dch@gmail.com/
> Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft=
 filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-vfct-regre=
ssion-v3-0-fe9586ed6978@amd.com?part=3D2

