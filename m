Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57E937F8C1
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816917; cv=pass; b=hlGr6Oo4CA6lM5xYXmj/J11XEefLvsUdYoR5YMmhZMzhCTxJOzqCjAV4yGhYoKvERK8WrqjH6VLIxiYkcEiYjSNIRhousxjZm72ToXGQ3Fzg8stFLwnBIG+c+Bfm4HCWQGhEeQkLv5HZ54yuy1tb1oOWhD+4WoK8NwKeXnXp3v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816917; c=relaxed/simple;
	bh=EElVO0SyMWfbu0TO/p9IG8++sd29PlCl+ReAKWNQ0Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omcwoUwj9/JSxMf2u5b8c16HrfpR1MMOCCp0i64Wl4GPGPLO/a6mNlw2J56TEMg8mMailGSK0Xks3cEjGiziVq+wKUjlyq4cH64TN72W4/M5/5QXvAUXRb+OYOystzj/kDZNv/HqD+SR1kzgGEsh5z6EjqYmS2MU3FLGQ0K6mmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1qvFaOH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwC5G5N9; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1qvFaOH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwC5G5N9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790816911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6337Slr26G9fWAkknUzN8X+fyx+rX5+fV3KYKCnIUr0=;
	b=J1qvFaOH/RPV6CeGVEkyUf0x+N8q3FSzEXHzvl4qkS+YfpkPfau7aPxVWzA20bDMUhVa/J
	1q9WsuLm2UYTnyOQmBUqIafPOpFDPIMjCb/mWE/IKT2eat4rpICchTlctwme2o07aJclLZ
	xHcPh8u2aa4MDBJzq2KuPqwNHCBpHFg=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-reHsGrNFM5-mYnWDRLdjuQ-1; Wed, 30 Sep 2026 21:08:29 -0400
X-MC-Unique: reHsGrNFM5-mYnWDRLdjuQ-1
X-Mimecast-MFC-AGG-ID: reHsGrNFM5-mYnWDRLdjuQ_1790816908
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1416f32fe11so5928809c88.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 18:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790816908; cv=none;
        d=google.com; s=arc-20260327;
        b=XkgEdCiXxheyWNUzH02JZDkXmwxDNbMR4eavsPKtt3C3eLDKaawzTJ4oFPW4JLDkNs
         3brJ5ZhLjEq1ZE6T3lb2TpJDUOq6gGd/rodB1uj5NblcDy03qt8mwPTpleTn8ZDWYMqd
         wcsEY9IYM1uWbmCtmXx5jlZASyJiJ6c0R330QtJIKFh1HH1RmllkMQ1eJlC3CfpgHycT
         zqbFFpsgTDJhS1U46sImtyhfgpdRivW3N35ArEisM4/J85bffHkdwtB90Hry34SjC9+h
         xbgFonYXm1L8M/LW1Xu3cv9wKe4oB40mc+RReNtcoxuYKQ4x6O2DHxVlpQyEZLUINDGd
         +dtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6337Slr26G9fWAkknUzN8X+fyx+rX5+fV3KYKCnIUr0=;
        fh=HhBYthnGSWlW2QvAzdg5Y+fHgAyXnrg5EW7aaeNzYpU=;
        b=shVQOCJyoRiKuxbyH9+gB01I6Zr5rYoiUcAhRGEewH5iGjeWKbjL0TDXHnzs+FdhL+
         cL5mmlg7cjsZ4lwJ+heYqNQrd0CDEcjYfCzzrPOEDGdqicKEyG6EXVqRCkH0aBeDSj04
         3uthpt59NPbT1yLVo1b6QKXWwQ7ButZGwPxLTtSJeONV0f+LaoVdhyR7TQ1t0NzBjKny
         sHrPeQFfMV/7FrMKKVHLcAg2Vpp5279V5nGTBnfKAMNBGDa/WuqSFg7G4mumrqB3ej8T
         EF+8rQjeJPM79Mkq9KtNmRn/SZCFB3VuJjGfcOhKpqOycRFAtpd7ciff2wqEsp49y4gD
         joPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790816908; x=1791421708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6337Slr26G9fWAkknUzN8X+fyx+rX5+fV3KYKCnIUr0=;
        b=MwC5G5N9LXKcAvgOKxeK9dd9ij90H4qO5wZCt33ZQLZjkCtV3FvoJYQ97PkJPi21Fj
         9Nvh4tNtHXnhigUR1/rSaAfsb5pMef/F136zHTonyewH13J/r7qBeC9XON1QONKwsNgJ
         XkMqUzG8/t+MBR34JJWKiaHVcfqXjhZZauLEGvz8V0Lty9nGlDuDcyUJPEm3CWm5J/Md
         EDvvBtR+yb32/xRKNi4l7Cei2n8bk6JOamnOn+edPNRTcapPOL1lhS0qjhR2/7DVE1Ex
         aPBNWV950Vd9IwOMJjwO67m9Irm7DizXxLAUn0U0AU8p14Xy8AzK3AbHGEnOj7kYXi4x
         f7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790816908; x=1791421708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6337Slr26G9fWAkknUzN8X+fyx+rX5+fV3KYKCnIUr0=;
        b=USm4Cw8MmAAl/Lp8K9tIJ7ogGShtMcIF25HoFrG7/3LEcPQKmqCKAr7ZpQCP882FXP
         0BLAiolWhsD+SM/A3NOouWvJKIuYuHBkvXlnvOCYGbhJwkGEU4WDp45WZORmqPh35njP
         KN8iORzgoErS2yIh/JSOyN1q+D83nSTxMDc/dse+pY7+6UX5/NCeB+tMhFKGVXcic4Rx
         emtxeIrUE7BvPV/yDeP0vfvTHBuWc1OVR4dd21cgzb/fypuBXK1PKisyngUjzEjLn4zc
         SxOHago3b3xqzeEM2wqQI/tAx3FYdpnKHRGcl5tTtYSgRthCj9Uh2BuWeuJXK0TtSd0Z
         YqsQ==
X-Forwarded-Encrypted: i=1; AKwUvBylWRBn3o0aRGoOpgSSwaLFyBsU6tIdqj8CU/3J/ikmC5G7+9gJBtoRCLx2g4JGAhYSwlUVc6u7IaU=@vger.kernel.org
X-Gm-Message-State: AFuF++lrgFGwOytsa2IymE7TZYTjR7KzApFuq4JOwYagTwj9AArJ1XwV
	KrtF8Kn62NBAWPzMksiMsqGQWKdeYHqRvKtCWmMoyRL/3BtjNxcELL7izYLmA8vRNhgtYYBMLOh
	BXTKvDkxY+itMcUHFqY73KiTOAMRzTRM4oyzhGmEYgBTWUcSyNZgFaC/o3TuLyIkpxwDBSStZeK
	Tz0SjJm4T/4xZ/bhvi7G1PnkQGqHezkULQMfNk
X-Gm-Gg: AYBFou1i16So5ip0iUojp0et7Thni7njJ7ZaiJUIrpeQ13g0yUbnLHhuWRsQFZRdbAh
	+TWTTiQG3XnWmV7/dLlKHsqxJ6qORwmVeQK/cvW2T7dZFXuZXBOa5Fg7vkR1Vhx2q9qUdVx6PVl
	cPRtodhL2J/vt5+zuUgruPTLPc6qALAkACu9pUcIyXBuVvEbYcwRs4IE2mZJPadFgTF8u1sIb/v
	L0npIqFzDxuzxv5
X-Received: by 2002:a05:7022:607:b0:13d:19da:9370 with SMTP id a92af1059eb24-14d3214813amr3682610c88.17.1790816907998;
        Wed, 30 Sep 2026 18:08:27 -0700 (PDT)
X-Received: by 2002:a05:7022:607:b0:13d:19da:9370 with SMTP id
 a92af1059eb24-14d3214813amr3682563c88.17.1790816907221; Wed, 30 Sep 2026
 18:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922071807.2533884-1-airlied@gmail.com> <20260928140028.02900e68@shazbot.org>
In-Reply-To: <20260928140028.02900e68@shazbot.org>
From: David Airlie <airlied@redhat.com>
Date: Thu, 1 Oct 2026 11:08:15 +1000
X-Gm-Features: AclHuK8H40xGZ7LDm4tWEaoZ7Fx41p0eMmMGmCD_ZHFdFpJFjKlkMOkwot6pi94
Message-ID: <CAMwc25oCKJaYaUOt32-xegXOjLbWMpk2RAASyZDj1ooh_41hnQ@mail.gmail.com>
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the decode
 callback (v2)
To: Alex Williamson <alex@shazbot.org>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"Simon Song (SW-GPU)" <xinmengs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 6:06=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Tue, 22 Sep 2026 17:18:07 +1000
> Dave Airlie <airlied@gmail.com> wrote:
>
> > From: Dave Airlie <airlied@redhat.com>
> >
> > This changes the vgaarb client API so that the user can pass a
> > private data pointer into the register that will get used in
> > the decode callback.
> >
> > This allows a bunch of pdev conversions in the drivers, and lets
> > some future vfio cleanups be nicer.
> >
> > I'd like to merge this via the drm next tree but also fine with
> > it going via pci.
> >
> > Signed-off-by: Dave Airlie <airlied@redhat.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > ---
> > v2: fix loongson (spotted by sashiko)
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
> >  drivers/gpu/drm/i915/display/intel_vga.c   |  7 ++++---
> >  drivers/gpu/drm/loongson/lsdc_drv.c        |  4 ++--
> >  drivers/gpu/drm/nouveau/nouveau_vga.c      |  6 +++---
> >  drivers/gpu/drm/radeon/radeon_device.c     |  7 +++----
> >  drivers/pci/vgaarb.c                       | 13 +++++++++----
> >  drivers/vfio/pci/vfio_pci_core.c           |  9 +++++----
> >  include/linux/vgaarb.h                     |  8 +++++---
> >  8 files changed, 34 insertions(+), 26 deletions(-)
>
>
> Acked-by: Alex Williamson <alex@shazbot.org>
>
> Preemptively, could this get merged via a topic branch that we could
> share in case further drvdata cleanup arrives in vfio-pci this cycle?
>
> I'm imagining this might also be a good time to push vgaarb
> registration out of vfio-pci-core as well.  Thanks,
>

Thanks Alex and Bjorn,

Okay I've cleaned up the last few bits from Bjorn, added lines and
created a drm topic branch

https://gitlab.freedesktop.org/drm/kernel topic/pci-vgaarb-rework

I'll send a PR merge this into drm-next and you can work off it as
well if you need to.

Dave.

