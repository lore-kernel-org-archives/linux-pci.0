Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:39548 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107Ab3KARLm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Nov 2013 13:11:42 -0400
Date: Fri, 1 Nov 2013 10:56:09 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: mvebu - Support a bridge with no IO port window
Message-ID: <20131101165609.GA25978@obsidianresearch.com>
References: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131031101357.5a56e2d0@skate>
 <20131031164810.GA26426@obsidianresearch.com>
 <CAErSpo7bUP63J5RkXr-DkQE8qmvKT7ri-vjkfq+TtGEaYWxSwA@mail.gmail.com>
 <20131031233245.GA9853@obsidianresearch.com>
 <CAErSpo4NDuNJ4mj1n4V8UgsdAJxMrSRy43Qz=3JNvtsrv2rMjA@mail.gmail.com>
 <20131101052848.GA20163@obsidianresearch.com>
 <CAErSpo5Y5TH+iapqzhQAcLY6V0rvK=7QAEStcbzLv4mAuLKPDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5Y5TH+iapqzhQAcLY6V0rvK=7QAEStcbzLv4mAuLKPDg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> I don't know why 0xf0f0.  Anything that's non-zero in the upper four
> bits of each byte should work to determine writability.  It seems like
> it would be safer to write 0x00f0 so the window is disabled, because
> even if we're enumerating the bridge at hot-plug time, nobody else
> should be trying to access a device behind the bridge, and we wouldn't
> inadvertently claim something destined for [io 0xf000-0xffff].

What do you think of this?

>From f1f0d6a5b192a46585c5fefdc7ec06808639be4d Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Fri, 1 Nov 2013 10:54:13 -0600
Subject: [PATCH] PCI: Use a safer method to determine if a bridge has IO
 support

We want to avoid disturbing an active an enabled bus during IO detection,
so first check if IO is enabled - if so then we know for sure that
the bridge has IO.

Otherwise we can safely fiddle with the IO window register to detect IO,
as IO is disabled.

This also changes the probe value to 0x00f0, which is intended to be
clearer to the reader that this is just a probe.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/pci/setup-bus.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bc26d79..d63087f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -665,10 +665,16 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 
 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
 	if (!io) {
-		pci_write_config_word(bridge, PCI_IO_BASE, 0xf0f0);
-		pci_read_config_word(bridge, PCI_IO_BASE, &io);
- 		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
- 	}
+		u16 command;
+		pci_read_config_word(bridge, PCI_COMMAND, &command);
+		if (command & PCI_COMMAND_IO)
+			b_res[0].flags |= IORESOURCE_IO;
+		else {
+			pci_write_config_word(bridge, PCI_IO_BASE, 0x00f0);
+			pci_read_config_word(bridge, PCI_IO_BASE, &io);
+			pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
+		}
+	}
  	if (io)
 		b_res[0].flags |= IORESOURCE_IO;
 	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
-- 
1.8.1.2

