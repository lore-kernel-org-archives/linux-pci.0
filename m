Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3444B695
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486780; cv=none; b=PwQydQS0KgqDSy8wE9+d14ulvkeV19dXz/FpwvdT6pyjJNAFL0nQ2i9UkiwPUrl+RFy05S5jBIHpbVXE06AD6ezzCptsoJCWTAqt9hWs/Nzc26BBNQJHyUDipLwhHZfcAKsGTcvun2uJ8dnyWO0Id+wXOYLUD5HieLY+f4Lb+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486780; c=relaxed/simple;
	bh=WRE5bY3NDe0VKP2RwHC3Q9kyYCxkbG2jeWLMSuT2T08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DJdF/co6RlB0pWC9L8gWQvm3iyVlitWrprXAqUQgAkqKoip45KlqyJkmfc6NRcePvDibXbJtqGQd02+hCUW3jx110zqTCJS7N011OXqu0YadbUNVaFc0JwB/GRwto3wxTRAQaWvRtGzjpjwseaf1jdyTAmooRcoEZRxtkSXrwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeA624QE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeA624QE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAD81F00893;
	Wed,  3 Jun 2026 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486779;
	bh=ksW6Gd7nEtm88cY41pNqvoOkC+O4H3mMs52alE+llJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oeA624QEzUKabCBZXp1AydaV4MahUn5n0Y/iNZY07EYnuSusChdoSWVG1AnycjUiV
	 4jge2jmzhokdt3DZqOOJXI+Moif/afXDkbdc36Q9vyISaz7BVtGBYUI7R53B5V/luD
	 rK0KbJVAp/1DE3QN6baVdsndseorLEjKsllVPquANkqUPaRUniV8ebbThbVhGEcbjl
	 57mOig96T27C4TNP1KuKlt6rhTXw7ZcMwvx2CjrhyTIDADjnCgvBMY6QaRXInc0FRq
	 GxbstfoCPw5LRfvBBfWlkHpNas9PocWPfrQl/sd/FMeGLrUHb+v1Xj67KynSmAP4dg
	 qr8cPVOWshGFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] PCI: Add device-specific reset for Qualcomm
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260603105853.326290-3-jtornosm@redhat.com>
References: <20260603105853.326290-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:39:38 +0000
Message-Id: <20260603113938.DCAD81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing Device Readiness Wait
- [High] Unprotected State Modifications (IOMMU ATS invalidation on suspend=
ed device)
- [Medium] Commit Message Discrepancy (IOMMU preparation)
--

commit d37c19884265543746b79161f5a1ed58d8af78d3
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add device-specific reset for Qualcomm devices

This commit adds a device-specific reset method for certain Qualcomm device=
s=20
(WCN6855, WCN7850, SDX62/SDX65) via D3cold/D3hot power cycling. It also
extracts a shared helper function for the power cycle transition.

> Extract a shared pci_dev_d3cold_d0_cycle() helper function to avoid code
> duplication between pci_d3cold_reset() (strict _PR3 requirement) and the
> new reset_d3cold_d3hot() device-specific reset (automaticfallback). The
> helper handles IOMMU preparation, performs the power cycle via
> pci_set_power_state(), and cleans up IOMMU state.

[Severity: Medium]
Is the description of the helper function accurate? The commit message stat=
es=20
that the helper handles IOMMU preparation and cleanup, but the extracted=20
pci_dev_d3cold_d0_cycle() function does not perform these operations and=20
explicitly requires the caller to handle them.=20

Could the commit message be updated to reflect the actual implementation?

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 096868f80cd4c..f7a7443287fdf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
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

[Severity: High]
Does this sequence need to wait for the device to become ready? After
returning to D0 via pci_set_power_state(), the device undergoes a reset,
and the PCI spec requires polling Configuration Request Retry Status (CRS)
before it is ready.

Unlike pci_pm_reset(), which explicitly calls pci_dev_wait(), this helper
returns immediately. Since callers like pci_d3cold_reset() and
reset_d3cold_d3hot() rely on this, will this cause the PCI core to execute
pci_dev_restore() before the device is responsive, potentially leading to
dropped configuration writes?

> +}
> +
>  /**
>   * pci_d3cold_reset - Put device into D3cold and back to D0 for reset
>   * @dev: PCI device to reset
> @@ -4520,22 +4546,13 @@ static int pci_d3cold_reset(struct pci_dev *dev, =
bool probe)
>  	if (probe)
>  		return 0;
> =20
> -	if (dev->current_state !=3D PCI_D0)
> -		return -EINVAL;
> -
>  	ret =3D pci_dev_reset_iommu_prepare(dev);

[Severity: High]
Can this trigger ATS invalidations on suspended devices?

By moving the power state check inside the pci_dev_d3cold_d0_cycle()
helper, pci_dev_reset_iommu_prepare() is now executed before verifying that
the device is in D0. If the device is currently in D3, interacting with
the IOMMU to detach domains can trigger PCIe ATS invalidations, which may
result in Master Aborts or completion timeouts.

Should the state check remain before IOMMU preparation?

>  	if (ret) {
>  		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
>  		return ret;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603105853.3262=
90-1-jtornosm@redhat.com?part=3D2
