Return-Path: <SRS0=B7sc=BY=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=B7sc=BY=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH] PCI: rework error checking in the reset path
To: Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1508794608-15310-1-git-send-email-okaya@codeaurora.org>
 <20171025134511.GL21840@bhelgaas-glaptop.roam.corp.google.com>
 <20171025232805.163ccaad@t450s.home>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <47146df8-b4e1-595d-9664-3830d770eecf@codeaurora.org>
Date: Wed, 25 Oct 2017 17:42:24 -0400
MIME-Version: 1.0
In-Reply-To: <20171025232805.163ccaad@t450s.home>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 10/25/2017 5:28 PM, Alex Williamson wrote:
>> Previously, we only tried the next reset method if one method failed
>> with -ENOTTY.  With this patch, we'll try the next reset method if one
>> method fails for any reason, not just -ENOTTY.
> Hmm, I thought the return codes were pretty consistent.  -ENOTTY means
> that the reset callback doesn't handle the device, move on.  Many
> ioctls use the same return code to indicate an unknown ioctl.  This
> allows us to differentiate success vs error vs unhandled.  In the code
> below we lose the ability to, for instance, have a device specific
> reset that returns -EINVAL to prevent the PCI core for triggering
> further reset mechanisms which might be broken on the device.  So, I
> don't see that this patch specifically fixes anything, but it does
> remove what seems like useful functionality...  I'd veto it.  Thanks,
> 

OK, It was not obvious how the EINVAL and ENOTTY used by code inspection.

Thank your very much for the clarification. I'm dropping the patch unless
Bjorn has another idea.

> Alex
>  


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
