Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18276310784;
	Thu,  2 Jul 2026 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007750; cv=none; b=nSLaGoi+xR45yjAuSI8Fzd6pMyFWauJOxQQNygyrFPCM/nPclW66UMb5ty7SWN6YqvFKwm+FizudYnp2WDaOTPuIFuQsmEPFDPz1Tv7IbWSSjEguDb0kcFCftnmvz/r2uoGR+05g2VD/7hbYpuDxuKZ0DfaFbvoJXkj/sMuNTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007750; c=relaxed/simple;
	bh=rGKs0kNQQus8sqFUJW5xPwT87wIxN8QBvYV8RDo1rr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AqyU2WpFln2Y5/10pn1aENFV04JKRNGOG/av7/BPjH5n0UziBo7ayKguJB7oNa5l7BgjvjCZU2SIPyHifFRRSslswtUas8uJp5aaR1E80OEmjImC3+RSaWsZkC3/Vwsal7F72r/58bynvEvbgVKk2pk5ZlSP96GkmLIPnmNFxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVJfKr0h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVJfKr0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0031F000E9;
	Thu,  2 Jul 2026 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007749;
	bh=rGKs0kNQQus8sqFUJW5xPwT87wIxN8QBvYV8RDo1rr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lVJfKr0hKpsOssfD+kIo6uVAt+olqCnVnebRBOF9wt0fZNUkU2W6PZV/qAhWuYMor
	 sXxA9zJt/JdUZ9CDbtVie/8TTS+x+G+a3G2soV+D+OQt7UJ39zye+95YnQwnkPHFEh
	 YNVNZ+4yIsDg2GO0W1KmDU/6tmHY94QHqFRKxkJWBat1XNJWILHMM0PuoXI3ojRCie
	 wm61YPzvrNl128kqfV/nh0ipD5NpfWAepJ7mFYYLEkdm4FtGk2wwFtwrcm2Lmc5dFh
	 iDhiDAEN6RxUg6QMJoMaonbSl3Vh1zPIdBQ6qdr0jcuOFSQlxZwUNdTvbFUTok3NIy
	 zFw8Vav7yZAuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/11] powerpc: Use sysfs_emit() for cpumask show
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, linux-cxl@vger.kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, Frank.Li@kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260702154725.185376-3-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-3-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:55:47 +0000
Message-Id: <20260702155548.4D0031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> These callbacks are sysfs show paths.
>=20
> Use sysfs_emit() and cpumask_pr_args() to emit the masks.
>=20
> This prepares for removing cpumap_print_to_pagebuf().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702154725.1853=
76-1-ynorov@nvidia.com?part=3D2

