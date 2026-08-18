Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EABC353A9D
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787086811; cv=none; b=XU84bg0GrZ9h74Aaq/LOzt6maO+Df0UdrllB/K91K/oSx01aApAXwaD2aNe1ZEyzJ/Uqf48PdiSZNAnbaWX4tsbdtz0mADewpxKGe8yBVWn0eRPHlZjiJbHUMOoOOvalizGYe8fcqYI6as3kWCy44sEaKG60b6fVC0h5ngPFW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787086811; c=relaxed/simple;
	bh=RN8h1fplRuMp4TOfKyHqN7FqT3uB+O6KXfHhAM2HzJU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bNViDo3eS+mt64TBT2M1U5wIxDdcqH2eGE89/BenjSn4mQGAfnk6cMdtmj1oyeH61QyYvjbRv3G4hFFrFU+vlO3bOJn5qx7CQVksfQlu3P0uvLdtYE8/CLBtXzodULPp29c5mrG+5HYI9lcZmz3UVZEAWcLAtCwbTIOY5QpjxyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWqi4ux2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWqi4ux2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3C91F000E9;
	Tue, 18 Aug 2026 21:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787086809;
	bh=oOxkPXEA8LPnJTRsazMdqDpj4yh2A71fRKcQ+/4W7+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WWqi4ux2hmbp1BH3x01hVkiqMEpTEsEYBWCuQQY3D6rGd8EUIFwcKfrtDqD0UkuZE
	 P7yStnrdS+FytFe+OP6XeWteSCVrq7OMmiEZKSOPxQlVyqvm6qHIyLNLc8RyMUWF3f
	 vNy/D6Nea92v6Q0WKBCJH5JR7vBor0YmutG0m8FNPWAIcauCssltvXxnzGV2EUw80G
	 MAYgl9JJ5wV1lhY2nzqQzebkNqZR7AICAOYnkbSL+gT+Fx6SYC4zqZ4UxLdhtTD/FC
	 pGHfvzzQznj+E8fBXtp7zMTxWMRQ59IeJV9pfwy1e+BKbmrTrBLjp2f+VuSeA+yNzz
	 m60Rh2QABWdaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260818-pcie-lmt-v3-1-d5df983a5d53@google.com>
References: <20260818-pcie-lmt-v1-1-13716f446594@google.com>
 <20260818-pcie-lmt-v3-1-d5df983a5d53@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 21:00:09 +0000
Message-Id: <20260818210009.9B3C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Enabling Lane Margining permanently disables ASPM L0s/L1 without a=
 restoration path, resulting in a persistent power regression.
- [High] The driver determines the number of lanes using Maximum Link Width=
 instead of Negotiated Link Width, leading to massive command timeouts on i=
nactive lanes.
- [Medium] Ignoring the return value of `pci_lmr_demargin_lane()` causes so=
ftware state desynchronization and leaked hardware margins.
- [Medium] Incomplete LMR state teardown in `pci_lmr_exit()` fails to clear=
 `SW_READY`, leaking hardware state.
- [Medium] The lazy initialization of `pci_debugfs_root_dir` is not thread-=
safe, allowing concurrent device probes to corrupt the root dentry pointer.
- [Medium] Missing runtime PM protection allows the device to enter D3hot w=
hile margining is active, destroying the hardware margining state.
- [Low] Enabling LMR silently clobbers user-selected lane receivers, forcin=
g them back to LMR_RX_LOCAL.
- [Low] Incorrect error check for debugfs_create_dir() return value in pci_=
margin_debugfs_init().
--

--- Patch [1]: [PATCH v3] PCI/pcie: Add PCIe Lane Margining at Receiver (LM=
R) support ---
commit 8efc0096cd4866c98886e7abe624d739ed9f545f
Author: Priyank Rathod <rathodpriyank@google.com>

PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support

This patch adds support for PCIe Lane Margining at Receiver (LMR) per the P=
CIe
6.0 base specification. It introduces driver structures, debugfs exposure f=
or
manual margining configuration, and hooks into the device probe and remove
paths.

> diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pci/pcie/margin.c
> @@ -0,0 +1,890 @@

[ ... ]

> +static struct dentry *get_pci_debugfs_root(void)
> +{
> +	if (!pci_debugfs_root_dir)
> +		pci_debugfs_root_dir =3D debugfs_lookup("pci", NULL);
> +	if (!pci_debugfs_root_dir)
> +		pci_debugfs_root_dir =3D debugfs_create_dir("pci", NULL);
> +	return pci_debugfs_root_dir;
> +}

[Severity: Medium]
Could this concurrent lockless check corrupt the global debugfs root pointe=
r?

If two threads concurrently probe devices, both might see a NULL pointer and
attempt to create the directory, leading one to overwrite the global
variable with an error pointer from debugfs_create_dir().

[ ... ]

> +static int pci_lmr_cache_rx_info(struct pci_margin_lane *plane, u8 rx)
> +{
> +	struct pci_margin_rx_info *info =3D &plane->rx_info[rx];
> +	u16 sts;
> +	int ret;
> +
> +	if (info->caps_cached)
> +		return 0;
> +
> +	/* Issuing REPORT_CAPS aborts any active margin per PCIe spec */
> +	pci_lmr_demargin_lane(plane);
> +
> +	ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
> +			      LMR_TYPE_REPORT_CAPS, 0, 0, &sts);

[Severity: Medium]
Should the return value of pci_lmr_demargin_lane() be checked here?

If the demargining command fails due to a timeout, proceeding to issue
REPORT_CAPS resets the hardware state without software properly handling the
error, which might cause the hardware and software states to fall out of sy=
nc.

[ ... ]

> +static ssize_t margin_enable_write(struct file *file, const char __user =
*user_buf,
> +			       size_t count, loff_t *ppos)
> +{

[ ... ]

> +	if (enable) {
> +		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap)) {
> +			ret =3D -EIO;
> +			goto out;
> +		}
> +
> +		/*
> +		 * PCIe Base Spec r6.0: Link must be maintained in L0 during
> +		 * active margining. Disable ASPM L0s/L1.
> +		 */
> +		pci_disable_link_state(dev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);

[Severity: High]
Does pci_disable_link_state() permanently disable ASPM for this device?

There does not appear to be a restoration path when the enable flag is togg=
led
off. This could result in a persistent power efficiency regression for the
system until the next reboot.

[Severity: Medium]
Is a runtime PM reference needed here, such as pm_runtime_get_sync()?

Without taking a runtime PM reference, the PM core could transition an idle
device to D3hot. This would drop the link from L0, violating the active
margining state machine requirements and potentially destroying the hardware
margining state.

> +
> +		if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {

[ ... ]

> +		/* Cache capabilities for local receiver on all lanes */
> +		for (i =3D 0; i < mdev->num_lanes; i++) {
> +			mdev->lanes[i].rx =3D LMR_RX_LOCAL;
> +			pci_lmr_cache_rx_info(&mdev->lanes[i], LMR_RX_LOCAL);
> +		}
> +		mdev->enabled =3D true;

[Severity: Low]
Does enabling margining intentionally clobber user-selected lane receivers?

If a user configures specific receivers for lanes via debugfs while margini=
ng
is disabled, that configuration will be silently overwritten and forced back
to LMR_RX_LOCAL.

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
What happens if pci_lmr_demargin_lane() fails here?

If the error is ignored, plane->rx is updated to the new receiver anyway. T=
his
could leave the previous hardware receiver permanently margined while softw=
are
variables lose track of it.

[ ... ]

> +static void pci_margin_debugfs_init(struct pci_margin_dev *mdev)
> +{
> +	struct pci_dev *dev =3D mdev->dev;
> +	struct dentry *parent;
> +	char dirname[64];
> +	int i;
> +
> +	parent =3D get_pci_debugfs_root();
> +	snprintf(dirname, sizeof(dirname), "pcie_lmr_%s", dev_name(&dev->dev));
> +	mdev->debugfs =3D debugfs_create_dir(dirname, parent);
> +	if (!mdev->debugfs)
> +		return;

[Severity: Low]
Does debugfs_create_dir() return an error pointer rather than NULL on failu=
re?

Checking for NULL here will evaluate to false on an error pointer, causing =
the
driver to proceed with an invalid debugfs dentry instead of cleanly abortin=
g.

[ ... ]

> +void pci_lmr_init(struct pci_dev *dev)
> +{
> +	struct pci_margin_dev *mdev;
> +	enum pci_bus_speed speed;
> +	u16 lmr;
> +	u16 lnkcap;
> +	int i;

[ ... ]

> +	mutex_init(&mdev->lock);
> +
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCAP, &lnkcap);
> +	mdev->num_lanes =3D FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
> +
> +	if (mdev->num_lanes =3D=3D 0 || mdev->num_lanes > LMR_MAX_LANES) {
> +		pci_warn(dev, "Invalid link width %d for LMR\n", mdev->num_lanes);
> +		goto err_free_mdev;
> +	}

[Severity: High]
Should this use Negotiated Link Width (PCI_EXP_LNKSTA_NLW) instead of Maxim=
um
Link Width?

If a device like a x16 card is inserted into a slot with fewer active lanes,
the maximum link width will overestimate the active lanes. When margining is
enabled, commands sent to the inactive lanes might time out, causing massive
stalls during interaction.

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

[Severity: Medium]
Should this teardown path also clear the PCI_LMR_PORT_STS_SW_READY bit and
set mdev->enabled to false?

Unlike the suspend path, this function leaves SW_READY asserted in hardware.
During device unbind or teardown, this abandons the hardware in an active
margining state expectation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-pcie-lmt-v=
3-1-d5df983a5d53@google.com?part=3D1
