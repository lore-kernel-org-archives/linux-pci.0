Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A612DF151;
	Thu, 12 Mar 2026 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319730; cv=none; b=eYR86CHVAHmOyTV+L9qA2SJDXTcE1BW4UND6spmzpRtwP4nsxYssSamBJ50/2ztofuLyfICteLQK6gNeX43oM+lDrHLVYfl13HdNTImzvfEF0GonTAwvJYD6THD8RGgsj5XzkcwwhNc40jnfxEt2N5rOKGOdojr4kq8Mj4WetJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319730; c=relaxed/simple;
	bh=gnHwhYgOY14uV4IOOzoGrm+1PXeW58d1Qj2sTLzSx4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8Qi9YnUNmUeBBiJERuDSe2qXZDODlaFNBMJBTCLRttrhkQ28VzT/G8mufH8Hxy1T/wV8Ba3zSvOOg0bOokuY6aTn6mrdjMFCacXVM6yGXlN/8pJOZt1eIV8dkhr9XwkpOnrp2Qrj36zuanfiZXfxxoQLFzfIRxjoCUJCVtDYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09F56165C;
	Thu, 12 Mar 2026 05:48:41 -0700 (PDT)
Received: from [10.57.59.155] (unknown [10.57.59.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74EF13F694;
	Thu, 12 Mar 2026 05:48:43 -0700 (PDT)
Message-ID: <55c28218-1638-4b90-a9cd-a177fb5abcb6@arm.com>
Date: Thu, 12 Mar 2026 12:48:36 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
To: Danilo Krummrich <dakr@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
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
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-11 9:09 pm, Danilo Krummrich wrote:
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
>  From a driver-core perspective I think we're rather limited on what we can do;
> we are already in async context at this point and can't magically go back to
> initcall context.
> 
> So, the only thing I can think of is to kick off work on a workqueue, which in
> the end would be the same as the deferred probe handling.

Hmm, in fact, isn't the deferred probe mechanism itself actually quite
appropriate? A suitable calling context isn't the most obvious "resource
provider" to wait for, but ultimately it's still a case of "we don't
have everything we need right now, but it's worth trying again soon".
I may have missed some subtleties, but my instinct is that it could
perhaps be as simple as something like this (completely untested).

Cheers,
Robin.

----->8-----

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index bea8da5f8a3a..3c4a0207ae3f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -954,6 +954,16 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
  	if (data->check_async && async_allowed != data->want_async)
  		return 0;
  
+	/*
+	 * Bus drivers may probe asynchronously, but be adding a child device
+	 * whose driver still wants a synchronous probe. In this case, just
+	 * defer it, to be triggered by the parent driver probe succeeding.
+	 */
+	if (!async_allowed && current_is_async()) {
+		driver_deferred_probe_add(dev);
+		return 0;
+	}
+
  	/*
  	 * Ignore errors returned by ->probe so that the next driver can try
  	 * its luck.

