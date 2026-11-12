Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494453;
	b=ZGuBCV+Bk/eMZKydmimjzfWrxUyYHomS357JPB1m1MaxmnzwkeHFGtnrge3MEI1e21u9
	 ZQG4ViBxE9PANvPXb7WIRsUMCNfVPbHGBP8wvrcNAIf/7MX6hqMtUnVbaC74Hitf4CN50
	 C2zLSnXNg6UyrBnbMDJoQvebT3vlISzGCWmhWRySiv7dZj9lpUaSoIJUsC2qNm/QFd5TA
	 KVzG5g5IeT33C/Dg6SDJ+4nYTqYsyS5WFJEbiY5iFGqQuaX1SNRbeA5QFYqdYdD7STjCS
	 f32EKKBXICITgJ4Eak7/KKm/xIHyOWYYokePXY5TAQhFU2E7OjjPOo2y5BGT9FceZjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k/XARqEkJ0JFvf4NkKm9opx0Tky2DjpqU4c+SE6c/m8=;
	b=4ICfuPBXxCxlyhrlHI4uF0WZFm8KkIf/CgQ6jFzTgsBkiyNuhesV7WdsymRJAwuEohys
	 nNVwMSAEjKwTd3aI3VWoTzPI6KDezf7kGEDjAchCD/J/k6GkTKvjlKguyf6IlZcjsL3mU
	 KV8XfUhVmsDmZBWCiB34N9+5O0NRdTzhGZH1pazrbcvx8avzrJZEquBWV5XxNPQd2LJ1A
	 TYP57wC/QXKo60IRcr9pOWWswt5BFb3/2J8XqlSF2gbKDJY3oPLDTrO8dRN7B1HYXfuod
	 0ZgjvE2z+Niti9368IXVDltzi7lMxZ+BM7/ED11MEstwreNh28PZfnYHuJP9GmXr23g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DzhkOt/w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889A606A31C;
	Thu, 12 Nov 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzhkOt/w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC0C1F00A05;
	Thu, 12 Nov 2026 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494452;
	bh=k/XARqEkJ0JFvf4NkKm9opx0Tky2DjpqU4c+SE6c/m8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DzhkOt/wW9rsPOFQ7Vbo+Gcg1jhdAzi9lZCqYf9GlDlkDVPTuFuuD7+ofAYMmtk/+
	 hCW579SNigr2ywM/sjFZ/bcfEx6Hxkevswe4X/Vlg0dN0/98Oq4M6whqF0TDIcxxmI
	 muOZUXegbaKvqYlLnIrKLEvLMgz/is4GAt7hWv5ZXdOauh3663mP/DPXW2PhwTZBEY
	 Kt5Zh81IeOTaIoVn7DmDDQjdzv8yqgRFgIdTJ49DH4ZGKIpIRpfgt7sKM0Rc0po6oG
	 xU3fRJF4tKuVp1qnqR6KmIICqFk1tLU0T0cCjJQEXRgyzJ5zIuQgYdjr2tpLlUD51U
	 GSAn1sj5nsIbQ==
Message-ID: <sashiko-outbox-211362@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 05/20] vfio/pci: Buffer ROM reads before copying
 to userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-6-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-6-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:40:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] vfio/pci: pci_map_rom() called before
  __vfio_pci_memory_enabled() in vfio_pci_rom_read()
--

commit 95981493fc3ccf127f13d3a0117382988fa550cd
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Buffer ROM reads before copying to userspace

This commit buffers PCI ROM reads into a kernel buffer under memory_lock
and unmaps the ROM before copying the data to userspace.

> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci=
_rdwr.c
> index df88480876815..10cd091031fe4 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c

[ ... ]

> @@ -198,6 +200,96 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_=
device *vdev, bool test_mem,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
> =20
> +static ssize_t vfio_pci_rom_read(struct vfio_pci_core_device *vdev,
> +				 char __user *buf, size_t count, loff_t pos)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	bool rom_bar =3D pci_resource_start(pdev, PCI_ROM_RESOURCE);
> +	size_t size, length =3D 0, done =3D 0;
> +	void *data =3D NULL;
> +	void __iomem *io;
> +	ssize_t ret;
> +
> +	/* Protect ROM decoding against concurrent power changes and ROM access=
es. */
> +	down_write(&vdev->memory_lock);
> +	if (rom_bar) {
> +		io =3D pci_map_rom(pdev, &size);
> +	} else {
> +		io =3D ioremap(pdev->rom, pdev->romlen);
> +		size =3D pdev->romlen;
> +	}
> +	if (!io) {
> +		ret =3D -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	/* Buffer only ROM data, not unused space in a large ROM BAR. */
> +	if (pos < size)
> +		length =3D min(count, size - (size_t)pos);
> +	if (length) {
> +		if ((pci_resource_flags(pdev, PCI_ROM_RESOURCE) & IORESOURCE_MEM) &&
> +		    !__vfio_pci_memory_enabled(vdev)) {
> +			ret =3D -EIO;
> +			goto out_unmap;
> +		}

[Severity: Medium]
Should __vfio_pci_memory_enabled(vdev) be checked before calling
pci_map_rom()?

pci_map_rom() enables ROM decoding and calls pci_get_rom_size(), which
performs MMIO reads on the ROM BAR:

drivers/pci/rom.c:pci_map_rom() {
	...
	if (pci_enable_rom(pdev))
		return NULL;

	rom =3D ioremap(start, *size);
	if (!rom)
		goto err_ioremap;

	*size =3D pci_get_rom_size(pdev, rom, *size);
	if (!*size)
		goto invalid_rom;
	...
}

If userspace reads the ROM region while PCI_COMMAND_MEMORY is cleared in
vconfig or the device is in PCI_D3hot, pci_get_rom_size() still issues MMIO
reads to the disabled or D3hot device, which can trigger Unsupported Request
AER errors or platform faults.  When those reads return 0xffff,
pci_map_rom() also logs an invalid ROM signature error and returns NULL, so
vfio_pci_rom_read() fails with -ENOMEM before reaching the
__vfio_pci_memory_enabled() check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D5
