Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF683438BF
	for <linux-pci@vger.kernel.org>; Sat, 23 May 2026 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779498253; cv=fail; b=L8A/lt8Umz7XmuvNSuZEEGFYNeVAdJFuS+TY3MczUx6zgDB3+G/x2Ib6qf050P/fp2j43pOzy87VtaRrafx9b9fRDLheerlCq0YxKRBZCh/VYuIzcwob2+8OSerdU8Afle8rnejdk2YebopEJGEFoqdMtINgylO0iIpKTL/UYLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779498253; c=relaxed/simple;
	bh=/A4hX39HcRR7SH4Q02RYznjGYalKTiQUMXi+zCxotsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmz9YtFZxSELKc7WgLt8sgNMWdrwxaRfvBUvGJclEScdhYp1vC/4MvwFp8pW6jLveKhSWTmtabQr+4x/J5nvkhvbSP4rh2G7rTJUZKacj9ghL5dV8lm25HeLVzviC2VsGx5WEjpnDhePLeQJfxw/Q1Md66fwJTHS5PriGbPxS34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fT1NcaLS; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fT1NcaLS"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M7ol6i841950
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 18:04:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ZSYPnXqPgD1WmWUsBlypXTMK46Ru/H45VtdzBiXsUQo=; b=fT1NcaLS0als
	V0CzITn5MusJzO7wCLcepvtcBFTpq0bJwdQSvOVtuXxphbNRdr5w4GkHaTzTSf3+
	1R03uZUVNbYR09SXtNfze33jf0vl16nQtWNHx7IejIEpQwTNM6Zdr4URIJIP4IUZ
	/MxPR0PRQGLKj5okI7T8m28gwIvEkhfg4k5DlHcYM4LKRk6uMqHrbOKc8yy5HHtZ
	5eqDNEm/6fylQhFYaVIcSOMFDFs1Klh81XfuQ3MBoRuhLL4csUmWciCvrsH6JK3j
	sIxVPa7SHf06LM2veBJyy78S1WcvHjVGrhiGukFXNTCVAfsoQEefzYCSC/aL5enj
	hOGP41Rqtg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ea3yqjp9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 18:04:10 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-479d74f0d95so12877033b6e.0
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 18:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779498249; cv=none;
        d=google.com; s=arc-20240605;
        b=UmhfND4MBwDzzEsfA1TdcMGJGYXC21hbMpJNX66p7F6SoNQ85Ji+9h9pyp+uoeuzX7
         IX1NqF4xwOvdY2uehUD1HZtmVXfTpsi2Ffgr7+fVvMI2ipu9naLA0o6yzRi8Efm6qt1C
         jrrQsxvaBQUogmnpC+noMRVamK5FS/JTALIf/Emb6MT5n5XrzPyD9/HeRp91wvk7mmdo
         /WV9jp5UWzqZwu1lQskgiLSX5GzV78UIa4AIsbKmuWbBcltFq9fLDJP5CzWnC0mhRXy/
         Qil2keBqCzh92c15Toh2qEy1X9CoKytv3z1uGzK9OQ8xE1JFXnYx2hHzd8XX+8Yp79vV
         HkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ckSywFlrQVuSq3t4EfSWLfDKEF0bsmOAyDZjQDxER6Y=;
        fh=1Cna6m3ygD5BPKORsve3ug/ZTanB+qNDYMEVRSV74u4=;
        b=RWTPbwee7vAt4CgZbAEAcTbqdLLQw0dXfePkAacAUp6/tMoL5OqaDSsx787dXG1Vvg
         daAZGWvumzDjJePEweQISLx8gpPUmluMR8QIfJGSkroeeWyyvQ5rzygnlr5wF93gUkGY
         Wv9t9ZhZ2+6kSsNnEQKPsUJ/QAS94ggLtoegU3vDHQPSpnkxzZ8G5XZoybR6vy02YyOe
         Vxbuzg4li1UnQcnY2doBb2DPSh9FjBdIH7cungQJmZklPe+8ChPUEkhAWDt550r90OAV
         4B3AgSRnPI/mHmYbFOleMMWQ8oYCSD03/0TkMOpAsoQVu5fYfli7g7n/b/2xCIP9yO7D
         lcwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779498249; x=1780103049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckSywFlrQVuSq3t4EfSWLfDKEF0bsmOAyDZjQDxER6Y=;
        b=qmWXp5QCEAbZeeExGVdOx7fvkAAOojrGIR1cZZjSQfWm3RiER3qTZmV+WX8LjwIgvy
         ZJ22nJ1NREf2NXoPcYBfFWfUebTZr1FO2tfjR4Z07DYLUZpmuucnZOGNRsnf7xSHmLCN
         nwSy9OhSxRzLV/9fY8KbhsRLABc4QBnEJl3FpGVk5eaKMl5o5cwyDhKUsdawcegzek6F
         Dmq9dlOQ50bhC9PulFAIj/b5mN+ov6c3FyDMS6xFwUehxF0JwbF8xv5nyK6JSOR9w7sr
         lcMCusgrynvKqn83QBWoqOTGB33iTyMQ7JDOpcByhaIPYk3QJV9//V31kD2J3/IBnX2q
         u4Pg==
X-Forwarded-Encrypted: i=1; AFNElJ8FUWzVgRlMo3SBayCN3Hjcz9Rd4M0xDGjwxNgRLRg89GkAAh+rArg9+uLcV0NwG256ebQ7xMS8Tew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyul4DtcKF1gpam8kotA+iGhZ06BiW1fN3w4ekbB5sam6OME2Nf
	IDwzhAk1wRzGawZG21+i4bS1/a5GQnUCU8X29dlRv0sGUi3L2zoWo3QxoS3WgEMtMQCQd3amjI4
	lKDm0qMQs0WAg9avR5dVTE6+G+DeIuzlXBghyY2RkAApQlR07tfkKX9nzjzQ3Y5ueay4MxQOGO7
	FR56HQB0LnUZUz6vTon5FEYFyQO72HhpnUt+o=
X-Gm-Gg: Acq92OGGZb3KYgZqCbK7B3lev18bTG7SIBLvWaGi9v5sAnXk8nJB+wiKaeaG5dMMgI5
	/lSdXUcLG/tDdsLRr24zv1jVQ9WLNHUyWLcGS4tH5k7SJ5ypdg8BZZpE638Zrp9VMgMdzDi/uo2
	L8gp6ORirTEiZcId/kmcEYKXI4UXkr/utLnVz6Xr7it9aylGTy5nMtTQelO9mNwyBSMXKxnqGEG
	Z+T
X-Received: by 2002:a05:6808:f0c:b0:479:de32:b310 with SMTP id 5614622812f47-48549902f22mr3459521b6e.0.1779498249487;
        Fri, 22 May 2026 18:04:09 -0700 (PDT)
X-Received: by 2002:a05:6808:f0c:b0:479:de32:b310 with SMTP id
 5614622812f47-48549902f22mr3459507b6e.0.1779498248992; Fri, 22 May 2026
 18:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519201401.1558410-1-zhipingz@meta.com> <20260519201401.1558410-2-zhipingz@meta.com>
 <20260521160412.4fa75406@shazbot.org> <20260521162437.406085db@shazbot.org>
In-Reply-To: <20260521162437.406085db@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 22 May 2026 18:03:57 -0700
X-Gm-Features: AVHnY4InmgAbt-a7ZIoyl3OFAhk-P34lQOEjx6K7zj7MuEim3oYM-YaMDsRZ4E8
Message-ID: <CAH3zFs1gh6UZewMf9GJ6CtO5v0yWNokp-eZQ8G2QnyAyxD7-wQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: S-dGyxAKwWupIrxUlNMPhQakgVhqJZyI
X-Proofpoint-ORIG-GUID: S-dGyxAKwWupIrxUlNMPhQakgVhqJZyI
X-Authority-Analysis: v=2.4 cv=NuHhtcdJ c=1 sm=1 tr=0 ts=6a10fd0a cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=LZULGAC3ikq4sroI4wUA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDAwNyBTYWx0ZWRfXywIZVmK5R2mf
 z5J6L+kR5mY+UsZB8Xg+PPJW7xBo+9yt6YMbtg2kjYsg3tSrcwJLCn5RO+hD1CkrI6V2YRacEOr
 F7/MhWjLhI3F7PRCjJ/qFEE/eRnBlE3JKyxN07T90wGgHyOR8IVyMBAQ/Zcd5XrtqtedWEwMZvc
 gM9e8x5eqbm8Wdh+s0M4xT/fc+Hr5f2EFbNpdZ1sueb3m6i5U+DE4WOwIfAULW48r5yIFHjpZ1/
 9MVEC6/2uClMxB1JXBEoGFh1Oo3oddE+vZKGE3O101+wReo/JkGVGj9D3TNtO7FMwFIipf4nqoE
 hZuUIFP0X+dqq2KoZMnd/i2srPIid16FiFqFhoRh3AhrI7/4nAJU1CZ67oNOKfmXtRyCmffwGUf
 xCx8SvPYIHY+EYIi2r521PcneohnlrjOTIuZ79uLKacI8tEGGxAC7WaRL3w+yBNbvYOObcm36Fa
 BfjDDqRBgKXylTNEDjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01

On Thu, May 21, 2026 at 3:24=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 21 May 2026 16:04:12 -0600
> Alex Williamson <alex@shazbot.org> wrote:
>
> > On Tue, 19 May 2026 13:13:49 -0700
> > Zhiping Zhang <zhipingz@meta.com> wrote:
> >
> > > Add a dma-buf get_tph callback for exporters to return TPH
> > > (TLP Processing Hints) metadata, and add VFIO_DEVICE_FEATURE_DMA_BUF_=
TPH
> > > so userspace can attach that metadata to a VFIO-exported dma-buf.
> >
> > This should be two patches, the first extending the dma-buf framework
> > for the get_tph callback for explicit approval from dma-buf maintainers
> > (who are not even copied here).  The second the vfio-pci implementation
> > of get_tph.
> >
> > > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > > uAPI carries both with explicit validity flags so importers get the
> > > value matching their requested width. SET is write-once per dma-buf;
> > > the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI is unchanged.
> >
> > I didn't see what motivated this write-once change, I thought we
> > understood that it was a userspace problem that the tph values need to
> > be set before providing the dma-buf fd to the importer and that races
> > relative to that are a userspace ordering problem.  Write-once seems
> > unnecessarily restrictive and there's no justification provided here.
> >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 134 +++++++++++++++++++++++++++=
--
> > >  drivers/vfio/pci/vfio_pci_priv.h   |  12 +++
> > >  include/linux/dma-buf.h            |  21 +++++
> > >  include/uapi/linux/vfio.h          |  35 ++++++++
> > >  5 files changed, 198 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio=
_pci_core.c
> > > index 3f8d093aacf8..94aa6dd95701 100644
> > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_dev=
ice *device, u32 flags,
> > >             return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> > >     case VFIO_DEVICE_FEATURE_DMA_BUF:
> > >             return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > > +   case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > > +           return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > > +                                                    argsz);
> > >     default:
> > >             return -ENOTTY;
> > >     }
> > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vf=
io_pci_dmabuf.c
> > > index f87fd32e4a01..be1c65385670 100644
> > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > @@ -19,7 +19,24 @@ struct vfio_pci_dma_buf {
> > >     u32 nr_ranges;
> > >     struct kref kref;
> > >     struct completion comp;
> > > -   u8 revoked : 1;
> > > +   /*
> > > +    * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> > > +    * consumed by the @get_tph dma-buf callback.
> > > +    *
> > > +    * @tph_flags is the publish/consume gate: writers populate
> > > +    * @steering_tag, @steering_tag_ext and @ph first, then store
> > > +    * @tph_flags with smp_store_release(); readers do
> > > +    * smp_load_acquire(&tph_flags) before accessing the value fields.
> > > +    * @tph_flags =3D=3D 0 means "TPH not set". Writers publish a non=
-zero
> > > +    * value only once per dma-buf and serialize via vdev->memory_loc=
k;
> > > +    * readers stay lockless to avoid AB-BA against the dma_resv_lock=
 held
> > > +    * by importers.
> > > +    */
> >
> > Can you outline the ABBA hazard, I'm not seeing it.  You're acquiring
> > memory_lock in the feature SET and dma_resv_lock doesn't appear to be
> > held when calling .get_tph().  There's a lot of lockless complication
> > here balanced on this claim of avoiding a hazard that doesn't appear
> > present.
> >
> > > +   u32 tph_flags;
> > > +   u16 steering_tag_ext;
> > > +   u8 steering_tag;
> > > +   u8 ph;
> > > +   bool revoked;
> >
> > If we still used memory_lock for tph, these could be:
> >
> >       u8 tph_st_valid:1; /* memory_lock */
> >       u8 tph_st_ext_valid:1; /* memory_lock */
> >       u8 tph_ph:2; /* memory_lock */
> >       u8 tph_st;
> >       u16 tph_st_ext;
> >       u8 revoked:1; /* dma_resv_lock */
> >
> > The existing change of @revoked from bitfield to bool has no rationale
> > noted for it in the commit log.
>
> On second thought, what dependency does anything here have on
> memory_lock?  I think we're jumping through hoops to avoid a lock we
> don't even need.  If we just want to serialize SET vs get_tph we could
> have a mutex on the dma-buf structure, or use RCU if we want to manage
> it locklessly and make sure get_tph always sees a fully consistent set
> of values.  Thanks,
>
> Alex

Agreed, we don't need memory_lock in this path. For v5 I'll instead add a
struct mutex lock to struct vfio_pci_dma_buf and take it in SET,
get_tph,
and around the priv->vdev =3D NULL store in cleanup.

Thanks,
Zhiping
