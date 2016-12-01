Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933994AbcLAMdB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 07:33:01 -0500
Subject: [PATCH 25/39] Annotate hardware config module parameters in
 drivers/pci/hotplug/
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Scott Murray <scott@spiteful.org>, minyard@acm.org,
        gnomes@lxorguk.ukuu.org.uk, linux-pci@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org,
        keyrings@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 01 Dec 2016 12:32:58 +0000
Message-ID: <148059557836.31612.5039521915534964791.stgit@warthog.procyon.org.uk>
In-Reply-To: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
References: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When the kernel is running in secure boot mode, we lock down the kernel to
prevent userspace from modifying the running kernel image.  Whilst this
includes prohibiting access to things like /dev/mem, it must also prevent
access by means of configuring driver modules in such a way as to cause a
device to access or modify the kernel image.

To this end, annotate module_param* statements that refer to hardware
configuration and indicate for future reference what type of parameter they
specify.  The parameter parser in the core sees this information and can
skip such parameters with an error message if the kernel is locked down.
The module initialisation then runs as normal, but just sees whatever the
default values for those parameters is.

Note that we do still need to do the module initialisation because some
drivers have viable defaults set in case parameters aren't specified and
some drivers support automatic configuration (e.g. PNP or PCI) in addition
to manually coded parameters.

This patch annotates drivers in drivers/pci/hotplug/.

Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Scott Murray <scott@spiteful.org>
cc: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org
---

 drivers/pci/hotplug/cpcihp_generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/cpcihp_generic.c b/drivers/pci/hotplug/cpcihp_generic.c
index 88a44a707b96..bbf9cf8aeaad 100644
--- a/drivers/pci/hotplug/cpcihp_generic.c
+++ b/drivers/pci/hotplug/cpcihp_generic.c
@@ -220,7 +220,7 @@ module_param(first_slot, byte, 0);
 MODULE_PARM_DESC(first_slot, "Hotswap bus first slot number");
 module_param(last_slot, byte, 0);
 MODULE_PARM_DESC(last_slot, "Hotswap bus last slot number");
-module_param(port, ushort, 0);
+module_param_hw(port, ushort, ioport, 0);
 MODULE_PARM_DESC(port, "#ENUM signal I/O port");
 module_param(enum_bit, uint, 0);
 MODULE_PARM_DESC(enum_bit, "#ENUM signal bit (0-7)");

