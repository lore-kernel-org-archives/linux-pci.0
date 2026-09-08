Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5873B14D4
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898861; cv=none; b=nJrKuT1zDq2xOcJFRkzTppZ7xzlTlQvveq/3ZOZ9wIJcPpGaomzaKtcj8eZguymNxh3zqXzX+B91wT1vo++M4MBA9xJEuyLShY8RakQUJTYWq7N4SPdFJ7ft0HZux3t/Wbrh8Yp5J5tib8L5gcewYTkuw9K56QHbuzoXC+IuH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898861; c=relaxed/simple;
	bh=M0PBpGIAhpW0X6bvN03D6zpAcmGVa/E97r7aWk9WlpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEo2NbiMJWlwbYyAfENJ4j4M/dU89EpJQXqGdKObBzIurDfqFwiBTGS+1P0O6WcjkotpYGU2qJlQfQ9N84Xjy6tgvHYTCX7gvyjXLY60VSJuTszhggPD9jRUE7sLz6v4X+50lgeUpbDADukTVN4jTuYa42fYbFvvXuHCkkEaJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0xM1oOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0xM1oOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA271F00AC4
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 20:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788898860;
	bh=M0PBpGIAhpW0X6bvN03D6zpAcmGVa/E97r7aWk9WlpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X0xM1oOQqiZAQ2goSxXtX5Us6gm+EU4mhOPctdUb6JV5f8EsTmNHec1eE0GyUr7vT
	 6Gleog65VVNo6znm3TM7TUdYWatG7Y2CQ4tK+p8UAALwJMeBMxmqg3R1lvSn7+ROsO
	 LN5GVeMoGYtBBxA6E8CUaGRU05U9tbUUC+tma4zVoQtmov1/yn2MweOMURZiLwrqRh
	 b6Yi1u5ZGP40ajRufqNIgRyKCxQ/ZjQvu/3HeLHULDDted/AW7j+kgi8tARQC9GruF
	 SrQ8/qqJmPe3DdH+N45CoJjxF+4KCheVl0C9gGMYtX9blvQ1unU0IimXxqFJkUe5EG
	 osy0eitbam+gQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aec201b582so3563054e87.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 13:20:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx6CtlOJzr54UGtZ8gCOMqHdwhWvTp68F/Se/tZfz2b2J3CII3Tr/4HGVoymj9SHrQCPmCCmC70BWk=@vger.kernel.org
X-Gm-Message-State: AFuF++mqeD9xVPzhtz/3/R/1LbiO3/AX6rWz7e7ulrsQthpmMYW7uOzp
	4RHCEuIsGQJboeramnI4AnAnCc2Uuxd5Rt9QnWRz9evUmGFcRl839bCXJTbiWuTub/LaSg7juzO
	ZwQjEPby5KZCwGFsjcl39kup4R+Y9/Dw=
X-Received: by 2002:a05:6512:3f09:b0:5b7:611c:7995 with SMTP id
 2adb3069b0e04-5b7611c79bdmr1232298e87.32.1788898858369; Tue, 08 Sep 2026
 13:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6044499.DvuYhMxLoT@rafael.j.wysocki> <ap8t5qhuEll-Xx4N@kekkonen.localdomain>
In-Reply-To: <ap8t5qhuEll-Xx4N@kekkonen.localdomain>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 8 Sep 2026 22:19:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iJSPFn8R+VVAJoCXyiqBmrb8jdRO+Vx44F9Beng+hMsQ@mail.gmail.com>
X-Gm-Features: AcwNN1VYhrdGvXxOeEBHNURhnq3gGDQC1Na0NDa-owUGsy5EEMZQidWlmK6bPa4
Message-ID: <CAJZ5v0iJSPFn8R+VVAJoCXyiqBmrb8jdRO+Vx44F9Beng+hMsQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ACPI: scan: Adjust power management initialization
 and PCI devices handling
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Peixin Xie <peixin.xie@linux.spacemit.com>, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Hans de Goede <hansg@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 11:34=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> Thanks for the set.
>
> On Thu, Sep 03, 2026 at 06:57:09PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This is an update of
> >
> > https://lore.kernel.org/linux-acpi/5144065.31r3eYUQgx@rafael.j.wysocki/
>
> Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thank you!
