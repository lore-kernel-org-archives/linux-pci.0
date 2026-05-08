Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEBE2E762C;
	Fri,  8 May 2026 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277168; cv=none; b=FICMSPAov9iXUUK3WY8Nfme6f8IDDqfidEQmTsfIi+flaA8p8lUr/ZT27xHUzwzuBvuOfKWHNXPRk7edxTX79WVzox44BsjYlEHvq58+WFfnaytQwixRacjosY2Cdk8Fh+gt6hNhiXsxzNQpEX8e8JR9pA8403m46vQgYnCdVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277168; c=relaxed/simple;
	bh=2ft7ENV4Q+1UIVHLV+1ZilABTSDxqlSv/DzDkwMcbWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V6A0qT7628UUhwpEZz6hoU5+mg04dINbz5LVR1I/jBL/DCudpsdWvRmcTWcG+wAxl71ImfTo34IP+f8te10a6ZNIQFZtAP4oTR7VT0EHdRFW38g7ft1Zpz86m8I+pRKomJttsWNesFaby+JIK6YCBYXRrT3wOE2hpuqkJPPlE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGkJLYQp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGkJLYQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71919C2BCB0;
	Fri,  8 May 2026 21:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778277167;
	bh=2ft7ENV4Q+1UIVHLV+1ZilABTSDxqlSv/DzDkwMcbWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DGkJLYQps+6b5pT9X0x+i5jagWGJu1wvR6rjNFIFhuZNLZ6/9yiQgQY3C+MF3R/D2
	 rsJvYwDPIYk4qiY2Fc0MZFcv2w5sb2QtW7LgToQGABm7mzmKDUUe6eJ2yQkvkzvENb
	 wijjnJQw9AH6M+rhqjyIruoUjYA64ZQiNbuwpKHGt3hv5KMIgou9kO/MKntgIf4ejo
	 vZ3zphcLVusDm65+ZtA/GI2/DUr2fMH/E2SKRBXsiSffVWuwv0PyhwN5BI/At56uya
	 WTmCvf8ucBZa85Cf2pd3wvssa0884U/b9jQxT4LuqpjcETBvKDm5O3HMYCUpDoqoAe
	 vF6SHIkTYTgVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: add AMD Promontory 21 xHCI temperature
 sensor support
Reply-To: sashiko@lists.linux.dev
To: "Jihong Min" <hurryman2212@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260508143910.14673-3-hurryman2212@gmail.com>
References: <20260508143910.14673-3-hurryman2212@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:52:46 +0000
Message-Id: <20260508215247.71919C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Using pm_runtime_put_noidle() can permanently prevent the PCI devi=
ce from runtime-suspending.
- [Low] The local hwmon->lock mutex is redundant and violates the hwmon sub=
system locking architecture.
--

commit 62e33fab546f8b14b0cd80683aa504672db60e64
Author: Jihong Min <hurryman2212@gmail.com>

hwmon: add AMD Promontory 21 xHCI temperature sensor support

This commit adds an auxiliary-bus hwmon driver to expose the temperature
sensor on AMD Promontory 21 xHCI controllers. It reads the sensor value
through a vendor-specific index/data register pair in the PCI MMIO BAR.

> diff --git a/drivers/hwmon/prom21-xhci.c b/drivers/hwmon/prom21-xhci.c
> new file mode 100644
> index 0000000000000..f91303ce3428d
> --- /dev/null
> +++ b/drivers/hwmon/prom21-xhci.c
> @@ -0,0 +1,250 @@

[ ... ]

> +static int prom21_xhci_read_temp_raw_restore_index(struct prom21_xhci *h=
wmon,
> +						   u8 *raw)
> +{
> +	struct device *dev =3D &hwmon->pdev->dev;
> +	bool pm_ref;
> +	u32 index;
> +	u32 data;
> +	int ret;
> +
> +	ret =3D prom21_xhci_pm_get(hwmon, &pm_ref);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&hwmon->lock);

Is this private mutex redundant here?

According to the hardware monitoring subsystem guidelines, the hwmon core
automatically serializes sysfs operations for attributes registered via the
info parameter of hwmon_device_register_with_info().

Since this driver registers its only attribute (temp1_input) via the info
parameter and does not access the hardware from interrupt handlers or other
asynchronous paths, does it need its own serialization?

> +	index =3D readl(hwmon->regs + PROM21_INDEX);
> +	/* Select the PROM21 temperature register through the vendor index. */
> +	writel(PROM21_TEMP_REG, hwmon->regs + PROM21_INDEX);
> +	data =3D readl(hwmon->regs + PROM21_DATA);
> +	/* Restore the previous vendor index register value. */
> +	writel(index, hwmon->regs + PROM21_INDEX);
> +	readl(hwmon->regs + PROM21_INDEX);
> +	mutex_unlock(&hwmon->lock);
> +
> +	if (pm_ref) {
> +		/*
> +		 * Drop only the reference taken by pm_runtime_get_if_active().
> +		 * Do not mark the device busy or schedule autosuspend from the
> +		 * hwmon path; sensor polling must not keep the xHCI PCI device
> +		 * active.
> +		 */
> +		pm_runtime_put_noidle(dev);

Can using pm_runtime_put_noidle() permanently prevent the PCI device from
runtime-suspending?

If the xHCI driver drops its own runtime PM reference concurrently (e.g., v=
ia
pm_runtime_put_autosuspend()), the PM core's idle check sees usage_count > =
0,
returns -EAGAIN, and skips scheduling the autosuspend timer.

This code then calls pm_runtime_put_noidle(), which decrements usage_count
to 0 but intentionally bypasses queueing an idle check or notifying the PM
core.

Could this leave the xHCI controller permanently in the RPM_ACTIVE state wi=
th
a usage_count of 0 and no pending autosuspend timer until the next PM state
change?

To safely drop the reference without resetting the autosuspend timer, should
this use pm_runtime_put() instead, which properly queues an asynchronous
idle check?

> +	}
> +
> +	*raw =3D data & 0xff;
> +	if (!*raw || *raw =3D=3D 0xff)
> +		return -ENODATA;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508143910.1467=
3-1-hurryman2212@gmail.com?part=3D2
