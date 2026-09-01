Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A447A896;
	Tue,  1 Sep 2026 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256188; cv=none; b=rdO4QsZ9LRqhJeiGSWZWcW0gamOVZwME4lHXGfxmajJaKGdClfu12k6vu9fQhU5cqdE5Xzxf/LuBUOh+fgprD7LEUx1DLOgCX5PfmC+k8qBFjLiXYG40RSAlo8vINWT6cImdisk9PcYmH5cemOT/eJuXBbVZPJBPh9KYJVOQ6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256188; c=relaxed/simple;
	bh=MMqIUtt3EJmUbVPEhw8hJ0e2KZzXCQK4RV4SwX7CfyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A/DYO4nKZJRD+3CU7z2p6VDkgW8sDXr1wao464+LbUvTNv4oevzwLgh+l3yuRsVbjuopf5zCRs4dxqId6kBkjTrMgBUTXlXw1cA/szd6Dt99VC7ngLPQsaJ9mxTnnZz3stKS6VHAIrY6Jw4Ema27dhZcWNfEudihbHi24pJbvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wv1NzxUB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv1NzxUB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19011F000E9;
	Tue,  1 Sep 2026 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256185;
	bh=qBWJgS3KUPmjU7/R0RxzB7VblO+85JcguHFHMnARIrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wv1NzxUBGqIrRLTBQlYNsQpjTZqF5y7vVHix58Z1rGtJWKZUdk3rs74N/t3OKOFgf
	 TtDJgSvtp1UP+Gl03EVqkepxdDyoIE8JWAcI83AlflYSXAiOdr6MArzr81eFULkApp
	 8nvdtCvpKfz+PZUmHfmlGt56d1FDNVYuqdMkJc1adrbQjJ+Jovtpbtu3kxbUWun/zj
	 EYwKUuSiYkYQ3f3RrPnISYg7vpom+hWJ7DaYO+ASKH5T7YqBIaKcm+8G9FsmaInSJ6
	 BH7GXXrdnRh/Zoe5BPox7DLaKQ5Dy/04Gg/cadmQCOzQ23YrgIkHmkimXZP70lLXn9
	 waLAvugnjAmiQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 11/19] vfio/pci: Serialize runtime PM with recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260901093217.8539-12-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-12-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:49:44 +0000
Message-Id: <20260901094944.D19011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `synchronize_irq()` in runtime suspend and missing `pm_run=
time_get_if_active()` in shared INTx interrupt handler.
--

commit ff5cf80e830fcc9b546457ca5f098d220807ca16
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Serialize runtime PM with recovery

This commit serializes runtime PM entry and exit with PCI error recovery by
holding the recovery_lock for reading. It ensures that BAR mappings and
DMA-BUF exports are handled safely without waking the device unnecessarily.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index bd3d79d28f27a..95884e713a4bd 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but it persists through this patch and seems
important since it can cause an AER panic and host crash.

The runtime suspend callback masks the INTx interrupt but fails to call
synchronize_irq() to wait for any executing handlers. In addition, the
interrupt handler accesses the PCI config space without verifying the device
is active.

In drivers/vfio/pci/vfio_pci_core.c:vfio_pci_core_runtime_suspend():

    vdev->pm_intx_masked =3D ((vdev->irq_type =3D=3D VFIO_PCI_INTX_IRQ_INDE=
X) &&
                            vfio_pci_intx_mask(vdev));

If the VFIO device is runtime suspended while sharing an INTx IRQ line
(IRQF_SHARED), and another device on the shared line triggers an interrupt:

In drivers/vfio/pci/vfio_pci_intrs.c:vfio_intx_handler():

    } else if (!ctx->masked &&  /* may be shared */
               pci_check_and_mask_intx(vdev->pdev)) {

The handler will execute without a pm_runtime_get_if_active() check and
read the PCI config space of the D3cold device. This causes a PCIe Unsuppor=
ted
Request (UR) error which can crash the host system. The read returns 0xffff=
ffff,
which the handler interprets as a pending interrupt, returning IRQ_HANDLED =
and
signaling a spurious interrupt to the userspace VM.

Could synchronize_irq() be added to the suspend path, and
pm_runtime_get_if_active() to the interrupt handler to prevent accessing a
powered-off device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D11
