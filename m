Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226CD3DB627;
	Mon,  1 Jun 2026 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329528; cv=none; b=tn7gfeyBjDByC1dk8oU4QDX9SMV05WTCDkKqvUasRF8CFvj1omkKbP+b3uuRe1BRmJXkyIAtlOo9QHgFaainwt8+F04sb6IRBR/20wDmYZXEw/JI9T0vta8+59lvzmbZVN4xc7znxVmjWe0QKtg8+81zMpnRB1arQaJ+SlG63P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329528; c=relaxed/simple;
	bh=AyJcanJoqDuO2I7ZRmVmk7YcJUmnUEflBuKeGuX5hlc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4IPFT5k/cuhK4diUHmANkyyHI3+nZPWFicDjTzjrhel+ZMmq4gl7KKOjgDix+b1CkrKh2BJgXhBXlisK/9mMvcOX1cj2Vo/MNZ1/ZBSycdVLDBmlS6k9o23QRyLh48Czx+pBYs73sEk0YtICusrWKA9VmgMCYBzu0i4hw2nyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=NMmSgc0Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dlYVpjWA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="NMmSgc0Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dlYVpjWA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 39428EC0119;
	Mon,  1 Jun 2026 11:58:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 11:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780329525;
	 x=1780415925; bh=ZeyprTgB5QV8vWoWhx3BhUMu40zhcIw6vb2piHMWiMg=; b=
	NMmSgc0Zp55FDRlUCG359zoCmiI9Z4k9wT4JyuH7tLu5ApSS+w5DfCtRTq9NaAZv
	nPx/8FQbeaiLh07dQLe3bifIhDqWrwrEoUSR3R0iy2uyU0dkrVNCLWIMKf8MtNNu
	vQ6bFhX/UidtE4aMwYT37G9riT1vAoCxa+ChjN3mbf3kr+HE3hYi668nSd73umtU
	7Z9Vcp5+4Vs6vDd/oWUvOFFMR0hzuPikls3Bv7TI3W6tIDlkVcYqYkc/uZl4ZoHQ
	m3VSScSS8MOUduykKnmdrEwJ4E/Mfi50ymkVmToiYVQbX3i0mHcy/0CkQY65vawS
	6CTf6nKVubNl+TMck2g+zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780329525; x=
	1780415925; bh=ZeyprTgB5QV8vWoWhx3BhUMu40zhcIw6vb2piHMWiMg=; b=d
	lYVpjWAXtRWme9Noz5qTVLRuKQZd7CV2wrO8mwAaWYjGN3GUK/GkHYiejQf59q16
	H7EGsf8qC81p73YlJfVGgNAp4dVcZf2rnG5n7Ij6HRu4IfQZH1cyd5V6uhVod8cT
	xQEIRDO7xK1zcWfBcl80ZpY88fzQeocoo1Nvj52v/J3sc2cWRRQt5n5ekRZvqMwT
	5F1JzcBXbdw/jVehYW6SWFbEGM+XboOyy/EO4Bz2g124LsJCNtJgnG+IcMqSU57J
	97GAX2K4M/2ZBgH7LvXDLaSlUrX0i+sjXWf8EBUbXEx6o/PXgZosddOiNC3xPCz1
	51C0BZnqhQvMVb0RtGi1w==
X-ME-Sender: <xms:NKwdau1z_OM8zAy5m5l0oerfc0AsuW2ZVKJOygC42yXQvDmOFEU4Cw>
    <xme:NKwdaiqHznnF4fkPjDxMLgsK2JdAkvSO1JCzyHQ4SuHW5b23jCsEnEfNqvSyEXixv
    ptJyHd98xjm-kEeBSojRfVncbnOgJqNNeD_Uzbwkzv002tjks9U>
X-ME-Received: <xmr:NKwdamLfobemrtOZ5oCARPFlVu7M_vZo8z23LmAJKuO7jVLDdtzuh8o5_CU>
X-ME-Proxy-Cause: dmFkZTEoVJObxv8HEoN6LjJwjXfFCMxRVB+hL2YojZODug4fsYFDsMrXoh+qc52R4Iax2E
    ODaQgCtLIKNRvevefnLxbCi2/Vwj+Vz34brHnFuFOaqJXrkZkSIyWRj6dsSCiMU/v8yM1T
    vIdnlnxwM4PiTr3Rkf+XEh1R8B927W/xqs+qPuq8X70HQ3O3M3TcnLfdAVBXzuRwqDnGnJ
    DzlkoVEwB6ESr2bSByf99LfwQP9M2mnFvOKDqkAR2dXe0A0lVugKOIXT7gutcarwHC3HKZ
    vgZ2hmMAb/EJJRYKyqKVBGsWQDXDiH0Ho/ocyW+wuZkMi4vydQkgjnPFr/YzfJii86MpqZ
    fB3ufwSREeOhGF0cADw+r3Q33oGt32eXYy0+QIJQok7C/tzceaJxe3uCj+WRfZgVq4tifv
    igChLrmzPJbluo2vxHh6+3bMnjoZrl84IxCnD0dZKfVds0aAnjDcUSJPmLHrlxMo/RbV2p
    BKaVLRlMD99mJlihh9IMeHwihOq2J0usYAycaHx723m+mYzo3QixXUZE0hI8gDHKRd10g8
    VHgNDgMGsSifdKyM8JW2+esJ3jczSX7hkXbYf2wA3JWqYfaphNszFFCkoBtOK/Sr1u1AQ8
    yoUmxtiKNUA03OF08fQVOATxDOItA2cT4eGCkU/hSQ4ccJlK5nIp2GGTAxVg
X-ME-Proxy: <xmx:NKwdamT69LORNEBSSgD12IsIlpo8of1OzO6Vd4g1m_sSioTZJnRLcw>
    <xmx:NKwdamOCDQ6dYqGLQ33F6EdDGSvqFDkLnyyYP850QiSHZnHUNLRQ0Q>
    <xmx:NKwdarX0k36glkziGZ3hC1vGTRZyN9OAlX0utXqQqg4t2uDTQKAV6w>
    <xmx:NKwdapjwpdwuwmhpH0b6Dic4sys93lf78vnoXuWb6yriEbWNNZPMVA>
    <xmx:NawdapYkNAjZE7q5kwLHhLBhcpjbXow9C-6QgoCZS-CqUldOQD1_18G_>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 11:58:43 -0400 (EDT)
Date: Mon, 1 Jun 2026 09:58:40 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v14 0/8] vfio/pci: Add PCIe TPH support
Message-ID: <20260601095840.3aaaa508@shazbot.org>
In-Reply-To: <20260528124649.14732-1-fengchengwen@huawei.com>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 20:46:41 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

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
> ---
> v14:
> - Return PCI_TPH_LOC_NONE when !CONFIG_PCIE_TPH accord Alex's comment
> - Fix Sashiko comments:
>   - Clear ST shadow state across user session
>   - Fix out-of-bounds byte masking in vfio_pci_tph_config_read
> v13:
> - Fix Alex's comments:
>   - Add virtualize of TPH request type
>   - Adopt two feature


 - Patch 2/ sets tph_cap to zero if TPH cannot be enabled, but this is
   never propagated to vfio-pci to drop the TPH capability from the
   capability chain.

 - Patch 3/ exposing the enum to callers is a bit ugly, maybe we should
   retain pci_enable_tph() as the "auto" wrapper, resulting in no
   change to existing users, and add _ext and _std wrappers.

 - Patch 4/ same, multiple wrappers keeps the "auto" api cleaner.  Also
   note that auto is broken before TPH is enabled when tph_req_type is
   zero.

 - Patch 6/:
   - mutex_init/destroy belong in vfio_pci_core_init_dev/release_dev()
   - Re-order to avoid forward declarations.
   - vfio_check_feature() does not require declaring PROBE as a
     supported op.
   - pcie_tph_set_st_entry() can write to MMIO space without testing
     for or enabling device memory or power state.
   - tph_init allocates shadow table regardless of opt-in for tph
     support.
   - Redundant tests for count/index in feature function.
   - Duplicate memcpy/kfree in feature function.

 - Patch 7/:
   - Unclear why it's vfio-pci's responsibility to provide this
     translation interface.
   - PROBE is unnecessary for vfio_check_feature().
   - Array size conversion is strange.

 - Patch 8/:
   - default config read handles emulated bits.  Clear the bit if
     necessary in vconfig, use p_setd() to mark PCI_TPH_CAP_EXT_TPH
     virtualized, read-only.
   - Follow examples like vfio_pm_config_write, vfio_vpd_config_write,
     vfio_exp_config_write, etc.  Set the virtualized and writable
     bits, perform default config write, evaluate if anything was
     enabled, effect the change in hardware via kernel APIs.
   - pcie_disable_tph() happens after the restore state is recorded.
   - TPH capability becomes read/write, an ABI change to the user, with
     only a host-based opt-in.  Seems like the userspace driver also
     needs to opt-in to the ABI change.
   - Memory enable not assured for pcie_tph_set_st_entry().
   - Sashiko notes there are existing hazards in the tph_enabled
     storage unit relative to multiple bitfields that can be updated
     concurrently.  The problem is worse with this exposed through
     vfio-pci.

Thanks,
Alex
