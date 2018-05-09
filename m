Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:46140 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756333AbeEIOHa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 10:07:30 -0400
Received: by mail-ua0-f182.google.com with SMTP id e8so20803578uam.13
        for <linux-pci@vger.kernel.org>; Wed, 09 May 2018 07:07:29 -0700 (PDT)
MIME-Version: 1.0
From: Doug Meyer <dmeyer@gigaio.com>
Date: Wed, 9 May 2018 07:07:28 -0700
Message-ID: <CA+GK6enjOck_VKNZq99yZcfAtn9oZ2FA0NC_GGqDcEi4C2Uz=w@mail.gmail.com>
Subject: Solution for access to device registers in PCI quirk for proxy devfn aliasing
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The primary intent of this email is to pass on my experience getting a
PCI quirk working with a PCIe NTB switch, in the hope that somebody in
the community can benefit from this experience.

The other intent of this email is to thank Bjorn Helgaas and Logan
Gunthorpe for helping out on the investigation and, ultimately,
finding the solution. Thank you, gentlemen.

Summary Overview:
I needed a way for a PCI switch to access host memory with TLPs that
had requester IDs (BDFs) that the host did not know about (had not
enumerated). The un-enumerated IDs had to be read from the PCI switch.

The solution implemented here is a function in drivers/pci/quirks.c
which uses pci_add_dma_alias(). But access to the PCI switch registers
was not possible until a call to pci_enable_device() was added at the
top of the function.

Problem:
With the IOMMU on, the IOMMU would object to seeing PCI
device-functions that it did not enumerate in TLPs originating from
the switch. This would happen because of the way the PCIe NTB switch
allows hosts to communicate with each other via non-transparent
bridges.

Essentially, Host A would enumerate its bus and see a non-transparent
endpoint (NT EP) at some BDF, such as 03:00.1. It is non-transparent,
so nothing is enumerated behind that EP. Host B does the same thing,
and sees its NT EP, perhaps also at its own BDF 03:00.1 (or something
else if the machines are not identically configured). When Host B
tries to access memory on Host A, a "proxy ID" is used internal to the
switch. The proxy ID is the devfn portion of the BDF. So, if Host B is
internally given a proxy ID of 04.2, then a memory access from Host B
to host A would have a TLP requester ID of 03:04.2. That BDF was never
enumerated by Host A.


TLP = TLP with Host B requester ID
TLP' = TLP with requester ID changed to a proxy ID for internal chip routing

                     [          SWITCH            ]

Host B ---> TLP ---> [NTB EP ---> TLP' ---> NTB EP] ---> TLP' ---> Host A

e.g. BDF    00:00.0                                      03:04.2


By default, the IOMMU does just what it is supposed to do: it blocks
the TLP. This is the sort of thing you'd see in dmesg/syslog:

        [ 1923.060446] DMAR: [DMA Read] Request device [03:04.2] fault
addr ffa00000 [fault reason 02] Present bit in context entry is clear


Proposal:
The proposed solution was to use pci_add_dma_alias() to alias the
proxy ID of any valid requestor to the NT switch device on the target
host.

As a topic for another day, my initial naive attempt was to call this
in the switch's device driver. The call seemed to work, but there was
no change in behavior, as if the aliasing wasn't actually happening.
It was then that Logan suggested that the aliasing needed to happen
much earlier, and so I was pointed to drivers/pci/quirks.c.

[Note: The idea of being able to do this aliasing in the driver is of
interest to me, should somebody know how.]

Solution:
There could be more than NT peer (host) in the system, and each peer
could have one or more proxy IDs. The proxy IDs are set by the switch
itself when it performs internal configuration after reset is
released. So, it is necessary for the quirk (on Host A in the above
example) to read this proxy configuration information from the switch
chip at runtime.

Fortunately, the switch supports a management capability which
provides access to the internal registers. This management capability
is located in BAR0. It was straight-forward to create a quirk with
this basic concept. The following code is simplified/scrubbed to focus
on the essentials.

    static void quirk_ntb_dma_alias(struct pci_dev *pdev)
    {
           void __iomem *mmio;
           u32 id_info;

           /* iomap all of BAR0 */
           mmio = pci_iomap(pdev, 0, 0);
           if (mmio == NULL) {
                   dev_err(&pdev->dev, ...);
                   return;
            }

            /* read the proxy ID information */
            [...]

           id_info = ioread32(mmio + various offsets);
           [...]

           /* extract the proxy ID and alias it to this device */
            pci_add_dma_alias(pdev, (id_info >> 1) & 0xFF);

            pci_iounmap(pdev, mmio);
           return;
    }
    DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_XXX,
         PCI_DEVICE_ID_YYY,
         PCI_CLASS_BRIDGE_OTHER, 8,
         quirk_ntb_dma_alias);


The issue with the above code is that it did not work. Reads of the
mapped iomem space returned all-Fs. Typically an indicator that the
reads timed out. Apparently the device was not responding to the read
TLPs.

Now, interestingly, a little test quirk (similar to the above, but
without the aliasing) was run on several different machines. These
machines did differ in terms of CPU (i7 vs a couple flavors of Xeon)
and PCI topology. In only one case was the BAR0 register space
accessible. In all other cases it was not (Fs were returned). That
mystery remains to this day.

In the end, I was pointed to the PCI command register. You can find
this register in the PCIe Base Specification section 7.5.1.1. This has
memory, I/O, and bus master enables that need to be properly set up.
Bjorn pointed me to pci_enable_device() which does this. To quote
Bjorn:

"The most likely reason it didn't respond here is that the
PCI_COMMAND_MEMORY bit in its command register is not set. That is
normally done when the driver calls pci_enable_device().  Quirks are
run before the driver claims the device, so if you need to access BARs
from a quirk, you would to call pci_enable_device() from the quirk
itself."


So I added the following to the top of the function, and the quirk
worked on all machines I tested it on.

    static void quirk_ntb_dma_alias(struct pci_dev *pdev)
    {
           void __iomem *mmio;
            u32 id_info;

           if (pci_enable_device(pdev)) {
                    dev_err(&pdev->dev, ...);
                   return;
           }

            /* iomap all of BAR0 */
           mmio = pci_iomap(pdev, 0, 0);
           [...]


Again, thanks to Bjorn and Logan.
Hopefully this will be a help to somebody else.

Closing repeat of previous note: If somebody knows a way to accomplish
this aliasing later so that it could be done in a device driver, I
would like to understand that.

Blessings,
Doug
