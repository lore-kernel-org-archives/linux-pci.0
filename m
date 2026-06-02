Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D878731F985
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429318; cv=pass; b=iq0VWFdiYZ/fhN2IFtgWbKRt4gikfbZwINISu0rvcueE/W+Kw6rV8WfVUBIvvZwJV81evHYGqLx3KUEZPW+aC9Mb3IVrV+e2bowIFZ6zaL+OWLn2i/8GU9u4crcpd4+5fQ9hZLStzveYCBBNoX3KEFIKXApcyNK36mNBSSpukh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429318; c=relaxed/simple;
	bh=EBlHZlU/yQb6bBWjzw7fMGP8qSSTAGTVxYB6n+3g18g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5rbRYMfbQU8VXMYo8h5gmoBuZo/o1koonEw9VodQ175/EguTtNHP47bc7cdNQ7yHhMzvKNNPJXRZOFIvNwvHM4aWoUvsiOmlTpY5zMPzxy1kg+n18mjM5oFBf57nJdDCNXmxRX361pXmpPksVjpDUz/Vw7qtl67NKIvbB6HRVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGV2txhM; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGV2txhM"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef29c5561so2643860f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 12:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780429315; cv=none;
        d=google.com; s=arc-20240605;
        b=aHH+PfkYHVfNdvKL+BvacAHwkYw3IZFuzau58rSUQeae2BxS/19mxwDoFlFjbzO0cE
         BV4OFzry0g1VZac7OrWt+LdJgdJcxxR/D4lqhC9yaH574nO7KXZ5m7Mkh9Xc/0gpiAHD
         uIzh/pv9c7GCG0SSI0jNZqZigztsXeyo39GcMHNlyEyMsE7D6RUu1XwUuCSwk0D6gjyr
         dCikucYgrBjLaPYpAZWRxe5bU6pTs9qJoptTWy7KsjurRkWnaN+sfWeiiewBN+Fp/su6
         0aO9P9vJvSJNOxRHhhFmqUCdP3VBIxmuKENWTcWtTJtSYRKOPTgugMs7BgICTi7RxXmk
         4a5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sEMh5W15s3ZL+Zo+DJX6OYmqs9feRMkS6Ofgti1mA8U=;
        fh=U2NJlVqfa0ikO8sepxEsjA482AhZZZSukDsqM3S+O8U=;
        b=D5WyJY024RTBS2xfGSt6RWwRsXe4eY3lGxgesStVLaWwPmGOPlK89U5WloqPUaO5Td
         2EMhobWX1l05WJBPdV8bhgyiBXaYz2wmt4t+g40AMJ8k8qq6qol+B/1DKVe5taEQHgL8
         b99lKy3l7sAnZ6y6FmIKLlu35t9p7sMBGX1oW2KBEjLebnGNo2HjiEJi9W/WINPpgPyZ
         fA09cFdXXwT7SjBdGOGjSWIRGMND1kXyLHzJQd2w2hw1H7ArVPvnOGeSS8g1+j3JTCSi
         nS21+ITUMvjnJ2zTEYc/NZe82Eio2IXZArjU8fCX9haE51JtOa5v74Jw7RFpjSAJLbyz
         2LgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429315; x=1781034115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEMh5W15s3ZL+Zo+DJX6OYmqs9feRMkS6Ofgti1mA8U=;
        b=cGV2txhMoLt57fIdn+/Nh0eqKujDeRLSChuzJd/mUtIXSsba3ameMWIW08BcR6nRIy
         1nj7HsPcP+sDSkgZFTMm/4xeKqW9Ky9MW9gkEHCHIlNthG2dUcB/PDxCBWM8WgOSb+Fb
         6c1eFowSDblf4cfx4pEK+xE7tmByy3wGGYVdGfR/gyZsLXt8lMY6yG/Hy7UPEM134Xdc
         gp4F3X0/+50gG99RrgkReoHSXVoaAz1LGhMXeQY5gv2ZLovTlUNCt5sK0wcbUVdZOU6W
         5qMqVDnpzvPY+M9zxQvZXFAI8ArwRbaKoD5HfhNCFXTRaE396atPTFc1UrQbQQFnRB1Q
         lihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429315; x=1781034115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sEMh5W15s3ZL+Zo+DJX6OYmqs9feRMkS6Ofgti1mA8U=;
        b=iCNCzFDZe66joV3aHJJfpg1Pdifs7stS1Syc/vdLbaBF1dbp5ZCkrGI6iNTl86NS5e
         /ROTLKlT8xTjuzWTmulhUgl1kSSIDLfp7PKpmeHho87gCryNWtFEMxTrWofYaNa2gqwe
         jhEwygMombhn6fdJXITZrHWUGumknuitS3/KjephU/LeZ0qyDcZ7NsqU8Q/O90I5Tntu
         zxFlXf033PpJhSRuWv1+alFY98qWcqzjz+Bi2Txe8Mm41AhmYjlHrOn7q7T3ihGtIUts
         j03ctlao2ibOh8j4HPYfZZmoeKylqM/8+esWvEy3giAnlGCl+K8tW0x0E7ItM4Xseof4
         3ytQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Rd9pJyekmmrr6XIUEGleWL2IkD6ZbxwQTduTsOcDPVJ0YCI8Sr1AcBI+utdKAMwcq7ykRCv3eV9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKuH2rMgD8kiaEzLXcb8dYmpD4sSa+RoMQ0maa8NkcNJoH9bKd
	t1W/KqmSk1ifLOwG1GAslXVzryOky9iaIOlHg4wRYt3LOgLX2okkQ3qyM7jDTwDHPbFnpypqGQs
	NQQd/loOSaZwe61U9w17wXLG/NvZi4Mc=
X-Gm-Gg: Acq92OFOw2uedHa7duA7Ekp5RKgmtWPJuB3qVmzAYTPXbw6KVBkriEnRHRmGjAKmKpK
	nXsrurzfFCUFIss2+urxTljLXRnwL052/few7lfMtQFbBoXW+zNLcrOnYcg1VjIZcrJrcY3SeA4
	kNpNRt46cvRNVZTVd9TmYztdkyJK+tn9kSUdwlsgtxhkmoQkyOeAuecaQp5OoFA8Y/ddq0OSYHW
	yTKFCuKUbEbSkrmgNtIh36nyu4hEzYBtpZmx3Ro+V4fK+fuKdYRDEJRW1aaxhb2yjgDZyhSeneu
	Cdz2JMx0Ry2OnAvbOL8YqDJz4HkN08RcarmLZaktxuufIdU3mYATwzWuidGpQWrrcFNgbGn6fU4
	RBcu6dxjejYRzioP4IljTLS+hxEaNP9LJ3GM=
X-Received: by 2002:adf:e508:0:b0:45f:1bd:a04d with SMTP id
 ffacd0b85a97d-4601f4fac09mr882189f8f.7.1780429315314; Tue, 02 Jun 2026
 12:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520164823.436992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260520164823.436992-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <86e80877-b860-4b93-a5ae-a416840eb393@tuxon.dev>
In-Reply-To: <86e80877-b860-4b93-a5ae-a416840eb393@tuxon.dev>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 2 Jun 2026 20:41:28 +0100
X-Gm-Features: AVHnY4LH3tVnbhX2kihO8dGiFPGS7IjVgtm6CenunWIAP8asGwsAHQWQnCcdEGs
Message-ID: <CA+V-a8vR0tOXdMZcA4fi+VykwHokHQqm-s97UNKMbPAaq-3ctg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thank you for the review.

On Tue, Jun 2, 2026 at 9:00=E2=80=AFAM Claudiu Beznea <claudiu.beznea@tuxon=
.dev> wrote:
>
> Hi, Prabhakar,
>
> On 5/20/26 19:48, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add support for the RZ/V2H(P) SoC PCIe controllers to the rzg3s-host
> > driver.
> >
> > The RZ/V2H(P) SoC features two independent PCIe controllers that share
> > four physical lanes. The hardware supports two configuration modes:
> > single x4 mode where the first controller uses all four lanes, or dual
> > x2 mode where both controllers use two lanes each.
> >
> > Introduce a setup_lanes() function pointer to configure the PCIe lanes
> > based on the hardware instance. Implement rzv2h_pcie_setup_lanes() to
> > detect the configuration at boot time and program the lane mode via the
> > system controller.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2->v3:
> > - Parsed controller-id from the "renesas,sysc" property instead of
> >    using linux,pci-domain.
> >
> > v1->v2:
> > - Updated commit message.
> > - Added locks to protect shared lane configuration state and
> >    prevent concurrent access issues during probe.
> > - Added cleanup action to release lanes on driver removal.
> > - Reconfigured RZG3S_SYSC_FUNC_ID_LINK_MASTER in resume path.
> > - Renamed num_channels to num_pcie_controllers for clarity.
> > ---
> >   drivers/pci/controller/pcie-rzg3s-host.c | 180 ++++++++++++++++++++++=
+
> >   1 file changed, 180 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/con=
troller/pcie-rzg3s-host.c
> > index edb49af7429a..15879b2c0bd2 100644
>
> [ ...]
>
> > +static int rzv2h_pcie_setup_lanes(struct rzg3s_pcie_host *host)
> > +{
> > +     struct device_node *np =3D host->dev->of_node;
> > +     u32 num_lanes;
> > +     int ret;
> > +
> > +     ret =3D of_property_read_u32(np, "num-lanes", &num_lanes);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * RZ/V2H(P) supports up to 4 lanes, but only in single x4 mode
> > +      * for the first controller. Dual x2 mode is supported with 2
> > +      * lanes for both controllers.
> > +      */
> > +     if (num_lanes !=3D 4 && num_lanes !=3D 2)
> > +             return -EINVAL;
> > +
> > +     if (host->controller_id =3D=3D RZG3S_PCIE_CONTROLLER_ID_1 && num_=
lanes > 2)
> > +             return -EINVAL;
> > +
> > +     guard(spinlock)(&rzv2h_lane_lock);
> > +     if (rzv2h_num_total_lanes + num_lanes > RZV2H_PCIE_MAX_LANES)
> > +             return -EINVAL;
> > +
> > +     ret =3D rzg3s_sysc_config_func(host->sysc, RZG3S_SYSC_FUNC_ID_LIN=
K_MASTER,
> > +                                  num_lanes =3D=3D 2 ?
> > +                                  RZG3S_SYSC_LINK_MODE_DUAL_X2 :
> > +                                  RZG3S_SYSC_LINK_MODE_SINGLE_X4);
> > +     if (!ret) {
>
> I personally would prefer:
>
>         if (ret)
>                 return ret;
>
Sure, I'll update it as above and send a new version.

Cheers,
Prabhakar
