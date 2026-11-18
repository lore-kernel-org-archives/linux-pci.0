Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000906;
	b=K12fSPmJrHObJS5TY/AJDJVcyvSHH41rlM8igBfFdVH/JBlXTmr8k/oYzl1SDA4F+hoq
	 l8utQMj4etOueY+yQVzX1M1EUxM6Yh5m14eJI5Fn9j6/MPdTr4q0NGGdHIn3KcuSvvJtJ
	 jtfeLgXW+wyxXtmeaVeqENkUCu6ISiaUpjKGLomsfQSy8Lgyp8TuByiBatpBziax0pzek
	 7ABKap+52ivbXTUCLiTYD5yHR5PYFreVyy5gEc3pDNmEmB2iKgeHh5xIGo+yeTj9HQZTz
	 e2RNXnkeZVNS5jronagWIiJFU3NeHqm7US0B1+8aRF+x0EQtJfPYBmz7nD4Z+1lqhmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000906;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B0NGvl4heywNe/2Uy1bIJsWF2DgbUHuiaFXjjkwUzFY=;
	b=YLOe49C8q9PHbyl7OujbkD1j9zWMHp/THaahczeWFry85psI0tQVMXRr6x5z96h9SW3u
	 kiBy0AfVPrf7RJ0jgFAy+Gc4xabS+fAEKA/PXjY+KrDvehvqrweC/9hJdFj+fqV6g4pDD
	 yVCGm3uXYYyAh4eyCsLwM9JrqZ1DDruncToK2k06FodFBFByKyj1Ypy+tnXJiPwy4UFbC
	 GHPXWZWzBruTEoecvwy6A/ZA2kxzQ5m7dufSHCnq8UMGljW444hCwVFLd35odG7uh5V15
	 C8Cedb3cjnLOvEpoMQy+WE6MVohQUb1qibz1OlnW+WZXWYoLgQFNVOpuCZBQh5Xu4dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFG0OK4M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033EF606A31C;
	Wed, 18 Nov 2026 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFG0OK4M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D091F000C4;
	Wed, 18 Nov 2026 11:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795000905;
	bh=B0NGvl4heywNe/2Uy1bIJsWF2DgbUHuiaFXjjkwUzFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hFG0OK4MzzO+f4QhGm1wSalLvyazJ6163iIxT/UTbqUkfXYQQ3u1SXwv6rItMZhh4
	 ZWCu6dMS8I8uCgRlzfCz/eSkDv8z01r+GtUy9M5Y9Qjwb3Q+FS7n8+vHEn/p2Mnd1b
	 5WlLldIf7pnX307ixHgQ8eegjLfrTiY5Y+ZdUvQygyv1Lb2Yy5oV157twb3lty64oW
	 GWwVZV+Bsnvm+XWYs3SrFkIGd5Gpqa5Wn+WumMrYqLkva5E7xB61xApbtqUf16IBVx
	 Hzv+ygoNTg0Naf/Hxd89cL4zvM2lqv5XsHvaJH5/du7KQhFg57BwaEIbQYivKRgDOa
	 kG2t9RvvnPnUA==
Message-ID: <sashiko-outbox-220818@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 10/13] vfio/pci: Add IV-ST TPH policy and
 TPH_PROGRAM batch programming support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-11-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-11-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 11:21:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [High] vfio/pci: UAF and leak in vfio_pci_tph_dev_deinit() on PCI
  disconnect
- [High] vfio/pci: vfio_tph_config_write() drops ST mode and active req
  updates
- [Medium] vfio/pci: UAF and NULL deref freeing tph_st_cpu before cpuhp
  removal
- [Medium] vfio/pci: OOB access on tph_st_cpu from uncached ST table
  size reads
- [Medium] vfio/pci: missing memory_lock and enable in
  vfio_pci_tph_cpuhp_offline()
- [Medium] vfio/pci: missing cpu_online() check in
  vfio_pci_tph_resolve_st_tag()
- [Medium] vfio/pci: vfio_pci_tph_get_capability() skips
  pcie_tph_dsm_supported()
- [Low] vfio/pci: race in vfio_pci_tph_dev_init() adding cpuhp node
  before init
- [Low] vfio/pci: unsigned promotion of -1 when setting tph_st_cpu in
  program
--

commit a348f43d0aba3da4e82aeff21aba4bc617cdcd33
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add IV-ST TPH policy and TPH_PROGRAM batch programming support

This commit adds the IV-ST TPH policy to vfio-pci, introduces the
VFIO_DEVICE_FEATURE_TPH_PROGRAM ioctl for batch programming architected
steering tag entries, and registers a CPU hotplug offline callback to clear
steering tags mapped to offlined CPUs.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index 3946ed2ec0cfe..398f8db8b8ff0 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
[ ... ]
> @@ -1210,7 +1218,7 @@ static int vfio_tph_config_write(struct vfio_pci_co=
re_device *vdev, int pos,
>  	cap =3D vdev->tph_vcap;
>  	mode =3D FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
>  	req =3D FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
> -	if (mode !=3D PCI_TPH_ST_NS_MODE || !(cap & (1u << mode)) ||
> +	if (mode > PCI_TPH_ST_IV_MODE || !(cap & (1u << mode)) ||
>  		req =3D=3D 0x2 /* reserved */ ||
>  		(req =3D=3D PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
>  		goto out; /* Drop invalid or unsupported write value. */

[Severity: High]
Does vfio_tph_config_write() drop ST mode updates and active requester-type
changes now that PCI_TPH_ST_IV_MODE is allowed?

Immediately below this check, vfio_tph_config_write() still has:

drivers/vfio/pci/vfio_pci_config.c:vfio_tph_config_write() {
	...
	org_req =3D FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
	if (req =3D=3D org_req)
		goto out; /* Only care about requester enable. */

	if (req =3D=3D PCI_TPH_REQ_TPH_ONLY || req =3D=3D PCI_TPH_REQ_EXT_TPH)
		pcie_enable_tph_ext(pdev, mode, req);
	else if (req =3D=3D PCI_TPH_REQ_DISABLE)
		pcie_disable_tph(vdev->pdev);
	...
}

Because writes where req =3D=3D org_req exit at goto out without updating
hardware:

1. Switching mode between PCI_TPH_ST_NS_MODE and PCI_TPH_ST_IV_MODE while
   TPH is already enabled is ignored.  Hardware and pdev->tph_mode stay on
   the old mode, and if pdev->tph_mode remains PCI_TPH_ST_NS_MODE,
   pcie_tph_set_st_entries() silently skips writing ST entries during
   VFIO_DEVICE_FEATURE_TPH_PROGRAM.
2. Writing PCI_TPH_ST_IV_MODE while req is PCI_TPH_REQ_DISABLE and enabling
   req in a second write loses the mode selection, because the next
   vfio_tph_config_write() syncs vconfig[start + PCI_TPH_CTRL] back from the
   hardware register before applying the second write.
3. Changing req between PCI_TPH_REQ_TPH_ONLY and PCI_TPH_REQ_EXT_TPH (or
   re-enabling TPH after a function reset cleared the hardware register)
   calls pcie_enable_tph_ext() while pdev->tph_enabled is still set, which
   fails with -EBUSY unless pcie_disable_tph() is called first.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 05a03aa2bceb0..23ed8ea396575 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1597,12 +1608,116 @@ static int vfio_pci_core_feature_token(struct vf=
io_pci_core_device *vdev,
>  	return 0;
>  }
> =20
> -static u32 vfio_pci_tph_get_capability(struct vfio_pci_core_device *vdev)
> +static enum cpuhp_state vfio_tph_cpuhp_state;
> +static u32 vfio_pci_tph_get_st_table_size(struct vfio_pci_core_device *v=
dev);
> +
> +static int vfio_pci_tph_cpuhp_offline(unsigned int cpu, struct hlist_nod=
e *node)
> +{
> +	struct vfio_pci_core_device *vdev =3D
> +		hlist_entry(node, struct vfio_pci_core_device, tph_cpuhp_node);
> +	u32 st_size =3D vfio_pci_tph_get_st_table_size(vdev);
> +	int i;
> +
> +	if (vdev->tph_st_cpu =3D=3D NULL)
> +		return 0;
> +
> +	mutex_lock(&vdev->tph_lock);
> +	for (i =3D 0; i < st_size; i++) {
> +		if (vdev->tph_st_cpu[i] !=3D (s64)cpu)
> +			continue;
> +		pcie_tph_set_st_entry(vdev->pdev, i, 0);
> +		vdev->tph_st_cpu[i] =3D -1;
> +	}
> +	mutex_unlock(&vdev->tph_lock);
> +
> +	return 0;
> +}

[Severity: Medium]
Should vfio_pci_tph_cpuhp_offline() wrap pcie_tph_set_st_entry() in
vfio_pci_memory_lock_and_enable() and vfio_pci_memory_unlock_and_restore()
as vfio_pci_core_feature_tph_program() does?

When the ST table is located in the MSI-X table (PCI_TPH_LOC_MSIX),
pcie_tph_set_st_entry() performs MMIO writes and reads on the MSI-X BAR,
which will fail or trigger AER errors if userspace has cleared
PCI_COMMAND_MEMORY or if the device is in a low-power state or resetting.

In addition, pcie_tph_set_st_entry() temporarily clears
PCI_TPH_CTRL_REQ_EN_MASK in PCI_TPH_CTRL and restores pdev->tph_req_type
under vdev->tph_lock, whereas vfio_tph_config_write() modifies PCI_TPH_CTRL
and pdev->tph_req_type under vdev->memory_lock without taking
vdev->tph_lock, so the two paths can race on PCI_TPH_CTRL.

[ ... ]

> +static int vfio_pci_tph_dev_init(struct vfio_pci_core_device *vdev)
>  {
> -	/* NO-ST only, no capability bits exposed now */
> +	bool has_arch_st;
> +	u32 st_size;
> +	int i, ret;
> +
> +	vdev->tph_opt_in =3D 0;
> +	vdev->tph_st_cpu =3D NULL;
> +
> +	has_arch_st =3D vfio_pci_tph_has_architected_st(vdev);
> +	if (!has_arch_st)
> +		return 0;
> +
> +	ret =3D cpuhp_state_add_instance_nocalls(vfio_tph_cpuhp_state,
> +					       &vdev->tph_cpuhp_node);
> +	if (ret !=3D 0)
> +		return ret;
> +
> +	st_size =3D vfio_pci_tph_get_st_table_size(vdev);
> +	vdev->tph_st_cpu =3D kcalloc(st_size, sizeof(*vdev->tph_st_cpu),
> +				   GFP_KERNEL);
> +	if (vdev->tph_st_cpu =3D=3D NULL) {
> +		cpuhp_state_remove_instance_nocalls(vfio_tph_cpuhp_state,
> +						    &vdev->tph_cpuhp_node);
> +		return -ENOMEM;
> +	}
> +	for (i =3D 0; i < st_size; i++)
> +		vdev->tph_st_cpu[i] =3D -1;
> +
>  	return 0;
>  }

[Severity: Low]
Can vfio_pci_tph_cpuhp_offline() observe a zero-filled vdev->tph_st_cpu
array before the initialization loop sets entries to -1?

CPU0                                    CPU1
vfio_pci_tph_dev_init()
  cpuhp_state_add_instance_nocalls(...)
  vdev->tph_st_cpu =3D kcalloc(...)
                                        vfio_pci_tph_cpuhp_offline(0, ...)
                                          if (vdev->tph_st_cpu =3D=3D NULL)
                                          mutex_lock(&vdev->tph_lock)
                                          vdev->tph_st_cpu[i] =3D=3D 0
                                          pcie_tph_set_st_entry(...)
  for (i =3D 0; i < st_size; i++)
    vdev->tph_st_cpu[i] =3D -1;

Because 0 is CPU 0's ID rather than the unmapped sentinel (-1), offlining
CPU 0 in this window races on vdev->tph_st_cpu and treats every
uninitialized entry as mapped to CPU 0.  Allocating and initializing
vdev->tph_st_cpu before cpuhp_state_add_instance_nocalls() avoids this.

> +static void vfio_pci_tph_dev_deinit(struct vfio_pci_core_device *vdev)
> +{
> +	bool has_arch_st;
> +
> +	has_arch_st =3D vfio_pci_tph_has_architected_st(vdev);
> +	if (!has_arch_st)
> +		return;
> +
> +	kfree(vdev->tph_st_cpu);
> +	vdev->tph_st_cpu =3D NULL;
> +	cpuhp_state_remove_instance_nocalls(vfio_tph_cpuhp_state,
> +					    &vdev->tph_cpuhp_node);
> +}

[Severity: High]
Does vfio_pci_tph_dev_deinit() leak vdev->tph_st_cpu and leave
vdev->tph_cpuhp_node registered if the PCI device is hot-unplugged or its
link is down when closed?

vfio_pci_tph_has_architected_st() calls vfio_pci_tph_get_st_table_size() ->
pcie_tph_get_st_table_loc(), which reads PCI_TPH_CAP from hardware config
space.  If the device is disconnected, the config read returns 0xffffffff,
so reg & PCI_TPH_CAP_LOC_MASK is 0x600 (neither PCI_TPH_LOC_CAP nor
PCI_TPH_LOC_MSIX) and vfio_pci_tph_has_architected_st() returns false.
vfio_pci_tph_dev_deinit() then returns early, leaking vdev->tph_st_cpu and
leaving vdev->tph_cpuhp_node on the global cpuhp list after vdev is freed,
which causes a use-after-free on the next CPU offline event or module
unload.  Checking if (!vdev->tph_st_cpu) instead of re-querying hardware
avoids this.

[Severity: Medium]
Even when the device is present, can freeing vdev->tph_st_cpu before
cpuhp_state_remove_instance_nocalls() cause a use-after-free or NULL
pointer dereference in vfio_pci_tph_cpuhp_offline()?

CPU0                                    CPU1
                                        vfio_pci_tph_cpuhp_offline()
                                          if (vdev->tph_st_cpu =3D=3D NULL)
vfio_pci_tph_dev_deinit()
  kfree(vdev->tph_st_cpu)
  vdev->tph_st_cpu =3D NULL
                                          mutex_lock(&vdev->tph_lock)
                                          vdev->tph_st_cpu[i]  <-- UAF / NU=
LL
  cpuhp_state_remove_instance_nocalls()

cpuhp_state_remove_instance_nocalls() is what synchronizes against running
hotplug callbacks, so it needs to run before freeing vdev->tph_st_cpu.

> +static u32 vfio_pci_tph_get_capability(struct vfio_pci_core_device *vdev)
> +{
> +	bool has_arch_st;
> +
> +	has_arch_st =3D vfio_pci_tph_has_architected_st(vdev);
> +	if (!has_arch_st)
> +		return 0;
> +
> +	return VFIO_DEVICE_TPH_CAP_PROG_ST_NONE | VFIO_DEVICE_TPH_CAP_PROG_ST_C=
PU;
> +}

[Severity: Medium]
Should vfio_pci_tph_get_capability() check pcie_tph_dsm_supported(vdev->pde=
v)
before advertising VFIO_DEVICE_TPH_CAP_PROG_ST_CPU?

Commit "PCI/TPH: Add pci_tph_dsm_supported() helper to detect device TPH ST
_DSM" earlier in this series added pcie_tph_dsm_supported() for VFIO, but
nothing calls it.  Without that check, VFIO_DEVICE_FEATURE_TPH GET reports
VFIO_DEVICE_TPH_CAP_PROG_ST_CPU even when CONFIG_ACPI is disabled, the
device is a Root Complex Integrated Endpoint, or the Root Port lacks the
TPH ST _DSM, and subsequent VFIO_DEVICE_FEATURE_TPH_PROGRAM calls with CPU
sources will all fail in pcie_tph_get_cpu_st_ext().

>  static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
>  				     u32 flags,
>  				     struct vfio_device_feature_tph __user *arg,
> @@ -1638,6 +1753,154 @@ static int vfio_pci_core_feature_tph(struct vfio_=
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
> +static u32 vfio_pci_tph_get_st_table_size(struct vfio_pci_core_device *v=
dev)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	u32 loc =3D pcie_tph_get_st_table_loc(pdev);
> +	int ret;
> +
> +	if (loc =3D=3D PCI_TPH_LOC_CAP) {
> +		return pcie_tph_get_st_table_size(pdev);
> +	} else if (loc =3D=3D PCI_TPH_LOC_MSIX) {
> +		ret =3D pci_msix_vec_count(pdev);
> +		if (ret < 0)
> +			return 0;
> +		return ret;
> +	} else {
> +		return 0;
> +	}
> +}

[Severity: Medium]
Can re-reading the ST table size from hardware in
vfio_pci_tph_get_st_table_size() cause out-of-bounds accesses on
vdev->tph_st_cpu?

vdev->tph_st_cpu is allocated once in vfio_pci_tph_dev_init(), but
vfio_pci_tph_cpuhp_offline() and vfio_pci_core_feature_tph_program() call
vfio_pci_tph_get_st_table_size() again to bound indices into
vdev->tph_st_cpu.  If PCI config space becomes inaccessible after
pcie_tph_get_st_table_loc() succeeds, the second config read inside
pcie_tph_get_st_table_size() or pci_msix_vec_count() reads all-ones and
returns 2048 (0x7ff + 1), which can exceed the allocated size of
vdev->tph_st_cpu and cause out-of-bounds reads and writes.  Caching the
table size on vdev at allocation time would keep the array bounds
consistent.

> +static int vfio_pci_tph_resolve_st_tag(struct pci_dev *pdev, u32 src_bit=
s,
> +				       u32 src_handle, bool extended, u16 *st)
> +{
> +	u8 req_type =3D extended ? PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
> +	int ret =3D 0;
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

[Severity: Medium]
Does vfio_pci_tph_resolve_st_tag() allow programming steering tags for CPUs
that are already offline?

vfio_pci_core_feature_tph_program() holds cpus_read_lock(), but neither it
nor pcie_tph_get_cpu_st_ext() -> acpi_get_cpu_uid() checks
cpu_online(src_handle).  An offline CPU ID still resolves via static ACPI
processor tables and gets programmed into the ST table and recorded in
vdev->tph_st_cpu[], where vfio_pci_tph_cpuhp_offline() will never clear it
(and on LoongArch, passing a possible-but-not-present CPU < nr_cpu_ids
indexes acpi_core_pic[cpu_logical_map(cpu)] at -1).

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
> +					(tags[k] =3D=3D 0) ? -1 : src_handle[k];
> +		}
> +
> +		mutex_unlock(&vdev->tph_lock);
> +	}

[Severity: Low]
Does (tags[k] =3D=3D 0) ? -1 : src_handle[k] store 0xffffffff instead of -1=
 in
vdev->tph_st_cpu?

Because src_handle[k] is a u32 and -1 is an int, the ternary expression has
type u32, so -1 is converted to 0xffffffffU before being widened to s64
(4294967295LL instead of -1LL).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D10
