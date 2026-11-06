Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977046;
	b=JGeF54FO1K2/vf4BluoZ5i3ASIp8FGekYN4Il4oTCOXxE1CtNvyqKKukQSBhndmFt6Ef
	 UJcnJx7rSwK9QKAVzA26XfGnPm9IGy97zV9wfay5ix+RXxabOVRCjywW2RGI2jEdRtxWI
	 yR0s9TvMALDSy+wum4XFU1MFvKIBI4u3YEGDJeNCJXbZaiCFavtFw9qZHGjYSlEJ2qlhb
	 ++dKCOJguWgxgs4iEAg3hsqkIxjHbNglAYRm19VmBn0lZC3P2gsOzXgHajV8QkON11Zh3
	 WXFsy4pj9fCbUnMcaNufWIj1yxqIzwx0WoHN8sObQNiJ7uFx+NSq5teTh5JVC0KRSqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IjIM6Eq5MNRQRYZrJJcFC31pU8nmdCkVuLpqU4Tx3qY=;
	b=4uP4JuXhzq1VkM5j1urmrsG5BRO+hgUFYoaegxGgthiXFs4nSSwoC4GQyn4aF4ipFoEZ
	 3MN/yiDPmY9eGqgrNudUKVVKaVijS2AYLn4q1g0YWaj77G+NEVgsXYShnnxe8x7NYG9qn
	 aLLSk9WN3FCLDwRPzw9YykWGBd1ApGj5hqKNRrMDXXas+TTp3KUMiuYbqwZf4t06HKPuf
	 xFL/URy2NgqHKZtXyyYpBbVx/BjTx4UkrW8v+4Qp05g/yIGilQexCA+cjx3/u/1YbQ6DG
	 rhM7Q8Bf1Fkmg71EJ49vzp8Ngu0w3A3g8w49zjnNN6ngzcE9giwJZjAiIgX7l3vIb3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrppfIxM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4434606A32D
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrppfIxM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B931F0089F;
	Fri,  6 Nov 2026 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977045;
	bh=IjIM6Eq5MNRQRYZrJJcFC31pU8nmdCkVuLpqU4Tx3qY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MrppfIxMDbT37uIeleZR7B6l+fybwsY1nDyhLaEp7i5q/Ez3xUcjGnu93SH09p1It
	 oiYExrYrMOuf9RQkEJOjyqvjTJ0SRBB7KydxcCUo098OXdiF7mvKSZeTVh6hd9dlIP
	 JJcBmWlVC9WI1QRrzHwTMF+vNCY811vOUQ3mr/akjm+knIqVvtVAVm3TLhw7uRfweh
	 uxGrgY9ffcz1VSGh247Pr29F8uRuylDcU/32vFQUMImNLDwCkKfjPCIGcNWyzmshEy
	 2d0/BhFcjWJEzixdZRfaDuZwd+MjGlndEjWO3yuPZNz3/g9WeGRGQCAU5Pk8cIEI+B
	 bz9KlPdDwSV1w==
Message-ID: <sashiko-outbox-201629@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/14] PCI: Separate align/raw size calculation from
 pbus_size_mem()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-11-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:57:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pbus_size_mem() contains many steps, the first one being calculation
> of required size and alignment. Refactor it into a separate function
> to be able to reuse the calculation.
>=20
> Rename size to winsize to better differentiate from r_size (resource
> size).
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D10

