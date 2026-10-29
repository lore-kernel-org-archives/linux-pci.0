Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286290;
	b=0E2zh89ESR2xdfyv+5nHIHXtZz/2aH4HzYcmZMueArB/pMNVVZLh4psZCTtgbjyXMUs+
	 AbRzO51TG8NjW1sYnWeCg4zIacSYV0mU4kUpJ8aw7QpaBP75yfPIyH5e+y6wjSwqKjUSm
	 iuVd/2TTfks01/jbCW3lnrQhE1SioZxILd4jaiSghbkYZBFARkNzrXBNP+olmficnrZQv
	 FiEtfq1p2Azz7wVdDgI8YFARVQfj2LMVMN8wCF7sBDnjuVNZ+vzJjgakWAspSpvIHf73L
	 z4+IgkHEmG+P8iXViCLP7VoZSYgFPjAN+diofvB4eLr6Upjio6aKoDDcejYru2GOF0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286290;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GkRohph8fvdnbHNc8VqeMFAnXIUYL5etWiWzO19vY7E=;
	b=NWBnJerNg/16WKEInlLWxM+bQqKVdGzkvMTbd7NLNfiB7edmdcJ2hiJ5PKZrALZjxjRO
	 FodomzNdKsOX0cva0Cet8QYVswbJqTnetFX4rcGxISuFfVTol6kR3u7cGbV6jbqyX4q+X
	 qMzOvNAEuulI35ntH7+jyFdOibZfrSTFoM9DYBknYJL1NtmHxuJB5qxPxksLvpbw2utlN
	 mjvOy97dsciME2uShHriiBSJIeFf2kVEO6ZDKlhsrmkNqUOKQ8nGZdiPX/Zci3IcATx3I
	 xKw3HgJwM4cuSbrZoP2OncPoDFfsbmkeud2nptrHA8WMdcXB194mO2JAg0OC2ePx+kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWrYHLXX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8B606A32E
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWrYHLXX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B207A1F01828;
	Thu, 29 Oct 2026 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286289;
	bh=GkRohph8fvdnbHNc8VqeMFAnXIUYL5etWiWzO19vY7E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XWrYHLXXz3IwyLbskzXhy8SmZ/h9wwQUxMLclmCPTAlUyMnlf7Y33BpdYIP+i0ZrL
	 BT1U3Und7xofKIhlxW4QWh/ZnKlsQtjyYDZYoNut34m0Du36cjdhYaLf33LlTFngS+
	 G6j54y8SvlUYr/D70ZeD3A2cAww2giNltBLdT+Nh7Sh+y6dl18OyLSo3/ofKTof26H
	 VQsbwLEWdTJNeYMGbQO/wKYkBudDYA0JnVorlMz7wmc1LhuKjk1faZ0kYhmH4zTe9x
	 UswxfATDAEHN/S6t4DPh5M83WftuRhf3hqVES8zAfiuOVIzV0pfjr1sXzwdee9dbGt
	 7pSdiVMi2cYpA==
Message-ID: <sashiko-outbox-189574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 08/18] cxl: Move cxl_rwsem into built-in code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-9-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:04:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Keep the region and DPA locks available to built-in CXL state management
> when cxl_core is modular.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D8

