Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33661 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbbHESuv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Aug 2015 14:50:51 -0400
Received: by igbpg9 with SMTP id pg9so120801827igb.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Aug 2015 11:50:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABLseQ56naxmEHupwjKLQE0J_w6oTGqC=ox_0J4CV1eisK=5Dg@mail.gmail.com>
References: <CABLseQ6HhaozD6D0Y-gPpjz1R5Ass_-mumn9jfcWReAVvrdjHQ@mail.gmail.com>
	<CAErSpo4f_BLrnq7T2foOA2HAySPTDVYn61dfyOfZahyiyzGTdg@mail.gmail.com>
	<CABLseQ4eR5DyzSar+TwTOOJkq2_za2t47j-4RYPgQnNrZXmWiA@mail.gmail.com>
	<20150803222726.GB11144@google.com>
	<CABLseQ56naxmEHupwjKLQE0J_w6oTGqC=ox_0J4CV1eisK=5Dg@mail.gmail.com>
Date: Wed, 5 Aug 2015 11:50:50 -0700
Message-ID: <CAE9FiQUdTAKp=rf+ursKzWowV9T0R=rV5eWrN6zoo7nkxbZ0Sg@mail.gmail.com>
Subject: Re: Failure to HotPlug if devices not present at boot - no memory space
From: Yinghai Lu <yinghai@kernel.org>
To: Barry Grussling <barry@grussling.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 3, 2015 at 4:31 PM, Barry Grussling <barry@grussling.com> wrote:
> On Mon, Aug 3, 2015 at 3:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> You might have a host bridge driver that knows how to set up the
>> windows.  Your dmesg logs mention altera_hps2fpga_bridge, which
>> doesn't seem to be in the upstream kernel, so I don't know what it
>> does.

Please try to use

echo 1 > /sys/devices/pci0000:00/000:02:0f.0/pci_bus/0000:08/rescan

it will increase mmio range for 02:0f.0.

If it does not work, you may need to try
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-v4.3-next

as it include one fix

PCI: Treat optional as must in first try for bridge rescan

https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/patch/?id=f83b7ff4676da783f4615cb5e60102cd5181eee9

Also you turn off the power between the removal and rescan, you may need to
boot with "pci=pcie_bus_perf" and use following patch that configure
the MPSS to make it consistent between bridge and device.

Subject: [PATCH] PCI: Configure MPS during rescan bus

When we disable link and renable link of pcie downstream port, MPSS of device
under the bridge could reset to 128.

Just call pcie_bus_configure_settings just like boot path and hotplug
path.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/probe.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-2.6/drivers/pci/probe.c
===================================================================
--- linux-2.6.orig/drivers/pci/probe.c
+++ linux-2.6/drivers/pci/probe.c
@@ -2409,6 +2409,8 @@ unsigned int pci_rescan_bus_bridge_resiz

     pci_assign_unassigned_bridge_resources(bridge);

+    pcie_bus_configure_settings(bus);
+
     pci_bus_add_devices(bus);

     return max;
@@ -2429,6 +2431,15 @@ unsigned int pci_rescan_bus(struct pci_b

     max = pci_scan_child_bus(bus);
     pci_assign_unassigned_bus_resources(bus);
+
+    if (pci_is_root_bus(bus)) {
+        struct pci_bus *child;
+
+                list_for_each_entry(child, &bus->children, node)
+            pcie_bus_configure_settings(child);
+    } else
+        pcie_bus_configure_settings(bus);
+
     pci_bus_add_devices(bus);

     return max;
