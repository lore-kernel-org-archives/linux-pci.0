Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0A2139C9
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778023625; cv=none; b=Aa6VYffLCunDjyrtsc1z7UI+BYIdrxNrDsLglutS8Kq63sSrx+Fl7c+/3tdqYwFUYCar4OA7QCetf8k948RxgyNed+swJ1x2L9caxhtsyYdUiccu0ecKC2fX+askzfr1l81cpA1uico925kHPmOKi/LI3ph/bbOwy2hlJgE9tf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778023625; c=relaxed/simple;
	bh=m0rd/ksG8t+ewlrpucAqM7DIqhPit9hbUkp2jzldRSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LOT2dCo8HgWGSzYnQi6SH5cLUZECn1/s06ZlzymkcdOGWAHrfaPmS6mP7r3BSKuozUWR9HNYspLtrdyD2MJAzYkAApfs5Bva7YQ0vsDNUPIR6Pm+X+laPDwC192/H3oLdM8QzUezNNYapsptJd6VNHai3sucB1WO2IP1/YT46Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqMFnjMS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqMFnjMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F95C2BCB4;
	Tue,  5 May 2026 23:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778023624;
	bh=m0rd/ksG8t+ewlrpucAqM7DIqhPit9hbUkp2jzldRSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XqMFnjMSHgCLgoH57GitSRF9gyWVBGqfCzl3KbTay5pl1Qb0zET4P33+MD+qC+3wP
	 dItgB4CPPIXFii13AXFEn6mjweeKNznHPxpZ5OsXYkrpjmIw+lu4mEUiH3ZvXCMtUr
	 wHVBs8up9UJGW2uboH9f6YOig1Ap6r5922/zgoZjfUcH9sNCAWp/AV+uIJJlQelkGC
	 mg+hNjN3jApgWKbaJomfDPGBD/1nDDZ6qcltlMGlVl5yMW4RoBiOsolGwygXmDc4Py
	 K7mzi/vhE5+KZRXEHvzWwKSI3/0Ai+AT+Rj+NRUX6p8LA3Ld/bh7Ybf3AXD21o8lUo
	 ptTcr0bbcXdfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 5/7] vfio-pci/zdev: Add a device feature for error
 information
Reply-To: sashiko@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505200510.2954-6-alifm@linux.ibm.com>
References: <20260505200510.2954-6-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 23:27:04 +0000
Message-Id: <20260505232704.A6F95C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] UAPI structure `vfio_device_feature_zpci_err` uses non-portable bi=
tfields and contains implicit padding, violating UAPI design guidelines.
--

commit 9302e2545ccb75aab62ae8f60f8aba469ebfdf04
Author: Farhan Ali <alifm@linux.ibm.com>

vfio-pci/zdev: Add a device feature for error information

This commit adds a new device feature to expose zPCI platform specific error
information to userspace. This allows userspace to take appropriate actions=
 to
handle an error on the device and perform mediated recovery.

> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5eee..3eead86a00ab2 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h

[ ... ]

> +struct vfio_device_feature_zpci_err {
> +	__u32 feature_flags;		/* Indicate future features */
> +	__u32 reserved1;
> +	__u32 fh;			/* function handle */
> +	__u32 fid;			/* function id */
> +	__u32 ett		:  4;	/* expected table type */
> +	__u32 mvn		: 12;	/* MSI vector number */
> +	__u32 dmaas		:  8;	/* DMA address space */
> +	__u32 reserved2		:  6;
> +	__u32 q			:  1;	/* event qualifier */
> +	__u32 rw		:  1;	/* read/write */

Since the memory layout, ordering, and packing of C bitfields are highly
compiler-dependent, could this compromise cross-platform ABI stability or
break compatibility with other languages interacting with the kernel?

Using standard __u32 fields and bitmask macros instead might be a safer
approach for a UAPI header.

> +	__u64 faddr;			/* failing address */

The faddr member requires 8-byte alignment, but it appears to be positioned
after exactly 20 bytes of prior fields. Does this force 4 bytes of implicit
compiler padding before it?

> +	__u32 reserved3;
> +	__u16 reserved4;
> +	__u16 pec;			/* PCI event code */
> +	__u8 reserved5[28];		/* Allow for future expansion */
> +};

The explicit data size of this structure appears to be 68 bytes, which
would force another 4 bytes of implicit trailing padding to align the 72-by=
te
structure.

Could this implicit padding make ioctl size validation fragile?

Additionally, if the compiler fails to zero the implicit padding during
struct initialization with err =3D {}, is there a risk that copy_to_user()
will leak uninitialized kernel stack memory to userspace?

Using explicit reserved padding fields to ensure manual, deterministic 8-by=
te
alignment could avoid these issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505200510.2954=
-1-alifm@linux.ibm.com?part=3D5
