Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDBC3BB48
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879582; cv=none; b=YR2ck/O55+CMhhIaGztwlMwwcvAsPO2G6rtN8ZnehvmoKMf12azRWx7RSGiWc2uDsNz7h7atopyyCqGE+76wi0aPuNWFd/ebeGtb/w/WHJY+VNcbZZ2QVMbLr65LjKe2MvP02iTlMoncV5K537mV+lOn2B8inRKPUfZpsIppxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879582; c=relaxed/simple;
	bh=n6DGw4dV1Hlh/6xaMObhUej1I41DSnABXNd3O0tuycs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gyqYDJKrMD8RkYZ32LX9zqudJTFJJZ5Ali8mZN3RWHZ/stpF3SjPY51wiFZiXAmBX+uC25xJQTHLTZ9uUOu9zZz1+qjJjpkNsERrvw1hHhvLdKD6BNuBtjwa3vnCeDFHM/ciBr3z9fn7v+ojHTDqAIWiVr2OIWUm26+ALHAyui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOe+4L4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOe+4L4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5769D1F000E9;
	Fri, 28 Aug 2026 01:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787879580;
	bh=nyAw2QKtPuJognlTSQxROBicn6t7fe2mSfPP5V6Skfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZOe+4L4psDaYkxi9R3hJSfWGAhCBLfz1F0WhuTtH6otNNrD/8h8ihet3xn0yCIVjD
	 gn1RMVaLC/69Bo7rpsJ4XEsQem8HX7P1PEROR1nC61rUZlQ2cbs0fngiIX+wwdcXZU
	 GA/Yv7qTpw9CmE42sswJdGBLGweDhCijblsu12UGcMlJi6oqaFI2TiJYc7eruTgJ3t
	 4nPIztp+Ju4XKDew8r+t0duX4iulqmC/jXLc8aIfO2g5E+6sPXP03/hgehix84AgxW
	 kT9HK786WWJrRjDwd1DOULJIVKSyzMTuuGfEZjPCDvrpB3Yn7gZe1NhKunH09dQ01P
	 nZc752idAioew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260828-pcie-lmt-v7-1-6012e9e0940a@google.com>
References: <20260828-pcie-lmt-v7-1-6012e9e0940a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 01:12:59 +0000
Message-Id: <20260828011300.5769D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Fast-path NAK detection is nested inside the timeout block, forcin=
g a 150ms delay on every NAK.
- [High] Lock mismatch in `margin_enable_write` when disabling margining le=
aves the remote target device unprotected.
- [High] Direct hardware modification of ASPM and link control bypasses the=
 kernel ASPM subsystem and remote device locks, causing state corruption.
--

commit ec623c281254474c94a2e37656d0693bdc62d283
Author: Priyank Rathod <rathodpriyank@google.com>
PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support

This commit adds driver and debugfs support for PCIe Lane Margining at
Receiver (LMR) on Gen4+ links. It introduces Kconfig options and debugfs
interfaces to control margining, configure target receivers, and run timing
and voltage margin steps.

> diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
> new file mode 100644
> index 0000000000000..a428726c500db
> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c
[ ... ]
> +static void pci_lmr_aspm_inhibit(struct pci_margin_dev *mdev, bool inhib=
it)
> +{
[ ... ]
> +		/*
> +		 * 1. Downstream Component (upstream_port) must be disabled
> +		 * FIRST per sec 7.5.3.7.
> +		 */
> +		if (upstream_port && pci_is_pcie(upstream_port) &&
> +		    upstream_port->current_state =3D=3D PCI_D0) {
> +			if (!pcie_capability_read_word(upstream_port, PCI_EXP_LNKCTL, &ctl)) {
> +				mdev->saved_usp_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
> +				pcie_capability_clear_word(upstream_port, PCI_EXP_LNKCTL,
> +							   PCI_EXP_LNKCTL_ASPMC);
> +			}
> +		}
> +
> +		/*
> +		 * 2. Upstream Component (downstream_port) must be disabled
> +		 * SECOND per sec 7.5.3.7.
> +		 */
> +		if (downstream_port && pci_is_pcie(downstream_port) &&
> +		    downstream_port->current_state =3D=3D PCI_D0) {
> +			if (!pcie_capability_read_word(downstream_port, PCI_EXP_LNKCTL, &ctl)=
) {
> +				mdev->saved_dsp_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
> +				pcie_capability_clear_word(downstream_port, PCI_EXP_LNKCTL,
> +							   PCI_EXP_LNKCTL_ASPMC);
> +			}
> +		}

[Severity: High]
Does this direct hardware modification of ASPM registers bypass the kernel
ASPM subsystem and the remote device's lock?

By clearing ASPM bits directly in the config space without acquiring the
remote partner's pci_dev_lock, this could lead to data races and state
corruption if the core ASPM tracking state diverges from the physical
hardware.

[ ... ]
> +static void pci_lmr_ensure_aspm_inhibited(struct pci_margin_dev *mdev)
> +{
[ ... ]
> +	if (re_inhibit) {
> +		pci_info_ratelimited(mdev->dev,
> +				     "ASPM re-enabled unexpectedly; re-enforcing ASPM inhibit for LM=
R\n");
> +		/* Disable Downstream Component first, Upstream Component second per s=
ec 7.5.3.7 */
> +		if (upstream_port && pci_is_pcie(upstream_port))
> +			pcie_capability_clear_word(upstream_port, PCI_EXP_LNKCTL,
> +						   PCI_EXP_LNKCTL_ASPMC);

[Severity: High]
Is it safe to repair the ASPM mismatch with naked configuration writes here?

This TOCTOU gap modifies the remote partner's ASPM registers while entirely
omitting the remote pci_dev_lock and bypassing the core aspm_lock.

[ ... ]
> +static int pci_lmr_run_cmd(struct pci_margin_dev *mdev, int lane, u8 rx,=
 u8 type,
> +			   u8 usage, u8 payload, u16 *status_val)
> +{
[ ... ]
> +		if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D type &&
> +		    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx) {
> +			if (status_val)
> +				*status_val =3D sts;
> +			return 0;
> +		}
> +
> +		if (time_after(jiffies, timeout)) {
> +			/*
> +			 * Per PCIe Base Specification Revision 7.0 sec 4.2.18.2
> +			 * & Table 4-77 (r6.0 Table 4-73), if receiver echoes
> +			 * NO_CMD (0x7) after command issuance, it indicates NAK.
> +			 */
> +			if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D LMR_TYPE_NO_CMD &&
> +			    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx)
> +				return -EOPNOTSUPP;
> +			break;
> +		}
> +
> +		usleep_range(LMR_CMD_SLEEP_MIN_US, LMR_CMD_SLEEP_MAX_US);
> +	}

[Severity: High]
Does nesting the NAK check inside the timeout block defeat the fast-path?

If the target receiver responds with NO_CMD (0x7) immediately to indicate a
NAK, this logic appears to force the loop to wait the full 150ms timeout
before ever evaluating the NAK condition. Can this check be moved outside
the time_after() block?

[ ... ]
> +static ssize_t margin_enable_write(struct file *file,
> +				   const char __user *user_buf, size_t count,
> +				   loff_t *ppos)
> +{
[ ... ]
> +	pci_lmr_get_link_partners(dev, &downstream_port, &upstream_port);
> +
> +	/* Strict hierarchical lock order: Downstream Port (parent) before Upst=
ream Port (child) */
> +	if (downstream_port)
> +		pci_dev_lock(downstream_port);
> +	if (upstream_port && upstream_port !=3D downstream_port)
> +		pci_dev_lock(upstream_port);
> +
> +	mutex_lock(&mdev->lock);
> +
> +	if (mdev->enabled =3D=3D enable) {
> +		ret =3D count;
> +	} else if (!enable) {
> +		pci_lmr_disable_locked(mdev);
> +		ret =3D count;
> +	}

[Severity: High]
Can a topology change between margining enable and disable cause a lock
mismatch here?

When disabling margining, pci_dev_lock() is acquired on the dynamically
fetched upstream_port and downstream_port, but the teardown configuration
writes inside pci_lmr_disable_locked(mdev) operate on the globally cached
mdev->partner.

If the link partner has changed, does this leave the remote target device's
runtime PM and config state unprotected?

[ ... ]
> +void pci_reset_lmr(struct pci_dev *dev)
> +{
[ ... ]
> +		/* Restore original hardware ASPM before saved states can seal the lea=
k */
> +		pci_lmr_aspm_inhibit(mdev, false);
> +		pci_lmr_restore_autonomous(mdev);

[Severity: High]
Does pci_reset_lmr() invoke config space mutations on the remote partner
without acquiring the remote partner's pci_dev_lock?

It appears that this reset path triggers pci_lmr_aspm_inhibit() without
locking the remote device, potentially causing data races during reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-pcie-lmt-v=
7-1-6012e9e0940a@google.com?part=3D1
