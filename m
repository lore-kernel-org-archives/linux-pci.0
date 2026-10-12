Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1920F49BD89
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819439; cv=none; b=aRUStALCBw5PKwjW+nPFWLsxuCmsruYssHUWmMOQO4g8iY6oaYelBBepYEw+WoCSr5pdo+wl09xYjreif9JSp0/R7VwlcedYqg6KpoJRMJeZ0O5GQP/lmId1N7vkC7QGF5v2hjNhBpA3Zq70Y1P9mQ0cv+4RTHT/+fr8kngX8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819439; c=relaxed/simple;
	bh=Ny6CnJcMREGWOqOHnwVu++VYZE8mUIUwqMU0hWC+Llw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDjR5b745SM+HEkJ7W4eV6TM4YX4lKuh9wFmgd+I5Lervr53h6mA1QTyOhhxlTrvsM69TZgDs6WmP4495cELcjNYh5JvQegtv6NnaLXnPkJ6PHvBwy1zyegC+JTjdw8SNg86ia3CtC5jkyVBkJy4LkXtgQIxGITwHeGx0bMO6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnV4OwTk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnV4OwTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28701F0089D
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819437;
	bh=0LtWcDpcoANXJxp8BUzLrX4nuAiYWSXUb2UN4CsRl44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FnV4OwTkZA/UNOS5Ux4gh2FK0Pqev8vsp2jMe/kCyc0LAycKwKRjIOP/dmsMCl/Uk
	 xI/S3z7UvSkvHPrE9BKs8TfHLfuxE/lQQ3eJooU5E0U+8vBoDnuj7K/E/djyTtbZlI
	 0EJSdzRxP64LUpDt/K0SdHckNJOr1gxQmFeeZjdOFgkv5n+t4lJis3K8NkyucUSkkN
	 dmMyS55Fm9znnm8c0pcjjqTHYX1enVN88XVTpvCOYFMSJNuZ2Ruwqhu2xD5tkJpeQi
	 00AqKHvOvAtlmUnjuw5G7mo/bpytNYAppPwvQxgr9RHAWZlkA56W48uHhG4sELbzjf
	 mXF4N8abeSmLQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso1356629e87.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 08:37:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy3CS0+8yV6l15XuzdbBORiDX+FGtSljRlp8aW4SNKeMuMqzWtQ7UoTr1gO7lO0Nj4bPkYjHDeb/GA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6GJfVbLQy2KjzyuZF50V+pTNWljwtqmXmKIEA5uxNW6LGQVpu
	TilEcP4fW+FWDA3JAmNAyXGUEngOMXmO7LsLbpxiGyA4qSAiRjEyZoxrf4i/kn/rq9ZU++tKoiu
	GUN9h/5q+sBrQIhm9jQcTTIuYuJ7D/UQ=
X-Received: by 2002:a05:6512:1592:b0:5bc:b5ea:94b2 with SMTP id
 2adb3069b0e04-5bcde8db1damr3599793e87.59.1791819436162; Mon, 12 Oct 2026
 08:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925155846.2381956-1-yaojiale02@163.com>
In-Reply-To: <20260925155846.2381956-1-yaojiale02@163.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 17:35:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hjijTBTcUWW_esn414CNenNuBN9Viv+boqYX=fSnuQpw@mail.gmail.com>
X-Gm-Features: AclHuK_MhwdXrrCVuVtKNaYGnMohUwJfio5uZBGpMkVRF1pokHTd6KvPAgrMm3U
Message-ID: <CAJZ5v0hjijTBTcUWW_esn414CNenNuBN9Viv+boqYX=fSnuQpw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PCI: link: clear driver_data before free
To: Jiale Yao <yaojiale02@163.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@suse.cz>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 5:59=E2=80=AFPM Jiale Yao <yaojiale02@163.com> wrot=
e:
>
> acpi_pci_link_remove() frees the link object without clearing the ACPI
> device's driver_data pointer. The ACPI device survives hot-removal and
> can later be retrieved by acpi_fetch_acpi_dev(), leaving callers with a
> dangling pointer.
>
> Clear driver_data before freeing the link.
>
> Fixes: db89b4f0dbab ("ACPI: catch calls of acpi_driver_data on pointer of=
 wrong type")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/acpi/pci_link.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index e6ed13aee48d..84bfcdf242dd 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -787,6 +787,7 @@ static void acpi_pci_link_remove(struct acpi_device *=
device)
>         list_del(&link->list);
>         mutex_unlock(&acpi_link_lock);
>
> +       device->driver_data =3D NULL;
>         kfree(link);
>  }
>
> --

Applied as 7.4 material, thanks!
