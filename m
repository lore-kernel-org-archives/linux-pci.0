Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752138AbdHDN1q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Aug 2017 09:27:46 -0400
Date: Fri, 4 Aug 2017 08:27:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Oza <oza.oza@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: Re: [PATCH v5 1/2] PCI: iproc: Retry request when CRS returned from
 EP
Message-ID: <20170804132743.GC16580@bhelgaas-glaptop.roam.corp.google.com>
References: <1499310582-21193-1-git-send-email-oza.oza@broadcom.com>
 <1499310582-21193-2-git-send-email-oza.oza@broadcom.com>
 <20170802210455.GF20308@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPcfUFmjg471qmzqQmayNYzfq8Wo7yfHeiEKrj7hkWF=zg@mail.gmail.com>
 <20170803185713.GV20308@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPcbnVefeVVh3HJd1M+8co+4VMj8HU2zmXMv4K5VGcdjVg@mail.gmail.com>
 <CAMSpPPfOwnevUNui+zUe1bbq655kHQ=u3FyOiRTO5NAo0yWBTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMSpPPfOwnevUNui+zUe1bbq655kHQ=u3FyOiRTO5NAo0yWBTg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 04, 2017 at 11:40:46AM +0530, Oza Oza wrote:
> On Fri, Aug 4, 2017 at 11:29 AM, Oza Oza <oza.oza@broadcom.com> wrote:
> > On Fri, Aug 4, 2017 at 12:27 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> On Thu, Aug 03, 2017 at 01:50:29PM +0530, Oza Oza wrote:
> >>> On Thu, Aug 3, 2017 at 2:34 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> > On Thu, Jul 06, 2017 at 08:39:41AM +0530, Oza Pawandeep wrote:
...

> >>> > What about CRS status for a config *write*?  There's nothing here to
> >>> > reissue those.
> >>>
> >>> No, we do not need there, because read will always be issued first
> >>> before any write.
> >>> so we do not need to implement write.
> >>
> >> How so?  As far as I know, there's nothing in the spec that requires
> >> the first config access to a device to be a read, and there are
> >> reasons why we might want to do a write first:
> >> http://lkml.kernel.org/r/5952D144.8060609@oracle.com
> >>
> >
> > I understand your point here. my thinking was during enumeration
> > process first read will always be issued
> > such as vendor/device id.
> > I will extend this implementation for write.
> 
> I am sorry, but I just released that, it is not possible to implement
> retry for write.
> the reason is:
> 
> we have indirect way of accessing configuration space access.
> for e.g.
> for config write:
> 
> A) write to to addr register.
> B) write to data register
> 
> now above those 2 registers are implemented by host bridge (not in
> PCIe core IP).
> there is no way of knowing for software, if write has to be retried.
> 
> e.g. I can not read data register (step B) to check if write was successful.
> I have double checked this with internal ASIC team here.

The bottom line is that you're saying this hardware cannot correctly
support CRS.  Maybe the workaround you're proposing will work in many
cases, but we need to acknowledge in the code and changelog that there
are issues we might trip over.
