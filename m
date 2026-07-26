Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202835F602
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785059021; cv=none; b=dz88CKdZpc4wCMiiejnBm6JSbDDcdZFN7F0BD5bBHEVMhwS52DUOk1hePA/mWq9MdEXKxghnVXO5Ja/6DRNJP+ReErRfxyUlE8hJhVt/UqUv/R7WnS5TAm5W4AP5JNBJKzrKzd6s0A067Q7IMaO6pLzHdmifC++VrmF2NeHBSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785059021; c=relaxed/simple;
	bh=2+q/wA+pgbIRomRUVUpLdc7pLXLFkaQePnMmT42u+Dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cvWQUML9oVYSZKkop+E4o6zShQwaeLHfXYnh8/tsOzRbh+n5RKZlO00S9ZAH4r/8WRt8YLxST0EMwOoQU9jhT2AHsOGsm3QEMFZ8P9KvxzZAYZ/qVqBAN0Xs/7dooyAd5UiZPEnTep/3zt1p+Nd/aLoyMh4mESDBMhG3H+oWSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXTzwf0o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXTzwf0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087C31F000E9;
	Sun, 26 Jul 2026 09:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785059020;
	bh=GCuGpFZ9PGpkzMBxf/a7VZHZTUMGrONHQLz+9VEbgH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXTzwf0o/66iiRrquU0swlWTMN7qOB1F6UHVFKO7Ex6gL6YMkdl5Oo3x5vRBWTwku
	 amTnO+l7FHINwIn67GaN6TEzNtECgZXpytQXrQZdzSFG1i1a5ZVZxlMPJ4kohy21Mr
	 sBfiyxbABcxBjZSfJ67SlD35S+46KaOfD+hS17tsFUXKGnrg6vqJOI9YR6saCHzzQH
	 iOABle6WPQAJ6v4XJQEeWkD36DXqtdeGk4vU8p7EnjmoD+wafQWcFXNyluKTmua8G3
	 HVK5onRbhqDYeOFqvviYDP+cBj1LzS1GrczQcm8Z7BYERIL9Y9ILZzWXoVNc0LEfqT
	 p1iVaLpc2B8Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Free the device name on the
 pci_setup_device() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rihyeon Kim" <rihyeon8648@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260726093200.146111-3-rihyeon8648@gmail.com>
References: <20260726093200.146111-1-rihyeon8648@gmail.com>
 <20260726093200.146111-3-rihyeon8648@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 09:43:39 +0000
Message-Id: <20260726094340.087C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory allocated by early fixups (e.g., `dev->saved_cap_space` and=
 `dev->dma_alias_mask`) is leaked when `pci_setup_device()` encounters an u=
nknown header type.
--

--- Patch [2]: [PATCH v2 2/2] PCI: Free the device name on the pci_setup_de=
vice() error path ---
commit 25426f7c4f229419785305695a130234f0fdabc2
Author: Rihyeon Kim <rihyeon8648@gmail.com>

PCI: Free the device name on the pci_setup_device() error path
   =20
This commit frees the device name in the pci_setup_device() error path
for unknown header types. Since device_initialize() hasn't been called,
pci_scan_device() simply uses kfree() to release the device, which
previously leaked the allocated name.

Link: https://lore.kernel.org/linux-pci/20220817084444.2876059-1-yangyingli=
ang@huawei.com/

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3e6f0eb7d456c..74d84093943bb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2192,6 +2192,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	default:				    /* unknown header */
>  		pci_err(dev, "unknown header type %02x, ignoring device\n",
>  			dev->hdr_type);
> +		kfree_const(dev->dev.kobj.name);
> +		dev->dev.kobj.name =3D NULL;
>  		pci_release_of_node(dev);
=20
[Severity: High]
This isn't a bug introduced by this patch, but since we're fixing leaks on
this exact error path, does this also leak memory allocated by early fixups?

Earlier in pci_setup_device(), we execute:

    pci_fixup_device(pci_fixup_early, dev);

Some of these early fixups dynamically allocate memory and attach it to the
device structure. For example, quirk_intel_qat_vf_cap() allocates state
buffers:

drivers/pci/quirks.c:quirk_intel_qat_vf_cap() {
    ...
    state =3D kzalloc(sizeof(*state) + size, GFP_KERNEL);
    ...
    pci_add_saved_cap(pdev, state);
}

Similarly, pci_add_dma_alias() allocates a bitmap:

drivers/pci/pci.c:pci_add_dma_alias() {
    ...
    dev->dma_alias_mask =3D bitmap_zalloc(MAX_NR_DEVFNS, GFP_KERNEL);
    ...
}

Because pci_scan_device() handles the -EIO return by directly calling
kfree(dev) instead of going through standard device release, it seems these
dynamically allocated resources (dev->saved_cap_space, dev->dma_alias_mask)
will also be permanently leaked here.

>  		return -EIO;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726093200.1461=
11-1-rihyeon8648@gmail.com?part=3D2
