Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635B3C4B9F;
	Thu,  4 Jun 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593979; cv=none; b=Hi3jcCE9QllFUj0ZjX5PxO3Vx6S8wF6r74+dwjIZhJehk1BoICjOksjcATZ8rXIjMb9Phc0RboVY/lNEJARpkOhMnLrKhVrxx9rAnSgTBFcd4qpKqzjM+a3BsOW7qC8XLIMn+inMbTHKDod+3O9Fqwipr8sYe7UgaE60untNwb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593979; c=relaxed/simple;
	bh=7ZFPvY/I/PsSY8fcm8vfefmAGor7doQwI6PrTZ0rd1g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c7IrIr9GdfU6lLLf/amgT4LLffA0KIBN7egMyniwUZ43jN2A8iUj43Up5F8mhcgwrry7HOUBMUyZ1OZMgnBm0kQvdeHMKH9BxojgA3uDGQtrSTdr7+y41x8+OnevNnGsbcgP8IWPpbljbt3bLT9WWebZZXhZcCmmI4BRo4hDJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNUxAzx8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNUxAzx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242B81F00893;
	Thu,  4 Jun 2026 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780593978;
	bh=FXqQYk9Ehwutv2yNZxQbQfRhJ+5UbUFJWhCjY7BqmDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PNUxAzx83pMPen16YzmCgCd/9MC7cuXXasMWQBj9uHAKaTDD/e/WTTqhXjbBwK5z4
	 cQ4DDwDNta7YJGNiAmg2YzFybPHXpW3X0rEJvp4LwYt3F13uu99LnubN4uGI6iFGgE
	 xmR1GUUzzMowPKz+QmE4OVIjDKUyE6pLDm7yM2BZM6kXUQ06G8IW+UJqDo0ryIG9QJ
	 2T1WY+hMrBY9jAe35Stvf+hWXhj0+/b+mskDG50VXZjnR7NlPx+ME128YN/2BCAsxS
	 Ic5jYYv85hhRLqod0++irSpYzC2sLD2TZbMs+/WXQcKZ7Kmx8V86qvWMkm/Nc8sEcM
	 E9qv6F+Xz2kUw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 04/12] PCI: Convert arch/powerpc to pci_is_sriov_* helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dimitri Daskalakis" <dimitri.daskalakis1@gmail.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260604150153.3619662-5-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-5-dimitri.daskalakis1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 17:26:17 +0000
Message-Id: <20260604172618.242B81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Missed conversions of SR-IOV specific is_virtfn and is_physfn chec=
ks.

Pre-existing issues:
- [High] Unconditional NULL pointer dereference in pnv_pci_sriov_disable() =
if PE allocation fails.
- [High] Unchecked NULL pointer dereference in pnv_pci_ioda_fixup_iov() for=
 VFs with failed configuration.
- [High] Failure to unshift IOV BAR resources in pnv_pci_sriov_disable() if=
 the first VF's PE failed to configure.
- [High] Lockless list traversal of phb->ioda.pe_list exposes traversal to =
concurrent modifications.
--

commit 5e49eb3e31cb4ac469a301b263f891c4ba0713e3
Author: Dimitri Daskalakis <daskald@meta.com>

PCI: Convert arch/powerpc to pci_is_sriov_* helpers

This patch converts SR-IOV specific is_physfn and is_virtfn reads in the
PowerPC PCI code to use pci_is_sriov_physfn() and pci_is_sriov_virtfn().
This is intended to keep SR-IOV semantics intact once those flags are
widened to cover other virtualization types.

> Convert SR-IOV-specific is_physfn / is_virtfn reads in the PowerPC
> PCI code to use pci_is_sriov_physfn() / pci_is_sriov_virtfn(). These
> call sites are all SR-IOV-specific: they guard SR-IOV state
> dereferences, VF PE management, or sit inside #ifdef CONFIG_PCI_IOV
> blocks.=20

[Severity: High]
The commit message states that all SR-IOV specific is_physfn and is_virtfn
reads are converted, but did we miss some checks in other PowerPC PCI files?

For instance, in arch/powerpc/kernel/eeh.c:eeh_break_device():

    if (pdev->is_virtfn) {
        ...
        pos =3D pci_find_ext_capability(pdev->physfn, PCI_EXT_CAP_ID_SRIOV);
        ...

If a non-SR-IOV VF (like SIOV) has is_virtfn set, wouldn't this read from
pdev->physfn (which might be NULL) or fail to find the SR-IOV capability
(pos =3D 0) and corrupt the PCI config space at offset 8 (PCI_SRIOV_CTRL)?

Similarly, there appear to be missed conversions guarding SR-IOV logic in:
- arch/powerpc/platforms/powernv/eeh-powernv.c:pnv_eeh_get_upstream_pe()
- arch/powerpc/kernel/eeh_sysfs.c:eeh_notify_resume_add()
- arch/powerpc/kernel/eeh_sysfs.c:eeh_notify_resume_remove()


> diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/pl=
atforms/powernv/pci-sriov.c
> index 7105a573aec42..1113488f43720 100644
> --- a/arch/powerpc/platforms/powernv/pci-sriov.c
> +++ b/arch/powerpc/platforms/powernv/pci-sriov.c
> @@ -225,7 +225,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct p=
ci_dev *pdev)
> =20
>  void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
>  {
> -	if (pdev->is_virtfn) {
> +	if (pci_is_sriov_virtfn(pdev)) {
>  		struct pnv_ioda_pe *pe =3D pnv_ioda_get_pe(pdev);
> =20
>  		/*
> @@ -235,7 +235,7 @@ void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
>  		 */
>  		pe->pdev =3D pdev;

[Severity: High]
This is a pre-existing issue, but can pnv_ioda_get_pe() return NULL here,
leading to a NULL pointer dereference when assigning pe->pdev =3D pdev?

During SR-IOV enablement, if pnv_ioda_configure_pe() fails for a specific VF
in pnv_ioda_setup_vf_PE(), the error is ignored and the VF's PE number
remains IODA_INVALID_PE. When the PCI core subsequently adds the VF and cal=
ls
this function, pnv_ioda_get_pe() will return NULL because the PE number is
invalid.

[ ... ]

> @@ -479,7 +479,7 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pd=
ev)
> =20
>  	phb =3D pci_bus_to_pnvhb(pdev->bus);
> =20
> -	if (!pdev->is_physfn)
> +	if (!pci_is_sriov_physfn(pdev))
>  		return;
> =20
>  	/* FIXME: Use pnv_ioda_release_pe()? */
>  	list_for_each_entry_safe(pe, pe_n, &phb->ioda.pe_list, list) {

[Severity: High]
This is a pre-existing issue, but does this lockless traversal of
phb->ioda.pe_list expose us to concurrent modifications?

The lock phb->ioda.pe_list_mutex is only held briefly during list_del()
inside this loop. However, other PCI hotplug paths (such as
pnv_ioda_setup_PE()) add entries to this list while holding the mutex.

If a concurrent hotplug event mutates the list during this traversal,
could it corrupt the cached pe_n pointer or list linkages, leading to
a use-after-free?

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential NULL pointer
dereference in pnv_pci_sriov_disable() in the same file if PE allocation
fails:

arch/powerpc/platforms/powernv/pci-sriov.c:pnv_pci_sriov_disable() {
    ...
    base_pe =3D iov->vf_pe_arr[0].pe_number;
    ...
}

In pnv_pci_sriov_enable(), if pnv_ioda_alloc_pe() fails, it returns -EBUSY
and iov->vf_pe_arr remains NULL. The generic PCI core handles this failure
by calling pcibios_sriov_disable(), which invokes pnv_pci_sriov_disable().
This unconditionally accesses iov->vf_pe_arr[0], which would crash.

[Severity: High]
This is another pre-existing issue in pnv_pci_sriov_disable(). Does the
error teardown path fail to unshift IOV BAR resources if the first VF's
PE failed to configure?

arch/powerpc/platforms/powernv/pci-sriov.c:pnv_pci_sriov_disable() {
    ...
    base_pe =3D iov->vf_pe_arr[0].pe_number;
    ...
    pnv_pci_vf_resource_shift(pdev, -base_pe);
    ...
}

During SR-IOV enablement, pnv_pci_vf_resource_shift() shifts the IOV BARs
based on the allocated base PE number. If pnv_ioda_configure_pe() fails
for the first VF (VF 0), it zero-initializes the PE structure. During
error teardown, base_pe is read as 0, resulting in a call to
pnv_pci_vf_resource_shift(pdev, -0). This fails to unshift the IOV BARs
back to their original addresses, which could leak the shifted MMIO windows.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604150153.3619=
662-1-dimitri.daskalakis1@gmail.com?part=3D4
