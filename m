Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208033C19E
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083247; cv=none; b=foao7dmHaZHJvEIBb4Ud3cV/APsFqYhEZuyAFR9k53T3ersOEtuZ6JqLrm59eRRQqGGoAamapPzKyRe+r6Dn6srXpQyMt7nu5laZjM3pTv+Vlf+6asZj/BHmdMXH/MlSsAOuVVQsdngCnKj0TlHB6MGuIISGQbwLSioVcySk6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083247; c=relaxed/simple;
	bh=7KHMBP6wARQBVwiXT2b84SM43ec/dK1yPxh9b+qadiI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BIJsI3zZlgiKTg4etdVekdSoMItWBXgKV5gnvC65b1WGq81MDhs127gnaJ4K/H/eUlkM8x1Lbuot9Pgr6HqKuNBvn+K/UQAxMRfrSL0EdWIKZLmVPTheqj5EiZl+CCfzaM5hTUH5hRoBSgGRmm+ql6KZOuHNie858SVRBPhTNlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QERg39am; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QERg39am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C5D1F000E9;
	Tue, 18 Aug 2026 20:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787083245;
	bh=g6EUXqCOPakjCvKFN+FxbXtKThCwwn7TThf+EhjfbUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QERg39amlc+x9gqgV0KzUwFxczdQyy7siwlRqeh2P3YZ8s0HOgbH2Jqd+o3TJEtge
	 M5ERO0MKhViaWUVM/ju3fkM9wiAgYvjpU7Zplp3IBSh0FYIPqUnt6bCf7JWSQsE/o0
	 R94W/d9vBdBsHLAIlT2WlNC1LPJ7Xs/9lVBOxcGeQZHBRbd3YUre0B8ytUH2w6litj
	 F+RENAqpxKD5jqVW0NuOMMNT50KB5SqaFAC9BFfEE2a6iHeQtaIdK7BnOGkvl2tXMj
	 XHDoGoeJow/oQeJdp3KMMEAMajokbvI97YJI4o6aWqNx3foxBBA9Z0qUuxmeJod3Qt
	 q4yCPzVNLEeEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260818-pcie-lmt-v2-1-04ec6327f874@google.com>
References: <20260818-pcie-lmt-v1-1-13716f446594@google.com>
 <20260818-pcie-lmt-v2-1-04ec6327f874@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 20:00:45 +0000
Message-Id: <20260818200045.B3C5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Disabling LMR via debugfs fails to demargin lanes and incorrectly =
clears SW_READY, violating the PCIe specification.
- [High] ASPM (Active State Power Management) is not disabled during margin=
ing.
- [High] Issuing NO_CMD hardcodes the receiver number to 0, failing to clea=
r the margining status on the target receiver.
- [High] Changing the target receiver via debugfs abandons any active margi=
n on the previous receiver, violating the 'single Receiver per Lane' PCIe r=
ule.
- [High] Reading static capabilities dynamically issues hardware commands, =
which silently destroys the active margin.
- [High] Validation checks for independent margining support are inverted, =
rejecting valid symmetric margining commands.
- [Medium] The driver tracks relative step commands as absolute state and i=
gnores the applied margin step returned by the hardware.
- [Medium] Debugfs `show` functions and capability reads access shared stat=
e variables without holding `mdev->lock`, leading to TOCTOU races.
- [Medium] The software margining enable state (`mdev->enabled`) becomes de=
synchronized from the hardware state after a device suspend/resume or reset.
- [Low] Debugfs directory is created in the debugfs root instead of the PCI=
 subsystem directory.
--

--- Patch [1]: [PATCH v2] PCI/pcie: Add PCIe Lane Margining at Receiver (LM=
R) support ---
commit bbd05305a407b4fac659a5611ac2d3b6bcb799ef
Author: Priyank Rathod <rathodpriyank@google.com>

PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support

This commit adds kernel driver support, debugfs controls, and a kselftest
script for PCIe Lane Margining at Receiver (LMR). It allows system software
to evaluate high-speed link margins by measuring timing and voltage steps.

> diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
> index 0000000000000..c940b1f659071
> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c

[ ... ]

> +static int pci_lmr_run_cmd(struct pci_dev *dev, int lane, u8 rx, u8 type,
> +			   u8 usage, u8 payload, u16 *status_val)
> +{
> +	u16 lmr =3D dev->lmr_cap;
> +	u16 ctrl_offset =3D lmr + PCI_LMR_LANE_CTRL + LMR_LANE_REG_STRIDE * lan=
e;
> +	u16 sts_offset =3D lmr + PCI_LMR_LANE_STS + LMR_LANE_REG_STRIDE * lane;
> +	u16 ctrl, sts;
> +	unsigned long timeout;
> +
> +	/*
> +	 * Per PCIe Base Spec r6.0 sec 8.4.4, software must issue NO_CMD (0x7)
> +	 * to clear MTYPE in Lane Status before issuing a subsequent command.
> +	 */
> +	if (type !=3D LMR_TYPE_NO_CMD) {
> +		pci_write_config_word(dev, ctrl_offset,
> +				      FIELD_PREP(PCI_LMR_LANE_CTRL_MTYPE,
> +						 LMR_TYPE_NO_CMD));

[Severity: High]
Does this hardcode the receiver number to 0?

When margining a retimer (rx > 0), the prerequisite NO_CMD will be sent to
the local receiver (rx =3D 0) since RX_NUM is missing from the control regi=
ster
write. Can this corrupt the local receiver's command state and leave the
target retimer's margining status uncleared?

> +		timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);

[ ... ]

> +static ssize_t margin_enable_write(struct file *file, const char __user =
*user_buf,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct pci_margin_dev *mdev =3D ((struct seq_file *)file->private_data)=
->private;
> +	struct pci_dev *dev =3D mdev->dev;
> +	unsigned long timeout;
> +	bool enable;
> +	int ret, i;
> +	u16 sts, cap;
> +
> +	ret =3D kstrtobool_from_user(user_buf, count, &enable);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&mdev->lock);
> +
> +	if (mdev->enabled =3D=3D enable)
> +		goto out;

[Severity: Medium]
Can mdev->enabled become desynchronized from the hardware state after a
device suspend/resume or reset?

If the hardware margin state is reset during suspend/resume, mdev->enabled
remains true. Would the early exit here force the user to manually toggle t=
he
enable state off and on to recover?

> +
> +	if (enable) {
> +		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap)) {

[Severity: High]
Should active state power management be disabled during margining?

The PCIe 6.0 specification requires the link to be maintained in L0 during
margining. If ASPM is not disabled, could the link transition to low-power
states like L0s or L1, abort the margining process, and cause link instabil=
ity?

> +			ret =3D -EIO;
> +			goto out;
> +		}

[ ... ]

> +	} else {
> +		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts) =3D=
=3D 0) {
> +			sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
> +			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
> +		}
> +
> +		for (i =3D 0; i < mdev->num_lanes; i++) {
> +			mdev->lanes[i].timing_val =3D 0;
> +			mdev->lanes[i].voltage_val =3D 0;
> +		}
> +		mdev->enabled =3D false;
> +	}

[Severity: High]
Does this leave the hardware in a margined state when disabling LMR?

This clears SW_READY unconditionally but omits any NO_CMD or DEMARGIN comma=
nds.
Could this leave hardware receivers with an active margin offset when softw=
are
believes margining is disabled, potentially causing link drops?

> +
> +out:
> +	mutex_unlock(&mdev->lock);

[ ... ]

> +static ssize_t margin_lane_receiver_write(struct file *file, const char =
__user *user_buf,
> +				      size_t count, loff_t *ppos)
> +{
> +	struct pci_margin_lane *plane =3D ((struct seq_file *)file->private_dat=
a)->private;
> +	u8 rx;
> +	int ret;
> +
> +	ret =3D kstrtou8_from_user(user_buf, count, 0, &rx);
> +	if (ret)
> +		return ret;
> +
> +	if (rx > LMR_MAX_RX_NUM)
> +		return -EINVAL;
> +
> +	mutex_lock(&plane->mdev->lock);
> +	plane->rx =3D rx;
> +	mutex_unlock(&plane->mdev->lock);

[Severity: High]
Does changing the target receiver here abandon any active margin on the
previous receiver?

If a user writes a non-zero margin step to one receiver and then changes the
receiver number, the previous receiver appears to be left in an actively
margined state. Doesn't the PCIe specification restrict margining to a sing=
le
receiver per lane?

> +
> +	return count;
> +}

[ ... ]

> +static int margin_lane_caps_show(struct seq_file *s, void *v)
> +{
> +	struct pci_margin_lane *plane =3D s->private;
> +	struct pci_margin_dev *mdev =3D plane->mdev;
> +	u16 sts;
> +	int ret;
> +	u8 val;
> +
> +	ret =3D pci_lmr_run_cmd_locked(mdev, plane->lane, plane->rx,
> +				     LMR_TYPE_REPORT_CAPS, 0, 0, &sts);

[Severity: High]
Does reading static capabilities dynamically issue a hardware command that
silently destroys the active margin?

The PCIe specification states that issuing NO_CMD (which happens before the
REPORT_CAPS command) dictates the receiver must not apply any margin. Could
reading capabilities silently abort an active test without updating the
software tracking variables?

[Severity: Medium]
Can plane->rx be modified concurrently while being accessed here?

This accesses plane->rx locklessly before and after the command. Could a
concurrent write to the receiver debugfs file cause inconsistent output or
send commands to the wrong receiver?

> +	if (ret)
> +		return ret;
> +
> +	val =3D FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts);
> +	seq_printf(s, "Lane %d Rx %d Capabilities: %#02x\n", plane->lane, plane=
->rx, val);

[ ... ]

> +static ssize_t margin_lane_timing_write(struct file *file, const char __=
user *user_buf,
> +				    size_t count, loff_t *ppos)
> +{
> +	struct pci_margin_lane *plane =3D ((struct seq_file *)file->private_dat=
a)->private;
> +	struct pci_margin_dev *mdev =3D plane->mdev;
> +	int val, ret;
> +	u8 step, dir;
> +	u16 sts;
> +	u8 caps;
> +
> +	ret =3D kstrtoint_from_user(user_buf, count, 0, &val);

[ ... ]

> +	if (val < 0) {
> +		step =3D -val;
> +		dir =3D LMR_STEP_DIR_DECREASE;
> +	} else {
> +		step =3D val;
> +		dir =3D LMR_STEP_DIR_INCREASE;
> +		if (!(caps & LMR_CAP_IND_LEFT_RIGHT_TIMING)) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +	}

[Severity: High]
Are the validation checks for independent margining support inverted here?

For receivers that only support symmetric margining, the PCIe specification
requires the direction bit to be set to 1b. By rejecting positive steps
(dir=3D1) when independent margining is not supported, does this incorrectly
reject valid symmetric margining commands?

> +
> +	ret =3D pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
> +			      LMR_TYPE_TIMING, 0,
> +			      (step & LMR_TIMING_STEP_MASK) | (dir << LMR_TIMING_DIR_SHIFT), =
&sts);
> +	if (ret)
> +		goto out;
> +
> +	plane->timing_val =3D val;

[Severity: Medium]
Does this ignore the applied margin step returned by the hardware?

The user input is passed as a relative step, but it is cached as the absolu=
te
tracking variable (plane->timing_val). Because hardware applies steps relat=
ive
to the current position and may cap the step at its maximum supported offse=
t,
can the software state become completely desynchronized from the actual
hardware margin offset?

> +
> +out:
> +	mutex_unlock(&mdev->lock);
> +	return ret ? ret : count;
> +}

[ ... ]

> +static ssize_t margin_lane_voltage_write(struct file *file, const char _=
_user *user_buf,
> +				     size_t count, loff_t *ppos)
> +{
> +	struct pci_margin_lane *plane =3D ((struct seq_file *)file->private_dat=
a)->private;

[ ... ]

> +	if (val < 0) {
> +		step =3D -val;
> +		dir =3D 0;
> +	} else {
> +		step =3D val;
> +		dir =3D 1;
> +		if (!(caps & LMR_CAP_IND_UP_DOWN_VOLTAGE)) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +	}

[Severity: High]
Are the validation checks for independent voltage margining support inverte=
d?

Similar to timing, does this incorrectly reject valid symmetric voltage
margining commands (dir=3D1) for receivers that do not support independent
up/down margining?

> +
> +	if (step > LMR_MAX_VOLTAGE_STEP) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	ret =3D pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
> +			      LMR_TYPE_VOLTAGE, 0,
> +			      (step & LMR_VOLTAGE_STEP_MASK) |
> +			      (dir << LMR_VOLTAGE_DIR_SHIFT), &sts);
> +	if (ret)
> +		goto out;
> +
> +	plane->voltage_val =3D val;

[Severity: Medium]
Does this ignore the applied voltage margin step returned by the hardware?

Just like with timing margining, caching the user input as the absolute val=
ue
ignores the actual step hardware applied. Can this lead to desynchronization
between software state and the actual hardware offset?

> +
> +out:
> +	mutex_unlock(&mdev->lock);
> +	return ret ? ret : count;
> +}

[ ... ]

> +static void pci_margin_debugfs_init(struct pci_margin_dev *mdev)
> +{
> +	struct pci_dev *dev =3D mdev->dev;
> +	char dirname[64];
> +	int i;
> +
> +	snprintf(dirname, sizeof(dirname), "pcie_lmr_%s", dev_name(&dev->dev));
> +	mdev->debugfs =3D debugfs_create_dir(dirname, NULL);

[Severity: Low]
Does this create the debugfs directory in the debugfs root instead of the
PCI subsystem directory?

Passing NULL as the parent argument will create /sys/kernel/debug/pcie_lmr_=
<dev>
instead of the intended PCI directory /sys/kernel/debug/pci/.

> +	if (!mdev->debugfs)
> +		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-pcie-lmt-v=
2-1-04ec6327f874@google.com?part=3D1
