Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D73A9625
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 23:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715584; cv=none; b=P4aOSLDJ91yS9WYOkZC446KhPH/Dk6gPv75jqGfuiDULNohbI9wZYp5OZcMl36sc7n31ROmfKpBzPM3pgVDXo8fVyqQdSVrmnUxcRFHysry2WMKORm1LObSwKEwtd6Gw8Ln5lDOUTE1MOCtKYpIacW1txrOwCHwS45R+TcqTWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715584; c=relaxed/simple;
	bh=JAd7Fl6gOGz/q4M3f/Nh3DRHf0OPjX6Q7FfJWAegsuw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eb7RnYL98Lle/Mq2vEaBh5NhVZ5vCHVVCKK/mJKZ9TeEJVFl8R5s31as2c6/wugPnk1Kd6f3S7dzWLtdOuLsXV9MFi9E/p9EZZIXgEVrJARvrZLYduvXTdGuisawzoTfkBk+NAREVjHH6DT/7howXTZiFJYrJUqUock2pj2KK9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baPttK4a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baPttK4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896FBC19425;
	Wed, 13 May 2026 23:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778715584;
	bh=JAd7Fl6gOGz/q4M3f/Nh3DRHf0OPjX6Q7FfJWAegsuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=baPttK4aSHaUlbmXktrx6tMJ8mCsPR3LcQNtJamBsQpVETpA1sGEucpvpY0jw6Dms
	 6U/zy2FRwh2PeL7+KBIQQ7d51N9sItVJMDMzBB5orfKWjieJ9E6U8bH+QfBNFvA+L/
	 uWFZRRANIx55Q8Q++Ra7NQigNhr8tHheDsHp6oXAd5SwQAX12lqa0on0+UZRNXI8xU
	 0t5kMYZ68xXoSpfSEcuBklLDMiAUYKSyRUncBbRnn7JiG47D/tMCqbRAL7IwwT57a0
	 syczd/j8LaOdxQ+BvWgx3zQltlj4kRkx0QODWA464S6igHdsrWu4gVQzruC/6o5PCl
	 P288BbJutYtLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pci_crash: capture PCI config space at panic time
Reply-To: sashiko-reviews@lists.linux.dev
To: hangej <hangej@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512162402.1929687-1-hangej@amazon.com>
References: <20260512162402.1929687-1-hangej@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:39:44 +0000
Message-Id: <20260513233944.896FBC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] Deadlock in panic path due to global pci_lock acquisition.
- [High] Hardware error and recursive panic from accessing offline or D3col=
d devices.
- [High] Lockless array teardown and missing memory barriers cause Use-Afte=
r-Free during panic.
- [High] Loss of intra-page offset in the physical pagemap for kmalloc-back=
ed buffers.
- [Medium] Resource leak when all matched devices are hot-removed.
- [Medium] Uninitialized variable used in AER capture check.
- [Medium] Missing locking in sysfs capture parameter setter leads to data =
race.
- [Low] Ignoring strim() return value prevents stripping of leading whitesp=
ace.
- [Low] Commit message incorrectly claims the use of slab_is_available().
--

commit f80de92901e525b2a8355b2b6d9ab3d784f115db
Author: Johannes Hange <hangej@amazon.com>
Subject: pci_crash: capture PCI config space at panic time

This commit introduces CONFIG_PCI_CRASH to capture PCI configuration space
data during a kernel panic. The data is stored in a buffer that can be
extracted from the vmcore for post-mortem analysis.

> diff --git a/Documentation/PCI/pci-crash-capture.rst b/Documentation/PCI/=
pci-crash-capture.rst
> index 0000000000000..35f676c2724b7
> --- /dev/null
> +++ b/Documentation/PCI/pci-crash-capture.rst
[ ... ]
> +- slab_is_available() guard in param setters prevents use-before-init
> +  when parameters are set via kernel command line.

This isn't a bug, but the commit message and documentation mention using
a slab_is_available() guard. It looks like the code actually uses
READ_ONCE(pci_crash_ready). Could this documentation be updated to
match the implementation?

> diff --git a/kernel/pci_crash.c b/kernel/pci_crash.c
> new file mode 100644
> index 0000000000000..8bbc9008fdc85
> --- /dev/null
> +++ b/kernel/pci_crash.c
[ ... ]
> +static int capture_param_set(const char *val, const struct kernel_param =
*kp)
> +{
> +	if (strlen(val) >=3D sizeof(capture))
> +		return -EINVAL;
> +	strscpy(capture, val, sizeof(capture));
> +	strim(capture);

Could concurrent sysfs writes from userspace cause data races here? The
devices_param_set() function protects the string modification with
pci_crash_lock, but it appears to be missing in this setter.

Also, does this code correctly handle leading whitespace? The strim()
function modifies the string in-place to remove trailing whitespace, but it
returns a pointer to the first non-whitespace character to skip leading
whitespace. Since the return value is ignored here and in
devices_param_set(), any leading whitespace would be preserved and might
break the exact token string comparisons later.

[ ... ]
> +static struct pci_crash_pagemap *pci_crash_build_pagemap(void *buf,
> +							 size_t buf_size)
> +{
[ ... ]
> +	for (i =3D 0; i < num_pages; i++) {
> +		struct page *page;
> +		phys_addr_t pa;
> +
> +		if (is_vmalloc_addr(buf + i * PAGE_SIZE))
> +			page =3D vmalloc_to_page(buf + i * PAGE_SIZE);
> +		else
> +			page =3D virt_to_page(buf + i * PAGE_SIZE);
> +
> +		if (!page) {
> +			kfree(pm);
> +			return NULL;
> +		}
> +		pa =3D page_to_phys(page);
> +		pm->addrs[i] =3D cpu_to_le64(pa);

Can this lose the intra-page offset for the buffer? The kvmalloc()
function falls back to kmalloc() for smaller allocations, which are
aligned to slab boundaries rather than page boundaries. The page_to_phys()
macro returns the physical address of the start of the page, so won't the
crash parser read from the page boundary instead of the actual buffer start?

[ ... ]
> +static void pci_crash_read_config_space(struct pci_dev *pdev, u8 *ptr)
> +{
[ ... ]
> +	for (offset =3D 0; offset < pdev->cfg_size; offset +=3D 4) {
> +		if (pci_read_config_dword(pdev, offset, &val)) {

Could this trigger a recursive panic when accessing offline or D3cold devic=
es?
The code iterates over all captured devices and reads their config space
without checking their power state. If a device is in D3cold or otherwise
unreachable, accessing it will cause a PCIe Master Abort.

On some architectures like ARM64, unhandled Master Aborts trigger an SError,
which would cause an immediate hard hang or reset when raised from within
the panic handler.

Also, the commit message claims that pci_read_config_dword() is lockless.
Is this description accurate? Looking at pci_read_config_dword(), the
generic implementation unconditionally calls pci_bus_read_config_dword(),
which acquires the global raw spinlock pci_lock. If the kernel panics
while this lock is held by another CPU, won't the panicking CPU spin
indefinitely attempting to acquire it and deadlock the panic handler?

> +			put_unaligned_le32(0xFFFFFFFF, &cfg_data[offset]);
> +			continue;
> +		}
> +		put_unaligned_le32(val, &cfg_data[offset]);
> +	}
> +}
[ ... ]
> +static void pci_crash_rebuild_snapshot(void)
> +{
[ ... ]
> +	if (count =3D=3D 0) {
> +		pr_info("no PCI devices found\n");
> +		WRITE_ONCE(pci_crash_num_devs, 0);
> +		if (old_devs) {
> +			for (i =3D 0; i < old_num_devs; i++)
> +				pci_dev_put(old_devs[i]);
> +			kvfree(old_devs);
> +			WRITE_ONCE(pci_crash_devs, NULL);
> +		}
> +		kfree(old_pm);
> +		WRITE_ONCE(pci_crash_pagemap, NULL);
> +		WRITE_ONCE(pci_crash_pagemap_phys, 0);

Could this result in a use-after-free during a panic?

On weakly ordered architectures, the CPU store buffer might delay making
pci_crash_num_devs =3D 0 visible globally while kvfree(old_devs) or
kfree(old_pm) modify allocator metadata in memory.

If an NMI stops this CPU at this exact point, could the panicking CPU
observe a non-zero device count and traverse the freed old_devs array or
export a freed physical address from old_pm? Should there be an smp_wmb()
after writing 0 to pci_crash_num_devs?

> +		old_buf =3D pci_crash_buffer;
> +		WRITE_ONCE(pci_crash_buffer, NULL);
> +		WRITE_ONCE(pci_crash_buffer_size, 0);
> +		kvfree(old_buf);
> +		return;
> +	}
[ ... ]
> +	if (count =3D=3D 0) {
> +		kvfree(new_devs);
> +		pr_info("no devices match devices=3D%s\n", devices);
> +		goto err_restore;
> +	}
[ ... ]
> +err_restore:
> +	WRITE_ONCE(pci_crash_num_devs, old_num_devs);
> +}

Does this code leak the struct pci_dev references for the removed devices?
When jumping to err_restore, it restores pci_crash_num_devs to old_num_devs
but doesn't appear to drop the references on the old_devs array, pinning
their memory indefinitely.

[ ... ]
> +void pci_crash_save(void)
> +{
[ ... ]
> +	if (!(cflags & PCI_CRASH_CAPTURE_ALWAYS)) {
> +		if (cflags & PCI_CRASH_CAPTURE_AER) {
> +			struct pci_dev **devs =3D READ_ONCE(pci_crash_devs);
> +			unsigned int i;
> +			bool pci_error_found =3D false;
> +
> +			if (!devs)
> +				return;
> +
> +			for (i =3D 0; i < num_devs; i++) {
> +				struct pci_dev *pdev =3D devs[i];
> +				u32 status;
> +
> +				if (!pdev || !pdev->aer_cap)
> +					continue;
> +
> +				if (pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) {
> +					pci_read_config_dword(pdev,
> +							     pdev->aer_cap + PCI_ERR_ROOT_STATUS,
> +							     &status);
> +					if (status & PCI_ERR_ROOT_UNCOR_RCV) {

Can this evaluate uninitialized stack memory? If pci_read_config_dword()
fails early, it returns an error without populating the pointer, leaving
the status variable with uninitialized stack garbage. The return value isn't
checked before evaluating status here.

> +						pci_error_found =3D true;
> +						break;
> +					}
> +				}
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512162402.1929=
687-1-hangej@amazon.com?part=3D1
