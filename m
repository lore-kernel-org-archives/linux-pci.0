Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE6402459
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955551; cv=pass; b=tu9hy82YhqEmVGBZz3xo0plK+J9qN2hwVvP/CnIWcCH+tel54ITxQ3FZBAM9upCRjkDtJPXjMnJGO7ZmP0utKLkBR/qJa5bEcfxvHCYS3qWWhD8r9oAGrxhWihEu8fq5kGIa6phY6c+g/k8qYE+Nl1b0Pk9rG1raLpKdaApInw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955551; c=relaxed/simple;
	bh=0xmPzjQJZlQdvWU93j2fpUbP2wdKZDeT3xI2xGj40f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nygn1eHvdsXhbRUcSPbNHOXaf/4br6BlsaY1+T6+2/LiO+EOxU+KeMIbQHatPfiORljlQ5cJj6zKe/mlXx+rb68GE7FRvOjr7+vvr3mly1Lw0aIBSp9E8NFQM2cnSQKtV/6h4k/0tPnndlWlamwmSXlMJXimIryV3FsChZ5sKM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq9falUI; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq9falUI"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b4121c40aso927162f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 14:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773955548; cv=none;
        d=google.com; s=arc-20240605;
        b=BhiPLoEOAvcHBLKAO1U5e6wFqOp302UWXukyiMOw23V9MeGLREckImD5DsuDoNkPqS
         AnIGBmbJFnPtj7p94x/RS8GoS/z4/EGUE3ZrlbDJzUX+Yj1sMszqsVANEnux0n/UZUzc
         nOqA43qmkSUKvHXqMo4o0RzHZJ/8SVAnVtJdkMAtmELRW8tGkTtZ5Gp0ba8ybKc8LQsG
         McYZSsk3EvsvxdRBZ+1Cn9yTOJP4JOf1aF5WinKgnScxy6qA0QUnLDuLXBW6e3zfsC0F
         W31zLD94Z/5CYQU3tHRnONrSikDrEZr8VNYxhtZqn0Be5S8oz9PcrFNRXkkowSfRIRZT
         u/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=11+5iQhuoi7uXTy7W6XUR1mpsLG8FBwfMw3VmGaz2Nc=;
        fh=8RoptJMG3WPjyfFoIdqgNc3R870/JUOgoiYae/PNrRE=;
        b=hhZRnWWv9rbPhbavn5nfgWThnLfwBjbgVwwsq/iPlnk3G4j5rGkJF0NCKxvLl3mqDq
         Emm7Um75jLwOO86qsUnDmxpT5U0TqGiWuhD0d+MdIkG/eK443ynRElPD8RWp56nYpPh0
         rVKB2pOSkY1VY29sBewVENKCC65rArJjonsnLE6xweVXLX1Ivdv00IGOBRgPKwsEwBWT
         Hui/9muKrPO7pFxX1FRjbPlr03YC8uPnFQZ6eAddF84F2XhCn4ruRSt6c+3FNpf6ZZM/
         5nEYOK7LImk8hgdi1N30ezBneNjef2kj2K/f4rpM9Mb77yw2RDGhsg6LYlqsjOmTHBcQ
         jf8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773955548; x=1774560348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11+5iQhuoi7uXTy7W6XUR1mpsLG8FBwfMw3VmGaz2Nc=;
        b=Wq9falUIevYVel+9X4YXlIUkivwkt7ibVUlP1G6Z4Y9YYevRjQKuggc83KoNeR2e/L
         4MD1xRVBwRnszzyvULbTOsUlULa1yqA8khDsuSN5EaizcXnbLc0KTBCQ0gDh0YVVvE27
         pk+4ceTqMioTv2trH6nP9QpTz5uPuWIa+bJSjsfaUNX388Ael18mXHKAn1p58Utv8esw
         X7CgolWRyfoOKHtobnPWXhd8YQQMfiV87oN2Ftq2VoZzyvWeimK4JgL7ud3LnwefNcQv
         laiZDYfFkEXlTZ0G4wIxerRmnFyn62/3RacrD5NQ8micJJEdf+mcEcvsDgQR7G3nHL2i
         wi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773955548; x=1774560348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=11+5iQhuoi7uXTy7W6XUR1mpsLG8FBwfMw3VmGaz2Nc=;
        b=pRaByRcG7J6K9d8R2CSeKjHSof/GexVWpuurxY9KAprXCaCL7cLZH10YCE0XSCvhXU
         SR0FuFROXgm/d6/1yIibi5JZc+kzBT4cxHhWdEqZgtIuXGvXFO43iDM2vas2ebIIczhr
         CtIWa0KszBJeNLG513/jiSQE/wnjZCiu/MzHI57Jjaf2MiLtZ4ORLI3X+2JQl0Gd40Vo
         7g6ZfwP6abYuOEx6kGnzJsXTHvPtMs7pdNurrlRp58WOsVXyMjNZ7265qY5WtIlBTg42
         QyRCoWnAKSAgMVtFx2ffrr083Tecko4qAmQ++E25FGdSZ5PjBIL5hoDHuYAT4z3aOzcP
         K+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB8o+tO6p3t79K48IrIZBg9PnpEm2kIOEQfKW6J6iqOw/5CKPAuuREtvsfVkbjE/tRy4aKRzjzlGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiXp7YakZHvLK0wl3IJvYSlR3MF9xMkhy2ziDpyM0TNscFgH2K
	bsV6IfOZhFRfIFfxYpH75QOdgoOuisgMisLOdgZUTsdYeb7HgLed3DblBDEDdQCbhCLT+vsmqcw
	ERYR8PHVSjeyHGRHQ9/TjgVbFcjivtFc=
X-Gm-Gg: ATEYQzyuimHIiJKn4nag0bFNqqBJVffKKeLOpmzhgkOj8UVvLD2DxF/K2zZNWV6eOv6
	fskxrRBmN7iGZUo1ZDj7NTvxeHvbPe4sm6d63OTvURX0TcIgQhwWqoYdSxQR6LJ1I58158XDe4O
	7f3uImmoRO+RIGbUdfB4sJcVtkDBJlY09wDW+t+Z75eXdlq4eqgHEa5vuJ8jjv99RXHoa/bpAWL
	ayiUonYpho8dzsLkF4QE6Zhk3OydHgY8+gwqFzOTKZwZ5BL/g49XV7hLFv7MeA1POsEUkoUG9N1
	xT3RgB4NqWF/W5tOwSgUgpSZFL5HsUDNoxaAu0Bcb/3A73fBeUKhMTftkDkR+cVbX3wZVQ==
X-Received: by 2002:a5d:5f86:0:b0:43b:4921:8743 with SMTP id
 ffacd0b85a97d-43b6428168dmr1457840f8f.42.1773955548067; Thu, 19 Mar 2026
 14:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260318124450.163471-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260319-outstanding-rustling-galago-79bbce@quoll>
In-Reply-To: <20260319-outstanding-rustling-galago-79bbce@quoll>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 19 Mar 2026 21:25:22 +0000
X-Gm-Features: AaiRm53jXekaVqxmChJ3S736fj6vkeVSf_bLa2tMBc3wXcwUkkgJMeStMSMAbkk
Message-ID: <CA+V-a8ukASOXD+2Bdy8HNpZmTARgVEaf_+WM-sjn1jG-AFr20A@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: pci: renesas,r9a08g045-pcie: Add
 RZ/V2H(P) support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	John Madieu <john.madieu.xa@bp.renesas.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Thu, Mar 19, 2026 at 9:34=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Wed, Mar 18, 2026 at 12:44:47PM +0000, Prabhakar wrote:
> >      then:
> >        properties:
> >          interrupts:
> > @@ -236,6 +239,21 @@ allOf:
> >          reset-names:
> >            maxItems: 1
> >
>
> I do not have above hunk in next from 16th March. Nothing about
> dependencies in cover letter or changelog. What am I missing?
>
My bad, this applies on top of next-20260317.

Cheers,
Prabhakar
