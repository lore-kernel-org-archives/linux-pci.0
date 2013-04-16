Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:5416 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab3DPIwA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2013 04:52:00 -0400
Message-ID: <516D110F.5060800@huawei.com>
Date: Tue, 16 Apr 2013 16:51:27 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Shengzhou Liu <Shengzhou.Liu@freescale.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -v2 1/2] PCI: decrease pci_dev->enable_cnt when no pcie
 capability found
References: <1366009135-19088-1-git-send-email-wangyijing@huawei.com> <CAErSpo7dgFR8a7Wee4CE7Rj+nZg_-+8uNOFq__d8EzY+gHQHGQ@mail.gmail.com>
In-Reply-To: <CAErSpo7dgFR8a7Wee4CE7Rj+nZg_-+8uNOFq__d8EzY+gHQHGQ@mail.gmail.com>
Content-Type: multipart/mixed;
	boundary="------------060505040902090709040602"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--------------060505040902090709040602
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index 31063ac..aef3fac 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -369,8 +369,8 @@ int pcie_port_device_register(struct pci_dev *dev)
>>
>>         /* Get and check PCI Express port services */
>>         capabilities = get_port_device_capability(dev);
>> -       if (!capabilities)
>> -               return 0;
>> +       if (!capabilities)
>> +               goto error_disable;
>>
>>         pci_set_master(dev);
>>         /*
> 
> Does this fix a problem you observed?  If so, please refer to it in
> your changelog.

Hi Bjorn,
   I found this problem when I try to fix the problem described in
[PATCH 2/2] PCI/IA64: fix pci_dev->enable_cnt balance when doing pci hotplug.

> 
> I think this patch is incorrect because pcie_portdrv_probe() will
> return 0 (success) with the device disabled.  When we call
> pcie_portdrv_remove(), we will attempt to disable the device again,
> even though it's already disabled.

Hmm, that's a problem, the driver will disable pcie port device twice regardless
any pcie capabilities found in the pcie port. There is another problem here.

enable pci bridge device:
1. first call pci_enable_bridges() after pci device resource assignment.
2. second call pci_enable_device() in pcie_port_device_register() in pcie port driver .probe.
above enable path, fist is in pci level, and second in pcie level.

disable pci bridge device:
1. first call pci_disable_device() in pcie_port_device_remove().
2. second call pci_disable_device() in pcie_portdrv_remove().

above disable path, first and second disable action are both in pcie level.

I think the enable and disable actions are not symmetric.

So it will cause another problem like this:
If we unbind a pcie port device driver, the pcie port device will be disabled by the pcie port driver.
the busMaster and irq.. will be disabled. So if there are some child devices under this port, this devices
maybe encounter problems during running, in my ia64, the child device network cannot transmit data anymore.

-+-[0000:40]-+-00.0-[0000:41]--
 |           +-01.0-[0000:42]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
 |           |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection
 |           +-03.0-[0000:43]----00.0  LSI Logic / Symbios Logic SAS1064ET PCI-Express Fusion-MPT SAS

linux-ha2:~ # lspci -vvv -s 0000:40:01.0 > before_unbind.log
linux-ha2:~ # cd /sys/bus/pci/devices/0000\:40\:01.0/driver/
linux-ha2:/sys/bus/pci/devices/0000:40:01.0/driver # ls
0000:00:01.0  0000:00:04.0  0000:00:07.0  0000:00:1c.1  0000:00:1c.3  0000:00:1c.5  0000:40:01.0  0000:40:04.0  0000:40:07.0  new_id     uevent
0000:00:03.0  0000:00:05.0  0000:00:1c.0  0000:00:1c.2  0000:00:1c.4  0000:40:00.0  0000:40:03.0  0000:40:05.0  bind          remove_id  unbind
linux-ha2:/sys/bus/pci/devices/0000:40:01.0/driver # echo "0000:40:01.0" > unbind
linux-ha2:/sys/bus/pci/devices/0000:40:01.0/driver # cd
linux-ha2:~ # lspci -vvv -s 0000:40:01.0 > after_unbind.log
linux-ha2:~ # diff before_unbind.log after_unbind.log
2c2
< 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
---
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
4d3
< 	Latency: 0, Cache Line Size: 64 bytes
13c12
< 	Capabilities: [60] Message Signalled Interrupts: Mask+ 64bit- Count=1/2 Enable+
---
> 	Capabilities: [60] Message Signalled Interrupts: Mask+ 64bit- Count=1/2 Enable-
15c14
< 		Masking: 00000002  Pending: 00000000
---
> 		Masking: 00000000  Pending: 00000000
19c18
< 		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
---
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
34c33
< 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
---
> 		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
57d55
< 	Kernel driver in use: pcieport

I prefer to move the second pci_disable_device() into driver/pci/remove.c. Disable pci bridge
during stopping the pci bridge. So we enable and disable the pcie port device symmetrically.

I tested the following attached patch, and result is ok.


Thanks!
Yijing.



> 
> I don't know whether it is desirable for pcie_portdrv_probe() to
> succeed when no capabilities are available or not.  Maybe somebody
> else has an opinion.
> 







-- 
Thanks!
Yijing

--------------060505040902090709040602
Content-Type: text/x-patch;
	name="0001-PCI-move-second-pci_disable_device-into-pci_stop_bus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-PCI-move-second-pci_disable_device-into-pci_stop_bus.pa";
	filename*1="tch"

>From 44914e0e39dbe51e1a932492d6b4909d5967308e Mon Sep 17 00:00:00 2001
From: Yijing Wang <wangyijing@huawei.com>
Date: Tue, 16 Apr 2013 11:41:47 +0800
Subject: [PATCH] PCI: move second pci_disable_device into pci_stop_bus_device() for symmetry

Currently, we enable and disable pcie port device is not symmetrical. If
we unbind the pcie port driver for pcie port device, we will call pci_disable_device()
twice. Then the pcie port device is disabled, if there are some child devices
under it, the child device maybe cannot transmit data anymore. This patch move the
second pci_disable_device() int pci_stop_bus_device() to avoid this bug.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/portdrv_pci.c |    1 -
 drivers/pci/remove.c           |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index ed4d094..2ca1a0b 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -223,7 +223,6 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
 	pcie_port_device_remove(dev);
-	pci_disable_device(dev);
 }
 
 static int error_detected_iter(struct device *device, void *data)
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index cc875e6..e8f7c3c 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -73,6 +73,7 @@ static void pci_stop_bus_device(struct pci_dev *dev)
 		list_for_each_entry_safe_reverse(child, tmp,
 						 &bus->devices, bus_list)
 			pci_stop_bus_device(child);
+			pci_disable_device(dev);
 	}
 
 	pci_stop_dev(dev);
-- 
1.7.1


--------------060505040902090709040602--
