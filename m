Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0BA26299
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886893; cv=none; b=g0OUvcapXr7xp2LffaROjC3sbvBJrOC1pRqiNFKu+UHnBjMHL6NhC8cQU5GiHZAuEvX8j6GWh/hsqaR4auJEnRWv8SHbNcNaIdxYI/zw9ikQrRF3YqGHLuXDDuQWmEfYLclrh4Pv1yJBl7D3ckoAwwEQBE1yyxACWTLyvLY/Jdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886893; c=relaxed/simple;
	bh=1jDHS3//SVF2/A/vC8oT6/lwq+kdzpM3dPjKRF+cWNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmNNK7mw0H7O9REdpczpJOvUXFh8KwGHe1vYFeFjf0JsOrizwSrvFOjMN87K+6F3YD5+ktMaMPZxvEK/zyrROsyHUMGaxjNfTtMQOqXfI61ZlCccmp1+ClnJsKVCC1VgHppomL44j8ItdeNcTHcJNUUviUoSolpM20Eq90DPm/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BPBfuDef; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BPBfuDef"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ba51e69988aso752009066b.0
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 12:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776886890; x=1777491690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8JHz3Efp15Ndyc9pOP3Ax7qZyPD4IXnQM3cK5pq58E=;
        b=BPBfuDefMxvACAE6/L1oo2yQd5pHIZPifMi+0chCmpCSsBBOb9SnVYnocqTq1hz0js
         FcMtvBFGbJOpemXAegMirlo5fuYqd6V6EFg+DjHWOV0tty137YJSJu2Z7FwODz3fpnUC
         7JNrBsv9oEqXMHOds565cDU+QZ/SGx16j9FtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886890; x=1777491690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A8JHz3Efp15Ndyc9pOP3Ax7qZyPD4IXnQM3cK5pq58E=;
        b=B/eZxZSRpDEq7qTVA613yakPZd9jXZD+Bvz+rbfIo9qnvgIYclcE6tDU8RLFZ6dSVy
         dWDD3p6H1cWBYC21OjkagYJjluaDKTXV8XdEmT8GMedJmBei0/mWmHBI0UEqvlfdX9xo
         ZibhixYXGjN021+JyFL2Wkg3ow7Jt7F5XIdrMWVkwnLbPeMclVFZEvJILdJn5qIR6vIY
         vHmjvVKmoNe5m033dOyOWrDmi6mA4eo9nPSq4ALe2cSI46/oBAB2LkMDROC6icXP1hGl
         4VfY5PmN/q/AwqtHJ9fi1OlmMYAJ6c5x9jvxSnQKPcuzryIvvUzJUu6SAV9whL9iT+K5
         iV+A==
X-Forwarded-Encrypted: i=1; AFNElJ9Scwgb05GXWoxkQ9D7M5iuqP6v6x8elOwnmMQQmrvNSVK/p8F6iJNYolGfkPzxNgCwsi3tQ2g63Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3L2UbWkhXmUxHBIyVWnmgxCy7iD3plokFGez9cxrWq1XKvEFW
	DWn1XyZ202zXQMHAa4BjUrq2vFMfUPBD5Fh8m2qq1EapKZcjzGGfr7ELZj9Bo1n4l+v+hANKUwk
	KvwbS6OOO
X-Gm-Gg: AeBDiesQbLVUFIc9s/lPCw2P7VROvxkNYliCuqvXtmFPpmhfskAQGvUf67jFevEzsmd
	vcRLzZqLq6TRv4gBgAFxQH0tZlErzQlIdiNadlCpe5iUXiTpX4QmNhXwZBZCBx36k8j6cFsSYYR
	4RE+h4TJMf8Hujfgab4bfF1PmD0Z0oH6z3WoDxSkTDDtg7eKFbAO9Cttq3TNCkLKY+wQZC6noNi
	o8YLc+7xO3pgHhihuFzL4wgiHlJhUb2nLaMunnAUCsDEBtk5R5O3CNpzpF86aBo1lXmU6ZldSis
	s15ibB1V2kDeinjXY6ikfIMaDNj+lEYY9q7hXLsp1UfW/C49IACckvKHH/ucMmRL4yq6bFw+Jgg
	rbTDPZsFOBTLb1aoI38R0D32hB9gGJKspvUUfpSOjhevxKFlrp6BrHHb115d/V4p9HuxzIKjler
	fw015J/tECH86ciFjP2U6nFRdF0lajnNw4ScQNx6O6PgTH4RtxeeJmcFKyBQUUYjh6/LcFqoSZ
X-Received: by 2002:a17:907:da7:b0:ba6:4e0f:e3a8 with SMTP id a640c23a62f3a-ba64e0fe96fmr790181866b.12.1776886889447;
        Wed, 22 Apr 2026 12:41:29 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba53297b1acsm512859066b.53.2026.04.22.12.41.29
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 12:41:29 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b941762394aso807465866b.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 12:41:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8a5suP7wnK8K/V1+CVKB2woiBHhQAkJSXIWlodIEZkJGqPRZ+vysGUJKA/x6meYaSqyDgwgxRubP0=@vger.kernel.org
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a55743d05mr122645615e9.27.1776886533988; Wed, 22 Apr 2026
 12:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com>
 <20260325143555.451852-3-herve.codina@bootlin.com> <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
 <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com> <aekg_IELc65BFrWp@ashevche-desk.local>
In-Reply-To: <aekg_IELc65BFrWp@ashevche-desk.local>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 22 Apr 2026 12:35:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
X-Gm-Features: AQROBzBA2DSdR2HBaIYSKp4MrG-iWYSiPDxUw6OYCOPyJYNxN20LzPXgyZNheJI
Message-ID: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Herve Codina <herve.codina@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
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

Hi,

On Wed, Apr 22, 2026 at 12:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 22, 2026 at 11:51:36AM -0700, Doug Anderson wrote:
> > On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com>=
 wrote:
>
> ...
>
> > > > +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> > >
> > > After commit f72e77c33e4b5657 ("device property: Make modifications
> > > of fwnode "flags" thread safe"), this must be changed to:
> > >
> > >     if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))
> > >
> > > With this change my DT overlays are working again.
> > >
> > > I guess keeping the FWNODE_FLAG_* names, but changing their values
> > > from bit masks to bit numbers was probably not such a good idea,
> > > as it fails to catch missing conversions...
> >
> > Crud, I should have thought about that. :( Do you think it's worth it
> > to do a rename at this point to catch future problems?
>
> You can try locally with allyesconfig / allmodconfig and see the outcome.
> If there are missed cases, and their amount reasonably low, I won't bothe=
r
> in this case.

I believe I caught all of them at the time of my CL, but the problem
is in-flight stuff, right? I think the problem Geert is pointing out
isn't something I missed in my original patch but rather an
interaction between my patch and this in-flight patch.

> But for the future it's kinda rule of thumb to rename when
> semantics changed.

Noted. I've certainly done that before, but I didn't think about it in
this case.

-Doug
