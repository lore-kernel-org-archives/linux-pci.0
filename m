Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:14329
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752010Ab3J3D2N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 23:28:13 -0400
Date: Wed, 30 Oct 2013 11:28:13 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Sachin Kamat <sachin.kamat@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sean Cross <xobs@kosagi.com>
Subject: Re: [PATCH 1/3] PCI: imx6: Remove redeundant of_match_ptr
Message-ID: <20131030032811.GK2839@S2101-09.ap.freescale.net>
References: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org>
 <CAErSpo6zQ26BccSzmSqXcptQvDADrzPxBcRfoivTO2gd9ApP8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAErSpo6zQ26BccSzmSqXcptQvDADrzPxBcRfoivTO2gd9ApP8g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 29, 2013 at 04:11:25PM -0600, Bjorn Helgaas wrote:
> [+cc Shawn]
> 
> On Mon, Oct 21, 2013 at 3:06 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> > imx6_pcie_of_match is always compiled in. Hence of_match_ptr is
> > not required.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > Cc: Sean Cross <xobs@kosagi.com>
> 
> I'll apply this for v3.13 if Shawn acks it, per
> http://lkml.kernel.org/r/CAErSpo5tN==4nSv2u3SUBe_L4VsWn4P7TN+LtrC172Qj1vhtog@mail.gmail.com

Yea, since PCI_IMX6 depends on SOC_IMX6Q which only supports OF build,
it makes sense to drop the of_match_ptr() wrapper, so

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> 
> > ---
> >  drivers/pci/host/pci-imx6.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index 5afa922..64aaa8e 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -558,7 +558,7 @@ static struct platform_driver imx6_pcie_driver = {
> >         .driver = {
> >                 .name   = "imx6q-pcie",
> >                 .owner  = THIS_MODULE,
> > -               .of_match_table = of_match_ptr(imx6_pcie_of_match),
> > +               .of_match_table = imx6_pcie_of_match,
> >         },
> >  };
> >
> > --
> > 1.7.9.5
> >

