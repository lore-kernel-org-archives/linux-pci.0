Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9C38B7C3
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508201; cv=pass; b=WcImQZ/LNuCHldNcZG0iCjOMoWAQXs1vvuAzWNrjwaMOeTnW41Qub8WlCr85y+fiQ/5eFSOPb1AcHNEetJCc3GHqd1cDdssPfUVYz2D6JviB017uhFBke5ecXlQAc9wZA0hyKOyBzKwVSOdfkw9ZnmKwZSpJozV0eoQ/f+Ityqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508201; c=relaxed/simple;
	bh=WfD4dCVWiG8ERAjlT2lUVZEkQgo52iiyfAGVYhwTEPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pue/fQ59rv3lrAyWXg7mQRRObozl4wKLoT3XCpxv9S+9ldN3iGuH+5cLR4IZKHxdG6NLVIclmRbpcXhmVZLOa6kApXTmk0PF2IjgWOR/MO8MABFlS2+DPWUpcNWBbKwsAZ5honuKiwoWF/hQhcAfxNHKjJ8LJVDwHm0cQ5H+gI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irGoNKdo; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irGoNKdo"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698e5859a3cso1223956a12.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 03:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783508191; cv=none;
        d=google.com; s=arc-20260327;
        b=A0CLBj0zK3mwWT5UXMz6nY6b/wGPDtC5ve0REitjMGwB1UX+d3FB6AEhthP+Sb5vKS
         VdNcdBoSdBjddiwljkAjJ1e7/p08TtUSB07yjbz8686mxAD/eNvBijyDN3kUbpQeRqci
         yPN4Xzl9s7BVlAj0yjCG0S47ctnUnb8g3YAmTwPYMuB9I1O30kZXpI209cixQJrZdBus
         y+CR2GVN9AJNwV4DKdjvji9H9aYVHon7239NDBx+MyJInT2Af1rmbO7Mt3WJFQHX1CV8
         +yhDVh58pwNRzQVgIAEFZGHvGOXSWsv6SQRo9SEmUAekY0IAYJe0gg0YDCmeVb9dRP2w
         aEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2fiM2VYmvB72xpzWLhl8f8r7LxlArjuugnUoazlpVE=;
        fh=0kV9ED6hjKYvHoKXH31jVUvIzxChI21lF4L2CWu52bM=;
        b=JO0X9MlXRSr4v35vbseQ2010kHU6PTnF/iF8tZ9hc/rhn7sJefHZH2zPtmNUX6svhy
         JQb+AtVfuUgtll0P93v/Jv0BmlGdtiilQ5x0g5kvglr0gV/vLpzjjUi+FeH/kz7FrnRX
         TJU/UcSYFWwXpP6PKJvfgY7Azu2tyrl3J6x0Qm+t+doWuLweUsCRq9vyxaZ0Rw1N6woj
         sLilAl7IinD3VDLWMQ6gBI9VZvomOQ7lzpT4VsyMewH/TvUesZnv69mNIARySc1CRiBw
         8WBg6zTAWqnBpT7etX00jRFDw9hg4ci1jwdYGAPDyo6K8ZlYOKlRXUw34/7c7TsgEbC/
         jZFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783508191; x=1784112991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c2fiM2VYmvB72xpzWLhl8f8r7LxlArjuugnUoazlpVE=;
        b=irGoNKdolUUgTf0DnlsaMqcv8EFqrqNt9G+UMU3794JepIYHPimEvdH1xV3PIdcEtC
         gQCwvRBq9PJwzARs9DoxCRJVJG3iDuQVnx+EoGl9vRNS7fcM9OX0vVKFNikxcx+5XrvE
         a5Nt09e8LJOOk/nliwuP7Es6nZ5ZRrpjVDB9R7SUfoXABmq1NRwvaVZbtctVrHLUizU/
         qdsxxkixSVjcoaszy/86kN/sFfXdm/49c/udVyh2bNaDB8je1wRETjszs3hOW8ODMv7+
         DWrync3UG+N8UGuuBD6Zor82yrI9AnhxOhaKYubosdTZCTi/2LRwX71T5YeYmpPkHsjt
         7cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508191; x=1784112991;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2fiM2VYmvB72xpzWLhl8f8r7LxlArjuugnUoazlpVE=;
        b=iZdSmvcrkcTb/Ug0wEzIXcIbfCn9hS1lrcDH8V5SBXbY4fJ1dWdsbFImjUIwQggUWD
         HQyXktCbQCw1gNem/Ls1BGOBH9tTepFTBKft+Y8X/yRJe5c/mSceFqFKAytp8dW6a2Va
         VRRNnUAP7zgUx2LLcE+kCDG0ExbEfiW399ULCgKOT1gAaDBJOMrjaAi0dvOkuKJ7doZW
         QyNmWCVsu6l20FM0kD/WX3QEpigHYFPH63tnI1No7KptidTG3PJBqWEbafefg/E1ppbo
         CWif290Y5XnD0zIzObwjz6FmToVor5Q90UxeOJcw1M0/hbAY37xSXTGTniGTl7gV5tSF
         IYjQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJttsieRvtSXEAta5CRG0ikGy4rmzgQrqV/1tJeeEJ1n/u3dT6gwLTMAFvoZBFnPd1Sb5aPf4z8gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YysO0YyA58sXLG5N0mtuhD/QrXVl4BVuzndQBPruqvtHr43Shn6
	VsYzZxHW47jc+PJmrLvGksbiXIh66t9BA/6fqLgixl8mu0ttsNgRSCGXj2UhyTu+FpFI02IwMiL
	AuBa/+N6N7widKCz0+FCpUlJrqp5Fnnk=
X-Gm-Gg: AfdE7ck0+MRR+kL/j40IaQ5f7U/A6rCVzPGpss8/Qd/b5loeoP65sq56JRzFzzYhbjh
	yKIheY6APLQlfMHCiZKjiC2pY9ZDyUV8WrSwcmr7O7aCJZ+oUQYywyaT+vCth6HZ73scFbsvkXm
	WLrWNFEQD5L95t9wHqtNkGi6sACkjjnNA1GUZ+LwRxcTvUu8Dkk83XXd46q6l2AGUqDTfL319nJ
	O1jIchgJRvuRFgBZR6p214ojbA/9WFkUBjL+SlrBDez0wqvoPv1XfnK4F3U+6UwhjXbfILKj2by
	WGYDr9suvidjZxB/d5BJnNfwe5zh4Ys=
X-Received: by 2002:a05:6402:3058:20b0:695:ded2:52d7 with SMTP id
 4fb4d7f45d1cf-69a910978edmr2584484a12.3.1783508190638; Wed, 08 Jul 2026
 03:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706175423.98305-1-kwilczynski@kernel.org>
In-Reply-To: <20260706175423.98305-1-kwilczynski@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 8 Jul 2026 12:56:19 +0200
X-Gm-Features: AVVi8CeoFjDXhiwTTyAokp7GmJLW8914hLJ0O-UdzoTFxDt0DrR1yRktWckx52o
Message-ID: <CA+=Fv5T8GUH-d0PG6fjn6ARRcenpcDmsg8uy3dJbQ2gKZ85KhQ@mail.gmail.com>
Subject: Re: [PATCH v2] alpha/PCI: Fix I/O port accessor argument order in pci_legacy_write()
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Jesse Barnes <jbarnes@virtuousgeek.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, linux-alpha@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 7:54=E2=80=AFPM Krzysztof Wilczy=C5=84ski
<kwilczynski@kernel.org> wrote:
>
> pci_legacy_write() in arch/alpha/kernel/pci-sysfs.c passes its arguments
> to outb(), outw() and outl() in the wrong order:
>
>   outb(port, val);
>
> The Alpha I/O accessors in arch/alpha/include/asm/io.h take the value
> first and the port second:
>
>   extern void outb(u8 b, unsigned long port);
>
> So the port number is written as data to the I/O address taken from the
> user-supplied value, and the intended write to the requested port never
> happens.
>
> The arguments have been reversed since the file was added, and the
> function returns the access size regardless, so the caller sees success
> while the requested port is left untouched.
>
> Fixes: 10a0ef39fbd1 ("PCI/alpha: pci sysfs resources")
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
> Changes in v2:
>  https://lore.kernel.org/linux-pci/20260612232400.585195-1-kwilczynski@ke=
rnel.org/
>
>  - Collected Reviewed-by and Tested-by tags from Magnus Lindholm.
>
>  arch/alpha/kernel/pci-sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 94dbc470cd6c..7050f0f7fe3d 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -224,17 +224,17 @@ int pci_legacy_write(struct pci_bus *bus, loff_t po=
rt, u32 val, size_t size)
>
>         switch(size) {
>         case 1:
> -               outb(port, val);
> +               outb(val, port);
>                 return 1;
>         case 2:
>                 if (port & 1)
>                         return -EINVAL;
> -               outw(port, val);
> +               outw(val, port);
>                 return 2;
>         case 4:
>                 if (port & 3)
>                         return -EINVAL;
> -               outl(port, val);
> +               outl(val, port);
>                 return 4;
>         }
>         return -EINVAL;
> --
> 2.55.0
>

Thanks for doing this, this is just me acking the v2 version of this patch,
please go ahead and take this through your tree.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
