Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150161;
	b=uGzomziBd8IS5Xj9/cIE76fb611XVz81WMtcqKvBlcMfooSZBy7Wnc2GYlvqVV3NzO+V
	 ZMuhvWgolVQB4Kk3vdUezcHprrHrYhwEN9tskbzINVltkvzPMYP9yHSR2c9GasTmHf7sY
	 wiqKTjDLbqPAV+WiFZdStuTBSU4KYZIRtZmDYhhtxkrLsDzcptXYm7zlQTabYY8Ejjqt2
	 x1cpgIQjRRueK8cVNJQnRugJYNhXwJf5meJsRjTUHq8K00kwZR+DtHw5CE1JGhCY2HEl2
	 Zr49Q/19ctOoitg80k1JI+e0WqmF3w55NAfRIYVPfH6kxL1WzeoDtCUNTWiwJ2MxqHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150161;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uG2baD4KmFm03ls6ensXkb5DtX6yrfjqKDUgQxcAsM0=;
	b=Q6j0SAgiLyzPdWicGZ/j2PqqkUGKd/Z/SjO3gC71blpo04o4F2Pq9axoMo2xz0dEcFJI
	 gNVZZ0s0fLJOMdJntYbY/TjG5t7TvqPcdepIm/kwZECHVdfSG2Trc9p2hVzn/o6TktJ9Z
	 Px6VdNbpjcGIkggminpRJJhfkd67oRyFFrmb3WweoDYLCCUmXvhTeEFdrq2gAxroQOkCY
	 rKc5jNWcXcxE5dIIIwu8n9YS0YfMk+kyOy2jiI9B0+jq7aC4208f65S2rx7ElcSh5M6uW
	 WCp3ST1A5+WJSnhN6Yu3P0/v3uOOxX/SsEMMnVFal7YK6R9nvQTwvZRU8+zpEmUeGdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PslBIo+y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005F760A260B
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 04:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PslBIo+y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ED01F000C4;
	Fri, 20 Nov 2026 04:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795150160;
	bh=uG2baD4KmFm03ls6ensXkb5DtX6yrfjqKDUgQxcAsM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PslBIo+y4pMErF8nD8geWt5t7IXtRC6UK2wdihjqkPZ6ALyDAKK+HcF2AUIQ0OOVa
	 PslKyQzj58uMnziVBHvWppY6jDAv6GvncHpmAYh0EKggYy9aBgeWockUbV3ohukYEl
	 hqVO+mia3lDY9X94u4qw/s6PzIEL/zMkaLRY8Myc4+tbGZFcAAASICmHrBW8VdiogS
	 lGwVxilB63BS4oqcf8vfhzyyuNYy2r39dfYR09+kKuI2+58zXeJRz23DKa9RniN7v1
	 nCDvtlsaB98OPSX5ucT0bbuDjtk6H7vLB2ulQaNcIfp4LcNPeHXBHxkcHG0Makwu4w
	 m0pycignyEtwg==
Message-ID: <sashiko-outbox-224473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] gpu: nova-core: falcon: factor out the wait for the
 GSP suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120044704.165223-3-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
 <20261120044704.165223-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 04:49:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The r000 boot protocol requires the driver to wait for the GSP suspend
> bit after each load-and-execute event, as the shutdown path already
> does.
>=20
> In order to make the wait available to the boot sequence, factor it out
> of the shutdown path, into a method of the GSP falcon.
>=20
> No functional changes.
>=20
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120044704.1652=
23-1-jhubbard@nvidia.com?part=3D2

