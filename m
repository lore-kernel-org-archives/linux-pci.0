Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:42394 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab3JXGwx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Oct 2013 02:52:53 -0400
Received: by mail-la0-f41.google.com with SMTP id el20so1542995lab.28
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2013 23:52:52 -0700 (PDT)
MIME-Version: 1.0
From: Niilona <niilona@gmail.com>
Date: Thu, 24 Oct 2013 09:52:31 +0300
Message-ID: <CAE5WV7OXKGvOCTOyZyK5cOCA2nxpN1WcDdqj9h+pakyhgT2sTA@mail.gmail.com>
Subject: PATCH: pci-subsystem: ixgbe: SR-IOV: kernel way to order driver's
 virtfn -entries is odd causing libvirt failures.
To: linux-pci@vger.kernel.org, libvir-list <libvir-list@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi.

As Bjorn Helgaas recommend, this might be the item to discuss in the wider area.
-----------------------------------

There is a behavior effecting virtfn -entries in sysfs, when amount of
them increases over 10.
Run VM's through LIBVIRT -> QEMU/KVM, this causes :
- MAC address setting by LIBVIRT disordered ie. setting targeted to wrong VF.
- VLAN setting by LIBVIRT overall failed

Basics of this are in "/libvirt-x.x.x/src/util/virpci.c" ; in function below,
which don't order virtfn entries correctly.

/*
 * Returns virtual functions of a physical function
 */
int
virPCIGetVirtualFunctions(const char *sysfs_path,
                          virPCIDeviceAddressPtr **virtual_functions,
                          unsigned int *num_virtual_functions)
{

But I let you to decide which is best way to fix this, as if every
application reads "virtfn" entries from PF's directory, they all need
to sort entries in alphabet. order to avoid this
influence.
So personally I did get over this by adding pre-zeroes to names to
have them in sorted order in PF's directory.

----------------------------

Tested :
- kernel 3.8.0-21
- libvirt 1.0.2 & libvirt 1.1.3
- ixgbe 3.11.33-k, ixgbe 3.17-3 & ixgbe 3.18.7

After applying this MAC/VLAN seen to work and VM's get contacted using
MAC's & VLAN's, which been checked using tcpdump.

P.S. Tested with 3.8.0-21, but patch constructed against
"https://github.com/torvalds/linux.git", so there is possibilty this
works in latest kernel, but haven't checked it.
At least ordering scheme seen in "iov.c" in same form as before.

-----------------------------

>From fac886b86099dca1937730026da24c34857c4077 Mon Sep 17 00:00:00 2001
From: Niilo Minkkinen <niilo.minkkinen@tieto.com>
Date: Wed, 23 Oct 2013 14:50:07 +0300
Subject: [PATCH 1/1] Fixes ordering of virtfn -entries on drivers with more
 than 10 entries ( virtfn0...virtfn9 ).

This effects on drivers like Intel 82599 "ixgbe", which have max 31
VF's (Virtual Function) on
one PF (Physical Function).
Currently, ordering is "diffused", which in case causes MAC/VLAN
-settings on libvirt based
to PCI -addressing failed.

Signed-off-by: Niilo Minkkinen <niilo.minkkinen@tieto.com>
Signed-off-by: Tommy Varre <tommy.varre@tieto.com>
---
 drivers/pci/iov.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 21a7182..fbd1209 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -106,7 +106,7 @@ static int virtfn_add(struct pci_dev *dev, int id,
int reset)
        mutex_unlock(&iov->dev->sriov->lock);

        rc = pci_bus_add_device(virtfn);
-       sprintf(buf, "virtfn%u", id);
+       sprintf(buf, "virtfn%02u", id);
        rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
        if (rc)
                goto failed1;
@@ -149,7 +149,7 @@ static void virtfn_remove(struct pci_dev *dev, int
id, int reset)
                __pci_reset_function(virtfn);
        }

-       sprintf(buf, "virtfn%u", id);
+       sprintf(buf, "virtfn%02u", id);
        sysfs_remove_link(&dev->dev.kobj, buf);
        /*
         * pci_stop_dev() could have been called for this virtfn already,
-- 
1.8.1.2

-----------------------------

What you think ?

Niilo Minkkinen
niilo.minkkinen@tieto.com
