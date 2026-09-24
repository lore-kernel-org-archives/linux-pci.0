Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463724BFE75
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277276; cv=none; b=a2h1R2g3Jik9cBcDSNSonNutHYxREilKnbxyFTnRA2KBRwxCjm7+1U2Dw0EW5WWJBrZsRz3yxwOXPEqoYsuAY7lytwcNqWZi3egjZoj3iXRI2NnYFWy6IyJ58T/rAiKSc7SEbE9lG4VSXOXpRJeO8V8PLfyj0XGAQKUZtsXLiSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277276; c=relaxed/simple;
	bh=hp/GSVLG9auPvauEMth8nxZakGUTRx9VbhrOfGyAxP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wc9AyeWdtvRjwzvQlCbqXqjZETJ6tMMpblkGjybsrnvNz6G1y3WLznegsXkih8w7hqD5Tm3PDrTiYDmKfxAncIFxQd4Av7IMJOmdysLx1FXHQZ5fCaqSzmaETk5Dc/1bw2ykS8rh36XtyVZEAeRXCc4uUsqfW9teCP2RzM7kcRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+U7k0PK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+U7k0PK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F9C1F000FF;
	Thu, 24 Sep 2026 19:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790277275;
	bh=hp/GSVLG9auPvauEMth8nxZakGUTRx9VbhrOfGyAxP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+U7k0PK3cL/OI/BYg+KSUDt6hiUcJoLSuUQhtvJbAPt3SIOQX5ohxPukcNBLFQel
	 /XGYW46bjCpg2SynZArOR8/nv0vkj2NH9tT1XYJQJjyp7N4djYnkNNpTzRKdPJu0hD
	 uE3CL1XNRBLlyhh+JGJQVWqbu3hlN/hraC3tkDMLJPIc4x2sU61viXyN24UiwSOoJH
	 LNgKfoi1Bt0/hXlVNK8SI9T/bjjNAYuLmm49FhlO4kU1nDqBXaw032ZEL6++y1PRHG
	 owSgZa4KX0PxF3KHXuNHOYKweKx9xCP3qq7RNzuvGBEh0z/gR5SP0U9r2HJycV3PmN
	 dsvqjyYc8pl7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] rust: pci: add is_virtfn(), to check for VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: ojeda@kernel.org, gary@garyguo.net, linux-pci@vger.kernel.org
In-Reply-To: <20260924190556.1620886-4-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
 <20260924190556.1620886-4-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:14:34 +0000
Message-Id: <20260924191434.A9F9C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: John Hubbard <jhubbard@nvidia.com>
>=20
> Add a method to check if a PCI device is a Virtual Function (VF) created
> through Single Root I/O Virtualization (SR-IOV).
>=20
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924190556.1620=
886-1-zhiw@nvidia.com?part=3D3

