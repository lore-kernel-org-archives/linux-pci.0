Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310409;
	b=wjJIAYqJ5WmMnIyBpAqv+8YxfTe0wXZ+9/jlXb0eevk1ROJbLAFuilFRuh/pm0Tx2f9N
	 0BCgxbnCIXEuR/hbl4ojOem7dOSDm1ylcgNorWJHbuA6Czflq8bTvQ1kQTrwFjzAoz6o8
	 foPp9VYuQtFHCytYvyY+tcJ8ZeIlfwRW1JDbyIGBLq1IlhN/37Fs5E8i6/vi6FbeZ8AM9
	 3N3yGBWItxf9kWnWT9rqRERbIYk0kfMU/cvJy4RE5wsy40v21fNJKANg1HrNsHF7ZSm0o
	 Ee6usvFI03U/ooeHBl9yWGMizd79oF2kyA8dWMpB0TRm7WcBt8OKUO0ZpSfpvwfk4uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310409;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YgY4GvZNXZvMZ3ql+8fhr4JZ923ggCuD2y7382GN+08=;
	b=XdbEVeygAq7D7kytXqEGe6oxw9vZMeF4EwJX6bWypWslf6162UVmKuG2edsm63SlLmlC
	 6AzrPt9FXiAignyNmj3nc4px/dbHgmMXdVLC9n1j3KFkrjzoVBhbmGoHAP84lq/09+CBQ
	 MjbEaPCKNwDleSDslOmfQe9vj+qKs3krkso5iXPQwgn9kRKNR/1TchT8TR2a/yQCyjWoR
	 dozU/SOT+P4fhVo2mW7nGhhgK1t7QYB+kx3v1uEwoPwk2trVJ9AAEJAcwd9IStjldA4IG
	 UdmL/QzCyCEzAdQPlOWBb7uVGPRAphwW7Lkz64dHfmiNK5JfydKMgWSNQ0IUjwJaRlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5Skoeev;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B9606A32E
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5Skoeev
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901021F008A2
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310408;
	bh=YgY4GvZNXZvMZ3ql+8fhr4JZ923ggCuD2y7382GN+08=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A5SkoeevCj1UI9vUNmbwr9lWAlHIjTHnPJHXb/YaHBBulWp9XWTXrSI4gz1FtM3E0
	 vJDdRbEFlV1bw6pE+dXAVmqntFaluCJ7KTigP1WyP/vIdwyfNmTE0l/SaK2Hp/cx/7
	 nhdKiTbADqa1hwadTEbJC8nURwMMXG2uop/5NMYLIcSvFEWTQ1hRLt6KMWuUg2bXCd
	 uLzYnuBSO0MIROo++oQrs/tpzHdXti0hUoLlzRNNcrQsB4Ap/cGZMDKusRNFPj0bxu
	 7dInUYKhImv/sEBiBCX8zbyxQZhGqI7DbCpMp36U3ruCfrTGhyuaymx1aFCAxDHWrD
	 yajzKbKPoFYBA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so1109549e87.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 03:33:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFLj5eW2Jvwhaa3qKiht2hlH2pjnEs5ZwqEA5at2Q8lZ+SGpElRSStkltlmfzTRFu7QCe5LD/VufHk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zbK4LiHlp3RQojKjNV2P709Sa0WyF1+433zwGzrowo/40IaR0
	URPytchvempfuNSiOsSxQa2vXxTcaWtfLWm/TJmBCfcuvevx9pFEVwJTTygnCd/CIdhZLtC04Up
	nEDQCZXscMLiQRboUOoP3wevxi3weKiE=
X-Received: by 2002:a05:6512:3c9d:b0:5c0:cba:7d30 with SMTP id
 2adb3069b0e04-5c156e9eed7mr707271e87.14.1794310406972; Tue, 10 Nov 2026
 03:33:26 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110053423.2517-1-lirongqing@baidu.com>
In-Reply-To: <20261110053423.2517-1-lirongqing@baidu.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 12:33:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iE7jKS+7J=RApvVZo0h7C2MPsp5Zkm+3-8VcoVGMum6Q@mail.gmail.com>
X-Gm-Features: AclHuK8kL6LYexEzPSOX_lwrmiw-eQLWHllK5RWqbY0IvprgeqWxWKHLkZgeY2c
Message-ID: <CAJZ5v0iE7jKS+7J=RApvVZo0h7C2MPsp5Zkm+3-8VcoVGMum6Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Check the found handle in acpi_get_rc_resources()
To: lirongqing <lirongqing@baidu.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 6:34=E2=80=AFAM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> acpi_get_devices() returns AE_OK even when the namespace walk finishes
> without a match, in which case the return_value argument is not written.
> The caller passes an uninitialized acpi_handle and hands it to
> acpi_fetch_acpi_dev(), which dereferences it as an ACPI node.
>
> Initialize the handle and reject a missing match.
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Stable may want to pick up this one, so please add a Fixes: tag as
suggested by Sashiko:

https://sashiko.dev/#/patchset/20261110053423.2517-1-lirongqing%40baidu.com

> ---
>  drivers/pci/pci-acpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e260089..e90e749 100644
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
> @@ -92,6 +92,9 @@ int acpi_get_rc_resources(struct device *dev, const cha=
r *hid, u16 segment,
>                 return -ENODEV;
>         }
>
> +       if (!handle)
> +               return -ENODEV;
> +
>         adev =3D acpi_fetch_acpi_dev(handle);
>         if (!adev)
>                 return -ENODEV;
> --
