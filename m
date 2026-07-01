Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C9838E8B7
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928421; cv=pass; b=eM9E03pShEf2adz3hLxmv27tMv8DxXq4UXzbIZSIKI+Rguz7wiFqLn5EejyZ8pkb1GGY4LWEvKSemeu8vyjY2SH+2ZWYahhbM+S+JZMH4c4PLkrHzVF4SD2k8D/SEj8dDD5dmqTlAmIkuFgO7nMXrHLqAClF2hGe5rLphbB2jdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928421; c=relaxed/simple;
	bh=6RtQ4aX4MIiDBOUtFN4cE0U13b1ydyIimdMtAEGn2wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQQNgy4I9rPVN2Lb0S9mCBReHVXRqDxKwJoj4nhq1M8VHgQCp7RrDR6i1jfeB/yNZdOA+c/mdYVS4Qe8ZKtuVRlhQscn4RnjfIbPzhHLsUQNXmfjuNA2mszKeMZwKY/j1mz5mGOCa2fvNZGW6VWn8AskVD0/THgX/r1L2ppfiFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=te9NKp0K; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="te9NKp0K"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 661GqGI9226265
	for <linux-pci@vger.kernel.org>; Wed, 1 Jul 2026 10:53:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=e7kmcvrJXFeA+SwUp+Q4JZ9GBs/Tu0VczqJ6zfGHtFQ=; b=te9NKp0KSuAB
	gJAStcqVmXyO90PdrOMhuz1QH+omYd4+Mw3B8TEdXPLJtkYQrsX/45BVNWyEblz+
	JCUQhK20eJ/NvICPYCtpkvbiKi0EHSaSmpoWEug8KslbHuTVqxo1Cyiq8npvWq8O
	iWJN4c+SNKe9prCgyypFFuDT+2fW//iCpWAfn5FZiHT3Ma+UfgQldfxu1JwL3wjT
	puoEMSaFB2J+gLTdLoKhlZdm4JHFAsQvSKn60MMl3h0pRepyXYCBK4DH/emUGdVP
	7d65A6CTugo700ojlRhKudPV6DZBXhMFm8x8LUWJmnAbgYzkzF4XYX6nodZkJ3HT
	F2Y7Da8ekA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by m0001303.ppops.net (PPS) with ESMTPS id 4f45ufeykq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 10:53:38 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e7624e584dso1347169a34.2
        for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 10:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782928418; cv=none;
        d=google.com; s=arc-20260327;
        b=jHZDcPY9QezDON8by87DYJfIYXAN+5UaJv6wyo/wyQUDL3wv9ADtGlIOgsEkacC/+G
         qPzB7rB2Gj5FLV1MYmVrwzLtan60cF3FTYEh9lO10Ox5Kqu5aekPD57sNL/Me4HhYGkw
         wGRYE8W2cVOxES0kdlcddLdm2LbEbIQHbixWacBNWk6YvmkFYmhSQ6qoD4kSLVAoiRHg
         z+J05wbuBP1R9uc7MK+M6uxYHaKCxrotmOGdpkz20o/0a2FCfqRHPMXxArrld0DqDSXm
         108LAaYbNfRjRssKL21YY2OqOG6my7TLKQraZ+sl+37q5kZdm3Du9tgnx3LhRjKzG20E
         o/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=e7kmcvrJXFeA+SwUp+Q4JZ9GBs/Tu0VczqJ6zfGHtFQ=;
        fh=fdDj27zDNCbvoVwG/5VWQMPc/3rR085kaiYkPY1oEKo=;
        b=OUOuDJVyUnQeVsf4RxbGjZkl/ZC4ky796F9rk0tkTLxm4DQQJnx9VMWP2uRJ9m/BtZ
         FpcYoTCAoRP4Dinz3FPExfholctjdu4FVCgu70+Mbwc4Fyu+hQ47yQypgvY7t1O3AWx/
         LIHHZ6HCpbiguuVW4LZvnJBobVAtkDhleVb2I0hsP6Lh5/hOTpCsNJxdEvSYdmeDFimJ
         iWmKnAJ+x8UA+gyX/7wjdYUOPt6+j3Dz8bRk9k3Fg2cjRxKfEl02v5O8jPcNDIDXgBdH
         O2SJhfgnn7iN4Ki3Vt2izVHngteCMxSE92TepeFpvUcH3qXb2CTY/mhaMJGUdkhqTMWr
         XWyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782928418; x=1783533218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e7kmcvrJXFeA+SwUp+Q4JZ9GBs/Tu0VczqJ6zfGHtFQ=;
        b=ghrWsYAcfNrldwbMmxcfaIrdSA9GAF74iCFPCD87NMkwXEV/d02a5B4cajD9XGQg8f
         BigDM/B3y8WFQMNXOhJ03YAX9724OePrgjs3gl+djRA2isMRXDFMf1yq7aHXNj+xA4Dh
         J0wCljNdY+apqX4eYUYrzPoTPekJ9cc3RqUmnbsgAGmQPfgqaPAcPcH4fkHkjP5kHk7X
         7/rzH80PX9bCICmT5DJ4IBsbXfN/u8zjfAg6mvW1wMwrXawzlmDZzXLR+KgqZee2adTg
         n1ZSRX5ul54OKEWvKH/dZ+0QlgoDvGbV/IKVq/vhr7zPlMfWfhD2WEeT7+d3qq1AQZtJ
         PJtg==
X-Forwarded-Encrypted: i=1; AFNElJ8dOFVufWxaRNsQWYpMdLZMEcJo8PrfmedY40X+quKa36GiwDyPWc1989d1e1rN84HewJ7ZJ0XX30M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJYP6pBTWasXtH1Oss5XVTTeIXlRp84bY4oRP2vlrrfS6Xs2gI
	7xkVTCKiv7d3pqPt9ejWw12x1YzKmEjnzM5UxiPjd8ScM7yeElcm6gebFQUdZtpS5e3MVqtZKSk
	R+/hwOyRCqbM0a6enZYdUmvzQLGq5Ej3zdJ07LnwymUmRb176iJeRoeuh826QBfUsqkkEO/jKc+
	99bd+TC/uHYIveikI3XUunEbYew1KvHSKtji4=
X-Gm-Gg: AfdE7clLOvnbdpo+02qoWB5yZN6eixpD57gQMRZmetsE7QW3FKeWEyn8TM8RVQe5fdc
	WRfSm9jGGjRCqKVcmogcL+cq3c/s/8EldhVooUIhHBs8L5Iqt6uKYqpiB+BHfMKA8zjx8eFwf6L
	j7abllAVQzx+LV8s+Aa2jEjimFfg9IdudcYasgf/fdzx9KvhMXOJvOaDKIUwQXcMhKf7iKqZ3w1
	Fs1Rh2BOQ==
X-Received: by 2002:a05:6830:348f:b0:7e7:62f:727e with SMTP id 46e09a7af769-7eb505175d6mr1172074a34.22.1782928418012;
        Wed, 01 Jul 2026 10:53:38 -0700 (PDT)
X-Received: by 2002:a05:6830:348f:b0:7e7:62f:727e with SMTP id
 46e09a7af769-7eb505175d6mr1172044a34.22.1782928417437; Wed, 01 Jul 2026
 10:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630224328.3218796-1-zhipingz@meta.com> <20260630224328.3218796-3-zhipingz@meta.com>
 <e132eb91-554e-493f-9da2-aff5a538da6a@amd.com>
In-Reply-To: <e132eb91-554e-493f-9da2-aff5a538da6a@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 1 Jul 2026 10:53:26 -0700
X-Gm-Features: AVVi8CfUmWw3yG8Q376o8lxaFsAzKao0Cd3LEJcq9dJNu4sURoDLmPjujqACaso
Message-ID: <CAH3zFs2tkxA9w-oCr0N4ixe2VupXXQF-cA2o8-fToj6uFyuMJQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] dma-buf: add optional get_pci_tph() callback
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5MSBTYWx0ZWRfX0y8ZmulavYWw
 3d3NH3Hzw/uAji/PdjxcBsbsUARxh3m90jnZi7F8uBFD2nRksl22x6cAo6Mwe17L4HiOsLbtt4J
 I/qdlCIKFgEVmnaYUMHjzJr0sacBiOw=
X-Proofpoint-GUID: bZv6EZwuwnelIVEROPjYuS0hoYxhZcP1
X-Authority-Analysis: v=2.4 cv=ZOfnX37b c=1 sm=1 tr=0 ts=6a455422 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=I4J65MU22ScPYueRrkgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bZv6EZwuwnelIVEROPjYuS0hoYxhZcP1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5MSBTYWx0ZWRfX0jNOLMs+bQPw
 aN6KwpkVGKM1G1qQWpi9vEC5FJ28B5HYt0WplbdeGuBr96VBmYMcua1kSiyq1IAXW+vvYsaJttH
 tkXSAmK8jlFezksOx48ldum9q4akRHE5ejmgMUa3Uh4xxMGd5XCCRJA9CbTyxVXLECCR/3UwTmP
 V+XLliA/8ksWQbYb8mhIhtB8ilxED4CcsMwN/oB9tAhD4oc+NNIig4hNMxsGJK3+BFCXrHcDQSl
 KSKjyzi7EXPUK4ZsKe+CpwsP0bL+nROdNtCKJtNPSA19c52Bhg8t+MLKc3rHxpWEFtJyYBnaiwV
 n0ahcKxad9K/ndWSHbppDrLhUoKXoQR67qXwFgr/8L+jF6kBwM5IuoQcOpfLD+NzPwwl9zvUMe9
 HiJd3yf2OrvEuM5Siekr86I0JZ54lpclb8Xjn68N6fevDPLf4tc/3mbKvz0uCZHZMejJf6WSeUp
 6drOIEOcHFBto74EJEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01

> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..7a4c9b0d5dab 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *at=
tach)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >
> > +/**
> > + * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metad=
ata
> > + * @dmabuf: DMA buffer to query
> > + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > + * @steering_tag: returns the raw steering tag for the requested names=
pace
> > + * @ph: returns the TPH processing hint
> > + *
> > + * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
> > + *
> > + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> > + * exporter does not implement the callback or has no metadata for the
> > + * requested namespace.
>
> Please add something like this:
>
> * The returned information is only valid till the next invalidate_mapping=
s() callback from the exporter and should be re-queried when a new mapping =
is created after invalidation.
>

Thanks, Will do in v11!

> Apart from that it looks good to me, but I still think we need some kind =
of example that this works for other DMA-buf users as well.
>
> Just demonstrating that this also works with some simple FPGA or similar =
PCIe endpoint should be sufficient.
>
> Regards,
> Christian.
>

On v10, I have validated a second importer: another vendor's NIC
(driver not upstream yet, so locally patched to
call dma_buf_get_pci_tph). A PCIe analyzer confirms the TLP steering
tag matches the exporter's for both mlx5/ConnectX-8
and this second NIC =E2=80=94 two unrelated importer drivers exercising the
API end-to-end.

Thanks,
Zhiping
