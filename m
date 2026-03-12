Received: from mail-m3295.qiye.163.com (mail-m3295.qiye.163.com [220.197.32.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1660338939;
	Thu, 12 Mar 2026 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773279207; cv=none; b=FPzwG1pEclBXYfOqhAbY3qjHae7AL3ebzNFhhfWFfamUbw1kSgN29GQt4fLqg1NABCN2U53pynBy9K3ja+aUmmTZV2aDAFAfnZONQFXDRaSvqN84Bzr3rf5Pvqs3K5Q3NMp0qOZYs8z4ts1S7vOZT/4MuEgfgea9auObsHXY57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773279207; c=relaxed/simple;
	bh=AYxMkc8vCVG5VNtrd8CH8c21SZ2MdMOcvan/+DRr6W0=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=q8IrMZ9ZfKtT7r03P6qXT4D1HkwGdry9urf4I+jAzVfLp40WkQsgnwHeNPBXATI5fdoACIjno5WR12AFG/X3VdqAqsY1wNGTfoliOi6EDsbjKNigDD1X9jQjXqgLkYVcnhcgnehG2edLtpC7aVDY8kvTZOGTuNZ866eFO20URUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Sed4lWnD; arc=none smtp.client-ip=220.197.32.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Sed4lWnD"
Received: from [192.168.61.151] (unknown [110.83.51.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 36a07fd9a;
	Thu, 12 Mar 2026 09:33:14 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, Robin Murphy <robin.murphy@arm.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>,
 Hans Zhang <18255117159@163.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>,
 Grimmauld <grimmauld@grimmauld.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, driver-core@lists.linux.dev,
 Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
To: Danilo Krummrich <dakr@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>
 <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <7b5592e7-8a9d-2cf0-bb3e-e306a6337165@rock-chips.com>
Date: Thu, 12 Mar 2026 09:33:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cdfad2d6809cckunm494d1a9c5f1dd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0NCVklOHx1DSklNGB4YS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG
DKIM-Signature: a=rsa-sha256;
	b=Sed4lWnDmwfKYVOVkbc4Y2rVhQcql/iiS/F9miQlGz9uPMIyj3zv76EbAV+aISfTpvB1Pl0bTfUZ8ldLKi584Z60igIIaGZ1u201GT2RVB3PU4/whmHBZz4C1IcfkvB7Echqz08J9oPFiIQyh0MGyr09uqGtdX4YzS4OFnJPaHc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=0ZuXcANpbO5f9lJpjp5DojLJZeC/g1ENjyYfealo8kY=;
	h=date:mime-version:subject:message-id:from;

Hi Mani and Danilo,

在 2026/03/12 星期四 5:09, Danilo Krummrich 写道:
> On Wed Mar 11, 2026 at 1:28 PM CET, Manivannan Sadhasivam wrote:
>> On Wed, Mar 11, 2026 at 12:46:03PM +0100, Danilo Krummrich wrote:
>>> On Wed Mar 11, 2026 at 6:24 AM CET, Manivannan Sadhasivam wrote:
>>>> I have a contrary view here. If just a single driver or lib doesn't handle async
>>>> probe, it cannot just force other drivers to not take the advantage of async
>>>> probe. As I said above, enabling async probe easily saves a few hunderd ms or
>>>> even more if there are more than one Root Port or Root Complex in an SoC.
>>>
>>> Then the driver or lib has to be fixed / improved first or the driver core has
>>> to be enabled to deal with a case where PROBE_FORCE_SYNCHRONOUS is requested
>>> from an async path, etc.
>>>
>>> In any case, applying the patch and breaking things (knowingly?) doesn't seem
>>> like the correct approach.
>>>
>>>> I strongly agree with you here that the underlying issue should be fixed. But
>>>> the real impact to end users is not this splat, but not having the boot time
>>>> optimization that this patch brings in. As an end user, one would want their
>>>> systems to boot quickly and they wouldn't bother much about a harmless warning
>>>> splat appearing in the dmesg log.
>>>
>>> You mean quickly booting into a "harmless" potential deadlock condition the
>>> warning splat tries to make people aware of? :)
>>>
>>
>> Hmm, I overlooked the built-as-module part where the deadlock could be possible
>> as indicated by the comment about the WARN_ON_ONCE().
>>
>> But what is the path forward here? Do you want the phylib to fix the
>> request_module() call or fix the driver core instead?
> 
> Here are a few thoughts.
> 
> In general, I think the best would be to get rid of the (affected)
> PROBE_FORCE_SYNCHRONOUS cases.
> 
> Now, I guess this can be pretty hard for a PCI controller driver, as you can't
> really predict what ends up being probed from you async context, i.e. it could
> even be some other bus controller and things could even propagate further.
> 
> Not sure how big of a deal it is in practice though, there are not a lot of
> PROBE_FORCE_SYNCHRONOUS drivers (left), but note that specifying neither
> PROBE_FORCE_SYNCHRONOUS nor PROBE_PREFER_ASYNCHRONOUS currently results in
> synchronous by default.
> 
> (Also, quite some other PCI controller drivers do set PROBE_PREFER_ASYNCHRONOUS
> and apparently got lucky with it.)
> 
>>From a driver-core perspective I think we're rather limited on what we can do;
> we are already in async context at this point and can't magically go back to
> initcall context.
> 
> So, the only thing I can think of is to kick off work on a workqueue, which in
> the end would be the same as the deferred probe handling.
> 
> Another alternative would be to let the subsystem handle such cases, which in
> this case would probably mean to handle the current_is_async() case in
> pci_host_probe() or pci_bus_add_devices().
> 
> On the other hand, this would probably end up to be a subsystem specific
> implementation of "kick of work on a workqueue".

Actually, this is exactly what we've been doing in our downstream
code[1] for quite a long time. We've even pushed this optimization down
to the individual driver level.

To be honest, I'm not particularly fond of this approach either.
However, on our platform, we have more than 5 Root Port instances that
need to be initialized during boot. When all of them probe
synchronously, it significantly delays the execution of many other
critical drivers. Our customers have been complaining about the boot
time, and our downstream team had no real choice but to kick off a
kthread similar to your suggestion.

The code is very ugly and expose a lot of corner cases problem which
wasted quite lot of time to fix. That's why I was hesitant to bring
up the this approach upstream initially. But since you mentioned it, I
think it's worth evaluating whether we can implement this at the
subsystem level instead of forcing each driver to handle it
individually. This way, the complexity would be centralized, and drivers
that benefit from async probe (like multi-Root-Port SoCs) could opt-in
without worrying about the request_module() deadlock scenario.

What do you think?


[1] 
https://github.com/rockchip-linux/kernel/blob/develop-6.6/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L1764

> 
>> I can drop this patch in the meantime. But holding this prolong wouldn't help.
> 
