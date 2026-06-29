Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6E737E2E7
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782773205; cv=fail; b=B24l5VExPhUPlLN0oz3g1IJAYaITG/sCLd7VIiyaEpZc2mrkDIfWW4NBSpOyDj5kj7ZE2Km6GInSrQ9rwMJ/ACHaa6m4EJnVjF8IukQhhPpt5M6jO+Xh0ymZo6u7qXf8HxmH1HjzzB5tD7fZ4w3JOyHzzN3wzMx5QwuOKcYlSp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782773205; c=relaxed/simple;
	bh=LAAsXswdYRhoMmUQBXGAxhkMFD79zG1d6WTOgeAPZ4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjZYME1d0eDApH38R38tX7VXYlBudAXrVkw/VI2kATDxDXbfCEC790UWafNcOdIJ/MsIjJLs57kW9yanLhwTNUvGHSm5PZyoo+PEKVUq+q9XlyeyQJHDzbMFt4I/wJmNBk3yaHYbC8CniBoXv0XOOGBzIiR9QLuBuap0HNngnJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D6Y+Suqj; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="D6Y+Suqj"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65TKgHpD2705434
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 15:46:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=wLX+q6aZUGU2+tNflRbeS5hmHMHpHmOV5uipQIZIRjc=; b=D6Y+SuqjEQrM
	f2QeVXHoqMHxZexgeghszFXVrZw4LS2kXjWpFfTX8mYzWTSEZtH/ttBdVAMkyWdy
	t22Kq702OWpcjEU/kF74grLjnJ54kbNPw0ntlbzzWsw9KEK4RR3CgBqUj3aHbeET
	ijCi6YifPqpFYhAvAOCkBJNfzC61asm2Ur9WnbU9jxmtIccXlhxFn7djlehRcrRk
	CI4mOnrSJnRZys+tAPctwAstQLwZ/r0gp8f8Cpuv+y14HBevZ8rrU6ANkQzUAHDJ
	nM51q117Utf29kv/dShBoc87MTcZ26F0vt+BK+TCjbX+Yw7l2sLH0bG+JlOh+Qz+
	pPe0+S/ERg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by m0001303.ppops.net (PPS) with ESMTPS id 4f2a69qupa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 15:46:43 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9bd376d65so4077442a34.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 15:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782773202; cv=none;
        d=google.com; s=arc-20260327;
        b=S01t+DrxntvctLh8iVm5pagmkaju/u5sCDQRL4qHRVncteptusDChnLwxCGRFO2MmZ
         H8KokyR54F6ecOOIJRQaO6avCeaIDlcTBNvUkB43Pql8lDZ8jxioXUWAVQWTP+0S2Q2a
         6hT6gSuAuGC9kJB0QXxkF8b6Kz0BZlKoH4ibBxHQ3ZSjss0mdGlyf+h27Ch6poyHSuTT
         D8MCSg0VxZ4Rmw4CPYAJ+kKE+Ms4btqUvjFkXh0q7Rdf/vE9DaaIxCDMdt6Q0lRDDUaO
         11x48tI4FSzA9/HjcQmhF827Fq3YpV+yudhJH5RhHKaRwCAi9AwfJAUAbNV1+cknhxXF
         ksNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=qoepALekrUydMw3++ECBWh0/IG+kKVdwdlDn299LcLI=;
        fh=z0RstNQxYQU/2FL2K5ZTeEvvZpRAChaPLRHi0QKDGdw=;
        b=keh9b9P6bAxSOd3yb+G2/ITKjMncmA4msxfTlFFvPO79S9Z/8KOdM566hwzbctv3dK
         dXZhVyZnLERdNDjBTzKsIKQ4A7U3pC/N1EGqZuI8se9oh3gFSjztLa8a2b9XRqEneJ8H
         jChrRCYwIRyaUEloGDJA6DFCTKXwk/MCd0yf9SLhNQAhFkbKGwQNz0fgqnxY4YFP9dMI
         HQndxgxlBSg98dgMWOLic7nsUyX0i7Xv5WP82X4m38LiKx1UqIhT7OZCxA+kKnzYb5EF
         sRT81ojV1zx2p/5i60aWT1E/2QuuIQdXXC/E8PhaTvngh15itz1x51I/jXxG168I/XTu
         elBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782773202; x=1783378002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qoepALekrUydMw3++ECBWh0/IG+kKVdwdlDn299LcLI=;
        b=p2zhyCj7Dd3+4pPbfmN6fMqxTnTU4OgGlLXxDExkA2s2y9V3NvQJWV/grOUN79Bgqw
         0LZmt/TP5jWNx0OyeclKIbPK2pJHPC3FKjyDzKQrQBY7TBlfmGSUdGzXlMmil3RSuCTt
         E7+4lkRoVvUsE/7pEWCwlyf/cgrmmlCnQhXBYO7vncE5Iq9LsvSAJV9Eku3Wg44klx7L
         z2yfgP5ZivJHqrhw8HbIY4p5GDpDNGb3IpnFyWMwj6s0uhvohId1PL28ZAlQd+voYK9X
         2CgQcy1lfVxYiOMVei9pjJR2RQw28U99mSMozY21+ByLQHx+7IyjyKoyE/lh+q2b36gf
         1SIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+73+eJ/O6BUWwudNvuGNGcf16/+uHQhqjk9lgEcM4o5RkAfGfSHKmXIgAHQEmbEbTUC+AzS8PYEkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjesZYUjyp4NuDW2cgl5DAz1aoxDSLUW/yPir0zJQHRdetGKKs
	sp642KJLVHCCtFYUtOhah7ohMkWsfaQ3w8e4Y3xSrECXIx0yS5Ko8zLdP2xHcNx7gDGGM1nTANH
	cBmry5luvA3PkZlGocuok5OfGZH8NRRBfAATGjYCFGdzz6qYYGuH6LKTwo+OBz8a+HFnJcHpE49
	3PVkMC1O8Z/w9ULmc1i9mXl6Ku8cNEGK9/bXow02o3Kq4WrQ==
X-Gm-Gg: AfdE7ckfufx+QTLoCOq2P7vJQmAWeAnm9ukhzYOWNjUtx6LKtza5Gn8+/f+4iE8GC9/
	6M0D0hsPlFwNC+g849me96cj6ArWdYTnsxeuWet7PEhEnWiIK18+4Z+aZ3hVZiKLkwwrdZoqw5P
	lz1fBt8yxtuQGkN9sxpISJ+XT5bgSX3Zj0WeSIoto4qGsyfd5Wu1dg8WTUlNiypGGes1A7FyQjF
	V2olSTS
X-Received: by 2002:a05:6830:6389:b0:7e9:e860:6ee with SMTP id 46e09a7af769-7e9ec7c6eaemr1372414a34.31.1782773202406;
        Mon, 29 Jun 2026 15:46:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6389:b0:7e9:e860:6ee with SMTP id
 46e09a7af769-7e9ec7c6eaemr1372389a34.31.1782773201883; Mon, 29 Jun 2026
 15:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622184211.2229399-1-zhipingz@meta.com> <20260622184211.2229399-5-zhipingz@meta.com>
 <b4c98f5a-b3a4-4dff-96ea-be2aa33cd1e8@nvidia.com>
In-Reply-To: <b4c98f5a-b3a4-4dff-96ea-be2aa33cd1e8@nvidia.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 29 Jun 2026 15:46:31 -0700
X-Gm-Features: AVVi8CfM8-1FZc35vpJ8kCojEp6xp5zFP0DjBW3kt6zGgKV_ax4f1nQ8Em8QwAQ
Message-ID: <CAH3zFs2LbjPCn9B2iCvFyW5yKoAirkZqdhwxmZh+U65wH9uy=Q@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Michael Gur <michaelgur@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE5NSBTYWx0ZWRfX+AjOaaWlZSwo
 Vz8ums/qoqTOxW/dT5/fCLkdwaADdjGcdGXMeK7daoYyx26PLDBscaY6BJt+eoLydzXFIeusYZi
 /OD6Be3ST4LholLyfMb7+0Zd0RxoV2Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE5NSBTYWx0ZWRfX+72hzBThuD8X
 zTCu3y54T6iaSX+bImfMxTHw1W/lCkfNcurZ+cX3OcSOsgiiia0Sv5XuxPSzzSykhZw6dGuwQLE
 EqInLfqajOgZSdt59Ks5rkyPubAxQIvJS/gAYNja2GTwzbYvZxC+pdcyP2NoFTKoAdv/4EA3Ktt
 1yJgqIAMcBqpfdPZZzUJuak3LQNoZ63NwVSqnV6VBmBdHCVVMFiVPq9Um3jORTEEaFaPpSf/KVW
 fZztk75y/PN0jjawrKKIyyPvi9rSTFn4UGWy/8IeAWjsbq/ppnk2quK6iqqAPG4gbY2B1JmQcAq
 lbJdXT1jSR41UYHRVueGQqiRUxEcF9JkK5I8BtxJDxnBW2XURbKQcP9lb2h5bc2J8cXXcK+mBir
 g/eE6Mvn38txOfYkgNfP8erMrfODoWlOT+0oE8PV/04YlQu2y9dNPSe3MlpBzyK6+DH6crLHs8e
 jaq5jinROvZ+6pOrJ4A==
X-Authority-Analysis: v=2.4 cv=Iei3n2qa c=1 sm=1 tr=0 ts=6a42f5d3 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=Ikd4Dj_1AAAA:8 a=VabnemYjAAAA:8 a=CbDCq_QkAAAA:8 a=l0kR5rhSyQLp93Ybf_gA:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22 a=1qrBK16LubpBFNPVNq2M:22
X-Proofpoint-ORIG-GUID: xX5J-juFKAGG3tjPBW6KDC1t_gdXOo0S
X-Proofpoint-GUID: xX5J-juFKAGG3tjPBW6KDC1t_gdXOo0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_05,2026-06-26_01,2025-10-01_01

On Mon, Jun 29, 2026 at 12:11=E2=80=AFAM Michael Gur <michaelgur@nvidia.com=
> wrote:
>
> >
>
> On 6/22/2026 9:41 PM, Zhiping Zhang wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Peer-to-peer DMA between a mlx5 NIC and a foreign PCIe endpoint
> > (typically a GPU or a vfio-pci passthrough device) traverses the host
> > PCIe fabric. The endpoint exporting the dma-buf knows which PCIe TLP
> > Processing Hint (TPH) Steering Tag yields the best placement for the
> > traffic it will sink: per-endpoint hint selection lets the root complex
> > or switch direct DMA to a specific cache slice / NUMA node, cutting
> > cross-socket snoop traffic and DRAM pressure under sustained p2p
> > workloads.
> >
> > Until now the mlx5 importer had no way to learn the exporter's chosen
> > ST tag, so dma-buf MRs were registered without TPH and ran with the
> > default (no-hint) routing. With dma_buf_get_pci_tph() in place this
> > patch wires up mlx5_ib to query that metadata at MR registration time
> > for p2p access and use it to program requester-side TPH on the outbound
> > mkey. If the exporter has no metadata, fall back to the existing
> > no-TPH path so behavior for non-TPH-aware exporters is unchanged.
> >
> > Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> > steering tags into local ST entries when table mode is active, and add
> > mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> > index.
> >
> > For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> > lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> > creation and release it again when the MR is returned to the pool or
> > the backing mkey is destroyed, while leaving the generic FRMR pool
> > core unchanged.
> >
> > Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> > modular mlx5_ib builds link cleanly.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >   drivers/infiniband/hw/mlx5/main.c             |   1 +
> >   drivers/infiniband/hw/mlx5/mr.c               | 103 +++++++++++++++++-
> >   .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 +++++++--
> >   include/linux/mlx5/driver.h                   |  13 ++
> >   4 files changed, 157 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/=
mlx5/main.c
> > index 02809114fc79..a2b497f6b16b 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -60,6 +60,7 @@
> >   MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
> >   MODULE_DESCRIPTION("Mellanox 5th generation network adapters (Connect=
X series) IB driver");
> >   MODULE_LICENSE("Dual BSD/GPL");
> > +MODULE_IMPORT_NS("DMA_BUF");
> >
> >   struct mlx5_ib_event_work {
> >          struct work_struct      work;
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > index e6b74955d95d..7aced3f55456 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -39,6 +39,7 @@
> >   #include <linux/delay.h>
> >   #include <linux/dma-buf.h>
> >   #include <linux/dma-resv.h>
> > +#include <linux/pci-tph.h>
> >   #include <rdma/frmr_pools.h>
> >   #include <rdma/ib_umem_odp.h>
> >   #include "dm.h"
> > @@ -167,6 +168,32 @@ static int get_unchangeable_access_flags(struct ml=
x5_ib_dev *dev,
> >   #define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK GENMASK_ULL(23, 16)
> >   #define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK GENMASK_ULL(15, 0)
> >
> > +static int mlx5_ib_get_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
> > +                                         u16 st_index)
> > +{
> > +       if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> > +               return 0;
> > +
> > +       return mlx5_st_get_index(dev->mdev, st_index);
> > +}
> > +
> > +static void mlx5_ib_put_st_index_ref(struct mlx5_ib_dev *dev, u16 st_i=
ndex)
> > +{
> > +       if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> > +               return;
> > +
> > +       mlx5_st_dealloc_index(dev->mdev, st_index);
> > +}
> > +
> > +static void mlx5_ib_put_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
> > +                                          u64 kernel_vendor_key)
> > +{
> > +       u16 st_index =3D FIELD_GET(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_=
MASK,
> > +                                kernel_vendor_key);
> > +
> > +       mlx5_ib_put_st_index_ref(dev, st_index);
> > +}
> > +
>
> Please remove the _frmr_ from the functions naming.
> This is now unrelated to the frmr and is strictly tight to MRs.
>

Agreed. Will rename for v10:
    mlx5_ib_get_frmr_st_handle_ref() -> mlx5_ib_get_st_handle_ref()
    mlx5_ib_put_frmr_st_handle_ref() -> mlx5_ib_put_st_handle_ref()

> ....
>
> > @@ -335,6 +364,7 @@ static int mlx5r_build_frmr_key(struct ib_device *d=
evice,
> >                  get_unchangeable_access_flags(dev, in->access_flags);
> >          out->vendor_key =3D in->vendor_key;
> >          out->num_dma_blocks =3D in->num_dma_blocks;
> > +       out->kernel_vendor_key =3D in->kernel_vendor_key;
>
> This path is used to translate an frmr key passed from user-space to the
> right values, enforced and masked by the drivers.
> kernel_vendor_key is not allowed in this path as user-space is not
> allowed to control those.
> Please drop this line.
>
> Thanks,
> Michael
>

Good catch, will drop.

Thanks,
Zhiping
