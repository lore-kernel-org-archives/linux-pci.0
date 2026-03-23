Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6D538645A
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273209; cv=none; b=TtOxn7idZFsbUYdewzUd+z/fAJnlvOCS/TWkhEzGQ2ymm/hUSPq6Y3n2kFpdZIlgFz8dk/lwLeOG+1cPca5w/FReRyEDpAMyrDUEpEf8/9Xj9zy1Bow6B2dgJjV4IWtpYUUHasbDuO3ByEE4/CB+qHBuT1k56fy81SjLRGNNzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273209; c=relaxed/simple;
	bh=TgusCMhIubLEZ4bInu3ubqktLQjOyVgr6o/0viqL3VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+S6zo/XR8d7MqNjKJi/qH24GvVjCRXCYpZFFc6ivSxrLEz5GELpj3An3XzhT3X+vW21Je73YEKUL3ubuFW/6GXxvK9SUbczhZEOlvNacXarePAO9wiK4E7GKRo2HORM2ZFSlK/B324i4dOK7G50cZ7xafRISDOtQAPN48ihKFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlczTnfo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlczTnfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47EBC4AF0B
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774273208;
	bh=TgusCMhIubLEZ4bInu3ubqktLQjOyVgr6o/0viqL3VA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RlczTnfotNfcU+QJhEUnTHwooLl+r6GPFRozX17lmA2w3LUUbqRj7Z857DPqOHNWG
	 /6tB9l8k2luPFcl5iaJQ1UfjTuUNqG3fuezMoN6srW8zxqb78e+SahV4iPN08PvEya
	 63/gs/fksVj7PTF4nYIl6+HT7TGyAROoE//z7EhXFWesZtYjCvXbkQfWAsx378Oscd
	 8L6acgGMRhnW62+aW8xl3/E3NNGb1V7RfyuR4q1OdXVog0Gr5757B770FTP4WQAXZu
	 QlNhs91lxj0g/HkM3LJPoxoJnJ22/2CTRtADfOfORwMzPhojnSiK6snULEqx2gThfb
	 QSrQdTNdQ5vnQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9793fa5371so558368066b.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 06:40:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkbpWEDu5VOyXg1HbFAzlsSIoccWSU5zGmKKrWiIuAbiT/rEY81gXBdDtku7OLum/ssVlWBaCsSZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1IIIFczre56tL/qihe/+cvCXO5icXMrXQhPXBPAXCXQG43+L+
	GT0jPnmrJ+vosUHofUDanjaCd98nvKcqa1M4cNBaZRxN/9RLTOhCuuBbAxO3+O5LcJuNKUMi7+w
	MhcmBfWdS8ypIaVK5sxfaWN9/mXPcDA==
X-Received: by 2002:a17:907:c903:b0:b96:e593:fd1e with SMTP id
 a640c23a62f3a-b982ee996a0mr595223266b.0.1774273207192; Mon, 23 Mar 2026
 06:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-pci-m2-e-v6-0-9c898f108d3d@oss.qualcomm.com>
 <20260317-pci-m2-e-v6-6-9c898f108d3d@oss.qualcomm.com> <20260322233713.GA98177-robh@kernel.org>
 <to2mrizprc3hjufqbiplpqyek7f4uutqtn4hx4gkmdgv2rykbc@ybwwjhdec4nm>
In-Reply-To: <to2mrizprc3hjufqbiplpqyek7f4uutqtn4hx4gkmdgv2rykbc@ybwwjhdec4nm>
From: Rob Herring <robh@kernel.org>
Date: Mon, 23 Mar 2026 08:39:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJXrHCJt770bJkMmAUhirSF3kHjYwSzkG7cXp7-eys8Rg@mail.gmail.com>
X-Gm-Features: AQROBzAm6V-IOC6VZZazNPJsxXSuw0kWV9dy9s5cLniOPgl3uSPi4q_Ka8yPibQ
Message-ID: <CAL_JsqJXrHCJt770bJkMmAUhirSF3kHjYwSzkG7cXp7-eys8Rg@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] dt-bindings: connector: m2: Add M.2 1620 LGA
 soldered down connector
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Sun, Mar 22, 2026 at 06:37:13PM -0500, Rob Herring wrote:
> > On Tue, Mar 17, 2026 at 09:59:56AM +0530, Manivannan Sadhasivam wrote:
> > > Lenovo Thinkpad T14s is found to have a soldered down version of M.2 =
1620
> > > LGA connector. Though, there is no 1620 LGA form factor defined in th=
e M.2
> > > spec, it looks very similar to the M.2 Key E connector. So add the
> > > "pcie-m2-1620-lga-connector" compatible with "pcie-m2-e-connector" fa=
llback
> > > to reuse the Key E binding.
> >
> > What is LGA?
> >
>
> Land Grid Array
>
> > If not in the spec, is it really something generic?
> >
>
> Good question. Yes and No! LGA is not something that Lenovo only uses. Ot=
her
> vendors may also use this form factor. PCIe connectors are full of innova=
tion as
> the spec gives room for hardware designers to be as innovative as possibl=
e to
> save the BOM cost.

innovation =3D=3D incompatible changes

> This is why I do not want to make it Lenovo specific. But if you prefer t=
hat, I
> can name it as "lenovo,pcie-m2-1620-lga-connector".

Depends if you think that s/w needs to know the differences. Hard to
say with a sample size of 1.

Rob
