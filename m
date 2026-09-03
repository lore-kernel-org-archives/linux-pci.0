Received: from mail-m49238.qiye.163.com (mail-m49238.qiye.163.com [45.254.49.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F623F58E1
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430671; cv=none; b=iheRm2BWGqGQXAn5UnoMRKFZTSSohtQXfXuwA9Ulu4Vl6XXN+SfNkeSdJ07h0GeI8Tua9Tos3MwI78zsrlHAqYs7sj/IZmV4iEEr4Nucl7r+l+hRaAiqKhw8wVoTdXVXW0Bozz2Oa6Qu3kgE2UrVIhBUNdK7NSGSG6BUAC073sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430671; c=relaxed/simple;
	bh=/sWk6p665VjdSjlm4T1srWviFUn/CUeytnk3wxiUIwE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UiIBrs8VC4Lc3vcjGkEzScu9qHtx0ODSMG8xVTN+8GW4sWnAed8vmsm7lzKPXrEMcUD/dtqldzIiIWx13jtS6A8hvzitzZ1z3/mxXgJiIwX9uv02vqA2b6zKZN5JLHQPEljU9BEl3K9ciihhpnPKoN2iU1CmihUNuAJXa1JPewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hYg9I2WJ; arc=none smtp.client-ip=45.254.49.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hYg9I2WJ"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c6907951;
	Thu, 3 Sep 2026 18:02:16 +0800 (GMT+08:00)
Message-ID: <f327888a-8bec-462f-82f9-3418fd07addd@rock-chips.com>
Date: Thu, 3 Sep 2026 18:02:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: Do not recreate the INTx irq domain
 on root port reset
To: Niklas Cassel <cassel@kernel.org>
References: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
 <1788403477-71491-3-git-send-email-shawn.lin@rock-chips.com>
 <apkx5X83hrHIPOZN@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <apkx5X83hrHIPOZN@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa066b8199303a4kunm5c7a04dcab72f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTB8ZVktNTBkfSR5IT0lCGFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=hYg9I2WJtxuPAVRVHUJr+8p05IBgRHF408pzh9+aias912QjW6sJiRIW2sje43ZazBqIr5HrOgKXvXkeoN9/VVMxvpefoOGa/NDM3l27UY7zRChFnXJIzcNjnTRwwGEDp8PVYjeQZ1eNhqnO7xwh84ZEBECgDLfGaJ5Q/wDmIiE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=typ9XrcJqimvs1Ez86DBSroYw0VFECmYrszjECfOdY4=;
	h=date:mime-version:subject:message-id:from;

Hi Niklas

在 2026/09/03 星期四 16:37, Niklas Cassel 写道:
> On Thu, Sep 03, 2026 at 10:44:37AM +0800, Shawn Lin wrote:
>> .reset_root_port() re-runs the host ops .init() callback to reprogram
>> the Root Complex after the controller reset. However, .init() also
>> creates a new INTx irq domain on every root port reset, so that:
>>
>>    - the previous irq domain is leaked, as it is never removed, and two
>>      irq domains end up registered for the same fwnode;
>>
>>    - the INTx virqs of the downstream PCI devices were allocated in the
>>      previous irq domain and are never re-mapped, while the chained
>>      handler now looks up virqs in the new, empty domain. Hence, after a
>>      link down recovery, INTx interrupts are silently lost.
>>
>> Split the (re)programming of the Root Complex registers out of .init()
>> into rockchip_pcie_host_hw_init() and call that from .reset_root_port()
>> instead. The INTx irq domain and the chained handler are now only set up
>> once, at probe time, which keeps the already mapped virqs valid across
>> root port resets.
>>
>> Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
>> Cc: Niklas Cassel <cassel@kernel.org>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
> 
> If I compare to pcie-qcom.c, the difference is that they do
> e.g.:
> irq = platform_get_irq_byname_optional(pdev, "global");
> 
> after calling dw_pcie_host_init() in qcom_pcie_probe().
> 
> 
> I guess pcie-dw-rockchip.c could do the same:
> Call of_irq_get_byname() and rockchip_pcie_init_irq_domain() in
> rockchip_pcie_configure_rc(), after calling dw_pcie_host_init().
> 
> That way, you don't need to introduce another rockchip_pcie_host_hw_init().
> 
> pci->pp.ops->init() is called by both dw_pcie_host_init() and
> dw_pcie_resume_noirq(). So calling of_irq_get_byname() in .init()
> does seem slightly wrong, as we would get the irq on each resume.
> 
> Perhaps pcie-dw-rockchip.c does not have support for resume, so it
> does not matter right now, but still seems a bit weird to call
> of_irq_get_byname() in init().
> 
> I did not look if rockchip_pcie_init_irq_domain() should be called
> on each resume, but I since we don't tear down the irq_domain in
> pci->pp.ops->deinit(), in fact we don't even have a ->deinit(),
> so calling rockchip_pcie_init_irq_domain() in ->init() does seem
> wrong as well.
> 
> So my vote is to move both to rockchip_pcie_configure_rc(), after
> calling dw_pcie_host_init().
> 

Thanks for the review!

I agree with your reasoning. Will moves the of_irq_get_byname() lookup,
the INTx irq domain creation and the chained handler installation into
rockchip_pcie_configure_rc(), right after dw_pcie_host_init(), matching
the qcom pattern you pointed out. The rockchip_pcie_host_hw_init()
helper from will be gone in v2, and the host ops .init() callback is
back to doing only idempotent register programming, which
.reset_root_port() can safely re-run.

Since there is still no ->deinit() to pair with .init(), and the
Sashiko review also flagged the missing cleanup on probe failure, I
made the irq domain devm-managed (devm_irq_domain_instantiate()) and
uninstall the chained handler through a devres action while moving the
code, so everything is released automatically if probe fails.

Will send out v2 for review.

> 
> Kind regards,
> Niklas
> 

