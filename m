Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752384AbdK1Uq4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Nov 2017 15:46:56 -0500
Date: Tue, 28 Nov 2017 14:46:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com,
        stelford@cadence.com, dgary@cadence.com, kgopi@cadence.com,
        eandrews@cadence.com, thomas.petazzoni@free-electrons.com,
        sureshp@cadence.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: cadence: Add host driver for Cadence PCIe
 controller
Message-ID: <20171128204655.GA31255@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <2670f7ddf59e708beb9d32bef1353e15bd4e1ecf.1511439189.git.cyrille.pitchen@free-electrons.com>
 <20171128204114.GE11228@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171128204114.GE11228@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 28, 2017 at 02:41:14PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 23, 2017 at 04:01:48PM +0100, Cyrille Pitchen wrote:
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 1d034b680431..27bdd98784d9 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -18,6 +18,7 @@ obj-y				+= pwm/
> >  
> >  obj-$(CONFIG_PCI)		+= pci/
> >  obj-$(CONFIG_PCI_ENDPOINT)	+= pci/endpoint/
> > +obj-$(CONFIG_PCI_CADENCE)	+= pci/cadence/
> 
> I can't remember why we added CONFIG_PCI_ENDPOINT here instead of in
> drivers/pci/Makefile.  Is there any way to move both CONFIG_PCI_ENDPOINT
> and CONFIG_PCI_CADENCE into drivers/pci/Makefile so this is better
> encapsulated?

I now see the note in your cover letter.  If there is a reason for
this, it should go in the changelog to forestall questions like this.
But what's in the cover letter isn't quite enough because it doesn't
answer the question of why drivers/pci/Makefile isn't sufficient to
control the ordering of pci/dwc and pci/endpoint.

And sorry, I now see Lorenzo's similar query so he's already jumped on
this :)

> >  # PCI dwc controller drivers
> >  obj-y				+= pci/dwc/
