Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8259C4756CE
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245823; cv=none; b=gtSv4NIK5OKDpYYEL+odhoytibqXG7R8vxZxoTi99OO9HMoBfcGmbZbWSfQPyAHeSx+lrAksv1TsaR83dHpdVD5/PMyTqg+Je14exzd/OyaBuLCWnp9pDz3vrjgSighNOI5ozR/0kh87yxeNCHbJKrph9DeHF5gtdcF/XaElQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245823; c=relaxed/simple;
	bh=U8nMggfZB2pfvOMthpuD5eenXWw+txwYNB5gvHaXPPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPkBGQXx4wRleUZYFhcgM68dnylKvqmNTK8M8ed2LvKPm4xQRvuV6UHX4TXnnEVDJwkbMmnlPnXPbZ11teKoV4vCDI3H+0ow8YT7m2kjOeTKp4ORVPAFT/3ybaWz1CTSvOwMeLHiap8tqBMRd+mGbgThAzkLbRsmOhw8oaM9ZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9Fn69XR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9Fn69XR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88CB1F000FF;
	Thu, 24 Sep 2026 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790245822;
	bh=rAFMTMvterXZhAVHx/XFXcEzI70FvYsFK594h0Se8zM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m9Fn69XRCAj0LPQTvX9MUjtlrqWDrUa4P+svKD1Fw3UOUHhsZezd2m7PuZbckL0/9
	 JTjsd6IetFfHI7nhQwZdkP85MkGsylKxowT3bLzkH2dPAF2UtK7yEBjk36/175gSW/
	 ZujvR6NXSpe6wqmT8sK35of59qlfCgE2EVRrmX1B1Nt+yN2K8rSbLcX0Ds0GLfTCpv
	 xNk+vyby/ltKm321S/05qvTkmmwoDFS9m+wl8/Gvj4+qChTsxQCvj1Y3Ae0MbtWed1
	 TbeTHNAsQ9+ZL5ezkTp64P6gB1g+2l9r8jVOIKHoA/FM+n2BRWM331ng1r/jiadHxP
	 DqSIU1pruTBXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: pciehp: Re-read Slot Control when cached HPIE is
 clear
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Qiyu" <qiyuzhu2@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924101929.143806-1-qiyuzhu2@amd.com>
References: <20260924101929.143806-1-qiyuzhu2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:30:21 +0000
Message-Id: <20260924103021.C88CB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: TOCTOU race in config space read leading to master abort
--

commit 7ceb468446bd25d57acbe78d0b28b124ca7b5902
Author: Zhu Qiyu <qiyuzhu2@amd.com>

PCI: pciehp: Re-read Slot Control when cached HPIE is clear

This commit addresses missed hot-plug events by re-reading the Slot
Control register directly from hardware when the cached Hot-Plug
Interrupt Enable (HPIE) bit is clear and the port is in the D0 state.

> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pcieh=
p_hpc.c
> index 4c62140a3cb44..df977d4af4056 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c

[ ... ]

> @@ -628,13 +628,34 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	u16 status, events =3D 0;
> =20
>  	/*
> -	 * Interrupts only occur in D3hot or shallower and only if enabled
> -	 * in the Slot Control register (PCIe r4.0, sec 6.7.3.4).
> +	 * Interrupts only occur in D3hot or shallower (PCIe r4.0, sec 6.7.3.4).
>  	 */
> -	if (pdev->current_state =3D=3D PCI_D3cold ||
> -	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) && !pciehp_poll_mode))
> +	if (pdev->current_state =3D=3D PCI_D3cold)
>  		return IRQ_NONE;
> =20
> +	/*
> +	 * Interrupts are only sent if enabled in the Slot Control register
> +	 * (PCIe r4.0, sec 6.7.3.4).  ctrl->slot_ctrl caches that register, but
> +	 * the cached Hot-Plug Interrupt Enable bit can fall transiently out of
> +	 * sync with the hardware if platform firmware clears it behind the
> +	 * driver's back (e.g. concurrently with a Slot Control read-modify-
> +	 * write).  While the port is in D0 it is accessible, so re-read the
> +	 * register from hardware before dismissing the interrupt as not ours.
> +	 * In a low-power state the port may be inaccessible and the cached
> +	 * value is authoritative.
> +	 */
> +	if (!pciehp_poll_mode && !(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE)) {
> +		u16 slot_ctrl;
> +
> +		if (pdev->current_state !=3D PCI_D0)
> +			return IRQ_NONE;
> +
> +		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);

[Severity: High]
Does this introduce a Time-of-Check to Time-of-Use (TOCTOU) race condition =
when
reading the config space?

A concurrent pm_runtime_suspend operation powering down the device can race
with pciehp_isr receiving an interrupt.

The lockless pdev->current_state !=3D PCI_D0 check could pass just before t=
he
state is updated, leading to an unprotected pcie_capability_read_word after
the device becomes inaccessible.

Reading the PCI config space of a suspended device can trigger an Unsupport=
ed
Request (UR) or Completion Timeout. On some platforms (e.g. ARM64), this do=
es
not gracefully return 0xFFFF but instead triggers a Synchronous External Ab=
ort
(SEA), leading to a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924101929.1438=
06-1-qiyuzhu2@amd.com?part=3D1
