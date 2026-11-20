Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182971;
	b=uP8cy/1BeHZP5E5azP7Ww+aR1BIxWNSv7r9TGA0Y51fmy7jJ+YUWip1Bj0tiLyGQCUt6
	 f50Dob3j9UjGfKgaMdPocaPfXZWN06jaFAC9sajeH2FTufatExTHfquwQyFhCAJ6eKLN2
	 DIhF95nNoD0TkMhclylgNg2aLUlqYkt//QV3k2eH8j5mbOqPPuaOpduFLXEsfqjZaDWZM
	 tvApOwDkGIk5Ug9bFswttqdirykxYsrYjveo8fK7267kSZaZ1OvNbVHnFCctwR4Ob7cAd
	 J2sVSXohAstvUohkN/qDzNw096tr2oeGstFtk5amSggk5FVTTAS9AhQvK1tOaF0dcng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182971;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uHbi1Nx4ZWqmOHyrdU65Kka26Z6lWCL0jPkn//DE/Kw=;
	b=hyyNsMBNHGRqpIiCcoOZ3tE11qgQWPvesOSwoi2HA0bWeZf+HHLE6T7PNtw/3oQJVcEN
	 p5TsmNYMuPOxuSzm0Z+j+PwIB2mK9CWfgHQ6j1gfP116egEBCgw7L/l1h8TwcbZEzKtKR
	 sjSnPJ0bWre+3FhMBJ4ObKFdqdpoL788iMwOZrHdoj/z4qtMsc6TB3K+jn0h/aoc3HU0N
	 5ZjpzcYOtKs2/28cigRpO6weYoqq7xCH76bSRdcAzBdQQ+kLvIizLwVA2OqCLVQfQrfvV
	 Xrkpw+gW5j8IG9kCzeM2hS3tgB7nJCZ+06USmdWhP7o8wp9Uf8ehAQY/Cz7wZVMJR3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqUow2Dp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC06071203
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqUow2Dp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1BE1F000F0;
	Fri, 20 Nov 2026 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182971;
	bh=uHbi1Nx4ZWqmOHyrdU65Kka26Z6lWCL0jPkn//DE/Kw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lqUow2DpLvey58dnXb3TcVh89bZX63m28Ehptvp7pYr8h3hd0lY/q+NR9wA65uuSo
	 UZwsjqkodnqBqmHoZD3VRqXlJbXKZgHvTKbOugn8YzNw5NWsuVkZyaAh1/vACNbaRU
	 v6wxbJz7fDRiQXVkm2kYLfi6YtG+BTIouQkjT5rNKumX3EH7dMKGzKddTCFXnzqgyS
	 c7LbvMbaxfZTyHIo5oW3uA0oU9yn8Q+0nz4l5jTiuAipOkuYo5kjyvkd2edpSCRWZv
	 Uit+VZblL2ASurouqCsAkWlq/KvCfQZTeCz3AW1RcLSmoX+5BSlErUoqG3BVK8E8IW
	 R/HIj6622yBfg==
Message-ID: <sashiko-outbox-225302@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/16] PCI: hv: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-16-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-16-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:56:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The pci-hyperv driver scans the bus and assigns resources using
> pci_bus_assign_resources(). That function makes bridge window sizing
> disjoint from the assignment phase and is going to be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources(). If no other bridges are involved,
> the extra sizing should be a no-op.
>=20
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D15

