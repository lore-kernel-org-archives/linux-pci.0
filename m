Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:45835 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab2ICAEx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Sep 2012 20:04:53 -0400
Subject: [PATCH 3/5] PCI: hotplug: remove acpi_bus_generate_proc_event
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Bjorn Helgaas <bhelgaas@google.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 03 Sep 2012 02:03:27 +0200
Message-ID: <1346630607.3170.31.camel@offbook>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Calling this function no longer makes sense as /proc/acpi/event
is being removed.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 drivers/pci/hotplug/acpiphp_ibm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index c35e8ad..5394fff 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -270,7 +270,6 @@ static void ibm_handle_events(acpi_handle handle, u32 event, void *context)
 
 	if (subevent == 0x80) {
 		dbg("%s: generationg bus event\n", __func__);
-		acpi_bus_generate_proc_event(note->device, note->event, detail);
 		acpi_bus_generate_netlink_event(note->device->pnp.device_class,
 						  dev_name(&note->device->dev),
 						  note->event, detail);
-- 
1.7.4.1




