Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB81A36655D
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047120; cv=none; b=Rve9ky2mdRyF82CWal/dnBoGBIjFynu9n7Y+aAJFGp9IMmLHVXnQ9o+FCl1yfmGPZoumGtRfwemizNM990fEoXleBIqUv7mXrutRqUJ93FDW2IQ70Rsr3DcgYeF4CNKH+ar9C1s5SlvHewNI9rc57mz76fegczhPFr4s9pX1+Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047120; c=relaxed/simple;
	bh=rWafkZjU0/k1nbfZQ805GM3RzMV+9zubztqW7YRrNqA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=evPxE8ywwSjsFIYWGUsXQY0TTgkMwlPCE6/pN61qB68UhTpYNaD6wahqzUkC4F8nXCeByc7ciX+hzszEtnUDhEcjCoEQeVsbqPsbNUnqs6LLxrtE7PRBPRxbuc7oUY5uyBz+27i8jcCgT2TbPin/SgPJa3qwqBHgyHHPNqTvvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxz3lbbY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxz3lbbY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6301F000E9;
	Thu,  6 Aug 2026 20:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786047115;
	bh=oNssV0hBnU5ZZla3H4vAWRPu4xH6p+ho46rU1g262kY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qxz3lbbYdbpW4m1xetGOOcs5AVcygrW9Dhqse/WMnrCOyIiPGeMnOCaiBia2rYnXs
	 yXtM4zu2A77pdJRIX3BV7WLxjJRhIQziI4xrmfUL+uudMwrOuXz+1ZclzMhj4ATUY6
	 whr1XKxy3QH6sBJzL2OSLO6Py9quQhwGM4v7CZabyklKmNJMP3XA0kGLqHFaHZ68Um
	 Krlz/qLizWDWgWBI9K9nXD5N7P9dnAK+URNWVVj++mfqdj6iV+aiIAmIOQGyRaKRNZ
	 Q58tJt00/f2l1729wlbgrYBjZGiIovaLIRSszHRgKoa64h9V+Ot4b1pWE8hPVOF8Gw
	 yY4Qtt/jytMAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/8] PCI: vmd: Add vmd_bus_enumeration() helper
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806221351.38592-2-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
 <20260806221351.38592-2-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 20:11:54 +0000
Message-Id: <20260806201155.3E6301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but concurrent VMD d=
river probes will corrupt the global ACPI companion lookup hook, causing si=
lent ACPI enumeration failures.
- [High] This problem wasn't introduced by this patch, but SRCU teardown in=
 vmd_remove() races with active devm-managed IRQs, risking a Use-After-Free=
 in the interrupt handler.
--

--- Patch [1]: [PATCH v6 1/8] PCI: vmd: Add vmd_bus_enumeration() helper fu=
nction ---
commit 773d34aa9783fc8b62fb9cb40eac288e4cc56317
Author: Szymon Durawa <szymon.durawa@linux.intel.com>

PCI: vmd: Add vmd_bus_enumeration() helper function

Move the vmd bus enumeration code to a new helper vmd_bus_enumeration().
No functional changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6d..070b247b3fbbe 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
[ ... ]
> @@ -771,6 +771,54 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev,=
 void *userdata)
>  	return 0;
>  }
> =20
> +static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long featu=
res)
> +{
> +	struct pci_bus *child;
> +	struct pci_dev *dev;
> +	int ret;
> +
> +	vmd_acpi_begin();

[Severity: High]
This isn't a bug introduced by this patch, but could concurrent VMD driver
probes corrupt the global ACPI companion lookup hook?

If two VMD devices are probed concurrently (e.g., via PCI hotplug or parall=
el
sysfs bind), one thread will successfully set the ACPI hook and set the glo=
bal
static hook_installed =3D true.

The second thread gets -EBUSY from pci_acpi_set_companion_lookup_hook, retu=
rns
early from vmd_acpi_begin(), but hook_installed remains true.

When the first thread finishes bus enumeration and calls vmd_acpi_end(), it
clears the hook. The second thread, still enumerating its bus, will then fa=
il
to find ACPI companions for its children, breaking features like power
management and IRQ routing.

> +
> +	pci_scan_child_bus(bus);
> +	vmd_domain_reset(vmd_from_bus(bus));

[ ... ]

[Severity: High]
This is also a pre-existing issue in this file, but does SRCU teardown in
vmd_remove() race with active devm-managed IRQs, risking a use-after-free in
the interrupt handler?

When the VMD driver is unbound (e.g., via sysfs) or removed via hotplug,
vmd_remove() calls vmd_cleanup_srcu(), which destroys the SRCU structs via
cleanup_srcu_struct().

However, because the driver's interrupts were requested with
devm_request_irq(), they are not freed until the devres release phase, which
executes after vmd_remove() returns.

If an interrupt fires between cleanup_srcu_struct() and devm_free_irq(), the
vmd_irq() handler will blindly invoke srcu_read_lock() on the freed SRCU
struct.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806221351.3859=
2-1-szymon.durawa@linux.intel.com?part=3D1
