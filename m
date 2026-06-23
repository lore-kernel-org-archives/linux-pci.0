Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2A2E7389
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782203380; cv=pass; b=rlVMYX4BZEmWckLWvgvZJWEhV7oO6uJkGfv0AxNChx3iIGUcIC3X+CbD78F9e/JhXl8tL9qiVyweNVENCN0pqUgQgsLc5uqkdUdpsseFLRFuTkxdW3fQtJuFkCxnslQJ5v6si4yIes4CKKu+wog6dXYDzSQtDfE2HkWkH/j6BJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782203380; c=relaxed/simple;
	bh=C+rVe3rgMlyulc0E1pMbdDXcZKdISk0r3L7hAmE6two=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzuSTeL/o8Io/2VSHFm5+onxFX145Izw0gRIoRqMsDA/INZqf6p9o3hpml+wGXD3v2shpmVDvp245FCoCHRnegWyE9sdOvMaoHiLbSIKBCr538ea7lElJNjSsmDLC5LaG85LbfsOMzUGqLYffW2IskvZclvBRyhCCLWjj3B2fro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX2jRg9a; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX2jRg9a"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-462ebd5d37dso5140960f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 01:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782203378; cv=none;
        d=google.com; s=arc-20240605;
        b=RuJtFj4vkXrBIlJSxOPr4LKqdYsSaudti8V/nLJ60tIaz1jEXPSH0MOqqZoUEjvLEY
         2v5m6jVw42WGvQ6b6cDVe0uXuqrNHPaN7yjaLOq4XRfGNeAN/y08r70rSkErInHl5p/h
         8KmsR45G/l38pRLroP+hy30TB4bvxGxaf1M+hFdMvMIJLmAFZpOkPbVRgoFnzNV4UKMN
         CZmbYL+0TxoBpPSuJXeJSNXOGsVvEW0wPA2QvJAn1TH/eK5ZPcsARmP39EESoG3Upyg5
         FiTdBJFo2QB/WMerYE81vqjN3xyX+8Rc/oRjve46YKMyubOYEeTxrBAOvGiIdQux7Dh0
         +H0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yrBfCI0KWhncSe2793Dm3kx6USZ2APOlz/hUKpRJG0I=;
        fh=n7bADc6RdPfxQ2T1vOpt/vQAnK5uk6LCSST7zmiTgwc=;
        b=jo7CuvnNAZMrLvlLJXoVsHDoezmxVqTCVjSAW3Xj3yKWUSQovU8tiDGshd5ct23QM6
         zrLJOStk3ClhN3b6tCy1YnUDCuPRorIlzRb8RtyM89GrtK8fWWJg3Lhi5j8myg451Fva
         rSySqSbZSnRk663wMq5ffQJbFl1VnNUOVTCGLoQP0LiEZ3uWVBtPvznqytorCdXkTF+M
         etktJnRw0bknPA0hLJwKpj+ykK9vZnW7JAZz1m6QQjPacWeOLgzobcoLbFGHESC/xzDa
         y0lFa3dvTYknSJVLor8utlzwaF41LD/b3Am1CrpiB6iJq/uW4sn8CwV92E/JFamopapV
         /S1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782203378; x=1782808178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrBfCI0KWhncSe2793Dm3kx6USZ2APOlz/hUKpRJG0I=;
        b=NX2jRg9axX9TBTAw0TFksFRyFltIIlBDUJ/R1TUVoX4uRuUzeu9Q4/BLyoI/qTMdcN
         vwox3hajpR9s+XkRsvFh+x41iBOVOxNaDvXN56lACGbLR5+Lu/9KV/B6HZEyDZ0PgfZE
         aP7UuTnnJwlRGs2r7bhdNvHreBlUnQcko7ci7nCSWhQsxmN9PJI6IQrN3/7GVeBwF1Rw
         Nfj0kkqGsoOlwFPrnMM5e7i0bVFcXpn3uOAtT/GdZmV3bjlx3D8xyhbkZwryj9vTNcnL
         HSVRmMHrRDKuojRluNSssAKJXjqXbPDmQuqzk82BYSqKZRrae4INgRDCxYVDvtfSxdap
         wJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782203378; x=1782808178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yrBfCI0KWhncSe2793Dm3kx6USZ2APOlz/hUKpRJG0I=;
        b=F79HZRAB84TOC0CeiCgPteLwVsvh7rjDyPchBTDVEwOTn1UQyPM/2hjv7XW2W5Z4L3
         5fCctEKWMP77Xz5nJwwiTlCyogwcutOsFq+B5ulWu12Ogv/5dBh/HNwzKof4PBE3Oszo
         XA25GIDgSNV3FTnmlGceKaBjj+i++iUpGTERWtmRRRYLLdzJB1TjAgP9yGkUQfrFwlV2
         FQCPLwucr3AYX8nxTC3o1VWnn3zVE1mB6nvE1QkLdACNoZr0yoIzy4Ou66nQOK0rv4uV
         ZTJKfhyWGdJBT19v81qVQkqv9lCw7C/XTYWIjNoCVklv4b8eyuylBJMfDK92xwE0liVv
         7Pig==
X-Forwarded-Encrypted: i=1; AHgh+RrbCnsqdFvbaEwrFfdKJeEnSTVjiL+GwoT9JXSjknxqPwY/iq3xAcY8wJQ3zvqbn/DP0DTYJ6zMn2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk8/a8eTZKIW2a+zylPF27DxfX7sMeF+wLoT9kuF1CW3HvLSU9
	SmgDbEB4+j/C3N1JonHkjfCa8GRnButBeNKEuECpcRmWN6hT3LIw3/JVJer24ll5ylVytfe0EfG
	UI1jLdDEeOm6R7rK93cfpxCNt6L0bwsE=
X-Gm-Gg: AfdE7cla9LcJI3tA0fa8UIZCGN6iO+atQ9lsouAj5iOSzq7AxYEjlHM8IT9x9UtIpvk
	P043mmupWOPLMCaOuQMHaGPFJk4OrC15ieM6XYj+JKbTUgNX2nMPaDqx9yl0dlfxXt76m+gFljl
	5+aXku6GRP7KM+PD1CwDOupQ2k4IfNbub9YApRsTWCpm2C1+dsJ6c18xhWqznhP8ZHT5EYyYPFo
	HzCBHgDVoveJ71pJl5/fEkEGmH5FOMwMaMQwUXMHR1ZO3y9F5HhTxHWJJJ4NjZlEr0/cZegpEKv
	pbVcCVW0zoQ/bOKg05lzJjYmcvIgaC76nno+Qx6ERMnyadpx498GAtB63MI=
X-Received: by 2002:a05:6000:4817:b0:464:c5be:37f4 with SMTP id
 ffacd0b85a97d-46add279a05mr2659263f8f.29.1782203377562; Tue, 23 Jun 2026
 01:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602195019.1798126-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260602195019.1798126-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <50a908557bb3ce5f14b67396d1e73e70289a583a.camel@pengutronix.de>
 <CA+V-a8uGho2RMhreDgieOOZTggUALoF0bGyjdEEDvyL_75sAyw@mail.gmail.com>
 <fuefvecgjdqbnbvpvam4gmewmpmhofllyq2ootwi6cjqhnyoys@edjzqlh6fjw4>
 <CA+V-a8sRxoR96TRM2V3cFXS5NPiQUVrUJCWwkh7o10cGYPU9_w@mail.gmail.com> <txpkke2xogecipyetascqajgaxamd3ualcuhsibxf75llzcym5@xgcn7efcbmp4>
In-Reply-To: <txpkke2xogecipyetascqajgaxamd3ualcuhsibxf75llzcym5@xgcn7efcbmp4>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 23 Jun 2026 09:29:11 +0100
X-Gm-Features: AVVi8Ceuc3mOlVkEu2V82Unm6uncN0y20DQ8eINHTMm2bh1FOOcG0M9fbuSJgo0
Message-ID: <CA+V-a8tiRc0J74e73qLyLgQOey1GLNoa5VbRgpEN9ZCy7hH-4w@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] PCI: rzg3s-host: Use shared reset controls for
 power domain resets
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivanna,


On Tue, Jun 23, 2026 at 7:04=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Mon, Jun 22, 2026 at 03:53:57PM +0100, Lad, Prabhakar wrote:
> > Hi Manivannan,
> >
> > On Mon, Jun 22, 2026 at 3:30=E2=80=AFPM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > On Fri, Jun 05, 2026 at 12:54:46PM +0100, Lad, Prabhakar wrote:
> > > > Hi Philipp,
> > > >
> > > > Thank you for the review.
> > > >
> > > > On Wed, Jun 3, 2026 at 9:16=E2=80=AFAM Philipp Zabel <p.zabel@pengu=
tronix.de> wrote:
> > > > >
> > > > > On Di, 2026-06-02 at 20:50 +0100, Prabhakar wrote:
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > Switch to shared reset controls for PCIe power resets to prepar=
e for
> > > > > > RZ/V2H(P) support. On this platform, multiple PCIe controllers =
share
> > > > > > the same reset line, requiring shared ownership of the reset co=
ntrol.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renes=
as.com>
> > > > > > Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > > > Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > > > ---
> > > > > > v3->v4:
> > > > > > - Added RB/TB tags.
> > > > > >
> > > > > > v2->v3:
> > > > > > - No change.
> > > > > >
> > > > > > v1->v2:
> > > > > > - Updated commit message.
> > > > > > ---
> > > > > >  drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers=
/pci/controller/pcie-rzg3s-host.c
> > > > > > index d86e7516dcc2..a5192e4b58df 100644
> > > > > > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > > > > > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > > > > > @@ -1276,9 +1276,9 @@ static int rzg3s_pcie_resets_prepare_and_=
get(struct rzg3s_pcie_host *host)
> > > > > >       for (i =3D 0; i < data->num_cfg_resets; i++)
> > > > > >               host->cfg_resets[i].id =3D data->cfg_resets[i];
> > > > > >
> > > > > > -     ret =3D devm_reset_control_bulk_get_exclusive(host->dev,
> > > > > > -                                                 data->num_pow=
er_resets,
> > > > > > -                                                 host->power_r=
esets);
> > > > > > +     ret =3D devm_reset_control_bulk_get_shared(host->dev,
> > > > > > +                                              data->num_power_=
resets,
> > > > > > +                                              host->power_rese=
ts);
> > > > > >       if (ret)
> > > > > >               return ret;
> > > > > >
> > > > >
> > > > > I have a few questions about this.
> > > > >
> > > > > Can you move rzg3s_pcie_resets_prepare_and_get() and
> > > > > rzg3s_pcie_power_resets_deassert() up before setting
> > > > > RZG3S_SYSC_FUNC_ID_MODE and RZG3S_SYSC_FUNC_ID_RST_RSM_B in
> > > > > rzg3s_pcie_probe() without ill effect?
> > > > >
> > > > > Can you move rzg3s_pcie_power_resets_deassert() up before setting
> > > > > RZG3S_SYSC_FUNC_ID_MODE and RZG3S_SYSC_FUNC_ID_RST_RSM_B
> > > > > rzg3s_pcie_resume_noirq()?
> > > > >
> > > > > Those would have the same effect as the reset already being deass=
erted
> > > > > by the other controller.
> > > > >
> > > > Yes to both. I have reordered the sequences as suggested, and it wo=
rks
> > > > perfectly without any ill effects.
> > > >
> > >
> > > Are you going to respin the patches incorporating the review comments=
?
> > >
> > If I have not mistaken, no code changes were requested; it was just
> > that Philipp wanted to ensure the shared reset worked correctly after
> > shuffling the code around.
> >
>
> Ah, I was mistaken.
>
> > I can respin the series if it fails to apply on top of pci/next.
> >
>
> Sure. Please respin once v7.2-rc1 is released.
>
Sure, will do.


Cheers,
Prabhakar
