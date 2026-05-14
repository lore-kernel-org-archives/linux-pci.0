Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B63264D9
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737973; cv=pass; b=q7HmRHFgl+UrADE77OcgR4Y8x+oM3r+MKQVToG0qRcmYtef+PK6WM9wXYRum5IxkzUQREVhY4Idd2LmfZFFoNRPX6n8OZ80USCcHjIm+HqomBJZXYbLr+bluci2d2jMDH+rM+89NiOGjDNK95qrh+Y6jdiLDrGAZECLjGp8Jo7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737973; c=relaxed/simple;
	bh=jNKZ4zNOiJapN2UCQkJ7YsxiCTXnQMvJQjELnoY502w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eU3jQdjpaq65CrQ8XYIs2eQYiSABkDZMnvSAwr2VymZFlnfCdylv8LYnbWNH874ihbFO2ckkiQqkEKvcbJ1tNU53D2u7r5bovO/r4El4WyuVQ4LB3AOK3kH+/Il8j3JuZ9BkFWzeLbA7Q9G3GAcCSvvFuM7ATypbINjUS1HZChI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fsyf2ung; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fsyf2ung"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DLiafb115008
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 22:52:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=; b=fsyf2ungMeq6
	yshHRzeQ4U6BrRrLOw2m5LnpTLwWNRFjtrke7zVSXSFihlkGIGQqF9ZGo3jGgRXv
	2rFeRHThXTMGtORk281jxrE4gu3k+yTDpZgaO0RXgdCq1N5vftBndt64eqJWuKnS
	+qFgwbyeb4nBJPMKSoH2gapTvLOVcXTpgpJbzNuSuxsG6wL6MDQuJFxJqBTW1JNi
	IVV9KnN8WwJIC23O9zBqlSvbZlQqGkv8pX6J8DxJKQRvwoU15pvU+KJVRC+Shz/1
	pdRz08JIRHpjjYq3PaY5+SYfamSp6mY3XF0mgHmyOf5/MBFj0ETZ9P3+2Z1Vr68E
	ax4mD3GJvw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nw25ahx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 22:52:50 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7dce1e67fccso9865480a34.2
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 22:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778737970; cv=none;
        d=google.com; s=arc-20240605;
        b=WxXNlCyLD1wOb9ypWxE40xq8n9ocSLy8NFSHpd6E1aNwaaB+dd3wYebhgjJPSQOGu4
         k3WawJWE2rtiElnonP2VbcL9ZaWTT1P21uzVriTgiEVi8D/vGbB+fDzYxOtwgmKmbD87
         TjcnjjI+Dr/sTPykZgRU/61IGBA0gtk9bEbLJTKifbQgLbYWbxlh6T6Pts+h2tRv5H0r
         grqh4OgoihhofaTQ8l8VxxPFbD5+XKJk6rUFJZ4VuCt0RUqj3WtZFZy+KGDo9ec/iW3P
         /E41PJBGDOx01jMyk6RJ7NESpNXxhV+89M8mjGunFeng85QgKDwqi2GNhTFPGS+ycbZb
         dPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=;
        fh=dt2sRO/ejIEWRGn+k2cahj3lqdAYe76OHSM+BiBINrA=;
        b=CM/EbqO48Pc+7JXphNiyEf+4sSMpOFrfKNq1zaxhDXaJnymTMou2stEqiS4/IxgUhc
         9CdOLABmP9xI4ju24Pvh7RniBUL992pPF/bl42kwsgZl5W/xyDO/xA1kM96DfEYsQmWs
         7AnIPwTJaxlZGA/9pB67OrLlB/dPgaYkB3fzFqNglCb/8aywfwyDtoKs1HfiAmx6knu1
         Q7koCnyV/DhRI7FtZg64ghnsluj/xKH4nGJBC4iJgpthQdsF/WBTmXq8K9B3kHumJkM4
         QW0CJExU5hfsWq/X19qFOZiQwfW/jX/spsSpFy5bnrlV3+9pFVhHm/Q8jtI0/IIjkvJq
         8KpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778737970; x=1779342770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=;
        b=hVru+32EQwzCx/WDiLljhYmVjpzHjuo2hAUyzMk8Ol7R3HA57eH8Ayu/rDGECL9en9
         QV2xQzWcD1ZYbHf4gDkiR9i+9tmEi23j5udSJIQh0y7K2jVQotX5iHQT1rRuKRmxzHur
         v007MuVJgnPtwgFnNbGwaU9IRb1knuZcp4Tla//OMf8bxr3MfVqKFtKGCesgLjn4XTm3
         vx1yE8GYQy97fFXITmmmTXrB5A9ppgoFklJWgg9cUEqjDeG2dBIWH/HXFG5gqP30laQD
         jdOjDUd6K9/fZZlA+IondjzmrOAAyDbOVGqNDVaCa/W69SzgY57xuQ+VmjSEelVoE7dU
         xsgw==
X-Forwarded-Encrypted: i=1; AFNElJ9yKV+TNrKq9JlyXAig3TKQeYJZK5nRYXO2XaK/U0vbX/XWGZF3V1o4TNfdk6/GX5z7NNY7JGO5pkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwehE4NnDEol3A6v834YeG4XHwFTCHuyvoHc5hDNBh808azI664
	DKkr0ybvtfTAZaRpLZldOMM4ubIXc7bQ6/iVvyugYrOrb47+uWkEaGH9NPznk/jxkWccH1qj66q
	eWW9qy8dfFn8fbigYROxMin+itfbQBTESFZceM4QC3169Glo/JvYE1S/DAeTzpYljwyXFcwPFk3
	KPKpSYtkRopO6r1vHpPd3YohiLVi3pc8OvSu4=
X-Gm-Gg: Acq92OHZR/ImOYzQvgnnTP5bD4ym1Pysyg57s4Fo0JEmTrdLWw1sHKaIz0MbnBHQNLZ
	i18rpsiLABrJTHFQ1dsyHgUQkGrxCRf5ANEGU8LC9qUeQHKj+H+0sT7kFnzN+hOQdpMnyHrWl+v
	dxaEYXdKDYlGpUNhtPx7AzgISYGxrRq6gImbcruwY/yN8YyTc+nphktsRBrXR5IfmL04GAlAw8Q
	4jyuTfALBD3LCVoY2MFepQRGSweS/J/m8oCowR+n4p4Xvrvj/c=
X-Received: by 2002:a05:6830:2a06:b0:7dc:da80:42b8 with SMTP id 46e09a7af769-7e3da47a167mr4289741a34.18.1778737969735;
        Wed, 13 May 2026 22:52:49 -0700 (PDT)
X-Received: by 2002:a05:6830:2a06:b0:7dc:da80:42b8 with SMTP id
 46e09a7af769-7e3da47a167mr4289722a34.18.1778737969331; Wed, 13 May 2026
 22:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com> <20260430200704.352228-2-zhipingz@meta.com>
 <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com> <CAH3zFs2x2QebpqDC0qwQg_GP2FVs-qqNxPupck40cEHNrBMEsA@mail.gmail.com>
 <20260513063141.GC15586@unreal>
In-Reply-To: <20260513063141.GC15586@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 13 May 2026 22:52:38 -0700
X-Gm-Features: AVHnY4L9mpkzt-pRZEvg5JzN0p2zqJY8w2-rDz2pv9D7N-e0Agw9sPJQbQsXATM
Message-ID: <CAH3zFs2XyXxzVwru2gYZn-9ioyvy44HMmfppf7shTn8Qop-4iw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: Leon Romanovsky <leon@kernel.org>
Cc: fengchengwen <fengchengwen@huawei.com>, Alex Williamson <alex@shazbot.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA1NiBTYWx0ZWRfX06VcxXT2zdws
 jYulah29H8R6CvfAJVluKRJLCOSi0gW79nmQA2PaDfkR//MFsV20VIu4I+NtSCbmj7VzmdrMF6b
 2WjnYqgwHRPAwEtSWNh7H39aHX4GmgtlS0//gqRdbiiw3mml95Vq3H0YmQYU5qileyIwg9zp+YR
 yf7+g7MoBzvmJ8RRQlfhIkxqir1EuU2UX4UF7KmfbTgkFEDe5tiV7NLXSmbDIVGzfT+nsK+ma5G
 kV+Qh2kVOM9YvDd1mMiZxTI7H1w2GrX2cq3Nwdsg543K0sMgYjM01A9Z2VJFllw3M0Jgx0J7BN1
 oicDqEZnu3PaVDen+tMqCYJ0fn49V49Y0xUQRz8yBbAJbqgB0n82+4zrkpIrZkElXPy/09Y0Zf9
 FPLSprjmHF5SONPadsYYNRnMQeajZyd6+oUmV82+qjCD2zELdjmwBKh9Ay3VhqFREdEzeZEn1KP
 ZbONe7V0s8phYAMXeRQ==
X-Proofpoint-ORIG-GUID: 43Uc2GhRRDRGTThYwAHzdFFlzDKklRo5
X-Proofpoint-GUID: 43Uc2GhRRDRGTThYwAHzdFFlzDKklRo5
X-Authority-Analysis: v=2.4 cv=MspiLWae c=1 sm=1 tr=0 ts=6a056332 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=VwQbUJbxAAAA:8 a=hJXI5Qx6rLfdTxNNxg4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01

On Tue, May 12, 2026 at 11:31=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
...
> >   #define VFIO_DMA_BUF_TPH_ST (1 << 0)  /* steering_tag valid */
> >   #define VFIO_DMA_BUF_TPH_ST_EXT (1 << 1)  /* steering_tag_ext valid
> > */
> >   struct vfio_device_feature_dma_buf_tph {
> >       __s32 dmabuf_fd;
> >       __u32 flags;
> >       __u16 steering_tag;       /* 8-bit ST */
> >       __u16 steering_tag_ext;   /* 16-bit Extended ST */
>
> I wonder whether `steering_tag` and `steering_tag_ext` can coexist
> and hold different values at the same time.
>
> BTW, please send your patches with diffstat.
>
> Thanks

Yes, firmware can report both `steering_tag` (8-bit ST) and
`steering_tag_ext` (16-bit Extended ST), they may differ. An importer
can consume only the one matching its width. I=E2=80=99ll clarify that in t=
he
next revision.

I=E2=80=99ll also make sure the next posting is sent with diffstat.

Thanks,
Zhiping
