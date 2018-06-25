Return-Path: <SRS0=T9i+=JL=gmail.com=kernelfans@kernel.org>
Return-Path: <SRS0=T9i+=JL=gmail.com=kernelfans@kernel.org>
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv2 0/2] drivers/base: bugfix for supplier<-consumer ordering in device_kset
Date: Mon, 25 Jun 2018 15:47:37 +0800
Message-Id: <1529912859-10475-1-git-send-email-kernelfans@gmail.com>
List-ID: <linux-pci.vger.kernel.org>

commit 52cdbdd49853 ("driver core: correct device's shutdown order")
places an assumption of supplier<-consumer order on the process of probe.
But it turns out to break down the parent <- child order in some scene.
E.g in pci, a bridge is enabled by pci core, and behind it, the devices
have been probed. Then comes the bridge's module, which enables extra
feature(such as hotplug) on this bridge.
This will break the parent<-children order and cause failure when
"kexec -e" in some scenario.

I tried to fix this issue in pci subsystem, and it turns out to be wrong.
Thanks to Christoph Hellwig, he enlightens me that it should be a bug in
driver core.

note: This series has some lock issue, should be fixed in next version

v1 -> v2:
  refragment

Pingfan Liu (2):
  drivers/base: only reordering consumer device when probing
  drivers/base: reorder consumer and its children behind suppliers

 drivers/base/base.h |   1 +
 drivers/base/core.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c   |   9 +---
 3 files changed, 138 insertions(+), 7 deletions(-)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
-- 
2.7.4
