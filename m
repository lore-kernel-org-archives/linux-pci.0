Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978780;
	b=fJyKWPaGJegaWMhyMYuY890/fKYkYNadI4SG37Kqr/y5gkxVBrRZs03YZRUMH5qi7Wd+
	 MU8EgDOylmwdbjkmkDoZI2y2I0LDochVfg2Vno9TD9glB77icpmhIaQmoguuOwCnnCs+a
	 Xs1eliJlH32sc1dnOaHritEm5pY76287tbWuNHxMEDADxvomQ7ub1g/ficb+piw2tk1lE
	 SIuyuOT7Qs041EfkY0GdNM8UidDS/4K49HVaQJifmiuUl3b0fekxh+mkAbZv+/rp+8iMY
	 q9VDlKeCDfya3ks1Gh4Wk1LR8GA6mePii1DxbIdPNz7SrIsyvjdUZbm4r7ERx+AZfYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/TPl9ChVplaiGyF0B8jqlbC6ybnJvpP06ebzuCgtj60=;
	b=y0WI7XoG3ZUS/R902CE8DvXTI1Ma99KI0aSwSP7vPzRqC5s1/Xtcf1kozo0zUGuxDzU1
	 wnUlL5qUxe3TAL6o5qFkTFc09cBmSYu2t4AOrS0UEVeiSIn6ROOC7NXL2ST937tNHkGym
	 Mm36VSJ8QqCRzK6bJzCESlUgTcvD1tEZo7yfvhrCBT19fUGEtXRaxx/GVK21azdhRC9g9
	 uYx1e7N0Jn+Yw6GVlctq8rPRSoU491+/Z0xiLPhg0ER2rXMzpZ7X195uohuxu5tDmP2sE
	 46w0QMeIkVdpahvRkFd3x6mY7KGqGPX5Y1impMEJIyfZ3V9+6JAxiYwM2fSuZjis17A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYMQ733E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C7B606A32E
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYMQ733E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A401F0089F;
	Fri,  6 Nov 2026 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978779;
	bh=/TPl9ChVplaiGyF0B8jqlbC6ybnJvpP06ebzuCgtj60=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RYMQ733Eh/LfV4CpJwrX/tuxWCf2QBqulPRQBvuqRi1a+jB+xo+ZMdgwc+49RNfL9
	 39ptOMEsdUymr/VbE3cYNkARiPYnA698cGbwvkrEn+lg4/u+9Jl3dHt2vihAi+7oO7
	 jbeZfkqsHLt0kXoN3th+imTev+i3gPheLB6gJfYHaVcprzmh73tC2Ikfd7UOjBp3iy
	 wr2cnSsvx+K8M9e1WqVHpRzmGp5oLyusdz3iQ8G847lG3XpaFPBEmalSAJQuYXE07U
	 DR7ZjVZJvY7aEpDu59TPTxsXcPWisFbn+rFHZgNrpadLDcZDawVvOddVtrhS3yg6BO
	 89xHGWaEPnBVw==
Message-ID: <sashiko-outbox-201690@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/14] PCI: Fix composite resource sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-14-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-14-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:26:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The bridge window sizing algorithm aims to pack child resources back to
> back. With composite child resources whose sizes are not a power of two,
> back-to-back placement may not be possible. The non-aligning remainder
> placement is limited because it must be adjacent to the rest of the
> composite resource.
>=20
> Add bridge window gap size calculation.
>=20
> When there are only two resources and at least one of them is
> composite, the gap end address aligns to meet the smaller of the two
> alignment requirements. If there is only one composite resource, the
> smaller alignment may be that of the composite resource.
>=20
> Other combinations fall back to filling each resource's align sized
> blocks fully. Sometimes, smaller size may be possible but due to how
> sizing and assignment are made in different phases, it is not always
> possible to predict where each resource is assigned. Thus, the sizing
> has to play it safe.
>=20
> Fixes: 9036bd0efcb6 ("PCI: Align head space better")
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Reported-by: Nikolas Joshua Britton <nbritton@exabit.io>
> Link: https://lore.kernel.org/linux-pci/20260903063124.9316-1-nbritton@ex=
abit.io/
> Reported-by: Maciej Grochowski <Maciej.Grochowski@sony.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D13

