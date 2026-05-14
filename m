Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5926FA7A
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778801271; cv=none; b=oDdOTx6sj0pNAFobPgTPBiNbdnUP73UPafkoyQo8Iyqbu9R4X85vPTCyGPnAS8Xf/8ypeLQm6IqJsQvjNlCqjrT8nPhnjhsrqmXc7UsLvwPCWy1jF0QF0mzKMTDVoXz0dcp/lbMPTHqzqJDDYKYXkEICe4psAE5VTvSiyJihAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778801271; c=relaxed/simple;
	bh=cDsQUC5dcuU8uM3N1XfJd0Y+6nbWHt9+od8jW7wX3h8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fgIaZStVmPjpCPhEqq5iUfWK61APHQPCGQJ88r+AiB8KnEFqFcxxj9PGwNY8u+RP08Q6u2oV2kScD02f181W+473iFWJJjygB3ax5ShQg/HhhQvNtTHlJoFUMC+0DAVQef4aCbQRl+KYSKGhHNjCijHnM8G2snbineII4c7TohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvtcjqgU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvtcjqgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED8DC2BCB3;
	Thu, 14 May 2026 23:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778801271;
	bh=cDsQUC5dcuU8uM3N1XfJd0Y+6nbWHt9+od8jW7wX3h8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZvtcjqgUNJ6hSYBdfI9oUFx4SWOu5P2a4SfsLFv8JBWZXaMzs0u3TtK1yL2IMiJhg
	 B1LrC8VhSQThQ8+lidxlgvAdrcjhGCgeq5NIEFVVhPxsW5Sl10IQEPAtc0HvxOZwke
	 71XE5O52RQrGV2bSCJ2srSsfaBnDoQHHL6+eyHjg3qM6Bk7OQrY5YlX2mWmCbK8w0v
	 /f6Gy2VVhvI6CqZuR/V50SPMgJHhb3eZ8Rzsiv2MT8pCqNFnRJwSMRfT2VJMuaxPox
	 +mfJbff9z9jPG4zJOgXALFKiiFWIHcFeX572qU9mygjlY+3ZjaH9Hvmlfu2doleI8q
	 LW/mhIwdWCAyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 5/7] vfio-pci/zdev: Add a device feature for error
 information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260514180059.1553-6-alifm@linux.ibm.com>
References: <20260514180059.1553-6-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 23:27:50 +0000
Message-Id: <20260514232751.8ED8DC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Unlocking an unheld mutex (`pending_errs_lock`) in `zpci_event=
_attempt_error_recovery()`
- [High] UAPI structure `vfio_device_feature_zpci_err` contains compiler-de=
pendent bitfields and implicit padding, breaking ABI
--

commit 034b8d0077a811c23deeb80ce7c989b1da79571b
Author: Farhan Ali <alifm@linux.ibm.com>

vfio-pci/zdev: Add a device feature for error information

This commit adds a new device feature to expose platform-specific PCI error
information for zPCI devices to userspace. This allows userspace to take
appropriate actions for error recovery.

> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index ad273decb1c2b..ec42b81eff330 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -75,6 +75,25 @@ static int zpci_store_pci_error(struct pci_dev *pdev,
>  	return 0;
>  }

While reviewing this code, I noticed a regression introduced by the precedi=
ng
patch in the series ("s390/pci: Store PCI error information for passthrough
devices").

Will this result in unlocking an unheld mutex?

In zpci_event_attempt_error_recovery(), if mediated_recovery is true,
the pending_errs_lock is explicitly unlocked:

    if (mediated_recovery) {
        pr_info("%s: Leaving recovery of pass-through device to user-space\=
n",
                pci_name(pdev));
        ers_res =3D PCI_ERS_RESULT_RECOVERED;
        status_str =3D "in progress";
        mutex_unlock(&zdev->pending_errs_lock);
        goto out_unlock;
    }

However, mediated_recovery is set by calling zpci_store_pci_error(),
which uses scope-based locking:

    guard(mutex)(&zdev->pending_errs_lock);

Since the guard automatically releases the lock when zpci_store_pci_error()
returns, does the explicit unlock in zpci_event_attempt_error_recovery()
cause a double-unlock panic or lockdep splat?

[ ... ]

> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5eee..3eead86a00ab2 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
[ ... ]
> @@ -1534,6 +1534,36 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> =20
> +/**
> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information=
 to
> + * userspace for vfio-pci devices on s390. On s390, PCI error recovery
> + * involves platform firmware and notification to operating systems is d=
one
> + * by architecture specific mechanism. Exposing this information to
> + * userspace allows it to take appropriate actions to handle an
> + * error on the device. The ioctl returns -ENOMSG if there are no pending
> + * PCI errors.
> + */
> +
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

Does the use of C bitfields here break UAPI ABI stability?

Bitfield memory layout and ordering are entirely compiler and architecture
dependent. Additionally, there appears to be a 4-byte implicit compiler
padding hole before the 8-byte aligned faddr field, and a 4-byte trailing
padding.

On 31-bit s390 compat user space environments, the __u64 alignment requirem=
ent
may differ (4-byte alignment), making the structure 68 bytes instead of 72
bytes. This mismatch causes vfio_check_feature() to incorrectly reject
valid 31-bit ioctls with -EINVAL.

Can these bitfields be replaced with explicit integer types (e.g. __u32)
paired with macros for masks, and explicit padding fields added to guarantee
identical layouts across all ABIs and eliminate implicit compiler padding?

> +	__u32 reserved3;
> +	__u16 reserved4;
> +	__u16 pec;			/* PCI event code */
> +	__u8 reserved5[28];		/* Allow for future expansion */
> +};
> +
> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514180059.1553=
-1-alifm@linux.ibm.com?part=3D5
