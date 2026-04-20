Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4762D3EF2
	for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698847; cv=fail; b=k11sx9Um2v0qLXMEzS48rIPvMvtbyHEyU+sN5RPKJy1Ur6c85i5hTijNrPVXcby+KhVRj1ygjlUvwrfygNx97D2unfawsYeoKGteRSoGqRvfL0A3BfKX2UZQIYGaHAZVMfWG5+1zRjCANHhRUK5Q9uPw6xuAXkLAc5Lvacebc1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698847; c=relaxed/simple;
	bh=L4kuFzmhSiJDEDk3U3r8fzjoMUjfFI5f37vT3OvTp3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uM1cZRZ7swJ7MBi0cR+btbg39EYnIDyh8801BtTtXkBZrVf2xCfNUrZfN6mCpEZjj3ospp6qGUj4WM7521W4fqAy3pdjRbMgQ2h4rekGAHNnVz/jYbNHusIs8KAQHyE1m+JdRQs/BsxSlvV9amsBu2TyGoTAlDmyc1hFIUUmk+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VB6Tk7Vb; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VB6Tk7Vb"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K4GQ533484258
	for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 08:27:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=61B/9vU+A81G4L+O2ZcjO81N3rDPDghM3foVO1cppDk=; b=VB6Tk7VbeUQK
	A9Pk08tyiCLxf9O7NfIltXyIQz9qKIiKA0BMqK8k/pyPvQQPoZgS6yrZl1Ra4cFq
	097unjjbAqqjerTpJ04SpD0SlZZIZwhd/pazve6YBvqf8h+ekIQzRzY/KBK/L0L3
	08mQWE0/x+9bR0iJ+/J6YRv2CFSetyevaZI6p3Y+uxEN1DPeXH5K/GVEM5BjBw0r
	rVwGkEDFpipH0phyDnLlTx9No5z9bf8XyheRH+QM2BSuYmwAt8eNVQzCy1wk+yu8
	x9jLcToMyxDwU15jBNC65YX5vbiopZbutxSj/yzCTc5ZgW7K7URuFTEoyJulfsgK
	Ay3mTwrBig==
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dmuhgnv36-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 08:27:24 -0700 (PDT)
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b90bb54d034so407434066b.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 08:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776698843; cv=none;
        d=google.com; s=arc-20240605;
        b=Z9FMsP6nG65BcQ1Z9M6ctiIig+5nQwTsZxuTzDkJrtR742eY+ZjM/LpGqgsYItzLj3
         EXfnnr3XKNUQL7/umyYVwL54fRhY7jNp3OsuPURezX9o1xAfhvYg+urDK1L1fvPhcz2A
         teF0Jdouc68/YMJk3wU+vs9hy78rWYFxsU5pGORsf64kKlRZ2B3qx6spv1BzVuGlJkRO
         1vZYsREa/7v4HX/K8l8rbDG54apyhZU7P3w8l5m+GroqiROZIBvNMO1/HQg5RUsW9FIS
         We7R4/8NVXAhVp849ifD//TU0bCFGhBP1nYvr5bEKmNl3V+0ywQNndgytlppo8P4tYNj
         R0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=RqAzmhyz8hrAMpUPFTdW8M9BUToBqVnAvelAPpDQEdE=;
        fh=UA2AOduo0cf2iotDvWO6FplXjIxaHP/B2Hlv2tZeB4A=;
        b=UPfCK5RfMNdXwVCcvewTfptNnc/aT/cX03bNVr3tf1nYGI9ThAktu9t20mrP1TXgRR
         QKWRsreIPu16SJHnY5wr3OCUlgUjdGO0rgfcjkl1w52lCOK4i4mnn3sJclF+oj/puzeV
         0XNWYNoRO30oSwPlZKB7SABYltkbqw5N6xf6hwm0uTOufVaNLq0V17oCgeIDIXnvoq6Z
         UHQ8bp4iCPh20beFn/BGSQwOc46R/IwstKeUY++vLuRhy6ybIc586S6gqNusqTfQXNjQ
         XYAZJWqrUwE9Ie7o6ktB08vykvG8Bwx2wIDKdHb4arM8mWomf9bDGUL4tTAxUsiI30ck
         Ygmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776698843; x=1777303643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RqAzmhyz8hrAMpUPFTdW8M9BUToBqVnAvelAPpDQEdE=;
        b=FdfxTnrQcDxpSil6Bs/24UrEKYTI2Valpfe/RYSMb5e0lyzZ+dmKvMFUXVS8D74zgL
         bUEM1lZcH9vppWbef05DojWbjyiCw1vuAsojL/bhEwh1LFkRaw0A8qvwujyFPaf4wqTn
         x7TDM6gTj40ZI30S76rIJXj4qLHMdGUEV0pwRfpNdQPfjQXecxCp7ZeVKT3m56gw9WCz
         UmETOQquAWkiRyMm14lu5sdasBw4XRbldev1TaYzGG/FfE8nGylCrKdmflwQBZzsi19G
         /FsVP7mlotSNE6VvFnfE7DU70wY3QjRDUi0zK9V08uy5WV6YW+nMxqsazDuFTQBfNGcn
         AI6g==
X-Gm-Message-State: AOJu0YwR2DGv3nxX6F+4XuLU2Yj4GnzZjJC0jM2lkpptXzj7iRZctz9K
	+PC9kYdcIEjhWKzTocJxSiezPfDdbsDxcx8rxBnH0hGJaMgaMHwnA5WI4I9zjxH5UKD4UGNf5N+
	3En6kp/MV0XiyGqZz2HVyC970s0Zz0t5FlLx5jIHLcQG519WhPvYATZZdMLLWL0jOdNLxBWwG12
	5SBc9YoHSc+rekLXXMxcUnB+1c5B7HdmUuZKLU1wMCxBaqSi8o
X-Gm-Gg: AeBDieuaxq9jNlyH8gQcHFWb7qatOYoLftW5Ehg88vbNa366D2KKiHkeARrYrlJ1l6H
	wgbWYH1pDuCcjsmUr7cev4RYmMY0zti7Xx/X1qwDYPVp8qsd9OPfUYqKZ8aAZci/D+FcVgqYMmu
	vpTomTD8WJMVPBOvAkKOPbODoAcx93iYG1p2QVskuzRFCWxomJS0NxuQYkUJ5zasXbSaRz2SGBV
	MonnG22zhMDIOn5TTbniYamZeA+lANp03S5nBBlsiDBILVmJNqO4JbUcYV1SbjkpDO18JPx78SY
	L5sc9rOMSIFN7GFzQgG5UE1eYGyQbTr1lHM=
X-Received: by 2002:a17:907:d10:b0:ba2:6dd1:a12a with SMTP id a640c23a62f3a-ba42063bd90mr595510966b.9.1776698842669;
        Mon, 20 Apr 2026 08:27:22 -0700 (PDT)
X-Received: by 2002:a17:907:d10:b0:ba2:6dd1:a12a with SMTP id
 a640c23a62f3a-ba42063bd90mr595509666b.9.1776698842176; Mon, 20 Apr 2026
 08:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417104223.3457417-1-mnissler@meta.com> <mj+md-20260417.125559.94223.nikam@ucw.cz>
In-Reply-To: <mj+md-20260417.125559.94223.nikam@ucw.cz>
From: Mattias Nissler <mnissler@meta.com>
Date: Mon, 20 Apr 2026 17:27:10 +0200
X-Gm-Features: AQROBzAZCe3eQcR-z-ASm8YfWwpfT_aeZAJXtt5zt_xphdyeAoTdER-v1Xz8qUU
Message-ID: <CADNGnga4ECcCWi8r_OZ1-89dfNrW8p4bSbXY3u+0VZ7cX1-pRQ@mail.gmail.com>
Subject: Re: [PATCH pciutils v3] ls-ecaps: Decode DPC RP PIO registers
To: =?UTF-8?Q?Martin_Mare=C5=A1?= <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Qo1uG1yd c=1 sm=1 tr=0 ts=69e645dc cx=c_pps
 a=D+UBI74RbQA8i2EYnbuvxw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=3Ut9Vrr-dLC2VLBHdPQA:9 a=QEXdDO2ut3YA:10
 a=PsfoTyiJ_72bb7xyA04f:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: qJUp--Dilg-q-Pq6s0HLpVkGBwagpgni
X-Proofpoint-GUID: qJUp--Dilg-q-Pq6s0HLpVkGBwagpgni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE1MSBTYWx0ZWRfX4a+X7m66D3Z/
 /ggYpi1MTHv+hTMfu+8ofBXaJ/vLwY+3V+ik0fopipH+IYv6kkdpor4DREjO8tl8N32lYnyEqBg
 XMsttPgDfCgqV6ggiQ1jxD8JUtDN4rSQfK9DQoOw2ioEGoeJz8m2eHrpuBUzjFcjy09jZ5n/P0o
 NSn459r5YB1/4Wgkm1agd0w5ZdEMh+gWcR7FuiBK5yXzvcpB9waFw9fHCxfCMdBoIgQb2SdC7JL
 J6CX6AfXp0CfO7VgFbpdrkN3Wsb3kCffVvid+w5JlXLq79JaLkzkdBDyXG9/nLnHGNbjAfBplfP
 T1BymY/cn7mZQh5uxYSARsVSnR7QLm2P1NOksjvUN722CDnbAEsa9kgYa6ys36mDe5OatgYdjj3
 RGBCpVy/qQlONqqk4n7oDgSnEuQIS7JrBqxfh3SNmfF3S+tnGxL7gBoWrdUbxh9H2SOEH7uyjgx
 HNlJ8J6HjbAnhQsq9Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01

On Fri, Apr 17, 2026 at 2:56=E2=80=AFPM Martin Mare=C5=A1 <mj@ucw.cz> wrote:
>
> >
> Hi!
>
> > The RP PIO registers in the DPC extended capability contain status
> > information and control bits related to how root ports handle failing
> > requests.
>
> Thanks, applied.
>
> Could you please add a configuration space dump with this capability to
> tests/?

I just sent a patch for that:
https://lore.kernel.org/linux-pci/20260420152529.687075-1-mnissler@meta.com=
/T/#u

>
>                                 Martin
