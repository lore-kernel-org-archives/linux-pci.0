Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56519 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab2HANmz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2012 09:42:55 -0400
Received: by wibhr14 with SMTP id hr14so4003165wib.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Aug 2012 06:42:54 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 1 Aug 2012 14:42:54 +0100
Message-ID: <CAOp+P+o5frkFRkrG9=2-3OL1AgDy+zVCbLgRqRVkm0yW_MaFVw@mail.gmail.com>
Subject: PCI express switch
From: =?ISO-8859-1?Q?Miguel_=C1ngel_=C1lvarez?=
	<caronteycerbero@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear all,

We are developing a board using a Freescale P2020. This micro has
three PCIexpress ports. 2 1xlane PCIe and 1 2xlane PCIe.

We have been able to successfully use the PCIe interfaces.

However, now we want to expand the number of PCIe slots connecting the
2xlane PCIe to a PCIe switch (89HPES6T5E). This switch offers a 2xlane
upstream port and 4 1xlane downstream ports.

The problem is that we do not really know how PCIe switches are
managed in Linux. If any of you can recommend us some resources to
read, we will appreciate it very much.

If there is no information to read, let me describe our main problem.

The question is that if I let u-boot scan the PCIe, the upstream and
downstream ports are detected as well as the cards connected to the
downstream port. However when u-boot launches Linux, this last just
finds a device (the HPES6T5E), and none of the downstream ports or
card connected to them.

pci 0000:00:00.0: PCI bridge, secondary bus 0000:01
pci 0000:00:00.0:   IO window: 0x00-0xffff
pci 0000:00:00.0:   MEM window: 0x80000000-0x9fffffff
pci 0000:00:00.0:   PREFETCH window: disabled
pci 0000:00:00.0: enabling device (0106 -> 0107)
pci 0001:02:00.0: PCI bridge, secondary bus 0001:03
pci 0001:02:00.0:   IO window: 0x00-0xffff
pci 0001:02:00.0:   MEM window: 0xa0000000-0xbfffffff
pci 0001:02:00.0:   PREFETCH window: disabled
pci 0001:02:00.0: enabling device (0106 -> 0107)
pci 0002:05:00.0: PCI bridge, secondary bus 0002:06
pci 0002:05:00.0:   IO window: disabled
pci 0002:05:00.0:   MEM window: 0xc0000000-0xc00fffff
pci 0002:05:00.0:   PREFETCH window: disabled
pci 0002:04:00.0: PCI bridge, secondary bus 0002:05
pci 0002:04:00.0:   IO window: 0x00-0xffff
pci 0002:04:00.0:   MEM window: 0xc0000000-0xdfffffff
pci 0002:04:00.0:   PREFETCH window: disabled
pci 0002:04:00.0: enabling device (0106 -> 0107)

However, if I do not let u-boot scan the bus, Linux finds five devices
for the 89HPES6T5E and the card connected to the downstream ports.

pci 0000:00:00.0: PCI bridge, secondary bus 0000:01
pci 0000:00:00.0:   IO window: 0x00-0xffff
pci 0000:00:00.0:   MEM window: 0x80000000-0x9fffffff
pci 0000:00:00.0:   PREFETCH window: disabled
pci 0000:00:00.0: enabling device (0106 -> 0107)
pci 0001:02:00.0: PCI bridge, secondary bus 0001:03
pci 0001:02:00.0:   IO window: 0x00-0xffff
pci 0001:02:00.0:   MEM window: 0xa0000000-0xbfffffff
pci 0001:02:00.0:   PREFETCH window: disabled
pci 0001:02:00.0: enabling device (0106 -> 0107)
pci 0002:06:02.0: PCI bridge, secondary bus 0002:07
pci 0002:06:02.0:   IO window: disabled
pci 0002:06:02.0:   MEM window: disabled
pci 0002:06:02.0:   PREFETCH window: disabled
pci 0002:06:03.0: PCI bridge, secondary bus 0002:08
pci 0002:06:03.0:   IO window: disabled
pci 0002:06:03.0:   MEM window: disabled
pci 0002:06:03.0:   PREFETCH window: disabled
pci 0002:06:04.0: PCI bridge, secondary bus 0002:09
pci 0002:06:04.0:   IO window: disabled
pci 0002:06:04.0:   MEM window: disabled
pci 0002:06:04.0:   PREFETCH window: disabled
pci 0002:06:05.0: PCI bridge, secondary bus 0002:0a
pci 0002:06:05.0:   IO window: disabled
pci 0002:06:05.0:   MEM window: 0xc0000000-0xc00fffff
pci 0002:06:05.0:   PREFETCH window: disabled
pci 0002:05:00.0: PCI bridge, secondary bus 0002:06
pci 0002:05:00.0:   IO window: disabled
pci 0002:05:00.0:   MEM window: 0xc0000000-0xc00fffff
pci 0002:05:00.0:   PREFETCH window: disabled
pci 0002:04:00.0: PCI bridge, secondary bus 0002:05
pci 0002:04:00.0:   IO window: 0x00-0xffff
pci 0002:04:00.0:   MEM window: 0xc0000000-0xdfffffff
pci 0002:04:00.0:   PREFETCH window: disabled
pci 0002:04:00.0: enabling device (0106 -> 0107)
pci 0002:05:00.0: enabling device (0000 -> 0002)
pci 0002:06:05.0: enabling device (0000 -> 0002)

/sys/bus/pci/devices # ls
0002:0a:00.0  0002:06:04.0  0002:06:02.0  0002:04:00.0  0000:00:00.0
0002:06:05.0  0002:06:03.0  0002:05:00.0  0001:02:00.0

I know that the problem could be in the u-boot, so I am trying to
analyse its code also... but I think there could be something in Linux
I am not taking into account yet.

Thanks.

Miguel Ángel
