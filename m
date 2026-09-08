Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254FE3B27C6
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899283; cv=none; b=YmLaf7A52xXH/PE57sNjv0QbhtYxCLa9ZFTsmcjpAhuSD7AZs7CN5BlJrio/uohW08019MsH+bDazH8fy2mChrgGP1Qi/hJy6jLzkCV4HzpBxVPu2djpu5d4J/FpOf4C8m7EWoAZJkceH8bQ2sb50g9EBMtweSfnlym0gjUTkJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899283; c=relaxed/simple;
	bh=xhjxFBTG7o3V1hF+9/Cr5Z1r4ea26wH+zPzkcZjKFfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgOUrnBog/uio7Nb47t8YSxU3gB7B5dQa/ZuO/HNDxqt2WPGT5Xdd6aMVlrLnC4bOmZZlnic6iS9xU9BCbISfqX2EIubizZKeVlcZykSwld42Ei2Fh7OTcynwfnqwF6Ht2YOsm9YaMP7DE8m3HkZZMaGrTeGvsCON34+EQfciSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYmwsrYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYmwsrYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4131F00ADE
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788899281;
	bh=S0a7sPcU8wc1jcg6rbzkx4XGuPOW8khUqg/hvozg0pw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QYmwsrYiWXxlcbrz+84a1PDCnJcJUbqh7YYLu57BTYKF/HKQWGAq0tUj+Qoyy2K0x
	 eus4yechctPc4uEZciQGtASCVjoxnLfqyKLLRiM3l7/KgW2sjrhnAq4bDJsYWBY8lC
	 Z6jvczHhr/FrruoWiFKtlx1N3CY/tY8C1YHkR0tXR1MK6E/ch1nd/b+VSotajvBlUq
	 +mG+d6QFGzvcjGe+4UyOH4OHWmHMejXjXp2CYYgsF55FDJ8ciuEGxvWI1Cmb0tgDlv
	 W837G0c3logmRNYG9HQWcWY9/Detx7pcB8mzSw2VMw/8PxOWK6PG+UldwzYbcrZtAh
	 3UgX57OUztwzQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b4ae3e201cso4424270e87.2
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 13:28:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByZoJbGe9w2x938nzYzLI1FhpCo2D0v81hBfvX/zFCemcIwbxBV7ZNUr436tCKIJNBRIwGqHlknoZE=@vger.kernel.org
X-Gm-Message-State: AFuF++m8glvPSOF+MJ3p/GmZzgenSgdFVEYaf6tg7VT0/e3yx1ejegC5
	/c5yopaMCsdPQI4TULNlv2h4PQ2tdZwITYQgBQBHQC78gFvE4rUnXs6nZVaBUN4reIKyqpV/rAj
	0tWeP2p+VvYg+DrUlNH6aupnuvek6vxw=
X-Received: by 2002:a05:6512:3b2a:b0:5b6:1870:268a with SMTP id
 2adb3069b0e04-5b6187043cbmr5136367e87.59.1788899280190; Tue, 08 Sep 2026
 13:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6044499.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <6044499.DvuYhMxLoT@rafael.j.wysocki>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 8 Sep 2026 22:26:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gsmu51KUNw-Z7UW2-wG8PmRwNLcPrV5q0-L5m6QdutDw@mail.gmail.com>
X-Gm-Features: AcwNN1US7Xwj1rSV2TcpMsp96DN_vSvbKxp-AM68iLIKkYIho42GE_IS0UgYI98
Message-ID: <CAJZ5v0gsmu51KUNw-Z7UW2-wG8PmRwNLcPrV5q0-L5m6QdutDw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ACPI: scan: Adjust power management initialization
 and PCI devices handling
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Peixin Xie <peixin.xie@linux.spacemit.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Hans de Goede <hansg@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:10=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi All,
>
> This is an update of
>
> https://lore.kernel.org/linux-acpi/5144065.31r3eYUQgx@rafael.j.wysocki/
>
> that adds 1 patch, 3 two patches, and addresses review comments in patch =
[2/4].
>
> The new patch drops in v3 is a cleanup relocating the acpi_bus_init_power=
()
> declaration to an internal header file in the core ACPI support code (pat=
ch
> [3/4]).
>
> One of the patches dropped from the v2 has been folded into patch [2/4]
> and the other two have become cleanups on top of this series that can be
> done later.
>
> Overall, the series aims at addressing a few issues present in the core A=
CPI
> device enumeration code, mostly related to the acpi_bus_attach() function=
.
>
> The first one is that, on some systems, ACPI power management is initiali=
zed
> twice for devices that have missing dependencies to start with.  An attem=
pt
> to address this issue had been made during the 7.3 merge window, but it h=
ad
> to be reverted [1].  The approach used here is roughly the same as in the
> reverted commit, but it takes PCI devices (which are a special case) into
> account.
>
> In addition to the above, ACPI power management may be initialized premat=
urely
> for device objects whose parents are not ready for enumeration.
>
> The other issues are that flags are unnecessarily cleared by acpi_bus_att=
ach()
> for devices with missing dependencies and PCI devices are handled by
> acpi_bus_attach() like any other devices which is a mistake.
>
> Please see the changelogs of individual patches for details.
>
> Thanks!
>
>
> Link: https://lore.kernel.org/linux-acpi/20260820-acpi-power-resource-ref=
-fix-v2-1-29818173ea13@linux.spacemit.com/ [1]

This series has received two Tested-by tags and I believe that the
only Sashiko's comment on it has been addressed:

https://sashiko.dev/#/message/CAJZ5v0i-Q_Gnz%2B2ti3sOHTCZF4dTZT%2BoUoNVSB-T=
Mfz-SJH4Xw%40mail.gmail.com

so I'm planning to put it into linux-next this week so it is exposed
to broader testing relatively soon in the cycle because it is not a
straightforward change.

If anyone has concerns or reservations regarding it, please let me know.

Thanks!
