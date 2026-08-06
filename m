Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB6471273
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016467; cv=none; b=dkv/q0ie480sO1a5fkkj9zldzwj0J76CNQNjWW9Dzi09xw4S3IWTUzSwk6O6kcxIc+sIMPxwIbisrpoUl9zG5g0Kzw8j5exWYabuRArlkUIlpxi0Qe+Y7c7xWGcoa3LERBn6ZhMmu9s+bhiucP3DoPxBZePBwvDLGo7QytZ5idk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016467; c=relaxed/simple;
	bh=5OxdxOliB/z8ocGMy/zmk/IUKpzPFd6AwpzfJxrPA2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ouN3nR6ZUvyn4P2kEZSn/36awIZNFQX4ZLGMaqmzzDm+UdfbyC4D0Afa2hZrD31HhVgk6QbtOYOkkGi9irZD0BKzWKJCqqVbiKFmguOhTcOj0Mi6scu7VPayt/9bboaC/b/ij654K/7akC/s8S+Oy0JhPkXB0H/N6824XC//rzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOYr0ork; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOYr0ork"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5951F00A3A;
	Thu,  6 Aug 2026 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016456;
	bh=ypO8s/dvnirUeVNaprQ9d+EhRe30BCwi+Jb0NcVAdGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KOYr0orkAYSmXGBdkbQGFzD8Ja1N66tKqV+xzhD/Ws6lQulMYKXvWBmOd0luzuX0i
	 ZD30opKKWyQ4iSvMXjIToAHs8OExTlx39OoFBTMaZo0l9MZ7Rxw1YwXKRP4yMMfFRs
	 A9RHbqHHKfmurlgBMaX6UMOltE8DPnEOWzdtov8dE7zizAXSz89Kt2wvQRJieDnBVW
	 F3vn/Jr72bEF7LzoKXzCh8090W7kXkm0vNkXR00lnbFPZ+jaR+XtmZACSx0wg/Wljr
	 2iCRIlO+r9JWj7+PqH2Nm09NzYIfbq5esJSGmfuHUe8vHKBdW/c7nFUeogCqLkv2dE
	 o1GKcmb58+KyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/13] PCI: Account for ACS egress control in
 isolation checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-6-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-6-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:40:55 +0000
Message-Id: <20260806114055.DB5951F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked PCI configuration reads in Intel SPT PCH ACS quirks lead=
 to hardware state corruption on read failures.
--

--- Patch [6]: [PATCH v2 06/13] PCI: Account for ACS egress control in isol=
ation checks ---
commit 99c1da7ad98e7bc62ca4515768fee9a8109e4739
Author: Leon Romanovsky <leon@kernel.org>

PCI: Account for ACS egress control in isolation checks

This commit modifies ACS isolation checks to ensure peer requests cannot
bypass the IOMMU when Egress Control overrides Request Redirect. It also
updates the Intel SPT PCH quirk to gracefully handle configuration read
failures and properly enforce isolation rules.

[ ... ]

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index bb4c09cbbd10d..ebfe902b01182 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4990,15 +4990,21 @@ static int pci_quirk_intel_spt_pch_acs(struct pci=
_dev *dev, u16 acs_flags)
>  		return -ENOTTY;
> =20
>  	/* see pci_acs_flags_enabled() */
> -	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
> +	if (pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap))
> +		return 0;
>  	acs_flags &=3D (cap | PCI_ACS_EC);
> =20
> -	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
> +	if (pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl))
> +		return 0;

[Severity: High]
This is a pre-existing issue, but since this patch adds return checks for
pci_read_config_dword() here, should similar checks be added to
pci_quirk_enable_intel_spt_pch_acs() and
pci_quirk_disable_intel_spt_pch_acs_redir() in the same file?

If pci_read_config_dword() fails in those functions, cap and ctrl are
populated with 0xFFFFFFFF by PCI_SET_ERROR_RESPONSE(). The subsequent
bitwise operations and write-back will write 0xFFFFFFFF (or 0xFFFFFFFF
masked in the disable function) to the INTEL_SPT_ACS_CTRL register,
setting all other writable bits.

For example, in pci_quirk_enable_intel_spt_pch_acs():

    pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
    pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);

    ctrl |=3D (cap & PCI_ACS_SV);
    ctrl |=3D (cap & PCI_ACS_RR);
    ctrl |=3D (cap & PCI_ACS_CR);
    ctrl |=3D (cap & PCI_ACS_UF);

    if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
        ctrl |=3D (cap & PCI_ACS_TB);

    pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);

Could these unchecked reads lead to hardware state corruption on transient
read failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D6
