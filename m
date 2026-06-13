Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4D36F8F7
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389517; cv=fail; b=nUZolj7yY8iANiXQKf8ZJ0daBGG9XQP9fl5P9igmrYMXgAkwLgHj+mQ7BsQBujnTwR60g0Sm13CBN88sSB0Fm1P8STcM0pJGi6BMqQLbpU9QS/UtJpmzpRyoiwcZSfRW+7rNSd14NYLdkyXNN8LqWCP+JeNHC5CSNgmTZ7vexG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389517; c=relaxed/simple;
	bh=1bdEY5yxv5t9XP5TtCJFWuEDTtBiQLjm4/B3JBKM7qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fq9NfQxl0FaBllYzskWHHDefh7i+xs126aE0NBDPjKoIJG4HLLRd30CBwmF1s5lUM6TF36WqQHuo7oEzu0tjhDGZKfVs72D7sezF+Y4gJnD7pYmVobOeNlUmNP1JU0Ue7lJjBEMb1WpfFDSa24yzMwzfzD0Uc/Odv6+UE2PB3Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=igpbZWWh; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="igpbZWWh"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DMBrjA1799734
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 15:25:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GRdIE6LSM1bH8RC9lncAbOJ2JdACIXbSk43KFW5xUf4=; b=igpbZWWhgcAG
	UQRhHeAkQUcQT9YS1C1yizMLyYubisFvGTIHjvXAP5Yq4zFuMdy0J6izagbAVYGE
	Oh4Rla1pSyswX57EwIqs6wjhCDpr7SSai2oeugc/TSvmNQ5+HA4Puhr8hB2sZfKm
	K24vuXIvlgHEIVuujAPmgQN4D9olXWM87UFrSbGJUSfPnONyzsT6/QOd4nUKplB6
	+eaVfmM5zaV0rySMY0pM1OEcco2PwpNZ4z+evfY3ySdK+6zvdWUdR9NvkMhTpJgz
	2PddCQmkEQIS46pCY7lwRWXYNf7regn3XsKqdJFxiGmJlAP+qmzk4l0OhsbMgxA/
	LQsjKjm8TQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es37yj990-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 15:25:15 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6db540d17so3757247a34.0
        for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 15:25:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781389514; cv=none;
        d=google.com; s=arc-20240605;
        b=GpKktdiVkzeqjfnJ06WvwpXDMPr66dFnw6FkrAY4D+KgDSxaZRLcYXWIUFJ/70hQbN
         4gpcQcgPP1YWMCpwbigZ3MltwtuVruWnZ6CqroUkt7f7PvYfPjtj0jQMb5qlxLwi30ms
         xzfsFd54pPFT9Vy/TWez4Xk2QRuuE67j5oEA/6Zdy9b9VXZvYLTIviY+mYEblh3olyhj
         33K12JTPu53sqQSh/3WeZSMSKr5Q4DBGferRhPJQzEZsF8Gxd8jJboe8S6HzVSLR/9dv
         dtw7KM8t4nlVPByInyQRtK4McOG61u351twI76AUm8xgJppCO3L8AupjpyPWoDjxByf1
         LYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=6/EAQqigRSI18sLOr5BrBLiEKIx0cvrRCkfg6C7SoSw=;
        fh=GyBzJbRZNtu6GHfZmhyV9eCA1iVTjZXH53FYmhTbsfk=;
        b=JruT+MfxAoWBSjwAOt3jOOukHSUhp58+8Dyg2mfUrV+Qrs3Z5oceGf1pJFVPrcAp93
         UVIu5TgdgnzGMjGGey8vWCZUCga6xJ5i0hY6bhhmnbk0/001kZ1bI3O09fTZ0VwjZFOp
         Izwt7Qm5iYZVOshOnyZ8iyJrE0TG2ix3fLvLK5LGqWJ6kppmXm6HM1tP9g3ILrlro2ma
         Y6kzMjDouNW2BTSKtlpFP8Dwg+CmVtQFAr5AqHuDutv/ODucga6LcnrqV9s8fPhabsEx
         3+Lw4ILRDcHs4ioqNmcxvOwivnCAuKyqRuWgj0sDIbN2T7sM72RxOc43iw+DalHeSiKv
         gKvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781389514; x=1781994314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/EAQqigRSI18sLOr5BrBLiEKIx0cvrRCkfg6C7SoSw=;
        b=aT083+5XWWPIkF7hw59ilJza6xngFeeSZfCOfKoC2abY/x0TihnKeWtReHZ0Nx/IEi
         bPUncrhKXAsKmcewKdGUV1DrdBOxsaQBHHtA/C6Q0p/NYDcbmGpTf2IHmHtAfp5qR1FT
         Ui0S4aVYKCzbJCsdHxC4l6uvladNiziIWU1raweGiAqiIg90PU9oZqpkad309a6UMJ1U
         SekUfry6xgSk+zRimvtDhZASRA+ZgTRz9saGRibfBK9RDysRZBS8PWuj1oYDmN24HpnA
         yBPL5G62a9cWFuWU5hIofq+eI9Zs2ryluUVjuUgv2PAqPLRsLM2KVFKp0Rj8IPlB3vlw
         eCrA==
X-Forwarded-Encrypted: i=1; AFNElJ/4rpwPozMll4w14m8TXTSPOP6sUXEfX5ROpWSBmQcsPlcxwO2FO1ZaN2ygeTFVwkr3mcW00rePQkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ialKtkm/ncfAUw/fKTbDxCpR5xOvPVlJf/IFld2QIROQMFky
	iE6W+IQBBOKali8KD1f0Piu5jpW4e3ZBzDQzJTq0LikVtPTrXyayqs4ztG1oYWRIgCvr4YL7ICB
	cGr00SJOz2grYvqEpNFygROAay8TDkP0LF1n+08jQtfFVyZ8/HOReuSzVYf9gxCx8k3xrkAomEC
	LhApkApE2cP5R7svYEvlHu+KjNRSgIKLU5OIg=
X-Gm-Gg: Acq92OFt8QPkL3L3aearn+crzS5urU9O53jURRwVlHykbc/U088urOgsaDnuWYA+OQ2
	UWc8Gs/KHcpMxa7v54mMbkoxqqM9S6hs7lnUhfwIYd8yz25wtTaSiRiSfGHBKlNZBOjn0eeTA6T
	YNQY7/L9bNepLw16y5syJw+PefiludjD5FwuEp5HPkqCGx6yoW5LDa9bGeTk+n6nwbm3GUP5mQF
	9bUCCfC2rd+XlqCglL2RQ==
X-Received: by 2002:a05:6830:6187:b0:7d7:fd71:f2e4 with SMTP id 46e09a7af769-7e78e75e354mr3483169a34.14.1781389514250;
        Sat, 13 Jun 2026 15:25:14 -0700 (PDT)
X-Received: by 2002:a05:6830:6187:b0:7d7:fd71:f2e4 with SMTP id
 46e09a7af769-7e78e75e354mr3483152a34.14.1781389513778; Sat, 13 Jun 2026
 15:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161546.4075580-1-zhipingz@meta.com> <20260611161546.4075580-5-zhipingz@meta.com>
 <20260612111001.5b7206eb@shazbot.org>
In-Reply-To: <20260612111001.5b7206eb@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Sat, 13 Jun 2026 15:25:02 -0700
X-Gm-Features: AVVi8CexW_WJJGnDTI4HN0FLeTaWayUrCy_spJuvDIJixjLtGyyKLpDTD_UhDYM
Message-ID: <CAH3zFs0Nr6PCEVj0+iyAt6bdOVdQCnmNOCVuJ-5v7xAtKFuXMg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX+08olPmcTMOo
 PFgcYP835g/bjZSQ6M5O2t30UfRbQaeemJ22Gtnvcvt1BjguanAk0zDhhSyiid371Ik8eXn1QFv
 bhDgCIJ1Z/ZNp6vU+cRQ0iqJxrnYWnGyy2aqV/IUg6+vqGRtYkrh/cFPC1ABOdU6NVCnI+ZuORr
 9yjXYIiue9pNibOk9SAPSoIjPCaxct0LRP5aRZYVkq4+gRO1xKWZwHvj5FWwzcYhFCI/dSMc6rX
 dIKDEzmOQlVjVzLx2bExyQQlKbrhUEPloDCRzTmVS8AI/bCYgVB0qkKmEHqrQEwa/N/8zA3jjRi
 O0sTZYkaCrLtrssHQ0o2ml+qQxDXr3KkdsR1+bNfwg64LymorYJnfwrX8QNP7LLPi/lGEkgFSVs
 DEsCLYtaM+KxYsIqwUjneI/mN2z+g7Ss1BIqWjWrrrlrSkwMjOGunrffOh6yW62mtY8Js34q2ps
 N54Uf2l5Qg9HWtwaUkA==
X-Proofpoint-ORIG-GUID: OiVEzqTJBSH6UQ7Xba4nbFeYdVyYTQLA
X-Proofpoint-GUID: OiVEzqTJBSH6UQ7Xba4nbFeYdVyYTQLA
X-Authority-Analysis: v=2.4 cv=bMom5v+Z c=1 sm=1 tr=0 ts=6a2dd8cb cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8
 a=e6IX7qM6bnzC-tgAjTwA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX4TW7Mxae/wTD
 TPDUsNw30cz632JeG5X7xyhKjOwOkTROhFYWw5tut2RhSvdRmOqLcLXvoTGXrv7X90Q9DVnPo/Q
 q7FI5/9HZeOw3cSSNtoezIHyKv+IxP8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_04,2026-06-12_03,2025-10-01_01

On Fri, Jun 12, 2026 at 10:10=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> >
> On Thu, 11 Jun 2026 09:11:19 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Implement dma-buf get_tph for vfio-pci exported dma-bufs and add
> > VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> > for a VFIO-owned device.
> >
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > uAPI carries both with explicit validity flags, and get_tph() returns
> > the value matching the importer's requested namespace or -EOPNOTSUPP.
> >
> > Publish and read the TPH descriptor under dmabuf->resv, matching the
> > locking used for other importer-visible dma-buf state. The SET ioctl
> > takes dma_resv_lock_interruptible(), while the callback runs under
> > DMA-buf's asserted resv lock.
> >
> > Reject requests the device cannot consume as a completer:
> > pcie_tph_completer_type() must report at least
> > PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
> > PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Validate fields before the completer
> > check so userspace gets the narrowest errno.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |  3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 94 +++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
> >  include/uapi/linux/vfio.h          | 37 ++++++++++++
> >  4 files changed, 145 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index 050e7542952e..4fa36f2f7555 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
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
> > index 1a177ce7de54..0a0705c8dbea 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -3,6 +3,7 @@
> >   */
> >  #include <linux/dma-buf-mapping.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pci-tph.h>
> >  #include <linux/dma-resv.h>
> >
> >  #include "vfio_pci_priv.h"
> > @@ -19,7 +20,12 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
> > +     u8 tph_st_valid:1;
> > +     u8 tph_st_ext_valid:1;
> > +     u8 tph_ph:2;
> > +     u8 tph_st;
> > +     u16 tph_st_ext;
> > +     u8 revoked:1;
>
> If these bitfields are now all protected under dma_resv_lock they
> should be grouped together with a comment to that effect, no need for
> revoked to get kicked out to its own storage unit.  In [1] I'm
> proposing runtime modified flags each get their own storage unit, but
> for more isolated cases, so long as we keep track and enforce serialized
> updates, I'm ok with runtime bitfields.  Thanks,
>
> Alex
>
> [1]https://lore.kernel.org/all/20260611213539.4100590-1-alex.williamson@n=
vidia.com/

Sure, will group them under one comment.

Thanks,
Zhiping
