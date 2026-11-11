Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441309;
	b=Kou6TdWr/NFAcXsAudSH7alhKNs3WIGhTZAeNP/pTVUzZ5mvQV5+35bNx9Y0boo8A78F
	 VGFLy+eHUvokM+Na3PpwfkOHcCUiYYjJkDzI6wXpxQCdgXs9bu2BzfLzS75xs1wFJaUiI
	 a6YV0DAyAal+1sCwmTMLPJnTNWTFT3hl3Y1709rMk2SLa1FbMrqdnaWIECpYOFH+LzO1E
	 OVEC4jcHcmxxuuZ8UdTPQk6+7na4AUC5zj3WHUsf1yTgbBtL3wPzNyVWM27iURYg5CfuW
	 YW/+8J+V79uwN5KXPzLqrU3rBMmE2ZHXgmDQ3KgqoHfzmdbAueLzcMtYbZ5EuPCfZDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hTPQ1ARXrEhh6yyP4vyPiJUWeS2Yc4SVuJBV6Q+XLYM=;
	b=2T8XRHmviYhSMQ6tpybc56vzb3dCMbdYid0IG6zpagFbFFWm7R812y3THCtze5oK6XkB
	 2c+6lvHeqEUzN7CXgtgo3jtcWxsyYZepPIfpgdTOIW6g+B3NGyML00gZNyg8KuAn5XDr4
	 qg6Y1kilpGNFCYDIHztVlS7y/GrQbkjHoeMDEQRZFFpsYze6tN1EIiPqFJoTTUVVXYHMN
	 usTdGi+pwvZhISAdQUptRIb8mMEoS2AgPttu8uqmLNjn46rm5ipSSb59vem5FOx7CxabX
	 i7sbTCbkf/sljJlY5b2cZkpy0jUSk1v4N0c+nT0btlagaU59heCAozhAZCXV/0WGTaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sr8KlG0O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA60606A321
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sr8KlG0O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C2A1F00A05;
	Wed, 11 Nov 2026 23:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441308;
	bh=hTPQ1ARXrEhh6yyP4vyPiJUWeS2Yc4SVuJBV6Q+XLYM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Sr8KlG0OCmSg/308qdYGWCA9WTjboOd47TvHUHFRO+ZLUU2RReiHMI2lkbYlAwzfw
	 sP/pbPRRtB+iY7FdDiU6ipw9FcI89TCNxwPiEmtXbyFVuif5QDOLE6rgV/wz+8LOY0
	 hpfYDvfH0T0hZJqF7Nub1oTD4bvV1UBGLK6iVpoxj9fc+OkDVL9YipTVetfvGdwqoI
	 KCuQkTezPyzloCYPY7TI4TNwNELYVPrDyqRVKufjsPutsYbU9SBEweN0prPWNkrYt/
	 2U9c4V7Irpx562rhfMIz5Ae9H6Nby8rymhUy9dzaSD4UzZy5b0t+LhWALo7j/XQp9u
	 OS5oXJinDXHmg==
Message-ID: <sashiko-outbox-209868@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/11] rust: pci: add SR-IOV enable and disable
 tokens
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111223337.508989-9-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
 <20261111223337.508989-9-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:55:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Zhi Wang <zhiw@nvidia.com>
>=20
> Enabling VFs can succeed before the driver's remaining setup fails.
> Use a callback-scoped token to return an enabled guard that disables
> SR-IOV when dropped, rolling back those VFs on a later error.
>=20
> Add SriovEnable, SriovEnabled and SriovDisable for the split callbacks
> introduced later in this series. Tie each token to its PF and callback
> lifetime, and limit the enabled count to the user's request. The PCI
> adapter disarms the guard when accepting a successful enable callback.
>=20
> Require a VfRegistration to own final VF teardown after that handoff.
> Drivers that do not share data with VFs can register (). A disable
> token permits explicit shutdown without forcing it on a rejected
> request.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111223337.5089=
89-1-xinmengs@nvidia.com?part=3D8

