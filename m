Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792485965;
	b=3MwlBWcRz38m8N/sUFAIC82ZijddMQZsCbK+O325+XiRXxyD+kXyLV4XG48Gwp1J80wN
	 W70sDrXu7uXl8FnCKXybcfkBapqathZz8/fFTYm9IBIuIvgVfekK8YidEmQLdlIdDjPg6
	 qyilD6r0/Ordw9wm2WF0cdwiUszxX7vLEh8KP9Nud69TCf+GMoQaQ9h6lWgyP3DD69t5g
	 eklQTJIdCCGxJ0fhIycIEBGP/u7ULk7yu5+e0y88ncF+HMter8NejIJ1333Zrfs9Sksrx
	 S/DbNdHn+Dh/jkc+N3xZAabsXftx+SrY/R9VpnfMutyz26Nwx7JH78jkVGFLo8qYxtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dPaUlNkCPLziA90hnNp1lAWN/FLqY45sp3q9cJ5rzKc=;
	b=onnbHzKzorcEKD9bf4ry/SGjQOp1/0lQi5NM+mmM77kbvcTvqg1IB0IjKGUUrmc9cXVh
	 Id7pHJfqFGhtLTdt6xeDF+okJDOXr/9Ipboo+e3Uw9OQjsTaM8YVyVAFELRhOm306p/TF
	 slGNfS85ktY4PnwxSsKiqj2C3BOM1CxqMOSlTZ/pl09M8tRDTZvtTR88peRyxpNZ8/IY0
	 5nziRdJpoHQxLLHLvvHCl3UGoQvn+3BJF8v0GZnSFBhIsKd6c+GyBc2U/jOelPCEXdj/s
	 F++AtANICC76/OdxmgkifRhJ0ObVa96V1PoIiC4pA0qBVgY+TJ5/jLRiOswXniW1vCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EOxh4Z9f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6D360A2605
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C6D360A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EOxh4Z9f
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4d870d54so1934451f8f.2
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 01:46:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792485964; cv=none;
        d=google.com; s=arc-20260327;
        b=gmVeyRfI1vb+BL16E4/tJc78NOJhw8QVJX81dUKNqE2OL2nhFjXBeV/n2qygLFLwAi
         QdbAsWfonntEsCDgulc9j354lN4p2OyhLTGF9QRS/sNDtENwiLj1FQFUZ5LqQ/Mz89dg
         r9wzHPVYEAM5am0AY2nXLanjs5wlWviNWULBGm2Wpud19k3BdfPcNy2yUb5a5z9z6+uH
         3tJMb1tQqQNuuWxcZTQfuCKSg2O3eAsjh+LMy+FrCR9iMevzu/06AO0CnfoKJDvqujx7
         WOEINu7NNeo9jfeLe59D1RU0LE2KPcOY4Uw5H1V5Gxy2yZEJJLHTTxq36iRUu/8bpS/a
         A43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dPaUlNkCPLziA90hnNp1lAWN/FLqY45sp3q9cJ5rzKc=;
        fh=shWMrgnVQl3oMbwIjyzT36bD4XBW3XS/Ct6yidiSxMM=;
        b=CAYTOeH5a0zdDLqxoKlyHT/qSJ/37pxZR2J9usbW9fuAtCzF3GcU39VSb5iVg9t4ol
         fbC4RGBgsbi1hG0rHvznt76qNpAUZ8soFcKx7s7hrnDIYEZu4uapfOnSYaGlg8ktVAzL
         x9yAjPLuIQgtOeC/WrRLiwcMJut6Ec/ZdwppfvXBUAc8jJqrhRBFKj2/KfUSCXBvAlk+
         MgNkVPLCZOz8t1lDUL3ttuy1CoJwHPUen8SHgHs5fe1cY5fE4a53Xq62V5D+TDRE7fzj
         rEu5CJvYjusluIp8MLRyw0bT+zr92Vu5Qvg6+Dveak9Fgb6ums4wndpTf/eRvsa/v/mR
         YKEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792485964; x=1793090764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dPaUlNkCPLziA90hnNp1lAWN/FLqY45sp3q9cJ5rzKc=;
        b=EOxh4Z9fRoRRWu9Bm9Z1tMLnFfM66s4Xo5FSgm6P97Ssxb2g2lliXffr40zTofIYnQ
         s9EDK4fYMTvAII44PVeoCGqdpxWOewXUdkwzhK0Scw78OW9ZRumBAGz7QGGl8Xi7A+gS
         7KEYnrbwreEkmc3lqEdsw+l3qs/LoVavXszWMkVq+aOr/fYv5yyJVehmXvT4cCDcB5vW
         V8/VvC1+G+WH9tZQV/G0bNtq+/gWXbAOf15ey+qK8wsBCsdUvaZjVipaPkI4m70fTwlX
         HoR798GKWTlqfKktrtQpdgwmrE/1Cfo7Kz5sQnKx20YzGWxuwB1j5FX+It3tmWUr8jfB
         oASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792485964; x=1793090764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dPaUlNkCPLziA90hnNp1lAWN/FLqY45sp3q9cJ5rzKc=;
        b=IZEVzPh8pDWkbj73IxKWex6aFHMA/Oew5yT9LJGq8oyKvOp1VyfN9bqyosQ4zK5KWH
         J1BkZuhRclMqyDJ/0+b+RVZsu9jBFsN/ZqFhhTRgngoVj/0N6427kJqbvjp+h6GKnBxd
         iuUKb/SHlwzg92dP54WzrpbxbldPaici4ejAg2xgxmREOmQE50e+uVfLhetwBrNj9Pqv
         WMmD6v54YxJ+uunerbN1j/I+/5+A7xsyDQ9T3gRhtpHThHtQY3tI1msqBouG9XIqLB2r
         PrqMl0lc9Lymnuw5rAh/gLX3wzqmM9zqkcmqoaIBYoA6ijKngsyGSefhyzaTfZ/u7i8L
         9PaA==
X-Forwarded-Encrypted: i=1; AKwUvBzxaEbRKM+5RLy3UuHxMnZZXhI+Sd3eNwh+r4ToXxrDodJhEILPjuzv37u+yjz1QiJQHT1CJDB+2eo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWV2cahLrjp6ekTKKTOEoF1Cyl8KaANeyH3N0yaUDqIrtZ3Yp6
	IBLfGWkT+aIjvXWrVas+0YGTKCOkP8FUMQfJShukwaGhAEiRO4R3z7EPnUutbvlaHr46Nqy7huh
	G74g2MhNl3RcaN4vCN6NwnWy5rdPQjbU=
X-Gm-Gg: AYBFou3BECONBysFDV2nmNM2DaXupfont4D7aJnUqKWlJk0LoVzwBJrcS5JruRT9SnL
	6luWiY3pwkwDWMm1e6R06K5gkOCQetGqNYXPzdWcV9Nd3+9UHNo2pcDL6i1WispCUHki2U8jrAU
	cnuPcX4gaisGxldnt1ejJtPA1vr5aF02XOtceqVV23Ltg1Kg3qVuj1xd56odcg1VdPVFFQmi0am
	WGZgpw8rUJ27bmMIF6Ziw/KUPDJ5JrbpNfbxL1y2JbbDR0Ul/1J6m2KCbJy7p5qsAk0E+/xrWxV
	SOIlt7LkMBRd8SzLeeAPo3gh0y0t+udF9KSB3CJdiM0UForzWEvFy5xi6ukWCnpulQRITWHj9JD
	r8elnttiRejXhCpJ7FgSgr8OrWNKMc9zjCy6/PQ==
X-Received: by 2002:a5d:5d09:0:b0:482:fd9c:3740 with SMTP id
 ffacd0b85a97d-48e07f98e2dmr24424365f8f.22.1792485963500; Tue, 20 Oct 2026
 01:46:03 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org> <20261019065025.2146539-8-claudiu.beznea@kernel.org>
In-Reply-To: <20261019065025.2146539-8-claudiu.beznea@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 20 Oct 2026 09:45:36 +0100
X-Gm-Features: AclHuK_0o_tLTtHRdwY1U_jUmzmwgKQ2ANnJ0QG91z7D7pQ5ZyLEGjAx2_i3mmg
Message-ID: <CA+V-a8sQe-bb7AEagc8QzQYVVY27+aVF2v=x1SxNtXQagpSOUw@mail.gmail.com>
Subject: Re: [PATCH v7 07/14] PCI: rzg3s-host: Use cached MSI address in .irq_compose_msi_msg()
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
	geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thank you for the patch.

On Mon, Oct 19, 2026 at 7:57=E2=80=AFAM Claudiu Beznea
<claudiu.beznea@kernel.org> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The MSI window address is already cached in msi->window_base when the
> MSI window is configured. Use it to fill msg->address_lo and
> msg->address_hi in .irq_compose_msi_msg() instead of reading it back
> from the controller registers.
>
> This avoids unnecessary register accesses.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v7:
> - none, this patch is new
>
>  drivers/pci/controller/pcie-rzg3s-host.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index b0a150262959..6acb0231a067 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -660,19 +660,9 @@ static void rzg3s_pcie_irq_compose_msi_msg(struct ir=
q_data *data,
>                                            struct msi_msg *msg)
>  {
>         struct rzg3s_pcie_msi *msi =3D irq_data_get_irq_chip_data(data);
> -       struct rzg3s_pcie_host *host =3D rzg3s_msi_to_host(msi);
> -       u32 lo, hi;
> -
> -       /*
> -        * Enable and msg data enable bits are part of the address lo. Dr=
op
> -        * them along with the unused bit.
> -        */
> -       lo =3D readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) &
> -            RZG3S_PCI_MSIRCVWADRL_MASK;
We need to drop RZG3S_PCI_MSIRCVWADRL_MASK macro, as this now triggers
the below warning:

drivers/pci/controller/pcie-rzg3s-host.c:66:9: warning: macro
=E2=80=98RZG3S_PCI_MSIRCVWADRL_MASK=E2=80=99 is not used [-Wunused-macros]
   66 | #define RZG3S_PCI_MSIRCVWADRL_MASK              GENMASK(31, 3)

Cheers,
Prabhakar

> -       hi =3D readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRU);
>
> -       msg->address_lo =3D lo;
> -       msg->address_hi =3D hi;
> +       msg->address_lo =3D lower_32_bits(msi->window_base);
> +       msg->address_hi =3D upper_32_bits(msi->window_base);
>         msg->data =3D data->hwirq;
>  }
>
> --
> 2.43.0
>
>
