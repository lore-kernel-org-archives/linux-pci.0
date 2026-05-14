Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395423B95F0
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 05:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735279; cv=none; b=G+8Fl9d/0J2ucF9NbwI18lFH2NemjWynRqlZMwz0CQhtrbtw7dFcwIcUchx5EBtRsYxYiBee3vSbF/zu+NYh0f7OXeC9uBNW++0U1Cm2y6P/Rrd5rwXgfQfFzqCG//dID+bWJmgrxuBaLbIfeBopaD2ars3kVPX7BjoPvYKCWjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735279; c=relaxed/simple;
	bh=ZN1PUfb8n0LdXVq02647XAk5qZmLkiC+4RdmkkSCG74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YglNAjODzsJYKJhtUKnEIiCydYVT/v/hv6bxr6F752N13KCTW2cGzexKVc34w5Vuj/h3q6MOo5TJz34k+jRbklTyYJvLzI4lwzYT8pZ0E6h0AHr0KZXXE9gJhxQlt8cd69JsK+zKFSlcRcYIYSHDqcAcX4gOKfn6wyTcb4iFTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKzk+d26; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKzk+d26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA3BC2BCB7;
	Thu, 14 May 2026 05:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778735278;
	bh=ZN1PUfb8n0LdXVq02647XAk5qZmLkiC+4RdmkkSCG74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KKzk+d26U4n10ODf9Qr4Ma6DrQW8vmjj7WT/KJXckzkQoIO5geJrSPLWbQEN/s9Vy
	 VE4/t43JotbsIEDikAxT221BmmgpVqx9i8WDCFp29SsJ8DvqNIe8Y8eARVy7b22afW
	 zE18DgDmdNRFBzSF0zIGG/hQb3JdJjVHlPJCJQ++JOLJ8QqUxj0OQwoWDtmMLk+5S+
	 OrNGS57Jpo+nba/3L2Vo138eMMTO/fpgAEAfm8GypNbI/ZlWJTCiLO2i2Zy8Qcdb64
	 n9re9aiM9wLTfPX7NN0gmQr4YE2GIjJrJxfKbCt8grIhsGbanhPnafylkQ16xy/qN8
	 3rdxUqtpEh66w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add D3cold as general reset method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260513122349.268753-1-jtornosm@redhat.com>
References: <20260513122349.268753-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 05:07:58 +0000
Message-Id: <20260514050758.ADA3BC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Silent reset failure and state leak via NoSoftRst+ bypass
- [High] Missing IOMMU coordination during reset sequence
- [High] Missing device readiness wait (CRS polling) after power transition
- [High] Catastrophic power loss for downstream hierarchy on single-functio=
n bridges
- [Medium] False advertisement of reset support in probe mode
--

commit 372c424ac498f1ceef866b966b4539db619980ea
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add D3cold as general reset method

This commit adds a D3cold power cycle as a general PCI reset method for
single-function devices. It implements pci_d3cold_reset() which attempts to
transition the device through D3cold and back to D0, falling back to D3hot =
if
ACPI _PR3 is unavailable.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..6da8feff7ccc3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -4491,6 +4491,46 @@ static int pci_pm_reset(struct pci_dev *dev, bool =
probe)
>  	return ret;
>  }
> =20
> +/**
> + * pci_d3cold_reset - Put device into D3cold (or D3hot) and back to D0 f=
or reset
> + * @dev: PCI device to reset
> + * @probe: if true, check if D3cold reset is supported; if false, perfor=
m reset
> + *
> + * Attempt to reset the device by transitioning through D3cold and back =
to D0.
> + * On platforms with ACPI _PR3 power resources, this performs a true D3c=
old
> + * power cycle (actual power removal). On platforms without _PR3 support,
> + * pci_set_power_state() automatically falls back to D3hot, providing a
> + * D3hot->D0 reset transition.
> + *
> + * Only available for single-function devices to avoid affecting other
> + * functions in multi-function devices.
> + *
> + * Returns 0 if device can be/was reset this way, -ENOTTY if not support=
ed,
> + * or other negative error code on failure.
> + */
> +static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (dev->multifunction)
> +		return -ENOTTY;

Many PCIe bridges (like Root Ports and Downstream Switch Ports) are
single-function devices.

If pci_d3cold_reset() is triggered on a single-function bridge,
pci_set_power_state() will physically shut off power to the entire downstre=
am
hierarchy. Because pci_reset_function() is intended to reset only the target
function, does this unexpectedly drop power to subordinate devices without
unbinding their drivers or saving their state?

Should there be a check for dev->subordinate to prevent execution on bridge=
s?

> +
> +	if (probe) {
> +		if (!pci_pr3_present(dev))
> +			pci_dbg(dev, "d3cold reset: no _PR3 support, will use D3hot fallback\=
n");
> +		return 0;

When called with probe =3D true, this unconditionally returns 0 if the devi=
ce
is single-function, even if it lacks both ACPI _PR3 and native PM
capabilities (dev->pm_cap is not checked).

Could this incorrectly register d3cold as a supported reset method for hard=
ware
that physically cannot change power states?

> +	}
> +
> +	if (dev->current_state !=3D PCI_D0)
> +		return -EINVAL;
> +
> +	ret =3D pci_set_power_state(dev, PCI_D3cold);

Other PCI reset methods in the kernel bracket their operations with IOMMU
coordination. For example:

static int pci_pm_reset(struct pci_dev *dev, bool probe)
{
        ...
        ret =3D pci_dev_reset_iommu_prepare(dev);
        ...
        pci_dev_reset_iommu_done(dev);
        return ret;
}

By omitting these calls, does pci_d3cold_reset() allow power to be removed
while the device might still have in-flight DMA or active IOMMU mappings,
potentially triggering spurious DMA faults or fatal IOMMU errors?

> +	if (ret)
> +		return ret;
> +
> +	return pci_set_power_state(dev, PCI_D0);

When true D3cold is unavailable, pci_set_power_state() transparently falls
back to putting the device into D3hot. If the device advertises the
PCI_PM_CTRL_NO_SOFT_RESET bit, a D3hot->D0 transition explicitly does not
reset the device's internal state.

Other reset methods like pci_pm_reset() explicitly check this:

static int pci_pm_reset(struct pci_dev *dev, bool probe)
{
        ...
        pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &csr);
        if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
                return -ENOTTY;
        ...
}

Since pci_d3cold_reset() does not check this bit and returns 0 on success,
does this falsely report a successful reset to subsystems like VFIO that re=
ly
on this to wipe guest state, potentially leaking state across VM boundaries?

Additionally, returning a device from D3cold or D3hot to D0 constitutes a
Conventional Reset, where devices may require up to 1 second to reinitialize
and return Configuration Request Retry Status (CRS).

Existing methods ensure readiness before returning:

static int pci_pm_reset(struct pci_dev *dev, bool probe)
{
        ...
        ret =3D pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
        ...
        return ret;
}

Does returning immediately from pci_set_power_state() mean the caller might
instantly invoke pci_dev_restore() while the hardware is still unresponsive?

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513122349.2687=
53-1-jtornosm@redhat.com?part=3D1
