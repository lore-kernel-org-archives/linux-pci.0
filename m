Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31592225A38;
	Sun, 11 Oct 2026 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685491; cv=none; b=jOTvPGFBAF8NxcM/t8j5B2B9B+chYPfYXvuQD0Xti6xPdZ1GnwgcMpzkBHQQ9Bcc8LQ40NtcDV82CaplRYOPqbH7F/1bxPmOqF26x9pGuyGxsMajmdIbZ+oy9gcijscjnCN+dWXthjToZVlwjtRVY38rLRADxnx+eoQCAuaRH7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685491; c=relaxed/simple;
	bh=MRFMJyYyp7eY4lbVfsYu/cKCMoJfY+hReJI6dPcdaAQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ags9GCm6CmO4bmSZOnPdEf3nbdTAiD80NZhcdqe1d3rYUKkELH3c/kkRCJBm3eKLfReo8QSWpb+6Qiqq+UnoTHyB9U5UI0l3GFQybCcaCVxOavnJ35A2BlZJ0lFTuFw1qS4rvrU1sf/bUYeCr2ana99V0KVEpfkHfkiJm3nxlOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbqO/99O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbqO/99O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C961F1F000FF;
	Sun, 11 Oct 2026 02:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685490;
	bh=qgPlWbd6618WaVaGI+7Ot7N9Qh68FrbqDmfxDn+DqU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bbqO/99OZ3nlrWm6VTCvt5lDqX12HzuS6dHRX6luMzAJ/FNpLiYHaD+VRyaHKemMi
	 CGJ7PUMdfzT+2HGOZZmlnA1fYm6r4OGxo7bxVMzzYYqZEtBK+ftA3Jc0n7PFVv6lG6
	 CXEyvOfyj3eFHoG06MeZn7ZD8HKov2Yq0ASlJTcewzFn2cCthZxi3tiuAPzRR71RvG
	 KoYnC8qagQKJrlg7FvBsCvcfBEi0N9WlQ+fmE0dYs/UH7tamS5phbVAF5NspM9VMSZ
	 lw3pHLZ70v7LEhdGUGn2eGJmsm+u2UIv69oyvuxWPnA36dGTSBirQ/QtmSJ3F22yCY
	 6G9t+7kpPHVuQ==
Message-ID: <sashiko-outbox-166974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 15/16] PCI/CXL: Restore CXL state after CXL bus
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261011021422.3428136-16-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-16-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:24:49 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: cxl_reset_bus_function() incorrectly bypasses SBR topology =
checks on probe
--

commit 3639cffcefe2a45e59bbab7de2628286c4acba6c
Author: Srirangan Madhavan <smadhavan@nvidia.com>
Subject: PCI/CXL: Restore CXL state after CXL bus reset

This commit restores CXL state after a successful cxl_bus reset while IOMMU
exclusion remains active. It allocates HDM state storage ahead of a bus
reset, restoring the PCI configuration first so HDM MMIO is accessible.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/comm=
it/?id=3Db93f0c8e67b198a63786fd3721b7177ab9df60be

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b58a6a6133119..cecf8e681e69b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5014,6 +5014,7 @@ static int pci_reset_bus_function(struct pci_dev *d=
ev, bool probe)
> =20
>  static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
> +	struct cxl_hdm_info *snapshot __free(kfree) =3D NULL;

[Severity: Medium]
Does this function incorrectly bypass the topology and hardware constraints
checked in pci_reset_bus_function() when probe is true?

For reference, the code in cxl_reset_bus_function() returns early for probe=
s:

	if (probe)
		return 0;

The pci_dev_reset_methods subsystem uses the probe argument to query whether
a specific reset method is supported and safe for a given device topology. =
By
returning 0 unconditionally when probe is true, the call to
pci_reset_bus_function() located further down is skipped.

Because pci_reset_bus_function() enforces critical constraints, such as
checking if SBR is enabled and ensuring the device is the only device on the
secondary bus, bypassing these checks during probe can cause the kernel to
falsely advertise the cxl_bus reset method via sysfs for devices that share=
 a
bus or have SBR masked.=20

If this occurs, when userspace attempts the reset, it will deterministically
fail with -ENOTTY during the actual execution phase, breaking the API contr=
act
of the probe step.

>  	struct pci_dev *bridge;
>  	u16 dvsec, reg, val;
>  	int rc;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D15
