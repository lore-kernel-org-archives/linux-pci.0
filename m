Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76F3AFB07
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997046; cv=none; b=V2lrbFPYr3ZwXe7NW4K6zde6yVPnpZMs5/IqQ7/rEU8fXAF+ASE5r++QUBU7s+p9vOJCeLkj+5hTJgB9fftXErVkZUfAn8FLrBa/vNHgr5cQqRVqLLZ4RudsbDrRcXkA4eWUFPjpd2+wmewZ/wpkiKEEmSuFGle3RPxTMQyiScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997046; c=relaxed/simple;
	bh=znLnXba9G2Bw5zKL5sQH+N8emqO1lbs6S29u8ElQPlk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qF6LBM1QSn0H9vTL5b3aAv3oCcdm9xQ3RRo8TGnUihXa5OLZqmpIg/eChZNhxZjyMMM61MJeA+DvqMZUyt4dcV45oxrs2O00vMqXpjre4JoQoqclJRrE7gl4CDLjh6L0Jq5Ucgu7YunM7u7i6pqUu+0nNXNJH5BS36X5nylXpyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc84D2zl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc84D2zl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3121F000E9;
	Mon, 17 Aug 2026 20:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786997044;
	bh=61MzQAlqcIX5494Wyjeb/tJPU0fw3DSul/fdvf7Qhb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bc84D2zl9jB/emlYdfjFT79hH7ytGAO+vvL2MXuz3km4D3jqyUq36XVjweDoOEj1F
	 ogrGV5ZQQmk+o/n9bzO3FoMnZcOsGjI9jcCcTfFZgSbmbjSuj7y1ZziQ6NB2wbnXi7
	 M0LjTCmg73pVG41bKjpkHkmM8zqf0gW5vdGEX9Z9Dxkub2jt5N72ouGazp7I+ANRZA
	 GNdVn3sPs+H4aIulLNB8rb9GCPXI3CP/pwX4pDfA2Xp4SUqzKnOyAlRgXEcLvM1N2/
	 0Tj1NvQUCyFjSUubiWo5IPJRi4GcyEurhTX5zjhDY+KByHVAqYoeotw+Esgj6yVRWz
	 BCoYZd277xZnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio/pci: Restore standard PCI config space in
 .slot_reset()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keith Busch" <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260817195110.2077698-1-kbusch@meta.com>
References: <20260817195110.2077698-1-kbusch@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 20:04:04 +0000
Message-Id: <20260817200404.BB3121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] The `vfio_pci_core_aer_slot_reset` callback has an incorrect f=
unction signature that violates `struct pci_error_handlers`, causing CFI pa=
nics.
- [High] The newly added `.slot_reset` callback is unreachable dead code fo=
r isolated VFIO devices because `error_detected` never returns `PCI_ERS_RES=
ULT_NEED_RESET`.
- [High] `pci_restore_state()` clobbers userspace runtime PCI configuration=
 with an outdated kernel probe-time snapshot, breaking VFIO virtualization =
state.
- [High] `pci_restore_state()` modifies hardware state locklessly, bypassin=
g VFIO synchronization primitives and causing severe race conditions with c=
oncurrent MMIO accesses.
- [Medium] Prematurely returning `PCI_ERS_RESULT_RECOVERED` from `.slot_res=
et` races with userspace recovery logic due to the lack of a reset completi=
on notification.
--

--- Patch [1]: [PATCH] vfio/pci: Restore standard PCI config space in .slot=
_reset() ---
commit e72e9372390b9003aeabcf98521c52beaad6c1a4
Author: Keith Busch <kbusch@kernel.org>

vfio/pci: Restore standard PCI config space in .slot_reset()

Currently, when a link reset or Secondary Bus Reset occurs due to an
AER/DPC event, the kernel PCI error recovery service executes reset
routines across affected downstream devices. Since vfio-pci does not
implement the .slot_reset() callback in its pci_error_handlers struct,
the standard PCI config space (BARs, Command register, MSI-X setup,
DevCtl, etc.) for downstream devices is left entirely uninitialized
after the link is brought back up.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index ea7bcd44bdfa9..9abf725446158 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -2351,6 +2351,13 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(st=
ruct pci_dev *pdev,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
> =20
> +pci_ers_result_t vfio_pci_core_aer_slot_reset(struct pci_dev *pdev,
> +					      pci_channel_state_t state)

[Severity: Critical]
Does the extra pci_channel_state_t argument violate the slot_reset
callback signature in struct pci_error_handlers?

The slot_reset callback expects a function pointer with exactly one
argument: pci_ers_result_t (*slot_reset)(struct pci_dev *dev).

Will this extra argument cause a control flow integrity panic or compiler
type-mismatch error when the PCI AER core invokes this via
err_handler->slot_reset(dev)?

[Severity: High]
Is this callback reachable under normal single-device circumstances?

In pcie_do_recovery(), the report_slot_reset broadcast is gated behind
checking if the combined error status is PCI_ERS_RESULT_NEED_RESET.

However, vfio_pci_core_aer_err_detected() unconditionally returns
PCI_ERS_RESULT_CAN_RECOVER. The PCI recovery state machine promotes
CAN_RECOVER to RECOVERED during the mmio_enabled phase, so the
condition to call slot_reset evaluates to false unless another driver
on the same PCIe bridge votes for NEED_RESET.

> +{
> +	pci_restore_state(pdev);

[Severity: High]
Can pci_restore_state() clobber userspace runtime configurations with
an outdated probe-time snapshot?

For a VFIO device, pdev->saved_config_space contains the host kernel's
baseline state captured during vfio_pci_core_enable(). Subsequent
userspace modifications (like enabling bus master or setting up MSI)
are recorded in VFIO's virtual cache (vdev->vconfig) but do not update
pdev->saved_config_space.

Will reverting the hardware to this stale baseline silently destroy
guest configurations while VFIO still thinks they are intact?

[Severity: High]
Does modifying the hardware state here locklessly bypass VFIO
synchronization primitives?

The PCI AER core invokes the slot_reset callback holding only the
baseline device lock. VFIO relies on vdev->memory_lock (using
down_write(&vdev->memory_lock)) to serialize state-mutating operations
against concurrent userspace operations like vfio_pci_rw or MMIO page
faults.

Could calling pci_restore_state() without this lock rewrite BARs and
the PCI Command register concurrently with active userspace MMIO accesses,
potentially causing host crashes or machine check exceptions?

> +	return PCI_ERS_RESULT_RECOVERED;

[Severity: Medium]
Does returning PCI_ERS_RESULT_RECOVERED here create a race condition
with userspace recovery logic?

VFIO notifies userspace via the VFIO_PCI_ERR_IRQ_INDEX eventfd when
an error is initially detected. By unconditionally returning
PCI_ERS_RESULT_RECOVERED, the host kernel completes its physical PCI
recovery and brings the link fully up before userspace has a chance
to react or rebuild its state.

Since there is no explicit completion notification to coordinate with
the kernel's state machine, will userspace operate blindly and potentially
attempt to access the device concurrently during the kernel's reset
sequence?

> +}
> +
>  int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817195110.2077=
698-1-kbusch@meta.com?part=3D1
