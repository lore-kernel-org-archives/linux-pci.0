Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730B377A9E;
	Wed,  2 Sep 2026 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334753; cv=none; b=BYrLai0rCnEsU4+4AAQPWhZwrK+9POP+UrKYReJslA2mSddCD4Dy+Y5Fj4/1uvM2yCCxfj6SPyYxUAmgBpONqsjcYY+O0r0/wmUDNB7FCtp01n30sthCD1rT6u7JKt2sMtyYjUIPpnb5MTI01bC6b9GS5Y6Ce8NY3ouYh84kXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334753; c=relaxed/simple;
	bh=bsefz2HeOELEJ1/jH1CeKTdgzsm2xjGoS/K3MIqJ0Ps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SBIh8bHjEL6srIZEut2h20t8Scb6x90fLmsh5MKHYMLABQMzgtkBzpe5iY5Dv5EOjzptrI5GTW2KeJepBtjeEiyO6+/FbxbrXfqhu9kmWOQOUbDt19TpCfhbzGZ3gZqBwKRGMDC4TzbO10KCzlRQnKu1VGkoEG5vPk4tkSMore8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu4xoGow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu4xoGow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CC61F000E9;
	Wed,  2 Sep 2026 07:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788334751;
	bh=bsefz2HeOELEJ1/jH1CeKTdgzsm2xjGoS/K3MIqJ0Ps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lu4xoGowZMU6YtJM5MSOl5D9J952ybgUF3NUYVBOgUmtZRCmp8yqL2RLjZ0f6QLtv
	 LYmAFQmT5Z52yob1oxQ2TEWXQkgVer9lrJPTdZ7m76XaE2jsMyRy1hr2SbKPX5kl1p
	 8lL7F0nFETRHKvQwTQEzzQmuh1ADXYp9jz9m83IfLQbvWEW0F8y3UJEOlv4t4y3Vbc
	 p3odlheXWDurlVa8ajD58Ju0j8MBTGCG620rXTWBMiwl8nYOD3GRcDX1n5UvYhrw4H
	 Iswu/wO2nns9tcUKuTjPPZhWKDTucgW+WjEe23m3IStE46mNls2amEQu4J7GCyZ3BY
	 X872JRN7C+8jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 03/12] cxl: Share HDM decoder decode logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260902072804.665639-4-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:39:10 +0000
Message-Id: <20260902073911.55CC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move HDM decoder register decoding into a helper shared by normal CXL
> core enumeration and early PCI HDM cache setup. This keeps validation of
> base, range overflow, interleave, target type, and enable state in one
> place before adding another HDM parser.
>=20
> Keep caller-owned policy out of the decode helper. A committed zero-size
> decoder now decodes successfully, while init_hdm_decoder() retains its
> existing zero-size rejection.
>=20
> Preserve endpoint DPA state ownership by using the decoded skip value as
> a local input to devm_cxl_dpa_reserve(). The reservation helper updates
> cxled->skip under cxl_rwsem.dpa.
>=20
> Reported-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072804.6656=
39-1-smadhavan@nvidia.com?part=3D3

