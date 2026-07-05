Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99D3570AD
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783266582; cv=none; b=a+H1pM8teT5Axc+74mBM9AmEiWf1h9EjrbRE+P5KS+xIZ3wG1ERQLD4lcQ5Ty2O3fdROj+coPZJ6v7p1M8e2n4b60OYpdSfE0LRmrF8uR4LPuWtlSkdAVsKXR5VDY4fPafjiMGvabFTrHQZi09kErYuBHdyEMQqqWbKy+F55gPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783266582; c=relaxed/simple;
	bh=ZyuuTJD8WSJpVj1ZSu6ZmagEu619NT8H56USokb5/fs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q16KkeC/8UqOTQPcKPV6c7OjIu1PN4DJNjD3UwUyO5D7K/upQKOg2tDDDz02eHpakW+nxhP9J57PcUWBh5X1LHcQ56o5GoKYbuNcaBKinU0fidAatPbRvXZ9KKzvSjNy92mWYPRfXK431fnqtAsIJimie4nBCy2Y+3z+G/to95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvOqffEa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvOqffEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E24E1F000E9;
	Sun,  5 Jul 2026 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783266581;
	bh=IN+TGyfJD81gcwtsh2SIYHr3WSo0cL/X3+HJ/b3+yUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QvOqffEaN0MTM6I3Ge5/pQt1tAukkjeFI2c6u22laa3mfXcjg0TRB4G+kg93VSSAD
	 Xyat6Xu3kZOfZOr/grb8sizHMyMpZ2pQ9aiS9mOYIZdcwKB8kBl5S0WW33kodfBgnc
	 wvNBfcNU6qSNZAXFy6yPIV0FjVZbjYn6+y1E8A8wPgHe+nNZYTiub8w20RThEAmcnI
	 MFmjzZJjiCTR15rz/mabSuHzFI7CNdZ80FU4z3rttk9Ol//z01D+Dz3fV35+LgDuY8
	 uA1MlRkM4jsSif/CpFgh00+6QdHj8iy/dkHgUbRKpo6K6PpDJ7Q25/EkxrKyW53269
	 7ZcCdOHmL5Ywg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Fix AB-BA deadlock between remove and SR-IOV sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705152458.291832-1-lgs201920130244@gmail.com>
References: <20260705152458.291832-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 15:49:40 +0000
Message-Id: <20260705154941.0E24E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Unbinding the PF driver outside of `pci_rescan_remove_lock` vi=
olates locking rules for SR-IOV VF cleanup, causing a lockdep splat and a r=
ace condition.

Pre-existing issues:
- [High] The patch fails to resolve the AB-BA deadlock between sriov_numvfs=
_store() and device removal for the upstream bridge removal scenario and na=
tive PCIe hotplug.
- [High] Potential Use-After-Free of `dev` due to a lack of reference count=
ing after breaking sysfs active protection.
--

commit 6bda954b3e229ff563e88b2a1788be84c1d6f539
Author: Guangshuo Li <lgs201920130244@gmail.com>
Subject: PCI: Fix AB-BA deadlock between remove and SR-IOV sysfs

This patch attempts to fix an AB-BA deadlock between SR-IOV sysfs operations
and PCI device removal by unbinding the driver before entering
pci_stop_and_remove_bus_device_locked().

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5ec0b245a69bd..5eae725081297 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -519,8 +519,35 @@ static ssize_t remove_store(struct device *dev, stru=
ct device_attribute *attr,
>  	if (kstrtoul(buf, 0, &val) < 0)
>  		return -EINVAL;
> =20
> -	if (val && device_remove_file_self(dev, attr))
> +	if (val && device_remove_file_self(dev, attr)) {
> +		/*
> +		 * Mark the device as dead so that no new driver can bind
> +		 * between the unbind and the removal below. Once the dead
> +		 * flag is set, the device core will refuse any new driver
> +		 * probe.
> +		 */
> +		device_lock(dev);

[Severity: High]
This is a pre-existing issue, but can dev be freed after
device_remove_file_self() completes?

device_remove_file_self() breaks the sysfs active protection that guarantees
dev won't be freed. If a concurrent removal (like PCIe hotplug) completes
device_del() and drops the final reference to dev before the subsequent cal=
ls
to device_lock(), kill_device(), and device_release_driver(), will this
result in a use-after-free?

> +		kill_device(dev);
> +		device_unlock(dev);
> +
> +		/*
> +		 * Unbind the driver before removing the device to avoid an
> +		 * AB-BA deadlock between device_lock() and
> +		 * pci_rescan_remove_lock. Without this, remove_store() takes
> +		 * pci_rescan_remove_lock first via
> +		 * pci_stop_and_remove_bus_device_locked(), then takes
> +		 * device_lock() during driver release, while a concurrent
> +		 * sriov_numvfs_store() takes device_lock() first and then
> +		 * pci_rescan_remove_lock via SR-IOV VF removal.
> +		 *
> +		 * By unbinding first, the driver's .remove() callback,
> +		 * including any SR-IOV VF cleanup, completes before
> +		 * pci_rescan_remove_lock is acquired.
> +		 */
> +		device_release_driver(dev);

[Severity: Critical]
Does this bypass the required synchronization for SR-IOV VF cleanup?

If the driver's .remove() callback (e.g., in ice or igb) calls
pci_disable_sriov(), it will eventually call
pci_stop_and_remove_bus_device(). This generic function explicitly requires
the bus rescan/remove lock via lockdep_assert_held(&pci_rescan_remove_lock).

Since device_release_driver() is now called outside of
pci_rescan_remove_lock, will this cause a lockdep splat and allow concurrent
unsynchronized modifications of the PCI bus lists?

>  		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));

[Severity: High]
This isn't a bug introduced by this patch, but does the AB-BA deadlock
still exist when removing an upstream bridge?

The explicit unbind here only applies to the targeted device (dev). When
pci_stop_and_remove_bus_device_locked() is called, it acquires
pci_rescan_remove_lock and recursively unbinds child devices.

If it reaches a downstream SR-IOV PF, it will acquire device_lock(&pf->dev)
while holding pci_rescan_remove_lock.

If a concurrent write to sriov_numvfs on that PF acquires
device_lock(&pf->dev) and waits for pci_rescan_remove_lock, wouldn't the
exact same deadlock occur?

> +	}
> +
>  	return count;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705152458.2918=
32-1-lgs201920130244@gmail.com?part=3D1
