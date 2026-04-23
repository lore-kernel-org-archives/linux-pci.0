Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB1A3D7D99
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927617; cv=none; b=qXTYIjjK4phAaqVMzlrAa3YJB4zNh2kyUq4ygNlpvOwzn3mHbYGYcM2Fc28rJQJd9k7q8+8XZ3bAAx0BoesuRNSvPyJ17qhVY13R0arKIZROI53kseLBBKfTLqyCburFmDRAMlZUez1jTWmvCs9nANGwgv1iriYSUODmNIg+cso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927617; c=relaxed/simple;
	bh=hexwbOGW/6m/Df6+GU12KM4IKYYaGu617h9GqYfIhNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1He9WHFoeWmvEeghQ+dWHhdZqHVuyMeL1yX5CmYiYBwcFpeXGly6FBQqSNE7T5wit9QLhp5hCwNDYA3eP02my8+PcOS04u8Lf2bYbhCxQKTPpP/AvBjtlsun7baWFYVMZ2JVt+pxwE7kyRakERL321H5JNXE9w3L/R5Obl7J5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506aa68065eso47105231cf.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 00:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776927615; x=1777532415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FB5PTwtw54UUlBS193h15pAhGHmMjXQQ1mJTpaYMvb8=;
        b=IVSDWCADUR9n5roqOY/B0SxCdGf835tIURcSaelgR1YBLF4kN4efXiRYWcF4nrj/U8
         z/cZtjicrKzPeYbJYsHUPcUp5pLxKc2tv/J0pMUo4AmP9WYWFku08xWDuoVd9Vx46l5m
         LVd1foeXauaFaATA0348cA7oAP9Reryl5wuN9q0Wbw2sxUDNcp7Hwcl6+AdCAG1dKTDr
         oaUBYUc+5i+hU3yeu40gIFV+xWVX7oqrRxrX1tZUokA1o5hLJ+fNFj2y+y8gz5jgLhBH
         ezrsypQqHZTxNdUmuzSsxKFoCm7/UI/hiko7XUktz2HnsV2VyOgzkeugyAPhzbqdfhpp
         czGA==
X-Forwarded-Encrypted: i=1; AFNElJ8h1WcO/vT3KUG7t2pxf9xy6769PGrDzMKvaXaxdzpgxWdBMllywa6lA1sbPJgkK3d2ZLOu/JNTqVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf3cIreDELqEIgi4ZxyqJsMtyGu+eMuWcWvHolVbWN/jmHnm87
	EFHs60yiuGyxt5xsxJNyksp7pNHq0F69XPfczWRf0Eu4XH37I+3u4/tZXBuWNJTIIQE=
X-Gm-Gg: AeBDiev9d71LG0G77vujXKHTOJiHABcq0Qgi5JYKjQR82MQmW8VRV+LvPWa74W4pFcj
	J6ksov3jv6YYTLlWqARsbV367k0xvCnuceSSr3OfdhJRo1Yrl+Ccc8AW6WBCFrAdCc4qKxeS4h6
	CTCdSHXXeUu7pRQrhQXMFemfZ8pnZd5dCX3F/PqQ0eZl5tEYYT5qBf3ycfFMiZhOfa58fW/zNlh
	b9NXpjNg9YyGKJn59vbl4kyBS9nmd1DsiapH7XZ5n80KWwVD4v8b843F9RH0Je3AaPN3cYBITJ+
	7R98egtbgfql9q5LYxLHSs1P31VGb//t2o+sNI8QepbN7dScwZMe9ANADrCxS2+N7z2TPCCV/R5
	umcMsyDXIE1Gw9ZnZ/dWXJuVKNCOl7sGaOw3mwrpUvEoKgjXx3xQH2pj0aEMpO6ntW6C4MXrEMi
	PWyC5uozczEHj4dS6FoW6KyYCQENPAD3fSjWEXlimd+yW62VS04ZRidS9TvMH6/yd3eaNtRrk=
X-Received: by 2002:ac8:7d95:0:b0:50d:5f34:9a with SMTP id d75a77b69052e-50e36c0d357mr388921641cf.28.1776927614130;
        Thu, 23 Apr 2026 00:00:14 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fafe9674csm95282021cf.3.2026.04.23.00.00.13
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 00:00:13 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a093c784b0so74795716d6.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 00:00:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Xxusr/FTHNJHwXfY85KgVFncpj7X6ciWa/7ONhcs5NB5QNRhTlJGRN0XXjMWdmeyvcd/W+mxcPRM=@vger.kernel.org
X-Received: by 2002:a05:6102:441d:b0:611:6fef:905 with SMTP id
 ada2fe7eead31-616f750858emr13450072137.20.1776927225241; Wed, 22 Apr 2026
 23:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com>
 <20260325143555.451852-3-herve.codina@bootlin.com> <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
 <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com>
 <aekg_IELc65BFrWp@ashevche-desk.local> <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
In-Reply-To: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Apr 2026 08:53:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUDCQrQ2Z9D7-ZOKiuDznDJVf2R_b_8P9+Xhk4RiJ3vdw@mail.gmail.com>
X-Gm-Features: AQROBzAvgx3axNivzcvHu1RjLcwZ8ZssrkMMWMoOA6QWZi8LwGEf_PBN_biPlMM
Message-ID: <CAMuHMdUDCQrQ2Z9D7-ZOKiuDznDJVf2R_b_8P9+Xhk4RiJ3vdw@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Herve Codina <herve.codina@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Niemi <kaleposti@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Wed, 22 Apr 2026 at 21:40, Doug Anderson <dianders@chromium.org> wrote:
> On Wed, Apr 22, 2026 at 12:27=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Apr 22, 2026 at 11:51:36AM -0700, Doug Anderson wrote:
> > > On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.co=
m> wrote:
> >
> > ...
> >
> > > > > +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> > > >
> > > > After commit f72e77c33e4b5657 ("device property: Make modifications
> > > > of fwnode "flags" thread safe"), this must be changed to:
> > > >
> > > >     if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))
> > > >
> > > > With this change my DT overlays are working again.
> > > >
> > > > I guess keeping the FWNODE_FLAG_* names, but changing their values
> > > > from bit masks to bit numbers was probably not such a good idea,
> > > > as it fails to catch missing conversions...
> > >
> > > Crud, I should have thought about that. :( Do you think it's worth it
> > > to do a rename at this point to catch future problems?

I am afraid it is too late (it is already in Linus' tree), and would
add only more to the confusion.  We just have to take care when this
patch (and 01/27) is backported to stable.  Fortunately the reverse
is caught, as the fwnode_*_flag() helpers did not exist before.

> > You can try locally with allyesconfig / allmodconfig and see the outcom=
e.
> > If there are missed cases, and their amount reasonably low, I won't bot=
her
> > in this case.
>
> I believe I caught all of them at the time of my CL, but the problem
> is in-flight stuff, right? I think the problem Geert is pointing out
> isn't something I missed in my original patch but rather an
> interaction between my patch and this in-flight patch.

There are no unconverted cases in upstream or linux-next
(I checked yesterday, and rechecked this morning).

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
