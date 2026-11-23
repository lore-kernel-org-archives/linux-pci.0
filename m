Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402715;
	b=N9op+mBcX+p6kWXVCtUGzVz3o7PQCCarWnn5Vkhmy+AbVRxW9EPRdOkc/OsyoJxAj/ZI
	 H6OHoC0vbVTOUZ5VMlUCGjb/7Dnc6TeLwQkP74qGkIIV2LxWgMfGYytzw5VxIpLB1koai
	 p3fV9K7p+6/XGeSTgWeFD1RhM+ZBcHIjsaBYBLkm8m1Opm3IaryqFZQc18U0RvR0j4XZ/
	 AttTE/lA675eZX4b4P/Fq03hTkpz2OAeSyXvjAnlMA0v07WCvTDkV4bJdjlXkANzljWRU
	 ao9DsWjqY3T9O4rnQjaoU91Pe9WBaQ4FjlY+3+Wurc/a+tJ/bgn0dxz3dbbK+jrx0+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402715;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=szCxED7tT/qWKtYqtJBYo+KP1S1fLxObYojqIzS8jBw=;
	b=TZdcVaRiOzJFKp4o1spT3QG4TTr7ZKqwX7cvDDbeC1M65kVECriAS6g9pkYgzXEi1ANm
	 jp7fCHfmTuuJ3KsT2eGe3LFm+xRYMK+jUnSYOghigdUAQrHJSuyLGkix3HEAoMxvNN7nc
	 ZKvsf+6XjNh9E8OU22o+N+lZ8UixgrLYervEZbMTJINAQXBAwLf3BQWyOhbv0CzE0oFYf
	 ATeGSJA0Gapn/7qb+x4lppGuer8jE6X/NSn5PiLXbIbj88v+VzPmAcJakOgT2eDGRv8oi
	 lvdzzh0yHMUQmMPwui1PkRgRN3BhzQdqRfUsJThrV12YdDf29Tt7D5jcORMhoSCstBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBjsuDDX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F661606A31A;
	Mon, 23 Nov 2026 02:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBjsuDDX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2B61F000C0;
	Mon, 23 Nov 2026 02:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795402714;
	bh=szCxED7tT/qWKtYqtJBYo+KP1S1fLxObYojqIzS8jBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lBjsuDDXmLtphgcSFpJZ89D4nfo8A57gt8fsl/3SiPBpO4MoHvQVCAtmP4r/uGDlm
	 /F01FYE4eN+Ka+sha+Wt/pY+P/OR3lT2Ry+VB+ycf2V/fsSRrkRKWtWT4IjpCaQ5ih
	 rKDAGVRUDSRMB6m16mVu5ycE3AD13UwhoypP4BRkfXjkd3EdHLeY/lAusUjwPYnuyQ
	 GKd0cMaGXzQAO9hPYLpstLkSofEtd/oDU/3ItlGclgYpFWPbt7ID8RHQ92jIDKPj86
	 g5cVNnHI9hBYw0lGYUMrbfmwEfdlQ7SbqsOkuohgafUAw8EsKkNe94ZzittXaMlljc
	 038sA5Oa+opZQ==
Message-ID: <sashiko-outbox-228576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 11/13] vfio/pci: Add IV-ST TPH policy and
 TPH_PROGRAM batch programming support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261123023628.7728-12-fengchengwen@huawei.com>
References: <20261123023628.7728-1-fengchengwen@huawei.com>
 <20261123023628.7728-12-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 02:58:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] vfio/pci: OOB read in vfio_pci_tph_resolve_st_tag() on
  cpu_online()
- [Medium] vfio/pci: ST table desync across TPH enable/mode and MSI-X
  transitions
- [Medium] vfio/pci: ST table and config accesses while device is
  suspended or in D3
- [Low] vfio/pci: unconditional memory_lock and per-entry ST writes on
  CPU offline
--

commit e8463ab09aa5bab8dbaf6df575e6c544d6e783aa
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add IV-ST TPH policy and TPH_PROGRAM batch programming support

This commit adds the VFIO_PCI_TPH_POLICY_IV_ST policy, introduces the
VFIO_DEVICE_FEATURE_TPH_PROGRAM ioctl to batch program architected
steering tag entries, and registers a CPU hotplug offline callback to
clear entries bound to offlined CPUs.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index be7d1921f5f31..83b81d1a61227 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1603,12 +1613,135 @@ static int vfio_pci_core_feature_token(struct vf=
io_pci_core_device *vdev,
>  	return 0;
>  }
> =20
> -static u32 vfio_pci_tph_get_capability(struct vfio_pci_core_device *vdev)
> +static enum cpuhp_state vfio_tph_cpuhp_state;
> +
> +static int vfio_pci_tph_cpuhp_offline(unsigned int cpu, struct hlist_nod=
e *node)
>  {
> -	/* NO-ST only, no capability bits exposed now */
> +	struct vfio_pci_core_device *vdev =3D
> +		hlist_entry(node, struct vfio_pci_core_device, tph_cpuhp_node);
> +	u16 cmd;
> +	int i;
> +
> +	if (vdev->tph_st_cpu =3D=3D NULL)
> +		return 0;
> +
> +	mutex_lock(&vdev->tph_lock);
> +	cmd =3D vfio_pci_memory_lock_and_enable(vdev);
> +	for (i =3D 0; i < vdev->tph_st_size; i++) {
> +		if (vdev->tph_st_cpu[i] !=3D (s64)cpu)
> +			continue;
> +		pcie_tph_set_st_entry(vdev->pdev, i, 0);
> +		vdev->tph_st_cpu[i] =3D (s64)-1;
> +	}
> +	vfio_pci_memory_unlock_and_restore(vdev, cmd);
> +	mutex_unlock(&vdev->tph_lock);
> +
>  	return 0;
>  }

[Severity: Medium]
Can vfio_pci_tph_cpuhp_offline() and vfio_pci_core_feature_tph_program()
access config space and the MSI-X table BAR while the device is runtime
suspended or in PCI_D3hot?

Unlike VFIO file operations, vfio_pci_tph_cpuhp_offline() runs from a CPU
hotplug thread without calling pm_runtime_resume_and_get().  In both this
callback and vfio_pci_core_feature_tph_program(),
vfio_pci_memory_lock_and_enable() sets PCI_COMMAND_MEMORY without checking
or transitioning pdev->current_state out of guest-initiated PCI_D3hot, so
pcie_tph_set_st_entries() -> pci_msix_write_tph_tag() can issue MMIO
accesses to the MSI-X BAR while the device is in D3hot or D3cold.

Also, on devices with vdev->needs_pm_restore set,
vfio_pci_set_power_state() saves config space into vdev->pm_save on D3hot
entry and restores it via pci_restore_state() -> pci_restore_tph_state()
on return to PCI_D0, which overwrites any ST entries cleared on CPU
offline while in D3hot.

[Severity: Low]
Does vfio_pci_tph_cpuhp_offline() need to acquire vdev->memory_lock and
read/write PCI_COMMAND when no ST entry is bound to the offlined CPU?

Because vfio_pci_tph_dev_init() registers every open device with an
architected ST table, every CPU offline event takes vdev->memory_lock in
write mode and touches PCI_COMMAND even when no entries match cpu, and
calling pcie_tph_set_st_entry() per entry repeatedly toggles PCI_TPH_CTRL
and re-reads PCI_TPH_CAP for each matching entry.

[ ... ]

> @@ -1644,6 +1777,144 @@ static int vfio_pci_core_feature_tph(struct vfio_=
pci_core_device *vdev,
>  	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
>  }
> =20
> +static u32 vfio_pci_tph_get_src_mask(struct vfio_pci_core_device *vdev)
> +{
> +	u32 flags =3D vfio_pci_tph_get_capability(vdev);
> +	u32 src_mask =3D 0;
> +
> +	if (flags & VFIO_DEVICE_TPH_CAP_PROG_ST_NONE)
> +		src_mask |=3D VFIO_DEVICE_TPH_SRC_NONE;
> +	if (flags & VFIO_DEVICE_TPH_CAP_PROG_ST_CPU)
> +		src_mask |=3D VFIO_DEVICE_TPH_SRC_CPU_VOLATILE |
> +			    VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT;
> +
> +	return src_mask;
> +}
> +
> +static int vfio_pci_tph_resolve_st_tag(struct pci_dev *pdev, u32 src_bit=
s,
> +				       u32 src_handle, bool extended, u16 *st)
> +{
> +	u8 req_type =3D extended ? PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
> +	u32 cpu_srcs =3D VFIO_DEVICE_TPH_SRC_CPU_VOLATILE |
> +		       VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT;
> +	int ret =3D 0;
> +
> +	if ((src_bits & cpu_srcs) && !cpu_online(src_handle)) {
> +		*st =3D 0;
> +		return -EINVAL;
> +	}

[Severity: High]
Can a user-supplied src_handle >=3D nr_cpu_ids trigger an out-of-bounds read
in cpu_online(src_handle)?

vfio_pci_core_feature_tph_program() copies arbitrary u32 values from
program.srcs into src_handle[] and passes them here without bounds
checking.  On SMP kernels, cpu_online() calls cpumask_test_cpu(), which
expects cpu < nr_cpu_ids and performs an unchecked test_bit() read relative
to __cpu_online_mask.  Checking src_handle >=3D nr_cpu_ids before calling
cpu_online() avoids the out-of-bounds access.

> +
> +	if (src_bits & VFIO_DEVICE_TPH_SRC_NONE)
> +		*st =3D 0;
> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE)
> +		ret =3D pcie_tph_get_cpu_st_ext(pdev, TPH_MEM_TYPE_VM,
> +					      req_type, src_handle, st);
> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT)
> +		ret =3D pcie_tph_get_cpu_st_ext(pdev, TPH_MEM_TYPE_PM,
> +					      req_type, src_handle, st);
> +	else
> +		ret =3D -EINVAL;
> +
> +	if (ret !=3D 0)
> +		*st =3D 0;
> +
> +	return ret;
> +}
[ ... ]
> +	if (i > 0) {
> +		mutex_lock(&vdev->tph_lock);
> +
> +		cmd =3D vfio_pci_memory_lock_and_enable(vdev);
> +		ret =3D written =3D pcie_tph_set_st_entries(pdev, program.start, i,
> +							tags);
> +		vfio_pci_memory_unlock_and_restore(vdev, cmd);
> +
> +		if (written > 0) {
> +			for (k =3D 0; k < written; k++)
> +				vdev->tph_st_cpu[program.start + k] =3D
> +					(tags[k] =3D=3D 0) ?
> +					(s64)-1 : (s64)src_handle[k];
> +		}
> +
> +		mutex_unlock(&vdev->tph_lock);
> +	}

[Severity: Medium]
Can vdev->tph_st_cpu[] become desynchronized from the hardware ST table
across PCI_TPH_CTRL mode/enable and MSI-X transitions?

In drivers/pci/tph.c, pcie_tph_set_st_entries() returns -EINVAL when
!pdev->tph_enabled and returns count without writing to hardware when
pdev->tph_mode =3D=3D PCI_TPH_ST_NS_MODE (and pci_msix_write_tph_tag() retu=
rns
-ENXIO when !pdev->msix_enabled):

drivers/pci/tph.c:pcie_tph_set_st_entries() {
    ...
	if (!pdev->tph_enabled)
		return -EINVAL;

	if (!count)
		return -EINVAL;

	/* No need to write tag if device is in "No ST Mode" */
	if (pdev->tph_mode =3D=3D PCI_TPH_ST_NS_MODE)
		return count;
    ...
}

If userspace invokes VFIO_DEVICE_FEATURE_TPH_PROGRAM while TPH is enabled
in PCI_TPH_ST_NS_MODE, pcie_tph_set_st_entries() skips the hardware writes
and returns i, so vdev->tph_st_cpu[] and the return value report that the
entries were programmed even though the hardware ST table was not updated.

Conversely, if a bound CPU goes offline while userspace has temporarily
disabled TPH, switched to PCI_TPH_ST_NS_MODE, or disabled MSI-X,
pcie_tph_set_st_entry(vdev->pdev, i, 0) in vfio_pci_tph_cpuhp_offline()
does not clear the hardware entry, yet vdev->tph_st_cpu[i] is reset to -1,
leaving the offlined CPU's stale Steering Tag in hardware when IV-ST mode
or MSI-X is later re-enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123023628.7728=
-1-fengchengwen@huawei.com?part=3D11
