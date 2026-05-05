Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E23533F586
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976572; cv=none; b=JET2kRzwaIvkYZgyfka+d/kthmqHNW383fiS0fMqSJL1ezuyU1kTx4wZhJZMJ6dLxcLMLGDIjvgZcqDMXTss+mkGDFvk/WRyd7JSLJNDkH1z6xXTOhs143SYVqq8rIlahfa0GIc/0FVXMZLVobic1BEseMWWhT3R8GYsbrdYRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976572; c=relaxed/simple;
	bh=z2YmbsS2kZk9RBeybP4JYxHRl0VR7eIBvyk4ziLXiBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X0k+PebjtqVIosLbq0tJRwPsP+8K+sHfJSs0h33lPDzP97k9nYXUt0AMAHAKtB+gA7ySp3IC2iEOt6TKMi6/1a/cwBVG3k3OwZhtoos63apx9y16Pgi2UtWkhVtIinvtIOHd/zAFU6XnI7uCDhfvYiKSF7k23qWm6QihGzTVYPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrrrbJ+y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrrrbJ+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4754C2BCB4;
	Tue,  5 May 2026 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777976571;
	bh=z2YmbsS2kZk9RBeybP4JYxHRl0VR7eIBvyk4ziLXiBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NrrrbJ+yED95GIUS1jm715Mzdnm94Kg3PGPEHZoWLbg32qzv3Y/5tvgu2cPN6JBZk
	 dUafsxTmQg7tJc8OSGBs28NlOg0hWx+eVI7mmAVNHbHUcF6f0goPPVKPCOAokUGmGF
	 HkzGosy4yWZ9ALumX1AHCwUIr0g59FuFOF9PL4VPPVIKpbXur6dLBeIwMoPDDEXcXE
	 cOc68IGhVhwf3vr4wA1nMYr8Y7+Kfeynx+Q+a4QgB2HNksw0O5lbxkSX62AYu0i5Ez
	 ac18EXqXZ3D9aUbGei84VSmK6p4g7mFPlJfoQIXV6I2/xqASod0eaiUf8PKA8ECP2t
	 VsqzjQJ1O4CWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] usb: cdnsp: Add support for device-only
 configuration
Reply-To: sashiko@lists.linux.dev
To: "Pawel Laszczak via B4 Relay" <devnull+pawell.cadence.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505-device_only_branch_v2-v2-1-98cc19fbd02a@cadence.com>
References: <20260505-device_only_branch_v2-v2-1-98cc19fbd02a@cadence.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 10:22:51 +0000
Message-Id: <20260505102251.B4754C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] The platform probe function silently swallows `-EPROBE_DEFER` for =
the optional OTG IRQ, permanently breaking DRD mode.
- [High] The error path for platform device registration in `cdnsp_pci_prob=
e()` incorrectly frees a shared driver wrapper, causing a Use-After-Free.
- [High] Concurrent execution of `cdnsp_pci_probe` across both PCI function=
s leads to a NULL pointer dereference.
- [Medium] Concurrent execution of `cdnsp_pci_remove` across both PCI funct=
ions causes the shared driver data to be leaked.
- [Medium] PHY mode is left unconfigured when operating in peripheral-only =
mode.
- [Medium] Forcing IORESOURCE_MEM on an unpopulated Host BAR creates a conf=
licting, zero-length memory resource.
- [Low] `cdns_get_id()` returns the Host ID instead of the Peripheral ID fo=
r Device-only mode.
--

Note: The format of this report has been altered to provide a free-form sum=
mary
of the findings due to recitation restrictions. Direct patch quoting has be=
en
omitted.

commit a05f3bd009fe3424669de67ea28711725bd2a6c9
Author: Pawel Laszczak <pawell@cadence.com>
Subject: usb: cdnsp: Add support for device-only configuration

This commit introduces support for operating the Cadence USBSSP controller
in a peripheral-only mode, bypassing the Dual-Role Device logic. It also
updates the BAR indexing for the peripheral-only configuration.

In cdns3_plat_probe(), the code fetches the optional OTG interrupt via
platform_get_irq_byname_optional(). If it returns -EPROBE_DEFER, the check
for negative values sets cdns->no_drd =3D 1 and continues in Device-only mo=
de.

Does this break the probe deferral mechanism? On platforms where the IRQ
controller probes later, the controller would be permanently degraded to
peripheral-only mode instead of deferring and retrying.

Looking at cdnsp_pci_probe(), when the second PCI function probes, it fetch=
es
the shared state wrapper via pci_get_drvdata(). If the platform device
registration fails, the error path unconditionally calls kfree() on the wra=
pper.

Can this lead to a use-after-free? The wrapper was allocated by the first
function and is actively stored in its driver data. Freeing it would corrupt
the first function's state, and when removed later, cdnsp_pci_remove() would
dereference the freed wrapper.

Also in cdnsp_pci_probe(), the driver relies on pci_is_enabled() to check if
the sibling function has already been probed. Since pcim_enable_device()
increments the enable counter early in the probe, concurrent probes could
both see pci_is_enabled() as true.

Could this cause a null pointer dereference? One thread might call
pci_get_drvdata() before the other has called pci_set_drvdata(),
receiving a null pointer that is immediately dereferenced when accessing
the wrapper's resources.

Similarly, in cdnsp_pci_remove(), the shared wrapper is conditionally freed
if the sibling function is not enabled. Since pcim_enable_device() uses
managed resources, the actual PCI disablement occurs after the remove
callback completes.

If both functions are unbound concurrently, would both threads see the
sibling as still enabled, causing them both to skip the kfree() and leak
the wrapper memory?

The updated cdns_drd_gadget_on() function returns early if no_drd is true.

Does this leave the PHY mode unconfigured? Skipping the rest of the function
also skips the phy_set_mode() calls for the USB2 and USB3 PHYs, leaving
them in an undefined state which might prevent the link from establishing.

In cdnsp_pci_probe(), the driver sets up the host resource using BAR 0 and
assigns the memory resource flag.

In a device-only configuration where the host controller is absent and
BAR 0 is unpopulated, pci_resource_start() and pci_resource_end() typically
return 0. Could passing a base-0 memory resource cause the platform core to
attempt claiming physical address 0 and abort the probe?

When the no_drd flag is true, cdns_get_id() is modified to return 0.

Since 0 corresponds to the host ID, does this incorrectly identify the
device-only controller as a host? Even if the role state machine handles
it later, returning the host ID for a peripheral-only setup seems
structurally flawed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505-device_onl=
y_branch_v2-v2-1-98cc19fbd02a@cadence.com?part=3D1
