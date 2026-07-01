Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A203346AFB
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940041; cv=pass; b=eklkTRHgxMLR5Yw0cc5O87RoldCpP32ci9WZjQGBo00NAHMEFO7ECW2xB3/FwJ38rnron3iaPtuoxc0RimYraZiVj/tdVlG9v6njlA45VdOJiQhtkc73h6hJhBctCox7ZTSlOMeIXiySJgEvzCKaOJmv9SfWktBkRrkU/bxGvf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940041; c=relaxed/simple;
	bh=Ceo/eQzTqKQOw6VV30yrUBdtzlEqkC/54DauyHODWuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsRxo4n75EiIQmWlMLmeKM43cmL7dpLlDbma/Aywco+CMLVsZ/ib05R7uFUvZKKrVJqhKYU5W3R1/F6fIH+UQgRY6lNGf6hK5CXrdRIKirJRsuDw8OxSR8Drsqp5MZvC9griO8U+Uy9H+AfH4J//W2/PpgWXiASR6bBS7p7zyLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JriekQid; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JriekQid"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GqS0v511999
	for <linux-pci@vger.kernel.org>; Wed, 1 Jul 2026 14:07:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=24aInYXtnwOY36q1nTcGx+GLSA67zMg6UsmTMMOvEvo=; b=JriekQidIHFn
	3OZIro8QTgAFnzTOmG7w3ybAxj4FiStpeTTRGBLMAMypxTBXO/RGcUhrKlV7/8+I
	NGp2k1oxd1md4lnH8eLkzcoRP6bO/irin9BMsg0lfaoBV8svypOfCmDIAXLNW5sK
	GtZ3MwaSl62Wu0/6dVeDLcyETxRKmxu3+aaDSQG1+4lqXzSIaR/Z73n1wWbswdiY
	JS+tG40E48v0uq/02iJ0qwE/0HOR2lWNrkfJif1YbJnyfmSRCgkJvV3Ifv5Qcrni
	D5okVxBynFuMB98gOqC6WhFZmaUI875K2RzzzSTr2Jczefn/3aJenaP3WDlVdFCR
	x47wIFjeLg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f48k5qh2y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 14:07:19 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e952bebdd5so897612a34.3
        for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 14:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782940039; cv=none;
        d=google.com; s=arc-20260327;
        b=II6UtgxxShFuRZdH0dRV1t+cRLJEr5gpJ+pSiUkMOiZoNDx6Cwn2IDOsyp/yH8y3O5
         qdE0l1xG9P0IM8fEdNHoE3tF+UqRii+44Nu21QGTaJXUkxMtPqWCVkq3c7/2PA75EhnR
         3iw0aHuReTLYZfMEMc68NkmDHhepZz13gRo0/ZFlqo6NDkq4VZBOjYRywrl/zb39e8Z0
         1DgE8CAUQ7wqA43SZcPslHljLVLKJTegmMGqvZTzO9jvlskK+nwAwfpPaY7Bm3kOBWJA
         zneseWaiT5v1NkYjK2Xp7iG7jMHClSrm01KNh6onRnhFrl9TUnMLp23EHlBp8q68bweU
         ivzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=24aInYXtnwOY36q1nTcGx+GLSA67zMg6UsmTMMOvEvo=;
        fh=pC+solWiHn91lkmQPL5eNardQknOlsE8Cmi5JFx+lyY=;
        b=OV/tHXdFr299Y9T9Cq3yYVtv4vOkUS3/8CmPMszPBfLGhSS4e8+400rLe7aSRAPu6Q
         kVNjmm3AkNcIS1hh7wpwCRuLeWJJ2Vxkha/X+HRhYsEgsMrxhDsldkCrKPIhjtqGte5v
         Yri5V0jflA5G+iAqYYs00MkneeOHRzhlVtQzCDj1rWz3x/sR0OaPwFX3T38NjEG9hIid
         VLlLYvgHTooFAgpXWoNWoAkYhFVbbB4Hxz51r+/+ElVLPfLbl0I6qcaSSd3KQKB5GTfh
         EvI1D9npx0B6pqqZCI3n9gVxCZsVNVmhaikBkfKf9QEivWWYd8/v3OxZzuEgP03EzB2z
         zcXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782940039; x=1783544839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24aInYXtnwOY36q1nTcGx+GLSA67zMg6UsmTMMOvEvo=;
        b=dg+Vc2l1N7QFn2a4N0K1uL41M1HkxyqjE8tweCjWuBmnmQnE5bEJjxJDWG8Xq1A1K/
         vuYXDtVOU4O/ANWJa50JQ1OyuMyEjEzbGvuEBFea+E8Cdvdgrd2k7avNXRvxyB5GECoQ
         wZMwvJ2NoRrLP5OnuIRCQU0Sk3t6ugSndWlsoAdofLSF0XxDKCwf7nxlAq60jk7s4bAD
         m3jhejNkH+JuPQACy2p+DMfzVfr87RMwJggOI9qGbWG2Ayjl01ZsmXv79RbCm9haqLhU
         vfWEQWX33p4maLSj/WJiPITm3zMOKvp8g1PH0usn4o+LH2aZZfXoy24XCwwWkk3Ni42W
         b9ng==
X-Forwarded-Encrypted: i=1; AFNElJ9s4945sn5ux6DY9txtyfA8/+4yGQZ8DCmiGJKzwiZ/d1Em/4jM5H/rDHradSL/h3t66WrNJqIU0+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fMJ/GVFGyt1n65ULFVyMjXDcJCf0nPdXUej/v9YH6kiaKcVg
	ZFApx9bxzlZZn5+vNkp2axo20IjLAkfQ5YYEmqzT4uhh/zne4ehlc0YlHdtU0u1fxvyuR3Axnoh
	xYdijhXzUBGIc5+7Wz4tS9sr+jz+6VyvcOeo49FA6OZUvOyTKjhfYeKh2O5lOQFDcZMS2iA0usL
	pabiD3beXcgTZztRUb+viOSGU8eRN5SD+bEMg=
X-Gm-Gg: AfdE7clT3fzT+RyOfGztGpBWn/Fud0t9rRJZFGUgU7x4UlDsyixdFcG7W6QdEBmePff
	4Ri7SL0jiwEtz3ChYpjdnKd7crQrdNNFdcvKb2D7wbrcK6qZJKa/49lLhEG30D+8JEkM03MhS+h
	h/Mxf3sPd4cLpi/ynWEC8T09fdsDxl4Cszmc+4kRfYF9g7Ll+MIHq+G8e7fufOjQ/LulzYLh6tc
	ys1yp5Oag==
X-Received: by 2002:a05:6830:82b5:b0:7e9:c481:ff8a with SMTP id 46e09a7af769-7eb48b0dad2mr2267496a34.11.1782940039017;
        Wed, 01 Jul 2026 14:07:19 -0700 (PDT)
X-Received: by 2002:a05:6830:82b5:b0:7e9:c481:ff8a with SMTP id
 46e09a7af769-7eb48b0dad2mr2267473a34.11.1782940038625; Wed, 01 Jul 2026
 14:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630224328.3218796-1-zhipingz@meta.com> <20260630224328.3218796-4-zhipingz@meta.com>
 <20260701120700.58bcafa1@shazbot.org>
In-Reply-To: <20260701120700.58bcafa1@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 1 Jul 2026 14:07:06 -0700
X-Gm-Features: AVVi8CfZM9KJwSZGN9TaUIufGVTMoHcKZ-xzBFuNkplSBdDCFbtywxUsQs319WM
Message-ID: <CAH3zFs0bmTTTtw-WZsbhFqzdPfriwOOqp4XAgo4TGekA8HYw0g@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyNiBTYWx0ZWRfX16fwovCCSoyh
 0EI+MUGfnACuAjkJYDroXMNFrQDXfGHCFwLM9UGY9YHeE1PuIlTV1NbERqsYROQ4rPqb2lM940i
 9PEGB+M4T3WObWlg1lq/ypWAA7bjAoo=
X-Proofpoint-ORIG-GUID: eybs62Bfky4foTE6AP46VVDMadp4TImC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyNiBTYWx0ZWRfXz3xdzfuK2Abi
 LWADVCcisCsNlq9eEqYkgKag/SFPVc62QiQxQ3MpIfm2N1hfYj84sJ4jHcB+i6ikDv+vmC2dY1R
 VTCipuNKHm2dejXZKlbJtYaV4gEacoxCbQQ1svfISgBCYuuBuHHFFY3rCSXbOWtW/Q2u7LavhNj
 FwYZ9AZty7fotFv9mebeOP1Yw/WzbfQciSf4qq7rflXjmuftNuYhKJdYmK6JP+RuIiXyLgcpAlO
 f2YyO5MQYtKcBDm5UIhhAwCifL+cwZO+oBX2ki6Ea+T8zZdeiDNPYtqojUlRetETURdlAjxbjDS
 IZvu1RCzOYKDpfj+fXCOfQF800UxTzp2RqXHLDMZ4uWaT1osw0VizO0bG6JrLRnFoy1ih2ndFMG
 C8jOQhrf6Rla+tOqWhPzv+NNGcwtILdsZgPFRdkFQSojsAI33+H7yqxcB9Kka9M3bpNWxNdlC4/
 3nwOsUplO2HGbCG/LdQ==
X-Proofpoint-GUID: eybs62Bfky4foTE6AP46VVDMadp4TImC
X-Authority-Analysis: v=2.4 cv=QMtYgALL c=1 sm=1 tr=0 ts=6a458187 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8 a=vGJ5o9TXFsc4WUGASEEA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01

> Since it seems there will be a v11, note again the comment made here on
> v9:
>
> On Tue, 23 Jun 2026 22:24:54 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
> > On Tue, Jun 23, 2026 at 11:17=E2=80=AFAM Alex Williamson <alex@shazbot.=
org> wrote:
> > >
> > > Nit, it would be more accurate to say:
> > >
> > >         /*
> > >          * Updates protected by dmabuf->resv, @revoked additionally
> > >          * protected by memory_lock.
> > >          */
> > >
> > > revoked also has an unprotected read, but it's previously existing an=
d
> > > benign, and likely just needs a READ_ONCE() annotation.
> > >
> >
> > Agreed, I'll update the comment and add READ_ONCE() as well.
>
> The READ_ONCE was added, but the comment remains as in v9.  The
> READ_ONCE rationale should be described in the commit log too.  Thanks,
>
> Alex

Sure, sorry for the miss. will do!

Thanks,
Zhiping
