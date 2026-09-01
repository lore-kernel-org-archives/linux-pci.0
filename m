Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B66379989
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788289948; cv=none; b=PcN+TSMbyG/aDvx77R2uyvZWVhiTBtR5NKQmj4VJGpCMLJ1rzqr3QwwlXUGg8j7d6yFYMQI7BAjBopRpTbvXtCLAKMS9L5ASlSq1LkdxGYIN4DU+ZNQmpc3sLEnyYfgo3ssfD3iBu2YbuAPK7UXUDMdDZCoUNwDx+cI+mW1j7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788289948; c=relaxed/simple;
	bh=nhisCh+ihwHTyvRNLjNIpcqJgcEdj09IgLhKNEbJRh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTJOaWtrCHbFuY1DJGhxZT/xP4qUEvkYUyuEx14wqpc2MOJ4+cx4TQ9Gn6rQqideZGdZ4kMiCI2fNEth0ZB/gjTuSD0LOsPfvvsmMKZV6BVluTcyogKZnSi/fxLOPxsBQQhMBt2cdhmOkNZLJxYR9HMJqPj06d9loCt0coxWy5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBOu/Gqx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBOu/Gqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DBA1F00ADB
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788289944;
	bh=TG3sfq3Q9eRabuWHt0uykLCNRXVg7IkhmV7MJfFm0Zg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BBOu/GqxmIEJHpaefNA2RSeSoJSFt4IBxBtIdo2YvAJ80OYU3QYgX1ublVdTORbew
	 K52Z4J+rKcsK4xUJmqi7p+cy2xvm/6+10KUKlXVpAPmiQ/adh8Zih1Zc1vBRKb6GOw
	 5s/zFWeplHRqr5TCfHYuLF1PGXHVwyb/guFF4dhooUsOrpzr0sY7+oMQGxdGU5CzCF
	 ufTb8+CmnP1rFMKWnYPf9S5Xr/aOHfug1rF8DMANDWfC/nZMrM7LtO8LMWwduEJkNf
	 ipJlImYX1BT6RFGdsAo44xAEptoXY+vrCIAKZ6Nj494JfSNMF1WoQD0pDovtPwixRe
	 05kmKwx8Clv6g==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39faf9e2c62so1507301fa.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 12:12:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwne/ge8IMcHSJVpJLdBYoQNipuQtb+WNVwjtu2twa+mJ9v/rg4+aP7lCOqBGDGs41wPm48Ez/45TQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mZy4FpcriJDWUz/Mv6Z33j+ioy8r3umCdEFq/xrWHIfi9nm8KU
	P+KW7vQHvUztbpoGw8beA3vFYutyq3zyp3NeD/NVBbwnl94vYY2Y3zZj6tJMn6vEJ2J1TbwP8mZ
	ZfH7VhZYhPImy20cYi26fyBtdS4NnwrA=
X-Received: by 2002:a05:651c:25c3:10b0:3a1:7f10:912b with SMTP id
 38308e7fff4ca-3a301ae9c8amr61000231fa.12.1788289942740; Tue, 01 Sep 2026
 12:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3435655.aeNJFYEL58@rafael.j.wysocki> <2021470.taCxCBeP46@rafael.j.wysocki>
 <apaPjaBH48O4V03m@ashevche-desk.local>
In-Reply-To: <apaPjaBH48O4V03m@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 1 Sep 2026 21:11:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7BHATHmLNftYHqdy-Ab-Dpq0PySV9q8BONc7KO30JqQ@mail.gmail.com>
X-Gm-Features: AcwNN1WG8gPxeTQ2F4zR4GcATKypWSZjtI14jt-NrdwQ4_9NpORm45pqC9DZBuE
Message-ID: <CAJZ5v0h7BHATHmLNftYHqdy-Ab-Dpq0PySV9q8BONc7KO30JqQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] ACPI: scan: Combine two conditionals in acpi_bus_attach()
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

On Tue, Sep 1, 2026 at 10:40=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 31, 2026 at 07:59:32PM +0200, Rafael J. Wysocki wrote:
>
> > There are two conditionals in acpi_bus_attach() that can be combined,
> > which slightly reduces the overhead and makes the code a bit easier
> > to follow, so do that.
> >
> > No intentional functional impact.
>
> ...
>
> > -     if (ret > 0 && !device->flags.enumeration_by_parent) {
> > +     if (!device->flags.enumeration_by_parent && (ret > 0 ||
> > +         (!device->pnp.type.platform_id && !device->pnp.type.backlight=
)))
> >               acpi_device_set_enumerated(device);
> > -             goto ok;
> > -     }
> > -
> > -     if (device->pnp.type.platform_id || device->pnp.type.backlight ||
> > -         device->flags.enumeration_by_parent)
> > -             acpi_default_enumeration(device);
> >       else
> > -             acpi_device_set_enumerated(device);
> > +             acpi_default_enumeration(device);
>
> I would leave a longer line (having logical split)
>
>         if (!device->flags.enumeration_by_parent &&
>             (ret > 0 || (!device->pnp.type.platform_id && !device->pnp.ty=
pe.backlight)))
>                 acpi_device_set_enumerated(device);
>         else
>                 acpi_default_enumeration(device);
>
> Or even going further and cleaning too many negations (if I'm not mistake=
n in
> the logic)
>
>         if (device->flags.enumeration_by_parent ||
> // not sure what the expected ret values here, maybe < 0 or =3D=3D 0 part=
 is not needed

!ret should be fine.

>             (ret <=3D 0 && (device->pnp.type.platform_id || device->pnp.t=
ype.backlight)))
>                 acpi_default_enumeration(device);
>         else
>                 acpi_device_set_enumerated(device);

Yes, it looks better this way.
