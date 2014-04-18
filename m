Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33304 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751111AbaDRM6v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Apr 2014 08:58:51 -0400
Date: Fri, 18 Apr 2014 14:58:47 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Neil Greatorex <neil@fatboyfat.co.uk>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140418145847.709b29ce@skate>
In-Reply-To: <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
References: <20140410181953.50ccfcc3@skate>
	<20140410165733.GB23104@obsidianresearch.com>
	<20140410200153.46669e0c@skate>
	<20140410201201.GA12661@obsidianresearch.com>
	<alpine.DEB.2.10.1404102206090.28003@vroombuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Neil, Jason,

On Thu, 10 Apr 2014 22:56:00 +0100 (BST), Neil Greatorex wrote:

> I took your attached patch and extended it a bit to print out how long it 
> took. The delays also need to be much longer for me. I also fixed a small 
> typo you made where the bit wasn't being set again to bring the link back 
> up. I've attached the diff to your patch, as well as the combined patch 
> (hope that makes sense).

Unfortunately here your patch doesn't work (and neither does the patch
from Jason Gunthorpe). On Armada 370 DB, without the patch, the e1000e
NIC is detected when earlyprintk is enabled, and not detected when
earlyprintk is disabled. With the patch applied, the e1000e is no
longer detected *at all*, even if earlyprintk is enabled.

Extract from a boot log:

Linux version 3.15.0-rc1-00007-gedf643a-dirty (thomas@skate) (gcc version 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu7) ) #317 SMP Fri Apr 18 14:54:13 CEST 2014
[...]
Kernel command line: console=ttyS0,115200 earlyprintk loglevel=8 root=/dev/nfs nfsroot=192.168.1.22:/home/thomas/nfsroot ip=192.168.1.142:192.168.1.22:192.168.1.1:255.255.255.0:devboard:eth0:on
[...]
mvebu-pcie pcie-controller.2: PCIe0.0: performing link reset
mvebu-pcie pcie-controller.2: PCIe0.0: link went down after 20 tries
mvebu-pcie pcie-controller.2: PCIe0.0: link came back up after 100 tries
mvebu-pcie pcie-controller.2: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
pci_bus 0000:00: root bus resource [mem 0xf8000000-0xffdfffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:01.0: [11ab:6710] type 01 class 0x060400
pci 0000:00:02.0: [11ab:6710] type 01 class 0x060400
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus1: Fast back to back transfers enabled
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
PCI: bus2: Fast back to back transfers enabled
pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:02.0: PCI bridge to [bus 02]
[...]
# /usr/sbin/lspci 
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710
#

Any idea?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
