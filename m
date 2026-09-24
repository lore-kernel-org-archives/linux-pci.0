Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61643313267
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277219; cv=none; b=gWxUHaxAsfqEptQPGDx9J3qeku+Bc/V92fb4RkE6RdtZWtG17FdLgbLWjNTW3RnA6GEeRhbxhsqF0jfe8eBJg0lBJhbH+NnVg4h7Lu1Rtn9wqId3FBx76s8Gz9y57YxlpJdzfQGOv+jAhYCT6WF0uxU8lEkHKEHLCWnaIeLKCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277219; c=relaxed/simple;
	bh=WFFnzxaMV4Ju+SWduOY98HTaAreThCuNXT2a6cbLK6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Umo4iXPnH0b7alCsx4zdZejGstzHV3FBmaFXVrUHbdNzTm6f+sZ4gGZAsa8ewBPAPQMDMt27CIkyHIO61aKPGyXzWJg6xtPThVPyHnn9+dhFyU9j0IbdYJYNn4YJx63bNrcSJQtGZTcCFzUz/rDNKywRBVpOwyxMXLYPSniJOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmtwhwPD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmtwhwPD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E501F000FF;
	Thu, 24 Sep 2026 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790277218;
	bh=WFFnzxaMV4Ju+SWduOY98HTaAreThCuNXT2a6cbLK6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NmtwhwPD4Q/oE9wSHobtV0YWDZfNzXGObzrgdySKzvecDsPnOq00SjCWVkmiyD4NE
	 2B3Av3AQs9UJ49lduYWKYyRQyJF002+kcExTjpjisIph3Ur1QJEPguJ03GLzAKg5MJ
	 j86kXNAd9SJi3Tcx/MSnmnpVESugNya2Dki7chdJes/bF4KXIE7HEUHbFCCEJFpBN3
	 ADv/j7sYTyJVqsHKEwrKBo/u/1XSdN/1dB5VFPCsLxGsf7uQFpZSkvKLiQFzNCD31i
	 2Xmnnun0PXecT1p6KaTQ7/s5FBjiDwKOwjjzsCWtIsh53H+8RNoD6iWRhPOjXUSXi5
	 RZ0g7Z486GThg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] rust: pci: add vtable attribute to pci::Driver
 trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20260924190556.1620886-3-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
 <20260924190556.1620886-3-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:13:37 +0000
Message-Id: <20260924191338.04E501F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Peter Colberg <pcolberg@redhat.com>
>=20
> Add the #[vtable] attribute to pci::Driver trait and implementations,
> to prepare a subsequent patch that adds an optional bus callback
> sriov_configure() to enable or disable the SR-IOV capability.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924190556.1620=
886-1-zhiw@nvidia.com?part=3D2

