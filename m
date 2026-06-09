Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014F2E7386
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048896; cv=pass; b=CGcHEQ4jUgv/jGQ1LGt546Cu0/sgIKDPhkikQ0jl7PdH7H+hBdkNMfXoKfV6DXvlqdJixpmb6vKmS3CvaTOpFzqHK1NjTVdlXBtVONh+Wq43Fc3w3BPNKd4AK7tUNqvlLmaD0Pp/s3WyzGQ6Ztnwu1MB/BKbh1XXNCU7uC3/iDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048896; c=relaxed/simple;
	bh=rzFi8rHbjUN/4EV94L92+v7yzItUHCmPw4oD5yP0uJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEn6cAs5v2DhW8sEItyf3npfBn3GE/4z354BbOKlBKFB6Hf+NqpwotIczpleiBmDCE0mzRdfSEAt8JfT0PmMUCkV4U2qQHCuq6ABSgZRYqBQtdpw0uziDbxWlcr4kQ04FkQxUjbvVU4CBPFzMH3dDpotkyKgFfdW/tiJEJn1zs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OZKBis2V; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OZKBis2V"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ModJn1458692
	for <linux-pci@vger.kernel.org>; Tue, 9 Jun 2026 16:48:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=2oke7nd3qgzSpwUghUx6
	5sQAoKy1HMHaETHva/Kk8Jw=; b=OZKBis2ViNPY7hO90BNGQapT/XbUSMHitxwk
	n9XV/Gazcj+2wD9m1KqBMuPmB9/KzpVT1nBJ6WPualsEDo7qL0Vtzy+VzpzOy4WO
	VJIhhmj08GYtZwFIjFfi83tEXNicBAxgVk0RaCm2kYxY8pYZ7r7p0XmODAFwWTKL
	TQm2udjgflTsDrm3B3obBvMx4aAmTTMePMUsDel0/p/JTzF3k6rH2qDUyVCJv8XZ
	rvlRdpBmF/Gt6Ek/OaG5ScR5kK8TQn1MNMSEQ16qjRMigOILwgvGGUt7t+zhrnYT
	ox3vb1WsVoPy1SXQ5ySWLbIoP0woSdDUhL2pkCkc2mLTW+2m1A==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4epju84h53-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 16:48:14 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e71adbb398so234415a34.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 16:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781048893; cv=none;
        d=google.com; s=arc-20240605;
        b=HcfeGPCxZBVPlkVSDrwUtvpWbcfwz/mV1xFtx14eQ218Pc9Ng7heF59p4s8XPu/OyV
         nGK7ksk9jiDw2/D5dwtBnBQ+oxwgH/mQFUxTpfpNeC+htqvco1fDSe3rFsjejVn6WXP8
         xwcVmBeZr7K3XZ9oTI80YAonodMa6WMHadlOrrKn8Gl6fVUjwY6Vb8L6NyvB8NU8LWXP
         Q92SFNofDjDc/heeOBsLT08agfXlpSabhM572qt/M4wz2ruh59fTQ4M5J9NH82zSYQHx
         zvbaf+sEOyDNcaAVkZrypntQXjbYqtbc26apQ8TkLb3Bb3ySwFvR+LI1qjzyAf7PC5tD
         rW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=2oke7nd3qgzSpwUghUx65sQAoKy1HMHaETHva/Kk8Jw=;
        fh=mXNTybVv/6CProtdIrWPrKl0WzfVwEuoh+j+WZ/gqz0=;
        b=hp+8gbps1AgTGrpUBp1LOy3hBb5OrZoh/eBRVX7IiXt9QygO/QfX5jAdT0HjGdm1zd
         rmNl2pocIth61zu0CrHDRVXfpSiZykPL2luJ7FNOtWrVLHqP+hsVPraiJRvpuhn7RAQZ
         zk0WdPdzfHelGvbuk0TF0DYMbFozcPFbLNgJbLVsIfxxAZphLDlX+4PO8cskdN4AkAG1
         a4D9fhGKCKidk9NW3ErjHeZfsiQyNILY+bFn7dn2UVkLhbyeIfcEHPIwk8oH/p68Epgm
         ErHrovCn5K6sr05hmHSAbUruP/k73LNTGN1d8kmfymSV8a06q2dmD0CZslK3lIC3fGe2
         DnAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781048893; x=1781653693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oke7nd3qgzSpwUghUx65sQAoKy1HMHaETHva/Kk8Jw=;
        b=CdLb0OV4P5pdU1sbCmfHhmldret1rKMJ2bmHezyOmoZrbRkyU7qXA2Yh9FEHWtHtEW
         d5abQqMGAvo8USeaskVnJ16dDeW5+7E+pvVMRKPEikmAoMq3NrHMpJkjgihgXzIqNCiz
         q+lqJVtGi2uAk/QPXrULgBEZYtjoWJiPuXDqbGF1GrOenojk7LaxhZ83SyrwZ5QmQbWl
         vvsM/xcfoBwrf2+ETzT+rPLWgnTwAW/6gSuhlSLT9Y9P4g5czSxEe0jXcF70VmqrkMuu
         Qak3iZArZnC9T8s5y/vr/blRGn8uUgLwDZhWlPmIthLm+9Rp6Zx4oItJvYuVHl2nPzXK
         Knsw==
X-Forwarded-Encrypted: i=1; AFNElJ+fS/GlFA97Z80Cabp/84jV9hQQp44+1x2ErJSrEmKmndzDX83VYBNa+ic/xY4DAXysVWXJYlOPSXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysC0/0T/Jie9jTe257y+vFuOPV6ZTMFkwON0CvOZpyNv46Jip5
	jDvaA45j65/eo8ZqihRdqvrUMGriF30iuX8daEg60ONIPqmEF1t6Cp3onvI8U6kJyKlNxQMjwCJ
	96Ez33n9dlzPYsiVRofFsSnZN+s/dwsYbthkb+rhxLuznHYRf37ZeHapDV1pN8bboQkPKmUylpP
	Y6pvmQgxjHFLtULkbt/p8ljQsA1mdfs+7H7Yw=
X-Gm-Gg: Acq92OGI3e0W/dIMzEIp4u0awMCW8K5leJVcwEeYNEevhzzffd2zzJ6OiMWrq+laonW
	SvsZSOj+G0+xvX2UvqhS63ccxI8KKrgVZrWuy7wMzeajJ8eJx7dtD38t7bd8yaVnWspTzB8TX9B
	d6ZZaS3/6nvIJzPMUY9g3XeCoJAZqMwtvzFyLphtUrsqQZ+Jp2k/uagbvx1vix7rYUBPIYUMk5b
	V+kQhk89+qhbcJy5J9FJRUS94Z9CQ==
X-Received: by 2002:a05:6830:4990:b0:7e6:fdea:7aee with SMTP id 46e09a7af769-7e70ca37187mr16012137a34.24.1781048893426;
        Tue, 09 Jun 2026 16:48:13 -0700 (PDT)
X-Received: by 2002:a05:6830:4990:b0:7e6:fdea:7aee with SMTP id
 46e09a7af769-7e70ca37187mr16012114a34.24.1781048892924; Tue, 09 Jun 2026
 16:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com> <20260608185646.4085127-5-zhipingz@meta.com>
 <20260609154634.46ee8328@shazbot.org>
In-Reply-To: <20260609154634.46ee8328@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 16:48:00 -0700
X-Gm-Features: AVVi8Ccv--t4yFPwVmIF6GS96siJpbic6hR37JvTtMZG4eYFQdBVvAgfn5CrAeU
Message-ID: <CAH3zFs2UEpVV2MDkPvd5qW=OAFZ=MFMn1FTTpGa=sM-Kc8vcXw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
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
X-Proofpoint-ORIG-GUID: d7YSeEqx1wkIOy0bbo_nSEnCLGMXkBvX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIyNCBTYWx0ZWRfX7gA7QAZ/hslg
 C9s+tLYOPLtH0F6Hc3PVDNCjY7PsHyeAvJdV3fBqCIGr6vs8cOAf4J/WB2FtwEQK21OGe+fyTgO
 ieTKIpeYHBHKDtXrsiuGFapGcG6QXKpX3coFx3xQT6R0IYLtIS09QZ3hAtIoRK1fnoDCzy3zHj1
 /v9cxVrxP6HI2Vp3pddXtuTEEt8xl2cc6Fi0wu05pwPEC/21GwBcHJYLMsHsNCFxsfqVlSY4wrj
 m6BTaJFEpL6hmWE3cjUm/s6rFSHkZ0yP6LbP5zQePT8HR42ZIBHxjfASYCtO9aQDUqxiIlVD9Y/
 A85qS65DK38++eWmK3GGdgPjjCY9uJSQk5xOHUhFVLuy4BUYLQmjcMYi+qqURwGCe+qTctSSp4n
 4Fyz/kxxHua1NM+kyaeTHNUWDWvwbArsLYeAWwNHVcxZcuQHfZEDicw/WPs18G1/CdpaHHCWDgD
 d1u8k72IxByjRZweGTg==
X-Proofpoint-GUID: d7YSeEqx1wkIOy0bbo_nSEnCLGMXkBvX
X-Authority-Analysis: v=2.4 cv=cr+rVV4i c=1 sm=1 tr=0 ts=6a28a63e cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=Udk1dkG43rCpktSCSPQA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01

> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_tph __user *arg,
> > +                                   size_t argsz)
> > +{
> > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > +     struct vfio_pci_dma_buf *priv;
> > +     struct dma_buf *dmabuf;
> > +     int ret;
> > +
> > +     if (!pcie_tph_supported(vdev->pdev))
> > +             return -EOPNOTSUPP;
>
> This tests for the TPH capability, but the TPH capability is only a
> requirement for functions that generate TLPs with TPH, ie. a requester.
> This feature is about providing TPH steering tags when the device is a
> completer.  Bits 13:12 of the Device Capabilities 2 register indicate
> if the device is supported as a TPH completer.
>
> Additionally these bits indicate if the device supports standard and
> extended TPH, which means we should not only fail if the device reports
> 00b, but should reject extended steering tags unless the device reports
> 11b.
>

You are right: pcie_tph_supported is not correct here.
Let me use a helper function to return something like this:
PCI_TPH_COMP_{NONE, TPH_ONLY, EXT_TPH}.

> > +
> > +     ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> > +                              sizeof(set_tph));
> > +     if (ret != 1)
> > +             return ret;
> > +
> > +     if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +             return -EFAULT;
> > +
> > +     if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> > +             return -EINVAL;
> > +
> > +     /* PCIe TLP Processing Hint is a 2-bit field. */
> > +     if (set_tph.ph & ~0x3)
> > +             return -EINVAL;
>
> Sashiko notes what appears to be a false positive here, the uAPI states
> ph is to be in the range [0, 3] and nowhere else says that it's allowed
> to be garbage for a clear operation.
>

Agreed - i will leave it as is.

> > +
> > +     dmabuf = dma_buf_get(set_tph.dmabuf_fd);
> > +     if (IS_ERR(dmabuf))
> > +             return PTR_ERR(dmabuf);
> > +
> > +     if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
> > +             ret = -EINVAL;
> > +             goto out_put;
> > +     }
> > +
> > +     priv = dmabuf->priv;
> > +     if (priv->vdev != vdev) {
> > +             ret = -EINVAL;
> > +             goto out_put;
> > +     }
>
> Sashiko notes this may need READ_ONCE()/WRITE_ONCE() semantics, but
> that may get fixed as part of the resv lock usage.
>

Ack.

> > +
> > +     scoped_guard(mutex, &priv->tph_lock) {
> > +             priv->tph_st = set_tph.steering_tag;
> > +             priv->tph_st_ext = set_tph.steering_tag_ext;
> > +             priv->tph_ph = set_tph.ph;
> > +             priv->tph_st_valid = !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> > +             priv->tph_st_ext_valid =
> > +                     !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
> > +     }
> > +     ret = 0;
> > +
> > +out_put:
> > +     dma_buf_put(dmabuf);
> > +     return ret;
> > +}
> > +
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> >  {
> >       struct vfio_pci_dma_buf *priv;
> ...
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 5de618a3a5ee..0ca26721849b 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,51 @@ struct vfio_device_feature_dma_buf {
> >   */
> >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >
> > +/**
> > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) metadata
> > + * with a vfio-exported dma-buf. The dma-buf must have been created by
> > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must expose the
> > + * TPH Extended Capability (otherwise the ioctl returns -EOPNOTSUPP).
> > + *
> > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_BUF.
> > + *
> > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) are
> > + * distinct namespaces in the PCIe TPH ST table and may both be present with
> > + * different values. Userspace should populate the value(s) it has from the
> > + * firmware ST table for this device and set the matching VFIO_DMA_BUF_TPH_ST /
> > + * VFIO_DMA_BUF_TPH_ST_EXT bit in @flags. An importer requests a specific
> > + * width and receives the matching value; if the requested width is not
> > + * present, the importer is told TPH is unavailable for this dma-buf.
> > + *
> > + * This publishes the PCI SIG-defined ST/PH tuple for a VFIO-owned PCIe
> > + * completer. The dma-buf core treats the tuple as opaque completer-owned
> > + * metadata; an importer simply requests the namespace it supports and places
> > + * the returned value on generated TLPs.
> > + *
> > + * @flags == 0 clears any previously published metadata.
>
> This is overselling the invalidation.  It only flags the fields as
> invalid for future get_tph() requests, it does nothing to clear
> previously published metadata from importers.  Thanks,
>
> Alex
>

Good catch, let me re-word.

Thanks,
Zhiping
