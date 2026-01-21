Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50C3816E5
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006229; cv=none; b=an8rtaWsyNO6NGJworRR49lvUBFdWs1OcEZpd9YFWzowbirT00iM8bIgJq87l0wupRqXJrsc+Al5xGqV75yrFtps8Ybj+D8QYnQqj7H+2wvklIEbSMis1VFpzDESgtiRpGpvyxxz/wVKGAT7FSKGBHKzQss4IGhkICYFrxlzBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006229; c=relaxed/simple;
	bh=VpzSOPPipZ7Wk3DVhXqnmZFKnblqi6knYh6FEjxvsEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1DHzN2Q5cYgSH39araoCeCaEp3O/XkHTK6DkMDdqSureLgR0PrEYvx61CTaj+2uPqnWJO7cksdKctsm7mUvDHxdvGJK8rB0/RMJZJzRfbToD9erf/ZTubfYzHbZDZwaEmqifZv/9syGeH4TTVANvzBV8bq4qzYZXSoXZVRANgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6a7638f42so851210085a.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 06:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006224; x=1769611024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AF6Iy9dgsc5sPND1gabv+P1umCdITLLVFz5zc76lNNw=;
        b=nIxE/2a+GniyWe22/slh5JVwZPaCsesdnrt7ZGW675mIsldUkLarIHKioQBEbm/YQZ
         XrEFe0T7CcD2nECKI6hH5s2/yGjqb/b4Yk9ZsXVhhB4jco3Ac8GL3HW6b2Kbuajmojqb
         xOmYJGa4e9zG0iJ3YyFcqmMVEqs0oUQg8sj/za0PlB5+tJRlTXZ8ItnNhqPUwI68Gduw
         yoDMdo035F/1395vG2DHpTun/x3stfoDp6W+78SCaB2kmjiEpRe0tLbYYtfd0XeI/Ni2
         +fD4l4XDwfGn6e3eNSkIXBiZlf4JchCNNB0Ow8Blo6e60w9nedUYdMbEsbufOcfYIbqk
         BfDw==
X-Forwarded-Encrypted: i=1; AJvYcCWhuZhKZXb/DzY83SVORkDY9ff5kHmOGep5lw7c/YuH5U+rz524oYS01uLZSA9oJZiesRzNzKNGGHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8PEtWj334wtPG8v9iIIXyhkxOl1Ttnczwayaw0u72MJzONHy
	vf52yn/xb6aCq2zcs6MFxkVshjL2NQajzso7/dv9kcEXroMa7rcTp1Jw9EnXsaQ9
X-Gm-Gg: AZuq6aJ//FwD0HSXQN3lGKzKclBKUyYSiVrwY7fyHVuuX1O1oq+rWeYHLGS6yCOeVEx
	RglFrXJfqqvQZUq9YErzCj1HHr8pgEMPK7i1OEGvNo1vC29qTJmb6AhuczCEpCVWFoBHA5IwBwc
	TL47sTsPwreRUMevIzffovu0SiANsXTn9m0m2dobAWpCMTDz8JKSI1D8v7V+sJymxkyvFgbWJJX
	/3yniCHJgDJM+igsPvkB+tCIqj3/bk0kHsJm9gV6Mn0Aqh1wZBG1eVIml/0GlmwLjH04+/kaMBJ
	BRNIdkw/PsJmcgQUHdKOPLP7zWVqLHrhhDX18/botYksazk/jENpTT3KN4QAKhiBTILs9JppXnF
	ZynQ5RqIym4bDUHMIL1m4lrU8XJtqLbEnSf/P4qkGnKnlVZDCXlQUu1VenDgrihpwsbt9flvYa6
	tZ+gxAdZCj966U8K8QKtv8z4A08IYHJRRoMWwRKA+QP4OU7XqFT3ejYYLWILs=
X-Received: by 2002:a05:620a:7114:b0:8c5:22e2:2cfd with SMTP id af79cd13be357-8c6a6962aafmr2418935685a.79.1769000734826;
        Wed, 21 Jan 2026 05:05:34 -0800 (PST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7248dcfsm1239697585a.25.2026.01.21.05.05.34
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 05:05:34 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89461ccc46eso30784206d6.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 05:05:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPowDSQKUzGw2L1PBDRSUswm6CyeTQK3jndwqabmhsiXYpNn5XaXXW6+nECnPbmBT1tYp2Ast99gQ=@vger.kernel.org
X-Received: by 2002:a05:6102:3053:b0:5e5:66c6:d23e with SMTP id
 ada2fe7eead31-5f1a6fd7b8amr5292858137.1.1769000378213; Wed, 21 Jan 2026
 04:59:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
 <f74ab0a2-b74b-4b96-8469-a716c850e230@gmail.com> <CAL_JsqJDOYuzutMHMeFAogd5a_OX6Hwi8Gwz1Vy7HpXgNeYKsg@mail.gmail.com>
 <5cf2a12a-7c66-4622-b4a9-14896c6df005@gmail.com> <CAL_JsqJjm12LxpDg6LmpY=Ro_keHwnrWiYMLVnG=s_pSP4X2WQ@mail.gmail.com>
 <072dde7c-a53c-4525-83ac-57ea38edc0b5@gmail.com> <CAL_JsqKyG98pXGKpL=gxSc92izpzN7YCdq62ZJByhE6aFYs1fw@mail.gmail.com>
 <55076f4b-d523-4f8c-8bd4-0645b790737e@gmail.com> <20251202102619.5cd971cc@bootlin.com>
 <088af3ff-bd04-4bc9-b304-85f6ed555f2a@gmail.com> <20251202175836.747593c0@bootlin.com>
 <dc813fc2-28d2-4f2c-a2a3-08e33eec8ec7@gmail.com> <20251204083839.4fb8a4b1@bootlin.com>
 <CAMuHMdXdwf7La1EYBWTJadsTAJG3nKQVW6wtBn-bUqshA=XHRw@mail.gmail.com>
 <20251210132140.32dbc3d7@bootlin.com> <c50c40cc-69f6-436c-a94e-94a3a10f6727@gmail.com>
 <20251211132044.10f5b1ea@bootlin.com> <1b9fa77b-d74a-4fa7-b2e7-8b389d59a5a0@gmail.com>
 <20251211161902.11ef4248@bootlin.com>
In-Reply-To: <20251211161902.11ef4248@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2026 13:59:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWGk5ig3v9tGy1cMOg1LmKu3KrxQq2HO1vcQeZPuRxWBQ@mail.gmail.com>
X-Gm-Features: AZwV_QgoZry7Ux_LWaq66D8-Sle9_xFUD1BP9eHkYs41xWjINnCZsHwmSX1GiNQ
Message-ID: <CAMuHMdWGk5ig3v9tGy1cMOg1LmKu3KrxQq2HO1vcQeZPuRxWBQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT overlays"
To: Herve Codina <herve.codina@bootlin.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Rob Herring <robh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Kalle Niemi <kaleposti@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Peter Rosin <peda@axentia.se>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

Revisiting his old thread (sorry for the delay)...

On Thu, 11 Dec 2025 at 16:19, Herve Codina <herve.codina@bootlin.com> wrote=
:
> On Thu, 11 Dec 2025 15:52:28 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > On 11/12/2025 14:20, Herve Codina wrote:
> > > On Thu, 11 Dec 2025 10:34:46 +0200
> > > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > > Do you see the same trace with:
> > > - "pinctrl-0 =3D <&i2c1_pins>;" in your overlay
> > > - fragment0 removed from the overlay (i2c1_pins definition removed fr=
om
> > >    the overlay.
> > > - i2c1_pins node defined in your base DT.
> >
> > Just tested. The i2c1 appears and the test-overlay probe gets called,
> > when the i2c1_pins is in the base-dt and not in the overlay.
>
> Geert, do you expirement same results?

Yes, after moving the pin control subnode from the overlay[1] to the
base DTS, the SPI bus and FLASH work after loading the overlay for
the first time.

> > > In other word, is the issues related to adding a pinctrl sub-node (pi=
nctrl
> > > pins definition) in the overlay or is it something else?
> >
> > Seems to be related to the pinctrl.
>
> I don't think that the issue is related to pinctrl itself.
>
> IMHO, I think the issue is related to overlays and fw_devlink.
> The distinction between "a new node is going to lead to a device" vs "a n=
ew
> node is just data and will never been attached to a new device" when an
> overlay is applied is broken.
>
> This is broken with the upstream "treewide: Fix probing of devices in DT
> overlays" commit I've tried to revert. Indeed, on the LAN966x PCI device
> use case devlinks created are not correct with this commit applied.
>
> I am not sure also that devlinks created with a more complex overlay will=
 be
> correct. For instance, Matti, with your overlay not sure that a phandle f=
rom
> the oscillator node referencing the pmic node will lead to a correct
> provider/consumer devlink between the pmic device and the oscillator devi=
ce.
>
> On the other hand, this is broken with "of: dynamic: Fix overlayed device=
s
> not probing because of fw_devlink" works for the LAN966x PCI device use c=
ase
> an lead to correct devlinks but breaks your use cases.

Loading my overlay[1] causes the following changes under
/sys/class/devlink/:

    + genpd_provider:ca53-cpu0--platform:e6e90000.spi ->
../../devices/virtual/devlink/genpd_provider:ca53-cpu0--platform:e6e90000.s=
pi
    + platform:e6055000.gpio--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:e6055000.gpio--platform:e6e90000.spi
    + platform:e6060000.pinctrl--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:e6060000.pinctrl--platform:e6e90000.=
spi
    - platform:e6060000.pinctrl--platform:keys ->
../../devices/virtual/devlink/platform:e6060000.pinctrl--platform:keys
    + platform:e6150000.clock-controller--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:e6150000.clock-controller--platform:=
e6e90000.spi
    + platform:soc--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:soc--platform:e6e90000.spi

Note that these changes are exactly the same in the working and the
non-working case.

Removing the overlay again removes all added links, but does not
restore the keys link:

    - genpd_provider:ca53-cpu0--platform:e6e90000.spi ->
../../devices/virtual/devlink/genpd_provider:ca53-cpu0--platform:e6e90000.s=
pi
    - platform:e6055000.gpio--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:e6055000.gpio--platform:e6e90000.spi
    - platform:e6060000.pinctrl--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:e6060000.pinctrl--platform:e6e90000.=
spi
    - platform:e6150000.clock-controller--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:e6150000.clock-controller--platform:=
e6e90000.spi
    - platform:soc--platform:e6e90000.spi ->
../../devices/virtual/devlink/platform:soc--platform:e6e90000.spi

Loading the overlay again causes no changes in the links, but the SPI
bus and FLASH always work.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drive=
rs.git/commit/?h=3Dtopic/renesas-overlays&id=3D383285b905a20d6734bfcbf7bcf7=
15c1c2b45395

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
