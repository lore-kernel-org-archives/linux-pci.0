Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BEC3CAA55
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052703; cv=none; b=MmQUPnV8dia/BftQTVRg8GuRzcISiDsNZWrEXK6PNUbX3s/98QNShXbiY1zSc73ulYbEJ6OzFScwrE9T0Ff5QmRrrSYEAEJKw1A+UB+h3VbRRjpaKNm2+Idp1nJN2DBdpA0kQnVEohh6ITuoby+CfpiR7RzypxrMFUbysBevdcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052703; c=relaxed/simple;
	bh=ZGFppJxDuKXpBPANVOCnFT6y0xGGbloFJU6wtQyAmVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UIjEzsbwYeMvVfHqJlv2FiXRlH8nMfrNe0C2dThLAM4y3D3nJze55SGD8bwawtOatF/kHK+wYnursQ1myhedyfQ32TybHdK14bZg5EXkQckRojw0GGPcvLbpu5dY8tHIdJFnUoKPVgIlAQdGnE8Cvc6OyjXfXKm7ctpUKMjMq5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpoiytlZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpoiytlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DD21F000E9;
	Tue, 14 Jul 2026 18:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784052702;
	bh=ONvNxhj60iXz3rKqldzskOYBVc/8xFVWC45uhdT2/Do=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WpoiytlZJBGWcja3kUUPVdjngtMswZFk7nYI54A9eFPk3Qe8eYtyj2VnLxSPJcSH2
	 LEjTvr78nhykY0K4PF/+Rn0f5piLydhUIiDXCQFOJcLVL57Fkzwq/gQs/B9M3XLoe/
	 nwklL0QUgrGj4eFVBrB5y5dzt5w3/HgDajE4gVIVyBlbiiPxDnz4yoXxfZggr9V/RG
	 6GgRR1TTXRppQ7sgDSniwR0abaQ3vF/YyJJz7HOJmDF5QTUK54lmYBnqrsFqeY6v/s
	 r0qoOL09vFsw8/YEbcTJiwk27u/5VtVuXKFqxZf6Uz8IONyObZbvCZKz10xIi65hye
	 hLEMjailIcT9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] pci_crash: capture PCI config space at panic time
Reply-To: sashiko-reviews@lists.linux.dev
To: hangej <hangej@amazon.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714175305.2783480-1-hangej@amazon.com>
References: <20260521223010.2681515-1-hangej@amazon.com>
 <20260714175305.2783480-1-hangej@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:11:41 +0000
Message-Id: <20260714181141.F2DD21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Calling `pci_dev_put()` from an RCU softirq callback can sleep in =
atomic context.
- [High] Accessing `bus->ops->read` on a removed device causes a Use-After-=
Free if the host controller driver was unloaded.
- [Medium] Skipped captures export un-flushed zeroed buffers, allowing the =
crash parser to read stale crash data from RAM.
--

--- Patch [1]: [PATCH v3] pci_crash: capture PCI config space at panic time=
 ---
commit 93c2fd5e7de948b1f47b018b3d8a6d93723570c6
Author: Johannes Hange <hangej@amazon.com>

pci_crash: capture PCI config space at panic time

This commit adds CONFIG_PCI_CRASH to capture PCI configuration space during
a panic before kexec. It uses a pre-allocated buffer exported via
VMCOREINFO and relies on RCU snapshots and lockless accesses to safely
record device state.

> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -131,7 +131,7 @@ int pci_bus_read_config_dword_trylock(struct pci_bus =
*bus, unsigned int devfn,
>  	if (!pci_trylock_config(flags)) {
>  		PCI_SET_ERROR_RESPONSE(value);
>  		return PCIBIOS_SET_FAILED;
>  	}
>  	res =3D bus->ops->read(bus, devfn, pos, 4, &data);

[Severity: High]
If a host controller driver is unloaded right before a panic, could this
dereference freed module memory?

Because the bus notifier uses a 200ms debounce delay, the crash snapshot
might hold a stale pci_dev reference. The reference keeps the pci_dev
struct alive, but if the controller module was unloaded, bus->ops->read
points to freed memory. Clean removals do not set error_state, so the
pci_crash_endpoint_reachable() check might not filter the device out.

[ ... ]

> diff --git a/kernel/pci_crash.c b/kernel/pci_crash.c
> --- a/kernel/pci_crash.c
> +++ b/kernel/pci_crash.c
> @@ -142,6 +142,6 @@ static void pci_crash_snapshot_free_rcu(struct rcu_he=
ad *head)
>  	if (READ_ONCE(pci_crash_captured_snap) =3D=3D s)
>  		return;
> =20
>  	for (i =3D 0; i < s->num_devs; i++)
>  		if (s->devs && s->devs[i])
>  			pci_dev_put(s->devs[i]);

[Severity: High]
Can this call to pci_dev_put() sleep in atomic context?

This runs in an RCU softirq callback. If a device was hot-removed,
this snapshot might hold the final reference to the device. Dropping
the last reference triggers device_release() -> pci_release_dev() ->
devres_release_all(), which may take sleeping locks or allocate memory
with GFP_KERNEL.

[ ... ]

> @@ -864,14 +864,14 @@ void pci_crash_save(void)
>  	WRITE_ONCE(pci_crash_captured_snap, s);
> =20
>  	pci_crash_buffer =3D s->buffer;
>  	pci_crash_buffer_size =3D s->buffer_size;
>  	pci_crash_pagemap_phys =3D s->pagemap_phys;
> =20
>  	cflags =3D READ_ONCE(capture_flags);
>  	if (!(cflags & PCI_CRASH_CAPTURE_ALWAYS)) {
>  		if (!(cflags & PCI_CRASH_CAPTURE_AER)) {
>  			goto out;
>  		}
>  		if (!pci_crash_aer_error_present(s)) {
>  			pr_info("no PCI errors detected, skipping capture\n");
>  			goto out;
>  		}
>  	}

[Severity: Medium]
If the capture is skipped and jumps to the out label, could the crash
parser read stale data from RAM?

The export variables are set before the AER check. If no AER errors are
found, the code jumps out without flushing the dcache. Since the buffer
and pagemap were written in process context during rebuild, they might
only reside in the CPU cache.

The crash kernel will read physical RAM, which might contain an older,
valid PCIC magic signature from a previous boot or panic, leading to
stale records being parsed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714175305.2783=
480-1-hangej@amazon.com?part=3D1
