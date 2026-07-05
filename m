Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCA360EC0
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290305; cv=none; b=Lj9uj4Nrm6XXpE4z6bo0ieZ+0oZXaDGQXbt8jtNs/SaTZ2J76e+k4YIlP/ePWCqAez4cDOVBocZv7suta6aX1MCcjhe7hnuCiOgmnqD1UkV+BMnedIoOtOhZ+R6aqL3tCUc4T11p33RInUsh1sPUeQNpX16crzbAX/7wf/uyTL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290305; c=relaxed/simple;
	bh=cVWWj1PpHa2OzWqtl7hhgw2QNWLYRrv+LVKgesO+M44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aGIeTWFY/1S+XpbWLCptFLbTaWA5QmBycjFopUNfdkcCr4eH5w5oxBbUfTsSBWLD4z6sAbpxdpSt1BPA4ciBLwj9YpnEN/Gs4AvwwZTM2OSRK9Bz5jXI22qICfuYyMbvDRpAnU5xRl6Qsi2HnWtmyu6dAOdqV7xjfYkzAlJqPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIfdjfKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIfdjfKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACF01F00A3A;
	Sun,  5 Jul 2026 22:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783290304;
	bh=8aP6SnCaHNRo09+iRQJukyvuS5v6B2rQUNt2vfQn7LE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KIfdjfKMgn5mSGDEIONCD0/Jcn68Z0r0QjEiQiOoddI3fBrZPgkdTpQLYjKxU7dqE
	 M6I76AM/2rmdwxFmp7tosbNEA6RmVCkflS3H+Z8fosvJgxBwId0D3FZe17FQRKn5T1
	 EN2lOi6d1+7npAXAL0P1/HR92nWX4gvDJb8ZD3winOudZnPGOVZlIVPdBVdcmUttsx
	 Yr5u5wpFGRTTCKhjmPnt3a58SDv1GmBahWvS6mIJBGq4p2Sv0sob6/gpA5V4tgokkK
	 BHWqXFjPaZtUwckJtjqOyEltm1YK0lXMmwBNiGIgzQMdIwvHKaBLahhW3vQzmzjbgd
	 vGRwWXTPsTScg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] PCI/TSM: Add relative MMIO offset support?
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-16-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-16-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:25:04 +0000
Message-Id: <20260705222504.6ACF01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The BAR mask calculation in `pci_tsm_mmio_alloc()` uses a 32-bit `=
unsigned long` for `mask` on 32-bit architectures, corrupting 64-bit `tsm_o=
ffset` calculations.
- [High] A 32-bit integer overflow when calculating `size` in `pci_tsm_mmio=
_alloc()` silently truncates MMIO ranges of 4GB or larger.
--

commit 39c72d1b357cb53c2cb3c0f7292c8909846cff30
Author: Dan Williams <djbw@kernel.org>

PCI/TSM: Add relative MMIO offset support?

The RMM specification documents the expectation that the MMIO_REPORTING_OFF=
SET
chosen for TDISP Interface Reports is always BAR aligned. This patch adds
support to ask the TSM drivers for the offset calculation scheme if it
deviates from this assumption.

Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>

> diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
> index 9ac216ad896d9..19ad35f2da4a9 100644
> --- a/drivers/pci/tsm/core.c
> +++ b/drivers/pci/tsm/core.c
> @@ -643,13 +643,15 @@ struct pci_tsm_devif_report {
>  /**
>   * pci_tsm_mmio_alloc() - allocate encrypted MMIO range descriptor
>   * @pdev: device owner of MMIO ranges
> + * @scheme: allow the low level TSM driver to hint the offset calc scheme
>   *
>   * Return: the encrypted MMIO range descriptor on success, NULL on failu=
re

[Severity: High]
This is a pre-existing issue, but I noticed a potential 32-bit
multiplication overflow in this function.

When calculating the size in pci_tsm_mmio_alloc():
    u64 size =3D __le32_to_cpu(mmio_data->nr_pfns) * SZ_4K;

Since both operands are 32-bit, will this overflow if nr_pfns is 1,048,576
(representing 4GB) or greater? The overflow would occur before being
promoted and assigned to the 64-bit size variable, causing MMIO ranges of
4GB or larger to be silently truncated.

>   *
>   * Assumes that this is called within the live lifetime of a PCI device's
>   * association with a low level TSM.
>   */
> -struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev)
> +struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
> +					enum tdisp_offset_scheme scheme)
>  {

[ ... ]

> @@ -712,10 +714,14 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_=
dev *pdev)
>  			last_bar =3D bar;
> =20
>  			/*
> -			 * Determine the obfuscated base of the BAR. BAR
> -			 * offsets are never obfuscated.
> +			 * Either the first range per bar always maps
> +			 * the start of the BAR, or the reporting_offset
> +			 * is BAR size aligned.
>  			 */
> -			reporting_bar_base =3D tsm_offset & ~mask;
> +			if (scheme =3D=3D TDISP_OFFSET_RELATIVE)
> +				reporting_bar_base =3D tsm_offset;
> +			else
> +				reporting_bar_base =3D tsm_offset & ~mask;

[Severity: High]
This is a pre-existing issue, but could this bitwise AND corrupt 64-bit
calculations on 32-bit architectures?

Looking at the definition of mask earlier in pci_tsm_mmio_alloc():
    unsigned long mask =3D pci_resource_len(pdev, bar) - 1;

Since pci_resource_len() returns a 64-bit resource_size_t on PAE systems,
it gets truncated to a 32-bit unsigned long mask on 32-bit architectures.
When ~mask is evaluated, it results in a 32-bit value.

Would applying bitwise AND with the 64-bit u64 tsm_offset here cause
zero-extension of ~mask, explicitly clearing all bits above 4GB in
tsm_offset?

>  		} else if (tsm_offset < last_reporting_end) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D15
