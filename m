Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA4371868
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046554; cv=none; b=YP3ZuM2gyHgyETVF3sJH+t/cbsgvoYhHWZ0SiGBuXt0/Oeho0bZpUjRacCm2LDQga37mLaFYENM1gz8/DqkB4EpWCiqWCFz8zTSGUOVIgQ10iggLGRPdc+jyvOYVSgfm9EqIZAxJvhHwhcKqnItfWiPeUmozdueJepVCWHvLubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046554; c=relaxed/simple;
	bh=TZA4ocOM0F3Zg4WwdF3ep6AkRsIUJta/PiuTP5vbn6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B13bgxz/9t3WXxofLbuZy2eoO17zB+55Ql0eXMyqeTNvfTpVKgveuCAvP5S9u7RDFmAgwLLLj5cIRjGLv73bfBQg1DAOPs2faUa/NmfdRvljPuJ042D/D+Toup/z1afF7/I8MNui3jpLuAbi8Ne98gBWbmIEvrinEjAl7XM59hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgpqn6lW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgpqn6lW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2A11F000E9;
	Thu,  6 Aug 2026 20:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786046550;
	bh=vQszuEPxs3Uvew1Onl6PlgaJk8J/SApGC9VL/yoeTLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hgpqn6lWrlJakUPclFo4hLnxWRdd9KOqESgjYuBa6h68NWhwJW3ij3M5MWQM0p6ZT
	 /xGIAlJy3uc2OCkLs7wT0lmGm4G7apI3yIhdeLbSxMKcdPL+MsVbkI5yRcEdNZ+Q5M
	 NCG1X3oney/3Jjb8sRUBMCGXuXqsV9xNNb0kY58cf8zF/wDNxYWbRQazde0jM42SNP
	 y5RrsitjC4DzdZEFMCiZVoBPLDv13PITKLQIomNmw1qF2TFhmuaavijxQHh1ibFuq4
	 KYJh1UTeYx9skRzBfFid2sTmp1TbPeicTDvOHXT0kgt8MbSK2qSCn+6LunDygv3Yii
	 Hsr+9Cv4BZtBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/8] PCI: vmd: Add vmd_configure_cfgbar() helper
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806221351.38592-3-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
 <20260806221351.38592-3-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 20:02:29 +0000
Message-Id: <20260806200229.DD2A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a missi=
ng explicit `pci_free_irq_vectors()` on error paths and during device remov=
al after a successful `pci_alloc_irq_vectors()` call, violating PCI subsyst=
em guidelines.
--

--- Patch [2]: [PATCH v6 2/8] PCI: vmd: Add vmd_configure_cfgbar() helper f=
unction ---
commit bf3d098aa64842079a8c08e82a92ab1a8a2d4175
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
This isn't a bug introduced by this patch, but while looking at
vmd_enable_domain() I noticed we might be leaking IRQ resources on error pa=
ths.

Earlier during setup, vmd_alloc_irqs() successfully calls
pci_alloc_irq_vectors(). However, if an error occurs later in
vmd_enable_domain(), the error paths exit like this:

        pci_bus_release_emul_domain_nr(sd->domain);
        pci_free_resource_list(&resources);
        vmd_remove_irq_domain(vmd);
        return -ENODEV;
       =20
Should there be a call to pci_free_irq_vectors() before returning to avoid
leaking vectors and potentially exhausting system IRQ capacity?

Similarly, the device removal logic in vmd_remove() also appears to omit the
pci_free_irq_vectors() cleanup step entirely. Does the driver need a manual
cleanup step here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806221351.3859=
2-1-szymon.durawa@linux.intel.com?part=3D2
