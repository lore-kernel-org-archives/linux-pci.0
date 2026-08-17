Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DDA26ED4F
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003414; cv=none; b=EBzejroRQZLwHwm/PHWY19aBSS7hxBR11VSTQ/XBwHA9SVbkiW9aMQp7oPJPh/dH4c23lkgQei2OK6pt8pCV8ZlN5naXNzO2DIIB6JVrl7hXIeGRxR968IBJ6LqeF4OzWURK4Di/o2TZVPfshHC+vzW7Hst8/imufTrSzrTkkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003414; c=relaxed/simple;
	bh=43XWvRJa498cyzaEjDTP+devg1YDPqyCCbOiOwn7mBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTB5rurA/Jqah3CUWsul9YKEGG21PSPss55ZqpErVj/GzXbFcl7ZJeSZKDKG9i18jBENHRygyCgBVejADAi9MO0jijuj3d8zm7gcCYJwp9RV3ETBlPTvD/LTNfwzPVAlJ9X3HOp2kfZj2FnP0lzRoO/o+FDblMMqZdYEjW5jyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=xqGMVoTy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dFQYJkbu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="xqGMVoTy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dFQYJkbu"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E591AEC037E;
	Mon, 17 Aug 2026 17:50:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 17 Aug 2026 17:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787003409;
	 x=1787089809; bh=icnTLJmXYs7ObsLz290ljEFrtnTyQgT630CXL0ZKw0o=; b=
	xqGMVoTyVA6qwuRckRkAE3bhd9V9xNoQrcoz4iH/TfaGeLjJPxS2yPXohF2KpLbD
	IRt1hBl4/Djn7O3nJXwG5RmM/E/akEMpzlRV/URKBt4Lby5FLVq2o/GhwFSfATC7
	5aQeHtcE2wgjFZSDKwjvoLQga5O7Tcl1FZFe1r9z1NAvPvXCcm7JIGvcftakQ9qX
	8fsp1eLz18AeAvJrbhmQIN5rB1tPLzqFOEraJ/m9nV9zLTAl0Vj6CLjv3hajql1K
	ukK6sbYnSkiQ++UgDzm+OOEdPUlroa0y2x411tyKZzZu2UD66qk5+CGKsKX60X2c
	ftJqWeWnpdarznG/88lDKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787003409; x=
	1787089809; bh=icnTLJmXYs7ObsLz290ljEFrtnTyQgT630CXL0ZKw0o=; b=d
	FQYJkbuO/Q2BdP+ox5GgmFZHT1SHcrkDHaKioLGea85dm+89AAjS7A6bItfmI0uy
	z1Az1DGgM5DSnzQuk7RAOFROT86DViZwVJor2pStAzdvFRXAA83iQdjlqlQJuO4G
	YPRAmZL8V4kxY0TCx7bXFvJIaaExrTcsF+f1kdOVfV8Yv37nm0MFGKAlUrm3tq1C
	7LpGxKJYjL9JsBjahm01wPZZZbTXd3tjtb37LPILPdW7mQOPEpL9ajhZOroqnZDK
	ECeMHFHa4gas5evKpqIucVISL41Ogs9aBhuMiMGz3In9B5qTOgv/Rij4htKZP8Ce
	AywTrwWuQNFXQ3BFj+6eg==
X-ME-Sender: <xms:EYKDat1hCoDXP9uZhlkyfeTMp-_welMo-wS7HhJ5ff7lmIWUsjANsw>
    <xme:EYKDajI0fUQv58DX2hsOe-WAD-IVEwiPUeXi0drEyS7ejvu_1cD08_1AoZ0gxNNJ9
    dnlF0cDK4-d3joI_mxgozkEz0U9kgKKG7FDjj4doFTf6YITvzvPhg>
X-ME-Received: <xmr:EYKDakHj2LP6alnDecEV3OVWVacs-DDkw_fwaV_SqItqZZyTljKg-fGlPZ4-fA>
X-ME-Proxy-Cause: dmFkZTGpCOzzADIXrIiKhRbHjFndj7JhsKKSWpe4rJOL+lGXj+isWZB7I79ydmqFZ1oe4r
    V/J4vrOSwjNxR8ohAjYm24qe/qSWXdaMf23gb7vXpf6480KgFw0F5/R/w2a1vB1EmsxMQ2
    1te3CaYR9SK98kCYIJfOShRQx2BycpjcDgUoLc52WY2wt4U3cFNLc1K6wRGVO6S/Gwwbc2
    IRALbm8CES3owWAPjPzs1KbPwkLMhavIFlXw+NMu+NtB+wAf/VW7PqndZb5JZRU5mZJA0n
    ep6/S9z4+JuQmfdZATISb/OGp0HuMkJnILlie5qwismW7F3XIqHR3uVuiLxvWNof6kbniV
    aLIxDvgpc5EZ6jwrt/20UCJvepIGPSYcfjqHCsPWZM/xn2BO/0VD343h5zm+REWnvEKepX
    R+0shr5Nq83uCZgiG9/4jZm+lpzZ2EXE98JEK0nqYrVNuMBvoDjJ3TZi4jCwOb1Ckd5CEX
    gEnzQlYcyXJJW2eE6nP8kCFqVK/UjOyftIJfcI7t+GiFtGGRxoxKUrj/szzIuHLYDA42aA
    PNSU60HB0TJZaIiOrMKLTEoB33GVDolQ1D/O70pAo7LjMHhnzUEaUFV5ZbfEdza2gKqiWQ
    eHT1MBWuNai7zNsHapobawc1hqzzrnvk7MciEI6xWBWw0DqhffRoKQzzRauQ
X-ME-Proxy: <xmx:EYKDanVGWsIiArdNMKS-8UT3wtQSMMB_DTQjhKXBPOsOmGSgcXCUSw>
    <xmx:EYKDakys121AFAWAGGBYyzwSKNXk9ZWDbveJipKWt5YRP-vJEtFP-A>
    <xmx:EYKDakSiaCgOmNhpSZ0W-hV1Zk4-NdAOrnTYkr7AA-_78Lr42vG3pw>
    <xmx:EYKDaoh_yUenhdf5oS-bV_Sz-tBqzJthJ4PilET9W89mOEnBoHs5gQ>
    <xmx:EYKDaqqVHc1VN21Y3NXc33zXtDHW_4zAp7nQbhIyU75k1uJ5nAcVaI5d>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 17:50:08 -0400 (EDT)
Date: Mon, 17 Aug 2026 15:50:06 -0600
From: Alex Williamson <alex@shazbot.org>
To: Keith Busch <kbusch@meta.com>
Cc: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <mattev@meta.com>,
 <matt@ozlabs.org>, <nekto0n@meta.com>, Keith Busch <kbusch@kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Restore standard PCI config space in
 .slot_reset()
Message-ID: <20260817155006.5be3b518@shazbot.org>
In-Reply-To: <20260817195110.2077698-1-kbusch@meta.com>
References: <20260817195110.2077698-1-kbusch@meta.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Aug 2026 12:51:10 -0700
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
>=20
> Hi Alex, Bjorn, Linux-PCI, and VFIO,
>=20
> I'd like to initiate, or maybe restart, a discussion regarding the
> current state of PCIe AER and DPC (Downstream Port Containment) recovery
> for devices bound to vfio-pci, potentially expanding to devices not
> bound to anything at all.
>=20
> Currently, when a link reset or Secondary Bus Reset occurs due to an
> AER/DPC event, the kernel PCI error recovery service executes reset
> routines across affected downstream devices. Since vfio-pci does not
> implement the .slot_reset() callback in its pci_error_handlers struct,
> the standard PCI config space (BARs, Command register, MSI-X setup,
> DevCtl, etc.) for downstream devices is left entirely uninitialized
> after the link is brought back up.
>=20
> Historically the PCI core introduced early pci_save_state()
> checkpointing prior to driver probe (e.g. commit 30d52f6385d8, "PCI:
> Save device state in pci_pm_init() before driver probe") precisely to
> ensure that the kernel maintains a valid baseline config space
> snapshot=E2=80=94even for driverless or stub-bound devices. However, that
> infrastructure was never fully connected to the error recovery callbacks
> for generic pass-through drivers.
>=20
> For bare-metal userspace drivers, like custom user-level drivers, this
> creates an operational deadlock:
>=20
> 1. The kernel PCI error handling triggers a bus/link reset, but leaves
>    standard PCI config space wiped back to power-on defaults.
> 2. The eventfd (VFIO_PCI_ERR_IRQ_INDEX) alerts userspace that an error oc=
curred,
>    but gives no indication of when link recovery/reset completes.
> 3. Userspace attempting to re-initialize or access the device races again=
st
>    the kernel's reset sequence or operates on zeroed/uninitialized config=
 registers.
> 4. While QEMU originally included stubs intended to coordinate AER recove=
ry with
>    guest OS drivers, that guest-host coordination infrastructure has rema=
ined
>    unimplemented for over a decade.
>=20
> In scenarios where userspace simply needs the underlying hardware
> restored to its known-good baseline state post-reset, having vfio-pci
> implement .slot_reset() and leverage the existing PCI core snapshot via
> pci_restore_state() bridges this gap cleanly.

Does it though?  Even for a simple reset to initial state we need to
prevent the host and guest stepping on each other across the reset as
well as tear down user modified state, like interrupts.

> We recently saw related discussions around VFIO error recovery on s390x
> (https://lore.kernel.org/linux-pci/20260603182415.2324-1-alifm@linux.ibm.=
com/#t),
> where platform-specific mechanisms had to be wired up to communicate PCI
> errors to userspace. However, for standard PCIe setups relying on
> generic kernel error recovery (pcie_do_recovery), vfio-pci still lacks
> the fundamental .slot_reset() handling needed to restore standard PCI
> config space after recoverying from a fatal error.

The s390x series preempts recovery for assigned devices and only
provides an extra reporting channel through vfio-pci.  I don't know if
that's a model we can (or want to) copy, but may work for them given the
underlying hypervisor virtualization of the device.

> ---
> A few questions I'd like to put to the list:
> 1. Since the PCI core already takes responsibility for holding the early=
=20
>    config space checkpoint, is calling pci_restore_state() during
>    .slot_reset() the appropriate place for vfio-pci to apply it, or
>    should this be explicitly driven/triggered via a VFIO ioctl?
> 2. Does returning PCI_ERS_RESULT_RECOVERED here create subtle state
>    issues if userspace directly modified config space registers that
>    were not captured in pdev->saved_config_space?
> 3. Should we pair this with an explicit "link restored / reset complete"
>    eventfd notification so userspace knows exactly when it is safe to
>    resume access?
>=20
> Appreciate any feedback or historical context on how VFIO and PCI error
> recovery should interact here.

Certainly the host saved state doesn't take into account user
manipulation of the device since the last snapshot.  But also, vfio-pci
error handling is currently limited to generating an event when a
non-recoverable error has occurred.  I don't think we can nudge it
forward in any meaningful way by implementing a .slot_reset to restore
a prior host snapshot.  That misses the user modified state,
coordination across error handling, and may not even match the hand-off
state of the device to the user.

Forwarding AER to the guest and continuing came up in another thread
recently where I proposed[1] an approach we might use.  Effectively we
need to proactively block access to the device during the host error
handling progression while providing some observability of that
process and the resulting state of the device.  GHES/APEI is
potentially a model that this "host-first" error handling hides behind
for a guest.  Thanks,

Alex

[1]https://lore.kernel.org/all/20260707161234.23ed28db@nvidia.com/

>=20
>  drivers/vfio/pci/vfio_pci_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 3f11a9624b9c0..5b42430337e29 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2347,6 +2347,13 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(st=
ruct pci_dev *pdev,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
> =20
> +pci_ers_result_t vfio_pci_core_aer_slot_reset(struct pci_dev *pdev,
> +					      pci_channel_state_t state)
> +{
> +	pci_restore_state(pdev);
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
>  int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
>  				  int nr_virtfn)
>  {
> @@ -2419,6 +2426,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
> =20
>  const struct pci_error_handlers vfio_pci_core_err_handlers =3D {
>  	.error_detected =3D vfio_pci_core_aer_err_detected,
> +	.slot_reset =3D vfio_pci_core_aer_slot_reset,
>  };
>  EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
> =20

