Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409732E126
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404635; cv=none; b=pR/cESgw/vnIBZ9b9kFGzck9auu77Q5kY+xOyANgsloGeIqk+cBpHnfPhUu1gNjaeh4ZoomcKs3FLNUeRG5aZX85iisw93KbsxWZS5GKCmVLsgT4G1lbdRy5xdR/IG5euzxZXOzOPD+l3EoIaJgNEA+8vc/THyBznZKM0KbpnM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404635; c=relaxed/simple;
	bh=l4O9j9OYkkPACHzvPWwhFs9mN+64vgntEi4o8V9WLZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QXNGKqwwmmdhcP3fpPVb82tbVeCltpqxQ3qWrrnTss5BGnv71wjBM7ZTaufeTP0y7VW16dWXW/nRROiVBj/O9m3GaKy5th9E1+mKkVz3UDCw7cPW69d4/rgfKElT77+ufOGaLXt6UdeYP9Z1+GJJUuEwz4zLCIAEwIC3dUg69mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1A9wLnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1A9wLnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E641F000E9;
	Thu, 21 May 2026 23:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779404633;
	bh=WoawyMZfy2WmTE5Nbt8c0aX5aULi6rI4lurSRwvTMqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M1A9wLnlBgTjTnXuMb66wbk6t2bqYap76rcqcUGd3PP/03Y6Bi9eooXz8ms3ESOLH
	 FmOsjlqid4EQKElhtq30oHOssytAJNmlZFCbeAydsMGGKS5KZiquFftfxGYtrQb/7C
	 7NA32FObmDfg0dZ91iw9fXp+Q8CZaYeohRs9Pgaer+13THxGbq/2J5WsGaDsD4d+8n
	 xos2N33Q+bJZivlQVi94jrR5WtRqLrvDtymDKxyqATMJ+EZ+t3nZCG4N8mybfmmFSd
	 LuzGRJety8lFgWDCRejozdIkKdx0aRG7fmM1DkNm4nCMUv3yiaFtc12bgd0xzMaOKw
	 bQaytMVcNyOMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] pci_crash: capture PCI config space at panic time
Reply-To: sashiko-reviews@lists.linux.dev
To: hangej <hangej@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521223010.2681515-1-hangej@amazon.com>
References: <20260521223010.2681515-1-hangej@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 23:03:52 +0000
Message-Id: <20260521230353.02E641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Calling pci_read_config_dword() in the panic path can cause a hard=
 deadlock if another CPU was halted while holding the pci_lock raw spinlock.
- [High] pci_crash_build_pagemap() discards the intra-page offset for kvmal=
loc buffers, exposing garbage data to the crash parser.
- [High] Lack of RCU synchronization and memory barriers during rebuild all=
ows the panic path to hit use-after-free or out-of-bounds array accesses.
- [High] Accessing the PCI configuration space of devices in the D3cold pow=
er state triggers fatal bus errors.
- [Medium] Missing mutex in capture_param_set() allows concurrent sysfs wri=
tes to corrupt the configuration string.
- [Medium] The default capture mode in code contradicts the documented defa=
ult in the commit message.
- [Medium] Rebuild incorrectly retains stale state and leaks device referen=
ces if zero devices match the filter.
- [Low] Ignoring the return value of strim() fails to remove leading whites=
pace from module parameters.
- [Low] Registering the bus notifier after the initial snapshot creates a r=
ace condition that can miss hotplug events.
--

commit 0e9239796d3fc7bf4512456a275c5174281a6334
Author: Johannes Hange <hangej@amazon.com>
pci_crash: capture PCI config space at panic time

This commit adds CONFIG_PCI_CRASH to capture PCI configuration space
(including AER registers) during a panic. The data is written to a
pre-allocated buffer and exported via VMCOREINFO for crash analysis.

Link: https://lore.kernel.org/oe-kbuild-all/202605140501.1tSG7lxR-lkp@intel=
.com/

> - capture=3Daer (default): quick-scan root port ROOT_STATUS, bail if
>   no uncorrectable errors.  capture=3Dalways: every panic.

[Severity: Medium]
This isn't a bug in the code, but the commit message states the default
capture mode is aer, while the code initializes it to always. Should
the documentation and code match?

> diff --git a/kernel/pci_crash.c b/kernel/pci_crash.c
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
> +	if (READ_ONCE(pci_crash_ready))
> +		pci_crash_parse_capture();
> +	return 0;
> +}

[Severity: Medium]
Is it possible for concurrent sysfs writes to corrupt the configuration str=
ing
since this locklessly modifies the global capture array?

[Severity: Low]
Does ignoring the return value of strim() here (and in devices_param_set)
leave leading spaces in the buffer, causing exact string matches (like=20
strcmp(token, "aer")) to fail later?

[ ... ]

> +static struct pci_crash_pagemap *pci_crash_build_pagemap(void *buf,
> +							 size_t buf_size)
> +{
> +	unsigned int num_pages =3D DIV_ROUND_UP(buf_size, PAGE_SIZE);
> +	struct pci_crash_pagemap *pm;
> +	unsigned int i;
> +
> +	pm =3D kmalloc(struct_size(pm, addrs, num_pages), GFP_KERNEL);
> +	if (!pm)
> +		return NULL;
> +
> +	pm->magic =3D cpu_to_le32(PCI_CRASH_PAGEMAP_MAGIC);
> +	pm->num_pages =3D cpu_to_le32(num_pages);
> +	pm->buf_size =3D cpu_to_le64(buf_size);
> +
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

[Severity: High]
Could this discard the intra-page offset for kvmalloc buffers? When kvmalloc
falls back to kmalloc for small sizes, the returned buffer might not be
page-aligned. Would calculating the physical address from the page boundary
cause the vmcore parser to read unrelated slab data and miss the
PCI_CRASH_MAGIC header?

[ ... ]

> +static void pci_crash_read_config_space(struct pci_dev *pdev, u8 *ptr)
> +{
> +	struct pci_crash_device_record *record =3D
> +		(struct pci_crash_device_record *)ptr;
> +	u8 *cfg_data =3D ptr + PCI_CRASH_RECORD_META;
> +	int offset;
> +	u32 val;
> +
> +	record->domain =3D cpu_to_le16(pci_domain_nr(pdev->bus));
> +	record->bus =3D pdev->bus->number;
> +	record->devfn =3D pdev->devfn;
> +	record->config_size =3D cpu_to_le32(pdev->cfg_size);
> +
> +	for (offset =3D 0; offset < pdev->cfg_size; offset +=3D 4) {
> +		if (pci_read_config_dword(pdev, offset, &val)) {
> +			put_unaligned_le32(0xFFFFFFFF, &cfg_data[offset]);
> +			continue;
> +		}

[Severity: High]
Will accessing the configuration space of devices in the D3cold power state
trigger fatal bus errors? Unconditional MMIO reads to a physically powered-=
off
device can cause unhandled Master/Target Aborts, potentially escalating to
fatal exceptions (MCE/SError) that immediately double-fault the panic path.

[ ... ]

> +static void pci_crash_rebuild_snapshot(void)
> +{
> +	struct pci_dev *pdev =3D NULL;
> +	unsigned int count =3D 0, i;

[ ... ]

> +	/*
> +	 * Pass 2: populate device array (filtered) and compute exact
> +	 * buffer size from actual pdev->cfg_size per device.
> +	 * count from pass 1 is an upper bound; actual may be smaller.
> +	 */
> +	total_size =3D PCI_CRASH_HEADER_SIZE;
> +	pdev =3D NULL;
> +	i =3D 0;
> +	for_each_pci_dev(pdev) {
> +		if (i >=3D count) {
> +			pci_dev_put(pdev);
> +			break;
> +		}
> +		if (!pci_crash_device_matches(pdev))
> +			continue;
> +		new_devs[i] =3D pci_dev_get(pdev);
> +		total_size +=3D PCI_CRASH_RECORD_META + pdev->cfg_size;
> +		i++;
> +	}
> +	count =3D i;
> +
> +	if (count =3D=3D 0) {
> +		kvfree(new_devs);
> +		pr_info("no devices match devices=3D%s\n", devices);
> +		goto err_restore;
> +	}

[Severity: Medium]
If a hotplug removal or filter change results in zero matching devices, this
jumps to err_restore and restores the old count, keeping the old_devs array
intact. Does this leak the refcounts of the removed devices and continue to
expose stale device data in the crash buffer?

[ ... ]

> +	/* Release old device references */
> +	for (i =3D 0; i < old_num_devs; i++)
> +		if (old_devs && old_devs[i])
> +			pci_dev_put(old_devs[i]);
> +
> +	WRITE_ONCE(pci_crash_devs, new_devs);
> +	kvfree(old_devs);
> +
> +	/*
> +	 * Swap pagemap first (with pre-computed phys addr), then buffer,
> +	 * then size and count.  If crash fires mid-swap, num_devs is
> +	 * still 0 from above, so pci_crash_save() bails out safely.
> +	 */
> +	WRITE_ONCE(pci_crash_pagemap, new_pm);
> +	WRITE_ONCE(pci_crash_pagemap_phys, virt_to_phys(new_pm));
> +	WRITE_ONCE(pci_crash_pagemap_size, struct_size(new_pm, addrs,
> +			le32_to_cpu(new_pm->num_pages)));
> +	kfree(old_pm);
> +
> +	old_buf =3D pci_crash_buffer;
> +	WRITE_ONCE(pci_crash_buffer, new_buf);
> +	WRITE_ONCE(pci_crash_buffer_size, total_size);
> +	/* Ensure buffer/pagemap/size are visible before num_devs enables captu=
re */
> +	smp_wmb();
> +	WRITE_ONCE(pci_crash_num_devs, count);
> +	kvfree(old_buf);

[Severity: High]
Does the lack of RCU synchronization and memory barriers here allow the pan=
ic
path to hit a use-after-free or out-of-bounds array access?=20

The old_devs array is freed immediately after updating the pointer, and
new_devs can be smaller. A panicking CPU could locklessly read a stale,
larger pci_crash_num_devs and then iterate over the new smaller array, or
iterate over old_devs while it is being freed.

[ ... ]

> +void pci_crash_save(void)
> +{
> +	struct pci_crash_pagemap *pm;
> +	unsigned long cflags;
> +	unsigned int num_devs;
> +	size_t pm_size;
> +	size_t buf_size;
> +	void *buffer;

[ ... ]

> +#ifdef CONFIG_PCIEAER
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
> +				u32 status =3D 0;
> +
> +				if (!pdev || !pdev->aer_cap)
> +					continue;
> +
> +				if (pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) {
> +					pci_read_config_dword(pdev,
> +							     pdev->aer_cap + PCI_ERR_ROOT_STATUS,
> +							     &status);

[Severity: High]
Can calling pci_read_config_dword() in the panic path cause a hard deadlock?
This function acquires the global pci_lock raw spinlock. If another CPU was
forcefully halted by an NMI while holding this lock, the panicking CPU will
spin indefinitely and completely hang the crash dump process.

[ ... ]

> +static int __init pci_crash_init(void)
> +{
> +	/* Nothing to do in crash kernel -- the buffer from the first kernel
> +	 * is already in RAM (flushed before kexec) and the parser finds it
> +	 * via the pagemap in VMCOREINFO.
> +	 */
> +	if (is_kdump_kernel())
> +		return 0;
> +
> +	INIT_DELAYED_WORK(&pci_crash_rebuild_dwork, pci_crash_rebuild_worker);
> +
> +	pci_crash_parse_capture();
> +	pci_crash_parse_devices();
> +
> +	mutex_lock(&pci_crash_lock);
> +	pci_crash_rebuild_snapshot();
> +	mutex_unlock(&pci_crash_lock);
> +
> +	bus_register_notifier(&pci_bus_type, &pci_crash_bus_nb);

[Severity: Low]
Does registering the bus notifier after the initial snapshot create a race
condition? Any PCI hotplug events occurring in the window between the
snapshot completion and the notifier registration might be missed, leaving
the crash buffer out of sync with the hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521223010.2681=
515-1-hangej@amazon.com?part=3D1
