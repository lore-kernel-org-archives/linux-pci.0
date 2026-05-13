Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB83876DF
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714534; cv=none; b=bSfXY+Q9luvyCYmX5eLm6w6y9YqGUwtRODZeWkyH3+uTB8yqPh26Dq9MLdK+hxmViLYP0p3ALdr+wLvmwfGJXLyIcZ0SBIBLtQrdgrG8mxG9IqjFTmY2BXm4WhEeN/1dlNtAcNfYeX7bIEl67THTZ5VKgGDPAAmxIEMou4VrofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714534; c=relaxed/simple;
	bh=FzVSdJvqlS+XUnHgO5gZ/csdhO+MZYA/ic4K5IooeFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u1VFlU82tlurAsS70mAqsi9SdHsHwmiv4h2wq1Jc4s79TqivaLWqJkZmz+rOA4jDAlR+yPP7qSim5Ko9sgc8fN/ASqENTsUaH2IJF60U9CBAXNcu5EHdyAZeC4E7WkhZL/8HojiQqQW0xQ4MgPxV1LHXfqua04u8GIxZkKsPD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiGehHfi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiGehHfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C318FC19425;
	Wed, 13 May 2026 23:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778714533;
	bh=FzVSdJvqlS+XUnHgO5gZ/csdhO+MZYA/ic4K5IooeFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QiGehHfiWdGJdhDui86/fAqBdnv4tyV40eIta5b9cne9xDBmmNOFJOQBC77L6xZn9
	 GXHH42NY14+u0LrJuV+0ezdJ/4BtKHn6d8d9fGsg5yOJuMU14LcqMoqZ2PLjs+llnO
	 wVF+SPQX8CU1dnvXuK1uJXszBDLL7pz+pZIkaY4lGAy+oTqMZIburxo3+YkYIMKWZU
	 eGlYqHI+SMlqTXjKlZqrIlTJuxRrljDOOPVR0xbMUbeq32BFdbZxF66Q+exwfPKF4x
	 piLIkvgMDZaeXxPlhwg5rzy6JTVjI5CE6n6ptzWw7CgFVYSJ8GbIscV+smIfQ2sJM8
	 iOefddfBCw7WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/16] vfio: selftests: Add continuous DMA to
 vfio_pci_liveupdate_kexec_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511234802.2280368-17-vipinsh@google.com>
References: <20260511234802.2280368-17-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:22:13 +0000
Message-Id: <20260513232213.C318FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing PROT_READ flag in mmap() causes segmentation fault on re=
ad.
- [Low] Incorrect memset size in dma_memcpy_start() leaves half of the tran=
sfer buffer uninitialized.
--

commit 4781683698837fa3bf4dcf765b9c536579e8545a
Author: David Matlack <dmatlack@google.com>

vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test

This commit adds a long-running DMA memcpy operation to the Live Update kex=
ec
test to ensure continuous DMAs do not lead to system instability.

> diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.=
c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
> index 65c48196e44e7..36bddfbb88ed2 100644
> --- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
> +++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c

[ ... ]

> +static void dma_memcpy_start(struct vfio_pci_device *device)
> +{
> +	void *src =3D memcpy_region.vaddr, *dst;
> +	u64 count, size;
> +
> +	size =3D min_t(u64, memcpy_region.size / 2, device->driver.max_memcpy_s=
ize);
> +	dst =3D src + size;
> +
> +	/*
> +	 * Rough Math: If we assume the device will perform memcpy at a rate of
> +	 * 30GB/s then 7200GB of transfers will run for about 4 minutes.
> +	 */
> +	count =3D (u64)7200 * SZ_1G / size;
> +	count =3D min_t(u64, count, device->driver.max_memcpy_count);
> +
> +	memset(src, 1, size / 2);
> +	memset(dst, 0, size / 2);

Does this leave half of the transfer buffer uninitialized?

The transfer size is calculated as size, but the initialization loop
only covers size / 2 bytes. When vfio_pci_driver_memcpy_start() initiates
the DMA transfer of size bytes, the device will read from the uninitialized
second half of the buffer.

> +
> +	printf("Kicking off %lu DMA memcpy operations of size 0x%lx...\n", coun=
t, size);
> +	vfio_pci_driver_memcpy_start(device,
> +				     to_iova(device, src),
> +				     to_iova(device, dst),
> +				     size, count);
> +}
> +
> +static void dma_memfd_map(struct vfio_pci_device *device, int fd)
> +{
> +	void *vaddr;
> +
> +	vaddr =3D mmap(NULL, MEMFD_SIZE, PROT_WRITE, MAP_SHARED, fd, 0);

Does this mmap() call need the PROT_READ flag?

The DMA buffer is mapped with only PROT_WRITE, but the test subsequently
performs read operations on this mapped memory:

dma_memcpy_one()
    VFIO_ASSERT_EQ(memcmp(src, dst, size), 0);

On architectures that enforce strict memory permissions and do not
implicitly grant read access for write-only mappings, this will cause a
segmentation fault.

> +	VFIO_ASSERT_NE(vaddr, MAP_FAILED);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511234802.2280=
368-1-vipinsh@google.com?part=3D16
