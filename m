Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530148BD47;
	Thu,  2 Jul 2026 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996164; cv=none; b=nzXqe7nxK39DDpuwpXWKXAQpegcWd7GAu4pK3QgDQEYQRPuUy6NgX4XUqhsnbQ8dOHnF4OMeRvgQTptdJJgj/PhjvXlsCzLQ+J+ExN4HduR8RRk37gCNEPwS5Hw+dW5WZrAjRgE5WJdU8JQXrEFT66SHUKHT7Y7AF4TV3i2vnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996164; c=relaxed/simple;
	bh=qnrFbzOK6pVmKuT/nfyuyf/W4H/M6FMBbFnolj3mNJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dbV5/9cuKKPFihH6YsIRL1BfkisGkiZkACKOAG+Mib5xnydcJX/gv90hjAfhvVWFKbyre9l/G7i9yh5NGk/KFGe4C6S1F4k1Pn1vR2WgH6XNU0uby9oNOnrvbV+5CTzef0EVkuRcBF9muFxnM/jR37/5ofi/yBVCqq+Z6rotsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FO97dSrM; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FO97dSrM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0zetA8q8AlwIS7sWo2kQm5yp2DxB0v8DctpQEyiZLqI=;
	b=FO97dSrMc7VnM19ekPYza2M/HfL5AGVEG4naAhBseGCTjOzwsJ8BSuftD40BjwHZw0YCYSg0H
	epxljm+dopSNn42CYsUorbbM3UYQTokvI9CTzre50zv67I4dGaaHQQM/0X3en2Gyop6k23Nsf66
	ecUYavZce6F7xn7lJcIw220=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4grbrx4ChBz1K97H;
	Thu,  2 Jul 2026 20:33:21 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id BBD984058D;
	Thu,  2 Jul 2026 20:42:30 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:42:30 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v19 00/18] vfio/pci: Add PCIe TPH support                
Date: Thu, 2 Jul 2026 20:42:06 +0800
Message-ID: <20260702124224.57168-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

This patchset enables full userspace configurable PCIe TPH support for          
VFIO, which brings performance benefits for userspace workloads such as         
DPDK and SPDK.                                                                  
                                                                                
Currently VFIO only exposes read-only TPH capability registers to               
userspace, while all write operations are silently discarded. This              
prevents userspace from enabling and configuring TPH, limiting performance      
optimization opportunities.                                                     
                                                                                
Per PCIe spec 7.5.3.15: TPH Completer support is applicable to Root Ports       
and Endpoints, allowing Steering Tags to target host CPUs or peer devices       
for P2P transactions.                                                           
                                                                                
TPH usage model can be divided into three fundamental parts:                    
1. Retrieve Steering Tag:                                                       
   - Tags targeting host CPUs are obtained via platform methods (ACPI _DSM)     
     wrapped in pcie_tph_get_cpu_st(). Userspace requires a generic             
     interface to query these CPU-associated ST values.                         
   - Tags targeting peer devices are managed by userspace drivers, and set
     to kernel by dmabuf ioctl which address by zhiping's patchset.              
2. Program Steering Tag table:                                                  
   - For devices with standard ST table structures (in capability space or      
     MSI-X table), userspace needs a unified interface to configure ST          
     entries.                                                                   
   - Devices without standard ST tables are handled by userspace itself.        
3. Toggle device TPH Requester enable/disable state.

The patchset builds a complete, secure, staged TPH feature stack with core
design objectives:
1. Refactor & fix upstream PCI/TPH core implementation to provide clean, 
   safe, extendable helper APIs for VFIO consumption;
2. Introduce configurable per-device TPH policy for staged feature 
   enablement, supporting progressive enabling of No-ST/IV/DS/LITERAL 
   modes;
3. Fully virtualize PCIe TPH config space: read-only capability header, 
   virtually writable TPH_CTRL and ST-table entries, silent discard 
   invalid writes;
4. Implement unified VFIO user feature uAPI (TPH / TPH_RESOLVE / TPH_ST)
   for TPH enablement, tag resolution and batch ST table programming;

The patchset is split into two logical parts: the first eight patches fix       
and refactor core PCI/TPH kernel code to export required helper interfaces,
the remaining eight patches implement corresponding VFIO TPH virtualization
and uAPI step by step.

Based on earlier RFC work by Wathsala Vithanage
Based on zhiping's patchset of add TPH support for p2p access

---
v19:
- Address all comments from Alex
  - Drop CPU-to-ST translation of PCI/TPH
  - Re-implement vfio part, please refer:
    https://lore.kernel.org/linux-pci/20260626092232.53ed3a7c@shazbot.org/
- Add expose tph_policy via debugfs
v18-resend:                                                                     
- Fix apply failed only                                                         
v18:                                                                            
- Address all comments of [08/12] commit from Alex                              
  - Add document in sysfs-bus-pci                                               
  - Place the new field at the root port                                        
  - Add new filed only when root port support TPH completer and _DSM            
    method                                                                      
  - Support random offset read, return zero if cpu is offline                   
  - Zero-initialize the buffer rather than memset and reserved = 0              
- Fix git am fail for [10/12] commit                                            
- Fix folloing Sashiko review comments of [11/12] commit:                       
  - Add __GFP_ACCOUNT in thp_st_shadow allocation                               
  - Move reset tph_permit in vfio_pci_tph_init/deinit                           
  - Refine feature PROBE for `TPH_ST_CONFIG`, make sure probe OK when           
    enable_unsafe_tph is set                                                    
  - Add commit-log about why TPH ST shadow table is not cleared when the        
    VFIO device is reset 

Chengwen Feng (17):
  PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
  PCI/TPH: Fix tph_enabled concurrent update race by bitfield packing
  PCI/TPH: Cache TPH requester capability at probe time
  PCI/TPH: Refactor pcie_enable_tph & add explicit requester variant
  PCI/TPH: Refactor pcie_tph_get_cpu_st & add explicit variant
  PCI/TPH: Add pcie_tph_supported() helper to check TPH capability
    attributes
  PCI/TPH: Add pci_tph_dsm_supported() helper to detect device TPH ST
    _DSM
  vfio/pci: Hide TPH capability when TPH is unsupported
  vfio/pci: Introduce tph policy parameter for staged TPH feature
    enablement
  vfio/pci: Virtualize PCIe TPH capability registers
  vfio/pci: Add dmabuf TPH metadata storage and fd query helper
  vfio/pci: Introduce VFIO_DEVICE_FEATURE_TPH family uapi for PCI TPH
    control
  vfio/pci: Implement VFIO_DEVICE_FEATURE_TPH and valid TPH config write
    support
  vfio/pci: Implement TPH_RESOLVE feature for DMABUF and CPU source
    resolving
  vfio/pci: Implement TPH_ST feature for batch ST table programming
  vfio/pci: Reset hardware TPH state on device enable/disable
  vfio/pci: Expose tph_policy via debugfs

Zhiping Zhang (1):
  PCI/TPH: Expose the enabled TPH requester type

 drivers/pci/tph.c                  | 246 +++++++++++++++++++++-------
 drivers/vfio/pci/vfio_pci.c        |  25 +++
 drivers/vfio/pci/vfio_pci_config.c | 129 +++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c   | 252 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_dmabuf.c |  49 +++++-
 drivers/vfio/pci/vfio_pci_priv.h   |  13 ++
 include/linux/pci-tph.h            |  25 +++
 include/linux/pci.h                |   6 +-
 include/linux/vfio_pci_core.h      |   2 +
 include/uapi/linux/vfio.h          |  62 +++++++
 10 files changed, 742 insertions(+), 67 deletions(-)

-- 
2.17.1

