Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5AAC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 22:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41ED217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 22:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfDWWUW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:20:22 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:44379 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWWUV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 18:20:21 -0400
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7133724000A;
        Tue, 23 Apr 2019 22:20:18 +0000 (UTC)
Date:   Wed, 24 Apr 2019 00:29:18 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] pci: aardvark: Wait for endpoint to be ready before
 training link
Message-ID: <20190423222917.GN2754@voidbox.localdomain>
References: <20190313213752.1246-1-repk@triplefau.lt>
 <20190423163215.GB26523@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423163215.GB26523@red-moon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Apr 23, 2019 at 05:32:15PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Mar 13, 2019 at 10:37:52PM +0100, Remi Pommarel wrote:
> > When configuring pcie reset pin from gpio (e.g. initially set by
> > u-boot) to pcie function this pin goes low for a brief moment
> > asserting the PERST# signal. Thus connected device enters fundamental
> > reset process and link configuration can only begin after a minimal
> > 100ms delay (see [1]).
> > 
> > This makes sure that link is configured after at least 100ms from
> > beginning of probe() callback (shortly after the reset pin function
> > configuration switch through pinctrl subsytem).
> > 
> > [1] "PCI Express Base Specification", REV. 2.1
> >         PCI Express, March 4 2009, 6.6.1 Conventional Reset
> > 
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index a30ae7cf8e7e..70a1023d0ef1 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -177,6 +177,9 @@
> >  
> >  #define PIO_TIMEOUT_MS			1
> >  
> > +/* Endpoint can take up to 100ms to be ready after a reset */
> > +#define ENDPOINT_RST_MS			100
> > +
> >  #define LINK_WAIT_MAX_RETRIES		10
> >  #define LINK_WAIT_USLEEP_MIN		90000
> >  #define LINK_WAIT_USLEEP_MAX		100000
> > @@ -242,8 +245,10 @@ static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
> >  	return -ETIMEDOUT;
> >  }
> >  
> > -static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> > +static void
> > +advk_pcie_setup_hw(struct advk_pcie *pcie, unsigned long ep_rdy_time)
> 
> Nit: I prefer the prototype to be in one line, I wrap it for you.
> 
> I am wondering why you need to pass in ep_rdy_time parameter when you
> can easily compute it in the function itself.
> 

The only reason for that is because the sooner I get the jiffies the
lower the delay has to be. I was trying to reduce the impact of this
delay to a minimum, but maybe the improvement is not worth it.

-- 
Remi
