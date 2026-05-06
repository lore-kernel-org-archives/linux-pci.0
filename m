Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D83848C8C7
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091814; cv=fail; b=XAABlWETdDyzm1K4FteP39IanbZLTvVX2wBdrRd1AidjBUT3otzAEEMqgpNXtephCjhqo18q9AuJ4t9LEaOLUpcCbukOt3YlBLJG6fmBVgNjlGACd+fJMW08kYd+I6nzMbBQeK/wId3GX68lSGKYexPYWoo9/6yiFvdt+OE221o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091814; c=relaxed/simple;
	bh=bW6VioqM1I6vjQsLLVeVP3XOu1uhGTd03bArfH78eFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGjncXD/Ubuubgv9OXC60UzuKC9c8zKdtZMcTxv2q5rPOSNiT+iqdSRvo0dM6GHLpsWByFjYBzg+ckjX/n8klewhgPhOojLx7kVtXAgGX3+Oe7axm9grn7UdsrVaHuraXcdi59gOzeHlgSACUI4diYf68IVGL9F8e4P/b8fvmIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ecrKNO8M; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ecrKNO8M"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64663qOM2795101
	for <linux-pci@vger.kernel.org>; Wed, 6 May 2026 11:23:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=2YYLKXiToPfzzk84iAjnpM/kE1au7fYknVhGTQOnVXE=; b=ecrKNO8MJk5q
	oKIjdTP3cT9AdMHpRtYIW89FhY5abcRsfaMChsqaI29WSGcVqrxmCW6KF0syyjsU
	vXI+L5TDYQh9jgaGGd8jj0BHllL5waomMFt0M0n9CBCiB1dPI9YoWYdjX9Ms3CAr
	/SAHXyeletOuK9p8msNRfKXlukH2yHk5gRcTM18srPB6KJhdvGbk2B06ATSaEUy0
	GNA4BpGfx4il8hopju1ylXLm53Xe1Jd0huucKOv9aqixb3LuPoCYJS2o5kzLnMkP
	tS+7rw11iVZoYfP9udWgz/AiMp9YnhOy+Cp1r+syjSjMfpGJEU/w5r3R/fpUCjql
	KHoh0wEEWw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dxtp2a25a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 11:23:31 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dcde7bf859so122100a34.0
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 11:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778091811; cv=none;
        d=google.com; s=arc-20240605;
        b=AzYN5HmPY8QziTobIclwQhbXfUdZ0buHKpd6iyuXV80lBuFbdWpW9QqASH6yO0WeiX
         PWHPmTrqFZsum1sc/az6WSP+VVs7MhPa+65Rp6OuqwM1ZtUzeOT9kfJJuJ9sxbPuKjpH
         R6jcTNKVe/hZWrp+FYnS14I183thlkIW9kYzyCtC2m1XPJXeYJPNB0F+SMyJHV6pgCsG
         IEy65MRJkVYXZ8xlDUPwiwVNhs0VdyA6Cj4b2hWJLoXfwT4VcYQvEJuxLhVKsxr+F02C
         ApP/CowuRwzDYzaI16dQ4M4KYoaMZiLv/qwAsa+jyPq0KX6NCIBDmRn3k6Kc7wp+jwt5
         mxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=06MsYmJiQI0tIH7Lw/430OArMXdAJd2jDLxFSIS0mBU=;
        fh=Of0GpIUCUxTFWY1gBKZGWDY5cg4YQgfRNw8iml6yVlQ=;
        b=KIVxFtWs8WtvL5I2C3O/eZcTMPN34aOd/gZ2peQtCUGULkUVMOzTdWwzkIptz0P/Op
         mk+ZWQZRUQ2fkjLK10WYBEu+EB0WL8LOECYsG++LeTi8k3xO5N+JuhO9ktD6uPJ1yGm3
         PZnNgyX0THeCenxQB580OgDIrWh4X/gLfk4O0yGkx0ocmsB/eWqWrVdZTJJvNfLmZeLl
         XE1SRSYNS7Xn5R5no0KqIyDvntaonCULTKmBceLQjPl4EneAk4lnI9t7Fj/zG+3nPR6S
         b5eEJuC4LqqB3heSsMmYykVPnjWnIsHii1G70Wr8rbiJoxB8uSjmmKEl1plRPN8PLdV7
         7aXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091811; x=1778696611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=06MsYmJiQI0tIH7Lw/430OArMXdAJd2jDLxFSIS0mBU=;
        b=nKKsIzCySnTn3LQfZDEZq8H3zLd8VvdiHkx2ACbAbR3n7737/nQyr161W/z3o/clTo
         FooVVRIoFTw2fwC8MnyjKWjE7DzWNkdZN+iDWY78IFhXLAQfKoGhTCdLwdl+yatmHeZL
         7/0WmI36uRtF1lmoS6t+gsfwfHwFNrPenGnQI9QjfCBGOt4Q3JT3FIzRKQWIVAHIa0lG
         H7KXLkVCYRzf+uy+JBTWSXLZpfirveCTWT4dN/Y4qQfMTW1Zk0O5yqkJ+YjEopXakAC4
         Yfc9MYxFojwfR9oQWV+zoEwzStgEgQbWceFxbuHVpwC06hJFOyRM7RuW2bHliTiC3WoZ
         ZCZg==
X-Forwarded-Encrypted: i=1; AFNElJ/AfF0X6l36YO3QABaae+pXTjXFIzYCuTFLhtgxb4flieCwrCrqfqfDxS3PqixubdsteWQnD3G64qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxriHt1I7FDMyC9EyNFBwnKD1hX71c89p5cQ7Ct/ATmA0rv+dfj
	XFw/vFHPc5S8yw7HRw3P5H+JsvbSzYdKrsmOrO6PrjEhxlmt1xCG57rVICbtrzxxbpp8wlcGP2i
	zonEonI+c3WpGxhaOYfhvD4sBKCWxHE7tOymbYBcYr6wyDw63WrwrLHk7PWMhRw77FtyCA1OS8T
	o/ZC+XxYJNP7tC+t+PhZSE2I94QfvOKJm0zLU=
X-Gm-Gg: AeBDiesz3XPmys1XMXO8Cdq+yTCrqTtMPZaASAnGvh5StBVwp5Qu6PTuuNMTq41sDAK
	ZB9nJ+ReTH934nTH8nAB0qlouEZQQG0WV9DvL1yC6Vq3CGClKtBgBOizEX04E63x/pJTkuDPYd/
	+six6Bw8u7SaftQwP/X4q4Jts3bboOimhTIC24Kg076RGa4IXJvU8sCg4jZ0jvKhqPitl3nBjeC
	qqKcRLY0nh+Y1di4+aptrkW0R4+whsLMomS7ZK/R78=
X-Received: by 2002:a05:6830:4986:b0:7dc:e032:9b5f with SMTP id 46e09a7af769-7e1df220611mr2715785a34.25.1778091811279;
        Wed, 06 May 2026 11:23:31 -0700 (PDT)
X-Received: by 2002:a05:6830:4986:b0:7dc:e032:9b5f with SMTP id
 46e09a7af769-7e1df220611mr2715758a34.25.1778091810773; Wed, 06 May 2026
 11:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com> <20260430200704.352228-2-zhipingz@meta.com>
 <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com>
In-Reply-To: <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 6 May 2026 11:23:19 -0700
X-Gm-Features: AVHnY4Lr6ainK1nflhUwWMi2SscR_b7hHjj8HpGh-ezHilmWJEso71FyiVM42gA
Message-ID: <CAH3zFs2x2QebpqDC0qwQg_GP2FVs-qqNxPupck40cEHNrBMEsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Kbx7VgdJ7MuuV6MLYiMaBHtm8d4jUf_B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4MCBTYWx0ZWRfX6ZJThH+uRn+z
 gkS9N61HFIrYFEbPG7WAgXl2+xW6g1+aaDb5oE+UDZApcEQd/0bkZg3hHvwhbnkUDBun8+PqqHa
 2+3EGpKorzkzhgjV9ScdXpPd0i2IuqJr3cKsZ/dioAJdMzjOt75Rug0LXqgQlajNMLfr/CGs4qJ
 1VqIomtjXB2qayAh+Q+AHwLm6o+jaH6ME1IM8Zyxm6HYB8ZT4RN9lZKn9XV2ciJTNjg52hS0G8z
 jmdqEVVjtULZ75quuvDcOoStAbrB5spN108IVpfMbpOAc8RveeuZvhCyqq+BefafBsSGlrVnXv1
 7V6udQQAxY8YxKh0NNW3MfrBBG8XmQxAJIGP2FTH2BRTl4fFHtDQcBFUxpYuAbuImJ4h3DxnRB0
 ZdUM9FGeT1oNsjl+VefCNoj4kI7VVEP2oUjhOi0f/eRmNtnS6NVLv1R50xslILZlDxMxkycyu5w
 wqBT7A9PDityy8as2pg==
X-Authority-Analysis: v=2.4 cv=SsmgLvO0 c=1 sm=1 tr=0 ts=69fb8723 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=jjQCJkVV9gP_kkOIbcAA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: Kbx7VgdJ7MuuV6MLYiMaBHtm8d4jUf_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01

On Tue, May 5, 2026 at 11:58=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/1/2026 4:06 AM, Zhiping Zhang wrote:
> > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > so peer devices can reuse the steering tag and processing hint
> > associated with a VFIO-exported buffer.
> >
> > Add a new VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
> > VFIO_DEVICE_FEATURE_DMA_BUF along with a steering tag and processing
> > hint, validates the fd is a vfio-exported dma-buf belonging to this
> > device, and stores the TPH values under memory_lock. This keeps the
> > existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI completely unchanged.
> >
> > The user sequences setting TPH on the dma-buf before the importer
> > consumes it.
> >
> > Add an st_width parameter to get_tph() so the exporter can reject
> > steering tags that exceed the consumer's supported width (8 vs 16 bit).
> > When no TPH metadata was supplied, get_tph() returns -EOPNOTSUPP.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
e *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -19,6 +19,9 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > +     u16 steering_tag;
> > +     u8 ph;
> > +     u8 tph_present : 1;
> >       u8 revoked : 1;
> >  };
> >
> > @@ -69,6 +72,22 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >       return ret;
> >  }
> >
> > +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steer=
ing_tag,
> > +                                 u8 *ph, u8 st_width)
> > +{
> > +     struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +
> > +     if (!priv->tph_present)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (st_width < 16 && priv->steering_tag > ((1U << st_width) - 1))
> > +             return -EINVAL;
>
> The checker will failed in following cases:
> 1. If the exporter passed 8bit st, and importer support 16bit st, then it=
 will pass
>    the checker.
> 2. The exporter enabled 16bit st and its st is < 256 (note: the pcie prot=
ocol doesn't
>    restrict 16bit-st must >=3D256), and importer only support 8bit st, th=
en it will also
>    pass the checker
>
> Suggest userspace passing both st(8bit) and extend-st(16bit), and importe=
r chose the
> right one.
>

 Agreed =E2=80=94 8-bit ST and 16-bit Extended ST are distinct namespaces
(firmware returns
them as separate fields with separate validity bits), so a numeric
range check is insufficient.
For v3 I'll change the uAPI to carry both, gated by a flags field:

  #define VFIO_DMA_BUF_TPH_ST (1 << 0)  /* steering_tag valid */
  #define VFIO_DMA_BUF_TPH_ST_EXT (1 << 1)  /* steering_tag_ext valid
*/
  struct vfio_device_feature_dma_buf_tph {
      __s32 dmabuf_fd;
      __u32 flags;
      __u16 steering_tag;       /* 8-bit ST */
      __u16 steering_tag_ext;   /* 16-bit Extended ST */
      __u8  ph;
      __u8  reserved[3];
  };

get_tph() then picks the field matching the importer's st_width and
returns -EOPNOTSUPP
if that one isn't valid.

Thanks,
Zhiping
