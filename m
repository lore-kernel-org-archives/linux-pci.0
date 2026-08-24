Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E536C0AC
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787611918; cv=none; b=gD1IQRC4OHgsYhsiR1lkW1t7PEk4gJmCf3l5Ob0NmIFLT9eSPFoSEN8TBSR+BWuybqZHwJrjQzmEH4X3znFMnUZN8S1bAZUi+dloVg4szrCSjOioaKwCf5UB6GEsgC8jIihPpn9LJv2BKfceQNNxROnvp4OVeeNi4w4sDb8SN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787611918; c=relaxed/simple;
	bh=Gkoz+R9foAskNE8FLPf1HkOdKHlYMKjFa9tLhUTUVdM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rXfm6iQcyp+90oFuqAwRec7QhuMkLzVAmTPrWY6ZI41bdcD5wwVMIbT9H91FN1XmDigFc1RsoGcYJsaIO+YsOMo9iVwpwtqVvHPc0hopPsV1vz+its3elhp1y0y4khdaS9dzIwl3bDnHpet6+b6rIbgMBj+v8Ar0RtCyHouXVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7U72FN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7U72FN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCB11F000E9;
	Mon, 24 Aug 2026 22:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787611916;
	bh=XTBGEqbfIxtxKVJh0O4XD7cTA+aMgWnJMWneQBLuF4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T7U72FN65ZOG3N4G2MsU1w8CrjcQKZcnAbDF0/FyI4zTOyeuyL1Q75UZLNUymGY9B
	 GZHwnz79wdqVVFP9jl4jb0Bwdtyte9FAtnu4BbcH2kO21cLaIqE4vK0QOPCmJjrZgm
	 +5taqPctDDcCbqK+ef4DgeFxtD9IUD6sXJfq2KMBHr2a2HLHBrnnX0TbCCxjHyeyp4
	 Ytqi4rEGTMnybpZJp4lNxsiUEoSkN/krDKENBpk8GID4O0tXyjKMFFZWBDUIzDJkg3
	 xRuWcmmxo1X41azBTVEMFUE5kKxgU+mKSRJYkpd57SOuKnpvAR5FvgNVqAaC/BQ8uM
	 n6juYRt5FS7FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260824-pcie-lmt-v6-1-bab4ce233fa5@google.com>
References: <20260824-pcie-lmt-v6-1-bab4ce233fa5@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 22:51:55 +0000
Message-Id: <20260824225156.5BCB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Temporary ASPM disablement leaks into the permanently saved PCI co=
nfig state during resets or system suspend.
- [High] Inverted logic in pci_lmr_check_sample_multiple_rx() allows invali=
d concurrent margining.
- [High] Teardown race in pci_lmr_exit() causes resource leaks due to concu=
rrent debugfs accesses.
- [High] Direct modification of ASPM hardware registers bypasses the PCI AS=
PM subsystem and its locking.
- [High] ASPM L1 is restored in the wrong order, enabling the Downstream co=
mponent before the Upstream component.
- [Medium] Missing runtime PM reference before reading config space in debu=
gfs show callbacks.
- [Medium] Mixing goto-based error handling with guard() cleanup in margin_=
enable_write().
- [Medium] Error return code is clobbered in the cleanup path of margin_ena=
ble_write().
- [Medium] Lane array size and debugfs entries incorrectly initialized usin=
g Negotiated Link Width instead of Maximum Link Width.
--

--- Patch [1]: [PATCH v6] PCI/pcie: Add PCIe Lane Margining at Receiver (LM=
R) support ---
commit 2b24000364052ba88665b523eec643f2f9d276e4
Author: Priyank Rathod <rathodpriyank@google.com>
Subject: PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support

This commit adds support for PCIe Lane Margining at Receiver (LMR), which
allows software to evaluate high-speed link margins by measuring timing
and voltage steps for each physical lane. It exposes capabilities and
margining controls via debugfs.

Link: https://lore.kernel.org/r/20260820-pcie-lmt-v5-1-943b3b0e18bf@google.=
com

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

[Severity: High]
Is it possible that the temporary ASPM disablement leaks into the
permanently saved PCI configuration state here?

The PCI core calls pci_save_state() prior to this function, capturing the
state while LMR (and its temporary ASPM disablement) might be active. When
the reset finishes, pci_restore_state() might overwrite the hardware config
with this saved state, clobbering the correct restoration performed by
pci_reset_lmr().

> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c
[ ... ]
> +static void pci_lmr_disable_aspm(struct pci_margin_dev *mdev)
> +{
> +	struct pci_dev *dev =3D mdev->dev;
> +	struct pci_dev *parent =3D pci_upstream_bridge(dev);
> +	u16 ctl;
> +
> +	if (mdev->aspm_saved)
> +		return;
> +
> +	if (!pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &ctl)) {
> +		mdev->saved_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
> +		pcie_capability_clear_word(dev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);

[Severity: High]
Does modifying the ASPM hardware registers directly bypass the PCI ASPM
subsystem and its locking?

This clears the PCI_EXP_LNKCTL_ASPMC bits without holding the ASPM lock or
using the official PCI core APIs like pci_disable_link_state(). If the
ASPM core concurrently re-evaluates the link, or if userspace changes ASPM
policies, these direct modifications could race with or be clobbered by
the core's changes.

[ ... ]
> +static void pci_lmr_restore_aspm(struct pci_margin_dev *mdev)
> +{
> +	struct pci_dev *dev =3D mdev->dev;
> +	struct pci_dev *parent =3D pci_upstream_bridge(dev);
> +
> +	if (!mdev->aspm_saved)
> +		return;
> +
> +	pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> +					   PCI_EXP_LNKCTL_ASPMC,
> +					   mdev->saved_aspm);
> +	if (parent && pci_is_pcie(parent))
> +		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
> +						   PCI_EXP_LNKCTL_ASPMC,
> +						   mdev->saved_parent_aspm);

[Severity: High]
Does this restore the Downstream component before the Upstream component?

PCIe r6.0 sec 7.5.3.7 mandates that when enabling ASPM L1, software must
enable the Upstream component prior to enabling the Downstream component.
This sequence appears to execute the L1 enablement backward.

[Severity: High]
Could blindly restoring these cached ASPM bits erase legitimate ASPM policy
changes that might have occurred while margining was active?

[ ... ]
> +static int margin_caps_show(struct seq_file *s, void *v)
> +{
> +	struct pci_margin_dev *mdev =3D s->private;
> +	struct pci_dev *dev =3D mdev->dev;
> +	u16 cap;
> +	int ret;
> +
> +	ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap);

[Severity: Medium]
Could this return bogus configuration data (like 0xFFFF) to user space
if the device is in a lower power state (e.g., D3hot)?

There does not appear to be a pm_runtime_resume_and_get() call here to
ensure the device is in D0 before reading the config space.

[ ... ]
> +static int margin_port_status_show(struct seq_file *s, void *v)
> +{
> +	struct pci_margin_dev *mdev =3D s->private;
> +	struct pci_dev *dev =3D mdev->dev;
> +	u16 sts;
> +	int ret;
> +
> +	ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);

[Severity: Medium]
Similar to the capabilities check, should this function wake the device
before attempting to read the port status?

[ ... ]
> +static ssize_t margin_enable_write(struct file *file, const char __user =
*user_buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	struct seq_file *s =3D file->private_data;
> +	struct pci_margin_dev *mdev =3D s->private;
> +	struct pci_dev *dev =3D mdev->dev;
> +	unsigned long timeout;
> +	u16 sts, cap, lnksta;
> +	bool enable;
> +	int ret, i;
> +
> +	ret =3D kstrtobool_from_user(user_buf, count, &enable);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&mdev->lock);

[Severity: Medium]
Does this function mix goto-based error handling with guard() cleanup?

The function uses guard(mutex)(&mdev->lock) at the start but relies on
goto labels (like goto err_sw_ready) for error handling below. The kernel
cleanup subsystem guidelines specify that goto labels and scope-based
cleanup should not be mixed in the same function to avoid confusing
ownership semantics.

[ ... ]
> +err_sw_ready:
> +	if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
> +		ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
> +		if (ret =3D=3D PCIBIOS_SUCCESSFUL) {
> +			sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
> +			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
> +		}
> +	}
> +err_aspm:
> +	pci_lmr_restore_aspm(mdev);
> +err_rpm:
> +	pm_runtime_put_sync(&dev->dev);
> +	return ret;

[Severity: Medium]
Is the error return code clobbered in this cleanup path?

If a failure occurs (like -ETIMEDOUT), the code jumps to err_sw_ready. If
pci_read_config_word() succeeds here, ret is overwritten with 0
(PCIBIOS_SUCCESSFUL), masking the original error and returning success to
user space.

[ ... ]
> +static bool pci_lmr_check_sample_multiple_rx(struct pci_margin_dev *mdev,
> +					     struct pci_margin_lane *plane)
> +{
> +	struct pci_margin_rx_info *info =3D &plane->rx_info[plane->rx];
> +	int i;
> +
> +	if (info->caps & LMR_CAP_SAMPLE_MULTIPLE_RX)
> +		return true;
> +
> +	for (i =3D 0; i < mdev->num_lanes; i++) {
> +		struct pci_margin_lane *other =3D &mdev->lanes[i];
> +
> +		if (i =3D=3D plane->lane)
> +			continue;
> +		if (other->rx =3D=3D plane->rx &&
> +		    (other->timing_val !=3D 0 || other->voltage_val !=3D 0))
> +			return false;
> +	}
> +	return true;
> +}

[Severity: High]
Does this logic allow invalid concurrent margining while blocking valid
concurrent margining?

Per PCIe r6.0 sec 8.4.4, if 'Sample Multiple Receivers' is 0, software may
only margin a single receiver at a time across the link, but may do so on
any or all lanes.

The check "if (other->rx =3D=3D plane->rx)" appears inverted. It wrongly
blocks evaluating the same receiver on multiple lanes, but allows different
receivers to be margined simultaneously because they skip the return block.

[ ... ]
> +void pci_lmr_init(struct pci_dev *dev)
> +{
> +	struct pci_margin_dev *mdev;
> +	enum pci_bus_speed speed;
> +	u16 lmr, lnksta;
> +	int num_lanes, i;
> +
> +	if (WARN_ON_ONCE(!dev) || !pci_is_pcie(dev))
> +		return;
[ ... ]
> +	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +	num_lanes =3D FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);

[Severity: Medium]
Should the lane array size and debugfs entries be initialized using the
Maximum Link Width (PCI_EXP_LNKCAP_MLW) instead of the Negotiated Link
Width (PCI_EXP_LNKSTA_NLW)?

If the link trains to a reduced width at boot (e.g., x4 instead of x16) due
to power saving or retrain, the driver will lack the structures to margin
the upper lanes if it later retrains to its full width.

[ ... ]
> +void pci_lmr_exit(struct pci_dev *dev)
> +{
> +	struct pci_margin_dev *mdev =3D dev->lmr;
> +
> +	if (!dev || !mdev)
> +		return;
> +
> +	pci_suspend_lmr(dev);
> +
> +	pci_margin_debugfs_remove(mdev);
> +	mutex_destroy(&mdev->lock);
> +	kfree(mdev);
> +	dev->lmr =3D NULL;
> +}

[Severity: High]
Does pci_suspend_lmr() drop the lock before the debugfs files are removed?

pci_suspend_lmr() drops the lock after disabling LMR. Before
pci_margin_debugfs_remove() finishes, a concurrent write to the 'enable'
debugfs file could acquire the lock and re-enable margining. When teardown
completes, the hardware state and PM references initialized by the racing
write might be left dangling. Debugfs files usually need to be removed
before tearing down the associated hardware state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-pcie-lmt-v=
6-1-bab4ce233fa5@google.com?part=3D1
