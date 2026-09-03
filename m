Received: from mail-m32113.qiye.163.com (mail-m32113.qiye.163.com [220.197.32.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4022E2286
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 04:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411492; cv=none; b=E3OGrnRo13ly1m8fJLOYHK4fDmwDaQRZkrOptbPy9uyO9RJvKp+JCsf2EXFoWR+RfEv2/mFO5EL1LvpYune087fZT+WweDunx+5oc62G4SZVRPrfDdM6Bl5OefBIXSBeSv44xb9rg7PyIk2v3NYvRylJTQd1O/MoDPzJq1LoVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411492; c=relaxed/simple;
	bh=h4QNyVa06Y1yL3RWZbvOH1GQEk/7mlp+nr7a5hs7C5U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UwnYGFtWd/M2jhmcvtCIC2N7hsnbEmQ+/xZ6TMoFZDRJ5rkNs5lVGlFX62DHwtXaItnMgBWJosKfWMnX5owxdM0ziOJeHHJkQkGWElSoyfjRZmj++98i9yXceCSMDDzCH7ic8pfgSz4kMIj/aClQQi+ZofbioDzkc6jzJoTTgzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ct9KROZm; arc=none smtp.client-ip=220.197.32.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ct9KROZm"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c5aa23b7;
	Thu, 3 Sep 2026 11:42:24 +0800 (GMT+08:00)
Message-ID: <8b6879d5-1245-40f1-9601-269135f4db23@rock-chips.com>
Date: Thu, 3 Sep 2026 11:42:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dw-rockchip: Bail out if the INTx irq domain
 creation fails
To: sashiko-reviews@lists.linux.dev
References: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
 <1788403477-71491-2-git-send-email-shawn.lin@rock-chips.com>
 <20260903031209.B655A1F000E9@smtp.kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260903031209.B655A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0655c511103a4kunm1446f2a36db93
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTk9MVh0eGU8fQx1LS0pLQ1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ct9KROZm1HtCoM4PdcnqXj2PITYwmDWwieW5DLNS/HzLI3OyhR5DkzYKVDxeeg+Vz2dHVV5U2dN23u8/2gKj/RcJ1V/xEENok/ES1r05oROJzvpwW+bWktHQjDZhyvOL0rGqLQ5k4BOn0mm3p38lzcIm5a9nu8SmNxi3ckB7Nio=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=SKCatsD5Rtp3ytAz1Ba+scU6LM6ydSy8vFr0VwbMt3k=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/03 星期四 11:12, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but there is a missing IRQ domain and chained handler cleanup on initialization failure paths, leading to a memory leak and potential Use-After-Free.
> - [High] This problem wasn't introduced by this patch, but there is an unprotected lockless iteration over the PCI bus devices list in the threaded IRQ handler.
> --
> 
> commit e7543706c2d1058d78b54feb3252321efa4a390b
> Author: Shawn Lin <shawn.lin@rock-chips.com>
> 
> PCI: dw-rockchip: Bail out if the INTx irq domain creation fails
> 
> rockchip_pcie_init_irq_domain() can fail, e.g. when the DT node is
> missing its "legacy-interrupt-controller" child node. This commit
> propagates the error to abort probing instead of continuing with a
> NULL irq_domain, which previously caused a panic on the first INTx.
> 
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index af26a07c0c9e5..50824c8b1d83e 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -432,8 +432,10 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>>   	pci->dbi_base2 = pci->dbi_base + PCIE_TYPE0_HDR_DBI2_OFFSET;
>>   
>>   	ret = rockchip_pcie_init_irq_domain(rockchip);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>>   		dev_err(dev, "failed to init irq domain\n");
>> +		return ret;
>> +	}
>>   
>>   	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>>   					 rockchip);
> 
> [Severity: High]
> This is a pre-existing regression, but there is a missing IRQ
> domain and chained handler cleanup on initialization failure paths,
> which can cause a memory leak and use-after-free.
> 
> If rockchip_pcie_host_init() succeeds but a subsequent step in
> dw_pcie_host_init() fails (e.g., link training), the probe aborts and
> devres frees the rockchip struct. Because the driver lacks a .deinit
> callback in rockchip_pcie_host_ops, the IRQ domain allocated via
> irq_domain_create_linear() is leaked.
> 
> Additionally, the chained handler mapped via
> irq_set_chained_handler_and_data() is never removed. Can a subsequent
> legacy interrupt or spurious trigger invoke rockchip_pcie_intx_handler()
> with the devm-freed rockchip pointer, causing a kernel panic?
> 
> Does rockchip_pcie_host_ops need a .deinit callback to properly unwind
> these resources on failure paths?
> 

Ack, good catch. One correction though: the "driver unload" part does
not apply here. The driver is builtin (builtin_platform_driver()) and
sets suppress_bind_attrs, so it can never be unbound and there is no
module removal path. The probe failure window remains real though: if
dw_pcie_host_init() fails after the host ops .init() callback succeeded,
devres frees the rockchip structure while the chained handler still
points to it, and the INTx irq domain is leaked.

I will send a follow-up series that makes the INTx irq domain devm-
managed via devm_irq_domain_instantiate() and uninstalls the chained
handler through a devres action, so that both are released automatically
when probe fails.


> 
> While reviewing this file, another pre-existing regression was noticed in
> rockchip_pcie_rc_sys_irq_thread():
> 
> drivers/pci/controller/dwc/pcie-dw-rockchip.c:rockchip_pcie_rc_sys_irq_thread() {
> [ ... ]
> 	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
> 		dev_dbg(dev, "hot reset or link-down reset\n");
> 		for_each_pci_bridge(port, pp->bridge->bus) {
> 			if (pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
> 				pci_host_handle_link_down(port);
> 		}
> 	}
> [ ... ]
> }
> 
> [Severity: High]
> This is a pre-existing regression, but there is an unprotected lockless
> iteration over the PCI bus devices list in this threaded IRQ handler.
> 
> When a hot-reset or link-down event occurs, the handler traverses
> pp->bridge->bus->devices using for_each_pci_bridge(). This traversal is
> performed locklessly without acquiring the required down_read(&pci_bus_sem).
> 
> If a concurrent PCI device removal operation modifies the list (e.g., via
> sysfs or hotplug), could this lockless traversal access poisoned pointers
> or freed device structures, potentially causing list corruption or a panic?

Note that this is exactly what qcom does in its threaded IRQ handler:
qcom_pcie_global_irq_thread() walks pp->bridge->bus with
for_each_pci_bridge() and calls pci_host_handle_link_down() the same way
(4d88cb82a6d9 "PCI: qcom: Implement .reset_root_port() and use for link
down"), which is what the rockchip code was modelled on.

If the PCI core considers this walk racy, I think it should be fixed at
the pci_host_handle_link_down() level so that both users (qcom and
rockchip) are covered, rather than driver by driver.

> 

