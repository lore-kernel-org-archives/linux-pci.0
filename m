Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C5351C07
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776408566; cv=fail; b=ss7d0TCwWSWE1N46wzamreIeFPe37zkDfGYKAmOaaDrofrXrLx7ctgsebNO5TtFYXtJdXfYJQwm9UoviBEOqX/0yx63pZXxzhxWuj3yhstOIY/N0GDJK8hhu+bL5XDLskMEsy5iu7NIbnTY3MA+QtDwqcfu9OE5BOWr7l4MxfAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776408566; c=relaxed/simple;
	bh=oeHFaw3s/PCX7cU5u8dfbsK00eXcszbbKHbB6QtRK6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEECGgM/Iufiz6hHOBNaJuUwXWk8UGC09V/irrhdT63hYCRk5RXjhCMNecOgU4scyYzKkbKR2bzig9WvfK+gs1h9xRF77Exm1n6b4NsgaABnDftJ6Nsl8wCykg1BOWRMgcUp0ariVSe1gUM4bkpZL0083kW2guak0tDPKN1Yyuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SJxsmT1R; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SJxsmT1R"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H4uFcR1706733
	for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 23:49:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=9DQIHSXy57V29gOreLP4MNlIs9IB+kfYCQIO/ug9DhE=; b=SJxsmT1Rb7wn
	DnavkOP3WIE+/X9ro/gP8ybfIwxYHN7dYmGT8GQ7I1igZkUnzIzpGhSdEKEcpaBZ
	8mzzG87jhfjr87Bwt5JdpZj7pPa5lGVUzfJRJ83dphDf/aZMzgNmYa0H2qwswi71
	C9MtAt6zxw5YTg84BiUmFqBI5XDRrzvnXxg8fFSW8G9ePVv7m4T2vvGyGGv1bRFC
	HDdFcrlb376z+yj2bU5FKD5ysAr26EjL/H845VSLyL/54vOulongU8sM5N4pzxpu
	hQWP7cDZNDW7yRZb5o8+pW89STcjKqA30z7WviYtEX2x0eOPjSWSeRgYvVNLeFDs
	Yf4863XNAg==
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84yt9u0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 23:49:23 -0700 (PDT)
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b90484c398cso51584566b.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 23:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776408562; cv=none;
        d=google.com; s=arc-20240605;
        b=V6LwPCA7m95x2cW2ZTNe888S3hNDKAMOx4QGBwc5rKxCi81SGFay/za7SddptyBII1
         MK9/dvHlvH6+WdqM+qSizP7MlkXLlBSARahx1pbiBh4Bq7GDIMnhvYZB4j0UB0i8Njam
         A14gmu7J9yc9Io7Ms74mNxyHiLxZ0Oi6mGlfmGIaNEhmk7mE2k/MTVKgkeT45MtO8qsb
         nfOU0kk+HK0zLsXAxJMZ/77O2R/26sLEDWpjlRW74yZ1yfzcg94j5EzFHIq4qMpM5Bu2
         9Y427v/1aoyiA5HnXLud6wUv9GiJfWwc5jTLuO6DHNmbFZr396tl1Wlf0Pe0WibPSQGq
         +iDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=gfgVtS44xCRreKc6qtU92qVlIXNM8dOFIUDj8CN1Cow=;
        fh=UA2AOduo0cf2iotDvWO6FplXjIxaHP/B2Hlv2tZeB4A=;
        b=f7OOcQCWjTWfMhX0+lNTB7CAOqaCrN/CyiCfCBOvckD2UbyPC9WqpvdXU6Hi+75RW6
         WMQqVmk+GZRpBXxUhnry/yiBdynKlgVU0vOaZrAZfz1LQZb/JeEHb67D8rXR5775Uqeu
         85y+quXl/5bwbiml8g+6ClboNdZcfwhiyIZ+iAMHu69hG4QsYyVVPeN7jWeW9AGDnisf
         CVfltgvmaL1MDDgtof+86GFOVsCX7NZV1SUpA6H1VVsNZIuRV400VtC/DdEPkIUSLLpz
         o9OuqzkF7sk/+fMtkgAxja4fpLVoDUcfZYJyq8aS+CSd0+0RZcyzqDKs0uNxr5scvCjU
         IL9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776408562; x=1777013362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gfgVtS44xCRreKc6qtU92qVlIXNM8dOFIUDj8CN1Cow=;
        b=Ot+FCLRLykl/gVvtBvbOywy8eR7giNYAeeGvOGLas7O4rafLcAG3E72hv+UaZ09FRj
         6Gt8+4iRHrZblQl0upqKqEKqtSLGRln+QHmoePnFStdz4NWoSicMSxBNSXkThnNlCOaT
         uJ6crtChVPcHVAb75bRB6UDYfsn6MAs5BdJ+YXzFuIZqUh6cb+IrqfBwv4srDCuSSJdK
         HgefoXrA3d0Dxv3JClFcLrxlcD63MKOCu0bj/+zoobQWzP96+O6Rkhxl+Okh5JhFtMTO
         mYAoy1i2FtwMTC/KdRpWHTVvM0kAe6uN+gFFrcVKG+LKdk1pT+7li6rlxiOhj2AlOaq6
         i/Iw==
X-Gm-Message-State: AOJu0YxYoYvUm4AJv/NoNHmknnr891BLeUvAAjy681KJyoHAvkwCXFQS
	yBI7rhKJUo1qraDoEYaN7W+w/uzGNPeWfNN5ZI6ApzNAIBOiZBMEnXIGACTHwyn2dkAoWGCWmpS
	yjKXVN7zSezjMwYAL0CabA6BxeRkpiIFftmzD6ysMXVj6DZ2kDPJvTaq6dTvhauAh+vWFfyMyIy
	iGbYCAUqIeo248X7ysSSEe+Z/CooRPkQ2Gyao=
X-Gm-Gg: AeBDiesCBCynKawnke84xlEJ2vWEF09WlGLNHvz/F2bwfrUSZAEeXeY3ZKPQgPN5nvf
	PP9aIUEqEh7dI4blVywt7w/35oh7DoGHOJ5oxYK+Z6nexSj+WiHJzXTU7EUDN0i9ilnWEKTQhM9
	2QQsCU8uPkbvpHDx7HB0Pa+59tgppWDscJkXp8rTqsoQvOy0AiBQ/g7aWfkwoA+QTvBLoftPhZI
	Lc3QtaYfEk4ZweC6URYP4Xy/BrCwIrRhsX3CL+IAebn/EhSi72jf9jNywCjQqkAInyJMwrA3rkH
	aQeIVnU5oKAYkDJW7Fz8Obo1NVXFUYZAepw=
X-Received: by 2002:a17:907:cd09:b0:b97:b3bc:f6ba with SMTP id a640c23a62f3a-ba41ac040f5mr86148366b.39.1776408561541;
        Thu, 16 Apr 2026 23:49:21 -0700 (PDT)
X-Received: by 2002:a17:907:cd09:b0:b97:b3bc:f6ba with SMTP id
 a640c23a62f3a-ba41ac040f5mr86146666b.39.1776408560936; Thu, 16 Apr 2026
 23:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416125706.3875359-1-mnissler@meta.com> <mj+md-20260416.200014.48272.nikam@ucw.cz>
In-Reply-To: <mj+md-20260416.200014.48272.nikam@ucw.cz>
From: Mattias Nissler <mnissler@meta.com>
Date: Fri, 17 Apr 2026 08:49:09 +0200
X-Gm-Features: AQROBzCd82nI2YZId8Pwk31oGLQ7yTcd4i9kLdPNRScdyoC-1cvq7vrQWBAp5sc
Message-ID: <CADNGngY7bpBP59x9B7Ekiy4Bgbyrz4Sm-RkXPAy9FRLGpN-uTQ@mail.gmail.com>
Subject: Re: [PATCH pciutils] ls-ecaps: Decode DPC RP PIO registers
To: =?UTF-8?Q?Martin_Mare=C5=A1?= <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA2NSBTYWx0ZWRfX7ljALyIOGfOg
 FZdWKebjpy8fier410TQb2Rw3qOcIOXtowdN78NBIb7IKObcDx+HHLKsncMODV9wiN4k/rxFVQM
 QvKM4mpL7W0gW5pHv/oodw5cP3cjD4LpOc1cuQ796Se18t0/hCBLD4nNn0gxPSF9XUv87Zc/llO
 EMvQGOuCTRf9EZOajQCPSCbXgP4tGL16ljFsdRA2UiPHzH6E/5wba6bsteofRKt0Vm1lb7mukVO
 mo10lR2rtf9biBq31nAjbPLd3B3bonidSjf/10tCbCGW4hnDtAzeSzUNHS3Hy4/Kn351TS6n1Om
 ov4iWZCOYN72MYeXwRYQCner6yGgeZTjq92+xK7LgYt8OhGZ82ODGEG/deTkUFaczp/0zFLjfly
 HJWRVTRr8b1UP2lbf3LcDnXt5OKh/O0693lrdIADjOeLlpbfqM6y+jy+QXy7kmxNEBkWzaX4s4E
 N9ykF5bSg3Lw5p/IsVg==
X-Authority-Analysis: v=2.4 cv=eubvCIpX c=1 sm=1 tr=0 ts=69e1d7f3 cx=c_pps
 a=D+UBI74RbQA8i2EYnbuvxw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=z7uqSuEKCs6fyQqRiYEA:9 a=QEXdDO2ut3YA:10 a=PsfoTyiJ_72bb7xyA04f:22
X-Proofpoint-GUID: VcO_1mmyI4f1HJrDkY2aIoYQpTcpHpH_
X-Proofpoint-ORIG-GUID: VcO_1mmyI4f1HJrDkY2aIoYQpTcpHpH_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01

On Thu, Apr 16, 2026 at 10:03=E2=80=AFPM Martin Mare=C5=A1 <mj@ucw.cz> wrot=
e:
>
> >
> Hello!
>
> > +#define PCI_DPC_RP_PIO_EXCEPTION     0x1C    /* DPC RP PIO Exception */
>
> We use lower-case hex digits.

Ack, will update.

>
> > +  if ((cap & PCI_DPC_CAP_RP_EXT) && config_fetch(d, where + PCI_DPC_CA=
P + 8, 24 + 4 * log_size)) {
>
> Please follow the indentation style of the rest of the file.

Ack, adjusting.

>
> > +    printf("\t\tRP PIO:\n");
> > +
> > +    l =3D get_conf_long(d, where + PCI_DPC_RP_PIO_STATUS);
> > +    printf("\t\t\tSta: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c =
MemUR%c MemCA%c MemCTO%c\n",
> > +      FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA), =
FLAG(l, PCI_DPC_RP_PIO_CFG_CTO),
> > +      FLAG(l, PCI_DPC_RP_PIO_IO_UR), FLAG(l, PCI_DPC_RP_PIO_IO_CA), FL=
AG(l, PCI_DPC_RP_PIO_IO_CTO),
> > +      FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA), =
FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
> > +
> > +    l =3D get_conf_long(d, where + PCI_DPC_RP_PIO_MASK);
> > +    printf("\t\t\tMsk: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c =
MemUR%c MemCA%c MemCTO%c\n",
> > +      FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA), =
FLAG(l, PCI_DPC_RP_PIO_CFG_CTO),
> > +      FLAG(l, PCI_DPC_RP_PIO_IO_UR), FLAG(l, PCI_DPC_RP_PIO_IO_CA), FL=
AG(l, PCI_DPC_RP_PIO_IO_CTO),
> > +      FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA), =
FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
> > +
> > +    l =3D get_conf_long(d, where + PCI_DPC_RP_PIO_SEVERITY);
> > +    printf("\t\t\tSev: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c =
MemUR%c MemCA%c MemCTO%c\n",
> > +      FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA), =
FLAG(l, PCI_DPC_RP_PIO_CFG_CTO),
> > +      FLAG(l, PCI_DPC_RP_PIO_IO_UR), FLAG(l, PCI_DPC_RP_PIO_IO_CA), FL=
AG(l, PCI_DPC_RP_PIO_IO_CTO),
> > +      FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA), =
FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
> > +
> > +    l =3D get_conf_long(d, where + PCI_DPC_RP_PIO_SYSERROR);
> > +    printf("\t\t\tErr: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c =
MemUR%c MemCA%c MemCTO%c\n",
> > +      FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA), =
FLAG(l, PCI_DPC_RP_PIO_CFG_CTO),
> > +      FLAG(l, PCI_DPC_RP_PIO_IO_UR), FLAG(l, PCI_DPC_RP_PIO_IO_CA), FL=
AG(l, PCI_DPC_RP_PIO_IO_CTO),
> > +      FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA), =
FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
> > +
> > +    l =3D get_conf_long(d, where + PCI_DPC_RP_PIO_EXCEPTION);
> > +    printf("\t\t\tExc: CfgUR%c CfgCA%c CfgCTO%c IOUR%c IOCA%c IOCTO%c =
MemUR%c MemCA%c MemCTO%c\n",
> > +      FLAG(l, PCI_DPC_RP_PIO_CFG_UR), FLAG(l, PCI_DPC_RP_PIO_CFG_CA), =
FLAG(l, PCI_DPC_RP_PIO_CFG_CTO),
> > +      FLAG(l, PCI_DPC_RP_PIO_IO_UR), FLAG(l, PCI_DPC_RP_PIO_IO_CA), FL=
AG(l, PCI_DPC_RP_PIO_IO_CTO),
> > +      FLAG(l, PCI_DPC_RP_PIO_MEM_UR), FLAG(l, PCI_DPC_RP_PIO_MEM_CA), =
FLAG(l, PCI_DPC_RP_PIO_MEM_CTO));
> > +
> > +    l0 =3D get_conf_long(d, where + PCI_DPC_RP_PIO_HEADER_LOG);
> > +    l1 =3D get_conf_long(d, where + PCI_DPC_RP_PIO_HEADER_LOG + 4);
> > +    l2 =3D get_conf_long(d, where + PCI_DPC_RP_PIO_HEADER_LOG + 8);
> > +    l3 =3D get_conf_long(d, where + PCI_DPC_RP_PIO_HEADER_LOG + 12);
>
> Shouldn't you check that the log is long enough before accessing the
> first 4 entries?

Per the spec, the 4DW Header Log register is always present, and there
is language requiring the log size field to be >=3D 4.

Also, my understanding is that this is intentionally analogous to the
AER Header Log register, so I took the same approach as used for that.

>
>                                 Martin
