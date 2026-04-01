Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14603E0C6D
	for <linux-pci@vger.kernel.org>; Wed,  1 Apr 2026 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048848; cv=none; b=ZucXalh+iuJpwh7ZE/3kJ3eiDOlfvdUMHFr1zBuA9MqQ8Sfr1LO7BihtjMqmjTKnEIPwpEDwpbkiXH3QsbUbnfWx9rn/+UGnjv6epeYsWAak5oeKTtXcqg6m/irhWn5SCcdfZIYldZzr4wf7YONd2V9YRWsLdesvm+jWN/ux+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048848; c=relaxed/simple;
	bh=qkKhweAY//5zkyFTaHxIoNtX5ZAftxTc8VW+g8ChTNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgyaKuXjOVapFQ67V5PBtPgIB1NwkJqdYE33mTGD4wirY2uUhj7N1VPPSRselc9stjeNlECdJsBhhVFLf7cLTDR4wUdlA9ECRZbSOFGHoqi+jV/EKGZahFjh+WPkCBlyW3UXxORL6T0GkfQCl/5XnLmGYxVWICzqIM75deV8aVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCLyhLq9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCLyhLq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6398EC116C6
	for <linux-pci@vger.kernel.org>; Wed,  1 Apr 2026 13:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775048848;
	bh=qkKhweAY//5zkyFTaHxIoNtX5ZAftxTc8VW+g8ChTNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hCLyhLq9J/ABM35Wm9QbJqi43kKXh6/dw9CehFhu2Besy5HzT2WIJH3zD5+Y9ERm5
	 +E/XTl5UXX65p6AXBsh03PlV7GHbHtmOPh+yjKD2uOckbLKRG2CB3ekMy8Zd6cyC0I
	 GL8V3DDmxCzVcS7sMJ0AmECQhSZQoj68QIE5B8SN+Xp90JKzdUGnqEFuaCXteKcKso
	 wDpQzWzEz3P/cUwCutXDRyS5LzZowNNPIXfXBdQWfF0udlBeCd0C3Bk0uj2O4eR25C
	 QkDEo3oH7AYk52tsx89xJrRQPG1BzIxcB+dckzi1TeYKbeeBpyGRvAu4C1rxj6/NUo
	 SIRTpUpzJsBcw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66c24b42efbso3808072a12.2
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2026 06:07:28 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw4jqNOhtqfrZSG3vojGN6f0JWiwrjLO2QOh15/sy51wEc+D/NQ
	+PbdFb53CwBGoYdVZd5djZdVJ+fu3NqfoB7gCay5vvevK7urI1iEcgNDzTgq0wcNaisuhyj+4r8
	CCfWB6LSBaGp/D4S9kquhN9PL2v8KOw==
X-Received: by 2002:a05:6402:20da:b0:66b:a96e:5ed8 with SMTP id
 4fb4d7f45d1cf-66db9b254a3mr1461970a12.25.1775048846845; Wed, 01 Apr 2026
 06:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.tdt.de>
 <20260401-pcie-intel-gw-v3-7-63b008c5b7b2@dev.tdt.de> <177503985369.3634917.6461713197883659054.robh@kernel.org>
In-Reply-To: <177503985369.3634917.6461713197883659054.robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 1 Apr 2026 08:07:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL2JW6zecCJGhFiJYraSGRNJGRsZ+oWJ+=4JWY5GD9SPQ@mail.gmail.com>
X-Gm-Features: AQROBzCjMQjJuu3vbBIWhN2h98fV7ysRTiNf73QbP1lvot8_B7A0rVK0McGfb7g
Message-ID: <CAL_JsqL2JW6zecCJGhFiJYraSGRNJGRsZ+oWJ+=4JWY5GD9SPQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] dt-bindings: PCI: intel,lgm-pcie: Add atu resource
To: Florian Eckert <fe@dev.tdt.de>
Cc: linux-pci@vger.kernel.org, Eckert.Florian@googlemail.com, 
	Rahul Tanwar <rtanwar@maxlinear.com>, linux-kernel@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Sajid Dalvi <sdalvi@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ajay Agarwal <ajayagarwal@google.com>, devicetree@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>, Conor Dooley <conor+dt@kernel.org>, ms@dev.tdt.de, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:37=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Wed, 01 Apr 2026 11:31:43 +0200, Florian Eckert wrote:
> > The 'atu' information is already set in the dwc core, if it is specifie=
d
> > in the devicetree. The driver uses its own default, if not set in the
> > devicetree. This information is hardware specific and should therefore =
be
> > maintained in the devicetree rather than in the source.
> >
> > To be backward compatibile, this field is not mandatory. If 'atu'
> > resource is not specified in the devicetree, the driver=E2=80=99s defau=
lt value
> > is used.
> >
> > Old DTS entry for PCIe:
> >
> > reg =3D <0xd1000000 0x1000>,
> >       <0xd3000000 0x20000>,
> >       <0xd0c41000.0x1000>;
> > reg-names =3D "dbi", "config", "app";
> >
> > New DTS entry for PCIe:
> >
> > reg =3D <0xd1000000 0x1000>,
> >       <0xd10c0000 0x1000>,
> >       <0xd3000000 0x20000>,
> >      <0xd0c41000.0x1000>;
> > reg-names =3D "dbi", "atu", "config", "app";

This is also wrong. But the diff of the example shows the old vs. new,
so there's really no reason for any of this in the commit msg.

> >
> > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > ---
> >  Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/intel-gw-pcie.example.dtb: pcie@d0e00000 (intel,lgm-pcie): reg-names:1: =
'config' was expected
>         from schema $id: http://devicetree.org/schemas/pci/intel-gw-pcie.=
yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/intel-gw-pcie.example.dtb: pcie@d0e00000 (intel,lgm-pcie): reg-names:2: =
'app' was expected
>         from schema $id: http://devicetree.org/schemas/pci/intel-gw-pcie.=
yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/intel-gw-pcie.example.dtb: pcie@d0e00000 (intel,lgm-pcie): reg-names:3: =
'atu' was expected
>         from schema $id: http://devicetree.org/schemas/pci/intel-gw-pcie.=
yaml
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.kernel.org/project/devicetree/patch/20260401-pcie-i=
ntel-gw-v3-7-63b008c5b7b2@dev.tdt.de
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>
>
