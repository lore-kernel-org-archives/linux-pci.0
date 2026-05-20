Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F93C5546
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271526; cv=pass; b=ZElMxkJRGcwc4aDN/RxyiahsJY1wKPsYenmUcfvQIs2Lljl70XnThZ2cCIHJz1xe1KyFMfWgKPxVxiiwwygxJ7/dSu4YokmmuLxRBcXMiUY9Uy0iDqY5QkCU0le0D3OIMzSTVJHRI26V8lcfYTPHtndCgVgXXqQRA52knGA+7oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271526; c=relaxed/simple;
	bh=u/6205l7iMnwqWVLXGAxcCKZD8Sogf90abuPnY6+8YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccoQYIiQuVSC99uxoxTvcWYiPiw3TRQ4NmxDc0NSm1S88dazNlc0tcXTul5Au99hitbQSP0QwNRSmyDo9/UO4RglsDrvmzjF6Rk3qX7pFT3UwS+5INVvmUAbCrbRfLX7GERAXs5wpaLo2iFGHqLI7lBwfmWZNn5n+awjJ/llsns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO1r8w8B; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO1r8w8B"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44e1860558fso2889949f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 03:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779271523; cv=none;
        d=google.com; s=arc-20240605;
        b=asvoraQuwtVt4h6ulyn7ZLIXqt4LeOT2GESMywQXkuFUZrlJsBp9ygZdormfhZC3/7
         1wzsSN0lRND4Fr1x6UB0dDuiIRPQCQJuOtDx0PIwBiQvUYRkiRlgsOWPCnKft7l2HSF4
         +jXVCS9tliJONhrPz+BFw/+ybzxkyJhmsw2m65Rga1JGBIveJiUrEEKjP7THz5TxfxXB
         iRlJAzFLBOVdO5FMFmIFOrQlfg+YtcXRUc84wTCTwX2Kg+PN6+66hVJPgFDlVornPcHc
         a3180wG5f6KE0DUvaVHX6oI49a3yHV0ykhxTcn+7Xr6zv4cWnCxePrt/CeDQljuWm6JH
         1Urg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z1h1gbTy8T7fcLJb/vcSzl6o5vQ4FVeUEqyDq65RDD8=;
        fh=7/ZU9wrWn/X+nP44EfsQwWor9KqW+Kd9+TJd+GfWmLA=;
        b=N+AiOmWwJdI6nUBiun5p1Oh81HatXMEZvxelOhGj36h3xUoPnqb7XUKaHkqRq8IA8I
         oZm4/wtpPbibNErcSs7h8Mcb/GenWJzReERKqBDN1nDy2boYNl2o79GoOMiua0zxvNc0
         NlHXCgEq6iubqVbUTls7pvLow4CcAWE9Uciu5FejgpIIAeItu7TCBMNq47SHg8zLrI2c
         GfA9ldcVhtHeta2k0FyPNpiAOqgvzCHNb8lj9taSmtjo898cH/G0lminDOkzbaepIatL
         ulZ0gQmF41R3fUwca0dhQwE58lpQCeb6o9YuAoECkidUjZKkOQEji7tTW4o+eKBS6DSX
         XT+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779271523; x=1779876323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1h1gbTy8T7fcLJb/vcSzl6o5vQ4FVeUEqyDq65RDD8=;
        b=HO1r8w8BouR0pEnM/AJYEuOy+kxkGPqRTSscTp93DfdU/ez6x3NI+r3Q1xEjLzr6F1
         igDWX+OjgWmiw6slzHkliD7wXGFwt9h6GiEc2mmro7Q4/WvPk2GBfYIJVY8RXYmWXLDE
         TKQHFM3cjcHvXx07Tt/lj62bFApCqMwTOBGWrVe59b20HMWcJX5vfcW0leiLaXKRdU6T
         ZkAQvwzT2KGZ71MGE9mph9fgKLZssS+9+UPs5WeIcReYsdnx7la1ZeU1UjTnNuIFXdOU
         /VXMgaRZsiMzwaWnkFNOSdWumfEgyM6Ji150WBwpg7D5OjqGyODAv2X994Jw6QeEERqW
         ulZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271523; x=1779876323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z1h1gbTy8T7fcLJb/vcSzl6o5vQ4FVeUEqyDq65RDD8=;
        b=JxM+4eywKcN1Q5rBNn1LvA8kJk5rTrKhtAINQkMY6LQz0YdjHCWLU1RZqQj0NZmUn+
         lbnIwA0A12Q3JQwkJ/1zhqANwcnIHZ0wTBNn/fJLar1EpG8WFbGrmL5t/rtoyqf6LbW9
         D5wctToM5Lh15MZizlNDuyt+b8l2g/pL5RUVNLa9ljEbiSn6HRgVSQvZD6LUNRh3afJY
         8+Sifm80hIka5CUbCNbqZdMr8bkWe+Om/bIOYEVcpWuVbilfS3CMd9xPbX+ebP7ckoxS
         fwIdiBEeDYxIXlskGGbLhBEappdxj+aFIaJTjdvI6Rib2rILJMiAgzuZrNnvYL80SDIP
         2pKg==
X-Forwarded-Encrypted: i=1; AFNElJ/NmXCYudIDFI/vgfi+e2vEJOyiIyL2h0S5AAQfvmQuZ2pSY7FzoxDmdEL0nC8J46PvFjfgISQbzZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzySYayW5c2z+mW2VpNrHD5RVcX+MtabNonqRKu9XyRHPr4mumu
	NeokFcBQEWDbrNKqs3c3OSWXwSXj+RajoXMnPy22bVQFXUcsvDhxS3n8QwTrkjv39QMiDxFRmuw
	J4sPebJ6CKlWC/C+857Oz1d7q1nhBHFg=
X-Gm-Gg: Acq92OF/HxV0jv5TQosE/gvw1yrNh41krTZ/TKk5Rzyg9DHCiH516um6Y4Y0gl05lCr
	3843GlP0DakJdCIQIxSvAAaNZJu5NL24O+6WKd59wi+VJvU//feeTjrjL2pXlA1zwWENAJwNNZK
	l2o7MYPRBM4+Op/yCxfwDyPf/1zkbxpKRPfxIJiXrU160bjT01KIsNofWWxw3grQ6xEVZhzdMVn
	UtzF+wrn7Rd+o/i2nOrLt1VNmNPe5U5AZIOR+pSaIskumgS8Cq3nH47Zxfn6gcQszowXTVwo/LZ
	C9K7pQIhIPUzaOJLc5dJVrk359G9w3TGcEhIox0qHn5wLDvF45vbaoEzAi0gyD/L+AnT7b8N/8L
	4rjXx
X-Received: by 2002:a5d:64c6:0:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-45e5c5dadbamr36893897f8f.38.1779271523324; Wed, 20 May 2026
 03:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520091111.67666-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUpa_R0C70eJjS6urpSx3jtcVnbjZ8K0OvhO25Bx1-u4g@mail.gmail.com>
In-Reply-To: <CAMuHMdUpa_R0C70eJjS6urpSx3jtcVnbjZ8K0OvhO25Bx1-u4g@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 20 May 2026 11:04:57 +0100
X-Gm-Features: AVHnY4IgebT0d-w8ha5uMUJJ5b2Bm3VcKLOPFArk4myqceaa3cNrfoIoJYMWWEU
Message-ID: <CA+V-a8t1osQxWOn2Veyjmy2kquKn7XvTbX9h7uGXtTje4N2Jmw@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-host: Remove unused LIST_HEAD(res)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Wed, May 20, 2026 at 10:20=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, 20 May 2026 at 11:11, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Remove the unused LIST_HEAD(res) declaration from
> > rcar_pcie_hw_enable().
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/pci/controller/pcie-rcar-host.c
> > +++ b/drivers/pci/controller/pcie-rcar-host.c
> > @@ -346,7 +346,6 @@ static void rcar_pcie_hw_enable(struct rcar_pcie_ho=
st *host)
> >         struct rcar_pcie *pcie =3D &host->pcie;
> >         struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(ho=
st);
> >         struct resource_entry *win;
> > -       LIST_HEAD(res);
> >         int i =3D 0;
> >
> >         /* Try setting 5 GT/s link speed */
>
> Indeed, this was never used since its introduction in commit
> ce351636c67f75a9 ("PCI: rcar: Add suspend/resume").
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Since this does not seem to cause a warning, even with W=3D2 (TBH,
> I had expected some shadowing warning), no Fixes-tag is needed?
>
It does actually,
drivers/pci/controller/pcie-rcar-host.c: In function =E2=80=98rcar_pcie_hw_=
enable=E2=80=99:
drivers/pci/controller/pcie-rcar-host.c:357:34: warning: declaration
of =E2=80=98res=E2=80=99 shadows a previous local [-Wshadow]
  357 |                 struct resource *res =3D win->res;

So, I'll respin it with the fixes tag added.

Cheers,
Prabhakar
