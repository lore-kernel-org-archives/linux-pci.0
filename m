Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716EF202C29;
	Tue, 10 Mar 2026 21:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176628; cv=none; b=YlQGyHtAOuV6ycbmoNo+X7F+vmcRZBQt6OADU+269EyfsRA4xVDHLd2+RTO573ZxR1B2bpPGp3pFlLUHX6Xvi05RwkCfzy0iTAA2zU/1Akntv+xiKWbAbyXw7F9uy+JVTtTkptCkZ7dUOsn4pSRbOFCjgrtR7xcU6JerXuq+YcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176628; c=relaxed/simple;
	bh=wvFFbyl5VN0FXyuzOFNsi/DYncegnMaFuWdcoiLeGdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVW1LNw3uE8HrTXmqoRybG0wNr+PDJcBuW8WdG5TIvZ0i8eNM19uGnAwqz3BWqtyZh7RK0/CjuEQH6cKyTFkdbL5dQJbJPvsy6wUF0B3qWSALiVVQodCWBk/J6Yd04OzAXe+57dkON9knOFDUWYnTWkY8OiaqSmkFqDoBf7Na6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 577941596;
	Tue, 10 Mar 2026 14:03:34 -0700 (PDT)
Received: from [10.57.58.37] (unknown [10.57.58.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A1E93F694;
	Tue, 10 Mar 2026 14:03:35 -0700 (PDT)
Message-ID: <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
Date: Tue, 10 Mar 2026 21:03:32 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>,
 Grimmauld <grimmauld@grimmauld.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 driver-core@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[ +driver-core maintainers - async probe question below ]

On 2026-03-10 3:30 pm, Manivannan Sadhasivam wrote:
> Hi Robin,
> 
> On Tue, Mar 10, 2026 at 01:41:56PM +0000, Robin Murphy wrote:
>> Hi Mani,
>>
>> On 2026-03-04 6:48 am, Manivannan Sadhasivam wrote:
>>>
>>> On Thu, 26 Feb 2026 15:40:23 +0530, Anand Moon wrote:
>>>> Rockchip DWC PCIe driver currently performs synchronous link training for
>>>> combo PHYs (PCIe 3.0/2.0 and SATA 3.0) during boot. This process waits for
>>>> the link to be fully established, adding several milliseconds to the boot
>>>> sequence. To optimize boot time, this change enables asynchronous probing,
>>>> allowing link establishment to proceed in the background while the kernel
>>>> continues probing other devices.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/1] PCI: dw-rockchip: Enable async probe by default
>>>         commit: ec392abc95932838bf7e3d659d358f4df9ff5a0a
>>
>> This appears to have the side-effect that calling pci_host_probe() from
>> async context can effectively force async probe for the endpoint drivers
>> as well, but some drivers are not OK with that, as our CI has just
>> flagged up.
>>
> 
> Thanks for reporting!
> 
>> (And as for that particular warning, ISTR last time I looked into it
>> another context, the opinion of the MDIO/phy maintainers seemed to be
>> "don't force async probe".)
>>
> 
> This was discussed during v2 [1] and concluded that the async probe benefits
> outweigh the unharmful splat from phylib. I also agree with the above conclusion
> that this splat should not prevent us from enabling async probe for PCI
> controller drivers. It can easily save a few 100ms during boot.

The problem is not an "unharmful splat" from one driver on one board - 
that's *a* symptom, and the fact that it happens to be a relatively 
benign one does not dismiss the problem that forcing async probe upon 
drivers that are not designed to support async probe cannot in general 
be assumed to be safe, so is not OK. It's one thing if a user brings it 
upon themselves by explicitly using the "driver_async_probe=" option, 
but it's very different if some other driver starts doing it for them.

Looking closer, it seems like the fundamental issue might be when we've 
got this far (simplified for clarity):

- async_run_entry_fn
   - rockchip_pcie_probe
     - pci_host_probe
      - pci_bus_add_device
        - device_initial_probe
          - __device_attach_driver

wherein we then reach the "if (data->check_async && async_allowed != 
data->want_async)" condition, at which point check_async is true (from 
device_initial_probe()), while async_allowed and want_async are *both* 
false, but that leads us to actually go ahead and call 
driver_probe_device() for the child device despite being in async 
context. That doesn't seem right to me - I'm guessing it maybe wasn't 
anticipated to have bus drivers calling device_initial_probe() from 
within async in the first place?

It may not strictly be the fault of this patch - clearly 91703041697c 
("PCI: Allow built-in drivers to use async initial probing") is 
implicated in this too - but the fact is that it *has* exposed a bug 
that needs fixing one way or another, it can't just be left hanging and 
impacting end users.

Thanks,
Robin.

> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/aYHVlS1nbCMMyF04@ryzen
> 

