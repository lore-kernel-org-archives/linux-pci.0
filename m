Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA53D9025
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455980; cv=pass; b=Ckd+25Taof1AAY7BNcI3pjuPTLZi5BMDDDqnoB04Zy41yM78vmof+7fhga91JfMZ0o5Ei63+BEYjsS0FTH9hR2WDKjMbcu1GVh96VBLb6uR/lLvRHHiRBqtgR7tpIcHOBbp5vzEP8k3JWK72fD69Eg7o1RPkB56wV3QmaVR7WMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455980; c=relaxed/simple;
	bh=LWd+W6kZABm6SWTt6QoGalimxlkWEoirJAHN9Ibwb+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLtID+tni77FDBzYV14nr7Xt50xZYcPvENHYrMNps3ZGoYkI1G6kipgaaX8/ucApGuAwXTRA0ezR9Y4ifRbqpH5dn756CCj4aZ6aB6/YDV/E2q6cA0MTv/oxv1lzju4amgiAAZPrZ7g3t68+NKKZ6gaR+fLqnftUwjZsvdbQXEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jWhIvPAu; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jWhIvPAu"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNXCfG3682071
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 16:59:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=aFHuyGsjsa956iCoWQLUmEvVwVe7uwZZhrewi
	8w6Mn8=; b=jWhIvPAuqvVFcHLbLiDbK0cVadXlVv/ohNS/DhYlJ6mYaT12UCVXw
	oexjZjyFAFDA+f8DiWclsfHu9FcMCzk7vjsWjW5YuOeRuj9sA7pLqrwfdmGPohry
	x2PKA/CrzkufCYEL44vzw6Y1hX41H/YxuBbzEyqWVQJXdfoRsBSfffyA+9oNObz6
	lSvgRWC3B+K5RTWefpMGGtGiiXQMIcvkmdyWQ51cxZ1PQqW6Rjtn9Jvrv2p56ytc
	tSf/PSQqoyW9mEa5jqrnn71vTb9+ty4tHPOe8lll5PY9TFUAcCr6MMXW3ykyk8Xa
	5JaXB36DeNKn/+GQM6TgJuy9ATY596evg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fqrk1hquu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 16:59:36 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7eb60cfd476so295961a34.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 16:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785455976; cv=none;
        d=google.com; s=arc-20260327;
        b=alGmulPQqOV22Kz/CnCVR+NpjfpDak1VD1zryobTHZTpVyIz0ZxST9ONvaWb7LBSP7
         VZwf+XFTt5PI15BJqjZBS9bbhY4QYeHSXSGADCAyJXtN+ubVUtGrSLO6lF81mBqBK8S4
         tmnE7wg8nVxoVXwg8gjQa1hsDog7KhsaASckkzYx81Y5I7eeGJ2T1Nr3KlzsMGFP4DSq
         hgDdiqPWw5jDKpd7ZdlP8l0C1grVWOaNdOssRN7I6hW19WSxJRObR7Pz90LKxF4G2Ny5
         Zzd+dWeUOU2JJaxrKoWv96dfo6PgiW+2LZebXh47Dcd4H7UUV6rOWsD6B5RsLsUWL/7J
         NugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=aFHuyGsjsa956iCoWQLUmEvVwVe7uwZZhrewi8w6Mn8=;
        fh=EYECvpLaRccwzgq/0tqrP/PJTwB5dA6wtXJyFPmAJ9k=;
        b=HLOOcwGN7TEHUYFclzj9Nv/INzwEDkmT5NgBqYwtmhzZcrheBQZpY3NCTPM5nk8b6L
         F3et4Ra9m9j+Y0buph0nD4He9wnga8QJjB1cXyfedMSBn/dutYKVNI1iclW4OCoP21hz
         3Z68GxqM2ldc9d8Lwh/NIlnMdn3JIoKrcuOhbf5EF20Vi44R7YBTkXcli9RxY57NJg3o
         3Sy8/S1tggwFfTH5wnEZat1i9+aJEG1heuLHBHPjsOWEJTmsHvTPqUWzSe1XN1gVtKEF
         x8aKyW7YkElrW91Ws1ExDH5HizSnriDbH7lHQPeR1DnPC3E2ettHt65+Y+C47A6O/sWH
         SZ3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455976; x=1786060776;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFHuyGsjsa956iCoWQLUmEvVwVe7uwZZhrewi8w6Mn8=;
        b=HQYVS70X6vw5mXajanLMT0GPf+NSQRODdzCxOkLSjUwMQQjI1SqEvzGYdN9eNpP4ip
         fP+ee4+sa5L+aryKG5PMaZ4ajyQOfRd5FDOCYInY6DdLQHfMV2dLL3xYnfqC+Qhq0ocA
         XAEGJS4JMeaCw72c2sCUQHWBtFdy1SgDtSRpdlDdlIlyTbMpdw/upizGa2yYujwGGpBc
         EBLkfar9Sjvo0e099mJRnnmahD/1N1bKxcO1qA5UUjqrmwmZ/EL+RLd/JHdLRBkSi28e
         IQfQtXrhJ2LyKOu/Tt9PjT9rIJ4AyoojCIdt0ivMCVFwdQnQkedPCWYO8EZsawaRSGyb
         dgJA==
X-Forwarded-Encrypted: i=1; AHgh+RqCh2H+WbUlEla+o8DeUey/CpOy7YtexPdo4M0nZslEfT8GYrCdHw8f4D7J4uAZ8F7Lh+dmTuCZmXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3k2ER7e9Eew8sBk9y9+aqLOPC7PXFBB0OzbwXf0HylB4MVdu
	g92ErhKvgKtjDG99DmL1hGe9W/+KUmc/pAQZz59ACQP+5L06A+R3SBmLgAiTyrv6iWDZ31jivKV
	TS8F92XpTT+CkV/R5yo4vuTf2Id+ekvg/Uz5ndHDHFDV5/EhIrRSFXWsw61vO+XWetHAf83JOfW
	iBjkDptyI0Yd2QcoEOUL4Pt6uV9itco8f0V0w=
X-Gm-Gg: AR+sD137SO4ZwBHkUv6Kvs+nFHvHB6vjyANwbI5WyGxdHgWfGZXpp1NNZ1GZFWftUOM
	IuG6joXqEiJEjVFs63RCA5Ueljom0SZedin0KsvFAWZGPRL1eqJNcK98R9OA5btIY9tNPLDIYSb
	TFYcVM4fWkR3WugzbgmFBuC0D1HlaWJIldtQQKcQI8gK9cCbXv3ED94uKB86BsrgEreXF8y+v8
X-Received: by 2002:a05:6830:82ce:b0:7d7:fbe2:9725 with SMTP id 46e09a7af769-7f02becc0aamr3745870a34.5.1785455976212;
        Thu, 30 Jul 2026 16:59:36 -0700 (PDT)
X-Received: by 2002:a05:6830:82ce:b0:7d7:fbe2:9725 with SMTP id
 46e09a7af769-7f02becc0aamr3745791a34.5.1785455974484; Thu, 30 Jul 2026
 16:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715204008.3911275-1-zhipingz@meta.com> <20260729170350.1a1c2229@shazbot.org>
In-Reply-To: <20260729170350.1a1c2229@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 30 Jul 2026 16:59:23 -0700
X-Gm-Features: AUfX_mx-hlfiuAI4ouKh3POt6LNkchZ4_m4FnV7O04E1uYsL5TQ-m_yA6NY7xNk
Message-ID: <CAH3zFs0pnmy=q1-jwsE69Wam1TNszKyBg-U219Sjt_syQ1JruQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=JKQLdcKb c=1 sm=1 tr=0 ts=6a6be568 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8 a=JJdtByxIUwxPJm2e3F4A:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: W40wfGTBpC6Wy_NWFXTUEDtOnQXCBMZ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE2OSBTYWx0ZWRfX4zgbcYOrLzRp
 /gXbRzaHDmDL3z68l63V0cdi5c7emU8WvMkZGOHKMlkGxPu1jk6x+KM6HyhI7vHMVAqfDuLYWRZ
 /tY2+dXbXg6cLrdQqCAAFUv5uHw38D+RK74xxu+SCW82wpmJJ7sZvPhpufP7Ql3Z8+PWmM6CezG
 BHber19q4QLwF07HB0RpAot3VWTqhkf54h9onX0F92XC5k/Mw+tHKioZMTVOi9OaEP61UIklzTQ
 JiQ1XdcDq+TvoieiT1Eh5bzhAY8QyH+639OK+cvCI7RnzPjeBIpq8iCr0jmyxHz7vis3Nxj7pbv
 QZbd0y6j58ystH6wjaEuuxDS15vTgSH9viWobGf0fZzhaFnU8tEfL9WfzchG/IsDB46AoNkTyVO
 AlDJaSaPpX+R/G0UNte1yhkmn7bnODQUKlTXkZPGMKcAZKZw8jCbr3KK1MzKg+qg8xkbSKtCTuv
 CKL1aqMHKNAWj9f4n4Q==
X-Proofpoint-ORIG-GUID: W40wfGTBpC6Wy_NWFXTUEDtOnQXCBMZ9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE2OSBTYWx0ZWRfX1wNYRYoKupFR
 wjZZmmOTNI+ozieNiBa+au4a28yf5uXtySwmrkp0T2PvIRPgjkxtWsJ5CjIMhSJ8UJF/W3I1SQ9
 GPB7mLByWBCIQ9lNdbIuWmP29grq+8o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01

On Wed, Jul 29, 2026 at 4:03=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
...
> On Wed, 15 Jul 2026 13:39:55 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
> >
> > Depends on (submitted separately):
> >   net/mlx5: free mlx5_st_idx_data on final dealloc
> >     https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhiping=
z@meta.com
> >   PCI/TPH: fold reserved completer encoding in get_rp_completer_type()
> >     https://lore.kernel.org/linux-pci/20260715202409.3767494-1-zhipingz=
@meta.com
>
> Sashiko failed to apply[1], it can't handle such dependencies.  The
> first dependency already exists in linux-next, I applied the latter
> manually, therefore the patch indexes in the below local sashiko run
> results are off by one.  This used Claude Opus 4.8 rather than the
> standard Gemini 3.1 Pro Preview used in the on-list reviews, other LLMs
> may find more or less.
>

Thanks for applying it by hand and running this locally.  Both
findings are real and v13 will fix them.

> We should probably reevaluate the best merge path for these, it doesn't
> make a lot of sense to me to have one patch routed through Bjorn's tree
> for a self-contained fix where no known hardware makes use of the
> reserved encoding, then depend on that change in the first patch of
> this series.  We need Bjorn's ack here anyway, the Fixes: tag is
> academic in current code.  Suggest adding that patch into this series
> on the re-spin and prodding required subsystem maintainers for review.
>

Agreed, and I've said the same on the PCI thread
[https://lore.kernel.org/linux-pci/20260720172304.117134-1-zhipingz@meta.co=
m].

...
> [Severity: Low]
> Should the PROBE path here also require that the device can actually
> export a vfio dma-buf?
>

> The only gate before vfio_check_feature() is the completer-type check:
>
>         comp =3D pcie_tph_completer_type(vdev->pdev);
>         if (comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_NONE)
>                 return -EOPNOTSUPP;
>
> vfio_check_feature() returns 0 for a PROBE request, so on a device that
> reports TPH Completer support in Device Capabilities 2 but whose pci_ops
> has no get_dmabuf_phys, a VFIO_DEVICE_FEATURE_PROBE for
> VFIO_DEVICE_FEATURE_DMA_BUF_TPH reports success even though no vfio
> dma-buf can ever be created to carry the TPH metadata. Every real SET
> would then fail later, either at dma_buf_get() or at the
> dmabuf->ops !=3D &vfio_pci_dmabuf_ops ownership check.
>
> The sibling base feature vfio_pci_core_feature_dma_buf() opens with:
>
>         if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
>                 return -EOPNOTSUPP;
>
> so its PROBE reports unsupported when no dma-buf can be created.
>
> The commit message says PROBE was made to "follow the same hardware gate
> so the feature only probes as supported when the device can really
> consume it." Would adding the same get_dmabuf_phys check make PROBE
> consistent with vfio_pci_core_feature_dma_buf() and match that stated
> intent?
>

For this VFIO PROBE issue, yes, I agree this should use the same
dma-buf export capability gate as VFIO_DEVICE_FEATURE_DMA_BUF. TPH
metadata is only useful for a vfio-pci dma-buf, so PROBE should not
report support on a device that cannot create one. I will add:

        if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
                return -EOPNOTSUPP;

before the completer-type check in vfio_pci_core_feature_dma_buf_tph().

> --- Patch [5]: RDMA/mlx5: get tph for p2p access when registering dma-buf=
 mr ---
> commit e612584ae6697d1ebf77baf0fb1487a41e4c6511
> Author: Zhiping Zhang <zhipingz@meta.com>
>
...
> [Severity: Low]
> This refactor moves the if (!st) return -EOPNOTSUPP; short-circuit into
> mlx5_st_alloc_index_by_tag(), so the remaining mlx5_st_alloc_index() now
> calls pcie_tph_get_cpu_st() before that guard is reached.
>
> Before this patch mlx5_st_alloc_index() checked !st first and returned
> -EOPNOTSUPP without ever calling pcie_tph_get_cpu_st().  Now the order is
> reversed:
>
> mlx5_st_alloc_index()
>     pcie_tph_get_cpu_st(dev->pdev, ...)   /* runs first */
>     mlx5_st_alloc_index_by_tag()
>         if (!st) return -EOPNOTSUPP;      /* guard now lives here */
>
> For a device where dev->st is NULL (TPH not supported, e.g.
> !MLX5_CAP_GEN(mkey_pcie_tph), no pdev->tph_cap, or a failed mlx5_st_creat=
e()),
> the DMAH-with-CPU-id path mlx5_ib_alloc_dmah() -> mlx5_st_alloc_index() n=
ow
> reaches pcie_tph_get_cpu_st(), which performs an ACPI _DSM invocation
> (acpi_get_cpu_uid() + pcie_find_root_port() + tph_invoke_dsm()) that was
> previously skipped entirely.
>
> Is this added firmware query on a device that does not support ST intende=
d?
>
> There is also an errno change: when the _DSM lookup itself fails,
> mlx5_st_alloc_index() now returns pcie_tph_get_cpu_st()'s error (e.g.
> -ENODEV or -EINVAL) to userspace instead of the prior -EOPNOTSUPP.  When =
the
> lookup succeeds the by_tag re-check still returns -EOPNOTSUPP, so the two
> differ only on the sub-path where the _DSM fails.
>
> Would it be worth restoring the !st early-out in mlx5_st_alloc_index() be=
fore
> the pcie_tph_get_cpu_st() call, or noting this behavioral change in the
> commit message, which currently presents the change only as extracting
> mlx5_st_alloc_index_by_tag()?

Agreed. The added _DSM query on the !dev->st path was not intended;
that function should preserve the old early -EOPNOTSUPP behavior
before calling pcie_tph_get_cpu_st(). I will restore the !dev->st
early-out in mlx5_st_alloc_index(), while keeping the guard in
mlx5_st_alloc_index_by_tag() for the dma-buf-provided tag path.

I will include these fixes in the next respin, including the folding
patch as patch 1 in the set.

Thanks,
Zhiping
