Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46CB488DAF
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281946; cv=none; b=oPn2aq5rO5wg7uQERaTRw5aSSxR846rrsZMWS/xOJ18Irscenatuwf67uZqrzWUqrrkI2ZslyFDkAFNloUG01lD9j+gpIUyistt6fm+CmuZx+tM3jS+Pj9KwVHdMF2nO4ZTJ6owb8xKAQpvLnAdbvMfvn5jJcSg1IPyexvIOSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281946; c=relaxed/simple;
	bh=e3UlQvfsBCgYPhIPS4h5GwPnyntILhUACVh/wBzK3ho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JUocGPK2UVTGOsojaYCkfmbpXp5sJqZo1pj4uXvkZFDJ0yK9CT5V6iXCsTglJuqcY1JbiftaUnpooZ54dT9DBkqFzXG1e7MdeHz8LNUimQgWiGNqqjO3Anr+KNqnSAdZM/lv5d4S2LS2gstDj3RS5c9xpmS4mGsSqQncS2Dc/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhqCVzJJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhqCVzJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DA71F00A3A;
	Tue,  1 Sep 2026 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281944;
	bh=e3UlQvfsBCgYPhIPS4h5GwPnyntILhUACVh/wBzK3ho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nhqCVzJJubcl/KHRw30/pIjxBkIvr4Zd75H/z3mE9SZcps4PtoTGFpqES5mzx1XEB
	 nxKiFJAcD+3Z8Alwh3BG+KVgRmuBOJTZbM/GV1D6vXZu3wbSmi04Rz3wM/5DvdT/ak
	 xZc02/Q0WPg2OZwh/mmsJmCGz0Y1akzWF/rebtLr0zLsVt7GSsouDPLONP4zBPze99
	 tcdcowxs/DYXcr4Ra+bg/8Lx7gCNrYNznHPqB71EIEBVbs7IV4ln3ILsLMvP7DHtPm
	 pxijb6YOe6l4xjFQAcP//jgD9AOiC5zFuvFuRgkd0UsDNJjzYyQ43u5OkA2SEme8WA
	 ezysGObTw3SgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/16] rust: mem: add `transmute` with deferred size
 check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260901-typed_register-v4-2-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-2-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:59:03 +0000
Message-Id: <20260901165903.C5DA71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Implement a `transmute/safe_transmute` that checks size at
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D2

