Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3681E3AFB07
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322998; cv=none; b=ecGXPxYKN/AgDKXDpDlSJlMw8lori42ciMRDmp/cFVm8+C6Tqo0FwbfQo6b042BpPpGA6U4SPnyz7hBhvIJgoi+JNuWAC8HHFHQSHlxLYnyVAaHioAA64mrBPwa2b9W+qj+YN3LP2hzrW3QRD8D8jaup+KWPgaiCiFNCVSixsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322998; c=relaxed/simple;
	bh=7NInHBMrIsJufvzbvDyH1jZvK1yfWx/8RbKjct+EOew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LHGccJmJtjur6Rk+ViUnckJaEqPJpWsiclqZ0vmI5t7741K+GGzSb5jLsw9IZ82Qv/7tFr2veVSUDPNn/sYBOAmh82dD4rfUd4Gl2oCST40Iy+VAo/8K5ZVvOogvtOgyqJ6Q+nNDKcLYreWIifEJEJg3u53yIivPqBKUKq5xUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZa3wXl5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZa3wXl5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00F01F00893;
	Mon,  1 Jun 2026 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322996;
	bh=uREsGMgCgere+Hmoqzrr5NCOMOYh8X9BziLHIotCS58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bZa3wXl5vFxJ3K8tYJ6V5HGrAIptSETr5WCb7RE9NwtEN1abEefK2FnIHg9gd4EfC
	 jHIGdbhpop/1+2ooVXzSssxUKdQTJoE6c28/7fKcsDd+6fw3fbO8uFgqMXJTso3KlA
	 sNnKfoG0wYjxiG75GzeRfYAeQfJ5dEs50gb4LWOawRIdGLIlj/jB0ud6PzZVCSNOst
	 sjS/8CpuuIHw1n22YLvNjSx9F2L8ErNNk6VmUmHGJdY8QUvhmOajK24TQ/nmXrlt9Z
	 T85TNGxnNh7cFH4MCX+z39qfe83AKxiil3UUH4LabT0JWNz3LP1c+MZN/9R3e/GWlj
	 mJVE/wFGMSkGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] iommu/amd: Clear DTE with update_dte256 in
 iommu_ignore_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260601134204.2150602-3-praan@google.com>
References: <20260601134204.2150602-3-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 14:09:56 +0000
Message-Id: <20260601140956.B00F01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Calling `setup_aliases()` before clearing the primary DTE propagat=
es the active DTE to aliases instead of safely clearing them.
- [Low] The variable `dev_data` is used in `iommu_ignore_device()` without =
being declared or initialized, causing a build failure. Note: I found the f=
ix later in the series in commit 'iommu/amd: Split probe error paths to pre=
serve IRQ remapping'.

Pre-existing issues:
- [High] The patch leaves the hardware torn-write vulnerability unmitigated=
 when `dev_data` is NULL by falling back to unsafe `memset()`.
--

commit 57abff52ae96ef6d8a5ffe516b907b27e8c51040
Author: Pranjal Shrivastava <praan@google.com>
Subject: iommu/amd: Clear DTE with update_dte256 in iommu_ignore_device()

This commit modifies iommu_ignore_device() to use update_dte256() instead
of memset() for clearing the Device Table Entry (DTE) when dev_data is
available. This aims to prevent torn writes caused by the hardware reading
256-bit DTEs atomically.

Link: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.o=
rg/

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -750,7 +750,16 @@ static void iommu_ignore_device(struct amd_iommu *io=
mmu, struct device *dev)
>  	setup_aliases(iommu, dev);

[Severity: High]
Does calling setup_aliases() before clearing the primary DTE cause the
aliases to receive the active DTE?

Looking at setup_aliases(), it invokes clone_aliases() which reads the
current primary DTE and copies it to all alias DTEs. Since this happens
before the primary DTE is cleared below, it appears the aliases remain
active with the uncleared DTE.

> =20
>  	pci_seg->rlookup_table[devid] =3D NULL;
> -	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> +
> +	/* Clear DTE if we have a live entry */
> +	if (dev_data) {

[Severity: Low]
Is dev_data declared in this scope? It appears this will cause a compilation
failure since dev_data is evaluated without being declared or initialized in
iommu_ignore_device().

I noticed this build issue is fixed later in the series by commit
'iommu/amd: Split probe error paths to preserve IRQ remapping'.

> +		struct dev_table_entry new =3D {};
> +
> +		amd_iommu_make_clear_dte(dev_data, &new);
> +		update_dte256(iommu, dev_data, &new);
> +	} else {
> +		memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));

[Severity: High]
This is a pre-existing issue, but does falling back to memset() leave the
hardware torn-write vulnerability unmitigated when dev_data is absent?

If a device lacks dev_data, such as during failed initialization, the BIOS
or ACPI IVHD table may have already established a live DTE. Executing
memset() in this state could still cause a torn read by the active IOMMU
hardware.

> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601134204.2150=
602-1-praan@google.com?part=3D2
