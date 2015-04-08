Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37080 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbbDHPdn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2015 11:33:43 -0400
Received: by igblo3 with SMTP id lo3so41604918igb.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2015 08:33:42 -0700 (PDT)
Date: Wed, 8 Apr 2015 10:33:19 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] of/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
Message-ID: <20150408153319.GM10892@google.com>
References: <1428452680-24861-1-git-send-email-yinghai@kernel.org>
 <CAL_JsqLx4dB9CG0t0pCV89VxECXVTZyyiGfq=awNJSgfD50Raw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqLx4dB9CG0t0pCV89VxECXVTZyyiGfq=awNJSgfD50Raw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 07, 2015 at 08:30:58PM -0500, Rob Herring wrote:
> On Tue, Apr 7, 2015 at 7:24 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > For device resource PREF bit setting under bridge 64-bit pref resource,
> > we need to make sure only set PREF for 64bit resource, so set IORESOUCE_MEM_64
> > for 64bit resource during of device resource flags parsing.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> Bjorn, are you collecting these or should I apply?

I am not collecting them, at least not yet.  These seem a little more on
the OF side of the fence than PCI.  They are a little intertwingled with
the sparc PCI bridge window issue, and Ben has some concerns, so maybe
we'll have to figure out what makes the most sense when that gets sorted
out.

I'm still curious whether all these functions can be consolidated.  If
that's possible, it would be much nicer than having to fix all the copies.

Bjorn

> > ---
> >  drivers/of/address.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > Index: linux-2.6/drivers/of/address.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/of/address.c
> > +++ linux-2.6/drivers/of/address.c
> > @@ -128,9 +128,11 @@ static unsigned int of_bus_pci_get_flags
> >                 flags |= IORESOURCE_IO;
> >                 break;
> >         case 0x02: /* 32 bits */
> > -       case 0x03: /* 64 bits */
> >                 flags |= IORESOURCE_MEM;
> >                 break;
> > +       case 0x03: /* 64 bits */
> > +               flags |= IORESOURCE_MEM | IORESOURCE_MEM_64;
> > +               break;
> >         }
> >         if (w & 0x40000000)
> >                 flags |= IORESOURCE_PREFETCH;
