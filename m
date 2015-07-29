Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33525 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbG2UYL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 16:24:11 -0400
Received: by igbpg9 with SMTP id pg9so174626854igb.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2015 13:24:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55B93151.8040608@roeck-us.net>
References: <1436292680-25111-1-git-send-email-linux@roeck-us.net>
	<20150729160903.GD31170@google.com>
	<CAE9FiQWr3-dw0FhgZjSq=pT-Cn3DaDV3E4QFjURJbQo_igQGNw@mail.gmail.com>
	<55B92DA5.4030409@roeck-us.net>
	<CAE9FiQXC5P3qZC7CS0UBq4=Uz9mcvgguP0EgV7G0x-PnRZn9-w@mail.gmail.com>
	<55B93151.8040608@roeck-us.net>
Date: Wed, 29 Jul 2015 13:24:10 -0700
Message-ID: <CAE9FiQW3yGhuzABYDf89tAA93Y6Gc1GAbGwitVtG1YDf3gPUkg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] PCI: Only enable IO window if supported
From: Yinghai Lu <yinghai@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: multipart/mixed; boundary=047d7b10c8718f8eba051c095e15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--047d7b10c8718f8eba051c095e15
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 29, 2015 at 1:02 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> Do you have an idea on how to make it work with
> the reversed definition ?

attached one should address the problem.

index ddda0916..e8def25 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -378,16 +378,16 @@ static void pci_read_bridge_io(struct pci_bus *child)

     if (!pci_bridge_supports_io(dev)) {
         dev_printk(KERN_DEBUG, &dev->dev, "  no I/O window\n");
+        child->bus_flags &= ~PCI_BUS_FLAGS_SUPPORTS_IO;
         return;
     }

     if (!pci_root_has_io_resource(child)) {
         dev_printk(KERN_DEBUG, &dev->dev, "  no I/O resource on root bus\n");
+        child->bus_flags &= ~PCI_BUS_FLAGS_SUPPORTS_IO;
         return;
     }

-    child->bus_flags |= PCI_BUS_FLAGS_SUPPORTS_IO;
-
     io_mask = PCI_IO_RANGE_MASK;
     io_granularity = 0x1000;
     if (dev->io_window_1k) {
@@ -544,6 +544,7 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
     INIT_LIST_HEAD(&b->resources);
     b->max_bus_speed = PCI_SPEED_UNKNOWN;
     b->cur_bus_speed = PCI_SPEED_UNKNOWN;
+    b->bus_flags |= PCI_BUS_FLAGS_SUPPORTS_IO;
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
     if (parent)
         b->domain_nr = parent->domain_nr;

--047d7b10c8718f8eba051c095e15
Content-Type: text/x-patch; charset=US-ASCII; name="supports_io.patch"
Content-Disposition: attachment; filename="supports_io.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_icp7yr020

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Byb2JlLmMgYi9kcml2ZXJzL3BjaS9wcm9iZS5jCmlu
ZGV4IGRkZGEwOTE2Li5lOGRlZjI1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9wcm9iZS5jCisr
KyBiL2RyaXZlcnMvcGNpL3Byb2JlLmMKQEAgLTM3OCwxNiArMzc4LDE2IEBAIHN0YXRpYyB2b2lk
IHBjaV9yZWFkX2JyaWRnZV9pbyhzdHJ1Y3QgcGNpX2J1cyAqY2hpbGQpCiAKIAlpZiAoIXBjaV9i
cmlkZ2Vfc3VwcG9ydHNfaW8oZGV2KSkgewogCQlkZXZfcHJpbnRrKEtFUk5fREVCVUcsICZkZXYt
PmRldiwgIiAgbm8gSS9PIHdpbmRvd1xuIik7CisJCWNoaWxkLT5idXNfZmxhZ3MgJj0gflBDSV9C
VVNfRkxBR1NfU1VQUE9SVFNfSU87CiAJCXJldHVybjsKIAl9CiAKIAlpZiAoIXBjaV9yb290X2hh
c19pb19yZXNvdXJjZShjaGlsZCkpIHsKIAkJZGV2X3ByaW50ayhLRVJOX0RFQlVHLCAmZGV2LT5k
ZXYsICIgIG5vIEkvTyByZXNvdXJjZSBvbiByb290IGJ1c1xuIik7CisJCWNoaWxkLT5idXNfZmxh
Z3MgJj0gflBDSV9CVVNfRkxBR1NfU1VQUE9SVFNfSU87CiAJCXJldHVybjsKIAl9CiAKLQljaGls
ZC0+YnVzX2ZsYWdzIHw9IFBDSV9CVVNfRkxBR1NfU1VQUE9SVFNfSU87Ci0KIAlpb19tYXNrID0g
UENJX0lPX1JBTkdFX01BU0s7CiAJaW9fZ3JhbnVsYXJpdHkgPSAweDEwMDA7CiAJaWYgKGRldi0+
aW9fd2luZG93XzFrKSB7CkBAIC01NDQsNiArNTQ0LDcgQEAgc3RhdGljIHN0cnVjdCBwY2lfYnVz
ICpwY2lfYWxsb2NfYnVzKHN0cnVjdCBwY2lfYnVzICpwYXJlbnQpCiAJSU5JVF9MSVNUX0hFQUQo
JmItPnJlc291cmNlcyk7CiAJYi0+bWF4X2J1c19zcGVlZCA9IFBDSV9TUEVFRF9VTktOT1dOOwog
CWItPmN1cl9idXNfc3BlZWQgPSBQQ0lfU1BFRURfVU5LTk9XTjsKKwliLT5idXNfZmxhZ3MgfD0g
UENJX0JVU19GTEFHU19TVVBQT1JUU19JTzsKICNpZmRlZiBDT05GSUdfUENJX0RPTUFJTlNfR0VO
RVJJQwogCWlmIChwYXJlbnQpCiAJCWItPmRvbWFpbl9uciA9IHBhcmVudC0+ZG9tYWluX25yOwo=
--047d7b10c8718f8eba051c095e15--
