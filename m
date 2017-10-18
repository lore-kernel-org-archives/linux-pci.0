Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.192]:64157 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753787AbdJRNXy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2017 09:23:54 -0400
Received: from 1e4oK6-0005MO-U7 by out6a.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1e4oK6-0005Rc-V7
        for linux-pci@vger.kernel.org; Wed, 18 Oct 2017 06:23:50 -0700
Received: from [156.67.243.126] (helo=AcuExch.aculab.com)
        by out6a.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1e4oK6-0005MO-U7
        for linux-pci@vger.kernel.org; Wed, 18 Oct 2017 06:23:50 -0700
From: David Laight <David.Laight@ACULAB.COM>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: lspci reports 'stale' BAR info after a card reset
Date: Wed, 18 Oct 2017 13:23:53 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD009AD46@AcuExch.aculab.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm doing some experiments that generate errors on a PCIe link.
(I'd like to get AER reporting things - but that is a different
problem.)

If I force 'link down' (by shorting the TX lines with a screwdriver!)
the card side resets everything to do with the PCIe links including
all of config space - particularly the BARs.

The kernel doesn't know this has happened, so the bridge is left
configured and the device driver (hopefully) doesn't crash the
kernel when it gets 0xffffffff back from reads!

If I then run 'lspci -vx' I get:
09:00.0 Class 0004: Device 12d9:001e (rev 01) (prog-if 02)
        Subsystem: Device 12d9:0001
        Flags: fast devsel, IRQ 16, NUMA node 0
        [virtual] Memory at fa200000 (32-bit, non-prefetchable) [size=1M]
        [virtual] Memory at fa100000 (32-bit, non-prefetchable) [size=1M]
        [virtual] Memory at fa300000 (32-bit, non-prefetchable) [size=8K]
        ...
00: d9 12 1e 00 00 00 10 00 01 02 04 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 d9 12 01 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 00 01 00 00

Note that the hexdump shows the BARs as all zero, but the text shows the
values that the kernel thinks are being used.
This doesn't make it obvious that something has gone badly wrong.

AFAICT most of the info lspci outputs comes from decoding config space.
I suspect it is getting the BAR info from the kernel (linux 4.14.0-rc4 ish)
in order to print the size.
It would be better if it reported the inconsistency.

	David
