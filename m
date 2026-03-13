Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4775D31D75E;
	Fri, 13 Mar 2026 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407755; cv=none; b=hYyzmXRImkQKHVBytfqboezOSIauo/ajBy8A6MHg3++PjD60Lr5NmUDeM9vRP+EgNQXAWfltt0si8Vzz3yX4NFUxX4jbqp7E1YVj+KRcQp4OkPCDxpMG/rTTPseoT72ekfwUTumAiEOGlvdgsMXwk6oQkTbq7flrKTNz0EZ+moA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407755; c=relaxed/simple;
	bh=wxlHc9c7iJN3g9SDWUpvLcjyUqW7JOefkKsYFpY2Y1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLBVICKwEzJSuwDvCn/erOBD5UB0dKjIFAgQoTSItBwHpEiwi5sMcDZ4Fn5rKrwZLwNemBLp/ZbaWkFme6AFpInXXlE3xHq1ZqYL4SX6VQ4EgEIOvkuJMZ4M1/RWWPO7sxEGMsmw1/R9N1mM0K4NKHNayO6ehx9FQYAsnxabyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 558D8497;
	Fri, 13 Mar 2026 06:15:45 -0700 (PDT)
Received: from [10.57.59.200] (unknown [10.57.59.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D39153F73B;
	Fri, 13 Mar 2026 06:15:47 -0700 (PDT)
Message-ID: <6cfe4bda-036f-4bb9-8a08-ed75f61cae24@arm.com>
Date: Fri, 13 Mar 2026 13:15:45 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
To: Danilo Krummrich <dakr@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
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
 "Rafael J. Wysocki" <rafael@kernel.org>, driver-core@lists.linux.dev,
 Lukas Wunner <lukas@wunner.de>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>
 <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org>
 <55c28218-1638-4b90-a9cd-a177fb5abcb6@arm.com>
 <DH0TM60TVX5D.20W4O1X696ALA@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <DH0TM60TVX5D.20W4O1X696ALA@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-12 12:59 pm, Danilo Krummrich wrote:
> On Thu Mar 12, 2026 at 1:48 PM CET, Robin Murphy wrote:
>> On 2026-03-11 9:09 pm, Danilo Krummrich wrote:
>>>   From a driver-core perspective I think we're rather limited on what we can do;
>>> we are already in async context at this point and can't magically go back to
>>> initcall context.
>>>
>>> So, the only thing I can think of is to kick off work on a workqueue, which in
>>> the end would be the same as the deferred probe handling.
>>
>> Hmm, in fact, isn't the deferred probe mechanism itself actually quite
>> appropriate?
> 
> Yes, I've also mentioned this in [1], including the fact that it technically
> even complies with the guarantees given by PROBE_FORCE_SYNCHRONOUS. I.e. the
> documentation says:
> 
> 	Use this to annotate drivers that need their probe routines to run
> 	synchronously with driver and device registration (with the exception of
> 	-EPROBE_DEFER handling - re-probing always ends up being done
> 	asynchronously).
> 
> However, I'm still not sure how I feel about this, since I consider this to be
> more like a workaround that just moves things to a "more approprite" async
> context.

I guess the underlying problem there is that there are at least 3 
different significant aspects to what "synchronous" can mean:

- literally in the context or device/driver registration as documented. 
Off-hand I'm not really sure what useful property may be *specific* to 
those conditions that a driver might rely on, other than for 
super-special cases like platform_driver_probe().

- serialised, i.e. probes of multiple devices won't happen concurrently 
on multiple threads. This is probably the one hiding the most driver 
bugs, e.g. internal shared/global state without sufficient 
synchronisation. I guess this falls out as a side-effect of the first 
condition, but AFAICS it *can* also still provided by deferred probe 
(given that it's a single work item iterating a list one-by-one)

- in some regular thread context that isn't liable to have issues 
synchronising against other async_func workers (i.e. the request_module 
case). Again, deferred can't have a problem here, or it wouldn't have 
worked properly in general for the last decade.

So it's not that we'd be relying on some dubious "deferred is always 
synchronous" assumption - AFAICS deferred *can* launch async if the 
driver permits it - more just ratifying that deferred is still able to 
effectively honour all the useful properties of PROBE_FORCE_SYNCHRONOUS 
other than "during registration of the thing". And where people do want 
the semantics for a platform_driver_probe()-like thing, then I think 
it's reasonable to say that they should definitely never be invoking 
that from the probe routine of some other driver which permits async itself.

Thanks,
Robin.

> 
> On the other hand, eventually we want everything to work with
> PROBE_PREFER_ASYNCHRONOUS, so maybe it's also good enough for the time being.
> 
> [1] https://lore.kernel.org/driver-core/DGZJBMG2Y738.2MU5LXVGEDD47@kernel.org/

