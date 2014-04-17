Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43444 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882AbaDQDau (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Apr 2014 23:30:50 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so11484271iec.30
        for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2014 20:30:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6mLmzFOy4kqBCSTVrbT2_OqfuugZh7bA-kywwSnYto_A@mail.gmail.com>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
	<1394222924-28886-1-git-send-email-yinghai@kernel.org>
	<CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
	<20140408025738.GA3198@yanx>
	<CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
	<20140409075215.GA3173@yanx>
	<CAErSpo4aGU_rmNSiv=HS-pDVsfKk798zLQW8Kx5huHe8jwdghw@mail.gmail.com>
	<20140415115450.GA7792@yanx>
	<CAErSpo63LKffb4DH+cSfBnvtAoPy06u22e7CUhRuKr-PHNWZMw@mail.gmail.com>
	<CAE9FiQUv7yfUDsTa_N=FFARRYFmrCxRVN-vCp3NikSf+ARkPdA@mail.gmail.com>
	<CAErSpo6mLmzFOy4kqBCSTVrbT2_OqfuugZh7bA-kywwSnYto_A@mail.gmail.com>
Date: Wed, 16 Apr 2014 20:30:50 -0700
Message-ID: <CAE9FiQUKYMPvXLsk84o-gH-j0-wiJGL0Wt1aTW2o4FPSm0PvbQ@mail.gmail.com>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>, talal@mellanox.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: multipart/mixed; boundary=047d7bd76d1ede8c2104f734a8b9
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--047d7bd76d1ede8c2104f734a8b9
Content-Type: text/plain; charset=UTF-8

On Wed, Apr 16, 2014 at 10:06 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I think we should stop putting PCI_PREF_RANGE_TYPE_64 in res->flags.
> I don't think we ever test for PCI_PREF_RANGE_TYPE_64 today, except
> for the trivial usage in pci_read_bridge_mmio_pref(), which can be
> easily removed.
>
> Everywhere else, we use IORESOURCE_MEM, IORESOURCE_MEM_64, and
> IORESOURCE_PREFETCH to keep track of the properties of the hardware
> underlying the struct resource, i.e., the BAR.  Why shouldn't we do
> the same for bridge windows?
>
> The struct resource flags should tell us the *possible* properties of
> the window, e.g., what the bridge can support.  These properties are
> fixed by the bridge hardware, regardless of what devices happen to be
> below the bridge.  We discover those properties at enumeration-time,
> and we shouldn't change them afterwards.

After this patch (we check exact type with 64bit pref), actually bridge flags
IORESOURCE_MEM_64 would not get cleared.
so we don't check that in pbus_size_mem anymore.

Following patch could be applied later.

Subject: [PATCH] PCI: don't update bridge resource flags according to children

After  PCI: Try best to allocate pref mmio 64bit above 4g
We don't need to check if children support 64bit, and update
bridge resource flags anymore.
As the code size and assign according exact type already.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/setup-bus.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -926,7 +926,6 @@ static int pbus_size_mem(struct pci_bus
     int order, max_order;
     struct resource *b_res = find_free_bus_resource(bus,
                      mask | IORESOURCE_PREFETCH, type);
-    unsigned int mem64_mask = 0;
     resource_size_t children_add_size = 0;

     if (!b_res)
@@ -936,9 +935,6 @@ static int pbus_size_mem(struct pci_bus
     max_order = 0;
     size = 0;

-    mem64_mask = b_res->flags & IORESOURCE_MEM_64;
-    b_res->flags &= ~IORESOURCE_MEM_64;
-
     list_for_each_entry(dev, &bus->devices, bus_list) {
         int i;

@@ -980,7 +976,6 @@ static int pbus_size_mem(struct pci_bus
                 aligns[order] += align;
             if (order > max_order)
                 max_order = order;
-            mem64_mask &= r->flags & IORESOURCE_MEM_64;

             if (realloc_head)
                 children_add_size += get_res_add_size(realloc_head, r);
@@ -1005,7 +1000,7 @@ static int pbus_size_mem(struct pci_bus
     }
     b_res->start = min_align;
     b_res->end = size0 + min_align - 1;
-    b_res->flags |= IORESOURCE_STARTALIGN | mem64_mask;
+    b_res->flags |= IORESOURCE_STARTALIGN;
     if (size1 > size0 && realloc_head) {
         add_to_list(realloc_head, bus->self, b_res, size1-size0, min_align);
         dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "

--047d7bd76d1ede8c2104f734a8b9
Content-Type: text/x-patch; charset=US-ASCII; name="remove_mmio64_check.patch"
Content-Disposition: attachment; filename="remove_mmio64_check.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hu3ht8od0

U3ViamVjdDogW1BBVENIXSBQQ0k6IGRvbid0IHVwZGF0ZSBicmlkZ2UgcmVzb3VyY2UgZmxhZ3Mg
YWNjb3JkaW5nIHRvIGNoaWxkcmVuCgpBZnRlciAgUENJOiBUcnkgYmVzdCB0byBhbGxvY2F0ZSBw
cmVmIG1taW8gNjRiaXQgYWJvdmUgNGcKV2UgZG9uJ3QgbmVlZCB0byBjaGVjayBpZiBjaGlsZHJl
biBzdXBwb3J0IDY0Yml0LCBhbmQgdXBkYXRlCmJyaWRnZSByZXNvdXJjZSBmbGFncyBhbnltb3Jl
LgpBcyB0aGUgY29kZSBzaXplIGFuZCBhc3NpZ24gYWNjb3JkaW5nIGV4YWN0IHR5cGUgYWxyZWFk
eS4KClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdoYWlAa2VybmVsLm9yZz4KCi0tLQog
ZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMgfCAgICA3ICstLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgNiBkZWxldGlvbnMoLSkKCkluZGV4OiBsaW51eC0yLjYvZHJpdmVycy9w
Y2kvc2V0dXAtYnVzLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9wY2kv
c2V0dXAtYnVzLmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9zZXR1cC1idXMuYwpAQCAtOTI2
LDcgKzkyNiw2IEBAIHN0YXRpYyBpbnQgcGJ1c19zaXplX21lbShzdHJ1Y3QgcGNpX2J1cwogCWlu
dCBvcmRlciwgbWF4X29yZGVyOwogCXN0cnVjdCByZXNvdXJjZSAqYl9yZXMgPSBmaW5kX2ZyZWVf
YnVzX3Jlc291cmNlKGJ1cywKIAkJCQkJIG1hc2sgfCBJT1JFU09VUkNFX1BSRUZFVENILCB0eXBl
KTsKLQl1bnNpZ25lZCBpbnQgbWVtNjRfbWFzayA9IDA7CiAJcmVzb3VyY2Vfc2l6ZV90IGNoaWxk
cmVuX2FkZF9zaXplID0gMDsKIAogCWlmICghYl9yZXMpCkBAIC05MzYsOSArOTM1LDYgQEAgc3Rh
dGljIGludCBwYnVzX3NpemVfbWVtKHN0cnVjdCBwY2lfYnVzCiAJbWF4X29yZGVyID0gMDsKIAlz
aXplID0gMDsKIAotCW1lbTY0X21hc2sgPSBiX3Jlcy0+ZmxhZ3MgJiBJT1JFU09VUkNFX01FTV82
NDsKLQliX3Jlcy0+ZmxhZ3MgJj0gfklPUkVTT1VSQ0VfTUVNXzY0OwotCiAJbGlzdF9mb3JfZWFj
aF9lbnRyeShkZXYsICZidXMtPmRldmljZXMsIGJ1c19saXN0KSB7CiAJCWludCBpOwogCkBAIC05
ODAsNyArOTc2LDYgQEAgc3RhdGljIGludCBwYnVzX3NpemVfbWVtKHN0cnVjdCBwY2lfYnVzCiAJ
CQkJYWxpZ25zW29yZGVyXSArPSBhbGlnbjsKIAkJCWlmIChvcmRlciA+IG1heF9vcmRlcikKIAkJ
CQltYXhfb3JkZXIgPSBvcmRlcjsKLQkJCW1lbTY0X21hc2sgJj0gci0+ZmxhZ3MgJiBJT1JFU09V
UkNFX01FTV82NDsKIAogCQkJaWYgKHJlYWxsb2NfaGVhZCkKIAkJCQljaGlsZHJlbl9hZGRfc2l6
ZSArPSBnZXRfcmVzX2FkZF9zaXplKHJlYWxsb2NfaGVhZCwgcik7CkBAIC0xMDA1LDcgKzEwMDAs
NyBAQCBzdGF0aWMgaW50IHBidXNfc2l6ZV9tZW0oc3RydWN0IHBjaV9idXMKIAl9CiAJYl9yZXMt
PnN0YXJ0ID0gbWluX2FsaWduOwogCWJfcmVzLT5lbmQgPSBzaXplMCArIG1pbl9hbGlnbiAtIDE7
Ci0JYl9yZXMtPmZsYWdzIHw9IElPUkVTT1VSQ0VfU1RBUlRBTElHTiB8IG1lbTY0X21hc2s7CisJ
Yl9yZXMtPmZsYWdzIHw9IElPUkVTT1VSQ0VfU1RBUlRBTElHTjsKIAlpZiAoc2l6ZTEgPiBzaXpl
MCAmJiByZWFsbG9jX2hlYWQpIHsKIAkJYWRkX3RvX2xpc3QocmVhbGxvY19oZWFkLCBidXMtPnNl
bGYsIGJfcmVzLCBzaXplMS1zaXplMCwgbWluX2FsaWduKTsKIAkJZGV2X3ByaW50ayhLRVJOX0RF
QlVHLCAmYnVzLT5zZWxmLT5kZXYsICJicmlkZ2Ugd2luZG93ICIK
--047d7bd76d1ede8c2104f734a8b9--
