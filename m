Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35259 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136AbbL3NZ7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Dec 2015 08:25:59 -0500
Subject: Re: [PATCH v2] PCI/AER: enable SERR# forwarding for bridges and
 switches
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1449074998-9664-1-git-send-email-okaya@codeaurora.org>
 <20151204210622.GI20125@localhost> <5669E073.4000801@codeaurora.org>
 <20151210223742.GC367@localhost> <566B5CA1.1010306@codeaurora.org>
 <566F08EF.5010904@codeaurora.org> <20151228222927.GA15808@localhost>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, izumi.taku@jp.fujitsu.com, jcm@redhat.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5683DB75.4050604@codeaurora.org>
Date: Wed, 30 Dec 2015 08:26:13 -0500
MIME-Version: 1.0
In-Reply-To: <20151228222927.GA15808@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/28/2015 5:29 PM, Bjorn Helgaas wrote:
> Hi Sinan,
> 
> Sorry for the delay in responding; I was on vacation when you sent
> this, and I missed it when I returned.
> 
> On Mon, Dec 14, 2015 at 01:22:39PM -0500, Sinan Kaya wrote:
>> On 12/11/2015 6:30 PM, Sinan Kaya wrote:
>>>> I think the best way to fix all the cases would be to do something in
>>>>> in pci_configure_device().  Then we could drop the AER bus walk in
>>>>> set_downstream_devices_error_reporting().  A bus walk like that is
>>>>> always an issue for hotplug.
>>>>>
>>> Let me read some code.
>>
>> OK, If I understand it right; pci_configure_device is where
>> program_hpp_type0 called. You also want to enable AER in this function.
>>
>> Move the contents of set_device_error_reporting into
>> pci_configure_device like this below ?
>>
>> ...
>> + int type = pci_pcie_type(dev);
>>
>> pci_configure_mps(dev);
>>
>> +	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (type == PCI_EXP_TYPE_UPSTREAM) ||
>> +	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +		pci_enable_pcie_error_reporting(dev);
>> +	}
>>
>> +	pcie_set_ecrc_checking(dev);
> 
> Yep, that's the sort of thing I'm thinking.
> 
> I think there are some subtleties to consider.
> 
> _HPP/_HPX can twiddle some of the same bits.  Should we allow _HPP to
> clear a bit that pci_enable_pcie_error_reporting() would set?  What
> about the reverse?
> 
> There are a ridiculous number of places that call
> pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR).  We should
> do it once and cache the result in struct pci_dev.
> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Thanks for the heads up. I had another pending question to you on another patch.
I just sent a ping. 

I'll start working on this patch after the holidays.




-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
