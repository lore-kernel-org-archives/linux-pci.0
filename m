Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443448;
	b=D7vz8m8cnRbGH7ilnyILXIvCMVxzsXc8p+iFmL3STUYwzEySQx5wL1QY+xtzeIABlxIa
	 WKeueC+Ih2U101SgT37QQ2sfTFS4+NMUjcJM0n++p8IL92vBx6uEoeVgqalXyQgVA63HJ
	 E2oxHP8+5/Pkh1qs/aU6XwhB4h2wHhi2OSSMdioch62L88DdjkLq5VHgyKxPYAna6bYYg
	 Qb1lcITfrRBs5n6zV1O1XiLQvVoPRjNB+c8hGS6yyGnIFOg1ZesGRb2fw8MZhhMNCk2bY
	 Dq5rCcaedal3cei/m0HDQjhnxc8LXSzFOo/6z3o0Bm6Yfjo4bUWwL8/E+covKWb9bCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t+NGV2AAyfYSQ77/p3qf2VWaZ4ota4JzwmDv/Clw/rg=;
	b=LTxQCgQzbhUNyut55B1XMYjuJ+c+2c0NDJ2fCXkHD/grBy+x9jWJ10AwDsGzxMZCAfWT
	 T0qdpklmbaQsWaaIM3BaMJ2gycXLYiP78mjWh/dar0FGiEkV9aFXtUOea1JPixEpTVN51
	 /NITKwfj8RPf1hTZpJ0e5YwstsvC3kaxSgO444rOaLjUGUgTzdKWDWQdIgGHuWXtJDzv0
	 kNDLXZKr3S4MnNBHMLM1ioHe3EJ1l4Zt7GkWn8aZAczjPjvBZN5dbK/Ej5EcDI4E9B2sY
	 kNVYbXvu9K0hCjvBCLf6OST7p4UFKKmK6uBMzgie1aZkMq+bTOch1FTtXW+L0n5jUOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksM7GvsI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E279606A321
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksM7GvsI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51051F00A05;
	Thu, 12 Nov 2026 00:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443447;
	bh=t+NGV2AAyfYSQ77/p3qf2VWaZ4ota4JzwmDv/Clw/rg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ksM7GvsIPRE45G0xb2k2ZNCxmibVbZB4gzmPDOwSxSJP2BXalPL5yy8o9Rslw99Ae
	 IQM13FlJE8qJBBkqIIGGLBMAmCMQR8VDOGih7OBHz0xvkGbHMuMYyqV+6eqdTs8B27
	 tBenLjH9CNNSW8Gh2V9EYahcrCHIdLzU0114RGeTTY92OCMFcy6AQoc+5NAg05748s
	 +n1XO7Szr0+X2jyaXQJPDyXPXxkQnrA6Epf+0iEYj/3zjUwV7d3lhs1Q+5cGgDje4w
	 FzW+Ajcjo7X5J7Tk/PIuntUHCYPVROiVb+BPiJRjk1VZkgsoRvyNE2hv86Xp8XhOCK
	 /q3sSNGu8sfPQ==
Message-ID: <sashiko-outbox-209923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] crypto: ccp - Drop unused <asm/cpu_device_id.h>
 include
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111234821.4814-8-pavel.e.popov@intel.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-8-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:30:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Nothing in ccp-dev.c uses <asm/cpu_device_id.h>; the CPU match table
> it was included for is long gone. Drop the include and the #ifdef
> CONFIG_X86 around it.
>=20
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111234821.4814=
-1-pavel.e.popov@intel.com?part=3D7

