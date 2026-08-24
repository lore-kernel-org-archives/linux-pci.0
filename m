Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033F395AD3
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787611877; cv=none; b=cONLmlH3skwQMcpYcB4e4b9jVHuYPJmaHlMuvuPgbPMAazcC1QmQDQ1yG1zd+zsD3gd+uP0O9DN4PVlzwfZOY/XefFniz232LeRKjHe0lp8D4oyszgkrtY3jvoQE43Txnm09p7SOWBhAHtAxohopnXfCzqmz6fqyRRGi0mqgkNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787611877; c=relaxed/simple;
	bh=o1Gr2e00zG6+BOs6CckhzmiTdEjqTtdWuz+/H47TM/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k/Yw+ZvpkULzs/VSb++qXQdKbFCXphVqavHIJDhWpXgTXxQWrX1KDZlN+QjEFCgQmu3gIgdlkrOkfvZqKl9X5age5ZZsTjt7TVkwZc6cSyEPjNhxEWuKpoQ8YBoxIoccMomj0sE8Ov4dabaxhYTCb3GH2DJY346sdYcFG6M40nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoFIM9ft; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoFIM9ft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A743B1F000E9;
	Mon, 24 Aug 2026 22:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787611875;
	bh=87Y5ghH4ldt7gsksBDe7NVVM5pjgv1r3VrWwQ4jCRrg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LoFIM9ftgo6o6/L/Zc37dCh8rnAbqPTbk4bukggUyvPAiJJuUjqO6u2ereg8t7A/a
	 SUP+GP7zUHqyuJaOmj1T6S1U3rrXap9TdJAUurqWooirKs7J6bB88GB0e9LzcYOQuH
	 hvHRu6ZTXrH1Wz4gpnF8mzip4NHLkOcrcRWUDzdnXpC1AxilHaaQmhCrV863Vu8BMF
	 eG9RlnQQp0NTp6SwivAF+98pqnR/muTN+oTrW9aPTLYqvdJ8+Xg5vGEMHUXVRabL0C
	 uhUaDpReniIVIvH6noDusRtYLb4WCG1OSd5LB+4wN8uey1BAE8Pt2tssYxc8tbMiV2
	 DivGJJDc2Vhyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260824-pcie-lmt-v6-1-86ada768b0c8@google.com>
References: <20260824-pcie-lmt-v6-1-86ada768b0c8@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 22:51:15 +0000
Message-Id: <20260824225115.A743B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Device ASPM state is permanently disabled after a PCI reset becaus=
e `pci_restore_state()` clobbers the correctly restored LMR ASPM configurat=
ion.
- [High] Concurrent execution of sysfs device reset and device removal lead=
s to a Use-After-Free of `dev->lmr` and its mutex.
- [High] Incorrect teardown ordering in `pci_lmr_exit()` allows concurrent =
debugfs writes to permanently leak an RPM reference and leave upstream ASPM=
 disabled.
- [Medium] LMR software state is not suspended during hibernation, leading =
to a mismatch between software tracking and hardware state upon thaw/restor=
e.
- [Medium] The driver violates PCIe specification requirements by failing t=
o automatically issue a Demargin command before reversing margin directions.
- [Medium] The error cleanup path in `margin_enable_write()` clobbers the o=
riginal negative error code, causing the function to silently return succes=
s.
- [Medium] Secondary Bus Resets (SBR) bypass device-specific reset handlers=
, permanently desynchronizing LMR software state and leaking the runtime PM=
 reference.
- [Medium] The driver writes 1 to reserved direction bits when configuring =
devices that only support symmetric margining.
--

--- Patch [1]: [PATCH v6] PCI/pcie: Add PCIe Lane Margining at Receiver (LM=
R) support ---
commit 23e30598998c8cd47f12107ec01b8ff50f90586b
Author: Priyank Rathod <rathodpriyank@google.com>
Subject: PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support

This patch introduces support for PCIe Lane Margining at Receiver (LMR). It
adds debugfs controls to allow manual execution of timing and voltage margin
steps on capable receivers, along with basic state management.

Link: https://lore.kernel.org/r/20260820-pcie-lmt-v5-1-943b3b0e18bf@google.=
com

> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -821,6 +821,7 @@ static int pci_pm_suspend(struct device *dev)
>  	 * since Coffee Lake, to enter a lower-power PM state.
>  	 */
>  	pci_suspend_ptm(pci_dev);
> +	pci_suspend_lmr(pci_dev);
> =20
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend(dev, PMSG_SUSPEND);

[Severity: Medium]
Does this miss hibernation (S4) support?=20

The LMR suspend is hooked into pci_pm_suspend() for S3 sleep, but=20
pci_pm_freeze() and pci_pm_poweroff() don't appear to call pci_suspend_lmr(=
).=20
If the system hibernates, the device loses power and the margining state=20
resets, but upon resume, mdev->enabled would still be true, leaving ASPM=20
tracking desynchronized and a leaked runtime PM reference.

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
>  			return 0;
> +		}
> =20
>  		pci_dbg(dev, "%s failed with %d\n", method->name, rc);

[Severity: High]
Will the ASPM restoration in pci_reset_lmr() be immediately clobbered here?=
=20

The pci_reset_function() sequence calls pci_save_state() before this, and=20
pci_restore_state() afterwards. If pci_reset_lmr() restores the ASPM hardwa=
re=20
state to its original configuration, won't pci_restore_state() subsequently=
=20
blindly overwrite it with the saved config space (where ASPM was disabled b=
y=20
LMR), leaving ASPM permanently disabled?

[Severity: Medium]
By hooking LMR reset cleanup exclusively here in __pci_reset_function_locke=
d(),=20
do we miss Secondary Bus Resets (SBR)?=20

If a root user triggers a bus reset via the parent bridge, the downstream=20
devices are reset using a different path. The hardware LMR state would be=20
wiped, but pci_reset_lmr() is never invoked, leaving mdev->enabled as true=
=20
and failing to drop the runtime PM reference.

> --- a/drivers/pci/pcie/margin.c
> +++ b/drivers/pci/pcie/margin.c
[ ... ]
> @@ -557,6 +557,13 @@ static ssize_t margin_enable_write(struct file *file=
, const char __user *user_buf,
>  	mdev->enabled =3D true;
>  	return count;
> =20
> +err_sw_ready:
> +	if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
> +		ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
> +		if (ret =3D=3D PCIBIOS_SUCCESSFUL) {
> +			sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
> +			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
> +		}
> +	}
> +err_aspm:

[Severity: Medium]
Does this error cleanup path accidentally clobber the original negative err=
or=20
code?=20

If an error like -ETIMEDOUT occurs above, the jump to err_sw_ready issues a=
=20
pci_read_config_word(). If that read succeeds, ret is overwritten with=20
PCIBIOS_SUCCESSFUL (0). The function will then silently return 0 instead of=
=20
propagating the actual failure to userspace.

[ ... ]
> @@ -732,6 +732,10 @@ static ssize_t margin_lane_step_write(struct file *f=
ile, const char __user *user_buf,
>  	if (!mdev->enabled)
>  		return -EBUSY;
> =20
> +	if (val =3D=3D 0) {
> +		ret =3D pci_lmr_demargin_lane(plane);
> +		return ret ? ret : count;
> +	}
> +
> +	ret =3D pci_lmr_cache_rx_info(plane, plane->rx);

[Severity: Medium]
Are we missing an automatic demargin when changing margin directions?=20

The code issues a demargin command if the requested value is exactly 0, but=
=20
if a user sequentially writes a positive offset and then a negative offset =
(or=20
vice versa), the driver issues the new step command immediately. Per the PC=
Ie=20
Base Specification, software must issue a Demargin (or Clear Margin) comman=
d=20
before changing margin directions to avoid undefined behavior or NAKs.

[ ... ]
> @@ -754,6 +758,11 @@ static ssize_t margin_lane_step_write(struct file *f=
ile, const char __user *user_buf,
>  		if (val < 0) {
>  			if (!(caps & LMR_CAP_IND_LEFT_RIGHT_TIMING))
>  				return -EINVAL;
>  			step =3D -val;
>  			dir =3D LMR_STEP_DIR_DECREASE;
>  		} else {
>  			step =3D val;
>  			dir =3D LMR_STEP_DIR_INCREASE;
>  		}

[Severity: Medium]
Does this write 1 to a reserved direction bit on symmetric-only receivers?=
=20

For positive margins, the code unconditionally assigns=20
dir =3D LMR_STEP_DIR_INCREASE (1). If the receiver doesn't support independ=
ent=20
left/right or up/down margining, the PCIe Base Specification designates the=
=20
direction bits as Reserved, so they should be written as 0.

[ ... ]
> @@ -983,6 +983,16 @@ void pci_lmr_exit(struct pci_dev *dev)
>  {
>  	struct pci_margin_dev *mdev =3D dev->lmr;
> =20
> +	if (!dev || !mdev)
> +		return;
> +
> +	pci_suspend_lmr(dev);
> +
> +	pci_margin_debugfs_remove(mdev);
> +	mutex_destroy(&mdev->lock);
> +	kfree(mdev);
> +	dev->lmr =3D NULL;
>  }

[Severity: High]
Does this teardown ordering allow concurrent debugfs writes to leak a runti=
me=20
PM reference?=20

By calling pci_suspend_lmr() before pci_margin_debugfs_remove(), a concurre=
nt=20
write to the enable file could be blocked on mdev->lock. Once=20
pci_suspend_lmr() sets enabled =3D false and releases the lock, the write t=
hread=20
wakes up, sees enabled is false, enables LMR again, acquires a runtime PM=20
reference, and disables ASPM. Then pci_margin_debugfs_remove() completes an=
d=20
the structure is freed, abandoning the newly created hardware and RPM state.

[ ... ]
> @@ -1029,6 +1039,11 @@ void pci_reset_lmr(struct pci_dev *dev)
>  {
>  	struct pci_margin_dev *mdev =3D dev->lmr;
> =20
> +	if (!dev || !mdev)
> +		return;
> +
> +	guard(mutex)(&mdev->lock);
> +	pci_lmr_reset_software_state_locked(mdev);
>  }

[Severity: High]
Can a concurrent device removal and sysfs reset trigger a use-after-free he=
re?=20

In pci_lmr_exit(), mdev is freed and dev->lmr is set to NULL without holdin=
g=20
the device_lock. If a concurrent sysfs reset triggers pci_reset_function()=
=20
(which acquires device_lock) and calls pci_reset_lmr(), it might read the=20
dev->lmr pointer just before pci_lmr_exit() nullifies it. It would then=20
attempt to lock the mutex of the already freed mdev structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-pcie-lmt-v=
6-1-86ada768b0c8@google.com?part=3D1
