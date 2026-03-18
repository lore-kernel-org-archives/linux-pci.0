Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1553F2111
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773863226; cv=pass; b=U5p8pQUqkBQYhckeYVOhRFcn6tb0XLHy0qNNUp+1WzuIitLr8DzpLhfnfpM+k1rvpBmvvF+hscrfg53cd8lYrfZQGkdRUxP7DSJCRUSrX7mpJK6XOg5RLGxJ6hk7+UaxV3RXwHFGunxQ1bMOtgNgBv1eza7OLgght8Sz/amGVvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773863226; c=relaxed/simple;
	bh=wdw7cbek1kXD1UoVWXdD4fCHrDKGOkOz00GR1xyGDLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEl3Tq40IsvyjPCtWBGkSXvX6YhWDtTFIGh30I3GzQxrkLyA4Tv6I7HuhwDoWYsEeho4LOvJM4gHyjAoGR0F+PrKJItQMqJuGhN6vYiXc/jVeOEv7E81hch9/VhLqJUWYFkfaYlH0hU9gAGYhBqOtEbUBUqaWCfmECwtrzKrO8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwIFsXDZ; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwIFsXDZ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso2163245e9.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 12:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773863223; cv=none;
        d=google.com; s=arc-20240605;
        b=aLmjmV2QojxG8NVKfftbVNDeFdv7OKnimph5scEDdUOZVkMB8RLbCKtF8EU0iGwXaB
         JjO9/JwD5zmqJE/MHTwGkUR/wbUx22b/s6H+ZyVm6VXqMF19b+5SvBrup3NcovFu/VUn
         j9IfKKVfNcKuKbZgxPF/fD+cOAYknc4xWoSwvw/DHJhuOP6vkkDxqTakGBX7lR7MQkVC
         /pYPLON4xCQgfC0pjW2NqaOKNnY010hPIMrleCKI8GR+gONZAhQo5s5mGYPglJyRRSP1
         G434sOjwnl8r9kF+AXfB4Yb0C/nwf7SoIe/NZVKtpW9iV3o7yDt2sWjJLy5IM5QYnLEk
         QeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zZ+yvFyJb7pO8tRyYufwJywFQ3yWc3oSOzzyu5XObJ4=;
        fh=O/+FTw3GuZ53j4+0Da9LE7Z/MuB+WtVIt9wwj/tD9eg=;
        b=Hmaa7YhRQ/PK0+E0VUe1ihmBVLnOQQX1t13uw0Taq9WD3lGEZbxCVF5TOavYpGektD
         SKX7lMeimwj7BBgbRloiXY6FP2DkiJxW71LNq0hCHkeFIOxiHbijxl6A1+L/9rYLIrtP
         Xn0HUIT/WYuBSNF8gitA4cJkIFDETeBYD4dSrfI51daiiNq6GbeX2eSadvNc5xXr7noS
         6HUNri3ux4HYgsYym5FcgvvPbHPB2qUDhqELj9hf8x7jOMKzcZr1tYy4x7CJVUAgykTq
         WxMgoPyxAgXnXdAOk+c+FyhL4mFV5i1f++CsJL1RBKT1oTlboM9UjBdLOs+8Q+TT4NWI
         qvuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773863223; x=1774468023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZ+yvFyJb7pO8tRyYufwJywFQ3yWc3oSOzzyu5XObJ4=;
        b=jwIFsXDZd1icPQSx9k+rMnIhbs8Fp+hOelEKXuTbd67mwsRptHVAdPebIVmZ/uHwYz
         FsTj/IrQXeZ359BBmie+HkXpVa1KqzqD7n0JJT8sIz1iBAGFGSKLB8dIk5W9njBrxvPX
         WlGcttiCWKD+9SDMzv+0C9+58Z15z9ujpUZPYtdQMP/k91hBfDURu9wIjXVtcsdo+weD
         Eq9MpFk9Ro2c2/rGHerpj+QyOVHPqX84UCVtVPna6K7MelEbfqWf/3e8UVzRNG+97W8+
         yND1GqI5580aAASkNeo0l3PNkSWjneJAjdTCBMfTDWQ8hrXafNxRCyagnlSqCAJS2+1p
         /Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773863223; x=1774468023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zZ+yvFyJb7pO8tRyYufwJywFQ3yWc3oSOzzyu5XObJ4=;
        b=Lospw7xxHYbMbqPQpT5+pOl+Mr+5PgPJYoZLBNqE65q1h0XatWld2qaAnRQHSkbgi7
         Ils9sShKHrlMG/BKqwm/3Venlz0kODp6/kqqFuyQKCMMjuLBvnAXqjsYKGrbLI5+y0nt
         KcdjP7FGspq6Kw4rR79/2HHKi7xXjy7l7A7or2echZ2V6z8PfyIf/NP4wkQkGluK9vqk
         ohdh3NewHPnbNgvUGBlWYPayjvuU9sVMKYhwDxkGL7uc466cyiDXJzfWiyWu52Jc46Ug
         JY//TD/xGdkMuFLZtOA7BRBoyLR5GChBCghkkUzdUsxkgYlP5y9Wu2DFB7eSFc1b/Euo
         sDdA==
X-Forwarded-Encrypted: i=1; AJvYcCW06/XMUFQup3UR3FVTTDZ2UY+cOSbkWwd2fFxUzgeobDldenFF3Wf06EWSMp2H6mdWFa+FuO6OidA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQG50940GwUNJ3Qx3SBZUyWN54TLy7J87FcSrht+CtPLFDNQWB
	F4Jcxaky4eePekw5Cq8rStbB7tBxJ0n5YpGl191La2zxgSQRDluK9hpMv+BQWeOMz60DQTwfUCu
	ZVTXvN0/qCvBxDq5A4TBr72OtgeH/+xA=
X-Gm-Gg: ATEYQzx/5TIecz0wr0M3yf6cfJa/5L5ug3W3IOc7L7TNcc3KigDzuGC+Q8qj2ne2yHF
	U5bZWF7k/Sa6Xnns6ldgLiecMHsYrMf+QoFSHv8f0hiRi/Ajc2QyZnT3N5X/ZqRFHRGDSMTb0Hj
	RUH8rXlSPo2LUmeaSTOORQtiF3RdzeO399h3PAuHmiV4kdbl/D54sfwdhIkWuQIRZ0/Ujk8KpcD
	Khxz+H1v7UJl+L7j2VT1yyT68WGNxc3INL031zMDQJwzZn/k8ANDveIufRX3EieY3LPff7KxqxN
	5f2DGIPcdQn8ZDgeR8GxpaVNO3/q2l+O4hUthaFlCyRHoom11bjLGOrk5DQt+mzSPQn7b2NqZf8
	6Qw==
X-Received: by 2002:a05:6000:2004:b0:43b:5094:a9bf with SMTP id
 ffacd0b85a97d-43b527c4f31mr8413523f8f.29.1773863223212; Wed, 18 Mar 2026
 12:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318124450.163471-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260318163451.GA45978@bhelgaas>
In-Reply-To: <20260318163451.GA45978@bhelgaas>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 18 Mar 2026 19:46:37 +0000
X-Gm-Features: AaiRm53vsowSxkB5--4HeT_RVVv_RKIJ1zLa_k6p-WVMbxRBxgyHI8U3GVl43Nw
Message-ID: <CA+V-a8sTKuPnNs-shtDAt=J4n2naBoEhsTsck5-ZfJqt7wwRuA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: pci: renesas,r9a08g045-pcie: Add RZ/V2N support
To: Bjorn Helgaas <helgaas@kernel.org>
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

Hi Bjorn,

Thank you for the review.

On Wed, Mar 18, 2026 at 4:34=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> Conventional capitalization for subject lines here is:
>
>   dt-bindings: PCI: renesas,r9a08g045-pcie: Add ...
>
Ok.

> You can easily see this with:
>
>   git log --oneline --no-merges Documentation/devicetree/bindings/pci/
>
Ok, I will make a note of it.

> On Wed, Mar 18, 2026 at 12:44:46PM +0000, Prabhakar wrote:
> > ...
>
> > @@ -152,6 +158,7 @@ patternProperties:
> >          enum:
> >            - 0x0033
> >            - 0x0039
> > +          - 0x003B
>
> Other constants in this file use lower-case hex.
Agreed, I will switch to lowercase.

Cheers,
Prabhakar
