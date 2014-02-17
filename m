Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:63148 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbaBQT2H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2014 14:28:07 -0500
Received: by mail-oa0-f52.google.com with SMTP id i4so18316047oah.11
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2014 11:28:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140217045004.GB3230@yanx>
References: <20140217045004.GB3230@yanx>
Date: Mon, 17 Feb 2014 11:28:06 -0800
Message-ID: <CAE9FiQXmWG2RNP-t=U06JUsqkmDm2My5762za8QuwUMZsG+yNg@mail.gmail.com>
Subject: Re: Support huge alignment in pbus_size_mem()
From: Yinghai Lu <yinghai@kernel.org>
To: Guo Chao <yan@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: multipart/mixed; boundary=e89a8ff25042acfaab04f29f2746
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--e89a8ff25042acfaab04f29f2746
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Feb 16, 2014 at 8:50 PM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> pbus_size_mem() limits resource alignment within 2G. We want to extend
> this limit to support a 16G BAR. I found similar effort was tried before:
>
>         https://lkml.org/lkml/2012/6/21/411
>
> What's the result? Does anyone come up with an adaptive algorithm?

I suggest following changes:

From: Nikhil P Rao <nikhil.rao@intel.com>
Subject: [PATCH] PCI: Fix bus align checking to support more than 2G

current 2G is out of date.

-v3: We only need to extend that when 64bit mmio is supported.
     So extract mmio64 mask checking, and still keep old 2G checking
     for other path.  --- Yinghai

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/setup-bus.c |   42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -921,7 +921,7 @@ static int pbus_size_mem(struct pci_bus
 {
     struct pci_dev *dev;
     resource_size_t min_align, align, size, size0, size1;
-    resource_size_t aligns[12];    /* Alignments from 1Mb to 2Gb */
+    resource_size_t aligns[44];    /* Alignments from 1Mb to 2^63 */
     int order, max_order;
     struct resource *b_res = find_free_bus_resource(bus, type);
     unsigned int mem64_mask = 0;
@@ -937,6 +937,40 @@ static int pbus_size_mem(struct pci_bus
     mem64_mask = b_res->flags & IORESOURCE_MEM_64;
     b_res->flags &= ~IORESOURCE_MEM_64;

+    /* kernel does not support 64bit */
+    if (sizeof(resource_size_t) == 4)
+        mem64_mask &=  ~IORESOURCE_MEM_64;
+
+    if (!(mem64_mask & IORESOURCE_MEM_64))
+        goto mem64_mask_check_done;
+
+    /* check if mem64 support is supported and needed at first */
+    list_for_each_entry(dev, &bus->devices, bus_list) {
+        int i;
+
+        for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+            struct resource *r = &dev->resource[i];
+            resource_size_t r_size;
+
+            if (r->parent || (r->flags & mask) != type)
+                continue;
+            r_size = resource_size(r);
+#ifdef CONFIG_PCI_IOV
+            /* put SRIOV requested res to the optional list */
+            if (realloc_head && i >= PCI_IOV_RESOURCES &&
+                    i <= PCI_IOV_RESOURCE_END)
+                continue;
+#endif
+            mem64_mask &= r->flags & IORESOURCE_MEM_64;
+
+            if (!(mem64_mask & IORESOURCE_MEM_64))
+                goto mem64_mask_check_done;
+
+        }
+    }
+
+mem64_mask_check_done:
+
     list_for_each_entry(dev, &bus->devices, bus_list) {
         int i;

@@ -959,8 +993,9 @@ static int pbus_size_mem(struct pci_bus
 #endif
             /* For bridges size != alignment */
             align = pci_resource_alignment(dev, r);
-            order = __ffs(align) - 20;
-            if (order > 11) {
+            order = __ffs64(align) - 20;
+            if (order > ARRAY_SIZE(aligns) ||
+                (!(mem64_mask & IORESOURCE_MEM_64) && order > 11) ) {
                 dev_warn(&dev->dev, "disabling BAR %d: %pR "
                      "(bad alignment %#llx)\n", i, r,
                      (unsigned long long) align);
@@ -976,7 +1011,6 @@ static int pbus_size_mem(struct pci_bus
                 aligns[order] += align;
             if (order > max_order)
                 max_order = order;
-            mem64_mask &= r->flags & IORESOURCE_MEM_64;

             if (realloc_head)
                 children_add_size += get_res_add_size(realloc_head, r);

--e89a8ff25042acfaab04f29f2746
Content-Type: text/x-patch; charset=US-ASCII; name="bus_mmio_align.patch"
Content-Disposition: attachment; filename="bus_mmio_align.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hrs5088i0

RnJvbTogTmlraGlsIFAgUmFvIDxuaWtoaWwucmFvQGludGVsLmNvbT4KU3ViamVjdDogW1BBVENI
XSBQQ0k6IEZpeCBidXMgYWxpZ24gY2hlY2tpbmcgdG8gc3VwcG9ydCBtb3JlIHRoYW4gMkcKCmN1
cnJlbnQgMkcgaXMgb3V0IG9mIGRhdGUuCgotdjM6IFdlIG9ubHkgbmVlZCB0byBleHRlbmQgdGhh
dCB3aGVuIDY0Yml0IG1taW8gaXMgc3VwcG9ydGVkLgogICAgIFNvIGV4dHJhY3QgbW1pbzY0IG1h
c2sgY2hlY2tpbmcsIGFuZCBzdGlsbCBrZWVwIG9sZCAyRyBjaGVja2luZwogICAgIGZvciBvdGhl
ciBwYXRoLiAgLS0tIFlpbmdoYWkKClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdoYWlA
a2VybmVsLm9yZz4KCi0tLQogZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMgfCAgIDQyICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM4IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtMi42L2RyaXZlcnMvcGNp
L3NldHVwLWJ1cy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2RyaXZlcnMvcGNpL3Nl
dHVwLWJ1cy5jCisrKyBsaW51eC0yLjYvZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMKQEAgLTkyMSw3
ICs5MjEsNyBAQCBzdGF0aWMgaW50IHBidXNfc2l6ZV9tZW0oc3RydWN0IHBjaV9idXMKIHsKIAlz
dHJ1Y3QgcGNpX2RldiAqZGV2OwogCXJlc291cmNlX3NpemVfdCBtaW5fYWxpZ24sIGFsaWduLCBz
aXplLCBzaXplMCwgc2l6ZTE7Ci0JcmVzb3VyY2Vfc2l6ZV90IGFsaWduc1sxMl07CS8qIEFsaWdu
bWVudHMgZnJvbSAxTWIgdG8gMkdiICovCisJcmVzb3VyY2Vfc2l6ZV90IGFsaWduc1s0NF07CS8q
IEFsaWdubWVudHMgZnJvbSAxTWIgdG8gMl42MyAqLwogCWludCBvcmRlciwgbWF4X29yZGVyOwog
CXN0cnVjdCByZXNvdXJjZSAqYl9yZXMgPSBmaW5kX2ZyZWVfYnVzX3Jlc291cmNlKGJ1cywgdHlw
ZSk7CiAJdW5zaWduZWQgaW50IG1lbTY0X21hc2sgPSAwOwpAQCAtOTM3LDYgKzkzNyw0MCBAQCBz
dGF0aWMgaW50IHBidXNfc2l6ZV9tZW0oc3RydWN0IHBjaV9idXMKIAltZW02NF9tYXNrID0gYl9y
ZXMtPmZsYWdzICYgSU9SRVNPVVJDRV9NRU1fNjQ7CiAJYl9yZXMtPmZsYWdzICY9IH5JT1JFU09V
UkNFX01FTV82NDsKIAorCS8qIGtlcm5lbCBkb2VzIG5vdCBzdXBwb3J0IDY0Yml0ICovCisJaWYg
KHNpemVvZihyZXNvdXJjZV9zaXplX3QpID09IDQpCisJCW1lbTY0X21hc2sgJj0gIH5JT1JFU09V
UkNFX01FTV82NDsKKworCWlmICghKG1lbTY0X21hc2sgJiBJT1JFU09VUkNFX01FTV82NCkpCisJ
CWdvdG8gbWVtNjRfbWFza19jaGVja19kb25lOworCisJLyogY2hlY2sgaWYgbWVtNjQgc3VwcG9y
dCBpcyBzdXBwb3J0ZWQgYW5kIG5lZWRlZCBhdCBmaXJzdCAqLworCWxpc3RfZm9yX2VhY2hfZW50
cnkoZGV2LCAmYnVzLT5kZXZpY2VzLCBidXNfbGlzdCkgeworCQlpbnQgaTsKKworCQlmb3IgKGkg
PSAwOyBpIDwgUENJX05VTV9SRVNPVVJDRVM7IGkrKykgeworCQkJc3RydWN0IHJlc291cmNlICpy
ID0gJmRldi0+cmVzb3VyY2VbaV07CisJCQlyZXNvdXJjZV9zaXplX3Qgcl9zaXplOworCisJCQlp
ZiAoci0+cGFyZW50IHx8IChyLT5mbGFncyAmIG1hc2spICE9IHR5cGUpCisJCQkJY29udGludWU7
CisJCQlyX3NpemUgPSByZXNvdXJjZV9zaXplKHIpOworI2lmZGVmIENPTkZJR19QQ0lfSU9WCisJ
CQkvKiBwdXQgU1JJT1YgcmVxdWVzdGVkIHJlcyB0byB0aGUgb3B0aW9uYWwgbGlzdCAqLworCQkJ
aWYgKHJlYWxsb2NfaGVhZCAmJiBpID49IFBDSV9JT1ZfUkVTT1VSQ0VTICYmCisJCQkJCWkgPD0g
UENJX0lPVl9SRVNPVVJDRV9FTkQpCisJCQkJY29udGludWU7CisjZW5kaWYKKwkJCW1lbTY0X21h
c2sgJj0gci0+ZmxhZ3MgJiBJT1JFU09VUkNFX01FTV82NDsKKworCQkJaWYgKCEobWVtNjRfbWFz
ayAmIElPUkVTT1VSQ0VfTUVNXzY0KSkKKwkJCQlnb3RvIG1lbTY0X21hc2tfY2hlY2tfZG9uZTsK
KworCQl9CisJfQorCittZW02NF9tYXNrX2NoZWNrX2RvbmU6CisKIAlsaXN0X2Zvcl9lYWNoX2Vu
dHJ5KGRldiwgJmJ1cy0+ZGV2aWNlcywgYnVzX2xpc3QpIHsKIAkJaW50IGk7CiAKQEAgLTk1OSw4
ICs5OTMsOSBAQCBzdGF0aWMgaW50IHBidXNfc2l6ZV9tZW0oc3RydWN0IHBjaV9idXMKICNlbmRp
ZgogCQkJLyogRm9yIGJyaWRnZXMgc2l6ZSAhPSBhbGlnbm1lbnQgKi8KIAkJCWFsaWduID0gcGNp
X3Jlc291cmNlX2FsaWdubWVudChkZXYsIHIpOwotCQkJb3JkZXIgPSBfX2ZmcyhhbGlnbikgLSAy
MDsKLQkJCWlmIChvcmRlciA+IDExKSB7CisJCQlvcmRlciA9IF9fZmZzNjQoYWxpZ24pIC0gMjA7
CisJCQlpZiAob3JkZXIgPiBBUlJBWV9TSVpFKGFsaWducykgfHwKKwkJCSAgICAoIShtZW02NF9t
YXNrICYgSU9SRVNPVVJDRV9NRU1fNjQpICYmIG9yZGVyID4gMTEpICkgewogCQkJCWRldl93YXJu
KCZkZXYtPmRldiwgImRpc2FibGluZyBCQVIgJWQ6ICVwUiAiCiAJCQkJCSAiKGJhZCBhbGlnbm1l
bnQgJSNsbHgpXG4iLCBpLCByLAogCQkJCQkgKHVuc2lnbmVkIGxvbmcgbG9uZykgYWxpZ24pOwpA
QCAtOTc2LDcgKzEwMTEsNiBAQCBzdGF0aWMgaW50IHBidXNfc2l6ZV9tZW0oc3RydWN0IHBjaV9i
dXMKIAkJCQlhbGlnbnNbb3JkZXJdICs9IGFsaWduOwogCQkJaWYgKG9yZGVyID4gbWF4X29yZGVy
KQogCQkJCW1heF9vcmRlciA9IG9yZGVyOwotCQkJbWVtNjRfbWFzayAmPSByLT5mbGFncyAmIElP
UkVTT1VSQ0VfTUVNXzY0OwogCiAJCQlpZiAocmVhbGxvY19oZWFkKQogCQkJCWNoaWxkcmVuX2Fk
ZF9zaXplICs9IGdldF9yZXNfYWRkX3NpemUocmVhbGxvY19oZWFkLCByKTsK
--e89a8ff25042acfaab04f29f2746--
