Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576995;
	b=vo0XvqrsTVJ54rWG/Al1gwegFJJiNfhf4M8hgtR4+A2JUO2hOpjk/aNue1GJv7Kl+IwW
	 JtN/4tSeghhox+8OEF24l1PeEltxJ84+kGnLrygiUaW7bfNT69hiCr3qE1Qx649vWEZvH
	 LSlkDFxafF6r3LsaKcVfVkm1zVz+J3bbHtbK9JhDusUt5oo8ecat/zAd3v4kobmKUrR2L
	 o6xA97YF/GY2yhdiK3EeCYzHB7rk1SPBLtPMN7j9pqcUOTgD18+gg8tvr8fz5HAi92nt/
	 ixrD+GDtcUVqK58GQ3yrqTRnxmPwspTP6+tJ/8i9IXUxCaGen9+6iZyyIZtEbhYyMsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576995;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xF+4eKY6dTJ6rYNLklvTWTpjYHf75fOfeK4jFbYXtNU=;
	b=utVO3J++j7BIQNzorg4psE60+BT5VUhKj1kY9Vtn8XnKA+rogCesmr08q5ZOKN/kDwBv
	 iYFqrrbXTIbssUvhJ8T45nfURge4XGcMdegUhRKKeWCx+qC0SSfO6EzMwhwIqX58RB9tp
	 c7i4fiZJurWEEdZpQiFIQPMgtiRrRnN+HLYVciRoosfU9hIz6XlMlyUyc+Q8pbHQoR8na
	 k210pH7kE7n1emEXO9CGEjf+s+sv5Bd2njc/hOgZjAb9oVswJzrLlC1A603gWtxbhY8bj
	 6P35L555cTnbo+HXCVdY3nSeGh3Hqd1HNcQvVm2rfXD6YRycIdxhUXmCj30fed5FTvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYxtD+Ee;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9CD606A327
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYxtD+Ee
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C23F1F000C4;
	Fri, 13 Nov 2026 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794576994;
	bh=xF+4eKY6dTJ6rYNLklvTWTpjYHf75fOfeK4jFbYXtNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JYxtD+EetZN53gUZ/Vxpjq6xzP2s++r5n0UjvdmFsxMZqGcYzdOYxNkYvDNyuvT2L
	 PBYpE4sH9n//gUwwJtj6yD+bCstSXRSiILbeDMgXnhuF0aTNb5T3kCzUQcMfCgAVjg
	 G2Vo15IxFNP4ghfXzkAQNFUEOH30SxkJKmGD6NxKDzcVHu5Er6DnNolzFrOkkwyQtg
	 EO7cuk03bfl2zBAVgk50FIMXA1sKQ1BuKU8dtv6fCEfmHf80Pel5oIMqzyoz/vnqkn
	 gD5BhtxNCEdFORiXvH1XBzU2HG8sQz3XgPkfgQDaWH47yeqdUOl4i48T22qkYW2jCB
	 HAG33Lzzv7DyA==
Message-ID: <sashiko-outbox-212901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/10] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113132935.4152566-2-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
 <20261113132935.4152566-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:36:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Endpoint functions that export controller-local DMA channels need the
> controller register and descriptor-memory layout.
>=20
> Add DMA control and descriptor-memory resource types. The control
> resource carries the register layout and channel counts. Each descriptor
> region is associated with the static channel ID assigned by the local
> DMA driver.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113132935.4152=
566-1-den@valinux.co.jp?part=3D1

