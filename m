Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761957;
	b=a+l5+YDIyhsmkgJwmzwGNIh7fIbBM+fTnxElkM+jkUbZZtZmNZiZopotTdCXxu5KDJK6
	 gtMANJrPk8/THfNwwQX3UHWq0rj8f6gs/thGkX4mTmrwK6olLH5j7S4M9MQ/eOd8Bd3Jb
	 AKKwvUgV9mrLlXq7Y2TEnpnqDKCjlsEmDvoYFsZv4rlx1eO9qUvNzz5gsh/ByfjGFc4N/
	 qt3oTvEfx4SEdfwTPO0Ks1IFL3Ga5T7wd7keI8vz09dgm+UyQ+Z8oVZ0NwsHGerCDI3wH
	 PHCBWs88K5/LRVHkixLabK1BOB5v/pW5knBk1Imr6G+uDpggd+IXacSrRz5k5kT7zVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761957;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Orpmto/mHaBAJNPssCHIy4GZRDD/5W3xu9CR3WTtqXc=;
	b=FsGy/QkzudS01o5B6GNx5wGQKpTDJMT4efNYykhjAzroQKhBzgxGeyd/HKTQ6nYRgaxc
	 +C/M4WLqwT4HIVbjUW5+p7naWFwUCTcIowmvN5RHIrMs0shos0xyTJhjtzI5Gj1g6+kE1
	 YOdG5UT1YA/3i+SIQQyk0tnTOHBeadH9LqKH4u+mgrkM2ZS8DVSE9+VsgMyw8JRmygs2v
	 iXQnWa6+CLg8zUY/WfsqRNpmyTox+3AvtyVz2BB/GRXpyEDCrK0juj5XEZp6PG4Hly3Ha
	 7RpgeUegADG09TmX2XFkyDxoWEpPSAqpRKnJFp/cv4AvUKXLKlNni6DCiDp4Y2J43qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pie8GJs0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF1C606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pie8GJs0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178ED1F000C1;
	Wed,  4 Nov 2026 03:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761957;
	bh=Orpmto/mHaBAJNPssCHIy4GZRDD/5W3xu9CR3WTtqXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pie8GJs0WpD9Ct8Kri4XDnGrdm4SUE9i5OwrDau057XiVoNYQXH+UgmsvVRKsbtdi
	 pBTNDcazcPMixX07VHiNzySWwYDBkQdcPP2XTVWvo47QdEn25DVx3IH8RIvwpK7LGZ
	 VsU7cg/n4WCpYGXQFK9cSNJTAl04wXuGLy34TeYc7yhMxp3AsiLNg+cKZBzH3N5eaa
	 Ky1LCOOiDOzj0VgMRdQdUTIBD7pokYQhP0J9lnpWKEpIyhau6xwafKFGc30Dx37gJQ
	 IYdp+jN5JbbXQCdK3+5hcBa07N7EhfNqAmsoFANn0inUpoosC0jQkEKCoLI4JudI5M
	 7OYEKUVjgJrcg==
Message-ID: <sashiko-outbox-196589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 20/25] dmaengine: sdxi: Add client context release
 with update and sync
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-20-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-20-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:12:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nathan Lynch <nathan.lynch@amd.com>
>=20
> Invalidate an unused, stopped client context and synchronize hardware
> caches before freeing its resources. Add administrative update, reservati=
on, and
> completion-polling helpers.
>=20
> Claim completion-status storage before making an irrevocable ring
> reservation. Return the claim if reservation fails, and release it after
> consuming a terminal result. A timeout leaves hardware ownership
> unresolved, so retain that block in the administrative pool until context
> teardown, even if the device writes its terminal signal later. Repeated
> timeouts can exhaust the pool, causing further claims to time out rather
> than reuse outstanding status blocks.
>=20
> If update or synchronization fails, retain the context and its ID for
> cleanup after function shutdown. Device-wide teardown frees clients after
> the best-effort function stop/reset path without submitting additional
> administrative operations.
>=20
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D20

