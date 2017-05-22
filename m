Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936015AbdEVVUE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2017 17:20:04 -0400
Subject: Re: IO Space Allocation Question on ARM64
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>
References: <31f48cf6-fd97-98fe-ac7c-ad80870df68b@codeaurora.org>
 <20170522141416.4fdc09a3@w520.home>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <112199ef-40fe-1c78-c2d8-bee0071f3ddf@codeaurora.org>
Date: Mon, 22 May 2017 17:20:02 -0400
MIME-Version: 1.0
In-Reply-To: <20170522141416.4fdc09a3@w520.home>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

On 5/22/2017 4:14 PM, Alex Williamson wrote:
>> UEFI seems to be assigning an IO resource to bridge only if finds an endpoint
>> behind it with an actual IO BAR space.
> If it's anything like we saw with similar issues on QEMU, it might be
> because the slots report themselves as hotplug capable and Linux tries
> to allocate minimum apertures for any hotplug slot.  See hpiosize
> and hpmemsize options for pci=.  Thanks,

That was it. I was suspicious of this but didn't realize that we were allocating
0x1000 as a minimum due to hotplug.

Thanks for the suggestion. I didn't know the hpmemsize and hpiosize arguments.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
