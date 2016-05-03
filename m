Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([125.16.236.7]:38668 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbcECHgE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2016 03:36:04 -0400
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Tue, 3 May 2016 13:06:01 +0530
Subject: Re: [PATCH] vfio-pci: Allow to mmap sub-page MMIO BARs if the mmio
 page is exclusive
To: "Tian, Kevin" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <1461759740-5072-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F84131D@SHSMSX101.ccr.corp.intel.com>
 <00243350-1ccc-75e5-8cd8-a58dfe14637f@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F8425FE@SHSMSX101.ccr.corp.intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"aik@ozlabs.ru" <aik@ozlabs.ru>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"paulus@samba.org" <paulus@samba.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"warrier@linux.vnet.ibm.com" <warrier@linux.vnet.ibm.com>,
	"zhong@linux.vnet.ibm.com" <zhong@linux.vnet.ibm.com>,
	"nikunj@linux.vnet.ibm.com" <nikunj@linux.vnet.ibm.com>,
	"gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <ade934de-0335-d2fb-11c1-5ecf05c800b2@linux.vnet.ibm.com>
Date: Tue, 3 May 2016 15:36:05 +0800
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D15F8425FE@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/5/3 14:11, Tian, Kevin wrote:

>> From: Yongji Xie [mailto:xyjxie@linux.vnet.ibm.com]
>> Sent: Tuesday, May 03, 2016 1:52 PM
>>
>>>> +
>>>> +		if (!(res->start & ~PAGE_MASK)) {
>>>> +			/*
>>>> +			 * Add shadow resource for sub-page bar whose mmio
>>>> +			 * page is exclusive in case that hot-add device's
>>>> +			 * bar is assigned into the mem hole.
>>>> +			 */
>>>> +			shadow_res = kzalloc(sizeof(*shadow_res), GFP_KERNEL);
>>>> +			shadow_res->resource.start = res->end + 1;
>>>> +			shadow_res->resource.end = res->start + PAGE_SIZE - 1;
>>> What about res->start not page aligned so you end up still having
>>> a portion before res->start not exclusively reserved?
>> Do you mean add a 'dummy' resource to reserve the portion
>> before res->start if res->start not page aligned?
>>
>> But would it happen that there is a mem hole in the portion
>> before res->start? The resource should have been assigned
>> into the hole at the beginning.
>>
> Just a quick thought. Another device might occupy that range
> before initializing this device, and then 'another device' is hot
> removed later...
>
> Thanks
> Kevin

That's a good point! I will add support for this case in v2.

Thanks,
Yongji

