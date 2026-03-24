Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47438F929
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368093; cv=none; b=FQgZOFaVDlV+Zy5HsG9FojAd5EQAvbdwH4Z8DTUpGbbqeniKKV4Ze9RK8Bdghc0BLFCtw2HtZMtdwhHm5xEcGCw1CrtXyaN3et7pPigAoh3RvYWpTLJUt9VNEILV5sOENrlMT/QByDJyyP1zKW9iVmJY6rzUDgWpSDoAVLmN7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368093; c=relaxed/simple;
	bh=MOGi0JV4ZNfOjsgGZ/ADIOJMY48no6lV8jCg7ewXSzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gacMICg3evgOGGhlSXjKrlSQvsIcfKdJcozeOCw+NSc9ZJHSe+7M5KWmpPLYh3azNcqy1fA2zpx4U+Zbf8STCiZeqAI2VIQ7vl91hKv3kc3q9dISonLnPHlyRGdqoxDv/DBMhYJGjMiN1MzWZ/YsAMXWcsloxFyTT56jc0HbEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVB21Fo+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVB21Fo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A2BC2BCB3
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 16:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774368092;
	bh=MOGi0JV4ZNfOjsgGZ/ADIOJMY48no6lV8jCg7ewXSzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WVB21Fo+O7Zs4Oyj5si2An9Ps3ebguksgeeeAwqr5CdHTpYmG5KtIl0L1kUJHClLe
	 A1Jg/FHuxnUb61zK7vHr8QFMmvLHdz8DzSAxDTPu8UnQj0lydb86oEfUlxY0vw6vB6
	 XlsE/twIe/x3aABUmcoiSjeFY9Wqq0fIySzwiDF1UBtyj40VZljwFVkGrEJa39xk4C
	 Ic3BcECZC0rbSZtKBilR1TX6m8RFstHQhT9usYUKDIAxnRSAxLE7SVnCK310fbch14
	 xbQSV8BVCugqunqe9XCJvojwkCSe0w2NPzP3g8UJzqYcVQyMY7P0o2CO/jhNUpCR0Q
	 YU080OQi7cxkg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4042905015cso2256854fac.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 09:01:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdpBtsGdBSnTChOM1JA+shEor2vRfmo3BCsUNus2at99YqmLJrPFAP4TvxVHJg3PSYMJByxpGTDHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJ+1xjjn9h3jkTd/zZSkedYOa+FQsK+3kJAH2aH+tNk/DNLb3
	p6BkLOghrG6YR/LkrMk0CreFL0JDjDCBG2U4fLhLdD0gGbZj0wDTjTgaB461bIvxGGZzslKegWj
	F7r8Kjr29F+0HGy03etuGgfTj1m+++Ag=
X-Received: by 2002:a05:6870:40ca:b0:41c:5ea1:b4e with SMTP id
 586e51a60fabf-41ca6bd33camr136194fac.0.1774368091372; Tue, 24 Mar 2026
 09:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313-synology_microp_initial-v3-0-ad6ac463a201@posteo.de>
 <20260313-synology_microp_initial-v3-3-ad6ac463a201@posteo.de>
 <CAJZ5v0jxHO2EH5NeEsMkxGz5xqVL00tO-W1JpaVd=GhwgQ3T=A@mail.gmail.com> <e8ffc9902c0af24ce6fde2d8712ea588b36e9194.camel@posteo.de>
In-Reply-To: <e8ffc9902c0af24ce6fde2d8712ea588b36e9194.camel@posteo.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Mar 2026 17:01:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jHQ7sHJ8SV25p2gQugC-a8f9oVFarS17NXwPzGOJUD0Q@mail.gmail.com>
X-Gm-Features: AQROBzDv-gLIyLVlaLI4MGuXPvB1psB6PmnWZDRsERdSTCHkDpp6XRnBMFQQ9_4
Message-ID: <CAJZ5v0jHQ7sHJ8SV25p2gQugC-a8f9oVFarS17NXwPzGOJUD0Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] acpi: add acpi_of_match_device_ids
To: Markus Probst <markus.probst@posteo.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Igor Korotin <igor.korotin.linux@gmail.com>, 
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

On Tue, Mar 24, 2026 at 4:30=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> On Mon, 2026-03-23 at 20:57 +0100, Rafael J. Wysocki wrote:
> > On Fri, Mar 13, 2026 at 8:03=E2=80=AFPM Markus Probst via B4 Relay
> > <devnull+markus.probst.posteo.de@kernel.org> wrote:
> > >
> > > From: Markus Probst <markus.probst@posteo.de>
> > >
> > > Add a function to match acpi devices against of_device_ids. This will=
 be
> > > used in the following commit ("mfd: match acpi devices against PRP000=
1")
> > > to match mfd sub-devices against a of compatible string.
> >
> > Please always spell ACPI in capitals in patch subjects, comments,
> > changelogs, etc.  It is not a regular word.
> Ok.
> >
> > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > ---
> > >  drivers/acpi/bus.c      | 7 +++++++
> > >  include/acpi/acpi_bus.h | 2 ++
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > index f6707325f582..5ddcc56edc87 100644
> > > --- a/drivers/acpi/bus.c
> > > +++ b/drivers/acpi/bus.c
> > > @@ -1044,6 +1044,13 @@ int acpi_match_device_ids(struct acpi_device *=
device,
> > >  }
> > >  EXPORT_SYMBOL(acpi_match_device_ids);
> > >
> >
> > Missing kerneldoc.
> The same amount of kerneldoc as `acpi_match_device_ids`, if I am not
> mistaken.
> >
> > > +int acpi_of_match_device_ids(struct acpi_device *device,
> > > +                         const struct of_device_id *ids)
> > > +{
> > > +       return __acpi_match_device(device, NULL, ids, NULL, NULL) ? 0=
 : -ENOENT;
> > > +}
> > > +EXPORT_SYMBOL(acpi_of_match_device_ids);
> >
> > Are you aware of the consensus that using PRP0001 in production
> > platform firmware will be regarded as invalid?
> >
> > Because of that, it is not an option for a driver to avoid providing
> > ACPI match data on a platform that uses ACPI.
> First of all, the driver that would have made use of it has been
> restructed to not use mfd subdevices. It would not be affected anymore
> through this patch set.

So what exactly would be affected by it?

> Not sure if I should still send it as its own patch series though.
>
> The device of the driver has no ACPI ID allocated by the manufacturer,
> as it is only used on a proprietary Linux OS (with their own modified
> kernel).

Do I understand correctly that there is an ACPI platform firmware on
the board, but it doesn't enumerate the given device properly (that
is, as an ACPI device object with a specific device ID)?

In which case there probably is a driver that can find that device
somehow (it has hardcoded resources or similar).

> The driver would have only been useful via device tree or an ACPI
> Overlay.

Do you mean a custom SSDT loaded via configfs or something else?

> Obviously, I don't have a PNP or ACPI Vendor ID, so I can't
> assign one. The parent/main driver does only have a of compatible id.
> As it needs to use PRP0001 anyway on ACPI, I thought it makes more
> sense to also use PRP0001 there instead of matching it with a _ADR
> which is "a grey area in the ACPI specification".

You can't match a device with _ADR.  By itself, _ADR doesn't provide
you with any information on the device in question, it only helps to
connect it to some information that can be collected by other means.
The role of it, at least in principle, is to allow some device objects
in the ACPI hierarchy to be associated with devices enumerated by
other means (like on a PCI bus).

The enumeration with the help of PRP0001 only works if there is a
device object in the ACPI hierarchy and its _HID is PRP0001 or its
_CID list contains PRP0001, there is a _DSD under it and a
"compatible" property is returned by that _DSD.  Who's going to
provide all of that for the given device?

Moreover, if the device has some resources that the kernel needs to
know about, there should be a _CRS under the device object in question
and the resources should be listed there.  Or how are the resources
going to be found otherwise?
