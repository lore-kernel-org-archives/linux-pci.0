Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93F306746;
	Tue, 23 Jun 2026 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194695; cv=none; b=FBb0yvkEJQJvIDIYfY5h7Yi77IDs8C79cRskG9rHGGiRqn3rxfFqssDuh1pFN/YsLRC6GKvloUPj6ttpvrlrXhmuDlZ2m1ARv4m/XNlpTKhL/GMqB/JiwwLj/BZQ7uX3uzg1sPtTyhcn5czKpgJAy+1lNoAiGh/IJ0VncmuuXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194695; c=relaxed/simple;
	bh=fGs6zTIutUW0qECkrDbevTMOjjIx02kPZ3JtVZXIzBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6bGRkgzsj2yWSKDZh9regE0oZj/KqVbFJy+chfz+8TLn7M4WNqbfdD5xV+3YJNcM7evxf8FFqIuiA5E5nPTEYUzGvKMbLshHbkgkbuv8vNx3DE4KPp4jngrW8m0dL6Qg4ONueg6cimBze9VA0zywXHWNFNYQIlGzEOvSdud8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUnsruAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUnsruAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC5C1F000E9;
	Tue, 23 Jun 2026 06:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782194694;
	bh=7P6aWzyQ8qict/dJu3CzxuJcqtMPA0MghThn8dibXEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aUnsruAvyoLMArbh/g4mBxzC0FmEOROTkWum6xPDMW4bEqPiEargO13uDS9XyBMiE
	 QyOFqwK0Xk5aqDvdXzYSFMY4NxMoWqqO+a9CIqwxyeRE0bwcT1zrY1r8UQHtYdg+nW
	 NrbCMsDLtk1HqmXx8UDAlk7d+dA+hIu2cbNt2X7Rq63oRpO8oieDvg/qU9zlnGc/i3
	 3wWug6E8m/aHNeef9+H+dWrv7bM1bMCYjF/U1DXFboEAVshR/nD+Mln+dt9/BC8ia3
	 snAMZAOFStso0+W8K2y+F0LxdWZZROH7cjHw9hM2WaO9vHhXfZQy5FIkuOnXXTGYXE
	 kqwWrIxMgVfXQ==
Date: Tue, 23 Jun 2026 08:04:42 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 2/4] PCI: rzg3s-host: Use shared reset controls for
 power domain resets
Message-ID: <txpkke2xogecipyetascqajgaxamd3ualcuhsibxf75llzcym5@xgcn7efcbmp4>
References: <20260602195019.1798126-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260602195019.1798126-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <50a908557bb3ce5f14b67396d1e73e70289a583a.camel@pengutronix.de>
 <CA+V-a8uGho2RMhreDgieOOZTggUALoF0bGyjdEEDvyL_75sAyw@mail.gmail.com>
 <fuefvecgjdqbnbvpvam4gmewmpmhofllyq2ootwi6cjqhnyoys@edjzqlh6fjw4>
 <CA+V-a8sRxoR96TRM2V3cFXS5NPiQUVrUJCWwkh7o10cGYPU9_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+V-a8sRxoR96TRM2V3cFXS5NPiQUVrUJCWwkh7o10cGYPU9_w@mail.gmail.com>

On Mon, Jun 22, 2026 at 03:53:57PM +0100, Lad, Prabhakar wrote:
> Hi Manivannan,
> 
> On Mon, Jun 22, 2026 at 3:30 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Fri, Jun 05, 2026 at 12:54:46PM +0100, Lad, Prabhakar wrote:
> > > Hi Philipp,
> > >
> > > Thank you for the review.
> > >
> > > On Wed, Jun 3, 2026 at 9:16 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > > >
> > > > On Di, 2026-06-02 at 20:50 +0100, Prabhakar wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Switch to shared reset controls for PCIe power resets to prepare for
> > > > > RZ/V2H(P) support. On this platform, multiple PCIe controllers share
> > > > > the same reset line, requiring shared ownership of the reset control.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > > Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > > ---
> > > > > v3->v4:
> > > > > - Added RB/TB tags.
> > > > >
> > > > > v2->v3:
> > > > > - No change.
> > > > >
> > > > > v1->v2:
> > > > > - Updated commit message.
> > > > > ---
> > > > >  drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> > > > > index d86e7516dcc2..a5192e4b58df 100644
> > > > > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > > > > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > > > > @@ -1276,9 +1276,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
> > > > >       for (i = 0; i < data->num_cfg_resets; i++)
> > > > >               host->cfg_resets[i].id = data->cfg_resets[i];
> > > > >
> > > > > -     ret = devm_reset_control_bulk_get_exclusive(host->dev,
> > > > > -                                                 data->num_power_resets,
> > > > > -                                                 host->power_resets);
> > > > > +     ret = devm_reset_control_bulk_get_shared(host->dev,
> > > > > +                                              data->num_power_resets,
> > > > > +                                              host->power_resets);
> > > > >       if (ret)
> > > > >               return ret;
> > > > >
> > > >
> > > > I have a few questions about this.
> > > >
> > > > Can you move rzg3s_pcie_resets_prepare_and_get() and
> > > > rzg3s_pcie_power_resets_deassert() up before setting
> > > > RZG3S_SYSC_FUNC_ID_MODE and RZG3S_SYSC_FUNC_ID_RST_RSM_B in
> > > > rzg3s_pcie_probe() without ill effect?
> > > >
> > > > Can you move rzg3s_pcie_power_resets_deassert() up before setting
> > > > RZG3S_SYSC_FUNC_ID_MODE and RZG3S_SYSC_FUNC_ID_RST_RSM_B
> > > > rzg3s_pcie_resume_noirq()?
> > > >
> > > > Those would have the same effect as the reset already being deasserted
> > > > by the other controller.
> > > >
> > > Yes to both. I have reordered the sequences as suggested, and it works
> > > perfectly without any ill effects.
> > >
> >
> > Are you going to respin the patches incorporating the review comments?
> >
> If I have not mistaken, no code changes were requested; it was just
> that Philipp wanted to ensure the shared reset worked correctly after
> shuffling the code around.
> 

Ah, I was mistaken.

> I can respin the series if it fails to apply on top of pci/next.
> 

Sure. Please respin once v7.2-rc1 is released.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
