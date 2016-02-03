Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0131.outbound.protection.outlook.com ([157.56.111.131]:35054
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751600AbcBCXPL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2016 18:15:11 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH RESEND 1/3] PCI: Add fwnode_handle to pci_sysdata
Date: Wed, 3 Feb 2016 22:42:00 +0000
Message-ID: <DM2PR0301MB123298B3233B172BA2C92EF4ABD00@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1454434903-1680-1-git-send-email-jakeo@microsoft.com>
 <1454434903-1680-2-git-send-email-jakeo@microsoft.com>
 <20160203182528.GB10879@localhost>
 <DM2PR0301MB12328FC565D58EB8F995DECFABD00@DM2PR0301MB1232.namprd03.prod.outlook.com>
 <20160203185127.GE10879@localhost> <56B24D93.4040202@arm.com>
In-Reply-To: <56B24D93.4040202@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: Wednesday, February 3, 2016 10:57 AM
> To: Bjorn Helgaas <helgaas@kernel.org>; Jake Oshins
> <jakeo@microsoft.com>
> Cc: gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; Haiyang Zhang
> <haiyangz@microsoft.com>; bhelgaas@google.com; linux-
> pci@vger.kernel.org
> Subject: Re: [PATCH RESEND 1/3] PCI: Add fwnode_handle to pci_sysdata
> 
> On 03/02/16 18:51, Bjorn Helgaas wrote:
> > On Wed, Feb 03, 2016 at 06:32:20PM +0000, Jake Oshins wrote:
> >>> -----Original Message-----
> >>> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> >>> Sent: Wednesday, February 3, 2016 10:25 AM
> >>> To: Jake Oshins <jakeo@microsoft.com>
[snip]
> >>>>
> >>>> +#ifndef pci_root_bus_fwnode
> >>>> +#define pci_root_bus_fwnode(bus)	((void)(bus), NULL)
> >>>
> >>> Huh, interesting.  This is new for me; I guess the idea is that we at least
> >>> evaluate "bus" even when pci_root_bus_fwnode isn't defined, so the
> >>> compiler can catch egregious errors?
> >>>
> >>
> >> This was a suggestion by Mark Zyngier.  It made the non-x86 architectures
> build benignly.  If you'd like it done differently, I'm open to suggestion.
> 
> I don't remember suggesting the use of the comma operator, but just to
> check that pci_root_bus_fwnode wasn't previously defined.
> 
> > Something like "#define pci_root_bus_fwnode(bus) NULL" would be
> > typical.  What I'm curious about is the use of the comma operator.
> > I'm not opposed to it; I'm just trying to understand why it makes a
> > difference.
> 
> I guess it flags the variable as used, and prevents an overly sensitive
> compiler from being loud and obnoxious... Just a guess though.
> 
> 	M.
> --

I was just copying the form that was in the code that Marc pointed out, somewhere else.  I have no particular attachment to this construct.  Honestly, since I'm still relatively new to the Linux codebase, I just assumed that was a common form that I should follow suit on.  If you tell me that the simpler NULL is more typical, I prefer that.  I'll simplify this when I resend the patch series.

Thanks,
Jake

