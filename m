Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC23DEADB
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428259; cv=none; b=HO6ciFviWUtAaVgzpR/jJgF5O9ch7H5FtfKw87kU9NeS2+Ml5bvjs3Pcb//qOUFAtTz3uTaiMH4Wxa8+gxb/nV6+QaTPxr+BhRvWaSbZjNskYvoBqT5WpWoIzvRvyrSFI0E4xqqBJdd/Jqd9LVZy4mKNaLL/upFre4itX6ZvcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428259; c=relaxed/simple;
	bh=34m2T8zjB+u4MLGHeKznxeFD6ttVQwhK+4XwYx0EGyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYjgOrpOz+hRG38cgGI0zgKbLa7KIzPuLv+q5fnbgm7e6DIQIC2Z26N5QJPnl52eUWoZ1Tpe2eNC/XNslS5219qjZ+/MVC490tss3l9ZMsTTP9ZXhVTSx1MmzlV1jg4O+CM3yVVRn8f5+bgr8fP3OwN721TTKp+uCSn4HiSm8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm2dlo+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm2dlo+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0479CC19424
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 18:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773428259;
	bh=34m2T8zjB+u4MLGHeKznxeFD6ttVQwhK+4XwYx0EGyM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qm2dlo+fBapnSg37oXr63vJhpeX7UtmcLGwzmE4FZ8iaaL7nLqRsc5zqRVsU/St9v
	 B3ltfdJEqM/EdZ6jDkan+KcUKAIF7icbF9ftnurPONFOZUumcQRlw7vIXxN419qTgZ
	 HuUOh5abZBFDnyT7j8teuo+EPei8Br4i2SG9kQoPg/FZe6vAkzqlJ5FJndsYgzwFt4
	 zfKw9WyvjgcbFv3HLErt8ASd8ES0WH48YiW0bCEW4J0GmzfWA85B9K6tmZ+QT/0TDu
	 Yv2zXjMDMc0YocnwRC2JnuZA6nQDJysI5QGbsbRMhat/BaQQLODeY4npBwTYKf5Sjg
	 olprJvVyoQDNw==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d7447778b9so1308732a34.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 11:57:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdgUAV8Fj4/9Ak5fyxjpPTCqS2gXRHGUUcQlomx2ZTbZAZDt25R9MSXPyhltdiBeJ8r6anScZVwNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OVbu8zZJVMfsjAy1IUB9JwrxgDn8y3bDExmQg2ugjbSl5Fnx
	TxAk/IBV1wMx5kcq7JgVsDArTYaEOio7AoKIFvI8FMdn2DpYLDswo3cD0HVZ0Kb7WpghponEplE
	EuBdXUXg1kBj9zJ+XrX5znnbVAZ/FLpA=
X-Received: by 2002:a05:6820:c93:b0:67b:bf52:9987 with SMTP id
 006d021491bc7-67bdaa63959mr2561459eaf.60.1773428257476; Fri, 13 Mar 2026
 11:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313-synology_microp_initial-v3-0-16941debd8a0@posteo.de> <20260313-synology_microp_initial-v3-3-16941debd8a0@posteo.de>
In-Reply-To: <20260313-synology_microp_initial-v3-3-16941debd8a0@posteo.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 19:57:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hYcSDKid4cbz8ZVZG+vLSHvzPB2UryevEpE15W1w7G3g@mail.gmail.com>
X-Gm-Features: AaiRm52wIYLXzpbrcPk1yGnN18zABaxFLxVozfWcNMKe7mZAiwm1YS4O-8Hh8h0
Message-ID: <CAJZ5v0hYcSDKid4cbz8ZVZG+vLSHvzPB2UryevEpE15W1w7G3g@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] acpi: add acpi_of_match_device_ids
To: Markus Probst <markus.probst@posteo.de>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 7:48=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> Add a function to match acpi devices against of_device_ids. This will be
> used in the following commit ("mfd: match acpi devices against PRP0001")
> to match mfd sub-devices against a of compatible string.

Not until I can see how this is going to be used.

Maybe never.

> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  drivers/acpi/bus.c      | 7 +++++++
>  include/acpi/acpi_bus.h | 2 ++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index f6707325f582..5ddcc56edc87 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1044,6 +1044,13 @@ int acpi_match_device_ids(struct acpi_device *devi=
ce,
>  }
>  EXPORT_SYMBOL(acpi_match_device_ids);
>
> +int acpi_of_match_device_ids(struct acpi_device *device,
> +                         const struct of_device_id *ids)
> +{
> +       return __acpi_match_device(device, NULL, ids, NULL, NULL) ? 0 : -=
ENOENT;
> +}
> +EXPORT_SYMBOL(acpi_of_match_device_ids);
> +
>  bool acpi_driver_match_device(struct device *dev,
>                               const struct device_driver *drv)
>  {
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index aad1a95e6863..0081b9e4aaee 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -677,6 +677,8 @@ void acpi_bus_trim(struct acpi_device *start);
>  acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
>  int acpi_match_device_ids(struct acpi_device *device,
>                           const struct acpi_device_id *ids);
> +int acpi_of_match_device_ids(struct acpi_device *device,
> +                         const struct of_device_id *ids);
>  void acpi_set_modalias(struct acpi_device *adev, const char *default_id,
>                        char *modalias, size_t len);
>
>
> --
> 2.52.0
>
>
