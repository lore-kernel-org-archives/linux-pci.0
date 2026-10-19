Received: from mail-m19731116.qiye.163.com (mail-m19731116.qiye.163.com [220.197.31.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F004825AC
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390089; cv=none; b=EpmoG7z5bhatK2vw/jr0fkjGr/Uy60Zw8YbyUfq7xN+KE3Bk4TjSk6rgy9MuGCCT/D6dW1ydtkm0J13dl9baogUTBmUnZgRV7YK30pkbMBCB/fv8WGH8JdsFs6Eonh54PiqDMmGOJFyru63WEpygV2+HiIhqhc7BSXs/NP7pGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390089; c=relaxed/simple;
	bh=JB82PfHE7hAsuihF68ENZAUlg6qwTakPNhuhVUHPgto=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NsxcVfvsQuxREPiqspXTZvvFN+sbTsFWj3650m+sDY5Ro0zn0TjtwDVLu2YuZKm/ne285YLtDonQPeAgG97tHoKxVcTlBdEB5v66S7gfxeAZ1Y+W21ZusbpfVqg//1i3N4fzLHo7m5eZecMXGLrmgyGWnQ2CG8VyUciqR7obfLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TD9n+NTh; arc=none smtp.client-ip=220.197.31.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TD9n+NTh"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 517613f42;
	Mon, 19 Oct 2026 08:25:13 +0800 (GMT+08:00)
Message-ID: <d6becae5-df39-422b-8d2c-f15efb4ef4a5@rock-chips.com>
Date: Mon, 19 Oct 2026 08:25:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI: dw-rockchip: Enable INTx affinity support
To: Thomas Gleixner <tglx@kernel.org>
References: <1790664898-207928-1-git-send-email-shawn.lin@rock-chips.com>
 <atRLsp1qUA_sGS-0@debian> <87y0bubws7.ffs@fw13>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <87y0bubws7.ffs@fw13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1518c524103a4kunm24f5ed8a5ff813
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTxlPVh9LHUsYSU5MHx8aQlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TD9n+NTh0EX+TpPG74TbMH6mKTeQLOCgnsFyB63BJkXrvDa+A7RnAHBg15/jS8FdsfitzXlgRk0TY93MtG+j/j/imUrzWs7+stzxiupdg5fIAZynzQI8qEsp4VmEOlBvNtw8DqGaG3Y0X/8Z2WtQ9oRck5/pJ4tp1+bVuG/ipUk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=7M+DcHmAl0Qr6G2WXxfJbEG7iMvZDkTSZZ2o71deWKo=;
	h=date:mime-version:subject:message-id:from;

Hi Thomas

在 2026/10/19 星期一 4:04, Thomas Gleixner 写道:
> On Sun, Oct 18 2026 at 10:05, Manivannan Sadhasivam wrote:
>> On Tue, Sep 29, 2026 at 02:54:58PM +0800, Shawn Lin wrote:
>>> Leverage the interrupt redirection infrastructure to enable CPU
>>> affinity support for the legacy INTx interrupts. The INTx virqs are
>>> demultiplexed by the chained handler of the "legacy" interrupt, whose
>>> affinity cannot be changed, so affinity control for the INTx virqs is
>>> achieved by redirecting the handler to run in IRQ work context on the
>>> target CPU.
>>>
>>> Mask the INTx source in .irq_pre_redirect() before the handler is
>>> redirected: the legacy interrupt is level triggered, so an unmasked
>>> line would keep re-firing the chained interrupt until the redirected
>>> handler runs.
>>>
>>> Same approach as the DesignWare core, commit eaf290c404f7c39f2 ("PCI:
>>> dwc: Enable MSI affinity support").
>>>
>>> Test was done on RK3588 EVB1 board with an NVMe with pci=nomsi
>>> parameter. The /proc/interrupts columns are trimmed for brevity.
>>>
>>>    # cat /proc/interrupts | grep INTx
>>>    51:  137 0 0 0 0 0 0 0 INTx 0 Edge PCIe PME, nvme0q0, nvme0q1
>>>    # echo 10 > /proc/irq/51/smp_affinity
>>>    # dd if=/dev/nvme0n1p1 of=/dev/null bs=1M count=200
>>>    200+0 records in
>>>    200+0 records out
>>>    209715200 bytes (210 MB, 200 MiB) copied, 0.182021 s, 1.2 GB/s
>>>    # cat /proc/interrupts | grep INTx
>>>    51:  137 0 0 0 946 0 0 0 INTx 0 Edge PCIe PME, nvme0q0, nvme0q1
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> I'd like to get an Ack from Thomas for this patch since I'm not an irqchip
>> expert to decipher whether this patch is valid or not.
> 
> I'm happy to look at it, but I can't be bothered to fish it out from a
> mail archive. Can you please bounce me the original submission?

Sure, you can check it from:

https://lore.kernel.org/linux-pci/87y0bubws7.ffs@fw13/T/#mf0d53a0e27cb142ec0a2b09418ea2a7f04dbb321

> 
> 

