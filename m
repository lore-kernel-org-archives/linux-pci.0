Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432B231A41
	for <linux-pci@vger.kernel.org>; Sat, 16 May 2026 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778971533; cv=none; b=qW4FnJAtZe3rLEw+n6KYBMfBfW8EvDs9aSM87cBkx30E92b7MWBJY7oNKzFN3OZf9VZyFB2m3hCon1lsQTDKJleXRyTEppOp5paaR9pIWjpMCMAnXkeD+9Mr3QGoLWdpr3G6lWoi7PwrAUgwnu2aGgZzkbaDHFC+m+hOSSq+5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778971533; c=relaxed/simple;
	bh=LWofDWmabqBWKvANCp7+ewB1AtkAmEcn15TcANT31BY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GmQDn5xYLbMij86wsouZ0IhAw/0mQtBcmCvcgpWEQL55qK79F9wVF1w16OUDpqKnS48qe4CHcENp6nA7Dmawxd4ijcdEzIH3M9i45m/2F5M+jY98vAFO2zw/QkE13D/8yLkAZPWaZmGnH4yg3waVzXBfkRuIWhMu+KHmrNXuzDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYNlWt6D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYNlWt6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB33C2BCB7;
	Sat, 16 May 2026 22:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778971533;
	bh=LWofDWmabqBWKvANCp7+ewB1AtkAmEcn15TcANT31BY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eYNlWt6DkNg9lean92Elp9mCm9ZLpQzfGqStY6I5rqpR9cbFXBNjSFQvuE8mZxavy
	 Up7PJ+QSgtGdQRpP+g0gmiPfMhkzVtb8g9Bidhoq8N+yqiodmz0wTRzc579kDbyBO7
	 Cdxf1+0MwG4VF0100lHgf+zjZpwdfuRMqJMlbuCMRO350VP9a7lF8HoSIHGIgshXrb
	 HW19jF3rbhnk4hOuXBurMFIlVBprtRvMgA12OK4ccHEXIh0NO/gY5e8Cg4ms5ffsg9
	 WNNRDmeMan1dCLArVONGx27X9oGjZnOCCgBCFSKYIwfSPJgoVixIoaobXH5GeQmky7
	 ubam9jiBjRBUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 02/14] libie: add PCI device initialization
 helpers to libie
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tony Nguyen" <anthony.l.nguyen@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515224443.2772147-3-anthony.l.nguyen@intel.com>
References: <20260515224443.2772147-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 22:45:32 +0000
Message-Id: <20260516224532.DDB33C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Integer overflow in MMIO region bounds check allows out-of-bounds =
physical memory mapping.
- [High] Use of unmanaged `ioremap()` in PCI API forces manual cleanup, lea=
ding to Use-After-Unmap crashes in driver teardown.
- [Medium] Missing bounds check for MMIO access size in `__libie_pci_get_mm=
io_addr` allows out-of-bounds memory accesses.
- [Low] Missing `depends on PCI` in `CONFIG_LIBIE_PCI` causes build failure=
s.
--

commit 20e33f0ecbedce390794d8ede7c6cdd2f15cacf9
Author: Phani R Burra <phani.r.burra@intel.com>
Subject: libie: add PCI device initialization helpers to libie

This commit introduces a new PCI library under libie to help network
drivers map and manage non-linear MMIO regions and perform standard
PCI initialization.

> diff --git a/drivers/net/ethernet/intel/libie/Kconfig b/drivers/net/ether=
net/intel/libie/Kconfig
> index 70831c7e336e9..500a95c944a8c 100644
> --- a/drivers/net/ethernet/intel/libie/Kconfig
> +++ b/drivers/net/ethernet/intel/libie/Kconfig
> @@ -23,3 +23,9 @@ config LIBIE_FWLOG
>  	  for it. Firmware logging is using admin queue interface to communicate
>  	  with the device. Debugfs is a user interface used to config logging
>  	  and dump all collected logs.
> +
> +config LIBIE_PCI
> +	tristate
> +	help
> +	  Helper functions for management of PCI resources belonging
> +	  to networking devices.

Will this build successfully if CONFIG_PCI is disabled and a user manually
enables CONFIG_LIBIE_PCI=3Dy?

While some PCI core APIs have stubs for when PCI is disabled,
pcim_request_region does not appear to be stubbed in include/linux/pci.h.

Should this config depend on PCI to prevent linker errors?

> diff --git a/drivers/net/ethernet/intel/libie/pci.c b/drivers/net/etherne=
t/intel/libie/pci.c
> new file mode 100644
> index 0000000000000..7276a3533b54d
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/libie/pci.c
> @@ -0,0 +1,208 @@

[ ... ]

> +void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_inf=
o,
> +					resource_size_t offset,
> +					int num_args, ...)
> +{
> +	struct libie_pci_mmio_region *mr;
> +	int bar_idx =3D 0;
> +	va_list args;
> +
> +	if (num_args) {
> +		va_start(args, num_args);
> +		bar_idx =3D va_arg(args, int);
> +		va_end(args);
> +	}
> +
> +	list_for_each_entry(mr, &mmio_info->mmio_list, list)
> +		if (bar_idx =3D=3D mr->bar_idx && offset >=3D mr->offset &&
> +		    offset < mr->offset + mr->size) {

Does this verification prevent partial out-of-bounds accesses?

If a caller requests an offset at the very end of the region, such as
mr->offset + mr->size - 1, the check passes. If the driver then performs a
32-bit or 64-bit MMIO read, it would read past the mapped boundary.

Should the function take an expected access size parameter to verify the
entire access falls within the region?

> +			offset -=3D mr->offset;
> +
> +			return mr->addr + offset;
> +		}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(__libie_pci_get_mmio_addr, "LIBIE_PCI");
> +
> +bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
> +				 resource_size_t offset,
> +				 resource_size_t size, int num_args, ...)
> +{
> +	struct pci_dev *pdev =3D mmio_info->pdev;
> +	struct libie_pci_mmio_region *mr;
> +	resource_size_t pa;
> +	void __iomem *va;
> +	int bar_idx =3D 0;
> +	va_list args;
> +
> +	if (num_args) {
> +		va_start(args, num_args);
> +		bar_idx =3D va_arg(args, int);
> +		va_end(args);
> +	}
> +
> +	if (offset + size > pci_resource_len(pdev, bar_idx))
> +		return false;

Could this addition overflow if a compromised firmware or control plane
provides very large values for offset and size?

If offset + size wraps around, the result could evaluate to a small value,
bypassing the length check. This might allow mapping arbitrary physical
memory via ioremap.

Would it be safer to check this as:
if (size > pci_resource_len(...) || offset > pci_resource_len(...) - size)

> +
> +	mr =3D libie_find_mmio_region(&mmio_info->mmio_list, offset, size,
> +				    bar_idx);
> +	if (mr) {
> +		pci_warn(pdev,
> +			 "Mapping of BAR%u (offset=3D%llu, size=3D%llu) intersecting region (=
offset=3D%llu, size=3D%llu) already exists\n",
> +			 bar_idx, (unsigned long long)mr->offset,
> +			 (unsigned long long)mr->size,
> +			 (unsigned long long)offset, (unsigned long long)size);
> +		return mr->offset <=3D offset &&
> +		       mr->offset + mr->size >=3D offset + size;
> +	}
> +
> +	pa =3D pci_resource_start(pdev, bar_idx) + offset;
> +	va =3D ioremap(pa, size);
> +	if (!va) {
> +		pci_err(pdev, "Failed to map BAR%u region\n", bar_idx);
> +		return false;
> +	}
> +
> +	mr =3D kvzalloc_obj(*mr);

Since the initial device setup in libie_pci_init_dev uses managed resources
like pcim_request_region, is there a reason this mapping relies on manual
ioremap and kvzalloc_obj?

Forcing drivers to manually unmap these regions during teardown can lead to
crashes if the driver unmaps the registers before the network device is ful=
ly
unregistered, as concurrent network traffic or NAPI polling might write to
the unmapped virtual addresses.

Could this use devm_ioremap and devm_kvzalloc to tie the mapping lifecycle
safely to the device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515224443.2772=
147-1-anthony.l.nguyen@intel.com?part=3D2
