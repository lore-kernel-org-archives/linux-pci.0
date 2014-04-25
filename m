Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0235.outbound.protection.outlook.com ([207.46.163.235]:45212
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753234AbaDYQe0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Apr 2014 12:34:26 -0400
From: Guenter Roeck <groeck@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatxjain@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rajat Jain <rajatjain@juniper.net>
Subject: RE: [PATCH] pci/pciehp: Allow polling/irq mode to be decided on a
 per-port basis
Date: Fri, 25 Apr 2014 16:34:23 +0000
Message-ID: <e760e15b4f404c6cb3252480a7d8a78a@CO1PR05MB523.namprd05.prod.outlook.com>
References: <5339FF99.2050200@gmail.com> <20140424213106.GI29593@google.com>
In-Reply-To: <20140424213106.GI29593@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Thursday, April 24, 2014 2:31 PM
> To: Rajat Jain
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Rajat
> Jain; Guenter Roeck
> Subject: Re: [PATCH] pci/pciehp: Allow polling/irq mode to be decided
> on a per-port basis
> 
> On Mon, Mar 31, 2014 at 04:51:53PM -0700, Rajat Jain wrote:
> > Today, there is a global pciehp_poll_mode module parameter using
> which
> > either _all_ the hot-pluggable ports are to use polling, or _all_ the
> > ports are to use interrupts.
> >
> > In a system where a certain port has IRQ issues, today the only
> option
> > is to use the parameter that converts ALL the ports to use polling
> mode.
> > This is not good, and hence this patch intruduces a bit field that
> can
> > be set using a PCI quirk that indicates that polling should always be
> > used for this particular PCIe port. The remaining ports can still
> > hoose to continue to operate in whatever mode they wish to.
> >
> > Signed-off-by: Rajat Jain <rajatxjain@gmail.com>
> > Signed-off-by: Rajat Jain <rajatjain@juniper.net>
> > Signed-off-by: Guenter Roeck <groeck@juniper.net>
> 
> I'm willing to merge this, but I'd prefer to merge it along with a
> quirk that actually sets dev->hotplug_polling.  Otherwise it's dead
> code and I'll have no way to tell whether we need to keep it.
> 
Bjorn,

what would be the proper location for such a quirk ? 
We use it to help simulating hotplug support on an IDT PES12NT3.
The code is a bit more invasive than just the quirk itself,
since it also needs to touch link and slot status registers,
so quirks.c doesn't seem appropriate.

drivers/pci/pes12nt3.c, maybe, with a separate configuration
option ? Or in the hotplug directory ?

Guenter

