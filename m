Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987257;
	b=J20x/4l8m0pVYOGpEMhlEBqYDJkzfhu01AqCAFgGvNbRK3wNDYXpQsn8yTJEk2wtQUcn
	 gLDPRzxEoGKwu9L1OfrmrUPDfNr4iFnp/coAilfUdNGY4Qx7/pXJPJoVOrrJKMi2+yNwT
	 8weUr21I6gL+lMHSr07U0457jE4DDZlEKFuK1C+echBTfUurvFGqZFMj2RrsywxG3VgXm
	 rLxKUcIF/XLmUdxfG+R7P4JcEFjSC3+NhJiheK2rg1u91wiNOC5MCmalCIcnVctjmiBVH
	 f+ikw+DK2VkptQLju+ZCTsQl9/D20+H9dgmar0Fv5V5EKykgydJAGT5aTeHAr9tiP+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987257;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f4PEmA+bT59NE6BGALJSFH8WxeZO618e7fk+Xi4Yk/U=;
	b=Zq/LmVQaTvub44n5LvYTq0MDUESeV+ZCxfcLf3Fcja4jOhhTHq833YjZO3rRZjvS2aZr
	 sROxuANYUXX5Q950Sc2ByTJqY2HZf/nHak5CtIfLGRVqEdg1pcX902BiLzEitNYqgi4pj
	 kxGRdfK+N4wI2dgHUmPCZRS/Sa9EarE2bRKwI5bXygO4HExHGtocSUgB7MrHpIhzLoxy7
	 tAnGalUucptL1iACiwTSoQYFkjuy4qCLjin7POMp5i5nKdccpQ+58wnVtvMCih4AmcczG
	 rgPvbPe67+kUkOP4xiWwKVFgai2KZORaFEJh4yZoJWU5g6iOFevR71TOtufNjbVKvig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+V2CGCc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621E606A329
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+V2CGCc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA591F008A1;
	Fri,  6 Nov 2026 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987256;
	bh=f4PEmA+bT59NE6BGALJSFH8WxeZO618e7fk+Xi4Yk/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+V2CGCcdVdY4lGY98zitL2/oe2L+jAlvzSLdxKyVN3W1qcVpLfS/8K/NZTVs53BB
	 szoOfwoC1EGoYbw2Al/PgpjyDeYJdZB/lnsH/CkoY7lLp2vJZxGfAjIdXgjuOVDYZ/
	 VpcnyE5BYGGNLQb/l8FqyXRMXMoFGGPx1cd9oalMU2M+h26rqit03IWMx2NpspmtLu
	 rL0pCD3C2boCgZQ2PzE0l+eOVn2hW27vEMoYnEi1Vo9lTmO3dzJyfCtwU/qmkaH6IG
	 sA/bLrgZPsz1ytarD/DXf0SxdTHnbrh+Lkyn4TF04CwSUkyY5hJfAcKbHNRnEeXGBH
	 rE8KpFPd9h7PA==
Message-ID: <sashiko-outbox-201967@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-X
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keith Busch" <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106173448.34794-3-kbusch@meta.com>
References: <20261106173448.34794-1-kbusch@meta.com>
 <20261106173448.34794-3-kbusch@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:47:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Keith Busch <kbusch@kernel.org>
>=20
> Skip the read-back that flushes the MSI-X mask write. Parent domains
> that mask on behalf of PCI/MSI keep using their own irq_mask().
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106173448.3479=
4-1-kbusch@meta.com?part=3D2

