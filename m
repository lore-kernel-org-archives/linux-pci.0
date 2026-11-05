Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793840215;
	b=gcQ0WMs/BsAsAfZPGVq4tEMwiNOVubaFICfxF3oNdycOYgPgvTy/2eR1X6ed47Dpto0R
	 b94nRj/Y/HWwxNhH/kxNkn23s9/EsxEYc7CG8N6qL8DRE7bGkVDsRCpqyWpGwXTq0cWW9
	 fh7hxp/w0RQTDxds/lfx3PbziRRySyVK4vopazGhOUTULEDpghw2VmMT88qMTfVAigk3A
	 MFFYzfLm9nVaM/BIhkfC7CRCGL/nbAq3LviEqsw6ho+Td4aufYMoRt2rkUSXDcpGo/3NU
	 uyViCPDlIIZQWevxLBXBLcIjxuehEU+IvReMc1ZeabHj26lqjEhF0C1eSD9pft4wFGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=4BxIDYk+3lGT5I32DI65EPyZmn6DI78imoXZLMW8wDs=;
	b=C4r5fOf6291eDNp9ILDfQLvrtseM9wmBrrqtdUffzwIK64VE7VMQLGl6dDsdk3BUCoUs
	 5G6qQVbRq+yp+clhptG4EMPeD2fma+Nx7y7bmOaAnP78qK3dXjrOKANpwBdaSLu9RlfiB
	 BfmRllMBCUHvBXBKIIe/Iizuh5evNECZUW5N8nhiF/zbqFqIo1kDGHbzcqxzFXzlmptNj
	 I4h+8codBsgEqYV3fGLJegwxjqUyA7Rus/vAClloJT8a7Gd6VqIoqGJvwOZ6BdhyHQ7Ij
	 GwbpJZCBiv3KBrqIhSwpKbnhspoxM15Yxgbrzk4InFEiWvBK41vqF4iNqmAawBjARhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.oaklandcc.edu;
	spf=pass smtp.mailfrom=student.oaklandcc.edu;
	dkim=pass header.d=student.oaklandcc.edu header.i=@student.oaklandcc.edu header.a=rsa-sha256 header.s=google header.b=PIdGrYqU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B0606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 00:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 746B0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.oaklandcc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.oaklandcc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=student.oaklandcc.edu header.i=@student.oaklandcc.edu header.a=rsa-sha256 header.s=google header.b=PIdGrYqU
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ae8607e8afso13334197b3.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 16:56:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793840214; cv=none;
        d=google.com; s=arc-20260327;
        b=Y2i9bGrDvfWXkYDFEaG2pLlFyUm1dyHdSsy3v0eaXEa/5/3nKlxqU7Bg9tIRTad4dh
         m9LTlOgZD05sKbitjodUC/mfCbuG3Br1NRLx/srYEwf4WmdQSomJSYHNDqwNZAD6RAvZ
         TKHGC2QdS1UZxU1tAgjnzV0WJqM+2YkQNm7CHfafBPPFkKc9cK8BVZCjuhc065+k32bS
         qqHxnpctMcNU9ANLuhzmdLmQrTPYjpeGjpfVV6KUj8YvFakFd5D5c8KNKeJMXpXoC1Ml
         czOMfYrkV/VVlYdhzLGV3WBbnOOMQWQTMvlV7EggitcZb905jAgqqAltFyjkcl23yElQ
         AUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=4BxIDYk+3lGT5I32DI65EPyZmn6DI78imoXZLMW8wDs=;
        fh=eW7iQdKcZ2ExO2FqD3RHdpEmehW+pWblwUM9dStdj1s=;
        b=h6Q4nMcp0tUEBTi9nI0XpEXqVipFEbMdMv7BZFV1jh6h6l7YPncEs6ftFHcYWG5tBI
         KKDf5TgthBodwbjD4DB1mYRJI0mqsbETp3xA7rwD5vUKR+vJH0YF62zI5UUlfQgBZv1p
         m1M82p0zjEuaRzgBvBabj4urRCB+01Tl/ygJVbpobm3Jf2D+AoRUjrwX0gjbjYXXmPrm
         W+m0ytA6eC1dOAArHWR0avzGuIenb0y3ZRhGMYvlngJnFKy4kYwdEMiU60uWXqhnDBhA
         8xq00EJ9AMskzM8NAo6U8p9+Uvf3OUUduoJoh0EYs15lcl+k8WYOlf8Z1Y5mhouirZ7J
         fq1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.oaklandcc.edu; s=google; t=1793840214; x=1794445014; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4BxIDYk+3lGT5I32DI65EPyZmn6DI78imoXZLMW8wDs=;
        b=PIdGrYqUGarz+9jR3mdCHEzDudiVpMHbsnJp6XndMuTalXuKBOuMuygx92qzMOanOP
         8WgY4brf3YmHVAqVr5d2cWflbeXDyywbdEmQ5bqIQd4T1Is026LYw26S8wcejzSE+9vG
         d1tHN8F5PHqSgaTTVQQShJ5h4aZBmcu21gUKbwbtkS+qj8+PT/u0LEbnN5a9M2Bnzfmi
         GzPnVOPFrlk63QqTTD5qv6jx7AuduFXTGhaO/Lf1A0Cj5CFI6FK03bKsiFaxbJ5YKzpU
         pR7yavuWMxL9VuO/q2JxvZ3Yn82MH/PHAnQJzUAU/orF9kqzgTulDiqAQ0BNjvbifeYC
         dYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793840214; x=1794445014;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4BxIDYk+3lGT5I32DI65EPyZmn6DI78imoXZLMW8wDs=;
        b=gMSy4Jn+1CG97rx2bomHBo8xJ5/Dnfm9kUWSk6LOerMXaZWZHfp6tn4IU7A/IPX5QF
         9AY0tV1QiCUMtXcQH/jE70Ys24Q2Wwtx97gti+kAAjTH9lhXH1UyXVczACLookZCkBxn
         MR3RlUTNpf/eEpE2IMxTcPV5m+S5wMzKmOePWIHhBraSmyr/nKIIZ/UrfjQWqr4Rg4Ff
         2SeSV6CE9XGSErqlWqk4gUaRPejCANXULRoSnzuXcnh3oPZXi0VOII2J6wAm5zislZyB
         KnZPOUTmOEHpP40nP99JGFFgCuMOpDIAmcB1jGCYR7AbyzJs8X1OFBg0TPVSmhrYINH5
         NG+A==
X-Gm-Message-State: APuU4Z/U7xN/teE3R9FfwjRqaa77ZYvdrWZFkwPEA0nbSI/02JYC+P2j
	pzMexWmKmQrYxvx+8TObwRPc7DhRNer+MqfUwD9GOcUYPEpdE4ySOc2cecXdM779lhjDy89IMPU
	1N9G5Hv5b0H2rNwgYVRt9gx9vcEgvnCfAUQDU4KdUzra/uk7TP8xLmOQ=
X-Gm-Gg: AYBFou2ppr1AXatxfMmZjt1ROMIWYVBoeB71MxjIVnjCV8aT9YCuxCGTMxK/tAmzBqA
	Chyfpqv+kC+HcTc9F0aJIAjzsRXJic3ixNA+kGxTFSJUpBbRjRq8MPz5I7ToFEA08dni8jxnsCN
	xlFbgh9KpPcIa7oIpf6FaDE/T6tH2OtDyTQb5U1RG7SuQFoGS9Lz87SLBkXaB4cUTjTD+z6zKjO
	n/2hAQQQj4jIbJiNcz9bAj8sCWtH+20MbJlZHnj2/eorel4zE5Vj14aNVe5MeU7M0GWiKEzexjd
	xOtYvvo1AcvxD2eZswTcjZZXQeNe+7hQd2gCpJnTeanmhapk/ZFGsjkAS2ekfxINtBwaXJugUpA
	tDrIn7RqJKt0qNHPchKjbLg+txocNXc+pCA==
X-Received: by 2002:a05:690c:10:b0:8ac:b167:4877 with SMTP id
 00721157ae682-8b2b6738e57mr111620767b3.36.1793840214321; Wed, 04 Nov 2026
 16:56:54 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 00:56:53 +0000
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 00:56:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAGQButtv-1k9DzOLEBwjoKQP+=-u4obM5bBHZZs=Mw2vd1cBnQ@mail.gmail.com>
References: <CAGQButtv-1k9DzOLEBwjoKQP+=-u4obM5bBHZZs=Mw2vd1cBnQ@mail.gmail.com>
From: "Poulin, Louis" <poulin.louis@student.oaklandcc.edu>
Date: Thu, 5 Nov 2026 00:56:53 +0000
X-Gm-Features: AclHuK8LNLiz5gugEYYew4NfNWdSnvtoqnsw5X0nCjXCd67zVqVHoJtAWnfUubE
Message-ID: <CAGQButvxbWxVSmcodzx+CNM+49PCywZufVJSSM_XU9T0Wx1VcA@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Add missing NULL check for link in sysfs
 show/store callbacks
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, zhaojinming@uniontech.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Following up with results from the ASUS TUF GAMING X870-PLUS WIFI.
Thanks to ZhaoJinming for proposing the missing-link checks.

I tested a downstream OGC 7.2.15-ogc1.1.fc45 kernel with a guard in
aspm_attr_show_common(). When the link lookup returned NULL, it
logged the device and upstream bridge and returned -ENODEV. The
guard fired during boot on:

  0000:75:00.4  AMD xHCI USB controller [1022:15b7]
  0000:75:00.6  AMD HD Audio controller [1022:15e3]

Both are downstream of AMD internal GPP bridge 0000:00:08.1
[1022:14dd]. The first messages on the initial patched boot were
about 9.2 seconds in. The read callback was reachable even though
the link lookup returned NULL.

The initial patched boot and three repeat cold boots reached Game
Mode with no matching kernel oops. InputPlumber answered
ObjectManager.GetManagedObjects and did not restart. On the third
repeat boot, deep suspend and resume kept the same boot ID and
InputPlumber process. I power-cycled the 8BitDo controller after
resume and verified that Game Mode responded to its D-pad.

I have not reproduced the crash on unmodified mainline. The
diagnostic identifies which devices reached the guard but does not
show why the link was unavailable while the attribute was readable,
or identify the caller of each guarded read.

Would a narrow -ENODEV guard in aspm_attr_show_common() be useful
while the visibility mismatch is investigated? I have a small RFC
against mainline that omits the diagnostic logging. If you prefer a
fix in link-state lifetime or sysfs visibility, guidance on which
transition to trace would help.

Earlier patch and review
https://lkml.iu.edu/hypermail/linux/kernel/2607.3/04295.html
https://lkml.iu.edu/hypermail/linux/kernel/2607.3/04745.html

Thanks,
Louis


On Wed, 04 Nov 2026 15:22:51 -0800, "Poulin, Louis"
<poulin.louis@student.oaklandcc.edu> wrote:
> Hi,
>
> We observed a cold-boot crash in l0s_aspm_show() that appears to
> contradict the assumption in this thread that the visibility check
> always keeps readers out when the ASPM link is unavailable.
>
> This was on an ASUS TUF GAMING X870-PLUS WIFI, BIOS 1805, running
> Bazzite's 7.2.15-ogc1.1.fc45.x86_64 kernel with InputPlumber 0.83.1.
> The fault occurred about 10 seconds into a cold boot. An earlier boot
> on the same system had the same fault address and symbol offset on
> 7.2.9-ogc3.1.fc44.x86_64 with InputPlumber 0.83.0. Both observations
> were on downstream kernels. The captured 7.2.15 kernel was tainted
> O/E (out-of-tree and unsigned module).
>
> Relevant excerpt from 7.2.15:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000030
>   Comm: inputplumber
>   RIP: 0010:l0s_aspm_show+0x47/0x80
>   RAX: 0000000000000000
>   CR2: 0000000000000030
>   Call Trace:
>     dev_attr_show+0x1f/0x50
>     sysfs_kf_seq_show+0xa8/0x110
>     seq_read_iter+0x132/0x4c0
>     vfs_read+0x34d/0x490
>
> The faulting instruction accesses offset 0x30 from the NULL register.
> In the corresponding source, aspm_attr_show_common() dereferences the
> result of pcie_aspm_get_link(). The read reached the callback even
> though that lookup had no link to return. The kernel killed the
> InputPlumber main thread and the service stopped answering
> ObjectManager.GetManagedObjects. This blocked the boot-time controller
> setup.
>
> We are building a diagnostic kernel that returns -ENODEV in that
> specific read callback when the link is absent and logs the PCI device
> and upstream bridge. The device and the reason its link state was
> missing are still unknown. We have not reproduced the fault on an
> unmodified upstream kernel.
>
> Would this trace justify a guard in the read callback, or is there a
> preferred way to instrument link-state teardown and sysfs visibility
> on this hardware? We can follow up with the device and bridge once
> captured.
>
> Kernel source for the captured build
> https://github.com/OpenGamingCollective/linux/blob/f6857d4bfd614b90302903490796ef376be0a67d/drivers/pci/pcie/aspm.c
>
> Thanks,
> Louis
