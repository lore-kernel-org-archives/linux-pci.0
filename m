Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36564 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752671AbdBGHMh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2017 02:12:37 -0500
Date: Tue, 7 Feb 2017 10:12:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: jakeo@microsoft.com
Cc: devel@linuxdriverproject.org, linux-pci@vger.kernel.org
Subject: [bug report] PCI: hv: Add paravirtual PCI front-end for Microsoft
 Hyper-V VMs
Message-ID: <20170207071219.GA15335@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[ No idea why I haven never sent this email before.  I was just going
  through all the use after free warnings again today and noticed it. ]

Hello Jake Oshins,

The patch 4daace0d8ce8: "PCI: hv: Add paravirtual PCI front-end for
Microsoft Hyper-V VMs" from Feb 16, 2016, leads to the following
static checker warning:

	drivers/pci/host/pci-hyperv.c:1441 pci_devices_present_work()
	error: dereferencing freed memory 'dr'

drivers/pci/host/pci-hyperv.c
  1410          /* Pull this off the queue and process it if it was the last one. */
  1411          spin_lock_irqsave(&hbus->device_list_lock, flags);
  1412          while (!list_empty(&hbus->dr_list)) {
  1413                  dr = list_first_entry(&hbus->dr_list, struct hv_dr_state,
  1414                                        list_entry);
  1415                  list_del(&dr->list_entry);
  1416  
  1417                  /* Throw this away if the list still has stuff in it. */
  1418                  if (!list_empty(&hbus->dr_list)) {
  1419                          kfree(dr);
                                ^^^^^^^^^
We free "dr".  Presumably we should set dr = NULL here?

  1420                          continue;
  1421                  }
  1422          }
  1423          spin_unlock_irqrestore(&hbus->device_list_lock, flags);
  1424  
  1425          if (!dr) {
  1426                  up(&hbus->enum_sem);
  1427                  put_hvpcibus(hbus);
  1428                  return;
  1429          }
  1430  
  1431          /* First, mark all existing children as reported missing. */
  1432          spin_lock_irqsave(&hbus->device_list_lock, flags);
  1433          list_for_each(iter, &hbus->children) {
  1434                          hpdev = container_of(iter, struct hv_pci_dev,
  1435                                               list_entry);
  1436                          hpdev->reported_missing = true;
  1437          }
  1438          spin_unlock_irqrestore(&hbus->device_list_lock, flags);
  1439  
  1440          /* Next, add back any reported devices. */
  1441          for (child_no = 0; child_no < dr->device_count; child_no++) {
                                              ^^^^^^^^^^^^^^^^
Use after free.

  1442                  found = false;
  1443                  new_desc = &dr->func[child_no];
  1444  
  1445                  spin_lock_irqsave(&hbus->device_list_lock, flags);


regards,
dan carpenter
