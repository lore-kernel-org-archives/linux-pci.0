Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007E5411FB8;
	Thu, 13 Aug 2026 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601203; cv=none; b=Q7H2PQDiXbKtXMcMxbd4Ta9z/PYQsBgFaLELID3hsjLHUHksZUffzpdmxHdjS6YJ2JJUY7zRSVuBYb8GAYvUyaodHSlc4WAYnroUyInLWE87RrQcZY+C+BosPeHaN6mEKK8Kp+cBbE+XZs3tWqJlGh8bJJd+OnOABPw98AZpX/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601203; c=relaxed/simple;
	bh=q4VOCvN9so/bl5JTL2R3NK0NEV3t15qu4E+uHTJMXmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYCB7noDxK6PtSW1txhARE5nb/SbZnSeiJU8dkS+qfeHv5AvpL6tzN12cXN8bZB4lhc3Zi+xkVTqGHhC6Vgq0+8J77W/7E4NJ1RXlpLKNkKrABxjVKqCZO0AVsb9mYg/CXRqgXH3ImhoWq62YAzTysWJeOAYJvK8PQdF/Gf7MZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WepnVrP8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WepnVrP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2EA1F000E9;
	Thu, 13 Aug 2026 06:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786601201;
	bh=2bRU4db2xtFcGOhDIJOKkQ4ShBGU9e2BMEUZzod3loM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WepnVrP8FwDHztG5a+pL5+vdR+Cg8T4y90PcZBh/rlnZNWLRLfnDWWRxVJvS0+crZ
	 lh7fpDVlbqh/6qvpmhacKyRBEAArsqvbDDRNZsTZ84+InSYC+LQE/2ApqTgrggsNhH
	 YhxB5J0+AVZSQsk4LoO4+RjU9GDi4VJ7LjJUaYY3sLwr0c5vz/7/bRPur4asCQDR1r
	 cNVYLKjWL4z4LWF+Z0JghcCDVi9WN26c7VGLvxJXgFSrnHhF5fGl1dbGiWnRcm8sU1
	 SI1/W2qha+159VhpFETiKxPs27GXkyYyN7ajSyXNSy7VOA36iIT+UpNy1PI2kQZa1m
	 WhxFEX5ERcXyQ==
Date: Thu, 13 Aug 2026 08:06:31 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	jingoohan1@gmail.com, imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/16] PCI: dwc: Use cached PCIe capability offset in
 core
Message-ID: <ps2qzgcb5lixkoqz2xbofdurkgmsiojg7e5ueqfdhyissqvzf2@tuderrjgzg6b>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720150619.24733-3-18255117159@163.com>

On Mon, Jul 20, 2026 at 11:06:05PM +0800, Hans Zhang wrote:
> Modify the DWC core functions to use the cached pcie_cap offset instead
> of calling dw_pcie_find_capability() each time.
> 
> In the DWC core, dw_pcie_find_capability() is called at several locations:
> - dw_pcie_ep_init_non_sticky_registers()
> - dw_pcie_wait_for_link()
> - dw_pcie_link_set_max_speed()
> - dw_pcie_link_get_max_link_width()
> - dw_pcie_link_set_max_link_width()
> 
> The cached offset is initialized after hardware is ready:
> - In host mode: dw_pcie_host_init() calls pp->ops->host_init() (enables
>   clocks/resets), then dw_pcie_get_pcie_cap() caches the offset.
> - In endpoint mode: the core no longer caches automatically. Instead,
>   drivers must call dw_pcie_get_pcie_cap() after hardware is enabled
>   (e.g., after PERST# deassert).

But you didn't modify all DWC EP drivers to call dw_pcie_get_pcie_cap(). This
can lead to pcie_cap being 0.

> dw_pcie_ep_init_non_sticky_registers()
>   is called after that point, so it can safely use pci->pcie_cap.
> 
> dw_pcie_ep_init_non_sticky_registers() now assumes pci->pcie_cap is
> valid. if not, it prints a warning and skips the operation.

Where is this warning printed?

These are already pointed out by Sashiko. You should go really go through all of
them (not the pre-existing issues) and comment whether the issues are valid or
false positive. For a series touching many controller drivers, this is necessary
to avoid introducing regressions.

I'm not going to merge this series until you fix the real issues Sashiko
reported or mark them as false positive if not valid.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
