Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C43B27F9
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776422147; cv=fail; b=LTX1u8A3PunOo062bCv2rA3rIabE2/SpNxEgUUMRLvMKaLVI3RIwUXAw/7AGnkJziW1p1BxVIkyEzCidfHJ35mhgT5WE20JhmiRhoUoRbsvpmnqH+rh16/8PHYYjpLzE8ElUvin72DC1PrkbIBooodF1NXcFl3vHPhd6j9djgxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776422147; c=relaxed/simple;
	bh=gHVocyxEBzU0kM+8eHfgk2nhy63+xfzCDOoE2ACHhkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+nI2usZfQH9kgyRo489AEWlntz6i8aj/U/QqjhI5gRhjrNzxWdNewp6jHmXrL+XCd5PfBeKxTK954XARKRrqahzJtM2IU3N9ZkhjrSsYdWUSy2C9m3CrG1YLBV9w3L8cemgsr0698W1gEZj4koIZZ0RpHNLTl7M3//L3EIMJAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tNnDgtJJ; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tNnDgtJJ"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GKxkpJ2769174
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 03:35:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=skjtpIUSDPxuYYxK9d30kczCk38UDI0MLRE+yJ2foEk=; b=tNnDgtJJgXRP
	zYoNyn+L67xkkiuzbBZE20PWG94LtXZAjtSYu3BDvMxE4SJ+FC650RKudG/88JnO
	JFtYQ78oNs4s/6W+cJN1r26G7gnsCreH2t7//+CgWSeE1WRiKKSVnieimWU1Xm+x
	v4vo6H17Ha9R0OkgK2qt65cqzeDX8G0mbPAa+b1J9mWfwDm3RftPYjvzF+dzIp0C
	5zek0eLennHFFyaknrNOOrTwPjp6ZGORqIgtuc6+fGCJjriH14mXUECKNpqyy/XT
	YAnWu2at97efehD7RlSRZUDc+Aq3W9EDP2PYQmEedli/lPzLG0pfySCHuER+5Hps
	LWGghYx8DQ==
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84vbfsn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 03:35:44 -0700 (PDT)
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-66e2f867f97so743641a12.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 03:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776422143; cv=none;
        d=google.com; s=arc-20240605;
        b=X2uBMSqgPQ5zwifW9c61KFIJNvuRaXB3nx9+J/EE3NymV5lg80rIyZlkKd/YFSFWyK
         kr6CU2YvebPxdYDWXH0GLfi7RMc7DdCmI0Yybk1fPHmq57tGmSRbrj8gmYlLlSCHDGK1
         gMH+Vw3Aw0gQ/aaw0Mau+4sU0AWu+SuWq7wHubt+phpkdReMCimKxyeSRE/6MujAotoJ
         Gm6lwSHYB/yPPYworUSqad8xI5as9EQgFAZpOBRFMHb3aVuR0Ug6TXV8i7MKjEaclR21
         YKTrn0/UI8jB2vXy92pr8k+Kjjo4iONQdTEbEIrG58KmDHVgrLUZ4iPDRQkeb2ygHSwi
         jMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=PpFkmrhp5xDHg5dSqbSn9cwSBgJQWnhxsQUfYm9QgAU=;
        fh=UA2AOduo0cf2iotDvWO6FplXjIxaHP/B2Hlv2tZeB4A=;
        b=O9pGp4Wlc0ZnrxWh/LLSCa18iMkMZmyIX0uogkROYN1bFgMiLBswrOAEgZdpF8eaTW
         ifl/72HYnUoFAxCIl1dxk5q/9J6eknqQsuLOw/1gyXiGH3HKxYNnTiMX256YNbR6NCmR
         JBlgpsbV9uC0Bk9Q1aqMCzhElVxTIAv5Nt0hNcIofi/gP5+/d5tEptHaLzcdIPThOz/o
         gvhEsqxdFjmwMHuEa/WDfwZjkQyuXB3FhDteJiETairHoOl525nr7hsnCkq5k4xmsRXR
         nLmPBFwn2DlGHdHrVOXSSJQ4w0pdl62ucwFtN0VCj5OEMEtzg3ediatbHo8+4PsfVrZg
         ExBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776422143; x=1777026943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PpFkmrhp5xDHg5dSqbSn9cwSBgJQWnhxsQUfYm9QgAU=;
        b=oek/Fp7w3M9pxggVwtvPE24UjfQt9TKj0PFHSZTPsKQrWNGuVJPxzcZkcPNxkHcw9M
         y56OwZuUwdOQNgiRIBByEMZpg0xTL4pvDdwx06r5nAI/lt8rXZ6pibqte3hpH2GSTVj6
         sRwA4T1ky9oIvbZi4Fsu8ZWZvqX6O4aj1/U3QfpzIToPZAZOMeA22c+zG0qRkrRCUa3f
         4oOc29/6d36s39hlb7VMPpJTH/tUAJweFvwy1F3vp/cT8b+tbW2LzoxUTx7qpkpyXZYu
         wzaLeSuEnn1ZT01KtIcwXgZCi1dlk/sTtljJkFGHojnhyv6AXnU+s6xnu8NL1XBed5bt
         /wCA==
X-Gm-Message-State: AOJu0YxZK5xNf9Yo10unJqkp1wX57/V5X8APaqRMmKHrzTnszDtZDd9a
	OcQB2jCTUqXnNhK+rMBpeujKPs71Ud4L5gnExwD6TZwx6KvqkwMXdQArucgLLMf2gokHlySd8QI
	ioYSwbqjvTbyERHm/sH2qolJ1YGyE+pTsfBQSanVo9d+Jm/LIlYVX8Z4Yyio3c2bChRzELtKdp7
	p+FZuhO/ybeyaMkZS3xSrsEIuTJpCwUZQTGk1/OQmr4xNqGQ==
X-Gm-Gg: AeBDies0W8FaJkq5sxF1mdciEzjByN1qHabv+JALdYMv+fRYwhBotseFqwcvBW6/ErF
	kGWcu4B1oz+3dXQUAk8ex/AHTVOpmnIv5N82YNpip89Dz98Yb7SFZR5c1nBIOwzJW6CH2A+QwWG
	xP6FsGEPJ9kM2Wd3mdMGI5SdzDlHJr4oUde0FBOrb2mTGMbl2SgIxQrUzgcQVqsnwn+gdGLtWiO
	rLtOEy6Nd8KdcZwwfVNPzxXP8PpfCLNoIbnSre4PO7nwJo8LcDgMaZeByiSmp+EcJBozY75YldR
	q/kq7FORkWqEGP51HENT1EYF1hEfCa0q+hw=
X-Received: by 2002:a05:6402:5483:b0:672:88a7:3885 with SMTP id 4fb4d7f45d1cf-672bfdc9464mr958176a12.18.1776422143096;
        Fri, 17 Apr 2026 03:35:43 -0700 (PDT)
X-Received: by 2002:a05:6402:5483:b0:672:88a7:3885 with SMTP id
 4fb4d7f45d1cf-672bfdc9464mr958165a12.18.1776422142662; Fri, 17 Apr 2026
 03:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416125706.3875359-1-mnissler@meta.com> <mj+md-20260416.200014.48272.nikam@ucw.cz>
 <CADNGngY7bpBP59x9B7Ekiy4Bgbyrz4Sm-RkXPAy9FRLGpN-uTQ@mail.gmail.com> <mj+md-20260417.095535.38120.nikam@ucw.cz>
In-Reply-To: <mj+md-20260417.095535.38120.nikam@ucw.cz>
From: Mattias Nissler <mnissler@meta.com>
Date: Fri, 17 Apr 2026 12:35:30 +0200
X-Gm-Features: AQROBzBwlWVRZJizLDlxX74inevpBJslfztAoUWOqXlNpRW44h3u8whqNCA_6q4
Message-ID: <CADNGngYxJ8p1ZKtZpifFscN_iCqMMuUV71JTGMtWnMkT8S5njA@mail.gmail.com>
Subject: Re: [PATCH pciutils] ls-ecaps: Decode DPC RP PIO registers
To: =?UTF-8?Q?Martin_Mare=C5=A1?= <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEwNSBTYWx0ZWRfX594XqrOdxiKg
 EwqgesRCcT+vE7lCNUvoy0JQXrhsaqvtA42Ta+lIoGcfHPE6oUq6cgWfLQDPI3UPXDsr6NAMv4m
 znnnjGpcyx7CJnXuSVOJUyBTrvSZWSXBtUHMu3lpySB23HULHj6IY9nGGlXcV/Ag7BCW9MTdHi2
 49ORanR1RDuIfYHW9sJdn9wuFVVkyurlqskaHjcqKSGG31hXpwIKn7X9JnPCGD6AifkGOwjftgk
 qddyoqMLUJnvj0UIJWiaTp7r0cBQgjedmCEdxm/INUQOL/XkKcqRx8unHlhWuTA1zgMSqoc7X7v
 6GxvLAv7LLue5JPVGuTu0jJxxLpvCoFRz41tzHSU4Pn8yBC+13EWlQfX4lm+CxHLjXykxo63eW/
 +te4wa1rno+GBpyFVGpA45M/OD1qMjiK9cGNQCl6AJFMCXI1zzVkk4SmzmcRO64yCIVEleZUOec
 yPAjgNLzBmRfQefUzzw==
X-Proofpoint-GUID: osv2YUepxb0J8EZ0Jv-qQh3BP2FVupcx
X-Authority-Analysis: v=2.4 cv=NfLWEWD4 c=1 sm=1 tr=0 ts=69e20d00 cx=c_pps
 a=9KvDgq78n9V61H3VJbnhTw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=4rZXt00JAAAA:8 a=j4imQEwaaW1qLRCarJ8A:9 a=QEXdDO2ut3YA:10
 a=j5kO0B45gQVIxiUYEfTy:22 a=7uy_MM2TgZVoQAy_xcjM:22
X-Proofpoint-ORIG-GUID: osv2YUepxb0J8EZ0Jv-qQh3BP2FVupcx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01

On Fri, Apr 17, 2026 at 12:20=E2=80=AFPM Martin Mare=C5=A1 <mj@ucw.cz> wrot=
e:
>
> >
> Hi!
>
> > Ack, will update.
>
> It's better, thanks!
>
> > Per the spec, the 4DW Header Log register is always present, and there
> > is language requiring the log size field to be >=3D 4.
>
> I know, but I've seen too many devices violating specs...
>
> Generally, the pciutils try to cope with whatever incorrect data the
> hardware reports. It particular, they should not crash nor get caught
> in an infinite loop.
>
> If the log size field were < 4, your code would call get_conf_long()
> on a part of the configuration space that was not read by a previous
> config_fetch(), which would trigger an internal error.
>
> A simple fix is to condition printing the HeaderLog on log_size >=3D 4.

Ah, you're right, I had overlooked the config_fetch angle of this. Let
me add the check as suggested.

>
> > Also, my understanding is that this is intentionally analogous to the
> > AER Header Log register, so I took the same approach as used for that.
>
> That's fine, but in case of the AER Header Log, the config_fetch()
> has a fixed size, which always covers the log entries.
>
>                                 Have a nice day
> --
> Martin `MJ' Mare=C5=A1                        <mj@ucw.cz>   https://urlde=
fense.com/v3/__http://mj.ucw.cz/__;!!Bt8RZUm9aw!-k2ThkLRdBtx6B1hSdcfTt_X77C=
luV8P_POzwnd1bnjYf_8tS900yCUARV58jcCfD7LS3XA$
> United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
