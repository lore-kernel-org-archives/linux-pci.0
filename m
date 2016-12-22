Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 22 Dec 2016 12:45:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: John Crispin <john@phrozen.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH] pci: add kernel config option for disabling common PCI
 quirks
Message-ID: <20161222184553.GA16590@bhelgaas-glaptop.roam.corp.google.com>
References: <1482306784-29224-1-git-send-email-john@phrozen.org>
 <20161221122213.GA32563@infradead.org>
 <8630ec3a-9424-653c-7c7a-d88554011151@phrozen.org>
 <20161221142607.GA8594@infradead.org>
 <dba6a1d8-d1d6-581e-8a1b-7988ff2577e0@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dba6a1d8-d1d6-581e-8a1b-7988ff2577e0@phrozen.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 22, 2016 at 06:54:51AM +0100, John Crispin wrote:
> On 21/12/2016 15:26, Christoph Hellwig wrote:
> > On Wed, Dec 21, 2016 at 02:11:25PM +0100, John Crispin wrote:
> >> I can turn it into an enable patch that is selected by default.
> >>
> >> The current patch disables all those quirks that are used for x86/PC
> >> style machines and hence are not required in the embedded world.
> > 
> > Maybe we'll just need to reorganize the quirks so that most of them
> > arch in arch code or the affected drivers?
> 
> to be honest i have no opinion on this. I am currently trying to reduce
> the amount of patches that we have inside the LEDE tree. the patches
> were written by other people and then dumped on us. obviously i am
> interested to get this upstream with the least amount of effort. I am
> quite aware though that some patches will need an overhaul to be
> applicable for upstream. its not really my call if it is enough to make
> this an enable patch and review the quirks enabled by it or if the code
> needs to be moved.

We already have CONFIG_PCI_QUIRKS, which enables everything in
drivers/pci/quirks.c.  That file should contain quirks for devices
that may appear on any architecture, e.g., things on plug-in cards.

Quirks that are only applicable to one arch should be in the arch
directory, e.g., in arch/x86/pci/fixup.c.

If drivers/pci/quirks.c contains arch-specific quirks, we should move
those to the appropriate arch directory.

It looks like arch/x86/pci/fixup.c is currently compiled
unconditionally (on x86 with PCI), but we should probably make it
dependent on CONFIG_PCI_QUIRKS, since I think the infrastructure that
*calls* those quirks is only present when CONFIG_PCI_QUIRKS=y.

Bjorn
