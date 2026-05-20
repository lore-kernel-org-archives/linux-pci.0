Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4813E35AC2F
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307189; cv=none; b=o/b0vyu3Qa3xgqNYioETFmvGwLTvyEJ5AFvuuIi2HCFvM/Fica68wfg+EUzVn46ybVPKt8iPvYsrTENLZAbBlkr+/PXNpWVx5xAhpstZHqX0PP14AXIqN4eo0yTto+KJO3tbaJg7l1VfElBeh81cMw/4fE15pXZU1W9xyD/Deyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307189; c=relaxed/simple;
	bh=D48MLhdimnHd1LVpIKs+Fne8Wf29heFga7F29oK53F8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EmcGKBOlUxGgbQINcNBo3nXuHOFGaojtcj1YMWIchY8Tt1lYfoq27gWjJEKcaT0rmcHrzq7Lo/w7YJVTtnzgmS+MEoacONvw2xbXhmaYHpuv9DiSFm1rEumUCM1JkWUjzv5eMcpqnQ0iCd2jPNeARpQIpnHR/7pT/SpnHd81/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfp9cpm0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfp9cpm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D1B1F000E9;
	Wed, 20 May 2026 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307188;
	bh=q/ncXbTpWV+EptIQAiv+ARpSAY2xagdJSvopEx2yYm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cfp9cpm0JsCk/h0XbcyN2A7/fHnM3E4eUhinEqJAmA04M+V3fqDMOi64sZIR8v5qU
	 /gPJBUncavFyuRjUTi+g+iPaATFK0Q3+/7rS3pRt0r8eKFlKmBFg/xYxAJVXQ+XpcM
	 pFhaUCWR8IZmANb1LhlUDliRp92sKAGFWN5x5COziyDWXD/xTYfueT1YiS3RfcTlEv
	 UTTliM/YFXeQTWEaBstA0JWgCfqoTI7bYpFyam4PMO2omR4W7Zapw/zclh7an1UDfm
	 Moc0ZFKOAm77xUklvd/45Z6gXpIKts2Xf6bzKHSw7SbSCXWDRTsaCZWRGpk/ALUfiK
	 udELeNRun0GIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 5/7] vfio-pci/zdev: Add a device feature for error
 information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260520171113.1111-6-alifm@linux.ibm.com>
References: <20260520171113.1111-6-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 19:59:47 +0000
Message-Id: <20260520195947.A0D1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly introduced UAPI structure `struct vfio_device_feature_=
zpci_err` uses C bitfields and contains implicit compiler padding, violatin=
g standard Linux UAPI design principles.
- [Medium] Pending PCI error events are permanently lost if `copy_to_user` =
fails, because the event is destructively dequeued from the kernel ring buf=
fer prior to the copy.
--

commit a4660375ffb0dd291a17be2bdc78cd55dbb931ab
Author: Farhan Ali <alifm@linux.ibm.com>

vfio-pci/zdev: Add a device feature for error information

This commit adds a new device feature to expose platform-specific zPCI
error information to userspace. This allows userspace to handle errors
and perform recovery for these devices.

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci=
_zdev.c
> index 78a28db00c6d6..cc148123a97b8 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
[ ... ]
> @@ -141,6 +141,45 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core=
_device *vdev,
>  	return ret;
>  }
> =20
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz)
> +{
[ ... ]
> +	ret =3D zpci_get_pending_error(zdev, &ccdf);
> +	if (ret)
> +		return ret;
> +
> +	err.fh =3D ccdf.fh;
> +	err.fid =3D ccdf.fid;
> +	err.ett =3D ccdf.ett;
> +	err.mvn =3D ccdf.mvn;
> +	err.dmaas =3D ccdf.dmaas;
> +	err.q =3D ccdf.q;
> +	err.rw =3D ccdf.rw;
> +	err.faddr =3D ccdf.faddr;
> +	err.pec =3D ccdf.pec;
> +
> +	if (copy_to_user(arg, &err, sizeof(err)))
> +		return -EFAULT;

[Severity: Medium]
If copy_to_user() fails here, is the pending PCI error permanently lost?

Looking at zpci_get_pending_error() introduced earlier in this patch, it
destructively dequeues the event by advancing the head pointer and
decrementing the count:

arch/s390/pci/pci_event.c:zpci_get_pending_error() {
        ...
        zdev->pending_errs.head++;
        zdev->pending_errs.count--;
        return 0;
}

Returning -EFAULT after this point leaves the event discarded completely.
Would it be better to only dequeue the event from the ring buffer after
verifying the transfer to userspace succeeds?

[ ... ]
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
> +	__u64 faddr;			/* failing address */
> +	__u32 reserved3;
> +	__u16 reserved4;
> +	__u16 pec;			/* PCI event code */
> +	__u8 reserved5[28];		/* Allow for future expansion */
> +};

[Severity: Medium]
Does this UAPI structure rely on compiler-dependent C bitfields?

Since bit-ordering and layout for bitfields are not strictly guaranteed
across toolchains, would it be safer to use explicit integer types
combined with bitmask macros for this UAPI design?

Additionally, does this layout introduce implicit compiler padding gaps
before the 8-byte aligned faddr field, and at the end of the struct?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520171113.1111=
-1-alifm@linux.ibm.com?part=3D5
