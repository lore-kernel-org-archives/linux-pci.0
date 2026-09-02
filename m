Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDD4A0922;
	Wed,  2 Sep 2026 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357011; cv=none; b=F2MCAPG9lF6tSpdbFkZLR9emzIFk3+eEFFGzHg5mCsTdJXJohlLWJM1mQmp5nFnz4vpS8FCQNAnsxfxdgVa/HFA9OD5tqM+feBusDjcLOAdQFx1pW3UNEhVhcSAdykeEQ86P3zQoycGwFugOFmTg/b/cC5K4JsNfZWqSiq4sgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357011; c=relaxed/simple;
	bh=V6PrF/xro/GPObKKakPCH6IJsphMzkHtwp1hrRNyCLo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UOLv14xtKi3bojajVCUc1F4BHSepJ1l92cJaxqLMXzSp+FSBn4NbVV74UeLo3YoNyYa9cwnrUQ14mEKybus2o3WGO8s/nuj0+1+8TciZfP0P0j6UOuUrxjr4hElhvOsVKo1GvYf01HBdi6iFBUund9TLtEl95fr2GHmipAyH36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPjSoXv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPjSoXv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100061F000E9;
	Wed,  2 Sep 2026 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357010;
	bh=V6PrF/xro/GPObKKakPCH6IJsphMzkHtwp1hrRNyCLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PPjSoXv/dBe/oYKrcD0AxYU0YUZRtahY1bIuRuc15a9BOEE2MBSqOg/p11bttwQ12
	 yYTR26tRbmYnbRwW1Tt4tL9xsHI6wnjPoIIwOsn2mZJRkAlnxQo+yFYutEDnvajJke
	 3CIQlTTmbGg/fPlB5yg3GDLW9fsdue3c3ucJvowrJdd2juXPnpL+dEAxxzFEd1Exsb
	 P4zKYh4DBNqZI8oGBdbaJN8RKcWsKs4NIQYrrx9M/+GeM/KWCXjsuDBVoGukKXOjAI
	 UEB5VG5nFIGLDHeHmuUugbuOZlCR2O9X/Vf8RbrfCznb/9OJU4yl+npqNZly2qRmc/
	 LIj4ePdYfhfRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 3/9] cxl/ras: Handle RCH correctable and
 uncorrectable errors in one pass
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260902133933.2992457-4-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-4-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:50:09 +0000
Message-Id: <20260902135010.100061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> cxl_rch_get_aer_info() reads and clears both the correctable and
> uncorrectable AER status registers in a single pass. The previous
> severity decode returned after the first matching class, so when a
> correctable and an uncorrectable error were logged simultaneously the
> correctable event was cleared in hardware but never traced or handled.
>=20
> Handle both classes independently: dispatch cxl_handle_cor_ras() when
> correctable status is set and cxl_do_recovery() when uncorrectable
> status is set. Remove the now-unused cxl_rch_get_aer_severity() helper
> and decode the uncorrectable severity inline.
>=20
> Log the uncorrectable status unconditionally. __pci_print_aer() only
> logs it via ANFE recursion when aer_compute_anfe_status() is non-zero.
> A conditional skip could drop a fatal or non-ANFE record once the
> hardware status is cleared.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260803222923.517B11F00A3A@smtp.=
kernel.org/
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902133933.2992=
457-1-terry.bowman@amd.com?part=3D3

