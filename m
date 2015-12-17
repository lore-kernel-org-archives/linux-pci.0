Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20769 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000AbbLQRet (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 12:34:49 -0500
Date: Thu, 17 Dec 2015 17:34:46 +0000
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv5 7/7] pciutils: Allow 32-bit domains
Message-ID: <20151217173446.GA31031@localhost.localdomain>
References: <1449523949-21898-1-git-send-email-keith.busch@intel.com>
 <1449523949-21898-8-git-send-email-keith.busch@intel.com>
 <20151217171545.GB23549@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20151217171545.GB23549@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 17, 2015 at 11:15:45AM -0600, Bjorn Helgaas wrote:
> > @@ -45,7 +45,7 @@ pci_filter_parse_slot_v33(struct pci_filter *f, char *str)
> >  	  if (str[0] && strcmp(str, "*"))
> >  	    {
> >  	      long int x = strtol(str, &e, 16);
> > -	      if ((e && *e) || (x < 0 || x > 0xffff))
> > +	      if ((e && *e) || (x < 0))
> 
> Just out of curiosity (I don't maintain pciutils; Martin would apply
> this one), is there some part of the PCI or PCI firmware spec that is
> relevant to this change?  Maybe this is connected to parsing things
> exported by the kernel and not directly tied to PCI at the spec level.
>
> Whatever it is, a pointer to the producer of the information you're
> consuming here would help us understand and review the patch.

Hi Bjorn,

This is not tied to anything defined in PCI spec. Domain numbers being
a software construct (ACPI6, §6.5.6), we don't need to constrain the
representation. ACPI defines 16-bit segments, and domains provided by
this new host bridge do not define _SEG, so this series proposes domain
numbers outside the ACPI reachable range to avoid potential clashes.

The pciutils patch just synchronizes the essential tooling software with
the kernel software's new representation.
