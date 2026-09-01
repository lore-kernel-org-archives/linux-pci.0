Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C94A205A
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290125; cv=none; b=dzpXwcNsOwXkFXRPQgyQbhUdrG3YQsxUkl74tUNTVx4l32AinKjR01z8QR65TE1dWioO1+nzOGGbQdz7zpBI+JVf4S9uTQ/8tPl0u1D32TgKeZ51erIiLGxxeRh26kw0gicbumG4lk1acMxD2gXtj3isS41tjJIQnI3i4B91nhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290125; c=relaxed/simple;
	bh=zFgPNUcADR/j94/tcNEBzI9E7MRbrav5+S3mPcZYaCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZEnN3WQxgGBPm8OpnwS5DJbppA4h45EIVI+DWZDqKiDi5VvCTDC9sptHBI9VXbnKxacOlPWXh/IojYw32EPPk4n+IPTRmpQu2d2isZBen/OMsQAG3JO0yaaFsnfBm6OzXVE+gJda26H9GoXQRMh/6hS/hwlBU8LdZkAkdhzJIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXDvCl9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXDvCl9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1545E1F00ADF
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 19:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788290124;
	bh=WGHZuGxkBMEGcBScQhd+KOYO8aGNNbmgGdXxIib6dAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lXDvCl9j8wTk7PGbeP5MFub94EwfxHnwUmEn9Lacv6ocTmJNbab/BpYMfOLo7yYpk
	 apwS4jpRfXmg4BqaIZFRSD6DKIi7OofrORRwIlYfGMPmSOv0zcZ6jymuKXuunvCy48
	 6wv795n1x1tge/vTmvh9i8YqgLFFtzPC3rCLjjGYjEOcqol7WVAbrI7J+dkhvwgf7/
	 CWrTXd1bnRVXGWI7BH+d/tRxXmA/0VqYX8pAssv4Jnib7ImZOwQD9xFKPMrItqnt9I
	 jMfLvTwX4jeYh0CthdOAKqbiN3AEtezueClffX8Xr8gk3I+ghFIuAcruXL8SahMpWp
	 NJboT2vkEktfQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b4ab4b4179so139139e87.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 12:15:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy67b8djY68LMaZABEa9aFyT5yirmFX4tGCjyAo0CWU68qHEPUKSXAWVh0th6+pJpwqPosXxB2oBVU=@vger.kernel.org
X-Gm-Message-State: AFuF++lQYfKHNYzWzAviR1mAd5EuJdfNTHRU9WzJAa9r0HF/T+u3PMcG
	FqUgLgnK6TEYbWCJJXKKwXy3VCMcKmHF6g19u0aaJqN5clKk/Fa28ZEgwWdE4P7QG6Hi7OxE/7V
	HyR5FliYqXhH9OA0UbclfWxfrEz3kEu8=
X-Received: by 2002:a05:6512:2311:b0:5b0:113d:8ae5 with SMTP id
 2adb3069b0e04-5b60853aefdmr5483e87.10.1788290122246; Tue, 01 Sep 2026
 12:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3435655.aeNJFYEL58@rafael.j.wysocki> <2497062.NG923GbCHz@rafael.j.wysocki>
 <apaQZr71mBe0_3fU@ashevche-desk.local>
In-Reply-To: <apaQZr71mBe0_3fU@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 1 Sep 2026 21:14:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g+N--XQFuD=ZD9tmevU6dQ32-VHJhbVVsDwqR9wM5BkA@mail.gmail.com>
X-Gm-Features: AcwNN1XyDF_pJJDrGrFfnXssS0wiNeSsDyVEpRrO1PBBZ79tCWrSAeBzZgk0EBA
Message-ID: <CAJZ5v0g+N--XQFuD=ZD9tmevU6dQ32-VHJhbVVsDwqR9wM5BkA@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] ACPI: scan: Take PCI device enumeration into
 account directly
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

On Tue, Sep 1, 2026 at 10:44=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 31, 2026 at 07:59:48PM +0200, Rafael J. Wysocki wrote:
>
> > The ACPI companions of PCI devices are associated with the correspondin=
g
> > PCI devices before being processed by acpi_scan_attach() and by the tim=
e
> > they are passed to attach_subtree(), the PCI devices associated with
> > them have been already enumerated and initialized (including power
> > management initialization).
> >
> > Accordingly, it is not necessary or even useful to check their status i=
n
> > attach_subtree(), so do not do that.
>
> ...
>
> > +     if (pci) {
> > +             acpi_handle_debug(device->handle, "PCI companion %s found=
\n",
> > +                               dev_name(&pci->dev));
>
> We have pci_name().

Ah, OK
