Received: from mail-m15593.qiye.163.com (mail-m15593.qiye.163.com [101.71.155.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BB35E958
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411753; cv=none; b=XovwJiYydfV5mBqW2UPRu06nL7wPH+9134SVOXjhYpqvd3MS3W0Cm0ZaKhvcFtGXcic+A2KhnUELpfwOSu8rxMz7zrpfTc7uVwtX+8eYaxV/E3LB/eq183kybDDpCfWT1nhm0Lvo5AYxCDGot3HCTvCrgaWDoPhcDplLE2yPgdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411753; c=relaxed/simple;
	bh=Lv8UrQCBu76i7BUozl7qVybpJwIkDhOQ7VSQNiiDJKU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HrIKXrvQKan9yTe+8ZMXyFtRfuaVz0M3WXy2BnYsMECJNae8sD1yncKN1tqd6UCZNWNcIgOgacNv1Z+F3eaO5rPt0U4n4T94yNbQdK2cD/5moLZvNj5H/9hpOno3GnnaTxLhvIUXZ8Rp+Qco6UUMla3kXKMllEWol9b55a9boVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QVdVsx8B; arc=none smtp.client-ip=101.71.155.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QVdVsx8B"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c5ae00d9;
	Thu, 3 Sep 2026 11:46:50 +0800 (GMT+08:00)
Message-ID: <4f3a7804-1b3b-4060-97c6-74b6259da42a@rock-chips.com>
Date: Thu, 3 Sep 2026 11:46:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: Do not recreate the INTx irq domain
 on root port reset
To: sashiko-reviews@lists.linux.dev
References: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
 <1788403477-71491-3-git-send-email-shawn.lin@rock-chips.com>
 <20260903031310.5FA0F1F000E9@smtp.kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260903031310.5FA0F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0656061aa03a4kunm0fa46cde6e633
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTE9KVkhPGB5CGUlCSB1NSFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QVdVsx8BwvmNSWlA1Jgw59+PNtisqbo8ehFGvOGPx2KrU/TBgSz7VzkCFPZy4OvMfO5pNt9xdEiRsbBQY5MN1JYQhnnrZxbKb5xtoTpwDUx+5OgPIfbYMkm3htR5yf00Lvk/TdQDbl5SSxGIQ/7T/G+hkBXU/egwm+xo4iCeNe4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=U15kSfCTzdbxYs1MBnMYhfo1LVk1PFMkYOz4UshbUa4=;
	h=date:mime-version:subject:message-id:from;


在 2026/09/03 星期四 11:13, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Probe error path and driver unload fail to clean up INTx irq domain and chained handler, leading to a potential use-after-free and memory leak.
> - [High] Disabling clocks during root port reset without masking IRQs can cause a synchronous external abort.
> - [High] Double PHY de-initialization permanently bricks the PCI controller on subsequent resets.
> - [High] DBI registers are accessed before the controller is set to RC mode during root port reset.
> --
> 
> commit 2778c4d5819445db0e096281981b7df261e7bc31
> Author: Shawn Lin <shawn.lin@rock-chips.com>
> 
> PCI: dw-rockchip: Do not recreate the INTx irq domain on root port reset
> 
> This patch extracts the programming of Root Complex registers out of
> the .init() callback into a separate rockchip_pcie_host_hw_init() function.
> It then calls this new function from .reset_root_port() instead, ensuring
> the INTx IRQ domain and chained handler are set up only once at probe time.
> 
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index 50824c8b1d83e..ff9239403cf22 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> [ ... ]
>> @@ -440,13 +459,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>>   	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>>   					 rockchip);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is it possible for the INTx
> irq domain and chained handler to be leaked on probe failure or driver
> unload?
> 
> If rockchip_pcie_host_init() or a later step in probe fails, devres will free
> the rockchip structure. However, it appears the irq domain is created in
> rockchip_pcie_init_irq_domain() without devm management and is never removed.
> Additionally, the chained handler is assigned with the rockchip structure as
> data but is never cleared on the error path.
> 
> If the legacy IRQ fires after probe failure, could the chained handler
> (rockchip_pcie_intx_handler) dereference the freed rockchip pointer and cause a
> use-after-free panic? Also, since the driver lacks a .deinit callback, does
> this permanently leak the domain on module removal?
> 
> [ ... ]
>> @@ -920,11 +933,7 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
>>   	if (ret)
>>   		goto deinit_phy;
> 
> [Severity: High]
> This is a pre-existing issue, but does this jump lead to a double PHY
> de-initialization that permanently bricks the PCI controller?
> 
> If the reset fails (e.g., dw_pcie_start_link() fails later in this function),
> the code jumps to the deinit_phy label and calls rockchip_pcie_phy_deinit().
> However, rockchip_pcie_rc_reset_root_port() already unconditionally calls
> rockchip_pcie_phy_deinit() near the top of the function.
> 
> If the PCI core attempts another reset later, the unconditional deinit at the
> top will execute again. Does this erroneously drop the PHY's power_count and
> init_count from 0 to -1, causing subsequent rockchip_pcie_phy_init() calls to
> silently fail to power on the PHY?

I don't think there is an unbalanced deinit here. The unconditional
rockchip_pcie_phy_deinit() at the top of
rockchip_pcie_rc_reset_root_port() pairs with the
rockchip_pcie_phy_init() done at probe time, while the deinit_phy label
pairs with the rockchip_pcie_phy_init() performed inside this same
function. Every path keeps the pairs balanced: on success the PHY ends
up initialized exactly as it was before the reset, and on the error
paths the function unwinds precisely the initialization it performed
in this invocation. The only way to skew the refcounts would be
reset_control_assert() failing on two consecutive reset attempts, and
after the first such failure the controller is already dead.

> 
> [Severity: High]
> This is another pre-existing issue, but can disabling clocks during root port
> reset cause a synchronous external abort (SError) if the chained IRQ is not
> masked?
> 
> Earlier in rockchip_pcie_rc_reset_root_port(), the controller clocks are
> disabled via clk_bulk_disable_unprepare() before resetting the hardware. If an
> unhandled interrupt fires concurrently while the clocks are disabled, the CPU
> will attempt to execute rockchip_pcie_intx_handler(), which directly reads
> PCIE_CLIENT_INT_STATUS over the unclocked APB bus.
> 
> Should the chained IRQ be explicitly masked (or disable_irq() used) before
> disabling the clocks to prevent accessing unclocked APB MMIO space?


Ack, this is a real issue introduced by b376b3ff9cb0. Devices may keep
their INTx line asserted while the controller clocks and PHY are gated
during the root port reset, so the chained handler can run and read the
unclocked APB bus.

I will send a follow-up that masks the INTx IRQ before turning the
clocks off and re-enables it once the clocks are running again. On the
error paths the clocks stay gated, so the IRQ is deliberately left
masked there.


> 
>> -	ret = pp->ops->init(pp);
>> -	if (ret) {
>> -		dev_err(dev, "Host init failed: %d\n", ret);
>> -		goto deinit_clk;
>> -	}
>> +	rockchip_pcie_host_hw_init(pp);
> 
> [Severity: High]
> This is a pre-existing issue, but does rockchip_pcie_host_hw_init() access DBI
> registers before the controller is explicitly set to Root Complex mode?
> 
> During reset, rockchip_pcie_rc_reset_root_port() applies a hardware reset via
> reset_control_assert(). It then calls rockchip_pcie_host_hw_init(), which writes
> to DBI registers (like PCI_BASE_ADDRESS_0) and accesses PCIe capabilities.
> 
> Since the controller is instructed to act as a Root Complex
> (PCIE_CLIENT_MODE_RC) only after rockchip_pcie_host_hw_init() returns, does
> accessing the PCI configuration space prematurely violate hardware state
> constraints and risk an SError on the AXI bus?


This ordering is not introduced by this series: the original
.reset_root_port() implementation (b376b3ff9cb0) also called
pp->ops->init() — which performs the same DBI accesses — before writing 
PCIE_CLIENT_MODE_RC, so the order is unchanged. Also, the DBI
aperture is just memory-mapped configuration space behind the APB/AXI
bus; it does not depend on the PCIE_CLIENT_xxx mode bits, which select
the  link/LTSSM behaviour rather than gating config space access.

> 
>>   
>>   	/* LTSSM enable control mode */
>>   	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
> 

