Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FC36C9CC
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948488; cv=none; b=WfzCzegx9FgP4volAws1NamlpnKDo3fTpZ7pVbEh/z9mPg2yHb3iOHTfTfXXnLPgdtABI5knAR5gQqqadtfJQ5l6kkzm+xmKHO9/nliQQLjonIO4k2Wr4j4GB3kYUDh92c8Z5cVsV40RhRPdCYuREdpiwuufGRtGuMSogYfBwhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948488; c=relaxed/simple;
	bh=8IOD1K+MNA+JCsGD/3AayBdJoG0Qr+sjwqjnC+Ixm5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GFWWBuHxNopebl4ZTQP1DflLEbW5VuT8oK82tPEbaWOcbwWFv50+6b1Oe2nUfX+obO5wSZnWGwwzBjEcdxzVkwdekFDhELpe4ReN61e8LvHufMak6x0tpBOzo39q/9XGmMrW2RBwMX24EL0RNjSqeeVx4eJL7RRbGbp/S0EagAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfOM8m8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfOM8m8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162641F000E9;
	Wed,  5 Aug 2026 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948487;
	bh=8IOD1K+MNA+JCsGD/3AayBdJoG0Qr+sjwqjnC+Ixm5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gfOM8m8cM8aoFn3e9dATK6qcaOMfvJearRESjg1kXvOzzIYb1UWXftRKHXMZ6+JUy
	 jeY3kO9juknSf2DgLFBOqRwoEYbkBntuZvP2gHAoI9JcElXuLCWMkbmNECjO9GMLId
	 YV0hRhB6bdKM7htsNvnEkDezbwtorG062TZbXH1Xvo+yhUzh31sjufdYU3b9yPs76i
	 fL+OFLDxzM3hqx+tDTQOkPXqLimSzNPevSyTZ/o2KfCLKCOeo9mHgumnAyNpizKgzV
	 yBvkr7tY9Ix3q5IFwVkhlvc9GKzCkYbwHdkB7oN+f58r8+g4V/KflFsDdIZivZAPB4
	 Fxj0qOw5bVxpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/16] rust: io: register: remove `Register` trait
 and cleanup macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-15-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-15-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:48:06 +0000
Message-Id: <20260805164807.162641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> With the removal of relative registers, there are only two type of
> registers left, fixed register and register arrays. There is not much
> benefit in having a common super trait for them anymore, thus remove it,
> and cleanup the macro rules associated with it.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D15

