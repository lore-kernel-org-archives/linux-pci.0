Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755151AbeD3VRn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Apr 2018 17:17:43 -0400
Date: Mon, 30 Apr 2018 16:17:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
Message-ID: <20180430211740.GG95643@bhelgaas-glaptop.roam.corp.google.com>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
 <b62c2a8e-fe14-6d7d-147c-0ce3b0c0ab2f@codeaurora.org>
 <20180427211255.GI8199@bhelgaas-glaptop.roam.corp.google.com>
 <20180428005620.GB1675@dhcp-128-65.nay.redhat.com>
 <20180428011845.GC1675@dhcp-128-65.nay.redhat.com>
 <3ebc908fb196168bf0373875ffc5679e@codeaurora.org>
 <d8d134dc-9757-97cd-7a24-cbb21611d6c6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <d8d134dc-9757-97cd-7a24-cbb21611d6c6@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 30, 2018 at 04:48:15PM -0400, Sinan Kaya wrote:
> Bjorn,
> 
> On 4/28/2018 9:03 AM, okaya@codeaurora.org wrote:
> >> Hmm, if it is the remove() method then kexec does not use it.  kexec use
> >> the shutdown() method instead.  I missed this details when I replied.
> > 
> > Portdrv hooks up remove handler to shutdown. That's why remove is getting called.
> 
> What should we do about this?
> 
> Since there is an actual HW errata involved, should we quirk this
> root port and not wait as if remove/shutdown doesn't exist?

I was hoping to avoid a quirk because AFAIK all Intel parts have this
issue so it will be an ongoing maintenance issue.  I tried to avoid
the timeout delays, e.g., with 40b960831cfa ("PCI: pciehp: Compute
timeout from hotplug command start time").

But we still see the alarming messages, so we should probably add a
quirk to get rid of those.

But I haven't given up on the idea of getting rid of the
pciehp_remove() path.  I'm not convinced yet that we actually need to
do anything to shut this device down.  I don't like the assumption
that kexec requires this.  The kexec is fundamentally just a branch,
and anything we do before the branch (i.e., in the old kernel), we
should also be able to do after the branch (i.e., in the kexec-ed
kernel).

> Paul,
> You might want to file a bugzilla so that we can keep our debug
> efforts out of this list.
