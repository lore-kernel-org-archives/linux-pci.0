Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FA2DECA1
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368341; cv=none; b=BdU0o1CRTcPS9eOB45M8uif0Bf3xpYFahrGbsWYxavw7Mawmsue+dvuJ/6kGY+TbDScj5de/lMQYnuYZRS0NGV2OhjYREAA+doen6BoJ3bprI3WSFH2KAlbigkb7nKjlSj/awaToI/CRhjCQ9bLuVvcUhdoQZn1UkeoSkvfZjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368341; c=relaxed/simple;
	bh=2MpQ2gfuQHTXRsMy0HV8eDlbt8tY/S0npk6/2Yt0JgU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NMaS58IgaK1GDnVcX9bx5gs5OeyuaGTBwKSgpNj2GYUy5Q3eYjG4O1t8lJLWbAKip5UOuftKoR8puTTqZoLJiiEjHNQbc2eaKxawsiCKVoFjWtVjIoqTAki9RiyiMS46FZbQUux4vy1cSbMSvw5YxzKAi0NUwqACWc3QWUc6pxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhgqzPYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhgqzPYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10671F00A3A;
	Thu, 25 Jun 2026 06:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782368340;
	bh=UVc8X77M+aFW0wm3EHXhiKJx02q2w0DR4J5uJ/FacHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WhgqzPYiAdyxqqra+37A9V9vgDVKZufeREGcHAsGpLd7u48Gz2Ug9/3zS0QiDYSxz
	 DTBqjQ7nGMMMyC3X5ogWFayaC8a6MzZPJufSePPgSlwgmo6kMDP3NTtSnAiU3kOlqc
	 JO0mvF9oB1pn5m2d/nKXxlFhEwXM5NgQkRQYxW3Kd+/aSO7ZcL1GfB68+qItl8cx2l
	 /LeTLnxkc3U5NeJe6uWw5rGlm/n2xZsvhOKPzvPuqfIiiXh6iYAN3WBSv7hvn1v9qo
	 WCrSNCTvxI0eip8tyIDNjGlD3vn7yBLqxZ3L4Q5mBq5u7XCbPvU4yzKYJRV7M8L0zI
	 oQo5T2UJsf82Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/8] PCI: vmd: Add vmd_create_bus()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260625082940.1290740-5-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
 <20260625082940.1290740-5-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 06:18:59 +0000
Message-Id: <20260625061859.D10671F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Memory allocated by kasprintf for resource names is leaked on vmd_=
enable_domain() error paths.
--

commit 1ab8bc19707a3b648b92906666ae290aa0884407
Author: Szymon Durawa <szymon.durawa@linux.intel.com>

PCI: vmd: Add vmd_create_bus()

This commit moves the VMD bus initialization logic into a new helper functi=
on
vmd_create_bus(). It aims to simplify the domain enablement code without
introducing functional changes.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 443a0cefb7f74..c0a953df5f238 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -968,25 +994,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, u=
nsigned long features)
> =20
>  	sd->node =3D pcibus_to_node(vmd->dev->bus);
> =20
> -	vmd->bus =3D pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
> -				       &vmd_ops, sd, &resources);
> -	if (!vmd->bus) {
> -		pci_bus_release_emul_domain_nr(sd->domain);
> -		pci_free_resource_list(&resources);
> -		vmd_remove_irq_domain(vmd);
> -		return -ENODEV;
> +	ret =3D vmd_create_bus(vmd, sd, offset);
> +	if (ret) {
> +		pci_err(vmd->dev, "Can't create bus: %d\n", ret);
> +		return ret;

[Severity: High]
Does this error path in vmd_enable_domain() leak the resource names allocat=
ed
by kasprintf() during the earlier memory bar configuration?

If vmd_create_bus() fails and returns an error, does this early return
lack the necessary rollback logic? Could this leave the previously
initialized bus active while its sysdata pointer (the vmd_dev struct)
is later freed by devres, resulting in a use-after-free?

>  	}
> =20
> -	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> -				   to_pci_host_bridge(vmd->bus->bridge));
> -
> -	vmd_attach_resources(vmd);
> -	if (vmd->irq_domain)
> -		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> -	else
> -		dev_set_msi_domain(&vmd->bus->dev,
> -				   dev_get_msi_domain(&vmd->dev->dev));
> -
>  	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>  			       "domain"), "Can't create symlink to domain\n");
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625082940.1290=
740-1-szymon.durawa@linux.intel.com?part=3D4
