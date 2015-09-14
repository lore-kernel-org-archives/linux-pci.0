Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0141.outbound.protection.outlook.com ([157.56.110.141]:36640
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750980AbbINR7e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2015 13:59:34 -0400
From: Jake Oshins <jakeo@microsoft.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: RE: [PATCH v2 00/12] New paravirtual PCI front-end for Hyper-V VMs
Date: Mon, 14 Sep 2015 17:59:31 +0000
Message-ID: <DM2PR0301MB12326BCA329D5D98A587C2DCAB5D0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
 <55F6E115.9050502@arm.com>
In-Reply-To: <55F6E115.9050502@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: Monday, September 14, 2015 8:01 AM
> To: Jake Oshins <jakeo@microsoft.com>; gregkh@linuxfoundation.org; KY
> Srinivasan <kys@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; linux-pci@vger.kernel.org; bhelgaas@google.com;
> tglx@linutronix.de; Jiang Liu <jiang.liu@linux.intel.com>
> Subject: Re: [PATCH v2 00/12] New paravirtual PCI front-end for Hyper-V
> VMs
> 
> Hi Jake,
> 
> In the future, please CC me on anything that touches irqdomains, along
> with Jiang Liu as we both co-maintain this piece of code.
> 

Absolutely.  Sorry for that omission.

> On 11/09/15 01:00, jakeo@microsoft.com wrote:
> > From: Jake Oshins <jakeo@microsoft.com>
> >
> > The patch series updates the one sent about a month ago in three ways.  It
> > integrated with other IRQ domain work done in linux-next in that time, it
> > distributes interrupts to multiple virtual processors in the guest VM, and it
> > incorporates feedback from Thomas Gleixner and others.
> >
> > These patches change the IRQ domain code so that an IRQ domain can
> match on both
> > bus type and on the PCI domain.  The IRQ domain match code is modified
> so that
> > IRQ domains can have a "rank," allowing for a default one which matches
> every
> > x86 PC and more specific ones that replace the default.
> 
> I'm not really fond of this approach. We already have a way to match an
> IRQ domain, and that's the device node. It looks to me that you're going
> through a lot of pain inventing a new infrastructure to avoid divorcing
> the two. If you could lookup your PCI IRQ domain directly based some
> (non-DT) identifier, and then possibly fallback to the default one,
> would that help?
> 
> If so, here's the deal: I have been working on a patch series that
> addresses the above for unrelated reasons (ACPI support on arm64). It
> has been posted twice already:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358768.html
> 
> and the latest version is there:
> 
> https://git.kernel.org/cgit/linux/kernel/git/maz/arm-
> platforms.git/log/?h=irq/gsi-irq-domain-v3
> 
> I have the feeling that you could replace a lot of your patches with
> this infrastructure.
> 
> Thoughts?
> 
> 	M.
> --

First, thank you so much for reviewing this.  I've read the patch series above, but I'm sure that I might have misinterpreted it.  It seems to merge the DT and ACPI GSI infrastructure, which I think is a great idea.  I'm not sure, however, that it would, as it stands, provide what I need here.  Please do tell me if I'm wrong.

The series above allows you to supply different IRQ domains for separate parts of the ACPI GSI space, which is fine for IRQs which are actually defined by ACPI.  Message-signaled interrupts (MSI), however, aren't defined by ACPI.  ACPI only talks about the routing of interrupts with pins and traces (or ones which have equivalent mechanisms like the INTx# protocol in PCI Express.)

What the older DT layer code allowed was for the PCI driver to look up an IRQ domain by walking up the device tree looking for a node that claimed to be an IRQ domain.  The match() function on the IRQ domain allowed it to say that it supported interrupts on PCI buses.

What's not clear to me is how I would create an IRQ domain that matches not on ACPI GSI ranges (because ACPI doesn't talk about MSI) and not just on generic PCI buses.  I need to be able to ask for an IRQ domain "from my parent" which doesn't really exist without the OF device tree or "for a specific PCI bus domain."  That second one is what I was trying to enable.

Is there a way to do that with the infrastructure that you're introducing?

Thanks again,
Jake Oshins

