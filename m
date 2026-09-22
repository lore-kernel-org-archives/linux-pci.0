Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6F39DBF8;
	Tue, 22 Sep 2026 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066876; cv=none; b=h3z2J2SK/DObYr3Q9oKLaKYDpSDHL88xp0r30ILhv0OW2B5/2h+S4rvz9H0u/67AeJRv3IMPXEuDShZzySv0K0Z6Q3/PbaivLpoUnggxCyi+UzQmYv23wTRUYeI+t0f4t83skqKJUXhnVXgXh5nlUjOCvrkhdEW5ZphnkgYSv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066876; c=relaxed/simple;
	bh=iQADt274MrxZKzsEFn1bVkPYMyulWZ11U+PzEBFYY3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kHPqPYOKQI1wAQz0HIVHHZss1U9vZ0AkyUZo9fW3FdzqOyAGRWF8u3Bl22VHgaG4yuo6s0Ou3/PLANDbGNRS4rWb0LSDIQJ9FOpEeoT7bcy+CupumC+sxt7YAktC//k1X5r8soWvRZftqolXB/Za1QVdZoM4Uh/zO3M1ejBga+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCGT9xeT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCGT9xeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5681F000FF;
	Tue, 22 Sep 2026 08:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066874;
	bh=iQADt274MrxZKzsEFn1bVkPYMyulWZ11U+PzEBFYY3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCGT9xeTYQDQZahVjmi68OXudF9OVmtS6ivoEK0uVYmYCkukuZUP+7vQsZ5A+OAPY
	 oq+IIL70i0Y51RN27D4Y2i+AzBN+Q3Yz4rZBrezeGaZ5mX0N22KtqdrIC3cKXftlKR
	 +I+KAzeMezywZj3fiLAW0AtcztTmRKSJZGAR29xc1hhB+nki2ZQFI8nzlt94smBa7A
	 akmx7a2FSjnZMa9EFG5cdnT+lCKLXAmvGqbiVe27WNTocxljUfOfq6YDa95QLWtdYA
	 OVKYbdpSJ/V0gRzLdklYlRFjdNgnMUrrGhi4j1TVRmd87KYhW9GS6yAm1WyT/dBayb
	 wMVNuhAoEk9OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 08/15] cxl: Refresh cached PCI HDM decoder settings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260922083924.2451158-9-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:47:54 +0000
Message-Id: <20260922084754.9D5681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Early PCI discovery creates the HDM cache, while later CXL enumeration and
> decoder operations provide updated programming state.
>=20
> Refresh the PCI snapshot when decoders are enumerated, committed, or reset
> so reset recovery need not walk the CXL topology. Ignore updates when no
> cache exists and reject decoder-count mismatches.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D8

