Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07427707
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368347; cv=none; b=YCVMqEIjV+MzaixXaLdFud/5tLUzs0cOG6I87IAy0hNp6/18jCI4gdaCi+H5MnCdldfjaBDh1d/64TOv3e0kH7x4ijUiFEZSIjJF9xknvtY58l0dl9k8lMNrEbBvu/CLawhNDbpL2upxrbWtQyZ+SoMDDgX8MGJUdCe2IHd7SPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368347; c=relaxed/simple;
	bh=yZMf+oFwBHEK1RKDbDvywnURrorCMh7ZDglE6UqmPww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JjmE0ljWZ/WGy7nYyJpE9eFlhl7AFPd/gad4QQB+mStMpIaIjcWjiL1HQ4NtK1H8eGGM54hf+zJXmG8glS1c4EqybF6ix+2MYVSuzzl06fhyA5AnmJgs3Y03E3uk3AMol8h3NI9rONff4fSgytbacInIGzSn1lzrwfcQrod9hJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLjD5zSS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLjD5zSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A3A1F000E9;
	Thu, 25 Jun 2026 06:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782368345;
	bh=W3/s7m8FsezHuNClB7d8s0Ue2vLX76YQvmE/7pfRQic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HLjD5zSSl2KiO6QzvuqwFebZlgizDA2bYZ1pu3Eueb++fZuXtNePIn7mMnUZFLXb7
	 wrHjaohdUmVRYCkFkjSh3zUgL5E7++jikXV4Lr6MbsPCmWSs3yq5OgZJH/06IsxWE3
	 mmI0R80ef2BLij0QsmLuViSrV4byEbe16QtyY6NX8CzUvyIumMAy1lo8coC1ExuzTa
	 TGHBmUvlHsd3LJtimuPdUCYPOwriD5vKsAHsAU0IDXOEDZ7hqY2mYrcX2OM99pu677
	 dAc6jsf+gQvV9pGtZn/5bxyzRzvT7cZO8sboezUyEd+nJ4cc4yVxjJGmimCnpF/mvG
	 GZud833Srf8Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] PCI: vmd: Add vmd_configure_membar() and
  vmd_configure_membar1_membar2()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260625082940.1290740-4-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
 <20260625082940.1290740-4-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 06:19:05 +0000
Message-Id: <20260625061905.A0A3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Dynamically allocated resource names are freed before the reso=
urces are detached from the resource tree, causing a Use-After-Free window.
- [Medium] Dynamically allocated memory for VMD MEMBAR resource names is le=
aked on error paths.
- [Medium] The return value of kasprintf() is not checked, potentially leav=
ing resource names uninitialized as NULL.

Pre-existing issues:
- [High] Error paths and device removal fail to call pci_free_irq_vectors()=
, causing IRQ resource leaks.
- [High] SRCU structures are destroyed before the IRQ handlers are unregist=
ered, risking a UAF if an interrupt fires during teardown.
--

commit 295e9b4a624efdd5299bd60f26213363d5cf8c68
Author: Szymon Durawa <szymon.durawa@linux.intel.com>

PCI: vmd: Add vmd_configure_membar() and vmd_configure_membar1_membar2()

This commit moves the MEMBAR1 and MEMBAR2 registry initialization code into
new helper functions. It introduces vmd_configure_membar and
vmd_configure_membar1_membar2 to handle the resource setup.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
[ ... ]
> @@ -783,6 +783,48 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
[ ... ]
> +static void vmd_configure_membar(struct vmd_dev *vmd, u8 resource_number,
> +				 u8 membar_number, resource_size_t start_offset,
> +				 resource_size_t end_offset)
> +{
[ ... ]
> +	vmd->resources[resource_number] =3D (struct resource){
> +		.name =3D kasprintf(GFP_KERNEL, "VMD MEMBAR%d",
> +				  membar_number / 2),

[Severity: Medium]
Does this kasprintf call need a check for allocation failure?=20

If kasprintf fails under memory pressure and returns a null pointer, the
resource structure will be initialized with a null name, which might violate
kernel API expectations for resource structures.

[Severity: Medium]
Could this dynamic allocation cause a memory leak if vmd_enable_domain fails
later on?=20

Looking at vmd_enable_domain, if functions like vmd_alloc_irqs or
vmd_create_bus return an error, the function exits directly. It doesn't
appear to free these allocated strings on those error paths, leaving the
memory leaked.

[ ... ]
> @@ -1074,6 +1089,11 @@ static void vmd_remove(struct pci_dev *dev)
>  	pci_stop_root_bus(vmd->bus);
>  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>  	pci_remove_root_bus(vmd->bus);
> +
> +	/* CFGBAR is static, does not require releasing memory */
> +	kfree(vmd->resources[1].name);
> +	kfree(vmd->resources[2].name);

[Severity: Critical]
Can this lead to a use-after-free if a userspace tool reads proc iomem
concurrently?=20

By calling kfree on the resource names here, the memory is freed before
vmd_detach_resources unlinks these resources from the parent PCI device
tree. A concurrent read of the global resource tree during this window
might dereference the freed pointer.

> +
>  	vmd_cleanup_srcu(vmd);

[Severity: High]
This is a pre-existing issue, but I noticed we don't seem to free the irq
vectors during teardown.=20

In vmd_alloc_irqs, pci_alloc_irq_vectors is called, but vmd_remove completes
without calling pci_free_irq_vectors. Does this leak IRQ resources,
potentially exhausting system IRQ capacity over multiple bind and unbind
cycles?

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to destroy the SR=
CU
structure here before the interrupt handlers are unregistered?=20

The handlers are registered with devm_request_irq, meaning they remain acti=
ve
until the devres cleanup phase, which happens after vmd_remove finishes. If=
 a
hardware interrupt fires in this window, vmd_irq will call srcu_read_lock on
the already destroyed SRCU object.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625082940.1290=
740-1-szymon.durawa@linux.intel.com?part=3D3
