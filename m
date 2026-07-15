Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F753AE6E6
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133247; cv=none; b=eniaLYeKVD/D+aYpQoJjd4IMfp1Ou/30IaEb5Zk2GoGGU+bbzKtPxwUOqPUb61VOW/jm08K/efOYHs74caP+IByEMYYG1f29T3lCnhIE6qV6ryqw/nq7jkwF+eFH5End9gIXJ0DjEanCcGJNph6+jI47nmqq5nN1LB1ejm4dxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133247; c=relaxed/simple;
	bh=NpYmbrmfdrmPUFKsPZmLJwfRC+dUO5fG60UVVcO1A04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZixbG13fZdN8nFknmo428RqtRwIB3MfbTQ0NPqg5yyXwV3b8/SGDBDs7Jp5NYWhsLLau/JmwMPWaCbZMpdmLiS6998/TyTJz4FxqnwB4M2AeAVnDwst47afiCQZjMq/Fiicpp6/omUzTAYee7gT7qtafiUfvbq4o9zZgtRcUcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFr03Yg3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFr03Yg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0A31F00A3E
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133245;
	bh=N7fxcLRSwAxJq3vMIXHgQRExbA5AtPqLuC8UuRkLZAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MFr03Yg3mcm/edAwncChryyMtWEO/eQbtply2K8lE+iNRKT7pHUPsrfayKoKaGBwf
	 /GqlWIaMz73+HUwEYHjovKP85p57p7la174ktn3FCB1RkoWUoIel42oEIEsFs28QXN
	 W7ZX9k7d0ZwtqXg0sovTeVpgLs0gZF2lt3mWZqH4QYOdLybqGEbRXyqrPdGuGNYulH
	 EtAY84+aeoWF3/Re38F/v8EtPWjOQ8eVkvkd9q62hM8VX/fgOQbqePyLutY3rZ9IBh
	 AdGjKQwWJ0n58FnqMlP7Nww1PQ+NZdoM+Cx17JTdFZTCmenzah20dLdoGJzj/5vEYh
	 tiF85zMeJ1NcA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aec139da7eso2312119e87.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 09:34:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrVRcAGKKb+Ef7+SDsW2wx/b0fTlqlli4X2in+t0nZHgREN69djutONULf/mSrLvrpmAaB4t+ZZ75I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLyN63vZxhft7VXfusnQsqMsoZkz7nIlikHwmgQJmAJ7cvytsK
	hlXClgAu2ngdgFNmGIA+v0GvEuRi2YE0WTag1ievzPaH9yJpjFhwtdARDmSJhyGu9/4j4gRqe4Y
	F3QNPixUMNEWyaecyOK6gUwhugYp3pFA=
X-Received: by 2002:a05:6512:24d1:b0:5b0:227d:cef9 with SMTP id
 2adb3069b0e04-5b1c0f78eacmr12879e87.3.1784133244080; Wed, 15 Jul 2026
 09:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5115219.31r3eYUQgx@rafael.j.wysocki> <1961532.tdWV9SEqCh@rafael.j.wysocki>
 <aletkRwD7QKDJE5y@ashevche-desk.local>
In-Reply-To: <aletkRwD7QKDJE5y@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 15 Jul 2026 18:33:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iAJZ6zAexDiF8bGbTwuxQFPRV0+k820DQK62UN1J2Nsg@mail.gmail.com>
X-Gm-Features: AUfX_mz58pU9e7d40LYELHmc12cYAdeCWxuMe3Vae59FKIlCSNMgxynGyoVckn0
Message-ID: <CAJZ5v0iAJZ6zAexDiF8bGbTwuxQFPRV0+k820DQK62UN1J2Nsg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] ACPI: PCI: Introduce acpi_dev_get_pci_dev()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:56=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 15, 2026 at 05:16:19PM +0200, Rafael J. Wysocki wrote:
>
> > Some acpi_get_pci_dev() callers already have a struct ACPI device for
> > which they want to get the struct pci_dev pointer of the associated
> > PCI device, so they don't need to look for one.
> >
> > For this reason, add acpi_dev_get_pci_dev() that will get a PCI device
> > for a given ACPI one (if possible) and turn acpi_get_pci_dev() into
> > a static inline helper passing the acpi_fetch_acpi_dev() return value
> > directly to acpi_dev_get_pci_dev().
>
> ...
>
> >  /**
> > - * acpi_get_pci_dev - convert ACPI CA handle to struct pci_dev
> > - * @handle: the handle in question
> > + * acpi_dev_get_pci_dev - Get a struct pci_dev for a given ACPI device
> > + * @adev: Target ACPI device.
> >   *
> > - * Given an ACPI CA handle, the desired PCI device is located in the
> > - * list of PCI devices.
> > + * Get the first PCI device associated with @adev, if present, and bum=
p up its
>
> What is the meaning of the "first PCI device" in terms of ACPI specificat=
ion (and
> implementation in the Linux kernel)? I think it's impossible case to have=
 more
> than one object to be a companion to a PCI device. Am I wrong?

The ACPI specification is kind of agnostic to that.

In the kernel, there can be multiple physical devices associated with
one ACPI device object, but I agree that every PCI device has at most
one ACPI companion.

I'll drop the word "first" from this comment.

> > + * reference counter.
> >   *
> > - * If the device is found, its reference count is increased and this
> > - * function returns a pointer to its data structure.  The caller must
> > - * decrement the reference count by calling pci_dev_put().
> > - * If no device is found, %NULL is returned.
> > + * Callers are responsible for dropping the PCI device reference obtai=
ned by
> > + * this function.
> > + *
> > + * Return: The struct pci_dev pointer of a reference-counted PCI devic=
e on
> > + * success or NULL on failure.
> >   */
>
> --
