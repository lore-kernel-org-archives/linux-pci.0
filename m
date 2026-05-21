Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAB1FC7
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779398426; cv=none; b=NqWk0MBbpAoiWQMBVjcdfYbkbdaNEd7VssPWnG1ye98W7kqg/xU4qnSx0UKygdwYc3n7NZ571h6mUnGO9DPPIORrGW9HUrcQqWc+QAvAfRal4cgAyGd60jkTca/m1fePXeT3VxP//t3MhCrNz5XsNw9f4cWwA/lZ51T94HjKVEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779398426; c=relaxed/simple;
	bh=e06c+M8Jt7thwcdlHReM6e55K7NiJMPvTdh75xlmFUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DUUHnx86DZ/ZJsqQQJ8V7B1wtAUY6wkojeVWIs7AsTE5Y3Lg1fVBbBGy3CnyyVP86TGzzrO8c0bKrzrb1EKvk5ndBJMZlOW2PSIKGhVluO5bbahoEVMOyzyBb7+CLEIdc7QVpyt/dThBqekVhmPn2q3qD0SbASuRv6rHO0c1h1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkbM1lOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkbM1lOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8689D1F000E9;
	Thu, 21 May 2026 21:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779398425;
	bh=39Qjy2TtUSN13Dos821ynVOFoDoV5AnhBQ7k5nBSync=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HkbM1lOOt+pybMF4nvh1kclYxXUcLumkwauiv1fLtOjA7mcmiU2p7uK++Mg9W7Jro
	 Zrp1TZ/y+qnWVAA4m/vPgdiZJHtIi8vHj3no9L4nItZo0wiHbxNjco62zqXxnUuTSd
	 78tzfLihXIeo8wWbLVUyFtRCZN1JR8n5DlylTMQ6lU1v3KyaV6td8IQkqPL+qgJoUR
	 s+oqeC/tQUC+J8jnbO3juC1jro7b011Dqmugm9fXFoGFmNDOyFeXZO3M3YCRQ5GGx4
	 3g104q6rzuBLzU12A8kOBBFAqpO5kLzruR7jDD4j/BCtKLBxIIHiU0jhBhjVr45szI
	 ZWGS4Px38nD9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] PCI: vmd: Protect root bus removal with rescan lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521161822.132996-9-18255117159@163.com>
References: <20260521161822.132996-9-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 21:20:24 +0000
Message-Id: <20260521212024.8689D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Acquiring `pci_rescan_remove_lock` in `vmd_remove()` introduces se=
lf-deadlocks and AB-BA lock inversions.

Pre-existing issues:
- [High] SRCU structures are destroyed in `vmd_remove()` while their corres=
ponding interrupt handlers are still registered and active, leading to a Us=
e-After-Free in interrupt context.
--

commit 8d5d06b67e6b02d2cc99f2151e90ba61c0d16662
Author: Hans Zhang <18255117159@163.com>

PCI: vmd: Protect root bus removal with rescan lock

This commit acquires the pci_rescan_remove_global_lock while stopping
and removing the VMD root bus in vmd_remove(). This is intended to
prevent races with concurrent PCI rescan operations.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6d..9565567026cf0 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -1056,9 +1056,11 @@ static void vmd_remove(struct pci_dev *dev)
>  {
>  	struct vmd_dev *vmd =3D pci_get_drvdata(dev);
> =20
> +	pci_lock_rescan_remove();

[Severity: High]
Can acquiring pci_rescan_remove_lock here cause self-deadlocks or AB-BA lock
inversions?

When a VMD device is removed via PCI hotplug or sysfs remove node, the PCI
core calls pci_stop_and_remove_bus_device_locked(), which acquires
pci_rescan_remove_lock and eventually triggers vmd_remove(). Because
pci_rescan_remove_lock is a non-recursive mutex, won't attempting to acquire
it again immediately self-deadlock?

Also, when unbound via sysfs, the core holds device_lock and calls
vmd_remove(), which then waits for pci_rescan_remove_lock. Since normal PCI
rescans acquire pci_rescan_remove_lock first, then attempt to acquire
device_lock, does this create an AB-BA lock inversion?

>  	pci_stop_root_bus(vmd->bus);
>  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>  	pci_remove_root_bus(vmd->bus);
> +	pci_unlock_rescan_remove();
>  	vmd_cleanup_srcu(vmd);

[Severity: High]
This is a pre-existing issue, but does this code cause a use-after-free in
interrupt context?

The driver registers its interrupts using devm_request_irq(), which means
devres runs after vmd_remove() returns, leaving the IRQ handlers active
throughout device removal.

If an interrupt fires during this window, won't the active vmd_irq() handler
call srcu_read_lock() on the destroyed SRCU structure and result in a
use-after-free of per-CPU memory?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521161822.1329=
96-1-18255117159@163.com?part=3D8
