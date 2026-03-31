Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8071AAE28
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918204; cv=fail; b=gTpAeTpWW+egFvE8XTBSt2NNvOKNEZmSb+3g6eq6ksRsy5tNO3tBOZu1kTvX1eHEuIuvW+54ih/B0PXyfQ7UJDriDktMKwBqKPXrZ5WbDL05XovOKsLxGyV5G9TkUDLyr+kV/U/h4Pr5jkXcCsCG+VSnDqnPddt3yozUGXrpVD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918204; c=relaxed/simple;
	bh=L9wxjJkVn9DCD3Je0oXdQaiq061HikX6e+NC7GqD39M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NceyfXILl45fgxUzaUJjK50zN9Az3NJrxUr4GNl/UV/+vHmzxKdMYGoHLziN6w5c2H6zrmjMAEOtQCSuMa5e6y24xqEGXT+Y9Ec+lgZqfumcxYZVGBqJ4E/MQ7tTNw9TjuYl+YFa8Kee8XIwknDpz4tJO/ZesBaMwQfozjqqoaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hmtSJqlW; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hmtSJqlW"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ULJkaQ3729754
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 17:50:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=G9PUQuU9Xd7OgZlLFFg33R8o/sQFjvSbJ31P2p7vH2c=; b=hmtSJqlWLivr
	FpTCzdmZ1sdgK0lw6T1On9MlFTNr/uNvKi/cXLpsRpNesknsvaBMgIL79u+XmQ4X
	OvONh8klorX+4pLd8y8kkhUDUQTnOoHsKZW+iV8xX7MGNxRD5b2L9dy2O8krlqFT
	T4CSD5bI4B7RrT4qwqBKOb4ybQ//NBf86XefGKXCzg+XsF/ie0yV8UBASZD+WhiY
	gHfb9ugRF/OC6V2rmi2H21Z8NJ7kJVUQ3wl8TD8HczsB5w6HeFYEojFVp/BfWvYQ
	hI+l07YKBq3lwSAlJXh0h1OGR0o8bpFCEz5x3yz03g+scWTCs0skkJpFTqyKTDiT
	LC6Prj3gjA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d6xq3sgfh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 17:50:01 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d7c848c866so8014987a34.0
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 17:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774918200; cv=none;
        d=google.com; s=arc-20240605;
        b=ZHGcYKjyENOGTfnT3HmfvQLg52nFaLvPljgMOvHkBYp1ZY8fYgxm9p//e8XRzYPytH
         1rgnFCoyqDnt6NN0ElFVKw/yB5uXGpGJi4e7nZeoQoot00AkeD4B/Y4XLKk2cOEG0YMG
         wsktvtdOnfeupEJz0+Uc4gL1FQBhTVKY3owLwLj3G0oq6nzsOS1JRmf2hxew8HjPhoBp
         J8MJXcG+4zfukdZz+2DKWHcJibSdb0P8SYzEILmie//ksyR9ldaxFDyubQMbPkLre8hx
         1Ehm0boDo1ueg9yK2D55nN1lR6cOB3XQpgWKiMTWED587LSL2PZDX+i7BDe2ZQyiZ+Pd
         7fMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=TOfgVd4WxlQKE+hK9yudL6ZnSayBQl5VVP5wHI64dXg=;
        fh=aElIoE42+eCD0Meo9tehe6yJ3LlShuk2iF0R8622gaM=;
        b=P3eVyzuhyE+tI22Jcr1TxjyfsrL+1LygXvhQ6iiJGAU0F38d9rMe7kcycwCyIhFK/p
         daqb+AnrtB1JhipEaooGdkQb4tqFy78oz1xFS6GiuO6lbTqHVRuQJeT7cymyM2jv7FPO
         /FOMBHoQ85ySPMr+lsu1MhiHssPKZBCZIUKvDPESDhJwZk7dU//EjcFtGknOfWZ7kLYN
         bbEZ6++qdTrV2ijblzDQkE3x0zPA5956zYSfvh8R9RaFI8hQDFBBQ6mZUIYlTydBV0Xp
         E9LKpsTKFIQkpwR9GGvcy8zq1lwV8+kMQUrk75UopaoN9pzCZdC/41pgR7MHtOMDMOoD
         Ty+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918200; x=1775523000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOfgVd4WxlQKE+hK9yudL6ZnSayBQl5VVP5wHI64dXg=;
        b=EDg4YWCe9sZOX/ocykHjLztjLiV78+ffMJm2lmCQjYtGAYAtvsIIOfO3iq1GCf4XMt
         FAowrB+vOoqmM7p2WawQmo2g6HOmqTYj9OCRu/SnX2g/GVgFCKBvzSpOuKQh/32ub0Xg
         hxueXAQ8qwVWuYHGusziNVdlZT/vmVIOhByV+YJ9BEYhxgg4qeM4X7XBkJtWTB8yZjfs
         gnC1DHZeZb8A8tYadA+gj6t1Kou63BS+vpYQ/xmT4nlBqf2C4TKbh0kJPuxCYrpa9Y/w
         e/uK9vCig4DQcpXay5KUTyXie4f/9pg7VJN3GwDLwASz8DzSZn0mIt4LNbW2fyIb7B+9
         efTg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ01kAnx81JEIzdVaCxHbRf0jj2ueSlOggdRNLxwjUzlhGdI2AZn1pLP95MkdLd55zivMbxkoo+ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/813GG3My4vmr03eyOFZaDnHgoMMnCC67OTBYx04Q/6hPXPc
	EMDszq6s0rxGY14pjKAF2JlCuxQYfG6P21CX2I270I86lRAgfMWtVVHhIMTbQ4q9BesUcuuWmcL
	hmZaVio+LEslycuAhRDO3Zv2HZ6h/5EctZIvzB/AKcGaSMYIbTy+hsv7mPU/shf/ZrCLBXDdr4j
	fiKKdlWPzXW2m1PQzuCYyMbd+VHVRqPuaITow=
X-Gm-Gg: ATEYQzyl+7RY021nzk7WyTEuO+3E8uDNgRX8nxM5Is3V6D3BBYErGZQCpFSz6dnvc5U
	JYykzTTxwXJewFSEyCuZ4NntlXGq1v4oM4V+zU72rshjhLzOgQM7Yz0eBC4bElQ6BQ3FYfCcj4H
	lYgKpue+RMa8C5Mt585nENtaVzpv923KkWAY5HleyJwwEcnXtRpCtIry9JhLdV4v19Vz8I9RFRF
	Xjgi1+crGs1zZI+q/M=
X-Received: by 2002:a05:6830:6d4f:b0:7d7:d4ee:c02d with SMTP id 46e09a7af769-7d9faebd4e9mr8218630a34.21.1774918200479;
        Mon, 30 Mar 2026 17:50:00 -0700 (PDT)
X-Received: by 2002:a05:6830:6d4f:b0:7d7:d4ee:c02d with SMTP id
 46e09a7af769-7d9faebd4e9mr8218613a34.21.1774918200006; Mon, 30 Mar 2026
 17:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324234615.3731237-1-zhipingz@meta.com> <20260324234615.3731237-2-zhipingz@meta.com>
 <04859df4-6fa4-4b2b-aef1-621f3c053c2e@huawei.com>
In-Reply-To: <04859df4-6fa4-4b2b-aef1-621f3c053c2e@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 30 Mar 2026 17:49:49 -0700
X-Gm-Features: AQROBzDnJHaZAUclxmUw4Fi3GhjHKGCAE6QyCPHZcIf2necy4jORB1gzd3l2wJA
Message-ID: <CAH3zFs2ia80jkLRTUdExd4wQM4tK_FSgGTgZumDWpL-gjoDERg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=eqzSD4pX c=1 sm=1 tr=0 ts=69cb1a39 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=o_g7sp7U41fvUp2KB-EA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAwNSBTYWx0ZWRfX1pS/+zryED+e
 7dCUlYvcjXwEz0e1YkL781b5BKxsv2T6mh0JprfTxqjZgl08kMfMxBnr662Dn/VEEGLvX/Y1Tnn
 47sRJ7ebB8vf+YZMYaCLqlJqyStvVY5I1TZAoUk8KZFY3uOe7IPDfThruxv7ufRMj0XBCVBwQgn
 xQR9NMSSjWF1xtWoH+asES9G0eYgBfJ4zjkCvby/SyAwLWtE/nNoARhTu8l4ScY2gvuG4N8jR5r
 psfAZfJhJpSUhWK/48CUtFifdprRyA5Irf7YS0zz74Fu8+xnhCSVy6h+dq9x5iY6pIav7YmgcIJ
 KayMU4/p7l4IoPdCJbdXk6OMw1EW30CRsaxQzUoCVj46sxpYgWrGWHq8rpDPy206ZL1VYSupP9p
 z+DW3pdTlDL7xAyZ6w5m0hKLJXyJgW3OtinEKOW/Wf7hd0MghpQwZCTvsKtHcUoTH0FaXenYoNM
 GMednoyoWH/6+CCxsBA==
X-Proofpoint-GUID: jGFeaAZSOwZX0uyEvHLrRUuFBD6KtANB
X-Proofpoint-ORIG-GUID: jGFeaAZSOwZX0uyEvHLrRUuFBD6KtANB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01

On Fri, Mar 27, 2026 at 7:22=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> Hi Zhiping,
>
> On 3/25/2026 7:46 AM, Zhiping Zhang wrote:
> > This patch adds a callback to get the tph info on DMA buffer exporters.
> > The tph info includes both the steering tag and the process hint (ph).
> >
> > The steering tag and ph are encoded in the flags field of
> > vfio_device_feature_dma_buf instead of adding new fields to the uapi
> > struct, to preserve ABI compatibility.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 26 ++++++++++++++++++++++++--
> >  include/linux/dma-buf.h            | 30 ++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h          |  9 +++++++--
> >  3 files changed, 61 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 478beafc6ac3..c45cb3884b85 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -17,6 +17,8 @@ struct vfio_pci_dma_buf {
> >       struct phys_vec *phys_vec;
> >       struct p2pdma_provider *provider;
> >       u32 nr_ranges;
> > +     u16 steering_tag;
> > +     u8 ph;
> >       u8 revoked : 1;
> >  };
> >
> > @@ -60,6 +62,15 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >                                      priv->size, dir);
> >  }
> >
> > +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steer=
ing_tag,
> > +                                 u8 *ph)
> > +{
> > +     struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +     *steering_tag =3D priv->steering_tag;
> > +     *ph =3D priv->ph;
>
> If the dmabuf exporter don't provide st&ph, this ops should return error

That is a good call, let me address that in the new revision.

>
> > +     return 0;
> > +}
> > +
> >  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachme=
nt,
> >                                  struct sg_table *sgt,
> >                                  enum dma_data_direction dir)
> > @@ -90,6 +101,7 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops =
=3D {
> >       .unpin =3D vfio_pci_dma_buf_unpin,
> >       .attach =3D vfio_pci_dma_buf_attach,
> >       .map_dma_buf =3D vfio_pci_dma_buf_map,
> > +     .get_tph =3D vfio_pci_dma_buf_get_tph,
> >       .unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
> >       .release =3D vfio_pci_dma_buf_release,
> >  };
> > @@ -228,7 +240,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
core_device *vdev, u32 flags,
> >       if (copy_from_user(&get_dma_buf, arg, sizeof(get_dma_buf)))
> >               return -EFAULT;
> >
> > -     if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
> > +     if (!get_dma_buf.nr_ranges ||
> > +         (get_dma_buf.flags & ~(VFIO_DMABUF_FL_TPH |
> > +                                VFIO_DMABUF_TPH_PH_MASK |
> > +                                VFIO_DMABUF_TPH_ST_MASK)))
> >               return -EINVAL;
> >
> >       /*
> > @@ -285,7 +300,14 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
core_device *vdev, u32 flags,
> >               ret =3D PTR_ERR(priv->dmabuf);
> >               goto err_dev_put;
> >       }
> > -
> > +     if (get_dma_buf.flags & VFIO_DMABUF_FL_TPH) {
> > +             priv->steering_tag =3D (get_dma_buf.flags &
> > +                                   VFIO_DMABUF_TPH_ST_MASK) >>
> > +                                  VFIO_DMABUF_TPH_ST_SHIFT;
> > +             priv->ph =3D (get_dma_buf.flags &
> > +                         VFIO_DMABUF_TPH_PH_MASK) >>
> > +                        VFIO_DMABUF_TPH_PH_SHIFT;
> > +     }
> >       /* dma_buf_put() now frees priv */
> >       INIT_LIST_HEAD(&priv->dmabufs_elm);
> >       down_write(&vdev->memory_lock);
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 133b9e637b55..26705c83ad80 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,36 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      *
> > +      * Get the TPH (TLP Processing Hints) for this DMA buffer.
> > +      *
> > +      * This callback allows DMA buffer exporters to provide TPH inclu=
ding
> > +      * both the steering tag and the process hints (ph), which can be=
 used
> > +      * to optimize peer-to-peer (P2P) memory access. The TPH info is =
typically
> > +      * used in scenarios where:
> > +      * - A PCIe device (e.g., RDMA NIC) needs to access memory on ano=
ther
> > +      *   PCIe device (e.g., GPU),
> > +      * - The system supports TPH and can use steering tags / ph to op=
timize
> > +      *   cache placement and memory access patterns,
> > +      * - The memory is exported via DMABUF for cross-device sharing.
> > +      *
> > +      * @dmabuf: [in] The DMA buffer for which to retrieve TPH
> > +      * @steering_tag: [out] Pointer to store the 16-bit TPH steering =
tag value
> > +      * @ph: [out] Pointer to store the 8-bit TPH processing-hint value
> > +      *
> > +      * Returns:
> > +      * * 0 - Success, steering tag stored in @steering_tag
> > +      * * -EOPNOTSUPP - TPH steering tags not supported for this buffer
> > +      * * -EINVAL - Invalid parameters
> > +      *
> > +      * This callback is optional. If not implemented, the buffer does=
 not
> > +      * support TPH.
>
> It seemed already impl...

Yup, it's supposed to be implemented.

>
> > +      *
> > +      */
> > +     int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph);
> > +
> >       /**
> >        * @map_dma_buf:
> >        *
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index bb7b89330d35..e2a8962641d2 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1505,8 +1505,13 @@ struct vfio_region_dma_range {
> >  struct vfio_device_feature_dma_buf {
> >       __u32   region_index;
> >       __u32   open_flags;
> > -     __u32   flags;
> > -     __u32   nr_ranges;
> > +     __u32   flags;
> > +#define VFIO_DMABUF_FL_TPH           (1U << 0) /* TPH info is present =
*/
> > +#define VFIO_DMABUF_TPH_PH_SHIFT     1         /* bits 1-2: PH (2-bit)=
 */
> > +#define VFIO_DMABUF_TPH_PH_MASK      0x6U
> > +#define VFIO_DMABUF_TPH_ST_SHIFT     16        /* bits 16-31: steering=
 tag */
> > +#define VFIO_DMABUF_TPH_ST_MASK              0xffff0000U
> > +     __u32   nr_ranges;
> >       struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
> >  };
>
> Another question:
> 1\ PCIE protocol define 8bit and 16bit ST
> 2\ In host-device ST impl, the ACPI will provide 8bit and 16bit ST, the c=
hoice of which
>    one to use depends on the minimum supported range of the device and th=
e RP.
> 3\ So in this P2P scene, although exporter (e.g. GPU) support 16bit ST, b=
ut the consumer
>    (e.g. RDMA NIC) only support 8bit this may lead to mis-match
>

Hmm, let me check how we can address this mis-match issue. One option
is to add an
additional parameter and fail the get_tph call when a mis-match is found.

> >
> > --
> > 2.52.0
> >
> >
> >
>
