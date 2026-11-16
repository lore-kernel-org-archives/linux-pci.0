Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794858652;
	b=Fg1KP3t6PXUdh4YCMXFtC+9i0oPwO0/E7T7GcpC54czFgPC8mx4A3yZbbrxjCMSBbZqW
	 6Ck7SIS1jLBY6UtKpVsM2BAHt0O0CrxwAHBCpOFzLEpems/jYfomAdQZx7aVvpNnI0jDu
	 FcgON9++Hf8mTkKoEi4J7wa8aprcvWyaFH8KIarZ0SX0B4MdO4iRcMX0Y0s18zvCkPZh+
	 R6HlVx7gFiG8q/4GyHfXQTCZXsMA370Vwh6i0/f/KW8X6mpP0uANmwxxXoPXZwLA007gL
	 T0iu6CyRl5nZUS9v/RWiekxXK4ePcoqtrKuHAYZgVtBD4OIbloxVGh6F4z6/k/oEjRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=CxkHrH3VxQe1SMYPYrNEyj9vp9sqPdyZzYaUVPRrdH4=;
	b=iR6oxKWPfQQX1+opuufQoq/o5gTs1UoQ5fsmmSaTch5topinoL2EHd5TcdbBLSrNRwhI
	 1d6sXdvzK5hKXA7KOyyu7WCwj4SecLd5X9oeADASgUulWt+wQprY6jbr3VnlSnXsdGQlN
	 VuRa02ueAQYW+uJClcgP/fes7k0D/bUDEGxy6wdj3IIrOFtY7Pgnt1Pf937HpawGQhJL0
	 lzDkpdFb+4LtY7by7IPXlt+zRxbNeHRDEmqGVxmha7EgIUFGxQtcgI4ie7akLjjhyAZ0y
	 UymBeIIn81gAVesh3QYPun6ZUYDfTILuWX2KCR6qjwi5zY0GXiFYleNph3wpr38cg4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a44tx9FY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47758606A323
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 19:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47758606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a44tx9FY
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b81214ab40so598540a12.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 11:50:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794858651; cv=none;
        d=google.com; s=arc-20260327;
        b=mNlFfQkcmzfQ6/bBsfQHspXWIlRjOKxb0FHo9j7z00dxFoArRdfkrXeC6KIIMP3ZGO
         FLTRSSqG54j5h2l4MQJY7DEyhyhgUDD6kgOSR9HoE3MCHhJCcR7tOJxx+E9lr7vBhCBx
         WdQb50y6GlWSYdp58ESPkPzCYowkZhUWHA5Hv+VN1M2oNRvzFfIMaFDewTSt2HG32GTo
         1c0T6o6qM5XzYwMJMpsxTF5MOOlTZCw3eljd910uw4na7QPnjJDjnKwl2AsLOWE82RGn
         5qbg5GlpB14Ung8ofW9QXUqvZW6XwlFAByXUK7nE71HGFl4+4zSNlj+QsgKD+ZZ5tUpM
         RolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CxkHrH3VxQe1SMYPYrNEyj9vp9sqPdyZzYaUVPRrdH4=;
        fh=DyGTSUgq5R1D+XLXC9W95QYDlGHkasWVvUy46G3d0S4=;
        b=DnCuoGEg3+y0PLVAUjCAwsR1QxRUZ8D3XgRPVV9ncgKV2+Nd0nctaQZ1TFEdNSdXnw
         W6q2Fqd9ALCJ2lfTNm/j2xWtVKdGVtAb5mTamo0uMTEH+bhV3VQkpbMG+nGd9vXns0hw
         WNhPlu/RqmOoJdKPgZTWgvvpz6Y6wI+2ypY/yGAdEhvPdwvWPfMJbnQGrpRpdCU6gHMO
         l6cH7oJ1Gx9OSiAcAJqAZyoa7fYMe+ea+oMyFW96GCxvGw0B8xD8zskC5lWmOI81y53Q
         1nxdOjjdZUBXpFB+98MBYiBs22GVOyevSHvvqsZb6VuJ8mZd7BKr3TjdH5ukLfkr+wLY
         FN/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794858651; x=1795463451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CxkHrH3VxQe1SMYPYrNEyj9vp9sqPdyZzYaUVPRrdH4=;
        b=a44tx9FYyulYEGe3djm9Dz0e4h/xYE50BzIFjZWY1zKfeBJKRnDZ7tRH5xTHnNkbKC
         YrNy7YuRVwhOfWVEbrk9cNdS9qLZw29MPMsit5oz5tz4efpaft9J5GLu9dExFJgC1GxE
         Fo9SP5H0u8Qh1mGGy8eOrfa8Jb7o4+gCQ6ztDG5atsUt8o8wI4m7iRI1UPAedfyZV3T9
         xYfQM8cLEkGF8gaYfwKGPKxknUriZVosfrn5SrWMrZBgDwvuOk2Up9e6zTMHQuw291wQ
         JN3IyTMeymXNNN+s2nh8650jxW8nzAbS2WkDJriAZsikKVfeinh6IYLIxDHgV1bsJwsd
         vrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858651; x=1795463451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CxkHrH3VxQe1SMYPYrNEyj9vp9sqPdyZzYaUVPRrdH4=;
        b=A8QJYqnWCBPTr5CK88JNPuutPl0P0AIrWtt7ty+1nKUEQxYk0i6DDuZxRw2j1Hp1uc
         SS3/5OFY4mkYpkHUDUTF8oKaoBqclcOTznMiowWbBZ0FaWOe5GewOXZoGt7pgXT80WW4
         gZwwayb/HngP1X1qor/3M8X0ItfbSGEZ3+i+cKGkCf7j3GW9sWrqG0xQQ0N5J84x4d9J
         2VVs6f45CQsrBQxiA4THOj0+Nws3p/H216u2sdE9vFg5SdY7L253L7RSmUkvetoXkexj
         AiUMFP8G/15XX1tMB4aIpEQUTl+86+AnsnDCtnEuTBcPwsU6Ue2f96fhwZU/bTnXaimM
         ylVg==
X-Gm-Message-State: APuU4Z/htI9XEO59vToyxqarRlcZ13DpoTHKI5/F44d9KW0+hFJz2qFV
	ecLxtbxMiKRFbQF3c57ce9DSnYsr4VWUR6f3uAkbBQ1Bk3Q1JKDJjeEkfX75IqSXU3YW7bdshwr
	40DwsbPXAkj9pjcFUqOQIAPOC3s3QA9E=
X-Gm-Gg: AYBFou20Z3kt3mJpRJjVhYL7kJPnttrZx7XRgT6r8Tl3vkG+1T/fDPjZxYsvO25xCsq
	ILk2u6MZcTwT07fVBaYGD0Ws/UQim+V1C0Z5izy8SQa/BRELH1wFPfdEpOfPvAKvU+epXdmPUfp
	WBc3PXQP08ZqxYAwLFrAMGKOlRZNKLMPtU9zomDXxOAnan9Rjc4zHPAkuvg/z5NbhQPaMUDWWxo
	lcE7NRy0yZY3CApN5EFqc7GOg8MncEhG5o0oFnETd4OwHuLe8qN+VC09SgZzRkb9p4VcKeeW5RK
	D5r+LArwh5PMljme554CKwFVcUZueP6+N0IbgpYpDT0EsyjCRVD1YgawoOaL7IC6pjy0m7MjmGS
	K2Ne9a66M6sWheaCMvJzPer390OBOZioJMym0dfGJzwtwlzYRgXeDgVFkBmCLL78w5mIPzyLL9g
	tyiBMfWK8IxNH7fLy2ZCzMsQo=
X-Received: by 2002:a05:6402:2b91:b0:6b4:1eed:b9f2 with SMTP id
 4fb4d7f45d1cf-6b859739689mr380339a12.10.1794858650577; Mon, 16 Nov 2026
 11:50:50 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com> <20261116152403.2672-3-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20261116152403.2672-3-ilpo.jarvinen@linux.intel.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 16 Nov 2026 20:50:39 +0100
X-Gm-Features: AclHuK_k2jdl-xE0SWqHh40PilxNCJBvLhOeyDjPjuatpm5yQ5pSESh5pEDEfkc
Message-ID: <CA+=Fv5SkcpskpFUCP-qDmP1vWqDiqO8FgSJJ92UvX6jGRfaGLQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] alpha/PCI: Convert to pci_bus_size_and_assign_resources()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Mon, Nov 16, 2026 at 4:24=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> To serialize bridge window sizing and resource assignment, PCI core
> needs to hold locks across both phases. Alpha nautilus PCI code calls
> pci_bus_size_bridges() and pci_bus_assign_resources() separately
> because it needs to do special resource alignment and setup after the
> window sizes have been calculated. At least the former would seem to
> belong to some existing __weak pcibios_*() hook but the latter might
> need yet another pcibios_*() hook just for this single use.
>
> The nautilus code runs during init, so nothing is likely to race with
> it. Converting it is mainly about consolidating the sizing and
> assignment entry points of PCI core, which eventually allows removing
> pci_bus_assign_resources().
>
> Instead of trying to do a complex rework of the code, which is risky
> without the ability to test on the hardware, simply convert
> pci_bus_assign_resources() to pci_bus_size_and_assign_resources(). This
> adds a small bit of extra work by performing the sizing step again, but
> the calculations should yield the same sizes, so it seems safe
>

Agreed. By the second pass irongate_mem has been request_resource()d, so
pbus_size_mem() skips it as assigned, and ioport_resource is never picked
as a window (find_bus_resource_of_type()). Only the AGP bridge's
unassigned windows are sized again, from the same inputs.

That does rely on the assigned check, though: if your follow-up series
starts sizing assigned windows, nautilus' relocated root window
(size_windows =3D 1) must stay untouched by the second pass.

It builds at every patch for the generic and Nautilus configs. I have a
UP1100 (Nautilus), but it doesn't start up at the moment; if I get it
running again I'll give this a boot. But for the Alpha part of this series:

Acked-by: Magnus Lindholm <linmag7@gmail.com>

> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/alpha/kernel/sys_nautilus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nau=
tilus.c
> index 13b79960b4b9..23a74fd4a83f 100644
> --- a/arch/alpha/kernel/sys_nautilus.c
> +++ b/arch/alpha/kernel/sys_nautilus.c
> @@ -263,7 +263,7 @@ nautilus_init_pci(void)
>         if ((IRONGATE0->dev_vendor >> 16) > 0x7006)     /* Albacore? */
>                 IRONGATE0->pci_mem =3D pci_mem;
>
> -       pci_bus_assign_resources(bus);
> +       pci_bus_size_and_assign_resources(bus);
>         pci_bus_add_devices(bus);
>  }
>
> --
> 2.47.3
>
