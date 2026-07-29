Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1879DA;
	Wed, 29 Jul 2026 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334623; cv=none; b=liu+HaBVHm+898tkzI7Fsmv0/IFr38wF0ZkkHKLLDUUPHJf3ss1Re62Pm+Sc3QK/+M5kUlweEHkppD+FsFSJIatr1d0XzCGhrJYAMY9ulpKyHhpwsOZjf41WumK0g5ZKdg/Oh8cWYbCEAWsMd1v+y/XsoMSV9wnAiSTqtstqhRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334623; c=relaxed/simple;
	bh=eYRWGm2Vysd+Sf7CqIx6VpzjWVzzUhwdRCtmj1zPgys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1gMRI2KXpQC0qJbEJtNC2/KSJNRPXAOV1eb9W+RHX3ixVrhq5RjRbn1UwyuAirbdJxP5Rr3Dsfdc3OklUmT7T/A4eoTyg7wKu3fOQTuXoOhgpF1lQCyQ897Q0HFixuZ1wPIlnK6OTdV+fiHg+wWv62pKyJeT2wNVHX4z+SV3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpFpx28j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpFpx28j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875DA1F00A3A;
	Wed, 29 Jul 2026 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785334622;
	bh=b3fhcR8TMRAJ2vcf4kPvpuBp2e3NxZlvBaOGhUa5gFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dpFpx28jNXHDUHQe1rXDSgEqLU7Bey+s5v+7iN/r2TDS1RliH4j1325dVKGtpbFyD
	 XPD+9S3gXwrmgQlverYKxsod2XJPry46pFiTtWRutICMv0/9jEtBeh4lFLNLtsOU9Q
	 97QATTyKKDEhK8YdDcbNYNQiQg3n+iOJFnL/uPu7QUfrGgja4Vf4hyb2Gp2mVnLyEf
	 TzlKoNHvDFU01BPMmQYWvxMdWHtD1yeBlKeB+3PeGcXos39usCWtHB8mDiYujZsvVH
	 X+ppl6c/74x1VbCb0szEr/nWMrfXoQ2leVrbUwP0aGraG70TtAl4O/WMMVaz8VPfnt
	 6l3dNO1PvATWg==
Date: Wed, 29 Jul 2026 16:16:53 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	matthias.bgg@gmail.com, bartosz.golaszewski@oss.qualcomm.com, wenst@chromium.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH] PCI: mediatek-gen3: Initialize all resources before
 installing ISR
Message-ID: <o3gaucow3oeiojt6ciahj7yicwevewm22sbzi763a2qhmcd5wm@7q4p3qrlh3wb>
References: <20260716113142.46742-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716113142.46742-1-angelogioacchino.delregno@collabora.com>

On Thu, Jul 16, 2026 at 01:31:42PM +0200, AngeloGioacchino Del Regno wrote:
> If the bootloader leaves the PCI-Express MAC+PHY enabled before
> booting the kernel, an interrupt may be pending while probing
> this driver, which means that the chained interrupt handler is
> called as soon as the irq is enabled and handler is installed.
> 
> Since the mtk_gen3_pcie structure gets fully initialized only
> after installing the handler, that condition results in a NULL
> pointer kernel panic (mostly due to pcie->base being NULL, but
> other members will be uninitialized as well).
> 
> In order to resolve this, disgregate the mtk_pcie_setup_irq()
> function and partially do the same to mtk_pcie_setup(), so that
> all of the required resources are initialized before installing
> and enabling the interrupt handler.
> 
> Also, install the ISR after deasserting resets and powering up
> the PCI-Express MAC and PHY, by moving the call to the function
> irq_set_chained_handler_and_data() to the appropriate place in
> mtk_pcie_setup(), as hardware registers cannot be modified if
> the hardware is powered down and could result in a SError.
> 
> This makes sure that all resources are actually available and
> hardware is powered on before any registers operation is done.
> 
> Fixes: eddbac092e5f ("PCI: mediatek-gen3: Move mtk_pcie_setup_irq() out of mtk_pcie_setup()")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> The real issue starts with commit eddbac092e5f but this still goes
> a bit further by reordering things a bit, enabling the interrupt
> after powerup and but before port startup, along with getting the
> irq in mtk_pcie_parse_port(), where a bunch of other devicetree
> resources retrieval is done, grouping them in one place.
> 
> This actually resolves the following issue:
> 
> <6>[    6.877824] mtk-pcie-gen3 16910000.pcie: host bridge /soc/pcie@16910000 ranges:
> <6>[    6.877854] mtk-pcie-gen3 16910000.pcie:      MEM 0x0050000000..0x0057ffffff -> 0x0050000000
> <1>[    6.877972] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000184

These error logs should be part of the patch description. Please trim it as per:
Documentation/process/submitting-patches.rst

> <1>[    6.877978] Mem abort info:
> <1>[    6.877980]   ESR = 0x0000000096000004
> <1>[    6.877983]   EC = 0x25: DABT (current EL), IL = 32 bits
> <1>[    6.877988]   SET = 0, FnV = 0
> <1>[    6.877991]   EA = 0, S1PTW = 0
> <1>[    6.877993]   FSC = 0x04: level 0 translation fault
> <1>[    6.877996] Data abort info:
> <1>[    6.877998]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> <1>[    6.878001]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> <1>[    6.878005]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> <1>[    6.878008] [0000000000000184] user address but active_mm is swapper
> <0>[    6.878012] Internal error: Oops: 0000000096000004 [#1]  SMP
> <4>[    6.878018] Modules linked in:
> <4>[    6.878027] CPU: 0 UID: 0 PID: 82 Comm: kworker/u32:3 Tainted: G        W           7.1.0-rc5-next-20260525+ #1700 PREEMPT(full) 
> <4>[    6.878037] Tainted: [W]=WARN
> <4>[    6.878040] Hardware name: Google Hylia SKU1/2/4/5 board (DT)
> <4>[    6.878044] Workqueue: async async_run_entry_fn
> <4>[    6.878060] pstate: 034000c9 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> <4>[    6.878068] pc : mtk_pcie_irq_handler+0x40/0x1f0
> <4>[    6.878082] lr : handle_irq_desc+0x3c/0x68
> <4>[    6.878095] sp : ffff800080003f50
> <4>[    6.878098] x29: ffff800080003f50 x28: ffff000080b7d3c0 x27: 0000000000000000
> <4>[    6.878109] x26: ffffcc9bfd8ca990 x25: 0000000000000000 x24: ffff000080204a05
> <4>[    6.878117] x23: 0000000043400009 x22: ffffcc9bfb60793c x21: 0000000000000000
> <4>[    6.878125] x20: 0000000000000000 x19: 0000000000000184 x18: 00000000ffffffff
> <4>[    6.878133] x17: ffff3367f0734000 x16: ffff800080000000 x15: 00000000ffffffff
> <4>[    6.878140] x14: ffff000081866bd3 x13: ffff000081866bd5 x12: 0000000000000020
> <4>[    6.878147] x11: 0000000000000040 x10: ffff0000802136a8 x9 : ffffcc9bf9da34c4
> <4>[    6.878155] x8 : ffff000083149020 x7 : 0000000000000000 x6 : 0000000000000000
> <4>[    6.878162] x5 : ffff000083148ff8 x4 : ffff0000831491a8 x3 : 0000000000000000
> <4>[    6.878169] x2 : 0000000000000000 x1 : ffffcc9bfa594188 x0 : ffff000080b4c830
> <4>[    6.878177] Call trace:
> <4>[    6.878180]  mtk_pcie_irq_handler+0x40/0x1f0 (P)
> <4>[    6.878192]  handle_irq_desc+0x3c/0x68
> <4>[    6.878204]  generic_handle_domain_irq+0x20/0x40
> <4>[    6.878217]  gic_handle_irq+0x144/0x2c0
> <4>[    6.878224]  call_on_irq_stack+0x30/0x48
> <4>[    6.878231]  do_interrupt_handler+0x88/0x98
> <4>[    6.878239]  el1_interrupt+0x48/0xb0
> <4>[    6.878252]  el1h_64_irq_handler+0x18/0x28
> <4>[    6.878264]  el1h_64_irq+0x84/0x88
> <4>[    6.878271]  _raw_spin_unlock_irqrestore+0x14/0x68 (P)
> <4>[    6.878283]  irq_set_chained_handler_and_data+0xc8/0xe0
> <4>[    6.878294]  mtk_pcie_probe+0x98/0x4b0
> <4>[    6.878304]  platform_probe+0x64/0xc0
> <4>[    6.878317]  really_probe+0xc8/0x3f0
> <4>[    6.878327]  __driver_probe_device+0x168/0x1d8
> <4>[    6.878337]  driver_probe_device+0x44/0x128
> <4>[    6.878347]  __device_attach_driver+0xc4/0x198
> <4>[    6.878357]  bus_for_each_drv+0x8c/0xf8
> <4>[    6.878365]  __device_attach_async_helper+0xbc/0x148
> <4>[    6.878375]  async_run_entry_fn+0x3c/0x188
> <4>[    6.878385]  process_one_work+0x164/0x4f0
> <4>[    6.878391]  worker_thread+0x19c/0x320
> <4>[    6.878396]  kthread+0x138/0x150
> <4>[    6.878407]  ret_from_fork+0x10/0x20
> <0>[    6.878416] Code: 9100c000 f90037e0 f9400793 91061273 (b9400273) 
> <4>[    6.878421] ---[ end trace 0000000000000000 ]---
> <0>[    6.891047] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> <2>[    6.891051] SMP: stopping secondary CPUs
> <0>[    6.893869] Kernel Offset: 0x4c9b79c00000 from 0xffff800080000000
> <0>[    6.893873] PHYS_OFFSET: 0x80000000
> <0>[    6.893874] CPU features: 0x08000000,003c018b,a6c605a1,357e7663
> <0>[    6.893879] Memory Limit: none
> <0>[    7.258223] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
> 
> 
>  drivers/pci/controller/pcie-mediatek-gen3.c | 44 ++++++++-------------
>  1 file changed, 16 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 66c33a09dd95..2c28b8e983c3 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -903,25 +903,6 @@ static void mtk_pcie_irq_handler(struct irq_desc *desc)
>  	chained_irq_exit(irqchip, desc);
>  }
>  
> -static int mtk_pcie_setup_irq(struct mtk_gen3_pcie *pcie)
> -{
> -	struct device *dev = pcie->dev;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	int err;
> -
> -	pcie->irq = platform_get_irq(pdev, 0);
> -	if (pcie->irq < 0)
> -		return pcie->irq;
> -
> -	err = mtk_pcie_init_irq_domains(pcie);
> -	if (err)
> -		return err;
> -
> -	irq_set_chained_handler_and_data(pcie->irq, mtk_pcie_irq_handler, pcie);
> -
> -	return 0;
> -}
> -
>  static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
>  {
>  	int i, ret, num_resets = pcie->soc->phy_resets.num_resets;
> @@ -939,6 +920,10 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
>  
>  	pcie->reg_base = regs->start;
>  
> +	pcie->irq = platform_get_irq(pdev, 0);
> +	if (pcie->irq < 0)
> +		return pcie->irq;
> +
>  	for (i = 0; i < num_resets; i++)
>  		pcie->phy_resets[i].id = pcie->soc->phy_resets.id[i];
>  
> @@ -1175,10 +1160,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  {
>  	int err, max_speed;
>  
> -	err = mtk_pcie_parse_port(pcie);
> -	if (err)
> -		return err;
> -
>  	/*
>  	 * Deassert the line in order to avoid unbalance in deassert_count
>  	 * counter since the bulk is shared.
> @@ -1205,6 +1186,9 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  		}
>  	}
>  
> +	/* All resources are now available: install the chained handler */
> +	irq_set_chained_handler_and_data(pcie->irq, mtk_pcie_irq_handler, pcie);

As Sashiko pointed out, 'msi_set->base' is not set at this point.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
