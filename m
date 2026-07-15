Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93C823507B;
	Wed, 15 Jul 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122516; cv=none; b=ugV6axTOMrOoQoiQ8A5D+cbMy0uHSZRwZ3geRSxWWGSXemyJZ5oiDRPXCgMSblvIHUOdRxwZITZY/VhA6b8ggPNlFkdxBrDs5jQleTJucGpsVJDnwLsuyeogTvWyuVZA3TRO0Dn3OwWfjBKoNJsU6liF2wSQ+vm3BHbZ2GKGfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122516; c=relaxed/simple;
	bh=TgLdUmwDmzGPgi23G0G4GIx/b/V5izieQpWr+IlBbNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EezMB3MJtnAYHwnbeuFfKoi3JF/oKiTq9neTCHWz1CNCVUwZ/tOsduZPdGtOeNspyY70hs+XFG7nUJKJbUQ1vQqJJFzjo6HoWuCqbqEORXQ5WKfwtsQdSVQ4IWdeUztaITHFMx8X/uu6fW8K0Y5rsefvrQYz+eQcr0sAdNyGmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGTYVIse; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGTYVIse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609AE1F00A3E;
	Wed, 15 Jul 2026 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784122515;
	bh=F5IP7CBxQw7aJmKHnYNo9T0f4+G5JzG/un29+KPX9po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hGTYVIseNleRsBf9JsqVrcLshYjtLgyxGM4DU1iyW54hgsY2J4ryLY8wUGyXeMztl
	 6T8bEVLmRc8htGaoxZNp5BRn3t8eemwpu4y5qqu7Agv/ZVGmUukvfZhDe04FiyTCtn
	 ZnU4WOQ0fKaASt/z7vWag1eGbGgElJw6q0XupbbCVJZHM9taRpk0HXtQBuyxv8S6CG
	 A+AYvDeYUipZwEFMhujbnY8mmkxzI4EIWYMjSw+kVCwrFWyy6ywjF9rYa/nW67OV6R
	 88dxMO5vJNC5ta5iXKVHMujWdqD1N/jOdif4hAUs3IlAlI94GSlnuuPH4mBbgD4mIZ
	 O7hGfxSdDljtQ==
Date: Wed, 15 Jul 2026 15:35:08 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	s-vadapalli@ti.com, a-garg7@ti.com, robh@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/16] PCI: dwc: Cache PCIe capability offset and
 simplify drivers
Message-ID: <4xnbhjohkww2v5qdq4uehjsev6nx23nr4ss5lreos3adx5sgfp@s6465oz7og4j>
References: <20260530153101.695580-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260530153101.695580-1-18255117159@163.com>

On Sat, May 30, 2026 at 11:30:45PM +0800, Hans Zhang wrote:
> Hi,
> 
> The DWC PCIe core and its many platform drivers repeatedly call
> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
> PCI Express Capability structure. This is wasteful and makes the code
> verbose. Some drivers even search for the offset in suspend/resume paths.
> 
> Add a cached pcie_cap field in struct dw_pcie and a helper
> dw_pcie_get_pcie_cap() to initialize it once at the point when the
> hardware is ready. Then replace all explicit capability searches with
> the cached value across the entire dwc subtree.
> 
> **Safety analysis: DBI access timing**
> The PCIe Capability offset is read from DBI configuration space. DBI
> registers are only accessible after the controller's clocks, resets, and
> power are enabled. The following call graph demonstrates that all
> dw_pcie_find_capability() replacements occur only after hardware is ready:
> 
> - For Root Complex mode:
>   dw_pcie_host_init()
>     ...
>     if (pp->ops->init)
>       pp->ops->init   [enables clocks/resets]
>     dw_pcie_get_pcie_cap()   [caches offset]
>     ...
>     dw_pcie_link_up
>       pci->ops->link_up
>     ...
>     dw_pcie_start_link
>       pci->ops->start_link
>     ...
>     pci_host_probe
>     if (pp->ops->post_init)
>       pp->ops->post_init
>     ...
> 
> - For Endpoint mode:
>   dw_pcie_ep_init()
>     ep->ops->pre_init()    [enables clocks/resets]
>     dw_pcie_get_pcie_cap()   [caches offset]
>     dw_pcie_ep_init_non_sticky_registers() etc.
> 
> - Some platform drivers (e.g., layerscape-ep, tegra194) need the offset
>   before calling dw_pcie_ep_init() / dw_pcie_host_init(). They already
>   enable hardware themselves and explicitly call dw_pcie_get_pcie_cap()
>   before the core caches it. This is safe and ensures the cached value is
>   available for all later users.
> 
> Thus, no DBI access occurs before hardware is operational.
> 

Not true. As Sashiko pointed out, EP platforms like Qcom, Tegra, enable
resources like clocks only after PERST# deassert. So any DBI access before that
will cause sync abort.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
