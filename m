Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12C39E198
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372003; cv=none; b=VmfZUP6MitAOlHqsAgE/+o/CwkgEzkG2/ZNIk1DqHgIqDjhDZ1vZNURyfDqu/h0XggYHJa2zqYmkg+ZflAnVO/6ATx2rTAc3uBX7/zHeFv7AVd0RAmOo3d0S/ynLt0Cr78IXjcfSlqyhh+7XOqUra4PtJKgpz0f2fZRAvTTiU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372003; c=relaxed/simple;
	bh=3GEJwPfpmz1HAcFqPqDcCHr7DP7fs2OA9k1TBgcroIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+HJRkdt3bI/AUpJWJG/ekEXKDBFGc84zJvyNUJj2wk9oFOHpURsS3zltYiEkZRvV+em6czUHaZaghRX2AilrDW5oo/Zj9nWy/BEqtMYQws1NCOP2aEvOL8uEGZxvFhm3vRy6oGbQVFRDzJNFC+BaJzj3w4EB9odrdVes7SCBFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5675d609621so4230739e0c.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 10:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774372000; x=1774976800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imA4hBFgRxEV6K6PxesH3aFI8Gk9es7sFYCGiASF9lc=;
        b=MWSfw/KSkk79woHXsrdfK8b6+C6SEZTF4HEt2beWVBcRXAXwTtm7q8Bd0cV4yV9YGJ
         v26b9Mq2m6F7Hex7U6119VZyWdQresiqqisIFE5QlB41Q6Ujz8NMzIW63s42CmgJeOdk
         bMoGDhCegehpazV4BkakL/GPvySpLq3sd/Dj0GwhB3MFVozcSKdPBBWCG+yIFe1J8yRo
         dS+LgS0CkWhzouir+El2Cpv1bnUyf/imS/j80neVWC+446YblawKUZXNEd8Ov/bdY666
         Wq2HDKxA0nuE10CG9+GTqI86h8H4XwPbv7lC4Ds53uPEqyE+oPDeXAvQKT8YrRH1yn5m
         EE+g==
X-Gm-Message-State: AOJu0Ywl8E2raWgUWpVaZIDdkcYRzlCmdt2wtJol/DoU2ztmGVzcwSYU
	4ZyCu+1pH7HH/Ngk7TCurZZmxjxqbuao0W9+xqN5m0XtvRf28qTDf8dYOUerGYH2goc=
X-Gm-Gg: ATEYQzzZAs2cZxQ7Q789FEJueABBLHrtYgV7Q4NNRM3RXD/7SyBbfFzVHpVBRj11Tc+
	ud6BdUYTzL4tjlEwxhOMvjcFgHti7S4eXsfBYWhbfcO3qvMtzjJKxwSA2DBoPskcwoCendfRlx0
	ZVU/6/PMhywRtroG3JbbvRJaTcze38KeWUv4+UdgV7rFpFReklNirkafvMhOmvCDt/QnR+cEaOI
	nTOOTGXrXMX5i3P2ls6YSIIP13GoXVSKhCZx2WvwdHHP6a6FfRg5qxFUZR/HzI3EsjSGkw0s9ks
	i08Q8tQVhu1VBr0+AguRTvg7QichL83sUxXODA6zL8Twpl7TeA69OX2c+w23W1uGbbGS6Ed59Ap
	VRWn2ZCD7imXMz4UhZKVECGQ5uYDX9JEGxdrpYM0ScPS7u6nrDs2+rxPi1pZayvk0RoTJW8XVuF
	76pVFauLRmfEuree2sFCYgHzN+qmwicU62nn/qXgkvlToeztsIaFzyIhwLERvY5pmY
X-Received: by 2002:a05:6122:4899:b0:56b:7cf0:cf67 with SMTP id 71dfb90a1353d-56d2210575dmr398668e0c.15.1774372000430;
        Tue, 24 Mar 2026 10:06:40 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56ce54d6b6asm14620086e0c.4.2026.03.24.10.06.35
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 10:06:36 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56b6c7c8d00so3452524e0c.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 10:06:35 -0700 (PDT)
X-Received: by 2002:a05:6122:1da4:b0:56b:5978:22f5 with SMTP id
 71dfb90a1353d-56d220a8b85mr416671e0c.12.1774371994638; Tue, 24 Mar 2026
 10:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com> <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Mar 2026 18:06:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXX16=pih34yehj=3bJkg2H3ivGUj_34JDg31ABheLE5Q@mail.gmail.com>
X-Gm-Features: AQROBzA3vydAXwvxX7mNaSzU55R-3eBg9lznDuFtNbFYtRdYd66gsLQKONTytjo
Message-ID: <CAMuHMdXX16=pih34yehj=3bJkg2H3ivGUj_34JDg31ABheLE5Q@mail.gmail.com>
Subject: Re: [PATCH 05/10] am68k/PCI: Remove unnecessary second application of align
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	linux-kernel@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC gerg

On Tue, 24 Mar 2026 at 17:59, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Aligning res->start by align inside pcibios_align_resource() is
> unnecessary because caller of pcibios_align_resource() is
> __find_resource_space() that aligns res->start with align before
> calling pcibios_align_resource().
>
> Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
> result in changing start either because 0x300 bits would have not
> survived the earlier alignment if align was large enough to have an
> impact.
>
> Thus, remove the duplicated aligning from pcibios_align_resource().
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/m68k/kernel/pcibios.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
> index 1415f6e4e5ce..7e286ee1976b 100644
> --- a/arch/m68k/kernel/pcibios.c
> +++ b/arch/m68k/kernel/pcibios.c
> @@ -36,8 +36,6 @@ resource_size_t pcibios_align_resource(void *data, cons=
t struct resource *res,
>         if ((res->flags & IORESOURCE_IO) && (start & 0x300))
>                 start =3D (start + 0x3ff) & ~0x3ff;
>
> -       start =3D (start + align - 1) & ~(align - 1);
> -
>         return start;
>  }
>
> --
> 2.39.5
