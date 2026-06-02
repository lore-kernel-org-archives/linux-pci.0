Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC22B371049
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418349; cv=none; b=DMQeqxUi792OcQyzaY2InP99LQEGFmC7cpM4nnsa3dMX3GSdHB/7fhfOeez3q/nmgOuIye0GXF+4LUdXbijXSPNeRGFLjxKBo+QKzL9Dxgk4VB+sSq5fkCgfICG0gzTc1/aJQTaVdEOC9nTzDi3qA12g3qWkcDIwgRyZDlXgfdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418349; c=relaxed/simple;
	bh=4iHB0TIrJSPU/ShITX+Z9pSRuxvCq6sRu4YEpjh1J8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YsY/BUzUDvtvIvtKN4a2bwCC4PMW84QGHPsUeAVLjnADTjflzWe/vECYzG7IoT6sQ+Pg0mB7I9ypLInHCmgjFi7rvScBMskxORz36UqgI7wa9ihTb+DUwckX6RbYB/fmSZif2LVq65c5r6JBTro/P+xMx+S5Q+LIfkyhk1+Xv+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOzk6bsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOzk6bsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6281F00893;
	Tue,  2 Jun 2026 16:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780418347;
	bh=vZqdItxYLL/P6RbXja9dqvzLbiB9qCGnuYhjRNlkaXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IOzk6bsh5ViQhP6P6EVIe5V/oQhoRbKMVt+rua399hURg5SBsXr6EZMNhL/3Lo8r1
	 m8Jk4TOv1POtnKtQraF1p4EmDxCYZQAGDJZD7Y0JaPf1rLdYztMrUNWgfF1VtZeNyh
	 kXyTY8Nk81sTVrms7IazSB/c0Sgt5uwzMwKZ8oJm56tWnuyq/CaZgV8xulNAfPCb5j
	 HMZTBY4teSlHaz81xo17htOweLnLUUGAyQkydHgFfrBeaZIPUKMMKjmhISk4uICaDO
	 M754QAKW1xTsfBb3sLwetoDCMXhmSt+0EEsOeLzfHp1zPwjLU6BZz+oKKPV4RW8f1n
	 L7I+4R0Xibqbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] PCI: Add device-specific reset for Qualcomm
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260602160024.1171949-3-jtornosm@redhat.com>
References: <20260602160024.1171949-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 16:39:07 +0000
Message-Id: <20260602163907.7A6281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Missing Device Initialization and CRS Polling Wait in `pci_dev_d3c=
old_d0_cycle`
- [Medium] Commit message contradiction regarding IOMMU preparation

Pre-existing issues:
- [High] IOMMU and ATS unconditionally disrupted during sysfs `reset_method=
` capabilities probe
--

commit 8b985d62d4b41384aa769fbbb431c482aeb82ae9
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add device-specific reset for Qualcomm devices

This patch adds device-specific reset methods for some Qualcomm PCIe devices
(ath11k, ath12k, SDX62/SDX65) that lack working reset methods for VFIO
passthrough. It introduces a shared pci_dev_d3cold_d0_cycle helper function
that attempts D3cold with automatic fallback to D3hot on platforms without
ACPI _PR3 power resources.

> Extract a shared pci_dev_d3cold_d0_cycle() helper function to avoid code
> duplication between pci_d3cold_reset() (strict _PR3 requirement) and the
> new reset_d3cold_d3hot() device-specific reset (automaticfallback). The
> helper handles IOMMU preparation, performs the power cycle via
> pci_set_power_state(), and cleans up IOMMU state.

[Severity: Medium]
The commit message states "The helper handles IOMMU preparation", but the
helper code documentation states "Caller must handle IOMMU preparation/clea=
nup
if needed" and leaves IOMMU handling to the caller. Could the commit message
be updated to reflect the implemented code logic?

[ ... ]

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 096868f80cd4c..f7a7443287fdf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4491,6 +4491,32 @@ static int pci_pm_reset(struct pci_dev *dev, bool =
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
> + * without ACPI _PR3 power resources.
> + *
> + * Caller must handle IOMMU preparation/cleanup if needed.
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
> +	ret =3D pci_set_power_state(dev, PCI_D3cold);
> +	if (ret)
> +		return ret;
> +
> +	return pci_set_power_state(dev, PCI_D0);
> +}

[Severity: High]
Does this function need to wait for device readiness (CRS) before returning?

Unlike pci_pm_reset() which polls with pci_dev_wait(), this returns
immediately after the D3hot->D0 transition. Since this targets the endpoint
directly and bypasses bridge-level pci_bridge_wait_for_secondary_bus() dela=
ys,
if the device internally resets during the transition and returns CRS (0xFF=
FF),
will pci_set_full_power_state() incorrectly mask the state and return succe=
ss
prematurely?

If so, could this cause subsequent configuration accesses by VFIO to fail w=
hile
the hardware is still initializing?

[ ... ]

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc02..2380a29970736 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4237,6 +4237,22 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev=
, bool probe)
>  	return 0;
>  }
> =20
> +/*
> + * Device-specific reset method via D3cold/D3hot power cycle.
> + *
> + * Some devices lack working FLR, advertise NoSoftRst+ (blocking PM rese=
t),
> + * and have broken bus reset. This function provides device-specific res=
et via
> + * power cycling, attempting D3cold with automatic fallback to D3hot on =
platforms
> + * without ACPI _PR3 power resources.
> + */
> +static int reset_d3cold_d3hot(struct pci_dev *dev, bool probe)
> +{
> +	if (probe)
> +		return 0;
> +
> +	return pci_dev_d3cold_d0_cycle(dev);
> +}

[Severity: High]
This is a pre-existing issue, but since the commit message suggests overrid=
ing
via sysfs, will querying these reset methods cause IOMMU faults for running
devices?

When userspace reads or writes to /sys/bus/pci/devices/.../reset_method, the
kernel calls reset methods with probe =3D true. In __pci_dev_specific_reset=
(),
it unconditionally executes pci_dev_reset_iommu_prepare(dev) before checking
the probe flag:

drivers/pci/quirks.c:__pci_dev_specific_reset() {
    ...
    ret =3D pci_dev_reset_iommu_prepare(dev);
    if (ret)
        return ret;
    // then calls i->reset(dev, probe);
    ...
}

Since pci_dev_reset_iommu_prepare() temporarily tears down PASID domains and
halts translations, will querying the reset methods for an actively running
device like ath11k disrupt ongoing DMA operations and cause system crashes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602160024.1171=
949-1-jtornosm@redhat.com?part=3D2
