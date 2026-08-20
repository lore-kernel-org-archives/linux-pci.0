Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C03769F5
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262680; cv=none; b=AIgHL20VCqWbZDMJXRHHrEHNaim1WM7I9eHtn9URPxb+T3DR3f5L2w0ClT8vOVew7tMg5Q6gNi7gahg7XGBaf0cUk8cOy3QbgnWT02UQ/zWneJRyWOMXBCejYkuxw6jELe9JFj34bM86UDIYtT/R70L4dKl+wN5ImwSOmMJsV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262680; c=relaxed/simple;
	bh=xvvIjQc9U37VbFRbUs1bntDXmoB5TlyrUUsgV5s7YNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YrS802dKUeXVJJgGp0H2aEQ+nDGVyZAIGVqr8kdzvMikVoxu3oM2olsGdPzIwcHbcVraAFQuca7n4QGQLB3K5k7PBu0XcqZ5xY4VLvfazOykQBUY6Xfd4uX5I7+AyV+wAQMLhussalIKvRIOY+/Utc9MmQJEB1cUOsbaJz7d04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1vi/axg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1vi/axg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919791F00A3A;
	Thu, 20 Aug 2026 21:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787262678;
	bh=Kw1TQloozns5q4Mvcg+HOS7nnAmr8p/92h7WIANIilg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1vi/axgGr5Lp3IQgGFyjx4QUuf+DqDAnqzNE4JRRsOmhfy7C1K5ijBQ0GqFiTyd2
	 4BShoVcDOxR1YygU1bAPyXCW9nmiF/VKU+Q37sm2tbu0PVNTSAmHJqK7W93MUyIPoQ
	 wF72O5OeVD3IHU3OdO2O2Bjmk/PgVRLVgGKdmdq4Zh4QcOSQdwnfvHpvghlb4x4FgC
	 D19SDK/R3SixA9iCWp8n1FVhMo4y3ejGarOUcHJPtVX/NnTG/a0MA97lL52Isw/Zqu
	 qm4ROl6lywXW65v92DenfRDBZ686guHd4oZbHf5H/SjvHIJ3fjRmihfwUzuKdql4gt
	 HbZMfHLcF58jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260820-pcie-lmt-v5-1-943b3b0e18bf@google.com>
References: <20260820-pcie-lmt-v5-1-943b3b0e18bf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 21:51:18 +0000
Message-Id: <20260820215118.919791F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Asynchronous pm_runtime_put() is used immediately before device_de=
l(), causing race conditions on device teardown.
- [High] Spurious command failure (-EOPNOTSUPP) in pci_lmr_run_cmd() due to=
 a fast-path NAK check racing with hardware state updates.
- [High] Graceful LMR suspend on reset device causes timeout delays and sta=
te corruption.
- [High] Direct modification of ASPM Link Control registers bypasses the PC=
I core ASPM subsystem.
- [High] Runtime PM violations with unprotected config space reads.
- [Medium] Mixing guard() lock acquisition with goto-based error handling i=
n margin_enable_write().
- [Medium] Incorrect bitmask used when extracting the maximum number of tim=
ing steps.
--

--- Patch [1]: [PATCH v5] PCI/pcie: Add PCIe Lane Margining at Receiver (LM=
R) support ---
commit 067656b09520551d8f1bf1f71cfd2550c4c5e0ba
Author: Priyank Rathod <rathodpriyank@google.com>

PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support

This commit introduces driver and debugfs support for PCIe Lane Margining at
Receiver (LMR). It exposes per-device interfaces to evaluate high-speed link
margins by controlling receiver selection and margin steps.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5145,8 +5145,10 @@ int __pci_reset_function_locked(struct pci_dev *de=
v)
>  		method =3D &pci_reset_fn_methods[m];
>  		pci_dbg(dev, "reset via %s\n", method->name);
>  		rc =3D method->reset_fn(dev, PCI_RESET_DO_RESET);
> -		if (!rc)
> +		if (!rc) {
> +			pci_reset_lmr(dev);
> +			return 0;
> +		}

[Severity: High]
Does calling pci_reset_lmr() here attempt to communicate with hardware that=
 has
just been reset?

If the hardware state is already cleared by reset, delegating to the gracef=
ul
suspend routine might time out when trying to issue demargin commands to
inactive hardware.

> diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
> --- a/drivers/pci/pcie/margin.c
> +++ b/drivers/pci/pcie/margin.c
[ ... ]
> @@ -183,6 +183,23 @@ static struct dentry *get_pci_debugfs_root(void)
> =20
>  /*
>   * pci_lmr_disable_aspm() - Temporarily disable ASPM L0s/L1 during active
>   * margining per PCIe Base Spec r6.0 sec 8.4.4, saving original ASPMC bi=
ts.
>   */
>  static void pci_lmr_disable_aspm(struct pci_margin_dev *mdev)
>  {
>  	struct pci_dev *dev =3D mdev->dev;
>  	struct pci_dev *parent =3D pci_upstream_bridge(dev);
>  	u16 ctl;
> =20
>  	if (mdev->aspm_saved)
>  		return;
> =20
>  	if (!pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &ctl)) {
>  		mdev->saved_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
>  		pcie_capability_clear_word(dev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);
>  	}
> =20
>  	if (parent && pci_is_pcie(parent)) {
>  		if (!pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &ctl)) {
>  			mdev->saved_parent_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
>  			pcie_capability_clear_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASP=
MC);
>  		}

[Severity: High]
Does directly modifying the ASPM Link Control registers here bypass the PCI
core ASPM subsystem's refcounting and synchronization?

If multiple child devices on the same bridge enable LMR concurrently, they
might race when manipulating the shared parent upstream bridge config space.
When one child restores its saved state, it might inadvertently re-enable
ASPM while a sibling is still actively margining.

[ ... ]
> @@ -240,6 +240,55 @@ static int pci_lmr_run_cmd(struct pci_dev *dev, int =
lane, u8 rx, u8 type,
[ ... ]
>  	timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
>  	while (1) {
>  		if (pci_read_config_word(dev, sts_offset, &sts))
>  			return -EIO;
>  		if (PCI_POSSIBLE_ERROR(sts))
>  			return -ENODEV;
> =20
>  		if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D type &&
>  		    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx) {
>  			if (status_val)
>  				*status_val =3D sts;
>  			return 0;
>  		}
> =20
>  		/*
>  		 * Per PCIe Base Spec r6.0 sec 8.4.4, if receiver echoes NO_CMD (0x7)
>  		 * after a command was sent, it indicates command rejection/NAK.
>  		 */
>  		if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D LMR_TYPE_NO_CMD &&
>  		    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx)
>  			return -EOPNOTSUPP;

[Severity: High]
Is there a risk that this fast-path NAK check will read a stale NO_CMD stat=
us
from the previous step?

Hardware state machine updates are typically not instantaneous. If the stat=
us
register is polled immediately after writing the new command, it may still
contain the NO_CMD state from the prior handshake.

This might cause valid margining commands to spuriously fail with -EOPNOTSU=
PP
before they have a chance to complete.

[ ... ]
> @@ -279,6 +279,11 @@ static int pci_lmr_cache_rx_info(struct pci_margin_l=
ane *plane, u8 rx)
>  	if (ret)
>  		return ret;
>  	info->caps =3D pci_lmr_sts_payload(sts);
> =20
>  	ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
>  			      LMR_TYPE_REPORT_TIMING_STEPS, 0, 0, &sts);
>  	if (ret)
>  		return ret;
>  	info->num_timing_steps =3D FIELD_GET(LMR_STEPS_MASK, pci_lmr_sts_payloa=
d(sts));

[Severity: Medium]
Should this use LMR_TIMING_STEP_MASK instead of LMR_STEPS_MASK?

The PCIe Base Specification defines the Max Timing Margin payload as 6 bits.
Since LMR_STEPS_MASK uses a 7-bit mask (GENMASK(6,0)), the driver might par=
se
an incorrectly large step limit if the device sets bit 6.

[ ... ]
> @@ -406,6 +406,17 @@ static void __pci_suspend_lmr_locked(struct pci_dev =
*dev)
>  	if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts) =3D=
=3D 0) {
>  		sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
>  		pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
>  	}
>  	pci_lmr_restore_aspm(mdev);
>  	pm_runtime_put(&dev->dev);
>  	mdev->enabled =3D false;
>  }

[Severity: High]
Does this asynchronous pm_runtime_put() create a race condition during devi=
ce
teardown?

In pci_destroy_dev(), device_del() is called immediately after pci_lmr_exit=
():

drivers/pci/remove.c:pci_destroy_dev() {
    ...
	pci_lmr_exit(dev);
	/* ... */
	pci_tsm_destroy(dev);
	device_del(&dev->dev);
    ...
}

Using pm_runtime_put_sync() instead might ensure the device reaches the pro=
per
power state and that pending idle/suspend work is completed before the devi=
ce
structures are removed.

[ ... ]
> @@ -428,6 +428,74 @@ static ssize_t margin_enable_write(struct file *file=
, const char __user *user_buf,
>  			       size_t count, loff_t *ppos)
>  {
[ ... ]
>  	guard(mutex)(&mdev->lock);
> =20
>  	if (mdev->enabled =3D=3D enable)
>  		return count;
> =20
>  	if (!enable) {
>  		__pci_suspend_lmr_locked(dev);
>  		return count;
>  	}
> =20
>  	/* PCIe r6.0 sec 8.4.4: LMR is physically undefined below 16.0 GT/s (Ge=
n4) */
>  	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  	if ((lnksta & PCI_EXP_LNKSTA_CLS) < PCI_EXP_LNKSTA_CLS_16_0GB)
>  		return -EOPNOTSUPP;
> =20
>  	if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap))
>  		return -EIO;
> =20
>  	/* Prevent D3hot runtime PM transition during active margining */
>  	ret =3D pm_runtime_resume_and_get(&dev->dev);

[Severity: High]
Can these configuration space reads return invalid data if the device is
currently in the D3hot power state?

Reading PCI_EXP_LNKSTA and PCI_LMR_PORT_CAP before calling
pm_runtime_resume_and_get() could return 0xFFFF or 0. This might cause the
link speed check to fail incorrectly, or cause the driver to erroneously see
USES_SW_READY as true.

>  	if (ret < 0)
>  		return ret;
[ ... ]
>  	if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
>  		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts)) {
>  			ret =3D -EIO;
>  			goto err_enable;
>  		}
>  		sts |=3D PCI_LMR_PORT_STS_SW_READY;
>  		pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
>  	}
> =20
>  	timeout =3D jiffies + msecs_to_jiffies(LMR_ENABLE_TIMEOUT_MS);
>  	while (1) {
>  		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts)) {
>  			ret =3D -EIO;
>  			goto err_enable;
>  		}
[ ... ]
>  err_enable:
>  	if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
>  		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts) =3D=
=3D 0) {

[Severity: Medium]
Is it safe to mix goto-based error handling with scope-based lock acquisiti=
on
in the same function?

While the label is at the end of the scope here, mixing the goto pattern
with guard(mutex)(&mdev->lock) makes ownership semantics less clear and mig=
ht
increase the risk of resource leaks or locking issues during future updates.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820-pcie-lmt-v=
5-1-943b3b0e18bf@google.com?part=3D1
