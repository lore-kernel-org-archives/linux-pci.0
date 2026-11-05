Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894125;
	b=Hfq4rZDzafNjAQHdS85M+yI5iuR7OrePyJ08n/+zMgAj4lnRiOqlp2BxG0dHzVsXxxNR
	 6J1+1a21EniT3OelEHjWWZqbe/uO/fnJZkQk+TzOpjctMOHr6bORkR8Q2xOlK2ms/PtKl
	 /vNVT+F91gnXTb5DtvnqaM3RcQ0jCbJfjZeTy7gYJud0ggatZII2Hj4BHBPOT5lVLuy+A
	 /Rle+zeZGHzbiGreJQl03gCMNItJcLMItwv9ZsC3ERiPF+hqlNO6scCMd5aMmDZM22SQW
	 nsYiTjVOi4Jm1T92wB0ToRya7UAGOREiY6BXSNTB+iIU9C0zA9IkkqySKq/1Xc6WO0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894125;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jI8Xhwb8k6Uj2zSHRkGm/CuaZQfkgHlBu2y9ImBrdts=;
	b=ju0QPkoTpbtJrma+dUoYn7E8fkM/JpQtc8nJKqOkc+WTPwllnyyj6ONwG4xs4D/IM5+2
	 AjTqkAMhWYXqpvrPeO9HOZnhpxCidSn8fyo3zjkFdyeTcKnbef4nI5DLcbGKgSgP8w9Mh
	 DVEAXDckAjIWzsaF9wcTuo13NBHr6BRIyqGL79Bi59z718n1YJj5XWk0rZojDQokPfwaz
	 iV42cwVAtJRz+FVWdpmraVvIxcx7UvPcynyRPscyRasoy+5Iilnsxj94Ttbtpi40ErCCP
	 gt+nKiaqlVY4Ea+krH2J/WKxbsvX/MxD9d0OrZvUyg4o0cldl0Js31X2g+qj6hjTrMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuifjbJE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018A6070782
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuifjbJE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64531F00A1A;
	Thu,  5 Nov 2026 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894125;
	bh=jI8Xhwb8k6Uj2zSHRkGm/CuaZQfkgHlBu2y9ImBrdts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BuifjbJEZ5qh60g6GcWg6gSk84zDzCWdR5s+OxGcaPnK+xOfpErEVm7mCtCG3VV/F
	 fBWcjFGpvDr+DbKcl1MO0HAr6dF9O/gEzLa9jzx2/Q0s+G51IvrbZOrLTBfmWdRpaq
	 e6PCeo9zlE8mHHgDxFKMDRWL6mIPlY/Ejs9tSQA1Q9YWaIgwlBQ1EWP+UY7t5tllca
	 DqfeWSiutzDD+sySozgwPwkjDFpjNOkssvMbMeF1BCwRv/WOp0dloXgRl20pwYz3mO
	 oCsl0Lkxur8oIWAe6JzYn5b+gRkU1mumWkSOFtTwslUn2x9ay0CYw0fhSfP0pXpDy6
	 Y+i2R8HGDaS6w==
Message-ID: <sashiko-outbox-199371@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 03/10] pinctrl: cs42l43: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103155540.365294-4-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
 <20261103155540.365294-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:55:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The code set directly fwnode->dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155540.3652=
94-1-herve.codina@bootlin.com?part=3D3

