Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082F3F6C2A
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753117; cv=none; b=WxY8qcGOQVFDZhe4PUjFNXHE+7riqJoLFvSP46TA0HFabA1cLShAjcL41CkHH9pnGD09tUwtW0nuDAC+CuDurX6tiTUmJNZ7dttErRNL0t2uaUr8CnsfL6rYfVUr21E01ANQ7cXy0nOl1DVLqApPrDCkk3mCtR1iqN9rvn/wNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753117; c=relaxed/simple;
	bh=20TVxeYyVXRr/HbElV6ons+mWSyEARnimPywb9tyBgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jgc+UMWKYPEmgsrd1DHpAjxMGNaI2qiGXs1Gnk5Cwb1gnVHidUL+sNYqokJLOUX57Fq6F1ddFFfUs47w3RwvQVTeL95a6CGbcb6s6z7nr97jxNJXP+SXdft91LPuIMcbVT0/ryPOQKrvSAiLml4bGNcDNtJUaROlOv3+QVKnOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsDOb9w2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsDOb9w2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8042C1F000E9;
	Mon, 29 Jun 2026 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782753115;
	bh=BzVZexK+va5LIfpDNECVqfyogKcz/YtIcFxoB+wDYr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RsDOb9w2xrGW/4ZevIseobfsLGCswi40h9P77LzYVFtu6paypYxWBzTnbtGYsGv5x
	 JGUhY612O63mbKLRVE7AMk+uD66OvE5GC4E4UKGJzfevq9mb84Z7+V6pC7ua2MYsp1
	 Pl0wWqt0K1cbHqVYoerGQiemFDfkzIH8XmE6kF8Kv7GAO/bcdymcJyyJyUoiouDRZ8
	 ToAR3hgnhvGXC8pVgCuhWXQWa0podKFRWd4vGviilUxiKZu6vV4kCRAJCyzTnJp9D/
	 SbYFPPvzEeouwtcjUAk7yqMxw7tHJv/FOBPmLuVG/2e01kQB/bQ8nxjzx5sQzb6EKh
	 Q2SfFcGzqKm9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: vmd: Only assign _OSC features in bare metal OS.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmal Patel" <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260629170117.269703-1-nirmal.patel@linux.intel.com>
References: <20260629170117.269703-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 17:11:55 +0000
Message-Id: <20260629171155.8042C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Incorrect logical condition for bare-metal identification copies _=
OSC flags in VMs.

Pre-existing issues:
- [High] Missing `pci_free_irq_vectors()` causes permanent IRQ resource lea=
k.
- [High] Use-After-Free of SRCU structures on device teardown.
--

commit e71e6e8c7000a74dc9ba1f30dbef4f5d9f13bf08
Author: Nirmal Patel <nirmal.patel@intel.com>

PCI: vmd: Only assign _OSC features in bare metal OS.

Copy valid _OSC flags from root bridge only when OS can provide correct
values. In virtual machine, all of the control features are disabled as
hypervisor will not passthrough root bridge information to VM.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6d..f9e38f2f926a7 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -910,8 +910,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, un=
signed long features)
>  		return -ENODEV;
>  	}
> =20
> -	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> -				   to_pci_host_bridge(vmd->bus->bridge));
> +	/* Don't copy _OSC control flags in VM, it disables features.*/
> +	if (!offset[0] || !offset[1])

[Severity: High]
Does this logical condition correctly identify a bare-metal environment?

If a VM exposes only one non-zero MEMBAR offset, this evaluates to true,
which misidentifies the VM as bare metal. This results in copying the
host bridge flags and incorrectly disabling control features in the VM.

Should this use && instead of || to ensure both offsets are zero?

> +		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> +					 to_pci_host_bridge(vmd->bus->bridge));
> =20
>  	vmd_attach_resources(vmd);
>  	if (vmd->irq_domain)

[ ... ]

[Severity: High]
This is a pre-existing issue, but does vmd_remove() leak the IRQ vectors?

vmd_alloc_irqs() allocates vectors without a devm wrapper:

drivers/pci/controller/vmd.c:vmd_alloc_irqs() {
...
    vmd->msix_count =3D pci_alloc_irq_vectors(dev, vmd->first_vec + 1,
                                            vmd->msix_count, PCI_IRQ_MSIX);
...
}

However, the teardown function lacks a corresponding cleanup:

drivers/pci/controller/vmd.c:vmd_remove() {
...
    vmd_cleanup_srcu(vmd);
    vmd_detach_resources(vmd);
    vmd_remove_irq_domain(vmd);
...
}

Since pcim_enable_device() doesn't exempt explicit cleanup for this API,
will this cause a permanent IRQ resource leak on module unload?

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk with the
SRCU structures during device teardown?

In vmd_remove(), the driver manually cleans up SRCU primitives:

drivers/pci/controller/vmd.c:vmd_remove() {
...
    vmd_cleanup_srcu(vmd);
...
}

Because the device's IRQ handlers are managed by devm_request_irq(), they
are not freed or unmasked until after vmd_remove() returns.

If an MSI-X interrupt fires in the intermediate window, could vmd_irq()
access the destroyed srcu_struct?

drivers/pci/controller/vmd.c:vmd_irq() {
...
    idx =3D srcu_read_lock(&irqs->srcu);
...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629170117.2697=
03-1-nirmal.patel@linux.intel.com?part=3D1
