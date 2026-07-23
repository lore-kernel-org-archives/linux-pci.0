Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5316941D125
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801204; cv=none; b=uZBc6xv2MemSeN0kuN4UUdqpRoDKvADat05zd63ooHou7OFTukVTtzwBc5vOJPL3qSYBnUBH/HKbMHDlys5yi+4wz43TUIoWNPS50x/MpMjv9VkzV9Zgoxs96y1M0zkfV8k+oNBuKYyTWN4TA1fOcWenpzj8hhiRgNqyJlnJ7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801204; c=relaxed/simple;
	bh=VBJ+REuH5+7l3ggyx24wBZwvQwDZTH1/rohtc/p8Cko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I1iNpF9iIikkC5EfVjuxpNK43hTqxA6Ep0pO820hXijBJl78fN42mkYXkAsjGHDzjscPoP3nssoB1ClTfi7sboTqz2C7tuLnZ2AeVRolaXS9440YF03gpVlbxnSYLRcezpHyzTjI7xJEL+YOhcP6iO95gzLIho69CE7uSpQxzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB64E1F00AC4;
	Thu, 23 Jul 2026 10:06:42 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs
 for PLDR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chandrashekar Devegowda" <chandrashekar.devegowda@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260723094443.855492-1-chandrashekar.devegowda@intel.com>
References: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
 <20260723094443.855492-1-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:06:25 +0000
Message-Id: <20260723100642.DB64E1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The newly added `vendor_reset` sysfs attribute is never created =
due to incorrect driver structure initialization.

Pre-existing issues:
- [High] Triggering the reset work concurrently with device removal causes =
an AB-BA deadlock.
- [High] Failed resets leave the device permanently unresettable by failing=
 to clear the recovery state flag.
--

--- Patch [1]: [PATCH v5] Bluetooth: btintel_pcie: Add vendor_reset PCI sys=
fs for PLDR ---
commit ed608b7313d52c701233c9571961267b8d846500
Author: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs for PLDR

Add a read-write sysfs entry at /sys/bus/pci/devices/<BDF>/vendor_reset
to allow userspace to trigger PLDR (Product Level Device Reset).
Reading the attribute displays supported reset types. Writing
integer 0 triggers PLDR. Any other input is rejected with
-EINVAL and a warning log.

> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 2e28847263ab0..b3d3219e4ebd7 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c

[ ... ]

> @@ -2781,7 +2781,10 @@ static void btintel_pcie_request_reset(struct btin=
tel_pcie_data *data,
>  	data->reset_type =3D type;
> =20
>  	pci_dev_get(data->pdev);
> -	schedule_work(&data->reset_work);
> +	if (!schedule_work(&data->reset_work)) {

[Severity: High]
This isn't a bug introduced by this patch, but triggering the reset work
concurrently with device removal appears to cause an AB-BA deadlock.

If driver removal (e.g., via sysfs unbind) occurs while
btintel_pcie_reset_work() is executing, the unbind thread holds the
device lock and blocks on disable_work_sync(&data->reset_work):

drivers/bluetooth/btintel_pcie.c:btintel_pcie_remove() {
...
	if (current_work() !=3D &data->reset_work)
		disable_work_sync(&data->reset_work);
...
}

Meanwhile, the reset work executes btintel_pcie_perform_pldr() and
btintel_pcie_acpi_reset_method(), which unconditionally attempts to acquire
the same lock:

drivers/bluetooth/btintel_pcie.c:btintel_pcie_acpi_reset_method() {
...
	pci_dev_lock(data->pdev);
...
}

Does this deadlock the unbind thread and the reset worker thread?

> +		pci_dev_put(data->pdev);
> +		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);

[Severity: High]
This is a pre-existing issue, but failed resets seem to leave the device
permanently unresettable by failing to clear the recovery state flag.

When a reset fails (e.g., btintel_pcie_acpi_reset_method() returns an
error), btintel_pcie_perform_pldr() skips device_reprobe():

drivers/bluetooth/btintel_pcie.c:btintel_pcie_perform_pldr() {
...
	if (!ret) {
		if (device_reprobe(&pdev->dev))
			BT_ERR("BT reprobe failed for BDF:%s", pci_name(pdev));
	}
...
}

The control returns to btintel_pcie_reset_work(), which jumps to the out
label and exits without clearing BTINTEL_PCIE_RECOVERY_IN_PROGRESS:

drivers/bluetooth/btintel_pcie.c:btintel_pcie_reset_work() {
...
	if (data->reset_type =3D=3D BTINTEL_PCIE_IOSF_PRR_PLDR) {
		btintel_pcie_perform_pldr(data);
		goto out;
	}
...
out:
	pci_dev_put(pdev);
	pci_unlock_rescan_remove();
}

Since device_reprobe() was not called, the data structure is not
reinitialized. Does this leave BTINTEL_PCIE_RECOVERY_IN_PROGRESS set
indefinitely, causing subsequent calls to btintel_pcie_request_reset()
to return early without doing anything?

> +	}
>  }

[ ... ]

> @@ -3251,6 +3291,7 @@ static struct pci_driver btintel_pcie_driver =3D {
>  	.probe =3D btintel_pcie_probe,
>  	.remove =3D btintel_pcie_remove,
>  	.driver.pm =3D pm_sleep_ptr(&btintel_pcie_pm_ops),
> +	.driver.dev_groups =3D btintel_pcie_groups,

[Severity: Medium]
Does this initialization prevent the vendor_reset sysfs attribute from being
created?

This assigns the attribute groups to .driver.dev_groups of the pci_driver
struct. However, the PCI core's __pci_register_driver() explicitly
overwrites the nested .driver.dev_groups with the outer .dev_groups field.
Since .dev_groups is not initialized, it defaults to NULL, which will wipe
the assigned sysfs attributes during registration.

>  #ifdef CONFIG_DEV_COREDUMP
>  	.driver.coredump =3D btintel_pcie_coredump
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723094443.8554=
92-1-chandrashekar.devegowda@intel.com?part=3D1
