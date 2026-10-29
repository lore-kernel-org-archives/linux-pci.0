Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245090;
	b=MHJfRLcXjZuyeP03oIDhlhj1gEO7iH65je8LIpseltxv2pBdYdClAPYMwTAHuguJP/Pr
	 Y8KJokFWkaebUIYWy7DqxryLZPUPlVCqp2B18bEFkZFlodnD3Ik9jktudjv77NKZKHRb4
	 +RutFPV3oBiuM42FES7Wq+rJFsAmdzKYEtHHoeQKdWYLkaDBY4eY01JMO+ud3FaRKyyH2
	 GA+j7Z/yWCrckjB3dv69Qmu1jVoWuDBeJMxKQLpyHXSea9rMrGkOHbQkgmQxZd0HsKrnx
	 1gIQAxgNtt1nEezZJMIYB7Lafwq0HC21Y1dSzvRoRACO2qxGkZ/ugpsxJT3Ra6eplMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245090;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hV/j2lLHYxudNBD0s7daFcRyopGg52aY3UK5vTrwYF0=;
	b=MWRr8C9STQ/Nbi3YPPFEjndGoGVFpSKb/OXN0UaPmO6E1obx7pJsfRA+6q9a7XoX6lUD
	 /7lr2qEOB44Z39XEE9DwL9aidbY4nmeHF1SQMFEqHV/ui6YRnAv8gPagWFagOTMdCQOaR
	 q0ilq3Q4TwYWBcvGNaO3FUWpCPP1+K8+MvWqVucCiSNUr4gWpEFAC3RlUthuL4CSWlasi
	 MJwcCJ9Yp0NqZWPQvDIziKR+IGwa8HpQ0/skPlY/7g3v+2tjF0773PRI/U/db14tWXshZ
	 5uDNI5FKqPm7NHPiuUPM0ydceBz4IvAvxHHuvAcgu4HAUuxsI5pI2TSfytYtoHIO8dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5eJj05K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA03606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5eJj05K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEBF1F01828;
	Thu, 29 Oct 2026 03:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793245090;
	bh=hV/j2lLHYxudNBD0s7daFcRyopGg52aY3UK5vTrwYF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5eJj05KOklUhVaw6GzgGU2aIidCURGZ9ylLDWqcOxTCM+1+rzvz03z8cVZ4sb6nP
	 hrDk0gEr8yVRw5KnPdusCVEravdFH2wPopKbn1WF7EZsvymuiPJQIOHsJw2iU/XbtD
	 sA3Fm72IiiGEe/QH8/PE6VknmW7NH1RNdm+1cugS6R2E9kbSD202e3CG0PW2YIL/i3
	 1bnUBEQ13xFjApXxMr/LHj/71MBQeC5zgsx1TtS5pWoibLcIDkmRWKdBF2ZEq4GnFB
	 ODrYW34BMxJFbaSRCs7oZe3SnUY4rohi7hqeagskpKDirHP2diE8HQEuPsD0oiT3xh
	 LgUetJBHjG0dA==
Message-ID: <sashiko-outbox-188671@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: PCI: tegra264: Allow the ats-supported
 property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-1-4d843dda0b02@nvidia.com>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-1-4d843dda0b02@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 03:38:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The C0 controller on Tegra264 is connected to the integrated GPU, which
> issues ATS requests. Add the ats-supported property to allow marking
> ATS as supported on the controller.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-t264-ig=
pu-pci-v1-0-4d843dda0b02@nvidia.com?part=3D1

