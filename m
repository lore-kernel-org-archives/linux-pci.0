Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA039BFFC
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173876; cv=none; b=PUWGJ6Ab6zHULo9xAfWO9qGkuiWmctiyNyNpTUdyrW+IbCMGkdtZayew46eAY/ac1U+G0prXoC3i+rgARZX/2o17pWdqXg8sTTCcBHOty1WGkJw22ixzK5mWeGTyg8HxB+14PoLUv+Z9EcrfmctXr1EfXz7URgC7X/g6R3ltvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173876; c=relaxed/simple;
	bh=Ck5PYZUAGeP/arKc7+joOM35SGiEsWGbMXReP2dGyfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0+mL1kC97R2Av4+fHt6Gu4+dxmWcF+clV1nRojnVzcDZ2XPLlgl5lsdEzHPhIuUd60xSPWPiqaz4y49UIlXTqelB05f8GjRJyJyoaddWoGdnulohPIV2pNCqb0j531DmeAkFYHLeZHqcYoVQhqtYRhDFb0gcxJstsn653AHyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-95f9d6a3a04so2202423241.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 23:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779173874; x=1779778674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvqi7WOJmULSzExbjI6JKbD+zff8xMlt2sOcKh3NdpM=;
        b=DB9fIZLwLIPVkEMmFkL6gtYXUTvlQyzabvo5UIWXdO5uVqjA02gMcEe4/EEq61CQyC
         NRlqcRs4Ep1XlmyDH/ONCv7zce/4i4bBdEUO6xfo1bPBZ/7HxgmeZsW1tyC4cTSwaB93
         nwC/RrnRML+nw1dLbaW0jgBOILGAENeQZO0GotzKeMDZmKcdaCGmxXfCySgtqJLWPnls
         v6pE0X6HPcBzd65o7/SkrNQLfZjt1Z0/cIbBKEhGHRsjZ9hv/Xi1ZnEf28qeCZbx/N+c
         W1+lgt0ganKQLVKJPXs8k/sO/S6MrCIEaM+H7f1m6vp31ZWqbskLP6IDWmoZKNGE4xKw
         NMbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dlIkFAwszXNMcPSZngAbNynGXI53fl+EEEBD0LnH0eRVdBn73XTXmGvsyp3Z33VCglAkFCmwNTtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygJXqePjDCx9K2nZtWtno+N4Bn/uvGIDEpFHnqMdj8DJ+erjqt
	OUaJnk67sPWnW1QTm8qKYip8cph110p15FnhbLKmWS72OKDBha5rGdE0yNNyhFAk
X-Gm-Gg: Acq92OGjmBXORpQSQyJ2yDEo+OPLeMiCostoD+jia/Deu9DugxhuWhNeXLrYXW+oUWK
	QMP9rdWI0FdMc/GW8k1vUHvUvTTilI+DqmHaWgwKpT4f+RKeoF+q0GZza7o5BWrbJsFVcg5eRuB
	pzWSmN3u5J++zWUqXv/uJpM1dxCyI8Za6ZlN7iSbw+vj9s9oglcjfb+SUg6Cno1FprLsgDnql2Y
	VfXIToAVhKg7E2a0gJPQ8dEJK0yAJ3wJcXLljoTnJS1dy46x7j7UaVrvip4l6u/m86RGPAM+TCY
	WLPwHNc1dSSLSH4ZRTj/XIe0d2CqYAb2ZVGGK5kSMr48nhBxnb19o/V9FdybDFir2CWxj6p7jqx
	wt+hbpakPc9847sStPubNCp6htsKLcJ6uTG6tIv5oWPbO92KMpX9zGW/Ajr1MdZDyG0lceq3M2T
	G2zyTPcmEAyNjaO8FFpvEZESTtE8wvzLoI1Nt+miV9ISp7qHy5yqfI2tWi4zYI
X-Received: by 2002:a05:6102:1499:b0:631:44b7:b88c with SMTP id ada2fe7eead31-63a3f5864fcmr8143360137.20.1779173873905;
        Mon, 18 May 2026 23:57:53 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2fbfb54sm5945578241.12.2026.05.18.23.57.52
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 23:57:53 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-95d0476492bso2138373241.2
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 23:57:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/93Td+TskNQD7IlYMBksc5AMHd2EBR0B3vDd0kzEPQ2wjHFYFILqdQFdL2GXUdSYB6mrsKVU8R844=@vger.kernel.org
X-Received: by 2002:a05:6102:4a8b:b0:631:26f6:7022 with SMTP id
 ada2fe7eead31-63a3f697fcbmr9602990137.23.1779173872462; Mon, 18 May 2026
 23:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518155324.168948-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260518155324.168948-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260518155324.168948-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 08:57:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1m1bUJY+7AF+W7hZ_zpcBt=nbJivjr-nrmSLBiZv8qw@mail.gmail.com>
X-Gm-Features: AVHnY4Jc61-evCo6difEXHaRZvepFdF2DA2aBeAZnXipFD8gNqintNb5uzSNM9A
Message-ID: <CAMuHMdW1m1bUJY+7AF+W7hZ_zpcBt=nbJivjr-nrmSLBiZv8qw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: renesas,r9a08g045-pcie: Add
 RZ/V2H(P) support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Mon, 18 May 2026 at 17:53, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add support for the PCIe controller found on the Renesas RZ/V2H(P) SoC.
>
> The RZ/V2H(P) controller is similar to the RZ/G3E variant but includes
> additional registers and configuration bits for PCIe lane control. It
> supports multilink operation configured as either a single x4 link
> or two independent x2 link controllers.
>
> Unlike earlier SoCs supported by this driver which only feature a single
> PCIe controller, the RZ/V2H(P) SoC implements two controllers. Both
> controllers rely on the system controller (`sysc`) for configuration,
> but the required registers reside at different offsets for each instance.
> To correctly identify the controller instance and map the corresponding
> system controller registers, make the "linux,pci-domain" and "num-lanes"
> properties mandatory for this SoC and restrict their values according to
> the hardware capabilities.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml

> @@ -235,6 +238,20 @@ allOf:
>            maxItems: 1
>          reset-names:
>            maxItems: 1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g057-pcie
> +    then:
> +      properties:
> +        linux,pci-domain:
> +          enum: [0, 1]

Sashiko has the following comments about this property[1]:

| Is it appropriate to use linux,pci-domain to identify the hardware
| controller instance?
| Device Tree is designed to describe hardware rather than software policy
| or configuration. The linux,pci-domain property is an OS-specific hint
| used to assign logical PCI domain numbers.
| Using it to identify hardware instances strictly couples the hardware
| register mapping to an OS numbering scheme.

and

| Does limiting this to [0, 1] cause a regression for valid software
| configurations?
| For example, if a board with multiple PCIe controllers assigns domains 2
| and 3 to these instances to avoid conflicts, the binding will fail
| validation and the driver will fail to probe.
| Could the hardware instances instead be identified via standard hardware
| descriptive mechanisms, such as their physical base address (reg),
| standard aliases, or by adding a phandle specifier argument to
| renesas,sysc?

dtschema/schemas/pci/pci-host-bridge.yaml states:

| linux,pci-domain:
|   description:
|     If present this property assigns a fixed PCI domain number to a
host bridge,
|     otherwise an unstable (across boots) unique number will be assigned.
|     It is required to either not set this property at all or set it for all
|     host bridges in the system, otherwise potentially conflicting
domain numbers
|     may be assigned to root buses behind different host bridges.  The domain
|     number for each host bridge in the system must be unique.

In the RZ/V2H case, the number is local to the SYSC instance referenced
by the renesas,sysc property, while linux,pci-domain is global to the
full system by definition. Fixing the numbers to zero and one works,
until some other controller in the system has conflicting requirements.

I do see a future case where this may break: if Renesas would release a
new SoC containing two RZ/V2H dies, there would be four PCIe controllers
and two SYSC controllers.  This would require two PCIe controllers to
have linux,pci-domain = <0>, and two having linux,pci-domain = <1>,
which is not permitted.

Hence adding a second cell to the renesas,sysc property, to specify
the base offset of the PCIe-related registers inside SYSC seems like
the best way to go?

[1] https://sashiko.dev/#/patchset/20260518155324.168948-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=1

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
