Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1A3358BE
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565759; cv=fail; b=Y+zjTY4r0qiOgmsSiR4NWWP/waCE8jwxZC4xrel/3pHokhtHHeS4/uB6kL1bIPBVA1JxIJMjN2fyuyJYEahU9RdRUaeXJv3J8gprYFjAffQDkUmyZOYWPnNXzrGm7LFnGBhlimyPgJCtZhkhjs4LNuul9nM+ATBLfhv/84/52+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565759; c=relaxed/simple;
	bh=BdyUGS9qVrZC2M4zs7j3VJuPzuCzCdpvDKaUG3wf5J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5TKORBIHI/IdxBEWLh0Z0btgauVIt4vIQoRIoEzsj5CgWuu7uIpzqwRaskFgkKDQ9jwR0gtjnTk5vAGl5LyFBmXAPlYPUwtweZyNtbllcR2Lx/AzmX9ExxUhD74Rq6uqla8pu3IEPdGr83CBfq5wDFywHeXgFMkW+JukFHs3oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=S+c8kVnG; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="S+c8kVnG"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QJ6v1k3537767
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 15:55:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=gWmaYzOqDIhtbUb8Zs5Nf1ednm4S50xRfwW0Jz6U+w0=; b=S+c8kVnGsspV
	a654lLZZ0b8EsEWQ7eZrMsM3U42hl5QQn43gPcbCwg1iIRVkzVp2dRFBMOENsKwv
	SFukOMCLHJB+BVExRhe9tAQ85TnRLm8BMieG/xu8T5GxAF4nxZYBRBXXNSu81mfz
	72IHHjWgJ7wrMUq4HLUK01uWKkwfjjbYiSew0OJdVYtTd9jpySKJMO9QYnD5wD1F
	hO4pop4o2ClGk5kOI5qvHHOrYSB5X7rKufRQLoSTlAVCrJgs3+MLzJEtviKWKK4E
	rl7jpexzUWHR2QNxm3b2slr+Jfm5udNi6cLbkjrHBtc/MhaQw/bPV2OzMvUx4TNz
	3tP95BR8hg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d51u79e54-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 15:55:57 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-46335278e7bso6244080b6e.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 15:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774565756; cv=none;
        d=google.com; s=arc-20240605;
        b=bWl1MPZl7EOYYCfoOZFWj/T5tS0zcL4fxKWxsgioiRe7QwMUklE1PBDNVpmliYyfs0
         5eIvPShcZbTzwiTw4m8nqj23bXLwj/azhUJJ98A0cGO93aqwUdYMjXFAXjGs/Z/P9EHG
         vGzwagtCXjZ+BXBcwypHWvWes2WfiNvez58KhwXEWzjt4aK+LHFOcBWIEi/ILj4uaSgf
         YHq7qtZz4XoWNmeLIRuMiunNsQyx50360awu/k+EP9I90Hn7BmtG9hyitIH45fapm9OI
         NyKgl+0+o1xf6UUlPw3uU3JlHp4b15PfjHHJ2/y63B1wKmnJ9mMlowpV6yD2jmZ3fx3W
         YePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=VGlyvxOOFksgPXoMLERC1kCayld4eO3E5k/3hyTOpHg=;
        fh=LU2kAide0UgDR4k1tp3usvn7kAqWo6o8SZpa5q0mcUU=;
        b=DiYBSn1wxts7ZvmZRN+aWfW/ONkCJ9Oi5IsMKz8GOEtfyUbZcEsX74iIhdy7HBOGeU
         mS+s5Ox5CZ8/rgttaMgKYBr4pkJFUC8gQxTQ4q8567cDzE/8Ssj+BI3eY+++8YbWhNjD
         XbqZbTtC8pq3iyldKrVcvw3mNlbjKsXyR17BkWQUcWTBS+QtaBrM5cWe+4RCIGuHKa4v
         iobccbmAra1O1n7bkc/iD+tLa/+rn1ES3CLiSy2wJce6HxrfkqzoS3QZwJDF6V6HmEo+
         DR3Z5vORdf/O/XlKpJb9NbU2XJtCqR9lvo1deAZjdD6iXQkfIsY1xn+OIRd42VhF4k98
         5CGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774565756; x=1775170556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGlyvxOOFksgPXoMLERC1kCayld4eO3E5k/3hyTOpHg=;
        b=eo3/e8owvWa9HqSWivevlO1kFhJCoha0QtmdB0JlKcHdCB52YHJwA+cg5FUyFHu+ND
         0PCkAKChc49eYj2fDmYjFX5WJPZ8v1OKa14rG7F0syr7GyyjvZ/XTFyRJvOOCGf6Xd4C
         hHvV6YIqN6f0Q+FnrZc3M4Rij9C+JZ01UGRe2XWm42CERsGeuov/ovK3iP+ArOF8Nqhp
         CwBe8tHZ7nsvE+txRG1e/exDESCgeNV1m1H2Hvnr1uGTGIIySBBbYJe1sUp2/FwWtQ75
         RxS8Bfm3PAncBk1KSZD2y2y4woPuz7yvS4KmORn1P14LFNaPT8qbQyXzgQ+vuoDiW1KI
         jnyA==
X-Forwarded-Encrypted: i=1; AJvYcCWX77PNAHQR9iYTbkPhCtVVjSThhuQXYupiXDJrcJL0ykQrJQQPVm8KBmc6B0XvNytCN5Rk0MFtKxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSo75z54TxlM21i3bbaF3dCtxiju1ab9S9VCFsyIxVJTOMh0BM
	RSXHnPuADAsgg2XEY77NhwTE8DWOfrgARL0cy2+BLfDVR8WoEg35Wqtt1+KYu4zZvhbfnIZy2iO
	aODcn/W8xcC1R6OYRwMpTniIKkSM28LprlLFPvk72gmDXCInnGiDdwZOKupPat53WX+dw6RYEyj
	lrW2zSasvUKNoKVF5N1Far4Ow+7JodMIjtoms=
X-Gm-Gg: ATEYQzxoHGNBAudpSxXOuIRhjJECCG0a9AnPg51OJBhwqcZ+XCaelalmMiaVGpHjrM9
	WYeNZGd/PnQDzY6UGgkBCC9Nkmp11HbqCY2QwheYPcebKVSMoNuUMV3twEtgFkICwEuH3kqrKbf
	ptuGhXaAWu0wWmbCjId39Q3knKfeDIgHbRGUJg3VbUV9Jg3mb4zBFX4keouov0bIE/lzA+txVEo
	FtuPVTqcryFZDmUYwFo+w==
X-Received: by 2002:a05:6808:1b20:b0:45e:fd68:3dd7 with SMTP id 5614622812f47-46a7aa42abemr1548513b6e.32.1774565756387;
        Thu, 26 Mar 2026 15:55:56 -0700 (PDT)
X-Received: by 2002:a05:6808:1b20:b0:45e:fd68:3dd7 with SMTP id
 5614622812f47-46a7aa42abemr1548497b6e.32.1774565755966; Thu, 26 Mar 2026
 15:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324234615.3731237-1-zhipingz@meta.com> <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
In-Reply-To: <acW2BwQKaUbS3eL9@kbusch-mbp>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 26 Mar 2026 15:55:44 -0700
X-Gm-Features: AQROBzDisNUSNgd3TlIskyBeYU1qigTy8IXoqXl2UWp2Iq9LIcNA3h_mkSfPwow
Message-ID: <CAH3zFs1nbAKpYxwzMcwpC_Sdy+3tE0n0wUzxJ411gV-q1O++qQ@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: iIjBq37o4ahcfNmUgNKH7WsNRdEGzvXV
X-Authority-Analysis: v=2.4 cv=cIvtc1eN c=1 sm=1 tr=0 ts=69c5b97d cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VwQbUJbxAAAA:8 a=NFdbOB6VLuGm633tFYQA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2NCBTYWx0ZWRfXwF43npQp8cGk
 dldh5IALlGNrH/73+Y9C2mgnCtonmHagnrASo1ubXWvsiBxXoE5vKBF39p9bbMRE47H2hEDXnhV
 g3bOpy5+ZaPz4oLlrh/nx4DtjNyl9tbcx/Cyt4F4NaDAvqro4P1tBGkpIF+yX4oGlhzG5siiN2D
 leu8hnpQ5SJmewO4hUzFSjGENpBALklAJzWfgvOMpm1OWRYorGqhbCVLqFbfaab0TJtb8qElDsx
 EH7POwid8EMsHT2qiRpRh5Gj8XiciQVRP0EARKArwXgWsXo0pXX0DIKsWPjp8t722u+0LsEDtHX
 cCXby6WkXneD2MM5+IKyOprAsk/bqunPL2Qzn9NaF9FslbXuFHwTImHiU3zLObrO/X0sVy2TPAb
 dE762TqBQwY0eDOIzPV3U61Dz0F8Padr2tz+/qChW53rg1Fg9KlUFDGND1WLcMuJFnCCd3hE5V+
 JCELHhoMq7WUhAHn1Cg==
X-Proofpoint-GUID: iIjBq37o4ahcfNmUgNKH7WsNRdEGzvXV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01

On Thu, Mar 26, 2026 at 3:41=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> >
> On Wed, Mar 25, 2026 at 10:25:34AM +0200, Leon Romanovsky wrote:
> > On Tue, Mar 24, 2026 at 04:46:02PM -0700, Zhiping Zhang wrote:
> > >  struct vfio_device_feature_dma_buf {
> > >     __u32   region_index;
> > >     __u32   open_flags;
> > > -   __u32   flags;
> > > -   __u32   nr_ranges;
> > > +   __u32   flags;
> > > +#define VFIO_DMABUF_FL_TPH         (1U << 0) /* TPH info is present =
*/
> > > +#define VFIO_DMABUF_TPH_PH_SHIFT   1         /* bits 1-2: PH (2-bit)=
 */
> > > +#define VFIO_DMABUF_TPH_PH_MASK    0x6U
> > > +#define VFIO_DMABUF_TPH_ST_SHIFT   16        /* bits 16-31: steering=
 tag */
> > > +#define VFIO_DMABUF_TPH_ST_MASK            0xffff0000U
> >
> > This extension of flags is basically kills future extension of this
> > struct for anything that includes TPH.
> >
> > Add new
> > enum vfio_device_feature_dma_buf_flags {
> >     VFIO_DMABUF_FL_TPH  =3D 1 << 0
> > }

yes we can do that.

> >
> > > +   __u32   nr_ranges;
> >
> > add your "__u16 steering_tag" and "__u8 ph" fields here.
>
That is what I did in V1, Leon.

> You're suggesting that Ziping append the new fields to the end of this
> struct? I don't think we can modify the layout of a uapi.
>
> If we can't carve the space for this out of the existing unused flags
> field, I think we'd have to introduce a new vfio device feature that
> basically copies VFIO_DEVICE_FEATURE_DMA_BUF with the extra hints
> fields.
>
if not using the fields in the flag, then we probably have to
introduce a new vfio
device feature.

> > >     struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
> > >  };
