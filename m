Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04865385D6A
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359973; cv=pass; b=gtTonNTO8Ww52MiKOG8tNjoi7XMg9rfqtkU8yvEjnmC8jO/L0JTuDuC2tkJHtOQhyaKWD3sn7V4ewqbg35x6HlIlF0FykadIDtk1OSdp/JWrBRrrDNkdweJyMx3IPN6vXqzWlYe7+efOanzDW5gmR7Gd8VE4N8qKB/1xwlneDTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359973; c=relaxed/simple;
	bh=XgCaPEGPE6A6McozbCIYUJY19fPlvYbKoa8eUxRXVTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ad86x6eDnalKp6uzXot99V4RSABPyFJu5HCBNhjVv3nDGvaZi5NQ6vEDVY+9Y3nGIpseXAi2zrJOhXp1kUhCTrTPp24Egy85AEua7BQTkzKhlMfAOepxmzk7Icsi9+VoYX5f0Bg4NH5yZ36T96GPEWX2hNu2/dvVmu0WnpkyVhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1T5UH59; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1T5UH59"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bd2c147abaso35464165ad.3
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 03:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779359971; cv=none;
        d=google.com; s=arc-20240605;
        b=ko2Isz8F8aBJzjcUmUGDV0/2nTxc6GNl8XcupCDKrBQOcWa1MZ3IurgsMMzle1Bqwp
         ttv3bZTlW2+ubS/yAeLQvhLNaK520m1LcrzMkTm3m/ordTXdxHDwtmw22pJ54vrRzRIF
         ehY79rRR/6bg89H9gqXmyDM1kx0zY4KTnhAV2ozc4mKstRjory+89C5Nagw1EywCYlPB
         MhRlfz1yFRg89QKaV+k2Mj8NDDz+jMbd1DlquR21gbWQxZXgAzRqCZEKaQSCm8DY9g9h
         shkm3872jJn2WQxU92CQz5BrE6cWyY5pLdxQh6Ct/S8zNGtedKImo8cnJfkajLTfNBSm
         5QrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YzbRSiwVtVkKoQFKJHFzsnzK4/HqohXOjCOnRd8yB/8=;
        fh=bbAe6GWMEcJ46/XHH2PZK5WhltBV5yBgl5JUCfzR0qE=;
        b=WOvaJ/CD/phZqxNAtkK5R+rWtTuNOEdC7cUcFlC1brovHU+cKeQI/FcoPp69Bz3YaK
         /TiJvq2LWiWH17N0WHky205Rby1OSmspLuk8V/sX8u1yiXHkctv9aIuEDPnxj5yesa2q
         X/zfrEjCDTa4z3f7A4PAW8pmIbvSvUVPIvQ/SP/mVzeA0BrLfeLXJdIFR7b/uuIx4bO5
         rvYVp9rVCpqKkqOLNnZBAoGsaw5awY4MRJJ125uZOVjn7IekLhNUc6Ze1YmCNTOSP4SC
         mEs8lZX2P+wqTjga7lNbyu31BTrUx7vuBdTo8gauKlMWrT70Rfk5M9nE+P04UKVtCe79
         +qOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779359971; x=1779964771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzbRSiwVtVkKoQFKJHFzsnzK4/HqohXOjCOnRd8yB/8=;
        b=O1T5UH59+nE7ll5/zz7+Lw8sveigCjkFpb5bZAwm0KKdbCUSUMOVOnyKVzjpS3LJzE
         376KUDaDXXjgqrKDadqzw1zDsVC5HlSShW8fVBoBO6weAiboBOSOt81APcGCFWwfylAB
         nxux+l/xtZKdSIXc8mdpUsD9ZElSbp0o+Lzyv8oaP56A5kT5JVx8h8NcAhDSyIoFN2XI
         U6pFTzhTEJJ/EXcEkTMUgtfQs7/Y9cR5/DopEOpKYDMBmFzwyEOEBJZuYPF8VB+dhYc1
         Xj2sOCQB/9aiB7X0Cj7Jfe2W5StaVXCks8IE9Z0kLukP7UhzhYBebXgPulRFbE073BiE
         EWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779359971; x=1779964771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzbRSiwVtVkKoQFKJHFzsnzK4/HqohXOjCOnRd8yB/8=;
        b=LExLrqNNj7k4CL7dTqLgR4i2aha5AV/XbI4rBKOtCECPH/S0CufgjrAgT9dDIA2PIh
         z3oMUjTUU2emhZvQhvr4OKn421tonJ3eN6ewiyaVdeqKdP2+fvJXOm4bI91bOWM3FEYQ
         XysWgG/7JBL+VxWJh1geqvp2XrOAea1yGJXyz+pxXICt4XISRw85kElUWl+ErmGv3c4L
         j+FN/UNQlXZJJUfnYx41TpjLoQBl7jvvB/5np3wD2RLmBusjLoZ36LxAopzbiJ8kCY16
         5i8+mj1lWvcNh7mtiAMBw6Q/r/Gg8d5pHQcAqXEMYV0lzlatVaZF8AtVoYRSlzpaHgeU
         w/hw==
X-Forwarded-Encrypted: i=1; AFNElJ/Iq6zAXEG+NcCvzUOJoNbGJGm+ginhvTWpXBhjHiIhX82PuyxdfBVeoMubl642coWP56sQOfB7VvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNg4SuX3TtegfUwYcVMnG9Tq29QH9fgnWsZu3XlJGWRtrX51o
	2dAcc085kYI8fsV8I+W2onSEtpzhWll/kaLjYwcepA+zy4DfyFC88N/Z/3JV6JqoZhWP+icOsSJ
	fs/KuO/JZLmmM1e1X7By+8WSwNPetns0=
X-Gm-Gg: Acq92OHNZhQy/yrpaLs3q/0/SK6158NFFmoJqTpP9FlfYC28rbAloaUH1LvuU/0p17d
	oUxrh1WKEht7JRKGwa+N1JEd2+VkD/ZAECFUdOK7MShF0ospVC1B4XgS1fPpUumCi+LRzaUZY0o
	/oDHYXPhgjs1rSYc36hQI+A6W2OfwyMiJcOUfOVKQV3lX8zdeaScD5XRLGIsE+kJlu4hicHUFGa
	ok2MFsPuQ0B9Go1bksJO/LAYT5LlADEH1xaV/Rlc7pKWhFuHkBjaZdPlmV1+omUOC7rYcQxhwnm
	PI/WwidJOQbWYAltd5nb8ef0/Ku5jEBz6yMUbZMCD8XORtbdXDHZd8CRPsLBYLiZ
X-Received: by 2002:a17:903:32c4:b0:2ba:839e:15cb with SMTP id
 d9443c01a7336-2bea307f84emr25410095ad.27.1779359971034; Thu, 21 May 2026
 03:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-eswin-v2-1-a221438a6317@gmail.com> <2d07dcc6.66e3.19e495d208f.Coremail.zhangsenchuan@eswincomputing.com>
In-Reply-To: <2d07dcc6.66e3.19e495d208f.Coremail.zhangsenchuan@eswincomputing.com>
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 21 May 2026 18:39:19 +0800
X-Gm-Features: AVHnY4JnGIN1_IEDkvxVlmQfenJ1HLVPyPeOUwtwRnJ1rRSYp7GlpkloClZxt-E
Message-ID: <CAN4SLj1=93DH56yS9jmJ04K0XOq_TERSThEWcYeYrYdVrhaUOw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: eswin: Fix resource leak on dw_pcie_host_init() failure
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Yu Ning <ningyu@eswincomputing.com>, 
	Yanghui Ou <ouyanghui@eswincomputing.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 3:08=E2=80=AFPM zhangsenchuan
<zhangsenchuan@eswincomputing.com> wrote:
> > --- a/drivers/pci/controller/dwc/pcie-eswin.c
> > +++ b/drivers/pci/controller/dwc/pcie-eswin.c
> > @@ -182,7 +182,7 @@ static int eswin_pcie_host_init(struct dw_pcie_rp *=
pp)
> >  {
> >       struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> >       struct eswin_pcie *pcie =3D to_eswin_pcie(pci);
> > -     struct eswin_pcie_port *port, *tmp;
> > +     struct eswin_pcie_port *port;
> >       u32 val;
> >       int ret;
> >
> > @@ -252,10 +252,6 @@ static int eswin_pcie_host_init(struct dw_pcie_rp =
*pp)
> >       reset_control_bulk_assert(ESWIN_NUM_RSTS, pcie->resets);
> >  err_deassert:
> >       clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> > -     list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > -             reset_control_put(port->perst);
> > -             list_del(&port->list);
> > -     }
>
> Hi, Felix
>
> If removed, in the dw_pcie_resume_noirq function, if the execution of
> "pci->pp.ops->init(&pci->pp)" fails, the resources will not be released.
>

Hi Senchuan,
Do we really need to release the port related resources in
dw_pcie_resume_noirq()
when pci->pp.ops->init(&pci->pp) fails?
And why not release the port related resources in the following error paths=
 of
dw_pcie_resume_noirq()?

Best regards,
Felix
> Kind regards,
> Senchuan
