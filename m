Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794734173;
	b=1Sosbn1BqGpGYk41EY9F0rR5L8RSHZiOEhIIwmZv+PCvLzccs8IZ/VQk9DYPm6B3A95d
	 iGSJbzh+NNyUkNyT+bTH0gVtPa04T3kDiyVoG0MDWk7P66JmqOHjP2PY+em2IXII1uSu7
	 /FgVZYWyPSM1S6MDw4m3osTC9NZH9MmA6FEiQ16tztyHfVnEOKYOsKpzhzOroDoqt/b84
	 u7uysjGCvA4pVW7N+s+d/Sp+YqbJGdWoe5tJw5dt9vi4VbXNYHbmzYy8Vtg0gDkVmdAKa
	 pHImjZ+0tWNCb2ORbjXFEgzkwLJ4RADaqEyv/sxR/4FirL5DY5paUCqMvZFuh/zcZ+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794734173;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fo0XS/LIiE+zQDSLfx+o8I9UERY8U+Y1EyVj6Xmmq8U=;
	b=TrOprAmy5V1CgTE8o8Qm+ejHOXsN4yL8h8sdaUX9yrU3akQxDz+7i6tbCcg541Cq47QT
	 YSnqeG4iMh4jsFn3LYtni37AOhO9mvu6O62bWTrS+z7bgS13YxdAEs4xefelrM9wd5csb
	 hotTM/WyM2cUGEZZWloe0Unq4xYcsXjddLUK/9Y9FA1dXS9OAIThGWn64lD11cPaZwji9
	 TL+XmwavXmpPx38rqsxA89iy/s32ElhEm20AsFMw2ZEBFlXcq04pKRfNRLmqZ2ZHlDh+j
	 3mUdoK6byy74rvPe0KB2x8qisj4CRLBgqNjbvNoYnpaRZ/6HUKgLqWqj7ofkmuAAtew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBojPZSW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66690606A31A
	for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBojPZSW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95E51F000C4;
	Sun, 15 Nov 2026 09:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794734173;
	bh=Fo0XS/LIiE+zQDSLfx+o8I9UERY8U+Y1EyVj6Xmmq8U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BBojPZSWiUwm/h0Ndm36UDED0f5o8GkEyfTM7LI0V+6b7/DhDDZxCx35SEf4pNO/y
	 33dKm9hbFi9+2ETX2Uz3BL+U/SAQE2/YvHwgW/yAHZfqdy56F/xhZbFdyBt+XytL5g
	 1fYqTkalUvnYWrQon9ZqooLsqjbsQDxZ/25PiUmaG2yMVz5ogvo/Hl6HhQOdIan/Ze
	 OyJsejvV0EixkvMtKz4kR8aQI0YnoVP+bLjnU073rr684mCquI+iwDLzDGrChCs6QW
	 OMHMDmMDiRJCW6eaE5mLDm0Y5UQvJj9umMmzmToFvKCJ9PU5V+/8YGf+afY8lqrIN5
	 KsFUiZFFPj65g==
Message-ID: <sashiko-outbox-215336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/ACPI: Check the found handle in
 acpi_get_rc_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261115091221.2217-1-lirongqing@baidu.com>
References: <20261115091221.2217-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 09:16:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> acpi_get_devices() returns AE_OK even when the namespace walk finishes
> without a match, in which case the return_value argument is not written.
> The caller passes an uninitialized acpi_handle and hands it to
> acpi_fetch_acpi_dev(), which dereferences it as an ACPI node.
>=20
> Initialize the handle and reject a missing match.
>=20
> Fixes: 169de969c018 ("PCI/ACPI: Provide acpi_get_rc_resources() for ARM64=
 platform")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115091221.2217=
-1-lirongqing@baidu.com?part=3D1

