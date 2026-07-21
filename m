Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940AE392C29
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653177; cv=none; b=nNV5eRjkKbUk28FiecDWVLsdJfUuFPYgOazC+6d/VqLVmmxXshVEiSgtE51DszuH+BRoTOYghUKC3RXQPrGJl7Mxam3j3AktFBtMcBy/ZEjnWMsgNJBF/oFy6o2ssYLfmhgyyzeM9DSlVbXTa5zJlf5UOEMktsfpuA1Cixlq0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653177; c=relaxed/simple;
	bh=WJUS7PUh6rougI4oL7CS6wKyDqtM7/jvvxuBpuoCyKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mjej6tZfWecl+yTKgMvwXhVfbVSzOzYV3RiLzKAUoqyzQosKwYEwGaB+4HAwz0uT1QgGkgJzEahvLQBKKT+o6ZfEDdycM/dKA2n+DUjF8gO5WA/9idPrz8jrBc98oECPmcEVzI3AKVtA5SSJgNr1epAWcr9rEobTzZajIBZAUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrYxLE93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrYxLE93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD33D1F000E9;
	Tue, 21 Jul 2026 16:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653176;
	bh=WJUS7PUh6rougI4oL7CS6wKyDqtM7/jvvxuBpuoCyKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NrYxLE93IaHik+vMvF43ES/Y1sSwthXOn1BW4A16AwPTuVd+rpmslVC9ECbHamDWL
	 QPtE8TYJQi1qU1+uaXNg9yVv2dEszPnKmncQcg7fmXRLK+aS5SbZuvo8VmrBHx4H6h
	 xoWnBnYN/RPucz56826FpZyarLqppQlVwH51Lj0fukiXwjWtGX796a2eZ2C1Vwx2oi
	 eWLbdmyIYH3QgfuTpEZTe4M8/mjGgSkK7NqtiJkPxke/XANyQhRew0oYR5+h6mJj6q
	 E7qGkbYdj+OK8k3meKJ01L9/4XZW/MhgW8ZVaT703/C541NuUZ2Wyo0v3aq/Sxv9Eb
	 WjiSNI2uGUigg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] gpu: nova-core: specify base type for registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260721-typed_register-v1-2-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-2-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:59:35 +0000
Message-Id: <20260721165935.CD33D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> All registers use the same base type, which is `<Bar0 as IO>::Target`. Th=
us
> add the base parameter to `register!` invocation.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D2

