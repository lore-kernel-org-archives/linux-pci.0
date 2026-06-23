Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6A1E832A;
	Tue, 23 Jun 2026 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205632; cv=none; b=TiAl1qSv55mV6s4SbXoDzcl6UgsrMmAyhVj0V4JMO22yo8AE7FhbqacGaBcRXxX/e29HJnsT6fH4xSmK5zfMJ3HfPorGw+k+55+PTd71kUdEq33Roen9JTBtj2C4bnv74p5FMBpYKEU+YwsUO2kX3mTrgsGfWHyIgrWIRtYMWf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205632; c=relaxed/simple;
	bh=bg3yIwxsW44+oOqUl39avmo3UgH9hPgXWcHMpa7mAj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HvsktHwxDxepyFz4unEnzLblBH+luQi+3UUP+dndbcov4aHRoXYf+PplaXKQEIjEeUBZArQORkIcGljN1KuGvBhjlQWbRv5nrQOG5u7CJ8aWe53XtJYiJcUv3Wj533Cq+5PcyOjLEeOLD+qrBrvbclGbzyeHQXDSMTVD5TGzhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4VKjRNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4VKjRNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0F51F000E9;
	Tue, 23 Jun 2026 09:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205630;
	bh=XOe9uE1kSJZYwFxi++xBcZPKUTv0cnRzx3Sr8Vkop+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G4VKjRNdFgsT/kC4DhpIKgUiPNGB06R/4AA7DheFs7SjIJ+/KSf9QmRQy2j8Umzmv
	 lV2z5XMLyDVGO6gYjBStG5qoRJSWIZrZbPmKX68vfXfdR/3/2MLVcf0iUyLiMoysIg
	 i8NmtG/w01JUMBKG2I6aywtDURGh6JfhvyR9sF7HHCLHoJOhHaACG1onCbGSQ9Q9JS
	 vnGKN0McnzfK6BXGF2967lzpzuMMTnHYO+MlpIoJIGIjmB277GZqkRujn3Fmtl9Vr8
	 pTk8KyosqFQON6utm7werPKfIjb/KYQehY/iv7fywjvV/92/fTCWfD+7KVSQNOzeQT
	 eCXS1LNzq6qtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v18 09/12] vfio/pci: Hide TPH capability when TPH
 is unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260623085048.51139-10-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-10-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:07:09 +0000
Message-Id: <20260623090710.2D0F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing kernel heap buffer overflow in `vfio_ecap_init()` due=
 to unvalidated extended capability lengths.
--

commit 04070fd3c8083d2b670da1000c99d6fc517e4114
Author: Chengwen Feng <fengchengwen@huawei.com>

    vfio/pci: Hide TPH capability when TPH is unsupported
   =20
    Check the device negotiated TPH support status before parsing the TPH
    extended capability. Return zero length to hide the capability from
    userspace if TPH is disabled during topology negotiation.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index a10ed733f0e3a..5c6ab172df6c0 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -22,6 +22,7 @@
> =20
>  #include <linux/fs.h>
>  #include <linux/pci.h>
> +#include <linux/pci-tph.h>
>  #include <linux/uaccess.h>
>  #include <linux/vfio.h>
>  #include <linux/slab.h>

[ ... ]

> @@ -1450,6 +1451,8 @@ static int vfio_ext_cap_len(struct vfio_pci_core_de=
vice *vdev, u16 ecap, u16 epo
>  		byte &=3D PCI_DPA_CAP_SUBSTATE_MASK;
>  		return PCI_DPA_BASE_SIZEOF + byte + 1;
>  	case PCI_EXT_CAP_ID_TPH:
> +		if (!pcie_tph_supported(pdev, false))
> +			return 0;
>  		ret =3D pci_read_config_dword(pdev, epos + PCI_TPH_CAP, &dword);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing
issue in how the returned capability length is handled.

Does the returned length from vfio_ext_cap_len() need to be validated
against pdev->cfg_size?

In vfio_ecap_init(), the length returned here is used directly:

drivers/vfio/pci/vfio_pci_config.c:vfio_ecap_init() {
    ...
		len =3D vfio_ext_cap_len(vdev, ecap, epos);
		if (!len) {
			...
			continue;
		}
		...
		memset(map + epos, ecap, len);
		ret =3D vfio_fill_vconfig_bytes(vdev, epos, len);
    ...
}

If a malicious or buggy PCIe device advertises an extended capability like
TPH with a large ST table length (e.g., up to 4108 bytes), could epos + len
exceed pdev->cfg_size?

If so, it appears the subsequent memset() and vfio_fill_vconfig_bytes()
operations could write out of bounds into the map and vconfig allocations.

>  		if (ret)
>  			return pcibios_err_to_errno(ret);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623085048.5113=
9-1-fengchengwen@huawei.com?part=3D9
