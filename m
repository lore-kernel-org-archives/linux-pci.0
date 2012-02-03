Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49024 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab2BCQzw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2012 11:55:52 -0500
Date: Fri, 3 Feb 2012 16:55:43 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v1 07/18] arm/PCI: get rid of device resource fixups
Message-ID: <20120203165543.GP889@n2100.arm.linux.org.uk>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com> <20120130165745.3231.37109.stgit@bhelgaas.mtv.corp.google.com> <20120203160146.GM889@n2100.arm.linux.org.uk> <CAErSpo6Ytx06f0yMW5q=YQBTcLxRdbBbB6EzSAFWNG82t=Qe4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6Ytx06f0yMW5q=YQBTcLxRdbBbB6EzSAFWNG82t=Qe4g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 03, 2012 at 08:12:02AM -0800, Bjorn Helgaas wrote:
> On Fri, Feb 3, 2012 at 8:01 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Jan 30, 2012 at 09:57:45AM -0700, Bjorn Helgaas wrote:
> >> Tell the PCI core about host bridge address translation so it can take
> >> care of bus-to-resource conversion for us.
> >
> > Are the rest of these patches (in particular whereever is introduced
> > the generic versions) available somewhere?
> 
> Oh, sorry, this doesn't mean much without the context.  Here's a
> pointer to the overview, with a git tree and so on:
> 
> http://marc.info/?l=linux-arch&m=132794281821723&w=2

Trying to read github in elinks isn't very nice.  But from what I could
see it looks fine.  When I get around to pulling my private patchsets
forward, I'll try to remember to give this a test.

The thing which was concerning me is that I have been carrying the
following patches for the last 10 years or more in various forms to
make PCMCIA work on a couple of platforms I have here.  It's more
or less the same problem, and it uses the bus_to_resource stuff to
fix it for Yenta.

These patches address PCMCIA's idea of 'lowmem' windows always being
at the low 640K of _CPU_ memory rather than the low 640K of _bus_
memory.  When your bus starts at an offset of more than 640K in CPU
memory, the resource handling doesn't work as well.

I've never pushed these upstream because I'm not entirely sure why
PCMCIA deals with lowmem windows on a card-by-card basis, rather than
a socket basis (surely its more to do with the capabilities of the
socket interface than the card itself...)

=== Patch 1 - generic bits ===

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 9da9656..8825c49 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -53,10 +53,17 @@ struct resource_map {
 	struct resource_map	*next;
 };
 
+struct resource_limit {
+	resource_size_t		start;
+	resource_size_t		end;
+};
+
 struct socket_data {
 	struct resource_map		mem_db;
 	struct resource_map		mem_db_valid;
 	struct resource_map		io_db;
+	struct resource_limit		low;
+	struct resource_limit		high;
 };
 
 #define MEM_PROBE_LOW	(1 << 0)
@@ -464,11 +471,11 @@ static u_long inv_probe(struct resource_map *m, struct pcmcia_socket *s)
 		return 0;
 	ok = inv_probe(m->next, s);
 	if (ok) {
-		if (m->base >= 0x100000)
+		if (m->base < s_data->low.start || m->base > s_data->low.end)
 			sub_interval(&s_data->mem_db, m->base, m->num);
 		return ok;
 	}
-	if (m->base < 0x100000)
+	if (m->base > s_data->low.start && m->base <= s_data->low.end)
 		return 0;
 	return do_mem_probe(s, m->base, m->num, readable, checksum);
 }
@@ -502,8 +509,8 @@ static int validate_mem(struct pcmcia_socket *s, unsigned int probe_mask)
 
 	for (m = s_data->mem_db.next; m != &s_data->mem_db; m = mm.next) {
 		mm = *m;
-		/* Only probe < 1 MB */
-		if (mm.base >= 0x100000)
+		/* Only probe low memory mappings */
+		if (mm.base < s_data->low.start || mm.base > s_data->low.end)
 			continue;
 		if ((mm.base | mm.num) & 0xffff) {
 			ok += do_mem_probe(s, mm.base, mm.num, readable,
@@ -512,7 +519,7 @@ static int validate_mem(struct pcmcia_socket *s, unsigned int probe_mask)
 		}
 		/* Special probe for 64K-aligned block */
 		for (i = 0; i < 4; i++) {
-			b = order[i] << 12;
+			b = s_data->low.start + (order[i] << 12);
 			if ((b >= mm.base) && (b+0x10000 <= mm.base+mm.num)) {
 				if (ok >= mem_limit)
 					sub_interval(&s_data->mem_db, b, 0x10000);
@@ -820,14 +827,13 @@ static struct resource *nonstatic_find_mem_region(u_long base, u_long num,
 	data.offset = base & data.mask;
 
 	for (i = 0; i < 2; i++) {
+		struct resource_limit *lim = low ? &s_data->low : &s_data->high;
+		max = lim->end;
+		min = lim->start + base;
+		if (min > max)
+			min = lim->start;
+
 		data.map = &s_data->mem_db_valid;
-		if (low) {
-			max = 0x100000UL;
-			min = base < max ? base : 0;
-		} else {
-			max = ~0UL;
-			min = 0x100000UL + base;
-		}
 
 		for (j = 0; j < 2; j++) {
 #ifdef CONFIG_PCI
@@ -1028,13 +1034,38 @@ static int nonstatic_init(struct pcmcia_socket *s)
 	data->mem_db_valid.next = &data->mem_db_valid;
 	data->io_db.next = &data->io_db;
 
+	/*
+	 * Setup the default resource limits
+	 */
+	data->low.start = 0;
+	data->low.end = 0xfffffUL;
+	data->high.start = 0x100000UL;
+	data->high.end = ~0UL;
+
 	s->resource_data = (void *) data;
 
+	if (s->ops->set_resource_limits)
+		s->ops->set_resource_limits(s);
+
 	nonstatic_autoadd_resources(s);
 
 	return 0;
 }
 
+void pccard_nonstatic_set_resource_limit(struct pcmcia_socket *s, int low,
+	resource_size_t start, resource_size_t end)
+{
+	struct socket_data *data = s->resource_data;
+	struct resource_limit *lim = low ? &data->low : &data->high;
+	lim->start = start;
+	lim->end = end;
+	dev_printk(KERN_INFO, &s->dev,
+		   "setting %s memory limit to 0x%08llx-0x%08llx\n",
+		   low ? "low" : "extended",
+		   (unsigned long long)start, (unsigned long long)end);
+}
+EXPORT_SYMBOL_GPL(pccard_nonstatic_set_resource_limit);
+
 static void nonstatic_release_resource_db(struct pcmcia_socket *s)
 {
 	struct socket_data *data = s->resource_data;
diff --git a/include/pcmcia/ss.h b/include/pcmcia/ss.h
index 731cde0..d358b16 100644
--- a/include/pcmcia/ss.h
+++ b/include/pcmcia/ss.h
@@ -128,6 +128,7 @@ struct pccard_operations {
 	int (*set_socket)(struct pcmcia_socket *s, socket_state_t *state);
 	int (*set_io_map)(struct pcmcia_socket *s, struct pccard_io_map *io);
 	int (*set_mem_map)(struct pcmcia_socket *s, struct pccard_mem_map *mem);
+	void (*set_resource_limits)(struct pcmcia_socket *s);
 };
 
 struct pcmcia_socket {
@@ -253,6 +254,8 @@ extern struct pccard_resource_ops pccard_nonstatic_ops;
 #define pccard_nonstatic_ops pccard_static_ops
 #endif
 
+void pccard_nonstatic_set_resource_limit(struct pcmcia_socket *s, int low,
+	resource_size_t start, resource_size_t end);
 
 /* socket drivers use this callback in their IRQ handler */
 extern void pcmcia_parse_events(struct pcmcia_socket *socket,

=== Patch 2 - yenta specific bits ===

diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 9dc565c..8ed7b11 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -203,6 +203,21 @@ static ssize_t show_yenta_registers(struct device *yentadev, struct device_attri
 
 static DEVICE_ATTR(yenta_registers, S_IRUSR, show_yenta_registers, NULL);
 
+static void yenta_set_resource_limit(struct yenta_socket *s, int low,
+	resource_size_t start, resource_size_t end)
+{
+	struct pci_bus_region region;
+	struct resource res = {
+		.start = start,
+		.end = end,
+		.flags = IORESOURCE_MEM,
+	};
+
+	pcibios_resource_to_bus(s->dev, &region, &res);
+	pccard_nonstatic_set_resource_limit(&s->socket, low, region.start,
+					region.end);
+}
+
 /*
  * Ugh, mixed-mode cardbus and 16-bit pccard state: things depend
  * on what kind of card is inserted..
@@ -811,6 +826,14 @@ static void __devexit yenta_close(struct pci_dev *dev)
 	pci_set_drvdata(dev, NULL);
 }
 
+static void yenta_set_resource_limits(struct pcmcia_socket *s)
+{
+	struct yenta_socket *socket = container_of(s, struct yenta_socket, socket);
+
+	yenta_set_resource_limit(socket, 1, 0UL, 0xfffffUL);
+	yenta_set_resource_limit(socket, 0, 0x100000UL, ~0UL);
+}
+
 
 static struct pccard_operations yenta_socket_operations = {
 	.init			= yenta_sock_init,
@@ -819,6 +842,7 @@ static struct pccard_operations yenta_socket_operations = {
 	.set_socket		= yenta_set_socket,
 	.set_io_map		= yenta_set_io_map,
 	.set_mem_map		= yenta_set_mem_map,
+	.set_resource_limits	= yenta_set_resource_limits,
 };
 
 
=== Patch 3 - really fun i82365 bits, not PCI related but illustrates
  the same problem on a system without PCI but with an ISA PCMCIA
  controller offset in the system.  It also has some IRQ weirdness... ===

9d4189629d05c4091eb9b28504d83e3a6114d41d
diff --git a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
index 72a033a..05c0ce4 100644
--- a/drivers/pcmcia/i82365.c
+++ b/drivers/pcmcia/i82365.c
@@ -60,6 +60,17 @@
 #include "vg468.h"
 #include "ricoh.h"
 
+#ifdef CONFIG_ARCH_EBSA110
+#include <mach/hardware.h>
+#define I365_MASK		(1 << 6)
+#define SOCKIRQ2REG(sock,irq)	((irq) ? ((sock) ? 3 : 4) : 0)
+#define RES_TO_I365(r)		((r) - ISAMEM_PHYS)
+#define BUS_TO_RESOURCE(x)	((x) + ISAMEM_PHYS)
+#else
+#define SOCKIRQ2REG(sock,irq)	(irq)
+#define RES_TO_I365(r)		(r)
+#define BUS_TO_RESOURCE(x)	(x)
+#endif
 
 static irqreturn_t i365_count_irq(int, void *);
 static inline int _check_irq(int irq, int flags)
@@ -162,7 +173,9 @@ static struct i82365_socket socket[8] = {
 };
 
 /* Default ISA interrupt mask */
+#ifndef I365_MASK
 #define I365_MASK	0xdeb8	/* irq 15,14,12,11,10,9,7,5,4,3 */
+#endif
 
 static int grab_irq;
 static DEFINE_SPINLOCK(isa_lock);
@@ -502,7 +515,7 @@ static u_int __init test_irq(u_short sock, int irq)
     }
 
     /* Generate one interrupt */
-    i365_set(sock, I365_CSCINT, I365_CSC_DETECT | (irq << 4));
+    i365_set(sock, I365_CSCINT, I365_CSC_DETECT | (SOCKIRQ2REG(sock, irq) << 4));
     i365_bset(sock, I365_GENCTL, I365_CTL_SW_IRQ);
     udelay(1000);
 
@@ -934,7 +947,7 @@ static int i365_set_socket(u_short sock, socket_state_t *state)
     
     /* IO card, RESET flag, IO interrupt */
     reg = t->intr;
-    reg |= state->io_irq;
+    reg |= SOCKIRQ2REG(sock, state->io_irq);
     reg |= (state->flags & SS_RESET) ? 0 : I365_PC_RESET;
     reg |= (state->flags & SS_IOCARD) ? I365_PC_IOCARD : 0;
     i365_set(sock, I365_INTCTL, reg);
@@ -1013,7 +1026,7 @@ static int i365_set_socket(u_short sock, socket_state_t *state)
     }
     
     /* Card status change interrupt mask */
-    reg = t->cs_irq << 4;
+    reg = SOCKIRQ2REG(sock, t->cs_irq) << 4;
     if (state->csc_mask & SS_DETECT) reg |= I365_CSC_DETECT;
     if (state->flags & SS_IOCARD) {
 	if (state->csc_mask & SS_STSCHG) reg |= I365_CSC_STSCHG;
@@ -1061,19 +1074,23 @@ static int i365_set_io_map(u_short sock, struct pccard_io_map *io)
 
 static int i365_set_mem_map(u_short sock, struct pccard_mem_map *mem)
 {
+    resource_size_t start, end;
     u_short base, i;
     u_char map;
-    
+
+    start = RES_TO_I365(mem->res->start);
+    end = RES_TO_I365(mem->res->end);
+
     pr_debug("SetMemMap(%d, %d, %#2.2x, %d ns, %#llx-%#llx, "
 	  "%#x)\n", sock, mem->map, mem->flags, mem->speed,
-	  (unsigned long long)mem->res->start,
-	  (unsigned long long)mem->res->end, mem->card_start);
+	  (unsigned long long)start,
+	  (unsigned long long)end, mem->card_start);
 
     map = mem->map;
     if ((map > 4) || (mem->card_start > 0x3ffffff) ||
-	(mem->res->start > mem->res->end) || (mem->speed > 1000))
+	(start > end) || (mem->speed > 1000))
 	return -EINVAL;
-    if ((mem->res->start > 0xffffff) || (mem->res->end > 0xffffff))
+    if ((start > 0xffffff) || (end > 0xffffff))
 	return -EINVAL;
 	
     /* Turn off the window before changing anything */
@@ -1081,12 +1098,12 @@ static int i365_set_mem_map(u_short sock, struct pccard_mem_map *mem)
 	i365_bclr(sock, I365_ADDRWIN, I365_ENA_MEM(map));
     
     base = I365_MEM(map);
-    i = (mem->res->start >> 12) & 0x0fff;
+    i = (start >> 12) & 0x0fff;
     if (mem->flags & MAP_16BIT) i |= I365_MEM_16BIT;
     if (mem->flags & MAP_0WS) i |= I365_MEM_0WS;
     i365_set_pair(sock, base+I365_W_START, i);
     
-    i = (mem->res->end >> 12) & 0x0fff;
+    i = (end >> 12) & 0x0fff;
     switch (to_cycles(mem->speed)) {
     case 0:	break;
     case 1:	i |= I365_MEM_WS0; break;
@@ -1095,7 +1112,7 @@ static int i365_set_mem_map(u_short sock, struct pccard_mem_map *mem)
     }
     i365_set_pair(sock, base+I365_W_STOP, i);
     
-    i = ((mem->card_start - mem->res->start) >> 12) & 0x3fff;
+    i = ((mem->card_start - start) >> 12) & 0x3fff;
     if (mem->flags & MAP_WRPROT) i |= I365_MEM_WRPROT;
     if (mem->flags & MAP_ATTRIB) i |= I365_MEM_REG;
     i365_set_pair(sock, base+I365_W_OFF, i);
@@ -1220,6 +1237,14 @@ static int pcic_init(struct pcmcia_socket *s)
 	return 0;
 }
 
+static void pcic_set_resource_limits(struct pcmcia_socket *s)
+{
+	pccard_nonstatic_set_resource_limit(s, 1,
+			BUS_TO_RESOURCE(0), BUS_TO_RESOURCE(0xfffffUL));
+	pccard_nonstatic_set_resource_limit(s, 0,
+			BUS_TO_RESOURCE(0x100000UL), ~0UL);
+}
+
 
 static struct pccard_operations pcic_operations = {
 	.init			= pcic_init,
@@ -1227,6 +1252,7 @@ static struct pccard_operations pcic_operations = {
 	.set_socket		= pcic_set_socket,
 	.set_io_map		= pcic_set_io_map,
 	.set_mem_map		= pcic_set_mem_map,
+	.set_resource_limits	= pcic_set_resource_limits,
 };
 
 /*====================================================================*/

