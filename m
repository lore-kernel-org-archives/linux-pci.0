Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:54998 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932065Ab3CLQfg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Mar 2013 12:35:36 -0400
Message-ID: <513F5954.9060701@fold.natur.cuni.cz>
Date: Tue, 12 Mar 2013 17:35:32 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
References: <50EDF8FE.6040607@fold.natur.cuni.cz> <CAErSpo6etF7_fZH9nNoAhtRXdGEmBrNE7v84TRkoawyG9s4AGw@mail.gmail.com> <51371AD9.4040801@fold.natur.cuni.cz> <CAErSpo5wmM8+Qd4FH0WeNS_DJEk2Tmmivk-FgEbD-UbTMQf+ZQ@mail.gmail.com> <51394317.20104@fold.natur.cuni.cz> <CAErSpo7wsduVN1Q6k_D7r24AhpVcARZRXtv6FvSfMMjFNJMcRA@mail.gmail.com>
In-Reply-To: <CAErSpo7wsduVN1Q6k_D7r24AhpVcARZRXtv6FvSfMMjFNJMcRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas wrote:
> On Thu, Mar 7, 2013 at 6:47 PM, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz> wrote:

> 
> There are three cards on the table now:
> 
>   pci 0000:11:00.0: [1095:3132] SiI 3132 Serial ATA Raid II Controller
>   pci 0000:11:00.0: [1106:3403] VT6315 Series Firewire Controller
>   pci 0000:11:00.0: [1033:0194] NEC Corporation uPD720200 USB 3.0 Host
> Controller
> 

>> My question is. Has the laptop hardwired the ExpressCard slot somehow through USB
>> to the SandyBridge chip?
> 
> An ExpressCard slot (spec at [1]) supports both a PCIe interface and a
> USB interface, so the slot *should* be connected to a USB controller
> as well as to a PCIe root port.  An ExpressCard can contain either a
> PCIe device or a USB device or both.  Section 6.3 of the spec talks
> about ACPI requirements to describe the relationship between the PCIe
> and USB devices.  I'm not sure that Linux pays any attention to this
> in the hotplug paths, so I'm a little worried about this.  (Maybe it
> doesn't need to in the PCIe-aware case; I don't know.)
> 
> It would be interesting to know exactly what devices are on your
> cards.  Assuming they all work when present at boot, you could find
> that by doing a single "lspci -vv" and "lsusb -v" after a boot with an
> empty slot, and doing it again after a boot with a card in the slot.

There is no USB device hidden in the eSATA card (SiI 3132) and
lspci -vvvxxx does not reveal any other device either. I also failed to 
ind any hidden interface in the Firewire card (based on VIA VT6315)
both using lspci -vvvxxx and lsusb -vv and comparing outputs gather
upon coldplug with a card in a slot and an empty slot. I even compared to
states with a hotplugged card.

The only difference I would mention is that acpiphp vs. pciehp give:

-       Physical Slot: 1
+       Physical Slot: 7

for whatever card is placed in the card slot.

Sometimes there is a difference in 

-       Latency: 0, Cache Line Size: 64 bytes
+       Latency: 0, Cache Line Size: 32 bytes


-                AERCap: First Error Pointer: 00, ...
+                AERCap: First Error Pointer: 14, ...


> The difference should be the ExpressCard devices.  I'm sure this is
> buried in your tarball somewhere, but all I want is the info from a
> machine in default configuration -- MediaCard enabled, etc.  Just the
> way a typical user would be using the machine.
> 
> [1] http://www.usb.org/developers/expresscard/EC_specifications/ExpressCard_2_0_FINAL.pdf

I tried to find some differences when I have Enabled (default) or Disables Media
Card Reader in BIOS. Unfortunately I had also disabled Intel WIFI and Bluetooth
via Fn+F2 (there is no BIOS entry for it so I forgot about the hotkey). The wifi
can be seen in lsusb and lspci. The bluetooth ... I don't know, looks btusb driver
is using it.
The MediaCard Reader device appears only in lsusb. If I disable it in BIOS its port
is left powered on. Below, one of the changes is the disabled wifi, the other is
the card reader being gone.

--- eSATA_inserted_coldboot/lsusb_vv_after_HDD_attached.txt     2013-03-11 18:12:05.000000000 +0100
+++ eSATA_hotplug_disabled_Media_card_reader/lsusb_vv.txt       2013-03-11 22:49:51.000000000 +0100
@@ -62,7 +62,7 @@
    Port 1: 0000.0100 power
    Port 2: 0000.0100 power
    Port 3: 0000.0100 power
-   Port 4: 0000.0103 power enable connect
+   Port 4: 0000.0100 power
    Port 5: 0000.0503 highspeed power enable connect
    Port 6: 0000.0100 power
 Device Qualifier (for other device speed):
@@ -142,7 +142,7 @@
    Port 3: 0000.0103 power enable connect
    Port 4: 0000.0100 power
    Port 5: 0000.0100 power
-   Port 6: 0000.0503 highspeed power enable connect
+   Port 6: 0000.0100 power
    Port 7: 0000.0100 power
    Port 8: 0000.0100 power
 Device Qualifier (for other device speed):
@@ -1568,76 +1318,7 @@
 Device Status:     0x0000
   (Bus Powered)
 
-Bus 002 Device 005: ID 0bda:0138 Realtek Semiconductor Corp. RTS5138 Card Reader Controller
-Device Descriptor:
-  bLength                18
-  bDescriptorType         1
-  bcdUSB               2.00
-  bDeviceClass            0 (Defined at Interface level)
-  bDeviceSubClass         0 
-  bDeviceProtocol         0 
-  bMaxPacketSize0        64
-  idVendor           0x0bda Realtek Semiconductor Corp.
-  idProduct          0x0138 RTS5138 Card Reader Controller
-  bcdDevice           38.82
-  iManufacturer           1 Generic
-  iProduct                2 USB2.0-CRW
-  iSerial                 3 20090516388200000
-  bNumConfigurations      1
-  Configuration Descriptor:
-    bLength                 9
-    bDescriptorType         2
-    wTotalLength           32
-    bNumInterfaces          1
-    bConfigurationValue     1
-    iConfiguration          4 CARD READER
-    bmAttributes         0xa0
-      (Bus Powered)
-      Remote Wakeup
-    MaxPower              500mA
-    Interface Descriptor:
-      bLength                 9
-      bDescriptorType         4
-      bInterfaceNumber        0
-      bAlternateSetting       0
-      bNumEndpoints           2
-      bInterfaceClass         8 Mass Storage
-      bInterfaceSubClass      6 SCSI
-      bInterfaceProtocol     80 Bulk-Only
-      iInterface              5 Bulk-In, Bulk-Out, Interface
-      Endpoint Descriptor:
-        bLength                 7
-        bDescriptorType         5
-        bEndpointAddress     0x01  EP 1 OUT
-        bmAttributes            2
-          Transfer Type            Bulk
-          Synch Type               None
-          Usage Type               Data
-        wMaxPacketSize     0x0200  1x 512 bytes
-        bInterval               0
-      Endpoint Descriptor:
-        bLength                 7
-        bDescriptorType         5
-        bEndpointAddress     0x82  EP 2 IN
-        bmAttributes            2
-          Transfer Type            Bulk
-          Synch Type               None
-          Usage Type               Data
-        wMaxPacketSize     0x0200  1x 512 bytes
-        bInterval               0
-Device Qualifier (for other device speed):
-  bLength                10
-  bDescriptorType         6
-  bcdUSB               2.00
-  bDeviceClass            0 (Defined at Interface level)
-  bDeviceSubClass         0 
-  bDeviceProtocol         0 
-  bMaxPacketSize0        64
-  bNumConfigurations      1
-Device Status:     0x0000
-  (Bus Powered)
-
[cut]



Looks that is all I could add to the whole story.

Martin
