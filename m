Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932377AbdHWSAc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Aug 2017 14:00:32 -0400
Date: Wed, 23 Aug 2017 13:00:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Oza <oza.oza@broadcom.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>,
        Timur Tabi <timur@codeaurora.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v7 1/2] PCI: iproc: Retry request when CRS returned from
 EP
Message-ID: <20170823180029.GD8498@bhelgaas-glaptop.roam.corp.google.com>
References: <1503331124-25029-1-git-send-email-oza.oza@broadcom.com>
 <1503331124-25029-2-git-send-email-oza.oza@broadcom.com>
 <20170822203347.GE6948@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPctfRhf8zkeoGN73N-vm8Adn7SwieAAeRKrjhY7m_RkEw@mail.gmail.com>
 <20170823135140.GA8498@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPf5c2=zO81-7TEidOHbB8K0L3T2_wV4+9Gem5DB6rHWFw@mail.gmail.com>
 <eb01a01b-ee8a-1c51-69ba-838bfe94b6f6@codeaurora.org>
 <CAMSpPPenUvGVwTf9ZKJoK08fm6L-0c=anPUaRRZdkHBzhGO-dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMSpPPenUvGVwTf9ZKJoK08fm6L-0c=anPUaRRZdkHBzhGO-dA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 09:32:06PM +0530, Oza Oza wrote:
> On Wed, Aug 23, 2017 at 9:22 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> > Hi Oza,
> >
> >> In working Enumuration case I get following:
> >> [    9.125976] pci 0000:00:00.0: bridge configuration invalid ([bus
> >> 00-00]), re-configuring
> >> [    9.134267] where=0x0 val=0xffff0001
> >> [    9.146946] where=0x0 val=0xffff0001
> >> [    9.158943] where=0x0 val=0xffff0001
> >> [    9.170945] where=0x0 val=0xffff0001
> >> [    9.186945] where=0x0 val=0xffff0001
> >> [    9.210944] where=0x0 val=0xffff0001
> >> [    9.250943] where=0x0 val=0xffff0001
> >> [    9.322942] where=0x0 val=0xffff0001
> >> [    9.458943] where=0x0 val=0xffff0001
> >> [    9.726942] where=0x0 val=0x9538086    >> actual vendor and device id.
> >>
> >> so I think I have to retry in RC driver, so the old code still holds good.
> >> except that I have to do factoring out
> > You need to return 0xFFFF0001 for vendor ID register and return 0xFFFFFFFF for
> > other registers like COMMAND register during the CRS period.

The proposal we're trying to implement is to handle this controller as
an RP that does not support CRS SV.  Such an RP would never return
0xffff0001 for the vendor/device ID.  If it never got a successful
completion, it would return 0xffffffff.

So I think you do have to either retry (as in your v7 patch) or add a
delay before we start enumeration.

It looks like we waited somewhere between 320ms and 590ms before this
device became ready.

The PCI specs do require a delay after a reset (PCIe r3.1, sec 6.6.1)
before software sends a config request.  I don't think there's
anywhere in the PCI core where we delay before we first enumerate
devices under a host bridge.  I'm not sure we'd *want* such a delay in
the PCI core, because on many systems the BIOS has already initialized
the PCI controller, and an additional delay would be unnecessary and
would only slow down boot.

But it might make sense to add a delay in the PCI controller driver --
it knows when the reset occurs and probably knows more about the
firmware environment.  I haven't tried to analyze all of sec 6.6.1,
but this section:

  Unless Readiness Notifications mechanisms are used (see Section
  6.23), the Root Complex and/or system software must allow at least
  1.0 s after a Conventional Reset of a device, before it may
  determine that a device which fails to return a Successful
  Completion status for a valid Configuration Request is a broken
  device. This period is independent of how quickly Link training
  completes.

  Note: This delay is analogous to the Trhfa parameter specified for
  PCI/PCI-X, and is intended to allow an adequate amount of time for
  devices which require self initialization.

makes it sound like a 1sec delay might be needed.  That sounds like an
awful lot, but this device did take close to that amount of time.

I don't care which way you go.  You've already implemented the delay
in the v7 patch, and that's fine with me.

Bjorn
