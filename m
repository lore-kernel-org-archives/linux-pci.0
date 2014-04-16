Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:60711 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaDPC3h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Apr 2014 22:29:37 -0400
Received: by mail-ig0-f169.google.com with SMTP id h18so542622igc.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2014 19:29:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo63LKffb4DH+cSfBnvtAoPy06u22e7CUhRuKr-PHNWZMw@mail.gmail.com>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
	<1394222924-28886-1-git-send-email-yinghai@kernel.org>
	<CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
	<20140408025738.GA3198@yanx>
	<CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
	<20140409075215.GA3173@yanx>
	<CAErSpo4aGU_rmNSiv=HS-pDVsfKk798zLQW8Kx5huHe8jwdghw@mail.gmail.com>
	<20140415115450.GA7792@yanx>
	<CAErSpo63LKffb4DH+cSfBnvtAoPy06u22e7CUhRuKr-PHNWZMw@mail.gmail.com>
Date: Tue, 15 Apr 2014 19:29:36 -0700
Message-ID: <CAE9FiQUv7yfUDsTa_N=FFARRYFmrCxRVN-vCp3NikSf+ARkPdA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary=001a11c1e914135e4604f71fb09a
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a11c1e914135e4604f71fb09a
Content-Type: text/plain; charset=UTF-8

On Tue, Apr 15, 2014 at 5:09 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> It went wrong at the beginning. Note the error message never considers
>> 64-bit or not, but BAR 15 here has it MEM_64 flag cleared.
>
> BAR 15 is a bridge window.  I think its resource flags should reflect
> the capability of the *window*, even if we disable the window or we
> happen to assign addresses that are under 4GB.  So I think it's wrong
> that we clear the MEM_64 flag  in pbus_size_mem() and the IO flag in
> pbus_size_io().

We keep PCI_PREF_RANGE_TYPE_64 in the flag.

We should check that before we touch PCI_PREF_LIMIT_UPPER32 BAR in
pci_setup_bridge_mmio_pref()

like following:

Subject: [PATCH] PCI: only touch upper 32bit for pref64bit bridge bar

If the bridge pref mmio bar does not support 64bit, we should touch
upper 32bit.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/setup-bus.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -592,23 +592,23 @@ static void pci_setup_bridge_mmio(struct
 static void pci_setup_bridge_mmio_pref(struct pci_bus *bus)
 {
     struct pci_dev *bridge = bus->self;
-    struct resource *res;
+    struct resource *res = bus->resource[2];
     struct pci_bus_region region;
     u32 l, bu, lu;

     /* Clear out the upper 32 bits of PREF limit.
        If PCI_PREF_BASE_UPPER32 was non-zero, this temporarily
        disables PREF range, which is ok. */
-    pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
+    if (res->flags & PCI_PREF_RANGE_TYPE_64)
+        pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);

     /* Set up PREF base/limit. */
     bu = lu = 0;
-    res = bus->resource[2];
     pcibios_resource_to_bus(bridge->bus, &region, res);
     if (res->flags & IORESOURCE_PREFETCH) {
         l = (region.start >> 16) & 0xfff0;
         l |= region.end & 0xfff00000;
-        if (res->flags & IORESOURCE_MEM_64) {
+        if (res->flags & PCI_PREF_RANGE_TYPE_64) {
             bu = upper_32_bits(region.start);
             lu = upper_32_bits(region.end);
         }
@@ -619,8 +619,10 @@ static void pci_setup_bridge_mmio_pref(s
     pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);

     /* Set the upper 32 bits of PREF base & limit. */
-    pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, bu);
-    pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, lu);
+    if (res->flags & PCI_PREF_RANGE_TYPE_64) {
+        pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, bu);
+        pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, lu);
+    }
 }

 static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)

--001a11c1e914135e4604f71fb09a
Content-Type: text/x-patch; charset=US-ASCII;
	name="only_touch_uppper32_for_64bitpref.patch"
Content-Disposition: attachment;
	filename="only_touch_uppper32_for_64bitpref.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hu206isl0

U3ViamVjdDogW1BBVENIXSBQQ0k6IG9ubHkgdG91Y2ggdXBwZXIgMzJiaXQgZm9yIHByZWY2NGJp
dCBicmlkZ2UgYmFyCgpJZiB0aGUgYnJpZGdlIHByZWYgbW1pbyBiYXIgZG9lcyBub3Qgc3VwcG9y
dCA2NGJpdCwgd2Ugc2hvdWxkIHRvdWNoCnVwcGVyIDMyYml0LgoKU2lnbmVkLW9mZi1ieTogWWlu
Z2hhaSBMdSA8eWluZ2hhaUBrZXJuZWwub3JnPgoKLS0tCiBkcml2ZXJzL3BjaS9zZXR1cC1idXMu
YyB8ICAgMTQgKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pCgpJbmRleDogbGludXgtMi42L2RyaXZlcnMvcGNpL3NldHVwLWJ1cy5j
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2RyaXZlcnMvcGNpL3NldHVwLWJ1cy5jCisr
KyBsaW51eC0yLjYvZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMKQEAgLTU5MiwyMyArNTkyLDIzIEBA
IHN0YXRpYyB2b2lkIHBjaV9zZXR1cF9icmlkZ2VfbW1pbyhzdHJ1Y3QKIHN0YXRpYyB2b2lkIHBj
aV9zZXR1cF9icmlkZ2VfbW1pb19wcmVmKHN0cnVjdCBwY2lfYnVzICpidXMpCiB7CiAJc3RydWN0
IHBjaV9kZXYgKmJyaWRnZSA9IGJ1cy0+c2VsZjsKLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsKKwlz
dHJ1Y3QgcmVzb3VyY2UgKnJlcyA9IGJ1cy0+cmVzb3VyY2VbMl07CiAJc3RydWN0IHBjaV9idXNf
cmVnaW9uIHJlZ2lvbjsKIAl1MzIgbCwgYnUsIGx1OwogCiAJLyogQ2xlYXIgb3V0IHRoZSB1cHBl
ciAzMiBiaXRzIG9mIFBSRUYgbGltaXQuCiAJICAgSWYgUENJX1BSRUZfQkFTRV9VUFBFUjMyIHdh
cyBub24temVybywgdGhpcyB0ZW1wb3JhcmlseQogCSAgIGRpc2FibGVzIFBSRUYgcmFuZ2UsIHdo
aWNoIGlzIG9rLiAqLwotCXBjaV93cml0ZV9jb25maWdfZHdvcmQoYnJpZGdlLCBQQ0lfUFJFRl9M
SU1JVF9VUFBFUjMyLCAwKTsKKwlpZiAocmVzLT5mbGFncyAmIFBDSV9QUkVGX1JBTkdFX1RZUEVf
NjQpCisJCXBjaV93cml0ZV9jb25maWdfZHdvcmQoYnJpZGdlLCBQQ0lfUFJFRl9MSU1JVF9VUFBF
UjMyLCAwKTsKIAogCS8qIFNldCB1cCBQUkVGIGJhc2UvbGltaXQuICovCiAJYnUgPSBsdSA9IDA7
Ci0JcmVzID0gYnVzLT5yZXNvdXJjZVsyXTsKIAlwY2liaW9zX3Jlc291cmNlX3RvX2J1cyhicmlk
Z2UtPmJ1cywgJnJlZ2lvbiwgcmVzKTsKIAlpZiAocmVzLT5mbGFncyAmIElPUkVTT1VSQ0VfUFJF
RkVUQ0gpIHsKIAkJbCA9IChyZWdpb24uc3RhcnQgPj4gMTYpICYgMHhmZmYwOwogCQlsIHw9IHJl
Z2lvbi5lbmQgJiAweGZmZjAwMDAwOwotCQlpZiAocmVzLT5mbGFncyAmIElPUkVTT1VSQ0VfTUVN
XzY0KSB7CisJCWlmIChyZXMtPmZsYWdzICYgUENJX1BSRUZfUkFOR0VfVFlQRV82NCkgewogCQkJ
YnUgPSB1cHBlcl8zMl9iaXRzKHJlZ2lvbi5zdGFydCk7CiAJCQlsdSA9IHVwcGVyXzMyX2JpdHMo
cmVnaW9uLmVuZCk7CiAJCX0KQEAgLTYxOSw4ICs2MTksMTAgQEAgc3RhdGljIHZvaWQgcGNpX3Nl
dHVwX2JyaWRnZV9tbWlvX3ByZWYocwogCXBjaV93cml0ZV9jb25maWdfZHdvcmQoYnJpZGdlLCBQ
Q0lfUFJFRl9NRU1PUllfQkFTRSwgbCk7CiAKIAkvKiBTZXQgdGhlIHVwcGVyIDMyIGJpdHMgb2Yg
UFJFRiBiYXNlICYgbGltaXQuICovCi0JcGNpX3dyaXRlX2NvbmZpZ19kd29yZChicmlkZ2UsIFBD
SV9QUkVGX0JBU0VfVVBQRVIzMiwgYnUpOwotCXBjaV93cml0ZV9jb25maWdfZHdvcmQoYnJpZGdl
LCBQQ0lfUFJFRl9MSU1JVF9VUFBFUjMyLCBsdSk7CisJaWYgKHJlcy0+ZmxhZ3MgJiBQQ0lfUFJF
Rl9SQU5HRV9UWVBFXzY0KSB7CisJCXBjaV93cml0ZV9jb25maWdfZHdvcmQoYnJpZGdlLCBQQ0lf
UFJFRl9CQVNFX1VQUEVSMzIsIGJ1KTsKKwkJcGNpX3dyaXRlX2NvbmZpZ19kd29yZChicmlkZ2Us
IFBDSV9QUkVGX0xJTUlUX1VQUEVSMzIsIGx1KTsKKwl9CiB9CiAKIHN0YXRpYyB2b2lkIF9fcGNp
X3NldHVwX2JyaWRnZShzdHJ1Y3QgcGNpX2J1cyAqYnVzLCB1bnNpZ25lZCBsb25nIHR5cGUpCg==
--001a11c1e914135e4604f71fb09a--
