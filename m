Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579173;
	b=MW2+r3P/Ha7EBQn7x7NXGvIStScM/xJ0aT67s03IgAFgJ9LjMOnB3WN6bMBOTGzDUPlW
	 H8lRdDpWSfGt55or9Sgw9s5twnabCdCcK5mPN12X4crNBCgMXQGxhZ0d1I2S3GsyOYqz0
	 cjkOg7hZLhfhoNWp7MwVVhcTxRJCeQU7TZkG9IyaWSiUydGhIK5MH6Pkl1P36TUpQxebV
	 FOdp7q+bHwBtFV9OKjXTks4zCAe6v40IEScUOrnT+TMyHMl/O2x6BQe7jdcG/0IbLaHR8
	 RnPWHA8IBJZqlnxuDpLjo7U2IdlreaJP9VeQBircJ9s/CQgA6d0SP3JM3ddY8wdg2kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579173;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OWR0NRqQC8KbM6AJCwSnbZEW7QAZuKNDQPVyygw69ko=;
	b=YgdsZr3hto3Wv+B5PhQw/3XxhF7RjKAU6S+yw++fZouzSdIXMWdunyB4d5fA67fBQne6
	 ECvzQVC2ATiHBxYaHDdJdHzP7k1QEzAgukPE2xp3aUP48JIxlAh4iYIzdYsOpr3OwtRFA
	 Z8R8Q/R+13XBbUhAclBwb0KMkiTJSFG1V+XDqPrsloiq9WvL1dciDaBA9eg+QLRX7zzLS
	 Fk+gYuzjSI1yhgcdtV+2pE17Ln5zVCzl1/5hdJSzUcBxRlQoSrjzBZzCvxDGatRm43kcJ
	 jDBt5PxeDnmQKEoUisK5ugz4VjBJqxTjmEtER1YAtQpkROLiyj0Sk4224FL8AnoWvLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdxvVTFC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39467606A330
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdxvVTFC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD071F000C4;
	Fri, 13 Nov 2026 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579172;
	bh=OWR0NRqQC8KbM6AJCwSnbZEW7QAZuKNDQPVyygw69ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TdxvVTFC/gODqv/jA//cl3ToAkzRcO9nvMzQv7r8tZQO+8pS7ldd3lTLFmuo2ohYC
	 lFAfNa4V0feJM2UG+kjPDx2pWDTw5U749LHhb8mD0mBBPzjiyObfIU0JoRS03rWujC
	 yxlO3ViYGiI5aixgDokNgJIXtaNr4eTNm7SFcIBwCXGvQ6RMHfc0HfOBKeFQuxXCS3
	 +zOzqxFYRf4iHA+5d8Tf6gYvt1uWKcb+KdnKOkp9D1Qxu8QV1Hr6VoFh5b4pmsaYyJ
	 WUJaRIgPLKZCQvj1ABamc/S+k6p5qrF6rQ993qWTV+h8tIxuG3h4sRaWB1Q8Yfsd3i
	 yMi1FeWIkviJQ==
Message-ID: <sashiko-outbox-212963@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/10] NTB: ntb_hw_epf: Support DMA and MW sharing a
 BAR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113132935.4152566-11-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
 <20261113132935.4152566-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:12:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A vNTB endpoint can place DMA resources after an MW in the same BAR.
> Limit the MW to the advertised boundary so clients cannot overwrite
> those resources.
>=20
> Advertise this support in LINK_UP, including when DMA is unavailable.
> Older endpoints ignore the argument.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113132935.4152=
566-1-den@valinux.co.jp?part=3D10

