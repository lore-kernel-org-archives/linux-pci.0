Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE035F165
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219282; cv=fail; b=f3VGhe3p0t7GytVmjcrFl592AZjmyht05RzOHmSLFy2mGKvnW7zUI83Pkc7Lnxgx9C/g93diiCuU/mVIcbRAafGYOHoobmMQ6KTSXAG6vJCrKN6RPGOxg7qHy8bDvtXZ13Zz7RKJQKpehc10XjllBFj5OmhkyoyjQ4UNlZoo3XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219282; c=relaxed/simple;
	bh=Xy3ScJnXdGO1uSMgz2W54lBdlaGYi8w2p6RzwRoDR08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWS9+Jm9SYg/ue1TT8qsz7Gb7d+YzvE0R6MGeQo3mzgY7klzG+Bsk78US5pmd7oKzM1IU/2gdShfqN7zVyjAG2bPCFbH0Fk631t+jt368xUW6kCXdhkm/9mB0deW9nx6YaHa7LtA1O3WvcimhzUBpkN0cEPdgZtO+vL93fpLimQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=S/OjtqUr; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="S/OjtqUr"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BEcXni1893421
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:08:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=eSd4DfDWKCJhrlk+WFf1HJuCXJjV3yJV405FpCwAOa8=; b=S/OjtqUrfaHy
	U2tzFcZ8mycupW/bmzC0ry9dC6/TLZhsjYUOLx9kRDPB0KY54IyAWb3v/8NCzgIb
	Lo7j7/o2b10gCRzYHkStHM3+46rjVxu480Rw69rpMHhOshrelnhYeaEHIAZWHY2c
	45cn3iSQuWvr09tWHy11Rg98ilzmEcTlYqqh9Q7sHC11wTUiTKCHHmUjQuUuiz+2
	BUzCK5pTcOnMAmuXtXpOjrSB6KpO6VLwRJcO/kgZ1gLYJTGY+KSd+TwJCKLMpmK8
	S3GzefST7H4aOVX962Ewe73xPQFn9Ny/oy+d2hIXiJkNWwIp7UrGbCvYz36QF7sN
	eBQXf3TFYQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe7dsa6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:07:59 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e60737a964so850997a34.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219279; cv=none;
        d=google.com; s=arc-20240605;
        b=igcbVWVOzPCgd6TmFM4vHrjHQQma8lnbcpe8LgQXulh/iTHROMk6tT4ZpF8pz1z6Pz
         3nE00JxVHALoKTTGKVttgjbvkFHoFjJfS9F7Qz7ewrcULf1YLoQ1Z82kv9ep/GhgHuCm
         g0Vd9WxtrSFi/vrBVn61Cmuj/W02mQv+X5Qt8nxfWIK7yD7c2k147MbSz2zdOfpMHIpn
         JZqksg2WWTRX7MKi6aPt3V0FY64kGiouiMO3oVmNc9oJSDnIooUPMo2eTyhFmxZKX9y1
         qqc7p6kXqO21dUHVPTxSII5FpjG/54HyivdyGadRGsSvdiUVL5K6iIDVcdyfuEFsCv/J
         QfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=jKBgDS5EhOCeCGVgkUxAvmWq6B4D8KMNSa2GuVyeKb0=;
        fh=SktteUFsvskytXKqkFDIDHosoJE7F9P243CRNnHewu0=;
        b=dM1ZWnKmpzFKrl4qaV5hmqKtnXSwVq8uJKkv6KveofiKiKLAGP7InhfLMiHy6B/HP9
         vVMN9DGayKAq4bKBRNl978cz/gAntWVFHOiVc4RjOyluSB4ANpNea0CNeUZr3b5pFWIA
         VSIflu1yMyFSAQ5hwNK3XwbwyOrsEuu5ebu6HYG+hROUHzGGvAhMtgCCm52RR9mbAwyQ
         aXfn3KMsJ9G1PKRdt0868ub+/iOfOTXH2N5vkdEu8fC2Sc22n79VC4BBGd3EO9iGhxTB
         pv0ks0CZMNm8AS8mvCf3+qGF/AB+Wx834zwtg6WCcZ4dd2sawE9DaND5sT4M82b5bdLH
         KSfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219279; x=1781824079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKBgDS5EhOCeCGVgkUxAvmWq6B4D8KMNSa2GuVyeKb0=;
        b=j3Y1SlJTq+EHDo7fcxSOau4q2SmxjxZdQjl1/2xoewu3EPPUWFs/Yi/5/ia4KQhqr/
         /Yc32L3EVYiMYmG9ffYSPnI+6SmVQ3jau8toHQh2TjSqv+6E2tDpxRdX16EqRT7xFV8V
         abopmeWVwvTNDBCLjGy9vJIGi9bKDsqYjJHv5Xrt7TT02NTgnmr8LytKDWBEq9SCAApd
         Ar4RN4ml5RCuqC4ReUuUgH+FKoi1LB48t9bjRu1dG+Egl05lm5RYsPFhs7mti2Fqt0qa
         x4frAeVvmGfs3dt45oTMgYGuYI0JwgKOclX8IrT8lrBkZuOIxt151f0YryKn+kb0UwmX
         tcFA==
X-Forwarded-Encrypted: i=1; AFNElJ/xaBh7iNw9y0nECS4exgB7VpaWpyJsJ9Qy7jVS++I+TA0D3Nr3I+1N5+XutdRX+SfkDuEfziUz3Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAC7+i9U7mE73tlJCR72RdLg/Gx19NLM/HVnlOgb/4an30nxl
	iZQrJd2pKl1zdFQeIXdAsGgfazyAbsc4+EuPa6Xev/6DX+b9Q8mioHWBvZrg3ECl9ktSKMTvmAv
	QXcitnfziUxKwf6DtTzCMEaeVN5socNb3T4NNLPIyi+PmcqoRRM/Oi+WXpc1anDS8Rpp+Ze/Mv9
	ZsWErwfFR9k6iPSRt9adTUQO/kUPquUY6Nts4=
X-Gm-Gg: Acq92OEh8fpP5qvzr1bCOGGSZbPD4IvQ4Zbf8MD+rRZnjEGTT2nQeHdlbgTSImzCg+b
	k76jRORgBKxhyqhBFrrPmIw2zYQbbXKOcwS1Q79iuZbfB82CN6ChEmYKk3M8Vg28k7FLRsqhSIS
	T9Pih2zUkjoh+Q2FRDeo5+KsOvrrz2wo3bdXwTmfg5gejzuvFV4dysXHarJid3R4z0/txrlSDlB
	SCRYwqD9jIImKtgbevX7w==
X-Received: by 2002:a05:6830:6810:b0:7db:b7ae:ef0b with SMTP id 46e09a7af769-7e7848a9e26mr96707a34.24.1781219279117;
        Thu, 11 Jun 2026 16:07:59 -0700 (PDT)
X-Received: by 2002:a05:6830:6810:b0:7db:b7ae:ef0b with SMTP id
 46e09a7af769-7e7848a9e26mr96676a34.24.1781219278679; Thu, 11 Jun 2026
 16:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-4-zhipingz@meta.com>
 <98b65e1f-1b5f-47fc-a4fb-0cdfab6725ed@amd.com>
In-Reply-To: <98b65e1f-1b5f-47fc-a4fb-0cdfab6725ed@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:07:47 -0700
X-Gm-Features: AVVi8CfN6ELCKVsJhBpTTQfWRh3GrCVI0SUXGM4wH5Fa1maXhiidrAdOyWsdUPU
Message-ID: <CAH3zFs1=CKtS524vU6f2inbX05JcyMi-5FouDxSCZAjNG0OUmQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] dma-buf: add optional get_tph() callback
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: u_XewiPzw5zJNBeO7ykTb8Rj6eEjSsnY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfXxuP/2Dbj6Da3
 MuCrRHFoPLUNKNELqF8o5iYjqZ9l4Q9IgZ9LXe9EC4Jm1XtnAih0TsngiCu/Jya/5d8+B1njla2
 6HzwzBIVhFN+M/ja6m3jBzHQmMC0SJc=
X-Authority-Analysis: v=2.4 cv=CeA4Irrl c=1 sm=1 tr=0 ts=6a2b3fd0 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=zd2uoN0lAAAA:8 a=VabnemYjAAAA:8 a=Zb6pUuT0p51Zl8jFNtYA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: u_XewiPzw5zJNBeO7ykTb8Rj6eEjSsnY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfX+fyUqn4BIZYM
 yxE6pE/JTSzqVQVp5Pfb6eYWtme0BP+tEfBctLUDhbgkKnH/46Wewf26fllh/AHOVhMOe56Zi6R
 StH087XowMULdCsMBXUeIzDxS3xi8kqBS9aILwxmidEWdhnhzCSiho1jsr1IJt02AqsJyGHiDy9
 9Uc38jUetN8rHxhZUw24VrE3peOZocQ/dIw5qW0RFoteyOs3N41j2pBeejTxsJX36QZuldncex5
 JIFLqL2zHotdpkoFEGwmvwih5iKwWRpluIelD31f+psYOUzgAdVOBByDRJcnIGdYlfCDn5Rc0KD
 rva7U5uohoFGeh/ReKddPdctLV7g7PPJL728GeHTuY1oVGcJ5vL3o94z7Is7tGZmA74fXTLN0pe
 Ncjv0F5Qv49C6kALGucPk+XG4gZNTnaVk9+WMjwMb/mArY+U//NmzUXZXXbFB2/MnXHV2CIUtgZ
 QTbawCg04zcD3V37sFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 3:35=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 6/10/26 21:31, Zhiping Zhang wrote:
> > Add an optional dma_buf_ops.get_tph callback and a dma_buf_get_tph()
> > wrapper for importers.
> >
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces, so
> > the importer requests the namespace it can emit and the exporter
> > returns the matching ST/PH tuple or -EOPNOTSUPP.
> >
> > dma_buf_get_tph() is the importer entry point. It returns -EOPNOTSUPP
> > when the exporter lacks the callback and requires dmabuf->resv to be
> > held while the callback runs.
> >
> > The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> > mlx5 as the first importer.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
> >  include/linux/dma-buf.h   | 21 +++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..aff79ea12e43 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *at=
tach)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >
> > +/**
> > + * dma_buf_get_tph - Retrieve TPH metadata from an exporter
> > + * @dmabuf: DMA buffer to query
> > + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > + * @steering_tag: returns the raw steering tag for the requested names=
pace
> > + * @ph: returns the TPH processing hint
> > + *
> > + * Wrapper for the optional &dma_buf_ops.get_tph callback.
> > + *
> > + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> > + * exporter does not implement the callback or has no metadata for the
> > + * requested namespace.
> > + */
> > +int dma_buf_get_tph(struct dma_buf *dmabuf, bool extended,
> > +                 u16 *steering_tag, u8 *ph)
>
> That name needs improvement, maybe something like dma_buf_get_pci_tph().
>
> It also needs some brief explanation what TPH is, maybe a reference to th=
e PCIe spec name etc...
>
> And document in the list of functions that this one should be called with=
 the lock held.
>
> > +{
> > +     dma_resv_assert_held(dmabuf->resv);
> > +
> > +     if (!dmabuf->ops->get_tph)
> > +             return -EOPNOTSUPP;
> > +
> > +     return dmabuf->ops->get_tph(dmabuf, extended, steering_tag, ph);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_get_tph, "DMA_BUF");
> > +
> >  /**
> >   * dma_buf_map_attachment - Returns the scatterlist table of the attac=
hment;
> >   * mapped into _device_ address space. Is a wrapper for map_dma_buf() =
of the
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..6a54e0f251a2 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,25 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > +      * @steering_tag: Returns the raw TPH steering tag for the reques=
ted
> > +      *                namespace
> > +      * @ph: Returns the TPH processing hint (2-bit value)
> > +      *
> > +      * Return TPH metadata for the namespace selected by @extended. R=
eturn
> > +      * 0 on success, or -EOPNOTSUPP if no metadata is available.
> > +      *
> > +      * This callback is optional. Importers must not call it directly;
> > +      * the dma_buf_get_tph() wrapper is the only entry point and hand=
les
> > +      * the NULL-callback case. The callback is invoked with
> > +      * &dma_buf.resv held.
>
> That most of that should be obvious, we only need that it's optional and =
that the lock should be held. Everything else can be dropped.
>
> And most of the description/documentation should be on the wrapper functi=
on, exporters who implement the callback should know what they are doing.
>
> Regards,
> Christian.
>

sure will do

Thanks,
Zhiping
