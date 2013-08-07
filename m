Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:44246 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089Ab3HGGee (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 02:34:34 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so3029666obc.27
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2013 23:34:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130807040112.GA14662@google.com>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
	<20130807040112.GA14662@google.com>
Date: Tue, 6 Aug 2013 23:34:33 -0700
Message-ID: <CAE9FiQVXhg299RKsoa8eCqoN7b9c0HaeTGHCnxQY=9vkSYaJJg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: Separate stop and remove devices in pciehp
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 6, 2013 at 9:01 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Kenji]
>
> On Sat, Jul 27, 2013 at 08:11:06AM -0700, Yinghai Lu wrote:
>> commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
>> (PCI: Simplify IOV implementation and fix reference count races)
>> broke the pcie native hotplug with SRIOV enabled: PF is not freed
>> during hot-remove, and later hot-add do not work as old pci_dev
>> is still around, and can not create new pci_dev.
>>
>> That commit need VFs to be removed via pci_disable_sriov/virtfn_remove
>> to make sure ref to PF is put back.
>
> Huh.  I wish we didn't have virtfn_remove() at all.  I wish the
> normal device removal path, i.e., pci_stop_and_remove_bus_device(),
> could deal with VFs directly.  I don't know all the history there,
> so maybe there's some reason that's not feasible.

I had one draft version, but looks more confusing.

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 21a7182..5f8d217 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -132,6 +132,24 @@ failed:
     return rc;
 }

+void virtfn_release(struct pci_dev *virtfn)
+{
+    struct pci_dev *dev;
+    struct pci_sriov *iov;
+    int locked;
+
+    if (!virtfn->is_virtfn)
+        return;
+
+    dev = virtfn->physfn;
+    iov = dev->sriov;
+    locked = mutex_trylock(&iov->dev->sriov->lock);
+    virtfn_remove_bus(dev->bus, virtfn->bus);
+    if (locked)
+        mutex_unlock(&iov->dev->sriov->lock);
+    pci_dev_put(dev);
+}
+
 static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 {
     char buf[VIRTFN_ID_LEN];
@@ -161,12 +179,10 @@ static void virtfn_remove(struct pci_dev *dev,
int id, int reset)

     mutex_lock(&iov->dev->sriov->lock);
     pci_stop_and_remove_bus_device(virtfn);
-    virtfn_remove_bus(dev->bus, virtfn->bus);
     mutex_unlock(&iov->dev->sriov->lock);

     /* balance pci_get_domain_bus_and_slot() */
     pci_dev_put(virtfn);
-    pci_dev_put(dev);
 }

 static int sriov_migration(struct pci_dev *dev)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8a00c06..1d78e95 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -262,6 +262,7 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno,
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
+void virtfn_release(struct pci_dev *dev);

 #else
 static inline int pci_iov_init(struct pci_dev *dev)
@@ -284,6 +285,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 {
     return 0;
 }
+void virtfn_release(struct pci_dev *dev)
+{
+}

 #endif /* CONFIG_PCI_IOV */

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 8fc54b7..46d9ec8 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -38,6 +38,8 @@ static void pci_destroy_dev(struct pci_dev *dev)
     list_del(&dev->bus_list);
     up_write(&pci_bus_sem);

+    virtfn_release(dev);
+
     pci_free_resources(dev);
     put_device(&dev->dev);
 }


>> +     }
>> +
>> +     list_for_each_entry_safe(dev, temp, &parent->devices, bus_list) {
>> +             pci_dev_get(dev);
>> +             pci_remove_bus_device(dev);
>>               pci_dev_put(dev);
>
> I don't see the point of the pci_dev_get()/pci_dev_put() here.  It
> doesn't do anything useful, does it?
>
> The pci_dev_get() doesn't help: it will keep a racing path from
> removing the dev *after* we call pci_dev_get(), but that racing path
> could just as easily remove the dev *before* we call pci_dev_get().
>
> And there's no reason to hold onto a reference after we call
> pci_remove_bus_device(), because we don't do anything else with the
> device before we call pci_dev_put().

should be ok, just like remove one device from /sys.
device_schedule will keep the last one ref and be put back
after the put from pci_destroy_dev.

Yinghai
