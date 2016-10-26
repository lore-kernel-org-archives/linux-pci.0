Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753142AbcJZOAz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 10:00:55 -0400
Message-ID: <5810B715.2040308@redhat.com>
Date: Wed, 26 Oct 2016 10:00:53 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Keith Busch <keith.busch@intel.com>
CC: linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Myron Stowe <mstowe@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFE PATCH] pci: Do not enable intx on MSI-capable devices on
 shutdown
References: <1477052083-13815-1-git-send-email-prarit@redhat.com> <20161025180858.GA22422@localhost.localdomain> <580FADC6.1020407@redhat.com> <20161025221613.GA32365@localhost.localdomain>
In-Reply-To: <20161025221613.GA32365@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/25/2016 06:16 PM, Keith Busch wrote:
> On Tue, Oct 25, 2016 at 03:08:54PM -0400, Prarit Bhargava wrote:
>> When pci_disable_msi() is currently called the result is that device is
>> switched back to intx and then the MSI IRQs are free'd.  This patch would
>> modify that behavior, and intx would not be reenabled when pci_disable_msix()
>> was called during runtime.  With the system_state patch we're only affecting
>> shutdown, which is seen as less risky than doing
> 
> My proposal isn't really modifying exisiting behavior since if it does,
> the currently in place expectations are being violated: if anyone calls
> "pci_disable_msi" with actions on the irqs being disabled, they're
> already screwed since they will hit the BUG_ON in free_msi_irqs.

I thought msi_has_action() would have returned 1 until free_msi_irqs() was
called.  Yes, your patch would work.

I also want to add this interesting tidbit:  I have noticed in the past that
*many* systems no longer print the

 Restarting system.
 reboot: machine restart

[and some also print an extra line of, "ACPI MEMORY or I/O RESET_REG"]

messages at the end of boot.  For a long time I had assumed that this was
because the reboot was racing with printk somehow and that the system shutdown
or rebooted before those lines made it "out" through the serial port.

With the previously rejected patch from

https://patchwork.kernel.org/patch/5990701/

the messages are output to the screen again (I'm not 100% sure on this but I
think this is occurring for systems where the serial port or usb port is behind
a pci device).  This result lends more support to the idea that we're doing
something wrong by blindly disabling msi/x interrupts when the driver doesn't
support it.

There are several ways of fixing this, and I'm not sure one is better than the
other.  It seems no matter what we do here there's risk of breaking something
and I'm leaning towards fixing this by only calling the msi disable code when a
shutdown function has been called.

Bjorn, I'd like to hear what you think...

P.
