Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377585;
	b=msniZye9ON8CNbHghaPoAduxuv9hcWZzGgPI//i1qhs5slTXg0Fo7/SnQgILeMObEHcv
	 UFQ9Yxg3o5CliAGuDMHJXKPYuF7ZAw7yrsKeUNM4yrIfzGUmyFotHMtjzg+yc0bf2Ey7+
	 jgQNjfr260DBaqEf+V+iAcC4IqRUdSOh0/BTp1cXj2Cg553bCtLNurnnHwCReOvA3xr+s
	 lgvIrX4QwrM3KXO5Rjw5R2k42yJNjkFYQHWcem3QREBt2C48vGVZn92K3roaKJz7rdVQx
	 fr7IURV7cVWZVpV+0VLCPPMBoJSLYQt7hgWJA7nJzM5mzYK6MEi7TKQA82vIRXIj6ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377585;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PvnNHfsDkRcSHDsWMy20W3XIOocOQK5w54qBrg26Hfg=;
	b=coS74afWVDZ9DYUEz19lJGbxvQpB9arcBLO+hyX3VuUpiYfm0+1oSlHY2L4f9VNNDbcy
	 fEdnpKg0UBuMcwdzV3gppuik+efAUz0JVckyC36KDs3quEK/whlFCdrD36XfoLojDYZQm
	 qx1ukRQNm/UG0lFrK1kw9kYf7qwY3Dvi+Bb3fvsXerZ4lFOXCWWeQ64gqLPcs+AhPEnem
	 eTpthkoobH1CWbkiEhdXQUpGEHKt8gfbRIbery0CAg7uy/wHvfX84cll16woc3hB5kuZF
	 jLuE+MopWIJJJYG9Xcms+Y5WMnUR3x+aIdpeINF5jFpfImkbGqW4LZ4uFHtyie+GQNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bqelv/sq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CE606A31A
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqelv/sq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFED1F000C0;
	Sun, 22 Nov 2026 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377585;
	bh=PvnNHfsDkRcSHDsWMy20W3XIOocOQK5w54qBrg26Hfg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bqelv/sq5WcibTHVMIX7YbYrpHYJn0mW5p6FQZ4SZVU5F+cBVoMo+SilP6zYBxaW2
	 5ayAKo05i34eJ/Uv2U1Q1B4ueUFa5MIM3qprGDCSr7CHP0jTVqyL5U/HMTcSf/qydT
	 qmZf+VytS2DjMRNjVdCUmTuNzaYa8FGbRCjw6gfjD36VfdGz9z8aXM29NO0eXvamR3
	 EXbsrH6FZAEQmlULbN8iBPvmoYqvSczPgpk0jOkLsHgYmGhIN3D1Lac/VoFF8m4Tm1
	 Kr5sfwccjmyK6qGg/8kAMr/WZzS7soYWfbX050hRlub6nAJkpFY3x3ef/35goZdLgd
	 69T5InRBl80sA==
Message-ID: <sashiko-outbox-228302@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: xilinx-nwl: Use devm_clk_get_enabled() in
 nwl_pcie_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Elfring" <Markus.Elfring@web.de>, linux-pci@vger.kernel.org
In-Reply-To: <f691bbaa-ddb5-45bf-8f85-fcf354a6af03@web.de>
References: <f691bbaa-ddb5-45bf-8f85-fcf354a6af03@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 19:59:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Nov 2026 20:35:35 +0100
>=20
> * Reuse existing functionality from devm_clk_get_enabled() instead of
>   keeping duplicate source code.
>=20
> * Omit a clk_disable_unprepare() call on an error handling path
>   and in the implementation of the function =E2=80=9Cnwl_pcie_remove=E2=
=80=9D.
>=20
> * Delete the label =E2=80=9Cerr_clk=E2=80=9D.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f691bbaa-ddb5-45bf-=
8f85-fcf354a6af03@web.de?part=3D1
