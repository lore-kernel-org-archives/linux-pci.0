Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50324356770
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948500; cv=none; b=Ee1DP2udpklANC7nJJckJD8vjhoZQW2bdjJGlRvpraF1S1mlQaQDKrX6Q0bhhEHh71y0sHMCRWhov7InZ0iGWBdfE0gwZAY05GwSHSaJtwbQLOPmw3YmNbgkJWtDVmONPBvMCAv0WwW0sk7RthIt+1VEm0TrSLbdufZEwQeaIPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948500; c=relaxed/simple;
	bh=2YoXrm+YrBdqLLPU4EIxJRsyoQw3Dz/KBoMXldFjO90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NDfVNTFqVgHN+owHYjHvYVuVv9D7QjswVNnwopxWjVmgOeHeMoLCZDpItfhkw+T4WUEscyttzRse/obPAr/PQNsoKnLsSUEjoAuwJvDkZrtGJAOJe8XHSWG7E4+OXGpD/UbY6mS72I10aJRV9qlci/auNWTSyKx4yHZM0YeC0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUIJpkHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUIJpkHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20F11F000E9;
	Wed,  5 Aug 2026 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948499;
	bh=2YoXrm+YrBdqLLPU4EIxJRsyoQw3Dz/KBoMXldFjO90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NUIJpkHtaHnaGvBixA/CLu77qThxdNJlxjMX75x2ZStQNmXqTTIF2lcFXGzPvaqCB
	 x7GTUj+OaSGkSDpt4s9AKgVsOXTd0XWl7wAnc2+L8y2dV6XYzWIDxUArUoNf8RuzDi
	 ofbjNJl4sY04pQzmS3HjrCrQwgJMdQRw/32Arlw8fwyhFfodObMHGh47dPQsIBdZmY
	 xJQYG/uu0HrBG8iLN6IgXSI/3EoJ+7aTaBk2RhMYWSvlOJ0Zlb0lg/6OvKcPLZCS95
	 gplf7xIDb45on7eY4D6DHFJ8W3U6NZTO0R5SR7sX3X62glkVVEfWmSr8PY95XKKtwD
	 DcA98ruVsBy5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/16] gpu: nova-core: convert hshub0 from relative
 register to projection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-13-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-13-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:48:17 +0000
Message-Id: <20260805164818.D20F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Similar to the PFALCON and PFALCON2 conversion, the hshub0 relative access
> can also be achieved cleanly with projection and a new base.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D13

