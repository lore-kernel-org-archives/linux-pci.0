Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C337206D
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621072; cv=none; b=KO8SRZCgiX18Bk60K+vRuOmd1CWwRkbq+bAzWfHrTkWd6kv6p44ojeXdsoH7S2luGTC8pLh+EMbd2K0fSXR3y1gvh39Ehjg9pHJ7LsrbHfSEP4iiLIDBiineVsndOED7paVUNemrYt24Wv67VoNYeh42a+Xgk+gyExY+L/hFVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621072; c=relaxed/simple;
	bh=x+mBFqZCy0/lg4AwvtKW+2fdL6v3igWT0DYWn1j3ON0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CbI5Topu3OdbUiTSjhTmJIGvwMtqKmzQgwENMYjspgtG55It1HbLHjt99X+VrTWivB94IvDKisJ1f4birTAlYUjrPxb5YcyenetPjn3fELj0iOZ50e3kJciXSUxo9yjeR4qRx7ToyrryMFG0a4ipr7NL39gd5oZElUfxfhVQjdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8SOd+KM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8SOd+KM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB324C2BCB0;
	Tue, 12 May 2026 21:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778621072;
	bh=x+mBFqZCy0/lg4AwvtKW+2fdL6v3igWT0DYWn1j3ON0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=X8SOd+KMo3FbRuVAALtlQhubnNSsBOGToGNWv7ouTFT8MxY1nzCy0Hajihet/oiLD
	 bZMtEZtJI+QjpGsOFJiMoK5gMnlaxCgAZuD1d9iGS5eFNsf3K3dR50jk0pxrzbfQtL
	 rXTZfWeNm0OQIXjy8bOKaW17KXVMS2kH9chi/+tc7VcWUzT6I55k1hC3iRF+Oaq+Xk
	 MsMoWGjGktSz4TSH8O7HJUY9EJW8iJmEKrpZhHeSW6wmABYPxTOSFrPu2F83OqcKN2
	 pMZutM6y3ELAYWwYHTv5Zi1r93MUYAACNogTL6oBF5ZiTGArLDlBmKb11tZ7d08u7Z
	 tlgIl0H9Mp1hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Reply-To: sashiko@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511162408.1180069-3-zhangyu1@linux.microsoft.com>
References: <20260511162408.1180069-3-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 21:24:31 +0000
Message-Id: <20260512212431.CB324C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing 4-byte padding in `struct hv_input_create_device_domain` re=
sulting in an unaligned ABI structure size.
- [Low] Preprocessor macros are defined inside structure definitions.
--

commit 424b106dd2a0b2fe17c666987a01e49923b0b297
Author: Wei Liu <wei.liu@kernel.org>

hyperv: Introduce new hypercall interfaces used by Hyper-V guest IOMMU

This commit introduces new hypercall interfaces to support the Hyper-V guest
IOMMU, which allows child partitions to interact with the facility for devi=
ce,
domain, and IOTLB management.

> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index b4cb2fa26e9bc..493608e791b45 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h

[ ... ]

> +struct hv_input_create_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	union hv_create_device_domain_flags create_device_domain_flags;
> +} __packed;

Should this structure include a 4-byte padding field at the end?

Since the device_domain field is 24 bytes and the create_device_domain_flags
field is 4 bytes, the structure size is exactly 28 bytes. Other hypercall
structures in this file explicitly use padding to maintain an 8-byte aligned
size.

While this might work for a single invocation, if this structure is ever us=
ed
in a rep (array) hypercall, would the 28-byte stride misalign subsequent
elements and cause the hypercall to fail?

[ ... ]

> +struct hv_output_get_iommu_capabilities {
> +	u32 size;
> +	u16 reserved;
> +	u8  max_iova_width;
> +	u8  max_pasid_width;
> +
> +#define HV_IOMMU_CAP_PRESENT (1ULL << 0)
> +#define HV_IOMMU_CAP_S2 (1ULL << 1)
> +#define HV_IOMMU_CAP_S1 (1ULL << 2)
> +#define HV_IOMMU_CAP_S1_5LVL (1ULL << 3)
> +#define HV_IOMMU_CAP_PASID (1ULL << 4)
> +#define HV_IOMMU_CAP_ATS (1ULL << 5)
> +#define HV_IOMMU_CAP_PRI (1ULL << 6)

This isn't a bug, but should these preprocessor macros be moved outside of =
the
structure definition?

Macros do not respect C scope, so placing them inside the structure definit=
ion
violates standard kernel coding style conventions and might falsely imply t=
hey
are locally scoped.

> +
> +	u64 iommu_cap;
> +	u64 pgsize_bitmap;
> +} __packed;

[ ... ]

> +struct hv_output_get_logical_device_property {
> +#define HV_DEVICE_IOMMU_ENABLED (1ULL << 0)

Similarly, could this macro be moved outside the structure definition to ad=
here
to conventional kernel styling?

> +	u64 device_iommu;
> +	u64 reserved;
> +} __packed;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511162408.1180=
069-1-zhangyu1@linux.microsoft.com?part=3D2
