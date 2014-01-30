Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:51047 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbaA3Q4G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 11:56:06 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp4so3774995obc.16
        for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2014 08:56:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWDqXNF5Cn5X_muBERMWdZsZFbzmoqWvuPARREz+XO9Gw@mail.gmail.com>
References: <20140130131236.GW18029@intel.com>
	<CAE9FiQWDqXNF5Cn5X_muBERMWdZsZFbzmoqWvuPARREz+XO9Gw@mail.gmail.com>
Date: Thu, 30 Jan 2014 08:56:05 -0800
Message-ID: <CAE9FiQUaof1tk151Wbu2OtpTYb+pvP16ZhLsmbn6LDdBqoVEgA@mail.gmail.com>
Subject: Re: Commit ef83b0781a73f (PCI: Remove from bus_list and release
 resources in pci_release_dev()) broke TBT hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: multipart/mixed; boundary=047d7b5d2ea4eb937804f132eedf
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--047d7b5d2ea4eb937804f132eedf
Content-Type: text/plain; charset=ISO-8859-1

>> The latest mainline kernel "hangs" when Thunderbolt devices are
>> hot-unplugged to the system. I can't see any oops but after hot-unplug I'm
>> getting huge amounts of messages like:
>>
>> [  352.717001] pci 0000:02:00.0: PME# disabled
>> [  352.717011] pci 0000:02:00.0: PME# disabled
>> [  352.717021] pci 0000:02:00.0: PME# disabled
>> [  352.717032] pci 0000:02:00.0: PME# disabled
>> [  352.717041] pci 0000:02:00.0: PME# disabled
>> [  352.717051] pci 0000:02:00.0: PME# disabled
>> [  352.717061] pci 0000:02:00.0: PME# disabled
>> [  352.717070] pci 0000:02:00.0: PME# disabled
>> [  352.717083] pci 0000:02:00.0: PME# disabled
>> [  352.717094] pci 0000:02:00.0: PME# disabled
>> [  352.717104] pci 0000:02:00.0: PME# disabled
>> [  352.717113] pci 0000:02:00.0: PME# disabled
>> [  352.717124] pci 0000:02:00.0: PME# disabled
>> [  352.717133] pci 0000:02:00.0: PME# disabled
>> [  352.717143] pci 0000:02:00.0: PME# disabled
>> [  352.717153] pci 0000:02:00.0: PME# disabled
>> [  352.717162] pci 0000:02:00.0: PME# disabled
>
> that mean pci_stop_dev() get called again and again ?

please check if attached patch could help.

it should prevent possible reattaching driver.

---
 drivers/pci/remove.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/pci/remove.c
===================================================================
--- linux-2.6.orig/drivers/pci/remove.c
+++ linux-2.6/drivers/pci/remove.c
@@ -11,6 +11,7 @@ static void pci_stop_dev(struct pci_dev
         pci_proc_detach_device(dev);
         pci_remove_sysfs_dev_files(dev);
         device_release_driver(&dev->dev);
+        dev->match_driver = false;
         dev->is_added = 0;
     }

--047d7b5d2ea4eb937804f132eedf
Content-Type: text/x-patch; charset=US-ASCII; name="not_allow_attach_driver.patch"
Content-Disposition: attachment; filename="not_allow_attach_driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hr29ldel0

LS0tCiBkcml2ZXJzL3BjaS9yZW1vdmUuYyB8ICAgIDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspCgpJbmRleDogbGludXgtMi42L2RyaXZlcnMvcGNpL3JlbW92ZS5jCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2RyaXZlcnMvcGNpL3JlbW92ZS5jCisrKyBsaW51eC0yLjYv
ZHJpdmVycy9wY2kvcmVtb3ZlLmMKQEAgLTExLDYgKzExLDcgQEAgc3RhdGljIHZvaWQgcGNpX3N0
b3BfZGV2KHN0cnVjdCBwY2lfZGV2CiAJCXBjaV9wcm9jX2RldGFjaF9kZXZpY2UoZGV2KTsKIAkJ
cGNpX3JlbW92ZV9zeXNmc19kZXZfZmlsZXMoZGV2KTsKIAkJZGV2aWNlX3JlbGVhc2VfZHJpdmVy
KCZkZXYtPmRldik7CisJCWRldi0+bWF0Y2hfZHJpdmVyID0gZmFsc2U7CiAJCWRldi0+aXNfYWRk
ZWQgPSAwOwogCX0KIAo=
--047d7b5d2ea4eb937804f132eedf--
