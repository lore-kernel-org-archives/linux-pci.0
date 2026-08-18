Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0035B21A
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088770; cv=none; b=bVrijeNnNIAaHKPzQB+PxormxbTtZXKDjiABb3vBjl/lVdLxbsb+RjtW8zune12FTOXQTBG6Mch19lEBPDY35DYrlrlD5Y8gz2y91lOtK7fZgHFKwZw82UrtshbtgXLfUatL9fAn9HdkQ8HFkHBZoJjXOv8btMgNYHgOsNs79ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088770; c=relaxed/simple;
	bh=CpeCpSNYuEw4gKeqhrYWDAsZpUG9RzTzvdnpR4mNGwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j78x4t4FmxB1umJDMZvSkNSDzybfsTdti90dG+vMLH3jsHsyZ0h8LDyCfdeHdaoWpLswRpAQsf1Qe+SjivUK1wBqAdcYnGmd1Xl/ZLT2S6lY/NwGuz5bq08FAYbQE59WgnVPK4U4HEJCDW7PINdT70YU3N5f402xhLe7jim5oHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8ZqQhK4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8ZqQhK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58C11F000E9;
	Tue, 18 Aug 2026 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787088768;
	bh=aP6kdyZFxWB+gsO40XmpnJvdtID55mL7arQEvyRco+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M8ZqQhK47tfLJLSKTKpkE9hA8KS38i8a0a+m0pxeEkA0ZPlPJOQQgt10xw3LqUBpG
	 TV7djTARJhnFOI9sevAleKl/FTMZ1H4G6s1tDMu+2EwZbKX2838xgpxN3/ompu8KRH
	 OtX7Sf+sqJ/iYi8o5U81fIRoki8k+NlNRNIkSoN7gXKNGRovsLUcBLh2EK1lQ203ID
	 wHNsZZM+tdN0ZTvA0dxJTqYVOZEhM6YTTdPCgpc4CLnsHSWWiQNvG49LhA3PU52LUO
	 bzXnSqAvnc0WGCYI9FrVIm6iIZy4lVQ6s8AE0enj60e/1ZgSMBhe6qaVF210qk93RC
	 NJbE0BuMsLDPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260818-pcie-lmt-v4-1-eb17a6d755fa@google.com>
References: <20260818-pcie-lmt-v1-1-13716f446594@google.com>
 <20260818-pcie-lmt-v4-1-eb17a6d755fa@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 21:32:48 +0000
Message-Id: <20260818213248.A58C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Fast-path NAK detection instantly fails valid LMR commands due to =
stale NO_CMD status.
- [High] Teardown race in pci_lmr_exit() between hardware demargining and d=
ebugfs interface removal allows margining to be re-enabled during device de=
struction.
- [Medium] pci_reset_lmr() issues DEMARGIN commands after hardware reset, c=
ausing massive synchronous timeouts and kernel stalls.
- [Medium] Concurrent lockless initialization of pci_debugfs_root_dir can c=
orrupt the global pointer and break LMR debugfs system-wide.
- [Medium] Software state loses sync with hardware if margin commands time =
out, skipping subsequent demargin operations.
- [Medium] Ignoring pci_lmr_demargin_lane() failure in margin_lane_receiver=
_write() causes state confusion and hardware state leak.
- [Medium] Iterating over the Maximum Link Width (MLW) instead of Negotiate=
d Link Width (NLW) causes multi-second timeouts for inactive lanes.
--

--- Patch [1]: [PATCH v4] PCI/pcie: Add PCIe Lane Margining at Receiver (LM=
R) support ---
commit 08906bfa6b5ee5f4a64cb0f08b667e3fc86991d7
Author: Priyank Rathod <rathodpriyank@google.com>

PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support

Adds PCIe Lane Margining at Receiver (LMR) support, probing Extended Capabi=
lity
ID 0x27 on Gen4+ links. It exposes debugfs interfaces for margining enablem=
ent,
receiver selection, and execution of timing/voltage margin step commands.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..dc9724cb7b4d8 100644
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

[Severity: Medium]
Since this hook is called after the hardware reset has already wiped the
device state, won't this cause timeouts?

The pci_reset_lmr() function aliases to pci_suspend_lmr(), which
unconditionally loops over all margined lanes and issues DEMARGIN writes.
Because the device was just reset, its Margining SW Ready bit is 0,
causing the hardware to ignore the commands and the driver to stall
while waiting for the status register to update.

>  			return 0;
> +		}
> =20
>  		pci_dbg(dev, "%s failed with %d\n", method->name, rc);

[ ... ]

> diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
> new file mode 100644
> index 0000000000000..e9e195744d5ad
> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c

[ ... ]

> +static struct dentry *get_pci_debugfs_root(void)
> +{
> +	if (!pci_debugfs_root_dir)
> +		pci_debugfs_root_dir =3D debugfs_lookup("pci", NULL);
> +	if (!pci_debugfs_root_dir)
> +		pci_debugfs_root_dir =3D debugfs_create_dir("pci", NULL);

[Severity: Medium]
Could this lockless initialization race during concurrent probing?

If two threads enter simultaneously, both might see a NULL pointer and
attempt to create the directory. The second thread could receive
ERR_PTR(-EEXIST) and overwrite the valid pointer, breaking the debugfs
functionality system-wide for future LMR devices.

> +	return pci_debugfs_root_dir;
> +}

[ ... ]

> +static int pci_lmr_run_cmd(struct pci_dev *dev, int lane, u8 rx, u8 type,
> +			   u8 usage, u8 payload, u16 *status_val)
> +{

[ ... ]

> +		/*
> +		 * Per PCIe Base Spec r6.0 sec 8.4.4, if receiver echoes NO_CMD (0x7)
> +		 * after a command was sent, it indicates command rejection/NAK.
> +		 */
> +		if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D LMR_TYPE_NO_CMD &&
> +		    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx)
> +			return -EOPNOTSUPP;

[Severity: High]
Does this instantly abort valid commands due to a stale NO_CMD status?

The driver successfully issues a NO_CMD handshake earlier, leaving the
hardware status register with MTYPE =3D 0x7. It then issues the real command
and immediately polls the status register. Because hardware updates are
asynchronous, the first read likely returns the stale NO_CMD state, which
this check misinterprets as an immediate command rejection.

> +
> +		if (time_after(jiffies, timeout))
> +			break;

[ ... ]

> +static int pci_lmr_demargin_lane(struct pci_margin_lane *plane)
> +{
> +	u16 sts;
> +	int ret;
> +
> +	if (!plane || !plane->mdev)
> +		return -EINVAL;
> +
> +	if (plane->timing_val =3D=3D 0 && plane->voltage_val =3D=3D 0)
> +		return 0;

[Severity: Medium]
What happens if a previous margin command timed out before updating the
cached state?

If a prior command returns -ETIMEDOUT, the driver skips updating
plane->timing_val even if the hardware actually applied the margin. When
demargining is requested later, this check short-circuits because
timing_val is 0, completely skipping the hardware DEMARGIN command and
leaving the physical lane permanently margined.

> +
> +	ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, plane->rx,
> +			      LMR_TYPE_DEMARGIN, 0, 0, &sts);

[ ... ]

> +static ssize_t margin_enable_write(struct file *file, const char __user =
*user_buf,
> +			       size_t count, loff_t *ppos)
> +{

[ ... ]

> +		/* Cache capabilities for local receiver on all lanes */
> +		for (i =3D 0; i < mdev->num_lanes; i++) {
> +			mdev->lanes[i].rx =3D LMR_RX_LOCAL;
> +			pci_lmr_cache_rx_info(&mdev->lanes[i], LMR_RX_LOCAL);
> +		}

[Severity: Medium]
Will this loop over physically inactive lanes if the negotiated link width
is less than the maximum link width?

If the device has downgraded links (for instance, an x16 card in an x4 slot=
),
these commands will silently time out for every inactive lane. Could we use
the Negotiated Link Width (PCI_EXP_LNKSTA_NLW) instead to avoid a multi-sec=
ond
stall?

> +		mdev->enabled =3D true;

[ ... ]

> +static ssize_t margin_lane_receiver_write(struct file *file, const char =
__user *user_buf,
> +				      size_t count, loff_t *ppos)
> +{

[ ... ]

> +	if (mdev->enabled) {
> +		/* Demargin previous receiver per single-receiver spec rule */
> +		pci_lmr_demargin_lane(plane);
> +		ret =3D pci_lmr_cache_rx_info(plane, rx);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	plane->rx =3D rx;

[Severity: Medium]
Is it safe to ignore the return value of pci_lmr_demargin_lane() here?

If the demargin command fails (e.g., via NAK or timeout), the active
timing_val and voltage_val are not cleared, but plane->rx is unconditionally
updated. This causes the new receiver to incorrectly inherit the margin sta=
te
of the old receiver, leaving the old receiver permanently margined in
hardware.

> +out:
> +	mutex_unlock(&mdev->lock);

[ ... ]

> +static ssize_t margin_lane_timing_write(struct file *file, const char __=
user *user_buf,
> +				    size_t count, loff_t *ppos)
> +{

[ ... ]

> +	ret =3D pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
> +			      LMR_TYPE_TIMING, 0,
> +			      (step & LMR_TIMING_STEP_MASK) | (dir << LMR_TIMING_DIR_SHIFT), =
&sts);
> +	if (ret)
> +		goto out;

[Severity: Medium]
When pci_lmr_run_cmd() times out, it returns without updating the cached
state. This leads to the software state losing sync with the hardware,
preventing subsequent demargin operations from executing successfully.

> +
> +	/* Record actual step count applied by hardware */
> +	step =3D FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts) & LMR_TIMING_STEP_MAS=
K;
> +	plane->timing_val =3D (dir =3D=3D LMR_STEP_DIR_DECREASE) ? -step : step;

[ ... ]

> +void pci_lmr_init(struct pci_dev *dev)
> +{

[ ... ]

> +	pcie_capability_read_word(dev, PCI_EXP_LNKCAP, &lnkcap);
> +	mdev->num_lanes =3D FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);

[Severity: Medium]
Does this allocate the array and set bounds based on the Maximum Link Width
instead of the active Negotiated Link Width?

If the active link is narrower than the capability, the driver will later
attempt to issue I/O commands to disconnected lanes, which will dependably
time out.

> +
> +	if (mdev->num_lanes =3D=3D 0 || mdev->num_lanes > LMR_MAX_LANES) {

[ ... ]

> +void pci_lmr_exit(struct pci_dev *dev)
> +{
> +	struct pci_margin_dev *mdev =3D dev->lmr;
> +	int i;
> +
> +	if (!mdev)
> +		return;
> +
> +	mutex_lock(&mdev->lock);
> +	if (mdev->enabled) {
> +		for (i =3D 0; i < mdev->num_lanes; i++)
> +			pci_lmr_demargin_lane(&mdev->lanes[i]);
> +	}
> +	mutex_unlock(&mdev->lock);
> +
> +	pci_margin_debugfs_remove(mdev);

[Severity: High]
Does releasing the lock before disabling the state create a race condition
with debugfs writers?

Because mdev->enabled is not set to false and the SW_READY bit isn't
cleared, a concurrent debugfs writer blocked on mdev->lock could wake up
right after the unlock and issue new margining commands to the hardware
just before the driver tears down the structures.

> +	mutex_destroy(&mdev->lock);
> +	kfree(mdev->lanes);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-pcie-lmt-v=
4-1-eb17a6d755fa@google.com?part=3D1
