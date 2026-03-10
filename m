Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62A26D4CD
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155520; cv=none; b=Zo1+yI7YtYNbrKZ4pNqXi6vH/UqHCXvBDL2vanIZn6c5n/yC6wq+lvM/+4qRxFHqZurPaudFkiLFy1ZafNo+607YKZIKyXO2ngpbx/SBJzDoOUE2Io+2wbel0r8uQLlVroLbm88woxfz+wKIV8zl2fCQ8CG8pMSFYV5aC4OjQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155520; c=relaxed/simple;
	bh=QEW3lhhJANPdrCVBmAIqH1dXUDPD23689ylzZ5dnJco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5LWNi2DFJ7wRMjovPZ0n4E9S81sNlyd6tnYrgQTy44kSlgyXLXDi3HyMio93Arj7SwJAa96gUtNarsvKwEL3Y40jqOt0NvWe7PguXYWRFYZ59I8l5zsaJ2czERKDZgO7TSmcQdW6DGBwbk9YqsDHsIWX/ksELxhilxwNQvuuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899a9f445cbso158413946d6.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 08:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155518; x=1773760318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ru18n38/qbgrYN5XhGLEd0K3IukQ/mw6D37X8x0z/qo=;
        b=gRVIry55+85tJ5ncZ6KA3HxuRV+kjWNy8XEdsl3zjLYaTPvILYtI2xeagKgbUjnvwe
         684SoDAEMfDxN1zn3vJdgWh/SKUencAfXMkha8Qy5PDCd60whLCpRtaZ0iNJgn5MIf9e
         dU6o2E+vGFQcAjmv9NAZw8q/bJYy9L1Ggh3jLcltI+YFqa2a0y6XpFraDMF/hytoAJ+w
         brokzn4muXv/DmNMcMJBaLYTuKyrMycfWjlfGoQMlE3rP1TnVf9RW08RJ7qoew5VZbMf
         zjxZWfV+PVr59s3MKZjPerf+3mhqxDn3MjHCPF3pnmcAllX8LBv8qNn5wXnOJcDmr+7r
         Gkfg==
X-Forwarded-Encrypted: i=1; AJvYcCUj3eRLk1/ppwIAKi/khYrpKI0As+MNT/h4kwZtYYfYpZ7oHsCTXWz1geALWyVLUQD0Jh4FbzGg9p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfPw4M4Cn03oe+8ifoLUpseeYJJwpMmE5KtiGqX0oeYORWTzI
	DK8w9XUqYkgywOMWrtwL1Iuq/PkJS/6YwtDfNAMgi/ud5tGCpxA4AvL7QgqfBxtW
X-Gm-Gg: ATEYQzzuTPVtxllCaSLfAsgD+YUq2gF6ArhF38LDB5p3nhKFBbI7REDZ4C52Fn4iKxf
	V8haZw7Qn0ZYt/DKRk+F6uA6VbElXlsUcg2MJcxYPBqI74gfb78vX5y2pHF4b6iot4I/OjQ4cLg
	6x1sD6hZ60sfTO8NdQwvPFOeigorzBgfowgry2/HIGO0RCQQUTZd2StJjj7kz4aqSMj+AQ93mlV
	L704Kq0ERNGSGnDJ8Q41wx+CAfRpdP1ZCpGqTOxIp16TNIHY23dfuoPkuPGF7cBztCsWywGkS74
	ozMdmOCu53qYAWBDMkS0R3IHSBBSBsRWG/GNfPif9vqeqlkZxcetlxcZn50LsWCFBoPOpsgfq+O
	uSFDIlTNXy4gioyHpbgbLYdsZagsxS/e3dRlfKfuWQfni4c2Lh3/Nm8oh+U1K+NxujnNA12jg29
	oLSXe0/UWsrFCNk32evA6tAe7eg5HgYknh798BnT1MtU5QvYLe9H5S2fedz6bhs7KsdjgQ6V8h+
	Y0=
X-Received: by 2002:a0c:eb4b:0:b0:89a:6119:cd27 with SMTP id 6a1803df08f44-89a6119d178mr12581386d6.23.1773155517362;
        Tue, 10 Mar 2026 08:11:57 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a623e19b2sm5043736d6.35.2026.03.10.08.11.57
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 08:11:57 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-508fe217a44so37717361cf.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 08:11:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiLVFwiuJvTDagZqCMLsWb/WI1h3tNF3gSreIUeUkksOhrxK5qrtBPUQ/RyShRmh001ZnC2HPL8g8=@vger.kernel.org
X-Received: by 2002:a05:6102:c8f:b0:5f1:70fe:3027 with SMTP id
 ada2fe7eead31-5ffe6121c90mr5181206137.24.1773155033187; Tue, 10 Mar 2026
 08:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227135428.783983-1-herve.codina@bootlin.com> <20260227135428.783983-3-herve.codina@bootlin.com>
In-Reply-To: <20260227135428.783983-3-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Mar 2026 16:03:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
X-Gm-Features: AaiRm53b7liJL7XJhyMA-JPl81LkjhC0Orfn04kAcG7__Cf3-wDY5cIOlphhcC4
Message-ID: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
Subject: Re: [PATCH v5 02/28] driver core: Rename get_dev_from_fwnode()
 wrapper to get_device_from_fwnode()
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Fri, 27 Feb 2026 at 14:55, Herve Codina <herve.codina@bootlin.com> wrote=
:
> get_dev_from_fwnode() calls get_device() and so it acquires a reference
> on the device returned.
>
> In order to be more obvious that this wrapper is a get_device() variant,
> rename it to get_device_from_fwnode().
>
> Suggested-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/lkml/CAGETcx97QjnjVR8Z5g0ndLHpK96hLd4aYSV=
=3DiEkKPNbNOccYmA@mail.gmail.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

FTR, one more user of get_dev_from_fwnode() appeared in commit
9035073d0ef1de81 ("reset: convert reset core to using firmware nodes")
in reset/next.

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
