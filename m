Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:60045 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932489AbaLEAYz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Dec 2014 19:24:55 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so19702393igi.6
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2014 16:24:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXe-jedCr-DUat3Ujay1Q=jUX9B_qLJRfhia-QVB_RW4w@mail.gmail.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
	<CAE9FiQXqqg-KYi3aEVvCm=hfjN3mx_7J8uQ61hVJFVLNe+U=Zg@mail.gmail.com>
	<20141204163741.GD3168@google.com>
	<CAE9FiQXe-jedCr-DUat3Ujay1Q=jUX9B_qLJRfhia-QVB_RW4w@mail.gmail.com>
Date: Thu, 4 Dec 2014 16:24:54 -0800
Message-ID: <CAE9FiQVKgG64o+8ngqh=7tQ0jWqqSMGkxtuDc-tgqhVmfU+jjw@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Saifi Khan <saifi.khan@datasynergy.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	=?UTF-8?Q?Marek_Kord=C3=ADk?= <kordikmarek@gmail.com>
Content-Type: multipart/mixed; boundary=bcaec5171a8718aba905096d1b9a
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--bcaec5171a8718aba905096d1b9a
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 4, 2014 at 2:24 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Dec 4, 2014 at 8:37 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> pci=realloc should workaround the problem, as it would take control of
>>> the bridge mmio BAR, and allocate more range for mmio pref under it.
>>
>> I don't think pci=realloc is the answer because
>>
>>   1) It's a poor user experience.  We should be able to handle this
>>      automatically, without asking the user to do anything.
>
> we can detect that when bridge support 64bit mmio pref, and reject
> child device pref that only
> support mmio pref non-b64bit.
>
>>
>>   2) It puts the radeon framebuffer in the non-prefetchable window, and we
>>      should be able to keep it in the prefetchable window.
>
> clear bridge 64bit flags if all children does not support that?
>
> even that slot supports hotplug.

Please check if attached patch is good for v3.18.

---
 drivers/pci/setup-bus.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -1118,6 +1118,52 @@ handle_done:
     ;
 }

+static void pbus_check_mem64(struct pci_bus *bus, unsigned long mask,
+             unsigned long type, struct list_head *realloc_head)
+{
+    struct pci_dev *dev;
+    resource_size_t align;
+    resource_size_t aligns[18];    /* Alignments from 1Mb to 128Gb */
+    int order;
+    unsigned int mem64_mask = 0;
+    struct resource *b_res = find_free_bus_resource(bus, mask, type);
+
+    if (!b_res || !(b_res->flags & IORESOURCE_MEM_64))
+        return;
+
+    memset(aligns, 0, sizeof(aligns));
+
+    mem64_mask = IORESOURCE_MEM_64;
+    b_res->flags &= ~IORESOURCE_MEM_64;
+
+    list_for_each_entry(dev, &bus->devices, bus_list) {
+        int i;
+
+        for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+            struct resource *r = &dev->resource[i];
+
+            if (r->parent || (r->flags & mask) != type)
+                continue;
+#ifdef CONFIG_PCI_IOV
+            if (realloc_head && i >= PCI_IOV_RESOURCES &&
+                    i <= PCI_IOV_RESOURCE_END)
+                continue;
+#endif
+            align = pci_resource_alignment(dev, r);
+            order = __ffs(align) - 20;
+            if (order < 0)
+                order = 0;
+            if (order >= ARRAY_SIZE(aligns))
+                continue;
+
+            if (i != PCI_ROM_RESOURCE)
+                mem64_mask &= r->flags & IORESOURCE_MEM_64;
+        }
+    }
+
+    b_res->flags |= mem64_mask;
+}
+
 void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head
*realloc_head)
 {
     struct pci_dev *dev;
@@ -1171,6 +1217,10 @@ void __pci_bus_size_bridges(struct pci_b
         b_res = &bus->self->resource[PCI_BRIDGE_RESOURCES];
         mask = IORESOURCE_MEM;
         prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
+
+        if (b_res[2].flags & IORESOURCE_MEM_64)
+            pbus_check_mem64(bus, prefmask, prefmask, realloc_head);
+
         if (b_res[2].flags & IORESOURCE_MEM_64) {
             prefmask |= IORESOURCE_MEM_64;
             ret = pbus_size_mem(bus, prefmask, prefmask,

--bcaec5171a8718aba905096d1b9a
Content-Type: text/x-patch; charset=US-ASCII; name="clear_bridge_mmio64_flag.patch"
Content-Disposition: attachment; filename="clear_bridge_mmio64_flag.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i3at86dh0

LS0tCiBkcml2ZXJzL3BjaS9zZXR1cC1idXMuYyB8ICAgNTAgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9u
cygrKQoKSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9zZXR1cC1idXMuYwo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Ci0tLSBsaW51eC0yLjYub3JpZy9kcml2ZXJzL3BjaS9zZXR1cC1idXMuYworKysgbGludXgtMi42
L2RyaXZlcnMvcGNpL3NldHVwLWJ1cy5jCkBAIC0xMTE4LDYgKzExMTgsNTIgQEAgaGFuZGxlX2Rv
bmU6CiAJOwogfQogCitzdGF0aWMgdm9pZCBwYnVzX2NoZWNrX21lbTY0KHN0cnVjdCBwY2lfYnVz
ICpidXMsIHVuc2lnbmVkIGxvbmcgbWFzaywKKwkJCSB1bnNpZ25lZCBsb25nIHR5cGUsIHN0cnVj
dCBsaXN0X2hlYWQgKnJlYWxsb2NfaGVhZCkKK3sKKwlzdHJ1Y3QgcGNpX2RldiAqZGV2OworCXJl
c291cmNlX3NpemVfdCBhbGlnbjsKKwlyZXNvdXJjZV9zaXplX3QgYWxpZ25zWzE4XTsJLyogQWxp
Z25tZW50cyBmcm9tIDFNYiB0byAxMjhHYiAqLworCWludCBvcmRlcjsKKwl1bnNpZ25lZCBpbnQg
bWVtNjRfbWFzayA9IDA7CisJc3RydWN0IHJlc291cmNlICpiX3JlcyA9IGZpbmRfZnJlZV9idXNf
cmVzb3VyY2UoYnVzLCBtYXNrLCB0eXBlKTsKKworCWlmICghYl9yZXMgfHwgIShiX3Jlcy0+Zmxh
Z3MgJiBJT1JFU09VUkNFX01FTV82NCkpCisJCXJldHVybjsKKworCW1lbXNldChhbGlnbnMsIDAs
IHNpemVvZihhbGlnbnMpKTsKKworCW1lbTY0X21hc2sgPSBJT1JFU09VUkNFX01FTV82NDsKKwli
X3Jlcy0+ZmxhZ3MgJj0gfklPUkVTT1VSQ0VfTUVNXzY0OworCisJbGlzdF9mb3JfZWFjaF9lbnRy
eShkZXYsICZidXMtPmRldmljZXMsIGJ1c19saXN0KSB7CisJCWludCBpOworCisJCWZvciAoaSA9
IDA7IGkgPCBQQ0lfTlVNX1JFU09VUkNFUzsgaSsrKSB7CisJCQlzdHJ1Y3QgcmVzb3VyY2UgKnIg
PSAmZGV2LT5yZXNvdXJjZVtpXTsKKworCQkJaWYgKHItPnBhcmVudCB8fCAoci0+ZmxhZ3MgJiBt
YXNrKSAhPSB0eXBlKQorCQkJCWNvbnRpbnVlOworI2lmZGVmIENPTkZJR19QQ0lfSU9WCisJCQlp
ZiAocmVhbGxvY19oZWFkICYmIGkgPj0gUENJX0lPVl9SRVNPVVJDRVMgJiYKKwkJCQkJaSA8PSBQ
Q0lfSU9WX1JFU09VUkNFX0VORCkKKwkJCQljb250aW51ZTsKKyNlbmRpZgorCQkJYWxpZ24gPSBw
Y2lfcmVzb3VyY2VfYWxpZ25tZW50KGRldiwgcik7CisJCQlvcmRlciA9IF9fZmZzKGFsaWduKSAt
IDIwOworCQkJaWYgKG9yZGVyIDwgMCkKKwkJCQlvcmRlciA9IDA7CisJCQlpZiAob3JkZXIgPj0g
QVJSQVlfU0laRShhbGlnbnMpKQorCQkJCWNvbnRpbnVlOworCisJCQlpZiAoaSAhPSBQQ0lfUk9N
X1JFU09VUkNFKQorCQkJCW1lbTY0X21hc2sgJj0gci0+ZmxhZ3MgJiBJT1JFU09VUkNFX01FTV82
NDsKKwkJfQorCX0KKworCWJfcmVzLT5mbGFncyB8PSBtZW02NF9tYXNrOworfQorCiB2b2lkIF9f
cGNpX2J1c19zaXplX2JyaWRnZXMoc3RydWN0IHBjaV9idXMgKmJ1cywgc3RydWN0IGxpc3RfaGVh
ZCAqcmVhbGxvY19oZWFkKQogewogCXN0cnVjdCBwY2lfZGV2ICpkZXY7CkBAIC0xMTcxLDYgKzEy
MTcsMTAgQEAgdm9pZCBfX3BjaV9idXNfc2l6ZV9icmlkZ2VzKHN0cnVjdCBwY2lfYgogCQliX3Jl
cyA9ICZidXMtPnNlbGYtPnJlc291cmNlW1BDSV9CUklER0VfUkVTT1VSQ0VTXTsKIAkJbWFzayA9
IElPUkVTT1VSQ0VfTUVNOwogCQlwcmVmbWFzayA9IElPUkVTT1VSQ0VfTUVNIHwgSU9SRVNPVVJD
RV9QUkVGRVRDSDsKKworCQlpZiAoYl9yZXNbMl0uZmxhZ3MgJiBJT1JFU09VUkNFX01FTV82NCkK
KwkJCXBidXNfY2hlY2tfbWVtNjQoYnVzLCBwcmVmbWFzaywgcHJlZm1hc2ssIHJlYWxsb2NfaGVh
ZCk7CisKIAkJaWYgKGJfcmVzWzJdLmZsYWdzICYgSU9SRVNPVVJDRV9NRU1fNjQpIHsKIAkJCXBy
ZWZtYXNrIHw9IElPUkVTT1VSQ0VfTUVNXzY0OwogCQkJcmV0ID0gcGJ1c19zaXplX21lbShidXMs
IHByZWZtYXNrLCBwcmVmbWFzaywK
--bcaec5171a8718aba905096d1b9a--
