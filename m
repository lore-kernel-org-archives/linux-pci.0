Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56339 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460AbbLDQRj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 11:17:39 -0500
Date: Fri, 4 Dec 2015 10:17:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: MSI: Only use the generic MSI layer when domain is
 hierarchical
Message-ID: <20151204161735.GA13427@localhost>
References: <1448288826-19058-1-git-send-email-marc.zyngier@arm.com>
 <PS1PR06MB11808365B312F6C3DAE2DB35F5000@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151204002758.GA10479@localhost>
 <20151204081350.2113b7e6@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151204081350.2113b7e6@why.wild-wind.fr.eu.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 04, 2015 at 08:13:50AM +0000, Marc Zyngier wrote:
> On Thu, 3 Dec 2015 18:27:59 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Mon, Nov 30, 2015 at 10:25:34AM +0000, Phil Edworthy wrote:
> > > Cc'd linux-pci ml
> > > 
> > > On 23 November 2015 14:27, Marc Zyngier wrote:
> > > 
> > > Since d8a1cb757550 ("PCI/MSI: Let pci_msi_get_domain use struct
> > > device::msi_domain"), we use the MSI domain associated to the PCI device.
> > > 
> > > But finding a MSI domain doesn't mean that the domain is implemented
> > > using the generic MSI domain API, and a number of MSI controllers
> > > are still using the arch_setup_msi_irq/arch_teardown_msi_irqs.
> > > 
> > > In order to avoid a firework on these systems, check that the domain
> > > we just obtained is hierarchical. If not, don't use the generic MSI
> > > stuff and stick with the old one. Not pretty, but reliable.
> > > 
> > > Another insentive to rework those drivers and phase out this API.
> > > 
> > > Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > Tested-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Thanks, I applied this with Thomas' ack to pci/msi for v4.5.
> > 
> > It looks like d8a1cb757550 appeared in v4.3.  Is this a fix for that
> > commit?  Does this need to be backported via a stable tag?
> 
> Hi Bjorn,
> 
> I think this really deserves to be queued as an immediate fix for 4.4
> rather than 4.5, as some systems in mainline are affected by this bug:
> 
> http://www.spinics.net/lists/arm-kernel/msg465792.html
> 
> It would also deserve a stable tag for 4.3.

OK, I can do that.  It would save me a lot of time to get a hint when
this is the case.  I couldn't tell if this issue happened on mainline
or with some still out-of-tree patches.  I'd also like to know what
machines are affected.

I did look at d8a1cb757550, and the connection between that and this
patch is not completely obvious; would you regard this as a fix to
d8a1cb757550?  Should this patch be backported to every kernel that
includes d8a1cb757550?  Or is this more closely tied to some other
change?

Bjorn
