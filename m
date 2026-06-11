Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53172BDC2A
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218960; cv=fail; b=NzAB5lDNM8UieyN3tZdxMgvR5FIOpp2B9pNAt1iN496w3SdRO4dgKtdyE1Aaky8a0fzn7RNGTIvX2wt/bHfJxdioNuwcJ1F05QwixRTCSjTxX6BpiBn5bDvhHQ/uD/W1toH1alz7pQvq67QbA3OVc3UOiZkOUs1SalR8vStsKIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218960; c=relaxed/simple;
	bh=KmwjCJkcGhr9SpyfvITozRaH7etw0dkoyx0aMoQc8E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+9On4AIn7Ic1sXXvf/co5Vd51qFRadJnnGvBev4sck97vwPnTWhuQr98zDtAypiRXXkO0NdPonwg6bsQHIeCUGYBcosII5lbsMjuqdXzN9ScDalfiF2hPoxkBuuV6dZ8eYas9WcFi1lGyKCWulXKS5yX17lRr/4njnS70tklrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=md1FMUhb; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="md1FMUhb"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65BE9Jnh3822302
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:02:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ob92Tq2R57wAiMWenfqpV0H25NaZcFwlwctuc69C3Js=; b=md1FMUhbMLo8
	Fh894GG//O50My3HeLIl+N1moRtgU28J41XgC7IeNjtkXzdqb3Q4pJbloUb0sI57
	9jVz7NnQpwJ5bDPV4npoEbwYzhg4rgAl9HiKES6OFpGviFE4XpNWf6+El9J9dJ7B
	Yo/EOv0vO3lg0CKH0IeKIWviH2o6Ji1sS4icJbrVsodYNItHLNAjRW6ZraJMViyk
	n/FyvaceZSOsCn5SwSysZB4DgzxdCuNLNoHpkBe5q1vDh++JPpSH4eLPJhsKjRSE
	bq0UWdRUpM7b1KbePNQSfzI9YgeqCUP1xW5dgvSck3N00OzgCLYF3SsitjHsc7bI
	ag85db8yRw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by m0089730.ppops.net (PPS) with ESMTPS id 4eqe7xhd35-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:02:37 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e74781faaaso842274a34.2
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218957; cv=none;
        d=google.com; s=arc-20240605;
        b=h3DMQWs2AcnLi+jv50ty2Ax7pt6+2rNgeprHplfQLpF5Yopp4PCoxBbXQdMSeauJ21
         BOkmh+VanOepxVGJFFOWrOOqXENuydToI8Ei/pRtiTt3DemvUyP7cAQJd7ollTj2BEYh
         sp4HcoiBhymcFpv9vMQ2R5ZmDM+Mp5DehEqY3VOEUEx4FKm4DQXQbiuQBIRUG8bmNUI4
         SnJ8JuVhGwV2vClK7/7H/mr5uTB2rptG9UGutqU7n6J+sUWQp9g4bpUPn66tEvPGc/+n
         O2mPvc7+Qe//spd+typHXgksSWRz7gSG3EmZ+SxCYEH6ewsNERoSSPfJx06rj3YFAUgY
         H3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=WY5Yrlv2Sc7Wnv9jSySuWH/Jl8+9GO4Ig0Gi7133UjE=;
        fh=sImXpcRDPx5U58yDC/2Ri7tG8zC0m2k+SZgE0QR0TMU=;
        b=Xd/plK7DcQPLlzv0DA259EfY/spSmbZAw03k4XrLQX/rOg9cnXIHrP3rCew49sYoYx
         sJOaLwjP1vCbcT5omCkoHFn2BUp+/jfP+V9up/jeuSoYz7m1pPvn4YEaUcexxnLVZ3o3
         8uAoe6/gsei2baZyk+0qvH6x27Znt2ap3ybC/8m/RV5MbxEd1BWK7VPvkMB2Tom4o0eK
         F/X/CwHF1UjmlufawWBBIzjnkzP4Eda7LzIjvad7/O/uVOaud6a2U9jWJ2vK11sRwchj
         nnN8mFWpjU88gv8+3gA51AybBAr8NKvq2PQoDG5KVxw+FNgWtfiXfpg1D+SFsimVPDVW
         /f1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781218957; x=1781823757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WY5Yrlv2Sc7Wnv9jSySuWH/Jl8+9GO4Ig0Gi7133UjE=;
        b=b924EId+isgdM5kfBNVhgjxEWX7ILFL70bG4/jKMb5qi9eCMxFaX872D/478+USGTi
         ifd36oWgm/MkAmiTPzuAojmlr6aug4WEWInbCrp0FSsZP1s3z5ApFEoerzW909/DcUci
         SupNNfnfnlXAWnytLutJI0DPH3HZTn30oqOBtGzbq4CF0ociM+eU62P1fOHmR+5ohpH7
         cBK5VMIQt9nn30XvADKOhVW06cFSJWvAR41GW35CA1kf7OOweolHcrcS5eAYNgtkkIhT
         jaxaInPIM6sBOT7aIq2UfVdRTAZOid6PMsGATxkF8XM9Yvteju/O9rOhmoOm8GNJYbR4
         RS0A==
X-Gm-Message-State: AOJu0YzHouZ8lRbACQ9AKUqEYD7tg9kkTPN13it4LhfhKCYvP1dsHRzL
	PWBc97yF9HpgkireU6keaJ7Rd2Jh2dL8ZRJcGFTLDhY5aNfNFqFSrKJ5Csps3AjX/COk5x/ilZu
	ZyS2GSxP4mUHnVVw4ZwvdHF/EUBQRm9Ofn9ANUIR9hIA6hK0AU7Ingo0BtIdPv3Yl6V7+ziQ+P7
	Bpd6rPPa6osoG3F1fmRzeQcTH3clxGkBVvFvo=
X-Gm-Gg: Acq92OHg2G6JH1LhtsAUKFIC0U5siPgWdPjQNwLbtWehhWOYZnC2atg4Kx2QM+LnMGK
	LZvWcXPxonV3M+aP+ZXr/AHlv4xcuzlzgAUWD2G8u1qsJKyzZYYUekFrUqwdFTPPx9+PhLPRci/
	kNOOqJGEAdq27Ps80RBUi/m9afCYiGuueENwsfF2SV53fcHmm8qinzLf73xYQy4AphT+ey8/b+a
	6SyLfr5OPssa8qme4hKvg==
X-Received: by 2002:a05:6830:4411:b0:7dc:cd0b:58bc with SMTP id 46e09a7af769-7e78473e9a9mr114906a34.7.1781218957180;
        Thu, 11 Jun 2026 16:02:37 -0700 (PDT)
X-Received: by 2002:a05:6830:4411:b0:7dc:cd0b:58bc with SMTP id
 46e09a7af769-7e78473e9a9mr114839a34.7.1781218956672; Thu, 11 Jun 2026
 16:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-5-zhipingz@meta.com> <20260611202555.B0FE31F000E9@smtp.kernel.org>
In-Reply-To: <20260611202555.B0FE31F000E9@smtp.kernel.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:02:25 -0700
X-Gm-Features: AVVi8CelQJPHsRb_TsddVOxCGdtZJzAKJ67zmwHKr7MIkmqZ8rgse99DfYGSmhU
Message-ID: <CAH3zFs3FjiCfOceVRin0ytKNdZ7Pgyv4ds=Dd_GhrRC_XcbNOg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfX9OGB6X1SrQc0
 V2WuNHroU/rRjIREMuBlndnpfRcH72052E8UD3fk8YUUcYybLNux96P4Z6uErYAxvCcXUXBrcp/
 9w5sSBpBsKdhKu+sZl8TL3ZjaJ7geHY=
X-Proofpoint-GUID: os0-2TEEIFVN_Pz_3UjjxB4iD78sQVRZ
X-Proofpoint-ORIG-GUID: os0-2TEEIFVN_Pz_3UjjxB4iD78sQVRZ
X-Authority-Analysis: v=2.4 cv=Zagt8MVA c=1 sm=1 tr=0 ts=6a2b3e8d cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=vvh9Qk1aVFpNxidmG9UA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfXykevy26vYNSE
 cyd49jMdW6X+zvS/M6o5JRB1GHONiXzpEd8a+ZSLuhRF7K5g3TlSDFil/xFUqLGCulvQArsMHnq
 9jRozsZs2rQRzxw9YrTdxT8dWtc0GM+n4I1RByIu5eiQxeTsR3x8CTLQQPlCqTLeldNPzMlhgnF
 heKsJfq6k4LoNiWyJ1cnAgY2bp6SF1GVeDaj/RG9fJ2q9uIvgi5zMP7CWCZSEKDgD3WsQWO4o2H
 eWfHT0j8ow/2oxs3m6yEyOLhJ/M/ShMyIjEV7Fy7TVdEON2zexAbQ4OwdjLNzq92GtiZlqoAntV
 GcBo9SU8Th4heX2UuGWQgWu67XVVXgiJbnSoucAJvceL07bUVXb3i2+/SE6XD43d9aUJ0tDOLPL
 VNdj/Lxw9hD/hzxtcd4gTjJk2qR5Mz8lf31EUmPqg+ZeMALmlM5r+Bp4/QEE79Nlczp9KaPVg0b
 Hww74oB12T64snGjQnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 1:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> >
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Unconditional validation of the flag-gated 'ph' parameter can =
lead to spurious -EINVAL errors, breaking the syscall trust boundary.
> - [Medium] VFIO_DEVICE_FEATURE_PROBE falsely reports that VFIO_DEVICE_FEA=
TURE_DMA_BUF_TPH is supported even if the hardware lacks TPH support.
> --
>
> commit d57637d667ca6dc95def77a0a5bd339d62d4f506
> Author: Zhiping Zhang <zhipingz@meta.com>
>
> vfio/pci: implement get_tph and DMA_BUF_TPH feature
>
> This commit implements dma-buf get_tph for vfio-pci exported dma-bufs and
> adds the VFIO_DEVICE_FEATURE_DMA_BUF_TPH feature. This allows userspace to
> publish TPH metadata for a VFIO-owned device. It checks completer support
> and protects the metadata under dmabuf->resv.
>
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 1a177ce7de546..0a0705c8dbea6 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>
> [ ... ]
>
> > @@ -333,6 +360,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
core_device *vdev, u32 flags,
> >       return ret;
> >  }
> >
> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vde=
v,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_=
tph __user *arg,
> > +                                   size_t argsz)
> > +{
> > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > +     struct vfio_pci_dma_buf *priv;
> > +     struct dma_buf *dmabuf;
> > +     u8 comp;
> > +     int ret;
> > +
> > +     ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> > +                              sizeof(set_tph));
> > +     if (ret !=3D 1)
> > +             return ret;
>
> [Severity: Medium]
> vfio_check_feature() returns 0 for VFIO_DEVICE_FEATURE_PROBE, causing an
> early return of success.
>
> Should the hardware capability check (pcie_tph_completer_type) occur befo=
re
> checking the feature flags, to avoid falsely reporting that the feature is
> supported on devices that lack TPH?
>

Will fix it with a change like below:
 -     if (ret !=3D 1)
+     if (ret !=3D 1) {
+             if (ret =3D=3D 0 &&
+                 pcie_tph_completer_type(vdev->pdev) =3D=3D
+                     PCI_EXP_DEVCAP2_TPH_COMP_NONE)
+                     return -EOPNOTSUPP;
                return ret;
+     }

> > +
> > +     if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +             return -EFAULT;
> > +
> > +     if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_E=
XT))
> > +             return -EINVAL;
> > +
> > +     if (set_tph.ph & ~0x3)
> > +             return -EINVAL;
>
> [Severity: Medium]
> When userspace clears the TPH metadata by passing flags =3D=3D 0, is it r=
equired
> to zero-fill the unused ph field?
>

Not an issue.
