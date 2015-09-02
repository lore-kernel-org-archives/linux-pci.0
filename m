Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36542 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbbIBJvT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2015 05:51:19 -0400
Received: by pacik9 with SMTP id ik9so568095pac.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2015 02:51:18 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 2 Sep 2015 11:51:18 +0200
Message-ID: <CAAa04yFQEUJm7Jj1qMT57-LG7ZGtnhNDBe=PpSRa70Mj+XhW-A@mail.gmail.com>
Subject: trouble with PCI: Call pci_read_bridge_bases() from core instead of
 arch code
From: oe5hpm <oe5hpm@gmail.com>
To: "CC: Ralf Baechle" <ralf@linux-mips.org>,
	"CC: James E.J. Bottomley" <jejb@parisc-linux.org>,
	"CC: Michael Ellerman" <mpe@ellerman.id.au>,
	"CC: Bjorn Helgaas" <bhelgaas@google.com>,
	"CC: Richard Henderson" <rth@twiddle.net>,
	"CC: Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"CC: David Howells" <dhowells@redhat.com>,
	"CC: Russell King" <linux@arm.linux.org.uk>,
	"CC: Tony Luck" <tony.luck@intel.com>,
	"CC: David S. Miller" <davem@davemloft.net>,
	"CC: Ingo Molnar" <mingo@redhat.com>,
	"CC: Guenter Roeck" <linux@roeck-us.net>,
	"CC: Michal Simek" <monstr@monstr.eu>,
	"CC: Chris Zankel" <chris@zankel.net>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

today i tried to boot up the most recent vanilla kernel on my
Freescale i.mx6 board.
I ran into trouble regarding PCI enumeration.

[    0.431949] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.431976] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
[    0.431996] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.432022] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.433271] PCI: bus0: Fast back to back transfers disabled
[    0.433629] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    0.435181] PCI: bus1: Fast back to back transfers disabled
[    0.435564] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.435593] pci 0000:00:00.0: BAR 8: no space for [mem size 0x01000000]
[    0.435613] pci 0000:00:00.0: BAR 8: failed to assign [mem size 0x01000000]
[    0.435635] pci 0000:00:00.0: BAR 9: assigned [mem
0x01100000-0x011fffff pref]
[    0.435655] pci 0000:00:00.0: BAR 6: assigned [mem
0x01200000-0x0120ffff pref]
[    0.435676] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.435705] pci 0000:01:00.0: BAR 2: no space for [mem size 0x00200000]
[    0.435722] pci 0000:01:00.0: BAR 2: failed to assign [mem size 0x00200000]
[    0.435739] pci 0000:01:00.0: BAR 1: no space for [mem size 0x00004000]
[    0.435754] pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x00004000]
[    0.435770] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00000100]
[    0.435786] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00000100]
[    0.435804] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.435826] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    0.435855] pci 0000:00:00.0:   bridge window [mem
0x01100000-0x011fffff pref]

there are several fails assigning memory ressources to pci-devices.

i bisect down this trouble to commit id:
dff22d2054b5dbb1889f20c03959dd0c494fab8c : PCI: Call
pci_read_bridge_bases() from core instead of arch code

For testing purpose i've reverted this commit on a local branch and
everythings works fine, as before.

[    0.431976] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.432004] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
[    0.432023] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.432047] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.433302] PCI: bus0: Fast back to back transfers disabled
[    0.435122] PCI: bus1: Fast back to back transfers disabled
[    0.435504] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.435535] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x013fffff]
[    0.435557] pci 0000:00:00.0: BAR 6: assigned [mem
0x01400000-0x0140ffff pref]
[    0.435585] pci 0000:01:00.0: BAR 2: assigned [mem 0x01200000-0x013fffff]
[    0.435626] pci 0000:01:00.0: BAR 1: assigned [mem 0x01100000-0x01103fff]
[    0.435665] pci 0000:01:00.0: BAR 0: assigned [mem 0x01104000-0x011040ff]
[    0.435703] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.435728] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x013fffff]

Further i can break down the failure to "drivers/pci/probe.c" line #924.
If i comment out the "pci_read_bridge_bases(child);" also everything works well.

I have to confess, that my knowledge about the whole PCI thing in the
kernel is not very deep, so it is not possible for me to figure out
what is going wrong.

maybe some of you can help?

best regards,
Hannes
