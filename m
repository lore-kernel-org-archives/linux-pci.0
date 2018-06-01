Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44628 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbeFAPKX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jun 2018 11:10:23 -0400
Subject: Re: [PATCH v2] PCI: Check for PCIe downtraining conditions
To: "Alex G." <mr.nuke.me@gmail.com>, bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180601150129.10486-1-mr.nuke.me@gmail.com>
 <35a67b5b-5f37-c779-64a3-eb5e21362e9c@codeaurora.org>
 <c677b42a-f5f0-474e-c9ce-da05ced45b23@gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <321c6d7d-b8e6-9b8d-91e5-a4f748acaa8e@codeaurora.org>
Date: Fri, 1 Jun 2018 11:10:20 -0400
MIME-Version: 1.0
In-Reply-To: <c677b42a-f5f0-474e-c9ce-da05ced45b23@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/1/2018 11:06 AM, Alex G. wrote:
> On 06/01/2018 10:03 AM, Sinan Kaya wrote:
>> On 6/1/2018 11:01 AM, Alexandru Gagniuc wrote:
>>> +	/* Multi-function PCIe share the same link/status. */
>>> +	if (PCI_FUNC(dev->devfn) != 0)
>>> +		return;
>>
>> How about virtual functions?
> 
> I have almost no clue about those. Is your concern that we might end up
> printing more than our fair share of link statuses?

Yes, struct pci_dev also has a flag called is_virtfn that you should bail out
here too. 

> 
> Alex
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
