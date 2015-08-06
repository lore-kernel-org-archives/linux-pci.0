Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34560 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbbHFBic (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Aug 2015 21:38:32 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXuTKmXXCFsKUiMK43U+LpOzfa3oV0iNWS+Jh879EDNsw@mail.gmail.com>
References: <1438308908-12259-1-git-send-email-linux@roeck-us.net>
	<CAE9FiQXuTKmXXCFsKUiMK43U+LpOzfa3oV0iNWS+Jh879EDNsw@mail.gmail.com>
Date: Wed, 5 Aug 2015 18:38:31 -0700
Message-ID: <CAE9FiQVGhfbFW5-5deYcU2bDWE9k0-4+V+cepwdqZ661sLWOFA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Only enable IO window if supported
From: Yinghai Lu <yinghai@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: multipart/mixed; boundary=047d7b160413abb2c0051c9a9376
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--047d7b160413abb2c0051c9a9376
Content-Type: text/plain; charset=UTF-8

On Wed, Aug 5, 2015 at 6:14 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> It only can avoid warning with bridge, and still have warning on
> devices under the bridge.
>
> also would have problem on transparent bridges, like
>
> BRIDGE_A ---- BRIDGE_AA----DEVICE_AA
>                    |
>                    \-- BRIDGE_AB ---DEVICE_AB
>
> if only BRIDGE_A and BRIDGE_AA are transparent, and BRIDGE_AB is not.
>
> and if pci_bridge_supports_io() return false for BRIDGE_A.
>
> We will have all three bridges have PCI_BUS_FLAGS_SUPPORTS_IO cleared.
> so all will not been sized and will not get assigned io port resource.
>
> later DEVICE_AA could root bus io port as parent, and get io resource assigned.
> but DEVICE_AB will not get assigned.
>
> so we should get rid of pci_bridge_supports_io(), and just check root
> resource IO port.

I would suggest this version instead:

Subject: [PATCH] PCI: Only try to assign io port only if root bus support that

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
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

---
 drivers/pci/probe.c     |    5 +++++
 drivers/pci/setup-bus.c |    6 +++++-
 include/linux/pci.h     |    1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/probe.c
===================================================================
--- linux-2.6.orig/drivers/pci/probe.c
+++ linux-2.6/drivers/pci/probe.c
@@ -340,6 +340,9 @@ static void pci_read_bridge_io(struct pc
     struct pci_bus_region region;
     struct resource *res;

+    if (!(child->bus_flags & PCI_BUS_FLAGS_ROOT_SUPPORTS_IO))
+        return;
+
     io_mask = PCI_IO_RANGE_MASK;
     io_granularity = 0x1000;
     if (dev->io_window_1k) {
@@ -2070,6 +2073,8 @@ struct pci_bus *pci_create_root_bus(stru
         } else
             bus_addr[0] = '\0';
         dev_info(&b->dev, "root bus resource %pR%s\n", res, bus_addr);
+        if (resource_type(res) == IORESOURCE_IO)
+            b->bus_flags |= PCI_BUS_FLAGS_ROOT_SUPPORTS_IO;
     }

     down_write(&pci_bus_sem);
Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -156,6 +156,10 @@ static void pdev_sort_resources(struct p
         if (r->flags & IORESOURCE_PCI_FIXED)
             continue;

+        if ((r->flags & IORESOURCE_IO) &&
+            !(dev->bus->bus_flags & PCI_BUS_FLAGS_ROOT_SUPPORTS_IO))
+            continue;
+
         if (!(r->flags) || r->parent)
             continue;

@@ -909,7 +913,7 @@ static void pbus_size_io(struct pci_bus
     resource_size_t children_add_size = 0;
     resource_size_t min_align, align;

-    if (!b_res)
+    if (!b_res || !(bus->bus_flags & PCI_BUS_FLAGS_ROOT_SUPPORTS_IO))
         return;

     min_align = window_alignment(bus, IORESOURCE_IO);
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -193,6 +193,7 @@ typedef unsigned short __bitwise pci_bus
 enum pci_bus_flags {
     PCI_BUS_FLAGS_NO_MSI   = (__force pci_bus_flags_t) 1,
     PCI_BUS_FLAGS_NO_MMRBC = (__force pci_bus_flags_t) 2,
+    PCI_BUS_FLAGS_ROOT_SUPPORTS_IO = (__force pci_bus_flags_t) 4,
 };

 /* These values come from the PCI Express Spec */

--047d7b160413abb2c0051c9a9376
Content-Type: text/x-patch; charset=US-ASCII; name="pci_root_bus_no_ioport.patch"
Content-Disposition: attachment; filename="pci_root_bus_no_ioport.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iczjb0xo0

U3ViamVjdDogW1BBVENIXSBQQ0k6IE9ubHkgdHJ5IHRvIGFzc2lnbiBpbyBwb3J0IG9ubHkgaWYg
cm9vdCBidXMgc3VwcG9ydCB0aGF0CgpUaGUgUENJIHN1YnN5c3RlbSBhbHdheXMgYXNzdW1lcyB0
aGF0IEkvTyBpcyBzdXBwb3J0ZWQgb24gcm9vdCBidXMgYW5kCnRyaWVzIHRvIGFzc2lnbiBhbiBJ
L08gd2luZG93IHRvIGVhY2ggY2hpbGQgYnVzIGV2ZW4gaWYgdGhhdCBpcyBub3QgdGhlCmNhc2Uu
CgpUaGlzIG1heSByZXN1bHQgaW4gbWVzc2FnZXMgc3VjaCBhczoKCiAgcGNpZXBvcnQgMDAwMDow
MjowMC4wOiByZXNbN109W2lvICAweDEwMDAtMHgwZmZmXSBnZXRfcmVzX2FkZF9zaXplIGFkZF9z
aXplIDEwMDAKICBwY2llcG9ydCAwMDAwOjAyOjAwLjA6IEJBUiA3OiBubyBzcGFjZSBmb3IgW2lv
ICBzaXplIDB4MTAwMF0KICBwY2llcG9ydCAwMDAwOjAyOjAwLjA6IEJBUiA3OiBmYWlsZWQgdG8g
YXNzaWduIFtpbyAgc2l6ZSAweDEwMDBdCgpmb3IgZWFjaCBicmlkZ2UgcG9ydCwgZXZlbiBpZiBy
b290IGRvZXMgbm90IHN1cHBvcnQgSS9PIGluIHRoZSBmaXJzdCBwbGFjZS4KClRvIGF2b2lkIHRo
aXMgbWVzc2FnZSwgY2hlY2sgaWYgcm9vdCBidXMgc3VwcG9ydHMgSS9PLCB0aGVuIGNoaWxkIGJ1
cwp3aWxsIGluaGVyaXQgdGhlIHNldHRpbmcgZnJvbSBwYXJlbnQgYnVzLCBhbmQgbGF0ZXIgZHVy
aW5nIHNpemluZyBhbmQKYXNzaWduaW5nLCBjaGVjayB0aGF0IGJ1cyBmbGFncyBhbmQgc2tpcCB0
aG9zZSByZXNvdXJjZXMuCgpbYmhlbGdhYXM6IHJldmVyc2Ugc2Vuc2Ugb2YgbmV3IHBjaV9idXNf
ZmxhZ3NfdCB2YWx1ZV0KW3lpbmdoYWk6IG9ubHkgY2hlY2sgcm9vdCBidXMgaW8gcG9ydCwgYW5k
IHVzZSBmbGFnIG9uIHNpemluZyBhbmQgYXNzaWduaW5nXQpDYzogR3VlbnRlciBSb2VjayA8bGlu
dXhAcm9lY2stdXMubmV0PgpDYzogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4K
Q0M6IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPgoKLS0tCiBk
cml2ZXJzL3BjaS9wcm9iZS5jICAgICB8ICAgIDUgKysrKysKIGRyaXZlcnMvcGNpL3NldHVwLWJ1
cy5jIHwgICAgNiArKysrKy0KIGluY2x1ZGUvbGludXgvcGNpLmggICAgIHwgICAgMSArCiAzIGZp
bGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCkluZGV4OiBsaW51
eC0yLjYvZHJpdmVycy9wY2kvcHJvYmUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9k
cml2ZXJzL3BjaS9wcm9iZS5jCisrKyBsaW51eC0yLjYvZHJpdmVycy9wY2kvcHJvYmUuYwpAQCAt
MzQwLDYgKzM0MCw5IEBAIHN0YXRpYyB2b2lkIHBjaV9yZWFkX2JyaWRnZV9pbyhzdHJ1Y3QgcGMK
IAlzdHJ1Y3QgcGNpX2J1c19yZWdpb24gcmVnaW9uOwogCXN0cnVjdCByZXNvdXJjZSAqcmVzOwog
CisJaWYgKCEoY2hpbGQtPmJ1c19mbGFncyAmIFBDSV9CVVNfRkxBR1NfUk9PVF9TVVBQT1JUU19J
TykpCisJCXJldHVybjsKKwogCWlvX21hc2sgPSBQQ0lfSU9fUkFOR0VfTUFTSzsKIAlpb19ncmFu
dWxhcml0eSA9IDB4MTAwMDsKIAlpZiAoZGV2LT5pb193aW5kb3dfMWspIHsKQEAgLTIwNzAsNiAr
MjA3Myw4IEBAIHN0cnVjdCBwY2lfYnVzICpwY2lfY3JlYXRlX3Jvb3RfYnVzKHN0cnUKIAkJfSBl
bHNlCiAJCQlidXNfYWRkclswXSA9ICdcMCc7CiAJCWRldl9pbmZvKCZiLT5kZXYsICJyb290IGJ1
cyByZXNvdXJjZSAlcFIlc1xuIiwgcmVzLCBidXNfYWRkcik7CisJCWlmIChyZXNvdXJjZV90eXBl
KHJlcykgPT0gSU9SRVNPVVJDRV9JTykKKwkJCWItPmJ1c19mbGFncyB8PSBQQ0lfQlVTX0ZMQUdT
X1JPT1RfU1VQUE9SVFNfSU87CiAJfQogCiAJZG93bl93cml0ZSgmcGNpX2J1c19zZW0pOwpJbmRl
eDogbGludXgtMi42L2RyaXZlcnMvcGNpL3NldHVwLWJ1cy5jCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4
LTIuNi5vcmlnL2RyaXZlcnMvcGNpL3NldHVwLWJ1cy5jCisrKyBsaW51eC0yLjYvZHJpdmVycy9w
Y2kvc2V0dXAtYnVzLmMKQEAgLTE1Niw2ICsxNTYsMTAgQEAgc3RhdGljIHZvaWQgcGRldl9zb3J0
X3Jlc291cmNlcyhzdHJ1Y3QgcAogCQlpZiAoci0+ZmxhZ3MgJiBJT1JFU09VUkNFX1BDSV9GSVhF
RCkKIAkJCWNvbnRpbnVlOwogCisJCWlmICgoci0+ZmxhZ3MgJiBJT1JFU09VUkNFX0lPKSAmJgor
CQkgICAgIShkZXYtPmJ1cy0+YnVzX2ZsYWdzICYgUENJX0JVU19GTEFHU19ST09UX1NVUFBPUlRT
X0lPKSkKKwkJCWNvbnRpbnVlOworCiAJCWlmICghKHItPmZsYWdzKSB8fCByLT5wYXJlbnQpCiAJ
CQljb250aW51ZTsKIApAQCAtOTA5LDcgKzkxMyw3IEBAIHN0YXRpYyB2b2lkIHBidXNfc2l6ZV9p
byhzdHJ1Y3QgcGNpX2J1cwogCXJlc291cmNlX3NpemVfdCBjaGlsZHJlbl9hZGRfc2l6ZSA9IDA7
CiAJcmVzb3VyY2Vfc2l6ZV90IG1pbl9hbGlnbiwgYWxpZ247CiAKLQlpZiAoIWJfcmVzKQorCWlm
ICghYl9yZXMgfHwgIShidXMtPmJ1c19mbGFncyAmIFBDSV9CVVNfRkxBR1NfUk9PVF9TVVBQT1JU
U19JTykpCiAJCXJldHVybjsKIAogCW1pbl9hbGlnbiA9IHdpbmRvd19hbGlnbm1lbnQoYnVzLCBJ
T1JFU09VUkNFX0lPKTsKSW5kZXg6IGxpbnV4LTIuNi9pbmNsdWRlL2xpbnV4L3BjaS5oCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2luY2x1ZGUvbGludXgvcGNpLmgKKysrIGxpbnV4LTIu
Ni9pbmNsdWRlL2xpbnV4L3BjaS5oCkBAIC0xOTMsNiArMTkzLDcgQEAgdHlwZWRlZiB1bnNpZ25l
ZCBzaG9ydCBfX2JpdHdpc2UgcGNpX2J1cwogZW51bSBwY2lfYnVzX2ZsYWdzIHsKIAlQQ0lfQlVT
X0ZMQUdTX05PX01TSSAgID0gKF9fZm9yY2UgcGNpX2J1c19mbGFnc190KSAxLAogCVBDSV9CVVNf
RkxBR1NfTk9fTU1SQkMgPSAoX19mb3JjZSBwY2lfYnVzX2ZsYWdzX3QpIDIsCisJUENJX0JVU19G
TEFHU19ST09UX1NVUFBPUlRTX0lPID0gKF9fZm9yY2UgcGNpX2J1c19mbGFnc190KSA0LAogfTsK
IAogLyogVGhlc2UgdmFsdWVzIGNvbWUgZnJvbSB0aGUgUENJIEV4cHJlc3MgU3BlYyAqLwo=
--047d7b160413abb2c0051c9a9376--
