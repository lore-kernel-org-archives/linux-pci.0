Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E452421EF4
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091212; cv=fail; b=fNDW+BvAmwPogdx1h6zxmgxkPBL6CwdrdJ6Pz0Mis6V+v6UhxYfx7IAuFbOWge9wnzHas5rk3VjTYsIBX1vbqzFhXxBvxGJKdrnAJexTTVEXJDDoSV4/c+uoc7H53jeSk6JdDH7VU6sPBNtxBVE+rPdwgisnUkST9mTRM6NxLlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091212; c=relaxed/simple;
	bh=iwJF8kNlzSONi72wttB9cdvYDDohgwHHTCevGMN+7M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Liwn81ayAe5t7jJEjNC4np0hKlUb/Vdw8Ys37CWhWWygorhuIGga9uu4ZFDM0N4MuODQd//HV3Y7MDxAOmcXIwd72R6JGdMhy6cJhhZMRAiIcsq5+Gr7RgBytGzX8mPNPI8QQHT/7sRuQ9ukOrZsqEAGwcAqeC07casKV8zNdn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WohxvzDB; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WohxvzDB"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6465Md8I3686368
	for <linux-pci@vger.kernel.org>; Wed, 6 May 2026 11:13:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=bsbBvRMYnEJLwO6vFciq2lgaf49YRFfLC0382/bbMDg=; b=WohxvzDB7qU8
	o2wqk7WXisIZ2+qX8jjaoaehtsTVUyToiY5UVloN7qizzETPowd5S4Zb8nsC9EMl
	ULfRCe+eyS5F3L7XFUvewUEdAC5eCpjIHy/fSU0RKXCPBgxqLmVKOK5uz4d1xyua
	Eke9sevlGUcg5bDSN2idKRVF5h0mP8Krj1GJ0bk7ZFEuvrRJTHCQyy6EslL8rHDc
	eY2QYB8+Y7raLFdBngjmOlFSqJJ7pt4TUuOaX0mcx7wJ+l1lJ5lGdJpHSXCX+lte
	R3HEpqoAP35QuGsNrP9kQzHI0fvkMtoI/VDJafYjIWur8zAzA/LlV1Ml+TglKNA0
	ju/vhonoEw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx5vjp6g0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 11:13:29 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7de4be150b9so31278a34.1
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 11:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778091208; cv=none;
        d=google.com; s=arc-20240605;
        b=Fis40sH8e6WS1K7OAB1Kd7Wk8O4awew7Tp2YH/9hEls3VRR+o5C90Dlx4Q001+w7G8
         JnDrJgcaNxfkkXUCkj/xPGbUw08tt1wWFLYoaqaHOJ0gs62pfx1GJu6iWGxufhAcpnI/
         RLNzKs5hl/dsz6FIlJscLm/hmWT3vlPY4LCr0Izs8VkoH9w095UtKZ9v5ULY1pz7vgCF
         xsRiefxW3CEx94CuFq5wdtS+5vCzTVXb4plbfpVhu6VCYoatUMFS7xYWTGeZHZnefrD4
         1RYF1xBdqmRy9uISKxD+DMula8EBcWFcU871OW4Jccls3I3stryr5R/A0k+eTgwf4fpA
         uR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=3NDxADxfe9nDq1onSpJIot5yt/9B+/JmRFYIwD1lbrE=;
        fh=R/ktfef4r2s5SYSxDwdNYtoCghil54+8C3p4HAu+8P8=;
        b=IHtUrfVlIu5nrHwKd6u2O9aSHcdNoy7ZN4VNUue/f8fi4n0ts+ZVbX5tQPNlA6Q8yj
         8vYfMTW1pjjQLWhMGvLtJ/R7zFbxvEMFGD6YAUkmlBILpIB4zZLQLas9nxGc0fBWmPuk
         swIDzu3jixky4u1EqvoCUqfnyj/+NI8vWKl16rF7psN3FKrZqZxhFwIfEqP0AkVfQZWr
         GDHinSSJBOSm2Nw6BTF4i5eqQR1XzN1RuS5T+KBfQcAyMOAygneRHZno2JJEvbLSMUds
         VulV0VNxGmCWiU1+dyzoWTRAByv5FvZoCRcDmzNNfgUJWVWqZVatR31HVnh2vv6VO3Qg
         nWgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091208; x=1778696008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3NDxADxfe9nDq1onSpJIot5yt/9B+/JmRFYIwD1lbrE=;
        b=h13IgOZslx+RAvoSHpHGVRYq3LUJipF9YJMsVQMjFIECrcTgAVWpNc4Pj39QWmo3DD
         zfs+xe4m/8eIL5I1DS1hnkbYM4B5jBKRuCpqrHGJS6t3m1tm9FGaTEaCog2GpQbkB5Jf
         9ahK+3NtCsOb6Bbimy3Y1sxMXx16PE0e05H3k8feUoLloOdJKZt72cpC+Y6pcv4TUhK5
         p7BMThjk4PKddlDJBlavjRNAFL0dwGWZ9m0Cg/cOhBwl93SiTyZk0Kwq35QWhfMCzHog
         AJBs5Sr9Lhv9ajIFyVfLdvU8KZO5eFxSrRN2gCJUWcaFuuHEYJ3o1XNRsgMWNBEPqzJE
         S4gw==
X-Forwarded-Encrypted: i=1; AFNElJ/CLxgUrJ5UDYAfB66uf9vGyVLpsbvs29jEnp/A5BslaQtLySbx9RL/K52KpSa4N5ltv3suOAo5hHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+kSKKOvmIJuBj6Bq0O136RzqGTSCw6pqXDSMlH5JuaAbacjTP
	AHL2X6jryibXpjiA9oZock+U9B1Qok/xWJAWbSnp+qJrPDjwS2vNso60JemH2KlyubEP3zt432u
	0Mm7YhmVCFCNB88TtaL9iNYrtOlC6Ywm8zPCt47gkpGjEf7F2TSS0e+Cqtz/BKOFh96mKuOEiV5
	GLaUrWb4DMkcrW5Wt+pd+oU273qT+sNGbBXEc=
X-Gm-Gg: AeBDiesDoipSWELZ/9DLbIRVGx21OuN1q4dQLCg8I5pBhEDE6MKGau59w4S+jPEhkM6
	xhHM74FyMOvPkamxfxzVVixtq3g/pL7MYLAxb7vfLuQo8jC88emkX9hYCEsdEUFWsmQw1esdMqh
	/IYBHt9Mdh9kDbDJUw9fPThuGPpumhUO69DGiuRlUrhnfc1blng45xUVdRubfwMfXwQkPPiAXh2
	LqnwMmKfQbyi9znBxPt2CQ2nHXddqG+
X-Received: by 2002:a05:6830:6615:b0:7dc:da80:42c5 with SMTP id 46e09a7af769-7e1df2863femr2542386a34.28.1778091208360;
        Wed, 06 May 2026 11:13:28 -0700 (PDT)
X-Received: by 2002:a05:6830:6615:b0:7dc:da80:42c5 with SMTP id
 46e09a7af769-7e1df2863femr2542358a34.28.1778091207771; Wed, 06 May 2026
 11:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com> <20260430200704.352228-3-zhipingz@meta.com>
 <a63179d7-28b1-4269-9ef2-c20368d0b91c@huawei.com>
In-Reply-To: <a63179d7-28b1-4269-9ef2-c20368d0b91c@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 6 May 2026 11:13:16 -0700
X-Gm-Features: AVHnY4IkP9FyuA_XByk4LxkXqiqZTgspyYe5GlY8B_-IOTQbxE0OcjjDWm1D7Xc
Message-ID: <CAH3zFs0zAf0=kxxMfyxuBF0Mw+0FTFANHDG5C9d7-vQ9dFO0Qg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: GWZXdxtf4WhP0HHvBB_W6z8iDyPtHwDd
X-Proofpoint-GUID: GWZXdxtf4WhP0HHvBB_W6z8iDyPtHwDd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3OCBTYWx0ZWRfX9Ap1G5omO4y/
 2ZhaRyIhPftBRNhAMNQi32e+yXJ43WxgRHEQ69apR+jTLVZCmSRPeul/D7iuOBMWzqsuN3Zo+i2
 yHI25MsZYY1N5KWXo27anwd/zTX4ze77vsrNoqWrPWN+a3c0SOr4ldyPdE0MPqHVWJf46jzaHCI
 xLakmyHhXucsrcjHKR0XvdzgRINJ0PDI9IS86qvDKy2EeHL8Koo6w7SsUQbBNGdCEW8QcJ8AMTz
 VUB0wXs8+sCVLUZIfjdA2RVa6bUVNbdh3RpM0ZG8f8dxUxjwjVbvw3nHWSydfP02+B1eXrSzVEV
 zOmc10vrGuv6YUQjfVxi0uowkrENEkAaycH0yyz2M38kTlbk8I79q0vwUxJqzlS7GfomyKlRVV6
 hZmJG5lRZE4r70KgNH5Lm7D3fiy3iHbW2TQL8cmaZkUKca2uGm3W4vAW6aU3Px34yDw+a8CLlyi
 3Cl5gMym+yfgixbsyTA==
X-Authority-Analysis: v=2.4 cv=fvrsol4f c=1 sm=1 tr=0 ts=69fb84c9 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=kFoJLRxUVyBjw7Himy0A:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01

On Wed, May 6, 2026 at 12:04=E2=80=AFAM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/1/2026 4:06 AM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer to
> > peer access and translate the raw steering tag into an mlx5 steering tag
> > index. Factor mlx5_st_alloc_index() so callers that already have a raw
> > steering tag can allocate the corresponding mlx5 index directly. Keep t=
he
> > DMAH path as the first priority and only fall back to dma-buf metadata =
when
> > no DMAH is supplied.
> >
> > Pass the device's supported ST width (8 or 16 bit, derived from
> > pdev->tph_req_type) to get_tph() so the exporter can reject tags that
> > exceed the consumer's capability. Initialize ret in mlx5_st_create() so=
 the
> > cached steering-tag path returns success cleanly under clang builds.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -46,6 +46,8 @@
> >  #include "data_direct.h"
> >  #include "dmah.h"
> >
> > +MODULE_IMPORT_NS("DMA_BUF");
> > +
> >  static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
> >  {
> >       if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> > @@ -899,6 +901,40 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
> >       .invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
> >  };
> >
> > +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st=
_index,
> > +                           u8 *ph)
> > +{
> > +     struct pci_dev *pdev =3D dev->mdev->pdev;
> > +     struct dma_buf *dmabuf;
> > +     u16 steering_tag;
> > +     u8 st_width;
> > +     int ret;
> > +
> > +     st_width =3D (pdev->tph_req_type =3D=3D PCI_TPH_REQ_EXT_TPH) ? 16=
 : 8;
>
> The tph_req_type is defined under CONFIG_PCIE_TPH, how about add a wrap f=
unction
> to query it.
>
Good catch!
so the direct dereference here will break the build when TPH is
disabled. I'll add a small
wrapper in include/linux/pci-tph.h alongside the existing helpers, e.g.:

  #ifdef CONFIG_PCIE_TPH
  u8 pcie_tph_get_st_width(struct pci_dev *pdev);
  #else
  static inline u8 pcie_tph_get_st_width(struct pci_dev *pdev) { return 0; }
  #endif

  with the implementation
in drivers/pci/pcie/tph.c returning 16 for PCI_TPH_REQ_EXT_TPH and 8 otherw=
ise.
Then get_tph_mr_dmabuf() becomes:

  st_width =3D pcie_tph_get_st_width(pdev);
  if (!st_width)
      goto end_dbuf_put;

which also gives us a clean early-out when TPH isn't supported on the
device. Will fix in v3.

Thanks,
Zhiping
