Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2549C385D96
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133297; cv=none; b=eCfpdnxJr8wMlsntUjaxlBXnwvkVqI6JlSUevg9lMba4/ZTdl6I3q4cFihVkeUFcUXZ/ddF9kiBUwPwKO3YQ8dzc049vBDTw0P1HLdKtaNtSKhsktYFpQGVZ1PznarxKrWmiChWVjzcG4k3vg6yRJjQI4z1scIylHVZvYUq93hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133297; c=relaxed/simple;
	bh=xklFY7jiNfxbOwm2afgigwLDyXAIDQlKwreNetLZm28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgfAyIxOd/GYppr4C+lkAd06sV8229DCiuRa4Jtr7Zw1dbTCYi+i7XlhNXJpUNQArrXa4UsgtqUYUOIb0YH6fceqyGxHuHqPpz8IggfMgCgZVHOWU5H0vdxT6nTCxNCoZQnTzvrLdWO2Yk17eRJxnBTGQaA+RTgnhN/mN6KUKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/YcQ+bu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/YcQ+bu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B375A1F00A3F
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133295;
	bh=aUR6TK12zOwCpmFN2mBE5VaKFv6paOL9Pd091+0pRI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=d/YcQ+bu7P0gomP52oEFaFLOTjrRwM61otTaaPh9EhLtrOtwGqsz5TinXOBXSRnMf
	 Ev2M/63PiRyyJC1+xaoY22/MufwHffw/2giRmBTyDk5QB9q4voEEo1xOWB84/g8GiF
	 UesbEkpGRb6dysXtff5w9D0lYOcbdO6OPqCx0EBvfHkwbnMERtfPkqZwPHh3J5ulid
	 m/cutH9StehdEaXxItDF6abZUj7dxEpqolcRrm7ON/n7JkuBwUrBJ59AfzWax7PpIQ
	 xk8QjjVxAuVV8y3ACvpFOJmS8noDeWg+f6wzCi0/2X1vYn8dm4BHz4PahJC4UGlq+M
	 aLCv3sXJ9kLog==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b01910b499so2115866e87.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 09:34:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqWwsc+XCcg5bkkNUXuKBOB93flUQmq5mMv4xupur2WCScgmAa2c4sNAVRKk0Qy9rH2PKee56qXGPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9FsSeOMXmJqp3hK01W5OvNH619VEtHCw8RaPKUtJExU+63P4
	T8S8Joj3TX8Ls/dGjY2L0v304xHuyEuf69a77MFY2LSrp1mNqucNzXuV3AAv6cvewbCPe6B4y4g
	eoCi7UqsY5mPY/4gsRRQ4GYardjdeULQ=
X-Received: by 2002:a05:6512:3089:b0:5ae:bf5d:5c54 with SMTP id
 2adb3069b0e04-5b1c0f9251emr31531e87.27.1784133294165; Wed, 15 Jul 2026
 09:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5115219.31r3eYUQgx@rafael.j.wysocki> <8706171.T7Z3S40VBb@rafael.j.wysocki>
 <aleucS8bSeEveCDZ@ashevche-desk.local>
In-Reply-To: <aleucS8bSeEveCDZ@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 15 Jul 2026 18:34:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gSJYkHhKrA=gDFnovarB9kHdPi9ZTc=iXDRvsdCQRvGA@mail.gmail.com>
X-Gm-Features: AUfX_mxI6tZx2IuUjgrzQQUi9YVdmUEpmXs8MyJd16QA-mgvRUa1TZhoRxwvDdg
Message-ID: <CAJZ5v0gSJYkHhKrA=gDFnovarB9kHdPi9ZTc=iXDRvsdCQRvGA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] ACPI: video: Use acpi_dev_get_pci_dev() instead of acpi_get_pci_dev()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:59=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 15, 2026 at 05:21:23PM +0200, Rafael J. Wysocki wrote:
>
> > In acpi_video_bus_check() and find_video(), simply replace
> > acpi_get_pci_dev() with acpi_dev_get_pci_dev() that can be used
> > in both places because the ACPI device needed to do the lookup is
> > available.
> >
> > In acpi_video_dev_register_backlight(), instead of doing a parent ACPI
> > handle lookup based on the handle of an ACPI device that is already
> > available, pass that ACPI device to acpi_dev_parent() which is much
> > more straightforward and pass the return value of the latter directly
> > to acpi_dev_get_pci_dev() to get the PCI device associated with it.
> > That allows local variable acpi_parent to be eliminated.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> ...
>
> > +++ b/drivers/acpi/video_detect.c
>
> >       if (acpi_dev && !acpi_match_device_ids(acpi_dev, video_ids)) {
> > -             dev =3D acpi_get_pci_dev(handle);
> > +             dev =3D acpi_dev_get_pci_dev(acpi_dev);
>
> This likely needs to be rebased on top of the series I sent?

Probably.
