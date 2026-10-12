Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85153750D5
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815919; cv=none; b=i9pQRwvQHXXAT+obcs8Qr0u5omjI7EyHXlAb3h/+x168hFYQmDmupf22d6XBRgxpGRGmzTyEcze+vy9ULeRA7ffAKKSYJPSWyejbnhZoDysiabXJBy3+8QTlqM6m6OwcZX3ENPcfsVEBXDDWJmqSX/FZwpvUNt0zODO7AqgEcXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815919; c=relaxed/simple;
	bh=N1/l8Kla8P7IehtK8R0KBpqpGIIP3xRru5dPvuwTpUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsJ9ZLWfxvX0MH4i8HHjm3XeS/Nh8fKgyNBAX81BcarI8HkrXgyuWsF5dYi44PbPMGbW9D5lwd38aNO3cxjFr6+9fhEdvv4HkzlhobA86eAGMVpOmebw/Za7+QgJQaBh49fvvPXhw/bZiaf+oAP8hIQpeAOf4pxvLfiFtTdjrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3gB+sVL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3gB+sVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB551F008A0
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815918;
	bh=tuPxZXuGLU7wX3l3pKMP81CnZG4Db7ko04WR+gDObKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=N3gB+sVLglxV1K+/5Z+DJ9Fu2/7soPIUqCVSC80c0NMqo7I4PxDqAN8ajMtJd6j40
	 NUOA1MOAzQ3H6xPVJt5sW/t88+VtzyySuxAbui7MfKbYx9NpY+clMh9YaFoHC67zuu
	 B0bhgNTv/1RdvzWTN5fPFWGM3xdWVA8j+PoZZvTsmpMxnFGXw8q4k9cB2Z8VMSPwGr
	 Z2pjUa4bMLRkuvGYBx2lDmMA6pjY0mCGxw4tbhhy7ZRA9h+iG+Fr3S0nmZwgJjyfue
	 Sxh/ZbD/s8THBWmUeB7B9ueWUl1j9rI07wx0Cgnxn681isHmTYGnroXcOxuer2Lo+K
	 mi2RhUFqmuKfQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ba7ed32ccdso2346757e87.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 07:38:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByObYs5xw8vkvh8/kk2CBK3U0HCSNtfjrdMU3NagVndkR81H2elp4Dkr2LULCkihBQjZfqQdmn3ybs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL221lCeIjNi+dEn/o7rmt80UgxyJ05jF34gu/kqfLlEFfkv7oS
	VrQuUFUL6RBmKMWUmdvpPoiiegC8M0O7+1JAe7yzkDW7xkRpGlO4V8j1MikROQTOVm7uYi6uhEw
	gbhcAstgL0JprXEiGFnMLa/PQMJTT12k=
X-Received: by 2002:a05:6512:31ca:b0:5b8:efa9:b822 with SMTP id
 2adb3069b0e04-5bcde8d0c43mr3653296e87.52.1791815917004; Mon, 12 Oct 2026
 07:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007165840.1604136-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261007165840.1604136-4-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261007165840.1604136-4-sathyanarayanan.kuppuswamy@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 16:36:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gURgKAU9tvgMhy9KvUEKWLrPSUA5mCd4hs+9ZfrZsbnw@mail.gmail.com>
X-Gm-Features: AclHuK8WHhhyNVu1g8Iokcs3OmI2nvd96ZylRDnDO6gW49A3hr0YCq8qwXXEib8
Message-ID: <CAJZ5v0gURgKAU9tvgMhy9KvUEKWLrPSUA5mCd4hs+9ZfrZsbnw@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI/ACPI: Request DPC control only together with AER control
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 6:58=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER control
> when it requests DPC control.  calculate_control() requests DPC control
> whenever CONFIG_PCIE_DPC is enabled, even if it does not request AER
> control, e.g., with "pci=3Dnoaer" or when MSI is disabled.
>
> Request DPC control only if AER control is also requested.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/acpi/pci_root.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b0e0b33e3254..5c674d5b6bb8 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -516,8 +516,12 @@ static u32 calculate_control(void)
>          * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
>          * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
>          * and EDR.  EDR is always built with DPC on ACPI systems.
> +        *
> +        * PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER
> +        * control while requesting DPC control.
>          */
> -       if (IS_ENABLED(CONFIG_PCIE_DPC))
> +       if (IS_ENABLED(CONFIG_PCIE_DPC) &&
> +           (control & OSC_PCI_EXPRESS_AER_CONTROL))
>                 control |=3D OSC_PCI_EXPRESS_DPC_CONTROL;
>
>         return control;
> --
> 2.43.0
>
