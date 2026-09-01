Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EADD1DED49
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281805; cv=none; b=nqGy0+OxQsJuPD+BuGE1r1XbHIPJYwYibYRd+YAp98nIgSCjXTnhfiwvmEnzvbPVfmS1IJENz4d+NklJZExjz91jzstngRfydwpmJiMPGursGhArt8SB4deQDa2xjQO0+MrAxcNnzVu/jZ3GjBDnonFz8BMsfYB549FLALaTxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281805; c=relaxed/simple;
	bh=GHzELN0xThaJnvdVdCzOhVkGCHy37qdXcSez0RKtoK4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cru2u2K/Vr0TO/U9Cp3f3WsLf1oTeRylrYiRpu3fEs2TPnHalJn76K9Uk5gbFkTZIZFl3y4nBhczsuZdSceKX/yH391/pzw8e19/1DljRW75WBM6feBjMfR936xrOXfIrmwNnBl7Dp7HflbbIjzd6NpxzdCBnty1hJtlEd5rBaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwP9zK2D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwP9zK2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF70F1F000E9;
	Tue,  1 Sep 2026 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281804;
	bh=GHzELN0xThaJnvdVdCzOhVkGCHy37qdXcSez0RKtoK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BwP9zK2Dp+GB+ZM7kGVF3Okbs/H87GrhnSrtEk0Z8Urex4MPcx3cYCmwH/Pbm15R6
	 m0YznQZWrDFiaVYRoewPyjA22ronvlte1EDJaq3t36Hwtu9tb6sHbjFZgEMrGGuSfw
	 aKkFG7v5PqXcKseWX9MnulqFdom3OU7PY3osa1AQaoUI0XpKAMN7GLzEvh3hee9PZA
	 4l+2UgUmrDtm3PTAzR1fwdEwHMzp104i2YvKXFwoPJkEZJRgwFa5+mBe2GM2mzIXYg
	 hmL1bzXa5qD+OCnoYjPJIpV0bqMC6zn1F0kzVOAdtv6s2WchPXFiB/z+XAC0rSYdPk
	 2z5FlF0mpZi6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/16] samples: rust: pci: specify base type for
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260901-typed_register-v4-9-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-9-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:56:43 +0000
Message-Id: <20260901165643.DF70F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The `register!` macro is going to require explicit base type, specify it
> for both `register!` usages in PCI sample driver.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D9

