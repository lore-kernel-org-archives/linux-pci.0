Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36061 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbaA2MUm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 07:20:42 -0500
Date: Wed, 29 Jan 2014 21:20:38 +0900
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	linux-kernel@lists.codethink.co.uk,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/8] pci-rcar-gen2: add of match table
Message-ID: <20140129122038.GA26253@verge.net.au>
References: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk>
 <1390754945-28142-2-git-send-email-ben.dooks@codethink.co.uk>
 <52E6559D.6090708@cogentembedded.com>
 <52E65EAD.9000909@codethink.co.uk>
 <20140129061722.GB23833@verge.net.au>
 <CAMuHMdVSWM5wYeA1OarFEv_yYCJR1FSm5Ercjyc5qtcVameSsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdVSWM5wYeA1OarFEv_yYCJR1FSm5Ercjyc5qtcVameSsw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 29, 2014 at 11:06:42AM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 29, 2014 at 7:17 AM, Simon Horman <horms@verge.net.au> wrote:
> >> >>+static struct of_device_id rcar_pci_of_match[] = {
> >> >>+    { .compatible = "renesas,pci-r8a7790", },
> >> >
> >> >    Why only H2 SoC, if the driver is for both Gen2 SoCs?
> >>
> >> I can add a "renesas,pci-rcar-gen2" as a fallback match however
> >> I've not got anything other than an r8a7790 to test on. Also the
> >> compatible properties are preferably named after the soc.
> >
> > I'm not sure what the "best practice" is here but I propose that
> > you add both "renesas,pci-rcar-gen2" and "renesas,pci-r8a7790" now.
> 
> To the driver or to the '90 DTS?
> 
> If the DTS says
> 
>     compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2"
> 
> then the driver can just live with "renesas,pci-rcar-gen2" for now.
> 
> > And that "renesas,pci-r8a7791" can be added once the code has been
> > integrated and tested on that platform.
> 
> And later we can add
> 
>     compatible = "renesas,pci-r8a7791", "renesas,pci-rcar-gen2"
> 
> to the '91 DTS if it turns out to be compatible.
> 
> If the '91 turns out to be incompatible, or partially compatible, the driver
> can be updated later to handle both "renesas,pci-r8a7790" and
> "renesas,pci-r8a7791" and differentiate between them.
> 
> (That's what I was instructed to do with SPI ;-)

Thanks, that is more or less how I thought things work :)
