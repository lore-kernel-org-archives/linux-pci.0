Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9236680F
	for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2026 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776105183; cv=fail; b=CcsBIm+WELxmvtILCQtdxjsZmXL9m6KDbApqywdUrEevKBAmCrnOgynT5CfW5AIk/Qz5DIeOLlWkflFjH7M9dO684p+GcNX7VYjm15Xd5aHxyHW2J2tDNac3dL0RuAnJw6rBU5nrqjK+LXruyUXxO/x6C8ml9plUxxtYzCJAyKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776105183; c=relaxed/simple;
	bh=cBpXrkihGcjGQcaYRaWShDZmky7Cxex9eGcodqpepCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STCW1/3bnPFxgDMf6xvoi2UWUMzfON2B9YWIxVZ2L4ERWi13fG9OzjPYyU9i2Xw2mVGyeqCNcN+rvmhleb+yxqnHOLucHY7cd+aEwpR+06yh9iPclTQGcdKBgq+d3QTMpmjvmDpBCOfIOYLaM3U0FfXheCDBNp2gUlKJcuFTUNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BhCoaxeI; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BhCoaxeI"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 63D2pkWj482050
	for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2026 11:33:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zG1i4GOJI0Qqxhx6X/y+OYVi9v31A3eEgoxO9M8dGo8=; b=BhCoaxeIAUTn
	YJ7JhPz3Cx4IihaBsBpITr2/1JYDB8qkbM1UsOnx6Hz7lD9+VdcpE1EJyypDO/KG
	WCuinBHxBNAbk1fqrW0/uMUNq3AFMFBcyij842gJXDxEArbnbnSFlkWcDzkkpHJw
	93uzWR86iB/Yoqf4nv/24SWhVkPlWjvuAPhNCj2eGDalRmeGG5B83FBpS4No7Y7L
	joGCbmbGXSXrXvzc89j++TyvF2Kco6Mo2SyFjdP79qHqn/VKxxhWFXQ309Ujk0O2
	ZWUwUErBjTlmgcLhxUNhmB9eD3sRs8I5KPtN+ckqJ0rrQA5u0slfiHH3Lke5SO3z
	mic2S/rLnA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by m0001303.ppops.net (PPS) with ESMTPS id 4dfhyear55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2026 11:33:00 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d7e995a87cso27440a34.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2026 11:33:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776105180; cv=none;
        d=google.com; s=arc-20240605;
        b=ZPUWwf7WqoH2ezC6UatE2WC6Prvt/zyIwbguB8zAt9w1h+wECyftrqJ9mwSqcUj1eo
         hBpWItz2fXTd0qBYrue10aQ+fz/IPvOpE83FcPknrwkrn0CvUX5lvsoeGx870ZArtBMB
         w1eguPVu7G1GaiWXej2xMX+SYU7M0lzPmtOcwUt5C6/FnMbN5trMJy6FNJvYiZJuEeth
         gDxYqr6EFKyJ0CXepZh65xj+wenFPR+PLYIKeGqQfRtpZqNoLOgyxj1yoqH4mXklKewU
         LZyid/ElcSj6D3QUDVJ6UoE+aQPFInAb3TwkZ+bjCVWXFhD7NMDoieU9/VsVJqc/0zN0
         pSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=+JPsy6ZFn+T7uthNgDQuwBwhJArt54L0xqFFmpZV85I=;
        fh=NcDVO38u9EQRVnQKeJ4bmdjlFRYg7CnZnnJCV62ZILg=;
        b=M6TZVfWVtoEJPvPhz6MzAmtyixFu/55xGfLjxcOuC8M5LUtcxiyTjGD5i5vrjEsDeB
         d/FgT0Gp4oquxDt3y/dOMXOab8MC/8WzWnWYFwQf9vzzpISQ/F8ng3j0U+lzs9gQzAn0
         Pu1DsnXK1e2rihbduFRxQfNQ7tSBioF6GAG6+q1+IWfsv96MgyauGq9uHoX7PjxSlE+7
         ROHwNxhHsLxKPxiAF0Zqj51V8Ye35yN6dW8Hm4+/1y37DGAhLTUQQKRkA1KmrVZzvckg
         PQjnQV+EHqAqP4RvcYYdC93ug9NNBgqr/TGa2WKeYLudmvGl9Y5d+xYwehnMRCW5avu8
         2WUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776105180; x=1776709980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+JPsy6ZFn+T7uthNgDQuwBwhJArt54L0xqFFmpZV85I=;
        b=aP8983Zx+7e01biJpidMrlnRuC6mHS1mYlsEAFp3PfJtp+HsrpDRBXi3/Mq6V6m3gj
         b42aeXCZRDyMZKL9sDUEogsMqo8R/c9NF81M27Jp9CaBINnzMmKW+lEcgHxC7v9a19kd
         Azp/EpEW7QH/mDpl+7zSCJd2kaE7po18EBwsopOCGkvL6j5K123s4nwfNiEa4otQSvVo
         VTMOpKrmze6w6EYKCmzn8+7azJ6Uc7IMYFZl3B7/4iUtXq+cEOjT9fDpBjLE50Cgy4pc
         YRGc5aH/eJ3Jr4OK8r/NWccY8W5R0WAfhm2k9vOhSfhMNM7sPubBeMWAXMz8ueNEPRqz
         Jj7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8w99G2FuU+6V3PsmqKPpVYtozDyD60xHvv36HIu8jn/4QGWptGAmSH9WkWNy1wt6YJmXhp23UCmAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJN5PRd7E5qMjfEvI326AHOo5slBZ+A5T1xNLTRW3j9ZiJ2CO
	GtKQmzs4fgPsE/ea8hzNrteTnTFldFqxxSpPySWIk66o/fTJzKsRJIRn48MbLP7h8a1SDSVzNhx
	u3ClNGGXMcS5QRcgRM7nlbjGsx8ATTt0CeYfZowgwlhghvUc2VsLfMWFywNj8CVqkX77qVIU13D
	DcfYvJMa9X0o9zhnsnIReS4RS51Z2nTBvF3eI=
X-Gm-Gg: AeBDies8arcc0VWj/zv/OJVuFLXXX1fshHfTm8+o7rmTS8LhtSmvYPA/VSNZvLPBob2
	R8qMZYWj5waHr9gvIAm7LPMG+E+9qOL2s0/HRoRH6FwB4cmls5FzWebo8xYV5CDSNnSH19l0w1o
	L97uCO10Xe4tLRbFlGGPO498aDG2T8q/eVEArRQr0UpM0PV3bFJJ/MvuCqFF1I98rgTZlTI8mbP
	trRazTd2Je8W8AKJKb28SF+LHIJEOhy
X-Received: by 2002:a05:6830:488e:b0:7db:a0b2:b5d5 with SMTP id 46e09a7af769-7dc27e1ca9cmr8189343a34.24.1776105180134;
        Mon, 13 Apr 2026 11:33:00 -0700 (PDT)
X-Received: by 2002:a05:6830:488e:b0:7db:a0b2:b5d5 with SMTP id
 46e09a7af769-7dc27e1ca9cmr8189318a34.24.1776105179660; Mon, 13 Apr 2026
 11:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal> <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal> <acvNsvS5ShlQlrox@kbusch-mbp>
 <20260331140309.GH814676@unreal> <acvWplw67b3Gwlkc@kbusch-mbp>
 <20260331190220.GI814676@unreal> <acwkAo2k41xaxdTS@kbusch-mbp> <20260409120415.GF86584@unreal>
In-Reply-To: <20260409120415.GF86584@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 13 Apr 2026 11:32:48 -0700
X-Gm-Features: AQROBzDIIpZEN3aiHYPi89ixDuzK7SpFChCr2JMeXAVEQc6s_3ctAex9jcSvckQ
Message-ID: <CAH3zFs0hx_-3LetSUaPRMg=0jaL=GD7Mop3pEUhJ3O3qkaJrQg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE4MiBTYWx0ZWRfX87N561Cly8Ti
 wr/xrA9UY0sQ3FIz5Fz+c/EkOlOFGA8NrGw0dLK88vMuvrzbX/pZWUxkFAxSam7ckD1p7Lv4lem
 1Bm2k9AnuyZMqa7jA7M0cS5BpPiTQ9bQxIKX+4cAHTKolSPi8MpBN4OHcQsPQ9u46QtcSXKT3+e
 5fX2WdM5yYrErP3Fi7tOt9r5l+DuaEj4IPQ+r/NozzfDpUuSdwWACIrVaKfwYLDYMyJJZHoqVMX
 90Kc4PYJIYFI3MEbTjhBz7Pn70PraTL3ZcXOzTpoio16It1M1f23pAxShIIGSYhi9SzrT2mbxl3
 lccb1A+cgbHbr1HH0kWy+/voiGNSfMgB1CUqBfVR1Cp56ffruOW8erRUbsxes3ILGqP3eCB07gr
 btyPvanEVf7TGepo9LazmeHbIfi7oPiC/Byt3BANyaJ8k4NyQNK3JKi9mFOAOswPNQoCFs8O/XK
 dbOC7q6/Y95jMpKFxsA==
X-Authority-Analysis: v=2.4 cv=d7HFDxjE c=1 sm=1 tr=0 ts=69dd36dc cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=VwQbUJbxAAAA:8 a=f99BUTzuh9MxvKowt8oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ugY1AU9yIDNMoA_AA3zSq0yya_ipcM12
X-Proofpoint-ORIG-GUID: ugY1AU9yIDNMoA_AA3zSq0yya_ipcM12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01

On Thu, Apr 9, 2026 at 5:04=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> >
> On Tue, Mar 31, 2026 at 01:44:02PM -0600, Keith Busch wrote:
> > On Tue, Mar 31, 2026 at 10:02:20PM +0300, Leon Romanovsky wrote:
> > >
> > > Right, what about adding TPH fields to struct vfio_region_dma_range
> > > instead of struct vfio_device_feature_dma_buf?
> >
> > You might have to show me with code what you're talking about because I
> > can't see any way we can add fields to any struct here without breaking
> > backward compatibility.
> >
> > If we can't claim bits out of the unused "flags" field for this feature,
> > then my initial reply is the only sane approach: we can introduce a new
> > feature and struct for it that closely mirrors the existing one, but
> > with the extra hint fields.
>
> Something like that, on top of this proposal:
>
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index 3961afa640391..70d5ee1e3ef7b 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -241,9 +241,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_cor=
e_device *vdev, u32 flags,
>                 return -EFAULT;
>
>         if (!get_dma_buf.nr_ranges ||
> -           (get_dma_buf.flags & ~(VFIO_DMABUF_FL_TPH |
> -                                  VFIO_DMABUF_TPH_PH_MASK |
> -                                  VFIO_DMABUF_TPH_ST_MASK)))
> +           (get_dma_buf.flags & ~VFIO_DMABUF_FLAG_TPH))
>                 return -EINVAL;
>
>         /*
> @@ -300,13 +298,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
>                 ret =3D PTR_ERR(priv->dmabuf);
>                 goto err_dev_put;
>         }
> -       if (get_dma_buf.flags & VFIO_DMABUF_FL_TPH) {
> -               priv->steering_tag =3D (get_dma_buf.flags &
> -                                     VFIO_DMABUF_TPH_ST_MASK) >>
> -                                    VFIO_DMABUF_TPH_ST_SHIFT;
> -               priv->ph =3D (get_dma_buf.flags &
> -                           VFIO_DMABUF_TPH_PH_MASK) >>
> -                          VFIO_DMABUF_TPH_PH_SHIFT;
> +       if (get_dma_buf.flags & VFIO_DMABUF_FLAG_TPH) {
> +               priv->steering_tag =3D
> +                       dma_ranges[get_dma_buf.nr_ranges + 1].tph.tag;
> +               priv->ph =3D dma_ranges[get_dma_buf.nr_ranges + 1].tph.ph;
>         }
>         /* dma_buf_put() now frees priv */
>         INIT_LIST_HEAD(&priv->dmabufs_elm);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index e2a8962641d2c..a8b8d8b1a3278 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1497,20 +1497,30 @@ struct vfio_device_feature_bus_master {
>   */
>  #define VFIO_DEVICE_FEATURE_DMA_BUF 11
>
> +struct vfio_region_dma_tph {
> +       u16 tag;
> +       u8 ph;
> +};
> +
>  struct vfio_region_dma_range {
> -       __u64 offset;
> -       __u64 length;
> +       union {
> +               __u64 offset;
> +               struct vfio_region_dma_tph tph;
> +       };
> +       union {
> +               __u64 length;
> +               __u64 reserved;
> +       };
> +};
> +
> +enum {
> +       VFIO_DMABUF_FLAG_TPH =3D 1 << 0,
>  };
>
>  struct vfio_device_feature_dma_buf {
>         __u32   region_index;
>         __u32   open_flags;
>         __u32   flags;
> -#define VFIO_DMABUF_FL_TPH             (1U << 0) /* TPH info is present =
*/
> -#define VFIO_DMABUF_TPH_PH_SHIFT       1         /* bits 1-2: PH (2-bit)=
 */
> -#define VFIO_DMABUF_TPH_PH_MASK        0x6U
> -#define VFIO_DMABUF_TPH_ST_SHIFT       16        /* bits 16-31: steering=
 tag */
> -#define VFIO_DMABUF_TPH_ST_MASK                0xffff0000U
>         __u32   nr_ranges;
>         struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>  };

Sounds good, thanks! We will follow up and move this RFC to a formal patch.

Zhiping
