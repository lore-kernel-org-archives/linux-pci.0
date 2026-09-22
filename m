Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0541F3CAA49;
	Tue, 22 Sep 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067005; cv=none; b=kKhdaV62dUHSSNo7UAx1RIXaRuQ6ImqZTrZ59mQFR7/m4BL3Iqes7pe9mNn0qeMOp5PqAfuPW/AQ89lYIiUE3L2Vkyt//O5UxVx9tQh/dZlmmxTNz2jAUyeSC8uJ88fUbBy+Dy/0ScZlx0CedfWKPoLgklumB7ECvrpGCuUR88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067005; c=relaxed/simple;
	bh=cE00AwlO3XQmDg3unRIjSEcGe2SCkr6gIp9t84ZvvcQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qi3ZbMJIpJEQmHygvMFiGyEUWcgatxzu0qNGiQAmkZpGO8iGYSj094QAh0Ckx+K0Z38Kt+0gLPqTdlc7EESuEgLSipzn1UlPZH6Q78uRhEZQ0cFh2nEm5PlP3dG65hJqCLbppBdUki0rJOp+1PXSS7mfULWjRtS/7ctZe/f6YWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9lzMV/Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9lzMV/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A86B1F000FF;
	Tue, 22 Sep 2026 08:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067003;
	bh=cE00AwlO3XQmDg3unRIjSEcGe2SCkr6gIp9t84ZvvcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e9lzMV/QCrDgxIE2JpE1J3PVlT185Sn1MCWJOenilihkzG9O9ZY+rt7/k2ReFSUYy
	 Ja9emn8hRHlkD85oHtWu8gQGsA40j9kuG4vW2x8tzWLHZeZb1Rv7RMcMlUjxHn67RR
	 8LcTTkwp6U2R+XJ4AJrlQnUT9ucKXcLMyT5HbqZHgZSMsYbCbYtp1vcdnJh7VsatGG
	 EfmaoQV8VOycn9YKxTRPAbMGd0917iHjMFLGCa6er3QFBcjdX4BlAN1RKubBisoQtr
	 TnCt6n71zsZVoq1ndWBUqqm9XXbGt03gIc3N57mcTp0xOrAarp/IjDEyJKQwjW/waY
	 nbkEs1wR1Mphw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/15] cxl: Move HDM decoder programming helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260922083924.2451158-4-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:50:02 +0000
Message-Id: <20260922085003.5A86B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the HDM decoder programming helpers and cxl_rwsem from hdm.c to
> resource.c for reuse by reset restoration. Keep their behavior unchanged
> and expose only the cross-object helpers within cxl_core.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D3

