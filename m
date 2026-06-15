Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A138B12E
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553946; cv=pass; b=TaJWcphrxWhk9GL9JAgfOmIN34URh/gmbuvxLGdoFUyzw+IzIkpM34UM5Box2QqJNCROJiyFW6tq8qpFXHuIu+f4/CFupIIhmo53nmdmPETiezC4FlWf0kwLowuf5lU9x+uEQ9qLOXSc9vI9kF2MJTFtQ6ixQj87+hCArcY6zZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553946; c=relaxed/simple;
	bh=3V/U8KgIXhuClTDyJ1k6zrpIQe+ZvsYMWtZDcuyI4E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1h0C7hdoUe6XuO6fVC/hRevESfdMu3M9iv5TTPbDnb14xCSz4PWwHd698BLuqNY5zLrlxLTf+JrgZtUFPk/785lbKmCTVOb73qSFbDTe65YjAfnTmBWJAiAubm1to5r11nq17K7gagp8Vx7GFR+19U1iZL4hoDS92QWSCR6cVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLPib+9t; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLPib+9t"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6912f4acca4so6620536a12.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 13:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781553943; cv=none;
        d=google.com; s=arc-20240605;
        b=d1zWGh5gQOccKWESBx05SmFpSkrwQbSTyfo1onyo9zWOpbHlaNadD2JHZXFymJAx2n
         75RlYcRSUeSuGQHxvDDg6sUF+fFANZtUcUl3vob8e4l1chhBbf56+snu4XBp6Y+WXp+N
         nWrUkKf/8EIF5MGuVxP7mQDQZfeuaE5G6T2z5h5gxV0LnY2r2bO/SSznCK9rjBotwPIb
         gvaso8mRUOSwJSG1W6AOA+RGGygiVVXBt6P5FtCbhhdhFAjTbCD7fQfNnpoP+CjIgwlS
         6mHBqQeLQf+TqPiOqzz2EHXHxgd00EGB53wmzvzCMlClzKWiv/W0Pz9IbBVz/4YNKkOY
         hUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kv3VSLJgNyoH+NUWiTKXsR5r5F4mupN8PAxWMZPbE/8=;
        fh=4z8JL7XLB9FSCQN1TkkiWLL6CMkIO6VybjDgqVk1wdI=;
        b=WsJQediCBg/P/0awP3/AiRBAfUSV5wxiNj0dbRrvAiNmnZiyBeRv29NnJm5VMP93gY
         s7Y2Vevm7biCAzd0dQNuPekx5qtNnIOdoKjP7tYddGSyiuKSk4nEw8hVtlo9drDO/G9Q
         ltTMz+bpg3EgmOoEeFbdPH3Cj6Rhl6QBWwyeDPv1KZisL9EGnL9eouhtUMjule5WvhOf
         FRW+L/f0dwttOWkNS2j+4VCxECzU3MnuIXCmE65COh4On9x7U87+9/ECchJI6eDpmjGF
         IWCz56VYOO+16HDlBxxdILS5q3363iLUl3j9DWckeqrE60CsmyZ7YURmBcTKummM81vE
         SQ/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553943; x=1782158743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kv3VSLJgNyoH+NUWiTKXsR5r5F4mupN8PAxWMZPbE/8=;
        b=gLPib+9tNEu3NOvFixvGG8vTXvzlN8K5remQ+rj+4QTWAc6rY7O6w6bLkyde2A2JXM
         THRRIXK6LGvHi6rZYXkRRxm+pgj7iFjz3Pb/fFbZBYXwJueVGZ8IR1NiX4bFd4H0lhT4
         QtE8iAtv/+SvRPKW3/Y5oAOh4RqIkHQ0pceHWRIi9q/zyd3aHQ/ycQHlSLtM1HMbL/Lk
         bj5A2i2Wd2/t0omVrb+i9w/T4N9Q2pvTuguWtut3wOdren0XYhytc2kWcyG1xVmhBYX/
         wYovmeGF5hyNunVEAjB8IE3Xt3rrKGn/CvR5OaluOrBMNsJzR/oUeQtnOfd0YiuYBeLB
         KqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553943; x=1782158743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kv3VSLJgNyoH+NUWiTKXsR5r5F4mupN8PAxWMZPbE/8=;
        b=tYZ4y3GdQ1firezsA+xdeDb6AmqSO7cM2T1ZLrXMucfLtv5eomeNgvv4EK/JvZAGbv
         76HeVYBHFhM4bias22LjtNYIzfn18AoYlFfgzQweF/8LTGdeAuu73NjBKFG6cI+vowXi
         YPJTrFkjmoy3E+mjPzOCQ6JCC2P+1dxvSTKLw7Y3gtoJum/hqocmSxDEkIj/zqgjsSt7
         +2d3AWAPPmWCZaA2FOSUze68+mC8tc3zMM/DitgDTYUwa5MUV8eyWcd718hSiX8P7Nd2
         xACwUGnhjBF3lzrOBrs/eLfTpJZLqujvS4CCPs1xOXwpP2W3pBF9qAKjviqFfuuAiIql
         vpCg==
X-Forwarded-Encrypted: i=1; AFNElJ8+z71Zyn4sQMBD5kP3qO0dFzNc/9jN12WToFqXD0E5NLDHYfvJJXWrx1jttXEfU9gslMbTIfheTDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzphjPfLLcUN5VwUkXrCGumQG42oshAjuzwTOaiJU+pmNSzrppE
	e5E4PXimlVyuMhO9f6UEtAa1aL1qXce0tfU3ZfPk80RKauGy7StoFqM/V4caw5MXrFaDQlBG0Hi
	1IwM7gik+lLZ5SGlonEnGy5OD3iQzMu4=
X-Gm-Gg: Acq92OHPtZzW/2W7sFlLldEYEY5jUHKE5ASk/SDWkZQIckd+JbG/wV26E57qa5HyFR5
	IF94KfbDlF+fX8lZ+KgJZQpuNIFKNV+hNeDvKOl65syiSTHw/YmCd29stlrt0kudhtE4vAUbJYC
	r+ueIshJ0QGlXEOZzOFMaYaIacQx87VTwekisEk3YESoaf3lWUGmmVGNAgkjy+soJPbKOlHLWVv
	om5Fz41UpS/7kZcFEr5Cx3cm4veCJmbBZqfRKy2bOs5atX7/rqr3vst7J2dMlkG6cbaVMX3xR4c
	QN81YU98F1Kr20wjMf6ZaJhpge8PxTsEc8tKT2c=
X-Received: by 2002:a05:6402:a51c:10b0:68c:f3a5:4990 with SMTP id
 4fb4d7f45d1cf-693c6a93526mr3313262a12.25.1781553943083; Mon, 15 Jun 2026
 13:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612232400.585195-1-kwilczynski@kernel.org>
In-Reply-To: <20260612232400.585195-1-kwilczynski@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 15 Jun 2026 22:05:31 +0200
X-Gm-Features: AVVi8CcsKHXnY2Y_-E5yGWXaZJVn7GiYK3wlMHP7wC_FW7_gkEwKQPN8p-F0FZc
Message-ID: <CA+=Fv5Q4dG0JC0yPn9iwQJTwYMb+VwT9EANpcL28=WzGLLAz9A@mail.gmail.com>
Subject: Re: [PATCH] alpha/PCI: Fix I/O port accessor argument order in pci_legacy_write()
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Jesse Barnes <jbarnes@virtuousgeek.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, linux-alpha@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 1:24=E2=80=AFAM Krzysztof Wilczy=C5=84ski
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 3048758304b5..354ec5f10ad0 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -355,17 +355,17 @@ int pci_legacy_write(struct pci_bus *bus, loff_t po=
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

Krzysztof,

Well spotted, this looks correct to me.

This must have been lingering here unnoticed for quite some time.  The
Alpha outb/outw/outl accessors take the value first and the port second,
so the current pci_legacy_write() argument order is clearly wrong.

I tested this on an AlphaStation DS10 by exercising the PCI legacy_io
sysfs path against the scratch registers of the onboard 16550A UARTs at
0x3f8/0x2f8.  With the fix applied, writes through legacy_io read back
correctly:

  ttyS0 scratch at 0x3ff: 0x5a/0xa5 write/readback passed
  ttyS1 scratch at 0x2ff: 0x5a/0xa5 write/readback passed

For comparison, attempting the same test on the unpatched kernel caused
the machine to hang, which is consistent with the reversed arguments
turning the intended UART scratch-register write into an access to an
unrelated legacy I/O port.

I will pick this up.  It might not make this merge window, but I will try
to get it queued sooner rather than later.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
