Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F4377019;
	Tue, 14 Jul 2026 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026805; cv=none; b=LqvfYjs80hcWURXDsATYg9PkJX2bdNY4x6AKzAU8bnkKHpkB/2QooyTJJeS4s/yZ9DOjv8eE5IcFUanoS+RWrIcFSTpMMHbSbPRUOX8jS6cdeqvT3uz32ELO3G/UOJ09AL8tVqhIxX7qfdRfghj55yJhPdkh630q/6GjN18W0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026805; c=relaxed/simple;
	bh=lroHN1SJR2LcM9tZuA8waXaeMuinCQQiTzOkNTfaQuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QoVjB4iX8tiDxuA9UO+sdRf71BSoEVHIuU27NKwyDyuSGHM+rr2q7aVpOfxXIIHyUbbg0RfsrMr85EJrC1ARDYkc/Fxgwg+0lqUafJcBrLSnaMbgSd/P+tYu2TS/0krwuL7okRut4vS3W+E8C9Wezz9wiiFbAddFTEzBUcIGH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ0M1osz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ0M1osz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF911F000E9;
	Tue, 14 Jul 2026 11:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784026803;
	bh=Y6TH0nvaNNbWuWCAbzmCNP0FkANzCFBtJGMAGfPyIuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZ0M1osz2MknbFhIHuG6vFVR9lVSvMLTsgC0fYG3H2MwOeJwtVfvdm/gJY5F7SLMB
	 BI9X1SYJO7RlvPf3s5A/ipFp2OSUp5y0JnLmiNXaVLyPVrDkCPtXJ6iX2Eeiue62qQ
	 oW5xXhl2FELqLs1FHlwLkyhcCwjdyOvfzFfzMGGzb5jJReS+iIPF54ckiBN8DD85+y
	 X3cZSlk06NABf8xq3lzwXRjhQiNxJZEkaH4HYe0ZkGd5fWI7PmHBa1JmwwgcCPuaAm
	 rsltZCJRSmRpcTSAaHCCSC/KRpYaFdyEsYRn0s9j8p5g2Ig5SmrIjoaHLSPL+QDHUk
	 ofDuht2o6ViJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 08/16] PCI/TPH: Refactor pcie_tph_get_cpu_st & add
 requester variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260714104325.54444-9-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-9-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:00:02 +0000
Message-Id: <20260714110003.3CF911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing length check for ACPI buffer in tph_invoke_dsm() leads to =
a heap out-of-bounds read.
--

--- Patch [8]: [PATCH v20 08/16] PCI/TPH: Refactor pcie_tph_get_cpu_st & ad=
d requester variant ---
commit a4213c1c2a9777e1dab404b096c528682a773636
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Refactor pcie_tph_get_cpu_st & add requester variant

This commit refactors pcie_tph_get_cpu_st() into a compatibility wrapper
and introduces pcie_tph_get_cpu_st_ext() to allow explicit TPH requester
type selection. It also adds validation for the requester type against
hardware negotiated capabilities.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

> @@ -313,17 +319,38 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum =
tph_mem_type mem_type,
>  		return -EINVAL;
>  	}
> =20
> -	*tag =3D tph_extract_tag(mem_type, pdev->tph_req_type, &info);
> +	*tag =3D tph_extract_tag(mem_type, req_type, &info);

[Severity: High]
This is a pre-existing issue, but while reviewing this code I noticed a
potential out-of-bounds read in tph_invoke_dsm() when it populates the
info union.

When tph_invoke_dsm() evaluates the ACPI _DSM method, it verifies the return
type is a buffer, but it doesn't verify the buffer length before casting the
pointer to a 64-bit integer and dereferencing it:

drivers/pci/tph.c:tph_invoke_dsm() {
    ...
    if (out_obj->type !=3D ACPI_TYPE_BUFFER) {
        ACPI_FREE(out_obj);
        return AE_ERROR;
    }

    st_out->value =3D *((u64 *)(out_obj->buffer.pointer));
    ...
}

Could this cause a heap out-of-bounds read if buggy ACPI firmware provides a
buffer that is smaller than 8 bytes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D8
