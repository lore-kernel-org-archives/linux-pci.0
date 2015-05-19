Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0132.outbound.protection.outlook.com ([157.56.111.132]:60917
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750911AbbESASj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 May 2015 20:18:39 -0400
Date: Mon, 18 May 2015 17:18:29 -0700
From: Guenter Roeck <groeck@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: BAR 7 io space assignment errors
Message-ID: <20150519001829.GA14895@svl-evodev-groeck.juniper.net>
References: <20150515172836.GA27797@svl-evodev-groeck.juniper.net>
 <CAErSpo5R0WF7J1OCagXNB2PcFUnNDB3LD6Q8A3pi=YYswzsaLw@mail.gmail.com>
 <20150515200422.GA29321@svl-evodev-groeck.juniper.net>
 <20150515221149.GA31666@google.com>
 <20150516022713.GA4417@svl-evodev-groeck.juniper.net>
 <20150516131209.GD31666@google.com>
 <20150516164151.GA2042@svl-evodev-groeck.juniper.net>
 <20150518155546.GM31666@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150518155546.GM31666@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 18, 2015 at 10:55:46AM -0500, Bjorn Helgaas wrote:
> On Sat, May 16, 2015 at 09:41:51AM -0700, Guenter Roeck wrote:
> > Hi Bjorn,
> > 
> > On Sat, May 16, 2015 at 08:12:09AM -0500, Bjorn Helgaas wrote:
> > > > The problem is that I can not reprogram PCI_IO_BASE on 0000:00:00.0.
> > > > Here is a debug log:
> > > > 
> > > > pci 0000:00:00.0: io base written 0xe0f0 reads back as 0x0
> > > > pci 0000:00:00.0: io base written 0xf000 reads back as 0x0
> > > 
> > > That's odd; that's a non-conformant bridge.  Per spec (PCI-to-PCI Bridge
> > > r1.2, sec 3.2.5.6), for a bridge that implements an I/O address range, the
> > > upper four bits of I/O Base is writable.
> > > 
> > > But I suspect this bridge is discovered via OF and there's something broken
> > > about how config access is done.  That's arch code and I don't know much
> > > about it.
> > > 
> > Maybe. I'll dig into it some more.
> > 
> > > Or maybe the hardware itself is not quite spec-compliant, although it would
> > > be strange to have I/O aperture addresses hard-wired into the hardware.  
> > > 
> > This is a Freesale P2020. We should have the specification somewhere.
> > Guess it may be time for some digging in there.
> 
> Hmm, I spoke too fast above.  I assumed that we checked whether the
> bridge actually implements an I/O aperture, but pci_read_bridge_io()
> doesn't do that.  On a bridge that doesn't implement an I/O range, both I/O
> Base and I/O Limit must be read-only zeroes.  But pci_read_bridge_io()
> doesn't test whether they are writable, so it treats that situation as an
> enabled [io 0x0000-0x0fff] window.
> 
> pci_bridge_check_ranges() *does* check for writability, but it might be
> too late to make a difference in this case.  I would like to get rid of 
> pci_bridge_check_ranges() anyway; it seems like whatever it does should be
> folded into pci_read_bridge_io() and pci_read_bridge_mmio_pref().
> 
> Bottom line, 
> 
> 1) I don't know whether your bridge actually implements an I/O aperture,

I don't think it does.

> and 2) I think pci_read_bridge_io() should check for writability.
> 

Something like the patch below ? It seems to address my problem. At the
same time it tries to be minimalistic, ie if a bridge is already configured
for an IO window it will still try to assign it (and the message will still
be seen), even if its parent does not support it (or has it disabled).

I don't know if there is a better way to check if a port supports IO.
If there is, please let me know.

Thanks,
Guenter

---
>From 4d9c3f95290d13c0bbd3a0a6c8043ccb2b53d06f Mon Sep 17 00:00:00 2001
From: Guenter Roeck <groeck@juniper.net>
Date: Mon, 18 May 2015 13:27:27 -0700
Subject: [PATCH] pci: Only enable IO window if supported

The PCI subsystem always assumes that I/O is suported and tries
to assign an I/O window to a bus even if that is not the case.

This may result in messages such as

pcieport 0000:02:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pcieport 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
pcieport 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]

for each port, even if one of its parent ports does not support I/O
in the first place.

To avoid this message, check if a port supports I/O before enabling I/O
on it. Also check if port's parent supports I/O, and only modify its I/O
resource size if it does.

Signed-off-by: Guenter Roeck <groeck@juniper.net>
---
 drivers/pci/probe.c     |   14 ++++++++++++++
 drivers/pci/setup-bus.c |    2 +-
 include/linux/pci.h     |    9 +++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index afae480..1eb9fc6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -354,6 +354,20 @@ static void pci_read_bridge_io(struct pci_bus *child)
 	base = (io_base_lo & io_mask) << 8;
 	limit = (io_limit_lo & io_mask) << 8;
 
+	/* If necessary, check if the bridge supports an I/O aperture */
+	if (!io_base_lo && !io_limit_lo) {
+		u16 io;
+
+		if (!pci_parent_supports_io(child))
+			return;
+
+		pci_write_config_word(dev, PCI_IO_BASE, 0xe0f0);
+		pci_read_config_word(dev, PCI_IO_BASE, &io);
+		pci_write_config_word(dev, PCI_IO_BASE, 0x0);
+		if (!io)
+			return;
+	}
+
 	if ((io_base_lo & PCI_IO_RANGE_TYPE_MASK) == PCI_IO_RANGE_TYPE_32) {
 		u16 io_base_hi, io_limit_hi;
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e3e17f3..4fde12a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -695,7 +695,7 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	b_res[1].flags |= IORESOURCE_MEM;
 
 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
-	if (!io) {
+	if (!io && pci_parent_supports_io(bus)) {
 		pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
 		pci_read_config_word(bridge, PCI_IO_BASE, &io);
 		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2d39586..174600f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -489,6 +489,15 @@ static inline bool pci_is_root_bus(struct pci_bus *pbus)
 	return !(pbus->parent);
 }
 
+/*
+ * Returns true if the parent bus supports an I/O aperture.
+ */
+static inline bool pci_parent_supports_io(struct pci_bus *pbus)
+{
+	return pci_is_root_bus(pbus) || pci_is_root_bus(pbus->parent) ||
+	       (pbus->parent->resource[0]->flags & IORESOURCE_IO);
+}
+
 /**
  * pci_is_bridge - check if the PCI device is a bridge
  * @dev: PCI device
-- 
1.7.9.5

