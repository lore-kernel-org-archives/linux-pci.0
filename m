Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA291D86E4;
	Tue, 30 Jun 2026 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818616; cv=none; b=kjqr/lL/J7P9gEbYCc77/7KGvK6K6zOcHGPXie6uSeH/L79NZ9PxN5FVbtLt2DD0cwnK3xqWxntdrxX9zlNzYIBZUm4cxKYE1d8ZZVrbLvkIbMdlXGuEe5L5FCUrjcYqUttwwHVfN1/uCZ8gDTOYWN4d/QSd/l6hFnbN2/6sMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818616; c=relaxed/simple;
	bh=PpfuVb5CLjscV5hz1E6W80Bh5+R1wIAPY2fKA3JaT4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=td0J9KME1JAQc/Sej178/riyVwFUTccrfYKUTw/qFE0SDfHAl7aKRxSGBM0V4HUcpvxDzwTJTJlO7BWxg8NbRPHcs+0Gl8HJNgCHcNU6rPY42SlvOglo9+Ob4unLR4JVTarhtTIJiQhRENzBl6IfGW1WEqCUTyHurfoWZOaGUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQra21i0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQra21i0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0151F000E9;
	Tue, 30 Jun 2026 11:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818614;
	bh=rxuHCf5VdGpp+3/4HSdb3+WgTy7wezIGoS59769/Z14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mQra21i0bD1ERmp3XGAmWgFwKVZsmo6WEpxy/j9OsETQFdMgg6NCo/nGl1ffWUQE4
	 M1XalOtqV98o7rDtejd9tgbUk0fzJlclvtMjRC6S2MffTtFRDGE3vK9W6omR48HfdB
	 n8SpcFmt9StMJAVtF4D3UMzhmYHYvO89EFFtz4c1wnOkGbnhFZldEYb7aXtmQFoqwQ
	 XZhv0uuBbkORxDp3LQAndRxTLiJFnba/kuFwxC59U7cmu7WH4vz0fP2lsceEO/4sDP
	 CImE0s7fHDi1HzK3SUgifYzSgmXKOKJ9xfCVB3aAsfsQTKERtaeC6dAK/peU6Rk2z7
	 O8ZFW8cpUOfDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/8] PCI: of: Set fwnode device of newly created PCI
 device nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260630102804.413563-8-herve.codina@bootlin.com>
References: <20260630102804.413563-1-herve.codina@bootlin.com>
 <20260630102804.413563-8-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:23:33 +0000
Message-Id: <20260630112334.5D0151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Dangling `fwnode->dev` pointer leads to Use-After-Free during PCI =
device or host bridge removal.
--

commit 282379de7d271ef07bfe62ea73e0c684092059cd
Author: Herve Codina <herve.codina@bootlin.com>

PCI: of: Set fwnode device of newly created PCI device nodes

This commit sets the fwnode device field for dynamically created PCI
device nodes. This ensures fw_devlink uses the correct PCI device as a
supplier rather than walking up to the PCI root bridge device.

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index ee9eb384b377a..eda14cefca5e7 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -709,6 +709,13 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  	if (ret)
>  		goto out_free_node;
> =20
> +	/*
> +	 * Set the fwnode device in order to have fw_devlink creating links
> +	 * pointing to this PCI device instead of walking up to the PCI host
> +	 * bridge.
> +	 */
> +	fw_devlink_set_device(&np->fwnode, &pdev->dev);

[Severity: High]
Could this leave a dangling pointer in np->fwnode.dev resulting in a=20
use-after-free during device removal?

When of_pci_remove_node() is called during teardown, it executes=20
device_remove_of_node(&pdev->dev) which clears pdev->dev.fwnode early.

When device_del() runs later, its standard cleanup logic relies on the
fwnode pointer still being intact on the device:

    if (dev->fwnode && dev->fwnode->dev =3D=3D dev)
        fw_devlink_set_device(dev->fwnode, NULL);

Since pdev->dev.fwnode is already NULL from the earlier call, this cleanup=
=20
is bypassed. If any reference to the OF node is held after the PCI device=20
is freed, np->fwnode.dev will still point to the freed pdev->dev structure.

Does of_pci_remove_node() (and similarly of_pci_remove_host_bridge_node())=
=20
need to manually call fw_devlink_set_device(&np->fwnode, NULL) to clear=20
this safely before the node is removed?

> +
>  	ret =3D of_changeset_apply(cset);
>  	if (ret)
>  		goto out_free_node;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630102804.4135=
63-1-herve.codina@bootlin.com?part=3D7
