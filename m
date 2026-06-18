Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECC331EA5
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763006; cv=fail; b=YtVVMrSdnOx/tvV1A1ho/w0UIoFlYY9bq8tMmAPlODpyvTip/jvxCq+IrJH2xPmNBuwm/jFfgwyeQexsw/tHStT9mg8PvKQoXWZxHYxwlgTH54S7bsh5Ym2V1e6fQ//xk90ofKEvvix+gRA1t6X4EL+H/a0gesw+QLzdg7+ueps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763006; c=relaxed/simple;
	bh=6/T0Dclshlhmnc1UxrEhCEHM4cymDyecbTC6Ux8+uFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPIyHUXHNfNdorHc/GRLPRIXB6d97OCRzJUvQdKqyIdDOMx1sNxN+SN1J3JuV71FFcI6wui/o2JatU3hoMd9b+iyDt+NDOyaGfEY/jZAwCPboRNIsqmjUu8AEwdu5xq5Nze1OuAHj046UV3z3UtEN8LH8U4CojD7zaOF3DvS6jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=v/PNqA1x; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="v/PNqA1x"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I386Fu1659601
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 23:10:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=6/T0Dclshlhmnc1UxrEhCEHM4cymDyecbTC6Ux8+uFA=; b=v/PNqA1xBXvG
	hxasA0LzJ8yq94mP/vLG9ehEDNugAO22PhggvV4w6bqGrDNdz+I5GVtpeVimerEm
	uQBbADRTqFkt4j39n2wuBQO0TJMx0k/Ngsr/XypO3PKVRwiKmvh4Fej+Aga7MC9b
	SW5npdoy0mfJQ2gKUZm2NjxDs+U6T2IMmgYmFXjYTvdZIOpbnaLPBLLnoXNEvfc7
	iabwsALTLrmBCaTpNjhGZBs9JP2hcI6hMQgOEm5TRf/VAIkH5wj2q3y76PUcwfDQ
	7Jhe6K6dHnRe/0Myi50bJqPCe/2OBqPV5juk7YchPYXVwYkfOdTu4kMRyv7cWYYL
	TS+Mvy0faQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eueg79upt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 23:10:03 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6cea6ada5so1365933a34.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 23:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781763003; cv=none;
        d=google.com; s=arc-20240605;
        b=gqKYwFh/MXK1Sl0wwfNHjdc7I+AtQVp6Ed2U3TRjw/h7RG4mmpozwu99cqCA61DYZw
         rbKBfOC1HcOjDszrBmkP2alCki9NKgSbjLYIhAjtQRw4596008bvfiJX3HYLM9p6HWc0
         9D8A7sTDN/FUJ3TlSs3UMxZepzkSK1D9swWnGO4nE5Flr+anLVcAZRDF5i0ydzNuulTW
         LghqqYXJBTft7ZfPBp8PvP98ejajlsthWUMXUV3XBl+1/cxN6FaRJS4t8rsHcDJzE+bh
         TRNI+t90vQyGkmZgXfE4AKWhp2LbBYSVWJQqpKCHocxYnhWhvprY/fCblTvoWZf07SsG
         zjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=zpTmQ37GmXWdpWUeDrqTjiaqwbJfjoWYHVp4s39Z4p0=;
        fh=LshX/iVJYh1hq6Wo1G9DSyUsmmQOV+jEUsCbbQDZiC8=;
        b=jWUN/XpdrRAqm50cfL9W8po1ZlTLnymOnFNda2N9bLOZ6jEPQaxbJedT6Lf+XCFKJq
         tNB9tvCqiM3AHMGCu/EME97e9pcs3UqxszKOESVRlv8x3rx+H+PBor+DBa/bvFAnpLVW
         wL69WOgtvK8VWH2dX8hrMy9ntl6oAml7gO6QnH8MQ/DXDURgfaFwGzyca2FnDhKjZnQY
         h7+x3pIN/27S7chiW3eXjVGSNh+Pg/ltUWNdRRYgyG/pQ5jSmQyK2Ospn8DqZfCB+lkK
         dcFe62CL2+XOvmcm6IeVulHqE9Ni4oUdKlIM4B03oDDVqrCX/yya/b3v3OTouJpJH88y
         NQIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781763003; x=1782367803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zpTmQ37GmXWdpWUeDrqTjiaqwbJfjoWYHVp4s39Z4p0=;
        b=Bq06V1V4QXgURjBqNgfEu1uYiysvq3d652GrYsj1GW4/cW/IZ+jHE3H0iDS4Ua2B0d
         hIDTiI/qxSD+xU5i14A95Esqa9OKfkkCNENe8WA2pqT5mWgcFRRPJR9YWI/f1Wk2quOk
         +X0V1USmHuAkliy0Sbh1bhXvTxeqwnAEqmCDjpOgz6GFQQNUkKKih7S/JVW77ME9RIZn
         xU983VRIvsGorDUPIy2rVtfgakKpm5Sayl0+IWBEj86qWAJKgXkip5P1dXRRPCVtZiii
         u8JjoWBi41IvlbpbuDABAgkoStEPmKrhMeXmZvtEHpgz79Ji+3K3b/i9w4z2Ey8ncksi
         79sQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RpdVP+MIIBENedX45RTRjZaRodbyGvqIfaCFPXWNjEIPH1++Q5hw7wM21wehx7ZysHyfCCU6FdqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGYCFfJ872U8iynHU7et6MMZHdRhlF3o7jZKQGMZDzOadIwE/
	PAt6zmR2NZhLmqAGJU1IXVZXHPTwkCThxaBcZz5r3YXGAtjk/8xBJmFgSE5cHNqMY461uei3ueL
	bJMhg39P1mnYiFJSd4QL0hH4rAba6cAwz2/f/besLBPKfqCNTKc7goFPFLHPGgqDoi1CtJwL6ZG
	UTKgwXJWnWrPXW5muK+h40HMIcACuBRaWBC/c=
X-Gm-Gg: Acq92OGCQGbYchGxDZ+SjZ71HFNxZBt78iW9fjxOW/c9HJNfwSq0ZZfzxLYWpOHDais
	AJOkC1MltKHlzPv3oegOaLuaKADhC0maLN6RKD55htqeF/MfRQrTaJlXWmheI5b6MGMbNN7Mqck
	pAdEL5xr7CP6xeKy+xKgHrbuwJAZ3/3HH8mF3bJBE8mMzScgbIhVK8xTmKVUs9IM10Miwf5Zm21
	hjMCghvr7Dzg46/RXgKVDLIafPD0A==
X-Received: by 2002:a05:6830:67f5:b0:7e7:57d8:a8c2 with SMTP id 46e09a7af769-7e90b3b9930mr6882343a34.12.1781763003208;
        Wed, 17 Jun 2026 23:10:03 -0700 (PDT)
X-Received: by 2002:a05:6830:67f5:b0:7e7:57d8:a8c2 with SMTP id
 46e09a7af769-7e90b3b9930mr6882279a34.12.1781763001909; Wed, 17 Jun 2026
 23:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615065912.2177918-1-zhipingz@meta.com> <20260615065912.2177918-5-zhipingz@meta.com>
 <20260617092550.GT327369@unreal>
In-Reply-To: <20260617092550.GT327369@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 17 Jun 2026 23:09:49 -0700
X-Gm-Features: AVVi8Cd9LqQxIAml-YNLrnCpxwyq6SYcSY7qEQ2JpeKmDJHK_hh3DSp6GvPOQmk
Message-ID: <CAH3zFs3xfc5k0fhgedCpNAfgfoAvfk0V2pF-xqA1_Q2sGkLnig@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX7z4T5crwiG+Q
 uZm1hI67WJYELgifjn0PL47Lf9+Y7yrBoLDy1vguGEr6xvaJPt+PCu+at60IzvQIdHcrWgmj/HD
 yyisrD/KpbPvQ/EF2K5BhGmFzhAuXcs=
X-Authority-Analysis: v=2.4 cv=NZfWEWD4 c=1 sm=1 tr=0 ts=6a338bbb cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=VwQbUJbxAAAA:8 a=wthcJ2XvByERRjf4MtwA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: OswEGBWYMY7u5Dw7h2HpCvUyVxXvwVbw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfXzyJIbWQnpW4O
 M5lmxa2xanzdF68z0hcNSGnRPLdH1EwIfU5KgSz8sOuaQDWcsNo83jmHEU15l0gpgjoxCfSP5kq
 K8BJeQvsRDGX0KT6N7XEnR+/ZGuBSDrZBHUgEghBiffvofV83GK0mzjeJmt8YCeyvpwf6J+680o
 rWgEtgAPoXBmni1c44r4nj0CRqePsLksewMhAYSWnxudgk6mWk9xCovxkPIMefcA+TeZherfYpW
 G5pB3YclhHprBhQTT+OtN7KyDFuZ986kXsB2OwFdJi9QfxhDhDw1AGBo8+tSMrkll0Tibp0w29h
 Mz5xrpNUUvxpIrU1fDSe9ecQu+Cnu/RzBq48G9Q4EHGewUhieHkwNw1ZyzarsJW9UKEzy1eJQkz
 OH+HxTP2D0P3+2AwZ8hT0yhWebpScXin1Ti1XMAYgyP7v078GWEDjNFEr+ltJdrsFIq5+7wUBvO
 6lgLifOeHb8c+eTz5RA==
X-Proofpoint-ORIG-GUID: OswEGBWYMY7u5Dw7h2HpCvUyVxXvwVbw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01

On Wed, Jun 17, 2026 at 2:25=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Sun, Jun 14, 2026 at 11:59:01PM -0700, Zhiping Zhang wrote:
> > Query dma-buf PCI TPH metadata when registering a dma-buf MR for
> > peer-to-peer access to a PCIe endpoint and use it to program
> > requester-side TPH on the outbound mkey. If the exporter has no
> > metadata, fall back to the existing no-TPH path.
> >
> > Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> > steering tags into local ST entries when table mode is active, and add
> > mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> > index.
> >
> > For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> > lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> > creation and release it again when the MR is returned to the pool or
> > the backing mkey is destroyed, while leaving the generic FRMR pool core
> > unchanged.
> >
> > Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> > modular mlx5_ib builds link cleanly.
>
> The commit message explains *what* the patch does, but it lacks context on
> *why* the change is needed. The 'what' is mostly clear from reading the c=
ode;
> the important part missing here is the rationale behind the change.
>
> Thanks

Noted, will change the msg in the next version.

Thanks,
Zhiping
