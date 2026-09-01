Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D53A9DA3;
	Tue,  1 Sep 2026 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256126; cv=none; b=bUcnXavmntuZACESV9dMB90pBcfUUjCk73QF2RKBNmiQSeXse0ZIMAH3/5I/DnvDxEtUIDJg8onvr1zgNJilqbsGIkZ1tp7N7Qn+33P0HlAlzcSBKcNP3hivDc/8zxxYlOXvXjywz+n69J+Q9Yb4efd3MYaYWcIBAihfScPemVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256126; c=relaxed/simple;
	bh=G3iA71pFqNqxzG2k/U72SQEMt/T5aeQazIk+GtT3ul0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T+LMo9fMNRKq9014rMVz1YamX6Yf49SoP8nP6hTBmswF1pwNBUPPRGWPu04qJfiChF9trFOcyQIDStjQS6NH8pbzLrYwSuRMuIf2D+TkChDHN8RYQp4MxW5GYGTcv5kZNhYxfwTFf0WZ2TKhQyn1CySdpNv8dnSxuGduJtEFQiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTzDZCWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTzDZCWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8BC1F00ACA;
	Tue,  1 Sep 2026 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256124;
	bh=e0TtJfikHU5dBgvfdZnQsO/o7lz/Df8fp98XffYq+Us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HTzDZCWs4KUhcMhfjDgyfh3424mXtoAn78trQbpQRI92W8MQmO2HIuSs+xPcAQ9zM
	 Xi1k2z+u3gugPmZsrZPcu9LY7M32xJ6eceGXwCeWL7OCsI9WjvK1B53wA1hStkDH5/
	 X00f1ursEv+l2haGR1ujpzAPKStJzAqvVlnMay05rM7LPwPqyIqZNka0d1ZkcCC7QU
	 djgqESNEFh9gTBmClav8f7GMyzTiGU07rrj+ojbR78y94S1O/2ZUkzQSfKh7RznU4c
	 Ef6LBgJijcV5zZGB0GVgxme53pJiUm1v2MYbFqS/vzaruXCTlciYyrwBU99JQn1nBL
	 ZEDmdw8vdVDYw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/19] vfio/pci: Serialize BAR and ROM access with
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901093217.8539-9-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-9-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:48:42 +0000
Message-Id: <20260901094843.4F8BC1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent accesses to PCI_ROM_RESOURCE map and unmap the ROM, whi=
ch concurrently read/modify/write the ROM_ENABLE bit in PCI config space wi=
thout serialization. One thread's unmap can disable the ROM while another t=
hread is still performing IO, leading to Master Aborts or AER hardware erro=
rs.
--

commit 56bec71818cf734e5593b7903748915f73efa3b3
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Serialize BAR and ROM access with recovery

This commit holds the recovery_lock for reading around trapped BAR reads
and writes, as well as around ROM mapping. It defers unmapping configuration
changes during host recovery to prevent accesses while recovery blocks them.

> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci=
_rdwr.c
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
[ ... ]
> @@ -230,7 +275,11 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device =
*vdev, char __user *buf,
>  		 * filling large ROM BARs much faster.
>  		 */
>  		if (pci_resource_start(pdev, bar)) {
> +			ret =3D vfio_pci_core_access_begin(vdev);
> +			if (ret)
> +				return ret;
>  			io =3D pci_map_rom(pdev, &x_start);
> +			vfio_pci_core_access_end(vdev);
>  		} else {
>  			io =3D ioremap(pdev->rom, pdev->romlen);
>  			x_start =3D pdev->romlen;
[ ... ]
> @@ -269,7 +318,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *=
vdev, char __user *buf,
> =20
>  	if (bar =3D=3D PCI_ROM_RESOURCE) {
>  		if (pci_resource_start(pdev, bar))
> -			pci_unmap_rom(pdev, io);
> +			vfio_pci_unmap_rom(vdev, io);

[Severity: High]
This is a pre-existing issue, but does the lack of serialization around ROM
mapping and unmapping expose the host to hardware errors?

When two threads in userspace concurrently call pread on the VFIO device fi=
le
descriptor targeting the PCI_ROM_RESOURCE BAR, both threads will enter
vfio_pci_bar_rw and call pci_map_rom. This enables the ROM address decoder =
in
the PCI config space.

When the first thread finishes reading, it calls vfio_pci_unmap_rom, which
disables ROM decode by clearing the ROM_ENABLE bit in config space.

If the second thread is concurrently executing vfio_pci_core_do_io_rw and
performing IO reads on the memory-mapped ROM, the disabled ROM address deco=
der
will cause the PCI read transaction to result in a Master Abort or an
Unsupported Request.

Depending on the host AER configuration and hardware, this could trigger
an Advanced Error Reporting interrupt, leading to a system freeze or panic.

Given that unprivileged userspace like a QEMU process can reach this path,
is there a need to serialize these concurrent accesses to prevent a Denial =
of
Service?

>  		else
>  			iounmap(io);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D8
