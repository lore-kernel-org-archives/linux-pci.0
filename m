Received: from mail-m15592.qiye.163.com (mail-m15592.qiye.163.com [101.71.155.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BCE2F8EB7;
	Wed,  3 Jun 2026 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481315; cv=none; b=JAIaqVsgfmq19jkebMLErw3bqquoV3VTToONn1SaziBavThIGnQCI52yexlEGxskl+Iov+wAWIVtibCqH+ckz7/Z0J1pTiTX+Skpa7DWSLcZmIKY4Ig9SSo822KHQGRX0wcY6ujRkCQArDUtGHsAicfG+PyiuW8nltwHP8WbFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481315; c=relaxed/simple;
	bh=GyaVHVL/iz4PPi41VlPcKjNZt4nMvAXrfzi0hqA3MNk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TdZm7l1/VqOs/8gVUxJZj9quSSajoWLrvqiD7vcxoer87k1ro2NlVTlvafBEp5dkZuewwWBjyZzrpQQln6nWMk/XCUDWqS7PbdqlTAL5mhpxYwGkuaLoxGWT0NVEotvekkxHpNRjDjEG/nbR5X+7j4rL6yqAcBT6js/TW1/iN0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=101.71.155.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [172.23.72.187] (unknown [43.247.70.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40e90ae79;
	Wed, 3 Jun 2026 17:32:57 +0800 (GMT+08:00)
Message-ID: <96e8ff0e-b538-42d5-a328-96515fc3fa9e@sangfor.com.cn>
Date: Wed, 3 Jun 2026 17:32:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?B?5LiB6L6J?= <dinghui@sangfor.com.cn>,
 zhengyingying@sangfor.com.cn
From: Yingying Zheng <zhengyingying@sangfor.com.cn>
Subject: [RFC PATCH] PCI: readiness condition with Configuration RRS in
 pci_dev_wait()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e8cd4329e09d5kunm281298023ea5b8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEhNVk1LQ0xPQx1KGEhPSVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlPSFVJT0xVTEtVQ0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++

We are seeing reproducible AER/DPC fatal errors during VM boot when passing
through one or more NVIDIA RTX 4090 GPUs via VFIO. The issue is triggered
during QEMU device initialization, before the guest starts running, when
QEMU issues the VFIO_DEVICE_PCI_HOT_RESET ioctl. After this hot reset,
the subsequent PCI config restore may happen before the GPU is fully
re-initialized, which correlates with the AER/DPC fatal errors.

Kernel: based on Linux 6.6 stable

Call chain (simplified):
ioctl(..., VFIO_DEVICE_PCI_HOT_RESET, ...)         (QEMU)
      vfio_pci_core_ioctl                            (kernel)
          vfio_pci_ioctl_pci_hot_reset
              vfio_pci_ioctl_pci_hot_reset_groups
                  vfio_pci_dev_set_hot_reset
                      pci_reset_bus
                          __pci_reset_bus
                              pci_bridge_secondary_bus_reset

Hardware (example BDFs):
Root Port: 0000:b7:01.0 PCI bridge [0604]: Intel Corporation PCI Express Gen5 Port A [8086:352a]
PCIe switch: 0000:b9:00.0 PCI bridge [0604]: Broadcom / LSI PEX890xx PCIe Gen 5 Switch [1000:c030]
GPU: 0000:ba:00.0 VGA compatible controller [0300]: NVIDIA Corporation AD102 [GeForce RTX 4090] [10de:2684]
           0000:ba:00.1 Audio device [0403]: NVIDIA Corporation AD102 High Definition Audio Controller [10de:22ba]

The GPU functions 0000:ba:00.0 and 0000:ba:00.1 are bound to vfio-pci on
the host and assigned to the guest. The GPU is connected to the Root Port
through the Broadcom/LSI PCIe switch.

Topology (lspci -vtnn excerpt):
+-[0000:b7]-+-...
  |           \-01.0-[b8-bb]----00.0-[b9-bb]--+-00.0-[ba]--+-00.0 NVIDIA Corporation AD102 [GeForce RTX 4090] [10de:2684]
  |                                           |            \-00.1 NVIDIA Corporation AD102 High Definition Audio Controller [10de:22ba]
  |                                           \-01.0-[bb]--+-00.0 NVIDIA Corporation AD102 [GeForce RTX 4090] [10de:2684]
  |                                                        \-00.1 NVIDIA Corporation AD102 High Definition Audio Controller [10de:22ba]
  ...
  +-[0000:97]-+-...
  |           \-01.0-[98-9d]----00.0-[99-9d]--+-00.0-[9a]--+-00.0 NVIDIA Corporation AD102 [GeForce RTX 4090] [10de:2684]
  |                                           |            \-00.1 NVIDIA Corporation AD102 High Definition Audio Controller [10de:22ba]
  |                                           +-01.0-[9b]--+-00.0 NVIDIA Corporation AD102 [GeForce RTX 4090] [10de:2684]
  |                                           |            \-00.1 NVIDIA Corporation AD102 High Definition Audio Controller [10de:22ba]
  |                                           +-02.0-[9c]----00.0 Broadcom / LSI Virtual PCIe Placeholder Endpoint [1000:02b2]
  |                                           \-1f.0-[9d]----00.0 Broadcom / LSI PCIe Switch management endpoint [1000:00b2]

During VM power-on, the host logs show a DPC containment event and an AER fatal
Transaction Layer error on the upstream Root Port:
pcieport 0000:b7:01.0: DPC: containment event, status:0x1f01 source:0x0000
pcieport 0000:b7:01.0: DPC: unmasked uncorrectable error detected
pcieport 0000:b7:01.0: PCIe Bus Error: severity=Uncorrected (Fatal),
                                       type=Transaction Layer, (Receiver ID)
pcieport 0000:b7:01.0: device [8086:352a] error status/mask=00040000/00180020
pcieport 0000:b7:01.0: [18] MalfTLP (First)
pcieport 0000:b7:01.0: AER: TLP Header: 60701001 ba00000f 00000001 2e45f000

On the upstream port, the Virtual Channel capability indicates only TC0
is mapped to VC0, e.g.:
Capabilities: [280 v1] Virtual Channel
                      VC0 ... Ctrl: ... TC/VC=01
                      VC1 ... Ctrl: ... TC/VC=00
However, on the NVIDIA GPU function (e.g. 0000:ba:00.0), after a reset
the GPU's Virtual Channel resource control (TC/VC mapping) is observed
to change from the expected 01 to ff:

Before VM power-on:
ba:00.0 VGA compatible controller [0300]: NVIDIA Corporation AD102 [GeForce RTX 4090] [10de:2684] (rev a1) (prog-if 00 [VGA controller])
     Subsystem: Gigabyte Technology Co., Ltd Device [1458:40de]
     ...
     Capabilities: [100 v1] Virtual Channel
         ...
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status: NegoPending- InProgress-

After VM power-on:
ba:00.0 VGA compatible controller [0300]: NVIDIA Corporation AD102 [GeForce RTX 4090] [10de:2684] (rev a1) (prog-if 00 [VGA controller])
     Subsystem: Gigabyte Technology Co., Ltd Device [1458:40de]
     ...
     Capabilities: [100 v1] Virtual Channel
         ...
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-

With TC/VC=ff , the GPU may emit transactions with non-TC0 traffic
class encoding, and those TLPs are then treated as Malformed TLP by
the upstream port (which only expects TC0->VC0), triggering the AER
fatal error above.

We are running a Linux 6.6 stable kernel. After comparing behavior
with older kernels, we traced the regression to commit ac91e6980563
("PCI: Unify delay handling for reset and resume").

The key behavioral change is that pci_reset_secondary_bus() no longer
includes the previous 1-second delay after deasserting secondary bus reset.

On our system, after the GPU is reset, the GPU hardware temporarily ends
up with an unexpected Virtual Channel mapping (e.g. VC0 resource control
TC/VC=ff ). The VC state had been saved before reset via pci_save_vc_state() ,
but during the restore path pci_restore_vc_state() does not restore the
VC configuration because pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VC)
returns 0 at that moment, which means the VC extended capability is not
accessible yet. As a result, the saved VC state is not restored and the
device continues operating with the incorrect mapping, which later triggers
AER on the upstream port.

As a workaround, reintroducing a 1-second delay after pci_reset_secondary_bus()
makes the issue go away on our system.

We then found commit d591f6804e7e ("PCI: Wait for device readiness with
Configuration RRS").

This looks like the proper direction: when the upstream Root Port enables
Configuration RRS Software Visibility, software can detect Configuration
RRS responses by reading Vendor ID and observing the reserved 0x0001 value,
so pci_dev_wait() can perform correct exponential backoff until the device
is actually ready for config accesses.

On our system, the upstream Root Port does report CRSVisible enabled, e.g. (excerpt):

b7:01.0 PCI bridge [0604]: Intel Corporation PCI Express Gen5 Port A [8086:352a] (rev 04) (prog-if 00 [Normal decode])
     ...
     Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
         ...
         RootCap: CRSVisible+
         RootCtl: ErrCorrectable- ErrNon-Fatal+ ErrFatal+ PMEIntEna+ CRSVisible+

However, with some PCIe switches (in our case Broadcom/LSI PEX890xx PCIe
Gen5 switch), when the downstream device is in reset or link training is
not completed, the switch exposes a Virtual PCIe Placeholder Endpoint on
the downstream side. During this window, reads to the GPU BDF Vendor ID
return the placeholder endpoint Vendor/Device ID (Broadcom/LSI) instead
of the expected 0x0001 RRS-visible value.

Based on this behavior, we have a candidate change for discussion: only
treat the device as ready once reads of PCI_VENDOR_ID appear to be coming
from the actual endpoint, i.e. the returned Vendor/Device ID matches the
dev->vendor/dev->device recorded at enumeration time.

If we keep reading PCI_VENDOR_ID from 0000:ba:00.0 over time, we observe
the following:

t+  0ms: 1000:02b2
t+ 16ms: 1000:02b2
t+ 28ms: 1000:02b2
t+ 40ms: 1000:02b2
t+ 56ms: 1000:02b2
t+120ms: 10de:2684

In our case, this would effectively wait until the PCI_VENDOR_ID read
transitions from 1000:02b2 to 10de:2684 (around t+120ms in the sequence
above), instead of returning immediately at t+0ms.

We are not sure about potential side effects of making pci_dev_wait()
more strict (e.g. for SR-IOV VFs or other devices/platforms), so we
would appreciate feedback on whether this approach is acceptable and
whether it should be handled generically or via a quirk.

We can provide more details (full topology, exact reset trigger path
in VFIO/QEMU, kernel logs, and config diffs before or after reset)
if that would help.

Appreciate any comment and suggestion, thanks.

Signed-off-by: Yingying Zheng <zhengyingying@sangfor.com.cn>
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
  drivers/pci/pci.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b98e04865..1e6d8a84a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1219,7 +1219,9 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
  
          if (root && root->config_crs_sv) {
              pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
-            if (!pci_bus_crs_vendor_id(id))
+            if (!pci_bus_crs_vendor_id(id) &&
+                (id & 0xffff) == dev->vendor &&
+                (id >> 16) == dev->device)
                  break;
          } else {
              pci_read_config_dword(dev, PCI_COMMAND, &id);
-- 
2.18.4


