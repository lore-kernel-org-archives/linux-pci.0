Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095283043BE;
	Mon, 10 Aug 2026 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786324512; cv=none; b=ey3D20Yt9xO64IxQsTWqIgXIg3Ob0iUDT+wu+ux4Kk+af3zRiSaCJoHU7upUbqfWYmijcWGJL5NJRkkve8veJKLizP1x+nLmvUo4A6fYltiew7lIB+xCZ96CmaeJ0d8KZR02F8kdlNLJDzVxaQMPHM1ecWBk5BgP54p1t1e1Gy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786324512; c=relaxed/simple;
	bh=bw/EwA/bDr+fkYz9/4VEgjOxuqTxNxg3MZJ8IbI4ul0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Un5lWcYmsXdwiAIe3vL3brJj/gI6weTwqnBV/4iOT1d0GyMcgIQMLG/F6E+fIlSOqUz7pC6PguXV5Z+dcXmQKgb9Hcy/QN/z5h2gnEFD4YLTB7hDeGopPUox5oBQN3o+dtiI4y//mkoMgdEZUrF25VTSQ4z+nyK5XV+LvrIOGNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QsKuP7AR; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QsKuP7AR; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QsKuP7AR";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QsKuP7AR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AnCMHCxYA3w8u95MeRtrua2hq8G/Kwk85wuXOYUVoWY=;
	b=QsKuP7AROWZEg7Jj5kbqEs3lyZERWfHsJUdKNzQennFexuMqPP1ShpG8tpWHf9jHWO8K7uLm9
	ZbYrr/pG+9jM2OH23hZW6p8OrEQaSZwdloFJU1FIsg2Jvg1+Bfz8BpFd7wjUf8mcGm9U7+PghTm
	TG+ruhaJ6GhOMYQjKbNHjwE=
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4hJGxw3TDnz126Ltp;
	Mon, 10 Aug 2026 09:14:44 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AnCMHCxYA3w8u95MeRtrua2hq8G/Kwk85wuXOYUVoWY=;
	b=QsKuP7AROWZEg7Jj5kbqEs3lyZERWfHsJUdKNzQennFexuMqPP1ShpG8tpWHf9jHWO8K7uLm9
	ZbYrr/pG+9jM2OH23hZW6p8OrEQaSZwdloFJU1FIsg2Jvg1+Bfz8BpFd7wjUf8mcGm9U7+PghTm
	TG+ruhaJ6GhOMYQjKbNHjwE=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hJGjk5Cktz1prKd;
	Mon, 10 Aug 2026 09:04:10 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AAF24057D;
	Mon, 10 Aug 2026 09:14:48 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 09:14:47 +0800
Message-ID: <e31b0dcf-1a10-4fb5-b364-5f821df6f8dc@huawei.com>
Date: Mon, 10 Aug 2026 09:14:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 00/16] vfio/pci: Add PCIe TPH support
From: fengchengwen <fengchengwen@huawei.com>
To: <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
Content-Language: en-US
In-Reply-To: <20260714104325.54444-1-fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

Hope everything goes well.

I’m sending a gentle follow‑up on my previous mail dated Jul 27,
about splitting this VFIO‑TPH v20 patchset into standalone‑core series
and the subsequent dma‑buf P2P TPH extension to resolve the
invalidate‑mapping lifecycle issue.

One extra question I’d like to consult with you.
This v20 series is built upon Zhiping’s v11 dma‑buf TPH patches,
and his patchset has now advanced to v13.
Should I rebase my work on top of his latest v13 for the next revision,
or keep another way to organise the patch series?

I will arrange v21 accordingly once I get your advice.
Thanks a lot.

Best regards,
Chengwen Feng

On 7/14/2026 6:43 PM, Chengwen Feng wrote:
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
>    - Tags targeting peer devices are managed by userspace drivers, and set
>      to kernel by dmabuf ioctl which address by zhiping's patchset.
> 2. Program Steering Tag table:
>    - For devices with standard ST table structures (in capability space or
>      MSI-X table), userspace needs a unified interface to configure ST
>      entries.
>    - Devices without standard ST tables are handled by userspace itself.
> 3. Toggle device TPH Requester enable/disable state.
> 
> The patchset builds a complete, secure, staged TPH feature stack with core
> design objectives:
> 1. Refactor & fix upstream PCI/TPH core implementation to provide clean,
>    safe, extendable helper APIs for VFIO consumption;
> 2. Introduce configurable per-device TPH policy for staged feature
>    enablement, supporting progressive enabling of No-ST/IV/DS/LITERAL
>    modes;
> 3. Fully virtualize PCIe TPH config space: read-only capability header,
>    virtually writable TPH_CTRL, silent discard invalid writes;
> 4. Implement unified VFIO user feature uAPI (TPH / TPH_RESOLVE / TPH_ST)
>    for TPH enablement, tag resolution and batch ST table programming;
> 
> The patchset is split into three logical parts:
> 1. The first three patches is Zhiping's patchset of add TPH support for
>    p2p access (based on v11), because this patchset support query dmabuf's
>    ST/PH
> 2. The second eight patches fix and refactor core PCI/TPH kernel code to
>    export required helper interfaces
> 3. The last five patches implement corresponding VFIO TPH virtualization
>    and uAPI step by step.
> 
> Based on earlier RFC work by Wathsala Vithanage
> 
> ---
> v20:
> - Address almost all comments from Alex about v19, not within Alex's
>   scope:
>   - Drop LITERAL policy support
>   - uAPI changes: cap have been split into fine-grained
>   - TPH config access: still based on perm mechanism, but restrict the
>     readable and writable length
>   - Debugfs add more fields
> v19:
> - Address all comments from Alex
>   - Drop CPU-to-ST translation of PCI/TPH
>   - Re-implement vfio part, please refer:
>     https://lore.kernel.org/linux-pci/20260626092232.53ed3a7c@shazbot.org/
> - Add expose tph_policy via debugfs
> 
> Chengwen Feng (13):
>   PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
>   PCI/TPH: Fix tph_enabled concurrent update race by bitfield packing
>   PCI/TPH: Cache negotiated max requester type at probe time
>   PCI/TPH: Refactor pcie_enable_tph and add requester variant
>   PCI/TPH: Refactor pcie_tph_get_cpu_st & add requester variant
>   PCI/TPH: Add macros to check standard and extended TPH support
>   PCI/TPH: Add pcie_tph_set_st_entries() batch ST entry programming
>     helper
>   PCI/TPH: Add pci_tph_dsm_supported() helper to detect device TPH ST
>     _DSM
>   vfio/pci: Add basic NO-ST TPH VFIO device feature support
>   vfio/pci: Add IV-ST TPH policy and VFIO TPH_ST batch programming
>     support
>   vfio/pci: Add DS-ST TPH policy and extend TPH_RESOLVE capabilities
>   vfio/pci: Sync core PCI TPH software state across device lifecycle and
>     resets
>   vfio/pci: Expose per-device TPH state via debugfs
> 
> Zhiping Zhang (3):
>   PCI/TPH: Add requester/completer type helpers
>   dma-buf: add optional get_pci_tph() callback
>   vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
> 
>  drivers/dma-buf/dma-buf.c          |  32 +++
>  drivers/pci/tph.c                  | 282 ++++++++++++++++++------
>  drivers/vfio/pci/vfio_pci.c        |  23 ++
>  drivers/vfio/pci/vfio_pci_config.c | 164 ++++++++++++--
>  drivers/vfio/pci/vfio_pci_core.c   | 341 ++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 102 ++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h   |  18 ++
>  include/linux/dma-buf.h            |  25 +++
>  include/linux/pci-tph.h            |  53 ++++-
>  include/linux/pci.h                |   6 +-
>  include/linux/vfio_pci_core.h      |   3 +
>  include/uapi/linux/vfio.h          | 144 ++++++++++++
>  12 files changed, 1090 insertions(+), 103 deletions(-)
> 

