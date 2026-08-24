Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C04052DF
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570551; cv=none; b=hNmbsML347yVI2IfuToZnxasJsZWQsTwWPS/5Hvv7OOecfeT6VaHBjnCzA0km38Npujg9FFtWLRx69ob17CTjDnAYU+R5Q0ziAX3YVFBbvVLSbplYw2Jv2bayiutHxu9oznFSyJ0IUUUW1U4He1ZuJHjYxY/IGenBdLBz4xkAHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570551; c=relaxed/simple;
	bh=Oj0jMTC8srQp5zygQ/Wdg+FroDjsgNjFW4EaDOOL0Hw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a5PuD3YZBpjbe2SqEjrBmlurr0pPLiyYl7nn/I1olKugpiEusaMQOAdXAOBwWVfiBTrYS7tlsoyB4tWSO9GlyWM2+4MZbiKI/7XPJuoFAbNIgABXJ2TIkOvu9YKLeqTJp9XjAK+9kckPvhM/xpR6LeW+6Hu7kW61ywX/9jfkPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrPWCFhO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrPWCFhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF251F000E9;
	Mon, 24 Aug 2026 11:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570550;
	bh=Oj0jMTC8srQp5zygQ/Wdg+FroDjsgNjFW4EaDOOL0Hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mrPWCFhONEM7d4PKE749JmcAWxgmaaVHvsGp7+VfZBQjEj2IuzXjJn/LJucfNnp1L
	 T9IQ9freoHIpleQRoOO8rtnIUoeD6LBCXgW1l+rVczRat/c/aJaGH6ef9CeC+gMtEy
	 qZEfgNO0qmPwuLoDhMFlWMy9AxNAxiOZL8PSWnFI8gREKaNPBY+7yt3w0woexCWMdv
	 y8T5BHujsDp7mPO7g47mVPNx00aO+keP+roz3wiu/3hmUssf45XykAqmzRlReQHucS
	 quYB09luaJ2PNPaIeaYG43jOKKpyceW1FkYljknqxJbPAUrDPAyBUfb0dTF77cWqIi
	 R5zZPMwEqd7Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 1/8] rust: alloc: add `KBox::into_non_null`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260824-unique-ref-v20-1-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-1-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:22:29 +0000
Message-Id: <20260824112229.CEF251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
> is a convenience wrapper around `Self::into_raw` for callers that need
> a `NonNull` pointer rather than a raw pointer.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D1

