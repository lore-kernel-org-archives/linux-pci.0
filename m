Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E9A47F788
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 23:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514114; cv=fail; b=mzU1/bMw0ZiC6DdkfWkgjdC15elQ/nl3iF55utW7J1bhweCVVtz4b6qp3+APe9BowE7dJTvLAyDcsfQAbIWCcoKRzjHk653oRI4CG+m9SOxRir5JrNbaJK55SutOwP90W4wspSdg3rk6uW8VOQWa0s1g30BIS0G+qcfFomLY1XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514114; c=relaxed/simple;
	bh=Rmo+TwHeElx+2npaJnRSKbzBj193sekBXZLZI35ZXwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ltvz0U0DW5cxUIAmdpHtlzc8jggu6gjJnB+XjozmctNmXtk3AjnAwAUTPkH/18UTo8L5Vc8MLWPRPKzY+xb5nOb9IZeWUERB2C7etCWFvrcEL4XqutSTKUGoyM/d2AXX7GnJAyxzN9QtEgBJpq9GknBPwpIfOdbdojOQTXwKKb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SIXx0xrA; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SIXx0xrA"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FMOhdS1531545
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:15:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=9wSKnU6K8x6VtxP/QNuLN7MLmNw6mKZQmf+9X
	IiVvUU=; b=SIXx0xrA+TwjdlTogR7fvr6LvG2I7Icv08Az9vCa/jwMZH5282lDb
	fITP5NGPExDCwMPo2NWJYTt4cs//NI3xZM6vnLSwvCKR03RHUaKT4FRbZQXF7pW8
	wsxiplIBxZPBMsM/WO1a6MO0wTOImFGp0ZNUrmacGmQkr1i93e3ApULxS50+MCOG
	RDvPl4MJ2C+2R6YDeiugKDUPRPGote74ERplmgd5+LniAtVGTlx4x2BIu1DmUtp6
	4bCDxqPm0RNRhVOR0xeEdOywHGun5E4lFBdCvFLcju9Nq0rmk6h1Ixd6uFDthHXF
	laYCFWUso+8lYVXC18+EsNnAdYEHhqNkw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gq4w8d4u5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:15:11 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7ffe94da829so2845156a34.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789514110; cv=none;
        d=google.com; s=arc-20260327;
        b=YpLaQ+sCXn4bWww+0EJuSqa+im1uWtF6u7pox/xXwQY7yKpAo35PU8Vrsy8ZtBP23y
         klKEz9XvaiD/LWoxMmq8iIGiAaSd1kQ2oluZ4mA0BdtxaAqalhnI+bGkQynm4YSHgzIJ
         KKU/1nAxDKDktSGhorEDZnVwMPAVCuuuWRzhuYHzKF9+hf3lv/oo6v38ZfmvdVDUFZcz
         K4PLU6ziFGVj/+G0Iv1ooPzmYvMXarqLL8j4Kxu4SjARWoN9C3y+tsT6+zR76ISIbnwg
         gow82PWRJYp20RnxljSu6CMSac78wq5Ee+vFhHC4XaWa6s9t6+cqdZsgtim+HioDz1nh
         zVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=5Z9FH4pGg+zZG5DGIDh+CM+cqcFCAu2VEGfh4kw4QyM=;
        fh=RFohNrVOh5Iki/tp+b/3NxkupcG4fd2qEjhDy9GaRIE=;
        b=FUnXQMB3JBKM0NXaY9NdMXl9AdCKfm2NkSv6NTMP8d2Pl8f3DsDJHwsjPH/k4USVLN
         SgbH8KC/CXQzvlq30ogv07vPlMl0lQZcsmgTom6/MeNGXlNiAFzfPv4c54jPSBA+9abe
         uyIwP3hjcE3iUASpbUimAQZcTqPcUKGjROscm5ZMiFs6KLGVetANIN35Fshth40tti9+
         0ZADjbKvRGNfc12IsS4NJFduZrgbl0yJTW/FRnxOKWqCecaddQYJ7iFNykyBi9UFn8G3
         mHK1c1VXM6NBrcIpUEAnYFIeLBEqVSbo9N4oPlpu99F+97Qb6PR6SFaWuno1yVqKapIa
         pc7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789514110; x=1790118910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Z9FH4pGg+zZG5DGIDh+CM+cqcFCAu2VEGfh4kw4QyM=;
        b=HHbJh/Iw3A6BvN4Vht8Ls7zjdHimLys0kOn1DUbZi+MEK7C/WYcYb2D2wXh/gfpbgF
         P0bHZmNC3zQOP7i2YnczKoe7pZiqGpdRcAZh+dJLrHWoNQgWiPGXGC3nYMQYPwYdGaF1
         wHRxsmDEcT36KiLbHziW7UTxb+xRnM3BUqaVsx1cDKddTR+nroFiLttj82mg1RPaC7vd
         BG4sS8mMOPLqBrhW6KwQ/XoxqMYFJ8DYeflEAlwHJefLQWTARJ6L0Wk5V+8Bq70/AScE
         DXTbDhmhBGKEsRk+oBEG1UdcCC+6Rm2HFizYl9+B7Xp6gSs4CoG16e29s0789Yn/yCXu
         YGRA==
X-Forwarded-Encrypted: i=1; AKwUvBwW7qnm54Fb6Wt8A8ktAaiBwKgsjHVYD76u0X5YH4QbK1hqdYkeOb+6PbUqo05qEByPm/0Wh0hXmmY=@vger.kernel.org
X-Gm-Message-State: AFuF++npkBOGXFzfHxdvxltgEwqE3srvD4S+Lj+5foTaVOXVZ9TjvEpW
	9MgTRlsAN1RbnUTqe3bmo+72EtyF2cCZrlBrnJPLdqGYLWvc32K5hQWq4M5AUDPSS9pcSrpmuUB
	6K5X9/9hSt+Kt0sRuwtx3IB3eQ+JNnfMW95xVt48anMJO57CrRWACU1l+mfhlRyuBpsCSS+Qud1
	FqiDY9cHLGRSdpwAjBTFk/o1CieyijMdaM7j8=
X-Gm-Gg: AYBFou095dR99SGK2R/zfh/RxYrcbWJLTpjYcmcal1JxcPgf+QYPvCXwFNxuMw2ujqD
	v05G8NoKDGrcOYZeVDxQVNUOKrBDMM/vMM477wxXvdadwxvo34zs/H6BAP0GiT8g3QHUPcbtbGx
	9Q1HVUMCTkGQ8S6LMQnzkpZ5LJbeXsRRRgyh3O5f7lF/vf1byHmfxXBPVzMKQ3J1+vIAUysRYS
X-Received: by 2002:a05:6830:6001:b0:7f9:555:1def with SMTP id 46e09a7af769-80b37d7fdc1mr343251a34.11.1789514110413;
        Tue, 15 Sep 2026 16:15:10 -0700 (PDT)
X-Received: by 2002:a05:6830:6001:b0:7f9:555:1def with SMTP id
 46e09a7af769-80b37d7fdc1mr343224a34.11.1789514110002; Tue, 15 Sep 2026
 16:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-2-zhipingz@meta.com> <20260915221924.GA876929@bhelgaas>
In-Reply-To: <20260915221924.GA876929@bhelgaas>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 15 Sep 2026 16:14:58 -0700
X-Gm-Features: AcwNN1XwigNQ9uW6nBUmoxE2F8a1TK24gfEznyxrn867tS2zzsfZXU6D-kJDtU4
Message-ID: <CAH3zFs2EyhpkJXRr7gbC+Oyb3y6Y+yyVzAgXCvg7_won0er4oQ@mail.gmail.com>
Subject: Re: [PATCH v13 1/5] PCI/TPH: treat reserved 0b10 completer encoding
 as unsupported
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Chengwen Feng <fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=D7HSufRj c=1 sm=1 tr=0 ts=6aa9d17f cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=i0EeH86SAAAA:8 a=1XWaLZrsAAAA:8
 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMzOSBTYWx0ZWRfXwekYBGYspa6V
 qJhmRmW60wvEoK0hfMNFbrU8OAtEzEtwFiYSZfRfXCM8hGCbYXYiVsxUuU2++33LbHL0CqWfZkf
 J9kaVqM8RmNMiANuoSXwl4ESRyBKZAI=
X-Proofpoint-ORIG-GUID: 8kuO1qZID63kKDhMiyGZsgZWb27-Hnlu
X-Proofpoint-GUID: 8kuO1qZID63kKDhMiyGZsgZWb27-Hnlu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMzOSBTYWx0ZWRfX2v9brvZRQAmt
 ZNaFjfvGQ6nkIff6PNUmLWrOzyp1fY5EdeS2E4tp6laMlJ0nLijlH8JjoU6sqReD8dLXcOgRu3L
 qjVNVDmV8kMF9WPNE/8AAjleLDVAkBsPN1pleZAiyYBsVgXiWprtbN6xkxwpq17LsxbAk13F0Mk
 DWviOXTbj2so1Q3fwZrj58jy9Sj20moot9AVfz0c+mkSQwNjyaBXC+nu7/e8StCOjehxDY1qf4N
 gs1hFeEbNlF8f3hGgDbXhabGr5hPrN2tFdBwQMjLQM66FzgI30Mm7cOqOX3s6QsRRuxt8imJVDm
 30BEJBbOveWCJQZavOw/WMaqHJWqnM1BDCBxVJqLibuvCr3uMSNEogfmNd99AodX+47FOIeC/6u
 Rcqt/1jAkm7e8g0ugWD2JLZvfcMTxVomXfRnzMR5mNDVFppJuUITMPoJH8OMRdHFJzerfphqO22
 +vNNN9AvkY1HOv7iVfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01

On Tue, Sep 15, 2026 at 3:19=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> >
> On Fri, Jul 31, 2026 at 02:15:48PM -0700, Zhiping Zhang wrote:
> > get_rp_completer_type() returns the Root Port's "TPH Completer
> > Supported" field (bits 13:12 of Device Capabilities 2) verbatim. The
> > 0b10 encoding is reserved, but pcie_enable_tph() feeds the raw value
> > into the requester type:
> >
> >       pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);
> >
> > and later writes tph_req_type to the TPH Requester Enable field, which
> > only defines 0b00 (disable), 0b01 (TPH only) and 0b11 (extended TPH).
> >
> > No known hardware presents the reserved 0b10 in this field, so this is
> > defensive hardening rather than a fix for observed silicon: fold the
> > reserved encoding into "not supported" so only the three architected
> > values can ever reach the Requester Enable field.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > Acked-by: Chengwen Feng <fengchengwen@huawei.com>
>
> In subject, to match history of the file:
>
>   PCI/TPH: Treat reserved 0b10 completer encoding as unsupported
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>

Thanks Bjorn! I'll fix the subject to match the file's history and
carry your Acked-by in v14, which will otherwise just be a rebase of
v13 onto 7.3.

Thanks,
Zhiping
