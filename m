Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
Date: Tue, 03 Jul 2018 16:22:25 +0530
From: poza@codeaurora.org
To: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <20180703083447.GA2689@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
Message-ID: <324f8cf2fe6f7bdc43ca8a646eea908d@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci-owner@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-07-03 14:04, Lukas Wunner wrote:
> On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
>> If a bridge supports hotplug and observes a PCIe fatal error, the 
>> following
>> events happen:
>> 
>> 1. AER driver removes the devices from PCI tree on fatal error
>> 2. AER driver brings down the link by issuing a secondary bus reset 
>> waits
>> for the link to come up.
>> 3. Hotplug driver observes a link down interrupt
>> 4. Hotplug driver tries to remove the devices waiting for the rescan 
>> lock
>> but devices are already removed by the AER driver and AER driver is 
>> waiting
>> for the link to come back up.
>> 5. AER driver tries to re-enumerate devices after polling for the link
>> state to go up.
>> 6. Hotplug driver obtains the lock and tries to remove the devices 
>> again.
>> 
>> If a bridge is a hotplug capable bridge, mask hotplug interrupts 
>> before the
>> reset and unmask afterwards.
> 
> Would it work for you if you just amended the AER driver to skip
> removal and re-enumeration of devices if the port is a hotplug bridge?
> Just check for is_hotplug_bridge in struct pci_dev.
> 

I tend to agree with you Lukas.

on this line I already have follow up patches
although I am waiting for Bjorn to review some patch-series before that.
[PATCH v2 0/6] Fix issues and cleanup for ERR_FATAL and ERR_NONFATAL

It doesn't look to me a an entirely a race condition since its guarded 
by pci_lock_rescan_remove())
I observed that both hotplug and aer/dpc comes out of it in a quiet sane 
state.

My thinking is: Disabling hotplug interrupts during ERR_FATAL,
is something little away from natural course of link_down event 
handling, which is handled by pciehp more maturely.
so it would be just easy not to take any action e.g. removal and 
re-enumeration of devices from ERR_FATAL handling point of view.

I leave it to Bjorn.

follwing is the patch wich I am trying to set it right and under test.
so till now I am in an opinion to handle this by checking in err.c

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 410c35c..607a234 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -292,15 +292,17 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, 
u32 service)

         parent = udev->subordinate;
         pci_lock_rescan_remove();
-       list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
-                                        bus_list) {
-               pci_dev_get(pdev);
-               pci_dev_set_disconnected(pdev, NULL);
-               if (pci_has_subordinate(pdev))
-                       pci_walk_bus(pdev->subordinate,
-                                    pci_dev_set_disconnected, NULL);
-               pci_stop_and_remove_bus_device(pdev);
-               pci_dev_put(pdev);
+       if (!udev->is_hotplug_bridge) {
+               list_for_each_entry_safe_reverse(pdev, temp, 
&parent->devices,
+                                                bus_list) {
+                       pci_dev_get(pdev);
+                       pci_dev_set_disconnected(pdev, NULL);
+                       if (pci_has_subordinate(pdev))
+                               pci_walk_bus(pdev->subordinate,
+                                            pci_dev_set_disconnected, 
NULL);
+                       pci_stop_and_remove_bus_device(pdev);
+                       pci_dev_put(pdev);
+               }
         }

         result = reset_link(udev, service);
@@ -318,7 +320,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 
service)
         }

         if (result == PCI_ERS_RESULT_RECOVERED) {
-               if (pcie_wait_for_link(udev, true))
+               if (pcie_wait_for_link(udev, true) && 
!udev->is_hotplug_bridge)
                         pci_rescan_bus(udev->bus);
                 pci_info(dev, "Device recovery from fatal error 
successful\n");
                 dev->error_state = pci_channel_io_normal;


> That would seem like a much simpler solution, given that it is known
> that the link will flap on reset, causing the hotplug driver to remove
> and re-enumerate devices.  That would also cover cases where hotplug is
> handled by a different driver than pciehp, or by the platform firmware.
> 
> Thanks,
> 
> Lukas











_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
