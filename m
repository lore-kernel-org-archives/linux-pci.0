Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B483A1691
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374003; cv=none; b=LMLKYCBcNiAwTbWupK869snAsW3suAcjVC1EnrhMc41eA4+ICeXE5qDIvI32rjBUdPFZoWBftz7bKJoUJIF2rY4s3weFZ+EjtZX8Z+ADHZETSh8G7vbVoOZKwLiyTBMb5Fv5HkD4va9KFzQBAdcxXWBbHXe6DC2A1HSgoYBsols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374003; c=relaxed/simple;
	bh=sZ9R9A6EyluvGAUCUqlygxCnnXACQl62uyvQhMVFpEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=go/ZTVNQTXFPYUcR6WrAfcGy7AZB3NoiO9qzUocS2uC0oGu5i0b6HKdfjF+VlLuOaWQztCODxoPYS0kIzvXJUmBZNVK9tz82faNbKcHlv9ywhgvKbgUOijCoe6jCANMuwd5ujRDGWlcpm5kTDY6uPbmzuG92QGX5EVu4ucHXvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgSFwAvw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgSFwAvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5180AC2BC9E
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 17:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774374003;
	bh=sZ9R9A6EyluvGAUCUqlygxCnnXACQl62uyvQhMVFpEE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TgSFwAvwC7c0S6t29Y+Hbk/4xniNeHVNvn5ca2RnKwvoV9vzKxs8sg1syP4BsljaV
	 2+QwzQTrOhZ+odEmy1qCG+4HVIEN8A/epUNf6bXxsC29q+Dm7y0QSF1sopf5qYnRa8
	 jHiUE0VHWSivrWSww1XU7pwHI+PXkGKl0Lb5SbkxrSoRuj7dnUOj98Q+FAgrYVM53n
	 9iVBP6IoRXrd6kIw9g8jpvi03WIZISoyeg3++wSGg711xT76UQJRPu/Dae5evd05uh
	 5akGqdPcz5Yeufs2tL5r2oah7if6B7QUUAnWfUGyVey6RTCEPgGwXMDYoBWNtosGRq
	 9Qv3xehnocjGQ==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45f053b7b90so880606b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 10:40:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGmlDgb7kO4uhRftUOu+MKKQzgQaGqhrCYS+qr6UYZzpqPVAsIhZMZJLZf4sMkeQv90i295sk1SSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTMVcnfEAXZnMPQbRe4BcrbkPcFTdVj/6Q2hqQSStIUqy4+bM
	mJClIr+Y13ENdlARbZIESt45tULmTd/sXeNiDwcLPVsUJfdy9uQcX8D5m8DUKbXgZ3+jsoRyuRW
	O71SR5qCyaIY3MdVVRS9xyEkxeGJNoF0=
X-Received: by 2002:a05:6808:144e:b0:467:880:7454 with SMTP id
 5614622812f47-46a5c5a3227mr224727b6e.18.1774374002202; Tue, 24 Mar 2026
 10:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313-synology_microp_initial-v3-0-ad6ac463a201@posteo.de>
 <20260313-synology_microp_initial-v3-3-ad6ac463a201@posteo.de>
 <CAJZ5v0jxHO2EH5NeEsMkxGz5xqVL00tO-W1JpaVd=GhwgQ3T=A@mail.gmail.com>
 <e8ffc9902c0af24ce6fde2d8712ea588b36e9194.camel@posteo.de>
 <CAJZ5v0jHQ7sHJ8SV25p2gQugC-a8f9oVFarS17NXwPzGOJUD0Q@mail.gmail.com> <f32aba79b98b357487c44e1952e536051fcd7a51.camel@posteo.de>
In-Reply-To: <f32aba79b98b357487c44e1952e536051fcd7a51.camel@posteo.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Mar 2026 18:39:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0guwtAepn2eS_fGik6iCEYWn3vt2s5oAGnnL_u62-YbpQ@mail.gmail.com>
X-Gm-Features: AQROBzBgz9X_18TNZxhGoIzxIF6ZRQ4p9BklVyTGwPgiiSXx52mPCcekAjItT7o
Message-ID: <CAJZ5v0guwtAepn2eS_fGik6iCEYWn3vt2s5oAGnnL_u62-YbpQ@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 5:26=E2=80=AFPM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> On Tue, 2026-03-24 at 17:01 +0100, Rafael J. Wysocki wrote:
> > On Tue, Mar 24, 2026 at 4:30=E2=80=AFPM Markus Probst <markus.probst@po=
steo.de> wrote:
> > >
> > > On Mon, 2026-03-23 at 20:57 +0100, Rafael J. Wysocki wrote:
> > > > On Fri, Mar 13, 2026 at 8:03=E2=80=AFPM Markus Probst via B4 Relay
> > > > <devnull+markus.probst.posteo.de@kernel.org> wrote:
> > > > >
> > > > > From: Markus Probst <markus.probst@posteo.de>
> > > > >
> > > > > Add a function to match acpi devices against of_device_ids. This =
will be
> > > > > used in the following commit ("mfd: match acpi devices against PR=
P0001")
> > > > > to match mfd sub-devices against a of compatible string.
> > > >
> > > > Please always spell ACPI in capitals in patch subjects, comments,
> > > > changelogs, etc.  It is not a regular word.
> > > Ok.
> > > >
> > > > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > > > ---
> > > > >  drivers/acpi/bus.c      | 7 +++++++
> > > > >  include/acpi/acpi_bus.h | 2 ++
> > > > >  2 files changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > > > index f6707325f582..5ddcc56edc87 100644
> > > > > --- a/drivers/acpi/bus.c
> > > > > +++ b/drivers/acpi/bus.c
> > > > > @@ -1044,6 +1044,13 @@ int acpi_match_device_ids(struct acpi_devi=
ce *device,
> > > > >  }
> > > > >  EXPORT_SYMBOL(acpi_match_device_ids);
> > > > >
> > > >
> > > > Missing kerneldoc.
> > > The same amount of kerneldoc as `acpi_match_device_ids`, if I am not
> > > mistaken.
> > > >
> > > > > +int acpi_of_match_device_ids(struct acpi_device *device,
> > > > > +                         const struct of_device_id *ids)
> > > > > +{
> > > > > +       return __acpi_match_device(device, NULL, ids, NULL, NULL)=
 ? 0 : -ENOENT;
> > > > > +}
> > > > > +EXPORT_SYMBOL(acpi_of_match_device_ids);
> > > >
> > > > Are you aware of the consensus that using PRP0001 in production
> > > > platform firmware will be regarded as invalid?
> > > >
> > > > Because of that, it is not an option for a driver to avoid providin=
g
> > > > ACPI match data on a platform that uses ACPI.
> > > First of all, the driver that would have made use of it has been
> > > restructed to not use mfd subdevices. It would not be affected anymor=
e
> > > through this patch set.
> >
> > So what exactly would be affected by it?
> I won't have a use for myself anymore, but I still think the patch is
> useful. Anyway,
>
> MFD Devices without an assigned ACPI ID, if they are present on devices
> with ACPI platform firmware.
>
> >
> > > Not sure if I should still send it as its own patch series though.
> That is why I asked this question (see 1. sentence in the paragraph
> above).
>
> > >
> > > The device of the driver has no ACPI ID allocated by the manufacturer=
,
> > > as it is only used on a proprietary Linux OS (with their own modified
> > > kernel).
> >
> > Do I understand correctly that there is an ACPI platform firmware on
> > the board, but it doesn't enumerate the given device properly (that
> > is, as an ACPI device object with a specific device ID)?
> There is only a serial device in the ACPI platform firmware.
> The device connected to the bus isn't specified.
> >
> > In which case there probably is a driver that can find that device
> > somehow (it has hardcoded resources or similar).
> Yes, that driver has `filp_open("/dev/ttyS1")` hardcoded.
> >
> > > The driver would have only been useful via device tree or an ACPI
> > > Overlay.
> >
> > Do you mean a custom SSDT loaded via configfs or something else?
> Yes, in my case via initrd.
>
> >
> > > Obviously, I don't have a PNP or ACPI Vendor ID, so I can't
> > > assign one. The parent/main driver does only have a of compatible id.
> > > As it needs to use PRP0001 anyway on ACPI, I thought it makes more
> > > sense to also use PRP0001 there instead of matching it with a _ADR
> > > which is "a grey area in the ACPI specification".
> >
> > You can't match a device with _ADR.  By itself, _ADR doesn't provide
> > you with any information on the device in question, it only helps to
> > connect it to some information that can be collected by other means.
> > The role of it, at least in principle, is to allow some device objects
> > in the ACPI hierarchy to be associated with devices enumerated by
> > other means (like on a PCI bus).
>
> This patch affects mfd devices. A bus device can via mfd register child
> devices and those child devices will be matched to a fwnode if
> available.

That only works because the parent can be recognized and properly
enumerated, so it is parent-relative.

> According to commit 98a3be44ffa67b812de7aa7aed9f2331edcfb1a5, there is
> a board on the market with a sub-device that will be matched using _ADR
> [1].

With the help of a quirk though.

> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D98a3be44ffa67b812de7aa7aed9f2331edcfb1a5
>
> >
> > The enumeration with the help of PRP0001 only works if there is a
> > device object in the ACPI hierarchy and its _HID is PRP0001 or its
> > _CID list contains PRP0001, there is a _DSD under it and a
> > "compatible" property is returned by that _DSD.  Who's going to
> > provide all of that for the given device?
> A ACPI Overlay would do that.
>
> >
> > Moreover, if the device has some resources that the kernel needs to
> > know about, there should be a _CRS under the device object in question
> > and the resources should be listed there.  Or how are the resources
> > going to be found otherwise?
> Resources in mfd are usually handled by the parent device, not the mfd
> child device. But yes, it would be using _CRS if any.

So this is kind of a valid use case, but since you don't need it any
more, I'd rather not put it in without a clear need.

Also, it's not a huge deal for a vendor to allocate a proper ACPI
device ID for a piece of hardware.  It just involves some due
diligence.
