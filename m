Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF93557F3;
	Wed,  3 Jun 2026 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509516; cv=none; b=CIKjayoUhL+YYIISJQhgl17ZhY7Jz/dnhLNWeR/Enh599nXxX+W50ILF6zVpWKJ7RXjUeN4zcJ1kr+/F9elOJAw88YdsPoATVsu41NsrUh17Qq3yBMh3au4w3P5/AsnY0gtM7b2XxscNRIniGLl8vmgKBlV7yFT1hlVz4UOUUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509516; c=relaxed/simple;
	bh=XCZVfbUq+NtLi9h9dNX3wljSjcgEuqKEmriX0TqT1+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMclMYYkDlXwnWaskYWvp8crBchyA84BnCTzyiXHOcfIu7sH+tdXf4wDLp16imMR2/kbynCsgf5CeXlnpV2IkOGYXfxrz9A7e/y1HSXTZ2p5gFtY76p+NKxcCdvb+U5dkNxSmF/Y/lPQbmR8RCwk1InVDInzSL0p1NjI2wqty7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=TVBB/EWN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VzhTMtFI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="TVBB/EWN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VzhTMtFI"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9360C1D00168;
	Wed,  3 Jun 2026 13:58:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 03 Jun 2026 13:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780509512;
	 x=1780595912; bh=/hyimqtR3dJ5OSnVN0tycpqCgAq8wZ0lo2UnF9x9zw4=; b=
	TVBB/EWNtgL9Q9if4oobSp6uYZT7zRhR4fDLBvg0MZhNIHIh2RsN7VFfqJ+bOvmx
	uEvcCdAH8y/U8r3OfsdeVL/u5VJokPMBveYEuPET+FIlo6MyTVzn2fTJ/lZCqwqd
	W7GRdzOx1/6JhPArcVe66fwgOPkvfTjDqysmUj4QjComwBskSb2b+yKxFgVZghSo
	+WMH8+HkFviW6uDwvMwTpMeDq2EhDVLZ7/ieIBI4Ca6nWeGg7Va3eFoGistnrDoF
	ewUbwK8zX5wwMRUEaUxHOIFeUK7pdH8F10nWuGUK5bJSCWkk5DcISYpduYRBKo1X
	YXqdLU2sdWKZEJTgerVypA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780509512; x=
	1780595912; bh=/hyimqtR3dJ5OSnVN0tycpqCgAq8wZ0lo2UnF9x9zw4=; b=V
	zhTMtFIQW2q/Lqigo+5Trpn61eg53OdxjThbxigG+AFFop0C/gQ/siIhzVALXwmR
	kCYYcfAP9swK9ikYygKwde/tvEIF1vt33ZJ6Vk3xwuOLyZ7awMbqwwo1cG6vZOr6
	BWTGyV1f2srCAmt+E1+Xb8R4oW+NzpmoLF319jwr2ft06WxSMll7WwsYMPwvyKoO
	+rnaMWZXu2KZTwif2oohUIxWCDdOV1kqCZxLPsqTK8KntZtUiiuBCJXAOZam9Epp
	9Pt10dP90w/mGWvvZVfgjTBOd2yeUfRdTGli5nzQcqmJu2ffSWweexPc2AZZ2LHl
	v9YZnn7ihgJaLoQX4Ye6A==
X-ME-Sender: <xms:R2sgakfTa0y8eAGD7TQuL7kdSH-S0uojubUjLRkW5RsVsWI7AQ-ANg>
    <xme:R2sganz83PPOPENsX0TuNzhL5auMNRbe4_aMV69lzCsLiN5n7qnZ4Lzz6Ysw-ainB
    402LkL_SRoIkI7OSzzfxgeRC7GKgV2EkY5J724IfRWtmMLdD3xIEBs>
X-ME-Received: <xmr:R2sgakx_yfDVqZXyuzANs5gsbpNd1VZ_vjJQIF0kS1GqNjeO__7K_UYDqvg>
X-ME-Proxy-Cause: dmFkZTEb3F3VfJcFBZ0xYpcN9Zp/SWYi8J6XsDYqlGHMDUQhXDkYx8wDBYnTnwwAxdMNoN
    /ebJJ7G8AkyfCHPesErchj4FkJ7AdZ3CYGDTP41B5kV5QuSX5U+a0CtpAYQ8W87wtf6RvA
    c4xrhupsru9ILIE54VpjvF8Hc0N9pVoNVTqZKNb4EUfq6ivopM0y/RUkLws80KQZ3yjzdH
    SsnfFT/dPin/Ie5Np9h6n1h++eifHpgc9Q4Q1YWP6b12Gy/+SG1ephCl1NDqFKtFA1GZoz
    pY/uXyfExlYixJ4YIFVWbejzzL8hKh1bByGI1t1EpS29NYK4nGQNhXuYDCyxRIVfxFclHZ
    udI/LkHWyX3o+9pQacHM0ElwO7F5Yh5Vk3NDrscMVvkxcsAHFiI9W3Jwfswux+VIVWnLUq
    2otrbDsHCzZ8vT2jIyCL3knQU5RJz/UqrlLOLlRLWCWWfReRgGGGGYplW9zm7e3yHjA268
    Ppl0eneWwEPbwt027AlJl9nKlykR3p8rxX02xK1QJ7D2uriK1wPk4WdvB8NCtgGnhVp6BE
    w0vavPi+AV0q8Umq3XsrrN+MQi+iY+m6ouVMRz2OE5t7auQTxW8IvPIXnwe10oa09ElOqJ
    KOSdFC8FVLm5JKfKC/TqXYNc2Dyslvfc84se1i6rNH/5ewd4qNdlrxL1AExw
X-ME-Proxy: <xmx:R2sgagZNOPsjr3haXeD1RE9mqzAjo_dm5o-6jbRR6QvY8UGb9UY4GA>
    <xmx:R2sgal09TYuKOWttpxY8WgfAKsRggqsun9dqzOsuC9gYXMUC2i1d-w>
    <xmx:R2sgaictKz8XxcSgiwcgRYVJKsak_f4NwAKkXIFduDcE58ws9vWaDA>
    <xmx:R2sgaiJl157Kn8cOscq8Bu7UqlV48dM92FDvaJj3jhB4W97N4li1jQ>
    <xmx:SGsgagQBBAaXj87kuRC9gEMZT7Yq8Khp6QCpTbyo5lrMeLSrGm6wG5ko>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 13:58:30 -0400 (EDT)
Date: Wed, 3 Jun 2026 11:58:28 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v14 0/8] vfio/pci: Add PCIe TPH support
Message-ID: <20260603115828.21216c0f@shazbot.org>
In-Reply-To: <3f8d1722-6749-4f3a-b630-c96303cec284@huawei.com>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
	<20260601095840.3aaaa508@shazbot.org>
	<59c82855-59a7-4f0e-b534-d35535d04b93@huawei.com>
	<20260602170847.75bd159d@shazbot.org>
	<3f8d1722-6749-4f3a-b630-c96303cec284@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 08:34:53 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> On 6/3/2026 7:08 AM, Alex Williamson wrote:
> > On Tue, 2 Jun 2026 22:46:13 +0800
> > fengchengwen <fengchengwen@huawei.com> wrote:  
> >> On 6/1/2026 11:58 PM, Alex Williamson wrote:  
> >>>
> >>>
> >>>  - Patch 2/ sets tph_cap to zero if TPH cannot be enabled, but this is
> >>>    never propagated to vfio-pci to drop the TPH capability from the
> >>>    capability chain.
> >>>
> >>>  - Patch 3/ exposing the enum to callers is a bit ugly, maybe we should
> >>>    retain pci_enable_tph() as the "auto" wrapper, resulting in no
> >>>    change to existing users, and add _ext and _std wrappers.
> >>>
> >>>  - Patch 4/ same, multiple wrappers keeps the "auto" api cleaner.  Also
> >>>    note that auto is broken before TPH is enabled when tph_req_type is
> >>>    zero.
> >>>
> >>>  - Patch 6/:
> >>>    - mutex_init/destroy belong in vfio_pci_core_init_dev/release_dev()
> >>>    - Re-order to avoid forward declarations.
> >>>    - vfio_check_feature() does not require declaring PROBE as a
> >>>      supported op.
> >>>    - pcie_tph_set_st_entry() can write to MMIO space without testing
> >>>      for or enabling device memory or power state.
> >>>    - tph_init allocates shadow table regardless of opt-in for tph
> >>>      support.
> >>>    - Redundant tests for count/index in feature function.
> >>>    - Duplicate memcpy/kfree in feature function.
> >>>
> >>>  - Patch 7/:
> >>>    - Unclear why it's vfio-pci's responsibility to provide this
> >>>      translation interface.
> >>>    - PROBE is unnecessary for vfio_check_feature().
> >>>    - Array size conversion is strange.
> >>>
> >>>  - Patch 8/:
> >>>    - default config read handles emulated bits.  Clear the bit if
> >>>      necessary in vconfig, use p_setd() to mark PCI_TPH_CAP_EXT_TPH
> >>>      virtualized, read-only.
> >>>    - Follow examples like vfio_pm_config_write, vfio_vpd_config_write,
> >>>      vfio_exp_config_write, etc.  Set the virtualized and writable
> >>>      bits, perform default config write, evaluate if anything was
> >>>      enabled, effect the change in hardware via kernel APIs.
> >>>    - pcie_disable_tph() happens after the restore state is recorded.
> >>>    - TPH capability becomes read/write, an ABI change to the user, with
> >>>      only a host-based opt-in.  Seems like the userspace driver also
> >>>      needs to opt-in to the ABI change.
> >>>    - Memory enable not assured for pcie_tph_set_st_entry().
> >>>    - Sashiko notes there are existing hazards in the tph_enabled
> >>>      storage unit relative to multiple bitfields that can be updated
> >>>      concurrently.  The problem is worse with this exposed through
> >>>      vfio-pci.    
> >>
> >> Thanks for review, all your comments are resolved in v15:  
> > 
> > Not everything.  At a glance I can see that v15 is still pushing for
> > vfio-pci to provide the interface to translate CPU IDs to steering
> > tags, despite my push back above that it doesn't seem within vfio-pci's
> > scope to provide a CPU ID -> ST interface.  
> 
> This translation helper is required to handle varied TPH configurations,
> including cases where ST entries live inside device private registers
> instead of MSI-X or TPH capability space.
> 
> Prior discussion with Jason (
> ref: https://lore.kernel.org/all/20260414151125.GF2577880@ziepe.ca/)
> indicated VFIO-PCI is the correct component for per-device TPH
> implementation.
> 
> Production high-speed NICs from multiple vendors rely on this CPU-to-ST
> mapping logic for DPDK optimized polling I/O; removing this helper would
> render the whole TPH userspace control feature unusable for existing
> target workloads.
> 
> Therefore, I believe it is appropriate to support it.

The citation is only describing that vfio should provide a way to
program the steering tags.  That's not the issue I'm raising.

The proposed uAPI has morphed from one where the user provides CPU IDs,
which are translated to STs and written to the device or returned to
support device specific implementations, to one where raw STs are used.

I think this was a result of my question of how this interface
integrates with the concurrently proposed interface where drivers can
expose TPH values for a dmabuf.  Suddenly the user is managing raw TPH
values and what used to be an integrated feature of performing CPU ID
to ST value, with necessary ugliness of exposing that raw ST value for
device specific support, becomes largely a standalone translation
interface, which might be more generically implemented elsewhere in the
kernel.  It largely loses any direct association to the vfio aspect of
the device.

The interface now looks more like one where raw STs are provided to
vfio-pci through various sources.  It then becomes unclear why vfio-pci
itself is necessarily one of those sources.

> > The host-only opt-in issue above also doesn't appear to be addressed or
> > rebutted.  
> 
> enable_unsafe_tph host opt-in already fully gates all new TPH ABI:
> TPH cap + feature ioctl are completely hidden from userspace when off,
> no userspace opt-in needed.

I'd argue that opt-in on the host doesn't mean we should ignore the ABI
change to userspace.  There's an entire virtualization stack that needs
to be built on this change, intercepting writes to the TPH control
register, MSI-X vectors, and capability ST entries.  The host opt-in is
a global switch, it might enable your userspace driver, but it might
also break QEMU, where writes to the TPH capability had been dropped
previously.  A per instance opt-in, gated by the host opt-in, allows
seamless integration of the new feature.

> > Typically v15 would be an indication that a series is coming to
> > maturity, but with the quick cadence and lack of discussion throughout
> > this development, I'm not even sure we've arrived at a proper uAPI for
> > this feature.  Thanks,  
> 
> Sorry for sending frequent quick updates without leaving adequate window
> for list review.
> 
> This feature originates from an earlier ARM prototype posted last year for
> DPDK TPH acceleration scenarios. Based on that foundational exploration,
> this series has refined the interface through continuous upstream review
> feedback.
> 
> All recent rapid iterations are code improvements and review fixes.

The issue is that feedback like above is represented as if it's been
addressed and changelogs are scant on details, requiring significant,
repeated effort to understand the actual changes between iterations.
The issues raised and interface design require discussion, not simply
assertions that it's correct and addressed.  Thanks,

Alex
