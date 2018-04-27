Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757592AbeD0VM7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Apr 2018 17:12:59 -0400
Date: Fri, 27 Apr 2018 16:12:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
Message-ID: <20180427211255.GI8199@bhelgaas-glaptop.roam.corp.google.com>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
 <b62c2a8e-fe14-6d7d-147c-0ce3b0c0ab2f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b62c2a8e-fe14-6d7d-147c-0ce3b0c0ab2f@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Eric, Vivek, kexec list]

On Fri, Apr 27, 2018 at 03:34:30PM -0400, Sinan Kaya wrote:
> On 4/27/2018 3:22 PM, Bjorn Helgaas wrote:
> > Sinan mooted the idea of using a "no-wait" path of sending the "don't
> > generate hotplug interrupts" command.  I think we should work on this
> > idea a little more.  If we're shutting down the whole system, I can't
> > believe there's much value in *anything* we do in the pciehp_remove()
> > path.
> > 
> > Maybe we should just get rid of pciehp_remove() (and probably
> > pcie_port_remove_service() and the other service driver remove methods)
> > completely.  That dates from when the service drivers could be modules that
> > could be potentially unloaded, but unloading them hasn't been possible for
> > years.
> 
> Shutdown path is also used for kexec. Leaving hotplug interrupts
> pending is dangerous for the newly loaded kernel as it leaves
> spurious interrupts during the new kernel boot.
> 
> I think we should always disable the hotplug interrupt on shutdown.
> We might think of not waiting for command-completion as a
> middle-ground or go to polling path instead of interrupts all the
> time.

Ah, I forgot about the kexec path.  The kexec path is used for
crashdump, too, so ideally the newly-loaded kernel would defend itself
when possible so it doesn't depend on the original kernel doing things
correctly.

Seems like this question of whether to do things in the original
kernel or the kexec-ed kernel comes up periodically, but I can never
remember a definitive answer.  My initial reaction is that it'd be
nice if we didn't have to do *any* shutdown in the original kernel,
but I'm sure there are reasons that's not practical.

I copied Eric (kexec maintainer) and Vivek (contact listed in
Documentation/kdump/kdump.txt) in case they have suggestions or would
consider some sort of Documentation/ update.

Bjorn
