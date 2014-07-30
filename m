Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:47015 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbaG3T7f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jul 2014 15:59:35 -0400
Received: by mail-ie0-f169.google.com with SMTP id rd18so2255683iec.14
        for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2014 12:59:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1406707207-13152-1-git-send-email-yan@linux.vnet.ibm.com>
References: <1406707207-13152-1-git-send-email-yan@linux.vnet.ibm.com>
Date: Wed, 30 Jul 2014 12:59:35 -0700
Message-ID: <CAE9FiQVkGcqFQ7e22Ekg7t-gWrQ9FdtadbVCASTGqU20FPE50g@mail.gmail.com>
Subject: Re: [PATCH] PCI: Reset failed bridge resources in PCI realloc
From: Yinghai Lu <yinghai@kernel.org>
To: Guo Chao <yan@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: multipart/mixed; boundary=047d7b10d13166554c04ff6e980f
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--047d7b10d13166554c04ff6e980f
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 30, 2014 at 1:00 AM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
>         * However, in pbus_size_mem() we call calculate_memsize() to
>           calculate the final size. calculate_memsize() never shrinks
>           window, i.e. if old size is larger than newly sized result,
>           old size will be honored. Unfortunately, the old size at this
>           time is the sum of both normal BARs and SR-IOV BARs when doing
>           realloc.
>

that checking about old_size is added by:

| commit d65245c3297ac63abc51a976d92f45f2195d2854
| Author: Yinghai Lu <yinghai@kernel.org>
| Date:   Fri Jan 22 01:02:23 2010 -0800
|
|    PCI: don't shrink bridge resources
|
|    When clearing leaf bridge resources, trying to get a big enough one, we
|    could shrink the bridge if there is no resource under it.  Confirm
|    against the old resource side to make sure we're increasing the
|    allocation.

so to make both cases ok, may need to check if there is any children devices
on the dev->subordinate. Please check attached.

Thanks

Yinghai


---
 drivers/pci/setup-bus.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-bus.c
+++ linux-2.6/drivers/pci/setup-bus.c
@@ -1622,8 +1622,11 @@ again:
         res->start = fail_res->start;
         res->end = fail_res->end;
         res->flags = fail_res->flags;
-        if (fail_res->dev->subordinate)
+        if (fail_res->dev->subordinate) {
             res->flags = 0;
+            if (!list_empty(&fail_res->dev->subordinate->devices))
+                res->start = res->end = 0;
+        }
     }
     free_list(&fail_head);

@@ -1688,8 +1691,11 @@ again:
         res->start = fail_res->start;
         res->end = fail_res->end;
         res->flags = fail_res->flags;
-        if (fail_res->dev->subordinate)
+        if (fail_res->dev->subordinate) {
             res->flags = 0;
+            if (!list_empty(&fail_res->dev->subordinate->devices))
+                res->start = res->end = 0;
+        }
     }
     free_list(&fail_head);

--047d7b10d13166554c04ff6e980f
Content-Type: text/x-patch; charset=US-ASCII; name="shrink_realloc_bridge_resource.patch"
Content-Disposition: attachment;
	filename="shrink_realloc_bridge_resource.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hy92s5jo0

LS0tCiBkcml2ZXJzL3BjaS9zZXR1cC1idXMuYyB8ICAgMTAgKysrKysrKystLQogMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCkluZGV4OiBsaW51eC0yLjYv
ZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJp
dmVycy9wY2kvc2V0dXAtYnVzLmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9zZXR1cC1idXMu
YwpAQCAtMTYyMiw4ICsxNjIyLDExIEBAIGFnYWluOgogCQlyZXMtPnN0YXJ0ID0gZmFpbF9yZXMt
PnN0YXJ0OwogCQlyZXMtPmVuZCA9IGZhaWxfcmVzLT5lbmQ7CiAJCXJlcy0+ZmxhZ3MgPSBmYWls
X3Jlcy0+ZmxhZ3M7Ci0JCWlmIChmYWlsX3Jlcy0+ZGV2LT5zdWJvcmRpbmF0ZSkKKwkJaWYgKGZh
aWxfcmVzLT5kZXYtPnN1Ym9yZGluYXRlKSB7CiAJCQlyZXMtPmZsYWdzID0gMDsKKwkJCWlmICgh
bGlzdF9lbXB0eSgmZmFpbF9yZXMtPmRldi0+c3Vib3JkaW5hdGUtPmRldmljZXMpKQorCQkJCXJl
cy0+c3RhcnQgPSByZXMtPmVuZCA9IDA7CisJCX0KIAl9CiAJZnJlZV9saXN0KCZmYWlsX2hlYWQp
OwogCkBAIC0xNjg4LDggKzE2OTEsMTEgQEAgYWdhaW46CiAJCXJlcy0+c3RhcnQgPSBmYWlsX3Jl
cy0+c3RhcnQ7CiAJCXJlcy0+ZW5kID0gZmFpbF9yZXMtPmVuZDsKIAkJcmVzLT5mbGFncyA9IGZh
aWxfcmVzLT5mbGFnczsKLQkJaWYgKGZhaWxfcmVzLT5kZXYtPnN1Ym9yZGluYXRlKQorCQlpZiAo
ZmFpbF9yZXMtPmRldi0+c3Vib3JkaW5hdGUpIHsKIAkJCXJlcy0+ZmxhZ3MgPSAwOworCQkJaWYg
KCFsaXN0X2VtcHR5KCZmYWlsX3Jlcy0+ZGV2LT5zdWJvcmRpbmF0ZS0+ZGV2aWNlcykpCisJCQkJ
cmVzLT5zdGFydCA9IHJlcy0+ZW5kID0gMDsKKwkJfQogCX0KIAlmcmVlX2xpc3QoJmZhaWxfaGVh
ZCk7CiAK
--047d7b10d13166554c04ff6e980f--
