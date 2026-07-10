Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0EE3B2FED
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718026; cv=fail; b=uU1vpC74HPl2/xSmvR5BAa4uUQgKFNPijiC6jRfecx/8GnBEpAE5CNOTyqi+hmKHm9w7A+vgDYYB/7JS2YU67BaG5FAq156UZDnzMRG8CQjb2rpth/7GsQmQ//0fX5TCrR8HSlpeqDz3MEBpG0zk+qDnAB3joUgtDVc6H8Bdwoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718026; c=relaxed/simple;
	bh=qTGJ1qCsNSroWoULGPtpQMjb5UjkQ/i1Jx9oQeZCKyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQqNi4g7ygAE8g17Oi43VDfsyklKz1lycObaRMXzBN3CPu6nCTJ0xVW8DB1LM5fy3MynWcJfjoTolkDWwim9zm67ghteKbo183G/MVnFFDHvbgCPJsNGvubWX5yCaL5KR/ulHc9aY+5Jt/vqQemtlICEExwy90gnNOjPpmRghZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RYK35fQ/; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RYK35fQ/"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AK3jKa2602606
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 14:13:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=RF8cFAwOnRSkhH9D0DDvmvcNKGy8nfBCbBtEkVfL0v4=; b=RYK35fQ/CwFt
	9Y6liH/+T+e8GjLaxejo6rcLnWNoms5TDAneieLNEs3hl1aa2PsrH/U24euiowpl
	9luuMEPbfvWzkjV6f+XoTtHYas77VVD5ZWtxfcDX+6WYOimoCorso3lVvOn7BFr8
	jgFGWDg5+s368ZiJ1y+Idu0Hy9dtSy4mLqOl1ApPtN0Q4jAwmaMMJYd/7GaIeqHq
	hRwsF7KvtNf+HLABfW3TP0f6XjwilIPxO1af7LFe+Aa3IMnPKCrPiujbH+hMKUIf
	QrfNgj7RQdzrvELzpA8rSXxe86AHthCE8wer5/AyftFWjSgImjzNasXhC8aOsEav
	+4nOGAwTFw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fagek85te-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 14:13:43 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e9fdc2870fso784296a34.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 14:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718023; cv=none;
        d=google.com; s=arc-20260327;
        b=DthEuVRWoL0lKYs1HeZxlppYrP0rX5tFdn2FFpVFtYyjg3K3M/qKmTwTd+jF6KdgoK
         59nIE9x2LIITGNgjyAbDCeICWWkVTn457cKq1oKJMFfWUImZWQVeB8CTe4pNdgEkp0BH
         QZQIXcjpiMVwzIttRW/PQov+Xz3K6MxKyK7TIo/QIvtjNUt4e6fhEkHV+c2fGa2lM09z
         U0gLe5koO6uR5skjf2/oX7udDS9kVg7tej6AGg0Jjg4dJbE04ClsI4C6ggTa578BFBJi
         qvlx2Pm//AZpU2SAEkXDYt/xyeTsZNIw7nNViepcF0c1gyh+T+dsRXs4pB7kYdC1JW62
         HqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=dzINuCyV1AjhEQXZagg0c3klT12KrUQB8e556Tlb738=;
        fh=jrFdDhXf0f9lTUrtfd83wUba+l9WtozZMvZmrNXHwg0=;
        b=bJGZ4DY4L84cBjybw3rxqbSDZADbsa+Z2AGH37o5TefqBBl9c+q7Nt3Lr1BV/erXRR
         2SQoNgRQZuyImZkk9dbJAXnLIy0rirAAX3kjzUl8UufE07WIm7Z1mCD1tI9erIP99YAt
         aiM/ZA91Hr8YDFnj9W3ztSnKIdGyn4NVKnxXEuSwEqkn5oR7TE2P9Kb4FJLie9u3CWXZ
         pIr3HFwV+4peVFM5p0Vkfo/EZUbwzuCnwf85EmQap4Umu/TmT1B6HwotuXXw5houAP/f
         57Hc8H+PE0UjC2K9mKIPWBCnXvfbiHJxb7Pe9BX8b44VL6Jsh2nRAC66y3LUcNeTkKV+
         oemQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718023; x=1784322823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzINuCyV1AjhEQXZagg0c3klT12KrUQB8e556Tlb738=;
        b=FaB44chkhYWFW5sVXWSiO/J/jPTorFIkWYigxLFCuC/6DBuh6aiEv29yuHCwyHJvsE
         L0uJAqsInb/bEo3XoUEt3KcItbEtQhwKnEvS625qTkmPIFn2/kOtCfCtU4r2rdpOAw2I
         NtuM79PGrou+Ns6DJN7u8C9RnN1dkIDtjJC3FtkiagBOgIsfje2yVyFQ3HX0PgkTN/tW
         Lf9qcvZYF8KG7F7z7snfd0XuuWS1sIrB4h2984X++rov6l3KOG/YQO9AvOrvW87plRGP
         nbaoE0foP5fbNDhoRsrYf0aNt1YjnO8KFLabSCXOYxfubBGYiIXKvVFh0yhR4BjR8wu4
         W5+w==
X-Forwarded-Encrypted: i=1; AFNElJ/0i5U6FICxukffboYJNChMrv3q8yoL3n4bl55lTBtPzdGSjGNVKC5sL0U8CmS4G6mmt6+ResB8iNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywapsx7n3tw8kJeT4nFB1tpu85k62zXaYTqtbTjmw61QQ5CfJaL
	bLLJSJyYO7zrwf8N+S5PgaRSv8aIdaYxIW1Li83VhNv4CAl+aPvppvTOROcdrN8GZTVRAt0KdHJ
	bRZjztr59Y1VxISoMPzS5EMGz8/PdWj2r0lFIP0phuSZCczgqKjRoiTG5NC0pcC+TZ8YcYjxz9c
	6A3Mw/2Glu4XoLGW6Dt7uKRzNxN1P8aXknllY=
X-Gm-Gg: AfdE7ckFK+piPId1mEDtjixMjlugnG2waBnviJhtoQbQlawmoXchyHClms5kWwak3qH
	6qJM9MDoPXbwxHB/T3iEK0it0O31BQs0fagYSGHr8kQxmeGWLsJknJxFhPm8+zSuE41j8ZSsq/j
	T4/7JPlCvYcrhUw6q42KstUPb23vU4S+UqTQKMQhKplGYsagOWyjML5XGVtgPL3r+04qbK8FINY
	E14v7b9GmA=
X-Received: by 2002:a05:6830:6c11:b0:7e9:b772:9aae with SMTP id 46e09a7af769-7ec0981c52amr316864a34.23.1783718022932;
        Fri, 10 Jul 2026 14:13:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6c11:b0:7e9:b772:9aae with SMTP id
 46e09a7af769-7ec0981c52amr316843a34.23.1783718022507; Fri, 10 Jul 2026
 14:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702181025.2694961-1-zhipingz@meta.com> <20260709132602.6a3fb084@shazbot.org>
In-Reply-To: <20260709132602.6a3fb084@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 10 Jul 2026 14:13:31 -0700
X-Gm-Features: AVVi8CfXe8KvJ5Z7sUtkIYqefn9JRiYpvw-OvxoKOz-vRkAAzCUP8YaHHQIwWXo
Message-ID: <CAH3zFs3OwPyTrWk7oaMYETq7sBEQ7VRfDtzWWamhiE3AJzVShw@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
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
X-Proofpoint-GUID: 0h2uyxyP9Eib-c6EJV1pF-IIYGvGaMuw
X-Authority-Analysis: v=2.4 cv=W8UIkxWk c=1 sm=1 tr=0 ts=6a516087 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8
 a=FfEKJDObtavKmf3ECVgA:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxMyBTYWx0ZWRfXxo90bPArDdDF
 VywzMzdtf4JLRj9oYlt7KsPQPiJEn7y9PX8OlGfAuLHclA8N8aRokjutyGGtnRv6RnIwg/AjUVV
 vFtfMiMJbj9qi6QewtNdW1T8GNMBTHb2RofiLW3pYhlAQIL6ynnBXiGGPQ+OD2Qu4NSV6FJUvJN
 xOYrvvNYt7MidakE92wR+jfylBkYogeFkQN1L0s1dqMfR9jy1QFIHWxtq6SmpQjmTB5NAWgac2L
 tNqZup78Vuzb9zoEYLlDeNbEV1v4lBk1YhlD9FpRw1XS4vfAz+khnV8AKvW+pS5XkR9Abac2S1u
 5UqEhvZ+nBc+APryiHoZOa3b3Scj0FOf2sfCkQ+xLm/I0psLI25GxeYpii0Lp0J4y9GoWIfOvx3
 vMJ31hzrlnojaxt6SBKdGt303+jyRJBk5rU2KHapiZajO6ftULx44SKpK1xoQrbGEvmG9M3bu+r
 /cwHvDqpS7x54xgmNVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxMyBTYWx0ZWRfX1H75ppA20J5m
 UJNcH4XH+DQTxlf1/vaJdIB2C6yiTlaPxF81C60TlHJpHM0r+z012J8AzZ4q5mUPgqez4ZkhHY+
 V9c4KeV8Z6z/I4RMdEl5lpVh3YXnId4=
X-Proofpoint-ORIG-GUID: 0h2uyxyP9Eib-c6EJV1pF-IIYGvGaMuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01

On Thu, Jul 9, 2026 at 12:26=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 2 Jul 2026 11:10:13 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Changes since v10:
> >   Patch 2 (dma-buf): Per Christian K=C3=B6nig, document that the ST/PH
> >   returned by dma_buf_get_pci_tph() is only valid until the exporter
> >   invalidates the current mapping and must be re-queried afterwards;
> >   note added to the wrapper kernel-doc and referenced from the callback
> >   kernel-doc. Also add dma_buf_get_pci_tph() and dma_buf_ops.get_pci_tp=
h()
> >   to the central dma-buf locking convention.
> >
> >   Patch 3 (vfio/pci): Per Alex Williamson, update the vfio_pci_dma_buf
> >   comment to note that @revoked is additionally protected by memory_loc=
k,
> >   and describe the READ_ONCE() rationale in the commit log. No behavior
> >   change.
>
> Sashiko has valid comments[1] across most of the series.
>
>  - Passing through 0b10 seems mis-categorized as High in patch 1, but
>    is valid hardening if tph_req_type can ever hold an invalid value.
>

agreed, not High and pre-existing: get_rp_completer_type() is from the
original TPH
support and untouched here. I can send the hardening change in a separate p=
atch.

>  - The documentation error in patch 2 is real.
>

will fix!

>  - Patch 4 ironically fails to re-validate according to the lifecycle
>    requirements that patch 2 specifies.  This is a significant gap in
>    the implementation proof for a real requester.
>

Got it, I'll re-query ma_buf_get_pci_tph() there and reprogram the
mkey's steering tag,
so the lifecycle is honored.

>  - The broadened scope of the existing memory leak in patch 4 is
>    already addressed in [2], ok.  Maybe should be folded into this
>    series if mlx5 isn't going to pick it up separately.
>

 [2] is already accepted and landing through the mlx5/RDMA tree.

I plan to keep it as a standalone dependency.

> Thanks,
> Alex
>
> [1]https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260702181=
025.2694961-1-zhipingz@meta.com__;Iw!!Bt8RZUm9aw!5x8TPHfbpTXQJ872nmZaHsPIXH=
7HsL9ICbZR3G37yKkHgB-RukCDOy3XiLIOhfhP-yTczTyWQmud$
> [2]https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhipingz@m=
eta.com

Thanks,
Zhiping
