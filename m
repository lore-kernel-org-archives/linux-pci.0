Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5023546F6
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784232672; cv=fail; b=DyH1doktW2bj7hrpiL8Pj3YrzpNZ63SWP+HAIMBq5u3YlkQi/iTp+axa82hwOckX27ot7a2isy/akoOKgruK83NSlTUquwA2ekYK7+mICED4MA00v473QUFwSDPMfgrExn9VENrJ/J6Xq7jBYb93xg1D7GYLS5xTVrf0NQHG+nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784232672; c=relaxed/simple;
	bh=FmELQBnFhyva8tqlkEZm6vsX9KbwpXPdoDW/5vArsKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3gjL49VjPGNNFu1HbrVRg/Fgs+dMaduSTsGisYqm02R2ETau7HrO1kuWkPvF9jz9rEFx1Mw0+J7ryG2+sQymhyjNUVtgWWmVw3ZPWwD51qFBC87v0AjD1JQxrCQ/tV9zJVQqlifzi47UWCGjF4lc2pbm+GkPfrx2B/Sh1IOXoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BeR11qvm; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BeR11qvm"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GJpoeQ4041735
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 13:11:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=FmELQBnFhyva8tqlkEZm6vsX9KbwpXPdoDW/5vArsKs=; b=BeR11qvmnnNI
	DzI/KcfGXkxY1JZELI8FYHdPO9IXUhqdHYrWC8lX59Hu2MJ0ZHd4AsNG2hgDGQpG
	IHT6XH5Qlfcp5OP6jzCLd5FvYJglbau8ApcPoD8Xz8kK/fSxfdjJ8AN8toSgqmVe
	v5wge45nB//G/3uFGquRWqSQUTJvOt53gIka1wnS/2dOzX9ajVcld2KKhTTJDgb2
	HLYpsvHpWstKTDtQXwYKzP+utDzERk+q65fDYWCP+ttjXMpPWN/GGjFizYxN52+n
	0G14OHlgtzgd5o2++cURe6sCIkND9KFf2CJXFvIJACRpxYjoKeFIkldXMd9VvGym
	8BWJjHisZA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fex3ck6ce-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 13:11:10 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e9f686e18cso4033742a34.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 13:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784232670; cv=none;
        d=google.com; s=arc-20260327;
        b=j0dry3DQJz2pj15N4zT0/mUCgx01pFjrIfu9F638qOVV8jvjCaz7wZ+7uTalSOvW2s
         2R5cHD+oIdH1ieO1/qEBLaB2EC9nxdZ17vIry6XFGV7IMrGql1U+8qBuNk12X2BoxItX
         911fG2KgOY/sAqvdmE+JaN1FAzT1fBoc/8z1C0kcNnOMlUMJ3DYvcQJcGOrcTUkesU0L
         0mC4sceGzkVb9pWvD0sJLEmQTo5aZDbAfj+a6ScZnfumsBV91W1/glC6qSOfwGKuG/6D
         6EUkvhbYhcDVLycvDeLwP24VbK1HcuIpngYJF1PH+rA5LdMBuKxfbeXamFIRNAEQXYCU
         GoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=h9z4CHpNCAe01AgBaapdbFFT33ePTDg6qz9BNy0e+IE=;
        fh=eRF+2MFUX5t+Y33A6VdNBtlTj2zwq39XZqqimmTC3XQ=;
        b=R6gA62mbQeDoUnwQR4o85NrbCuiPBV2dw/cxANhmSO5r/OGaqNQLECNLVd6BY907Nn
         ZU9/C/ZYaU87F0PoeEj9BNuBjWLbYnNpkPbFlaOq6Puehej3YrlUW8z1PkWVzA9Om1l2
         O7tRuV8q0licaxUMVW7aZT6QQ1lgdzydb4V4dnqZOoLDkVlCvF/kxwFJ5Pc7GBqtyqFW
         GdKLhVnvkem0GLc+CpeA/5hsUoX/i0xOqUe3BttyZFPtO71iyOqyutMUSKMswIeAI+Wa
         /W5XzOYRcmbiUcwaW1nkAcpRXKM2d3yu/9K0LCzVumfR9IWRP1nXgE4/oxMpDTtX6aMB
         +euA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784232670; x=1784837470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9z4CHpNCAe01AgBaapdbFFT33ePTDg6qz9BNy0e+IE=;
        b=FG9yUdf91MTTyJoS3omfUpCIdAuLxY9J51FJFewCzwgM8fHg4UG6ympVdoUGlQ9QuV
         gmPQaf54J6kOsgw1yNajgwRbMbPji+mL7hfDhFLk9q4zfk+1lcedDETCHe4eFNewOFFH
         z4XH7TZQiDjOA/kWM+TWrAu8p4tUbNs+t08W5Gz1liOwdvUevfkxqNAbe7wnBnwOlAa7
         3oMn0xKcpcrN2aLuE0+BxxG1pxcLC40AZENp8Isx48vXpmpZV3uH1z6xHlQ5tknDXdWs
         9y4Dp9llCKVQlyRbw+1nbIezSqoi0tygAzzSPh0flo7utRpvJhOHUyh5OGcWn8Hr26Q8
         HY/g==
X-Forwarded-Encrypted: i=1; AHgh+RqeUvCvJyDCiKzYkb2qGWW4G2Wsu+kP+byV80f2tdc5mRKnK57344ykq1AX/vKoezAEHh9wxR4WTN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUeuXwZgWtVC+pJ/i2Sxx7OkW64aGRhzgI/5umEQ/PSAN0sz7
	iQGbDV6M5q9AP2o+lor20F9BMvOknUq8QzGfGICGXBAs+UznosqbMgcnf0xVW2x1S2OEdurhAdj
	Vy9UVqvvNYCSQPZQDb17o9tAy2o63zHJVUhY26DDUG9zlFsu+kypg1c9LQCGXfBngrn5P8t43Jf
	GermZffVjRML51B7mamzH1Wur6xT5SRefjo+/eSxM4S/amhA==
X-Gm-Gg: AfdE7ckck/ycYQgckU6j7I1VVcD5H3GbdlRRkSMER3hsBuXBz3NuXBYKn8VlnpgAsUY
	S9/vKgqCbgbvoXrUr7rwhOF/dqHr6LDqplDmFWW9WNlZJi8RrrLTdnM9UkW1E6azw+NMjIhhRUl
	DIvAxHvmwdPhF5LQSQ3tY7sPpeNw2MrBP7R/d6iyCCUwxRE+H4btcg2M0Gc7+KyASaVdetZsCe/
	cnbil8JXBy5ooWF938=
X-Received: by 2002:a05:6830:6aaf:b0:7e6:e162:915 with SMTP id 46e09a7af769-7ec97340ddamr801696a34.5.1784232670054;
        Thu, 16 Jul 2026 13:11:10 -0700 (PDT)
X-Received: by 2002:a05:6830:6aaf:b0:7e6:e162:915 with SMTP id
 46e09a7af769-7ec97340ddamr801684a34.5.1784232669654; Thu, 16 Jul 2026
 13:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715204008.3911275-1-zhipingz@meta.com> <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
 <20260716144708.GD210048@ziepe.ca>
In-Reply-To: <20260716144708.GD210048@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 16 Jul 2026 13:10:58 -0700
X-Gm-Features: AUfX_myheEIlUGdSHFK_vqkE1hm0qjp53c8YkJwDa1cVW2p7StXgd-p-wIuQhRA
Message-ID: <CAH3zFs2fLC5GodysR9_QhFMb169DjtsNFnfBeO9MPk9S=DLcfA@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: fengchengwen <fengchengwen@huawei.com>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX1APt8euWQKLi
 4pDaQKfTTSmOyoDnEgsnwdwhZAVQPRAmZA6ornc9X+qqEpYkyHD+LsU1DWTd8XZCV8cz9ah8uZF
 22wyNVkY8f7ub7rpiToYy0CYB0gbp+dJVawnj0NdUxC17ZYDkohCfIwDiZqFBJAve+hamdwXEQu
 Ne4fDJVvIv68fH0BQt6Ct4kgiyL06tK6uWvakvV0/fHIIjcMevx/ibxFimHGfnHBccf+IL0Muw/
 zDmlJVK1Xl2KGffDxPLlVd3rwgko5Ma3QZc3PoEvRNFCOMOu4EmIs9oBEguOSZWOgoR48Uzujzq
 M1Pau/BfYEAFHO4gA8/4gqtSj3vOV+loub9E7l+rLVZuLUGH4YUExDJP0I1BgVwo7LdEQK/4Xej
 bHGL96iTc3wL5ThV+ar+SFW3rtvDL/j4O6TK4qb2HB8mzstsotnWgP9tFuD0M9gVkhXaKx8emgu
 sjwI91H/IWTETkl6lKQ==
X-Authority-Analysis: v=2.4 cv=ar+CzyZV c=1 sm=1 tr=0 ts=6a593ade cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=9jRdOu3wAAAA:8 a=AMAE7NpZmBqY-1WNrTMA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-ORIG-GUID: XPhNHH2Kv0shPB6jyHxO_Z4HCuAaZ32j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX5HvcBfEmhl3n
 XZJop4ugB9cWXO79i8JvaKrdsevT63zyl00kKzai9+fbEdcb+AQoYM2ggga8xAM/1kOWE5v0+0I
 iwkcrdKVHJTsrI895DuwKqruJxyS6lQ=
X-Proofpoint-GUID: XPhNHH2Kv0shPB6jyHxO_Z4HCuAaZ32j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01

On Thu, Jul 16, 2026 at 7:47=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Thu, Jul 16, 2026 at 09:07:35AM +0800, fengchengwen wrote:
> > Because cross-Root-Port P2P traffic with ST does not affect the host, b=
ut
> > merely the completer may experience some performance degradation because
> > it lacks the TPH hint. In this case, I suggest adding restrictions in t=
he
> > uAPI.
>
> I don't think this is complexity is worth doing for something that has
> no functional impact.
>
> There is no difference between supplying the TPH and not supplying it,
> so may as well supply it.
>
> Jason

Agreed, thanks -- that's the intended model. The ST is an advisory
hint; when it can't reach the completer the traffic just behaves as
the non-TPH baseline, so there's nothing to gate in the uAPI.

Thanks,
Zhiping
