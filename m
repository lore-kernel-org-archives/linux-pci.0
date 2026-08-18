Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099A1FECBA
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080223; cv=none; b=aFMzSeCqWUHPzzlmD7h5p8b36CUFVIPsujWttPTtDzEWuxuiJ9UBT/fu332iU1KBQC69zPzmMAn9qofqXE8rRhBdiV3HjzZGkycd1pftNWL7pYUpwUG8C8cV0vRLd28iznbTnyk4nVZnZLmCWsqav+xvko87nMJOu/JIqNvL6+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080223; c=relaxed/simple;
	bh=82dakn1M7uSX5WuhhUeROswdHjFY8cbVI45VWHRpzaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pjs4X3eDIndRucJO6Eizv54hHY4TxXzNGGnbNriHcKK+nDxZ8EZjmpi+niMz0oTGK+h58buC30epPNtj8LDfgaAiD3tnLX3JTlE0n0JTOuf+Y/E03TLYZBKKp7KV2inFbHNIlX6A5RaaIorDfnScsP+itxkzG1ozSh2A4blWz7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grl9beFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grl9beFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947141F00A3A;
	Tue, 18 Aug 2026 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787080221;
	bh=fLVD0Oi1WDeQhe+A4m0W3uV5+SKRgJQQMrqfwYUgIlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=grl9beFNckNBmgCfLwQ/4xg5dqYqINm6ShL/rWyAQlJ8vykfBNzKkjEjHDZtHhvNc
	 al7JvlszDKn9IddOQ0eoggyjWa1o5J24uSsaNwbzZhQrkms4nGjtK9taqF7YX37Frq
	 RVanZF7DzoutySgFWsS5k0GjtGoFCyKVze2T9xW6LCYMbNRia5iyLhe05FAbsMIFIB
	 n+5CCTEvTghvbrrzJp3ZBI/QYgslC/sxH6XVMu4T4+hlrijY5MdEZjxaP5+NubJHPC
	 qHtTWh82nLfFNfdZn2AMiY4mJ3cI6QCzeqPfF5dOZzfCiU0PdqcL2+Rzo8yHRzRpBJ
	 TX9kvjQTLQvSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260818-pcie-lmt-v1-1-13716f446594@google.com>
References: <20260818-pcie-lmt-v1-1-13716f446594@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 19:10:21 +0000
Message-Id: <20260818191021.947141F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Missing command clearing via NO_CMD (0x7) causes consecutive comma=
nds of the same type to be falsely acknowledged.
- [High] The lane receiver index (`plane->rx`) is modified locklessly, crea=
ting a data race during multi-step hardware operations.
- [Medium] Incorrect register bit definitions for Margining Port Capabiliti=
es lead to false capability reporting.
- [Medium] The debugfs directory is placed at the root instead of under `/s=
ys/kernel/debug/pci/`, breaking kselftests.
- [Medium] Integer wrap-around from narrowing cast allows out-of-bounds mar=
gin steps to bypass limits.
- [Medium] Time-of-Check to Time-of-Use (TOCTOU) race condition checking `m=
dev->enabled` outside of the device lock.
- [Medium] Ignoring the return value of `pci_read_config_word` leads to the=
 use of uninitialized stack variables.
- [Low] The `cap` variable is read but unconditionally ignored in `margin_e=
nable_write`, resulting in a dead store.
- [Low] Usage of non-existent function `kstrtou8_from_user` causes a build =
failure.
- [Low] If the PCIe link speed is `PCI_SPEED_UNKNOWN`, the initialization l=
og incorrectly reports that a 'Gen6' capability was detected.
--

--- Patch [1]: [PATCH] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) =
support ---
commit 91ae8e1bf71eb2b01c6d741e0bcecbd38ee29c2e
Author: Priyank Rathod <rathodpriyank@google.com>
Subject: PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support

This patch adds driver and debugfs support for PCIe Lane Margining at
Receiver (LMR) for Gen4+ links. It introduces capabilities register
definitions, exposes control interfaces via debugfs, and includes an
automated kselftest.

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index facaa324bd86a..a13c09f8d6dfd 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1181,6 +1182,24 @@
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
> =20
> +/* Lane Margining at Receiver */
> +#define PCI_LMR_PORT_CAP		0x04	/* Margining Port Capabilities */
> +#define  PCI_LMR_PORT_CAP_MARGIN_READY	0x0001	/* Margining Ready */
> +#define  PCI_LMR_PORT_CAP_SW_READY	0x0002	/* Margining SW Ready */

[Severity: Medium]
Are these bit definitions for the Port Capabilities register correct?

Bit 0 of Port Capabilities (0x04) is actually "Margining Uses Software
Ready", and Bit 1 is reserved. The spec defines "Margining Ready" and
"SW Ready" only in the Port Status register (0x06).

Does this pollute the UAPI header and expose wrong semantics to userspace
when evaluating these bit masks?

> diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
> new file mode 100644
> index 0000000000000..a1ccd473a4070
> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c
> @@ -0,0 +1,673 @@
[ ... ]
> +static int pci_lmr_run_cmd(struct pci_dev *dev, int lane, u8 rx, u8 type,
> +			   u8 usage, u8 payload, u16 *status_val)
> +{
[ ... ]
> +	timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
> +	while (1) {
> +		pci_read_config_word(dev, sts_offset, &sts);
> +		if (sts =3D=3D 0xFFFF)
> +			return -ENODEV;
> +
> +		if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D type) {
> +			if (status_val)
> +				*status_val =3D sts;
> +			return 0;
> +		}

[Severity: High]
Could the polling loop exit instantly on a false positive if the previous
command shared the same MTYPE?

The PCIe Base Spec 6.0 requires software to issue a "No Command" (0x7)
to clear the MTYPE in the Status register before issuing a new command of
the same type. Since this command clearing is omitted, does the driver
read stale payload data and fail to properly apply hardware margins for
consecutive commands?

[ ... ]
> +static int pci_lmr_run_cmd_locked(struct pci_margin_dev *mdev, int lane,=
 u8 rx,
> +				  u8 type, u8 usage, u8 payload, u16 *status_val)
> +{
> +	int ret;
> +
> +	if (!mdev->enabled)
> +		return -EACCES;
> +
> +	mutex_lock(&mdev->lock);

[Severity: Medium]
Is there a race condition checking the enabled state outside of the
device lock?

If one thread checks the state locklessly and proceeds to block on the
lock, could another thread acquire the lock, set enabled to false,
and clear the hardware state? Once the first thread wakes up, would it
blindly execute the command on disabled hardware?

[ ... ]
> +static int margin_caps_show(struct seq_file *s, void *v)
> +{
> +	struct pci_margin_dev *mdev =3D s->private;
> +	struct pci_dev *dev =3D mdev->dev;
> +	u16 cap;
> +
> +	pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap);
> +	seq_printf(s, "Port Capabilities: %#06x\n", cap);

[Severity: Medium]
Does ignoring the return value of pci_read_config_word() risk exposing
uninitialized stack memory to userspace?

While the PCI core tries to set the value to 0xFFFF on disconnection,
some low-level architecture drivers do not initialize the value on read
failures.

Also, as mentioned earlier, this applies the incorrect bit definitions
from the UAPI header. Does this evaluate erroneous bit masks to display
false capability states to userspace?

[ ... ]
> +static ssize_t margin_enable_write(struct file *file, const char __user =
*user_buf,
> +			       size_t count, loff_t *ppos)
> +{
[ ... ]
> +	if (enable) {
> +		pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap);

[Severity: Low]
Is the cap variable read but unconditionally ignored, resulting in a dead
store?

This triggers a compiler warning for an unused but set variable and
misses a logical check on whether the hardware actually requires the
software ready bit to be set.

> +
> +		pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
> +		sts |=3D PCI_LMR_PORT_STS_SW_READY;
> +		pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);

[Severity: Medium]
Does ignoring the return value of pci_read_config_word() here risk
applying bitwise operations to a potentially uninitialized sts variable
and writing uninitialized garbage back to hardware configuration
registers?

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

[Severity: Low]
Does the usage of kstrtou8_from_user() cause a build failure?

The kernel API provides kstrtou8, but it does not provide a variant
named kstrtou8_from_user.

> +	if (ret)
> +		return ret;
> +
> +	if (rx > LMR_MAX_RX_NUM)
> +		return -EINVAL;
> +
> +	plane->rx =3D rx;
> +	return count;
> +}

[Severity: High]
Is the lane receiver index updated without acquiring the device lock?

Multi-step sequences read this value multiple times, assuming it remains
constant for the duration of the locked block. Does this create a data
race where capabilities are validated for one receiver, but the margin
step is applied to a different receiver if updated concurrently?

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
> +	if (ret)
> +		return ret;
> +
> +	if (!mdev->enabled)
> +		return -EACCES;
> +
> +	mutex_lock(&mdev->lock);

[Severity: Medium]
As mentioned earlier, does checking the enabled state outside of the
critical section introduce a race condition?

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
> +
> +	if (step > LMR_MAX_TIMING_STEP) {

[Severity: Medium]
Does the truncation from int to u8 bypass the bounds limit check?

Since val is cast to an unsigned 8-bit integer step before the bounds
limit check is applied, out-of-bounds values like 256 or -256 are
truncated to 0. Does this bypass the safety limit, passing the truncated
value to hardware while saving the original out-of-bounds integer to
the driver state?

[ ... ]
> +static ssize_t margin_lane_voltage_write(struct file *file, const char _=
_user *user_buf,
> +				     size_t count, loff_t *ppos)
> +{
[ ... ]
> +	if (val < 0) {
> +		step =3D -val;
> +		dir =3D 0;
> +	} else {
> +		step =3D val;
> +		dir =3D 1;
[ ... ]
> +	if (step > LMR_MAX_VOLTAGE_STEP) {

[Severity: Medium]
Does the same truncation flaw occur in the voltage margin handler,
allowing out-of-bounds margin steps to bypass limits?

[ ... ]
> +static void pci_margin_debugfs_init(struct pci_margin_dev *mdev)
> +{
> +	struct pci_dev *dev =3D mdev->dev;
> +	char dirname[64];
> +	int i;
> +
> +	snprintf(dirname, sizeof(dirname), "pcie_lmr_%s", dev_name(&dev->dev));
> +	mdev->debugfs =3D debugfs_create_dir(dirname, NULL);

[Severity: Medium]
Does passing NULL as the parent create the directory at the debugfs root
instead of under the expected PCI subsystem hierarchy?

The test script assumes the directories are located in the pci
subdirectory, causing the automated kselftest to fail with a skip
message.

[ ... ]
> +void pci_lmr_init(struct pci_dev *dev)
> +{
[ ... ]
> +	pci_info(dev, "Lane Margining at Receiver (Gen%u) Capability detected\n=
",
> +		 speed >=3D PCIE_SPEED_64_0GT ? LMR_GEN6 :
> +		 speed >=3D PCIE_SPEED_32_0GT ? LMR_GEN5 :
> +		 LMR_GEN4);
> +	return;

[Severity: Low]
If the PCIe link speed is PCI_SPEED_UNKNOWN, does this initialization
logic incorrectly report that a Gen6 capability was detected?

PCI_SPEED_UNKNOWN evaluates to 0xFF, which is numerically greater than
PCIE_SPEED_64_0GT. The ternary logging statement unconditionally checks
speed >=3D PCIE_SPEED_64_0GT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-pcie-lmt-v=
1-1-13716f446594@google.com?part=3D1
