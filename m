Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3131C34B1B0;
	Tue, 14 Jul 2026 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028516; cv=none; b=GGjTsRcs8jnfiiA+XmzG18cl0/Xq+3qKDvAKgsjcwx3mbbrMx8We9SbbMm0MCTdgea220r/W2NgtPtR2PrvOAvduskhUNHNGBAC08y7Wf7p4xX6Dxy9Ei0GQqHKP4uG9cNKl4K1HZ5T9d1vSpmO7bCoyAc+uAn0kkzE7KRDIBcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028516; c=relaxed/simple;
	bh=bsKYA+ZJEgs+Lrd4GJzOD6g+/9a9SeUqzwhlf2eTMuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pgHh6WZbma98LBuB5bRImgCZbFWC20JQB3+GycfLFbo/txKAm74xtgAFpoDfmWSj0CnJeuvS2dEiJSt0eRfAGqRu1vyvJFO1CMGaAZIPoHxEFzt4+MsLt0JCt2AFMJvtFUVoU3XhIFQTdz4zJFLqS6cm/TDyZb1Rd+6e3zqV8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jb54BuZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jb54BuZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB681F000E9;
	Tue, 14 Jul 2026 11:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784028514;
	bh=xXT7+gGXn6VMW/79KjmsIjoohbdeCmfHyrS0kjNq528=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jb54BuZPuTtLHpHFKRAmQChZKaI4zvDSpQ5spgjpp6lSte09NJV2Boezi9sVfqO/N
	 mle2laB04StOf/v9UzCIZ0I97DukJLWppZZkL1uzt8rnSGg+42fEh9yRlggmKbUfSu
	 zpnINMtml5otbHLbCaSzXg1TxQy5Jq0LEy4Dz+UfATeHVoRofSuAKAWlTtFUvW1j3b
	 2feBoNZGdfE7cL0e/TgYhvLm8qgv719fDv/iasTXh95fMwMJbgdDdjCkJy11c3TrbW
	 JC02xUJW1ZH8L78KUR9CwTZo6JX0NVm1PdCwxQ+7OGl/gl1T/yWLaJuTu3YRKagGa3
	 1RSzO01Plsx5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 15/16] vfio/pci: Sync core PCI TPH software state
 across device lifecycle and resets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260714104325.54444-16-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-16-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:28:34 +0000
Message-Id: <20260714112834.AFB681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] VFIO_DEVICE_PCI_HOT_RESET fails to synchronize software TPH state =
for all devices in the affected reset group.
- [High] Unlocked calls to `pcie_disable_tph()` in VFIO ioctl reset paths c=
ause TOCTOU data races with concurrent TPH configuration.
- [High] TPH virtual configuration space (`vconfig`) remains stale after re=
set ioctls, permanently breaking future TPH enablement.
- [High] pcie_disable_tph() accesses PCI configuration space without holdin=
g a runtime PM reference, which can race with device suspension.
--

--- Patch [15]: [PATCH v20 15/16] vfio/pci: Sync core PCI TPH software stat=
e across device lifecycle and resets ---
commit 0b983b3e1196f13bb26ca2c1d7517ec00ad08a77
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Sync core PCI TPH software state across device lifecycle and rese=
ts

Hardware resets clear PCI TPH registers, but core PCI driver software TPH
state can become stale across device open/close and reset paths. This patch
calls pcie_disable_tph() during device enable/disable and after reset ioctls
to synchronize the software tracking state with the hardware.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index ae2e0e2252a1e..c509adb76955d 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1573,9 +1579,15 @@ long vfio_pci_core_ioctl(struct vfio_device *core_=
vdev, unsigned int cmd,
>  	case VFIO_DEVICE_IOEVENTFD:
>  		return vfio_pci_ioctl_ioeventfd(vdev, uarg);
>  	case VFIO_DEVICE_PCI_HOT_RESET:
> -		return vfio_pci_ioctl_pci_hot_reset(vdev, uarg);
> +		ret =3D vfio_pci_ioctl_pci_hot_reset(vdev, uarg);
> +		if (!ret)
> +			pcie_disable_tph(vdev->pdev);

[Severity: High]
Does this successfully clear the software state for all devices in the reset
group?

When userspace invokes VFIO_DEVICE_PCI_HOT_RESET, the hardware TPH state
is cleared for all devices in the reset group. However, only the targeted
vdev has pcie_disable_tph() called.

Will other devices in the reset group retain pdev->tph_enabled =3D=3D 1,
causing pcie_enable_tph_ext() to fail with -EBUSY when userspace attempts
to re-enable TPH later?


[Severity: High]
Can pcie_disable_tph() race with device suspension here?

vfio_pci_ioctl_pci_hot_reset() acquires PM runtime references for all devic=
es
but drops them via pm_runtime_put() before returning. If the device is
configured for runtime PM, it may immediately begin suspending.

Since pcie_disable_tph() performs an unlocked pci_write_config_dword(),
does it risk accessing the PCI configuration space of a suspended device,
potentially leading to PCIe Completion Timeouts or dropped writes?

> +		return ret;
>  	case VFIO_DEVICE_RESET:
> -		return vfio_pci_ioctl_reset(vdev, uarg);
> +		ret =3D vfio_pci_ioctl_reset(vdev, uarg);
> +		if (!ret)
> +			pcie_disable_tph(vdev->pdev);

[Severity: High]
Is there a data race with concurrent TPH configuration?

The reset handlers drop dev_set->lock and vdev->memory_lock before
returning, allowing pcie_disable_tph() to run locklessly.

If a concurrent userspace thread writes to the TPH virtual config space, it
takes memory_lock and calls pcie_enable_tph_ext(). Can these two threads
concurrently modify PCI_TPH_CTRL and pdev->tph_enabled, corrupting the
tracking state?


[Severity: High]
Does this leave the virtual configuration space (vconfig) stale?

While pcie_disable_tph() clears the hardware state and pdev->tph_enabled,
it doesn't update vdev->vconfig.

If the guest OS later rewrites the config space to re-enable TPH,
vfio_tph_config_write() will see:

    new_ctrl =3D le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL=
]);
    if (new_ctrl =3D=3D org_ctrl)
        goto out;

Since vconfig still contains the enabled state from before the reset, won't
this treat the write as a no-op, leaving TPH permanently disabled in hardwa=
re?

> +		return ret;
>  	case VFIO_DEVICE_SET_IRQS:
>  		return vfio_pci_ioctl_set_irqs(vdev, uarg);
>  	default:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D15
