Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640033F7891
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512576; cv=none; b=mfHmq5EhBbvQhJ/XJKIFBx4AbM35E8/oejDAIQ/f/NHcSrBjaa2beexvYyvDtWXsQlDitX+TOxIh860RXZSg1QB6etKHOJUuOCkIuJhXnaReoOIviw0WUqh/HVCErauytmI5c/eKxVpwtlfLOBwSR8/JOY7/qpb5Naez0wLs+58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512576; c=relaxed/simple;
	bh=5Pp9D5Vsk6/FZ58Zk2/yETw+xhDODDNJZpXjtJhlSf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XPdvl/VFxoAXWj5vW+AR6kG1yYpzLrbZ0YBF1OPQOw4+OOrtDNdNeqOuSJFZMEyIBPk+zjXUiDs3sfMbuyODWlSePTVQYdPPJUw0NrR/hygsYLmUHVscY9tKWyafTTYnVeZSxTFan0yTiCgH0PYWQr2Gnw+jiggJnvzDRPKL1ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STUrmtX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STUrmtX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994BF1F00893;
	Wed,  3 Jun 2026 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780512575;
	bh=ENi+cT03eWpzK+M188g1CBc4LCmHQZ/CCkybanowFT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=STUrmtX84CzMBtfvI2hekf04hRsCEHTMEOVNVzQL6tC+2BpA2I1Bn0yI2XFen6GL8
	 IDJqd8L2ZpiJo1nQtDyzETVARxRWppwq1x+vdFSNyWgvHzO/pSjtq85djiaqT5C2qY
	 yXCTsYYZJVsdCT3sAQQqEIEu8GvBq2xwg0uskuo/tlX+4tMMwViwHAcugqhKA7oY35
	 LZ6b+r3izsvszJFu+0Kk8LT3B5wmK/mxcScoakPzKFypzINornyux4JDks6L4UYWP7
	 yX1cRM5I093CTSGqXr0uyp+en/HEvfG/kMb+MNOM8POPbiAsnn09ujKGRj50yxJeAy
	 wuo2p/R7JeQQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 2/4] vfio-pci/zdev: Add a device feature for error
 information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260603182415.2324-3-alifm@linux.ibm.com>
References: <20260603182415.2324-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 18:49:34 +0000
Message-Id: <20260603184934.994BF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The UAPI structure `vfio_device_feature_zpci_err` uses C bitfields=
 and contains implicit compiler padding holes, violating ABI stability guid=
elines.
- [Medium] User-triggerable kernel warning log due to failed `copy_to_user(=
)`.
--

commit 91bf6efc558a8f6b752d8cbe1ecebd56aaccfea2
Author: Farhan Ali <alifm@linux.ibm.com>

vfio-pci/zdev: Add a device feature for error information

This commit adds a new device feature to expose zPCI platform specific
error information to userspace. This allows userspace to recover from
these errors.

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci=
_zdev.c
> index 78a28db00c6d6..c0d6362cc4eb0 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
[ ... ]
> @@ -141,6 +141,49 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core=
_device *vdev,
[ ... ]
> +	if (copy_to_user(arg, &err, sizeof(err))) {
> +		dev_warn_ratelimited(device->dev,
> +				     "Failed to handle PCI error event for PCI function 0x%x",
> +				     zdev->fid);
> +		return -EFAULT;
> +	}

[Severity: Medium]
Is it intended to log a kernel warning when copy_to_user() fails?

Because copy_to_user() failures are caused directly by user space providing
an invalid, unmapped, or read-only memory address in the arg pointer,
could an unprivileged user intentionally pass invalid pointers to trigger
these warnings and spam the host kernel logs?

> +
> +	return 0;
> +}
[ ... ]
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5eee..3eead86a00ab2 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
[ ... ]
> @@ -1534,6 +1534,36 @@ struct vfio_device_feature_dma_buf {
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
> +	__u64 faddr;			/* failing address */
> +	__u32 reserved3;
> +	__u16 reserved4;
> +	__u16 pec;			/* PCI event code */
> +	__u8 reserved5[28];		/* Allow for future expansion */
> +};

[Severity: High]
Does this struct layout rely on C bitfields and implicit compiler padding in
a UAPI header?

Bitfields are highly compiler- and architecture-dependent, which can break
cross-architecture compatibility.

Additionally, is there a 4-byte implicit padding hole between the bitfields
(ending at offset 20) and faddr (which must start at offset 24 due to
8-byte alignment on 64-bit platforms)? Is there another 4-byte implicit
padding hole at the end of the struct to satisfy the overall 8-byte
alignment requirement?

Should explicit padding fields and bitmask macros be used instead of C
bitfields to ensure ABI stability?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603182415.2324=
-1-alifm@linux.ibm.com?part=3D2
