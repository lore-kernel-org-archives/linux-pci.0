Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7A30F815
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399058; cv=none; b=mo8csZgwMvBdOTO+pCZLSy0TCeNVLF/4tl7JW159c0SYg3151Hwr+mcNGGIrzqTNIe1fc3IHwu7bc4AKYAiCVJ7pTgoGs63Cuf1gg94zxGZk1YK+fZZEOBP7yTpGlL5iW5z0fBbauQ0L5fEYnCg4mSWfOluoMhjidKphjjDZeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399058; c=relaxed/simple;
	bh=D24L5DcBOXbqNu04qQRktX8kEasgjJJu0mAxpqFJ2m4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tf73ML2k9gtD7x35B69R/3AgnRFfLqxN/zSk4mOEvxbjtt/Ky9cAFoRU2ECMGhJ6X0xm+iRng0xcEPZWRSdNKX+27FDvsQggbiFFGxTAriWARLlVnd8bC1cia3UVRKnYS2aV+HfI/8CS7aPd/gAfwPC4Gdi2j4mxz2VOG0UKjOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crZfwdaC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crZfwdaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFA11F00893;
	Tue,  2 Jun 2026 11:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780399050;
	bh=QjB86anNSTPBmxi3wXZoRmPdvNkjgvpeBas1HN00EVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=crZfwdaCBPisbJfwYF94xj6tagWZfNAXCmZE+hAR4rMad66brc7FKGOCAjgey32Gl
	 7QHnBq3gOvUdGTIQ9T1D7RwWefBX7KrFLiCLjkuC8XvWpTz2GYUWyu64FFQa9mdAXQ
	 aZ4AcBOPNYgx2Kv07QxOCmFAiWY6IJkucVavlXsmd5Gtv5Rolkq0OkLsEvt6ywobmM
	 mHVRLeiBUQjmj4hhf+yE7HSRGxfugm3fMev+XFWjVycRZf03l86HPhp57KjUDVGvlS
	 sc1XjTPl9GEd5Ohg6x6JC6aaXemDcGbSpmrKCztR2NIGtBtc9e0bQ3Ofp1FR1gprjO
	 lNtqBuNggYpYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: Add pci=noaer_recovery kernel boot option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Murashka" <yurypm@arista.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260602105558.1799563-2-yurypm@arista.com>
References: <20260602105558.1799563-2-yurypm@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:17:29 +0000
Message-Id: <20260602111730.2EFA11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Bypassing recovery incorrectly returns the uninitialized inter=
mediate state `PCI_ERS_RESULT_CAN_RECOVER`, which causes the ACPI EDR subsy=
stem to report a recovery failure to firmware, potentially triggering a sys=
tem reset.
- [High] The `pci=3Dnoaer_recovery` option clears non-fatal AER error statu=
s bits but fails to clear fatal AER error status bits, leaving the device i=
n a persistent error state.
- [High] Bypassing recovery skips `dpc_reset_link()`, causing DPC containme=
nt to permanently disable the link and triggering PCIe hotplug (`pciehp`) t=
o destroy the device state.
- [High] Bypassing AER recovery accesses PCI configuration space without PM=
 runtime protection, potentially targeting a suspended device.

Pre-existing issues:
- [High] PM runtime reference is dropped before invoking the final permanen=
t failure callbacks, risking suspended device access.
--

commit 10d2b1d7566623bafffeeabe2e066bc1a7bfb30d
Author: Yury Murashka <yurypm@arista.com>

PCI: Add pci=3Dnoaer_recovery kernel boot option

AER error recovery is part of the AER error handling subsystem in the
Linux kernel. On large modular systems with a complex PCIe tree, AER
recovery could cause unexpected behavior and side effects. Sometimes it
would be nice to have the option to keep the system in an unmodified
state and be able to handle PCIe errors from userspace.

> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index bebe4bc111d75..c022cfd85b939 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c

[ ... ]

> @@ -216,6 +223,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *de=
v,
>  	pci_ers_result_t status =3D PCI_ERS_RESULT_CAN_RECOVER;
>  	struct pci_host_bridge *host =3D pci_find_host_bridge(dev->bus);
> =20
> +	if (pcie_aer_recovery_disable) {
> +		if (host->native_aer || pcie_ports_native) {
> +			pcie_clear_device_status(dev);

[Severity: High]
Does clearing the device status here attempt to access the configuration
space without PM runtime protection?

The early return block clears error statuses before the later PM runtime get
call, so the endpoint device may have entered a low-power state like D3hot
or D3cold before the handler executes.

Could this lead to dropped writes, failure to clear the error status, and
potential Uncorrectable Request errors on the bus?

> +			pci_aer_clear_nonfatal_status(dev);

[Severity: High]
Since this path deliberately bypasses recovery, will the downstream hardware
bus reset that normally clears fatal errors implicitly ever occur?

This function masks out fatal error bits, which leaves them permanently set
in the AER Uncorrectable Error Status register.

Does this block future AER reporting for the same error type and leave a
stale error state that might cause firmware or userspace to reset the
device?

> +		}
> +		return status;

[Severity: Critical]
By returning the intermediate status value PCI_ERS_RESULT_CAN_RECOVER, will
the ACPI EDR subsystem report a recovery failure to the firmware?

The Error Disconnect Recover subsystem checks if the return value is exactly
PCI_ERS_RESULT_RECOVERED. Receiving CAN_RECOVER causes EDR to send an
EDR_OST_FAILED message, which can lead the firmware to inject a Machine
Check Exception or reset the platform.

[Severity: High]
Does bypassing the shared recovery path unconditionally skip the
dpc_reset_link() call?

Without this call, the DPC Trigger Status is never cleared to release
hardware containment. When PCIe hotplug handles the Link Down event, it
waits for the waitqueue which times out:

drivers/pci/pcie/dpc.c:pci_dpc_recovered() {
    ...
    wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
                       msecs_to_jiffies(4000));
    ...
}

Does this cause the driver to be unbound and the device deleted, preventing
userspace from accessing or recovering it?

> +	}
> +
>  	/*
>  	 * If the error was detected by a Root Port, Downstream Port, RCEC,
>  	 * or RCiEP, recovery runs on the device itself.  For Ports, that

[Severity: High]
This isn't a bug introduced by this patch, but does dropping the PM runtime
reference before invoking the permanent failure callbacks risk accessing a
suspended device?

Looking at the error path later in pcie_do_recovery():

drivers/pci/pcie/err.c:pcie_do_recovery() {
    ...
failed:
    pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);

    pci_walk_bridge(bridge, report_perm_failure_detected, NULL);
    ...
}

Because the reference is released first, the device could immediately
transition to a low-power state. If the driver's callback attempts to access
registers for cleanup, could this trigger fatal bus Uncorrectable Request
errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602105558.1799=
563-1-yurypm@arista.com?part=3D1
