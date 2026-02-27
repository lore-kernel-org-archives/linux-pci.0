Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94593876C5;
	Fri, 27 Feb 2026 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180939; cv=none; b=UZPVLUPGu248ekix5lXTtF89HbhmZY8+FlLqiW0mwUQ7zpfQjAKVcGAX/7U6wN3ry9tMd4fjuZHs+USl+rpz8LgslyDT2q+Kaypv9kLGd1A6OnW5gCbyr9P2X+wdt3fL2qT+Eowp2NKRyh38DrZMeHvZ9h9JlDdZHu5AbADiZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180939; c=relaxed/simple;
	bh=Lr3z9krdyzkJc04Exn6O0kaAlVSEhIG48nEE3vqdn9Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OxfsuGDCZHcW3AkaOX4nqLrQU9LVK6dhE9Wm3l2AvpUi7Cu5XvvOYaxYspiRYcGQ/zDMKcFLGglv5477XnyYaDaNPeLDSeKvdJKN23dw/06443GlHl2ZkAn8QGMMZ46nj5U1ll690NsReEPPa4RndVjuWqcmco+rhCw7MiiSOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FkStHnFN; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FkStHnFN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772180933; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=LRn/oGL+tuAtq64yYzAexbKedW997ZLDSHRH+Js7iPY=;
	b=FkStHnFNPNvqXSJV4EkEgQy23FUUZV8ZLE19ltFe35oSlqdfIQ0MEPs56ZJo32TA9kEbQzwC5FAeVYIBchmwhnVZFCIfiXtsD3ldzvhHcdUtlo6A/O6BDRFUUGFyUkNCVTSfUTEXsMtA/SA+qHXDzI6h9zKGFXZB2thIMHeLbNM=
Received: from 30.246.163.43(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wztj3at_1772180931 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 16:28:52 +0800
Message-ID: <234dcf9e-05ff-485c-a330-019a4fbb5f3b@linux.alibaba.com>
Date: Fri, 27 Feb 2026 16:28:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] PCI/DPC: Run recovery on device that detected the
 error
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-3-xueshuai@linux.alibaba.com>
 <aYCujqZIvxElSsOE@wunner.de> <aYESh4bCE2lzTg2S@wunner.de>
 <924dce22-171e-4508-907c-74f57f1bdea8@linux.alibaba.com>
In-Reply-To: <924dce22-171e-4508-907c-74f57f1bdea8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/7/26 3:48 PM, Shuai Xue wrote:
> 
> 
> On 2/3/26 5:09 AM, Lukas Wunner wrote:
>> On Mon, Feb 02, 2026 at 03:02:54PM +0100, Lukas Wunner wrote:
>>> You're assuming that the parent of the Requester is always identical
>>> to the containing Downstream Port.  But that's not necessarily the case:
>>>
>>> E.g., imagine a DPC-capable Root Port with a PCIe switch below
>>> whose Downstream Ports are not DPC-capable.  Let's say an Endpoint
>>> beneath the PCIe switch sends ERR_FATAL upstream.  AFAICS, your patch
>>> will cause pcie_do_recovery() to invoke dpc_reset_link() with the
>>> Downstream Port of the PCIe switch as argument.  That function will
>>> then happily use pdev->dpc_cap even though it's 0.
>>
>> Thinking about this some more, I realized there's another problem:
>>
>> In a scenario like the one I've outlined above, after your change,
>> pcie_do_recovery() will only broadcast error_detected (and other
>> callbacks) below the downstream port of the PCIe switch -- and not
>> to any other devices below the containing Root Port.
>>
>> However, the DPC-induced Link Down event at the Root Port results
>> in a Hot Reset being propagated down the hierarchy to any device
>> below the Root Port.  So with your change, the siblings of the
>> downstream port on the PCIe switch will no longer be informed of
>> the reset and thus are no longer given an opportunity to recover
>> after reset.
>>
>> The premise on which this patch is built is false -- that the bridge
>> upstream of the error-reporting device is always equal to the
>> containing Downstream Port.
> 
> Thanks again for the very detailed analysis and for the pointers to
> your earlier mail.
> 
> You are right, thanks for pointing it out.
> 
>>
>> It seems the only reason why you want to pass the reporting device
>> to pcie_do_recovery() is that you want to call pcie_clear_device_status()
>> and pci_aer_clear_nonfatal_status() with that device.
> 
> In the AER path, pcie_do_recovery() is indeed invoked with the Error
> Source device found by find_source_device(), and internally it treats
> that dev as the function that detected the error and derives the
> containing Downstream Port (bridge) from it.  For DPC, however, the
> error-detecting function is the DPC-capable Downstream Port itself, not
> the Endpoint identified as Error Source, so passing the Endpoint to
> pcie_do_recovery() breaks that assumption.
>>
>> However as I've said before, those calls are AER-specific and should
>> be moved out of pcie_do_recovery() so that it becomes generic and can
>> be used by EEH and s390:
>>
>> https://lore.kernel.org/all/aPYKe1UKKkR7qrt1@wunner.de/
> 
> Sure, I'd like to move it out.  I will remove the AER-specific calls
> (pcie_clear_device_status() and pci_aer_raw_clear_status()) from
> pcie_do_recovery() itself, and instead handle them in the AER and DPC
> code paths where we already know which device(s) are the actual error
> sources.  That way, pcie_do_recovery() becomes a generic recovery
> framework that can be reused by EEH and s390.
> 
>>
>> There's another problem:  When a device experiences an error while DPC
>> is ongoing (i.e. while the link is down), its ERR_FATAL or ERR_NONFATAL
>> Message may not come through.  Still the error bits are set in the
>> device's Uncorrectable Error Status register.  So I think what we need to
>> do is walk the hierarchy below the containing Downstream Port after the
>> link is back up and search for devices with any error bits set,
>> then report and clear those errors.  We may do this after first
>> examining the device in the DPC Error Source ID register.
>> Any additional errors found while walking the hierarchy can then
>> be identified as "occurred during DPC recovery".
> 
> I agree this is similar in spirit to find_source_device() -- both walk
> the bus and check AER Status registers.  For the DPC case, I'll perform
> this walk after the link is back up (i.e., after dpc_reset_link()
> succeeds).
> 
> Regarding pci_restore_state() in slot_reset(): I see now that it does
> call pci_aer_clear_status(dev) (at line 1844 in pci.c), which will
> clear the AER Status registers.  So if we walk the hierarchy after
> the slot_reset callbacks, the error bits accumulated during DPC will
> already be cleared.
> 
> To avoid losing those errors, I think the walk should happen after
> dpc_reset_link() succeeds but *before* pcie_do_recovery() invokes the
> slot_reset callbacks.  That way, we can capture the AER Status bits
> before pci_restore_state() clears them.
> 
> Does that sound like the right approach, or would you prefer a
> different placement?
> 
> Thanks a lot for your guidance.
> 
> Best Regards,
> Shuai
> 

Hi, Lukas,

Gentle ping. Any feedback?

Thanks.
Shuai

