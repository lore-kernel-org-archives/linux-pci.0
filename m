Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8481ACED5
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639473; cv=none; b=r/yhwQCPdfzLaQ/y6zdO4sDFTMRvCCk3hXAdzgXuQMfLE8LkrFcToLGd69DLrMG3rcZIHmE4IFf3g5VmIYetzAzKFhn7QlET7KHgypjAAxBXKM6+rf0pkuUsB5vdIi5/GZPPLaehcBDLQ4UEkQaS6GqCnoqoqFPG6Xt/fDHf4/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639473; c=relaxed/simple;
	bh=KjZrP57ZU+DM3j+jGBhwPMmD35cCb2vxUh+Ws1UXizM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ln2uH7HNIEQ7kl3BxLjQBKA4PqhMMaV9y3baga/cJWFZCLgUJRrL1UcF8X3MrBqbcimKS7Zcgc+5eKvrbLMaHC2x7zHO1FxXJB2yAgiPmI3D9GKITuimiPSMcEAwUHG7bBoApnmGtdONcw56tdZKIHkI8YKgxkejLeJZDAPCpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2BG0jY4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2BG0jY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453D41F000E9;
	Tue, 25 Aug 2026 06:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787639472;
	bh=KjZrP57ZU+DM3j+jGBhwPMmD35cCb2vxUh+Ws1UXizM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R2BG0jY4RddYc7BWKHoxL4TazT3xOo6mB3i9rS98jXFltWr1ZP8QRuk1hasKxvvDh
	 W/8zvEbcA5tLp6KREgyZx+mTkRoSXWDBhq3cjhm2WI0K8MzOPkj4xqslq5qHyKUsQF
	 1hBZlETjR5YulW/HAaEYgjBaGHmbOfXQSblJWweN7iLgxFqeqAraFP4+zhUPqVuxTX
	 ZXFEln3n1h4rvCp0WiB+OppdkinKGKABdPVfeIWKeSLJnZhF9v9n95O689F/6BVFXQ
	 G1MbGDN9KnxxVpk+vVGVFxGTEprf6eXQY1jLpgZJOrBqzD56bkD8LrrKVBDR2SSKWz
	 PgrhMP9k5OYLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] dma-buf: Document how exporters and importers agree
 on mapping lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 06:31:11 +0000
Message-Id: <20260825063112.453D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Pinned, revoked and movable mappings are selected by which optional
> callbacks each side implements and by whether dma_buf_pin() succeeds,
> not by any flag or enum. Nothing in Documentation/ says so, and the
> rules are spread over the kdoc of dma_buf_ops.pin,
> dma_buf_attach_ops.invalidate_mappings and dma_buf_invalidate_mappings(),
> so a driver author has to know the symbol names before finding them.
>=20
> Name, per flow, the callbacks both sides have to implement to end up in
> it, describe dma_buf_pin() as the runtime negotiation, and record that
> the pin is what tells a revoke from a move.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-document-d=
ma-buf-v1-0-5ecfb3e1371c@nvidia.com?part=3D2

