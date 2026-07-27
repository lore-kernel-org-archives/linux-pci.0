Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF43FBEAF
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154233; cv=none; b=uR0tVG2s1fsrlHPzFCEg1r8XKzBsIfLg+OxXPB1iYWPXEu8tgEAI38/w7nfZ32bh6DqBA7QJOJlaqn+zjROkzF5/vz8IdvIHGZ7SGjHpviBjY/pRijzA3mNy6s4OAGI12w9iN07OVHlwle5Si3uhLTuOP6/lajwWzV/UH0r4JMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154233; c=relaxed/simple;
	bh=AxWBmt7HYNFpujBnQhtQJvcCKraELIFeYSYo+bJ9KIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EK5BTr7eqNGDaKxq68u4Nm/6ml3aBJpkfgtaMXKa/+RkwGtxnex1TeWv7vU/jgxhJCJGHmJ131PER9FTRfFTa63y4UGoYcXcYPqO7G04lZEwwulyPcJ3qMb8j41FF9ZF41gxVBy+DEPbKFdEsdNslxZ2kDG0riJ72PKEcfEzKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYj3Dhu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYj3Dhu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECAD1F00AC4
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 12:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785154231;
	bh=JhYIp1CKigvj4CYO+OIWNTACrKJgXXmqeayTYKrnS5E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LYj3Dhu/YIrO7Dv9JxqpjxBbxIjNXtO2rTnkHrCIuHFdG1lFJm5DvTVCWCp2n1FE0
	 PbfGllkZuOFdCuAyNKF2tecRbqDWe5hz1FNUCu5mFsBbvSMVI5UJmptBBvVy+XP9qc
	 0tvRBvEePPyJycO/H4Hec2ECRSK2vWDz2bBUs0dFyY2ibDk/Mn7H42X56fDczp/8bo
	 XQuOOt38Nz/QakUGm6Eo5RH8QbvG8mUGwupgxIrcyjvq+Y8bBKEsWn5rxpOfM+I366
	 ZPSSzw+6/1njrlSjmigNpfCDPbflRM282xWcbI5e4kgTNK60bFzmPNVOptswSnb9Vd
	 cAWtD9Ry+eUeQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c9452244aso25251341fa.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 05:10:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RolgvE3pUFFKteCSEdmWHDiA4iH1FT4UYu+OqxsgP7cWoLrVlpTV0dcOltnWVyB8AmvJFfqw0t7oME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9aV7xx0nyblIx6Oow0CafCK47ueu5w3Z8GhF0P8R7ShToN0a+
	IBQlqcYbSa/V+Y13NnVeadKOkBv5vqK1m0xCos602I3iL4bUkPVsQL+707XdLomt0VJ3ygM+Gvt
	Ieh9d6Z6hpyGMQZRAsg0DDwlx8gRK0vI=
X-Received: by 2002:a05:6512:3b8f:b0:5b2:a24a:e4f9 with SMTP id
 2adb3069b0e04-5b2c1b2ed8cmr1677929e87.40.1785154229841; Mon, 27 Jul 2026
 05:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0be949d-0e21-472e-a44b-cedb1dd8695d@nec.com> <CAJZ5v0iacu-FW04zgTO5WDvjB4BgRvfhE9hsGskgOLGHrNwUSg@mail.gmail.com>
 <03e9f950-4791-4c77-a961-204398255adb@nec.com>
In-Reply-To: <03e9f950-4791-4c77-a961-204398255adb@nec.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 27 Jul 2026 14:10:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hEdnMSWbZ9xwNPxOw4iPaCqOquSQcRHQoiQqULDdJDhg@mail.gmail.com>
X-Gm-Features: AUfX_mxXCZdwn2tjftj1XMuKIbDYmkAHaIJPuhvBpFImSQ0x9DKmrPZikp-3OAE
Message-ID: <CAJZ5v0hEdnMSWbZ9xwNPxOw4iPaCqOquSQcRHQoiQqULDdJDhg@mail.gmail.com>
Subject: Re: [REGRESSION] ACPI: PCI: misleading _OSC failure message when _OSC
 is absent
To: =?UTF-8?B?S09ORE8gS0FaVU1BKOi/keiXpCDlkoznnJ8p?= <kazuma-kondo@nec.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, 
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:15=E2=80=AFPM KONDO KAZUMA(=E8=BF=91=E8=97=A4=E3=
=80=80=E5=92=8C=E7=9C=9F)
<kazuma-kondo@nec.com> wrote:
>
> Hello,
>
> On 2026/07/18 1:22, Rafael J. Wysocki (Intel) wrote:
> > Hi,
> >
> > On Fri, Jul 17, 2026 at 2:01=E2=80=AFPM KONDO KAZUMA(=E8=BF=91=E8=97=A4=
=E3=80=80=E5=92=8C=E7=9C=9F)
> > <kazuma-kondo@nec.com> wrote:
> >>
> >> Hello,
> >>
> >> After 7d703df7f4f5 ("ACPI: bus: Split _OSC evaluation out of acpi_run_=
osc()"),
> >> AE_NOT_FOUND from acpi_evaluate_object() is handled as AE_ERROR in
> >> negotiate_os_control().
> >>
> >> I haven't yet observed any functional issue with this change,
> >> but I started seeing the following misleading messages on my Intel ser=
vers:
> >>
> >>     kernel: ACPI: Enabled 2 GPEs in block 00 to 7F
> >>     kernel: ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus fe])
> >>     kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI EDR HPX-Type3]
> >>   + kernel: acpi PNP0A03:00: _OSC: OS requested [PCIeHotplug SHPCHotpl=
ug PME AER PCIeCapability LTR DPC]
> >>   + kernel: acpi PNP0A03:00: _OSC: platform willing to grant [PCIeHotp=
lug SHPCHotplug PME AER PCIeCapability LTR DPC]
> >>   + kernel: acpi PNP0A03:00: _OSC: platform retains control of PCIe fe=
atures (AE_ERROR)
> >>     kernel: PCI host bridge to bus 0000:fe
> >>
> >> Before the commit, the log was:
> >>
> >>     kernel: ACPI: Enabled 2 GPEs in block 00 to 7F
> >>     kernel: ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus fe])
> >>     kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI EDR HPX-Type3]
> >>     kernel: PCI host bridge to bus 0000:fe
> >>
> >> "UNC0" is an uncore root bridge and does not define an _OSC method in =
the ACPI
> >> namespace on my systems.
> >>
> >> Previously, when acpi_evaluate_object() was called for UNC0._OSC, it r=
eturned
> >> AE_NOT_FOUND, and that status was propagated to negotiate_os_control()=
.
> >>
> >> Now, it appears that acpi_eval_osc()/acpi_run_osc() no longer preserve=
 the
> >> distinction between AE_NOT_FOUND and other errors from acpi_evaluate_o=
bject(),
> >> so negotiate_os_control() no longer receives AE_NOT_FOUND in this case=
.
> >>
> >> The call chain looks like this on my system:
> >>
> >> negotiate_os_control()
> >>   acpi_pci_osc_control_set()       [retval =3D AE_ERROR    ]
> >>     acpi_pci_query_osc ()          [retval =3D AE_ERROR    ]
> >>       acpi_pci_run_osc()           [retval =3D AE_ERROR    ]
> >>         acpi_run_osc()             [retval =3D AE_ERROR    ]
> >>           acpi_eval_osc()          [retval =3D -ENODATA    ]
> >>             acpi_evaluate_object() [retval =3D AE_NOT_FOUND]
> >>
> >> As a result, negotiate_os_control() logs messages as if the OS had neg=
otiated
> >> with the platform via _OSC, even though _OSC is absent and no such neg=
otiation
> >> actually happens.
> >
> > Fortunately though this only affects the printing of messages and only
> > in the non-PCIe case.
> >
> >> I'm not very familiar with the ACPI/PCI code, so I may be missing some
> >> context. However, if my understanding is correct, would preserving
> >> AE_NOT_FOUND here (for example, having acpi_eval_osc()/acpi_run_osc() =
return
> >> the error as-is) be the right direction, or should the message handlin=
g be
> >> adjusted instead?
> >>
> >> If there is a preferred direction for fixing this, I would be happy to=
 try
> >> putting together a patch and testing it on my system.
> >
> > I cannot send you a proper patch ATM (sorry about that), but please
> > try to replace the
> >
> > (status =3D=3D AE_NOT_FOUND && !is_pcie(root))
> >
> > check in negotiate_os_control() with the following one:
> >
> > (!is_pcie(root) && !acpi_has_method(handle, "_OSC"))
> >
> > and see if that helps.
>
> Sorry for the late reply.
>
> With the change you suggested, the failure message no longer appears.
> If that's okay with you, I'd like to submit it as a patch.

I think that it'd be better to do this check earlier, even at the
beginning of negotiate_os_control(), because it is pointless to
prepare for evaluating _OSC if it is not present.

So I would add

if (!is_pcie(root) && !acpi_has_method(handle, "_OSC")) {
        print a diagnostic message;
        return;
}

to negotiate_os_control() after the x86_apple_machine check and remove
the (status =3D=3D AE_NOT_FOUND && !is_pcie(root)) check that would become
redundant then.

Feel free to send a patch doing so.

Thanks!
