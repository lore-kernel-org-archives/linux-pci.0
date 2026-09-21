Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB344F57A
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000775; cv=none; b=ordxrWZRFPO7+6BC+Ii5LKS/KigF1HyigtQoLxTJh0wYbNiByxuX7jdykmhlTS50TyAAwtkO3MrWo+OFcJriy3HGR2E77RKJIwwgI5FbUiCYnX/g+Y4sRs7YA6015B3luxXsr8ZdUkupGSb9eRWBRfWoO4zv21ZDDH3aO67sL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000775; c=relaxed/simple;
	bh=EsMYJtAQeFGw1kszjB65DxKhJgklAdJeQIi3/UPSVys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lw2vMBWWeHW/7GYBcv32irNmU1ef3aq1f5/TDC7P9+5GHsptMzSIwOMVph+avPRo0oqHCXHXeOGF3PM3rDs92kdDjZcyeDLtOAKiqlD+GA9FS5moQlQqkkXrEqw1ZBF6vt+4jmYs3GrvBzSe6CxcHPGSJjbkgIO5Ouv4EgLSJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBX79jPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBX79jPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56B61F000FF;
	Mon, 21 Sep 2026 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000774;
	bh=aFG5kH3dY7yNSbAgncSxTVO8N/eHHP1oD6mswFVL7oA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GBX79jPA0HH9fKw0b33OSDxzvEAMmh0B9mCAzkC6n85w2S/XjzHD2dYKd5tGeCHJb
	 nqbKHGCcCiLljBs2bs8+J/g5dqEbR812xaKRkrgWnQlAEJQrEE2EQqSfH5RJahOaQ9
	 INW6i09pfxvTq8CySNoGNkOaD4MA+XYDSTo9NHphImTd8jyeRWCaSFk6BL4H8BFKJ1
	 nYyTsegBCICUopB/Df0DyoGloLmiWDEmzzzCZrf72iIzyuUBKjQYUKfWwm+pM/MT1h
	 DWJAJaZa4RG9nDK5gqTZ95ixSVpKe2EEqg1BzxB/Cm4GicoQmZayrnBjMRvwoXYHhR
	 wTBDXS2OTku8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/8] PCI: vmd: Replace hardcoded values with enum and
 defines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921164316.3860312-6-szymon.durawa@linux.intel.com>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
 <20260921164316.3860312-6-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:26:13 +0000
Message-Id: <20260921142613.D56B61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] pci: incomplete refactoring, hardcoded index '0' used instead of VM=
D_RES_CFGBAR
--

commit d6af2294e28d1c964e8b78ed89f34bf845a9c3ed
Author: Szymon Durawa <szymon.durawa@linux.intel.com>

PCI: vmd: Replace hardcoded values with enum and defines

Add enum vmd_resource type to replace hardcoded values. Add defines for
vmd bus start number based on VMD restriction value. No functional
changes.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 8b59b369f1263..b7c4e22deee58 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -562,7 +574,7 @@ static resource_size_t vmd_cfgbar_ecam_space(struct v=
md_dev *vmd)
>  }
>  static void vmd_domain_reset(struct vmd_dev *vmd)
>  {
> -	u16 bus, max_buses =3D resource_size(&vmd->resources[0]);
> +	u16 bus, max_buses =3D resource_size(&vmd->resources[VMD_RES_CFGBAR]);
>  	u8 dev, functions, fn, hdr_type;
>  	unsigned int ecam_bus;
>  	char __iomem *base;

[Severity: Low]
Does this refactoring miss other instances of the hardcoded 0 index?

For example, in the preceding function vmd_cfgbar_ecam_space():

	ecam_start =3D vmd_bus_to_ecam(vmd, vmd->resources[0].start);

And a few lines further down in vmd_domain_reset():

		ecam_bus =3D vmd_bus_to_ecam(vmd, vmd->resources[0].start + bus);

Could these also be updated to use VMD_RES_CFGBAR for consistency?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164316.3860=
312-1-szymon.durawa@linux.intel.com?part=3D5
