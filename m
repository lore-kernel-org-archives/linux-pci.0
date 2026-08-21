Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9013793CC
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341436; cv=none; b=tlQOmiXnsPg1SJl+4WUJRThIfWK0JF6vTUshtINlOA9+T29yl5NqYbEkYvaY1nWVSauu0F5IUuKgSYqgzLy3KT5AmHruSeMqBLIcKdde1E8YgKQhpZQrQb9Sr47w68iAa9aFtH5BxQH5nKiqmUx0GYOHPxl6AGtw6R6q4G8g0b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341436; c=relaxed/simple;
	bh=8qhBb/NqVlSg4vkJFXZij9wG2YNYl9Dcz+tXT276ZtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u8PJIc6LGmrspIRzDgYy3Y6T+WBOeOmpneByerGi9ZJTIYAkAfQWOFGYnlwLuXIJJrXMS2T5cn67gRMGLYXDYH8yZCHJtEEGnTckhgC6JuHC07kLFPjHHACxLk1qAys1djgivvFoRBIk+61xvdhK8Va3ZYHLq0kIoOO1UEp3gYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN7o1h9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN7o1h9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA85E1F000E9;
	Fri, 21 Aug 2026 19:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341434;
	bh=8qhBb/NqVlSg4vkJFXZij9wG2YNYl9Dcz+tXT276ZtU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oN7o1h9xWhgLrYiNiTpOM9aHDFIyJQh8cOmWQhFycKb8bMsdF8dBQfx8txp1d//gC
	 H0Si/L+US8V0RKNxl8iQPdht6NiG1pbhoSPUOVhCvv1VyKam1KfJ9hepkNSuppf6Gh
	 gTh9OxI+frVF6APnQjKfzRp3bStMVHoMAkoJ4oKkYrz2gH3QI8ONL5IzGMN2oo+g4o
	 BzCdewbG/B4SO00/lw16rwXRBM33EQeE/r0SVwiEbNBzFeWNDxQl8MR41McfR593Hn
	 zkD3aLaezyOwvTy+R9F4gtNwKM/yZs99C35Wj2aUxY4xOV0nNk6A08rDCUHJcvFuKI
	 qVqR4awq63/0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/18] PCI/P2PDMA: Document the Address Type
 assumption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-7-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-7-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:43:54 +0000
Message-Id: <20260821194354.AA85E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> P2PDMA selects a mapping from the ACS controls that govern Requests
> carrying an Untranslated address. PCIe r7.0, sec 6.12.3 routes a
> Translated Request directly to the peer when ACS Direct Translated P2P is
> enabled, regardless of P2P Request Redirect and P2P Egress Control.
> Translation Blocking takes precedence and prevents that direct route.
>=20
> Document this assumption because an ATS capable client can otherwise
> reach the peer directly whichever mapping P2PDMA selects.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D7

