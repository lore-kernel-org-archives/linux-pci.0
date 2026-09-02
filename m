Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B09345736;
	Wed,  2 Sep 2026 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334927; cv=none; b=g03I197+huu/Ax12q80vAa+Ac9RDTUwgxYLc0ZXz3Cva0Zi52yWGj3IlI6a7lwWyuGCKv4jzbtBPOKPVqAfRb0Hr5b9UuTZHY09CZD9zgrVInGCPvv8gBa4nhORhxtog1I5yuEmN8U9Naa9J5r7Fp5aNIUIC9DrxH6uAzTUs8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334927; c=relaxed/simple;
	bh=Zv0osE9DMCuyVWKrdJnWenjuV5KP7MVfdiZC3VY431g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RgLIghBaOT3ILw3eq0oCXsUTPRu8mgCBTjHaoc7n82n9VGvOL6NOphUFKIQB6DmmPlhfaaFDNPJR7zVVIeSHuVPBKlyTp7rWtDqz4WOQowlMV382DChxJxtM52avvaLpGbqsvgnSWmxWuMKQWdpSRmo9ubUQOQR4GcttuIzBdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUl7p5+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUl7p5+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0231F000E9;
	Wed,  2 Sep 2026 07:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788334925;
	bh=Zv0osE9DMCuyVWKrdJnWenjuV5KP7MVfdiZC3VY431g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IUl7p5+LPzaXeVV8BGT5Z+2AVWHdxkzyTtct6EYY8Ot/cCHRWvtAtCXGdoNP/rDV+
	 Ph6dCS3pVvxjCXLm1WzkVL+IoBPp8JA2OZSA0i0J+9whb1e/DVlCp0UufO9YwxdUXX
	 L0EOekkjDMDnmhEGTKPNB1K71VPL7CNC/+lhawSFI/3rIq7u5anvk7qCKLIw3x4cBt
	 aJIxPqVJv092P7te71DSLU9wMytP9ACGZNKXntByHoDxjxlqA6ct1mLRgWVKDa7Rv4
	 0JBViHK2+a1Zgbno74+9hsxVs1jtti+WBQE84rmyZ1Le+oZnjhigOtzGn0T0dFs3rB
	 jb0mDBErv1tNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/12] cxl: Validate HDM ranges before CXL reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260902072804.665639-8-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:42:04 +0000
Message-Id: <20260902074205.7F0231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Before reset, require cached HDM decoder state, collect enabled decoder
> ranges, and reserve them with request_mem_region(). This rejects reset
> while affected CXL memory is busy and keeps the validation stable
> through reset.
>=20
> If CPU cache invalidation support is available, invalidate the affected
> ranges before reset. If the runtime backend is unavailable, continue
> after the range reservation succeeds.
>=20
> Reject CXL Reset when no cached HDM decoder state is available. The reset
> path needs the cached address map to validate affected ranges and perform
> CPU cache invalidation. Also reject normalized-addressing decoders for
> now because the cached decoder range is not a system physical address.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072804.6656=
39-1-smadhavan@nvidia.com?part=3D7

