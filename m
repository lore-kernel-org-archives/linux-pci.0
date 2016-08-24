Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: PCI CRS Support
To: Bjorn Helgaas <helgaas@kernel.org>
References: <f114c582-8e55-ee1a-a72d-864483077fd0@codeaurora.org>
 <20160824191007.GD23914@localhost>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Vikram Sethi <vikrams@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <046ebcb0-cb0d-65a5-d7f4-2805fe99199e@codeaurora.org>
Date: Wed, 24 Aug 2016 15:28:51 -0400
MIME-Version: 1.0
In-Reply-To: <20160824191007.GD23914@localhost>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/24/2016 3:10 PM, Bjorn Helgaas wrote:
>> Where do we go from here? I was thinking of putting something deep down into the reset secondary
>> > bus function but I'm afraid it will break things especially when we wait up to 60 seconds.
> I agree CRS handling after reset is probably all broken.
> 
> I hate the fact that we reset devices without re-enumerating them.  We
> have no assurance that the device is the same after reset (it could
> have loaded new firmware and been completely reconfigured).
> 
> I don't have any good suggestions for you, so if you have some ideas
> and want to fix it, please go ahead.

I think I'll make a list of paths that reach to secondary bus reset function
and try to keep CRS loop as close as possible to the caller. 

I'll focus on FLR later. I won't be heart-broken if somebody took a stab at the
FLR.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
