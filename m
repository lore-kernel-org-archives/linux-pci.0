Received: from mail-m12749.qiye.163.com (mail-m12749.qiye.163.com [115.236.127.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8D73C9438;
	Thu, 18 Jun 2026 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767755; cv=none; b=HhNTDN2kcbMVX8m4RLKR+iRA069Y74SVBVJWFDcH2af5/8CvG5vKnfAqjx5Hj/JeSzBpnIGR/Vz/pgTvd7wdOXQNNLBeE/recSvcKD5yG65TNgxdX4Nf1o3faaNKJcRazK59x/47EKvLa1os4B9ENFxKfYVti6MZ2V71VBkfy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767755; c=relaxed/simple;
	bh=G2frdLkM/csPxPwoUjLhXK0y2r0U44PZwSnmzln5Yrc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DJ3Cph+3kEcxEM20KOaLk0A8OlXbw5Z3JMDJf7mUX/UbH2/8sEcP/QafW7v6ZaEbxP7t2ZLzqkladq4vHhywaOI+gtTT23GQNBAzcmRWrK/fGzy2epzupfg3B6JMGLrFXMJYB7YqOOvXxsu0sBsO/+vg3oiH5o81ZpHxaVOihX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=115.236.127.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:3276:b8d0:3c56:4032:2eb6:770c])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42e1fc67d;
	Thu, 18 Jun 2026 15:29:02 +0800 (GMT+08:00)
From: Ding Hui <dinghui@sangfor.com.cn>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	Ding Hui <dinghui@sangfor.com.cn>
Subject: [RFC PATCH] PCI: Sort resources by size as secondary key
Date: Thu, 18 Jun 2026 15:25:36 +0800
Message-Id: <20260618072536.28199-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Tid: 0a9ed9a2239b03a8kunm47dd1f0a18d31a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0lOVk9NTkJMQ0lMSxhPT1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0seQUgZTEFISUxNQRlDH0tBSBhOTUFPS0hJQUkeGU
	1BTExLGFlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSkJLS1kG
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

We encountered an issue on BCM57414 NIC where function 1 failed to
enable SR-IOV after remove & rescan. Investigation revealed this is
caused by BAR allocation failure during rescan.

Simplified topology:

 +-[0000:30]-+- ...
 |           +-02.0-[31]--+-00.0  Broadcom Inc. and subsidiaries BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller [14e4:16d7]
 |           |            \-00.1  Broadcom Inc. and subsidiaries BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller [14e4:16d7]

iomem layout after init bootup:

  22fffec00000-22ffffefffff : PCI Bus 0000:31 [Window size=19M]
    22fffec00000-22ffff3fffff : 0000:31:00.1  [align=1M  size=8M   BAR 9 (VF BAR 2)]
    22ffff400000-22ffffbfffff : 0000:31:00.0  [align=1M  size=8M   BAR 9 (VF BAR 2)]
    22ffffc00000-22ffffcfffff : 0000:31:00.1  [align=1M  size=1M   BAR 2]
    22ffffd00000-22ffffdfffff : 0000:31:00.0  [align=1M  size=1M   BAR 2]
    22ffffe00000-22ffffe0ffff : 0000:31:00.1  [align=64K size=64K  BAR 0]
    22ffffe10000-22ffffe1ffff : 0000:31:00.0  [align=64K size=64K  BAR 0]
    22ffffe20000-22ffffe3ffff : 0000:31:00.1  [align=16K size=128K BAR 11(VF BAR 4)]
    22ffffe40000-22ffffe5ffff : 0000:31:00.1  [align=16K size=128K BAR 7 (VF BAR 0)]
    22ffffe60000-22ffffe7ffff : 0000:31:00.0  [align=16K size=128K BAR 11(VF BAR 4)]
    22ffffe80000-22ffffe9ffff : 0000:31:00.0  [align=16K size=128K BAR 7 (VF BAR 0)]
    22ffffea0000-22ffffea1fff : 0000:31:00.1  [align=8K  size=8K   BAR 4]
    22ffffea2000-22ffffea3fff : 0000:31:00.0  [align=8K  size=8K   BAR 4]

iomem layout after remove function 1 by
  echo "1" > /sys/bus/pci/devices/0000:31:00.1/remove

  22fffec00000-22ffffefffff : PCI Bus 0000:31 [Window size=19M]
    22ffff400000-22ffffbfffff : 0000:31:00.0  [align=1M  size=8M   BAR 9 (VF BAR 2)]
    22ffffd00000-22ffffdfffff : 0000:31:00.0  [align=1M  size=1M   BAR 2]
    22ffffe10000-22ffffe1ffff : 0000:31:00.0  [align=64K size=64K  BAR 0]
    22ffffe60000-22ffffe7ffff : 0000:31:00.0  [align=16K size=128K BAR 11(VF BAR 4)]
    22ffffe80000-22ffffe9ffff : 0000:31:00.0  [align=16K size=128K BAR 7 (VF BAR 0)]
    22ffffea2000-22ffffea3fff : 0000:31:00.0  [align=8K  size=8K   BAR 4]

Rescan logs triggered by
  echo "1" > /sys/bus/pci/devices/0000:30:02.0/rescan

[   90.585067] pci 0000:31:00.1: [14e4:16d7] type 00 class 0x020000 PCIe Endpoint
[   90.585107] pci 0000:31:00.1: BAR 0 [mem 0x22ffffe00000-0x22ffffe0ffff 64bit pref]
[   90.585113] pci 0000:31:00.1: BAR 2 [mem 0x22ffffc00000-0x22ffffcfffff 64bit pref]
[   90.585116] pci 0000:31:00.1: BAR 4 [mem 0x22ffffea0000-0x22ffffea1fff 64bit pref]
[   90.585119] pci 0000:31:00.1: ROM [mem 0xb0e00000-0xb0e7ffff pref]
[   90.585216] pci 0000:31:00.1: PME# supported from D0 D3hot D3cold
[   90.585253] pci 0000:31:00.1: VF BAR 0 [mem 0x22ffffe40000-0x22ffffe43fff 64bit pref]
[   90.585255] pci 0000:31:00.1: VF BAR 0 [mem 0x22ffffe40000-0x22ffffe5ffff 64bit pref]: contains BAR 0 for 8 VFs
[   90.585258] pci 0000:31:00.1: VF BAR 2 [mem 0x22fffec00000-0x22fffecfffff 64bit pref]
[   90.585260] pci 0000:31:00.1: VF BAR 2 [mem 0x22fffec00000-0x22ffff3fffff 64bit pref]: contains BAR 2 for 8 VFs
[   90.585263] pci 0000:31:00.1: VF BAR 4 [mem 0x22ffffe20000-0x22ffffe23fff 64bit pref]
[   90.585265] pci 0000:31:00.1: VF BAR 4 [mem 0x22ffffe20000-0x22ffffe3ffff 64bit pref]: contains BAR 4 for 8 VFs
[   90.585534] pci 0000:31:00.1: Adding to iommu group 11
[   90.585575] pci 0000:31:00.1: BAR 2 [mem 0x22fffec00000-0x22fffecfffff 64bit pref]: assigned
[   90.585585] pci 0000:31:00.1: VF BAR 2 [mem size 0x00800000 64bit pref]: can't assign; no space
[   90.585587] pci 0000:31:00.1: VF BAR 2 [mem size 0x00800000 64bit pref]: failed to assign
[   90.585589] pci 0000:31:00.1: ROM [mem 0xb0e00000-0xb0e7ffff pref]: assigned
[   90.585591] pci 0000:31:00.1: BAR 0 [mem 0x22fffed00000-0x22fffed0ffff 64bit pref]: assigned
[   90.585599] pci 0000:31:00.1: VF BAR 0 [mem 0x22fffed10000-0x22fffed2ffff 64bit pref]: assigned
[   90.585603] pci 0000:31:00.1: VF BAR 4 [mem 0x22fffed30000-0x22fffed4ffff 64bit pref]: assigned
[   90.585606] pci 0000:31:00.1: BAR 4 [mem 0x22fffed50000-0x22fffed51fff 64bit pref]: assigned

Enable sriov failed logs triggered by
  echo 2 > /sys/bus/pci/devices/0000:31:00.1/sriov_numvfs

[ 1666.918432] bnxt_en 0000:31:00.1: not enough MMIO resources for SR-IOV
[ 1666.918442] bnxt_en 0000:31:00.1 eth5: pci_enable_sriov failed : -12

The resource allocation process during rescan is as follows:

  dev_rescan_store
    pci_rescan_bus
      pci_assign_unassigned_bus_resources
        __pci_bus_assign_resources
          pbus_assign_resources_sorted
            pdev_sort_resources
            __assign_resources_sorted
              assign_requested_resources_sorted
                pci_assign_resource

We noticed that current sort algorithm is only by alignment.
The BAR 2 (align=1M size=1M) is located before BAR 9 (VF BAR 2
align=1M size=8M), so the 8M cannot be satisfied.

If we keep alignment as primary sorting key, but use size as secondary
key, all resource can be satisfied when remove & rescan.

Does this approach only solve current specific case as a workaround,
or does it also benefit general PCI resource allocation?

I think it may help reduce allocation failures due to fragmentation
theoretically, but I'm not sure.

Appreciate any comment and suggestion, thanks.

Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 drivers/pci/setup-bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4cf120ebe5ad..63f224f0c6be 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -367,7 +367,8 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 			align = pci_resource_alignment(dev_res->dev,
 							 dev_res->res);
 
-			if (r_align > align) {
+			if (r_align > align ||
+			    (r_align == align && resource_size(r) > resource_size(dev_res->res))) {
 				n = &dev_res->list;
 				break;
 			}
-- 
2.17.1

