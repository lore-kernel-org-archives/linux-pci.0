Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793189142;
	b=yeFnUHDqhRptwS9QV3yFHp95cFXLsrMWwysJUTsGftu0S7rkLX2N/jpIo1h6Y5a9KPmN
	 tmthFtPPRBDsTnLNgKaGEImNWYnG5YAFdv1XtHT/SB7BypuR+hMMFaHE/I4Ct9W61iIZb
	 JV30t9UYRYaaHjDnrIovCN4m5zXY9V+tYIwOQmp0mOGdzUp1PHDN/Upb9ElItiNqVI5mA
	 VKGLIb4/aOdqEJDY26HG8HbAd+J9Je+BzEV/Oh6HI82cKPRrAGEhf1GOieXsoRh0vL2xV
	 hzNfsiud0yxHbCsAtZ7nZjzO5a6s1Ee0rL/+zfw/f7oxSlq0DmrOWfvL413Uyl8Ou+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189142;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zROEGJ08JOfOzZ0tlhI77x/nJ8Pk4p0z2YEh7a6tOqQ=;
	b=p/PjgmRy7HYXjDhKvdiONi0wuiFyuBhHS4dp+8xHyO3aK+4CD4mVduUqRx1ZGfu228pb
	 qZPqGH3EU6CzSHPk3kJCgi18NUjNnnjxF7eNMLqP56g5GCb1SKv2f6tcQCN9daQ262FH/
	 FZvNqGLstxuxj62v4UZtXyTqE12Mog0+mjwQxC4+rWkcKhdx0q2QClAB+VaCIDhd8FGWT
	 +hH9a7FM6iQCnN4i6LlOFP3K5LpCXfBxYojI37BK2iASOPZGUqtr8UahGO092H6YhV9ho
	 0XC/AyJmTZasvtrKtr7iBLEqsqumJXWD0bj3J9YRMUlqK1lUrtoDr60BDMVUBWh85gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KK8svPov;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF599606A31D
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KK8svPov
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9B61F01825;
	Wed, 28 Oct 2026 12:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793189141;
	bh=zROEGJ08JOfOzZ0tlhI77x/nJ8Pk4p0z2YEh7a6tOqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KK8svPovemx8G66leJpHuD1HDo/aXRmQB0U+XXQxpqaVflKXlt1KmHNBVBX3CP6q2
	 DSxA9Bv4FZjcpuVhT6TT8jDE76n9cK//2mNW88OIjpscyXylmVAoy+AMGpFw3oHkAo
	 1Outc4FFaRKpBT3P+5jym5vzHJCQZflGycIMmYKHQwJwYYScGiQvquuBGlzSND1JEX
	 m9q83DREc/QAjPpj6iYGIZ0cHim+hiB7hEGk8PNWAuPGxlVA7UBIYoNBfu6B0gPEJR
	 yFhcgQXhlOerKdYNZzV1NgpYBOQenjq+Qm50uBLK00ZjPngoa8ZtsyY/D4Z4vKVNI6
	 Mp74n91TOY6Vw==
Message-ID: <sashiko-outbox-187858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: Fix property name typos in if/then schemas
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028120216.2657397-1-robh@kernel.org>
References: <20261028120216.2657397-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 12:05:40 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Property names within if/then schemas currently go unchecked whether
> they have a type defined or match what's in the top-level schema. Adding
> a check finds a number of instances of typos. The typos result in the
> schema having no effect on constraints.
>=20
> With this, fix the mediatek,vcodec-encoder 'clocks' count constraint
> exposed by the name correction.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028120216.2657=
397-1-robh@kernel.org?part=3D1

