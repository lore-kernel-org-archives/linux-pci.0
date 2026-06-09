Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13E1BD9C9
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015903; cv=pass; b=GghSCE+moWosOB4PoxymzDGtouiwerQznLdcbTP86wbaO5Nqih7Exd69usJJu9wlv+/aORzbgUVkvJJKKt3dWcxsjMpCMPhMFVLvxt/rzyPq7qE/cyUx/aysH4LBo7G/upvJZXdiULopR09FDKyMjt53pRp8u8kU3xjGueN5hrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015903; c=relaxed/simple;
	bh=y3AzoKCQuHgd+PJJX0Ml7tfsX3S9F63aRJW3c7mG6Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUOUa1PS5xD+w/l3u9E65iFbWaPrNenOsZms1ak6xxi5IIpyk05alCzgGrGsn2jNsLcQgFhp+Gk8vzJBqUq/WlEnR+cgXca0x6g/xgTf9L9r2oGkswaBnUnaM4kMG27cZ2BQaYBDfWcF8D0uFHHiDRnWMG63QQLWbukvtm20Pt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=b+bzFh5l; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="b+bzFh5l"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659CQSil1458621
	for <linux-pci@vger.kernel.org>; Tue, 9 Jun 2026 07:38:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=A9sFQHsXqHrMgAiwxXHw
	qbtJi56QK9Hsrm8AczETl1g=; b=b+bzFh5lZdFG6ZMxUJUlD8Yt1iTFLbUkN44J
	0sEYOv5io+R4jUYJbE8CO/8bzyHasyD/fqldbu1TQANBQ68ej/P1D7bCh0Be/t9t
	77ignPYiVT73nQeplrY12DpT/Cb+rEjERmUU6TVCa6V7eUZ7JLMt94G73fGvajze
	zyUZleQxuZvCbUUSXYPL/gojMV01wKZCDt1r9+IxqZGQ1f29Qp3i37UJwt+6Vg4s
	mCO5U7LHFg4UrHlCu+BS9DH360ffxI9Csawy+GcEYer3nQpVrv42nRoVOUC7IsxZ
	e7IvZ+NUUzgTwRET8EbK90UUlwI9PBNVSniNuv50nJRdR5rglQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4epju80tfv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 07:38:21 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6b550a521so6052708a34.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 07:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015900; cv=none;
        d=google.com; s=arc-20240605;
        b=LAc9jsQq6yI/zN2HZ1gji6+oNqWpbt9tn5g85aTVHu/O8fq6OjL4lHTUppvlURUuOk
         2hAOWDDKvUCEPYyUXoWY1AJxlhLPwpM3th6r9cZ4MucM+fZvr7BoAmHo3a8p4vMy2KdX
         3qTV5BDh00arKx9yUpFtNX8Zm8Ux4jCzd5ainMjVRJO0ZG5WwfLY0/kylEFPqZOnUAg/
         c8pc8jGYMpQLdg4UVfurXaEODXM5lQKOlKjxqgntNorrOD4xphXtmP6BEuo918F+H4FO
         jiGIxrPzVdJZc3ndvFZET+3AjGheRFobLU4pR+3Bal8iKNbkOzKwdMJvgLwHYfzT73LY
         KmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=A9sFQHsXqHrMgAiwxXHwqbtJi56QK9Hsrm8AczETl1g=;
        fh=NNEkb6ynXP8rlOT4+tR8L7RPIhdtk6F8MH4SJoblsKI=;
        b=kbb/4nFAy1rFsbrvltA3dggcwg72/P38oJPJ1pG7SopeLxWzOfZ2oaw4UZNInUME6b
         AGGcTwkRYiSXmWFI99L6JpxXkCEpxVkXxoXTa5eKiHmlh8ma11yM60fb8S2xPmJL1M9Q
         R6Zu7tqAsfWUGqi9XcHJgSsh7e3zBgiqd2DyTxSZX6ln0RQ3EvEZ1tqUJY/5TcMO54Ny
         INt7iDfkMoMChsXxSBFdl6xdJvCOhOKduRvXv9RNK8ZzFgNoFWL0UJ2Kbr/Dse4I2UPW
         sCvmV6ELWFjXMcQgIm6FQMaSssMn1qO59s3CQ0saiLAKi5guiVzE4NlsKbMfVPyeF5kR
         g6Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015900; x=1781620700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9sFQHsXqHrMgAiwxXHwqbtJi56QK9Hsrm8AczETl1g=;
        b=PRMrftRBK8Y1N9stBP7PZBcv2dQFSTCnvwOsFIguhvWiHy0S9hy/piU3AzlMzZ6zVh
         YkiC6OMeBECuLhlY+jqteCPK4MrV3rDsIHz+4zBCuvPsIep2NTjpCFEQYVkcfe4XbtjP
         RuvXOZUWzAEe4tjsmzPKDMRob5hNYLEZlgAqSM2JxckA+LFpFEmDL9aHJe+Ubx9MWCuC
         YrCjvMQWs6C8D9GijuoNImoWXS61OqI/LDVoqlyEChpBG9c9K/BeOoQVvuvaw5/+CzQ5
         lQgYs7r8QijmiuH5jXSPSK4ZdAh0CFLXQOaKAQjLcdh5e41ccJUqRr7usgaCUc+5DwnW
         dXyg==
X-Forwarded-Encrypted: i=1; AFNElJ9ktDap/CndGf5zQKFlmTqx83A/GWA8Q5+yMZsxtxrzDdGugpnOyboIZcgqDHajF4zU/lkamZnQ4JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0GHE01oJS0HPMMIEKWEv1RdqKS8WQrOe9/FtV2PBsfaUNoal
	01cHRQeLzaIUQ88dywbBtWCrp0AsKzo3b6NV+bBSgNZQT+ryG029cC2d55w9m/gIlIUq0rYvl0N
	+fEQlI12lZ4X20Zp3EyKASBv3N41YAul5vS91tTy2eQcPGshz3pLdenBjIKQmkmT4FEWLkBiTV0
	cqmpp8dc2iusL5gxXQ+emMmjeXk2JMgemFHko=
X-Gm-Gg: Acq92OFCG9jd96TNgB9e9bEpW2Hwh9fgHFsvs0ftmhJQzDyzBQ8Pm9sQJwHLB7qY0Sg
	Uvi3hl0Zss7CmIOntYisKNtm6dVttkXdOnNvp932d46y9X14ihNOSMLtNSW5UkuH5TQsxfg5FVD
	Ku+KejHi6L/i8yjxpwPXFKfrq0P6KP7vNxHLJDyKd6oI9Pi6znDSl/ykNjimGAaRlrk3wKmigev
	q4LJxqnj6T3ywnw5DONplDguFziaL3Zxk716uBqwQ0w3JbPqf4=
X-Received: by 2002:a05:6830:6a96:b0:7d7:fb03:f6ba with SMTP id 46e09a7af769-7e70ca51cc9mr13515122a34.21.1781015900249;
        Tue, 09 Jun 2026 07:38:20 -0700 (PDT)
X-Received: by 2002:a05:6830:6a96:b0:7d7:fb03:f6ba with SMTP id
 46e09a7af769-7e70ca51cc9mr13515095a34.21.1781015899753; Tue, 09 Jun 2026
 07:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com> <20260608185646.4085127-4-zhipingz@meta.com>
 <40243782-e4ff-435c-ae40-3ac1c7c4815e@amd.com>
In-Reply-To: <40243782-e4ff-435c-ae40-3ac1c7c4815e@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 07:38:07 -0700
X-Gm-Features: AVVi8CfGCq2wYUK9zUjDs8_E_dqHl5wHKtBE7B2eSNCP9pHNCaJrScoAmctUT8I
Message-ID: <CAH3zFs1eE2VrxOZA9FoowJ9AKeBkdZE5P6t1cH0bxXq0iY6AhA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] dma-buf: add optional get_tph() callback
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
X-Proofpoint-ORIG-GUID: OLXfSZleCmmc4C5-Mabb81ZJMtUX8nHy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzOSBTYWx0ZWRfX5Es7cPuDB7bQ
 Oj+mBNAb+j1hS2Js3Vz+Yr2+XPbrRrN2GXeEZ+JyulwhfETg03S71w8tMIAzK8gJDXTURUiW0dw
 Cpq02cWoXmJf7mWkzhEU71FmkyhSjle+qG3KEU7TYY+yi5H2CeRW2Iv3KWqPnCkVrEwgH6Dhdzn
 ShhaLv/h+HcWNhxnvM2egNtSTHqYa9SO63CPWMqkKBy+yHf5/3uyDGdYXT/6nOd3KTTzXCIjUdJ
 GBEOo2++AM0kpEG59pAmUbp1wRkb4yAbiqtnKWr1ecUNUHWj5K5Xt1zX9TvRmZIswKQJjAp6oVZ
 4tUWd3sWEhL9Y1WIx/sBw+WadMtLfAk7/fTV0hzmEdTkMSoXd8MQlSRLqLv3VbEU1JYmoAvbgAY
 DYeWthBVECq99qqAk7V9fehsbZ0mzhEfPCCp5cMenLiUCLKPWK6U+KMjl7RxgGOyTgwU3sCkkV2
 kPyugvZrlghzKVjXBqA==
X-Proofpoint-GUID: OLXfSZleCmmc4C5-Mabb81ZJMtUX8nHy
X-Authority-Analysis: v=2.4 cv=cr+rVV4i c=1 sm=1 tr=0 ts=6a28255d cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=KaHoPmoT-FsTecDK8CMA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01

> >  include/linux/dma-buf.h | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..8437dbe4a83e 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,37 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @extended: false to request the 8-bit ST namespace, true to request
> > +      *            the 16-bit Extended ST namespace
> > +      * @steering_tag: Returns the raw TPH steering tag for the requested
> > +      *                namespace
> > +      * @ph: Returns the TPH processing hint (2-bit value)
> > +      *
> > +      * Return the TPH (TLP Processing Hints) metadata associated with this
> > +      * DMA buffer for the requested steering-tag namespace. 8-bit ST and
> > +      * 16-bit Extended ST are distinct namespaces in the PCIe TPH ST table
> > +      * and may both be present with different values, so the exporter must
> > +      * select the value that matches @extended and must not substitute one
> > +      * for the other.
> > +      *
> > +      * The exporter owns the completing address space for @dmabuf and
> > +      * therefore decides whether it can derive meaningful TPH metadata for
> > +      * that completer. The dma-buf core treats the returned ST/PH tuple as
> > +      * opaque transport metadata; importers that support TPH place it on
> > +      * outbound TLPs, while exporters that cannot derive a useful tuple
> > +      * simply return -EOPNOTSUPP.
> > +      *
> > +      * Return 0 on success, or -EOPNOTSUPP if no metadata is available for
> > +      * the requested namespace.
> > +      *
> > +      * This callback is optional.
> > +      */
> > +     int (*get_tph)(struct dma_buf *dmabuf, bool extended,
> > +                    u16 *steering_tag, u8 *ph);
> > +
>
> That needs a wrapper for importers to call which also handles if the callback isn't present.
>
> Regards,
> Christian.
>
agreed, will use a wrapper in next revision.

Thanks,
Zhiping
