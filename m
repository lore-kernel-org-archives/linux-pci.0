Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688247D46D
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252524; cv=pass; b=F5HTisqVhF95cR8uQEdEdYojcOeBrdnCQEkPvEWgiSv3A62j2zoT8XaCIPd4xS6BKfdvxAWHngEQnbR/XBqy/AMkqpE9qYdyM6MoeijTCxOXMbV33EJNHasfRCC3sE7/BLVsnFQMdtCkwhp7dHzEPjPROigCJfm3wAEUNaIYfGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252524; c=relaxed/simple;
	bh=EvGodLlEbslRWzVQvua6EH6r9eVohRL7wEOeWlhU3Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Skh3bQF/C6qJSrXCwNHAmwPl4/ml4jMNg19FKpu+46iBYmp+bunlJ2oPstGNPrGOeQfovn7NFkeO4kMGeIQ02pp+loThpfa5hL1idl4Erb8RtWLD6+0sGMNZn7hWxIY78fSgWTkN5WNIUsg/71fdEPXhmBozlkPW+iSJYOhty2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePhEyO2t; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePhEyO2t"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso25155175e9.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 05:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790252520; cv=none;
        d=google.com; s=arc-20260327;
        b=W2+8ZivkElao9yMWCCQaoTux67xj5x9HTg42c6nFJoNvHySBeTT/SZx8OvxPzTzzk6
         3w7kKgBklXAtEfdjKXbBLieTERigXHEB+TB8iY58Xz9WhroBcxfcpyzzsQaqO/FhjNu0
         IdcgWhY+2oTNfShVgGc84/CxUXBqbLvHQl7XB/HL1N7vrojNndsbh6H7ffSrQrVl7JmJ
         WFs1zDVAsO4f7PSdR2eUKmfGU/mHunQPs/jZKlSbFBAIn88tPoB53pB+48K7WfK3JHk9
         BMmG61mQyixLTvrLq1wRQ+b7qVItff3k6efXIoBYb8DQd+6nawVZS6/GUAUZ+ZvA3JEu
         Xv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bkDqHG9FQUeGbwC5soK6us7Sx1oxX72NgwVfnkQyDfQ=;
        fh=p7gW/DLhzTlp/cozmoicOC1K2DqKOgwVPaVEjA01Mf8=;
        b=o9aNmN3yh8ge9qmcAjATpal5964FgsEGxOoVKBZL2hQNuT4z/wvkqeuTEPWjCjDeMo
         eGJPR+HMznNWIErYS2Dx2KLFDtJh6FmAlgX7rul2Z7lxdbrr9SWL7Ou8AdZpqBh7bwew
         dlE+4xdlcc/L+KOtjdNi6O/lFwX08QWdn1hRw0Ji0Vq3wC1KsmwrB+pNjz9Pma5s7I4j
         cHnKmw7ybKu1ox/AWQHwd2CEIYq4RyATUXO/kheTemISpWrYeitughoAbSgJIvSz7VPv
         O+/6B6b+2nM0MUPnsvzPkDXITq1GnsPmFn20Za5L+5naILS+ANBn+A72vaHW7QTLbQry
         MH+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790252520; x=1790857320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bkDqHG9FQUeGbwC5soK6us7Sx1oxX72NgwVfnkQyDfQ=;
        b=ePhEyO2tW/V68Azdc1SrOFp8Egk1JuGFNZrprJGBOjDuUNXPzVfsrijDB4CY6IXq4q
         BEIxFRZ1m/nKocoki5oPe4qRwWHCqwgkl+39McIsMfxU6aQdyPi9+VVJvSyFYfct8MZu
         v6UlhBteJLmY9LIlCHaWz3AvEzgsWnmMME5ZpwG1K2NDgDdwNL9ho75gZmsGSbUkGHPs
         xdktlGnnTWTUtRJtJviZo/Yy06ckRfVFYi+G05IWtUy0JKL84NsDvjEnVPrmQ2uAKv2g
         98HBVHPpRHbv/HtkybjnoU6jFNV7SuS3Oe/B0dRGFTiCemfEfGyc3QNgrbUscrbXNNo/
         hNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252520; x=1790857320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkDqHG9FQUeGbwC5soK6us7Sx1oxX72NgwVfnkQyDfQ=;
        b=K6GxbE2570lZZN33Edwo0o+3k9K/95LjCKb+rjlmm+f8nI3QHIr1qx2ZekrtUQW8VS
         MB21TfTLe06oCWlm3De1FWLF1kxBa2rhmt0UwR9gcaCl7D//bDTlv9rAqORTKhBNNb5Z
         zcGucftyaMH9ECMndHOAk2IkNlHU9icnyyVNb2hLVYAglywVYJR0WvEpNvkXMdndAi6f
         FFkE2aBbfzD9xAZuDghYdJqlT+CRUFgf+c0ur0wI31FajfIslP1B6mvVzjp5qiNU73AA
         9TnGDdAEhGugTIU9F/lMAnu9JhqKl8HuarMfhV0U7CJWgE3goD34zZcckiMDtqBAEu8P
         uOjA==
X-Forwarded-Encrypted: i=1; AKwUvBxfPSnHpf/aX3slpdvkxOSRx0uJTLippsgyj62N41Oolt6lLOW99oz9A04Tunu85/wPPFslucU04eI=@vger.kernel.org
X-Gm-Message-State: AFuF++mM67jyL53ddvjbiZ9uT0FXLLcm3649F9lCWyus/0wC7Gzq8RoC
	+XPrFWr5nlKPaS/WxrslYRTeHjQOv4Fk/sXypXP160XEV2km6o/x82jw1AGyX2QydUXH7NnIIHP
	otR8+Cutu5sQ5fgMyvvAsny6iaPOXW7k=
X-Gm-Gg: AYBFou2IkQUsbs2EV/BCd10CEHU6i3vYYvDWWZlf6qba1BFj48kENyjLTraUFywXsPD
	hLdgyma9XWaKaXVhQEvGNlIwf3LkGFyCsExkLWehT9O1WIDJ+TvRgcbTPTnr0j3raTUsUJFI9w7
	6OOZ0F5Pv8eZd9nh0Drj0AnUme+3c6izXle36QqFG60O+AawboldaZuI0TWv2O5fjdbdeSrMNeT
	b3UVIL6csVh2g95x32z7K1n/LfxR3Any6I5djljMtPphBxVsZowUUpbfPruas7UN7/pSQPV9FNw
	sClrBuPtWyYmSr/1z1qRsoAaA7Ch4r5Yo/RAi9KM1cbPc71QD+lpc0tjXdLls8H8Z+lmjlx2Mom
	XRaNupB1ysB2eGiZzRCy5yIfBxrhrbt2cBQv/pcYXu5o=
X-Received: by 2002:a05:600c:468c:b0:49f:bd3c:bc19 with SMTP id
 5b1f17b1804b1-49fe66f4cabmr36315625e9.20.1790252519986; Thu, 24 Sep 2026
 05:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922144629.586997-1-claudiu.beznea@kernel.org> <20260922144629.586997-4-claudiu.beznea@kernel.org>
In-Reply-To: <20260922144629.586997-4-claudiu.beznea@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 24 Sep 2026 13:21:31 +0100
X-Gm-Features: AclHuK-O6h2RuWBPz-mV7C0IwMn3AQUXjZUOx9GCiSmdjH17BlohJmlvE2MoUV4
Message-ID: <CA+V-a8vicb6j9MAU=E_AxXr8JV3ERZGUz4TBWVCHD6nS4e-yzQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] PCI: rzg3s-host: Drop nop instructions
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
	claudiu.beznea@tuxon.dev, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:54=E2=80=AFPM Claudiu Beznea
<claudiu.beznea@kernel.org> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> On the RZ/G3S PCIe IP variant (which is similar to those used on the
> RZ/G3E, RZ/V2H, and RZ/V2N SoCs), access to the PCIe Type 1 registers
> requires setting the PCI_PERM.CFG_HWINIT_EN bit. Since this bit is not
> set on the code paths where rzg3s_pcie_set_max_link_speed() is called,
> the writes to PCI_EXP_LNKCTL2.TLS are nops. Drop them.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - none
>
> Changes in v3:
> - none, this patch is new
>
>  drivers/pci/controller/pcie-rzg3s-host.c | 5 -----
>  1 file changed, 5 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 0ef49bb5ab1a..362aa923978f 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1144,11 +1144,6 @@ static int rzg3s_pcie_set_max_link_speed(struct rz=
g3s_pcie_host *host)
>             remote_supported_link_speeds !=3D max_supported_link_speeds)
>                 return 0;
>
> -       /* Set target Link speed */
> -       rzg3s_pcie_update_bits(host->pcie, pcie_cap + PCI_EXP_LNKCTL2,
> -                              PCI_EXP_LNKCTL2_TLS,
> -                              FIELD_PREP(PCI_EXP_LNKCTL2_TLS, link_speed=
));
> -
>         /* Request link speed change */
>         rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PCCTRL2,
>                                RZG3S_PCI_PCCTRL2_LS_CHG_REQ |
> --
> 2.43.0
>
>
