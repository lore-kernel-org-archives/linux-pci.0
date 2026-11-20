Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180576;
	b=jUya3Bhshnq0BG0YA1ARsoOWAF0QZrNLB0OzeRqOqKuNP1tCr8AV6h/VPTKeO0noGZIq
	 TCXIiHgILLXG5MKDiL2X+nbjlkyjsd/FJIVfwMAqHJkcsu/9yiMMGix7uyOOYWH2sDIAr
	 s/gWQn6gEJl9Sff/W9Sd26nWLSsksSEHc4Q3vpgZ7M6pxrjBN2p5JniGAaib6eb5gqXYd
	 8rXUhqO3D+UTuP+VXBs3msoWIVlip2i+FAH2Gi5mrf9a7tqSkjlm0yCm8SrpQnAdf6g+8
	 kcub5A8lBY6DxRKngPXrlN30hKnpA/S0dEEHQAE23m/qcLD214neD/+yf31JE9rqprA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180576;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qJySTJ/Iif+q+bjvxyYP73UcN83CV57ktL1K2JtuFpA=;
	b=cMPw3IWdDxrXEOjyiM9YwqnnEv6FDCqP9sG3UTTiWMr+2U/E5hzQohyuDiBlVOJk5uZO
	 PTM7ImBjctt3kDcFKuDdFLFJ3TVWYc0AQAIzfWsH6epZatxGWcEfPS039VPvcmlsT7V1g
	 OKGrQoniVD6Rqd4/FtdPSyWhZOUfQk36TAKJr0LC1eKcqnB/hLNrHvrpZMmntIWJ78QEX
	 Qsp/jlUh1PKb6I2+EddrcNChcWLqRmssGVG7xFy+qvKhQ+ykDOpvyEDc6R0CGTSgm6ZtF
	 RqNyZi5fYIUPkIGXNELXdM5FiXDaHj6N6Bvx5BnzG/J/zwSN+9a9fX5zTP1tmWL256A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OA8Ngabj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838DA606A330
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OA8Ngabj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3D31F000EE
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180576;
	bh=qJySTJ/Iif+q+bjvxyYP73UcN83CV57ktL1K2JtuFpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OA8NgabjPJdYImpvqgdHdrrLy5S9ir6Yih63pz3ixpGLYxTGGQzOIJWxE86gaf1eC
	 RrUQ0ujCBvzBKTBeDxQco/TjqE7al7GPQnjWbqgvPklZNXIJ4JaIdx7xTrn/ZkTBpi
	 hDRl2+6I1oDpCk0b8VFLL0Aev/TxpUlAjxFT6GnLVnTvBFjfRlxnd8KV8b89nlmgwr
	 y9MT2Kl2rlS/odgR/15tOFR7FafGKo6BrdVakQXSJ6pSkP0OZZKUgEE96pzHUJ59/k
	 xAMIV8uOfjUSl24wxDmcIIdhy5PaUcilvxsfj01DGrO8cWauchDUEVl2FkPYHK3c8P
	 RQWLlRFIukyaw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3adfed9a887so7148601fa.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 05:16:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHotM7Mse0x2BxAUoHzs9u1+YvCw+A2LZNSHOK7/g+VMj7bKeTkfPAyTMQ36f2z+W3NffoW9ekDejI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+j1q8yP9S9DrGawqGgoLI2411cayaWD4l38M5qQ4RxwsWvQKhP
	Im+F/k2DVFYkl+Jo0P8nbgIeD7tpa/Lnc8BTsGkRm2vdLs/veO9Sm8zuOSUUySzjQ8FR+fxf4wS
	sjQ8QzHjw5h2gCYVE3qTW+qZN7xuIz5E=
X-Received: by 2002:ac2:4e0a:0:b0:5c1:4aa4:557 with SMTP id
 2adb3069b0e04-5c1bc7cc547mr921042e87.31.1795180574608; Fri, 20 Nov 2026
 05:16:14 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116120721.1713-1-lirongqing@baidu.com>
In-Reply-To: <20261116120721.1713-1-lirongqing@baidu.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 14:16:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gWmUAhiCQDHaazOUh03BToZ=qtwGoEfqpct0O0Nv9t8w@mail.gmail.com>
X-Gm-Features: Aa3M54qns9VkKX3b57FYvIkIX1ycEU2TcktxLJ1HaYV_ODY5a1ZOktNvzNP-3So
Message-ID: <CAJZ5v0gWmUAhiCQDHaazOUh03BToZ=qtwGoEfqpct0O0Nv9t8w@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/ACPI: Initialize the handle in acpi_get_rc_resources()
To: lirongqing <lirongqing@baidu.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 1:07=E2=80=AFPM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> acpi_get_devices() returns AE_OK even when the namespace walk finishes
> without a match; in that case its return_value argument is not written,
> because it is only updated when a match terminates the walk early.  The
> caller passes an uninitialized acpi_handle, so on the no-match path a
> stale stack value is handed to acpi_fetch_acpi_dev(), which treats it as
> an ACPI namespace node: acpi_get_data_full() rejects a NULL handle up
> front, but the garbage value passes through and is dereferenced in
> acpi_ns_validate_handle(), which may crash or yield a bogus acpi_device.
>
> Initialize the handle to NULL.  A missing match then makes
> acpi_fetch_acpi_dev() return NULL, and the existing NULL check on the
> returned acpi_device turns it into -ENODEV as intended.
>
> Fixes: 169de969c018 ("PCI/ACPI: Provide acpi_get_rc_resources() for ARM64=
 platform")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> Diff with v2: remove check if handle is NULL
> Diff with v1: add fix tag
>  drivers/pci/pci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e260089..f14f74d 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -82,7 +82,7 @@ int acpi_get_rc_resources(struct device *dev, const cha=
r *hid, u16 segment,
>  {
>         struct acpi_device *adev;
>         acpi_status status;
> -       acpi_handle handle;
> +       acpi_handle handle =3D NULL;
>         int ret;
>
>         status =3D acpi_get_devices(hid, acpi_match_rc, &segment, &handle=
);
> --
> 2.9.4
>
>
