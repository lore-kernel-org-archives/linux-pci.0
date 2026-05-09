Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55383815EF
	for <linux-pci@vger.kernel.org>; Sat,  9 May 2026 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778311115; cv=none; b=NnC6q/rmaGNSFwLbfq9ZYAffUt4ItBTBFvfEDZgIoRMjQNNsr4yZ7DVIyr3PeGWhaNtxKbWK3Xc7GiW8HmjDSxnEM4pu2T3bYhGAKQ7LelXezYXhu6QYKzqUuAWCNCl623+J2Agc4odsgC38cuYgL8EUhNuL7cCBVSg0FEnBuCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778311115; c=relaxed/simple;
	bh=xP9IGBwVhUQ7mQgqFJuihWWQKtVqwhyqli0I6YiuDMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOU3EO/wiP+iWG3HTOZHVoPWv0hKJ91CAJSbFzkkHabnRlGICRGUJ0UTT23h36htewX1bCVaoFoRpizOgJi+jgQbE4LMoRYEwyM5mZDFUjZ2a4ghuBRthZKxn5WywbhBRx8ikVdWxpWy6tWpfQdhxW13rWkBHoAbUI3reRLLx6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw7zHRas; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw7zHRas"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82faf871346so1922924b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 09 May 2026 00:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778311113; x=1778915913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=skObjcn2ITTEAn6Yzrs7wNLXCgAg8sVMpOQ0WmRpnAE=;
        b=fw7zHRasAXKPBMxSf5VUm+oYjsgvL6JXB8issm/OItZuvazMVM6lILtKyIv20lGg/W
         WV8yUCJiiRADNkzHmoFwgWPQluUC1zIAAhBP9lkUCjofrUi4MJDO/DRNUyQ/19iypXTH
         QJSFVUrjgr5hHy/ADoYX0Gk7S6L6qKO+EYmI50BLxahiKUtTYUV77mNTj/Iixzq1o4kq
         6cwOdLCHmO3CfRlkE5MpPr3/u/rgwFomQLNsNmcXUage76uHBFvT74Om41DWYivRQScv
         GvTRWfFIDpjHjkoaRJb2mA9u/z0FlhF2zOBLV2YGR2DpSTCfO4iXShaoZG0A7tg6fYEH
         hLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778311113; x=1778915913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skObjcn2ITTEAn6Yzrs7wNLXCgAg8sVMpOQ0WmRpnAE=;
        b=lD/StAwtczHlXaLi/DQZ21VB8hZD+q+CB9nUT92i6HvGG/tskBR5oMdFmSw+eYFlSq
         aQyTIZGPtWciktFr9gGEII6VAXP0i3CmM49MCMpkQOenrm+KwmCLehmIIE1UiRKGFAtk
         z6WeCYIIpqRCqdmq1/nDIo2KvaD+DRn2DF+dfsxZPQ3W8S6SJVyIvxGdHEDRZuIQrCsN
         c9nsd8jM2OA9TPE2xKn9L3vTYp4BnbHgbijVJT/mTdDQm0n8Ba24HngYTMdVtShRm89W
         a96FWB/RDITPn5FxqGBlv2joqyF4pCTPldnZ0dOi5xxgECkwn3ncIN0chzkF7ONAS6Q3
         uxKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/23dsHjFcYB5eARWvuTZfD7jBHLcyN8pGLXqMwJPHItxscCIUPVV+yeiHZwlFTBm7Py/WUchGjTW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7xVC/Jb+dlwtyRok/OxofaoaatVKz0NmI/P445gVjUMLgsJ6
	V+mZCtu8nDp/WbbBCBneXSkGN6VKdZ19tb7dfD2WCt3g3op24I+TbalJ
X-Gm-Gg: Acq92OHY/I4qt8t7z0GOJJMiIQmdRSrZsOhXoh+3EQg4J6YX7aIUsBt22o5kCOLUaWc
	fkNuZiwSM3oHXgxPzdhgygAaYPIoYsYAHPM0cuS4wZ+lXFNdUdpy22Qal0wpBrlkZdP3nzgmQJM
	k/5t4Xtpe5XmZOCIko2KYDSYfx0RJbFzHJOexsylgSo8NDzGJGWua5jHU1QgbK6t38jHo+GacwX
	Sc5Q9sYdYJ14f9eRUOkL9rPbs2hsNBPigxEbKiT770H3caFdEFI+vlDEkwxd4IPQveUpolMQ5wK
	d6GaYwNQcj8E3cP5cMpRxxJHf4Zll0vAoAUo1ruGrvuhsVyjqwfqVJFOwUprzTsp9rD2eFRPYLh
	0oN5fP89sympNbMRhe6TxWCHOBCIso+8pixAWPnuspxri+UGaYATchmcyn8tKWMYVUDJ5x5XrHF
	bAOqvSQ9xzxY8RDq/9kNJ9vVRw5heI+by3Ag==
X-Received: by 2002:a05:6a00:2442:b0:835:443e:4be2 with SMTP id d2e1a72fcca58-83a5badbebcmr16047333b3a.2.1778311112968;
        Sat, 09 May 2026 00:18:32 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf36sm17667656b3a.41.2026.05.09.00.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 00:18:32 -0700 (PDT)
Date: Sat, 9 May 2026 15:18:11 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Alex Elder <elder@riscstar.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: pci: spacemit: Introduce Spacemit K3
 PCIe host controller
Message-ID: <af7exVxVnDYagA7D@inochi.infowork>
References: <20260502101319.2364052-1-inochiama@gmail.com>
 <20260502101319.2364052-5-inochiama@gmail.com>
 <20260507191302.GA2284447-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507191302.GA2284447-robh@kernel.org>

On Thu, May 07, 2026 at 02:13:02PM -0500, Rob Herring wrote:
> On Sat, May 02, 2026 at 06:13:17PM +0800, Inochi Amaoto wrote:
> > Add binding support for the PCIe controller on the SpacemiT K3 SoC.
> > This controller is almost a standard Synopsys Designware PCIe IP,
> > with some extra link and reset state control.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../bindings/pci/spacemit,k3-pcie-host.yaml   | 142 ++++++++++++++++++
> >  1 file changed, 142 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> > new file mode 100644
> > index 000000000000..be2641526b19
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> > @@ -0,0 +1,142 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/spacemit,k3-pcie-host.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SpacemiT K3 PCI Express Host Controller
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@gmail.com>
> > +
> > +description:
> > +  The SpacemiT K3 SoC PCIe host controller is based on the Synopsys
> > +  DesignWare PCIe IP.  The controller uses the external MSI interrupt
> > +  controller.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: spacemit,k3-pcie
> > +
> > +  reg:
> > +    items:
> > +      - description: DesignWare PCIe registers
> > +      - description: Data Bus Interface (DBI) shadow registers
> > +      - description: ATU address space
> > +      - description: PCIe configuration space
> > +      - description: Link control registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: dbi2
> > +      - const: atu
> > +      - const: config
> > +      - const: link
> > +
> > +  clocks:
> > +    items:
> > +      - description: DWC PCIe Data Bus Interface (DBI) clock
> > +      - description: DWC PCIe application AXI-bus master interface clock
> > +      - description: DWC PCIe application AXI-bus slave interface clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: dbi
> > +      - const: mstr
> > +      - const: slv
> > +
> > +  resets:
> > +    items:
> > +      - description: DWC PCIe Data Bus Interface (DBI) reset
> > +      - description: DWC PCIe application AXI-bus master interface reset
> > +      - description: DWC PCIe application AXI-bus slave interface reset
> > +
> > +  reset-names:
> > +    items:
> > +      - const: dbi
> > +      - const: mstr
> > +      - const: slv
> > +
> > +  interrupts:
> > +    items:
> > +      - description: Interrupt used for port state
> > +
> > +  interrupt-names:
> > +    const: app
> > +
> > +  msi-parent: true
> > +
> > +  phys:
> > +    minItems: 1
> > +    maxItems: 6
> 
> You have to define what each entry is. I assume this is 1 per lane 
> though I thought only a power of 2 number of lanes was valid.
> 

In fact it is not 1 per lane, the PCIe accept lanes from the Comb PHY,
and the phy can provide 1 lane or 2 lanes according to the PHY MUX. 
In detail,
- PHY 0,1 is 2 lanes
- PHY 2,3,4,5 is 1 lane.

So the max number of the phys is 6 with 8 lanes.

Maybe need a description link to the phy mux configuration?

Regards,
Inochi


