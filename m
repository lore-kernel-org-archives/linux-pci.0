Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286651;
	b=0h+gPD0yxGjVXyaLF685zPtRhqzimaFmKW5fZejS1dMT/hl71dHy0lVtYHPW5RLfRcRl
	 TtkIxuJJjJbHY2PQH9RIuSn9nKTKXviKGo1TIqaSAE5tqlyAEBb9GKw0vtjLejgUksY9Q
	 NGywyqNAThvZnbR6yB9WnkrV2sqHEvmiTVXMKT9fWjoq23togYD6PFwdUMp61OrbbJRC4
	 AN3UmZmGnDSpEUNH025RPI7JP4UbwfpLCLw7ip9c675S35E4VWyFs5Hspfpb7YzAyuPDV
	 4zOQOhLpyJ2U3eODX1ANZaE7QblbW6Aa8UtUFF3SuENQ3Hbroq8tduuw7/wiL/1NECQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=twu9n7c9L1cfv4EYolXszyG6YZyGt09kv6MVIzIFywg=;
	b=zu9otxpJXq5OBAz8jVLW+j2/A6BX6D0tOSsRjMBBTqTR9w1jvPgjyFPtrYcN1Y9af4UO
	 h+xCjghWtPE4yW88LAtH3zriQk6/2QP0f2jptu8aUBVl3PNCyW+qPk0ZuWoHiOwqHX58a
	 vYkLPW2q4NINoaQGWkhPfd4THUh7BLjs31ipMbBVVkzQhPIEbA6tEA6gCplnVWTBvdred
	 k3+BT0q+Bn3bCQgwUw/Ak9gSZVWJOYOnVBwZQPeEabW1JKwTQQq/kdvQIP1Nn7537hAZ2
	 amba+ETByvy/RP5U9zWtkY4MuZ8zWtoQCDtpdUYIAI+1A4KkEXV8LGFE1p/t1PCLlhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iV9JJ2xV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894C606A321
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iV9JJ2xV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014061F01828;
	Thu, 29 Oct 2026 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286651;
	bh=twu9n7c9L1cfv4EYolXszyG6YZyGt09kv6MVIzIFywg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iV9JJ2xV5CIqRBdbFDzoBNJYcOSllR+sReLWX6t5DLq5Xy6H0Mdr8vsPAHp6JNN61
	 8nzrdNvsGX+1PqSl167oDgQtyREtFn0KC4ndSEGKORnZ+gPNufIzkmZ+Qd1NyoGupw
	 jARYjQvJewC0hataZD4/OUrPXVb3KZvl6ncfniL3PknL1+z5x07wQiacZTC3Zxz3KG
	 xzvmItkl3yIOjaprOYIgoF+1Bnf2VxM5IUg1ylsBEuVoxpYrQsK5aF3MfIroIDbxVq
	 wuSkd+li8FTXm08pwF1aItxifoeaa21GFnp+HOKOSKOFOvlOhTrpB+uufNMDFLyhrw
	 S44qNCfs33sxQ==
Message-ID: <sashiko-outbox-189586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 14/18] PCI/CXL: Reject reset with unsafe function
 scope
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-15-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-15-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:10:50 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The per-device PCI reset interface must not reset sibling functions.
> Reject cxl_reset and cxl_bus for VFs, multifunction devices, and PFs with
> enabled VFs.
>=20
> Suggested-by: Alex Williamson <alwilliamson@nvidia.com>
> Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.co=
m/
> Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-de=
v.notmuch/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D14

