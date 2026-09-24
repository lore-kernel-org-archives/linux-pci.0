Received: from mail-m12796.qiye.163.com (mail-m12796.qiye.163.com [115.236.127.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92E28851F
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220790; cv=none; b=hxePFTxEoXzj4fxSADSOfyew5l8W8s17EEsRO3vWY9QY6sAso/iTbTBu9F+QJxs8QNZthSWAP8ZCp8PBeoXYOxJkbdHxtF2v2kDNl9TfcsvzuYGYx6vvAVHW5NAQkBdivO8ZgNEM5IZCKt2W4Xo9/9Ib6Tf4KjP3m24Ljafr/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220790; c=relaxed/simple;
	bh=KsHWnf/QnKdey0zU8UV6jcH9fLt8NZAgogLA7JOw2bg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NIgxdHC6f8x945M+V6hOhyse/J+QG5oykjJpXW6/ZV8I36kIBOHtFaBndK+fBNSHGLq41zqEKyXphyz4Jsyc02LgYqstsU+Ye05/iLv1YTTOAA+gNoJxm/qjr8pyYGCwDy9O0DO2DlJCiXtXjg07puidl2+oPvFLHuSNSzOlUfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SKP7ccLQ; arc=none smtp.client-ip=115.236.127.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SKP7ccLQ"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ef5fe4e7;
	Thu, 24 Sep 2026 11:27:44 +0800 (GMT+08:00)
Message-ID: <c531d929-24a3-4b5b-b329-a11b0191baf9@rock-chips.com>
Date: Thu, 24 Sep 2026 11:27:44 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Diederik de Haas <diederik@cknow-tech.com>,
 linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/3] Small INTx fixes for Rockchip's dwc based PCIe
 controller driver
To: Niklas Cassel <cassel@kernel.org>
References: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
 <DLMKWV1AH8TZ.2R3JK2NPM4KZB@cknow-tech.com>
 <08329b2b-449a-4036-8e82-ad67d0d037ee@rock-chips.com>
 <arPvcQIu46N_gTmB@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <arPvcQIu46N_gTmB@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0d174730803a4kunmabe36c1150bb7c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQh1NVhkYTUNNHRpJQ0tJQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=SKP7ccLQWc33EiBC8F8/NJaKmN3/XEbN5/J3rG4yrcrHfH2lmAhzYVil6h74oaLY2ExwCJn8oTT3WizjF+Y01eA19ydHQnIwIOPt5RfF9iW6a5PouEn9Z1DRXqCKhKm4/4Ytst4X0IhW+u50Qk1tJrgIHMtFqP+5HpAnBtpn6+A=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=v+qqOE+xh9kXPgV1iezB4P8lSaYSSVqLNw4Hghtva1E=;
	h=date:mime-version:subject:message-id:from;

Hi Niklas

在 2026/09/23 星期三 23:25, Niklas Cassel 写道:
> Hello Shawn, Diederik,
> 
> On Wed, Sep 23, 2026 at 05:21:59PM +0800, Shawn Lin wrote:
>>>
>>> I build a kernel with this patch set (7.3~rc4-2) and got several warnings
>>> like this, shortly followed by a stack trace:
>>
>> Sashiko already reportted some valid concern around this, and I'll plan
>> to rework this series a bit later. Thanks for reporting this.
> 
> Just thinking out loud:
> 
> Patch 1/3 in this series fixes a regression, so it should be picked up as
> soon as possible.
> 

Thank you for your detailed analysis and valuable suggestions.

My original intention was to provide a minimal fix for the regression 
introduced during the merge window. However, after Sashiko's review, 
some existing problems (even if only theoretical) were pointed out, so 
the series grew into three patches.

I agree with your reasoning: patch 1 fixes a real regression and should 
be picked up as soon as possible, while patches 2 and 3 can be handled 
separately. Given that we are approaching -rc5 and I will have two 
consecutive national holidays in the coming weeks, I may be unable to 
access my development equipment for about two weeks. Therefore, I plan 
to revise patch 1 based on your suggestion (moving the code before 
dw_pcie_host_init()) and send it out promptly.

> Patch 2/3 is converting the resources to be device managed.
> However, after patch 1/3 (if the moved code is called _before_
> dw_pcie_host_init()) the only thing left after dw_pcie_host_init() is the
> PCIE_CLIENT_INTR_MASK_MISC write.
> 
> I.e. there is no error return remains that would need a dw_pcie_host_deinit().
> 
> So there is no strict need to convert to devm_().
> You can do so, but that should be in a separate series IMO.
> 
> 
> In fact, Diederik's later warnings are a result of Patch 2/3 which replaced
> irq_domain_create_linear() with devm_irq_domain_instantiate():
> 
>     error: hwirq 0x0 is too large for :pcie@fe150000:legacy-interrupt-controller
>     WARNING: kernel/irq/irqdomain.c:676 at irq_domain_associate_locked+0x118/0x1a0
> 
> 
> The fix seems to be to add .hwirq_max = PCI_NUM_INTX, to
> rockchip_pcie_init_irq_domain():
> 
> The fix is one line in rockchip_pcie_init_irq_domain() :
> 				.size = PCI_NUM_INTX,
> 				.hwirq_max = PCI_NUM_INTX,
> 
> 
> 
> Patch 3/3 looks like a theoretical problem that Sashiko found.
> 
> Is the underlying problem real? It's plausible, but nobody has reproduced it.
> For it to happen, the controller's legacy IRQ output has to be asserted while
> clocks are gated. Two ways that could happen:
> 
> - The output was high when clk_bulk_disable_unprepare() froze the logic.
> - A device was still asserting INTx when an AER- or sysfs-triggered reset
>    stopped the link.
> 
> Patch 3/3 is not enough though:
> 
> disable_irq() never masks this chained IRQ in hardware, so
> rockchip_pcie_intx_handler() can still run and read the unclocked APB.
> 
> This is the kind of case IRQ_DISABLE_UNLAZY exists for, according to the
> comment above irq_disable().
> 
> Minimal amend of patch 3/3 as it currently looks:
> 
> turn off lazy disable for this line when the chained handler is installed:
> 	irq_set_status_flags(rockchip->intx_irq, IRQ_DISABLE_UNLAZY);
> 	irq_set_chained_handler_and_data(rockchip->intx_irq,
> 					 rockchip_pcie_intx_handler, rockchip);
> 
> Such that irq_disable() masks the chained IRQ.
> 
> Do we want patch 3/3? Probably.. but this race seems very small...
> probably most imporent to get patch 1 (with the code move _before_
> dw_pcie_host_init()) accepted ASAP, as it currently is causing problems
> for Diederik.
> 
> 
> Kind regards,
> Niklas
> 

