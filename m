Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752EF470441
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453113; cv=fail; b=V4HFGeaRQ/W4O744YWpBEJuWSWhqgcEhHlBRsoVEIjkU1gygD4L7fjRcXKSvpkcLOk2qfm3jljKRWj5Q5tw0D935VnPf/MEYUYYdwTlkxV0c+X5ytwLH7WvfQw5JQhkd8iBbrgJ37pJ5kjyLc3QCdBmSvyLqUVOs8fZ/rCwTwiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453113; c=relaxed/simple;
	bh=mZkWuf8Tw1ScJOiGAEPnxEFupaFuqq16dRc3IKYjOE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+xxZpivyMfczPz6sg1TDH4rU5EOIfSIF7d712sk2XRQUIehFSSL7z5QohCx1ErftDfwPNa5T+pyDBxDZwiYXA1l3wqqmOjiwurWhHr8Fvn9M8mdJ79Fx9iP/0okOPwr0xQ6aLyTsV5LeZNB5Z+FkB+eGnyeFQ7pNkhSQ8Mz7DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZPG5m1H0; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZPG5m1H0"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UMvhjA3616562
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 16:11:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=MQZvIZut96GvNci3X99SyHgHT1lUNbmnZFvwy
	HttL9g=; b=ZPG5m1H0kFzvBQXgU72AfKEr0Mo8eXoJw9AH1/+AoyWU7osEmWB1z
	iNvtHmV80qUf0k9PBJJTcfkIlfCWYzIDz54TT6UqLhtCav/aSCsuKdYrdK+yjbKs
	bLeCRcQNikVbp+ifEJTkQF3dR/DeItQRPhrhflZt5x+CoUScOi5/4/E7yWqcX670
	kgPGlHlvmS28rVFWAQpIoVsZj++Jep54aE6u7ej0D9jHz7rWOgyDQehRxNzMoS5D
	GOzc8kDSWwGuciCoGmrGUEb8lyCkbAj6zA7QsFCBgTCnZkV/Rjub+sbXqVZAkzK3
	T1khLdV0Lkx8g/3l2RUTYYemAI4aFv/gw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fqrhh171q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 16:11:49 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7ee59eeb8c1so330726a34.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 16:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785453109; cv=none;
        d=google.com; s=arc-20260327;
        b=ndqRlOCLdcyDBlq0CJNb7l3iRzDJ8k8ySTe7Jk8UqSDTWLsYau9oaXrX4+wMqLTwfW
         hIC6pc2H+H2P70Z+iklkE2YPoU24rkAObI52uv6hKYgQy4o5oXdmFOClWGrWyJWpRQTQ
         grnM9WTYwtVeTKYMvxqHWPMyCHS96+OZ6UgqWTWzOtAWDJrXI8RINjr94xHPxnpUEkYw
         4o8vn18dLJwxOR/NvPa1NDb5H+Xcoj1dGIo3BgSaHHjr6yLWirxISAa5biNSGCD7oSKZ
         Ye14Btv7NNV8W6VwhMCVg1xezM4U0bRw9byf5UUCaqtIGuZKfjbobCS6DBtOVvJybUnP
         IAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=M/ULMas6IYvKWt6d/m/OrKQfnMR4mdz7pKS0PvlT0yk=;
        fh=HfYcnwI/QYUuZw7s6J8VNatLBmZrAC0KqWeR7SySMA8=;
        b=d2ZlPDMunKxBIryrhn4JLt9SAEiUDTGEp23vTyq7ygR7ohyzcKHuKK8HfqsxmS8cq3
         lsWYlpP7W0EEqYiClluvbFOvS+ST82CHOik2CV/+jcMX0pjCvjNARfb86evTJWsAeSMm
         2X5m7fQfDvB90PLE+cfdOM5zlPEGgGnOP1llj9oDmL2Q3EBb3bAnFCGK9eYSXblQLsAY
         p/Jakj02IYy9MaATJeViho1D4QLGg2ESrRJzidax1l5s6JDeOxn08PVlT53PyjQ9dYeX
         9LvzU5cSuyFOprQLziBmVAg44jdbFlUSDYjeDGuuIvcqd8VfAML1Av1q9TESyVOPeHDP
         lvTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785453109; x=1786057909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/ULMas6IYvKWt6d/m/OrKQfnMR4mdz7pKS0PvlT0yk=;
        b=hX5hpA8g8pLqngj1j0PK4XIxuHu+ASx4EmPxguPtYD/avEHXTauiw3Yb0WDY9n6Jtt
         Bn16oXJ5/msG72IROe2p6vAjyAn2QwAosst7yX7VX6cMb9C53utRpVsBZfUOcAtGu+pc
         wdnGt2FgKxGHi4cqYtsNT5LA/f+5dVQwe0aNX3/pjs1KM0eIyP99NBzYony7vTlRWwUB
         GirbCnmjcnQ3Fy4g1nUKudr2P2IGHnNJa37crWeN6z0/uAJZ8YLBpQW7tyZ8GmCotVET
         AzsFbbS0YZVxbaBj4j3WNsORwhUEzR1NSwvSqMa5KyOQiLXEWsruTrjqchP/87N9zK6e
         nbYQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEkwgtX1w5JFEd6rdmj8n4wSFUFnbQwj3FoDwigT0QrByuAAhVdLEnGqdkhUdvtmYf14+cFOMJdLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGPH4JSrpRPtdbekzNJnUR98PLNTkTwlperK4ydaOwYT32JXr
	7JCAr6T87eg7wDL/gyIkFcZV3yhG8Zj6DCbmFTWmb82OIn5eZWhgVk9FNdwgJ9FCN7jSBOA1Yxr
	IkweLgHnPatJ0dzYr8LyEjBujMD1AWJ3gv1k2wCmQVye3Z2YeHMawpQfAO2usUXlWwVnU/pmQoP
	quJobVnt5AtuXXh0xKSy7mAt6KaO9+u/vDotg=
X-Gm-Gg: AR+sD10x5YWtN//Pf9SWP5elbwy0H6awuOe+vXHEriOzJC+545qqLchU3QJylZ+xtbH
	T+o7xsLKTTUbZ3NsqpPWCYYqOJyfcw9NBar4ui+ZphJSCLRzXjW7Ih3A/v4sLDYkaP/4Dd3CXrt
	5VQXbcKJzjirIiVXCcf+TFBqNzMnJdREfOI3fVaqK3LKvb7KZP7MxQuAykEW6DBSwDs/UD6tZI
X-Received: by 2002:a05:6830:2b27:b0:7e6:e349:538e with SMTP id 46e09a7af769-7f02c164dfdmr3481507a34.19.1785453109090;
        Thu, 30 Jul 2026 16:11:49 -0700 (PDT)
X-Received: by 2002:a05:6830:2b27:b0:7e6:e349:538e with SMTP id
 46e09a7af769-7f02c164dfdmr3481462a34.19.1785453108481; Thu, 30 Jul 2026
 16:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720172304.117134-1-zhipingz@meta.com> <154760d3-a880-4d1a-b949-7d22efb805ce@huawei.com>
In-Reply-To: <154760d3-a880-4d1a-b949-7d22efb805ce@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 30 Jul 2026 16:11:37 -0700
X-Gm-Features: AUfX_mw5Pss60TeCzA9vFQZ6X_FK0vCL-oQCe7PFRlEJhncMdwP-o_KTKHFf72o
Message-ID: <CAH3zFs0L-k209Ct-uJn9UOctesJRWf6RmVNyD0kfhDdDtpu7JQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/TPH: treat reserved 0b10 completer encoding as unsupported
To: fengchengwen <fengchengwen@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Wei Huang <wei.huang2@amd.com>,
        linux-pci@vger.kernel.org, Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: r9Yn7DkoxW9lynfZ8A4zPETa-aCI9Zim
X-Authority-Analysis: v=2.4 cv=Go1yPE1C c=1 sm=1 tr=0 ts=6a6bda35 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=Ey0NKmTq3IFYR9_H72sA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE2NSBTYWx0ZWRfXzVEHcZQHqJO8
 7pnU4oqkONC+SdaKmo9eIHXouFBjvpI2hRUJvcCVmGXBLzM/omUtMVhjcgRmUT/1wrjuS/+m00S
 bGabTDZX4qMd27tCSt3PlhhB4eZe1Mo=
X-Proofpoint-GUID: r9Yn7DkoxW9lynfZ8A4zPETa-aCI9Zim
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE2NSBTYWx0ZWRfX0KuHTTn+YLTH
 DjJTq8xv9hyHOgZBNi9am4AMCXwAPOINSCG2QYsupN4mIhNlS7QbLX2XDxdvVNa6MegJ0qWuhX3
 4nMU4hs8a1l7FT0izwaci2VreScYkbPI7pgAZ5rCAHISuhwEkCkVr1skZ9ZlfjS4xPiWj8poYY1
 QnR03sSXBLH88FfjV0FXp5ojeC/ma32oPtRBzovQ3QD7lG2rUV3kcwq9WMwgxBKAyRRJgf86P67
 aV14DIZQ4qKudwfuUwnkJxR7ao2pC9IStczIFnUQkYOEYTDWWuCO5jfACHkWAA9fUgxJrY4cxBN
 dvrWKpNXyb4+opcFzJgWpI5L1hpsnnVNUnUGEMCl3vWEwhVNs4m8TAGH12UCp21owh7iwtCf/Xc
 ipAqKFyHNzl0CRCoAV9gV9WQDHUa0XqVULf6x/ZpSuu3nJOOnynfcRy4i7H6Qd0IwTkHsulfWqB
 /DVFnXhXco4+2FeoMmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01

Thanks Fengcheng and all!

Alex pointed out in the vfio/dma-buf TPH thread that keeping this as a
separate dependency makes the main series harder for review tooling to
apply, while this patch is a self-contained hardening change with no
known affected hardware. That makes sense to me.

Unless you prefer this to remain a standalone PCI patch, I plan to
include it as the first patch in the next respin of the vfio/dma-buf
TPH series.

Thanks,
Zhiping

On Mon, Jul 20, 2026 at 4:42=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
>
> On 7/21/2026 1:22 AM, Zhiping Zhang wrote:
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
> > Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
