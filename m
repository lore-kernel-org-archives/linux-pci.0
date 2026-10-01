Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFBC3E024B
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870553; cv=none; b=a/0ItWaCHYBLFTI3qjRBW+NW1ozC5Rxhi7m73xMNUv7frJnKPP+3RwDHFGPq8wjmdasyQUuMzRhFOJkJYQjkpHKhYoubhmYRWu9anAORxkoL+6MhL6spNgeoOneelGW2eJtKdMnjmAaPP6s2hbzFvs4Gq8Hbrb68EKWPkehXU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870553; c=relaxed/simple;
	bh=dJZIa1McDEZHD6ev7FVej/9NLYLxsGPhzVlCOqYL4KY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g5x775RImQELtM5xjVqKTrdb1fqnF+r6FftP2aOtN51hA0VWCwc/fMN9Vmkek3OJaEVw3r+dSqYxOBb5kuewDeE7V3B9F1Qb853tkh4tNFHJFebVPA9+rox4DywdMmFjcDLkIsTsyfPLgaz6cf1wKzNoz3U0Mb6KBSXn11guxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esyc/76v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esyc/76v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3841F000FF;
	Thu,  1 Oct 2026 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870552;
	bh=dJZIa1McDEZHD6ev7FVej/9NLYLxsGPhzVlCOqYL4KY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Esyc/76vFYzy6Dg+DiIvlok3O9kQXVxuSoM09cHz+utdWsPJiECHYMXmncTHh4ZOx
	 2ZaNsBZkyKuT/BiykI9eas15Kq52YtbI1lmPFnaQDo1TZi9O3hNSQtxfy9uWV7GF0z
	 xxa6JJewhmjAKTrnk0bT6sIhJ/NDekEy2wLdT6/uytkSCQL1uZ3jqm5b1cVKgdprVX
	 iDtoKf+3UJjliTEIN4M6g9nkx8EKN6WpCDs8EucMbXLutJD4lfqqDXmoo6im2ifyOe
	 rqsE4lv49dN4Mwim8a13iWoKdTo+vTVrqJGeEWanZZSLV5pyEz5P6Bm053At2xF1nj
	 5GYSGWgVPW9hQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/3] PCI/TPH: Factor out the ST _DSM evaluation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Huang" <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261001155551.4182899-2-wei.huang2@amd.com>
References: <20261001155551.4182899-1-wei.huang2@amd.com>
 <20261001155551.4182899-2-wei.huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 16:02:31 +0000
Message-Id: <20261001160232.3B3841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The ACPI _DSM that returns the CPU to Steering Tag (ST) mapping is
> evaluated in one place today, with the lookup of the ACPI device providing
> it open coded in pcie_tph_get_cpu_st().
>=20
> Factor the handle lookup and the per-CPU query into tph_dsm_handle() and
> tph_get_cpu_st_info() so other callers can reuse them, name the _DSM
> revision instead of repeating the bare number, and constify the ST info
> passed to tph_extract_tag().
>=20
> No functional change introduced.
>=20
> Signed-off-by: Wei Huang <wei.huang2@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001155551.4182=
899-1-wei.huang2@amd.com?part=3D1

