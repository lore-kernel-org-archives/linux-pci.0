Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1427707
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368273; cv=none; b=K9+u/kZy5sNND7pRzXF0ig2i+M/7boQjcdr3lppC1yTuvg/Ix2JKFvGzQQjjMIHhVX6HmOwFKJwAHKeFHHS+5iia+Hg8UZYG6T8VB4REvV8QZH0MctIqBKQ2oItBh9ZOx9J/iCwYVE8CWDMaQ3OYU63OE+ofkkjfXn4SCErXV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368273; c=relaxed/simple;
	bh=52rkROYqXfb3L8yMJ092wXfHuV/KJ0OTV6JY9ZNFDrk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ulmMiWEUOvPfU2a6m/pnr9pxKJKCKi9H8oNtR+GnacHUhNwiFiks0Z5SDfPjH9mHSMMPr2HuBGypRSoNmJD1BxbgV44FVpbrTz6x8GGnyRs5DDmn+HhIK/mJf6vGQJAYb1K23v2eoobQ7AD3IruDihXSNjlr6lYN9xGu78mYKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSiS8lEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSiS8lEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0551F000E9;
	Thu, 25 Jun 2026 06:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782368271;
	bh=jTL2aB9l1ZiEC9WUFZyfKun4jod+6QWUEe+fe9V8+g4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DSiS8lEJf2jKBCaMsy2+oSAsNyAGITyxQCkkan9kSrncuXTSi0kYUdBb6A9Mi8bFL
	 mj2k9fEBxyW3UYgaka6ncEhZYP7Qp64Eos4WVCZyp1wb8KK1xL94nF9IePPCPfqtPI
	 uQifCg+dln7aD5RK8uavHbiYVtfwfOPi4I61id7FENRjEpHsFZh/F259Pmcj1YIvGl
	 lmrq9G6JDFbw0zKwzq5Y29f04fMUiPzcfGyRzlLRPVcWBQozI1OCxaEfCjrVvtxJSz
	 uCLHU+iN8UfXNh39VD2d05SUU9UelHgANqkkyxipy4pPDzPjARq8dP11FYVaoDlqT9
	 5p9gZCrVYXgOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/8] PCI: vmd: Add vmd_configure_cfgbar() helper
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260625082940.1290740-3-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
 <20260625082940.1290740-3-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 06:17:51 +0000
Message-Id: <20260625061751.AE0551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Destruction of SRCU struct before freeing IRQ handlers leads to po=
tential Use-After-Free.
--

commit 277c077bdf8fa22a45d1262f68f3e1a7fc357e50
Author: Szymon Durawa <szymon.durawa@linux.intel.com>

PCI: vmd: Add vmd_configure_cfgbar() helper function

Move the VMD CFGBAR initialization code to a new helper
vmd_configure_cfgbar(). No functional changes.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 070b247b3fbbe..2c824660cabd5 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
[ ... ]
> @@ -857,13 +869,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, un=
signed long features)
>  			return ret;
>  	}
> =20
> -	res =3D &vmd->dev->resource[VMD_CFGBAR];
> -	vmd->resources[0] =3D (struct resource) {
> -		.name  =3D "VMD CFGBAR",
> -		.start =3D vmd->busn_start,
> -		.end   =3D vmd->busn_start + (resource_size(res) >> 20) - 1,
> -		.flags =3D IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
> -	};
> +	vmd_configure_cfgbar(vmd);

[Severity: High]
This is a pre-existing issue, but does vmd_remove() have a use-after-free
race?

In vmd_alloc_irqs(), the interrupts are requested via devm_request_irq(),
which means they are freed automatically by devres after vmd_remove() retur=
ns.

However, vmd_remove() explicitly destroys the SRCU structure:

vmd_remove()
  vmd_cleanup_srcu()
    cleanup_srcu_struct(&vmd->irqs[i].srcu)

If an interrupt fires after cleanup_srcu_struct() but before the devres
cleanup unregisters the IRQ, vmd_irq() will unconditionally access the
destroyed SRCU structure:

vmd_irq()
  idx =3D srcu_read_lock(&irqs->srcu);

Should the IRQs be freed before the SRCU structures are destroyed?

> =20
>  	/*
>  	 * If the window is below 4GB, clear IORESOURCE_MEM_64 so we can

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625082940.1290=
740-1-szymon.durawa@linux.intel.com?part=3D2
