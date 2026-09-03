Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48E2931EB
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439325; cv=none; b=L0D8EQX7uA5RD5y+3ZpEK/by1KxAxC9GyEyAsgqhhNKcu3c0pxzKj0FSebZFfPSPBNS6QfV33+vjtFCyyW4CI9ZQWL3Y0ijblDIArOPrveUsvjOTN1Fe9aZUNqwwdrNbR2kileV6KmWhRm2w7q3uKNvGBXWpdG7JsAIbUGAcjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439325; c=relaxed/simple;
	bh=52IhV1NlD8VpIKm2oG40lSwrnp/KluZG7LbmqWFL7xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggMfwCQwTFRg20upcVO0xx5f6uwqNEVfX5B1SuQ+6gn9Eh03yjSoyXAuzvfZxZp/nBh6pJnj1NK48dxgMmk3rRDTw4tftHhW7yX3c93bNH5SH+uxeWbux9HqR5g7aYSjmVHlhap3NaE/gnNALh2KoUT3x56xLM8BbBvS3XNtvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-98076bb236eso692749241.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 05:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439322; x=1789044122;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4aThBV/MKXRTLxxMP9NP7CiDSYoBXBhVSup6n2UINuQ=;
        b=la5h3OV2REQn1thS4M5LYO+UM1wXfRCGaiG6UvkOj8B/p4VT/nELZeVbh0c6LSS/Rd
         Mn/gA1DFvauvmWE7KaKno+DOeP6cQ0sxigxzT7sVYhq3xOxlbBmqjuGIb6gk0ooT9ccW
         TA9GXI1KnBW8GmO69zOaD70GxsP4Q2MW2Eotbs8a3rGSL8igzU9wNDCDaXl48ENga/k3
         nx8JWpRYi4yh9knaZf88rvnRMiZd+s7qZLyITBpgm/MAczHX2GcxYPme+zAOStCzb+D5
         PGUhLKdPnGqXQe9qFoLxtXK4/pTpawufJ3Jt8lX0UFSTOGGmMuLpRmIQids8wYKUItPH
         +qRw==
X-Forwarded-Encrypted: i=1; AKwUvByowjmQQEOnz1BulmNFe3yDVH1c0lJ+6IQyBRuloowwXEywCxkzjTcDKpsoSP8vS2b+8mgwaLJJEgs=@vger.kernel.org
X-Gm-Message-State: AFuF++m6EDmBqID+MZNtyYgFmgCiG7TKhswroYyGyRIgrsVymd6mVyrL
	k4qaaVqXbims5GC+JQ5fIke712oltpHn39Pa24ZXuEPJ86LuF4+6vl6OopkHwySyjNQ=
X-Gm-Gg: AYBFou3yQCGcxEz4IMx6OFH49N67EJQ4y++fS3+RIpD/QY8qnzcvp4T5vxbZPgdfPKM
	WmUD1QtEWsHkE9Wi2/uMuXM6kaJqGz6j8OybLndQSepMfuTMbYbTECtSQdplhpsDzCRnsx4uARG
	5A8Bm6x7Qa+83JgrPtjduAQ6ACTRZvHLfOEbKnrKT+IJGrEnWiT7HuIBvTzRIffHZ7ZIYcugcXX
	+P/O7k2WA88Pk95vGPF1+swfTcM2+0S6mxqxHQDAa8ca7fxXsAR2lKTJSpY966ylmYbhBGYM5Ka
	wd0kSa23M8Vndmknfv4X1kHrgq4/qL/RqIkID/RF9yQlyLWJ1JOGPk7+6I+u71W6I0vHpw5JsmP
	GrBomap1DBDwBUUhl+o+VzLixpxSMo2NYTQU1femes8vnx8Ab3IUqefv7vehOamVZ/eaVfeCioj
	xJIV5D8WoNbxObGVlWffyyX/oyjVUMfU02lQOf/+2BXSOLPdv7CLE0/5DcXzI+gIUGNjwY7/MxO
	En7Ze0b6AUQdlB7MpIinuYyXg==
X-Received: by 2002:a05:6102:3ec5:b0:77d:e064:2dc1 with SMTP id ada2fe7eead31-78a1eedd409mr4617980137.0.1788439322190;
        Thu, 03 Sep 2026 05:42:02 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-980673fbf40sm4116106241.11.2026.09.03.05.42.01
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 05:42:01 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7866d924eaaso1576151137.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 05:42:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByCLHEPivwzwxB9xZ0e2/pd1WOwuqCGmbjnciYJM/WpSP/Cbg8iEVoK/a+wCl7uu2YXt9Y+BNx4UCo=@vger.kernel.org
X-Received: by 2002:a05:6102:330c:b0:786:fb19:d5d6 with SMTP id
 ada2fe7eead31-78a1f19f88fmr5114359137.1.1788439321117; Thu, 03 Sep 2026
 05:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825095047.9971-1-biju.das.jz@bp.renesas.com> <20260825095047.9971-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260825095047.9971-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Sep 2026 14:41:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW+ejFSGv-gTfvgk8ZSxX+QWns_kyteYr-KQkLnio8PJA@mail.gmail.com>
X-Gm-Features: AcwNN1Uzwrt2F_57qLud1MQRI-EP0blNweC_SW2rpdknAoyXWxcnxu0jErknhrc
Message-ID: <CAMuHMdW+ejFSGv-gTfvgk8ZSxX+QWns_kyteYr-KQkLnio8PJA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document
 RZ/G3L SoC
To: Biju <biju.das.au@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Tue, 25 Aug 2026 at 11:50, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Extend the existing device tree bindings for Renesas RZ/G3S PCIe
> controller to include support for the RZ/G3L (renesas,r9a08g046-pcie)
> PCIe controller. The RZ/G3L PCIe controller is similar to RZ/G3S but has
> some key differences:
>      - Has 3 clocks compared to 2 on other SoCs.
>      - Has a different set of reset signals
>
> Add device tree bindings for renesas,r9a08g046-pcie compatible IPs.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml

> @@ -87,14 +88,18 @@ properties:
>    interrupt-controller: true
>
>    clocks:
> +    minItems: 2
>      items:
>        - description: System clock
>        - description: PM control clock or clock for L1 substate handling
> +      - description: PM control clock or clock for L1 substate handling

As pointed out by Krzysztof, the "or ..." part should be dropped...

>
>    clock-names:
> +    minItems: 2
>      items:
>        - const: aclk
>        - enum: [pm, pmu]
> +      - enum: [pm, pmu]

... this can only be "pmu".

>
>    resets:
>      minItems: 1

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
