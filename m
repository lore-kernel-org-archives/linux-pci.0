Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A240303A12;
	Mon, 23 Feb 2026 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861954; cv=none; b=Ol+gd49HYBkDMRhXMaJ8vMvdN08Jhyn647qjLVpZzibWJijqtJxLWqWnXKpPqzmqqm1sJ8sR8Ml/T7ssMDApDGgbiNFcCrCac7kxEUaYkA2btiNFgPf81fGkMusnSKYbqiFKEIDpHDZWZ1WFF7hTlRBBFt4kvE5DjmQTiZNRvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861954; c=relaxed/simple;
	bh=zmLBskjCL1zRS+O30B6eQFLUzXO8640+29SuS1+Kr98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSVq2P9BL/nASHouiCjVpj5zTDc2KXDmigL2ppmT3pMep+S2OU0C0JEQyBhlHoQfwFtuoC9D0hJmCLnFpZZ93IpkXAxkQNoET33w269oyHO549OdY3wdcUJMdyR5pS/ZSfqiJ52AK7BUtwASVgkEXnXGcHdYoxPMHTCfFm/YFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXSNG4Yn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXSNG4Yn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771861952; x=1803397952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zmLBskjCL1zRS+O30B6eQFLUzXO8640+29SuS1+Kr98=;
  b=NXSNG4YnDkwauOAxwhWSY27FgeuXoZXQKMzqRTnNjCQsSUKbkcBClFtL
   CyHcjsuofV5BXpoa6PK3T7BDx+B+0rgr/jUrYVXjANcAoqqbtJi1Uy8P6
   aajSILX7tRL5ZzLyXH719jto7dzL/tQow0OKF3JGPfBTpT7WaXPXTtBQd
   FhJ9hGtOU/b1TgNNAwaO32uEROr/1DZGCIdew4zp5wm/sW4j/Ds7M1QUO
   Ao/vnjwXfZUwc8/MD9SZ34jgERlgpe2bHhpfWus28qOc+hzLmHOvfxzdM
   8kex9jMSdYJhyD40nVVgInvWRH3oPoouT7jnfkIVaHl2FfDbaYZJTU549
   Q==;
X-CSE-ConnectionGUID: EomL6PFPSKaZghMXwxiDqg==
X-CSE-MsgGUID: a5t2DVa+RZ6s5wdZUH/jtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="90267094"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="90267094"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:52:31 -0800
X-CSE-ConnectionGUID: quSGZpGyTlKuc8f8v+KT7A==
X-CSE-MsgGUID: Km9Tpl55S6SaVJ+PBzlNmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="220150087"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.216]) ([10.125.110.216])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:52:30 -0800
Message-ID: <d6e2617b-6dd2-4c08-830d-e6d917387c66@intel.com>
Date: Mon, 23 Feb 2026 08:52:29 -0700
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
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <82a5a344-26d7-40ef-9047-60657c6923b0@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/26 6:11 AM, Vidya Sagar wrote:
> On 21/02/26 02:51, Dave Jiang wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2/20/26 12:52 PM, Vidya Sagar wrote:
>>> The CXL specification (e.g., CXL r3.1 v1.0, sec 8.1.5.2) defines
>>> the "Unmask SBR" bit in the Port Control Extensions Register.
>>> When this bit is 0 (default), asserting the Secondary Bus Reset (SBR) bit
>>> in the Bridge Control register has no effect on the downstream bus.
>>>
>>> Currently, the Linux PCI core checks this condition in
>>> pci_reset_bus_function(). If SBR is masked, it returns -ENOTTY during the
>>> execution of the reset. However, during the probe phase (when probe=true),
>>> the function currently returns 0. This 0 return value incorrectly signals
>>> to the PCI subsystem that SBR is a viable reset method for the device.
>>
>> The "Unmask SBR" bit is a toggle bit. It does not give indicator whether the device is capable of SBR or not.
> 
> Not sure how is this point relevant here. Can you help me understand?

That means it's not a capability bit. It's a r/w toggle bit to mask or unmask SBR for CXL.

> 
> BTW, what do you mean by "whether the device is capable of SBR or not". My understanding is that each downstream port
> 
> must support SBR. The patch I made would ensure that 'bus' entry is not shown under 'reset_methods' if the downstream
> 
> port is a CXL capable port and 'Unmask SBR' is '0'.

The purpose of introducing the cxl bus reset method is, "you know what you are doing" because you selected this method and the kernel will set the bit to allow the reset. By default the Unmask SBR bit is clear. So if you hide the reset attribute then the user can't reset without going through other means to set the bit first (i.e. via setpci tool). This is intentionally setup to do this through total control of the kernel and not having to jump through hoops to toggle bit via a user tool first. Otherwise you can just toggle the bit with a user tool and use the standard PCI bus reset method.

Please see commit log of this commit:
53c49b6e6dd2 ("PCI/CXL: Add 'cxl_bus' reset method for devices below CXL Ports")

DJ

> 
>> The original thought was that if the user is issuing CXL SBR, you know what you are doing and the kernel will set that bit and issue the SBR.
>>
>> DJ
>>
>>> As a result, 'bus' is listed in the device's
>>> /sys/bus/pci/devices/.../reset_methods attribute, even though the hardware
>>> is incapable of performing it. If a user attempts to write bus to reset
>>> method or triggers a reset that falls back to SBR, the operation fails
>>> with: "bash: echo: write error: Inappropriate ioctl for device" error.
>>>
>>> This patch modifies pci_reset_bus_function() to return -ENOTTY immediately
>>> if cxl_sbr_masked() is true, regardless of the probe argument. This
>>> ensures that 'bus' is not advertised in reset_methods when the hardware
>>> prevents it, improving clarity for users and aligning the sysfs capability
>>> report with actual hardware behavior.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>>  drivers/pci/pci.c | 6 +-----
>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index f3244630bfd0..57e24300d1c7 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -4915,12 +4915,8 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>>>        * If "dev" is below a CXL port that has SBR control masked, SBR
>>>        * won't do anything, so return error.
>>>        */
>>> -     if (bridge && cxl_sbr_masked(bridge)) {
>>> -             if (probe)
>>> -                     return 0;
>>> -
>>> +     if (bridge && cxl_sbr_masked(bridge))
>>>               return -ENOTTY;
>>> -     }
>>>
>>>       rc = pci_dev_reset_iommu_prepare(dev);
>>>       if (rc) {
> 
> 

