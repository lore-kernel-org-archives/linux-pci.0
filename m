Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E903E2750;
	Mon, 15 Jun 2026 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525997; cv=none; b=JGGYlB2NDiejs1ZcWpWFXxY40ThVAbhHZU9sARw7MrzajjTnjCD5FX5EyWLKgseKwrlHkaOpFN+up21OUK/t2mYimTR+ANlMDcQqj7Hcze5U5u9wEXqJP+xm1JBHriSuBeyUTBH/JLvwqXweiud9CizaCO+JS34bcCgfCJVPpdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525997; c=relaxed/simple;
	bh=GfaaWiOxap24zw6CqDR7NSUh+gK0t+b7tM/KMQpacMw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=L9qoqetxZbnohTc26ShfRyH63LNBbTd6FFcaunu3+sPnRAWcZaCVkMLalIQ3cVIWNyK+8qIXhuoGoVF0ocZXrFrvC4O7VveTJrv/Z/opWhdm40jdCsKq14u4k+JCBhqxLis0Kc+wUXWZFw9sYTpK3PlEMHIvXmsO4sk7Tt61Ywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sglWnXkW; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sglWnXkW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uRMg5s1SHDa5cuTwAih0echSXs6DoScr+7o1o8hxPOE=;
	b=sglWnXkWHHZ9WFYw9QXL63CF/sQLKzuiIxWqMmiTwQl0Rc3BLJhs5l1keOeKQsbpt4tmEx96B
	Qv1d8v1n7PBeqEK4Y1OCFOFQI8iHHCWq0uUR1EBZjEYF4eua5pcMLj2dSd0ZcBGr1kDrU6fY0KJ
	Hdf1+dqphQyG0hLKN6/y49Q=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gf89y53MrzmV6m;
	Mon, 15 Jun 2026 20:11:50 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F204402AB;
	Mon, 15 Jun 2026 20:19:49 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Jun 2026 20:19:48 +0800
Message-ID: <812b6875-5c46-4e03-af81-161b7e2d0e12@huawei.com>
Date: Mon, 15 Jun 2026 20:19:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/12] vfio/pci: Add PCIe TPH support
From: fengchengwen <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260604132804.28678-1-fengchengwen@huawei.com>
Content-Language: en-US
In-Reply-To: <20260604132804.28678-1-fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Gentle ping for v16 TPH series.

Would appreciate reviews from Alex and Jason. Let me know if major changes are needed.

Thanks,
Chengwen Feng


On 6/4/2026 9:27 PM, Chengwen Feng wrote:
> This patchset enables full userspace configurable PCIe TPH support for
> VFIO, which brings performance benefits for userspace workloads such as
> DPDK and SPDK.
> 
> Currently VFIO only exposes read-only TPH capability registers to 
> userspace, while all write operations are silently discarded. This 
> prevents userspace from enabling and configuring TPH, limiting performance
> optimization opportunities.
> 
> Per PCIe spec 7.5.3.15: TPH Completer support is applicable to Root Ports
> and Endpoints, allowing Steering Tags to target host CPUs or peer devices
> for P2P transactions.
> 
> TPH usage model can be divided into three fundamental parts:
> 1. Retrieve Steering Tag:
>    - Tags targeting host CPUs are obtained via platform methods (ACPI _DSM)
>      wrapped in pcie_tph_get_cpu_st(). Userspace requires a generic 
>      interface to query these CPU-associated ST values.
>    - Tags targeting peer devices are managed by userspace drivers.
> 2. Program Steering Tag table:
>    - For devices with standard ST table structures (in capability space or
>      MSI-X table), userspace needs a unified interface to configure ST 
>      entries.
>    - Devices without standard ST tables are handled by userspace itself.
> 3. Toggle device TPH Requester enable/disable state.
> 
> To support the above scenarios, this series extends VFIO with complete TPH
> virtualization features:
> - New device feature TPH_CPU_ST: Batch query interface to resolve 
>   CPU-specific ST tags.
> - New device feature TPH_ST_CONFIG: Batch configure interface for device ST
>   table entries, with shadow cache and atomic rollback support.
> - Full TPH capability register virtualization: allow userspace to toggle
>   TPH Requester state via TPH_CTRL register writes.
> 
> To guarantee isolation and security, this patchset adopts a two-level
> safety gate design with careful ABI considerations:
> 1. Global unsafe gate:
>    TPH caching behavior may cross isolation domains and impact shared
>    platform resources. A new module parameter `enable_unsafe_tph` is
>    introduced (default off) to globally gate all TPH functionalities.
> 2. Per-device opt-in gate:
>    To preserve strict ABI compatibility and avoid unexpected hardware
>    state changes for existing users, a new VFIO device feature TPH_ENABLE
>    is added. TPH capabilities are only available after userspace explicitly
>    enables it per-device.
> 
> Because Kernel PCI TPH implementation requires TPH Requester to be enabled
> before programming ST entries. To support userspace configuring ST table
> in arbitrary order, a shadow ST table is introduced to buffer ST writes
> before TPH is enabled. All cached entries are flushed to hardware when
> TPH Requester turns on. This also provides atomic batch rollback capability
> for reliable configuration.
> 
> The patchset is split into two logical parts: the first seven patches fix
> and refactor core PCI/TPH kernel code to export required helper interfaces,
> and the remaining five patches implement corresponding VFIO TPH
> virtualization layer step by step.
> 
> Patch breakdown:
>  1/12 PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
>  2/12 PCI/TPH: Fix tph_enabled concurrent update race by bitfield packing
>  3/12 PCI/TPH: Cache TPH requester capability at probe time
>  4/12 PCI/TPH: Refactor pcie_enable_tph & add explicit requester variant
>  5/12 PCI/TPH: Refactor pcie_tph_get_cpu_st & add explicit variant
>  6/12 PCI/TPH: expose the enabled TPH requester type
>  7/12 PCI/TPH: Add pcie_tph_supported() helper to check TPH capability attrs
>  8/12 vfio/pci: Hide TPH capability when TPH is unsupported
>  9/12 vfio/pci: Add TPH_ENABLE feature skeleton and unsafe module parameter
> 10/12 vfio/pci: Add TPH_CPU_ST to query CPU's TPH steering tag
> 11/12 vfio/pci: Add TPH_ST_CONFIG for PCIe TPH ST configuration
> 12/12 vfio/pci: Virtualize PCIe TPH capability registers
> 
> Based on earlier RFC work by Wathsala Vithanage
> 
> ---
> v16: 
> - Supports opt-in at the device level which address Alex's comment.
> - Split sub-commit: add hide TPH capability when TPH is unsupported.
> - Optimize the tph fields layout of the pci_dev structure.
> - Optimize virtualize PCIe TPH capability commit: support rollback
>   when set fail.
> - Reorder PCI/TPH commits: make fix commit ahead.
> - Reorganized the cover letter to serve as the starting point for
>   discussion.
> v15: Address Alex's comments:
> - Drop TPH capability when tph_cap=0
> - Use _explicit postfix other than add policy parameter for enable
>   TPH and get tph st.
> - Make sure set st entry under D0
> - Reimpl virtualize TPH capability register
> - Other fix
> v14:
> - Return PCI_TPH_LOC_NONE when !CONFIG_PCIE_TPH accord Alex's comment
> - Fix Sashiko comments:
>   - Clear ST shadow state across user session
>   - Fix out-of-bounds byte masking in vfio_pci_tph_config_read
> 
> Chengwen Feng (11):
>   PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
>   PCI/TPH: Fix tph_enabled concurrent update race by bitfield packing
>   PCI/TPH: Cache TPH requester capability at probe time
>   PCI/TPH: Refactor pcie_enable_tph & add explicit requester variant
>   PCI/TPH: Refactor pcie_tph_get_cpu_st & add explicit variant
>   PCI/TPH: Add pcie_tph_supported() helper to check TPH capability
>     attributes
>   vfio/pci: Hide TPH capability when TPH is unsupported
>   vfio/pci: Add TPH_ENABLE feature skeleton and unsafe module parameter
>   vfio/pci: Add TPH_CPU_ST to query CPU's TPH steering tag
>   vfio/pci: Add TPH_ST_CONFIG for PCIe TPH ST configuration
>   vfio/pci: Virtualize PCIe TPH capability registers
> 
> Zhiping Zhang (1):
>   PCI/TPH: expose the enabled TPH requester type
> 
>  drivers/pci/tph.c                  | 220 ++++++++++++++++++++--------
>  drivers/vfio/pci/vfio_pci.c        |  13 +-
>  drivers/vfio/pci/vfio_pci_config.c | 111 ++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c   | 228 ++++++++++++++++++++++++++++-
>  include/linux/pci-tph.h            |  22 +++
>  include/linux/pci.h                |   6 +-
>  include/linux/vfio_pci_core.h      |   7 +-
>  include/uapi/linux/vfio.h          |  60 ++++++++
>  8 files changed, 600 insertions(+), 67 deletions(-)
> 

