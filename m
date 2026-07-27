Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B527732
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130544; cv=none; b=f9T4EAGlmzlzhsBSeiP9K2MYPDPBIslWoR53xnP7UHFZrOlKpnVmJSDnMlfKcIQvYtd2dfYoE2ic55Ulq/0MRs1qR6GXmJG7Vf00XLXFc8kr/VP2ItCImtONRIXZXjwBsaFuYb6kSc1799JJjL8nGMBsJwPy2RJ4icMghfcOjt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130544; c=relaxed/simple;
	bh=5n0ePbI9DXVprOjjNEhdZt9jburmqI9Eqg7J/hf38zo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KDfXIiuKEawEl9/bMvHIQKkHcNfm4VL0S+ZmIcjwuEfTjr8j2jMA4C2eNnwZZv3v6s1jO+12d7G9OnrazuszswlUv0Fz83oBxPBpuDKfs7OMF7t2bIfaE0VE9F5gF7FYmS3ztiUQkDrz3a0AkaW6vHfRPH2XXPwcKX5d2HIoHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvBblQh4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvBblQh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9301F000E9;
	Mon, 27 Jul 2026 05:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785130542;
	bh=Y8NNPGxyNpDndAvfb1Nz/EtaqfcidzYDmu3AN8Ssf/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DvBblQh40EK3YCvtBBYBqJRUAnFHENVSERhj+ciEpo5mMIKZq2v238LOQfT4SGP7L
	 LAam+KELNPnjivyYhu/2e3euB1znCl53Lo6BNpNsUmbXuWsu/uO8zBhipQt0JdZz3H
	 cTBEhrbHc5Nbf32nI5WF0lXMIMcnuwIqnP0I6WAAyixj8E8utrFo+5OtYIi2SbcO94
	 6axnGEhvC/hbdkpPa53ixWkN3GngVSvewQrTDxmQDIDeHL5yka8mE9lNA0JA8pwKIx
	 uxeeSat1NB2RxOc6tLphXroNf7IfqL5CwH+hTbCne3M8uVyyFOMiTBSynIeWVZtt8b
	 xmoU+8KD8Bqzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs
 for PLDR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chandrashekar Devegowda" <chandrashekar.devegowda@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727052104.1026824-1-chandrashekar.devegowda@intel.com>
References: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
 <20260727052104.1026824-1-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 05:35:42 +0000
Message-Id: <20260727053542.6D9301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The `vendor_reset` sysfs attribute silently drops manual PLDR re=
quests if the device setup failed.

Pre-existing issues:
- [High] ABBA deadlocks between driver unbind/hot-remove and `reset_work`.
- [High] Missing state cleanup on reset failures permanently blocks all fut=
ure reset attempts.
- [Medium] Leaked PCI device reference when reset work is canceled during m=
odule removal.
--

--- Patch [1]: [PATCH v6] Bluetooth: btintel_pcie: Add vendor_reset PCI sys=
fs for PLDR ---
commit 405f703cae1beabdc354fcdf50ce09274b48b2a9
Author: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs for PLDR

Add a read-write sysfs entry at /sys/bus/pci/devices/<BDF>/vendor_reset
to allow userspace to trigger PLDR (Product Level Device Reset).

> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
[ ... ]
> @@ -2790,6 +2790,43 @@ static void btintel_pcie_hci_reset(struct hci_dev =
*hdev)
>  	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
>  }
> =20
> +static ssize_t vendor_reset_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	unsigned int val;
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	struct btintel_pcie_data *data =3D pci_get_drvdata(pdev);
> +
> +	if (!data || !data->hdev)
> +		return -ENODEV;
> +
> +	if (kstrtouint(buf, 10, &val) || val !=3D 0) {
> +		bt_dev_warn(data->hdev, "PLDR rejected: invalid input");
> +		return -EINVAL;
> +	}
> +
> +	bt_dev_info(data->hdev, "PLDR triggered via sysfs");
> +	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR);

[Severity: Medium]
If the device fails during its initial probe and BTINTEL_PCIE_SETUP_DONE is
never set, will this silently drop the manual PLDR request?

Looking at btintel_pcie_request_reset(), it aborts early if the setup flag
is missing:

static void btintel_pcie_request_reset(struct btintel_pcie_data *data, ...)
{
    if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
        return;
    ...
}

Since vendor_reset_store() returns count and logs success, won't userspace
be unaware that the recovery attempt was ignored?

[Severity: High]
This is a pre-existing issue, but does exposing this reset via sysfs
introduce an ABBA deadlock against device unbind or PCI hot-remove?

If a user writes to the remove sysfs file of the PCI device, the PCI core
acquires pci_lock_rescan_remove() and calls the driver remove function.
Then btintel_pcie_remove() waits for the reset work:

btintel_pcie_remove()
    disable_work_sync(&data->reset_work);

If the reset work has already started, it attempts to acquire the lock:

btintel_pcie_reset_work()
    pci_lock_rescan_remove();

Alternatively, if the device unbind sysfs file is written, device_lock() is
held. Then the reset work calls btintel_pcie_acpi_reset_method() which
attempts to acquire the same lock:

btintel_pcie_acpi_reset_method()
    pci_dev_lock(data->pdev);

Could a concurrent sysfs reset and driver unbind cause a deadlock?

[Severity: High]
This is a pre-existing issue, but can this recovery mechanism become
permanently blocked if a reset fails?

When btintel_pcie_request_reset() is called, it sets a flag to prevent
concurrent resets:

if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
    return;

If the reset operation fails (for example, in btintel_pcie_perform_pldr),
it skips device_reprobe(). Because reprobing is the only path that clears
the IN_PROGRESS flag, won't the flag remain set permanently?

If this happens, won't all future writes to this sysfs attribute be ignored?

[Severity: Medium]
This is a pre-existing issue, but can this leak a PCI device reference if
the module is removed?

Calling btintel_pcie_request_reset() increments the reference count:

btintel_pcie_request_reset()
    pci_dev_get(data->pdev);
    schedule_work(&data->reset_work);

If the driver is unbound before the work executes, btintel_pcie_remove()
cancels it:

btintel_pcie_remove()
    disable_work_sync(&data->reset_work);

If disable_work_sync() successfully cancels the pending work, the work
never runs and pci_dev_put() is never called. Could this leak the pdev
structure?

> +
> +	return count;
> +}
> +
> +static ssize_t vendor_reset_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727052104.1026=
824-1-chandrashekar.devegowda@intel.com?part=3D1
