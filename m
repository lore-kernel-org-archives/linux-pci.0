Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1831DED49
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281795; cv=none; b=CnSooDAFy0tFs/jxlE1ZL4iT28SGE086+ZfYVr+3TgEppGMz/SPOyoAMhbIiC3a2Ju7iTccla0hRxfhKf1LZmsB5xPhlritfLbz+zralfugvWnNd4vH6UlPylyFU2iNkm42Mu/kgc/e43S9ixzEA8RkMALz3ih4IYhypLgduB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281795; c=relaxed/simple;
	bh=FxxxYtRiaDFHCV+R3q2mZlvyzfxA8ksELi+XBCAA8AE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BnC2JPRNDhts4z8TadHO+VmYWBPirf+g6ZOEJ2P33/XJtoCzWRDby4BNiDMBZQb1r9KQzs2KdxGY8a42gSCRzF0Dv/8mbc3mOW1/TUYInMqUBNW4KgB8kvzMAY5GLhY3w9p1dPfYpC9NbkSH90XoBVJPU2bWXH2hXQ3R2gvmtps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDKD+YVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDKD+YVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D76B1F000E9;
	Tue,  1 Sep 2026 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281793;
	bh=FxxxYtRiaDFHCV+R3q2mZlvyzfxA8ksELi+XBCAA8AE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZDKD+YVgA0n8nmNycUT00Tc4paMagldD4rZ1oaU1lOrd57Cwmq1EsgTzCLvuenxwk
	 0aEXFC29j7yuRhCfDwvrZnGA58o76mecgMByJN2Jrb+kGIWvaR/6iLcMZpn9RO0i7F
	 doOkUBxZR199+AbZlwsl2C5SBYXMst0B0yd+ia/TeHngi3ai6DmWP2juFW81O31Drq
	 gU+Wt1iFKJunf3NAPVLfjbHvzs6N5xdTMI7BFgjc/OWQn6LvVEUNqjYMhY2SokLHa2
	 buHYSKADPvJuhzo9ti1/XCMNnPxvtWXOmDQoqnjjpTvhg+Womnn7+8yZ2QkpRAEMgy
	 e/4bxLt3pbGuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/16] rust: mem: add `AsRepr` and `AsReprMut`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:56:32 +0000
Message-Id: <20260901165633.1D76B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Some API like atomics and I/O operate on primitives only; therefore other
> types would need to converted to these primitive first. Add two traits
> `AsRepr` and `AsReprMut` to indicate that the type can be turned into a
> primitive for these operations.
>=20
> `T: AsRepr` means that `&T` can be viewed as `&T::Repr` and thus it needs
> to support transmutability in one direction. `T: AsReprMut` means that
> `&mut T` can be viewed as `&mut T::Repr` and thus it needs to support
> bi-directional transmutability.
>=20
> To avoid duplicating implementations, all repr types are normalized to
> unsigned integers.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D3

