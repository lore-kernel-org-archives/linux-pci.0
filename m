Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446F3DD87C
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781221562; cv=fail; b=jy7MNCLevF7nNi+oyBxIUVDolh1Pg0nkbTqfkf1/LvwJMjp/IsIZtN+lflfKNAYZkt8YO4xvHqWSmBtXUY18M+Ph43EDkPfRP2j4SEUtFWBb8/4msYwPGlSQt2h8bLspT+8713TZicfSvNOtt4hRdkxRlKrTVuJKCXaTIIqEKZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781221562; c=relaxed/simple;
	bh=wM82CBZM/T/B4tXhf63AjAwD1f2VxLY1SoQyRorBE9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVkTZgoIESYK1EERC93b1KBUVaHOSGarTBMxPLlpxNR2LgLiVbTIrBXO8ceNvENHGyiKBosZtaQihbUlm5O3g/JExsRTNjHtwAWVGESOkyu3LyK6QqDcVeP7X5Io2TzESL+O5+MWZZPr76Y6wgN5XUIW2Sm+LAX9wDkFfC5tj+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C/D5WLO0; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C/D5WLO0"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BEGQCk2262312
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:45:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=wM82CBZM/T/B4tXhf63AjAwD1f2VxLY1SoQyRorBE9I=; b=C/D5WLO0mmbA
	Ud0JqF5B+NiRYogOXFY27nmYpBJEirm9IRllvwozXjgx8OIFD5ZV8faeqTA3bkPS
	QQWZkebPb05AEUyMH8P16H5UX/fEBtNpeSpSliXT4oXjzyno6ILLCxFInu9/96z5
	1EJj/KLr2YVNpfd/nUoJ5mhagh5nM7sa5TvPfzFUJ71l8C1p7W0tPydae6CxTcqV
	tYwT6puC45+P6mMcS1ezBsA7Os1dhZQGhyxQyH3i47tvMD+VBY2zLGJ1L2IC/Muy
	9fS62yBoiRy7/k9VAoZ+zz+a3YlY8q3mXa4pSOy8Nssbs4fwqZWQUMQUW7GP/2Hm
	q3IRLexocQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe7b9ja8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:45:54 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e713779405so919396a34.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781221553; cv=none;
        d=google.com; s=arc-20240605;
        b=Ure1M5t6lialg9FSODwXj7ArF+lf2qTsJrRHimGkpOrDakIBxvxTqf0GUxa+zUnnyL
         mWQFbfhqhqsAWrYUCwUetZSnZkW5GCnnNXpE/cxqTANOq0YcqpJTdNRxOSPFik5OMLFu
         4zX1My+qTcZceGfSuVumRmH7e9yiGHaJ+8rr6lY70zd6h+TLw++IVVCiBMXP0NwveJf8
         vMp7sBVeT6XQx8Ga9zvoZyfnRHfBO2w3YZXO9vPGCQ2LAie1yULP3er8aNFdX4Xfa6Yj
         wV2wGOuB0jNfjn/M179VXvvXq/cWKlSqLMmh4oSwQMQpTN77IzE9Fx2ehz2f6dbSsjtV
         8nIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=1UnBtkB8A80kDFmam85CYV9Oy02dqYtmeBOXBtV1LT0=;
        fh=sXGoVYdlpWJ0UhzCXa5OnZoNBKN1OsNzE7+iCPJvsB0=;
        b=ikjzsEBZnrMQZwC4Xzjs0WPQ2x+SJtWXBMVlr9uv5q7YDvzWjA8lvaoD9y2HbGVwyW
         lbc/WOt+8/vM9ua0uQRQvCkfmC8kJsPne+lWoglFmb+PC/prdVZ2YOFuQT8EQiCjPwgS
         ggUADU3X3o4eLiNQJs3eCTCnzC2tACGuWBCy9Xkz0QmNTgcXtPs/g0sgaXbkx5wWKCuN
         BV+mvxnsFaXqQu86vOAioPEEnJB+NwDPkHN5K5ZJ4PtZ4JS428aSstqXRuWcxNgaBITK
         JiZQhHj7OMaDaw45EwpmAAtlj786TUoa2JepfFcwmcbQBitr42MklarEj7r71slEDf9G
         Z9UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781221553; x=1781826353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UnBtkB8A80kDFmam85CYV9Oy02dqYtmeBOXBtV1LT0=;
        b=FNl/9g7ZLWFZYZ76LObFK3gRR6aH37GbVODKWVNUBtX2lDyIclHTc4qGUfNzAdV47o
         K2BwTITUAESIy8gDG0SZcqmwCgONnq8aN3b0bv10WNnKfsWuTuRWS0EX5MuBK28hQZW4
         79eB/KW+pUx0JGv+oVTx4JvZ8Kp2BpEe6Sp72OdAYe4cpYvxbKN4nbiGzD+xc76p8m0T
         3OYI3q0COyHX6jZDSQ7W4W9Ji93rZkDPEgp8f6k1flxH0jNL56IQui3hbVOHE1sN+7Ld
         4HlYNcTMW0nw912teOSw7zS0eRmnf8KixBcEa4B+iJtAlJd7kk10xtQVN5aRpDo/2KDe
         Xgmg==
X-Forwarded-Encrypted: i=1; AFNElJ8LXvBCCDYMP1WjvPWIaWckyA4VCwhe9kwFO3H8S6SrbaHHx4edslf83wtbWi+CaAriH1GEaAMDjm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSqjkdDF0np/v7WPv/coCvVEMZvz6wKisukxmApEC0MTYu0I6a
	XyzKAKeJEfeXW84CjOaU+3VTJRTvPkmnf9A4t3hDI9bjPjAf5mv0x2rua70ZIxex4gq10A+sKyV
	LEFztdUGbReyeabPxWV4wNXViSrRlmXW38x9Sh3KyHfUImHgrDE2tNmt6KcGHs/4qXc1HZMzYj5
	9WJRMiJAACvjMtVkPSB7qrEnfPywbY8uKHH4Y=
X-Gm-Gg: Acq92OHkLPYAvi3tjZE7dA/jx0JWOlX+IpR0IiMZUNkhI+hpqypzpiVVA2NM8fon5aJ
	m2ibArvtofOxM3ic2jbLvGPr3kGx5g77sUX3k38oHKm68Zzqj0RuM1X/4v5fOFzvCEF9RMofgTy
	brOMYYmtyy965spLlCWAyIg/3jWTPlkmX9lYQUfJGTg2acuUCSaLjw+NKSwJpcQIIKIbOI6D4hZ
	v4Gu/+mr0cQs/8lZd81oQ==
X-Received: by 2002:a05:6830:6734:b0:7e7:571:114e with SMTP id 46e09a7af769-7e784871fe1mr152175a34.20.1781221553601;
        Thu, 11 Jun 2026 16:45:53 -0700 (PDT)
X-Received: by 2002:a05:6830:6734:b0:7e7:571:114e with SMTP id
 46e09a7af769-7e784871fe1mr152160a34.20.1781221553208; Thu, 11 Jun 2026
 16:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-2-zhipingz@meta.com>
 <555912e9-818f-4906-a883-6f14e0790672@amd.com> <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
In-Reply-To: <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:45:41 -0700
X-Gm-Features: AVVi8Cfn8yu04sl-GzuR397tWS6RCJ76opDbk_4XDQqGmuG536f9nq5T-lNoRa0
Message-ID: <CAH3zFs21OjkJtYKSqV5rjnEqOU=221LQLY2qXo9pMb79kRSQgQ@mail.gmail.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzOCBTYWx0ZWRfX+ZPjHGN84TLY
 3f5Mc9F7mP9XJetxhF2IqcdYIuWNneYBLZl6Uev6cPpdKi7f7igCPE3rt6xeCdUyZ97OEYtaPCH
 Ob7kLW5fIxmFyRAYbPVitlVgh2QFIro=
X-Proofpoint-ORIG-GUID: y1o_bsCXDeBKLNDHgSdpfJPKhwxy0OQ_
X-Authority-Analysis: v=2.4 cv=FOIrAeos c=1 sm=1 tr=0 ts=6a2b48b2 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=VabnemYjAAAA:8 a=zd2uoN0lAAAA:8 a=iziE14hG8lcdKKJlCxoA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzOCBTYWx0ZWRfXzB3u71WUtVJt
 X3P9ivMKIFYEwzTWysY7WNrn+rYZ/YQItpCHFQZQ18oPSgFch7KRrZPNwyBSoawt9qzpE2TxdbT
 UP7/FXM7w3RtY9SYO6zHplfzrxMNg4ZmRqX5/4Rfl6hEQYS39gqD76P9uNUSFQPTKlrucuD9EaL
 bEQU4KnnJ5452hCxC6m53173oPKCeSMtbMLpeTVXonAeFOz8lV8xQOTl0Bs5uPPJufLkIo5/j8b
 hp4bV23JAU0bYCV9A/LCCvxb0ZCumPVjRUlwrn90pp5HhgypnGFqGPIbred7hjkMD/jsIvtaZol
 S5gt3SekVR/MiCwJjNINFlfAPEPH7kmtczhJojQJfN2hqN5UjB9jmeDqUkshj90sc1eCTnxSOq8
 zliV81J/QIAnftmy5zlLUfLb3tHTh+og3huAfGQhh4NjZPKpyMWWKADQEos+DFa7pJtvZ+eMssg
 +9W4nhzp08MttFhKuaA==
X-Proofpoint-GUID: y1o_bsCXDeBKLNDHgSdpfJPKhwxy0OQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 3:53=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com> w=
rote:
>
> On Thu, Jun 11, 2026 at 12:47=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > > >
> > On 6/10/26 21:31, Zhiping Zhang wrote:
> > > When the last reference to an ST table entry is dropped,
> > > mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> > > backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> > > therefore accumulate one struct mlx5_st_idx_data per cycle.
> > >
> > > Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> > > struct matches the lifetime of the ST entry it tracks.
> > >
> > > Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > Since this is an obvious bug fix I think it shouldn't be part of this p=
atch set and go upstream completely independent.
> >
> > Regards,
> > Christian.
> >
>
> Sure, Michael replied that he has made a patch to fix it, i will rebase o=
n top.

Never mind, it seems Michael's patch did not contain the fix, let me
submit a separate set.

Thanks,
Zhiping
