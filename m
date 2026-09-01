Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361942B74B
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280770; cv=none; b=dZb6sV4b+WvgUArt8LXQZs/gMQYqkcohUKnL3Ug2cOqsX/tGg7pshQ37FgoI6w5Y6rUOk70Jt2/Ixi1UG+i74VxxOfoiV2w7B6WTmuW82K8RBgig9BcwTJvgQJbIGt2+PlpKsP4i0GjsybgAofiPqaPPOPjiJ/wb6DK09e9NmnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280770; c=relaxed/simple;
	bh=0NEfzfUB+ZqrHij1mWOR7AL+g8F9vIr9nkY/YB5j4+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWy3RAF1knPcjmi5hEpdWf4DJRbYpDR4HKm0nbmNO6HoPMiR0nLUVIAUT1kEOYIbPqpmbmlEUplof+gqxzi7uZIJKFuPS4EAehnmBWSklbtwM0vUZh8tbQGfbAjD8ltWEOHpIxPKwbUO2ImaExGlxglyk4fgfrqFmBiAdvnvdPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4em78dj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4em78dj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2061F0155A
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788280769;
	bh=zYZWQQlSNPwAB++mf/7m1KlqrsLe3oiccISkKgMQZWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=H4em78djhPjvXkLTnF1CayiHiwNL2Mjk/l74sVKz4bsTYZ5Q/1KlHXkV1U40zpoq/
	 MK/JQV81mQ/F3slX/9HqhG7tJzNDkXTRO9Qc1KKLeqi8pTKL1SIoFyaf0q06tVL5es
	 3vW/WjmBwERfhGPttygyHWRf140jMzblR8IIeXGgQSQtUY0+xgI354WvycumWaNCUv
	 hr+RpioSCx0peEtJ03qbizfRTueoAneeFCKYo8dcUay7pIZSdLCi/9CTDQsrSBRUmK
	 kfAKn0vR8OF0aegiUfzAQJN64XMGTGdH0OghPy8nExHkK7jDaxvxp4mFY6/a29N2Io
	 pV7uqhDJEtR8w==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39faa67fabaso52141fa.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 09:39:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz/18SG1PlqYtZC16yAp4wNueNJs8p0S7Rmb5UhoSdl4QNQ66QbyJogNHstohaBKoR58o/KSx+Kb3c=@vger.kernel.org
X-Gm-Message-State: AFuF++keZ1Smi+viGXe/JGpo6qUP1oQoSgH6FDafomIiwa6VZl0sdStN
	49Gzhf8Zxp905NjPOX9FUnf8vuOxgbax+9rafc2Pd+qNMITsIrWgYDkwuXs76yfpJ6lXA5C0/Yz
	OKmA6Mdoh93M2OyMW8lQY5nSuuRPLkVI=
X-Received: by 2002:a2e:bd02:0:b0:3a1:5172:c287 with SMTP id
 38308e7fff4ca-3a301b13f39mr75798781fa.5.1788280767540; Tue, 01 Sep 2026
 09:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3435655.aeNJFYEL58@rafael.j.wysocki> <2055986.PYKUYFuaPT@rafael.j.wysocki>
 <apaM8fsWKaGPRWxD@ashevche-desk.local>
In-Reply-To: <apaM8fsWKaGPRWxD@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 1 Sep 2026 18:38:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iJ6Vu4+ZmZP+OLWX6WbfZkiU6uueV9qrPmjKquBmkdRQ@mail.gmail.com>
X-Gm-Features: AcwNN1WA-9io61CEESmaZsUYyu4XHnBg8_WaY9WSV9BLOydO-vhTp737jJs8EWA
Message-ID: <CAJZ5v0iJ6Vu4+ZmZP+OLWX6WbfZkiU6uueV9qrPmjKquBmkdRQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] ACPI: PM: Introduce acpi_device_init_power()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Peixin Xie <peixin.xie@linux.spacemit.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 10:29=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 31, 2026 at 06:25:52PM +0200, Rafael J. Wysocki wrote:
>
> > Two out of three callers of acpi_bus_init_power() need to clear
> > flags.power_manageable for the target device on errors, which
> > is somewhat cumbersome, so rename the function to
> > __acpi_device_init_power(), add a wrapper called
> > acpi_device_init_power() around it that will take care
> > of the flags.power_manageable clearing, and make the two
> > callers of acpi_bus_init_power() in question invoke that
> > wrapper.
> >
> > While at it, clean up the declaration of local variables
> > in __acpi_device_init_power().
>
> ...
>
> >  {
> > -     int state;
> > -     int result;
> > +     int result, state;
>
> Not sure if this change is required.

Nope, but I think that it's useful.

> >       result =3D acpi_device_get_power(device, &state);
> >       if (result)
>
> ...
>
> > +int acpi_device_init_power(struct acpi_device *device)
>
> Ah, here is a helper!

Yeah, I guess it's better to fold it into the first patch.

> > +{
> > +     int ret;
>
> Elsewhere in the file it's called 'result'.

Yes, it is.

So I guess you're suggesting to also use that name here, which is fair enou=
gh.

> > +
> > +     ret =3D __acpi_device_init_power(device);
> > +     if (ret)
> > +             device->flags.power_manageable =3D 0;
> > +
> > +     return ret;
> > +}
