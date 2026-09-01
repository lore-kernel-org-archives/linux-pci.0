Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929547F2CB
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281738; cv=none; b=QW6wpxYcLmsLMel87NXVUDoNUKqjaeGyPPWiAQlMYFKM4AYH7N473NxFOx2RxDFcbtYZtCmb9TtxNeb8eeaSZebH3GG2E2N4piXLwk794TXHcOUI2Cd0725lLsWTzDOIEjSP8haKJIWa/Y96XCsUAu2bttW7j5X7aAF8eSM/6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281738; c=relaxed/simple;
	bh=Dc6bwf/GahXGIO5yuZtsjqF/kfFRrgzsaVcAvEKcbA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=doqUSU15SBMiQPVke1b8Y9XX7vcIuUL8ZXfDGyO8Bq5npnHDCZwfWi374ZgSIYVU4uxiLMTfz54TJ0qTt0Cw6UFzajOaNEiSipwDsDuhfU5hJXaa7T4RQ/oqw3oSw79bOPf1lKy4+q+86YDkPGcBEDgH751SNWokglEz6Nax1D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXZkravo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXZkravo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E41C1F000E9;
	Tue,  1 Sep 2026 16:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281736;
	bh=Dc6bwf/GahXGIO5yuZtsjqF/kfFRrgzsaVcAvEKcbA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXZkravoMfMs3pgiGI3OCsoOhvEsnCm7ItbD5hUx5frHCOkaiArc9u+iPqndaM89T
	 OokUOnMLalieKVxOzBZTYaBjUm7PX+I5XIf17OUdXB9EV7/tXQYE4gmGJxTCyTs1pS
	 mRbYnjBY2sLAZDaXY67FRe6IOJp0YG8Df9Vu1TwT1D0+3fdby8/QLSL6Sn77k0NKYC
	 s2jcYOL/oLO19I3PYPTOF01TVDSaZQtIm9APCIM3+j1DniIbbwgtjGGjzGi0GEegQM
	 4cHmNFz8IGonqCPobqBERqFjilnq7Hhry/8gE6bCj6jO67Md94/ke0n+/FlPJc+Wdb
	 N7reCvh0h7pXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/16] gpu: nova-core: specify base type for
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260901-typed_register-v4-7-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-7-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:55:35 +0000
Message-Id: <20260901165536.3E41C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> All registers use the same base type, which is `<Bar0 as IO>::Target`. Th=
us
> add the base parameter to `register!` invocation.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D7

