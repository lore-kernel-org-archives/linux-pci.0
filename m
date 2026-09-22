Received: from mail-m11876.qiye.163.com (mail-m11876.qiye.163.com [115.236.118.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928327E1DC
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.118.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038458; cv=none; b=Q4ednqqiMcV6Tjpt5dMhpkLwd9g6ngC0WrcB2oi8DKUagBO5EK0bjZ3eE2YwmaZDscZHbpT314jskkniZBW1zt9TI+/McNGMhH2bpAYa44oHnTbFIb7zVEA2wjRRDD+o5a3M1JUOCRIbHPdlx5fGDsjWEpUylKx8rQzWwKkZRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038458; c=relaxed/simple;
	bh=O5Dt5y0OawNdq5fQ9KdjoXLFpfKfZ/SS41ym+ron0q8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eEMQE3wj9NtH6fRPIX6XK7WjBdSCGyTbRrkWqCJeMTczxzTMm9plo8fmrG9/WYchf7pnAzARHMH1YBCbe4dD1i44zUr50e5w69uT8mSpEf6AkV4JpeBM1mlKGpwz7ljOtDxRhtoqQGU1USDlOruOcUiQyV0W1LUemzZsWvUIgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=d4PUoeDf; arc=none smtp.client-ip=115.236.118.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="d4PUoeDf"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ea32f09c;
	Tue, 22 Sep 2026 08:49:01 +0800 (GMT+08:00)
Message-ID: <97679f9a-a9bc-4823-bf46-aa7153c534be@rock-chips.com>
Date: Tue, 22 Sep 2026 08:48:57 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2 1/2] PCI: dw-rockchip: Move the INTx irq setup to probe
 and make it devm-managed
To: Niklas Cassel <cassel@kernel.org>
References: <1788484709-139123-1-git-send-email-shawn.lin@rock-chips.com>
 <1788484709-139123-2-git-send-email-shawn.lin@rock-chips.com>
 <aprCfVgc1dl_h24T@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aprCfVgc1dl_h24T@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c696690b03a4kunmf1c19fa9386300
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUIfVklLTk9CHh1OQk8ZGVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=d4PUoeDfWp00hA4Po1QNl3m0bzvBFzreiaq+HldrhORIAN8C4HTaxSmlO6KF7s0ZgFfT1S5aDFuamMlHi/xZjDekAF3KG8FsxbP/B3nmnyuXXyglt+awxh7Jpks7wa6LiynFjlLn2k+QnqEfqj1xvjt5FmLo+qpU+EIrH7aYpiw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Gg7QC0imucH4qnSkWez8ljimIOZf4aefN4ADrJlrACU=;
	h=date:mime-version:subject:message-id:from;

在 2026/09/04 星期五 21:07, Niklas Cassel 写道:
> On Fri, Sep 04, 2026 at 09:18:28AM +0800, Shawn Lin wrote:
>> Since commit b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port()
>> and use for link down"), .reset_root_port() re-runs the host ops
>> .init() callback to reprogram the Root Complex after a controller
>> reset. That works for the register programming, but .init() is not
>> re-entrant: it also creates the INTx irq domain and installs the
>> chained INTx handler. Every root port reset therefore ends up with a
>> second irq domain registered for the same fwnode: the previous one is
>> leaked, as it is never removed, and worse, the INTx virqs of the
>> downstream PCI devices were allocated in the previous irq domain and
>> are never re-mapped, while the chained handler now looks up virqs in
>> the new, empty domain. After a link down recovery, INTx interrupts
>> are silently lost.
>>
>> Fix it by moving the of_irq_get_byname() lookup, the INTx irq domain
>> creation and the chained handler installation out of .init() and into
>> rockchip_pcie_configure_rc(), right after dw_pcie_host_init(). This
>> mirrors how the qcom driver requests its global IRQ, and leaves
>> .init() with nothing but idempotent register programming, so both
>> .reset_root_port() and dw_pcie_resume_noirq() can safely re-run it.
>> Re-running of_irq_get_byname() on every resume is also gone.
>>
>> With the irq setup now living in probe, tie its lifetime to the device
>> with devres: create the irq domain with devm_irq_domain_instantiate()
>> and uninstall the chained handler through the
>> rockchip_pcie_intx_chained_release() devres action. The driver is
>> builtin and cannot be unbound (suppress_bind_attrs), so probe failure
>> is the only path that ever needs this cleanup, and devres takes care
>> of it without sprinkling it over every error path. Since the irq setup
>> is the last step of rockchip_pcie_configure_rc(), the only failure
>> point left after the chained handler is installed is
>> devm_add_action_or_reset() itself, whose failure mode runs the action,
>> so the handler can never run against the devm-freed rockchip
>> structure. devres also unwinds in reverse registration order, so the
>> handler is always uninstalled before the domain is removed. There is
>> no devm API for chained handlers, hence the small devres action
>> wrapper.
>>
>> Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
>> Suggested-by: Niklas Cassel <cassel@kernel.org>
>> Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> I would have written it in two commits:
> 1/3 that moves the of_irq_get_byname() lookup, the INTx irq domain creation,
>      and chained handler installation.
> 2/3 that makes the irq doman device managed, to not leak the resources, as
>      flagged by Sashiko
> (3/3 that masks the INTx IRQ during .reset_root_port())
> 
> 
> Since fixing the resource leak seems like a separate issue.
> 
> The commit message for this patch does seem quite long, mostly because
> it is fixing two separate issues.
> 
> 
> Sorry that we did not detect this INTx issue when sending the
> .reset_root_port() patch. Since RK3588 does not support INTx in EP mode,
> it is unfortunately not tested when running the pci_endpoint_test selftest.
> 

Don't worry, and thanks for these suggestion. I'll spin a v3 later.

> 
> Kind regards,
> Niklas
> 

