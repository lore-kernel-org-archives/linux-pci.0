Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F633A708;
	Wed,  2 Sep 2026 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356579; cv=none; b=nqydg0+GHu6YsHTeLpOSggJOzES/eYoe8bBvMtAv+kDg5N44zjkUI90wjqw/yYIti6JlfJ+dCuau1g0NyPwTLdFd97FnY4T6b6J0gk8JA1cnQUX7C4s6p0C0r2S6ZoQzvGV8v1Fdw4p8uoe8mH8U3VQLmVjJphrrTL9n67SYpHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356579; c=relaxed/simple;
	bh=HimctPAdl4uhknz5inQXUbfZ8T9s+MHwTRvwmhBPoIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toETEDzHa7y5Mccl7iPS1avLoyPiOOTLfuIZD2fAV7kkuIUWP8g3GZzc7SiF6X0xQxiDSj349f4wdqNggd8rIbU7VpgBD8cGc+TIF0+V9sN4lHsE2kwZ7JNGj7nE6XICFmdlYIthjJiGAwWf1uB+yxaQfoMxnzyxk9cxq0xgjaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbnRy+qB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbnRy+qB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7843C1F00A3F;
	Wed,  2 Sep 2026 13:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356575;
	bh=qhAEz77Y2kZ1jZ+VILUhus+BJGUXN2LMY1ixFi2XZHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IbnRy+qBeV/o5vIsvzltys0xmFQ+2EOsgmvL/OsE6rAhpziJhvHXVb+YAAttbvzwj
	 7j5k5CvFbSNpW6oj6nO9yeIXIUTa8LLtPgqiWImU+W9307XnaADrwZgoGmvYPqcK16
	 HqgwxzO/N+GwvjTGmjfTtJAr3fw/ExygS0DSWxlL0PEELwaNLTOor73xtveXYYbWRY
	 gNIGaeb6gaZ4k2pljjeTrik6Jy0IGFQkegPbRp0J8epAB+Icu+s4WfwbN31rF5Bnyf
	 BdUTuoSxzyHs+/ZdFPoTpyysUZYuiSudwxLRpUtVXY/vmx+IZMAj/485sCT6pNYizH
	 fJq2J2O6mzp9w==
Date: Wed, 2 Sep 2026 15:42:41 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: spacemit@lists.linux.dev, Alex Elder <elder@riscstar.com>, 
	Bruno Banelli <bbanelli@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, Alex Elder <elder@riscstar.com>, Yixun Lan <dlan@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] PCI: spacemit-k1: port C probe hard-hangs a CPU with one
 endpoint on Milk-V Jupiter
Message-ID: <c24pt2ls62rxxg77xjbng7dmiflgdjlqd3mkoxehc2rvjgh7ai@dcxvmau3ykmt>
References: <20260825052249.66921-1-bbanelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260825052249.66921-1-bbanelli@gmail.com>

On Tue, Aug 25, 2026 at 07:22:49AM +0200, Bruno Banelli wrote:
> Hi,
> 
> On a Milk-V Jupiter, probing the PCIe controller at ca800000 (port C, the
> card slot) permanently wedges the CPU that runs the probe when one
> particular add-in card is installed.  The CPU stops responding to NMI, and
> because the probe is asynchronous, kernel_init() then blocks forever in
> async_synchronize_full() and the machine never finishes booting.
> 
> The same card, in the same slot, on the same board, does *not* hang the
> vendor 6.6 kernel -- it reports "Phy link never came up" and boots normally.
> Six other cards do not hang mainline either.  So whatever the electrical
> cause, this looks like a robustness problem in pcie-spacemit-k1: an endpoint
> should not be able to hang a host-side DBI register access.
> 
> 
> HARDWARE
> --------
>   Milk-V Jupiter v1.1, SpacemiT M1 (socinfo: CPU[M1-8571] REV[C] DRO[130]),
>   16 GiB LPDDR4X.
>   Firmware: stock vendor U-Boot 2022.10 (k1-bl-v2.2.9), unmodified.
>   Port B (ca400000, M.2) has a Samsung PM9B1 NVMe and works throughout.
>   Port C (ca800000) is the card slot -- an x8-length connector, silkscreened
>   PCIE_X2, wired x2.
> 
> 
> REPRODUCED ON
> -------------
>   v7.1 and v7.2, riscv defconfig (plus PHY_SPACEMIT_K1_USB2, USB_DWC3,
>   SPACEMIT_K1_TSENSOR, IGB, IGC, NVMe/ext4 built in).
>   gcc 13.3.0 (cross) and gcc 16.2.0 (native, Debian sid).
>   Identical failure in all combinations.  Not a regression -- port C has
>   never worked with this card on mainline.
> 
> Command line:
>   console=ttyS0,115200 earlycon root=/dev/nvme0n1p2 rootwait rw
>   swiotlb=65536 clk_ignore_unused pd_ignore_unused
> 
> 
> SYMPTOM
> -------
> Port C prints its address ranges and then never speaks again.  (Log below is
> from a run with port B disabled in DT, so nothing is interleaved.)
> 
>   [ 1.290074] spacemit-k1-pcie ca800000.pcie: host bridge /soc/pcie-bus/pcie@ca800000 ranges:
>   [ 1.297283] spacemit-k1-pcie ca800000.pcie:       IO 0x00b7002000..0x00b7101fff -> 0x0000000000
>   [ 1.312783] spacemit-k1-pcie ca800000.pcie:      MEM 0x00a0000000..0x00afffffff -> 0x00a0000000
>   [ 1.326753] spacemit-k1-pcie ca800000.pcie:      MEM 0x00b0000000..0x00b6ffffff -> 0x00b0000000
>   [22.348490] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>   [22.351764] rcu:     4-...0: (12 GPs behind) idle=051c/1/0x4000000000000000 softirq=43/43 fqs=1908
>   [22.367040] Sending NMI from CPU 2 to CPUs 4:
>   [32.367049] After 10 seconds, these CPUS still haven't responded to the NMI: 4
> 
> The CPU ignoring an NMI for ten seconds is why I read this as an MMIO access
> that never receives a completion rather than a spin or a deadlock.
> 
> 
> LOCALISATION
> ------------
> I added a dev_info() before each step of k1_pcie_init() (patch at the end of
> this mail).  The last marker port C prints is the one immediately before the
> first DBI access:
> 
>   [1.347050] spacemit-k1-pcie ca800000.pcie: K1DBG 1 toggle_soft_reset
>   [1.362635] spacemit-k1-pcie ca800000.pcie: K1DBG 2 enable_resources
>   [1.370918] spacemit-k1-pcie ca800000.pcie: K1DBG 3 first DBI write (vendor/device ID)
>   <nothing further>

Sounds weird that an endpoint is causing DBI write hang.

Can Alex or someone from Spacemit look into this issue?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
