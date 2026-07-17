Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F27D3D5C0C
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305368; cv=none; b=DPeKpRbncjLHYwnEDQZqk3hCXAOIQG5n4Cf1kUiWV/qKYYPoNd1faDzqZn7Sau3YSNAN+hXK1gdiaJN2qr0oSToSFIxvZuMZx8kpFAOYeO4RYCLyaA+HBoZECBhI4wJOekwu6xjxQHvBR7XqYBrfKP5PdVnSu1FxDL95Gvm7zqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305368; c=relaxed/simple;
	bh=NAKVWwlDO1sFC/fxnjYkMStdwKP08+Eb6vtCDvcSof0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOAeztPOfMo0XSRMQvrq0rfEji13oYN08Tt+3nFlsk1djmnsKW95xIXZ7v8AJr9kETtv1zVAi2SlpbcjScHwhWzn40V12nAW1SKeKkBW2t71KNc5HnQJ985B3xgxUeyUC5ZiNCrwxp+O5OvAAvvjRIkFgTqJo0a+aDVVX4EJsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUa4Jyh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUa4Jyh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4211F00A3F
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784305367;
	bh=v0hx4zLejONlwZJpz5qHgW1yIcYV5ASB31+Juks8V/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CUa4Jyh0cF6I3eXXBF36dWtqhOBc0WSoYEk+Fxr7ONZIqygWwXsXHUW41DT7P8QhP
	 JfL78zb3PbfZima0n9Y2PdNaeNEzjQXcITxAtYeST+rWy50pcK27WRzKoG07lkRdQm
	 Cs/xCF4nKgqeSQzB42RqfWBNoGwSIBmI6It4ZgxaYfnjO5ou6wuTXdQEnVT1J36Kzn
	 dKaJ7ESu9T6vHpHqQpYy1ydghikUZHc6IWx9ts5ETDlpiUB0uW8c43MLunfTvx70oi
	 DXxNGLvak5xf2LD/R81Rxtc1yJpYfhs189CR5oITUeoUrYx+jEjF/mRRMGSm/IacV6
	 oRAvgXa6Hpv9A==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c7ce122c7so72666741fa.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 09:22:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqD7y9y/KNCxn2pCbdSkaMONSxRT+zKucuuUQYlGFaby+SeyIXZviazUi2ZoDjntxc0H3roLZwEJDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YynzrVa1NhwvWq/KUFGIkr2y0+h5aIOP2B4cjoTSl7dZCgjr2/i
	P9IvWZ5QpH85fRJ5N1TUUYZ5yPKQrKg4r7b093pAS7XEwLadvefA2ZeBp8DYQXA1dYaBglh82nj
	y+8KKJ+/501r6k6BmfQo4yO75Q5CCDr8=
X-Received: by 2002:ac2:430d:0:b0:5aa:6c98:a090 with SMTP id
 2adb3069b0e04-5b28f9ba488mr581232e87.34.1784305365522; Fri, 17 Jul 2026
 09:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0be949d-0e21-472e-a44b-cedb1dd8695d@nec.com>
In-Reply-To: <d0be949d-0e21-472e-a44b-cedb1dd8695d@nec.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 17 Jul 2026 18:22:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iacu-FW04zgTO5WDvjB4BgRvfhE9hsGskgOLGHrNwUSg@mail.gmail.com>
X-Gm-Features: AUfX_mwX8nl7i4ecRRIHDY5L7n2CeDE5D3wIZWyq7DWfU0QBeRq-QtUZwBcK39o
Message-ID: <CAJZ5v0iacu-FW04zgTO5WDvjB4BgRvfhE9hsGskgOLGHrNwUSg@mail.gmail.com>
Subject: Re: [REGRESSION] ACPI: PCI: misleading _OSC failure message when _OSC
 is absent
To: =?UTF-8?B?S09ORE8gS0FaVU1BKOi/keiXpCDlkoznnJ8p?= <kazuma-kondo@nec.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, 
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 17, 2026 at 2:01=E2=80=AFPM KONDO KAZUMA(=E8=BF=91=E8=97=A4=E3=
=80=80=E5=92=8C=E7=9C=9F)
<kazuma-kondo@nec.com> wrote:
>
> Hello,
>
> After 7d703df7f4f5 ("ACPI: bus: Split _OSC evaluation out of acpi_run_osc=
()"),
> AE_NOT_FOUND from acpi_evaluate_object() is handled as AE_ERROR in
> negotiate_os_control().
>
> I haven't yet observed any functional issue with this change,
> but I started seeing the following misleading messages on my Intel server=
s:
>
>     kernel: ACPI: Enabled 2 GPEs in block 00 to 7F
>     kernel: ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus fe])
>     kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM Clock=
PM Segments MSI EDR HPX-Type3]
>   + kernel: acpi PNP0A03:00: _OSC: OS requested [PCIeHotplug SHPCHotplug =
PME AER PCIeCapability LTR DPC]
>   + kernel: acpi PNP0A03:00: _OSC: platform willing to grant [PCIeHotplug=
 SHPCHotplug PME AER PCIeCapability LTR DPC]
>   + kernel: acpi PNP0A03:00: _OSC: platform retains control of PCIe featu=
res (AE_ERROR)
>     kernel: PCI host bridge to bus 0000:fe
>
> Before the commit, the log was:
>
>     kernel: ACPI: Enabled 2 GPEs in block 00 to 7F
>     kernel: ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus fe])
>     kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM Clock=
PM Segments MSI EDR HPX-Type3]
>     kernel: PCI host bridge to bus 0000:fe
>
> "UNC0" is an uncore root bridge and does not define an _OSC method in the=
 ACPI
> namespace on my systems.
>
> Previously, when acpi_evaluate_object() was called for UNC0._OSC, it retu=
rned
> AE_NOT_FOUND, and that status was propagated to negotiate_os_control().
>
> Now, it appears that acpi_eval_osc()/acpi_run_osc() no longer preserve th=
e
> distinction between AE_NOT_FOUND and other errors from acpi_evaluate_obje=
ct(),
> so negotiate_os_control() no longer receives AE_NOT_FOUND in this case.
>
> The call chain looks like this on my system:
>
> negotiate_os_control()
>   acpi_pci_osc_control_set()       [retval =3D AE_ERROR    ]
>     acpi_pci_query_osc ()          [retval =3D AE_ERROR    ]
>       acpi_pci_run_osc()           [retval =3D AE_ERROR    ]
>         acpi_run_osc()             [retval =3D AE_ERROR    ]
>           acpi_eval_osc()          [retval =3D -ENODATA    ]
>             acpi_evaluate_object() [retval =3D AE_NOT_FOUND]
>
> As a result, negotiate_os_control() logs messages as if the OS had negoti=
ated
> with the platform via _OSC, even though _OSC is absent and no such negoti=
ation
> actually happens.

Fortunately though this only affects the printing of messages and only
in the non-PCIe case.

> I'm not very familiar with the ACPI/PCI code, so I may be missing some
> context. However, if my understanding is correct, would preserving
> AE_NOT_FOUND here (for example, having acpi_eval_osc()/acpi_run_osc() ret=
urn
> the error as-is) be the right direction, or should the message handling b=
e
> adjusted instead?
>
> If there is a preferred direction for fixing this, I would be happy to tr=
y
> putting together a patch and testing it on my system.

I cannot send you a proper patch ATM (sorry about that), but please
try to replace the

(status =3D=3D AE_NOT_FOUND && !is_pcie(root))

check in negotiate_os_control() with the following one:

(!is_pcie(root) && !acpi_has_method(handle, "_OSC"))

and see if that helps.

Thanks!
