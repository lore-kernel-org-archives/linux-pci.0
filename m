Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3557F345731
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218426; cv=fail; b=lzA7MRExQtO5av4xLbUGb6UBG4YYgZTXHv1Crh62UXNb4SgT5EEHlrPEVer2/pPDUrF36s2DxLsWZlF6Ys4iYnPN9ySkBIPvjBrWAYKmXiI2JLu9DwYxXKNGVqOAyOr/1Iuu5PUdR7fAQFNR+2ePM0Bpj2yKxTxmaotsC5huGmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218426; c=relaxed/simple;
	bh=PxRZuLlxPed7g3+uVJRSQh6h+tl2QKNm0St8ryyYUCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGt43mYYmdpRHW9BiUao4OieRO1B/INIFsJzOHkb2QuthHEwxmdaUKc5AWTJ5TnA8cZpuLG2vC4pnwYWxLZNJdAhAoONFeU9nmVSl4wJQikgPmJ1QFyC6MW+WnxgPqwj39caT6vuEAbC/k3JcTHJAMXUOmgSwhEpV9BC6UEaRnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FDSJxjU9; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FDSJxjU9"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65BEFurD3822102
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 15:53:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PxRZuLlxPed7g3+uVJRSQh6h+tl2QKNm0St8ryyYUCM=; b=FDSJxjU9lKGB
	zYwQmQEO00hYYEJ0A/ovopPo9d7CqKqD1XADgRLIn8Vqp1BtdkAsscjzjFBtTOm5
	diVk99kItK4XNYmeAXC4rJxohR1w4XfXN9Bp6eaanw4NKiAW4gyJmERZSpkYpCSp
	omOvIhSNxK+sDVYMbPZyhsgC+FkoO1ml34CzJ/gxKRcU8wmkmA9aQAC3EODqW0kl
	lDxIU9Q+19d3J+fSdA/QNT4u7oggrCXALTCFp2seGU1YuaR3sFJx91cwBUas6m4P
	Q7RVyD542fkWdg5hhoszqMfbGG+JSljRyZ8BmrK8G5dKPiI9D7qpr9eZb7kxJzyG
	Yl+tOZEnCQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by m0089730.ppops.net (PPS) with ESMTPS id 4eqe7xhaww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 15:53:43 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6e385508bso525310a34.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 15:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218422; cv=none;
        d=google.com; s=arc-20240605;
        b=hjiFqVA3wdHJDKRp32p9jE75U3iqGOCDumNGW1dNgDxyccIPa1Z64f5qqW32NiYaKX
         fMCmb6TX53h1DFICG6NUfvARcEAGP6naZ4bB3ysB+45oK5CBByvV4irEwwRe/mNnkkck
         odgyv3C0+ygoEjl9lfNJSGUZW5EyWMCbgmNf7MEo72WDl/RLpctQA/YsSUwOcosrDVt1
         OG2r5kDHXjk+++cvp8mVfkg6yWzMOM5dvWVHQZ0QZTsWtabJ0pzDVCmW9pG4FMz5snqg
         WZelgH2drmfZkXOO3fCxbhz4HtQzjCEKR3cruuDeiCSjwskCIm2BpE0clvcCJj+9vaps
         0zFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=bKpoPiSG0O/ElHpWyO7hVkQGPwY3Ah43xb7s+p7XAkg=;
        fh=JgZX7hHoDw6fUUIsZ6OKap4Qr36VNH/4uyqqDLDTB/E=;
        b=Rj59yiQ2M/LyIdyWbSefCzAGmtO76K0dyebZ8o7sH5r/n99Amozi8qed6PoFelt0Yx
         Zl+RZk3dcEIZ//m3qiYsE2JYsSChrNOXZ8FqJITvl4dKUjEN5VhI4zzcC2nMJkj4NWm6
         dBlmA8VrpygJQ4VrPSVo+bZ/m3YK8Fulgk3AjDqnipGRwffK266s66VK/JRYNqxieeIQ
         LpryHFbogH6pEtLMceGLN16JJNNpKvQbaoSWP/careYepz3O3DdeBVfpWOAx86cKB6V6
         9VtP4BIg2PAeowfhJaYUrFe73uYX4oNzTgylad9gaHicwFUDvl5W1M5uygynvT9/b5fE
         9O9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781218422; x=1781823222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKpoPiSG0O/ElHpWyO7hVkQGPwY3Ah43xb7s+p7XAkg=;
        b=nTEfnVDsZ21szHsX163qHn/VRQAuSTN7OBP8jWBCLHFWnjOlWiXYKL1/0Miuj7sBaF
         R42zhJD213sUHwHxAZalSdkTE0Ak8Sv/gX33+Z1VECJSWDkmJzWl/PQF+2alOXbFeBoV
         NZBz4iWl1fJxqWI1IzY7eAveVvvZnrUYK7DcEYbHyBQVUps+PM5tvi6C+MdPRphbtf2F
         4YHVPRqsbc5/8+wOtqbfwuG2CPmVMHHBX+C3Zv0iPTYA8/Huar6H4aMbqC4aa8P279Vj
         a8Joch0bSK9psar2eicpATohEmmNWJK6eya6aimyuteQ8GEl/iwKtKJG7//hPcNPpnUi
         xo5g==
X-Forwarded-Encrypted: i=1; AFNElJ+qlt+H+MDmNShiE9I2zJs9qIGDmI56p43TZ2TugorwHNT//7hNRuGVEKv4TlvIJ86fnw4vDugmEFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvDdx+eyLHO3fSia8omP5tbDoiDmTIvXDkq0xA3pRYtOFOVlj2
	gc/rmKwX0h9/X3coNxAD8E2tc62GPg7ff6Hl3ovIT7Agy7jZjuptocJT10BiFME5tv/BDQQUex4
	33f2LpQQY0SmDfYsnVhSiSrCJPc73dQb7da5p+J6JkAsf5E2coobDoZF0tSHke5ARklYrRuU9vI
	j7JtnYsTx37F/G0Zxr9ggDRkehMf4d+16hPQM=
X-Gm-Gg: Acq92OFGD6SWO+NSIWt1Ca+8mi0rxChl9/WRBiEIUkAUsq5Uld7v2dP5vrNplscoIYS
	mBg1LM0RYZ00HFqDuQ8Ai5NjlGZ9o4MhhoccOuLN2PBwab/e3SRex33kTOotRCK6cMo9qNqDaRy
	J4RWL/++yOxEhwLA8LzDeGOF6Tsj7Z9jevPGh+ocNL1Q4djJMGz7TuSULbaeY2apdxNJLBi1nfL
	dqVIT2WESpk491V1pB5VA==
X-Received: by 2002:a05:6830:6d29:b0:7e6:d8ea:7dd9 with SMTP id 46e09a7af769-7e7847e1560mr60110a34.22.1781218422501;
        Thu, 11 Jun 2026 15:53:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6d29:b0:7e6:d8ea:7dd9 with SMTP id
 46e09a7af769-7e7847e1560mr60099a34.22.1781218422119; Thu, 11 Jun 2026
 15:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-2-zhipingz@meta.com>
 <555912e9-818f-4906-a883-6f14e0790672@amd.com>
In-Reply-To: <555912e9-818f-4906-a883-6f14e0790672@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 15:53:31 -0700
X-Gm-Features: AVVi8CcTcZoIZDdh8OjH1IktxPjhUF1A0IE6AmeFSJNyea8GfNww1HwPJ1RCIPA
Message-ID: <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIyOSBTYWx0ZWRfX+d5iu4FQinIx
 083vv7VflgKm/umyGLPZP+qxp3XS235wiIEb5fK4J9QHXkxXfH7grW6Wsx9sQeowQ30MfRScX7m
 XRLcok16zTYxYRoOeu+L8o+DMfcux4o=
X-Proofpoint-GUID: M2sUgPrqANSiUBXCxNyRdeAhwGH4eQ0K
X-Proofpoint-ORIG-GUID: M2sUgPrqANSiUBXCxNyRdeAhwGH4eQ0K
X-Authority-Analysis: v=2.4 cv=Zagt8MVA c=1 sm=1 tr=0 ts=6a2b3c77 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=zd2uoN0lAAAA:8 a=VabnemYjAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIyOSBTYWx0ZWRfXxIR6HoB33U1o
 94CnGoCzR+lB6lgeKd+AYLb/CAt4iuhcwihxsAPmZ0he4V9BDnLUxwVNNLqrlcHKutlc+dCgoZH
 rpAh17I5VBi15bBX9VpasJZYvP0w54PqbcC9ubcldli8jnYR45fFbkvuzxzWLYV7b2pErqEeW1Z
 n0rDrwQUfcP41eHSix/7gRZFqJYgpPC7g2HM3j8kjZMIiTSVRNzwGCwZRhtZR5QJlN3iDyzmMKg
 VqyqGNW/B//e3+c8IB6pJBzzTFPGdDRC0jh4e177fkY8jfqBkmB1pC965wdWdXnGONN8dz33h2X
 8fU5LknqTLJS6hsSqMUHTb3jAo0/XwOx8owkRS04W24G0AGz49iQKq1Y5KiPvsIhT7cDq6Q5yd5
 SwhwO0x8kTCtQUUlVzQVKMvm4G8AvKafDbbUxnMn9psbUSFtsnomrVVMd/t3dnjxx4X0HxtwRGC
 t2kjdsHCQHb67uBu1+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 12:47=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 6/10/26 21:31, Zhiping Zhang wrote:
> > When the last reference to an ST table entry is dropped,
> > mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> > backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> > therefore accumulate one struct mlx5_st_idx_data per cycle.
> >
> > Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> > struct matches the lifetime of the ST entry it tracks.
> >
> > Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> Since this is an obvious bug fix I think it shouldn't be part of this pat=
ch set and go upstream completely independent.
>
> Regards,
> Christian.
>

Sure, Michael replied that he has made a patch to fix it, i will rebase on =
top.
