Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754841AbeEANZ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 May 2018 09:25:56 -0400
Date: Tue, 1 May 2018 08:25:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
Message-ID: <20180501132554.GA11698@bhelgaas-glaptop.roam.corp.google.com>
References: <b62c2a8e-fe14-6d7d-147c-0ce3b0c0ab2f@codeaurora.org>
 <20180427211255.GI8199@bhelgaas-glaptop.roam.corp.google.com>
 <20180428005620.GB1675@dhcp-128-65.nay.redhat.com>
 <20180428011845.GC1675@dhcp-128-65.nay.redhat.com>
 <3ebc908fb196168bf0373875ffc5679e@codeaurora.org>
 <d8d134dc-9757-97cd-7a24-cbb21611d6c6@codeaurora.org>
 <20180430211740.GG95643@bhelgaas-glaptop.roam.corp.google.com>
 <7285da70-2c3e-c3b7-62e1-fdbb55a77729@codeaurora.org>
 <3549ffe8-7605-d72c-5c09-1436a4288c7d@codeaurora.org>
 <ffe662be-00c7-ab7f-0e88-8119ccfd9600@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ffe662be-00c7-ab7f-0e88-8119ccfd9600@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 01, 2018 at 01:59:20PM +0100, Marc Zyngier wrote:
> On 01/05/18 13:38, Sinan Kaya wrote:
> > +Marc,
> > 
> > On 4/30/2018 5:27 PM, Sinan Kaya wrote:
> >> On 4/30/2018 5:17 PM, Bjorn Helgaas wrote:
> >>>> What should we do about this?
> >>>>
> >>>> Since there is an actual HW errata involved, should we quirk this
> >>>> root port and not wait as if remove/shutdown doesn't exist?
> >>> I was hoping to avoid a quirk because AFAIK all Intel parts have this
> >>> issue so it will be an ongoing maintenance issue.  I tried to avoid
> >>> the timeout delays, e.g., with 40b960831cfa ("PCI: pciehp: Compute
> >>> timeout from hotplug command start time").
> >>>
> >>> But we still see the alarming messages, so we should probably add a
> >>> quirk to get rid of those.
> >>>
> >>> But I haven't given up on the idea of getting rid of the
> >>> pciehp_remove() path.  I'm not convinced yet that we actually need to
> >>> do anything to shut this device down.  I don't like the assumption
> >>> that kexec requires this.  The kexec is fundamentally just a branch,
> >>> and anything we do before the branch (i.e., in the old kernel), we
> >>> should also be able to do after the branch (i.e., in the kexec-ed
> >>> kernel).
> >>>
> >>
> >> In my experience with kexec, MSI type edge interrupts are harmless.
> >> You might just see a few unhandled interrupt messages during boot
> >> if something is pending from the first kernel.
> 
> Unfortunately, that's not always the case.
> 
> A number of GICv3/v4 implementations (a very common interrupt controller
> on ARM servers) cannot be disabled, which means they will keep writing
> to their pending tables long after kexec will have started the new
> kernel. And since we don't track memory allocation across kexec, you
> end-up with significant chances of observing single bit corruption as
> interrupts carry on being delivered. Oh, and you won't actually be able
> to take MSIs because you can't even reprogram the damn thing.
> 
> Yes, this can be considered a HW bug.
> 
> >> It is the level interrupts that are more concerning. It remains pending
> >> until the interrupt source is cleared. CPU never returns from the
> >> interrupt handler to actually continue booting the second kernel.
> > 
> > This makes me wonder why kexec doesn't disable all interrupt sources by
> > itself instead of relying on the drivers shutdown routine. Some drivers
> > don't even have a shutdown callback. Kexec could have done both as another
> > example. Something like.
> > 
> > 1. Call shutdown for all drivers if available.
> > 2. Disable all interrupt sources in the interrupt controller
> > 3. Start the new kernel.
> 
> See above. Although you can shut off the end-point and to some extent
> mask interrupts before jumping into the payload, it is not always
> possible to go back to a reasonable state where you can take actually MSIs.

This is exactly the sort of thing it would be nice to collect and
document as part of the background of "why kexec works the way it
does."  It certainly helps explain things that are far from obvious if
you don't have the background.
