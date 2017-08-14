Return-Path: <SRS0=f3i4=7Q=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=f3i4=7Q=intel.com=keith.busch@kernel.org>
Date: Mon, 14 Aug 2017 18:11:23 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Mayurkumar Patel <mayurkumar.patel@intel.com>
Subject: Re: [PATCH] pciehp: Fix infinite interupt handler loop
Message-ID: <20170814221123.GI7233@localhost.localdomain>
References: <1501571512-8362-1-git-send-email-keith.busch@intel.com>
 <20170814205948.GF32525@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170814205948.GF32525@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 14, 2017 at 03:59:48PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 01, 2017 at 03:11:52AM -0400, Keith Busch wrote:
> > We've encountered a particular platform that under some circumstances
> > always has the power fault detected status raised. The pciehp irq handler
> > would loop forever because it thinks it is handling new events when in
> > fact the power fault is not new. This patch fixes that by masking off
> > the power fault status from new events if the driver hasn't seen the
> > power fault clear from the previous handling attempt.
> 
> Can you say which platform this is?  If this is a hardware defect,
> it'd be interesting to know where it happens.
> 
> But I'm not sure we handle PCI_EXP_SLTSTA correctly.  We basically
> have this:
> 
>   pciehp_isr()
>   {
>     pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
>     events = status & (<events we care about>);
>     pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
>     <queue event handling>
>   }
> 
> The write to PCI_EXP_SLTSTA clears PCI_EXP_SLTSTA_PFD because it's
> RW1C.  But we haven't done anything that would actually change the
> situation that caused a power fault, so I don't think it would be
> surprising if the hardware immediately reasserted it.
> 
> So maybe this continual assertion of power fault is really a software
> bug, not a hardware problem?

I *think* it's a software bug for the exact reason you provided, but I'm
sure it must be isolated to certain conditions with certain hardware. We'd
have heard about this regression during 4.9 if it was more wide-spread.

This is on a PEX8733 bridge, and it reports power fault detected status as
long as the power fault exists. While we can write 1 to clear the event,
that just rearms the port to retrigger power fault detected status for as
long as the power controller detects its faulted. The status is cleared
for good only when the power fault no longer exists rather than when
it is acknowledged. The spec seems to support that view (Table (7-21:
Slot Status Register):

  Power Fault Detected – If a Power Controller that supports power fault
  detection is implemented, this bit is Set when the Power Controller
  detects a power fault at this slot.
