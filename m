Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2D277CA5
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374777; cv=none; b=C+xW1CZaJJHWEX58mQiMiJvdwvJ1UXUwVUDz05nbxRSkgE3XFWhf0S0NQOPeSbU3NXBpoD/dahfntUQOHGz8Xysa90cUmfkcjL5G5o/hbSQelubz3iyAU2ZU2qQsqpbMYQ/H7+wn3IpIkFcKw02laJbz361u6l82M5CjwRhAWFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374777; c=relaxed/simple;
	bh=vRhheiRPZq3YCS5X+8qYKfYm5Q6dQZCZdshCwyMyi1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=htblS1nPFn/3e6yelXlNWH/ofYAgWs2Ol6edHHI9NxKtNoAW/zedQa6ZYjSrJYqriWS6csZSFvWkeQSy8ztgT+Ml0TKpy6MkThtUBwQsdY/7b8IlX7diIJH9koROazJ3jL+i4WOFHtbiPBlj8eqiR7RC4tn0gFR8wrqyumOpxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eoayf9zk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eoayf9zk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01CF1F00A3B;
	Thu, 21 May 2026 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374776;
	bh=/nH/EPcQU5NBd+G7t9UdiLHeSgqbzGEx8/q93/Hy0xU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eoayf9zkbGdUa2zvFLjp3JxvhhShoGafdvsvpvgWsmfwIg0ntxfZT9/kMnzaJNk/G
	 H3zTah+NNCAwBf1/pLtWoYHpgU8zsXmut3rE1msrLwfjtjwLSkgZfSg1cdq7rt01Fx
	 Mn+z/N3WvUYabumi3wCb+wx/qxFOWT4kpAKU06BiO35TnSPnLj37rgVUVdLMcVhvjz
	 BjVqikLFvhxcq0NJpILBnyum65zYkyqqC5SVA62UmCGRHyJZKpJFrAQCzqqW+KQoLG
	 XsWjNo0L1MlVONbSCdlEvCI/vHl6KE+ecNdNTeyFdjFjKEZwdU+4gEZTlUx8FvtgAu
	 MW4QNfYr32g8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] PCI: Add device-specific reset for Qualcomm
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521130512.515125-3-jtornosm@redhat.com>
References: <20260521130512.515125-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 14:46:15 +0000
Message-Id: <20260521144615.F01CF1F00A3B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Incomplete Device Reset / Cross-VM State Leak due to ineffecti=
ve D3hot fallback
- [High] Logic Error / Resource Re-entry via double invocation of pci_dev_r=
eset_iommu_prepare()

Pre-existing issues:
- [High] Missing Device Readiness Wait after D3cold->D0 transition
- [High] Lock Ordering Deadlock between device_lock and pci_bus_sem
--

commit 3c339ed7150450f08a8ac36c7607f84ee659f04d
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add device-specific reset for Qualcomm devices

This commit adds device-specific reset entries for several Qualcomm devices
that lack working reset methods for VFIO passthrough scenarios. It extracts
a shared helper function to perform a D3cold power cycle with an automatic
fallback to D3hot.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 096868f80cd4c..f6be5c58cc91d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -4491,6 +4491,40 @@ static int pci_pm_reset(struct pci_dev *dev, bool =
probe)
>  	return ret;
>  }
> =20
> +/**
> + * pci_dev_d3cold_d0_cycle - Perform D3cold->D0 power cycle
> + * @dev: Device to power cycle
> + *
> + * Common helper to perform D3cold->D0 power cycle for reset methods.
> + * Attempts D3cold transition with automatic fallback to D3hot on platfo=
rms
> + * without ACPI _PR3 power resources. Handles IOMMU preparation and clea=
nup.
> + *
> + * Returns 0 on success, negative error code on failure.
> + */
> +int pci_dev_d3cold_d0_cycle(struct pci_dev *dev)
> +{
> +	int ret;
> +
> +	if (dev->current_state !=3D PCI_D0)
> +		return -EINVAL;
> +
> +	ret =3D pci_dev_reset_iommu_prepare(dev);

[Severity: High]
Does this result in a double invocation of the IOMMU preparation routine?

The PCI core invokes device-specific reset quirks through
__pci_dev_specific_reset(), which explicitly calls
pci_dev_reset_iommu_prepare() before invoking the device's reset callback.

If the IOMMU subsystem's implementation checks the domain state and is not
re-entrant, will this unconditional second call in the helper cause the res=
et
to unconditionally fail with -EBUSY for devices attached to an IOMMU?

> +	if (ret) {
> +		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D pci_set_power_state(dev, PCI_D3cold);
> +	if (ret)
> +		goto done;
> +
> +	ret =3D pci_set_power_state(dev, PCI_D0);

[Severity: Critical]
The commit message notes these devices advertise NoSoftRst+, meaning PM soft
resets are blocked. If the platform lacks ACPI _PR3 power resources and
pci_set_power_state() falls back to PCI_D3hot, does this transition sequence
actually reset the device?

Because the D3hot fallback completes without error, it appears to return 0
(success) while falsely signaling to callers like VFIO that the device has
been successfully reset. Can this result in assigning an un-reset, stateful
device to a new VM?

[Severity: High]
This is a pre-existing issue, but should there be a polling delay after the
D3cold to D0 transition to handle Configuration Request Retry Status?

A transition from D3cold to D0 acts as a Fundamental Reset. The helper calls
pci_set_power_state() for PCI_D0 which applies PM delays, but does not poll
for readiness. Can subsequent configuration accesses be sent to an unready
device, causing Unsupported Requests or host Master Aborts?

[Severity: High]
This is a pre-existing issue, but does this sequence risk an AB-BA deadlock
between device_lock and pci_bus_sem?

When a device reset is triggered via sysfs or VFIO, the lock order is:
pci_reset_function() [acquires device_lock]
  -> pci_dev_d3cold_d0_cycle()
    -> pci_set_power_state()
      -> __pci_set_power_state()
        -> pcie_aspm_pm_state_change() [acquires pci_bus_sem]

Conversely, the AER recovery path lock order is:
pci_walk_bus() [acquires pci_bus_sem]
  -> report_error_detected() [acquires device_lock]

Could an AER event occurring concurrently with a device reset trigger a
deadlock here?

> +
> +done:
> +	pci_dev_reset_iommu_done(dev);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521130512.5151=
25-1-jtornosm@redhat.com?part=3D2
