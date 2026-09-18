Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148B3876B2
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744755; cv=none; b=Osp1IBdnS9kPKOCvSpMgKA8My99vGHRXtmgLG3eL5w4hIomprme3VHFWGCJZIko7Ru/7e8+1/hP/wcZqUb9Umu7H/ouLFZKZ+pddcAxD4jZQF4Zs9ohSCyqsoda+RC8jPrndY20oVPCz1KJM2mRUX0eBz5ZVG9wg57Qbv1NrmJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744755; c=relaxed/simple;
	bh=5voHmOL/lIb/Zh9iXwLvbLOsL8ngZ7ci0HoaEY/kfXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mbeR19U/SXI1vlUXtdUKHjar0KJv9o6C8qMtQW8rX1uk+8ytRBTN+EyDHSg94mBEyVZs4bMElTlRrhfEWxcX/Oe2rvK34zJaBChVWVmYM+kMQfW3ntFmBtz2PWT07QqJOf4bC8PclrADXOB1sDbWrjmr88oxAPbA2tiKO+q+TJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka7wzupJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka7wzupJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5F51F000FF;
	Fri, 18 Sep 2026 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744754;
	bh=YpjNYBH68YYGlqobDip/dtgpzwOHvtnxl9355hcSYhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ka7wzupJRCY6ejcCf7Sz4F1QN4lieFmLvAx4VizQz+ZgOBgkJktlWlpyD6WzAwuno
	 DhaUZUsM4MNCHZiG7YXOvbDQSWIM95xSnWGE7MRbp8zCSSp0FF5kQ8762ZoxScBH8j
	 CvSVjxIIrjbBYo1FyxwHzyA26V7//LI9jsMSogXsMAjdpiFL0lFxix0FvB+3t2u73h
	 Yt/Ow4cztNYFG4eHrMrPnrtJPWoU66PvxPfjWnJX9R4Ytm32BpTfs4zBcBOBVekUsk
	 gCfxHlCi/W9Si87hZqlbdG20aPcuhpwPPHfgs0F5diEHfrfqfxnQ+ouFWYwS0UfMkt
	 1P/jwC0208XbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] PCI/FLIT: Expose the error counter controls
 through sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918145619.3016889-11-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
 <20260918145619.3016889-11-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:19:13 +0000
Message-Id: <20260918151914.0E5F51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] PCI: data race in trigger_count_store allows flit_info->trigger =
to diverge
- [Medium] PCI: data race on capability save buffer between sysfs and pci_s=
ave_state
--

commit 3ec14595160ef1f891e99d5be3983ae720f59eb3
Author: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: PCI/FLIT: Expose the error counter controls through sysfs

This patch exposes the Trigger Event on Error Count and Events to Count fie=
lds=20
of the Flit Error Counter Control register via sysfs. It tracks the trigger=
=20
in struct flit_info and applies sysfs writes to the extended capability sav=
e=20
buffer to ensure they persist across resets and recovery paths.

> diff --git a/drivers/pci/pcie/flit.c b/drivers/pci/pcie/flit.c
> index 252bbb54e6172..33ec1b9c385c3 100644
> --- a/drivers/pci/pcie/flit.c
> +++ b/drivers/pci/pcie/flit.c
[ ... ]
> @@ -186,9 +209,130 @@ static void flit_cntr_ctrl_update(struct pci_dev *p=
dev, u16 clear, u16 set)
>  PCI_RATELIMIT_INTERVAL_ATTR(ratelimit_interval_ms, flit_info->ratelimit);
>  PCI_RATELIMIT_BURST_ATTR(ratelimit_burst, flit_info->ratelimit);
> =20
> +/*
> + * Program a durable setting into the register and the save buffer.
> + * pcie_portdrv_slot_reset() restores that buffer after running .slot_re=
set, so
> + * it is the last writer on the recovery path and would otherwise put the
> + * probe-time word back.
> + *
> + * Both writes happen under the lock, so the register and the buffer can=
not
> + * disagree if trigger_count and events_to_count are written at once. The
> + * buffer gets the same clear and set rather than a fresh sample, which =
would
> + * pick up the Counter Enable that flit_isr() leaves clear for flit_ist(=
).
> + */
> +static void flit_cntr_ctrl_set(struct pci_dev *pdev, u16 clear, u16 set)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	unsigned long flags;
> +	u16 *cap;
> +
> +	save_state =3D pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_FLIT);
> +	cap =3D save_state ? (u16 *)&save_state->cap.data[0] : NULL;
> +
> +	pci_config_pm_runtime_get(pdev);
> +
> +	spin_lock_irqsave(&pdev->flit_info->lock, flags);
> +	__flit_cntr_ctrl_update(pdev, clear, set);
> +	if (cap) {
> +		*cap &=3D ~clear;
> +		*cap |=3D set;
> +	}

[Severity: Medium]
Could this sysfs write to the capability save buffer race with
pci_save_flit_state()?

While flit_cntr_ctrl_set() modifies the save buffer (*cap) under
flit_info->lock, the preexisting pci_save_flit_state() function modifies
this same buffer locklessly.

If a userspace process writes to the sysfs attributes (e.g., trigger_count)
exactly while the device is probed and pci_save_state(pdev) is called, could
this concurrently modify the buffer and corrupt it? Upon resuming or error
recovery, pci_restore_flit_state() might then restore corrupted or stale
values to the hardware register.

> +	spin_unlock_irqrestore(&pdev->flit_info->lock, flags);
> +
> +	pci_config_pm_runtime_put(pdev);
> +}
[ ... ]
> +static ssize_t trigger_count_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	u16 val;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (kstrtou16(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	if (val > FIELD_MAX(PCI_FLIT_ERR_CNTR_CTRL_TRIGGER))
> +		return -EINVAL;
> +
> +	pdev->flit_info->trigger =3D val;
> +	flit_cntr_ctrl_set(pdev, PCI_FLIT_ERR_CNTR_CTRL_TRIGGER,
> +			   FIELD_PREP(PCI_FLIT_ERR_CNTR_CTRL_TRIGGER, val));

[Severity: Medium]
Is there a potential data race here when multiple threads write to the
trigger_count sysfs attribute concurrently?

Because kernfs doesn't serialize writes from different open file descriptor=
s,
two concurrent writes could interleave the assignment to
pdev->flit_info->trigger and the lock acquisition inside flit_cntr_ctrl_set=
().

For example:
Thread A sets pdev->flit_info->trigger =3D 10
Thread B sets pdev->flit_info->trigger =3D 20
Thread B calls flit_cntr_ctrl_set() and programs the hardware to 20
Thread A calls flit_cntr_ctrl_set() and programs the hardware to 10

The hardware would be programmed with 10, but the software state stored in
pdev->flit_info->trigger would remain 20. On the next enable (like resume or
recovery), the stale software state (20) would overwrite the hardware
register. Should the assignment to pdev->flit_info->trigger be done inside
flit_cntr_ctrl_set() under the spinlock?

> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(trigger_count);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918145619.3016=
889-1-yazen.ghannam@amd.com?part=3D10
