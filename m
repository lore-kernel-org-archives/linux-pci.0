Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36250 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbbIOUXh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 16:23:37 -0400
Received: by vkfp126 with SMTP id p126so87665834vkf.3
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2015 13:23:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55F84CAA.8060901@roeck-us.net>
References: <20150904164412.GD22997@red-moon>
	<CAE9FiQVB0swnTao3eS1kOLvwU-hm0aEpOTXP7wDKFGqtLQta5g@mail.gmail.com>
	<20150907091230.GB29293@red-moon>
	<20150914100929.GB18886@red-moon>
	<CAE9FiQV-eG42xzqVcO2Q+xT3jx-Oa7uC7fEuowvopx4Fp9F7hQ@mail.gmail.com>
	<20150914162834.GA11199@red-moon>
	<CAE9FiQWJfbMD1Akq6XD-Yedc+tNNF8o0obPGHt8f_WnWX0pLbA@mail.gmail.com>
	<CAE9FiQU6NTEdKJi58bNZU4u=+-rzB3mddp6vKGc4JjbZWoa9zQ@mail.gmail.com>
	<20150915094610.GD11199@red-moon>
	<CAErSpo5KaV7ERYcyZBzfvCEh40zSPJmymwXUCbAZkK=hb4DPSw@mail.gmail.com>
	<20150915163000.GA16240@red-moon>
	<55F84CAA.8060901@roeck-us.net>
Date: Tue, 15 Sep 2015 13:17:46 -0700
Message-ID: <CAE9FiQXrr2w5=QRpP9kL=xE4djwCz80wTPn1SA93Wg_u=6Tp3Q@mail.gmail.com>
Subject: Re: trouble with PCI: Call pci_read_bridge_bases() from core instead
 of arch code
From: Yinghai Lu <yinghai@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"oe5hpm@gmail.com" <oe5hpm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 15, 2015 at 9:51 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 09/15/2015 09:30 AM, Lorenzo Pieralisi wrote:
>
> It looks like me and Yinghai disagree how the problem I was trying to fix
> should be handled, I don't understand Yinghai's concerns, and unfortunately
> I just don't have the time I would need to get a better understanding.
> It is fine with me to revert your patch and abandon mine.

I put one simplified version in one my branch.

https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/patch/?id=cdf4bfbc1ce12d826abd49a8987eb3ca7e129332

and will sent that later if needed.

>From cdf4bfbc1ce12d826abd49a8987eb3ca7e129332 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 15 Sep 2015 12:59:11 -0700
Subject: PCI: Only try to assign io port only for root bus that support it

The PCI subsystem always assumes that I/O is supported on root bus and
tries to assign an I/O window to each child bus even if that is not the
case.

This may result in messages such as:

  pcieport 0000:02:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size
add_size 1000
  pcieport 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
  pcieport 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]

for each bridge port, even if root does not support I/O in the first place.

To avoid this message, check if root bus supports I/O, then child bus
will inherit the setting from parent bus, and later during sizing and
assigning, check that bus flags and skip those resources.

[bhelgaas: reverse sense of new pci_bus_flags_t value]
[yinghai: only check root bus io port, and use flag on sizing and assigning]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c4c6947..5d946bd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -339,6 +339,9 @@ static void pci_read_bridge_io(struct pci_bus *child)
  struct pci_bus_region region;
  struct resource *res;

+ if (!(child->bus_flags & PCI_BUS_FLAGS_ROOT_SUPPORTS_IO))
+ return;
+
  io_mask = PCI_IO_RANGE_MASK;
  io_granularity = 0x1000;
  if (dev->io_window_1k) {
@@ -2126,6 +2129,8 @@ struct pci_bus *pci_create_root_bus(struct
device *parent, int bus,
  } else
  bus_addr[0] = '\0';
  dev_info(&b->dev, "root bus resource %pR%s\n", res, bus_addr);
+ if (resource_type(res) == IORESOURCE_IO)
+ b->bus_flags |= PCI_BUS_FLAGS_ROOT_SUPPORTS_IO;
  }

  resource_list_for_each_entry(window, &bridge->windows) {
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9d5e415..8ee5d17 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -223,6 +223,10 @@ static void pdev_assign_resources_prepare(struct
pci_dev *dev,
  if (r->flags & IORESOURCE_PCI_FIXED)
  continue;

+ if ((r->flags & IORESOURCE_IO) &&
+    !(dev->bus->bus_flags & PCI_BUS_FLAGS_ROOT_SUPPORTS_IO))
+ continue;
+
  if (resource_disabled(r) || r->parent)
  continue;

@@ -1178,6 +1182,11 @@ static void pbus_size_io(struct pci_bus *bus,
resource_size_t min_size,
  min_size = 0;
  }

+ if (!(bus->bus_flags & PCI_BUS_FLAGS_ROOT_SUPPORTS_IO)) {
+ b_res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
+ return;
+ }
+
  min_align = window_alignment(bus, IORESOURCE_IO);
  list_for_each_entry(dev, &bus->devices, bus_list) {
  int i;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5ed9bf1..790c534 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -193,6 +193,7 @@ typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
  PCI_BUS_FLAGS_NO_MSI   = (__force pci_bus_flags_t) 1,
  PCI_BUS_FLAGS_NO_MMRBC = (__force pci_bus_flags_t) 2,
+ PCI_BUS_FLAGS_ROOT_SUPPORTS_IO = (__force pci_bus_flags_t) 4,
 };

 /* These values come from the PCI Express Spec */
-- 
cgit v0.10.2
