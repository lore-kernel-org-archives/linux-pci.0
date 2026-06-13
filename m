Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD0A26E71E;
	Sat, 13 Jun 2026 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781373354; cv=none; b=N0YL3DRs5hilUJ22P+7kVvcDXkYadUnj1krED8PAHPA1llQ/GH6bIYSkVpQzWJbe95QAerXWzvVGSORxS0C25N/Ff0yp+k2UE/Ey3hHLzpLY/qWEM66LpNeCw8YoAu8E4OmvoNEKL1vY2Pj+G+qlBfdQAjJ+sioFrnMXK1rU0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781373354; c=relaxed/simple;
	bh=bBZ2yRaZdCzQ2nqJww/v3QIv7bEpjzp/wH00Oz9lq7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y+ektsNvnB60Vj5NOKJhW7ihTJMGQiF/5jOFEeH9q047zgobUBs/LCRrD6S/0FMEmTVw4pbEWzPs67AHs2BsPXWNG06LkW6NQlZM20SbI1Bg+/NexaLhQoBZipzIR+F7qpIFKVTYXo8iA5kBCVlp279cugqDVlbuIZOiVatcRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFR813AG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFR813AG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97B41F000E9;
	Sat, 13 Jun 2026 17:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781373352;
	bh=RwqBJFSOFFHfPNGPzi4IwNxOgb8y4qx/Rc2tyk4Qtbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TFR813AGO9uqQ2PfDPbj9DZkjTF4btA5IQz9e0+mmQU5HJigBMF6/uM5KdvoYwIPO
	 Ty4nCPnKJATp55u+I8BqYni5XOnSFdhpfvXCOb7TTJ0gWVFxYK5IM9//g5uIHlloll
	 h03a8k2FDC/t5fdjtrEnqPI/2LhNBrz5BCZTCRKv2AU1EiVKGnzxdWtU9iuxel3yAT
	 TGVrd+qWo7G8O5fA91Gin+g35/l+LIrMKaf8d58xNd8rxJsixL57ltQeNPCB7sdB08
	 Yo2p9kEolupBOccjpIFxeDailDh78s9APni7ZE0UEBdEq4ehzUaaNKlhS46wsMkGgw
	 CtVwCdknxknRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/3] vfio/pci: Virtualize and scrub Device Serial
 Number from guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Arya" <pranjal.arya@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260613-pcie_vfio-v1-1-09168188f3f2@oss.qualcomm.com>
References: <20260613-pcie_vfio-v1-1-09168188f3f2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 17:55:51 +0000
Message-Id: <20260613175551.E97B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check in `vfio_ecap_init()` and `vfio_cap_init()` a=
llows malformed PCI capabilities to cause out-of-bounds memory accesses.
--

commit b6096a89941aa7c7c7c1394233c57ed4b01c16d6
Author: Pranjal Arya <pranjal.arya@oss.qualcomm.com>

vfio/pci: Virtualize and scrub Device Serial Number from guests

This commit virtualizes the PCIe Device Serial Number (DSN) capability in
vfio-pci to prevent guests from reading the persistent hardware serial numb=
er.
It adds a permission bits initializer for DSN and zeros out the serial numb=
er
in the virtualized config space during capability initialization.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index a10ed733f0e3a..24dfeb43cb714 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c

[ ... ]

> @@ -1702,6 +1729,18 @@ static int vfio_ecap_init(struct vfio_pci_core_dev=
ice *vdev)
>  		if (ret)
>  			return ret;
> =20
> +		/*
> +		 * Scrub the physical Device Serial Number from the
> +		 * virtualized config space so the guest cannot read the
> +		 * host device's unique identifier.  The capability is fully
> +		 * virtualized (see init_pci_ext_cap_dsn_perm()), so reads
> +		 * return this scrubbed value rather than hardware.  The user
> +		 * can present a chosen serial via VFIO_DEVICE_FEATURE_PCI_DSN.
> +		 */
> +		if (ecap =3D=3D PCI_EXT_CAP_ID_DSN)
> +			memset(&vdev->vconfig[epos + PCI_DSN_LOW_DW], 0,
> +			       sizeof(__le64));

[Severity: High]
This is a pre-existing issue, but does this loop need to verify that the
capability length fits within the config space buffer before writing?

Looking at vfio_ecap_init(), the loop iterates using the hardware-provided
capability pointer (epos). If a device presents a DSN capability (which has
a length of 12) at an offset near the end of the config space (for example,
if epos is 4092 for a 4096-byte PCIe config space), the capability would
extend beyond pdev->cfg_size.

Since vconfig and map are dynamically allocated based on pdev->cfg_size,
would the newly added memset() write out-of-bounds into the kernel heap?

This new memset() shares the same lack of bounds checking as the existing
unconditional capability writes in vfio_ecap_init():

	memset(map + epos, ecap, len);

and similarly in vfio_cap_init():

	memset(map + pos, cap, len);

Could a malicious physical PCI device or compromised VF supply a crafted
capability list to exploit this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-pcie_vfio-=
v1-0-09168188f3f2@oss.qualcomm.com?part=3D1
