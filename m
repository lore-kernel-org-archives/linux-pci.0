Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB0491B25
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420870; cv=none; b=hVPtgVffkoPt5dZtLu1i7HSpT7K7R5h7LKLp7p5XzcwKM/mB+6Jak57phCtXmGuTqteHAPqwfTeJkJrbdktNba9I5G4mw7M0LpVKArH4iatX6Drd0NZedilgxUe+/BZEg41YK4fmiRCmPIuOlk9LQ5FOiPvZGkJHyNiSJN92jD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420870; c=relaxed/simple;
	bh=sUawkdV/q8XbsdCTU9h4Hg2JIXWlh3WTTeqEF3xHcaw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pqsGteG1osY02WRYWa6TOWtRFZ9+Q01uC2qCr7jPUP6l7Dq46deZD5sNjQ0fRZ2nDd5QoYsr1yfCzSydMwKfToA7hWXr87xP4ne8nBhJ3wuyoKzmozabcRmiV+P9EaYy5/ueSgypMEeo0m7dhFpa4lBOMDN6D0rId+yIGzzelKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbPwn7VZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbPwn7VZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD061F000C4;
	Mon, 19 Oct 2026 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420868;
	bh=25+L5eDxT45BIwULOKBe/6/BmeChDC3UKew0KMD+kmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UbPwn7VZqHBAqSCtOlrGMHtQFEb582U8prEZQ0EPHXiNsCSF2FAMMLYPtCNlVTQ9M
	 ad2kCCeMT5K40i/y4CKMdCoXLKHEC4QZJKTnR00PWwsANhBUKC9G5+3BJc2WwKM7Dv
	 f3M3F3Pd7IrMN9GB2y3o491ojh/B1DkCk0qltqkfF4Km7mEshhsD8HkmyO5tB+pPQM
	 76vXwNRXkBYSkRf/cFLbV2rbjrri62sp/EAXugGzc0C4bORrjHPe5E9ZyHT9gNngGO
	 XXqAIe0NBlKyDy+h4fkQkJL3gJYF4ABw3Dct5iIASu5cQSg0TLtMGbtWA5Y4CAlavB
	 ecseFcKEK8e2Q==
Message-ID: <sashiko-outbox-177472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] PCI: Avoid saving config space state
 if inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019135441.1420968-191-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-191-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:41:08 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: skipping pci_save_state() in pci_dev_save_and_disable() break=
s restore
--

commit 4874b436f59a1ea615f5afac75821d16d1d67918
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Avoid saving config space state if inaccessible

This commit adds a helper to check whether PCI config space is accessible
before saving state during device reset, skipping pci_save_state() when
reads return an error response.

Link: https://patch.msgid.link/20260805165518.794-4-alifm@linux.ibm.com

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006cc..78048bce859d4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -5127,6 +5149,9 @@ static void pci_dev_save_and_disable(struct pci_dev=
 *dev)
>  	 */
>  	pci_set_power_state(dev, PCI_D0);
> =20
> +	if (!pci_dev_config_accessible(dev, "save state"))
> +		return;
> +
>  	pci_save_state(dev);
>  	/*
>  	 * Disable the device by clearing the Command register, except for

[Severity: High]
Does skipping pci_save_state() in pci_dev_save_and_disable() prevent
pci_dev_restore() -> pci_restore_state() from restoring config space after
the reset completes?

Upstream commit e18d1abc3bff0a24a5299f3c150ab9546e9439aa relies on
prerequisite commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at
all times"), which added pci_save_state(dev) to pci_bus_add_device() during
enumeration and removed the dev->state_saved check from
pci_restore_state().

In this tree, commit a2f1e22390ac is not present.  In drivers/pci/probe.c,
pci_device_add() initializes dev->state_saved =3D false, and in
drivers/pci/bus.c, pci_bus_add_device() does not call pci_save_state(dev):

drivers/pci/probe.c:pci_device_add() {
	...
	dev->state_saved =3D false;

	pci_init_capabilities(dev);
	...
}

Furthermore, in drivers/pci/pci.c, pci_restore_state() still checks
dev->state_saved at entry and clears it on every restore:

drivers/pci/pci.c:pci_restore_state() {
	if (!dev->state_saved)
		return;
	...
	dev->state_saved =3D false;
}

When config space is inaccessible prior to a reset (such as during DPC
containment or link-down error recovery via pci_reset_function(),
pci_reset_function_locked(), pci_try_reset_function(), __pci_reset_bus(),
or __pci_reset_slot()) and dev->state_saved is false =E2=80=94 either becau=
se no
driver saved state at probe or because a prior reset or PM transition
(such as vfio_pci_ioctl_reset(), pci_reset_bus(), vfio_pci_set_power_state(=
),
or pci_pm_runtime_resume()) already called pci_restore_state() and cleared
dev->state_saved =3D false =E2=80=94 returning early in pci_dev_save_and_di=
sable()
leaves dev->state_saved as false.

When the reset finishes and pci_dev_restore() calls pci_restore_state(dev):

drivers/pci/pci.c:pci_dev_restore() {
	const struct pci_error_handlers *err_handler =3D
			dev->driver ? dev->driver->err_handler : NULL;

	pci_restore_state(dev);
	...
}

won't pci_restore_state() bail out immediately without restoring BARs,
PCI_COMMAND, MSI/MSI-X, or PCIe capabilities, leaving the device at its
unconfigured post-reset register defaults?

Should prerequisite commit a2f1e22390ac ("PCI/ERR: Ensure error
recoverability at all times") be backported along with this change?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-191-sashal@kernel.org?part=3D1
