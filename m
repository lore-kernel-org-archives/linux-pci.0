Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0240.outbound.protection.outlook.com ([207.46.163.240]:17496
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751929AbaAGHN4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jan 2014 02:13:56 -0500
Message-ID: <1389078829.11795.138.camel@snotra.buserror.net>
Subject: Re: [03/12,v3] pci: fsl: add PCI indirect access support
From: Scott Wood <scottwood@freescale.com>
To: Lian Minghuan-b31939 <b31939@freescale.com>
CC: Minghuan Lian <Minghuan.Lian@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 7 Jan 2014 01:13:49 -0600
In-Reply-To: <52CA40D8.1090805@freescale.com>
References: <1382524894-15164-3-git-send-email-Minghuan.Lian@freescale.com>
	 <20140103223306.GC22546@home.buserror.net> <52CA40D8.1090805@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2014-01-06 at 13:36 +0800, Lian Minghuan-b31939 wrote:
> HI Scott,
> 
> please see my comments inline.
> 
> On 01/04/2014 06:33 AM, Scott Wood wrote:
> > A lot of this seems duplicated from arch/powerpc/sysdev/indirect_pci.c.
> >
> > How generally applicable is that file to non-PPC implementations?  At a
> > minimum I see a similar file in arch/microblaze.  It should probably
> > eventually be moved to common code, rather than duplicated again.  A
> > prerequisite for that would be making common the dependencies it has on
> > the rest of what is currently arch PCI infrastructure; until then, it's
> > probably better to just have the common fsl-pci code know how to
> > interface with the appropriate PPC/ARM code rather than trying to copy
> > the infrastructure as well.
> [Minghuan] Yes, This is a duplicate except it uses struct fsl_pci. But 
> it is hard to be move to common code.
> because every indirect read/write functions use different PCI controller 
> structure which is very basic structure and ARM has no this structure.
> If we can not establish a unified pci controller structure, we can only 
> abstract out a simple structure which includes indirect access related 
> fields,
> and need a callback function to get the pointer like this: 
> ((powerpc/microblaze/mips/ pci_controller 
> *)(pci_bus->sysdata))->indirect_struct.
> Should we provide the common code for indirect access API or wait for 
> the common PCI controller structure?

Either work with the PCI maintainer to come up with a common structure,
or leave the code where it is and call into it.

-Scott


