Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843415;
	b=mO7ACtzmzP/Gj+uRoXOjO529loWqX/yfghBu2WxrhYI2YDttoFwIyVLE4hS+r+M4nWr1
	 g8mvIoSkfRcCziHpNgJv/FkIW46BnBxwXDmXTw25QHD7GnG19Y6KUeh/n+tOsZyKdC37C
	 4C4OLehbEUkIgSOL38w+50KNNOTokJMJZAMackoOzME0kxVqXmP5ZU51ZTah/5yUdF6Nq
	 jBUgvnGUvwsP2SsgxdmtpvZZTQg6Zyk+evBSIYelJ/reo8EFoH5705JmHWVtK3wzVKoXp
	 bMkE3MMwlSmk8CGxxOca1pczo6rWdEq3cQmaHTV/bdAwl0ISM0fgl78tSA7zx+0KHzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843415;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=unNHPiygV1A1+nsU6FnKM/h1XzAJCmucuDcXSw3vH1s=;
	b=AdOCCm5cVO65Ige+74v0cpV2MC0XKInBcKzzvRrSVQ9Cvik7d830QeCwOC93zTUGa1I4
	 KMy5YpIsM59J3pAlvzMDeUpEtm7j9S5EpY0s7zs+3h6V/cAsO29hy426IANFEu2aTzEJy
	 kSgdMQxEA9HYd8UME7dniR+t2xeoBZWzVi+Hm2HDFVqbo1HcOiRSSOfaVB/DaKE1pRL9V
	 CZhABjcXPj5OUdJ6FwOqbwCAtmp4tmdutHcH9EnyVjo+LbxUyUZU1BYC8tW53d3vCHAM9
	 7UJxQLBR0nJQL2shfvkGE/+LHIffddtnz9Pb9mV5HfHX4Ihe6RcVI7TuOKPj2xq7WZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfRogfGy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F041606A323
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfRogfGy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66401F000C4;
	Mon, 16 Nov 2026 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843415;
	bh=unNHPiygV1A1+nsU6FnKM/h1XzAJCmucuDcXSw3vH1s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DfRogfGyGu3CsjoaNFKVcPSqdqdBgDqVKieb5lC4lzyTk4grjOxio1/Z61Omv2zFB
	 /buTgQZ3ClY/Iq/9ujDjtqL3S0Q5d4+NLVLMpJ03DDf2CtaJUafysvoOB8GpX7LvC7
	 X9ZA9sApQyG4HO5kf/cYOFBAi/9I8pIMsT4n1ozZfu3uKCJfn3Jt9qsdllXn/jKK1G
	 RjgQoRxhTlAXs40Ya76UnAD1aabzVhKXB3p63jl+Sj/xxjODDgHUDaiGIhqwrdzYTX
	 Xk3i7XYFR7nlhdmikNPajJJjJNXxppm4P6cE4BF4AcBZdyBB1/JqbCQEC/h9nrKVBs
	 rTKxUEUt2Ji0Q==
Message-ID: <sashiko-outbox-217305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] i82875p_edac: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-7-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:36:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The i82875p_edac driver scans single device and then attempts to assign
> its resource using pci_bus_assign_resources(). That function makes
> bridge window sizing disjoint from the assignment phase and is going to
> be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources() which is likely no-op in this case
> as it looks like bridges are not involved here.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D6

