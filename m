Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAFF345CC9
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784232554; cv=fail; b=KdDowetpclTkc6Ap6ZrvZAB7fhjwgs09Xu93KuSpxn+9fiidp35LckScSf/8Bt0JUP191LYJS1nCevsAymP08Va3lACqquHTItljf7CGuIcCEcQAza73vifPslvcuWh3huMUW1zRaaYVwMplpaKoVE6f5rSP05DXO5nULWvdlLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784232554; c=relaxed/simple;
	bh=fyZCLJIQW6xH8mOeeNx9UNPdCdkhruJNt4u6M+kl3Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKyKzYBZArmYXKDfkax4Q3tb9HiYctSbM3rn+DBWJuBRebk1cMWu84t2c/uPxqusmhnVCoF6GKd3sPlLvDYsDq9ibFy2CFy2QL+cd9g5s4Mx/GziFi1NTBrG2oFyANwqznsxkqOl1HcK03EK6U4kcx9aMyLZ8dMpkLIxM5sNDgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=G0tBoJWd; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="G0tBoJWd"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66GJqWBX3980137
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 13:09:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fyZCLJIQW6xH8mOeeNx9UNPdCdkhruJNt4u6M+kl3Po=; b=G0tBoJWdvaDk
	Wz4me9U9EmzdxbVYlbLVAfjJCP27d6V5CRGhDCsQxHd1wC51VEIW5NDlLtPdhtid
	Y3QFaqMgURyUh0GfmaRtX7cvFRuYL/eUy7XWGSK3W1UnNuGcmMhoDVxFZhjVwFdj
	Y0SJW4IzIYBm2nOniFrlhPh4CgIXlUL6NYUYlHM5wq/J4bRwQDAxtQyQEQjDAlw2
	I9nTh3mwe1qX+xfUsDbEtUHrMMFEyBk5OmI7ZaemvGPdpXU1zn1/SUSGNVDz9JhF
	gyGozHXiVdrg4wtKnjIXepWNvHOqU/PxZvm4VTQ9a9r/fvoy4pXcJNqU6imFJJms
	GDfW2AvWUg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by m0001303.ppops.net (PPS) with ESMTPS id 4ff2bshnw0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 13:09:10 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9fdc2870fso4041613a34.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 13:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784232550; cv=none;
        d=google.com; s=arc-20260327;
        b=bIcuLljhWbatQuhpelNc3jnp0rvLfkOcoGZI4V4EYFFOUv3wrUgPvxDIxSCDJ8FeDG
         XjiG5f6bj4gxaUyUA7WiIDSvxfNumSnNPMCravVLVpSZ2NekGYPMZZbDgvq9bsdXkqAm
         5dvWtoGbqaA6YJVj2IfbpBBkAt+9JIQMT0awUi3TJ8hXR5KDWYiY4QwfNW1cBEgTUx+L
         5fkp7aicogAAMcYE+rO+koLQIik/MpPsZYcXok8XDcB+W78cDSF47OnoMZpG6ETpfhhP
         6Z6UUhl/k8EH6Fkjmxu9pWjhtzBpV7C58vVc3tYcwNb/goDR4oAJ/uCd3J0A9KaWP0s8
         g+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=A/MBU9UxYJ0LTf7N8/pjvYID5QVas5vE3ImYU9370R0=;
        fh=d+wIdBuQGYyr3VX4RxLh1sulq10t7qBh3Ll9n8lljaM=;
        b=SCi5SKgdWvZ3uNHkpY/bdIZii5hLH9O7Fdbe3KPcAX6PaDC5sMV1zBcnX0laif6kUQ
         flh7hRERADC1q4YaEWnK3SsHIFk3iRzBQJvQGGYLuvevmj/a8/IKvdgzsWXgYEv/FC+z
         tBbhlumbmgGBBUXkDvReymbk9Koi050FQ/bfquFpTQELyDZVg66Qfda30EDH5Dyfqi3s
         59pP+YoXNwgwQn3ggUHrQsNAK0h9/RQtuYJohgOOAd2RG2kBJ8t4vOlMqpIURt+usBrR
         P/77pzKj2NCAljHFDzWyfkpaztx/Iptlrh7wvUbxOVBvg0O9aeVUTIBm1L6S2M7bWUwi
         eUEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784232550; x=1784837350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/MBU9UxYJ0LTf7N8/pjvYID5QVas5vE3ImYU9370R0=;
        b=QjxRl7FY6dsRaMkM/1jtEsplx1a4OtzYn2VTRgd6/h15ouDXipZZgtWK271Tps0qot
         C8dC5+dKub2BSwEviZSlEveRaiAIGcRMl3/W/BZfMraW6UgUOgYTAUYoL2dzhFG7Y7rs
         NLmtVa+Ns0ZYRqpw5YvbxFCeslfMX/uR7PYZdifd0d77rO/DkvEgkcQtc4rKEtoNEbMg
         WTnzDhxjgtPcRkEi331h3ze1BqbkZmMU6Oa1aZpCGBK22J0cLbJP3uAWpFzkQANFO3jJ
         UOGDFF6zQ1Bjoac16MUe7uytQTa0ibFoEsBQmqMyw7IufD1QnvWAmM/GhBQl2+1hZGsj
         hIZA==
X-Forwarded-Encrypted: i=1; AHgh+Rr23SvbP8zHwrKYThzF0SXn7/fh6F90j7ymejXCjHVYqjO0K2Ui08DLnz7HeFs4rE8UW1UD7pBh2N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJoxDccfhJMBeLqLtcTYp9XQBiZcMjkgGcjw1AEysjmj6QlFhb
	4W9WyQ4aao/Aoq8j7UFgrHqKiHbkz5yuxJ/39KlI8MKb/h2GUZacVcLGcmo1WpCLVpe+g0bMgyo
	ci+8Mm+fiyQy58dvrLX3RqPlHAd30N+Uv80mMyx/ln3RTubWBSkusr4K6EBzGaQDyoHX0gXx+ib
	HqxYI8MRUQnwsOwufEODaqcy5mtUEdAmYxtOY=
X-Gm-Gg: AfdE7cn1kwHf+TT5rN6PLcGoB7RdxwPSqEeCqq/spAxVgDtjDCNEHZ6KjqBD5N0voWx
	cxEmay03cwoQ/nwXZeeDNdE0uKgnaFkszm0kYJe+pN2cVx0MYK9In8V14APfOVuPjvoBv7P52HT
	4s0keb3c9JKLD/fwlsiN7U3DlNMhZlQeg7XlPjtdBGJRd9mfQH1v/tZvrC7UT3R6s4SlYGEGu3q
	r+hk1CODmyGvJApcfM=
X-Received: by 2002:a05:6830:6aeb:b0:7e9:cc39:2ef0 with SMTP id 46e09a7af769-7ec59cc5592mr5232588a34.18.1784232550367;
        Thu, 16 Jul 2026 13:09:10 -0700 (PDT)
X-Received: by 2002:a05:6830:6aeb:b0:7e9:cc39:2ef0 with SMTP id
 46e09a7af769-7ec59cc5592mr5232532a34.18.1784232549056; Thu, 16 Jul 2026
 13:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715204008.3911275-1-zhipingz@meta.com> <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
In-Reply-To: <7dd5c995-a23c-4d3a-9ba0-7fc77972339f@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 16 Jul 2026 13:08:58 -0700
X-Gm-Features: AUfX_mzMEcC_t0EX7NJOVZpINMLBmfJ4Fcr0yjX2dQzL33Xd9YvVjPxD4eAksO8
Message-ID: <CAH3zFs0Wbz5EYUMQArmUtT-jdAtisafw6e89RWKZJrJpipYQoA@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX3Zt2x9ALamxD
 /Kh19h7DyWvPJvlc+LeVPPIpHUcPFvr1mlwNAS5Cl/WooRg0urfGq6cl4iOasXr92KpqvHG0uhi
 kc8szGNcKu52xk9ESbEnMEjMQc8522I=
X-Proofpoint-ORIG-GUID: gRH2QP5ISWMqI1dFmU3ZP1Bfvkt0yMqJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX53f5Ij0W5qZq
 ObDDiXrcgY3VnX6tEbibolegoR5qrwP9C2ltvevpBbo/6mrWXgSqQcLmIUQFcNZY8KsSUBS+ckW
 rE1i9d5/I/FtD7IhdK82PhBawe3V002S0bA3KhssYs69iMxJNlxRvvuvDI2t5hp5w+CQoGJw7gr
 OevMO3GYefr+QFr/yInfEFs+0VUQCWebLJzSvwi7ESBpx6xcaqJNIt6unN6LNmpP5u4HcO3ni0G
 I8Ty8Qg4mJKIEYysoZ97QDB3t7WEMjPiF5Kl3mZ5svTU+3/Tkp2vJvitjaxFi46Dt7fE3NWpKB3
 8tkaodsEFrsOXqhQFFY1PxYXVCHtznmEwlrwGIohKlnVkRZLH/3dlrZG3+4acmbDVxRKxsjSpzc
 ZwHfHEQJb89L0x5W8iCvGJ1bhGxtIExLEh+wNTav36OfEbSCxw7EowzV3r8AiA2/P9MUpOaO5w/
 o6Ni0MIukIxTGAg5sCA==
X-Authority-Analysis: v=2.4 cv=ftbsol4f c=1 sm=1 tr=0 ts=6a593a67 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=i0EeH86SAAAA:8 a=G4JgLt0UOHroHTRVxaYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gRH2QP5ISWMqI1dFmU3ZP1Bfvkt0yMqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01

On Wed, Jul 15, 2026 at 6:07=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> Hi Zhiping,
>
> One concern I'd like to raise is the implicit topology constraint of the
> TPH P2P path. TPH Steering Tag only works reliably when both importer and
> exporter devices sit under the same Root Port (or same TPH-aware switch).
>
> For cross-Root-Port P2P traffic (e.g. P2P devices located in different
> RC or even socket), most server-grade Root Complexes do not forward TPH
> prefixes through their internal routing. The ST field gets silently
> stripped before reaching the target device, so all TPH setup becomes
> ineffective with no error reported to user.
>
> Because cross-Root-Port P2P traffic with ST does not affect the host, but
> merely the completer may experience some performance degradation because
> it lacks the TPH hint. In this case, I suggest adding restrictions in the
> uAPI.
>
> A further step is to check whether the importer and exporter are under
> the same root port. However, this verification will cause the P2P TPH
> to be unsupported in the case of multi-host or multi-root PCIe switch.
>
> Thanks

Hi Fengcheng,

Agreed the RC may not preserve TPH across Root Ports (PCIe Base Spec
r6.4 =C2=A76.17.4 requires all intermediate routing elements to support
TPH, and cross-RP forwarding is optional/implementation-dependent, cf.
=C2=A72.2.10.4.2). But the uAPI can't gate it: there's no discoverable "TPH
routing" capability -- DevCap2[13:12] (r6.4 =C2=A77.5.3.15) describes the
completer, not P2P forwarding -- and a same-Root-Port check would
wrongly reject switch and multi-root topologies where ST does forward.

And it's harmless anyway: per r6.4 =C2=A72.2.7.1 an element without TPH
support ignores the TH bit and completes as if unhinted, so a stripped
ST just degrades to the non-TPH baseline.

Thanks,
Zhiping
