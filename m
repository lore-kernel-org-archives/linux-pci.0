Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52848C3F6;
	Thu,  2 Jul 2026 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997455; cv=none; b=IMFSjFHiShlaHEm3rkQ40NLi85sRaLWHduPp8Y0Sgn6Go7s8CblaXlVln7r+JQBhB1u3epeY9fhk5wc+BEMigJwWEwTslkIRqbLLBoKnm9NZ1SfPJwndcQcOQ4/o9c4WUKEQwZ62M0UeeGZgZqGPtv60Q4EUORxVfCmn5GbNdIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997455; c=relaxed/simple;
	bh=xiFlcK7zXLHCbocxGkzbGn2SJX5Jc+lPLFBL6I2z6JU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Snx3vjflO204hv4HFmPS11L05VPsNapGMOwwVAM3ANvYYTG8bhCEFQ6LkJ+msECFrsse242ECQJF7x9k+MtAuqz6qfueBVrV8skb8NArgtsXwY1302NTeBTY227uzTYdIA8YBIwAAvoje9HAdD5ZtweGVgVEnbQamJUATSDBxpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0EpzWDM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0EpzWDM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA5A1F00A3D;
	Thu,  2 Jul 2026 13:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782997454;
	bh=a2T1C08ltbKKfHWQikGdUmW4h1fsC62h+ORCVqUrHdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j0EpzWDMBV5tLAudElV57/chvyOxZfudtPVEjmHRH8V8UfUBmzOGG9zw6fVKQyw+t
	 fb9IlGxdMHejCHCxUauRLZ6AXlnVqyiLLf3DynlbyzSrDAv8yY9Mn93Y3ALhoQNFzZ
	 wndH6k+BSZs88Hzg9+u/u46d63/Fv7ctDKi90ztFAX2pmneVdjxsjDjAxRR/d2PH7d
	 bxHyM8J4wmV4uIeh24wScfZGR2CbqOESyqQsPzp26MurFY2mXYMf03BmEvKgN8Ps2q
	 V4sv2ZfUOxB677jHqkb1c5gaNYVd2zRz5F0UBVFP0iVLlLW4JURX9eem4FLo1XI/o+
	 aYCzjiUFEuWsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 11/18] vfio/pci: Virtualize PCIe TPH capability
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260702124224.57168-12-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-12-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 13:04:13 +0000
Message-Id: <20260702130414.5DA5A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Out-of-bounds read and write on the `perm->virt` and `perm->wr=
ite` kernel heap buffers due to unvalidated dynamic hardware TPH capability=
 length.

Pre-existing issues:
- [Critical] Missing bounds check in `vfio_ecap_init` can lead to a heap bu=
ffer overflow when handling extended capabilities with dynamically parsed l=
engths.
--

commit 78dd911822344404c5af18d9dd92fb51e5d34a18
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Virtualize PCIe TPH capability registers

This patch implements virtualization and policy masking for the PCIe TPH
extended capability. It splits configuration space permissions to keep the
header read-only while marking TPH_CTRL and ST-table entries as virtually
writable, and adjusts virtual capability bits based on hardware support.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index 5c6ab172df6c0..06d7b2fbf866a 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1086,6 +1086,73 @@ static int __init init_pci_ext_cap_pwr_perm(struct=
 perm_bits *perm)
>  	return 0;
>  }
> =20
> +/* Permissions for TPH extended capability */
> +static int __init init_pci_ext_cap_tph_perm(struct perm_bits *perm)
> +{
> +	int i;
> +
> +	if (alloc_perm_bits(perm, pci_ext_cap_length[PCI_EXT_CAP_ID_TPH]))

[Severity: Critical]
Does this code under-allocate the permission bits if the capability length
is dynamically larger than 256 bytes?

Because pci_ext_cap_length[PCI_EXT_CAP_ID_TPH] is 0xFF, alloc_perm_bits()
will allocate a fixed 256-byte buffer. If vfio_ext_cap_len() calculates a
dynamically larger TPH capability size based on a device's ST table, it
appears subsequent user space reads or writes past offset 255 could cause an
out-of-bounds heap access when vfio_default_config_read() or
vfio_default_config_write() calls memcpy() against perm->virt and perm->wri=
te.

> +		return -ENOMEM;
> +
> +	p_setd(perm, 0, ALL_VIRT, NO_WRITE);

[ ... ]

> @@ -1704,6 +1774,8 @@ static int vfio_ecap_init(struct vfio_pci_core_devi=
ce *vdev)
>  		ret =3D vfio_fill_vconfig_bytes(vdev, epos, len);
>  		if (ret)
>  			return ret;
> +		if (ecap =3D=3D PCI_EXT_CAP_ID_TPH && !hidden)
> +			vfio_tph_capability_adjust(vdev, epos);

[Severity: Critical]
This is a pre-existing issue, but could the dynamically calculated length l=
ead
to a heap buffer overflow here?

If a faulty or malicious device advertises a large ST table size,
vfio_ext_cap_len() can calculate a length where epos + len significantly
exceeds pdev->cfg_size. Since there appears to be no bounds check before:

drivers/vfio/pci/vfio_pci_config.c:vfio_ecap_init() {
    ...
    memset(map + epos, ecap, len);
    ret =3D vfio_fill_vconfig_bytes(vdev, epos, len);
    ...
}

could this overflow the vdev->pci_config_map and vdev->vconfig heap buffers?

> =20
>  		/*
>  		 * If we're just using this capability to anchor the list,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D11
