Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731927;
	b=WGxD0fwrRMWOMKFNXaKppjbWuqfSmI1GGizQ/vuO/qW3pEBrQI9rBuzm2zgD4dJcBa1q
	 Nlsp3DdZaAjmuJzrbH8WQzBuyXLKCTCpyqXi6faEsP2Gr3xcDuQt0FZLb8WQWGb7C3Ih+
	 tNEiZJGnn/rA9ebmat3I4IwtMF9wk/Zb20x9RhPVweCe4vpNulTrN/5HyqyibJFkovU7J
	 2TCXhdEcbcVn8ncDuOQH1BNg8RUMQZqOrJ1GvdWNGzOwk38SRlLKIfywkP/xOtHie8mn6
	 bNTvD2yRFa75WFYyAw2TBGQ6sKRZsc9nI+ITTUmguinErfGNxcI5THg4G0war2JKO/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731927;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H01xfDvA8/uy6fTwsPZ9MJXq4V71UdmhkjvZFg9fuW4=;
	b=c96/wGMFzM09XkkO9opXnrw8WRloyiLLfIHc18nC4fCwXRWgkKQL9HMt8/AgxUOCcPNG
	 XjqFcs/csLE1cmMeGHY355n0gjujew1KMK81Uv5ApcMHDgZW4g+qZE9mLWuDAJPiIRPnZ
	 +QQS9uohBpkyHO7f2/+HM2TzSc5oXoxNFHDhSjrcsvt1Fd6iGxTwH3uYYq6Kq6kS+Hov9
	 YdkI38o5kNtaYstYgfCtH7Z1P6+uHB658lpyhg4VDDniGYqJldjGgy/BieYQFjTXFPVBT
	 HpVLZG3rklV5gpDymIupiEGnIdwfOohM9dDpk3b/Bjsh9o2Eq6zmR48GPD2lTpu3uGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGFSxF7T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB870606A324
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGFSxF7T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4981F000C1;
	Tue,  3 Nov 2026 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731926;
	bh=H01xfDvA8/uy6fTwsPZ9MJXq4V71UdmhkjvZFg9fuW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VGFSxF7TmdGIRk6gTo3W2Pz8uOWvwi46vwfZ87XgEXLBTHh0Ze2JfK35wFZ3XR+72
	 KJHPr3dW2y+I8CbDL1+H/uXOgCHQYPsNC6hR8fNtQeg3IPtQt07/OdR1/Pdu1ebWTT
	 GdhMTS3lfFve2MHTs8KgZBPGNszMpO/StrVp3bU5yBvyzNQ1I2ObXuAU/En083GYwI
	 REMh73mAx8c7rTne7bez0crqLvBwbOaTMzy5zNZSuG8LaAccRw4ssgwyIJRgffQzJi
	 275JuM2XU4inD5/8B1OJU3LPV8rWxV3d65aVwLt8Iq5Uv3/hV41UidjPQIHN36IjiZ
	 xFNHihU2XyonQ==
Message-ID: <sashiko-outbox-195866@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/5] iommu: Pass in reset result to
 pci_dev_reset_iommu_done()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <b8a1c348a5ef457bd75d882aaf60b9156a5aedb3.1793729707.git.nicolinc@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
 <b8a1c348a5ef457bd75d882aaf60b9156a5aedb3.1793729707.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 18:52:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] iommu: nested FLR failure lost in pci_dev_reset_iommu_done() and q=
uirks
--

commit bcd9c215d1b85e6e5dddae2f6e5dddae2f6e342b6ed1a3b197
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu: Pass in reset result to pci_dev_reset_iommu_done()

This commit passes the return value of PCI reset functions into
pci_dev_reset_iommu_done() so that on a failed reset the device remains
attached to the blocking domain with group->recovery_cnt kept elevated.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0d40eb4f15cc1..1e3a243a6f1ef 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
[ ... ]
> @@ -4138,20 +4152,28 @@ static bool group_device_dma_alias_is_blocked(str=
uct iommu_group *group,
>  /**
>   * pci_dev_reset_iommu_done() - Restore IOMMU after a PCI device reset i=
s done
>   * @pdev: PCI device that has finished a reset routine
> + * @reset_result: Return code from the reset routine
>   *
>   * After a PCIe device finishes a reset routine, it wants to restore its=
 IOMMU
>   * activity, including new translation and cache invalidation, by re-att=
aching
>   * all RID/PASID of the device back to the domains retained in the core-=
level
>   * structure.
>   *
> - * Caller must pair it with a successful pci_dev_reset_iommu_prepare().
> + * This is a pairing function for pci_dev_reset_iommu_prepare(). Caller =
passes
> + * the reset return value to @reset_result. On a failed reset, the devic=
e will
> + * remain blocked as a quarantine measure, with group->recovery_cnt inta=
ct, to
> + * protect system memory until a subsequent successful reset.
> + *
> + * Callers must skip pci_dev_reset_iommu_prepare/done() entirely when no=
 reset
> + * is attempted (e.g. probe mode).
>   *
>   * Note that, although unlikely, there is a risk that re-attaching domai=
ns might
>   * fail due to some unexpected happening like OOM.
>   */
> -void pci_dev_reset_iommu_done(struct pci_dev *pdev)
> +void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result)
>  {
>  	struct iommu_group *group =3D pdev->dev.iommu_group;
> +	enum blocked_reason old_blocked;
>  	struct group_device *gdev;
>  	unsigned long pasid;
>  	void *entry;
> @@ -4174,6 +4196,37 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>  	if (WARN_ON(!group->blocking_domain))
>  		return;
> =20
> +	/*
> +	 * A reset failure implies that the device might be unreliable. E.g. its
> +	 * device cache might retain stale entries, which might result in memory
> +	 * corruption. Thus, do not unblock the device until a successful reset.
> +	 */
> +	if (reset_result) {
> +		/*
> +		 * FIXME: the int-return values from the PCI reset functions are
> +		 * not consistent: some reset functions use -ENOTTY to indicate
> +		 * "no reset was attempted" (in which case IOMMU should revert a
> +		 * prepare), while others use -ENOTTY to indicate "reset failed;
> +		 * try the next reset method" (in which case IOMMU should keep
> +		 * the device blocked). Without fixing the PCI return result, we
> +		 * cannot tell the difference between the two cases. Warn it.
> +		 */
> +		if (reset_result =3D=3D -ENOTTY)
> +			dev_warn_ratelimited(
> +				&pdev->dev,
> +				"Reset may have been skipped. Keep it blocked conservatively\n");
> +		else
> +			dev_err_ratelimited(
> +				&pdev->dev,
> +				"Reset failed. Keep it blocked to protect memory\n");
> +		if (gdev->blocked =3D=3D BLOCKED_RESETTING)
> +			gdev->blocked =3D BLOCKED_RESET_FAILED;
> +		return;
> +	}
[ ... ]
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 3d3e95cb9f7dc..92e81460c2d8f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4416,7 +4416,7 @@ static int __pci_dev_specific_reset(struct pci_dev =
*dev, bool probe,
> =20
>  	ret =3D i->reset(dev, probe);
>  	if (!probe)
> -		pci_dev_reset_iommu_done(dev);
> +		pci_dev_reset_iommu_done(dev, ret);
>  	return ret;
>  }

[Severity: High]
Can a nested FLR failure inside a device-specific reset quirk be lost,
allowing the device to be unblocked even when the underlying FLR failed?

When __pci_dev_specific_reset() runs, it calls pci_dev_reset_iommu_prepare()
which increments gdev->reset_depth from 0 to 1, attaches
group->blocking_domain, and sets gdev->blocked =3D BLOCKED_RESETTING.

Several callbacks in pci_dev_reset_methods[] then invoke pcie_flr() or
pcie_reset_flr() without propagating its return value, such as
nvme_disable_and_flr(), delay_250ms_after_flr(),
reset_intel_82599_sfp_virtfn(), reset_chelsio_generic_dev(), and
reset_hinic_vf_dev():

drivers/pci/quirks.c:nvme_disable_and_flr() {
	...
	pci_iounmap(dev, bar);

	pcie_flr(dev);

	return 0;
}

drivers/pci/quirks.c:delay_250ms_after_flr() {
	if (probe)
		return pcie_reset_flr(dev, PCI_RESET_PROBE);

	pcie_reset_flr(dev, PCI_RESET_DO_RESET);

	msleep(250);

	return 0;
}

Inside pcie_flr(), pci_dev_reset_iommu_prepare() increments
gdev->reset_depth from 1 to 2. If the FLR fails (for example, pci_dev_wait()
times out or sees a disconnected device and returns -ENOTTY), pcie_flr()
calls pci_dev_reset_iommu_done(dev, ret) with ret =3D -ENOTTY.

However, pci_dev_reset_iommu_done() checks gdev->reset_depth before
inspecting reset_result:

drivers/iommu/iommu.c:pci_dev_reset_iommu_done() {
	...
	if (WARN_ON(gdev->reset_depth =3D=3D 0))
		return;
	if (--gdev->reset_depth)
		return;

	if (WARN_ON(!group->blocking_domain))
		return;

	if (reset_result) {
	...
}

Because --gdev->reset_depth is still 1 on the inner call,
pci_dev_reset_iommu_done() returns early and discards the inner failure.
(Similarly, if pcie_flr() fails at !pci_dev_config_accessible(), it returns
-ENOTTY before calling pci_dev_reset_iommu_prepare(), and reset_hinic_vf_de=
v()
and reset_ivb_igd() also return 0 on post-reset polling timeouts.)

The quirk callback then returns 0 to __pci_dev_specific_reset(), which calls
pci_dev_reset_iommu_done(dev, 0). At that outer call, --gdev->reset_depth
reaches 0 with reset_result =3D=3D 0, so pci_dev_reset_iommu_done() unblock=
s the
device (even clearing a prior BLOCKED_RESET_FAILED quarantine), re-attaches
group->domain and all PASID domains, and decrements group->recovery_cnt.

Should the FLR quirk callbacks propagate the return value of pcie_flr() /
pcie_reset_flr(), and should pci_dev_reset_iommu_done() also record a
non-zero reset_result before returning when gdev->reset_depth > 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793729707.gi=
t.nicolinc@nvidia.com?part=3D5
