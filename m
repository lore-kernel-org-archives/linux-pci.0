Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:59706 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbaFEFvk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jun 2014 01:51:40 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 5 Jun 2014 15:51:38 +1000
Date: Thu, 5 Jun 2014 15:51:34 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 4/4] vfio/pci: Restore MSIx message prior to enabling
Message-ID: <20140605055134.GA10787@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400468470-11262-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <20140530221232.GG4607@google.com>
 <20140531114252.GA8509@shangw>
 <CAErSpo4j8CSwKMn_V4=b5=JrX0M_GyTWoAqxWnRso+nvWbTQWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4j8CSwKMn_V4=b5=JrX0M_GyTWoAqxWnRso+nvWbTQWA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 02, 2014 at 10:57:05AM -0600, Bjorn Helgaas wrote:
>On Sat, May 31, 2014 at 5:42 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> On Fri, May 30, 2014 at 04:12:32PM -0600, Bjorn Helgaas wrote:
>>>On Mon, May 19, 2014 at 01:01:10PM +1000, Gavin Shan wrote:

.../...

[ Remove the confusing description ]

>It sounds like QEMU assumes the MSIx entries can't be changed by
>anything other than the writes it traps.  This assumption is false
>(the entries are cleared when the driver resets the device, and QEMU
>doesn't know about the reset).
>

If I'm correct enough, QEMU disallows access to MSIx table in HW.
Access is captured by QEMU and terminated there for most of cases.
MSIx message can't be written to HW.
 
>Why can't QEMU trap the write from pci_restore_state() and update the
>hardware, even if it thinks nothing has changed?
>

For MSIx messages, pci_restore_start() restores what the device got
from QEMU. I think the MSIx message isn't expected one by HW (more
details below).

Sorry, Bjorn. I think my last reply should have confused you as that's not
correct. The problem and tentative fix has been there for a some time.
I almost forgot the details. I rechecked the discussion about the topic.
It's not what I described in last reply:

http://comments.gmane.org/gmane.comp.emulators.kvm.devel/119689

Let me correct it like this. Alex.W in the cc list is the VFIO expert.
I might have something wrong about VFIO and Alex could help correcting :-)

1) Guest: PCI device works fine in guest
2) QEMU:  MSIx entry cache (unmasked). It seems the MSIx message maintained
by QEMU is figured out by itself and inconsistent with HW (host kernel). It's
separate (potential) issue. So QEMU and host don't exchange MSIx message with
each other.
3) Guest: PCI device driver calls pci_save_state(), issue reset,
pci_restore_state().
4) QEMU got trapped and notify VFIO PCI device to start the MSIx interrupt,
which is done by ioctl() to VFIO PCI device on host side. It seems that VFIO
device driver does request_irq() and setup irqfd stuff so that the interrupt
can be propagated to QEMU.

The problem is that we got MSIx message lost, which was caused by the
reset. Unfortunately, no one tried retoring the message to hardware.
Eventually, the PCI device sends DMA (for MSIx interrupt) traffic with
0x0's address/data, which isn't allowed on Power platform and causes
EEH error.

Since MSIx message QEMU and host owes are different and QEMU is having
invalid message, so it's not making sense to update hardware with QEMU's
cached message. On the other hand, the message data should be restored
to HW by somebody and the senario is related to VFIO PCI. It sounds
fair to have VFIO PCI driver resotres the message as we did. As you said,
it's ugly for driver to write MSIx message. I'm not sure.

>From guest itself, PCI code is consistent and I don't think there has
anything we need improve for this: pci_save_state(), reset, pci_restore_state()
should work fine.

>From the host side, we probably can restore MSIx message in request_irq().
In the IRQ chip callbacks (e.g. startup, unmask), we could have overhead
to restore MSIx message. However, it's totally unnecessarily to host itself.

Hopefully, I make myself clear this time :-)

Thanks,
Gavin 

