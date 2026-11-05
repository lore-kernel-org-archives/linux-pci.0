Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885820;
	b=hsHV4sPKuGOi1KtTbrAsr09GIuiTGUYZK5zULSE6IwQTp2RD9r/7t5eEdfWe6E+pawyv
	 tt3/PQDlA1fsEQWMkbY+tR2rDfHpNKj32D+/PW89tkJ8DRnleD8YCXcZHXxFiwN00ia8/
	 uCKzLe88xMO0tMPxmhx2gJM5tepHn5eS3TdBQIZlqxSIHGiARapqVd40vT/TnzG17gJfN
	 A6cLCM3ol41ZscCK49psXrN5R4q2BJgrmOVRYABeHZab8aBiYvAtzAS7wyg5WI4DE2pjV
	 5Di7S6TH5NkPjjebLtlAHnCehQESxNvnl5nsq1NXnTHMMjM3TcV6VqTO/KSqhDGk7wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885820;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K/2muAaJC1NvEvUWyOogF39v4c22VcLJHfb4Ii8tHIg=;
	b=dN9hOmRbjeEsn6IY76qLKpz8qeNhdwG/k0sjEYTvMhA5jJ/ke98A8ydrTIt4vUE8kDks
	 BMWvSVyChnyuAyd5D5262NFOnEh9qnk6uIi7paWjrbvkQaBRNtljhwaeVgNEXMEW9NasS
	 fTL8P4TRacEQ1yo8evCc5+Rv9Cg2YGf7Yfi6OuoRizNlxdnVWRaTJ8tmC+mtzfGNrg1GK
	 XiF7wZdUYt0a67x7yvUIivtb84qFJDIhD3MM7bz+aabmILJaosUOREfw0Xl8iXzLa8uBq
	 Z9J7cUr85ZPOX5/lmK8o2hDFbnMt8oKXLLwB/KBjH1T7yxN+Z8FVxQYVjuJ0WjkpT4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpZM9mWU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C54606A32C
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpZM9mWU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E41B1F0093A;
	Thu,  5 Nov 2026 13:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793885819;
	bh=K/2muAaJC1NvEvUWyOogF39v4c22VcLJHfb4Ii8tHIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jpZM9mWUaxHTqDb2erdbf6Ej1x5b85apVxSvyNUMSItep30FAV6ieIcAbIQvk6L8H
	 4CdnnXapjlWwLjJVL/j3RYuFoROc8sz/9rtepPbdpJmJEwMEO3b+6j+pAI1II1yV0u
	 rL6Bp8Zun+p4IIgHSK3HILUK7gWA58fC7SrHO79p0vA+/7l3whjM96l3xbGwh9ouIO
	 yZpO0z6palpWeIinh0WQ8XtkygrkJyQBVR09VuA49a8DAzLWEypfSujdmL+gT5cpBC
	 aRc0X11IyJxPD/XA9uZKStBMz4nncImCt21QS9z5El5sknpvlrQ6JNUK3wAuGySKa1
	 lhGmeFp5R3tsA==
Message-ID: <sashiko-outbox-199166@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/9] PCI: dw-rockchip: Fix LTSSM set functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-1-a2e55846649e@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v9-1-a2e55846649e@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:36:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Before the Rockchip PCIe driver has been switched over to the
> FIELD_PREP_WM16 macro, PCIE_CLIENT_ENABLE_LTSSM and
> PCIE_CLIENT_DISABLE_LTSSM were setting bits with a mask of 0xc =3D 0b1100,
> which means BIT 2 and BIT 3. After the conversion it only sets bit 2,
> with bit 3 being handled by a separate define named
> PCIE_CLIENT_LD_RQ_RST_GRT. Apparently the conversion missed to make use
> of this new macros resulting in the third bit not being set.
>=20
> Fixes: 30e919570581 ("PCI: dw-rockchip: Switch to FIELD_PREP_WM16 macro")
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-rockchip-p=
cie-system-suspend-v9-0-a2e55846649e@collabora.com?part=3D1

