Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380869;
	b=CpjzDDqf6UY5cyvf/qRVTn7YSAGCww64+g3bsEGqXVMcSSxt9q4ckzkrSEvGiB0gwVvF
	 cltUIfvkljasZ1mxHKXbaLw9QnS+4LA5koBkDj9suRu4uqMA5lxCes/g6C81BnrKVGjj7
	 DXOaHx3KODAutfJ6hSx3RqkCP4goqNrCRli6s/NCZ7Pn/1Mw7Q5/pZAXCBe/gzoWMJo2R
	 nQDq8N7wGnZtwCwnNEIX46vyJTpJvzIv8A8SCyMkS+a1tz6ps7AAudCjmcwuUqXtPI3pQ
	 G/nfHMmSdJiJXkPzXySkHhhNpOE0UvYWQ3YVeBTQ074COvv/OqE5gs/aBW9VgLO6i1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380869;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=adnD/q7LfEQLXaTHnMUmb6doFCJUa+Tn5M4OwdROZe8=;
	b=4PE1Azh3GfrXW16QF+PcfMF3kTMdmOwPc56RbEzFgw1TGE92zCxwQSGHiZyY/MZYnJdo
	 KPDQmVHj4h9zhp6k7DinYEDmd0coOOwWozpsiT+3RZuSb/ak5gLIXozDHGuNHaJiAuehz
	 1kn9zxQBgTbU/fLr6TNSX2IugZn/m233j/zJSoAGbRtT8eJ0J9CLO0FK/ktOyXNApQo1c
	 Gk4JNOQEwJK8M1SkdNnG+3FFteOCZEVVLWhy4Cg5EwOLBOdiBPW+JWAX+0OIo6bRXpTWv
	 a0XPrOd8GuI6pVv5YLEXtEcQEUBTsB4ysNiXPKFfRb7wZHx6AwCoYA85XVwjmE00x2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jf93tQEu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB9606A31D
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jf93tQEu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFFC1F000C1;
	Fri, 30 Oct 2026 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380869;
	bh=adnD/q7LfEQLXaTHnMUmb6doFCJUa+Tn5M4OwdROZe8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jf93tQEu4+662Tu8wei+o4Xhd5bySeXymZepqasvGG4wfbuTqDmQsTcgfTySyi498
	 oL3EXrJtDPU+tS5WZ0NVOkZ6SbzCXHCsf5Kr4E611hmq1zOgKiYRbBDq36/2lXbadr
	 7YE/iCCzSTrQbycBjiTIxV4yD910Ccdd+0oD2zi/fqeo2gqkEKrOqYBTkTcu/KQgLl
	 0KhUxmv+DIkDCWyDrUXKHyXLbhsFj81uStwY1u7RNLHD7WTWwmDHcO/wxj4TsA+bzu
	 h1DQGgdV0ds9EwGatARix2z+5fBvAXF9Xo8vo+9VQbqlLKaOlNX3olhpHOdIQEvQ2L
	 2BFzkdzcIzA+Q==
Message-ID: <sashiko-outbox-191326@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] rust: pci: add SR-IOV enable and disable tokens
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261030171230.196717-8-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-8-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:21:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Zhi Wang <zhiw@nvidia.com>
>=20
> Enabling VFs can succeed before the driver's remaining setup fails.
> Use a callback-scoped token to return an enabled guard that disables
> SR-IOV when dropped, rolling back those VFs on a later error.
>=20
> Add SriovEnable, SriovEnabled and SriovDisable for the split callbacks
> introduced next. Tie each token to its PF and callback lifetime, and
> limit the enabled count to the user's request. The PCI adapter disarms
> the guard when accepting a successful enable callback.
>=20
> Require a VfRegistration to own final VF teardown after that handoff.
> Drivers that do not share data with VFs can register (). A disable
> token permits explicit shutdown without forcing it on a rejected
> request.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030171230.1967=
17-1-xinmengs@nvidia.com?part=3D7

