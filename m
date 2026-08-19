Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654335F161
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138220; cv=none; b=odw0UsRMkotn6HEXqYsGdeZ32uxSXjke451YLoOtpZPrjZu6riOMCeaoBtB4LuYlEB4s0TvN/Taz2qsoPI3Mzzt2GBeW1P2KMMKg9vUsrVYd4zwiNFHhDTQXDwM2lYfOy7e1s6iyNbLDEE6oVmwXeY7WSLLm+zB2b4IsJmrfuS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138220; c=relaxed/simple;
	bh=bcALehRv1n2/qmFLx37UWyQWCBtULdXm0JIlL4vEy5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JuyJe2fZcSidtjSNWLF2jWh7LOFSlqTt45hsRSG2vKGR6GnlQSbtkSoOn2CEAMNn8QthkuxUaOcxeWDb06JSYHgbRUlQvVPigC651b00JJGGSU9zKUQ+btuxSS4d8lqrjaXW0I5v6MHBvd+M9CvGaBcsk6Bpt9cFZZk9ZPLWulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgyRGR+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgyRGR+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9EA1F000E9;
	Wed, 19 Aug 2026 11:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138218;
	bh=bcALehRv1n2/qmFLx37UWyQWCBtULdXm0JIlL4vEy5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KgyRGR+o+iUKyTDjHTF9rEI73A9E6cHnFKuWJnN2+7anAGQgDJ0qiUB5PgQB/I6gD
	 OmLwtLXrX5oj2DoN0fIomJ50FGMkt2d+vbkAB/ZvT27uALK+LQap7Flt/Kx/hRn5JT
	 n4zcgc0A2EN0nSEE11XRqC49rqw4/wCWPBxh+KjtyslI3J6LQDKnQ8iyJuga8LdcCV
	 ilL943/7vod1vuUlDgk2qklWei6xWto/wmvQdo5trZ4/BnPMb/sjJeoZjyivpSz/ed
	 habl5pXv1u1rY4gevWLxl6QEe9hMswEyELN6D0iXVcKgl3xM8z6iratfOHs6Zc5VQP
	 SRe/6xxUEmUoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/16] rust: mem: add `transmute` with deferred size
 check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260819-typed_register-v3-2-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-2-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:16:58 +0000
Message-Id: <20260819111658.AA9EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Implement a `transmute_unchecked/transmute` that checks size at
> monomorphization time instead of type-checking time. This allows more cas=
es
> where we know that the size matches but this is not generically checkable.
>=20
> The signature is equivalent to the unstable `transmute_neo` function in t=
he
> standard library. A safe variant is provided to use with types implementi=
ng
> `FromBytes` and `IntoBytes`.
>=20
> Existing users of `transmute_copy` to bypass size checks are converted.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D2

