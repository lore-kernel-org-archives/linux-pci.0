Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82D4B8DF1
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025107; cv=none; b=LPGsq5W+/YRMlUvf3cPt2LcMxwXQISzs4ITkv7nrO2tN32HBhtcPXSKoQytzQsjfzwF+aNRyFLfNyx9FS+wEWofNAlwDUr3KKnp4GWZgW0JBws51ihypX18TkHNzYWMw2diAmfxQzKpIybM130yDuBg8RG/xFzggEjpY4BVFCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025107; c=relaxed/simple;
	bh=EN/zVjRbNaYIrMnowfczwTQ7MzIKNbGZAXq29dlkxbA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F4oYDpp7voUvPWLyY9tkKFAVHUvVFL5JGkdZcULVxALjTaPODY9JJ29OHc+1KhWIu2ahDtKREXRmnBmFutx+hWIdtiYraxHFToLZs1m5gbZqddQgBbZ2t3xZs4bk+BJeeltlctTLRHMwvT3Ka22//six1igPjEUOInHCm7bHV8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy+Nh2oc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy+Nh2oc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E13F1F00893;
	Tue,  9 Jun 2026 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781025101;
	bh=6p07iGUYzvdAHSj/PasFbd3qyZpZpxFIaUWefwT5yRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fy+Nh2ocw9mfwu2DDTULGhNkQWhixO5BS6zgGo+wko3CJFAajbVhUEPshux3GNDmC
	 9K2Yu6ZM+q8nJkcgVSTjCuv7El5/A+qntFf6pOW6IA7K8J3jCcHbSNORCjbVzeweCM
	 Pf9F8tHxeiVDY2srurXznVG5YShyITBLMyPzfmxBrwMsAqGQ/Oh8X0B3J5rf4hhczZ
	 74bMJpquAgLB5Ud0bxvtzYlm13fOyLtgZGF27xo7LZ9eCIcZPX0jMvqFdJxl7MNGcr
	 TSC98e0iXUl9gMCnCNQEsjA0IcSfCQ61sn6mrAZt5ikwE8G3NU6TFxPZu2o3QMslMw
	 EJpx0wAfv7aIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] PCI: Add device-specific reset for Qualcomm
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260609163649.319755-3-jtornosm@redhat.com>
References: <20260609163649.319755-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 17:11:41 +0000
Message-Id: <20260609171141.7E13F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly extracted `pci_dev_d3cold_d0_cycle()` helper, and thus t=
he new device-specific method `reset_d3cold_d3hot()`, fails to wait for dev=
ice readiness after transitioning the device to D0.
--

commit f0c27acd50ba34288a06f87ab1b9a8e74f06aba2
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add device-specific reset for Qualcomm devices

This commit adds device-specific reset entries for several Qualcomm PCIe
devices that lack working reset methods. It implements a reset via D3cold
power cycling with automatic D3hot fallback, extracting a shared
pci_dev_d3cold_d0_cycle() helper for this purpose.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 096868f80cd4c..f7a7443287fdf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

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
Is there a missing wait for device readiness after transitioning to D0?

Standard reset implementations like pci_pm_reset() explicitly call
pci_dev_wait() after setting D0 to ensure the device has finished its
internal reset:

pci_pm_reset() {
    ...
    csr |=3D PCI_D0;
    pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
    pci_dev_d3_sleep(dev);
    ret =3D pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
    ...
}

Without this wait, does pci_dev_d3cold_d0_cycle() return before the
device is fully ready? If the caller (like VFIO via pci_reset_function)
immediately proceeds to restore the device's config space and BARs, could
those configuration writes be dropped or hit Configuration Request Retry
Status (CRS), leaving the device unconfigured?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609163649.3197=
55-1-jtornosm@redhat.com?part=3D2
