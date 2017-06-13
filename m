Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36516 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdFMEVR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jun 2017 00:21:17 -0400
Received: by mail-wr0-f171.google.com with SMTP id 36so1469291wry.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Jun 2017 21:21:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1706121010010.2092-100000@iolanthe.rowland.org>
References: <CAAd53p6S9NPBD=qGP419mhBgSgn-s1dc=adued8Y+Y0=GDsHKg@mail.gmail.com>
 <Pine.LNX.4.44L0.1706121010010.2092-100000@iolanthe.rowland.org>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 13 Jun 2017 12:21:15 +0800
Message-ID: <CAAd53p580X5_G6a05aAueHVxEoy5hpQrs6s2gtJA+gPEf2PqLg@mail.gmail.com>
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>, gregkh@linuxfoundation.org,
        USB list <linux-usb@vger.kernel.org>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 12, 2017 at 10:18 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> Let's get some help from people who understand PCI well.
>
> Here's the general problem: Kai-Heng has a PCI-based USB host
> controller that advertises wakeup capability from D3, but it doesn't
> assert PME# from D3 when it should.  For "lspci -vv" output, see
>
>         http://marc.info/?l=linux-usb&m=149570231732519&w=2
>
> On Mon, 12 Jun 2017, Kai-Heng Feng wrote:
>
>> On Mon, Jun 12, 2017 at 3:04 PM, Kai-Heng Feng
>> <kai.heng.feng@canonical.com> wrote:
>> > On Fri, Jun 9, 2017 at 10:43 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> >> On Fri, 9 Jun 2017, Kai-Heng Feng wrote:
>> >>
>> >> Is this really the right solution?  Maybe it would be better to allow
>> >> the controller to go into D3 provided no wakeup signal is needed.  You
>> >> could do:
>> >>
>> >>                 device_set_wakeup_capable(&pdev->dev, 0);
>> >
>> > This doesn't work.
>> > After applying this function, still nothing happens when devices get plugged in.
>> > IIUC this function disable the wakeup function, but what I want to do
>> > here is to have PME signal works even when runtime PM is enabled.
>
> This may indicate a bug in either the PCI or USB stacks (or both!).  If
> a driver requires wakeup capability from runtime suspend but the device
> does not provide it, the PCI core should not allow the device to go
> into runtime suspend.  Or is that the driver's responsibility?
>
>> > I also saw some legacy PCI PM stuff, so I also tried:
>> > device_set_wakeup_capable(&pdev->dev, 1);
>> > ...doesn't work either.
>> >
>> >>
>> >> Another alternative is to put the controller into D2 instead of D3, but
>> >> (1) I don't know how to do that, and (2) we don't know if wakeup
>> >> signalling works any better in D2 than it does in D3.
>> >
>> > I'll try if D2 works.
>>
>> Put the device into D2 instead of D3 can make the wakeup signaling
>> work, i.e. USB devices can be correctly detected after plugged into
>> EHCI port.
>>
>> Do you think this alternative an acceptable workaround?
>
> Yes, it is.  The difficulty is that I don't know how to tell the PCI
> core that the device should go in D2 during runtime suspend instead of
> D3.  Some sort of quirk may be needed -- perhaps Bjorn can help.
>

FWIW, this is the diff I used to make the controller transits to D2
instead of D3:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 563901cd9c06..36663688404a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -922,6 +922,9 @@ int pci_set_power_state(struct pci_dev *dev,
pci_power_t state)
        if (dev->current_state == state)
                return 0;

+       if (state > PCI_D2 && (dev->dev_flags & PCI_DEV_FLAGS_MAX_D2))
+               state = PCI_D2;
+
        __pci_start_power_transition(dev, state);

        /* This device is quirked not to be put into D3, so
diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 93326974ff4b..a2c1fe62974a 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -181,6 +181,8 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
                if (pdev->device == 0x7808) {
                        ehci->use_dummy_qh = 1;
                        ehci_info(ehci, "applying AMD
SB700/SB800/Hudson-2/3 EHCI dummy qh workaround\n");
+
+                       pdev->dev_flags |= PCI_DEV_FLAGS_MAX_D2;
                }
                break;
        case PCI_VENDOR_ID_VIA:
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8039f9f0ca05..6f86f2aa8548 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -188,6 +188,7 @@ enum pci_dev_flags {
         * the direct_complete optimization.
         */
        PCI_DEV_FLAGS_NEEDS_RESUME = (__force pci_dev_flags_t) (1 << 11),
+       PCI_DEV_FLAGS_MAX_D2 = (__force pci_dev_flags_t) (1 << 12),
 };

 enum pci_irq_reroute_variant {
