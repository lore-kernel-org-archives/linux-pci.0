Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33448 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeFANab (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jun 2018 09:30:31 -0400
Subject: Re: [PATCH] PCI: Check for PCIe downtraining conditions
To: "Alex G." <mr.nuke.me@gmail.com>, bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180531150535.9684-1-mr.nuke.me@gmail.com>
 <e137d5bf-b640-68ef-c07e-d872a9343548@codeaurora.org>
 <3e0ddec1-649b-3e97-65e5-073dd9d45a1c@gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <874b9b90-ae6a-ef88-ebd8-671f277443ab@codeaurora.org>
Date: Fri, 1 Jun 2018 09:30:29 -0400
MIME-Version: 1.0
In-Reply-To: <3e0ddec1-649b-3e97-65e5-073dd9d45a1c@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/31/2018 5:44 PM, Alex G. wrote:
> On 05/31/2018 10:30 AM, Sinan Kaya wrote:
>> On 5/31/2018 11:05 AM, Alexandru Gagniuc wrote:
>>> +	if (dev_cur_speed < max_link_speed)
>>> +		pci_warn(dev, "PCIe downtrain: link speed is %s (%s capable)",
>>> +			 pcie_bus_speed_name(dev_cur_speed),
>>> +			 pcie_bus_speed_name(max_link_speed));
>>> +
>>
>> Also this isn't quite correct. Target link speed is what the device tries to
>> train. A device can try to train to much lower speed than the maximum on purpose.
>>
>> It makes sense to print this if the speed that platform wants via target link
>> speed is different from what is actually established though.
> 
> After seeing Gen 3 devices that train above the speed in the target link
> speed field, I talked to one the spec writers today. There is some
> ambiguity with the target link speed field. In PCIe 4.0 they are
> clarifying that to state that this field is "permitted to have no effect".

Good to know.
Probably, some company screwed up implementing this register...
All these flexible terminology in the spec is an indication of such a failure.

> 
> Alex
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
