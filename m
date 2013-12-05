Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:35669 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750711Ab3LEFEx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 00:04:53 -0500
Date: Thu, 5 Dec 2013 10:34:24 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jg1.han@samsung.com>
Cc: Mohit Kumar <mohit.kumar@st.com>, Marek Vasut <marex@denx.de>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	<linux-pci@vger.kernel.org>, Tim Harvey <tharvey@gateworks.com>
Subject: [Query/Discussion]: IO translation with designware PCIe controller
Message-ID: <20131205050424.GA2298@pratyush-vbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd / Jingoo,

Sorry for not able to follow earlier discussion you had on this
topic while initial reviews of patches from Jingoo.

I have few doubts that how will it actually work.

As per my understanding under current implementation:

1. Physical IO addresses are in the range of 0x1000 to 0xfffff.
2. They are mapped to fixed virtual address 0xFEE00000 using
pci_ioremap_io.
3. IO resource addresses to any PCIe device will be allocated in above
range.
4. Driver for that PCIe device will write in the above range only for
IO transaction to the device.
5. As per current IO translation programming, its one to one
translation. It means PCIe translation unit will have both input and
output address in the range of 0x1000 to 0xfffff.

Did I miss something, or if above statements are correct, then what I
do not understand is how can designware PCIe translation unit accept
input address in the range of 0x1000 to 0xfffff?

For example in SPEAr1340, physically RAM is mapped on above addresses.
PCIe address translation unit can accept address only in the range of
core addresses which are assigned to PCIe RC ie 0x80000000-0x8FFFFFFF.

Regards
Pratyush

