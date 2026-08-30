Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558E3ACEF7
	for <linux-pci@vger.kernel.org>; Sun, 30 Aug 2026 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788093260; cv=none; b=Ovyk03nwhVrf8yOnJsXDrgP6LTclFrpBcGbnrSei7sN1UNXheJUtIPP+BZbuA0LgX7gXDjosr0hFz3OBBNANM0/7mN52jcp7B8Ltf6Ypk5o5w49RSXTj5yrhbgfMIcgMyseBFqzm/suuPlyFzsYURgHHEXRhZvmu1sYukuW+KZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788093260; c=relaxed/simple;
	bh=f76UOAz1THYiLFWjxR64iI63dgAFMOq7QkyjQYHPHhM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BOjfxw39zIj7+g28oPd/cZfJrfYDHZ4vs0yrzO47SUFuncSuySGcqgihLftbNitZtRo7G8In4sYkf82FXBBZOFGqAN/LP7BR8XblgfVrGBkP9QUXxhxtxeRp9QoLui0v9+JDPrqeUE0k70nFWbvK9q5t3OVG4QxbBhRIE8iNdjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b32pTxlA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b32pTxlA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2FA1F000E9;
	Sun, 30 Aug 2026 12:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788093259;
	bh=f76UOAz1THYiLFWjxR64iI63dgAFMOq7QkyjQYHPHhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b32pTxlABkYLl3zMgll0LLmKs64+lkOYSZAbCN90f0RRufHwrlQ3p2khDZl417WkT
	 OKcDM5EExWNSZw6S6mDF8mFRkNVomx40SBKgE7d8b5kB3iSeHHUgUMx5N9b4yxkNOz
	 FFHIVTooNuongPN5iaCfvqZehKDWg4Rjf1qkmi60GinuilaV9tkC5i0mxizKBYguTt
	 KX40a4wgJ+I0qdjondPXfn01dz24qvWu8iDhVNuEhaJNYvAnihmyuSZDkxbMrDUu3Y
	 XNQqZbLfiJMhjs/K8FXcDu9nMYVgzwM3xb655/O9N+JJOoxz5EMFLAspm1nEoBbOXk
	 dkmP1sd0kfX1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Update DMABUF lifecycle docs after
 move_notify() rename
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260830-doc-p2p-move-v1-1-61a388620588@nvidia.com>
References: <20260830-doc-p2p-move-v1-1-61a388620588@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 12:34:18 +0000
Message-Id: <20260830123418.DA2FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
> dma_buf_invalidate_mappings()") left the DMABUF section of the P2PDMA
> documentation pointing at move_notify(), a symbol that no longer
> exists. Readers grepping for it find nothing, and this is the only
> place in Documentation/ describing the revocation requirement.
>=20
> Name the current function and record that importers which cannot unmap
> within bounded time have to be rejected at attach time, which is what
> makes the synchronous unmap on remove() achievable.
>=20
> Fixes: 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to dma_buf_in=
validate_mappings()")
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-doc-p2p-mo=
ve-v1-1-61a388620588@nvidia.com?part=3D1

