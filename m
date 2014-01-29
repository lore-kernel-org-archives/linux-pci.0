Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55950 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbaA2GRY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 01:17:24 -0500
Date: Wed, 29 Jan 2014 15:17:22 +0900
From: Simon Horman <horms@verge.net.au>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	linux-kernel@lists.codethink.co.uk,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/8] pci-rcar-gen2: add of match table
Message-ID: <20140129061722.GB23833@verge.net.au>
References: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk>
 <1390754945-28142-2-git-send-email-ben.dooks@codethink.co.uk>
 <52E6559D.6090708@cogentembedded.com>
 <52E65EAD.9000909@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52E65EAD.9000909@codethink.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 27, 2014 at 01:27:09PM +0000, Ben Dooks wrote:
> On 27/01/14 12:48, Sergei Shtylyov wrote:
> >Hello.
> >
> >On 26-01-2014 20:48, Ben Dooks wrote:
> >
> >>Add OF match table for pci-rcar-gen2 driver for device tree support.
> >
> >>Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >>---
> >>Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>Cc: Simon Horman <horms@verge.net.au>
> >>Cc: linux-pci@vger.kernel.org
> >>Cc: linux-sh@vger.kernel.org
> >>Cc: devicetree@vger.kernel.org
> >>---
> >>  drivers/pci/host/pci-rcar-gen2.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >
> >>diff --git a/drivers/pci/host/pci-rcar-gen2.c
> >>b/drivers/pci/host/pci-rcar-gen2.c
> >>index ceec147..ea65bac 100644
> >>--- a/drivers/pci/host/pci-rcar-gen2.c
> >>+++ b/drivers/pci/host/pci-rcar-gen2.c
> >>@@ -311,9 +311,17 @@ static int __init rcar_pci_probe(struct
> >>platform_device *pdev)
> >>      return rcar_pci_add_controller(priv);
> >>  }
> >>
> >>+static struct of_device_id rcar_pci_of_match[] = {
> >>+    { .compatible = "renesas,pci-r8a7790", },
> >
> >    Why only H2 SoC, if the driver is for both Gen2 SoCs?
> 
> I can add a "renesas,pci-rcar-gen2" as a fallback match however
> I've not got anything other than an r8a7790 to test on. Also the
> compatible properties are preferably named after the soc.

I'm not sure what the "best practice" is here but I propose that
you add both "renesas,pci-rcar-gen2" and "renesas,pci-r8a7790" now.
And that "renesas,pci-r8a7791" can be added once the code has been
integrated and tested on that platform.
