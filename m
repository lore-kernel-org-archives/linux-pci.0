Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84E342524
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778796532; cv=none; b=d619/CMXzOZWk1HlNAwfjJla2Ue/Gbzgg7LnhFP51D0xeiEc+9eJPKqwNYUXF/bmK6pjGCDiUv3qtc4Kkn+AWrIa6yoMRByrqE0rMfi6QRITe5/8RhjniFp69zSV9ZDhPlRwxtJY/W5v7gMX66cmE2rTpby0N8WHOS5guw7BSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778796532; c=relaxed/simple;
	bh=+0dOwqvTDarTe6t1w5ronJ9Mb7hhus3tQDP4h5Kz8+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C/Ar0Rh/09OhV4x2K2/q8ZOnmmu2reI8AcslbW/pjO80KKX1oN0nF3M9jkV6OmBByhiiVxt/4LY/vY7YsOSGQAfStBrD1tduMZBwZ56y+ezXr18M9MuVysuudrMiDhc6k5UwjpztUzLk4I98e8ndIVLSzbyfKYl/q9H+UHUb3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6qQttcS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6qQttcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900BAC2BCB3;
	Thu, 14 May 2026 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778796531;
	bh=+0dOwqvTDarTe6t1w5ronJ9Mb7hhus3tQDP4h5Kz8+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=B6qQttcS9E/glL2U3CPeBWp28kSeEsy2LS8DiA4kWoyEt4LF7wpkraeVzYDFEVzGb
	 SIe8p4x9JD5BnsaMvbnEGpGZAOivEzvRFDVszu74VG/wx7l9x05Iq2qbKBk7+bDutR
	 a9v1+tOfwhnaDDEufXliO57jB/luaKWvLQj5O4wR2K+YhotfB93nveZoouwcy093ZA
	 HxE5d+sCJLis4jiaNiera71HhYmkA9/aBk+1F1hwpeCyTZnav3SNfewtolCV7Dz0Fc
	 USvZVyWvTvcaT944PYe+Evd5bEkh6uB//+uqGSYS+U09mkLQxBqz4eE3X3YEdQHRpc
	 cwqTHDvkpBGqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 2/7] PCI: Avoid saving config space state if
 inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260514180059.1553-3-alifm@linux.ibm.com>
References: <20260514180059.1553-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 22:08:50 +0000
Message-Id: <20260514220851.900BAC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Returning early from `pci_dev_save_and_disable()` when the config =
space is inaccessible skips the crucial hardware disablement step.
- [Medium] The variable `val` in `pci_dev_config_accessible()` is uninitial=
ized and the return value of `pci_read_config_dword()` is ignored.
- [Low] The `pci_dev_config_accessible` function accepts a `char *msg` para=
meter but is called with a read-only string literal (`"save state"`).
--

commit 5aedd0a5cc35c507762b05ea728c194c780f2934
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Avoid saving config space state if inaccessible

This commit avoids saving an invalid config space state when a device
becomes inaccessible, such as during a DPC event. It introduces a check
to read the PCI_COMMAND register and skips saving the state if it returns
an error response.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d0c9f0166af5c..e71b814153921 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -722,6 +722,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u=
16 vendor, u16 dvsec)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> =20
> +static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)

This isn't a bug, but could msg be typed as const char *?

The string literal "save state" is passed to this function, which discards
the const qualifier.

> +{
> +	u32 val;

Does this code risk leaving val uninitialized if pci_read_config_dword()
fails?

If the function fails without modifying the output pointer, val will contain
stack garbage. Since it wouldn't necessarily equal ~0 (PCI_ERROR_RESPONSE),
could this lead the kernel to incorrectly assume the config space is
accessible?

> +
> +	/*
> +	 * If device's config space is inaccessible it can return ~0 for
> +	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
> +	 * check Command and Status registers. Note that this is racy
> +	 * because the device may become inaccessible partway through
> +	 * next access.
> +	 */
> +	pci_read_config_dword(dev, PCI_COMMAND, &val);
> +	if (PCI_POSSIBLE_ERROR(val)) {
[ ... ]
> @@ -5027,6 +5048,9 @@ static void pci_dev_save_and_disable(struct pci_dev=
 *dev)
>  	 */
>  	pci_set_power_state(dev, PCI_D0);
> =20
> +	if (!pci_dev_config_accessible(dev, "save state"))
> +		return;

By returning early here, does this skip the subsequent
pci_write_config_word() call?

If the link recovers right before the reset takes full effect, could the
device be left with DMA and legacy interrupts enabled, potentially leading
to memory corruption or interrupt storms?

Should this bypass pci_save_state() but still attempt the disablement
write?

> +
>  	pci_save_state(dev);
>  	/*
>  	 * Disable the device by clearing the Command register, except for
>  	 * INTx-disable which is set.  This not only disables MMIO and I/O port
>  	 * BARs, but also prevents the device from being Bus Master, preventing
>  	 * DMA from the device including MSI/MSI-X interrupts.  For PCI 2.3
>  	 * compliant devices, INTx-disable prevents legacy interrupts.
>  	 */
>  	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514180059.1553=
-1-alifm@linux.ibm.com?part=3D2
