Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9707D531
	for <linux-pci@vger.kernel.org>; Sun, 30 Aug 2026 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788089091; cv=none; b=EHoz+J51B0XgO01216Ul4QJ0KtBgWKSC9o3xR3ziyC8KF+j/gHeAM+I8Jz4RPP2MgN5lCF+BcgJgqJ28gA9cpAU/3DhNhjNsnzFALWA27WGrYZxyc30haVRq4fWiZv6JvGzptG23DnUy35Cb7P2B21iZTqaSm3mhLjatvUDpzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788089091; c=relaxed/simple;
	bh=dZOlXAKP20WmbMVwqvy6oErPfVVrn7Jjj2kNGtWDmn8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lWnwfbbrYhf1EvrYi7IQz8uUpUeeiKom3CyC7HQaNNGhPgqGEWvGRcw58M+WsqrzoCZvG9VvZWfXS9iSQSCqx3jbHPF8IJf/POMCdpLcbggC8N2pT6SsPejIPILlwcsSpBJI/1RBRxDrTwDXuXJYIGuC/TP9/aseOYgkdSJNMiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdWiotah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdWiotah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C511F000E9;
	Sun, 30 Aug 2026 11:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788089090;
	bh=VW7QpYzJmBkFGqihThW1bacAk2krinFbf2M4VxEpHKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdWiotahrIrz+XRTaeCrTwdJMZCPx3/X1psgPT43vowrBSr4MpP1CxACQDA3O8JJT
	 Ryv9Kj9UZzAmeDxSO9EngzVLLGeAxXN5Ss+SRQ53NzWYaoyRX8LmgtAMPicHMPMurf
	 2UTe7MigpA9ItdLVu+rU6Sz9BYbSoVKN43VfulYcOUNW0VGIMNxL/vokmiCThru0rA
	 gG9KKujvIja2QwqM0QX67aOsPR89BINEIr2WpELcUIC3qCFE8xb8I3LqBAGDcFRrjR
	 17PpTrPEFVCWdps4dHeZCzDbxCrxoG2p0Pxxe+hPknDxBgb47UrQ+tq9xtyCtzAL7f
	 eW9VKFxcXotAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] PCI/P2PDMA: Do not tear down the allocate attribute
 on registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260830-batch-p2p-fixes-v1-1-5044e8dfbe2e@nvidia.com>
References: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>
 <20260830-batch-p2p-fixes-v1-1-5044e8dfbe2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 11:24:50 +0000
Message-Id: <20260830112450.84C511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> pci_p2pdma_add_resource() installs pci_p2pdma_unmap_mappings() as a devres
> action with the devres allocated p2p_pgmap as its data, and only then adds
> the range to the pool:
>=20
> 	error =3D devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
> 					 p2p_pgmap);
> 	if (error)
> 		goto pages_free;
>=20
> 	p2pdma =3D rcu_dereference_protected(pdev->p2pdma, 1);
> 	error =3D gen_pool_add_owner(p2pdma->pool, ...);
> 	if (error)
> 		goto pages_free;
> [ ... ]
> Fixes: f58ef9d1d135 ("PCI/P2PDMA: Separate the mmap() support from the co=
re logic")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-batch-p2p-=
fixes-v1-0-5044e8dfbe2e@nvidia.com?part=3D1

