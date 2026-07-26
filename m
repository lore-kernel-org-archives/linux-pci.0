Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74F3783A1
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785103547; cv=none; b=rcsf8N7MYdLn4RsyridWiexLB4Q+HTqDqf7u1TCIfVeajS+ZB+K88TQhwq3uJKHjBUwAtwOPzjUPay9fhy34jKdGtX8hvppo68AvZ4urVWIrDdNc1sHsvkRV4qfKKO/FoB0UNm5IIy9ykhUYHUN7Uti+y6qjTUkxWJ2pRbW63CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785103547; c=relaxed/simple;
	bh=0yVVZYDi8iIF3eDbupRAFYWBqg54fUOkkxsyxGkICfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T4+nN5jbWTnNwI70ftNf3ACJLoN4jPlR/cwvv6FN7VfxMtdBuj6WvEH21O7syaZ9gFktdgrsrmGZVlqFOZDfZHp+uAzAauxtHB8hDIjqwYiAFe0oXhDAXSY9X+rIAKCOizRBoTQMJzwcmfitjlLQI6pS2O7OOqMuhdE9Dv315Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1/rMa84; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1/rMa84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC821F000E9;
	Sun, 26 Jul 2026 22:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785103546;
	bh=eIUPT6+ODKRsPFL426uNRATuCzVd4hI5OayouFRPcAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1/rMa8449LUrxL9u50NtScvGuJzrYp4BNzDw/sAhtUG4L0rya6OWZwfZKanbv7e4
	 KT9CEhqOaIUXRVoNc5VXz74WrGvFQjmh3Bh8zIuR26nwxYUS8rOmeyUkGEWOoPCHO2
	 GXaed37kZgYfio6zs2AztaJ4Nf6RKWAyNvcYSmjO+yXl+HmJnFr7JWuPBTei2ZOJGo
	 aJlZZUO72m6FirMt1xnuM+QeN8oEVusOokN859DHk9BpY+EU7/eQwZ16AZ0RNGoNOn
	 TTrtFbMondd6u+E8yqYV6EXYIHu39tc7lb/1vHd4tKhMTHt7QD2G2x02tQY/h8vJnb
	 I65SmAvJORVfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: iproc: platform: use device functions instead of
 OF.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260726215558.34091-1-rosenp@gmail.com>
References: <20260726215558.34091-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 22:05:45 +0000
Message-Id: <20260726220545.CCC821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The arguments `type` and `num` are swapped in the call to `platfor=
m_get_resource`, causing it to always return NULL.
--

--- Patch [1]: [PATCH] PCI: iproc: platform: use device functions instead o=
f OF. ---
commit 2f0a3f1eb1db2f4c07d6f4eed3d9de0ee3b5177e
Author: Rosen Penev <rosenp@gmail.com>

PCI: iproc: platform: use device functions instead of OF.

This commit updates the iProc PCIe platform driver to use generic device
properties and functions instead of relying directly on OF-specific APIs.
The corresponding OF header inclusions are also removed.

> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/c=
ontroller/pcie-iproc-platform.c
> index 4c9a0c4bb923e..abd04a05fbfff 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c

[ ... ]

> @@ -40,11 +36,14 @@ static int iproc_pltfm_pcie_probe(struct platform_dev=
ice *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct iproc_pcie *pcie;
> -	struct device_node *np =3D dev->of_node;
> -	struct resource reg;
> +	struct resource *reg;
>  	struct pci_host_bridge *bridge;
>  	int ret;
> =20
> +	reg =3D platform_get_resource(pdev, 0, IORESOURCE_MEM);

[Severity: High]
Are the type and num arguments swapped in this call to
platform_get_resource()?

Looking at platform_get_resource(), its signature expects the resource type
followed by the resource index:

struct resource *platform_get_resource(struct platform_device *dev,
                                       unsigned int type, unsigned int num)

Passing 0 as the type and IORESOURCE_MEM as the num means this will attempt
to retrieve the 512th resource of type 0. This will consistently return NULL
and cause the driver probe to unconditionally fail with -ENODEV.

Would it be correct to use platform_get_resource(pdev, IORESOURCE_MEM, 0)
here instead?

> +	if (!reg)
> +		return -ENODEV;
> +
>  	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726215558.3409=
1-1-rosenp@gmail.com?part=3D1
