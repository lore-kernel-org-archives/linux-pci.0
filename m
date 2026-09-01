Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272EC3890F3
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282148; cv=none; b=cEoubGLXmeHr9zVQNrMKk3w8wjMW+E1aizh6E5ieSZsBSQkR+Fj9qlHX5rCVJKoVAfgCQBSunVXc73HVK4M2+ZYVmORs7fA8DYu2RA13z7T8fzw01yN9CldahAIPHrr9Zd5LVqjk69xDfDCyt0Ar5K077DoJs5D13dn0dkz8gDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282148; c=relaxed/simple;
	bh=ByYVMag5bEmCjwCVHkw7W/ipKCZmgqVI3FuC5WX29rI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cVch3fr9saDD7lkRGiNqymbH+wH36y110WIqtTi+257yrO8iSIuIMAZbm667A2M/FMzMoK1HWZbGE6QTI+/yV9A4JzENaGc4N8qyep92gNlVUi8Bgx7p9DQ7ZiGVG1OJrsjDoCfyt+VmK9PR7RZ7kiejyWh0mHLEA+sTSL4CGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrREq5Ks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrREq5Ks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AAF1F000E9;
	Tue,  1 Sep 2026 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282147;
	bh=ByYVMag5bEmCjwCVHkw7W/ipKCZmgqVI3FuC5WX29rI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JrREq5KsNP01V9DqagWK/hesrKzGtT3GZ2p4FuO64VJSGLl8Z8wBdmzbxOoLHPOnV
	 vtXK+QQGKl95il+zSX/pQGoTaWB1LUGoRr/DhVIPDz9pQkC90RqEh5gf0oPrkuyFSW
	 iFyEtV9B4NSllebZmP4LV8bxrdP7/2xNdrDcYYE9nfuwAnsgJ4q6z/de2hFYYgCtlY
	 gYTam0WELgxz3pHacz9cBj6PwwahnG7Fa1kXP0fO9qRydz3Wzoo4bFQok9/tcLitdQ
	 QinRHu5h/FRlAT00xDvvE0CNonfYwTP3VSE1aD5YkFOaD1+QmtcbGhM2ThOOEsyI8g
	 xAH7St2jatxjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/16] rust: io: register: unify handling of register
 with/without bitfields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-typed_register-v4-16-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-16-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:02:26 +0000
Message-Id: <20260901170226.C6AAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the `FixedRegister` from a property of register to become a property
> of type. Name the new trait `FixedIoLoc` indicating if I/O location of a
> type is unique for a specific base. Thus, bitfields become just a special
> case of this (where type is unique because we're generating it in the
> register macro), and expose feature to registers without inline bitfield
> definition with the `#[unique]` attribute.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D16

