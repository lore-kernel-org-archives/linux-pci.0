Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7F83876CF
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061847; cv=pass; b=VMMunFgyLdLYwdeFNICpWUQ1ZTqk+7lbTR3JHL4HEuKS3kDY/vY7V16+3WWGlpXoZqo7xpwc2vI60+GvJ62uNfIPfAUnUBD1lNVRtXExdg6uTLHS2jFDcxFnlu1kQ0ZGdsGDO65ia+2CBy2rICEJRC9g23RCu76nSW/VmMDnTK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061847; c=relaxed/simple;
	bh=dSdsH9dksi+uHV/fTw6nPqI8igLABzvcuyiyNSlvbvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvkoqIKa0cGhFU2HZFPlssauwdXSyEvYVpH4aFglg5ySnxusZfk5WbjSslAW73kF//tlvzXoMo8HuQ3cGszBLaES/chD04mlHN/U4Mev8Sk/Qwg5oRwfPuNybhgDMayUIXA7bzEFVhjMkv7BbIG3adq4LPlCV0Ag8KzchXfUscE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C0z5ENmq; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C0z5ENmq"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rj121145990
	for <linux-pci@vger.kernel.org>; Thu, 2 Jul 2026 23:57:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=1ooYXEhr8R5Avu36PkA1
	fDBaUkP8RkT4tBNox1TcVoA=; b=C0z5ENmqDzbJ1NLEJsUJo9CQ3N/uTO7VUwp4
	kfTj0sxCwlKtZcFAbfH5EzA4i/QyE7hzmnXKp60uoJGQ6MOgjGVYxymZs1LzEGgR
	KK/MabO62rFu7yFaRhdUXbWVs6RszHi4Llfrvj+O2Ur3DURJFa0bbiYbtGGtmf1S
	48+CP9y9ZSyGN4WLNaqbVQgnwIsdkrlxGhdYdoaiAHm7xF2MwkQzJeva9fd6d3Yw
	oQ3EMU2riwO6WaSrWDjGw+BApAFcAp1tWa/vlThjMXh9zmTVaUOIm+H2kTLvSMGL
	86M/qI56en4xsmMLOVp5WIYEay69OIWSI0Mz0mScKxmp2zYwIw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f65au0t4a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 23:57:24 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9e54e9cf5so349427a34.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 23:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783061843; cv=none;
        d=google.com; s=arc-20260327;
        b=XMbYaMmazFp3nHNsUuh0XStKLa9MwDc5Bi/hri5X6Rmm2TxSn8v++6/qdk+gx9+Kcn
         n6qUVLqnt0k5amPlrMhFlEULC1kQCZT7YKwppOQI6xs3X7VYJUwnWK8cTGA7lEq9WDyA
         42XRVkN/MDzEQ2eESxLu07HQIlE3WfFMY1rct6KIWhuiIUyMFmooNRQDGOkne8b9+GfB
         E07jHUm06LVXreBlCanUbCf7uYPrCCaN96Q/5SMKdaH9qTyMc/73HWo5AAG8NNevVG6q
         ODn1UxyH4X/gaALFI7BjMUWELPcddd1ovTxyvwhOJIDh8qKxos3SHgbRZlKuZ4yvwnB6
         Tb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=1ooYXEhr8R5Avu36PkA1fDBaUkP8RkT4tBNox1TcVoA=;
        fh=Vl4aQ2uignfiimEjmtJlXrKkUuU1hNCoo1w1h6FYuuc=;
        b=Wim+jqFliXJRRwGx95XhNAgIVHJzVhnAXj9kXQ0sonye5lVff4qEytgssW3G5kwzjL
         TI26qjW/Mdm9t9YM5A7INNoEmkl3iijhk40BH+i1JTjTBaHs7jZ8arBSiEDeG+RXjujs
         LUh6k527Z9ZcXZa3lpo/qIsCiyBPHQL+MYTCMVVOaEE8TzrYotG+lC9nva/sqehKp/aB
         uIsAQwJ1Xue+WPlPRgYLyFMYnos08DqeQBimyN5qUnqDm6z8pjBfN0dxDG9rOSO/x210
         D7rmBykhtMlUJ7VmAnbeD2WfWkCz7ru0XMAtKH8v29h81ljOkjAo70Zl1s3wne5slx4K
         GQQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783061843; x=1783666643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ooYXEhr8R5Avu36PkA1fDBaUkP8RkT4tBNox1TcVoA=;
        b=RJCl87TDuxfiiY/HNU8a0rOtiIWqC2ooy7QTxc/F6cQGcvOJsEDnwUqmo3186LaA6f
         fDpqzIlfXAheujU1CDtzS5iq5R8CBI3CDDRyH947bOexhBZt6MeMIB06QHSRnl8ubM4W
         XRSUMAe83fjr2yq6QGtg+1WLIqRw4R4NWFOucBIerWlmSu8jCqExDtBciEO+9mb8iZtJ
         JSKDskwBm6yySXUShqPJjCIr7mwYgt4i+kIL3VDYmKh+/13gIQXLaSp2XZc0Sx0PuOKT
         pQmqnixauuK2roCerrjIc2BOaBh6IuT3BaSHL9dapgmU4s03TSFdqEND2eNeDpaZ+V/u
         CZsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9e+qziQjvTOkzt6tC2x/N1Y3M+2ROZCnVPVDipjlyQvfY6imAhPBaOg9+WCjFBqNOvG0kaJvGkbqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOGsrV44IsAQqiTAHdggQ2HwGh2uBWtZE64VX4fqVFGEYZJGad
	W9Mi2K1SWASeW9TS5xxa16wSF1nspxEduQR/sQB6dOVyQ8lsYbBRlwo/l+UvsiDIyakywQuV6JR
	x+dOEu101m8tOpKWZBdovkqV87opokQEWsByvf/Aa9Q/YnHAIe2uubuifDh79ta4wPQMSz+Xezd
	fjrb5YO1/TRmZ3UENwATCobXqDqUp7f5LwvDA=
X-Gm-Gg: AfdE7cmOTMK+vlb3ZjybdMtQGkbNfxk8xOSMtkb8qi9GYhiIRA5gYcVeERtsGSozOEH
	PiCg40sAGAxtybqBTFaLzm2Mfngycc+Y/1k1aQLYFlSKfHFeoszXDj/EHJAwHLr6S7TnHMZYBlH
	Ystjq60mDHY4n/tLKRBxPJ9/vxIs3ODtMqQ5/HOuEF8CMjN71MCGG6d9g8xhxOkHSx+NBgNESyn
	DAIw8HdgU4yyKwR/2yt1ZGJ4XcO1Q==
X-Received: by 2002:a05:6830:82c8:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7eb4cc26248mr5970995a34.17.1783061843372;
        Thu, 02 Jul 2026 23:57:23 -0700 (PDT)
X-Received: by 2002:a05:6830:82c8:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7eb4cc26248mr5970963a34.17.1783061842839; Thu, 02 Jul 2026
 23:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702181025.2694961-1-zhipingz@meta.com> <20260702181025.2694961-4-zhipingz@meta.com>
 <6ab4c781-2409-4015-aac1-01d5cc1b9f6f@huawei.com>
In-Reply-To: <6ab4c781-2409-4015-aac1-01d5cc1b9f6f@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 2 Jul 2026 23:57:10 -0700
X-Gm-Features: AVVi8Ccw8yAXcsgDvWHGsVO2xij76p-6UW92x4FC6KeN1aOXDWOhO-jLzIpoK30
Message-ID: <CAH3zFs31yd9uyo3waOT=SxCGaKGBfxdAv2XDQ+9dQyuo-cCV3g@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2NCBTYWx0ZWRfX2rXTpB2zg712
 gZKGIJ9I3jeFLS45blax+RyRSANrgrUQL/9GunN/vD7DhzvT2usMueQQNQSC45fW9m+1ixckMlI
 T2u7wxBqNxDDYmM0j/sQLqzeRCPpT/qyONteW4tUa49VF5KFvHTysfK8qlt4zzHrI5PQ/IMGPGX
 e3ozYPt5EUSiPM3Qxhb2/Bcycj2LtlKSm7/Xbujq/gX3P+jewWqxfLQoflEWy0iNjdD/aGlkqDj
 iFXw8mv3+HLYeWtEw36Av/Jm5xhwdB3gSaWNMBsjF6jy/4/j5EligpI9sVF7aPTa32g1FqMtfMZ
 QB1AiH/B1jRjdGvCDwfIU19fWTj81H52BDFHTeiS9g1dfBYrmNzeG64e9kj3Vi1iPcEiKq20heT
 6XIvPgZr/xe9vyL8xeSLl3fqWSx8w/JRlUWTlEDZ1Wvu8S9la/ggfW9tJ3FUWxt2odGq3oJ72KT
 pxBOijgb4ORs6WA5yxg==
X-Authority-Analysis: v=2.4 cv=Y8bIdBeN c=1 sm=1 tr=0 ts=6a475d54 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=wlcL9-RM8ybxaKpgEcQA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: QPIA2eUz9IYU5v1K16b8V-s0M58kfkgW
X-Proofpoint-GUID: QPIA2eUz9IYU5v1K16b8V-s0M58kfkgW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2NCBTYWx0ZWRfX2/StPT8Ipab8
 XJhm5mq1lC2ldrHhqJ6mWG8QcGYmAtjIs9r8P/2JsOnCxvLYbnBmOEu7EafeOaDZgKCfbSadSol
 jpI4LOjfUb0aWr2V7ujd1gl/Y/GSci0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01

...
> > The attach path reads @revoked without holding memory_lock. Annotate it
> > with READ_ONCE() to document this intentional lockless access: the read
> > is a benign early-out, and a racing revocation is re-checked under
> > dmabuf->resv in vfio_pci_dma_buf_map() before any mapping is handed out.
>
> I believe this modification (@revoked) might be related to resetting the
> bit field segment and subsequently identifying a concurrency issue. It is
> recommended to submit this as an independent commit.
>

Thanks, I think the @revoked part is still closely related here. The lockless
attach-path read existed before this patch; this only annotates it
with READ_ONCE().
The bitfield-to-bool change is needed because READ_ONCE() cannot be used on a
bitfield. The real check remains the dmabuf->resv recheck in
vfio_pci_dma_buf_map(),
so I'd prefer to keep it in this patch.

...
> > +
> > +     /*
> > +      * Updates protected by dmabuf->resv, @revoked additionally
> > +      * protected by memory_lock.
> > +      */
> > +     u16 tph_st_ext;
> > +     u8 tph_st;
>
> how about: u16 tph_xst;
>            u16 tph_st;
>

I'd prefer to keep tph_st/tph_st_ext if that works for you. They map directly to
ST and Extended ST, and non-Extended ST is 8-bit, so u8 tph_st reflects the
actual width.

> > +     bool revoked;
>
> why not move revoked before or after tph fields if it don't take one bit field?
>

I kept @revoked there because the comment documents the locking for these
dma-buf state fields: TPH under dmabuf->resv, and @revoked under dmabuf->resv
plus memory_lock.

> > +     u8 tph_st_valid:1;
> > +     u8 tph_st_ext_valid:1;
>
> how about: u8 tph_xst_valid
>

I'd prefer tph_st_ext_valid since it matches VFIO_DMA_BUF_TPH_ST_EXT and the
"Extended ST" wording used in the documentation.

> > +     u8 tph_ph:2;
> >  };
>
> ...
>
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > +
> > +#define VFIO_DMA_BUF_TPH_ST          (1 << 0)
> > +#define VFIO_DMA_BUF_TPH_ST_EXT              (1 << 1)
> > +
> > +struct vfio_device_feature_dma_buf_tph {
> > +     __s32   dmabuf_fd;
> > +     __u32   flags;
> > +     __u16   steering_tag_ext;
> > +     __u8    steering_tag;
>
> how about:
>         __u16 xst;
>         __u8 st;
> and it corresponding to VFIO_DMA_BUF_TPH_ST/ST_EXT
>
> Thanks
>

If that's OK, I'd prefer steering_tag/steering_tag_ext in the uAPI. They
match the PCIe "Steering Tag" term and seem clearer for userspace than
st/xst.

Thanks a lot!
Zhiping
