Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4E3D902C;
	Wed, 25 Feb 2026 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035753; cv=none; b=XSszBp/OAR8gxs09rW3PeuVlZWXFV+i1PA9nKQPfxH4tcQn9RuM6ZNx7GWvezbJbbkjyEuf6PM7gktDRUFJ7oPNM0A3fxHDGZkLnK3lCWIUjfU+4+jrjTWdBtsULwo5RoSMWNBT+5wHqUi9Q8/f3aorPJIQJ2qUY1Orjkf19qmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035753; c=relaxed/simple;
	bh=ANomuQGtwJBVOlScVj0hlbIkzsKM2420UHn1bHN/8uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSpGOjm430Z7azayMtCKTeD/oyFgxw7uvrUXCqHPMeTND7petP4ziN8E/CNm90qMYGVPjK2Ora56Ev1RNj5ml5uGIklHq0zGmLBA1/xpGik3XaDOur0P4YP4tIsm8E2+uzRipfh0GnJgPyW2Eie3ypt/bO0ZLZyCs5XCvQgTeME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5oXl5ir; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5oXl5ir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772035750; x=1803571750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ANomuQGtwJBVOlScVj0hlbIkzsKM2420UHn1bHN/8uM=;
  b=U5oXl5ir52cRK2USN/5XaHbMqQAOX7Beu3LblQvFA/W8aFSBYbxbrJvP
   NyLUphu3jKAbT58g5N45ATcdX7c8e7dmau5glS61to5kevVVL705D2Aus
   dHSxXq/v+XNPgX7J46lTdBQNyFDBXnmR40+6GZqy1UHAxcxkQN2O8cMad
   yU7Vzy7fc0ZGS8+Ynjxp5IfTj5XZawpyGz9YP/R+0isSysGljzxkvw+PL
   9+QBQnLcRtONS7djxKXHhOqASKiT3VJTC/hV1yicTPm/4BsfXtl1Vt/wC
   +moFjgDPHyMCXph2aHWrZlU1dcBMsQsBeFWJN8o2WFCngPWHpk7XoZh18
   g==;
X-CSE-ConnectionGUID: PQ9CMmuKRR+lV/wn74vkCQ==
X-CSE-MsgGUID: XWjndECPQjGL6WDvT68eGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73055976"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73055976"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:09:09 -0800
X-CSE-ConnectionGUID: UR4/Jk+VRJODQQTWkH3JUg==
X-CSE-MsgGUID: 0W+OyvvtRi2vxkDH+C2S1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="239283690"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.111.86]) ([10.125.111.86])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:09:08 -0800
Message-ID: <0df25574-6de7-4453-9012-e5538f36b7cf@intel.com>
Date: Wed, 25 Feb 2026 09:09:06 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] PCI: Hide SBR from reset_methods if masked by CXL
To: Vidya Sagar <vidyas@nvidia.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 "raphael.norwitz@nutanix.com" <raphael.norwitz@nutanix.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Vikram Sethi <vsethi@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Srirangan Madhavan <smadhavan@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Krishna Thota <kthota@nvidia.com>,
 Manikanta Maddireddy <mmaddireddy@nvidia.com>,
 "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20260220195259.2397847-1-vidyas@nvidia.com>
 <835de7c9-a64f-4aaa-95e0-b91c2ae5885e@intel.com>
 <82a5a344-26d7-40ef-9047-60657c6923b0@nvidia.com>
 <d6e2617b-6dd2-4c08-830d-e6d917387c66@intel.com>
 <66a7d3e6-d97d-43e3-8629-e793dbabb1f8@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <66a7d3e6-d97d-43e3-8629-e793dbabb1f8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/25/26 6:13 AM, Vidya Sagar wrote:
> On 23/02/26 21:22, Dave Jiang wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2/23/26 6:11 AM, Vidya Sagar wrote:
>>> On 21/02/26 02:51, Dave Jiang wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 2/20/26 12:52 PM, Vidya Sagar wrote:
>>>>> The CXL specification (e.g., CXL r3.1 v1.0, sec 8.1.5.2) defines
>>>>> the "Unmask SBR" bit in the Port Control Extensions Register.
>>>>> When this bit is 0 (default), asserting the Secondary Bus Reset (SBR) bit
>>>>> in the Bridge Control register has no effect on the downstream bus.
>>>>>
>>>>> Currently, the Linux PCI core checks this condition in
>>>>> pci_reset_bus_function(). If SBR is masked, it returns -ENOTTY during the
>>>>> execution of the reset. However, during the probe phase (when probe=true),
>>>>> the function currently returns 0. This 0 return value incorrectly signals
>>>>> to the PCI subsystem that SBR is a viable reset method for the device.
>>>>
>>>> The "Unmask SBR" bit is a toggle bit. It does not give indicator whether the device is capable of SBR or not.
>>>
>>> Not sure how is this point relevant here. Can you help me understand?
>>
>> That means it's not a capability bit. It's a r/w toggle bit to mask or unmask SBR for CXL.
>>
>>>
>>> BTW, what do you mean by "whether the device is capable of SBR or not". My understanding is that each downstream port
>>>
>>> must support SBR. The patch I made would ensure that 'bus' entry is not shown under 'reset_methods' if the downstream
>>>
>>> port is a CXL capable port and 'Unmask SBR' is '0'.
>>
>> The purpose of introducing the cxl bus reset method is, "you know what you are doing" because you selected this method and the kernel will set the bit to allow the reset.
> I'm not really questioning the purpose of 'cxl_bus' reset method.
> I'm only wondering why is 'bus' reset method shown if it can't be used.
>> By default the Unmask SBR bit is clear. So if you hide the reset attribute then the user can't reset without going through other means to set the bit first (i.e. via setpci tool). This is intentionally setup to do this through total control of the
>> kernel and not having to jump through hoops to toggle bit via a user tool first. Otherwise you can just toggle the bit with a user tool and use the standard PCI bus reset method.
> This doesn't make much sense to me. Since the 'cxl_bus' method is anyway going to update the 'Unmask SBR' before applying the SBR through Bride Control register, what is the point in showing 'bus' which doesn't work by default and expecting the user to toggle the 'Unmask SBR' through tools like setpci? The user can very well use 'cxl_bus' directly which does the same thing, right?

Ok I think I see where I made a mistake. You are hiding the regular PCI bus reset method and not the cxl_bus reset method. Yes then I agree what you are doing is fine. This does not impact the cxl_bus reset method. Sorry about the noise. 

DJ

> BTW, I found one issue with my current patch where I try to hide 'bus' if 'Unmask SBR' is '0', but the CXL spec also says that for the SBR bit in Bridge Control Register to be ineffective, both 'Unmask SBR' should be '0' and also the link as such must be operating in the CXL mode. I'll push V2 patch to add this check as well.
>>
>> Please see commit log of this commit:
>> 53c49b6e6dd2 ("PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Ports")
>>
>> DJ
>>
>>>
>>>> The original thought was that if the user is issuing CXL SBR, you know what you are doing and the kernel will set that bit and issue the SBR.
>>>>
>>>> DJ
>>>>
>>>>> As a result, 'bus' is listed in the device's
>>>>> /sys/bus/pci/devices/.../reset_methods attribute, even though the hardware
>>>>> is incapable of performing it. If a user attempts to write bus to reset
>>>>> method or triggers a reset that falls back to SBR, the operation fails
>>>>> with: "bash: echo: write error: Inappropriate ioctl for device" error.
>>>>>
>>>>> This patch modifies pci_reset_bus_function() to return -ENOTTY immediately
>>>>> if cxl_sbr_masked() is true, regardless of the probe argument. This
>>>>> ensures that 'bus' is not advertised in reset_methods when the hardware
>>>>> prevents it, improving clarity for users and aligning the sysfs capability
>>>>> report with actual hardware behavior.
>>>>>
>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>> ---
>>>>>  drivers/pci/pci.c | 6 +-----
>>>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>> index f3244630bfd0..57e24300d1c7 100644
>>>>> --- a/drivers/pci/pci.c
>>>>> +++ b/drivers/pci/pci.c
>>>>> @@ -4915,12 +4915,8 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>>>>>        * If "dev" is below a CXL port that has SBR control masked, SBR
>>>>>        * won't do anything, so return error.
>>>>>        */
>>>>> -     if (bridge && cxl_sbr_masked(bridge)) {
>>>>> -             if (probe)
>>>>> -                     return 0;
>>>>> -
>>>>> +     if (bridge && cxl_sbr_masked(bridge))
>>>>>               return -ENOTTY;
>>>>> -     }
>>>>>
>>>>>       rc = pci_dev_reset_iommu_prepare(dev);
>>>>>       if (rc) {
>>>
>>>
>>
> 

