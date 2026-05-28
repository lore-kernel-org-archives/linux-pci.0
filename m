Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634E2F8E87
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947711; cv=fail; b=Pm4XfrlFeduLKAXX0CHcJbAbaAmjlpYgL8ohWPWurHXeI1Xhe3/lsgpODtWlY0ZRtadL8aSjGj9zm+9GLFALuLDTnkWx8x0FuD6UdiVwAw+uQ7cFZNpgB4VsTzOW3DtDtAQLCVFQHjS/dQkQ9xdqrEh4Rj8yBiDcZGF8A5weBsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947711; c=relaxed/simple;
	bh=5iwsiCJ1qeiS0l/pE9qpH/G/kMlLOpTQJgijlOnz9I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFf+6Qm7QvFJzpUmRGRyIYJEMnwoPytcbFunR4Y2D8lfqQne0YtCco+JJEBZBr6wwaTsOr4EvmWg4cUw7FnzuHaSB/CkhPgCEl3b91wkb9ygf0TunKQl7WBdOY/6N8gzwjfXHKXqiXpNn+qyaCS6JRJ3rlK9rLfCwx9j5esaRZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tbSbpLMQ; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tbSbpLMQ"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64RKjE6n1173073
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 22:55:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fCWJk+yJSEw0QmMgTgm6c5hQ8WDFshVgdpTjabTs05U=; b=tbSbpLMQe9V1
	fRrJsZLmCEINOnKwTwP24JHLpfkIKwEepx/Dh3tfucJeXjyBmxUl4K+3pzS40lhe
	Vk0KGeyW3V3XwtowE8EShojrRZa6LzLLYzZHk0cQiurg9iLcff5bt/+GGIVjUhJg
	GS2yjzLlbBm1Fz4V9mfBh9ZrCRYNbh87Q2e58QbU0kZl0LslSz8HIGX1FN2WqmJn
	V6u86OtEtfnMzSmkk0ZLjfBzjM5sNOAWRA7g+AaUWdIpOcgd0eCkAao9PZ/W168l
	EQ62MMb9iFTIqzogr6WSS9W4iYEsdvQL/qDgcEewoSbDNuHTRvFxM9ZwvkmAy0OU
	GhfeODKKwA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by m0089730.ppops.net (PPS) with ESMTPS id 4ee7x62ekh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 22:55:07 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e3a223b936so26998381a34.3
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 22:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779947707; cv=none;
        d=google.com; s=arc-20240605;
        b=hfHBj6eUezsCZYSk7L0BLkwQU2pKTnE0Th44W8qSkM0YlkwKjfGElkSXLK+M5Ulmi7
         Xwz2dpbHfsa8rI/1skjaHjbXIv2gaWSSwXxSER1M76eLur8fG+a6Yb5RJgxG0a2uP02n
         w5Xfc+PUOTP1fpg+Jv//5fTWzdoRfQrml83dnsgXgL35c9It6tXITke+iRw6eVdBdN7J
         FMDSyOoprwy94l/jHw/N9nPHrfAi5RirBy7FpxJtqtDobjWtJzCbjh4f9S8HpV4/Cjr0
         bz0KkPkTbqV5kc3CAx6vypxoBIOwJuQtguzl1iKl1LONqzffZXE5MeWMSUcl/4WrnobX
         4Wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=7OjunUEtjbIoqlgaeDvI71z7AvyuDzMU0DogPcHFH+E=;
        fh=OX1Sp915O0ouiJWHVyOi95QuvqqZ52O7sa7hb/8Q/Gk=;
        b=i0m1u5rB3knHeJY3nxN462jqVaHhROlIA/9mh2XhI/B93R4fVAkl4cLfjnqJ8aJN6J
         fXFxyS/4eLuwg6lFGryle5YwQHbu7jbrfa98XqYR54gCiX4ZFM2mJw+VWDVAsnXbt0FA
         F4mESSHtOTFMmztOIYE5jpMb6GP8P3/tNqbQlA2U+Jc297s1kq0MB3Hh2/W4N1RGO9Is
         XYqayRoU8yWO2DMjDquXoI9Z00TqlU608dZ1e0yKmNTBcuVpmUdd5DFQC05mVJdnEQE7
         lJTfDHRYNu4t1AJ9Jc/Q888VcrmHVRjxKAxihIbxw/FcZ9r/M6VvCLX1L8kS+jTxqJeI
         /FFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779947707; x=1780552507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OjunUEtjbIoqlgaeDvI71z7AvyuDzMU0DogPcHFH+E=;
        b=nkg22R3OdNwxqzU4kVjK24Y1EQw0S9dRflJRG73j3U02PEd9s/zjquQqLh8ZdHoOYK
         +IX4W8/NtqF/c0gQUvmETLDMj3hBKQuhAl+zQcC4E+6eo/4rchefFrJrd6requAG1Fvq
         pn/HJiOZXHPNpfWQ5Jpr+dAzix4SksZ4FulhRiSrpO8yEjOaFH54TSQUA+MZw1xHTpKb
         a+K9zO6z3dEc5cXGI+CIaX2jzLpU3TmPAVXIQv9H2CGzp5uxeqaDtNZWOJ8CvHNwzF3f
         x1BOJgy3GS5BqSzCOanaMXeHBh6qM7tTGLqUocf8T/YrUCamGkcnNKeUSPxLkvJNOqIF
         fhGg==
X-Forwarded-Encrypted: i=1; AFNElJ+XktmiXe/GPUqBiIcAKKZUo4l8z8Oyze1u8ICJeluJUsxAIHL0ZTm2HLvfEKw/bXqllTnTZNQWfj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcD9pgXB03ctSYhsqfnhRkWEN4SHtFyH1WMWEJ+ymGjPWzBz8D
	B0I1mlwIZUMdIUpXHx/PCJ464Y8kmvs/jS/bx93+7K+K2p2T/0btwAwm6ex2snhqURYJRFSLvYY
	2KZv/nHBCQnB2EkMHJuOwcQ0ghTMVwgk1dmROZlGGypMF8zJGSMQIpIOzjxpq9sAYvR86LU2Bzb
	lOP9XZSDQH9hKLRtNbLa3kr5nu9xrTN3DkBsY=
X-Gm-Gg: Acq92OFPetTLd5GVADQW6Fwp+MLgtVw5az7H8ib9wEqDzh/rcPs2ZNO1icsjZlP1f2+
	8tihkILDNQuk5g9371Qf0WyITevs/7vu6Jbh0smQngkecp6PeVT4l1sEClvPEe6dJ8vjTbo53MA
	C4OmDIQoxynpsVDkIulhoXr9AY/HtnIm4Fn0DYUJIWKi6r86v9MjZhkQMJpeZv62G53N70YIJ4y
	nfilIR1TtBo063vft04SCB6RLgg55O/etx2mmIB/c55E10wer4=
X-Received: by 2002:a05:6830:6d4d:b0:7d7:f158:1f44 with SMTP id 46e09a7af769-7e5feef5d68mr16377927a34.21.1779947706898;
        Wed, 27 May 2026 22:55:06 -0700 (PDT)
X-Received: by 2002:a05:6830:6d4d:b0:7d7:f158:1f44 with SMTP id
 46e09a7af769-7e5feef5d68mr16377893a34.21.1779947706138; Wed, 27 May 2026
 22:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <20260526144401.1485788-5-zhipingz@meta.com>
 <20260527130045.704a4502@shazbot.org>
In-Reply-To: <20260527130045.704a4502@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 22:54:54 -0700
X-Gm-Features: AVHnY4ICjE7MkEm4LXONvDpsmeBdG0UBYV3y_krDxSXZVAQVCJMknB8fJo9QBXs
Message-ID: <CAH3zFs2RuXC06tkg2gBNMLfBuL4FXzu+AV_axEh+ZnzdGCo1XQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: MDQMaJfxlsCBeRaK94Coxi6SANrI1n4E
X-Authority-Analysis: v=2.4 cv=d5jFDxjE c=1 sm=1 tr=0 ts=6a17d8bb cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=25xbtWhBidXVKMBX-WEA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: MDQMaJfxlsCBeRaK94Coxi6SANrI1n4E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1NiBTYWx0ZWRfX3gfAbRCRSw88
 gX1gJpu3k+w/gd0Hx4vloy2/uijI2UwIhIbDmDCp5hvpkgS0slyiNwFxrdqVHzYiYO+Pu96cIPG
 IlBBIFIn9pr0U4J8+VKsqILXWSYHnm2jfWvG4lLIegMeScWeajilK1BrUfFDCUc1Zt328EggmmU
 gzJFwvCEp20JELv8nWMWz75l7+R0HdTidPY5Ja9+TXU5B1t93NokjuTaqKr1BTJFBRPEEkSrOyC
 WVj4U9IqgioTKXmJoTEYMGkMR35ABw6ok+0IfehZ0P7SnlaJgTOMBlb5JljOZOYl3vGZP0I6uYy
 ZA2M0pYCtrLx698DfXbC9QpzbIOjWsSroM4zB3bYZo0rZG/fvKsPQs1001ziFtKgKhq/XgtGr4h
 gODou4GF6pBNCZxQGDVG+VFCshV4B7kzfU6H0SuXvWwmIMoEIRLTDrVqY1faaAQy/62SgBp1xT+
 NnGqFgNLbdg1y+6u49w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01

On Wed, May 27, 2026 at 12:00=E2=80=AFPM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> >
> On Tue, 26 May 2026 07:43:56 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> > peer access and translate the returned steering tag into an mlx5 ST
> > index. Keep the DMAH path as the first priority and only fall back to
> > DMA-buf metadata when no DMAH is supplied.
> >
> > Track per-MR ownership of the allocated ST index and release it on MR
> > setup failure, destroy, and FRMR-pool reuse. Release the ST index before
> > the MR is pushed back into the FRMR pool, and free mlx5_st_idx_data when
> > its refcount reaches zero so repeated allocation/deallocation does not
> > leak memory.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
> >  drivers/infiniband/hw/mlx5/mr.c               | 86 ++++++++++++++++++-
> >  .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 28 ++++--
> >  include/linux/mlx5/driver.h                   |  7 ++
> >  4 files changed, 115 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/=
hw/mlx5/mlx5_ib.h
> > index e156dc4d7529..4ab867392267 100644
> > --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > @@ -721,6 +721,12 @@ struct mlx5_ib_mr {
> >                       u8 revoked :1;
> >                       /* Indicates previous dmabuf page fault occurred =
*/
> >                       u8 dmabuf_faulted:1;
> > +                     /* Set when the MR owns dmabuf_st_index and must
> > +                      * release it via mlx5_st_dealloc_index() once the
> > +                      * firmware mkey is no longer referencing it.
> > +                      */
> > +                     u8 dmabuf_st_owned:1;
> > +                     u16 dmabuf_st_index;
> >                       struct mlx5_ib_mkey null_mmkey;
> >               };
> >       };
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > index 3b6da45061a5..8059b5e4da97 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-resv.h>
> > +#include <linux/pci-tph.h>
> >  #include <rdma/frmr_pools.h>
> >  #include <rdma/ib_umem_odp.h>
> >  #include "dm.h"
> > @@ -46,6 +47,8 @@
> >  #include "data_direct.h"
> >  #include "dmah.h"
> >
> > +MODULE_IMPORT_NS("DMA_BUF");
> > +
>
> This doesn't appear to add any dma-buf namespace dependencies.
>

sure let me check and drop if not necessary.

> >  static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
> >  {
> >       if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> > @@ -899,6 +902,63 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
> >       .invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
> >  };
> >
> > +/*
> > + * Query TPH metadata from @dmabuf and translate the raw steering tag =
into
> > + * an mlx5 ST index. On success, returns 0 and the caller becomes the
> > + * owner of *@st_index (must be released with mlx5_st_dealloc_index()
> > + * once the firmware mkey no longer references it). On any failure
> > + * *@st_index and *@ph are left as the no-TPH defaults set by the call=
er.
> > + *
> > + * @dmabuf must already be referenced by the caller (e.g. via the umem=
's
> > + * attachment) so we don't re-resolve the user's fd here and avoid a
> > + * dup2() TOCTOU between umem creation and TPH lookup.
> > + */
> > +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_buf =
*dmabuf,
> > +                           u16 *st_index, u8 *ph)
> > +{
> > +     u8 req_type;
> > +     u16 steering_tag;
> > +     u8 st_width;
> > +     int ret;
> > +
> > +     if (!dmabuf->ops->get_tph)
> > +             return;
> > +
> > +     req_type =3D pcie_tph_enabled_req_type(dev->mdev->pdev);
> > +     switch (req_type) {
> > +     case PCI_TPH_REQ_TPH_ONLY:
> > +             st_width =3D 8;
> > +             break;
> > +     case PCI_TPH_REQ_EXT_TPH:
> > +             st_width =3D 16;
> > +             break;
> > +     default:
> > +             return;
> > +     }
> > +
> > +     ret =3D dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
> > +     if (ret) {
> > +             mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
> > +             *ph =3D MLX5_IB_NO_PH;
> > +             return;
> > +     }
> > +
> > +     ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_in=
dex);
> > +     if (ret) {
> > +             *ph =3D MLX5_IB_NO_PH;
> > +             mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", r=
et);
> > +     }
> > +}
>
> ph handling is inconsistent, why not use a local variable and only set
> the caller's pointer on success?
>

good point -- will do that.

> > +
> > +static void mlx5_ib_mr_put_dmabuf_st(struct mlx5_ib_mr *mr)
> > +{
> > +     if (mr->umem && mr->dmabuf_st_owned) {
> > +             mlx5_st_dealloc_index(mr_to_mdev(mr)->mdev,
> > +                                   mr->dmabuf_st_index);
> > +             mr->dmabuf_st_owned =3D 0;
> > +     }
> > +}
> > +
> >  static struct ib_mr *
> >  reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
> >                  u64 offset, u64 length, u64 virt_addr,
> > @@ -941,16 +1001,26 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct devi=
ce *dma_device,
> >               ph =3D dmah->ph;
> >               if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
> >                       st_index =3D mdmah->st_index;
> > +     } else {
> > +             get_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
> > +                               &st_index, &ph);
> >       }
> >
> >       mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
> >                               access_flags, access_mode,
> >                               st_index, ph);
> >       if (IS_ERR(mr)) {
> > +             if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_=
TAG_INDEX)
> > +                     mlx5_st_dealloc_index(dev->mdev, st_index);
> >               ib_umem_release(&umem_dmabuf->umem);
> >               return ERR_CAST(mr);
> >       }
> >
> > +     if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDE=
X) {
> > +             mr->dmabuf_st_index =3D st_index;
> > +             mr->dmabuf_st_owned =3D 1;
> > +     }
> > +
> >       mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
> >
> >       atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_page=
s);
> > @@ -1377,9 +1447,17 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5=
_ib_mr *mr)
> >       bool is_odp =3D is_odp_mr(mr);
> >       int ret;
> >
> > -     if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
> > -         !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> > -             return 0;
> > +     if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr)) {
> > +             /*
> > +              * The mkey has been revoked: firmware no longer referenc=
es
> > +              * dmabuf_st_index, so release it before this mr can re-e=
nter
> > +              * the FRMR cache for reuse by another registration.
> > +              */
> > +             mlx5_ib_mr_put_dmabuf_st(mr);
> > +
> > +             if (!ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> > +                     return 0;
> > +     }
> >
> >       if (is_odp)
> >               mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
> > @@ -1400,6 +1478,8 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_=
ib_mr *mr)
> >               dma_resv_unlock(
> >                       to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv=
);
> >       }
> > +     if (!ret)
> > +             mlx5_ib_mr_put_dmabuf_st(mr);
> >       return ret;
> >  }
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers=
/net/ethernet/mellanox/mlx5/core/lib/st.c
> > index 997be91f0a13..8929c17c88bc 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> > @@ -29,7 +29,7 @@ struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *=
dev)
> >       u8 direct_mode =3D 0;
> >       u16 num_entries;
> >       u32 tbl_loc;
> > -     int ret;
> > +     int ret =3D 0;
>
> Unnecessary change.
>

ack, will check and revert.

> >
> >       if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
> >               return NULL;
> > @@ -92,23 +92,18 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
> >       kfree(st);
> >  }
> >
> > -int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type m=
em_type,
> > -                     unsigned int cpu_uid, u16 *st_index)
> > +int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
> > +                            u16 *st_index)
> >  {
> >       struct mlx5_st_idx_data *idx_data;
> >       struct mlx5_st *st =3D dev->st;
> >       unsigned long index;
> >       u32 xa_id;
> > -     u16 tag;
> > -     int ret;
> > +     int ret =3D 0;
> >
> >       if (!st)
> >               return -EOPNOTSUPP;
> >
> > -     ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> > -     if (ret)
> > -             return ret;
> > -
> >       if (st->direct_mode) {
> >               *st_index =3D tag;
> >               return 0;
> > @@ -152,6 +147,20 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev,=
 enum tph_mem_type mem_type,
> >       mutex_unlock(&st->lock);
> >       return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
> > +
> > +int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type m=
em_type,
> > +                     unsigned int cpu_uid, u16 *st_index)
> > +{
> > +     u16 tag;
> > +     int ret;
> > +
> > +     ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return mlx5_st_alloc_index_by_tag(dev, tag, st_index);
> > +}
> >  EXPORT_SYMBOL_GPL(mlx5_st_alloc_index);
> >
> >  int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
> > @@ -175,6 +184,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev=
, u16 st_index)
> >
> >       if (refcount_dec_and_test(&idx_data->usecount)) {
> >               xa_erase(&st->idx_xa, st_index);
> > +             kfree(idx_data);
> >               /* We leave PCI config space as was before, no mkey will =
refer to it */
> >       }
>
> Should this be pulled out as a fix separate from the feature added
> here?  Thanks,
>
> Alex
>

Yes, will split it out as its own patch.

Thanks,
Zhiping
