Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F92E1F06
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015962; cv=pass; b=DQXgQ6pJb4C+0XnMU/B6IHXo4sNBtysS4iNyi26Tp4KDPbOPrC7w+7/7+5iW9px8SCsw4xtKch4R0M26NRTWNTyPvl1nRzf0Irnsg77H6wrd5NfRDCVIlOW5u575t0RFOrk3Sy4LLioKTqBcgvIYeEtxHYG8uwI/skinKl5/AWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015962; c=relaxed/simple;
	bh=FbYR/k8DLxlAf8kVof4hhiKT8ECF5Pd8+LC9O69NXFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSk/iYnYne1FRHchD+y5dVSGBEymKdsB3eCDvVxfp49BU7vzy6/bW5Es+BncZN8qrewXbazYNw/iCsF+NvfcmbsZlti1+SYfD7B3oJTOLhZtiCBq3YKTSYAhW1nzu533mBZtmyyn/Q+c71Ey/fxIbEnqBWdvds8wwRnjbvSQoqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bofmRsKL; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bofmRsKL"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658LRs1f2355535
	for <linux-pci@vger.kernel.org>; Tue, 9 Jun 2026 07:39:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=kNeH4tXtKNJiFBFWJPRK
	N1EPfU64g+YPkV/H/UdFhBs=; b=bofmRsKLK4osQcAFWiwXbtpr69w36y9aEPuV
	DGBeGSJClR6Iux5v8lxlgpMiVzO5x2Rc7XvV3WDDGERk1A0vudeYRpxUQTgVJ8FP
	Vp24tp6sGkRRtgnEWh5ISlm3X8w10Fv5cHFadx3zazkv3Puh6lk2WAALivP4RcaP
	osrasMZGfR98HjII9TAhAiRWO3neAxrV6MDSF+gSO8eKfKkKXqCwiEoRahlhPycg
	4+6EMm9OA50YdVt23PeVBTNs8CTpAfdAPGVGJTNzDE3Lz+aVd4fRXAzpSV2n29Ro
	DBqbIiI7haSoaEF0q5UsONLcNWq3+7vIqLg83UvH33HJ3kZ2gw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4en7jsvy28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 07:39:20 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6db540d17so10434492a34.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 07:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015960; cv=none;
        d=google.com; s=arc-20240605;
        b=dpjcYV8rv1NlXzaIWdRvXLdOFCO1rIw3POL70nNJfJO3P2EThLdPwJqnNwWpbZnVOW
         j/KkY4GGOZdGld3Fqm8FxtXWly7hEVpoIpFJSwW5c6SVuuX3PDu82Zkjpa7E9UUTfb6F
         Nhy5+oYal4D7OVIjG8es65bl57x9ntic89qBnootdZihFMVKunAe9GTYVKcuoNuJVCqb
         9vzedRRiqbNkIB7BszZX72RFod8MqZH4Tr0pDUdCoXAEDhhxVlQ5lvahwav/tVyUQX4x
         TO14u4ELjm8BPHiKWO1mvlzylE/HkPARk/Kn3A/rMaoh3MiUvOb4rP1iqa7JM4DStZH7
         zeaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=kNeH4tXtKNJiFBFWJPRKN1EPfU64g+YPkV/H/UdFhBs=;
        fh=qX8bA3SFtFQCr2DiS4dGXaSxlQmPDlzV1O3yVoPazZ4=;
        b=N3bgyZg/40HibJKkgb9UCTgI0sFP1FvHSF5Q3ScytyJ5V/LxEMqg1URCC4hAbUE345
         Oz5H/qm1bwdecZ+tvmo5WgIAStVSn6lWa6VFm97opV2lXH01c8E/v85tJAc9HR2hysKl
         EBjTDxWFTZbIs0KtgrJMyTjr+IX4WnDjGa5ISI/iM1DNthqPu7f3k1CqGeyhXT/cv7mc
         Vin+A3l8qnLEDqoVHyaM3DFfRryO4+ZlBo3gXOwGnkxpdA76tWXf+kL6prI/uiUt5L2U
         hqeQ19OhacZurDv1xQWB7+/x3yHW0hBBp5cxNPsLghBWAhzoLSxRKzJagjZpQTmFGI6f
         DVWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015960; x=1781620760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNeH4tXtKNJiFBFWJPRKN1EPfU64g+YPkV/H/UdFhBs=;
        b=XQOitzAi0ydlKyld0X0uF4hL28iw17uTjNINgssyqp73bafJQzg/tHBbWjKEH1nw1O
         XNP+UzJS0aKs673fD9KDjWIfwstNj8X6Bhyw+eBrdts0qK7expYyEPgJ3KYN1+DD8T/n
         Nv2C2UpYiXxVI619YFnqdAN4nv2+GZwYfrE0ULAIth34ICkJtxO1I+CcmF6igeVViACA
         0evPtNoC6GbsIVBgVIfn4knmiTtcQ5716BRYFiKfYD97WJuM1TRxRQsPe5ZN0xUGN5cl
         +VbBKU40+vOC8taFETBerKKpaQyRH8Jg4MA111y+qVOA/PHMdo8bAftHj7XfKB+aTcuS
         JTjw==
X-Forwarded-Encrypted: i=1; AFNElJ8/1F4Y5bKaoQCiODe3JSyU2zuvFb583KCY8mLuRsAVnAZLI+kzWZQxlmSpQrt1IMus29HtTE2F8+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6vXR0av/+eGeY6/GFhWm/JN2YG9GsTLnuvk3cgToK4gaRBfWw
	PNmXsFTaTm4mBh3i6QD3JB5p2Z7zmYZmVaRGurjEWl2kkV+OWcGgN5m/b0XnoygSUqR9rcaGqn5
	xD+gCBM18JqI6s8dzeCJY/BvEz95uNcT5Zxvd27zX0OG1m0Kp9bEi+BExwHllGIYMb7TKuQsmZN
	IjKhYGzY6k0llisjzok0yYjYgDHMvYQQe7qgI=
X-Gm-Gg: Acq92OGGyREHEMSbZGY4khrIgpakF18U7LWV67lwFSH/gRjxqoI5D2d7nNPW+R5y0W7
	4mQIZ1p33Nb6vONt5JANKTAKBTbxOCoEyOQT8zJG5sIKCJfBHK0T+OlCs5TCSysXIUgrrwuFMoU
	JeaSzs0T5eV5JTKjg3vtpnZaqeg5Nx9VaBeIMvgzge6omhmXrTX9Zd7+D6iF9rUDAAhXyCU5HYg
	V//8koFO//G5H29N8nDjimAbzqc9/a0DE/NARW61Mvnca5nLGs=
X-Received: by 2002:a05:6830:67f8:b0:7e6:ed97:ce6e with SMTP id 46e09a7af769-7e70ca3ef99mr13168177a34.19.1781015959836;
        Tue, 09 Jun 2026 07:39:19 -0700 (PDT)
X-Received: by 2002:a05:6830:67f8:b0:7e6:ed97:ce6e with SMTP id
 46e09a7af769-7e70ca3ef99mr13168142a34.19.1781015959353; Tue, 09 Jun 2026
 07:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com> <20260608185646.4085127-5-zhipingz@meta.com>
 <fdf1bb37-7158-46a0-b6a2-6cca0ac7ae20@amd.com>
In-Reply-To: <fdf1bb37-7158-46a0-b6a2-6cca0ac7ae20@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 07:39:08 -0700
X-Gm-Features: AVVi8CcZCg6NF1_DYHadZzneoVcOoxTF9hqIosFI2rLUJBAF8tno0qEb8k4EdV4
Message-ID: <CAH3zFs2FtVN9LZw487ei6cs3AMwh-30jRHenn3X87PAkZ8CmRA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0MCBTYWx0ZWRfXyUtK1lBHoHXm
 cjdxoqAuW7ihe29I3ylqvCinhWG2xDSGcqe6Foprdu/Mel4DppkUbRx7frSzWPOTz0OS01qlqm3
 rot7Gzkx1ZIXGyrW9R2LqlN2lTORWOGwZqqlajCr9HDKWNrZlre7Tg1fVRXNTog+DcON3EB6kCq
 TVsGPHrIY/LjAxRpWmMFaIgVcEmO8fCCIqUtabWkOie/57frOIDy9IvuUomwaJAeCi2niCykpMn
 SOWBxCFUAm0GToR6ZnWS9AqyzHnHhJxW6X9o7eVpcxiJjuBW10L8kh+6JeJq7ljZXWGU1lO2MmQ
 dpHMllWhaOfHm4o4YHlFTFh4OB9QkZlQBKJPVXarrEp34HBb0pWbiNaKA6GKx+h5i11fatQec3D
 EYDOFQept+bL6vsTzoIfbHv86R4U1kp+yZNU5sVfW7U5CtfPxZhCd29Wn4nM9ypElp29iHbM3kt
 Yw3T+r1Kg42XbX2NGmQ==
X-Authority-Analysis: v=2.4 cv=Fso1OWrq c=1 sm=1 tr=0 ts=6a282598 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=zMbl56DWmGmIhi6d5aIA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: 2hrcnwuQtm4oZxD8JMtQvQvjedT2bK7_
X-Proofpoint-ORIG-GUID: 2hrcnwuQtm4oZxD8JMtQvQvjedT2bK7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01

> >  drivers/vfio/pci/vfio_pci_core.c   |  3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 92 +++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
> >  include/uapi/linux/vfio.h          | 45 +++++++++++++++
> >  4 files changed, 151 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 050e7542952e..4fa36f2f7555 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 1a177ce7de54..dd11a7db6b41 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -2,7 +2,9 @@
> >  /* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES.
> >   */
> >  #include <linux/dma-buf-mapping.h>
> > +#include <linux/mutex.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pci-tph.h>
> >  #include <linux/dma-resv.h>
> >
> >  #include "vfio_pci_priv.h"
> > @@ -19,7 +21,14 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
>
> > +     /* @tph_lock serializes TPH SET vs get_tph on the TPH fields below. */
> > +     struct mutex tph_lock;
>
> Clear NO-GO.
>
> When that info is exposed through DMA-buf it must be protected by the DMA-buf resv lock.
>
> Christian.
>

Understood, will fix in next revision.

Thanks,
Zhiping
