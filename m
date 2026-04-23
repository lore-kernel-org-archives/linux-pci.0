Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FE3246E8;
	Thu, 23 Apr 2026 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956360; cv=none; b=snd7LaLkpOwMO7ll3Ws8Ke5I7lljDzZf1L71e1n6R4g9NpZLlyoZT76vUFG8V9aIdsbOUONto+tmEqYyT14SVKwZu3Fnj2p6yOxiHh9hskfkXJE1lRWC3jhurlz+Sq/9qkTURy9wypetY1VcVGvSt4QNJi8jpfyfsJ3AzJqvotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956360; c=relaxed/simple;
	bh=n7r8iN3op2gCbPkpb8d9KEiHBDYYHBQtjCw6R8Tk/0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvdKNUdhas/4LaRXh76fv6ppjfq5gYm/ajmErhHwQG67l1ICu2iPz9Lh0G6fmXT0ducDCpoFiJuEZdYEEfxP1dNge4WEk1LbQ2m41Z+C8Kzoqx1HjI4lRfp7/W1IiQo4440hl6VF6z/cvXVkheaZSGfKZFTV58a991p3s9H7pco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnyWTlFd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnyWTlFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD07AC2BCAF;
	Thu, 23 Apr 2026 14:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776956360;
	bh=n7r8iN3op2gCbPkpb8d9KEiHBDYYHBQtjCw6R8Tk/0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnyWTlFdiiqbEUVkwoV3Ky5zmmhRoq6tENIeaFJBClu/hY8d3yAk4fRA5DeabAkun
	 KfhhqVB3UAFR+HmakskFk0nL+Hk3xdNJCTL/dfwtVkeo07IYYq4wMwhll1rlpirP/6
	 Z66fyABZX+9cdvOewr744zh5CiqzAi5uHenP3ddN+10DhgAMnnVQx5soaPCOVGw/4F
	 KaGB5sEhW0sWyCo5yNog6pGHl+Ox6T8CYyXMfum/oy1WViZnaokEepbnOzQH4CEm/G
	 mobJqStK+acZGvywnXkYKBbKA4ZGSJL0eLrbVq6xouk1UQyzlKaM5cXxhUJAe0xa3/
	 3bmqwuPdQNIKQ==
Date: Thu, 23 Apr 2026 17:59:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: alex@shazbot.org, jgg@ziepe.ca, wathsala.vithanage@arm.com,
	helgaas@kernel.org, wangzhou1@hisilicon.com,
	wangyushan12@huawei.com, liuyonglong@huawei.com,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/5] vfio/pci: Add PCIe TPH support
Message-ID: <20260423145915.GG172828@unreal>
References: <20260423010851.46737-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423010851.46737-1-fengchengwen@huawei.com>

On Thu, Apr 23, 2026 at 09:08:46AM +0800, Chengwen Feng wrote:
> This series adds support for PCIe TLP Processing Hints (TPH) to
> vfio-pci, allowing userspace to manage device steering tags for
> improved performance and QoS in virtualized deployments.
> 
> The implementation follows a clean incremental structure:
> - Patch 1: Export pcie_tph_get_st_modes()
> - Patch 2: Introduce UAPI ABI and implement capability query to
>   let userspace discover supported TPH modes, ST table presence
>   and size. Also add module parameter enable_unsafe_tph_ds to
>   guard unsafe usage of TPH Device-Specific mode with no ST table.
> - Patch 3: Add TPH enable/disable with mode selection. Restrict
>   unsafe Device-Specific mode without ST table to be allowed only
>   when the module parameter is enabled.
> - Patch 4: Add interface to batch get per-CPU steering tags for
>   device-specific mode without standard ST table. This interface
>   is only available when the unsafe module parameter is enabled.
> - Patch 5: Add interface to batch program steering tag table
>   entries for standard TPH modes.
> 
> All user API definitions are finalized in the first patch and
> remain stable across the series. The design follows existing
> VFIO conventions and relies on kernel pcie-tph infrastructure.
> 
> To avoid potential security risks in virtualization environments,
> TPH Device-Specific mode without a standard ST table is blocked
> by default. It can only be enabled by administrators via the
> enable_unsafe_tph_ds module parameter for trusted bare-metal
> userspace.
> 
> This series addresses the TPH management requirements discussed
> in the RFC "Proposal: Add sysfs interface for PCIe TPH Steering
> Tag retrieval and configuration".

As in the RFC, this patch series still lacks an explanation of *why* it is
needed. Please describe the scenario that cannot be handled without these
changes.

Thanks
