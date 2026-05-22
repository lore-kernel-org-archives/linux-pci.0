Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44113202997;
	Fri, 22 May 2026 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779413477; cv=none; b=KPFy+lYS1YvBeBmpSIVxg8OCsccbzW6tYYDuH2X3iea3mWjVmtqKOznlH3xv+tb2+KYjbKlJP107Ab4ivfc7u3N5NY13KOFleLztmHFmvCQjAivunXUItJ12zjB4zQR/bJ/Khs5Pn57rji/Gb7nQgbodDRIH/g4TbQb54GHRMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779413477; c=relaxed/simple;
	bh=ZZ04BoHLVA4LefkhwvvqPGpIiuBAS9yQqacZty5JN94=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=QNsvS/LX0y6tDaFbp68eeUgyTceEEmVBtRLz++hWMI03Oph98l6pL+Dst6TD1wE+KgUjvd94i1AZw8xGSAaXazBxFSM99MM2jAoKZXDHGCw0+asiR85PFMJ0v08PiZIwGu4WSsGT7QuwiyYl+EqcJfPgAOTZjh5jQ18ys7XEkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=D6eWmw5r; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="D6eWmw5r"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vQMChNB37Q8/4e7v7mz1M5o9qmVWKH8gMI2EsakFAc4=;
	b=D6eWmw5rWFMk04QtM7z5MQHyyWCKgsQ4C/d1Nx0Kc4JmToM28j+4ssyM80a4umecoZmXwyZjw
	272LDLFodW8EieQlB3Q+q2kzkTPXW5w0jbMw/3GN4atnv7lGzJIxqcWhAgieZZ/Z6eh7FzVROCj
	mH/R2lYqC2ttmnf8PU/xG04=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gM6wy4y7dz1K96Y;
	Fri, 22 May 2026 09:23:30 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id BEDB040538;
	Fri, 22 May 2026 09:31:11 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 09:31:11 +0800
Message-ID: <7a7b544f-8af1-4b9a-8c36-55b9f9744933@huawei.com>
Date: Fri, 22 May 2026 09:31:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/5] vfio/pci: Add PCIe TPH support
From: fengchengwen <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260518071701.25177-1-fengchengwen@huawei.com>
Content-Language: en-US
In-Reply-To: <20260518071701.25177-1-fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Hi Alex & Jason,

Gentle reminder for this v11 TPH patchset.

Could you help review it at your convenience?

Your comments will help verify the overall design direction and polish the code further.

Thanks

On 5/18/2026 3:16 PM, Chengwen Feng wrote:
> This patchset enables userspace control over PCIe TPH steering tags,
> motivated by the following considerations:
> 
> 1. Why userspace needs the capability to control steering tags:
>    When PCIe devices are fully owned by userspace workloads such as DPDK
>    and SPDK, only userspace has full knowledge of core binding policies
>    and traffic distribution strategies. Without this series, userspace
>    cannot enable TPH or configure steering tags, leaving built-in PCIe
>    performance optimizations unused in high-throughput polling I/O
>    scenarios.
> 
> 2. Why this interface must be implemented in VFIO:
>    VFIO is the standard, secure community solution for granting full
>    PCIe device ownership to userspace. Existing kernel TPH interfaces
>    are designed purely for in-kernel drivers. For user-owned devices,
>    VFIO provides the only isolated and correct path to expose per-device
>    TPH management.
> 
> TPH supports both IV and DS modes. Since both modes could introduces
> cross-VM isolation risks such as untrusted guests programming arbitrary
> steering tags to impact other domains:
> 1. If ST location in MSI-X table, untrusted guests may program the
>    MSI-X table.
> 2. If ST don't locate in MSI-X or CAP, untrusted guests may program the
>    device-specific register.
> So a new module parameter `enable_unsafe_tph` is added. It defaults to
> off, and blocks all unsafe TPH operations when disabled.
>   
> Based on earlier RFC work by Wathsala Vithanage
> 
> v11:
> - Fix Sashiko review comments:
>   Add tph_lock for protect all tph operations from vfio user
>   Fix memory-leak when copy_to_user failed
> v10:
> - Fix Sashiko review comments:
>   - Fix TPH virtualization write return negetive val of 4/5 commit
>   - Fix don't support probe feature of 5/5 commit
>   - Fix return positive val if copy_to_user fail of 5/5 commit
> v9:
> - Address Alex's comment on VFIO part: adopt device feature scheme
> - Remove pcie_tph_get_st_table_size and add pcie_tph_is_enabled
>   depending on the implementation requirements
> 
> Chengwen Feng (5):
>   PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
>   PCI/TPH: Export pcie_tph_get_st_modes() for external use
>   PCI/TPH: Add pcie_tph_enabled_mode() helper
>   vfio/pci: Add PCIe TPH configuration space virtualization
>   vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for TPH ST entry management
> 
>  drivers/pci/tph.c                  |  38 +++++++---
>  drivers/vfio/pci/vfio_pci.c        |  13 +++-
>  drivers/vfio/pci/vfio_pci_config.c |  28 ++++++++
>  drivers/vfio/pci/vfio_pci_core.c   | 107 ++++++++++++++++++++++++++++-
>  include/linux/pci-tph.h            |  10 +++
>  include/linux/vfio_pci_core.h      |   4 +-
>  include/uapi/linux/vfio.h          |  41 +++++++++++
>  7 files changed, 230 insertions(+), 11 deletions(-)
> 

