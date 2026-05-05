Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3613264C2
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025398; cv=none; b=cEMJWdC+lxTZ9Jf8EcH+pSmoMp9F3M7tEzngXVOLK7SonevdWbzot8fTXOey06XIDH542gSCb/iRHRCbg4BwjsX1y9y26F5GubDSwS+PoYWgmRHfOhaJDdavtgFNOeZqujA7U4MyhOGlMqt83hfSPghwJ4uodHh2Do0r0Nj1+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025398; c=relaxed/simple;
	bh=t+90LNdeQiAdwG9I/bOCuS87OwD+8NcSjAIU5OtDiCg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VjcntQPChWFC8qGfyX+vTBtALbfUL7sPYO4qL2BnibSM+fbpQv5YjO7bGE97YgjHZPs47zZ3Njxy0zKUsv/TU9/Suxm0Tg+bX/HgzeecEngv5a36JLt8o0YTfIXUBCtKx+S2wzK5TltEXpO5Hbp/oXMf4MDpY/K9PUB8a9RX9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7fBo999; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7fBo999"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6CDC2BCB4;
	Tue,  5 May 2026 23:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778025398;
	bh=t+90LNdeQiAdwG9I/bOCuS87OwD+8NcSjAIU5OtDiCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d7fBo999A0S2wUSWUWSdNzgq1KQnuM4ajl/DMDIgdyBlvKHENqJ3adA1WGIPWl2LO
	 rZPcW4XiNSyU4hs1wvBCaHQhT2ndSE9Cg8YbYcWEy6/OtTTt7L5vBIa++WiR6oi+W/
	 GOXe2t2fn8LzcMKMSiKDfM+x9BOHgBa8zZMuNpSpHMvc+yfvjMkpAOyWSyzTO8Ha+L
	 YqzXnrE143cydr2dfFsU5fd5D+irccEwjEGnN9VHiGuOC/WPlMarAnz6wEHIpf334C
	 4DTVLQxiND24X3X/h5aCetPTAIsg3Bbr7fDVUCOBVdQbXMhIz8zF2G/nnvsCMCeNKa
	 vI4Ty0lbxTwSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 6/7] vfio/pci: Add a reset_done callback for
 vfio-pci driver
Reply-To: sashiko@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505200510.2954-7-alifm@linux.ibm.com>
References: <20260505200510.2954-7-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 23:56:37 +0000
Message-Id: <20260505235638.3F6CDC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Concurrent execution of `vfio_pci_core_aer_reset_done` and `vf=
io_pci_core_disable` leads to an exploitable Use-After-Free on `vdev->pci_s=
aved_state`.
- [High] The return value of `pci_load_saved_state()` is ignored, potential=
ly pushing corrupted state to the hardware.
- [Medium] The state recovery logic is marked `static`, depriving vendor-sp=
ecific VFIO PCI drivers of the feature.
--

commit 50af2d4f1aef440c94cd13a26e090b9661198f8c
Author: Farhan Ali <alifm@linux.ibm.com>

vfio/pci: Add a reset_done callback for vfio-pci driver

On error recovery for a PCI device bound to the vfio-pci driver, this
commit attempts to restore the device state to its initial saved state
by adding a reset_done callback.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index f47a49ca67fae..6358b59fab2b1 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -2255,6 +2255,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(st=
ruct pci_dev *pdev,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
> =20
> +static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)

Vendor-specific VFIO PCI drivers sometimes override the .reset_done callback
in their pci_error_handlers. Should this function be exported instead of
static, so that vendor drivers can also invoke the core framework's state
restoration?

> +{
> +	struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev);
> +
> +	if (!vdev->pci_saved_state)
> +		return;
> +

Is there a race condition here between the AER recovery thread and the VFIO
device close path?

The AER thread invokes vfio_pci_core_aer_reset_done() holding
device_lock(&pdev->dev), but without VFIO-specific locks like dev_set->lock.

Concurrently, closing the VFIO device file descriptor invokes the disable
path:

vfio_pci_core_close_device() -> vfio_pci_core_disable()

The disable path runs with dev_set->lock held, but without
device_lock(&pdev->dev), and it frees the saved state:

pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state)

Could vdev->pci_saved_state be freed immediately after the check here,
causing a use-after-free when it is passed to pci_load_saved_state() below?

> +	pci_load_saved_state(pdev, vdev->pci_saved_state);
> +	pci_restore_state(pdev);

Can pci_load_saved_state() fail and return an error?

If it returns an error, such as -EINVAL for capability size mismatches,
dev->state_saved remains false and the capability buffers may only be
partially copied.

Since the return value is ignored here, does calling pci_restore_state(pdev)
immediately afterward risk pushing partially populated or corrupted state b=
ack
to the hardware?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505200510.2954=
-1-alifm@linux.ibm.com?part=3D6
