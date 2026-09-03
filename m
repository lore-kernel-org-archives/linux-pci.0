Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601074A2614
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459311; cv=none; b=Z4Myehuq5aZv2stvZk679RLZMRbjInsQIiWRrlUkOQkMd+xl3YoTtR5bs+itBpCKlZFyz81QSbIqHolKAqqpzsC+OuF2kgsOLVHHdD7wQGO/0Jb56o5P+v/Z/25SW8o5pOcf4ecIOoFjFpHaxAfL+WhIHwFLyKLiySVeKHFPGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459311; c=relaxed/simple;
	bh=zvAf15vIU0Me3R0xbvYwev95o9dToUwb+S3NiUxi8DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7RC/j/7sCtqNByn80pqPCoaGvxv6/A+6HoxMtJ7X54d/pMddu23tr4CdWVIXLqASfLXz2GmUnIn4NCgZaN3gLe/iWT1T+QKkJxNvgOzvIX7LamqiKWgjfJSVnVvJ0zwmuuUGss3g51d5s+slKMRcIKW0gnXWbAnZew2m2/Oh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvVLdY4D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvVLdY4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14711F00A3D
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459310;
	bh=HTivv1PPcN1iOkPucxMztByW+icmKQM9yk5kfuMSLR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RvVLdY4D7CG9r5HRjAH5BfnO3Ltbt0N8JElj/mg9k3uX5BmPWh/SB2VTz0kim0BBt
	 vOStUZYY+TDJmud8LOIW+CzD20TpkzdpI+7KSeW6vRK2Sx+IePdRXem6pj20dndnHe
	 qv9D1vjP31U9qQmk9PbIcyV1G2OTJqlmDLZL29SBYhsRrfIJcIn2xWHNYUY9k9ULqz
	 DgjWNc8oq8mgm9aeKlmFZT8UDlIAmDaiy1S13EzqDLfnpSxQFP7LTU2tAPneT9erRi
	 +rtWzyryqPajQJLITjF391hNG1dYentmqPWx2LE1PncJW2wpn/q9aMjMnWOXu7KjHy
	 E9vGyRdtozzWw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a1e9f55e03so2707781fa.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 11:15:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwwCQCt5Wd0cendNaSD5GI6l08ma/Hp/3LZlHyoQ7cmcWymwPQBbrZ2pzpPLZ1J5aseltdDo7WXiuY=@vger.kernel.org
X-Gm-Message-State: AFuF++ldt1a6oKn7URn57LKUxPnFfNTkDV+C6gsiaaUk5O2BlBBGycAb
	ttUqGW535Si4sVLxa580dbAxWCd4HWexn5OhvoUU4lzS9txiQ6+T8RnHH7/I9XVZbBg2/l+hEBr
	iuusb7BNnoO2/mKO7bSDkKwhrinzyKSQ=
X-Received: by 2002:a05:6512:3a8f:b0:5b6:4b2:c6da with SMTP id
 2adb3069b0e04-5b6155b6986mr686211e87.33.1788459308293; Thu, 03 Sep 2026
 11:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6044499.DvuYhMxLoT@rafael.j.wysocki> <2295263.irdbgypaU6@rafael.j.wysocki>
 <20260903172437.CB90B1F000E9@smtp.kernel.org>
In-Reply-To: <20260903172437.CB90B1F000E9@smtp.kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 3 Sep 2026 20:14:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i-Q_Gnz+2ti3sOHTCZF4dTZT+oUoNVSB-TMfz-SJH4Xw@mail.gmail.com>
X-Gm-Features: AcwNN1WwKGCg7LIlC0QqCjVjGf1mtW5uVEzc1uK85_sNr07Us1QCFblw0AbTJcM
Message-ID: <CAJZ5v0i-Q_Gnz+2ti3sOHTCZF4dTZT+oUoNVSB-TMfz-SJH4Xw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ACPI: scan: Stop calling acpi_bus_init_power() early
To: sashiko-reviews@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:24=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Non-power-manageable devices are incorrectly left in `ACPI_STATE=
_D0` instead of inheriting their parent's power state, breaking the non-rec=
ursive power state hierarchy.

I beg to differ.

> --
>
> commit 1b9c3462d28f35e1a6f47e065a29b14b3971db3a
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: ACPI: scan: Stop calling acpi_bus_init_power() early
>
> This commit stops calling acpi_bus_init_power() from
> acpi_bus_get_power_flags() to prevent devices with missing dependencies
> from being put into D0 prematurely. It introduces a separate invocation
> during PCI device initialization and uses ACPI power state tracking to
> decide when to initialize a device's power state.
>
> Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-ref=
-fix-v2-1-29818173ea13@linux.spacemit.com/
>
> > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> > index 4269735aadde5..76104f715efa1 100644
> > --- a/drivers/acpi/device_pm.c
> > +++ b/drivers/acpi/device_pm.c
> [ ... ]
> > @@ -340,9 +346,36 @@ int acpi_bus_init_power(struct acpi_device *device=
)
> >               state =3D ACPI_STATE_D0;
> >       }
> >       device->power.state =3D state;
> > +
> > +     acpi_handle_debug(device->handle, "Initial power state: %s\n",
> > +                       acpi_power_state_string(state));
> > +
> >       return 0;
> >  }
> >
> > +int acpi_bus_init_power(struct acpi_device *device)
> > +{
> > +     int result;
> > +
> > +     if (device->power.state !=3D ACPI_STATE_UNKNOWN)
> > +             return 0;
>
> [Severity: High]
> Does this check prevent non-PM devices from ever executing
> acpi_device_init_power()?
>
> In acpi_add_single_object(), struct acpi_device is zero-initialized, whic=
h
> defaults device->power.state to 0 (ACPI_STATE_D0). If a non-PM device ski=
ps
> the ACPI_STATE_UNKNOWN assignment in acpi_bus_get_power_flags(), this ear=
ly
> return will silently freeze its state at D0 instead of letting it inherit
> its parent's power state.

First of all, it is not clear whether or not the power states of
non-PM devices should matter.  If so, then transitioning a device into
a new power state should cause the power states of all of its non-PM
descendants to the same power state which doesn't happen.  The
existing code doesn't do that even for the immediate children.

Next, acpi_bus_get_power_flags() skips non-PM devices, so
acpi_bus_init_power() is only called for them from acpi_bus_attach().

Indeed, passing a non-PM device to acpi_bus_init_power() causes it to
inherit the current power state of the parent, but this is just the
power state of the parent at this specific time.  The power state of
the child doesn't change after that point and if the parent is
power-manageable, its state may change.  For instance, it may be in D0
initially and then it may transition to D3cold, but the "power state"
of the child will still be D0.  This is not different from the
situation after the change.

Suppose though that the parent is initially in, say, D3hot.  It will
pass this power state to the child and if the child has power
manageable children, they will never be allowed to transition into D0
(if they were in D3hot initially).

In the absence of full power state propagation from power-manageable
devices to their non-PM descendants, leaving all of the non-PM devices
in D0 is better IMV, which is what the patch does (although admittedly
it may be good to mention that in the changelog).

> > +
> > +     /*
> > +      * The ACPI device power state can be only initialized once.  If =
this
> > +      * fails, ACPI power management will not be used for the device g=
oing
> > +      * forward.
> > +      */
> > +     result =3D acpi_device_init_power(device);
> [ ... ]
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index f48715ed827c7..f219a16e018a4 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> [ ... ]
> > @@ -1145,8 +1146,7 @@ static void acpi_bus_get_power_flags(struct acpi_=
device *device)
> >                       device->power.states[ACPI_STATE_D3_COLD].flags.va=
lid =3D 1;
> >       }
> >
> > -     if (acpi_bus_init_power(device))
> > -             device->flags.power_manageable =3D 0;
> > +     device->power.state =3D ACPI_STATE_UNKNOWN;
>
> [Severity: High]
> Will non-power-manageable devices be incorrectly left in ACPI_STATE_D0
> because of this new assignment's placement?
>
> Earlier in acpi_bus_get_power_flags(), the code returns early for non-PM
> devices:
>
>         /* Presence of _PS0|_PR0 indicates 'power manageable' */
>         if (!acpi_has_method(device->handle, "_PS0") &&
>             !acpi_has_method(device->handle, "_PR0"))
>                 return;
>
> Because this early return happens before the assignment to
> ACPI_STATE_UNKNOWN, non-PM devices bypass it and retain their
> zero-initialized D0 state.
>
> Can this break the non-recursive ACPI power state hierarchy check?

Not really, and it may even help (see above).

> If intermediate non-PM devices are left in D0, a PM-capable child device
> might be incorrectly allowed to power up to D0 even if its grandparent is
> physically powered off (D3_COLD). This could lead to bus errors or system
> crashes when the child attempts to access powered-off hardware.

This doesn't happen in practice though because the parent-child
dependency tracking is done at the physical devices level, not at the
ACPI device objects level.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6044499.DvuYhMxLo=
T@rafael.j.wysocki?part=3D2
