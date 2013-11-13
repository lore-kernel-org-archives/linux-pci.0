Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:51385 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab3KMNJq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2013 08:09:46 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <qiudayu@linux.vnet.ibm.com>;
	Wed, 13 Nov 2013 18:39:42 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id D46FB125803F
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2013 18:40:27 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rADD9YAa47841326
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2013 18:39:35 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rADD9bWJ004634
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2013 18:39:38 +0530
Message-ID: <52837A10.3040301@linux.vnet.ibm.com>
Date: Wed, 13 Nov 2013 21:09:36 +0800
From: mike <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: ying.huang@intel.com
CC: bhelgaas@google.com, stern@rowland.harvard.edu,
	linux-pci@vger.kernel.org
Subject: A question about the patch: [PATCH] PCI/PM: Keep runtime PM enabled
 for unbound PCI devices
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Huang Ying,

I see you are the author of this patch, commit id is:
967577b062417b4e4b8e27b711220f4124f5153a

I have a question while I try to understand this patch,
So I would very grateful if you or others can give me some reply.....

............
-       rc = ddi->drv->probe(ddi->dev, ddi->id);
+       pm_runtime_get_sync(dev);
+       pci_dev->driver = pci_drv;
^^^^^^^^^^^^^^^^^^^^^^^^^^
I see here you make the driver to initialize before probe,
But I have no idea of why you do this change.....

and I look inside the code, it may be pm_runtime relate??

Thanks
Mike
+       rc = pci_drv->probe(pci_dev, ddi->id);
         if (rc) {
-               pm_runtime_disable(dev);
-               pm_runtime_set_suspended(dev);
-               pm_runtime_put_noidle(dev);
+               pci_dev->driver = NULL;
+               pm_runtime_put_sync(dev);
         }
-       if (parent)
-               pm_runtime_put(parent);
         return rc;
  }

@@ -330,10 +325,8 @@ __pci_device_probe(struct pci_driver *drv, struct 
pci_dev *pci_dev)
                 id = pci_match_device(drv, pci_dev);
                 if (id)
                         error = pci_call_probe(drv, pci_dev, id);
-               if (error >= 0) {
-                       pci_dev->driver = drv;
+               if (error >= 0)
                         error = 0;
-               }
         }
         return error;
  }
.......................

