Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 9 Oct 2015 18:04:20 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	device-tree <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] of: Add vendor prefix for PLDA.
Message-ID: <20151009170420.GH3394@e106497-lin.cambridge.arm.com>
References: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com>
 <1444409849-5685-4-git-send-email-Liviu.Dudau@arm.com>
 <20151009165929.GF21629@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20151009165929.GF21629@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 09, 2015 at 05:59:29PM +0100, Mark Rutland wrote:
> On Fri, Oct 09, 2015 at 05:57:27PM +0100, Liviu Dudau wrote:
> > Use "plda" as vendor prefix for PLDA.
> > 
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> Having looked on PLDA's website it seems "PLDA" is their preferred name,
> and I can't find any suffix used, so this looks fine to me:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Liviu

> 
> Mark.
> 
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 82d2ac9..57653eb 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -168,6 +168,7 @@ pericom	Pericom Technology Inc.
> >  phytec	PHYTEC Messtechnik GmbH
> >  picochip	Picochip Ltd
> >  plathome	Plat'Home Co., Ltd.
> > +plda	PLDA
> >  pixcir  PIXCIR MICROELECTRONICS Co., Ltd
> >  powervr	PowerVR (deprecated, use img)
> >  qca	Qualcomm Atheros, Inc.
> > -- 
> > 2.6.0
> > 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
