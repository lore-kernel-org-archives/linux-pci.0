Received: from mail-m155100.qiye.163.com (mail-m155100.qiye.163.com [101.71.155.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460038E8D9;
	Thu,  4 Jun 2026 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567331; cv=none; b=Nm5KbHa147gNCC24GJGfkpH4rs4RXzpDh94DpmmfGMvfJTDAcrZpokr0wu2FIs2tqIhwDPV7FofPAMSumBrZOUgYZ3bYbR/cVw0haYy9x3mqtkagtnJqvmclsn1w/IaKz+oevW4NKI7S/KI2WLBeKVZGZhPntt7AIMLFDwpWMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567331; c=relaxed/simple;
	bh=pdLRBsyP9xxT9xnUxBct/5ZXQv/5QRr0VkmXWa2X+YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awC4R1NUyJskM9DJLhUHHfbsVNYY8CbUN0MMizs2uf42MLx1nbfMe2eHO5O3LbkM4VW8KzJJ9Zm7UHxXBh/vHBaX+xjqg+jknh2pOv86WtHFr1zvg37y/O/JswvZY6N2Jh5CsPvIR1OAzZIy10vwvZhkar7X7mvgS2xfRfy8zMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=101.71.155.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [172.23.72.187] (unknown [43.247.70.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4110d6912;
	Thu, 4 Jun 2026 17:26:24 +0800 (GMT+08:00)
Message-ID: <37ac5cd1-c71f-4f04-a996-d97079c9855f@sangfor.com.cn>
Date: Thu, 4 Jun 2026 17:26:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PCI: readiness condition with Configuration RRS in
 pci_dev_wait()
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, ?????? <dinghui@sangfor.com.cn>
References: <96e8ff0e-b538-42d5-a328-96515fc3fa9e@sangfor.com.cn>
 <aiAhq-BO5baJBfVl@wunner.de>
From: Yingying Zheng <zhengyingying@sangfor.com.cn>
In-Reply-To: <aiAhq-BO5baJBfVl@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e91f4903109cfkunm7b4461e6399ceb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGE1OVkoeHxhNSEgdGhhMH1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlPSFVJT0xVTEtVQ0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pOTElVSktLVUpCS0tZBg++

Thanks a lot for the detailed explanation and the pointers about Broadcom
"Synthetic Mode". This matches what we are observing very well.

在 2026/6/3 20:44, Lukas Wunner 写道:
> On Wed, Jun 03, 2026 at 05:32:54PM +0800, Yingying Zheng wrote:
>> However, with some PCIe switches (in our case Broadcom/LSI PEX890xx PCIe
>> Gen5 switch), when the downstream device is in reset or link training is
>> not completed, the switch exposes a Virtual PCIe Placeholder Endpoint on
>> the downstream side. During this window, reads to the GPU BDF Vendor ID
>> return the placeholder endpoint Vendor/Device ID (Broadcom/LSI) instead
>> of the expected 0x0001 RRS-visible value.
> 
> What's the OEM and model name of the system you're observing this on?
> 
> We ran into this issue on a Supermicro SYS-421-GE-TNRT server with
> AOM-PCIE5-418P-1-P board.  The two Broadcom PCIe switches are located
> on the AOM board.
> 
> Do you happen to use the same system?
> 

OEM: our system is from a different OEM (not Supermicro)
Switch firmware: we checked with Broadcom’s g4Xdiagnostics tool and both
PEX89104 switches report FW version 01.05.11.01

> The Broadcom PCIe switches support a "Synthetic Mode" (alternatively to
> "Base Mode") for use cases where a single PCI function is accessible to
> multiple hosts.
> 
> In Synthetic Mode, the Broadcom switch spoofs responses when the actual
> device downstream of the switch is inaccessible.  The spoofed responses
> come from the virtual placeholder device with ID [1000:02b2].
> 
> When I investigated the issue, I cooked up a tentative patch to recognize
> spoofed responses in the PCI core:
> 
> https://github.com/l1k/linux/commits/broadcom/
> 
> After some back and forth with Broadcom and Supermicro FAEs, it turned out
> that the switch had an outdated firmware with version 04.101.00.00.
> 
> The Supermicro server had already been updated to the latest BIOS version,
> but the BIOS update does not include updates for the PCIe switches.
> One has to contact Broadcom directly and ask for a separate firmware
> update.  In our case, we received a file called
> "AOM-PCIe5-418P-1 _PLX FW 4.16.0 Package.zip".
> 
> The zip file contained a g4Xdiagnostics.efi utility which can be run from
> an EFI shell to query the current firmware version on the Broadcom switches.
> It can also flash the switches with a new firmware, which was included in
> the zip file as:
> "AOM-PCIe5-418P-1_4.16.0GCA_PLX1_07172024.fw" and
> "AOM-PCIe5-418P-1_4.16.0GCA_PLX2_07172024.fw".
>                                 ^
> After updating the switches with these files, they reported 04.16.00.00
> as firmware version.  In that version, Synthetic Mode is deactivated,
> the placeholder device does not appear and reset on passthrough works
> as it should.
> 

Given your findings, this firmware version seems quite old and is likely
the root cause of the spoofed placeholder responses during reset/link
training on our platform as well.

At the moment, we are not sure whether we will be able to obtain an updated
switch firmware from the OEM in a timely manner. We will try to contact the
OEM to obtain an updated switch firmware and will report back whether the
issue disappears after the update.

Thanks again for sharing your investigation and the recommended resolution.

> According to the Broadcom FAE, the OEMs own the switch firmware settings
> and so the kernel is not permitted to deactivate Synthetic Mode at runtime.
> 
> Because the problem was no longer reproducible after updating the switch
> firmware, we decided that this is the recommended way to solve the problem
> and I did not pursue an in-kernel workaround as a result.
> 
> As an aside, the amdgpu driver contains a workaround for Broadcom Synthetic
> Mode which was introduced with 1dd2fa0e00f1 (and subsequently fixed up with
> 9b608fe94870 and 4e89d629dc72).  Obviously, this only helps if there are
> AMD devices downstream of the Broadcom switch, and not with those of other
> vendors.
> 
> Thanks,
> 
> Lukas
> 
> 

Best regards,
Yingying Zheng
