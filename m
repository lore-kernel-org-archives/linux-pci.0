Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7A57C9F
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 01:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784511320; cv=none; b=YQplP4oD7IezAygOzkjN/bQyf/bCYLbyxILYPvDLmDsWwiJUQD+A+Bd2zSv6FIHN9f+gR8PYxTvuBPc5lR0sWACqQUe3GFmP16MFhDZGb7j7lEFXEbX4Zqzw20w+cbUH11jGKqYbYX3wwS801xoJiy6DjVDFsGI77lXIdxJC8nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784511320; c=relaxed/simple;
	bh=jQOwMtIjdMVWWA8jKqVZbuKycHb0HmHFPiKugmVsILI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f+nP66n2pncvawFhLaSaoqd0YPQ/0smI63Tf5qdP/fEFrFV5B3ttr4lTw0ICyEt9c3a4pilNRZjBiEuZZZsLt4Y6XR0CJoqjmYMtTUFoGYqbikuUwfGNmZaICFnJjRGyyXmKminQP5ALcEvx7er0KMM9lTIaZ208TpdcDHUrkyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a19Vvdm5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a19Vvdm5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2C01F00A3D;
	Mon, 20 Jul 2026 01:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784511318;
	bh=jQOwMtIjdMVWWA8jKqVZbuKycHb0HmHFPiKugmVsILI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a19Vvdm54cWLIwQlB+9Yd/ld1ycF98/slWTcoT3k/go7APekB1D9qJKwFuWeUPIDs
	 bjkoKwiBj6GCEcEWfsBZqeopD6MpRg5bu1uKz+0q/IcrxywTQt5o/4++D5LcYGASbO
	 4StrwGAPJLoKq8YsxpuTnuPTYDFjl8o885UPtPu/Xn9ALq6B6G8dIvXDJddi9bLc7W
	 LuS9gxD0i02v/3z5gK3dP5AhrAUtU51Z2x8nM0Lr5F6yfHo8EJmXbI0JEog+57p9W2
	 ypBDzptGBAjcBxIV7PgQ3pgyRMT4Fy7fJG4A+fWqieg4VT0GzZxovJiIAadtRHrTd0
	 bJzzS23Ppc9Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/P2PDMA: Fix use-after-free in
 pci_p2pdma_add_resource() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Lei" <leixiang@kylinos.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260720012109.24164-1-leixiang@kylinos.cn>
References: <2026071700-chitchat-uninsured-0767@gregkh>
 <20260720012109.24164-1-leixiang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 01:35:18 +0000
Message-Id: <20260720013518.8F2C01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In pci_p2pdma_add_resource(), a devm action is registered to call
> pci_p2pdma_unmap_mappings() with the 'p2p_pgmap' context. If the subseque=
nt
> call to gen_pool_add_owner() fails, the code jumps to the 'pages_free'
> error path.
>=20
> In this error path, 'p2p_pgmap' is explicitly freed via devm_kfree().
> However, the previously registered devm action is never removed. This
> leaves a dangling pointer in the device's devres list. When the device
> is unbound and devres is cleaning up resources, the unmap action will be
> called with the already-freed 'p2p_pgmap', resulting in a use-after-free
> bug.
>=20
> Fix this by properly calling devm_remove_action() in the error path before
> freeing 'p2p_pgmap'.
>=20
> Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through=
 sysfs")
> Assisted-by: Antigravity:Gemini [tools]
> Signed-off-by: Xiang Lei <leixiang@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720012109.2416=
4-1-leixiang@kylinos.cn?part=3D1

