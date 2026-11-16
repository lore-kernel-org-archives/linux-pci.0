Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831081;
	b=wL1Kxfoh/LNgDDFoQevdjfJYYyLloqbzjUnXmjasl7wkQ/sy1EYKzZukWVelgQY0uclf
	 IOxLxF0MhFsj3dcSdtUoll6dSKpFbNACjOIXwC7Vvv5J/rM50USCYVVgikTRhROQRgrK5
	 t6mCBNgfuAzmay3mQRuhra3fRLsHoykHZF+b48gJvJPSTPzNZnDxzM6dRYlpboWHNbBWp
	 I+AGeG1jH2erZVRLSrVgTBNXCYt8wBmyb416A8PqGl4Y9eowkzANyWvMUbU1Xe3twruA5
	 55eioS48FfVK9fafHlANB/kkUD78OphXqwnliB//5pcxMSe0Tbzd7OOdfwmLc8zecog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831081;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3pC+vkdZsFUWo6oQGmfPjHRKVVzgeTt3pVzdh76fYII=;
	b=EKgnoV1zy4jvKenQx8zSXqzFGqbEtFuhdvi8XfZn8seIH+ADuNUSL8n6Ak0AmtJUT3pE
	 LbbBdW36cqCCsYhrMsGsF6JhDjx6E1nrA0ArA/HF/8U+MnymrOpyaojFRlkwkGeXEFDeo
	 T/T3KgogfnFgpUeshlajumFb2d/Fr/7BLyqUj1UJ9/PfzjUTr8HCK0D5UkE48qamITRHD
	 x2LYn1ytUG2q50qzfe3QMW3jVJuP2zjCXdMoBLrbqoqnFzxGAOEWXMUBJP1M3Qetosv/p
	 GlknUXu6twtZzmvCzjRiltnsw/TWHwmyrfBIaVg0uuBXSlZ1FxPqVHsExsV9TewFh2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CWyc9ck/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CE606A329
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWyc9ck/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63EC1F000CC;
	Mon, 16 Nov 2026 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794831081;
	bh=3pC+vkdZsFUWo6oQGmfPjHRKVVzgeTt3pVzdh76fYII=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CWyc9ck/o6TdDV1B4oDoKDp9TUmJkl0eoqGpsJYdTMnxC4ELmHPE0tauamHOIRI0e
	 Bad5fi/cuyiwssjQymb0CKpBJ0i/rXxpkv/PwLKVFC9wWAWoMBcKdxVv9JB/4ofssM
	 bE1EeN4Wb4cncQrFZ4yR6HDUwzAY26u4yDphZ/o8JAGzE6tSU0nLVJDD7uUxIhSn0p
	 CuIrnPAdyJM25GulIkk686JUQ24gedd6Dw/wtkr03kd3ftQaNqlUBWoYEZtLp1AXjq
	 Wg1wcE+TvvNlBIhEs1OjLcdtKJoxH0FoR/iYHDSHV6ga+ncrobSawTXuOt6ln9TmMC
	 qgjMt0cg004Gg==
Message-ID: <sashiko-outbox-216986@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI/ACPI: Initialize the handle in
 acpi_get_rc_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116120721.1713-1-lirongqing@baidu.com>
References: <20261116120721.1713-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 12:11:20 +0000
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
> without a match; in that case its return_value argument is not written,
> because it is only updated when a match terminates the walk early.  The
> caller passes an uninitialized acpi_handle, so on the no-match path a
> stale stack value is handed to acpi_fetch_acpi_dev(), which treats it as
> an ACPI namespace node: acpi_get_data_full() rejects a NULL handle up
> front, but the garbage value passes through and is dereferenced in
> acpi_ns_validate_handle(), which may crash or yield a bogus acpi_device.
>=20
> Initialize the handle to NULL.  A missing match then makes
> acpi_fetch_acpi_dev() return NULL, and the existing NULL check on the
> returned acpi_device turns it into -ENODEV as intended.
>=20
> Fixes: 169de969c018 ("PCI/ACPI: Provide acpi_get_rc_resources() for ARM64=
 platform")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116120721.1713=
-1-lirongqing@baidu.com?part=3D1

