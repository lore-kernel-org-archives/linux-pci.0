Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.152]:52912 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752630Ab3H1Ndt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 09:33:49 -0400
Date: Wed, 28 Aug 2013 15:33:37 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: <linux-pci@vger.kernel.org>
CC: <johannes.thumshirn@men.de>
Subject: PCI reset problem
Message-ID: <20130828133337.GA8544@jtlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi List,

I have a rather odd problem with a PCIe swicht/bridge which does not get
enumerated correctly. If I issue _two_ manual rescans of the PCI bus via sysfs,
everything get setup correctly. To work around the problem I decided to make a
platform specific PCI quirk (for the embedded system I'm on, to not break
anything else) and issue the pci_rescan_bus() myself as a "final" fixup. However
this does not have any effect at all.

Does anyone have an idea what I could do wrong?

Example:
root@generic-powerpc:~# lspci -tv
-[0000:00]---00.0-[01]--
root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
[...]
root@generic-powerpc:~# lspci -tv
-[0000:00]---00.0-[01-05]----00.0-[02-05]--+-01.0-[03]--
                                           +-02.0-[04]--
                                           \-03.0-[05]--
root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
[...]
root@generic-powerpc:~# lspci -tv
-[0000:00]---00.0-[01-05]----00.0-[02-05]--+-01.0-[03]----00.0  Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
                                           +-02.0-[04]--
                                           \-03.0-[05]--+-00.0  Pericom Semiconductor Device 400e
                                                        +-00.1  Pericom Semiconductor Device 400e
                                                        \-00.2  Pericom Semiconductor Device 400f


"My" rescan quirk:
#if CONFIG_PCI
static DEFINE_MUTEX(rescan_mutex);
static void xm51_fixup_bridge(struct pci_dev *dev)
{
        struct pci_bus *b = NULL;

        mutex_lock(&rescan_mutex);
        while((b = pci_find_next_bus(b)) != NULL)
                pci_rescan_bus(b);
        mutex_unlock(&rescan_mutex);
}
DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, 0x0401, xm51_fixup_bridge);
#endif


Thanks in advance,
Johannes
