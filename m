Return-Path: <gwshan@linux.vnet.ibm.com>
Return-Path: <gwshan@linux.vnet.ibm.com>
Date: Wed, 26 Oct 2016 12:02:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, benh@au1.ibm.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au, clsoto@us.ibm.com
Subject: Re: [PATCH v2 2/2] PCI: Don't disable PF's memory decoding when
 enabling SRIOV
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1475192870-7763-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1475192870-7763-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20161021165034.GE9007@localhost>
 <20161023232802.GA7215@gwshan>
 <20161024140316.GA14177@localhost>
 <20161025014728.GA32507@gwshan>
 <20161025035113.GA21423@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161025035113.GA21423@localhost>
Message-Id: <20161026010225.GA10306@gwshan>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 24, 2016 at 10:51:13PM -0500, Bjorn Helgaas wrote:
>On Tue, Oct 25, 2016 at 12:47:28PM +1100, Gavin Shan wrote:
>> On Mon, Oct 24, 2016 at 09:03:16AM -0500, Bjorn Helgaas wrote:
>> >On Mon, Oct 24, 2016 at 10:28:02AM +1100, Gavin Shan wrote:
>> >> On Fri, Oct 21, 2016 at 11:50:34AM -0500, Bjorn Helgaas wrote:
>> >> >On Fri, Sep 30, 2016 at 09:47:50AM +1000, Gavin Shan wrote:

.../...

>
>That specific case (pci_enable_device() followed by
>pci_update_resource()) should *not* work.  pci_enable_device() is
>normally called by a driver's .probe() method, and after we call a
>.probe() method, the PCI core shouldn't touch the device at all
>because there's no means of mutual exclusion between the driver and
>the PCI core.
>
>I think pci_update_resource() should only be called in situations
>where the caller already knows that nobody is using the device.  For
>regular PCI BARs, that doesn't necessarily mean PCI_COMMAND_MEMORY is
>turned off, because firmware leaves PCI_COMMAND_MEMORY enabled for
>many devices, even though nobody is using them.
>
>Anyway, I think that's a project for another day.  That's too much to
>tackle for the limited problem you're trying to solve.
>

Bjorn, it's all about discussion. Please take your time and reply when
you have bandwidth.

Well, some drivers break the order and expects the relaxed order to work.
One example is drivers/char/agp/efficeon-agp.c::agp_efficeon_probe(). I
didn't check all usage cases.

I think it's hard for user, who calls pci_update_resource(), to know
that nobody is using the devcie (limited to memory BARs as we concern).
The memory write is usually non-posted transaction and it can be on
the way to target device when pci_update_resource() is called. So which
one tranaction will be completed first (disabling memory decoding and
memory write). I guess it can happen even with the mutual exclusion,
especially on SMP system. Yes, the situation is worse without the
synchronization.

.../...

>> 
>> Yeah, it would be the solution to have. If you agree, I will post
>> updatd version according to this: Clearing PCI_SRIOV_CTRL_MSE when
>> updating IOV BARs. The bit won't be touched if pdev->mmio_always_on
>> is true.
>
>I think you should ignore pdev->mmio_always_on for IOV BARs.
>mmio_always_on is basically a workaround for devices that either don't
>follow the spec or where we didn't completely understand the problem.
>I don't think there's any reason to set mmio_always_on for SR-IOV
>devices.
>

Agree, thanks for the comments again. I will post updated version
shortly.

Thanks,
Gavin
