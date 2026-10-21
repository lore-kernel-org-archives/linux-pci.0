Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792546996;
	b=zYygs73ykcuuX/8hKk8c3QMuqiSYhS8TWAq8VmK0Ms9+wpPqxaReW6iqTbsAyOrAB2fr
	 F2edterXKYnTCN23E/vrZSBidoRNWqBSVbd+bLZi/p6+51WJeB/5Hx85tTqpxRCXyB9Ms
	 u8SIvdX4KJJqJjEj/8ENbRbJcAiUDOGwbz2ibiiKwexgUPhgWRoiDFw4RyVje95bc7TtO
	 gC69L6CuDTV+oX43CTTp5HPjSPR19EA2au2dQa4uKQvZhgJYjcrQLgM9KRZvOzxxvJzUf
	 xkum0i1nCxitsPqO6vuoHmO+iYqpJtz3zbR/GG3SzifPdjUyyK3DHT241++faDukLnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546996;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:CC:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=50mE+TFxHoSoXlP90mElxa07zcuU+qcnOEjh3mmzvkg=;
	b=4dpJRxa2hj8kuwp7LwgfLqbizMqbpJGK+pkkq4Dgk6d4MWy6ul9d6CmWiEiaKUYx/g5/
	 FfS8+HIjqklSuMD/dnFqr3wLoqKmSm7g/ehvNa4jlQrp4WCmOzKnZ3BA3WJyfx4CbGw61
	 FFoDTyS05aAPsNTnU1Rk9IALi2qgfNS9FOi7diZMVobY+ugr9cJ9zsVB1b18oINlDbkIB
	 flj15ZLNtdP8XeQi3rcgbCvX4E+Ep2Jze8VpAl1Ze+r0KHRrA8UJw7RCilAo9reh90/Go
	 bnWWAZ3H27r0nznSZFKAMVG/DJe2i0oX88FQoERNqK2qgyXtvyOABomEYGUTGiU75qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=H9eEAdIH;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC7606A319;
	Wed, 21 Oct 2026 01:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12AC7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=H9eEAdIH
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=50mE+TFxHoSoXlP90mElxa07zcuU+qcnOEjh3mmzvkg=;
	b=H9eEAdIHnxzDlwu+6/Yjn7+5dIH6OaFhTV9R2sOIq/QiWat/oOG9z3hq8vNMHz8y+YIejX5LZ
	wgIt85byGqwnvsF28+WbiVnYHq6azBKx0xboBQtqULJdKQIHbRvk92VToI0ODCCjUw1VJ3xOrZm
	iNH9M3qqydQQDZU7OmY8DXc=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j8X9R3YgcznTXh;
	Wed, 21 Oct 2026 09:43:07 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 059D040578;
	Wed, 21 Oct 2026 09:43:06 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 21 Oct 2026 09:43:05 +0800
Message-ID: <6d86dd9c-83ad-4884-915e-6509995c5ba3@huawei.com>
Date: Wed, 21 Oct 2026 09:43:05 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

Quick follow-up from our LPC discussion on the VFIO TPH patchset.

The P2P TPH path carries significant verification complexity, as it builds
on the PCI P2PDMA stack which is still under active upstream revision.

Meanwhile there is clear real-world demand for the device-to-host scenario.
AMD recently posted their debugfs series exposing CPU-to-ST mappings [1],
and we also have strong use cases for D2H TPH enablement.

I'd like to propose a phased upstream approach:
land device-to-host support first, and defer P2P TPH to a follow-up series.

We can add P2P support cleanly on top once the interface and verification
are solid. This way we can deliver usable TPH functionality sooner, while
keeping the path open for full P2P support later.

Let me know your thoughts on going ahead with device-to-host support first.
If you're okay with this, I'll post v21 accordingly.

Thanks,
Chengwen

[1] https://lore.kernel.org/linux-pci/20261001155551.4182899-1-wei.huang2@amd.com/


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

