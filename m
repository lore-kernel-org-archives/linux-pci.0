Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48231274658
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283952; cv=none; b=l8jt0miuKx6PBrvaEOr5xjHhwnEfSsrCitpzITP2QHv2wrm9ZYy9R6Rd6OOi6ltJzZEDGLTvwcCow4O1+a3a6yS2Daa0TVhxL4qotjkl6+FQVRUYnXpxTn48WSKYAUBzDNflQRKdWGGKas/bBIqnh9ZYX1zSanVKFm7rjG+akNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283952; c=relaxed/simple;
	bh=0UnN7pOWdscf3V3uG2oqNtzUQ7WE4DwVAqmUMMlArLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMbe5947Egfd7NOGOk/L25aNwRP4FvXmNHq7MM+rapxZFRmwTfwurKayEJLb6AJLUKid+g9r/+h8tPqLsrjjhsgAByjoJyt6L2/xV/frZo5NhJrNwxH5Q0KQYzZYF2XKrDyulV/i4yDfeVg/A8I/QY6NBOGv/QuBrGrtjViwc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnYIGei7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnYIGei7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20F41F00A3A
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 17:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283951;
	bh=gHmwpsKoLpq6NlHt2ZG2kyAm1yl7EZ9b4eNKciqlHGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hnYIGei7berEk4f09pt7Uznq9FrHE5VMGk9m4S7GRB2D7zws4zl8ExruAFc/EBjyy
	 dbvv7i+f6nhiuTyF2K/5ZpSbFrLa5EIkTIPpNn67dPvoZ5G6ESvxlBQnjqEnfl3tbU
	 g0y30awX8y3er9u7Pf1JIfjHELtRmJ5qsfhZaW38IPIVGqtj91/7D1s4glWIH3lsKe
	 sLgvDbWSRuA4YeDmKjhpDiThlIV1MLqm2JE0dD2LEgfxIng1ZqAkk9vwGj4+afCCwc
	 kpnUgXxRI+I1M6KU79SH1+9UyMxcrJ7Kz2Ia3/bCbNQCAnKy+zRtuan+d5KPi+/Alx
	 m3dhyONeiHWMw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a1a3bb6c5dso646181fa.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 10:32:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByKtf7RcbBclUboAK6vAbsjV3NNgU+hqMlVM7EhU4HucA76gn+33N/eKswYCC0fbiBX5mF2+XMas8g=@vger.kernel.org
X-Gm-Message-State: AFuF++mYdzCKYTi3SQCWcwKKJG7odg8hrd2HrZx3ojMI/nr2HC8C+tvc
	caERVfEqWLSStESozGrSdzLb1brnBxY8ZqKZIn7w8MCFJr0DgYo/icG5HhKwl455/qiyjwxiHlr
	u5iTPCYkdFwh6Rj3mXm6kf8jUwJuehfM=
X-Received: by 2002:a05:651c:211c:b0:3a3:2585:3bc5 with SMTP id
 38308e7fff4ca-3a325853cebmr42466371fa.3.1788283949159; Tue, 01 Sep 2026
 10:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3435655.aeNJFYEL58@rafael.j.wysocki> <10913616.nUPlyArG6x@rafael.j.wysocki>
 <20260831201426.92F091F000E9@smtp.kernel.org>
In-Reply-To: <20260831201426.92F091F000E9@smtp.kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 1 Sep 2026 19:31:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i9+UaHF__1C+nZHjerChegZSewYsnU3viP=HW5Mq9UHw@mail.gmail.com>
X-Gm-Features: AcwNN1WpAOu2_0FJ-2hVzFHffFn7LMFme4B-bGrNMakdHK13wBDpU2UyL7ExrlE
Message-ID: <CAJZ5v0i9+UaHF__1C+nZHjerChegZSewYsnU3viP=HW5Mq9UHw@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] ACPI: scan: Stop calling acpi_bus_init_power() early
To: sashiko-reviews@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 10:14=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] Transient failures in early PCI enumeration due to unmet ACPI de=
pendencies permanently disable ACPI power management for the device.
> - [High] Concurrent execution of `acpi_device_set_power` and `acpi_bus_at=
tach` leads to power resource reference count leaks.
> - [High] Bitfield data race on `struct acpi_device_flags` leading to corr=
upted device flags.
> - [High] Unprivileged sysfs access to a child's power state bypasses the =
parent's power resource initialization, leading to reference count underflo=
w and permanent power leaks.
> --
>
> commit 00db710bd9860a36a16f28aa782d074b11d43aab
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> ACPI: scan: Stop calling acpi_bus_init_power() early
>
> This commit prevents premature transition into the D0 power state for
> devices with missing dependencies by changing when acpi_bus_init_power()
> is called. It updates acpi_device_set_power() to initialize power upfront
> and adjusts acpi_bus_attach() to use ACPI power state tracking instead of
> the initialized flag.
>
> Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-ref=
-fix-v2-1-29818173ea13@linux.spacemit.com/ [1]
>
> > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> > index aa55ecfc2923c..a680e6972a8c2 100644
> > --- a/drivers/acpi/device_pm.c
> > +++ b/drivers/acpi/device_pm.c
>
> [ ... ]
>
> > @@ -168,6 +168,12 @@ int acpi_device_set_power(struct acpi_device *devi=
ce, int state)
> >           || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
> >               return -EINVAL;
> >
> > +     if (device->power.state =3D=3D ACPI_STATE_UNKNOWN &&
> > +         acpi_bus_init_power(device)) {
> > +             device->flags.power_manageable =3D 0;
>
> [Severity: High]
> If acpi_bus_init_power() fails transiently here because dependencies are
> unmet (for instance, _PSC or _ON evaluations fail during early PCI
> discovery), does this permanently disable ACPI power management for the
> device? Since the prior restoration logic was removed from
> acpi_bus_attach(), it appears there is no mechanism to recover from this
> transient failure when dependencies are met later.

Good point.

> [Severity: High]
> Because struct acpi_device_flags is a bitfield, does modifying
> power_manageable here without mutual exclusion risk a data race?
>
> If acpi_device_set_power() runs concurrently with async enumeration
> (such as acpi_bus_attach() calling acpi_device_set_enumerated()), they
> could perform concurrent read-modify-write operations on the bitfield.
> This could cause one of the flag updates (like the visited or enumerated
> flag) to be silently lost.

This will not happen AFAICS, but in fact it is not necessary to clear
flags.power_manageable in acpi_device_set_power() which will also
address the previous comment.

The power state will remain ACPI_STATE_UNKNOWN until it gets properly
initialized either during acpi_device_set_power() execution or by
acpi_bus_attach() which both call acpi_bus_init_power() if the power
state is unknown.

>
> > +             return -ENODEV;
> > +     }
> > +
> >       acpi_handle_debug(device->handle, "Power state change: %s -> %s\n=
",
> >                         acpi_power_state_string(device->power.state),
> >                         acpi_power_state_string(state));
>
> [ ... ]
>
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index f48715ed827c7..1ad8dffc2dafe 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
>
> [ ... ]
>
> > @@ -2364,16 +2361,13 @@ static int acpi_bus_attach(struct acpi_device *=
device, void *first_pass)
> >
> >       acpi_ec_register_opregions(device);
> >
> > -     if (!device->flags.initialized) {
> > -             device->flags.power_manageable =3D
> > -                     device->power.states[ACPI_STATE_D0].flags.valid;
> > -             if (acpi_bus_init_power(device))
> > -                     device->flags.power_manageable =3D 0;
> > +     if (device->flags.power_manageable &&
> > +         device->power.state =3D=3D ACPI_STATE_UNKNOWN &&
> > +         acpi_bus_init_power(device))
>
> [Severity: High]
> Is it possible for acpi_bus_attach() (running asynchronously via
> acpi_scan_clear_dep_fn()) and acpi_device_set_power() (reachable via
> sysfs power/control) to execute concurrently?

This can only happen for PCI devices and only when their initial
power-up fails to initialize the ACPI power state.

> Both paths now perform a lockless check of
> device->power.state =3D=3D ACPI_STATE_UNKNOWN and subsequently call
> acpi_bus_init_power(). Could this lead to both threads acquiring power
> resource references via acpi_power_on_resources(), keeping the hardware
> powered on indefinitely when the second set of references is leaked?

This can be addressed by pulling the PCI device checks from the last
patch into the first one.

> [Severity: High]
> Could an unprivileged user reading the real_power_state sysfs attribute
> of a child device bypass this parent initialization?
>
> If a sysfs read calls acpi_device_get_power() on the child, it can
> locklessly mutate the parent's state to ACPI_STATE_D0:
>
> acpi_device_get_power() {
>     ...
>     if (!device->power.flags.ignore_parent && parent &&
>         parent->power.state =3D=3D ACPI_STATE_UNKNOWN &&
>         result =3D=3D ACPI_STATE_D0)
>             parent->power.state =3D ACPI_STATE_D0;
>     ...
> }
>
> If this occurs before acpi_bus_attach() runs for the parent, the
> lockless check here in acpi_bus_attach() will see a state other than
> ACPI_STATE_UNKNOWN and skip calling acpi_bus_init_power().
>
> Does this result in the parent's power resources never being initialized,
> leading to a reference count underflow when the device later transitions
> to D3?

Good catch.  This parent power state update is fishy and shouldn't be
done anyway.

> > +             device->flags.power_manageable =3D 0;
> >
> > -             device->flags.initialized =3D true;
> > -     } else if (device->flags.visited) {
> > +     if (device->flags.visited)
> >               goto ok;
> > -     }
>
> --
